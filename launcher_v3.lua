-- TSB Admin Tool - Launcher SIMPLES v3.0
-- DEBUG: Mostra tudo que acontece

print("[TSB] Iniciando Launcher...")

if _G.TSBLauncherLoaded then
    warn("[TSB] Launcher já carregado!")
    return
end
_G.TSBLauncherLoaded = true

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
print("[TSB] Jogador: " .. player.Name)

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

print("[TSB] Criando UI...")

-- ============ UI LAUNCHER ============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TSBLauncher"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 600)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
mainFrame.BackgroundColor3 = THEME.Dark
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Parent = screenGui

local stroke = Instance.new("UIStroke")
stroke.Color = THEME.Accent
stroke.Thickness = 2
stroke.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- ============ HEADER ============
local header = Instance.new("Frame")
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

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 10)
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
body.Size = UDim2.new(1, -20, 1, -100)
body.Position = UDim2.new(0, 10, 0, 70)
body.BackgroundTransparency = 1
body.Parent = mainFrame

local bodyScroll = Instance.new("UIListLayout")
bodyScroll.Padding = UDim.new(0, 10)
bodyScroll.SortOrder = Enum.SortOrder.LayoutOrder
bodyScroll.Parent = body

-- ============ WELCOME ============
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, 0, 0, 40)
welcomeLabel.BackgroundColor3 = THEME.Primary
welcomeLabel.TextColor3 = THEME.Text
welcomeLabel.Text = "Bem-vindo, " .. player.Name .. "!"
welcomeLabel.TextSize = 14
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.BorderSizePixel = 0
welcomeLabel.LayoutOrder = 1
welcomeLabel.Parent = body

local welcomeCorner = Instance.new("UICorner")
welcomeCorner.CornerRadius = UDim.new(0, 8)
welcomeCorner.Parent = welcomeLabel

-- ============ ADMIN KEY INPUT ============
local adminKeyLabel = Instance.new("TextLabel")
adminKeyLabel.Size = UDim2.new(1, 0, 0, 20)
adminKeyLabel.BackgroundTransparency = 1
adminKeyLabel.Text = "Admin Key:"
adminKeyLabel.TextColor3 = THEME.Accent
adminKeyLabel.TextSize = 12
adminKeyLabel.Font = Enum.Font.GothamBold
adminKeyLabel.TextXAlignment = Enum.TextXAlignment.Left
adminKeyLabel.LayoutOrder = 2
adminKeyLabel.Parent = body

local adminKeyInput = Instance.new("TextBox")
adminKeyInput.Size = UDim2.new(1, 0, 0, 35)
adminKeyInput.BackgroundColor3 = THEME.Secondary
adminKeyInput.TextColor3 = THEME.Text
adminKeyInput.PlaceholderText = "TheEminenceInShadowIsBestAnime"
adminKeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
adminKeyInput.TextSize = 11
adminKeyInput.Font = Enum.Font.Gotham
adminKeyInput.BorderSizePixel = 0
adminKeyInput.LayoutOrder = 3
adminKeyInput.Parent = body

local adminKeyCorner = Instance.new("UICorner")
adminKeyCorner.CornerRadius = UDim.new(0, 6)
adminKeyCorner.Parent = adminKeyInput

-- ============ FREE KEY INPUT ============
local freeKeyLabel = Instance.new("TextLabel")
freeKeyLabel.Size = UDim2.new(1, 0, 0, 20)
freeKeyLabel.BackgroundTransparency = 1
freeKeyLabel.Text = "Free Key:"
freeKeyLabel.TextColor3 = THEME.Accent
freeKeyLabel.TextSize = 12
freeKeyLabel.Font = Enum.Font.GothamBold
freeKeyLabel.TextXAlignment = Enum.TextXAlignment.Left
freeKeyLabel.LayoutOrder = 4
freeKeyLabel.Parent = body

local freeKeyInput = Instance.new("TextBox")
freeKeyInput.Size = UDim2.new(1, 0, 0, 35)
freeKeyInput.BackgroundColor3 = THEME.Secondary
freeKeyInput.TextColor3 = THEME.Text
freeKeyInput.PlaceholderText = "Alpha-Beta-Delta-22"
freeKeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
freeKeyInput.TextSize = 11
freeKeyInput.Font = Enum.Font.Gotham
freeKeyInput.BorderSizePixel = 0
freeKeyInput.LayoutOrder = 5
freeKeyInput.Parent = body

local freeKeyCorner = Instance.new("UICorner")
freeKeyCorner.CornerRadius = UDim.new(0, 6)
freeKeyCorner.Parent = freeKeyInput

-- ============ BOTÕES DE SCRIPTS ============
local adminBtn = Instance.new("TextButton")
adminBtn.Size = UDim2.new(1, 0, 0, 45)
adminBtn.BackgroundColor3 = THEME.Primary
adminBtn.TextColor3 = THEME.Text
adminBtn.Text = "🔥 ADMIN TOOL\nCarregar com Admin Key"
adminBtn.TextSize = 12
adminBtn.Font = Enum.Font.GothamBold
adminBtn.BorderSizePixel = 0
adminBtn.TextWrapped = true
adminBtn.LayoutOrder = 6
adminBtn.Parent = body

local adminBtnCorner = Instance.new("UICorner")
adminBtnCorner.CornerRadius = UDim.new(0, 8)
adminBtnCorner.Parent = adminBtn

adminBtn.MouseButton1Click:Connect(function()
    print("[TSB] Botão Admin clicado")
    local key = adminKeyInput.Text
    print("[TSB] KEY inserida: " .. key)
    
    if key == "TheEminenceInShadowIsBestAnime" then
        print("[TSB] KEY correta! Carregando script admin...")
        adminBtn.Text = "✓ KEY VALIDADA!"
        adminBtn.BackgroundColor3 = THEME.Success
        wait(1)
        mainFrame.Visible = false
        wait(0.5)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guilhermelourencoramos051-ship-it/shadowsama/main/main_admin.lua"))()
        end)
        
        if not success then
            print("[TSB] ERRO ao carregar admin: " .. tostring(err))
            adminBtn.Text = "❌ ERRO AO CARREGAR"
            mainFrame.Visible = true
        end
    else
        print("[TSB] KEY INCORRETA!")
        adminBtn.BackgroundColor3 = THEME.Error
        adminBtn.Text = "❌ KEY INVÁLIDA!"
        wait(2)
        adminBtn.BackgroundColor3 = THEME.Primary
        adminBtn.Text = "🔥 ADMIN TOOL\nCarregar com Admin Key"
    end
end)

local freeBtn = Instance.new("TextButton")
freeBtn.Size = UDim2.new(1, 0, 0, 45)
freeBtn.BackgroundColor3 = THEME.Primary
freeBtn.TextColor3 = THEME.Text
freeBtn.Text = "💨 FREE SCRIPT\nCarregar com Free Key"
freeBtn.TextSize = 12
freeBtn.Font = Enum.Font.GothamBold
freeBtn.BorderSizePixel = 0
freeBtn.TextWrapped = true
freeBtn.LayoutOrder = 7
freeBtn.Parent = body

local freeBtnCorner = Instance.new("UICorner")
freeBtnCorner.CornerRadius = UDim.new(0, 8)
freeBtnCorner.Parent = freeBtn

freeBtn.MouseButton1Click:Connect(function()
    print("[TSB] Botão Free clicado")
    local key = freeKeyInput.Text
    print("[TSB] KEY inserida: " .. key)
    
    if key == "Alpha-Beta-Delta-22" then
        print("[TSB] KEY correta! Carregando script free...")
        freeBtn.Text = "✓ KEY VALIDADA!"
        freeBtn.BackgroundColor3 = THEME.Success
        wait(1)
        mainFrame.Visible = false
        wait(0.5)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guilhermelourencoramos051-ship-it/shadowsama/main/main_free.lua"))()
        end)
        
        if not success then
            print("[TSB] ERRO ao carregar free: " .. tostring(err))
            freeBtn.Text = "❌ ERRO AO CARREGAR"
            mainFrame.Visible = true
        end
    else
        print("[TSB] KEY INCORRETA!")
        freeBtn.BackgroundColor3 = THEME.Error
        freeBtn.Text = "❌ KEY INVÁLIDA!"
        wait(2)
        freeBtn.BackgroundColor3 = THEME.Primary
        freeBtn.Text = "💨 FREE SCRIPT\nCarregar com Free Key"
    end
end)

-- ============ DISCORD ============
local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, 0, 0, 35)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.TextColor3 = THEME.Text
discordBtn.Text = "🔗 Discord | https://discord.gg/JtE2rx2eGx"
discordBtn.TextSize = 11
discordBtn.Font = Enum.Font.GothamBold
discordBtn.BorderSizePixel = 0
discordBtn.LayoutOrder = 999
discordBtn.Parent = body

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 6)
discordCorner.Parent = discordBtn

discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/JtE2rx2eGx")
    discordBtn.Text = "✓ LINK COPIADO!"
    wait(2)
    discordBtn.Text = "🔗 Discord | https://discord.gg/JtE2rx2eGx"
end)

-- ============ EVENTOS ============
closeBtn.MouseButton1Click:Connect(function()
    print("[TSB] Fechando launcher")
    screenGui:Destroy()
    _G.TSBLauncherLoaded = false
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightBracket then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("[TSB] Launcher criado com sucesso!")
print("[TSB] Pressione ] para abrir/fechar")
print("[TSB] Admin Key: TheEminenceInShadowIsBestAnime")
print("[TSB] Free Key: Alpha-Beta-Delta-22")