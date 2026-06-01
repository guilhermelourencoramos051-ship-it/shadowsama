-- TSB Admin Tool - Launcher Principal v2.0
-- Múltiplos Scripts com Seleção Dinâmica
-- Versões: Free (com Key) e Admin (LOS67ZITOSDIZEN67)
-- PlaceID: 10449761463

if _G.TSBLauncherLoaded then
    warn("TSB Launcher já está carregado!")
    return
end
_G.TSBLauncherLoaded = true

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerName = player.Name
local adminUser = "LOS67ZITOSDIZEN67"
local isAdmin = (playerName == adminUser)

-- ============ CONFIGURAÇÃO ============
local PLACEIDS = {10449761463} -- Apenas TSB
local CURRENT_PLACEID = game.PlaceId
local KEYS_PASTEBIN_URL = "https://pastebin.com/raw/YOURKEY"
local DISCORD_LINK = "https://discord.gg/JtE2rx2eGx"

-- Gera key semanal automaticamente
local function generateWeeklyKey()
    local keywords = {
        "Alpha", "Beta", "Delta", "Epsilon", "Gamma",
        "ShadowGarden", "CidKagenou", "ShadowBroker", "Ninja", "Cipher"
    }
    
    local date = os.date("*t")
    local weekNumber = math.floor((date.yday - date.wday) / 7) + 1
    local year = date.year
    
    math.randomseed(year * 1000 + weekNumber)
    local randomKeywords = {}
    for i = 1, 3 do
        table.insert(randomKeywords, keywords[math.random(1, #keywords)])
    end
    
    return table.concat(randomKeywords, "-") .. "-" .. weekNumber
end

-- Carrega key remota (com validação)
local function getRemoteKey()
    local success, response = pcall(function()
        return game:HttpGet(KEYS_PASTEBIN_URL)
    end)
    if success then
        return response:match("%S+") -- Remove espaços
    end
    return generateWeeklyKey() -- Fallback
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

-- ============ UI LAUNCHER ============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TSBLauncher"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 550, 0, 700)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -350)
mainFrame.BackgroundColor3 = THEME.Dark
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Parent = screenGui

-- Stroke (Borda Magenta)
local stroke = Instance.new("UIStroke")
stroke.Color = THEME.Accent
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- ============ HEADER ============
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = THEME.Secondary
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 1, 0)
title.BackgroundTransparency = 1
title.Text = "⚔️ TSB ADMIN LAUNCHER"
title.TextColor3 = THEME.Accent
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = header

-- Minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
minimizeBtn.Position = UDim2.new(1, -85, 0, 10)
minimizeBtn.BackgroundColor3 = THEME.Primary
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = THEME.Text
minimizeBtn.TextSize = 24
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = header

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

-- Fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.BackgroundColor3 = THEME.Error
closeBtn.Text = "✕"
closeBtn.TextColor3 = THEME.Text
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- ============ BODY ============
local body = Instance.new("Frame")
body.Name = "Body"
body.Size = UDim2.new(1, -20, 1, -90)
body.Position = UDim2.new(0, 10, 0, 70)
body.BackgroundTransparency = 1
body.Parent = mainFrame

local bodyScroll = Instance.new("UIListLayout")
bodyScroll.Padding = UDim.new(0, 10)
bodyScroll.FillDirection = Enum.FillDirection.Vertical
bodyScroll.SortOrder = Enum.SortOrder.LayoutOrder
bodyScroll.Parent = body

-- ============ AUTENTICAÇÃO ============
if isAdmin then
    local adminLabel = Instance.new("TextLabel")
    adminLabel.Size = UDim2.new(1, 0, 0, 35)
    adminLabel.BackgroundColor3 = THEME.Primary
    adminLabel.TextColor3 = THEME.Text
    adminLabel.Text = "👑 ADMIN MODE - Bem-vindo " .. playerName
    adminLabel.TextSize = 13
    adminLabel.Font = Enum.Font.GothamBold
    adminLabel.BorderSizePixel = 0
    adminLabel.LayoutOrder = 1
    adminLabel.Parent = body
    
    local adminCorner = Instance.new("UICorner")
    adminCorner.CornerRadius = UDim.new(0, 8)
    adminCorner.Parent = adminLabel
else
    -- Key Input
    local keyInput = Instance.new("TextBox")
    keyInput.Size = UDim2.new(1, 0, 0, 40)
    keyInput.BackgroundColor3 = THEME.Secondary
    keyInput.TextColor3 = THEME.Text
    keyInput.PlaceholderText = "Cole sua KEY aqui..."
    keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    keyInput.TextSize = 12
    keyInput.Font = Enum.Font.Gotham
    keyInput.BorderSizePixel = 0
    keyInput.ClearTextOnFocus = false
    keyInput.LayoutOrder = 1
    keyInput.Parent = body
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyInput
    
    _G.KeyInput = keyInput
end

-- ============ SCRIPTS DISPONÍVEIS ============
local scripts = {
    {
        name = "🔥 MAIN ADMIN TOOL",
        desc = "Ferramentas completas de admin",
        version = "admin",
        order = 2
    },
    {
        name = "💨 FREE PLAYER SCRIPT",
        desc = "Script para jogadores normais",
        version = "free",
        order = 3
    },
}

-- Renderizar botões
for _, scriptData in ipairs(scripts) do
    if isAdmin or scriptData.version == "free" then
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 50)
        container.BackgroundTransparency = 1
        container.LayoutOrder = scriptData.order
        container.Parent = body
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundColor3 = THEME.Primary
        btn.TextColor3 = THEME.Text
        btn.Text = scriptData.name .. "\n" .. scriptData.desc
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.TextWrapped = true
        btn.Parent = container
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            if not isAdmin and not _G.KeyInput.Text:match("%S") then
                _G.KeyInput.BackgroundColor3 = THEME.Error
                wait(0.5)
                _G.KeyInput.BackgroundColor3 = THEME.Secondary
                return
            end
            
            local remoteKey = getRemoteKey()
            if not isAdmin and _G.KeyInput.Text ~= remoteKey then
                _G.KeyInput.BackgroundColor3 = THEME.Error
                _G.KeyInput.Text = "KEY INVÁLIDA!"
                wait(2)
                _G.KeyInput.Text = ""
                _G.KeyInput.BackgroundColor3 = THEME.Secondary
                return
            end
            
            mainFrame.Visible = false
            wait(0.5)
            
            if scriptData.version == "admin" then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/guilhermelourencoramos051-ship-it/shadowsama/main/main_admin.lua"))()
            else
                loadstring(game:HttpGet("https://raw.githubusercontent.com/guilhermelourencoramos051-ship-it/shadowsama/main/main_free.lua"))()
            end
        end)
    end
end

-- ============ DISCORD BUTTON ============
local discordContainer = Instance.new("Frame")
discordContainer.Size = UDim2.new(1, 0, 0, 40)
discordContainer.BackgroundTransparency = 1
discordContainer.LayoutOrder = 999
discordContainer.Parent = body

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, 0, 1, 0)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.TextColor3 = THEME.Text
discordBtn.Text = "🔗 Discord | Copiar Link"
discordBtn.TextSize = 12
discordBtn.Font = Enum.Font.GothamBold
discordBtn.BorderSizePixel = 0
discordBtn.Parent = discordContainer

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 8)
discordCorner.Parent = discordBtn

discordBtn.MouseButton1Click:Connect(function()
    setclipboard(DISCORD_LINK)
    local originalText = discordBtn.Text
    discordBtn.Text = "✓ COPIADO!"
    discordBtn.BackgroundColor3 = THEME.Success
    task.wait(2)
    discordBtn.Text = originalText
    discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)

-- ============ EVENTOS ============
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    _G.TSBLauncherLoaded = false
end)

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    mainFrame.Size = minimized and UDim2.new(0, 300, 0, 60) or UDim2.new(0, 550, 0, 700)
    header.Visible = true
    body.Visible = not minimized
end)

-- Tecla ] para abrir/fechar
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightBracket then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("✓ TSB Launcher iniciado!")
print("Versão:", isAdmin and "ADMIN" or "FREE")
print("Tecla: ] para abrir/fechar")