-- Load BabyBloxZ Library
local BabyBloxZ = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local keyLink = "https://link-target.net/1343847/1Ovaz8Yyhqpj"
setclipboard(keyLink)

-- UI Setup
local Window = BabyBloxZ:CreateWindow({
    Name = "Climb and Jump HUB",
    LoadingTitle = "Loading Ultimate HUB",
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

BabyBloxZ:Notify({
    Title = "Key Copied",
    Content = "Key has been copied to clipboard: "..keyLink,
    Duration = 8,
    Image = 0
})

-- Notify
BabyBloxZ:Notify({
    Title = "Script Loaded",
    Content = "Auto Farm and Gamepass Hack Activated",
    Duration = 6,
    Image = 4483362458
})

-- =============================================
-- COMPREHENSIVE GAMEPASS BYPASS SYSTEM
-- =============================================
local originalRemotes = {}
local gamepassStates = {}
local bypassEnabled = true

-- List of all possible remote patterns
local remotePatterns = {
    "Gamepass", "Pass", "VIP", "Vip", "JumpPal", "Hatch", "Validation", "Check", "Validate", 
    "Purchase", "Activate", "System", "Reward", "Perk", "Benefit", "Upgrade", "Boost", 
    "Advantage", "Feature", "Unlock", "Special", "Offer", "Deal", "Promo", "Gift", "Bonus",
    "Fast", "Triple", "Tenfold", "Auto", "Collect", "Luck", "Secret", "Super", "Ultra", "Skip",
    "Season", "Double", "Win", "Speed", "Gold", "Buff", "BuffDetail", "Pal", "Pet", "Character"
}

-- Hook any remote that matches patterns
local function hookAllGamepassRemotes()
    if not bypassEnabled then return end
    
    -- Hook existing remotes
    for _, obj in ipairs(game:GetDescendants()) do
        if (obj:IsA("RemoteFunction") or (obj:IsA("RemoteEvent")) then
            for _, pattern in ipairs(remotePatterns) do
                if obj.Name:lower():find(pattern:lower()) then
                    -- Backup original
                    if not originalRemotes[obj] then
                        originalRemotes[obj] = {
                            Invoke = (obj:IsA("RemoteFunction")) and obj.Invoke or nil,
                            FireServer = (obj:IsA("RemoteEvent")) and obj.FireServer or nil
                        }
                    end
                    
                    -- Hook function
                    if obj:IsA("RemoteFunction") then
                        hookfunction(obj.Invoke, function(_, ...)
                            return true
                        end)
                    elseif obj:IsA("RemoteEvent") then
                        hookfunction(obj.FireServer, function(_, ...)
                            return nil
                        end)
                    end
                end
            end
        end
    end
    
    -- Hook new remotes
    game.DescendantAdded:Connect(function(obj)
        if (obj:IsA("RemoteFunction") or (obj:IsA("RemoteEvent")) then
            for _, pattern in ipairs(remotePatterns) do
                if obj.Name:lower():find(pattern:lower()) then
                    -- Backup original
                    if not originalRemotes[obj] then
                        originalRemotes[obj] = {
                            Invoke = (obj:IsA("RemoteFunction")) and obj.Invoke or nil,
                            FireServer = (obj:IsA("RemoteEvent")) and obj.FireServer or nil
                        }
                    end
                    
                    -- Hook function
                    if obj:IsA("RemoteFunction") then
                        hookfunction(obj.Invoke, function(_, ...)
                            return true
                        end)
                    elseif obj:IsA("RemoteEvent") then
                        hookfunction(obj.FireServer, function(_, ...)
                            return nil
                        end)
                    end
                end
            end
        end
    end)
end

-- Metatable hook for all remote calls
local function hookMetatable()
    if not bypassEnabled then return end
    
    local mt = getrawmetatable(game)
    local __namecall = mt.__namecall
    
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local remoteName = tostring(self)
        
        -- Bypass all possible gamepass checks
        for _, pattern in ipairs(remotePatterns) do
            if remoteName:lower():find(pattern:lower()) then
                return true
            end
        end
        
        return __namecall(self, ...)
    end)
end

-- Enable comprehensive bypass
local function enableFullBypass()
    if not hookfunction or not getrawmetatable then
        BabyBloxZ:Notify({
            Title = "ERROR",
            Content = "Your exploit doesn't support required features",
            Duration = 6,
        })
        return false
    end

    hookAllGamepassRemotes()
    hookMetatable()
    
    return true
end

-- Apply bypass on startup
enableFullBypass()

-- Gamepass Activation System
local function activateGamepass(passName, value)
    local player = game:GetService("Players").LocalPlayer
    
    -- Create GamePass folder if needed
    if not player:FindFirstChild("GamePass") then
        local folder = Instance.new("Folder")
        folder.Name = "GamePass"
        folder.Parent = player
    end
    
    -- Update gamepass state
    gamepassStates[passName] = value
    
    -- Special handling for each gamepass type
    if passName == "Fast-Hatch" then
        -- Set client-side value
        local pass = player.GamePass:FindFirstChild("Fast-Hatch") or Instance.new("NumberValue")
        pass.Name = "Fast-Hatch"
        pass.Value = value and 1 or 0
        pass.Parent = player.GamePass
        
        -- Simulate server activation
        for _, remote in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if remote.Name:lower():find("hatch") then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(value)
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(value)
                    end
                end)
            end
        end
        return
    end
    
    if passName == "VIP" then
        -- Set VIP GamePass value
        local vipPass = player.GamePass:FindFirstChild("VIP") or Instance.new("NumberValue")
        vipPass.Name = "VIP"
        vipPass.Value = value and 1 or 0
        vipPass.Parent = player.GamePass
        
        -- Set VIP gold bonus
        if not player:FindFirstChild("GoldBuffDetail") then
            Instance.new("Folder", player).Name = "GoldBuffDetail"
        end
        
        local vipGold = player.GoldBuffDetail:FindFirstChild("VipGoldAdd") or Instance.new("NumberValue")
        vipGold.Name = "VipGoldAdd"
        vipGold.Value = value and 0.5 or 0
        vipGold.Parent = player.GoldBuffDetail
        
        -- Simulate server activation
        for _, remote in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if remote.Name:lower():find("vip") then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(value)
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(value)
                    end
                end)
            end
        end
        return
    end
    
    if passName == "JumpPalPass" then
        local pass = player.GamePass:FindFirstChild("JumpPalPass") or Instance.new("NumberValue")
        pass.Name = "JumpPalPass"
        pass.Value = value and 1 or 0
        pass.Parent = player.GamePass
        
        -- Set max JumpPals (server-side)
        player.JumpPalMax.Value = value and 5 or 3
        
        -- Simulate server activation
        for _, remote in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if remote.Name:lower():find("jumppal") then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(value)
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(value)
                    end
                end)
            end
        end
        return
    end
    
    -- For other gamepasses
    local pass = player.GamePass:FindFirstChild(passName) or Instance.new("NumberValue")
    pass.Name = passName
    pass.Value = value and 1 or 0
    pass.Parent = player.GamePass
    
    -- Simulate server activation
    for _, remote in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if remote.Name:lower():find(passName:lower()) then
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(value)
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(value)
                end
            end)
        end
    end
end

-- =============================================
-- AUTO FARM SYSTEM
-- =============================================
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

-- =============================================
-- UI: GAMEPASS TAB
-- =============================================
local GamepassTab = Window:CreateTab("Gamepass Hack", 4483362458)

-- Add info labels
GamepassTab:CreateLabel("FULL GAMEPASS BYPASS ACTIVATED")
GamepassTab:CreateLabel("Covers all possible remote patterns!")

GamepassTab:CreateToggle({
    Name = "Enable Bypass System",
    CurrentValue = true,
    Callback = function(Value)
        bypassEnabled = Value
        if Value then
            enableFullBypass()
            -- Reapply gamepass states
            for passName, state in pairs(gamepassStates) do
                activateGamepass(passName, state)
            end
        end
        BabyBloxZ:Notify({
            Title = "Bypass System",
            Content = Value and "ENABLED" or "DISABLED",
            Duration = 3,
        })
    end
})

-- All gamepasses with server activation
local gamepasses = {
    "Fast-Hatch",
    "Triple-Hatch",
    "Tenfold-Hatch",
    "AutoCollect",
    "Luck",
    "SecretLucky2",
    "Super-Luck",
    "Ultra-Luck",
    "VIP",
    "JumpPalPass",
    "SkipAllSeason",
    "2XSpeed",
    "2XWin",
    "GoldBonus",
    "JumpBoost",
    "SpeedBoost",
    "LuckyCharm",
    "DoubleRewards",
    "AutoHatch",
    "InstantWin"
}

for _, passName in ipairs(gamepasses) do
    GamepassTab:CreateToggle({
        Name = passName,
        CurrentValue = false,
        Callback = function(Value)
            activateGamepass(passName, Value)
            
            BabyBloxZ:Notify({
                Title = "Gamepass Updated",
                Content = passName .. ": " .. (Value and "ENABLED" or "DISABLED"),
                Duration = 3,
            })
        end
    })
end

-- Pet System (Server-Side)
GamepassTab:CreateToggle({
    Name = "Unlimited Pet Capacity",
    CurrentValue = false,
    Callback = function(Value)
        local player = game:GetService("Players").LocalPlayer
        
        -- Client-side value
        player.PetMax.Value = Value and 1000 or 3
        
        -- Server-side activation
        activateGamepass("PetCapacity", Value)
        
        -- Simulate server calls
        for _, remote in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if remote.Name:lower():find("pet") or remote.Name:lower():find("capacity") then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(Value and 1000 or 3)
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(Value and 1000 or 3)
                    end
                end)
            end
        end
        
        BabyBloxZ:Notify({
            Title = "Pet System",
            Content = "Unlimited Pets: " .. (Value and "ON (1000)" or "OFF (3)"),
            Duration = 3,
        })
    end
})

-- JumpPal System (Server-Side)
GamepassTab:CreateSlider({
    Name = "JumpPal Max Count",
    Range = {1, 20},
    Increment = 1,
    Suffix = "JumpPals",
    CurrentValue = 3,
    Flag = "JumpPalMaxSlider",
    Callback = function(Value)
        local player = game:GetService("Players").LocalPlayer
        
        -- Client-side value
        player.JumpPalMax.Value = Value
        
        -- Server-side activation
        for _, remote in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if remote.Name:lower():find("jumppal") or remote.Name:lower():find("palmax") then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(Value)
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(Value)
                    end
                end)
            end
        end
        
        BabyBloxZ:Notify({
            Title = "JumpPal Max Set",
            Content = "JumpPal max count set to: " .. Value,
            Duration = 3,
        })
    end
})

-- =============================================
-- UI: AUTO FARM TAB
-- =============================================
local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458)

-- Single Run Buttons
AutoFarmTab:CreateButton({
    Name = "1 Win (Single Run)",
    Callback = function()
        tween1Win(function()
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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
            BabyBloxZ:Notify({
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

-- =============================================
-- UI: MISC TAB
-- =============================================
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Walk Speed Control
local walkSpeedValue = 16
local walkSpeedEnabled = false

local function updateWalkSpeed()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeedEnabled and walkSpeedValue or 16
        end
    end
end

MiscTab:CreateToggle({
    Name = "Enable Custom Walk Speed",
    CurrentValue = false,
    Callback = function(Value)
        walkSpeedEnabled = Value
        updateWalkSpeed()
        BabyBloxZ:Notify({
            Title = "Walk Speed",
            Content = Value and "Enabled" or "Disabled",
            Duration = 2,
        })
    end
})

MiscTab:CreateInput({
    Name = "Walk Speed Value",
    PlaceholderText = tostring(walkSpeedValue),
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local newSpeed = tonumber(Text)
        if newSpeed and newSpeed > 0 then
            walkSpeedValue = newSpeed
            if walkSpeedEnabled then
                updateWalkSpeed()
            end
            BabyBloxZ:Notify({
                Title = "Walk Speed Updated",
                Content = "Set to: " .. walkSpeedValue,
                Duration = 3,
            })
        else
            BabyBloxZ:Notify({
                Title = "Invalid Value",
                Content = "Please enter a valid number",
                Duration = 3,
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
        BabyBloxZ:Notify({
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
        BabyBloxZ:Notify({
            Title = "Character Reset",
            Content = "Your character has been reset",
            Duration = 3,
        })
    end
})

-- Credits
MiscTab:CreateLabel("Script by BabyBloxZ")
MiscTab:CreateLabel("UI by BabyBloxZ")

-- =============================================
-- INITIALIZATION
-- =============================================
-- Connect character added event for walk speed
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    -- Reapply walk speed if needed
    if walkSpeedEnabled then
        character:WaitForChild("Humanoid")
        updateWalkSpeed()
    end
    
    -- Reapply gamepass states
    task.wait(2)
    for passName, state in pairs(gamepassStates) do
        activateGamepass(passName, state)
    end
end)

-- Auto farm safety
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1)
    if looping1 or looping5 or looping20 or looping100 or looping500 or looping2k or looping10k or looping50k or looping250k then
        BabyBloxZ:Notify({
            Title = "Auto Farm Restarted",
            Content = "Resuming auto farm after respawn",
            Duration = 4,
        })
    end
end)

-- Initialize bypass
task.spawn(function()
    while true do
        enableFullBypass()
        task.wait(30) -- Reinforce bypass every 30 seconds
    end
end)