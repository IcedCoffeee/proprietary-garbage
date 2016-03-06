local meta = FindMetaTable("Player")

hook.Add("PlayerInitialSpawn", "hack_initialspawm", function(ply)
	if(!file.Exists("hack/players/" .. ply:SteamID64() .. ".txt", "DATA")) then
		local newip = NewServer(ply:SteamID64())
		file.Write("hack/players/" .. ply:SteamID64() .. ".txt", util.TableToJSON({ip = newip}))
	end
	
	if(file.Exists("hack/players/" .. ply:SteamID64() .. ".txt", "DATA")) then
		local data = util.JSONToTable(file.Read("hack/players/" .. ply:SteamID64() .. ".txt", "DATA"))
		net.Start("MyIP")
			net.WriteString(data.ip)
			net.WriteTable(opendir(data.ip, "/"))
		net.Send(ply)
	end
end)

function GetIP(ply)
	if IsValid(ply) then
		local data = util.JSONToTable(file.Read("hack/players/" .. ply:SteamID64() .. ".txt", "DATA"))
		return data.ip
	end
end
