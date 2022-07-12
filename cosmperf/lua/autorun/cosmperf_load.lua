cosmperf = {}

-- Make loading functions
local function Inclu(f) return include("cosmperf/"..f) end
local function AddCS(f) return AddCSLuaFile("cosmperf/"..f) end
local function IncAdd(f) return Inclu(f), AddCS(f) end

-- Load addon files
IncAdd("config.lua")
IncAdd("constants.lua")

if SERVER then

	Inclu("server/sv_functions.lua")
	Inclu("server/sv_hooks.lua")
	Inclu("server/sv_network.lua")
	Inclu("server/sv_ticket.lua")

	AddCS("client/cl_functions.lua")
	AddCS("client/cl_hooks.lua")
	AddCS("client/cl_network.lua")
	AddCS("client/cl_ticket.lua")

else

	Inclu("client/cl_functions.lua")
	Inclu("client/cl_hooks.lua")
	Inclu("client/cl_network.lua")
	Inclu("client/cl_ticket.lua")

end
