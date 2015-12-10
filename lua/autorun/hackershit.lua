if SERVER then
	AddCSLuaFile()
	include("hackershit/sv_init.lua")
else
	include("hackershit/cl_init.lua")
end
