-- TSB ADMIN TOOL - VERSÃO ADMIN v2.1
-- Com sistema de KEY de admin
-- PlaceID: 10449761463

if _G.TSBAdminLoaded then
    warn("Script admin já está carregado!")
    return
end
_G.TSBAdminLoaded = true

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Camera = Workspace.CurrentCamera

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- ============ CONFIGURAÇÃO ============
local ADMIN_USER = "Bandidoqur67rezenh"
local isRealAdmin = (player.Name == ADMIN_USER)

if not isRealAdmin then
    warn("⚠️ Acesso negado! Você não é o admin.")
    return
end

-- ============ THEME ============
local THEME = {
    Primary = Color3.fromRGB(138, 43, 226),
    Secondary = Color3.fromRGB(25, 25, 112),
    Accent = Color3.fromRGB(255, 20, 147),
    Dark = Color3.fromRGB(10, 10, 10),
    Text = Color3.fromRGB(255, 255, 255),
    Success = Color3.fromRGB(50, 205, 50),
    Error = Color3.fromRGB(255, 69, 0)
}

-- ============ CRIAR UI ============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TSBAdminUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Main Window
local mainWindow = Instance.new("Frame")
mainWindow.Name = "MainWindow"
mainWindow.Size = UDim2.new(0, 700, 0, 600)
mainWindow.Position = UDim2.new(0.5, -350, 0.5, -300)
mainWindow.BackgroundColor3 = THEME.Dark
mainWindow.BorderSizePixel = 0
mainWindow.Draggable = true
mainWindow.Active = true
mainWindow.Parent = screenGui

local stroke = Instance.new("UIStroke")
stroke.Color = THEME.Accent
stroke.Thickness = 2
stroke.Parent = mainWindow

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainWindow

-- ============ HEADER ============
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = THEME.Secondary
header.BorderSizePixel = 0
header.Parent = mainWindow

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "👑 TSB ADMIN TOOL - " .. player.Name
title.TextColor3 = THEME.Accent
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundColor3 = THEME.Error
closeBtn.Text = "✕"
closeBtn.TextColor3 = THEME.Text
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)
closeBtnCorner.Parent = closeBtn

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
minimizeBtn.Position = UDim2.new(1, -90, 0, 5)
minimizeBtn.BackgroundColor3 = THEME.Primary
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = THEME.Text
minimizeBtn.TextSize = 20
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = header

local minimizeBtnCorner = Instance.new("UICorner")
minimizeBtnCorner.CornerRadius = UDim.new(0, 6)
minimizeBtnCorner.Parent = minimizeBtn

-- ============ TAB SYSTEM ============
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 50)
tabBar.BackgroundColor3 = THEME.Secondary
tabBar.BorderSizePixel = 0
tabBar.Parent = mainWindow

local tabScroll = Instance.new("UIListLayout")
tabScroll.Padding = UDim.new(0, 5)
tabScroll.FillDirection = Enum.FillDirection.Horizontal
tabScroll.SortOrder = Enum.SortOrder.LayoutOrder
tabScroll.Parent = tabBar

local tabs = {
    "⚔️ Combat",
    "💨 Dash",
    "📊 Stats",
    "🌐 TP",
    "🏟️ Arena",
    "👁️ Visuals",
    "🔧 Utils",
    "👞 Troll"
}

local tabButtons = {}
local tabContents = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 1, 0)
    btn.BackgroundColor3 = THEME.Primary
    btn.TextColor3 = THEME.Text
    btn.Text = tabName
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    btn.Parent = tabBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    tabButtons[i] = btn
    
    -- Tab Content
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -100)
    content.Position = UDim2.new(0, 10, 0, 90)
    content.BackgroundTransparency = 1
    content.Visible = (i == 1)
    content.Parent = mainWindow
    
    local contentScroll = Instance.new("UIListLayout")
    contentScroll.Padding = UDim.new(0, 8)
    contentScroll.SortOrder = Enum.SortOrder.LayoutOrder
    contentScroll.Parent = content
    
    tabContents[i] = content
    
    btn.MouseButton1Click:Connect(function()
        for j, c in ipairs(tabContents) do
            c.Visible = (j == i)
            tabButtons[j].BackgroundColor3 = (j == i) and THEME.Accent or THEME.Primary
        end
    end)
end

-- ============ HELPER FUNCTION ============
local function createToggle(parent, text, callback, order)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 35)
    container.BackgroundColor3 = THEME.Secondary
    container.BorderSizePixel = 0
    container.LayoutOrder = order or 1
    container.Parent = parent
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 6)
    containerCorner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.8, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = THEME.Text
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 25)
    toggle.Position = UDim2.new(0.8, 0, 0.5, -12)
    toggle.BackgroundColor3 = THEME.Error
    toggle.Text = "OFF"
    toggle.TextColor3 = THEME.Text
    toggle.TextSize = 10
    toggle.Font = Enum.Font.GothamBold
    toggle.BorderSizePixel = 0
    toggle.Parent = container
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 4)
    toggleCorner.Parent = toggle
    
    local isEnabled = false
    toggle.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        toggle.BackgroundColor3 = isEnabled and THEME.Success or THEME.Error
        toggle.Text = isEnabled and "ON" or "OFF"
        callback(isEnabled)
    end)
    
    return toggle
end

-- ============ TAB 1: COMBAT ============
local combatTab = tabContents[1]

createToggle(combatTab, "⚡ No Stun (Agressivo)", function(enabled)
    if enabled then
        local noStunConnection
        noStunConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then noStunConnection:Disconnect() return end
            
            if character and humanoidRootPart then
                humanoidRootPart:SetNetworkOwner(player)
                
                for _, obj in ipairs(character:GetChildren()) do
                    if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                        obj:Destroy()
                    end
                end
                
                humanoid.Parent = character
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
                
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end)
        _G.NoStunConnection = noStunConnection
    else
        if _G.NoStunConnection then
            _G.NoStunConnection:Disconnect()
        end
    end
end, 1)

createToggle(combatTab, "👻 Anti-Ragdoll", function(enabled)
    if enabled then
        local antiRagConnection
        antiRagConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then antiRagConnection:Disconnect() return end
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
        end)
        _G.AntiRagConnection = antiRagConnection
    else
        if _G.AntiRagConnection then
            _G.AntiRagConnection:Disconnect()
        end
    end
end, 2)

createToggle(combatTab, "🛡️ Auto Block", function(enabled)
    if enabled then
        local autoBlockConnection
        autoBlockConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then autoBlockConnection:Disconnect() return end
            
            for _, enemy in ipairs(Players:GetPlayers()) do
                if enemy == player then continue end
                if not enemy.Character then continue end
                
                local enemyHRP = enemy.Character:FindFirstChild("HumanoidRootPart")
                if enemyHRP and (enemyHRP.Position - humanoidRootPart.Position).Magnitude < 22 then
                    UserInputService:SendKeyEvent(true, Enum.KeyCode.F, false)
                    task.wait(0.55)
                    UserInputService:SendKeyEvent(false, Enum.KeyCode.F, false)
                end
            end
        end)
        _G.AutoBlockConnection = autoBlockConnection
    else
        if _G.AutoBlockConnection then
            _G.AutoBlockConnection:Disconnect()
        end
    end
end, 3)

createToggle(combatTab, "💪 Auto Punch", function(enabled)
    if enabled then
        local autoPunchConnection
        autoPunchConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then autoPunchConnection:Disconnect() return end
            
            for _, enemy in ipairs(Players:GetPlayers()) do
                if enemy == player then continue end
                if not enemy.Character then continue end
                
                local enemyHRP = enemy.Character:FindFirstChild("HumanoidRootPart")
                if enemyHRP and (enemyHRP.Position - humanoidRootPart.Position).Magnitude < 15 then
                    UserInputService:SendKeyEvent(true, Enum.KeyCode.Z, false)
                    task.wait(0.1)
                    UserInputService:SendKeyEvent(false, Enum.KeyCode.Z, false)
                end
            end
        end)
        _G.AutoPunchConnection = autoPunchConnection
    else
        if _G.AutoPunchConnection then
            _G.AutoPunchConnection:Disconnect()
        end
    end
end, 4)

createToggle(combatTab, "🌟 Auto Awakening", function(enabled)
    if enabled then
        local autoAwakeConnection
        autoAwakeConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then autoAwakeConnection:Disconnect() return end
            
            UserInputService:SendKeyEvent(true, Enum.KeyCode.G, false)
            task.wait(0.05)
            UserInputService:SendKeyEvent(false, Enum.KeyCode.G, false)
            task.wait(3)
        end)
        _G.AutoAwakeConnection = autoAwakeConnection
    else
        if _G.AutoAwakeConnection then
            _G.AutoAwakeConnection:Disconnect()
        end
    end
end, 5)

createToggle(combatTab, "💚 God Mode", function(enabled)
    if enabled then
        local godModeConnection
        godModeConnection = RunService.Heartbeat:Connect(function()
            if not _G.TSBAdminLoaded then godModeConnection:Disconnect() return end
            humanoid.Health = humanoid.MaxHealth
        end)
        _G.GodModeConnection = godModeConnection
    else
        if _G.GodModeConnection then
            _G.GodModeConnection:Disconnect()
        end
    end
end, 6)

createToggle(combatTab, "⬆️ No Knockback", function(enabled)
    if enabled then
        local noKBConnection
        noKBConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then noKBConnection:Disconnect() return end
            
            humanoidRootPart.Velocity = Vector3.new(0, humanoidRootPart.Velocity.Y, 0)
        end)
        _G.NoKBConnection = noKBConnection
    else
        if _G.NoKBConnection then
            _G.NoKBConnection:Disconnect()
        end
    end
end, 7)

createToggle(combatTab, "🧲 Noclip", function(enabled)
    if enabled then
        local noclipConnection
        noclipConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then noclipConnection:Disconnect() return end
            
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
        _G.NoclipConnection = noclipConnection
    else
        if _G.NoclipConnection then
            _G.NoclipConnection:Disconnect()
        end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end, 8)

-- ============ TAB 2: DASH ============
local dashTab = tabContents[2]

createToggle(dashTab, "💨 No Dash CD (Todos)", function(enabled)
    if enabled then
        local noDashConnection
        noDashConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then noDashConnection:Disconnect() return end
            
            for _, attr in ipairs(character:GetAttributes()) do
                if attr:lower():match("dash") or attr:lower():match("cd") then
                    character:SetAttribute(attr, 0)
                end
            end
        end)
        _G.NoDashConnection = noDashConnection
    else
        if _G.NoDashConnection then
            _G.NoDashConnection:Disconnect()
        end
    end
end, 1)

-- ============ TAB 3: STATS ============
local statsTab = tabContents[3]

createToggle(statsTab, "🏃 WalkSpeed Blindado", function(enabled)
    if enabled then
        local walkSpeedConnection
        walkSpeedConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then walkSpeedConnection:Disconnect() return end
            humanoid.WalkSpeed = 20
        end)
        _G.WalkSpeedConnection = walkSpeedConnection
    else
        if _G.WalkSpeedConnection then
            _G.WalkSpeedConnection:Disconnect()
        end
        humanoid.WalkSpeed = 16
    end
end, 1)

createToggle(statsTab, "📈 JumpPower Blindado", function(enabled)
    if enabled then
        local jumpPowerConnection
        jumpPowerConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then jumpPowerConnection:Disconnect() return end
            humanoid.JumpPower = 50
        end)
        _G.JumpPowerConnection = jumpPowerConnection
    else
        if _G.JumpPowerConnection then
            _G.JumpPowerConnection:Disconnect()
        end
        humanoid.JumpPower = 0
    end
end, 2)

-- ============ TAB 4: TP ============
local tpTab = tabContents[4]

local tpBtn1 = Instance.new("TextButton")
tpBtn1.Size = UDim2.new(1, 0, 0, 30)
tpBtn1.BackgroundColor3 = THEME.Primary
tpBtn1.Text = "TP para Spawn"
tpBtn1.TextColor3 = THEME.Text
tpBtn1.TextSize = 12
tpBtn1.Font = Enum.Font.GothamBold
tpBtn1.BorderSizePixel = 0
tpBtn1.LayoutOrder = 1
tpBtn1.Parent = tpTab

local tpBtnCorner1 = Instance.new("UICorner")
tpBtnCorner1.CornerRadius = UDim.new(0, 6)
tpBtnCorner1.Parent = tpBtn1

tpBtn1.MouseButton1Click:Connect(function()
    local spawn = Workspace:FindFirstChild("Spawn") or Workspace:FindFirstChildOfClass("SpawnLocation")
    if spawn then
        humanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 3, 0)
    end
end)

local tpBtn2 = Instance.new("TextButton")
tpBtn2.Size = UDim2.new(1, 0, 0, 30)
tpBtn2.BackgroundColor3 = THEME.Primary
tpBtn2.Text = "TP para Inimigo Mais Próximo"
tpBtn2.TextColor3 = THEME.Text
tpBtn2.TextSize = 12
tpBtn2.Font = Enum.Font.GothamBold
tpBtn2.BorderSizePixel = 0
tpBtn2.LayoutOrder = 2
tpBtn2.Parent = tpTab

local tpBtnCorner2 = Instance.new("UICorner")
tpBtnCorner2.CornerRadius = UDim.new(0, 6)
tpBtnCorner2.Parent = tpBtn2

tpBtn2.MouseButton1Click:Connect(function()
    local closest = nil
    local closestDist = math.huge
    
    for _, enemy in ipairs(Players:GetPlayers()) do
        if enemy == player then continue end
        if not enemy.Character then continue end
        
        local enemyHRP = enemy.Character:FindFirstChild("HumanoidRootPart")
        if enemyHRP then
            local dist = (enemyHRP.Position - humanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closest = enemyHRP
                closestDist = dist
            end
        end
    end
    
    if closest then
        humanoidRootPart.CFrame = closest.CFrame + Vector3.new(5, 0, 0)
    end
end)

-- TP JUMP
local tpJumpBtn = Instance.new("TextButton")
tpJumpBtn.Size = UDim2.new(1, 0, 0, 30)
tpJumpBtn.BackgroundColor3 = THEME.Primary
tpJumpBtn.Text = "⬆️ TP Jump"
tpJumpBtn.TextColor3 = THEME.Text
tpJumpBtn.TextSize = 12
tpJumpBtn.Font = Enum.Font.GothamBold
tpJumpBtn.BorderSizePixel = 0
tpJumpBtn.LayoutOrder = 3
tpJumpBtn.Parent = tpTab

local tpJumpCorner = Instance.new("UICorner")
tpJumpCorner.CornerRadius = UDim.new(0, 6)
tpJumpCorner.Parent = tpJumpBtn

tpJumpBtn.MouseButton1Click:Connect(function()
    humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 50, 0)
end)

-- FLY MODE
local flyToggle = createToggle(tpTab, "✈️ Fly Mode", function(enabled)
    if enabled then
        local flying = false
        local speed = 50
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = humanoidRootPart
        
        local flyConnection
        flyConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then flyConnection:Disconnect() return end
            
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + (Camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - (Camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + Camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            bodyVelocity.Velocity = moveDirection.Unit * speed
        end)
        _G.FlyConnection = flyConnection
    else
        if _G.FlyConnection then
            _G.FlyConnection:Disconnect()
        end
        if humanoidRootPart:FindFirstChild("BodyVelocity") then
            humanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
        end
    end
end, 4)

-- ============ TAB 5: ARENA ============
local arenaTab = tabContents[5]

createToggle(arenaTab, "🏟️ Arena Sub (Seguidor)", function(enabled)
    if enabled then
        local targetEnemy = nil
        local distance = 5
        
        local arenaConnection
        arenaConnection = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then arenaConnection:Disconnect() return end
            
            if not targetEnemy or not targetEnemy.Character then
                for _, enemy in ipairs(Players:GetPlayers()) do
                    if enemy == player and enemy.Character then
                        targetEnemy = enemy
                        break
                    end
                end
            end
            
            if targetEnemy and targetEnemy.Character then
                local enemyHRP = targetEnemy.Character:FindFirstChild("HumanoidRootPart")
                if enemyHRP then
                    local targetPos = enemyHRP.Position + (enemyHRP.CFrame.LookVector * -distance) + Vector3.new(0, -3, 0)
                    humanoidRootPart.CFrame = CFrame.new(targetPos)
                end
            end
        end)
        _G.ArenaConnection = arenaConnection
    else
        if _G.ArenaConnection then
            _G.ArenaConnection:Disconnect()
        end
    end
end, 1)

-- ============ TAB 6: VISUALS ============
local visualsTab = tabContents[6]

createToggle(visualsTab, "👁️ Player ESP", function(enabled)
    if enabled then
        for _, enemy in ipairs(Players:GetPlayers()) do
            if enemy == player or not enemy.Character then continue end
            
            local humanoidRootPart = enemy.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local highlight = Instance.new("Highlight")
                highlight.Parent = enemy.Character
                highlight.FillColor = THEME.Accent
                highlight.OutlineColor = THEME.Primary
            end
        end
    else
        for _, enemy in ipairs(Players:GetPlayers()) do
            if enemy.Character then
                local highlight = enemy.Character:FindFirstChild("Highlight")
                if highlight then highlight:Destroy() end
            end
        end
    end
end, 1)

createToggle(visualsTab, "⭐ Inf Jump", function(enabled)
    if enabled then
        local infJumpConnection
        infJumpConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        _G.InfJumpConnection = infJumpConnection
    else
        if _G.InfJumpConnection then
            _G.InfJumpConnection:Disconnect()
        end
    end
end, 2)

-- ============ TAB 7: UTILS ============
local utilsTab = tabContents[7]

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(1, 0, 0, 30)
rejoinBtn.BackgroundColor3 = THEME.Primary
rejoinBtn.Text = "🔄 Rejoin"
rejoinBtn.TextColor3 = THEME.Text
rejoinBtn.TextSize = 12
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.BorderSizePixel = 0
rejoinBtn.LayoutOrder = 1
rejoinBtn.Parent = utilsTab

local rejoinCorner = Instance.new("UICorner")
rejoinCorner.CornerRadius = UDim.new(0, 6)
rejoinCorner.Parent = rejoinBtn

rejoinBtn.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

createToggle(utilsTab, "🎯 Chat Spammer", function(enabled)
    if enabled then
        local spamConnection
        spamConnection = RunService.Heartbeat:Connect(function()
            if not _G.TSBAdminLoaded then spamConnection:Disconnect() return end
            game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SendMessageRequest"):FireServer("test message", "All")
            task.wait(5)
        end)
        _G.SpamConnection = spamConnection
    else
        if _G.SpamConnection then
            _G.SpamConnection:Disconnect()
        end
    end
end, 2)

-- ============ TAB 8: TROLL ============
local trollTab = tabContents[8]

local flingBtn = Instance.new("TextButton")
flingBtn.Size = UDim2.new(1, 0, 0, 30)
flingBtn.BackgroundColor3 = THEME.Error
flingBtn.Text = "🌀 Fling (Selecione alvo no chat: ;fling Nome)"
flingBtn.TextColor3 = THEME.Text
flingBtn.TextSize = 10
flingBtn.Font = Enum.Font.GothamBold
flingBtn.BorderSizePixel = 0
flingBtn.LayoutOrder = 1
flingBtn.Parent = trollTab

local flingCorner = Instance.new("UICorner")
flingCorner.CornerRadius = UDim.new(0, 6)
flingCorner.Parent = flingBtn

local freezeBtn = Instance.new("TextButton")
freezeBtn.Size = UDim2.new(1, 0, 0, 30)
freezeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
freezeBtn.Text = "❄️ Congelar (;freeze Nome)"
freezeBtn.TextColor3 = THEME.Text
freezeBtn.TextSize = 10
freezeBtn.Font = Enum.Font.GothamBold
freezeBtn.BorderSizePixel = 0
freezeBtn.LayoutOrder = 2
freezeBtn.Parent = trollTab

local freezeCorner = Instance.new("UICorner")
freezeCorner.CornerRadius = UDim.new(0, 6)
freezeCorner.Parent = freezeBtn

local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(1, 0, 0, 30)
killBtn.BackgroundColor3 = THEME.Error
killBtn.Text = "☠️ Eliminar (;kill Nome)"
killBtn.TextColor3 = THEME.Text
killBtn.TextSize = 10
killBtn.Font = Enum.Font.GothamBold
killBtn.BorderSizePixel = 0
killBtn.LayoutOrder = 3
killBtn.Parent = trollTab

local killCorner = Instance.new("UICorner")
killCorner.CornerRadius = UDim.new(0, 6)
killCorner.Parent = killBtn

local kickBtn = Instance.new("TextButton")
kickBtn.Size = UDim2.new(1, 0, 0, 30)
kickBtn.BackgroundColor3 = THEME.Error
kickBtn.Text = "👞 Kickar (;kick Nome)"
kickBtn.TextColor3 = THEME.Text
kickBtn.TextSize = 10
kickBtn.Font = Enum.Font.GothamBold
kickBtn.BorderSizePixel = 0
kickBtn.LayoutOrder = 4
kickBtn.Parent = trollTab

local kickCorner = Instance.new("UICorner")
kickCorner.CornerRadius = UDim.new(0, 6)
kickCorner.Parent = kickBtn

-- ============ EVENTOS ============
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    _G.TSBAdminLoaded = false
    
    if _G.NoStunConnection then _G.NoStunConnection:Disconnect() end
    if _G.AntiRagConnection then _G.AntiRagConnection:Disconnect() end
    if _G.AutoBlockConnection then _G.AutoBlockConnection:Disconnect() end
    if _G.AutoPunchConnection then _G.AutoPunchConnection:Disconnect() end
    if _G.AutoAwakeConnection then _G.AutoAwakeConnection:Disconnect() end
    if _G.GodModeConnection then _G.GodModeConnection:Disconnect() end
    if _G.NoKBConnection then _G.NoKBConnection:Disconnect() end
    if _G.NoclipConnection then _G.NoclipConnection:Disconnect() end
end)

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    mainWindow.Size = minimized and UDim2.new(0, 300, 0, 50) or UDim2.new(0, 700, 0, 600)
    header.Visible = true
    tabBar.Visible = not minimized
    for _, content in ipairs(tabContents) do
        content.Visible = not minimized and (content.Parent == mainWindow)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightBracket then
        mainWindow.Visible = not mainWindow.Visible
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
end)

print("✓ TSB Admin Tool carregado!")
print("Bem-vindo, " .. ADMIN_USER .. "!")