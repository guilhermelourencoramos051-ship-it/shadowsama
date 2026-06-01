-- TSB ADMIN TOOL - VERSÃO ADMIN v3.0 (SIMPLIFICADO)
-- Com sistema de KEY de admin
-- PlaceID: 10449761463

print("[TSB ADMIN] Iniciando...")

if _G.TSBAdminLoaded then
    warn("[TSB ADMIN] Script admin já está carregado!")
    return
end
_G.TSBAdminLoaded = true

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

print("[TSB ADMIN] Usuário: " .. player.Name)

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

print("[TSB ADMIN] Criando UI...")

-- ============ CRIAR UI ============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TSBAdminUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

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
title.Text = "👑 TSB ADMIN - " .. player.Name
title.TextColor3 = THEME.Accent
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

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

-- ============ BODY ============
local body = Instance.new("Frame")
body.Size = UDim2.new(1, -20, 1, -70)
body.Position = UDim2.new(0, 10, 0, 60)
body.BackgroundTransparency = 1
body.Parent = mainWindow

local bodyScroll = Instance.new("UIListLayout")
bodyScroll.Padding = UDim.new(0, 10)
bodyScroll.SortOrder = Enum.SortOrder.LayoutOrder
bodyScroll.Parent = body

-- ============ FUNÇÕES ============
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

-- ============ FUNCIONALIDADES ============
createToggle(body, "⚡ No Stun", function(enabled)
    if enabled then
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then conn:Disconnect() return end
            if character and humanoidRootPart then
                for _, obj in ipairs(character:GetChildren()) do
                    if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                        obj:Destroy()
                    end
                end
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end)
        _G.NoStunConn = conn
    else
        if _G.NoStunConn then _G.NoStunConn:Disconnect() end
    end
end, 1)

createToggle(body, "👻 Anti-Ragdoll", function(enabled)
    if enabled then
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then conn:Disconnect() return end
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end)
        _G.AntiRagConn = conn
    else
        if _G.AntiRagConn then _G.AntiRagConn:Disconnect() end
    end
end, 2)

createToggle(body, "💚 God Mode", function(enabled)
    if enabled then
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not _G.TSBAdminLoaded then conn:Disconnect() return end
            humanoid.Health = humanoid.MaxHealth
        end)
        _G.GodModeConn = conn
    else
        if _G.GodModeConn then _G.GodModeConn:Disconnect() end
    end
end, 3)

createToggle(body, "🧲 Noclip", function(enabled)
    if enabled then
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then conn:Disconnect() return end
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
        _G.NoclipConn = conn
    else
        if _G.NoclipConn then _G.NoclipConn:Disconnect() end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end, 4)

createToggle(body, "✈️ Fly Mode", function(enabled)
    if enabled then
        local speed = 50
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = humanoidRootPart
        
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not _G.TSBAdminLoaded then conn:Disconnect() return end
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
        _G.FlyConn = conn
    else
        if _G.FlyConn then _G.FlyConn:Disconnect() end
        if humanoidRootPart:FindFirstChild("BodyVelocity") then
            humanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
        end
    end
end, 5)

createToggle(body, "⭐ Inf Jump", function(enabled)
    if enabled then
        local conn
        conn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        _G.InfJumpConn = conn
    else
        if _G.InfJumpConn then _G.InfJumpConn:Disconnect() end
    end
end, 6)

-- ============ EVENTOS ============
closeBtn.MouseButton1Click:Connect(function()
    print("[TSB ADMIN] Fechando")
    screenGui:Destroy()
    _G.TSBAdminLoaded = false
end)

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    mainWindow.Size = minimized and UDim2.new(0, 300, 0, 50) or UDim2.new(0, 700, 0, 600)
    header.Visible = true
    body.Visible = not minimized
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

print("[TSB ADMIN] Script carregado com sucesso!")
print("[TSB ADMIN] Pressione ] para abrir/fechar")