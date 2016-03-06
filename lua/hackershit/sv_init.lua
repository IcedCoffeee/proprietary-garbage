include("sv_netmessages.lua")
include("sv_player.lua")
include("sv_servers.lua")
include("sv_defaults.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_derma.lua")
AddCSLuaFile("cl_netmessages.lua")
AddCSLuaFile("cl_functions.lua")

util.AddNetworkString("laptopgui")
util.AddNetworkString("maingui")
util.AddNetworkString("connectgui")
util.AddNetworkString("MyIP")
util.AddNetworkString("OpenDir")
util.AddNetworkString("DirResponse")

resource.AddSingleFile("materials/icedcoffee/file.png")
resource.AddSingleFile("materials/icedcoffee/folder.png")

hook.Add("Initialize", "hack_init", function()
	if(!file.IsDir("hack", "DATA") or !file.IsDir("hack/servers", "DATA") or !file.IsDir("hack/players", "DATA")) then
		file.CreateDir("hack")
		file.CreateDir("hack/players")
		file.CreateDir("hack/servers")
	end
end)

print("hacker shit loaded")
