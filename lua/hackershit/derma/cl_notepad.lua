hacker.programs["notepad"] = function(tbl, dir)
	tbl = tbl or {}

	local frame = vgui.Create("DFrame")
	frame:SetTitle("Note++")
	frame:SetSize(600, 500)
	frame:Center()
	frame:MakePopup()

	local TextBox = vgui.Create("DTextEntry", frame)
	TextBox:Dock(FILL)
	TextBox:SetText(tbl[4])
	TextBox:SetMultiline(true)
		
	local MenuBar = vgui.Create("DMenuBar", frame)
	MenuBar:DockMargin(-3, -6, -3, 0)

	local M1 = MenuBar:AddMenu("File")
	M1:AddOption("New", function() 
		Msg("Chose File:New\n")
	end):SetIcon("icon16/page_white_go.png")

	M1:AddOption("Save", function() 
		tbl[4] = TextBox:GetValue()
		//UpdateServer()
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
