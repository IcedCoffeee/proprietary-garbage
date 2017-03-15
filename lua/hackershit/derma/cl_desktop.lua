hacker.programs["desktop"] = function()
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
			net.Start("hacker.requestwindow")
				net.WriteEntity(LocalPlayer().curpc)
				net.WriteString("filebrowser")
			net.SendToServer()
		end
		
	local WebButton = vgui.Create("DButton", frame)
		WebButton:SetText("Web Browser")
		WebButton:SetPos(85, 30)
		WebButton:SetSize(70, 25)
		WebButton.DoClick = function()
			net.Start("hacker.requestwindow")
				net.WriteEntity(LocalPlayer().curpc)
				net.WriteString("webbrowser")
			net.SendToServer()
		end
		
	local TutButton = vgui.Create("DButton", frame)
		TutButton:SetText("Tutorial")
		TutButton:SetPos(225, 170)
		TutButton:SetSize(70, 25)
		TutButton.DoClick = function()
			chat.AddText("type demos in console for the tutorial")
		end
	
end