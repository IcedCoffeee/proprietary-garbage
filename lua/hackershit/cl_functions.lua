function UpdateServer()
	net.Start("UpdateServer")
		net.WriteTable(Server)
	net.SendToServer()
end

function NewFolder(node)
	local newfolder = {false, "New Folder", {}}
	table.insert(node.files, newfolder)
	UpdateServer()
end

function NewFile(node)
	local newfile = {true, "New File", "1", ""}
	PrintTable(node.files)
	table.insert(node.files, newfile)
	UpdateServer()
end

-- /Apache/public_html/
function WebDir(filename)
	local jews = string.Replace(filename, "http://" .. Server.ip .. "/", "")
	for i=1, #Server.files[2][3][1][3] do
		if Server.files[2][3][1][3][i][2] == jews then
			return Server.files[2][3][1][3][i]
		end
	end
end	