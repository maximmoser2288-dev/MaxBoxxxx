local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

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

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 35, 0, 35)
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

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 330)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
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
Title.Text = "King Legacy Tracker"
Title.Parent = MainFrame

local TabSeaBtn = Instance.new("TextButton")
TabSeaBtn.Size = UDim2.new(0.5, 0, 0, 25)
TabSeaBtn.Position = UDim2.new(0, 0, 0, 30)
TabSeaBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TabSeaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabSeaBtn.TextSize = 13
TabSeaBtn.Font = Enum.Font.SourceSansBold
TabSeaBtn.Text = "Морские Ивенты"
TabSeaBtn.Parent = MainFrame

local TabBossBtn = Instance.new("TextButton")
TabBossBtn.Size = UDim2.new(0.5, 0, 0, 25)
TabBossBtn.Position = UDim2.new(0.5, 0, 0, 30)
TabBossBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabBossBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
TabBossBtn.TextSize = 13
TabBossBtn.Font = Enum.Font.SourceSansBold
TabBossBtn.Text = "Боссы"
TabBossBtn.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -105)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 60)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollingFrame

local SKTimerLabel = Instance.new("TextLabel")
SKTimerLabel.Size = UDim2.new(1, 0, 0, 20)
SKTimerLabel.Position = UDim2.new(0, 0, 1, -45)
SKTimerLabel.BackgroundTransparency = 1
SKTimerLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
SKTimerLabel.TextSize = 13
SKTimerLabel.Font = Enum.Font.SourceSansBold
SKTimerLabel.Text = "До Sea King: Поиск мира..."
SKTimerLabel.Parent = MainFrame

local ServerTimeLabel = Instance.new("TextLabel")
ServerTimeLabel.Size = UDim2.new(1, 0, 0, 20)
ServerTimeLabel.Position = UDim2.new(0, 0, 1, -25)
ServerTimeLabel.BackgroundTransparency = 1
ServerTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
ServerTimeLabel.TextSize = 13
ServerTimeLabel.Font = Enum.Font.SourceSansBold
ServerTimeLabel.Text = "Время сервера: 00:00:00"
ServerTimeLabel.Parent = MainFrame

local seaEventsList = {"Sea King", "Ghost Ship", "Hydra", "Sea Beast", "Terrors", "Serpent"}
local worldBossesList = {"Dragon Lv5000", "Mother", "Elite Skeleton", "King Samurai I"}

local currentTab = "Sea"

TabSeaBtn.MouseButton1Click:Connect(function()
    currentTab = "Sea"
    TabSeaBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    TabSeaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBossBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabBossBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

TabBossBtn.MouseButton1Click:Connect(function()
    currentTab = "Boss"
    TabBossBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    TabBossBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabSeaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabSeaBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

local function formatTime(seconds)
    local hrs = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hrs, mins, secs)
end

-- Переменная для хранения найденной таблички (чтобы не лагало)
local cachedPhysicalTimer = nil

local function getPhysicalTimer()
    -- Если мы уже нашли табличку и она существует, просто берем её текст
    if cachedPhysicalTimer and cachedPhysicalTimer.Parent then
        return cachedPhysicalTimer.Text
    end

    -- Если не нашли, ищем по всему Workspace (сработает один раз, когда таймер появится)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("TextLabel") then
            -- Проверяем, чтобы это не был кусок меню самого игрока
            if not obj:IsDescendantOf(CoreGui) and not obj:IsDescendantOf(player:WaitForChild("PlayerGui")) then
                local txt = obj.Text
                -- Ищем формат времени "00:00:00" или "00:00"
                if txt:match("^%d%d:%d%d:%d%d$") or txt:match("^%d%d:%d%d$") then
                    cachedPhysicalTimer = obj -- Запоминаем объект!
                    return txt
                end
            end
        end
    end
    
    return "Скрыт/Не заспавнен"
end

local function updateDisplay()
    if not MainFrame.Visible then return end
    
    local serverSeconds = Workspace.DistributedGameTime
    ServerTimeLabel.Text = "Время сервера: " .. formatTime(serverSeconds)
    
    -- Обновляем текст с 3D таблички
    SKTimerLabel.Text = "До Sea King: " .. getPhysicalTimer()

    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local activeList = (currentTab == "Sea") and seaEventsList or worldBossesList

    for _, nameItem in ipairs(activeList) do
        local foundObj = nil
        local realNameFound = nameItem
        local searchKeyword = nameItem:lower():gsub("%s+", "")
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if (obj:IsA("Model") or obj:IsA("Folder")) and not Players:GetPlayerFromCharacter(obj) then
                local objNameLower = obj.Name:lower()
                local objNameNoSpace = objNameLower:gsub("%s+", "")
                
                if objNameNoSpace:find(searchKeyword) or objNameLower:find(nameItem:lower()) then
                    local primaryPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                    if primaryPart then
                        foundObj = primaryPart
                        realNameFound = obj.Name
                        break
                    end
                end
            end
        end

        local rowFrame = Instance.new("Frame")
        rowFrame.Size = UDim2.new(1, 0, 0, 30)
        rowFrame.BackgroundTransparency = 1
        rowFrame.Parent = ScrollingFrame

        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(0.65, 0, 1, 0)
        statusLabel.BackgroundTransparency = 1
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.TextSize = 12
        statusLabel.Font = Enum.Font.SourceSansBold
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        if foundObj then
            statusLabel.Text = "🟢 " .. realNameFound
        else
            statusLabel.Text = "🔴 " .. nameItem
        end
        statusLabel.Parent = rowFrame

        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(0.3, 0, 1, 0)
        tpBtn.Position = UDim2.new(0.7, 0, 0, 0)
        tpBtn.TextSize = 12
        tpBtn.Font = Enum.Font.SourceSansBold
        tpBtn.Parent = rowFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = tpBtn

        if foundObj then
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.Text = "TP"
            tpBtn.MouseButton1Click:Connect(function()
                tpTo(foundObj.CFrame)
            end)
        else
            tpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            tpBtn.TextColor3 = Color3.fromRGB(130, 130, 130)
            tpBtn.Text = "—"
        end
    end
end

task.spawn(function()
    while ScreenGui.Parent do
        pcall(updateDisplay)
        task.wait(1)
    end
end)
