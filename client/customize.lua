-- This variable is essential for street labeling. Customize it according to your preferences. It's intentionally left unformatted in convars.
CompassOptions = {
    ticksBetweenCardinals = 9.0,  -- Distance between cardinal direction ticks
    tickColour = {r = 255, g = 255, b = 255, a = 255},  -- Color of ticks
    tickSize = {w = 0.0006, h = 0.003},  -- Size of ticks
    cardinal = {
        textSize = 0.40,  -- Text size for cardinal directions
        textOffset = -0.014,  -- Text offset for cardinal directions
        textColour = {255, 255, 255, 255},  -- Text color for cardinal directions
        tickSize = {w = 0.013, h = 0.022},  -- Size of ticks for cardinal directions
        tickColour = {r = 0, g = 0, b = 0, a = 140},  -- Color of ticks for cardinal directions
    },
    intercardinal = {
        textSize = 0.26,  -- Text size for intercardinal directions
        textOffset = -0.013,  -- Text offset for intercardinal directions
        textColour = {255, 255, 255, 255},  -- Text color for intercardinal directions
        tickSize = {w = 0.0005, h = 0.005},  -- Size of ticks for intercardinal directions
        tickColour = {r = 255, g = 255, b = 255, a = 255},  -- Color of ticks for intercardinal directions
    }
}

-- @param msg (string) The necessary message that will be displayed in the notification
function ShowNotification(msg)
    local getNotificationType = GetConvar('hud:NotificationSystem', 'ox_lib')
    local getNotificationTitle = GetConvar('hud:NotificationTitle', 'Seatbelt')
    local getNotificationPosition = GetConvar('hud:NotificationPosition', 'top')
    if getNotificationType == 'ox_lib' then
        if GetResourceState('ox_lib') ~= 'started' then return print('[WARNING]: OX_LIB is missing, the notification feature will not work.') end
        return lib.notify({title = getNotificationTitle, description = msg, position = getNotificationPosition})
    else
        -- Add your own logic for notify here
    end
end

-- @return GetHunger The current hunger status (percentage).
-- @return GetThirst The current thirst status (percentage).
function GetNeedsStatus()
    local getResource = GetConvar('hud:RequiredResource', 'esx_status')
	local GetHunger, GetThirst
	if getResource == 'esx_status' then
        if GetResourceState('esx_status') ~= 'started' then return print('[WARNING]: ESX Status is missing, hunger and thirst features will not work.') end
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            GetHunger = hunger.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
            GetThirst = thirst.getPercent()
        end)

		return GetHunger, GetThirst
	else
		-- Add your own logic for this here, make sure to return the values
	end
end

-- @param text (string) The text to be drawn.
-- @param font (number, optional) The font ID. Defaults to 4 if not specified.
-- @param colour (table, optional) The color of the text as RGBA values in a table {r, g, b, a}. If not specified, defaults to white (255, 255, 255, 255).
-- @param scale (number, optional) The scale of the text. Defaults to 1.0 if not specified.
-- @param x (number) The X coordinate of the text position.
-- @param y (number) The Y coordinate of the text position.
-- @param outline (boolean, optional) Whether to draw text with an outline. Defaults to false if not specified.
-- @param centered (boolean, optional) Whether the text should be centered. Defaults to false if not specified.
-- Edit this function if you want to customize the look of the streetlabel
function DrawText2D(text, font, colour, scale, x, y, outline, centered)
    font = font or 4
    scale = scale or 1.0

	SetTextFont(font)
	SetTextScale(0.0, scale)
	SetTextProportional(true)

    if colour then
        local r, g, b, a = table.unpack(colour)
        a = a or 255
        --print(r, g, b, a)
        SetTextColour(r, g, b, a)
    else
        SetTextColour(255, 255, 255, 255)
    end

    SetTextDropShadow()

	if centered then SetTextCentre(true) end
    if outline then SetTextOutline() end

	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x + -0.002, y + -0.029)
end

-- @param x The X-coordinate of the text.
-- @param y The Y-coordinate of the text.
-- @param w The width of the text.
-- @param h The height of the text.
-- @param sc The scale of the text.
-- @param text The text to be displayed.
-- @param r The red color component (0-255).
-- @param g The green color component (0-255).
-- @param b The blue color component (0-255).
-- @param a The alpha (transparency) value (0-255).
-- @param font The font to be used for the text.
-- @param jus The justification of the text (0-2).
-- Edit this function if you would like to customize the look of the speedometer
function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(false)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow()
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1 + w, y - 0.02 + h)
end