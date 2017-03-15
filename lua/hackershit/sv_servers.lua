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

function opendir(pc, path)
	if path[#path] == "/" and #path > 1 then path = string.sub(path, 1, #path-1) end
	path = string.Replace(path, "//", "/")
	local tbl = string.Explode("/", path)
	if tbl[2] == "" then table.remove(tbl, 2) end
	local newdir = {}
	local files = {}

	if pc:GetFileSystem() then
		files = pc:GetFileSystem()
	else
		return false
	end

	function getdir(tabl, name)
		if tabl == files then return files[3] end
		for k, v in pairs(tabl) do
			if not v[1] then
				if v[2] == name then
					return v[3]
				end
			end
		end
	end
	
	if tbl[1] == "" then
		newdir = files
	elseif tbl[1] == ".." then
		if path != "/" then
			local temp1 = string.Explode("/", path)
			table.remove(temp1, #temp1)
			return opendir(pc, "/" .. table.concat(temp1, "/"))
		end
	else
		newdir = opendir(pc, dir .. "/" .. path)
	end

	for i=1, #tbl do
		newdir = getdir(newdir, tbl[i])
	end
	return newdir
end

function exists(folder, name)
	if not istable(folder) then return true end
	for k, v in pairs(folder) do
		if(v[2] == name) then
			return true
		end
	end
	return false
end

function isfile(folder, name)
	if not exists(folder, name) then return false end
	for k,v in pairs(folder) do
		if v[2] == name and v[1] then
			return true
		end
	end
	return false
end

function makedir(folder, name)
	local newfolder = {false, name, {}}
	if not exists(folder, name) then
		table.insert(folder, newfolder)
		return true
	end
	return false
end

function newfile(folder, name)
	local newfile = {true, name, 1, ""}
	if not exists(folder, name) then
		table.insert(folder, newfile)
		return true
	end
	return false
end

net.Receive("hacker.opendir", function(len, ply)
	local pc = net.ReadEntity()
	local dir = net.ReadString()
	local response = opendir(pc, dir)
	--for i=1, #response do
	--	table.remove(response[i], 3)
	--end
	net.Start("hacker.dirresponse")
		net.WriteTable(response)
	net.Send(ply)
end)

net.Receive("hacker.updatefile", function(len, ply)
	local pc = net.ReadEntity()
	local file = net.ReadString()
	local dir = net.ReadString()
	
end)