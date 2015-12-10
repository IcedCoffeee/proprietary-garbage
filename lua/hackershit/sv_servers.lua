function NewServer(own)
	local newip = math.random(255,0) .. "." .. math.random(255,0) .. "." .. math.random(255,0) .. "." .. math.random(255,0)
	local newserver = Default.server
	newserver.ip = newip
	if !isstring(own) and own:IsPlayer() then
		newserver.secret.owner = own:SteamID64()
	else
		newserver.secret.owner = tostring(own)
	end
	file.Write("hack/servers/" .. newip .. ".txt", util.TableToJSON(newserver))
	return newip
end

function GetServer(ip)
	return util.JSONToTable(file.Read("hack/servers/" .. ip .. ".txt"))
end