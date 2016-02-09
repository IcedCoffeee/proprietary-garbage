function RequestContent(_, ply)
	local ip = net.ReadString()
	print("[Hack] Content request for " .. ip)
	if file.Exists("hack/servers/" .. ip .. ".txt", "DATA") then
		local Server = GetServer(ip)
		ply:SendContent({ip = Server.ip, website = Default.server.website})
	else
		net.Start("SendContent")
			net.WriteTable({website = Default.offline})
		net.Send(ply)
	end
end
net.Receive("RequestContent", RequestContent)

function ServerLogin(_, ply)
	local login = net.ReadTable()
	local server = GetServer(login[3])
	if login[1] == server.secret.login[1] and login[2] == server.secret.login[2] then
		ply:SendContent(server)
		print("[Hack] Succesful login for " .. login[3])
	end
end
net.Receive("ServerLogin", ServerLogin)

function PostContent(len, ply)
	local newserver = net.ReadTable()
	UpdateServer(newserver)
end
net.Receive("UpdateServer", PostContent)
