function OpenDir(folder)
	if folder != ".." then
		if folder == "/"  then
			dir = "/"
		elseif dir == "/" then
			dir = "/" .. folder
		else
			dir = dir .. "/" .. folder
		end
	else
		local temp1 = string.Explode("/", dir)
		table.remove(temp1, #temp1)
		dir = table.concat(temp1, "/")
	end
	if dir == "" then dir = "/" end
	hacker.filebrowser.setaddressbar(dir)
	net.Start("hacker.opendir")
		net.WriteEntity(LocalPlayer().curpc)
		net.WriteString(dir)
	net.SendToServer()

end

net.Receive("hacker.dirresponse", function()
	local res = net.ReadTable()
	if res != nil then
		hook.Run("DirResponse", res)
		CurrentDir = res
	end
end)

function UpdateFile(file, dir)
	net.Start("hacker.updatefile")
		net.WriteEntity(LocalPlayer().curpc)
		net.WriteString(file)
		net.WriteString(dir)
	net.SendToServer()
end