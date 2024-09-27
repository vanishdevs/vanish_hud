local showRadarOnFoot = GetConvarInt('hud:DisplayRadarOnFoot', 1) == 1
hudVisible <global> = true

if not showRadarOnFoot then
    CreateThread(function()
        while true do
            local playerPed = cache.ped
            local playerVehicle = cache.vehicle and true or false
            local playerRadarHidden = IsRadarHidden() and true or false
            
            if playerVehicle == playerRadarHidden then
                DisplayRadar(playerVehicle)
            end

            Wait(1000)
        end
    end)
end

CreateThread(function()
    while true do
		local myHunger, myThirst, health, armor, oxygen, stress

        myHunger, myThirst = GetNeedsStatus()

        local playerPed = cache.ped
        local playerId = cache.playerId
        health = GetEntityHealth(playerPed) - 100
        armor = GetPedArmour(playerPed)
        oxygen = math.floor(GetPlayerSprintTimeRemaining(playerId) * 10)
        stress = NetworkIsPlayerTalking(playerId) and 100 or 0

        SendNUIMessage({
            action = "updateStatusHud",
            show = hudVisible,
            hunger = myHunger,
            thirst = myThirst,
            health = health,
            armour = armor,
            oxygen = oxygen,
            stress = stress
        })

        Wait(1000)
    end
end)

exports('toggleHud', function(state) hudVisible = state end)