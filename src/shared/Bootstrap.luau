--!strict
-- Starts every feature module found in a folder, in two phases.
-- Phase 1 calls init() on each feature: set up its own state and remotes, no calls to other features, no yielding.
-- Phase 2 calls start() on each feature in its own thread: connect events and talk to other features.
-- Adding a feature means adding a folder with an init.luau next to the bootstrap script. The bootstrap never changes.

export type Feature = {
	init: (() -> ())?,
	start: (() -> ())?,
}

local Bootstrap = {}

local function loadFeatures(container: Instance): { [string]: Feature }
	local features: { [string]: Feature } = {}
	for _, child in container:GetChildren() do
		if child:IsA("ModuleScript") then
			local loaded = (require :: any)(child)
			if type(loaded) ~= "table" then
				error(`Feature {child:GetFullName()} must return a table`, 0)
			end
			features[child.Name] = loaded :: Feature
		end
	end
	return features
end

function Bootstrap.run(container: Instance)
	local features = loadFeatures(container)

	for _, feature in features do
		local init = feature.init
		if init then
			init()
		end
	end

	for _, feature in features do
		local start = feature.start
		if start then
			task.spawn(start)
		end
	end
end

return Bootstrap
