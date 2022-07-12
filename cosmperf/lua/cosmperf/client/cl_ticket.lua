hook.Add( "OnPlayerChat", "CosmPerfTicket", function( ply, strText, bTeam, bDead ) 
    if ( ply != LocalPlayer() ) then return end

	strText = string.lower( strText ) -- make the string lower case

	if ( strText == cosmperf.Config.TicketCommand ) then -- if the player typed /hello then
		
        
---------------------------------------------------------------
---------------------------------------------------------------
------------------------Variable-------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
        local main = vgui.Create("DFrame")
        local close = vgui.Create("DButton", main)
        local submit = vgui.Create("DButton", main)
        local gravity = vgui.Create("DComboBox", main)
        local raison = vgui.Create("DComboBox", main)


---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------


        


        main:SetSize(respW(400), respH(800))
        main:Center()
        main:SetDraggable(false)
        main:MakePopup()
        main:SizeIn()
        main:ShowCloseButton(false)
        main:SetTitle("")
        function main:Paint(w, h)
            draw.RoundedBox(16, 0, 0, w, h, cl1)
            draw.SimpleText("Bienvenue", "Title-2", respW(200), respH(100), color_white, TEXT_ALIGN_CENTER)
        end


---------------------------------------------------------------
---------------------------------------------------------------
------------------------Bouton-------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

        close:SetSize(respW(300), respH(50))
        close:SetPos(respW(50), respH(700))
        close:SetText("")

        function close:Paint(w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(128, 28, 28))
            draw.SimpleText("Fermer", "trebuchet24", respW(150), respH(12), color_white, TEXT_ALIGN_CENTER)
        end
        function close:DoClick()
            main:Close()
        end


        
        submit:SetSize(respW(300), respH(50))
        submit:SetPos(respW(50), respH(600))
        submit:SetText("")

        function submit:Paint(w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(20, 177, 72))
            draw.SimpleText("Soumettre", "trebuchet24", respW(150), respH(12), color_white, TEXT_ALIGN_CENTER)
        end
        function submit:DoClick()
            net.Start("SendTicket")
                net.WriteString(raison:GetValue())
                net.WriteString(gravity:GetValue())
            net.SendToServer()
            main:Close()
        end


---------------------------------------------------------------
---------------------------------------------------------------
------------------------TextEntry-------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

        gravity:SetSize(respW(300), respH(50))
        gravity:SetPos(respW(50), respH(200))
        gravity:SetValue( "Choisir une gravité" )
        gravity:AddChoice( "Basse" )
        gravity:AddChoice( "Moyenne" )
        gravity:AddChoice( "Haute" )
        gravity:SetFont("trebuchet24")
        gravity:SetTextColor(color_white)

        function gravity:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, cl2)
        end


        raison:SetSize(respW(300), respH(50))
        raison:SetPos(respW(50), respH(300))
        raison:SetValue( "Choisir une raison" )
        raison:AddChoice( "Troll" )
        raison:AddChoice( "Freekill" )
        raison:AddChoice( "Insulte" )
        raison:SetFont("trebuchet24")
        raison:SetTextColor(color_white)

        function raison:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, cl2)
        end


---------------------------------------------------------------
---------------------------------------------------------------
------------------------Ticket-------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

net.Receive("EmitTicket", function()
    local ticketCreator = net.ReadEntity()
    local gravity = net.ReadString()
    local raison = net.ReadString()

    if (!IsValid(ticketCreator) || !ticketCreator:IsPlayer()) then return end

    ticket(ticketCreator, gravity, raison)
end)

function ticket(ticketCreator, gravity, raison)
    chat.AddText( Color( 100, 100, 255 ), ticketCreator:Nick(), ", a ouvert un ticket (vous voyez ce message car vous êtes admins) " )

    local panel = vgui.Create("DFrame")
    panel:SetSize(respW(350), respH(200))
    panel:SetPos(respW(50), respH(50))
    panel:SetTitle("")
    panel:SetDraggable(true)
    panel:ShowCloseButton(false)
    function panel:Paint(w, h)
        draw.RoundedBox(12, 0, 0, w, h,cl1)
        draw.SimpleText("Ticket de : "..ticketCreator:Nick(), "ticket", respW(20), respH(10), color_white, TEXT_ALIGN_LEFT)
        draw.SimpleText("Gravité : ".. gravity, "ticket", respW(70), respH(50), color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText("Raison : ".. raison, "ticket", respW(70), respH(90), color_white, TEXT_ALIGN_CENTER)
    end
    local x = vgui.Create("DButton", panel)
    x:SetText("")
    x:SetSize(respW(30), respH(30))
    x:SetPos(respW(325), respH(5))
    function x:Paint(w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,0))
        draw.SimpleText("X", "trebuchet24", respW(10), 0, color_white, TEXT_ALIGN_CENTER)
    end
    function x:DoClick()
        panel:Close()
    end

    local take = vgui.Create("DButton", panel)
    take:SetSize(respW(100), respH(30))
    take:SetPos(respW(20), respH(120))
    take:SetText("")

    function take:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, cl2)
        draw.SimpleText("Prendre", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
        if (take:IsHovered()) then
            draw.RoundedBox(0, 0, 0, w, h, Color(36, 69, 110))
            draw.SimpleText("Prendre", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
        end
    end

    function take:DoClick()
        take:Remove()
        net.Start("takeTicket")
        net.SendToServer()

        local go = vgui.Create("DButton", panel)
        go:SetSize(respW(100), respH(30))
        go:SetPos(respW(20), respH(120))
        go:SetText("")

    function go:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, cl2)
        draw.SimpleText("Aller", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
        if (go:IsHovered()) then
            draw.RoundedBox(0, 0, 0, w, h, Color(36, 69, 110))
            draw.SimpleText("Aller", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
        end
    end

    function go:DoClick()
        RunConsoleCommand("say", "!goto "..ticketCreator:Name())
    end




    local ret = vgui.Create("DButton", panel)
        ret:SetSize(respW(100), respH(30))
        ret:SetPos(respW(150), respH(120))
        ret:SetText("")

    function ret:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, cl2)
        draw.SimpleText("Retourner", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
        if (ret:IsHovered()) then
            draw.RoundedBox(0, 0, 0, w, h, Color(36, 69, 110))
            draw.SimpleText("Retourner", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
        end
    end

    function ret:DoClick()
        RunConsoleCommand("say", "!return "..ticketCreator:Name())
    end

    local tp = vgui.Create("DButton", panel)
    tp:SetSize(respW(100), respH(30))
    tp:SetPos(respW(20), respH(160))
    tp:SetText("")

function tp:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, cl2)
    draw.SimpleText("Téléporter", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
    if (tp:IsHovered()) then
        draw.RoundedBox(0, 0, 0, w, h, Color(36, 69, 110))
        draw.SimpleText("Téléporter", "Cart-Font", respW(50), respH(5), color_white, TEXT_ALIGN_CENTER)
    end
end

function tp:DoClick()
    RunConsoleCommand("say", "!teleport "..ticketCreator:Name())
end



    end
end




		return true -- this suppresses the message from being shown
	end
end )