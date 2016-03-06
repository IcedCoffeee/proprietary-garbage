function LaptopGUI()
	dir = "/"
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Server: " )
	frame:SetSize(600, 400)
	frame:Center()
	frame:MakePopup()

	local MenuBar = vgui.Create("DMenuBar", frame)
		MenuBar:DockMargin(-3, -6, -3, 0)
		MenuBar:Dock(TOP)

	local M1 = MenuBar:AddMenu("File")
		M1:AddOption("New", function() 
			Msg("Chose File:New\n")
		end):SetIcon("icon16/page_white_go.png")

		M1:AddOption("Save", function() 
			Msg("jews")
		end):SetIcon("icon16/folder_go.png")

	local M2 = MenuBar:AddMenu( "Edit" )
		M2:AddOption("Copy", function() 
			Msg("Chose Edit:Copy\n")
		end)

	local M3 = MenuBar:AddMenu("Help")
		M3:AddOption("About", function() 
			Msg("Chose Help:About\n")
		end)

	local navbar = vgui.Create("DPanel", frame)
		navbar:Dock(TOP)
		navbar:DockMargin(-3, 0, -3, 1)
		navbar:DockPadding(-1, -1, -1, -1)

	local back = vgui.Create("DButton", navbar)
		back:Dock(LEFT)
		back:SetText("Back")
		back.DoClick = function()
			OpenDir("..")
		end

	local go = vgui.Create("DButton", navbar)
		go:Dock(LEFT)
		go:SetText("Go")

	local Directory = vgui.Create("DTextEntry", navbar)
		Directory:Dock(FILL)
		Directory:SetText("/")
		function setaddressbar(thing)
			Directory:SetText(thing)
		end

	local Panel = vgui.Create("DPanel", frame)
		Panel:Dock(FILL)
		Panel:DockMargin(-3, 0, -3, -3)

	local IconList = vgui.Create("DPanelList", Panel) 
		IconList:Dock(FILL)
		//IconList:SetAutoSize(true)
		IconList:EnableVerticalScrollbar(true) 
		IconList:EnableHorizontal(true) 
		IconList:SetSpacing(8)
		IconList:SetPadding(4)
		--IconList:SetSize( 0, 150 )
		reloadfiles = function()
		IconList:Clear()
		for k,v in pairs(CurrentDir) do
			if not v[1] then
				local border = vgui.Create("DPanel", IconList)
					border:SetSize(64,75)
					border:SetDrawBackground(false)
				local icon = vgui.Create("DImageButton", border) 
				icon:SetImage("icedcoffee/folder.png")
				icon:SizeToContents()
				icon.DoClick = function() OpenDir(v[2]) end
				local lbl = vgui.Create("DLabel", border)
					lbl:SetText(v[2])
					lbl:SetContentAlignment(5)
					lbl:SetDark(1)
					lbl:SetPos(0,55)
				IconList:AddItem(border)
			end
		end

		for k,v in pairs(CurrentDir) do
			if v[1] then
				local border = vgui.Create("DPanel", IconList)
					border:SetSize(64,75)
					border:SetDrawBackground(false)
				local icon = vgui.Create("DImageButton", border) 
				icon:SetImage("icedcoffee/file.png")
				icon:SetSize(64,58)
				icon.DoClick = function() 
					chat.AddText(v[2] .. " was clicked")
				end
				local lbl = vgui.Create("DLabel", border)
					lbl:SetText(v[2])
					lbl:SetContentAlignment(5)
					lbl:SetDark(1)
					lbl:SetPos(0,55)
				IconList:AddItem(border)
			end
		end
		end
		reloadfiles()
		OpenDir("/")
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
		WebPanel:SetSize(590, 445)
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