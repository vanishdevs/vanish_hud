if GetConvarInt('hud:EnableStreetLabels', 1) == 0 then return end

local ResData = lib.load('data.resolution')
local ZoneData = lib.load('data.zones')

local positionx, positiony = -0.002, -0.029
local w, h = GetActiveScreenResolution()
local locationText = ""
local pedInVeh = false

-- @param w (number) The width.
-- @param h (number) The height.
-- @return screenPosX (number) The X coordinate of the screen position.
-- @return screenPosY (number) The Y coordinate of the screen position.
local function GetScreenPos(width, height)
    local getRes = ResData.ResolutionPosition[width] and ResData.ResolutionPosition[width][height]
    if getRes then
        return getRes.screenPosX, getRes.screenPosY
    else
        return 0.165, 0.882
    end
end

-- @param degree (number) The degree value to be converted.
-- @return label (string) The label representing the cardinal or intercardinal direction.
local function ConvertDegreesToInterDirection(degree)
	local directions = {
		{label = "N ", range = {0, 22.5}},
		{label = "NE", range = {22.5, 67.5}},
		{label = "E",  range = {67.5, 112.5}},
		{label = "SE", range = {112.5, 157.5}},
		{label = "S",  range = {157.5, 202.5}},
		{label = "SW", range = {202.5, 247.5}},
		{label = "W",  range = {247.5, 292.5}},
		{label = "NW", range = {292.5, 337.5}},
	}
	
	degree = degree % 360.0
	
	for _, direction in ipairs(directions) do
		if degree >= direction.range[1] and degree < direction.range[2] then
			return direction.label
		end
	end
end

CreateThread(function()
    local screenPosX, screenPosY = GetScreenPos(w, h)
    local streetLabelTextColour = GetConvar('hud:StreetLabelTextColor') or {255, 255, 255}
    while true do
        local playerPed = cache.ped
        pedInVeh = IsPedInAnyVehicle(playerPed, false)
        
        local pxDegree = 0.06 / 180
        local playerHeadingDegrees = 360.0 - GetEntityHeading(playerPed)
        local tickDegree = playerHeadingDegrees - 180 / 2
        local tickDegreeRemainder = CompassOptions.ticksBetweenCardinals - (tickDegree % CompassOptions.ticksBetweenCardinals)
        local tickPosition = screenPosX + 0.005 + tickDegreeRemainder * pxDegree
        tickDegree = tickDegree + tickDegreeRemainder

        while tickPosition < screenPosX + 0.0225 do
            local isCardinal = tickDegree % 90.0 == 0
            local isIntercardinal = tickDegree % 45.0 == 0
            local isSpecial = (tickDegree % 90.0) == 63.0 or (tickDegree % 90.0) == 54.0 or (tickDegree % 90.0) == 27.0 or (tickDegree % 90.0) == 36.0

            if isCardinal then
                DrawRect(tickPosition + positionx, screenPosY + 0.128 + positiony, CompassOptions.cardinal.tickSize.w, CompassOptions.cardinal.tickSize.h, CompassOptions.cardinal.tickColour.r, CompassOptions.cardinal.tickColour.g, CompassOptions.cardinal.tickColour.b, CompassOptions.cardinal.tickColour.a)
                DrawText2D(ConvertDegreesToInterDirection(tickDegree), 4, CompassOptions.cardinal.textColour, 0.4, tickPosition, screenPosY + 0.128 + CompassOptions.cardinal.textOffset, true, true)
            elseif isIntercardinal then
                DrawRect(tickPosition + positionx, screenPosY + 0.128 + positiony, CompassOptions.intercardinal.tickSize.w, CompassOptions.intercardinal.tickSize.h, CompassOptions.intercardinal.tickColour.r, CompassOptions.intercardinal.tickColour.g, CompassOptions.intercardinal.tickColour.b, CompassOptions.intercardinal.tickColour.a)
                DrawText2D(ConvertDegreesToInterDirection(tickDegree), 4, CompassOptions.cardinal.textColour, 0.26, tickPosition, screenPosY + 0.128 + CompassOptions.intercardinal.textOffset, true, true)
            elseif isSpecial then
                DrawRect(tickPosition + positionx, screenPosY + 0.139 + positiony, CompassOptions.tickSize.w, CompassOptions.tickSize.h, CompassOptions.tickColour.r, CompassOptions.tickColour.g, CompassOptions.tickColour.b, CompassOptions.tickColour.a)
            end

            tickDegree = tickDegree + CompassOptions.ticksBetweenCardinals
            tickPosition = tickPosition + pxDegree * CompassOptions.ticksBetweenCardinals
        end
        if pedInVeh then
            DrawText2D(locationText, 4, streetLabelTextColour, 0.50, screenPosX + 0.037, screenPosY + 0.1100, true)
        end
        Wait(0)
    end
end)

CreateThread(function()
    while true do
        local sleepThread = 5000
        local playerPed = cache.ped

        if pedInVeh then
            sleepThread = 1000
            local position = GetEntityCoords(playerPed)
            local zoneName = ZoneData.Zones[GetNameOfZone(position.x, position.y, position.z)]
            local zoneNameFull = (zoneName and "[" .. zoneName .. "]") or "[Unknown]"

            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            locationText = streetName or locationText
            locationText = (zoneNameFull and locationText) and (locationText .. " | " .. zoneNameFull) or locationText
        end
        Wait(sleepThread)
    end
end)
