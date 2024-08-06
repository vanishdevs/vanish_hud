if GetConvarInt('hud:DisplaySpeedometer', 1) == 0 then return end

local mph = 0
local kmh = 0
local fuel = 0
local displayHud = false

local x = 0.01135
local y = 0.002

CreateThread(function()
    while true do
        local playerPed = cache.ped

        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(playerPed)
            local speed = GetEntitySpeed(vehicle)

            mph = tostring(math.ceil(speed * 2.236936))
            kmh = tostring(math.ceil(speed * 3.6))
            fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

            displayHud = true
        else
            displayHud = false

            Wait(500)
        end

        Wait(50)
    end
end)

CreateThread(function()
    while true do
        if displayHud then
            DrawAdvancedText(0.130 - x, 0.77 - y, 0.005, 0.0028, 0.6, mph, 255, 255, 255, 255, 6, 1)
            DrawAdvancedText(0.174 - x, 0.77 - y, 0.005, 0.0028, 0.6, kmh, 255, 255, 255, 255, 6, 1)
            DrawAdvancedText(0.2195 - x, 0.77 - y, 0.005, 0.0028, 0.6, fuel, 255, 255, 255, 255, 6, 1)
            DrawAdvancedText(0.148 - x, 0.7765 - y, 0.005, 0.0028, 0.4, 'mp/h              km/h              Fuel', 255, 255, 255, 255, 6, 1)
        else
            Wait(1000)
        end

        Wait(0)
    end
end)
