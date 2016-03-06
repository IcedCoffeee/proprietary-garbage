net.Receive("OpenDir", function(len, ply)
	local ip = net.ReadString()
	local dir = net.ReadString()
	local response = opendir(ip, dir)
	for i=1, #response do
		table.remove(response[i], 3)
	end
	net.Start("DirResponse")
		net.WriteTable(response)
	net.Send(ply)
end)