net.Receive("MyIP", function()
	IP = net.ReadString()
	CurrentDir = net.ReadTable()
end)

net.Receive("DirResponse", function()
	CurrentDir = net.ReadTable()
	reloadfiles()
end)