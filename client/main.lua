local togglehud = true
local showRadar = GetConvarInt('hud:DisplayRadarOnFoot', 1) == 1

if not showRadar then
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

        local player = cache.ped
        health = GetEntityHealth(player) - 100
        armor = GetPedArmour(player)
        oxygen = math.floor(GetPlayerSprintTimeRemaining(PlayerId()) * 10)
        stress = NetworkIsPlayerTalking(PlayerId()) and 100 or 0

        SendNUIMessage({
            action = "updateStatusHud",
            show = togglehud,
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

exports('togglehud', function(state) togglehud = state end)