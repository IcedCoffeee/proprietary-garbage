hacker.programs["webbrowser"] = function()
	net.Start("hacker.opendir")
		net.WriteEntity(LocalPlayer().curpc)
		net.WriteString("/Apache/public_html")
	net.SendToServer()

	local frame = vgui.Create("DFrame")
	frame:SetTitle("Web Browser")
	frame:SetSize(600, 500)
	frame:Center()
	frame:MakePopup()

	local URLBar = vgui.Create("DTextEntry", frame)
	URLBar:SetSize(550, 20)
	URLBar:SetPos(5, 29)
	URLBar:SetText("temp")//"http://" .. Server.ip .. "/" .. Server.files[2][3][1][3][1][2])
		//URLBar:SetMultiline(true) --dont think this is needed

	hook.Add("DirResponse", "kock", function(cur)
		WebPanel = vgui.Create("DHTML", frame)
		WebPanel:SetSize(590, 445)
		WebPanel:SetPos(5, 50)
		WebPanel:SetHTML([[<link rel="stylesheet" type="text/css" href="https://raw.githubusercontent.com/twbs/bootstrap/master/dist/css/bootstrap.css">]] .. cur[1][4] or "")
		WebPanel:AddFunction("console", "dologin", function(usr, pass)
			--net.Start("ServerLogin")
			--	net.WriteTable({usr, pass, Server.ip})
			--net.SendToServer()
		end)
		WebPanel:SetAllowLua(true)
		hook.Remove("DirResponse", "kock")
	end)

	local WebButton = vgui.Create("DButton", frame)
	WebButton:SetText("Go")
	WebButton:SetPos(556, 29)
	WebButton:SetSize(40, 20)
	WebButton.DoClick = function()
		WebPanel:SetHTML([[<link rel="stylesheet" type="text/css" href="https://raw.githubusercontent.com/twbs/bootstrap/master/dist/css/bootstrap.css">]] .. cur or "")
	end
end