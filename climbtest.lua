-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local keyLink = "https://link-target.net/1343847/1Ovaz8Yyhqpj"
setclipboard(keyLink)

-- UI Setup
local Window = Rayfield:CreateWindow({
    Name = "Climb and Jump HUB",
    LoadingTitle = "Loading Auto Farm System",
    LoadingSubtitle = "by BabyBloxZ",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "ClimbJumpConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "BabyBloxZ HUB Key System",
        Subtitle = "Key Required",
        Note = "Key has been copied to clipboard",
        FileName = "BabyBloxZKey",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/SvHPBQvm"}
    }
})

Rayfield:Notify({
    Title = "Key Copied",
    Content = "Key has been copied to clipboard: "..keyLink,
    Duration = 8,
    Image = 0
})

-- Notify
Rayfield:Notify({
    Title = "Script Loaded",
    Content = "Auto Farm and Gamepass Hack Activated",
    Duration = 6,
    Image = 4483362458
})

-- Enhanced Gamepass System with Remote Hooking
local function setGamepassValue(passName, value)
    local player = game:GetService("Players").LocalPlayer
    
    -- Create GamePass folder if it doesn't exist
    if not player:FindFirstChild("GamePass") then
        local folder = Instance.new("Folder")
        folder.Name = "GamePass"
        folder.Parent = player
    end
    
    -- Handle special cases
    if passName == "VIP" then
        -- Set VIP GamePass value
        local vipPass = player.GamePass:FindFirstChild("VIP")
        if not vipPass then
            vipPass = Instance.new("NumberValue")
            vipPass.Name = "VIP"
            vipPass.Parent = player.GamePass
        end
        vipPass.Value = value
        
        -- Set VIP gold bonus
        if not player:FindFirstChild("GoldBuffDetail") then
            local goldBuff = Instance.new("Folder")
            goldBuff.Name = "GoldBuffDetail"
            goldBuff.Parent = player
        end
        
        local vipGold = player.GoldBuffDetail:FindFirstChild("VipGoldAdd")
        if not vipGold then
            vipGold = Instance.new("NumberValue")
            vipGold.Name = "VipGoldAdd"
            vipGold.Parent = player.GoldBuffDetail
        end
        vipGold.Value = value
        
        return
    end
    
    if passName == "JumpPalPass" then
        local pass = player.GamePass:FindFirstChild("JumpPalPass")
        if not pass then
            pass = Instance.new("NumberValue")
            pass.Name = "JumpPalPass"
            pass.Parent = player.GamePass
        end
        pass.Value = value
        
        -- Set max JumpPals
        if value == 1 then
            player.JumpPalMax.Value = 5
        end
        return
    end
    
    -- Handle 2XSpeed and 2XWin
    if passName == "2XSpeed" or passName == "2XWin" then
        local pass = player.GamePass:FindFirstChild(passName)
        if not pass then
            pass = Instance.new("NumberValue")
            pass.Name = passName
            pass.Parent = player.GamePass
        end
        pass.Value = value
        return
    end
    
    -- For normal gamepasses
    local pass = player.GamePass:FindFirstChild(passName)
    if not pass then
        pass = Instance.new("NumberValue")
        pass.Name = passName
        pass.Parent = player.GamePass
    end
    
    pass.Value = value
end

-- Advanced Remote Function Hook
local function enableRemoteHook()
    if not hookmetamethod then return false end

    local originalNamecall
    originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        local remoteName = tostring(self)
        
        -- Bypass all gamepass checks
        if method == "InvokeServer" and remoteName:find("Gamepass") then
            return true
        end
        
        -- Bypass VIP checks
        if method == "InvokeServer" and remoteName:find("Vip") then
            return true
        end
        
        -- Bypass JumpPal checks
        if method == "InvokeServer" and remoteName:find("JumpPal") then
            return true
        end

        return originalNamecall(self, ...)
    end)
    
    return true
end

-- Enable remote hook on startup
enableRemoteHook()

-- Speed System with Server-Side Bypass
local desiredWalkSpeed = 16
local walkSpeedEnabled = false
local walkSpeedLoop = nil

local function setWalkSpeed()
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("AvatarSpeed") then
        player.AvatarSpeed.Value = desiredWalkSpeed
    end
end

local function startWalkSpeedLoop()
    if walkSpeedLoop then return end
    walkSpeedLoop = task.spawn(function()
        while walkSpeedEnabled do
            setWalkSpeed()
            task.wait(0.5)
        end
        walkSpeedLoop = nil
    end)
end

local function stopWalkSpeedLoop()
    if walkSpeedLoop then
        task.cancel(walkSpeedLoop)
        walkSpeedLoop = nil
    end
end

-- Climb Speed System (Fixed)
local desiredClimbSpeed = 16
local climbSpeedEnabled = false
local climbSpeedLoop = nil

local function setClimbSpeed()
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("AvatarSpeed") then
        player.AvatarSpeed.Value = desiredClimbSpeed
    end
end

local function startClimbSpeedLoop()
    if climbSpeedLoop then return end
    climbSpeedLoop = task.spawn(function()
        while climbSpeedEnabled do
            setClimbSpeed()
            task.wait(0.5)
        end
        climbSpeedLoop = nil
    end)
end

local function stopClimbSpeedLoop()
    if climbSpeedLoop then
        task.cancel(climbSpeedLoop)
        climbSpeedLoop = nil
    end
end

-- Gamepass Tab
local GamepassTab = Window:CreateTab("Gamepass Hack", 4483362458)

GamepassTab:CreateButton({
    Name = "Enable Gamepass Bypass",
    Callback = function()
        Rayfield:Notify({
            Title = "Success",
            Content = "Gamepass validation bypass active!",
            Duration = 5,
        })
    end
})

-- All gamepasses with special handling
local gamepasses = {
    {Name = "Fast-Hatch", Type = "normal"},
    {Name = "Triple-Hatch", Type = "normal"},
    {Name = "Tenfold-Hatch", Type = "normal"},
    {Name = "AutoCollect", Type = "normal"},
    {Name = "Luck", Type = "normal"},
    {Name = "SecretLucky2", Type = "normal"},
    {Name = "Super-Luck", Type = "normal"},
    {Name = "Ultra-Luck", Type = "normal"},
    {Name = "VIP", Type = "special"},
    {Name = "JumpPalPass", Type = "special"},
    {Name = "SkipAllSeason", Type = "normal"},
    {Name = "2XSpeed", Type = "normal"},
    {Name = "2XWin", Type = "normal"},
}

for _, pass in ipairs(gamepasses) do
    GamepassTab:CreateToggle({
        Name = pass.Name,
        CurrentValue = false,
        Callback = function(Value)
            setGamepassValue(pass.Name, Value and 1 or 0)
            
            if pass.Name == "JumpPalPass" and Value then
                -- Set JumpPalMax to 5 when JumpPalPass is enabled
                game:GetService("Players").LocalPlayer.JumpPalMax.Value = 5
            end
            
            Rayfield:Notify({
                Title = "Gamepass Updated",
                Content = pass.Name .. ": " .. (Value and "ENABLED" or "DISABLED"),
                Duration = 3,
            })
        end
    })
end

-- JumpPalMax Slider
GamepassTab:CreateSlider({
    Name = "JumpPal Max Count",
    Range = {1, 5},
    Increment = 1,
    Suffix = "JumpPals",
    CurrentValue = 1,
    Flag = "JumpPalMaxSlider",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.JumpPalMax.Value = Value
        Rayfield:Notify({
            Title = "JumpPal Max Set",
            Content = "JumpPal max count set to: " .. Value,
            Duration = 3,
        })
    end
})

-- PetMax Feature
GamepassTab:CreateToggle({
    Name = "Unlock All Pets (Max 1000)",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            game:GetService("Players").LocalPlayer.PetMax.Value = 1000
            Rayfield:Notify({
                Title = "Pets Unlocked",
                Content = "Max pets set to 1000!",
                Duration = 3,
            })
        else
            game:GetService("Players").LocalPlayer.PetMax.Value = 3
            Rayfield:Notify({
                Title = "Pets Reset",
                Content = "Max pets reset to default (3)",
                Duration = 3,
            })
        end
    end
})

-- Auto Farm System
local function createTween(part, targetCFrame, duration, easingStyle, callback)
    local TweenService = game:GetService("TweenService")
    local tween = TweenService:Create(part, TweenInfo.new(duration, easingStyle), {CFrame = targetCFrame})
    
    if callback then
        tween.Completed:Connect(callback)
    end
    
    tween:Play()
    return tween
end

local function tween1Win(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14400, startPos.Z)
    local step2 = Vector3.new(-4, 14401, -114)
    local step3 = Vector3.new(-4, 14401, 33)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween5Wins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(4999, 14404, -95)
    local step3 = Vector3.new(4999, 14404, 51)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween20Wins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(10000, 14404, -89)
    local step3 = Vector3.new(10000, 14404, 66)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween100Wins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(14997, 14405, -176)
    local step3 = Vector3.new(14997, 14405, 26)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween500Wins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(19999, 14403, -133)
    local step3 = Vector3.new(20000, 14403, 60)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween2kWins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(25000, 14406, -89)
    local step3 = Vector3.new(25000, 14406, 74)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween10kWins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(30000, 14402, -131)
    local step3 = Vector3.new(30000, 14402, 9)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween50kWins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(35000, 14406, -89)
    local step3 = Vector3.new(35000, 14406, 130)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

local function tween250kWins(callback)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return end
    
    local startPos = hrp.Position
    local step1 = Vector3.new(startPos.X, 14402, startPos.Z)
    local step2 = Vector3.new(40000, 14402, -221)
    local step3 = Vector3.new(40000, 14402, -62)
    
    createTween(hrp, CFrame.new(step1), 0.1, Enum.EasingStyle.Sine, function()
        createTween(hrp, CFrame.new(step2), 0.6, Enum.EasingStyle.Sine, function()
            createTween(hrp, CFrame.new(step3), 2.5, Enum.EasingStyle.Sine, callback)
        end)
    end)
end

-- Auto Farm Tab
local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458)

-- Single Run Buttons
AutoFarmTab:CreateButton({
    Name = "1 Win (Single Run)",
    Callback = function()
        tween1Win(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 1 Win route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "5 Wins (Single Run)",
    Callback = function()
        tween5Wins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 5 Wins route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "20 Wins (Single Run)",
    Callback = function()
        tween20Wins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 20 Wins route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "100 Wins (Single Run)",
    Callback = function()
        tween100Wins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 100 Wins route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "500 Wins (Single Run)",
    Callback = function()
        tween500Wins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 500 Wins route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "2K Wins (Single Run)",
    Callback = function()
        tween2kWins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 2K Wins route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "10K Wins (Single Run)",
    Callback = function()
        tween10kWins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 10K Wins route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "50K Wins (Single Run)",
    Callback = function()
        tween50kWins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 50K Wins route",
                Duration = 3,
            })
        end)
    end
})

AutoFarmTab:CreateButton({
    Name = "250K Wins (Single Run)",
    Callback = function()
        tween250kWins(function()
            Rayfield:Notify({
                Title = "Complete",
                Content = "Finished 250K Wins route",
                Duration = 3,
            })
        end)
    end
})

-- Auto Farm Toggles
local looping1, looping5, looping20, looping100 = false, false, false, false
local looping500, looping2k, looping10k, looping50k, looping250k = false, false, false, false, false

local function manageLoop(loopType, shouldStart, tweenFunction)
    -- Update loop state
    if loopType == "1" then looping1 = shouldStart
    elseif loopType == "5" then looping5 = shouldStart
    elseif loopType == "20" then looping20 = shouldStart
    elseif loopType == "100" then looping100 = shouldStart
    elseif loopType == "500" then looping500 = shouldStart
    elseif loopType == "2k" then looping2k = shouldStart
    elseif loopType == "10k" then looping10k = shouldStart
    elseif loopType == "50k" then looping50k = shouldStart
    elseif loopType == "250k" then looping250k = shouldStart end
    
    if shouldStart then
        local function loopStep()
            -- Check if still active
            if (loopType == "1" and not looping1) or
               (loopType == "5" and not looping5) or
               (loopType == "20" and not looping20) or
               (loopType == "100" and not looping100) or
               (loopType == "500" and not looping500) or 
               (loopType == "2k" and not looping2k) or
               (loopType == "10k" and not looping10k) or
               (loopType == "50k" and not looping50k) or
               (loopType == "250k" and not looping250k) then return end
            
            tweenFunction(function()
                task.wait(12)
                loopStep()
            end)
        end
        
        loopStep()
    end
end

AutoFarmTab:CreateToggle({
    Name = "Auto 1 Win",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("1", Value, tween1Win)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 5 Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("5", Value, tween5Wins)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 20 Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("20", Value, tween20Wins)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 100 Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("100", Value, tween100Wins)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 500 Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("500", Value, tween500Wins)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 2K Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("2k", Value, tween2kWins)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 10K Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("10k", Value, tween10kWins)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 50K Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("50k", Value, tween50kWins)
    end
})

AutoFarmTab:CreateToggle({
    Name = "Auto 250K Wins",
    CurrentValue = false,
    Callback = function(Value)
        manageLoop("250k", Value, tween250kWins)
    end
})

-- Misc Features
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- WalkSpeed Control
MiscTab:CreateSection("Movement Control")

MiscTab:CreateToggle({
    Name = "Enable WalkSpeed",
    CurrentValue = false,
    Callback = function(Value)
        walkSpeedEnabled = Value
        if Value then
            startWalkSpeedLoop()
            Rayfield:Notify({
                Title = "WalkSpeed",
                Content = "WalkSpeed enabled: " .. desiredWalkSpeed,
                Duration = 3,
            })
        else
            stopWalkSpeedLoop()
            Rayfield:Notify({
                Title = "WalkSpeed",
                Content = "WalkSpeed disabled",
                Duration = 3,
            })
        end
    end
})

MiscTab:CreateInput({
    Name = "Set WalkSpeed",
    PlaceholderText = "Enter speed value (e.g. 50)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local speed = tonumber(Text)
        if speed then
            desiredWalkSpeed = speed
            if walkSpeedEnabled then
                setWalkSpeed()
            end
            Rayfield:Notify({
                Title = "WalkSpeed Updated",
                Content = "WalkSpeed set to: " .. speed,
                Duration = 3,
            })
        else
            Rayfield:Notify({
                Title = "Invalid Input",
                Content = "Please enter a valid number",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

-- Climb Speed Control
MiscTab:CreateSection("Climb Control")

MiscTab:CreateToggle({
    Name = "Enable Climb Speed",
    CurrentValue = false,
    Callback = function(Value)
        climbSpeedEnabled = Value
        if Value then
            startClimbSpeedLoop()
            Rayfield:Notify({
                Title = "Climb Speed",
                Content = "Climb Speed enabled: " .. desiredClimbSpeed,
                Duration = 3,
            })
        else
            stopClimbSpeedLoop()
            Rayfield:Notify({
                Title = "Climb Speed",
                Content = "Climb Speed disabled",
                Duration = 3,
            })
        end
    end
})

MiscTab:CreateInput({
    Name = "Set Climb Speed",
    PlaceholderText = "Enter speed value (e.g. 50)",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local speed = tonumber(Text)
        if speed then
            desiredClimbSpeed = speed
            if climbSpeedEnabled then
                setClimbSpeed()
            end
            Rayfield:Notify({
                Title = "Climb Speed Updated",
                Content = "Climb Speed set to: " .. speed,
                Duration = 3,
            })
        else
            Rayfield:Notify({
                Title = "Invalid Input",
                Content = "Please enter a valid number",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

-- Infinite Jump
local InfiniteJumpEnabled = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

MiscTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
        Rayfield:Notify({
            Title = "Infinite Jump",
            Content = Value and "Enabled" or "Disabled",
            Duration = 2,
        })
    end
})

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

MiscTab:CreateLabel("Anti-AFK is automatically enabled")

-- Character Reset (For Stuck Issues)
MiscTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character:BreakJoints()
        Rayfield:Notify({
            Title = "Character Reset",
            Content = "Your character has been reset",
            Duration = 3,
        })
    end
})

-- Credits
MiscTab:CreateSection("Credits")
MiscTab:CreateLabel("Script by BabyBloxZ")
MiscTab:CreateLabel("UI by Rayfield")
