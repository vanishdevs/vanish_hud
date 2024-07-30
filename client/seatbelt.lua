if GetConvarInt('hud:EnableSeatbelt', 1) == 0 then return end

local isBuckled = false
SetFlyThroughWindscreenParams(15.0, 20.0, 17.0, 2000.0)

local function Buckled()
	CreateThread(function()
		while isBuckled do
			lib.disableControls()
			Wait(0)
		end
	end)
end

local function Seatbelt(status)
	local playSound = GetConvarInt('hud:PlaySound', 1) == 1
	local disableControls = GetConvarInt('hud:PreventExitWhileBuckled', 1) == 1
	if status then
		if playSound then SendNUIMessage({action = 'buckle'}) end
		SetFlyThroughWindscreenParams(1000.0, 1000.0, 0.0, 0.0)
		if disableControls then lib.disableControls:Add(75) Buckled() end
		ShowNotification("You have buckled your seatbelt")
	else
		if playSound then SendNUIMessage({action = 'unbuckle'}) end
		SetFlyThroughWindscreenParams(15.0, 20.0, 17.0, 2000.0)
		if disableControls then lib.disableControls:Remove(75) end
		ShowNotification("You have unbuckled your seatbelt")
	end
	isBuckled = status
end

local inVehicle
CreateThread(function()
	while true do
        local isPedUsingAnyVehicle = cache.vehicle and true or false
        if isPedUsingAnyVehicle ~= inVehicle then
            if not isPedUsingAnyVehicle and isBuckled then isBuckled = false end
            inVehicle = isPedUsingAnyVehicle
        end
		Wait(1000)
	end
end)

lib.addKeybind({
	name = 'seatbelt',
	description = 'Toggle Seatbelt',
	defaultKey = GetConvar('hud:seatbeltKey', 'B'),
	onPressed = function()
		if cache.vehicle then
			local vehClass = GetVehicleClass(cache.vehicle)

			if vehClass ~= 8 and vehClass ~= 13 and vehClass ~= 14 then
				Seatbelt(not isBuckled)
			end
		end
	end,
})

exports("seatbeltStatus", function() return isBuckled end)