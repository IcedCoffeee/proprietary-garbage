function LaptopGUI()
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Server: " .. Server.ip)
	frame:SetSize(600, 400)
	frame:Center()
	frame:MakePopup()
	
	if Server.files then
		local tab2 = vgui.Create("DPanel", frame)
			tab2:SetSize(590, 365)
			tab2:SetPos(5,30)
			local tab21 = vgui.Create("DPanel", Tabs)
			local tab22 = vgui.Create("DPanel", Tabs)
			
		function listdir(node)
			if node.files then
				for i=1, #node.files do
					if node.files[i][1] == false then
						local temp = node:AddNode(node.files[i][2])
						temp.files = node.files[i][3]
						temp.self = node.files[i]
						listdir(temp)
					end
				end
			end
		end
			
		FileTree = vgui.Create("DTree", tab21)
			FileTree:Dock(FILL)
			local rootfolder = FileTree:AddNode("root")
			for i=1, #Server.files do
				if Server.files[i][1] == false then
					local temp = rootfolder:AddNode(Server.files[i][2])
					temp.files = Server.files[i][3]
					temp.self = Server.files[i]
					listdir(temp)
				end
			end
			function FileTree:DoRightClick(node)
				if node != rootfolder then
				local Menu = DermaMenu()
					local SubMenu = Menu:AddSubMenu("New")
						SubMenu:AddOption("File", function() NewFile(node) end)
						SubMenu:AddOption("Folder", function() NewFolder(node) end)
					Menu:AddSpacer()
					Menu:AddOption("Rename", function() RenameGUI(node.self, node) end)
					Menu:AddOption("Copy")
					Menu:AddOption("Cut")
					Menu:AddOption("Delete")
					Menu:Open()
				end
			end
		
		local Files = vgui.Create("DListView", tab22)
			Files:Dock(FILL)
			Files:SetMultiSelect(false)
			Files:AddColumn("File")
			Files:AddColumn("Version")
			Files:AddColumn("Size")
			Files:SetMouseInputEnabled(true)
			FileTree.DoClick = function(wut, node)
			Files:Clear()
				if node == rootfolder then
					for i=1, #Server.files do
						if Server.files[i][1] == true then
							Files:AddLine(Server.files[i][2], Server.files[i][3], string.len(Server.files[i][4]) .. " Bytes").file = Server.files[i]
						end
					end
				elseif node.files then
					for i=1, #node.files do
						if node.files[i][1] == true then
							Files:AddLine(node.files[i][2], node.files[i][3], string.len(node.files[i][4]) .. " Bytes").file = node.files[i]
						end
					end
				end
			end
			Files.OnRowRightClick = function( ay, line )
				--print(ay:GetLine(line).file)
				--PrintTable(ay:GetLine(line).file)
				local data = ay:GetLine(line).file
				--print(ay:GetLine(line).Columns[1].asd)
				local Menu = DermaMenu()
				if ay:GetLine(line).Columns[1].Value:Split(".")[2] == "exe" then
					Menu:AddOption("Run")
				else
					Menu:AddOption("Edit with Note++", function() NotepadGUI(data) end)
				end
				Menu:AddSpacer()

				Menu:AddOption("Rename", function() RenameGUI(data, ay:GetLine(line).Columns[1]) end)
				Menu:AddOption("Copy")
				Menu:AddOption("Cut")
				Menu:AddOption("Delete")
				Menu:Open()
			end
			Files.DoDoubleClick = function( ay, line )
				local data = ay:GetLine(line).file
				if ay:GetLine(line).Columns[1].Value:Split(".")[2] == "exe" then
					chat.AddText("running " .. ay:GetLine(line).Columns[1].Value)
				else
					NotepadGUI(data)
				end
			end
		
		local Devider = vgui.Create("DHorizontalDivider", tab2)
			Devider:Dock(FILL)
			Devider:SetLeft(tab21)
			Devider:SetRight(tab22)
			Devider:SetLeftWidth(150)
			Devider:SetDividerWidth(4)
			
	end
end
net.Receive("laptopgui", LaptopGUI)

function ConnectGUI()
	local frame = vgui.Create("DFrame")
		frame:SetTitle("Personal Computer")
		frame:SetSize(200, 60)
		frame:Center()
		frame:MakePopup()
		
	local URLBar = vgui.Create("DTextEntry", frame)
		URLBar:SetPos(10, 30)
		URLBar:SetSize(125, 25)
		URLBar:SetText(Server.ip or "something's wrong")

	local ConnectButton = vgui.Create("DButton", frame)
		ConnectButton:SetText("Connect")
		ConnectButton:SetPos(140, 30)
		ConnectButton:SetSize(50, 25)
		ConnectButton.DoClick = function()
		end
end
net.Receive("connectgui", ConnectGUI)

function MainGUI()
	local frame = vgui.Create("DFrame")
		frame:SetTitle("Personal Computer")
		frame:SetSize(300, 200)
		frame:Center()
		frame:MakePopup()
		
	/*local URLBar = vgui.Create("DTextEntry", frame)
		URLBar:SetPos(10, 30)
		URLBar:SetSize(275, 25)
		URLBar:SetText(Server.ip or "something's wrong")

	local ConnectButton = vgui.Create("DButton", frame)
		ConnectButton:SetText("Connect")
		ConnectButton:SetPos(10, 60)
		ConnectButton:SetSize(70, 25)
		ConnectButton.DoClick = function()
		end*/
		
	local FileButton = vgui.Create("DButton", frame)
		FileButton:SetText("File Browser")
		FileButton:SetPos(10, 30)
		FileButton:SetSize(70, 25)
		FileButton.DoClick = function()
			LaptopGUI()
		end
		
	local WebButton = vgui.Create("DButton", frame)
		WebButton:SetText("Web Browser")
		WebButton:SetPos(85, 30)
		WebButton:SetSize(70, 25)
		WebButton.DoClick = function()
			WebBrowserGUI()
		end
		
	local TutButton = vgui.Create("DButton", frame)
		TutButton:SetText("Tutorial")
		TutButton:SetPos(225, 170)
		TutButton:SetSize(70, 25)
		TutButton.DoClick = function()
			chat.AddText("type demos in console for the tutorial")
		end
	
end
net.Receive("maingui", MainGUI)

function NotepadGUI(tbl)
	tbl = tbl or {}
	local frame = vgui.Create("DFrame")
		frame:SetTitle("Note++")
		frame:SetSize(600, 500)
		frame:Center()
		frame:MakePopup()

	local URLBar = vgui.Create("DTextEntry", frame)
		URLBar:Dock(FILL)
		URLBar:SetText(tbl[4])
		URLBar:SetMultiline(true)
		
	local MenuBar = vgui.Create("DMenuBar", frame)
		MenuBar:DockMargin(-3, -6, -3, 0)

	local M1 = MenuBar:AddMenu("File")
		M1:AddOption("New", function() 
			Msg("Chose File:New\n")
		end):SetIcon("icon16/page_white_go.png")

		M1:AddOption("Save", function() 
			tbl[4] = URLBar:GetValue()
			UpdateServer()
		end):SetIcon("icon16/folder_go.png")

	local M2 = MenuBar:AddMenu( "Edit" )
		M2:AddOption("Copy", function() 
			Msg("Chose Edit:Copy\n")
		end)

	local M3 = MenuBar:AddMenu("Help")
		M3:AddOption("About", function() 
			Msg("Chose Help:About\n")
		end)
		
end

function WebBrowserGUI()
	local frame = vgui.Create("DFrame")
		frame:SetTitle("Web Browser")
		frame:SetSize(600, 500)
		frame:Center()
		frame:MakePopup()

	local URLBar = vgui.Create("DTextEntry", frame)
		URLBar:SetSize(550, 20)
		URLBar:SetPos(5, 29)
		URLBar:SetText("http://" .. Server.ip .. "/" .. Server.files[2][3][1][3][1][2])
		URLBar:SetMultiline(true)
		
	WebPanel = vgui.Create("DHTML", frame)
		WebPanel:SetSize(590, 475)
		WebPanel:SetPos(5, 50)
		WebPanel:SetHTML([[<link rel="stylesheet" type="text/css" href="https://raw.githubusercontent.com/twbs/bootstrap/master/dist/css/bootstrap.css">]] .. Server.files[2][3][1][3][1][4] or "")
		WebPanel:AddFunction("console", "dologin", function(usr, pass)
			net.Start("ServerLogin")
				net.WriteTable({usr, pass, Server.ip})
			net.SendToServer()
		end)
		WebPanel:SetAllowLua(true)

	local WebButton = vgui.Create("DButton", frame)
		WebButton:SetText("Go")
		WebButton:SetPos(556, 29)
		WebButton:SetSize(40, 20)
		WebButton.DoClick = function()
			WebPanel:SetHTML([[<link rel="stylesheet" type="text/css" href="https://raw.githubusercontent.com/twbs/bootstrap/master/dist/css/bootstrap.css">]] .. WebDir(URLBar:GetValue())[4] or "")
		end
end

function RenameGUI(tbl, node)
	local frame = vgui.Create("DFrame")
		frame:SetTitle("Rename")
		frame:SetSize(250, 65)
		frame:Center()
		frame:MakePopup()

	local TextBox = vgui.Create("DTextEntry", frame)
		TextBox:SetPos(5, 30)
		TextBox:SetSize(180, 25)
		TextBox:SetText(tbl[2])

	local WebButton = vgui.Create("DButton", frame)
		WebButton:SetText("OK")
		WebButton:SetPos(190, 30)
		WebButton:SetSize(50, 25)
		WebButton.DoClick = function()
			tbl[2] = TextBox:GetValue()
			frame:Close()
			if IsValid(node) then
				node:SetText(TextBox:GetValue())
			end
			UpdateServer()
		end
end