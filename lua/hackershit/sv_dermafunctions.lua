local meta = FindMetaTable("Player")

net.Receive("hacker.requestwindow", function(len, ply)
	local pc = net.ReadEntity()
	local window = net.ReadString()
	if ply:GetPos():Distance(pc:GetPos()) < 100 then
		net.Start("hacker.openwindow")
			net.WriteString(window)
		net.Send(ply)
	end
end)