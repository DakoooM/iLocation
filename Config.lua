DakoM = {}

-- Name of your trigger get esx
DakoM.SharedObject = "esx:getSharedObject" -- get and loading esx

-- Notifications
DakoM.LivraisonVehGo = "~o~Location\n~g~Votre véhicules est en cours de Livraison..."
DakoM.NoEgouhtMoney = "~o~Location\n~r~Vous n'avez pas assez d'argent"
DakoM.SpawnPointBlocked = "~o~Location\n~r~Point de spawn bloquée"

-- Open Menu Position
DakoM.LocationPos = {
    {posloc = vector3(268.6472, -1195.63, 29.30051), ColorR = 255, ColorG = 155, ColorB = 0, ColorA = 220},
    --{posloc = vector3(268.6472, -1195.63, 29.30051), ColorR = 255, ColorG = 155, ColorB = 0, ColorA = 220} -- Second Pos..
}

DakoM.PedSpawning = {
    {
        spawnpos = vector3(268.6748, -1198.827, 29.28918),
        name = "g_m_y_armgoon_02",
        hash = 0xC54E878A,
        heading = 0.4318
    },
    -- Seconds Ped
    -- {
    --     spawnpos = vector3(268.6748, -1198.827, 29.28918),
    --     name = "g_m_y_armgoon_02",
    --     hash = 0xC54E878A,
    --     heading = 0.4318
    -- }
}

-- Menu and spawn véhicle and caméra settings
DakoM.LocationVeh = {
    {
        VehnameLabel = "Blista", -- Name of Button RageUI
        vehnamespawn = "blista", -- Name véhicle spawn
        price = "50", -- price véhicle
        spawnpoint = vector3(297.7532, -1200.914, 29.17627), -- spawn position
        headspawnpoint = 358.25805, -- heading spawn position
        radiuscheck = 0.8, -- radius check spawnpoint
        pedname = "g_m_y_armgoon_02", -- pedname spawn in véhicle
        hashped = 0xC54E878A, -- hashname spawn in véhicle
        drivetocoords = vector3(251.9725, -1187.153, 29.47816), -- drive to coordinates
        cameraheading = 40.0, -- -- caméra settings heading
        Waitaftervehtocoord = 12000 -- wait after spawn véhicle
    },
    {
        VehnameLabel = "Panto", 
        vehnamespawn = "panto", 
        price = "30", 
        spawnpoint = vector3(297.7532, -1200.914, 29.17627), 
        headspawnpoint = 358.25805, 
        radiuscheck = 0.8,
        pedname = "u_f_y_bikerchic",
        hashped = 0xFA389D4F,
        drivetocoords = vector3(251.9725, -1187.153, 29.47816),
        cameraheading = 40.0,
        Waitaftervehtocoord = 12000
    },
}