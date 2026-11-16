--!strict
-- Gets RemoteEvents and RemoteFunctions by name. They live in ReplicatedStorage.Remotes.
-- The server creates a remote the first time it asks for it. Clients wait for it.
-- Server features ask for their remotes in init(), so they exist before any client asks.
-- Name remotes "<Feature>/<Action>" (for example "Combat/Attack") and keep each
-- feature's names in src/shared/<Feature>/Remotes.luau.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FOLDER_NAME = "Remotes"
local CLIENT_WAIT_SECONDS = 10

local Net = {}

local function getFolder(): Instance
	local existing = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
	if existing then
		return existing
	end
	if RunService:IsServer() then
		local folder = Instance.new("Folder")
		folder.Name = FOLDER_NAME
		folder.Parent = ReplicatedStorage
		return folder
	end
	return ReplicatedStorage:WaitForChild(FOLDER_NAME)
end

local function getRemote(name: string, className: string, create: () -> Instance): Instance
	local folder = getFolder()
	local remote = folder:FindFirstChild(name)

	if not remote then
		if RunService:IsServer() then
			remote = create()
			remote.Name = name
			remote.Parent = folder
		else
			remote = folder:WaitForChild(name, CLIENT_WAIT_SECONDS)
		end
	end

	if not remote then
		error(`Remote {name} was never created. The server feature must ask for it in init().`, 0)
	end
	if not remote:IsA(className) then
		error(`Remote {name} is a {remote.ClassName}, expected {className}`, 0)
	end
	return remote
end

function Net.event(name: string): RemoteEvent
	return getRemote(name, "RemoteEvent", function()
		return Instance.new("RemoteEvent")
	end) :: RemoteEvent
end

function Net.func(name: string): RemoteFunction
	return getRemote(name, "RemoteFunction", function()
		return Instance.new("RemoteFunction")
	end) :: RemoteFunction
end

return Net
