local RunService = game:GetService("RunService")

-- HSV to RGB helper
local function hsvToRgb(h, s, v)
    return Color3.fromHSV(h % 1, s, v)
end

local hue = 0

-- This function returns the current theme with RGB overrides baked in
local function getTheme()
    hue = (hue + RunService.RenderStepped:Wait() * 0.2) % 1
    local rgbColor = hsvToRgb(hue, 1, 1)

    return {
        TextColor = Color3.fromRGB(240, 240, 240),

        Background = Color3.fromRGB(25, 25, 25),
        Topbar = Color3.fromRGB(34, 34, 34),
        Shadow = Color3.fromRGB(20, 20, 20),

        NotificationBackground = Color3.fromRGB(20, 20, 20),
        NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

        TabBackground = Color3.fromRGB(80, 80, 80),
        TabStroke = Color3.fromRGB(85, 85, 85),
        TabBackgroundSelected = rgbColor, -- RGB override
        TabTextColor = Color3.fromRGB(240, 240, 240),
        SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

        ElementBackground = Color3.fromRGB(35, 35, 35),
        ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
        SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
        ElementStroke = Color3.fromRGB(50, 50, 50),
        SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
                
        SliderBackground = Color3.fromRGB(50, 138, 220),
        SliderProgress = rgbColor, -- RGB override
        SliderStroke = Color3.fromRGB(58, 163, 255),

        ToggleBackground = Color3.fromRGB(30, 30, 30),
        ToggleEnabled = rgbColor, -- RGB override
        ToggleDisabled = Color3.fromRGB(100, 100, 100),
        ToggleEnabledStroke = rgbColor, -- RGB override
        ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
        ToggleEnabledOuterStroke = rgbColor, -- RGB override
        ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

        DropdownSelected = Color3.fromRGB(40, 40, 40),
        DropdownUnselected = Color3.fromRGB(30, 30, 30),

        InputBackground = Color3.fromRGB(30, 30, 30),
        InputStroke = Color3.fromRGB(65, 65, 65),
        PlaceholderColor = Color3.fromRGB(178, 178, 178)
    }
end

-- Example usage loop to update your UI every frame:
spawn(function()
    while true do
        local theme = getTheme()
        -- Rayfield:UpdateTheme(theme) -- wherever you update your UI theme
    end
end)
return theme
