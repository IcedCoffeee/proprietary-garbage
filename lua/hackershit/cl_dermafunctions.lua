local meta = FindMetaTable("Entity")
hacker.programs = hacker.programs or {}

function meta:OpenWindow(window)
	net.Start("hacker.requestwindow")
		net.WriteEntity(self)
		net.WriteString(window)
	net.SendToServer()
end

net.Receive("hacker.openpc", function(len, ply)
	local ent = net.ReadEntity()
	LocalPlayer().curpc = ent
	ent:OpenWindow("desktop")
end)

net.Receive("hacker.openwindow", function()
	local window = net.ReadString()
	hacker.programs[window]()
end)

function showerror(msg)
	local err = vgui.Create("DFrame")
end