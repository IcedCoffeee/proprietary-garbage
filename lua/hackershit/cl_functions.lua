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
	setaddressbar(dir)
	net.Start("OpenDir")
		net.WriteString(IP)
		net.WriteString(dir)
	net.SendToServer()

end
