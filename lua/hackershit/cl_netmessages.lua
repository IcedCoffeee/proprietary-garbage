net.Receive("SendContent", function()
	Server = net.ReadTable()
	if WebPanel then	
		WebPanel:SetHTML(Server.website or "error loading")
	end
end)

net.Receive("MyIP", function()
	MyIP = net.ReadString()
	Server = net.ReadTable()
end)