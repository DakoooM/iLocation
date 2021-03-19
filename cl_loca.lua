CreateThread(function()
    while true do
        if CinemaMode then
            DrawRect(0.471, 0.0485, 1.065, 0.13, 0, 0, 0, 255) -- Barre de haut
            DrawRect(0.503, 0.935, 1.042, 0.13, 0, 0, 0, 255) -- Barre de bas
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(19)
            HideHudAndRadarThisFrame()
        else
            Wait(1200)
        end
        Wait(1)
    end
end)

local function Notification(msg) 
    SetNotificationTextEntry('STRING') 
    AddTextComponentSubstringPlayerName(msg) 
    DrawNotification(false, true) 
end

local locationopenmenu = false
RMenu.Add("dLoc", "mainmenu", RageUI.CreateMenu("Location", "Choix du Véhicule", 10, 100))
RMenu:Get("dLoc", "mainmenu").Closed = function()
    locationopenmenu = false
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(0, 1, 800, 0, 0)
end;

local CreatePedTables = {}
local function ScenarioLoc(var)
    Notification(DakoM.LivraisonVehGo)
    RageUI.CloseAll()
    locationopenmenu = false

    local cameraloc = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamActive(cameraloc, true)
    SetCamParams(cameraloc, var.spawnpoint.x, var.spawnpoint.y, var.spawnpoint.z+2.0, -10.0, 0.0, var.cameraheading, 42.24, 0, 1, 1, 2)
    SetCamFov(cameraloc, 45.0)
    RenderScriptCams(1, 1, 1200, 1, 1)

    CinemaMode = true
    local modelloc = GetHashKey(var.vehnamespawn)
    RequestModel(modelloc)
    while not HasModelLoaded(modelloc) do Wait(10) end
    vehloca = CreateVehicle(modelloc, var.spawnpoint.x, var.spawnpoint.y, var.spawnpoint.z, var.headspawnpoint, true, false)
    SetVehicleNumberPlateText(vehloca, "loc-"..math.random(50, 999))
    SetVehRadioStation(vehloca, false)
    RequestModel(GetHashKey(var.pedname))
    while not HasModelLoaded(GetHashKey(var.pedname)) do Wait(1) end
    local pedvehlocc = CreatePed(4, var.hashped, var.spawnpoint.x, var.spawnpoint.y, var.spawnpoint.z, 3374176, false, true)
    table.insert(CreatePedTables, pedvehlocc)
    SetPedIntoVehicle(pedvehlocc, vehloca, -1)
    Wait(30)
    TaskVehicleDriveToCoord(pedvehlocc, vehloca, var.drivetocoords.x, var.drivetocoords.y, var.drivetocoords.z, 8.0, 0, GetEntityModel(vehloca), 411, 10.0)
    Wait(var.Waitaftervehtocoord)
    CinemaMode = false
    RenderScriptCams(0, 1, 1200, 0, 0)
    FreezeEntityPosition(PlayerPedId(), false)
    TaskLeaveAnyVehicle(pedvehlocc, true, false)
    Wait(1900)
    for _, omg in pairs (CreatePedTables) do 
        DeleteEntity(omg) 
    end
end

local function openLocationM()
	if locationopenmenu then
		locationopenmenu = false
    else
        locationopenmenu = true
        RageUI.Visible(RMenu:Get("dLoc", "mainmenu"), true)
        FreezeEntityPosition(PlayerPedId(), true)
    CreateThread(function()
        while ESX == nil do TriggerEvent(DakoM.SharedObject, function(obj) ESX = obj end) Wait(10) end 
        while locationopenmenu do
            Wait(1)
                RageUI.IsVisible(RMenu:Get("dLoc", "mainmenu"), true, true, true, function()

                    for _, var in pairs (DakoM.LocationVeh) do
                        RageUI.ButtonWithStyle(var.VehnameLabel, nil, {RightBadge = RageUI.BadgeStyle.Car, RightLabel = "~g~$" ..var.price}, true, function(_, _, s)
                            if s then
                                    if not ESX.Game.IsSpawnPointClear(var.spawnpoint, var.radiuscheck) then
                                        Notification(DakoM.SpawnPointBlocked)
                                    else
                                        ESX.TriggerServerCallback("DakoM:PaymentLocation", function(HasPrice) 
                                            if HasPrice then
                                                ScenarioLoc(var)
                                            else
                                                Notification(DakoM.NoEgouhtMoney)
                                            end
                                    end, tonumber(var.price))
                                end
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

CreateThread(function()
    for _, pedloc in pairs (DakoM.PedSpawning) do
        RequestModel(GetHashKey(pedloc.name))
        while not HasModelLoaded(GetHashKey(pedloc.name)) do
            Wait(1)
        end
        local pedlocation = CreatePed(4, pedloc.hash, pedloc.spawnpos.x, pedloc.spawnpos.y, pedloc.spawnpos.z-1, 3374176, false, true)
        SetEntityHeading(pedlocation, pedloc.heading)
        FreezeEntityPosition(pedlocation, true)
        SetEntityInvincible(pedlocation, true)
        SetBlockingOfNonTemporaryEvents(pedlocation, true) 
    end
    while true do
        local CoordsP2 = GetEntityCoords(PlayerPedId())
        local found = false
        for _,dakk in pairs(DakoM.LocationPos) do
            if #(CoordsP2 - dakk.posloc) < 1.5 then
                found = true
                BeginTextCommandDisplayHelp('STRING') 
                AddTextComponentSubstringPlayerName("Appuyer sur ~INPUT_PICKUP~ accèder au véhicules") 
                EndTextCommandDisplayHelp(0, false, true, -1)
                if IsControlJustReleased(0, 38) then
                    if locationopenmenu == false then
                        openLocationM()
                    end
                end
            elseif #(CoordsP2 - dakk.posloc) < 7.0 then
                found = true
                DrawMarker(21, dakk.posloc, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, dakk.ColorR, dakk.ColorG, dakk.ColorB, dakk.ColorA, 0, 1, 2, 0, nil, nil, 0)
            end
        end
        if found then
            Wait(1)
        else
            Wait(1500)
        end
    end
end)