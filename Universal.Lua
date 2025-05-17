--Latest version i have on hand











--// Wompington Universal Hub v1.5
   --|cat facts update: shows a cat fact in credits.
--// in the wise words of TheRussianBadger:
--// "Built Different, Built STUPID."
--// fair warning to any future security analysts, this is cursed as FUCK.


-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- States
local aimbotEnabled = false
local esp = false
local SpinEnabled = false
local SpinSpeed = 10
local CurrentJumpPower = 16
local aimForHead = false
local CurrentSpeed = 16
local MAX_DISTANCE = 245
local MIN_DISTANCE = 0
local triggerbotEnabled = false
local aimbotMode = "Distance"
--local spamming = false
--local customMessage = ""
--^broken atm^
local Tracers = false

--preamble definitions (folders and shit yk)
local tracerFolder = Instance.new("Folder", game.CoreGui)
tracerFolder.Name = "Wompington_ESP_Tracers"



--// Debug Mode (dunno what this is, RF docs said to enable it.)
debugX = true

--// UI Loader
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "Wompington Universal",
   Icon = 0,
   LoadingTitle = "Wompington Industries Moment",
   LoadingSubtitle = "powered by rayfield and spite",
   Theme = "DarkBlue",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Wompington_Industries_Universal_v1"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Key",
      Subtitle = "I dont js hand out my exploits gng :sob::pray:",
      Note = "(DM me on dc: stardestroyer89)",
      FileName = "Wompington_HubV1",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"IAmWompingIt", "RexIsTheGoat"}
   }
})

--// Tabs
local CreditsTab = Window:CreateTab("Credits", "scroll-text")
local AimbotTab = Window:CreateTab("Aiming", "locate")
local VisTab = Window:CreateTab("Visuals", "scan-eye")
local MoveTab = Window:CreateTab("Player", "chevrons-up")
local FunTab = Window:CreateTab("Fun/Misc", "dices")


--//credits
local Names = CreditsTab:CreateLabel("Made By MrWompington (@stardestroyer89 on discord, tarnished_remnant on roblox)", "user-round", Color3.fromRGB(255, 75, 255), false) -- Title, Icon, Color, IgnoreTheme
local vers = CreditsTab:CreateLabel("You Are Using Wompington Universal V1", "info", Color3.fromRGB(175, 175, 175), false) -- Title, Icon, Color, IgnoreTheme

local FetchCF = game:HttpGet('https://raw.githubusercontent.com/Justanotherscripter1/Wompington-Scripts-V1-/refs/heads/main/catfact.lua')
local catFactModule = loadstring(FetchCF)()
local fact = catFactModule:GetFact()

local CFact = CreditsTab:CreateLabel("Cat Fact: " .. tostring(fact))


--// Aimbot Section
AimbotTab:CreateSection("Legit")

local Aimbot = AimbotTab:CreateToggle({
   Name = "Aimbot (toggle with LeftAlt)",
   CurrentValue = aimbotEnabled,
   Flag = "AimbotLegit",
   Callback = function(Value)
       aimbotEnabled = Value
       print("[Wompington Industries] Aimbot is now " .. (aimbotEnabled and "ON" or "OFF"))
   end,
})

local AimFor = AimbotTab:CreateDropdown({
   Name = "Aim For: ",
   Options = {"Torso", "Head"},
   CurrentOption = {"Torso"},  -- The default option
   MultipleOptions = false,
   Flag = "AimBotSelection",  -- Make sure this flag is unique for saving configurations
   Callback = function(Options)
      if table.find(Options, "Head") then
         aimForHead = true  -- Set to true if "Head" is selected
      else
         aimForHead = false  -- Set to false if "Torso" is selected
      end
      print("[Wompington Industries] Aiming for: " .. (aimForHead and "HEADS 🎯" or "TORSOS 💥"))
local status = (aimforhead == true) and "heads" or "torsos"

Rayfield:Notify({
   Title = "Aiming for " .. status,
   Content = "Aiming at " .. status,
   Duration = 2.5,
   Image = "crosshair",
})

   end
})

local AimForFF = AimbotTab:CreateToggle({
   Name = "Aimbot ForceFields",
   CurrentValue = aimbotEnabled,
   Flag = "AimbotLegitFF",
   Callback = function(Value)
       FFEnabled = Value
   end,
})

local Range = AimbotTab:CreateSlider({
   Name = "Max Dist",
   Range = {25, 500},
   Increment = 5,
   Suffix = "Studs",
   CurrentValue = 245,
   Flag = "AimbotRange", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   MAX_DISTANCE = Value
   end,
})

local Range2 = AimbotTab:CreateSlider({
   Name = "Min Dist",
   Range = {0, 500},
   Increment = 5,
   Suffix = "Studs",
   CurrentValue = 0,
   Flag = "AimbotRange2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   MIN_DISTANCE = Value
   end,
})

local aimbotModeDropdown = AimbotTab:CreateDropdown({
   Name = "Aimbot Mode",
   Options = {"Distance", "Angle", "Health"},
   CurrentOption = "Distance",
   Flag = "AimbotMode",
   Callback = function(Option)
      aimbotMode = Option
   end,
})

local AimbotBind = AimbotTab:CreateKeybind({
    Name = "Toggle Aimbot",
    CurrentKeybind = "LeftAlt",
    HoldToInteract = false,
    Flag = "AimbotKeybind",
    Callback = function()
       aimbotEnabled = not aimbotEnabled
    Rayfield.Flags["AimbotLegit"]:Set(aimbotEnabled)
    print("[Wompington Industries] Aimbot toggled manually!")
local status = (aimbotEnabled == true) and "enabled" or "disabled"

Rayfield:Notify({
   Title = "Aimbot " .. status,
   Content = "Aimbot toggled to: " .. tostring(aimbotEnabled),
   Duration = 2.5,
   Image = "crosshair",
})



    end,
})
AimbotTab:CreateSection("Triggerbot")

local Triggerbot = AimbotTab:CreateToggle({
    Name = "Triggerbot (Auto Fire When Aiming)",
    CurrentValue = triggerbotEnabled,
    Flag = "TriggerbotEnabled",
    Callback = function(Value)
        triggerbotEnabled = Value
        print("[Wompington Industries] Triggerbot is now " .. (triggerbotEnabled and "LOCKED ON 🚨" or "DISARMED 💤"))
    end,
})
--// Visuals Section

local vis = VisTab:CreateToggle({
   Name = "ESP",
   CurrentValue = esp,
   Flag = "ESP",
   Callback = function(Value)
       esp = Value
       print("[Wompington Industries] ESP is now " .. (esp and "ON" or "OFF"))
   end,
})

local FulbrightToggle = VisTab:CreateToggle({
    Name = "Fulbright (Toggle)",
    CurrentValue = false,
    Flag = "Fulbright",  -- Flag to save the setting
    Callback = function(Value)
        if Value then 
        print("[Wompington Industries] Fulbright enabled!")
           while Value do
            game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)  -- Full white light everywhere
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(255, 255, 255)  -- Outdoor lighting set to white
            game:GetService("Lighting").Brightness = 2  -- Increase the brightness a little bit
            game:GetService("Lighting").GlobalShadows = false  -- Disable shadows
            wait()
            end
           
        else
            game:GetService("Lighting").Ambient = Color3.fromRGB(127, 127, 127)  -- Normal ambient
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(127, 127, 127)  -- Normal outdoor ambient
            game:GetService("Lighting").Brightness = 1  -- Default brightness
            game:GetService("Lighting").GlobalShadows = true  -- Re-enable shadows
            print("[Wompington Industries] Fulbright disabled!")
        end
    end
})

VisTab:CreateToggle({
    Name = "Mouse Tracers",
    CurrentValue = false,
    Flag = "MouseTracers",
    Callback = function(Value)
        tracersEnabled = Value
    end,
})

VisTab:CreateToggle({
    Name = "Head Circles",
    CurrentValue = false,
    Flag = "HeadCircles",
    Callback = function(Value)
        headCircleEnabled = Value
    end,
})


--// Player Section
local Speed = MoveTab:CreateSlider({
   Name = "Speed",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Speed",
   Callback = function(Value)
      local character = LocalPlayer.Character
      if character and character:FindFirstChild("Humanoid") then
      while true do
         character.Humanoid.WalkSpeed = Value
         wait(0.001)
         end
      end
   end,
})

local jump = MoveTab:CreateSlider({
   Name = "Jump Power",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Jump",
   CurrentValue = 16,
   Flag = "Jump",
   Callback = function(Value)
      CurrentJumpPower = Value
   end,
})

local GodmodeToggle = MoveTab:CreateToggle({
    Name = "Godmode (Toggle)",
    CurrentValue = false,
    Flag = "Godmode",  -- Flag to save the setting
    Callback = function(Value)
        -- Get the LocalPlayer and the Character
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        -- Check if Godmode is enabled or disabled
        if Value then
            -- Set Godmode: Set the humanoid health to a high value and prevent damage
            humanoid.MaxHealth = 1000  -- Set max health to a very high value (or any value you prefer)
            humanoid.Health = 1000  -- Set current health to match max health
            humanoid.HealthChanged:Connect(function()
                humanoid.Health = humanoid.MaxHealth  -- Keep health at max to prevent damage
            end)
            humanoid:SetAttribute("CanTakeDamage", false)  -- Prevent the humanoid from taking damage
            print("[Wompington Industries] Godmode enabled!")

            -- Continuously ensure Godmode stays active
            spawn(function()
                while GodmodeToggle:GetValue() do
                    humanoid.Health = humanoid.MaxHealth  -- Ensure health is always at max
                    humanoid:SetAttribute("CanTakeDamage", false)  -- Ensure no damage can be taken
                    wait(0.5)  -- Update frequency (adjust as needed)
                end
            end)
        else
            -- Reset Godmode: Restore normal health behavior
            humanoid.MaxHealth = 100  -- Reset max health to default value
            humanoid.Health = humanoid.MaxHealth  -- Reset health to max value
            humanoid:SetAttribute("CanTakeDamage", true)  -- Allow the humanoid to take damage
            print("[Wompington Industries] Godmode disabled!")
        end
    end
})
--[[
useless
local Rename = MoveTab:CreateInput({
   Name = "Name",
   CurrentValue = tostring(game:GetService("Players").LocalPlayer.Name),
   PlaceholderText = tostring(game:GetService("Players").LocalPlayer.Name),
   RemoveTextAfterFocusLost = false,
   Flag = "Name",
   Callback = function(Text)
   local function changePlayerName(newName)
    local player = game:GetService("Players").LocalPlayer
    if player then
        player.Name = newName
        -- Change the display name as well (if required)
        player.DisplayName = newName
        print("[Wompington Industries] Player name changed to: " .. newName)
    end
end
   end,
})

]]

--// Fun Section
local SpinToggle = FunTab:CreateToggle({
    Name = "Spinbot",
    CurrentValue = false,
    Flag = "Spinbot",
    Callback = function(Value)
        SpinEnabled = Value
    end,
})

local SpinSpeedSlider = FunTab:CreateSlider({
    Name = "Spin Speed",
    Range = {5, 90},
    Increment = 5,
    Suffix = "°/frame",
    CurrentValue = 10,
    Flag = "SpinSpeed",
    Callback = function(Value)
        SpinSpeed = Value
    end,
})
--// had to do this cause of a tabbing bug, wouldnt render
local function startChatSpam()
    local spamming = true -- Declare locally inside the function to avoid global variables.
    task.spawn(function()
        while spamming do
            local message = Rayfield.Flags["ChatSpamTXT"].Value
            if message ~= "" then
                -- Ensures that the message exists before trying to send it.
                print(message)
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")

            end
            wait(0.75)
        end
    end)
end


-- Function to stop chat spam
local function stopChatSpam()
    spamming = false
end

local CSpamTgl = FunTab:CreateToggle({
   Name = "Chat Spam - BROKEN!!!!!",
   CurrentValue = false,
   Flag = "CSpam", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   spamming = Value
   end,
})

local CSpamTXT = FunTab:CreateInput({
    Name = "CSpamTXT",
    CurrentValue = "MrWompington Is better than all of u",
    PlaceholderText = "Spam Text",
    RemoveTextAfterFocusLost = false,
    Flag = "CSpamTXT",
    Callback = function(Text)
        Rayfield.Flags["CSpamTXT"].Value = Text
        print("[Wompington Universal] Custom Spam Message: " .. Text)
    end,
})

--// Actual Hax -- Aimbot

local function getTargetPart(character)
    if aimForHead then
        return character:FindFirstChild("Head")
    else
        return character:FindFirstChild("HumanoidRootPart") or
               character:FindFirstChild("UpperTorso") or
               character:FindFirstChild("LowerTorso")
    end
end

local function isEnemy(player)
    if not LocalPlayer.Team or not player.Team then
        return true
    end
    return player.Team ~= LocalPlayer.Team
end

local function getClosestEnemy()
    local closestPlayer, bestMetric = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and isEnemy(player) then
            local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid and humanoid.Health > 1 then
                local part = getTargetPart(player.Character)
                if part then
                    local distance = (Camera.CFrame.Position - part.Position).Magnitude
                    if distance >= MIN_DISTANCE and distance <= MAX_DISTANCE then
                        local metric
                        if aimbotMode == "Distance" then
                            metric = distance
                        elseif aimbotMode == "Angle" then
                            local dirToTarget = (part.Position - Camera.CFrame.Position).Unit
                            metric = math.acos(Camera.CFrame.LookVector:Dot(dirToTarget))

                        elseif aimbotMode == "Health" then
                            metric = humanoid.Health
                        else
                            metric = distance -- fallback
                        end

                        if metric < bestMetric then
                            bestMetric = metric
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function aimAt(player)
    if player and player.Character then
        local part = getTargetPart(player.Character)
        if part then
            if AimForFF then
                if player.Character:FindFirstChild("ForceField") then
                    return
                end
            end
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, part.Position)
        end
    end
end


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        aimForHead = not aimForHead
        print("[Wompington Industries] Now aiming for " .. (aimForHead and "HEADS 🎯" or "TORSOS 💥"))
    end
end)

--// Loops
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestEnemy = getClosestEnemy()
        if closestEnemy then
            aimAt(closestEnemy)
        end
    end

    if SpinEnabled then
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SpinSpeed), 0)
        end
    end

    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and humanoid.JumpPower ~= CurrentJumpPower then
            humanoid.JumpPower = CurrentJumpPower
        end
    end
end)

local function createESP(player)
    if player == LocalPlayer then return end

    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.fromRGB(255, 255, 255)
    box.Thickness = 2
    box.Filled = false

    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Color = Color3.fromRGB(255, 255, 255)
    nameText.Size = 16
    nameText.Center = false
    nameText.Outline = true

    local teamtext = Drawing.new("Text")
    teamtext.Visible = false
    teamtext.Size = 14
    teamtext.Center = false
    teamtext.Outline = true

    local distanceText = Drawing.new("Text")
    distanceText.Visible = false
    distanceText.Color = Color3.fromRGB(200, 200, 200)
    distanceText.Size = 14
    distanceText.Center = true
    distanceText.Outline = true

    local healthBar = Drawing.new("Line")
    healthBar.Visible = false
    healthBar.Thickness = 2

    RunService.RenderStepped:Connect(function()
        if esp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid") then
            local hrp = player.Character.HumanoidRootPart
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local pos, visible = Camera:WorldToViewportPoint(hrp.Position)

            if visible then
                local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
                local scale = math.clamp(500 / distance, 0.1, 1)

                box.Size = Vector2.new(75 * scale, 100 * scale)
                box.Position = Vector2.new(pos.X - box.Size.X/2, pos.Y - box.Size.Y/2)
                box.Visible = true

                nameText.Text = player.Name
                nameText.Position = Vector2.new(pos.X - nameText.TextBounds.X/2, pos.Y - box.Size.Y/2 - 25)
                nameText.Visible = true

                local teamColor = player.Team and player.Team.TeamColor.Color or Color3.fromRGB(255, 255, 255)
                teamtext.Color = teamColor
                teamtext.Text = player.Team and player.Team.Name or "No Team"
                teamtext.Position = Vector2.new(pos.X - teamtext.TextBounds.X/2, pos.Y - box.Size.Y/2 - 40)
                teamtext.Visible = true

                distanceText.Text = string.format("%.0f studs", distance)
                distanceText.Position = Vector2.new(pos.X - distanceText.TextBounds.X/2, pos.Y + box.Size.Y/2 + 2)
                distanceText.Visible = true

                local healthRatio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                local barHeight = box.Size.Y * healthRatio
                local barX = box.Position.X - 8
                local barY = box.Position.Y

                healthBar.From = Vector2.new(barX, barY + box.Size.Y)
                healthBar.To = Vector2.new(barX, barY + box.Size.Y - barHeight)
                healthBar.Color = Color3.fromRGB(255 * (1 - healthRatio), 255 * healthRatio, 0)
                healthBar.Visible = true
            else
                box.Visible = false
                nameText.Visible = false
                teamtext.Visible = false
                distanceText.Visible = false
                healthBar.Visible = false
            end
        else
            box.Visible = false
            nameText.Visible = false
            teamtext.Visible = false
            distanceText.Visible = false
            healthBar.Visible = false
        end
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end

Players.PlayerAdded:Connect(function(player)
    createESP(player)
end)


-- Speed fix (make sure it updates every frame)
RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Update WalkSpeed
            humanoid.WalkSpeed = CurrentSpeed
        end
    end
end)

-- Jump Power fix (make sure it updates every frame)
RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Update JumpPower
            humanoid.JumpPower = CurrentJumpPower
        end
    end
end)

-- Speed slider callback
Speed.Callback = function(Value)
    CurrentSpeed = Value
    print("[Wompington Industries] Speed set to " .. Value)
end

-- Jump Power slider callback
jump.Callback = function(Value)
    CurrentJumpPower = Value
    print("[Wompington Industries] Jump Power set to " .. Value)
end


--// triggrbot 
RunService.RenderStepped:Connect(function()
    if triggerbotEnabled then
        local camera = workspace.CurrentCamera
        local ray = Ray.new(camera.CFrame.Position, camera.CFrame.LookVector * 1000)
        local part, position = workspace:FindPartOnRay(ray, LocalPlayer.Character, false, true)

        if part and part.Parent:FindFirstChild("Humanoid") and part.Parent:FindFirstChild("Humanoid").Health > 0 then
            local targetPlayer = Players:GetPlayerFromCharacter(part.Parent)
            if targetPlayer and targetPlayer.Team ~= LocalPlayer.Team then
                -- Simulate left click (if tool equipped with Activate method)
                local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("Activate") then
                    tool:Activate()
                elseif UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
                    -- Or simulate Mouse1 down (for click detectors etc.)
                    mouse1press()
                    task.wait(0.05)
                    mouse1release()
                end
            end
        end
    end
end)

local circleObjects = {}

RunService.RenderStepped:Connect(function()
    for _, v in pairs(circleObjects) do
        v:Remove()
    end
    table.clear(circleObjects)

    if not esp or not headCircleEnabled then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                local circle = Drawing.new("Circle")
                circle.Position = Vector2.new(headPos.X, headPos.Y)
                circle.Radius = 15
                circle.Color = Color3.fromRGB(255, 255, 255)
                circle.Thickness = 2
                circle.Transparency = 1
                circle.Visible = true

                table.insert(circleObjects, circle)
            end
        end
    end
end)


local circleObjects = {}

RunService.RenderStepped:Connect(function()
    for _, v in pairs(circleObjects) do
        v:Remove()
    end
    table.clear(circleObjects)

    if not esp or not headCircleEnabled then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                local circle = Drawing.new("Circle")
                circle.Position = Vector2.new(headPos.X, headPos.Y)
                circle.Radius = 15
                circle.Color = Color3.fromRGB(255, 255, 255)
                circle.Thickness = 2
                circle.Transparency = 1
                circle.Visible = true

                table.insert(circleObjects, circle)
            end
        end
    end
end)

local function createTracer(player)
    local tracer = Drawing.new("Line")
    tracer.Thickness = 1.5
    tracer.Color = Color3.new(1, 0, 0)
    tracer.Transparency = 1

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            tracer.Visible = false
            return
        end

        local pos, onScreen = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
        if onScreen then
            tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
            tracer.To = Vector2.new(pos.X, pos.Y)
            tracer.Visible = true
        else
            tracer.Visible = false
        end
    end)

    return {tracer = tracer, disconnect = function() conn:Disconnect(); tracer:Remove() end}
end

--active
local activeTracers = {}
if not esp or not Tracers then return end
for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        table.insert(activeTracers, createTracer(player))
    end
end

-- AUTO-CLEANUP
game.Players.PlayerRemoving:Connect(function(leaver)
    for i, tracer in pairs(activeTracers) do
        if tracer.player == leaver then
            tracer.disconnect()
            table.remove(activeTracers, i)
        end
    end
end)

-- CLEANUP ON LEAVE/RESET
game:BindToClose(function()
    for _, t in pairs(activeTracers) do
        t.disconnect()
    end
end)

-- Optional manual cleanup button:
function removeAllTracers()
    for _, t in pairs(activeTracers) do
        t.disconnect()
    end
    activeTracers = {}
end


--// Load last config
Rayfield:LoadConfiguration()

print("[Wompington Industries] Universal Loader fully operational ✅")
