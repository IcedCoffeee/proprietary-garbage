function LaptopGUI()
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Server: " .. Server.ip)
	frame:SetSize(800, 600)
	frame:Center()
	frame:MakePopup()
	
	local URLBar = vgui.Create("DTextEntry", frame)
		URLBar:SetPos(125, 30)
		URLBar:SetSize(550, 25)
		URLBar:SetDisabled(true)
		URLBar:SetText(Server.ip or "something's wrong")
		
	local Submit = vgui.Create("DButton", frame)
		Submit:SetText("Go")
		Submit:SetPos(675,30)
		Submit:SetSize(70,25)
		Submit.DoClick = function()
			net.Start("RequestContent")
				net.WriteString(URLBar:GetValue())
			net.SendToServer()
		end
		
	local Tabs = vgui.Create("DColumnSheet", frame)
	Tabs:SetSize(775, 600)
	Tabs:SetPos(0,65)
	
	local tab1 = vgui.Create("DPanel", Tabs)
		tab1:SetSize(650, 500)
		
		WebPanel = vgui.Create("DHTML", tab1)
			WebPanel:Dock(FILL)
			WebPanel:SetHTML(Server.website or "something went wrong")
			WebPanel:AddFunction("console", "dologin", function(usr, pass)
				net.Start("ServerLogin")
					net.WriteTable({usr, pass, Server.ip})
				net.SendToServer()
			end)
			WebPanel:SetAllowLua(true)
			
	Tabs:AddSheet("Internet", tab1, "icon16/world.png")
	
		if Server.files then
		local tab2 = vgui.Create("DPanel", Tabs)
			tab2:SetSize(650, 500)
			local tab21 = vgui.Create("DPanel", Tabs)
			local tab22 = vgui.Create("DPanel", Tabs)
			
		function listdir(node)
			if node.files then
				for i=1, #node.files do
					if node.files[i][1] == false then
						local temp = node:AddNode(node.files[i][2])
						temp.files = node.files[i][3]
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
					listdir(temp)
				end
			end
		
		local Files = vgui.Create("DListView", tab22)
			Files:Dock(FILL)
			Files:SetMultiSelect(false)
			Files:AddColumn("File")
			Files:AddColumn("Version")
			Files:AddColumn("Size")
			FileTree.DoClick = function(_, node)
			Files:Clear()
				if node == rootfolder then
					for i=1, #Server.files do
						if Server.files[i][1] == true then
							Files:AddLine(Server.files[i][2], Server.files[i][3], Server.files[i][4])
						end
					end
				elseif node.files then
					for i=1, #node.files do
						if node.files[i][1] == true then
							Files:AddLine(node.files[i][2], node.files[i][3], node.files[i][4])
						end
					end
				end
			end
			
		local Devider = vgui.Create("DHorizontalDivider", tab2)
			Devider:Dock(FILL)
			Devider:SetLeft(tab21)
			Devider:SetRight(tab22)
			Devider:SetLeftWidth(150)
			Devider:SetDividerWidth(4)
		
		
	Tabs:AddSheet("File Explorer", tab2)
	end
	
	local tab3 = vgui.Create("DPanel", Tabs)
		tab3:SetSize(650, 500)
		
	Tabs:AddSheet("Task Manager", tab3)
	
	local tab4 = vgui.Create("DPanel", Tabs)
		tab4:SetSize(650, 500)
		local lol = tab4:GetParent()
		
	 Tabs:AddSheet("asd", tab4)
end
net.Receive("laptopgui", LaptopGUI)

function ConnectGUI()
	local frame = vgui.Create("DFrame")
		frame:SetTitle("GHack Terminal")
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
		frame:SetTitle("GHack Terminal")
		frame:SetSize(300, 200)
		frame:Center()
		frame:MakePopup()
		
	local URLBar = vgui.Create("DTextEntry", frame)
		URLBar:SetPos(10, 30)
		URLBar:SetSize(275, 25)
		URLBar:SetText(Server.ip or "something's wrong")

	local ConnectButton = vgui.Create("DButton", frame)
		ConnectButton:SetText("Connect")
		ConnectButton:SetPos(10, 60)
		ConnectButton:SetSize(70, 25)
		ConnectButton.DoClick = function()
		end
		
	local WebButton = vgui.Create("DButton", frame)
		WebButton:SetText("Webstie")
		WebButton:SetPos(85, 60)
		WebButton:SetSize(70, 25)
		WebButton.DoClick = function()
			WebBrowserGUI()
		end
		
	local TutButton = vgui.Create("DButton", frame)
		TutButton:SetText("Tutorial")
		TutButton:SetPos(225, 170)
		TutButton:SetSize(70, 25)
		TutButton.DoClick = function()
		end
	
end
net.Receive("maingui", MainGUI)

function WebBrowserGUI()
	local frame = vgui.Create("DFrame")
		frame:SetTitle("Web Browser")
		frame:SetSize(600, 500)
		frame:Center()
		frame:MakePopup()
		
	WebPanel = vgui.Create("DHTML", frame)
		WebPanel:Dock(FILL)
		WebPanel:SetHTML(Server.website or "something went wrong")
		WebPanel:AddFunction("console", "dologin", function(usr, pass)
			net.Start("ServerLogin")
				net.WriteTable({usr, pass, Server.ip})
			net.SendToServer()
		end)
		WebPanel:SetAllowLua(true)
end