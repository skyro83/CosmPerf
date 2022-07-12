util.AddNetworkString("SendTicket")
util.AddNetworkString("EmitTicket")
util.AddNetworkString("takeTicket")
util.AddNetworkString("EmitTt")
util.AddNetworkString("dashboardticket")


local adminUsergroup = {
    ["superadmin"] = true,
    ["admin"] = true
}
local function myScriptIsAdmin(toCheck)
    if (!IsValid(toCheck) || !toCheck:IsPlayer()) then return false end

    return adminUsergroup[toCheck:GetUserGroup()]
end

local function myScriptGetOnlineAdmins()
    local admins = {}
    for _, target in ipairs(player.GetAll()) do
        if myScriptIsAdmin(target) then
            admins[#admins + 1] = target
        end
    end
    return admins
end

net.Receive("SendTicket", function (len, ticketCreator)
    local raison = net.ReadString()
    local gravity = net.ReadString()

    print("Un ticket vient d'être ouvert pour la raison suivante : ".. raison .. " par : " ..ticketCreator:Nick().. " avec la gravité suivante : ".. gravity)

    local onlineAdmins = myScriptGetOnlineAdmins()

    net.Start("EmitTicket")
    net.WriteEntity(ticketCreator)
    net.WriteString(gravity)
    net.WriteString(raison)
    net.Send(onlineAdmins)
end)



net.Receive("takeTicket", function(_, ply)
    ticket_action = true
    ticket_state = util.JSONToTable(file.Read("cosmperf/ticket.json", "DATA")) or {ticket_state = 0} -- Ici on lit ce qu'il y a dans le fichier ticket.json et on le convertit en tableau.
    local save = {} -- Ici on initialise la variable save à vide.
    if ticket_action then -- Ici on vérifie si la variable ticket_action est à true.
        ticket_state.ticket_state = ticket_state.ticket_state + 1  -- Ici on incrémente la variable ticket_state.
        ticket_state.steamid = ply:SteamID()
        save.ticket_state = ticket_state.ticket_state -- Ici on assigne la variable ticket_state à la variable save.ticket_state.
        save.steamid = ticket_state.steamid
    end
    PrintTable(ticket_state)

    local tab = util.TableToJSON( save ) -- Ici on convertit la variable save en JSON.
    file.CreateDir("cosmperf") -- ici on crée le dossier cosmperf.
    file.Write("cosmperf/ticket.json", tab) -- ici on écrit dans le fichier ticket.json.

    local new = table.ToString( ticket_state )
    net.Start("dashboardticket")
            net.WriteString(new)
    net.Send(ply)

end)