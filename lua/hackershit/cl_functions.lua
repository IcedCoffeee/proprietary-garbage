function UpdateServer()
	net.Start("UpdateServer")
		net.WriteTable(Server)
	net.SendToServer()
end
