--!strict
-- Server bootstrap: starts every feature folder in src/server. Don't add feature code here.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bootstrap = require(ReplicatedStorage.Shared.Bootstrap)

Bootstrap.run(script.Parent)
