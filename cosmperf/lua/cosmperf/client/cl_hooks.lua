hook.Add("OnPlayerChat", "CosmPerfRun", function(ply, strText)
	if (ply != LocalPlayer()) then return end

	strText = string.lower( strText )

	if ( strText == cosmperf.Config.Command ) then
		if cosmperf.Config.AdminRanks[LocalPlayer():GetUserGroup()] then
					--- Variables
		local main = vgui.Create("DFrame")
		local panel = vgui.Create("DFrame", main)
		local home = vgui.Create("DButton", main)
		local close = vgui.Create("DButton", main)
		local pr = Material("materials/icons/profil.png")
		local dashboard = Material("materials/icons/home.png")
		local moneyic = Material("materials/icons/money.png")
		local people = Material("materials/icons/people.png")
		local latence = Material("materials/icons/connexion.png")
		local iclose = Material("materials/icons/leave.png")
		local iset = Material("materials/icons/setting.png")
		local spectateic = Material("materials/icons/eye.png")
		local panel_money = vgui.Create("DPanel", panel)
		local panel_ping = vgui.Create("DPanel", panel)
		local panel_player = vgui.Create("DPanel", panel)
		local profil = vgui.Create("DFrame", panel)
		local avatar = vgui.Create("AvatarImage", profil)

		local watch = vgui.Create("DButton", main)
		local settings = vgui.Create("DButton", main)
		-----------------------------------

			net.Receive("dashboardticket", function ()
				local  new = net.ReadString()
				nombreticket(new) 
			end)


		main:SetSize(ScrW(), ScrH())
		main:Center()
		main:MakePopup()
		main:SetDraggable(false)
		main:SizeIn()
		main:SetTitle("")

		function main:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, cl1)
		end


		panel:SetSize(respW(1520), ScrH())
		panel:SetPos(respW(400), 0)
		panel:SetDraggable(false)
		panel:ShowCloseButton(false)
		panel:SetTitle("")
		function panel:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, cl2)
		end


		---------------------------------------------
		---------------------------------------------
		---------------------------------------------		
		---------------------------------------------
		local totalMoney = 0
		local highBase = 0
		local money = 0

		for k, v in pairs( player.GetAll() ) do
			local vMoney = v:getDarkRPVar( "money" ) or 0
			money = money + vMoney
		end


		panel_money:SetSize(respW(300), respH(100))
		panel_money:SetPos(respW(50), respH(100))
		function panel_money:Paint(w, h)
			draw.RoundedBox(16, 0, 0, w, h, cl1)
			draw.SimpleText("Argent total du serveur :", "Cart-Font", respW(200), respH(20), color_white, TEXT_ALIGN_CENTER)
			draw.SimpleText(money.. " €", "trebuchet24", respW(155), respH(50), color_white, TEXT_ALIGN_CENTER)
			surface.SetMaterial( moneyic ) -- Use our cached material
			surface.DrawTexturedRect( respW(10), respH(12), respW(70), respH(70) ) -- Actually draw the rectangle
		end

		panel_ping:SetSize(respW(300), respH(100))
		panel_ping:SetPos(respW(375), respH(100))
		function panel_ping:Paint(w, h)
			draw.RoundedBox(16, 0, 0, w, h, cl1)
			draw.SimpleText("Ping du serveur :", "Cart-Font", respW(200), respH(20), color_white, TEXT_ALIGN_CENTER)
			draw.SimpleText(GetAveragePing(), "trebuchet24", respW(150), respH(50), color_white, TEXT_ALIGN_CENTER)
			surface.SetMaterial( latence ) -- Use our cached material
			surface.DrawTexturedRect( respW(10), respH(12), respW(70), respH(70) ) -- Actually draw the rectangle
		end

		panel_player:SetSize(respW(300), respH(100))
		panel_player:SetPos(respW(700), respH(100))
		function panel_player:Paint(w, h)
			draw.RoundedBox(16, 0, 0, w, h, cl1)
			draw.SimpleText("Joueurs connectés :", "Cart-Font", respW(200), respH(20), color_white, TEXT_ALIGN_CENTER)
			draw.SimpleText(#player.GetAll().." / " ..game.MaxPlayers().." Joueurs", "trebuchet24", respW(190), respH(50), color_white, TEXT_ALIGN_CENTER)
			surface.SetMaterial( people ) -- Use our cached material
			surface.DrawTexturedRect( respW(10), respH(12), respW(70), respH(70) ) -- Actually draw the rectangle
		end
		function nombreticket(new)
			local panel_ticket = vgui.Create("DFrame", profil)
			panel_ticket:SetSize(respW(200), respH(75))
			panel_ticket:SetPos(respW(10), respH(400))
			panel_ticket:SetTitle("")
			panel_ticket:SetDraggable(false)
			panel_ticket:ShowCloseButton(false)
			function panel_ticket:Paint(w, h)
				draw.RoundedBox(16, 0, 0, w, h, cl2)
				draw.SimpleText("Ticket Résolus", "Cart-Font", respW(100), respH(20), color_white, TEXT_ALIGN_CENTER)
				draw.SimpleText("new", "trebuchet18", respW(10), respH(10), color_white, TEXT_ALIGN_CENTER)
			end
			print(new)
		end


			
		

		---------------------------------------------
		---------------------------------------------
		---------------------------------------------		
		---------------------------------------------

		profil:SetSize(respW(450), respH(900))
		profil:SetPos(respW(1025), respH(100))
		profil:SetDraggable(false)
		profil:SetTitle("")
		profil:ShowCloseButton(false)
		function profil:Paint(w, h)
			draw.RoundedBox(16, 0, 0, w, h, cl1)
			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color

			surface.SetMaterial( pr ) -- Use our cached material
			surface.DrawTexturedRect(0, 0, w, respH(200)) -- Actually draw the rectangle
			draw.SimpleText(LocalPlayer():Nick(), "Title", respW(225), respH(260), color_white, TEXT_ALIGN_CENTER)
			draw.SimpleText(LocalPlayer():GetUserGroup(), "Cart-Font", respW(225), respH(305), color_white, TEXT_ALIGN_CENTER)
		
		
		end

		avatar:SetSize(respW(84), respH(84))
		avatar:SetPos(respW(183), respH(155))
		avatar:SetPlayer(LocalPlayer(), 84)


		---------------------------------------------
		---------------------------------------------
		---------------------------------------------		
		---------------------------------------------
		home:SetSize(respW(200), respH(30))
		home:SetPos(respW(50), respH(100))
		home:SetText("")
		function home:Paint(w, h)
			surface.SetMaterial( dashboard ) -- Use our cached material
			surface.DrawTexturedRect( respW(0), respH(-2), respW(25), respH(25) ) -- Actually draw the rectangle
			draw.RoundedBox(0, respW(100), 0, w, h, Color(255,255,255,0))
			draw.SimpleText("            Tableau de bord", "trebuchet24", respW(75), respH(0), color_white, TEXT_ALIGN_CENTER)
		end
		function home:DoClick()
			if LocalPlayer():GetNWInt("settings", 1) then
				param:Remove()
				LocalPlayer():SetNWInt("settings", 0)
			end
		end

		close:SetSize(respW(150), respH(30))
		close:SetPos(respW(50), respH(280))
		close:SetText("")
		function close:Paint(w, h)
			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			surface.SetMaterial( iclose ) -- Use our cached material
			surface.DrawTexturedRect( respW(5), respH(0), respW(25), respH(25) ) -- Actually draw the rectangle
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,0))
			draw.SimpleText(" Quitter", "trebuchet24", respW(75), respH(0), color_white, TEXT_ALIGN_CENTER)
		end
		function close:DoClick()
			main:Close()

		end

		watch:SetSize(respW(150), respH(30))
		watch:SetPos(respW(50), respH(160))
		watch:SetText("")
		function watch:Paint(w, h)
			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			surface.SetMaterial( spectateic ) -- Use our cached material
			surface.DrawTexturedRect( respW(0), respH(-5), respW(35), respH(35) ) -- Actually draw the rectangle
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,0))
			draw.SimpleText(" Regarder", "trebuchet24", respW(75), respH(0), color_white, TEXT_ALIGN_CENTER)
		end
		function watch:DoClick()
			main:Close()
		end

		settings:SetSize(respW(150), respH(30))
		settings:SetPos(respW(50), respH(220))
		settings:SetText("")
		function settings:Paint(w, h)
			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			surface.SetMaterial( iset ) -- Use our cached material
			surface.DrawTexturedRect( respW(0), respH(0), respW(25), respH(25) ) -- Actually draw the rectangle
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,0))
			draw.SimpleText(" Paramètres", "trebuchet24", respW(75), respH(0), color_white, TEXT_ALIGN_CENTER)
		end
		function settings:DoClick()
			LocalPlayer():SetNWInt("settings", 1)
			 param = vgui.Create("DPanel", panel)
			param:SetSize(respW(900), respH(600))
			param:SetPos(respW(50), respH(250))
			function param:Paint(w, h)
				draw.RoundedBox(16, 0, 0, w, h, cl1)
				draw.SimpleText("Language", "trebuchet24", respW(150), respH(50), color_white, TEXT_ALIGN_CENTER)
			end
			local c_lang = vgui.Create("DComboBox", param)
			c_lang:SetSize(respW(200), respH(35))
			c_lang:SetPos(respW(50), respH(80))
			c_lang:SetValue( "Language" )
			c_lang:AddChoice( "Français" )
			c_lang:AddChoice( "English" )
			function c_lang:Paint(w, h)
				draw.RoundedBox(6, 0, 0, w, h, cl2)
			end



		end

		---------------------------------------------
		---------------------------------------------
		---------------------------------------------		
		---------------------------------------------
		end




		return true
	end
end)