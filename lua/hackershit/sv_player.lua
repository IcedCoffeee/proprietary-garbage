local meta = FindMetaTable("Player")

hook.Add("PlayerInitialSpawn", "hack_initialspawm", function(ply)
	if(!file.Exists("hack/players/" .. ply:SteamID64() .. ".txt", "DATA")) then
		local newip = NewServer(ply:SteamID64())
		file.Write("hack/players/" .. ply:SteamID64() .. ".txt", util.TableToJSON({ip = newip}))
	end
	
	if(file.Exists("hack/players/" .. ply:SteamID64() .. ".txt", "DATA")) then
		data = util.JSONToTable(file.Read("hack/players/" .. ply:SteamID64() .. ".txt", "DATA"))
		net.Start("MyIP")
			net.WriteString(data.ip)
			local server = GetServer(data.ip)
			--local server = Default.server
			server.secret = nil
			net.WriteTable(server)
		net.Send(ply)
	end
end)

function GetIP(ply)
	if IsValid(ply) then
		data = util.JSONToTable(file.Read("hack/players/" .. ply:SteamID64() .. ".txt", "DATA"))
	end
	return data.ip
end

function meta:SendContent(tbl)
	if tbl.secret then
		tbl.secret = nil
	end
	net.Start("SendContent")
		net.WriteTable(tbl)
	net.Send(self)
end