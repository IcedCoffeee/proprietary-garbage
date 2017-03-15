include("sv_player.lua")
include("sv_servers.lua")
include("sv_defaults.lua")
include("sv_pcmeta.lua")
include("sv_dermafunctions.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_servers.lua")
AddCSLuaFile("cl_dermafunctions.lua")
AddCSLuaFile("derma/cl_desktop.lua")
AddCSLuaFile("derma/cl_filebrowser.lua")
AddCSLuaFile("derma/cl_webbrowser.lua")
AddCSLuaFile("derma/cl_notepad.lua")

resource.AddSingleFile("materials/icedcoffee/file.png")
resource.AddSingleFile("materials/icedcoffee/folder.png")

util.AddNetworkString("hacker.openpc")
util.AddNetworkString("hacker.openwindow")
util.AddNetworkString("hacker.requestwindow")
util.AddNetworkString("hacker.opendir")
util.AddNetworkString("hacker.dirresponse")
util.AddNetworkString("hacker.updatefile")

hook.Add("Initialize", "hack_init", function()
	if !file.IsDir("hack", "DATA") or !file.IsDir("hack/servers", "DATA") then
		file.CreateDir("hack")
		file.CreateDir("hack/servers")
	end
end)

print("hacker shit loaded")

concommand.Add("newpc", function(ply)
	local tr = ply:GetEyeTrace()
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( "sent_pc_test" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.PC = true
	ent.IP = NewServer(ply)
end)
