hacker.filebrowser = {}

hacker.programs["filebrowser"] = function()
	hacker.filebrowser.selected = nil

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

	local Directory = vgui.Create("DTextEntry", navbar)
	Directory:Dock(FILL)
	Directory:SetText("/")
	function hacker.filebrowser.setaddressbar(thing)
		Directory:SetText(thing)
	end

	local go = vgui.Create("DButton", navbar)
	go:Dock(LEFT)
	go:SetText("Go")
	go.DoClick = function()
	net.Start("hacker.opendir")
		net.WriteEntity(LocalPlayer().curpc)
		net.WriteString(Directory:GetText())
	net.SendToServer()
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
	IconList.DoClick = function()
		for k,v in pairs(IconList:GetItems()) do
			v:SetBackgroundColor(Color(0,0,0,0))
		end
		hacker.filebrowser.selected = nil
	end
	--IconList:SetSize( 0, 150 )

	local function selectitem(border, name)
		for k,v in pairs(IconList:GetItems()) do
			v:SetBackgroundColor(Color(0,0,0,0))
		end
		border:SetBackgroundColor(Color(0,20,255,100))
		hacker.filebrowser.selected = name
	end

	local function reloadfiles(cur)
		IconList:Clear()
		for k,v in pairs(cur) do
			if not v[1] then
				local border = vgui.Create("DPanel", IconList)
				border:SetSize(64,75)
				border:SetBackgroundColor(Color(0,0,0,0))

				local icon = vgui.Create("DImageButton", border) 
				icon:SetImage("icedcoffee/folder.png")
				icon:SizeToContents()
				icon.DoClick = function()
					selectitem(border, v[2])
				end
				icon.DoDoubleClick = function()
					OpenDir(v[2])
				end
				icon.DoRightClick = function()
					selectitem(border, v[2])
					local right = vgui.Create("DMenu")
					right:SetPos(input.GetCursorPos())
					right:AddOption("cok", function() chat.AddText("cok " .. v[2]) end)
					right:Open()
					
				end

				local lbl = vgui.Create("DLabel", border)
				lbl:SetText(v[2])
				lbl:SetContentAlignment(5)
				lbl:SetDark(1)
				lbl:SetPos(0,55)

				IconList:AddItem(border)
			end
		end

		for k,v in pairs(cur) do
			if v[1] then
				local border = vgui.Create("DPanel", IconList)
				border:SetSize(64,75)
				border:SetBackgroundColor(Color(0,0,0,0))

				local icon = vgui.Create("DImageButton", border) 
				icon:SetImage("icedcoffee/file.png")
				icon:SetSize(64,58)
				icon.DoClick = function()
					selectitem(border, v[2])
					chat.AddText(v[2] .. " was clicked")
				end
				icon.DoRightClick = function()
					selectitem(border, v[2])
					local right = vgui.Create("DMenu")
					right:SetPos(input.GetCursorPos())
					right:AddOption("edit", function() hacker.programs["notepad"](v) end)
					right:Open()
					
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
	hook.Add("DirResponse", "kock", reloadfiles)
	OpenDir("/")
end