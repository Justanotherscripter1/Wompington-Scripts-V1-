local RunService = game:GetService("RunService")

-- Your base theme, copy-pasted with highlights to be overridden by RGB cycle
local baseTheme = {
    TextColor = Color3.fromRGB(240, 240, 240),

    Background = Color3.fromRGB(25, 25, 25),
    Topbar = Color3.fromRGB(34, 34, 34),
    Shadow = Color3.fromRGB(20, 20, 20),

    NotificationBackground = Color3.fromRGB(20, 20, 20),
    NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

    TabBackground = Color3.fromRGB(80, 80, 80),
    TabStroke = Color3.fromRGB(85, 85, 85),
    TabBackgroundSelected = Color3.fromRGB(210, 210, 210), -- will override with RGB
    TabTextColor = Color3.fromRGB(240, 240, 240),
    SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

    ElementBackground = Color3.fromRGB(35, 35, 35),
    ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
    SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
    ElementStroke = Color3.fromRGB(50, 50, 50),
    SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
            
    SliderBackground = Color3.fromRGB(50, 138, 220),
    SliderProgress = Color3.fromRGB(50, 138, 220), -- RGB cycle override
    SliderStroke = Color3.fromRGB(58, 163, 255),

    ToggleBackground = Color3.fromRGB(30, 30, 30),
    ToggleEnabled = Color3.fromRGB(0, 146, 214), -- RGB cycle override
    ToggleDisabled = Color3.fromRGB(100, 100, 100),
    ToggleEnabledStroke = Color3.fromRGB(0, 170, 255), -- RGB cycle override
    ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
    ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100), -- RGB cycle override
    ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

    DropdownSelected = Color3.fromRGB(40, 40, 40),
    DropdownUnselected = Color3.fromRGB(30, 30, 30),

    InputBackground = Color3.fromRGB(30, 30, 30),
    InputStroke = Color3.fromRGB(65, 65, 65),
    PlaceholderColor = Color3.fromRGB(178, 178, 178)
}

-- HSV to RGB helper, because Color3.fromHSV is life
local function hsvToRgb(h, s, v)
    return Color3.fromHSV(h % 1, s, v)
end

-- Main RGB cycle hue tracker
local hue = 0

RunService.RenderStepped:Connect(function(dt)
    hue = (hue + dt * 0.2) % 1 -- speed of RGB cycle, tweak 0.2 for faster/slower

    local rgbColor = hsvToRgb(hue, 1, 1) -- full saturation & brightness

    -- Override the highlight colors with rgbColor every frame
    baseTheme.SliderProgress = rgbColor
    baseTheme.ToggleEnabled = rgbColor
    baseTheme.ToggleEnabledStroke = rgbColor
    baseTheme.ToggleEnabledOuterStroke = rgbColor
    baseTheme.TabBackgroundSelected = rgbColor

    -- If you have access to Rayfield's API to update theme dynamically:
    -- Rayfield:UpdateTheme(baseTheme) or however it updates in your setup

    -- If you can't update the theme live, consider rebuilding the UI or
    -- just using this in your initial setup loop with delay timers for effects
end)
