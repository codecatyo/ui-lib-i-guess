-- Load the modified UI library
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/codecatyo/ui-lib-i-guess/refs/heads/main/main.lua", true))()

-- Table to store all settings
local Settings = {}

-- Notification function
local function ShowNotification(title, text, duration)
    duration = duration or 2
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration,
        })
    end)
end

-- Create main window
local MainWindow = Lib:CreateWindow("Example GUI")

-- ========== Basic Elements ==========
MainWindow:Section("Basic Elements")

-- Regular button
MainWindow:Button("Click Me!", function()
    ShowNotification("Example GUI", "Button clicked!", 1.5)
end)

-- Toggle switch
MainWindow:Toggle("Example Toggle", {
    location = Settings,
    flag = "ToggleFlag",
    default = false
}, function()
    local state = Settings["ToggleFlag"] and "ON" or "OFF"
    ShowNotification("Toggle", "State changed to: " .. state, 1.5)
end)

-- Slider
MainWindow:Slider("Volume", {
    location = Settings,
    flag = "Volume",
    min = 0,
    max = 100,
    default = 50,
    precise = false
}, function(value)
    ShowNotification("Volume", "Volume set to: " .. value .. "%", 1)
end)

-- ========== Advanced Elements ==========
MainWindow:Section("Advanced Elements")

-- Dropdown (regular list)
MainWindow:Dropdown("Select Option", {
    location = Settings,
    flag = "Dropdown",
    list = {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"},
    search = true
}, function()
    ShowNotification("Dropdown", "Selected: " .. tostring(Settings["Dropdown"]), 1.5)
end)

-- Dropdown (player list)
MainWindow:Dropdown("Select Player", {
    location = Settings,
    flag = "PlayerList",
    PlayerList = true,
    search = true
}, function()
    ShowNotification("Player Select", "Selected: " .. tostring(Settings["PlayerList"]), 1.5)
end)

-- Keybind
MainWindow:Bind("Action Keybind", {
    location = Settings,
    flag = "ActionKey",
    default = Enum.KeyCode.K
}, function()
    ShowNotification("Keybind", "Key pressed: " .. tostring(Settings["ActionKey"]), 1.5)
end)

-- Text input box
MainWindow:Box("Text Input", {
    location = Settings,
    flag = "Input",
    type = "text",
    hold = "Enter text here",
    default = "Default text"
}, function()
    ShowNotification("Input", "Text changed to: " .. tostring(Settings["Input"]), 1.5)
end)

-- Number input box
MainWindow:Box("Number Input", {
    location = Settings,
    flag = "Number",
    type = "number",
    hold = "Enter number",
    default = "100"
}, function()
    ShowNotification("Number", "Value changed to: " .. tostring(Settings["Number"]), 1.5)
end)

-- ========== Labels ==========
MainWindow:Section("Labels & Info")

-- Simple label
MainWindow:Label("This is a simple label")

-- Using String method
MainWindow:String("This is another label using :String()")

-- Dynamic label (shows current time)
local dynamicLabel = Instance.new("TextLabel")
dynamicLabel.Text = "Loading time..."
dynamicLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
dynamicLabel.Font = Enum.Font.GothamBold
dynamicLabel.TextSize = 12
dynamicLabel.BackgroundTransparency = 1
dynamicLabel.Size = UDim2.new(1, 0, 0, 25)

-- Add dynamic label to UI
task.wait(0.5)
for _, v in pairs(game.CoreGui:GetDescendants()) do
    if v.Name == "Holder" and v.Parent and v.Parent.Name == "ButtonHolder" then
        dynamicLabel.Parent = v
        dynamicLabel.LayoutOrder = 999
        break
    end
end

-- Update dynamic label every second
task.spawn(function()
    while task.wait(1) do
        local timeString = os.date("%H:%M:%S")
        dynamicLabel.Text = "Current Time: " .. timeString
    end
end)

-- ========== Search Feature ==========
MainWindow:Section("Search Feature")
MainWindow:Search(Color3.fromRGB(255, 255, 0))  -- Yellow highlight

-- ========== Feature Demo ==========
MainWindow:Section("Feature Demo")

-- Killaura demo
local killauraEnabled = false

MainWindow:Toggle("Demo Killaura", {
    location = Settings,
    flag = "DemoKillaura",
    default = false
}, function()
    killauraEnabled = Settings["DemoKillaura"]
    if killauraEnabled then
        ShowNotification("Killaura", "Killaura ENABLED", 1.5)
        -- Start attack loop
        task.spawn(function()
            local attackCount = 0
            while killauraEnabled do
                attackCount = attackCount + 1
                ShowNotification("Killaura", "Attacking... (" .. attackCount .. ")", 0.5)
                task.wait(0.1)
            end
        end)
    else
        ShowNotification("Killaura", "Killaura DISABLED", 1.5)
    end
end)

-- Range slider
MainWindow:Slider("Attack Range", {
    location = Settings,
    flag = "Range",
    min = 5,
    max = 30,
    default = 15,
    precise = true
}, function(value)
    ShowNotification("Range", "Attack range set to: " .. value .. " studs", 1)
end)

-- Speed slider
MainWindow:Slider("Attack Speed", {
    location = Settings,
    flag = "Speed",
    min = 0.05,
    max = 0.5,
    default = 0.1,
    precise = false
}, function(value)
    ShowNotification("Speed", "Attack speed set to: " .. value .. " seconds", 1)
end)

-- ========== Control Buttons ==========
MainWindow:Section("Controls")

-- Reset all settings button
MainWindow:Button("Reset All Settings", function()
    -- Reset Settings table
    Settings.ToggleFlag = false
    Settings.Volume = 50
    Settings.Dropdown = nil
    Settings.PlayerList = nil
    Settings.ActionKey = nil
    Settings.Input = nil
    Settings.Number = nil
    Settings.DemoKillaura = false
    Settings.Range = 15
    Settings.Speed = 0.1
    
    -- Update UI toggle states
    if MainWindow.SetToggleState then
        MainWindow:SetToggleState("ToggleFlag", false)
        MainWindow:SetToggleState("DemoKillaura", false)
    end
    
    ShowNotification("Settings", "All settings have been reset!", 2)
end)

-- Show all settings button
MainWindow:Button("Show All Settings", function()
    local settingsText = ""
    for key, value in pairs(Settings) do
        settingsText = settingsText .. key .. ": " .. tostring(value) .. "\n"
    end
    ShowNotification("Current Settings", settingsText, 3)
end)

-- ========== Information Section ==========
MainWindow:Section("Information")

MainWindow:Label("UI Library: Modified by CATTSTAR")
MainWindow:Label("Original credits: rty_lol")
MainWindow:Label("Hotkey: RightShift - Hide/Show UI")
MainWindow:Label("Version: 1.0")

-- Dynamic status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 12
statusLabel.BackgroundTransparency = 1
statusLabel.Size = UDim2.new(1, 0, 0, 25)

task.wait(0.5)
for _, v in pairs(game.CoreGui:GetDescendants()) do
    if v.Name == "Holder" and v.Parent and v.Parent.Name == "ButtonHolder" then
        statusLabel.Parent = v
        statusLabel.LayoutOrder = 1000
        break
    end
end

-- Update status label example
task.spawn(function()
    local statuses = {"Ready", "Running", "Idle", "Active"}
    local colors = {Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 165, 0), Color3.fromRGB(0, 255, 255)}
    local index = 1
    while task.wait(5) do
        index = (index % #statuses) + 1
        statusLabel.Text = "Status: " .. statuses[index]
        statusLabel.TextColor3 = colors[index]
    end
end)

-- ========== Global Hotkeys ==========
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Press G to show welcome message
    if input.KeyCode == Enum.KeyCode.G then
        ShowNotification("Hotkey", "Hello! G key was pressed!", 2)
    end
    
    -- Press H to toggle demo killaura
    if input.KeyCode == Enum.KeyCode.H then
        if Settings.DemoKillaura then
            Settings.DemoKillaura = false
            if MainWindow.SetToggleState then
                MainWindow:SetToggleState("DemoKillaura", false)
            end
            ShowNotification("Hotkey", "Demo Killaura toggled OFF (H key)", 1.5)
        else
            Settings.DemoKillaura = true
            if MainWindow.SetToggleState then
                MainWindow:SetToggleState("DemoKillaura", true)
            end
            ShowNotification("Hotkey", "Demo Killaura toggled ON (H key)", 1.5)
        end
    end
    
    -- Press R to reset settings
    if input.KeyCode == Enum.KeyCode.R then
        -- Reset Settings table
        Settings.ToggleFlag = false
        Settings.Volume = 50
        Settings.Dropdown = nil
        Settings.PlayerList = nil
        Settings.ActionKey = nil
        Settings.Input = nil
        Settings.Number = nil
        Settings.DemoKillaura = false
        Settings.Range = 15
        Settings.Speed = 0.1
        
        if MainWindow.SetToggleState then
            MainWindow:SetToggleState("ToggleFlag", false)
            MainWindow:SetToggleState("DemoKillaura", false)
        end
        
        ShowNotification("Hotkey", "All settings reset! (R key)", 2)
    end
end)

-- ========== Initialization Complete ==========
ShowNotification("Example GUI", "Loaded successfully! Press RightShift to hide/show", 3)

-- Display hotkey info
task.wait(1)
ShowNotification("Hotkeys", "G = Hello | H = Toggle Demo | R = Reset All", 4)
