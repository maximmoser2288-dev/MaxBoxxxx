local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

local function tpTo(targetCFrame)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 5, 0)
    end
end

if CoreGui:FindFirstChild("KingLegacyTrackerGUI") then
    CoreGui.KingLegacyTrackerGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingLegacyTrackerGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Звук оповещения
local notifySound = Instance.new("Sound")
notifySound.SoundId = "rbxassetid://459768054"
notifySound.Volume = 1.5
notifySound.Parent = SoundService

-- Уведомление
local NotifyFrame = Instance.new("Frame")
NotifyFrame.Size = UDim2.new(0, 300, 0, 40)
NotifyFrame.Position = UDim2.new(0.5, -150, 0.05, 0)
NotifyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NotifyFrame.BorderColor3 = Color3.fromRGB(0, 255, 127)
NotifyFrame.BorderSizePixel = 2
NotifyFrame.Visible = false
NotifyFrame.Parent = ScreenGui

local NotifyCorner = Instance.new("UICorner")
NotifyCorner.CornerRadius = UDim.new(0, 8)
NotifyCorner.Parent = NotifyFrame

local NotifyLabel = Instance.new("TextLabel")
NotifyLabel.Size = UDim2.new(1, 0, 1, 0)
NotifyLabel.BackgroundTransparency = 1
NotifyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifyLabel.TextSize = 14
NotifyLabel.Font = Enum.Font.SourceSansBold
NotifyLabel.Text = ""
NotifyLabel.Parent = NotifyFrame

local function showNotification(text)
    NotifyLabel.Text = text
    NotifyFrame.Visible = true
    pcall(function() notifySound:Play() end)
    task.delay(4, function()
        if NotifyLabel.Text == text then
            NotifyFrame.Visible = false
        end
    end)
end

-- Кнопка Menu
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 35)
ToggleBtn.Position = UDim2.new(0.01, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "Menu"
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 270, 0, 360)
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Text = "King Legacy Tracker & Compass"
Title.Parent = MainFrame

-- Переключатель Компаса
local compassEnabled = true
local CompassToggleBtn = Instance.new("TextButton")
CompassToggleBtn.Size = UDim2.new(1, -10, 0, 22)
CompassToggleBtn.Position = UDim2.new(0, 5, 0, 33)
CompassToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
CompassToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CompassToggleBtn.TextSize = 12
CompassToggleBtn.Font = Enum.Font.SourceSansBold
CompassToggleBtn.Text = "🧭 Компас: Включен"
CompassToggleBtn.Parent = MainFrame

local CompassCorner = Instance.new("UICorner")
CompassCorner.CornerRadius = UDim.new(0, 4)
CompassCorner.Parent = CompassToggleBtn

CompassToggleBtn.MouseButton1Click:Connect(function()
    compassEnabled = not compassEnabled
    if compassEnabled then
        CompassToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
        CompassToggleBtn.Text = "🧭 Компас: Включен"
    else
        CompassToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
        CompassToggleBtn.Text = "🧭 Компас: Выключен"
    end
end)

-- Табы
local TabSeaBtn = Instance.new("TextButton")
TabSeaBtn.Size = UDim2.new(0.5, -5, 0, 25)
TabSeaBtn.Position = UDim2.new(0, 5, 0, 60)
TabSeaBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TabSeaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabSeaBtn.TextSize = 13
TabSeaBtn.Font = Enum.Font.SourceSansBold
TabSeaBtn.Text = "Морские Ивенты"
TabSeaBtn.Parent = MainFrame

local TabBossBtn = Instance.new("TextButton")
TabBossBtn.Size = UDim2.new(0.5, -5, 0, 25)
TabBossBtn.Position = UDim2.new(0.5, 0, 0, 60)
TabBossBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabBossBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
TabBossBtn.TextSize = 13
TabBossBtn.Font = Enum.Font.SourceSansBold
TabBossBtn.Text = "Боссы"
TabBossBtn.Parent = MainFrame

-- Список с рабочей прокруткой
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -155)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 90)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollingFrame

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

local SKTimerLabel = Instance.new("TextLabel")
SKTimerLabel.Size = UDim2.new(1, -10, 0, 20)
SKTimerLabel.Position = UDim2.new(0, 5, 1, -45)
SKTimerLabel.BackgroundTransparency = 1
SKTimerLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
SKTimerLabel.TextSize = 13
SKTimerLabel.Font = Enum.Font.SourceSansBold
SKTimerLabel.Text = "До Sea King: Поиск..."
SKTimerLabel.Parent = MainFrame

local ServerTimeLabel = Instance.new("TextLabel")
ServerTimeLabel.Size = UDim2.new(1, -10, 0, 20)
ServerTimeLabel.Position = UDim2.new(0, 5, 1, -25)
ServerTimeLabel.BackgroundTransparency = 1
ServerTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
ServerTimeLabel.TextSize = 13
ServerTimeLabel.Font = Enum.Font.SourceSansBold
ServerTimeLabel.Text = "Время сервера: 00:00:00"
ServerTimeLabel.Parent = MainFrame

local seaEventsList = {"Sea King", "Ghost Ship", "Hydra", "Sea Beast", "Terrors", "Serpent", "Kraken"}
local worldBossesList = {"Dragon Lv5000", "Mother", "Elite Skeleton", "King Samurai I"}

local blacklist = {"codex", "forger", "npc", "quest", "merchant", "dialogue", "shop"}

local currentTab = "Sea"
local spawnedTracker = {}
local activeESP = {}
local rowElements = {}

local function createRows(list)
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    rowElements = {}

    for _, nameItem in ipairs(list) do
        local rowFrame = Instance.new("Frame")
        rowFrame.Size = UDim2.new(1, 0, 0, 30)
        rowFrame.BackgroundTransparency = 1
        rowFrame.Parent = ScrollingFrame

        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(0.55, 0, 1, 0)
        statusLabel.BackgroundTransparency = 1
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.TextSize = 11
        statusLabel.Font = Enum.Font.SourceSansBold
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        statusLabel.Text = "🔴 " .. nameItem
        statusLabel.Parent = rowFrame

        local espBtn = Instance.new("TextButton")
        espBtn.Size = UDim2.new(0.2, 0, 1, 0)
        espBtn.Position = UDim2.new(0.56, 0, 0, 0)
        espBtn.TextSize = 11
        espBtn.Font = Enum.Font.SourceSansBold
        espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        espBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        espBtn.Text = "ESP"
        espBtn.Parent = rowFrame

        local espCorner = Instance.new("UICorner")
        espCorner.CornerRadius = UDim.new(0, 4)
        espCorner.Parent = espBtn

        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(0.22, 0, 1, 0)
        tpBtn.Position = UDim2.new(0.77, 0, 0, 0)
        tpBtn.TextSize = 12
        tpBtn.Font = Enum.Font.SourceSansBold
        tpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tpBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
        tpBtn.Text = "—"
        tpBtn.Parent = rowFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = tpBtn

        rowElements[nameItem] = {
            frame = rowFrame,
            status = statusLabel,
            esp = espBtn,
            tp = tpBtn
        }

        espBtn.MouseButton1Click:Connect(function()
            activeESP[nameItem] = not activeESP[nameItem]
            if activeESP[nameItem] then
                espBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
                espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                espBtn.Text = "ESP ON"
            else
                espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                espBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                espBtn.Text = "ESP"
            end
        end)
    end
    
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

createRows(seaEventsList)

TabSeaBtn.MouseButton1Click:Connect(function()
    if currentTab == "Sea" then return end
    currentTab = "Sea"
    TabSeaBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    TabSeaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBossBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabBossBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    createRows(seaEventsList)
end)

TabBossBtn.MouseButton1Click:Connect(function()
    if currentTab == "Boss" then return end
    currentTab = "Boss"
    TabBossBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    TabBossBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabSeaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabSeaBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    createRows(worldBossesList)
end)

local function formatTime(seconds)
    local hrs = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hrs, mins, secs)
end

-- Оптимизированное кэширование таймера без лагов
local cachedTimerLabel = nil

local function getPhysicalTimer()
    if cachedTimerLabel and cachedTimerLabel.Parent then
        local t = cachedTimerLabel.Text
        if t and (t:match("^%d%d:%d%d:%d%d$") or t:match("^%d%d:%d%d$")) then
            return t
        end
    end

    -- Ищем только в PlayerGui (быстро и без нагрузки на FPS)
    local pGui = player:FindFirstChild("PlayerGui")
    if pGui then
        for _, gui in ipairs(pGui:GetDescendants()) do
            if gui:IsA("TextLabel") or gui:IsA("TextButton") then
                local txt = gui.Text
                if txt and (txt:match("^%d%d:%d%d:%d%d$") or txt:match("^%d%d:%d%d$")) then
                    cachedTimerLabel = gui
                    return txt
                end
            end
        end
    end

    -- Если не нашли в UI, один раз ищем в Workspace
    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local txt = obj.Text
            if txt and (txt:match("^%d%d:%d%d:%d%d$") or txt:match("^%d%d:%d%d$")) then
                cachedTimerLabel = obj
                return txt
            end
        end
    end

    return "Скрыт/Не заспавнен"
end

local function setESP(model, enable, distText)
    if not model then return end
    local highlight = model:FindFirstChild("KL_ESP_Highlight")
    local billboard = model:FindFirstChild("KL_Compass_Billboard")

    if enable then
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "KL_ESP_Highlight"
            highlight.FillColor = Color3.fromRGB(255, 0, 80)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = model
        end

        if compassEnabled then
            if not billboard then
                billboard = Instance.new("BillboardGui")
                billboard.Name = "KL_Compass_Billboard"
                billboard.Size = UDim2.new(0, 150, 0, 30)
                billboard.AlwaysOnTop = true
                billboard.StudsOffset = Vector3.new(0, 10, 0)

                local label = Instance.new("TextLabel")
                label.Name = "TextLabel"
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(0, 255, 127)
                label.TextSize = 14
                label.Font = Enum.Font.SourceSansBold
                label.Parent = billboard

                local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
                if primaryPart then
                    billboard.Adornee = primaryPart
                    billboard.Parent = model
                end
            end
            if billboard and billboard:FindFirstChild("TextLabel") then
                billboard.TextLabel.Text = model.Name .. "\n[" .. distText .. "]"
            end
        elseif billboard then
            billboard:Destroy()
        end
    else
        if highlight then highlight:Destroy() end
        if billboard then billboard:Destroy() end
    end
end

local function isBlacklisted(name)
    local lower = name:lower()
    for _, word in ipairs(blacklist) do
        if lower:find(word) then return true end
    end
    return false
end

local function updateDisplay()
    local serverSeconds = Workspace.DistributedGameTime
    ServerTimeLabel.Text = "Время сервера: " .. formatTime(serverSeconds)
    SKTimerLabel.Text = "До Sea King: " .. getPhysicalTimer()

    local allTargets = {}
    for _, item in ipairs(seaEventsList) do table.insert(allTargets, item) end
    for _, item in ipairs(worldBossesList) do table.insert(allTargets, item) end

    local foundModels = {}
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    for _, obj in ipairs(Workspace:GetChildren()) do
        if (obj:IsA("Model") or obj:IsA("Folder")) and not Players:GetPlayerFromCharacter(obj) then
            local objName = obj.Name
            
            if not isBlacklisted(objName) then
                local objNameLower = objName:lower():gsub("%s+", "")
                
                for _, nameItem in ipairs(allTargets) do
                    local searchKeyword = nameItem:lower():gsub("%s+", "")
                    if objNameLower:find(searchKeyword) then
                        local primaryPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                        if primaryPart then
                            local distStr = "—"
                            if hrp then
                                local dist = math.floor((hrp.Position - primaryPart.Position).Magnitude)
                                distStr = dist .. "m"
                            end
                            foundModels[nameItem] = {model = obj, part = primaryPart, name = objName, distStr = distStr}
                            break
                        end
                    end
                end
            end
        end
    end

    for nameItem, data in pairs(foundModels) do
        if not spawnedTracker[nameItem] then
            spawnedTracker[nameItem] = true
            showNotification("🚨 Заспавнился: " .. data.name .. "!")
        end
        if activeESP[nameItem] then
            setESP(data.model, true, data.distStr)
        end
    end

    for nameItem, _ in pairs(spawnedTracker) do
        if not foundModels[nameItem] then
            spawnedTracker[nameItem] = nil
        end
    end

    local activeList = (currentTab == "Sea") and seaEventsList or worldBossesList

    for _, nameItem in ipairs(activeList) do
        local elements = rowElements[nameItem]
        if elements then
            local foundData = foundModels[nameItem]
            if foundData then
                local dispText = "🟢 " .. foundData.name
                if compassEnabled and foundData.distStr ~= "—" then
                    dispText = "🟢 " .. foundData.name .. " [" .. foundData.distStr .. "]"
                end
                elements.status.Text = dispText
                elements.tp.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
                elements.tp.TextColor3 = Color3.fromRGB(255, 255, 255)
                elements.tp.Text = "TP"
                
                if elements.tpConnection then elements.tpConnection:Disconnect() end
                elements.tpConnection = elements.tp.MouseButton1Click:Connect(function()
                    tpTo(foundData.part.CFrame)
                end)
            else
                elements.status.Text = "🔴 " .. nameItem
                elements.tp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                elements.tp.TextColor3 = Color3.fromRGB(100, 100, 100)
                elements.tp.Text = "—"
                if elements.tpConnection then elements.tpConnection:Disconnect() end
            end
        end
    end
end

task.spawn(function()
    while ScreenGui.Parent do
        pcall(updateDisplay)
        task.wait(1.5)
    end
end)
