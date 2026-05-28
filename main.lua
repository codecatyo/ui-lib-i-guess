-- cred to rty i guess, dc of him: rty_lol
-- Modified by CATTSTAR

local Lib = {}
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local ASSET_ID = "rbxassetid://6850537969"
local GLOW_ASSET_ID = "rbxassetid://4905552912"
local ARROW_DOWN_ID = "http://www.roblox.com/asset/?id=5585095509"
local SEARCH_ICON_ID = "http://www.roblox.com/asset/?id=5585103223"

if game.CoreGui:FindFirstChild("Lib") then
    game.CoreGui:FindFirstChild("Lib"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Lib"

local visible = true
local usable = true

if _G.HideKeybind == nil then
    _G.HideKeybind = Enum.KeyCode.RightShift
end

UIS.InputBegan:Connect(function(key)
    if key.KeyCode == _G.HideKeybind and usable then
        usable = false
        visible = not visible
        for _, v in pairs(ScreenGui:GetChildren()) do
            v.Visible = visible
        end
        usable = true
    end
end)

local function addDrag(dragHandle, target)
    local dragging = false
    local dragStart = Vector2.new()
    local startPos = UDim2.new()

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
        end
    end)

    dragHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if dragging then
                    local delta = input.Position - dragStart
                    target.Position = UDim2.new(
                        startPos.X.Scale,
                        startPos.X.Offset + delta.X,
                        startPos.Y.Scale,
                        startPos.Y.Offset + delta.Y
                    )
                else
                    connection:Disconnect()
                end
            end)
        end
    end)
end

function Lib:CreateWindow(name)
    local Window = {}
    local mainMinimizeUsable = true

    local Main = Instance.new("ImageLabel")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0, #ScreenGui:GetChildren() * 170 - 155, 0, 15)
    Main.Size = UDim2.new(0, 150, 0, 25)
    Main.Image = ASSET_ID
    Main.ImageColor3 = Color3.fromRGB(35, 35, 35)
    Main.ScaleType = Enum.ScaleType.Slice
    Main.SliceCenter = Rect.new(100, 100, 100, 100)
    Main.SliceScale = 0.040

    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Parent = Main
    Glow.BackgroundTransparency = 1
    Glow.BorderSizePixel = 0
    Glow.Position = UDim2.new(0, -15, 0, -15)
    Glow.Size = UDim2.new(1, 30, 1, 30)
    Glow.Image = GLOW_ASSET_ID
    Glow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(20, 20, 280, 280)

    local ButtonHolder = Instance.new("Frame")
    ButtonHolder.Name = "ButtonHolder"
    ButtonHolder.Parent = Main
    ButtonHolder.BackgroundTransparency = 1
    ButtonHolder.BorderSizePixel = 0
    ButtonHolder.Position = UDim2.new(0, 0, 0, 25)
    ButtonHolder.Size = UDim2.new(1, 0, 0, 200)

    local Holder = Instance.new("Frame")
    Holder.Name = "Holder"
    Holder.Parent = ButtonHolder
    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.new(1, 0, 1, 0)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = Holder
    UIPadding.PaddingLeft = UDim.new(0, 5)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Holder
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local Title = Instance.new("Frame")
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.ZIndex = 2

    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "TitleText"
    TitleText.Parent = Title
    TitleText.BackgroundTransparency = 1
    TitleText.Position = UDim2.new(0, 5, 0, 0)
    TitleText.Size = UDim2.new(1, -5, 1, 0)
    TitleText.ZIndex = 2
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Text = name
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.TextSize = 15
    TitleText.TextStrokeTransparency = 0.92
    TitleText.TextXAlignment = Enum.TextXAlignment.Left

    local Minimize = Instance.new("TextButton")
    Minimize.Name = "Minimize"
    Minimize.Parent = Title
    Minimize.AnchorPoint = Vector2.new(1, 0.5)
    Minimize.BackgroundTransparency = 1
    Minimize.Position = UDim2.new(1, 0, 0.5, 0)
    Minimize.Size = UDim2.new(0, 25, 0, 25)
    Minimize.ZIndex = 2
    Minimize.Font = Enum.Font.GothamBold
    Minimize.Text = "-"
    Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
    Minimize.TextSize = 12
    Minimize.TextStrokeTransparency = 0.92

    local TitleGlow = Instance.new("ImageLabel")
    TitleGlow.Name = "TitleGlow"
    TitleGlow.Parent = Title
    TitleGlow.BackgroundTransparency = 1
    TitleGlow.BorderSizePixel = 0
    TitleGlow.Position = UDim2.new(0, -15, 0, -15)
    TitleGlow.Size = UDim2.new(1, 30, 1, 30)
    TitleGlow.Image = GLOW_ASSET_ID
    TitleGlow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    TitleGlow.ScaleType = Enum.ScaleType.Slice
    TitleGlow.SliceCenter = Rect.new(20, 20, 280, 280)

    local function updateSize(sizeDelta)
        Main.Size = Main.Size + UDim2.new(0, 0, 0, sizeDelta)
        for i, v in pairs(Holder:GetChildren()) do
            if v:IsA("Frame") then
                v.LayoutOrder = i - 2
                v.Name = tostring(i - 2)
            end
        end
    end

    local currentSize = 25
    local invisibleElements = {}

    Minimize.MouseButton1Click:Connect(function()
        if not mainMinimizeUsable then return end
        
        if Minimize.Text == "-" then
            currentSize = Main.AbsoluteSize.Y
            Minimize.Text = "+"
            invisibleElements = {}
            
            for _, v in pairs(Holder:GetChildren()) do
                if (v:IsA("Frame") or v:IsA("ImageLabel")) and v.Visible then
                    table.insert(invisibleElements, v)
                    v.Visible = false
                end
            end
            
            mainMinimizeUsable = false
            Main:TweenSize(UDim2.new(0, 150, 0, 25), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
            task.wait(0.2)
            mainMinimizeUsable = true
        else
            Minimize.Text = "-"
            mainMinimizeUsable = false
            Main:TweenSize(UDim2.new(0, 150, 0, currentSize), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
            task.wait(0.15)
            
            for _, v in pairs(invisibleElements) do
                v.Visible = true
            end
            invisibleElements = {}
            
            task.wait(0.05)
            mainMinimizeUsable = true
        end
    end)

    addDrag(TitleText, Main)

    Window.ToggleButtons = {}
    Window.ToggleElements = {}
    
    Window._toggleCallbacks = {}

    function Window:Button(name, callback)
        callback = callback or function() end
        
        local Button = Instance.new("Frame")
        Button.Name = "Button"
        Button.Parent = Holder
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(1, 0, 0, 25)

        local Text = Instance.new("TextButton")
        Text.Name = "Text"
        Text.Parent = Button
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(1, 0, 1, 0)
        Text.Font = Enum.Font.GothamBold
        Text.Text = name
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 12
        Text.TextStrokeTransparency = 0.92
        Text.TextXAlignment = Enum.TextXAlignment.Left
        
        Text.MouseButton1Click:Connect(function()
            task.spawn(callback)
        end)
        
        updateSize(25)
    end

    function Window:Button2(name, options, callback)
        callback = callback or function() end
        local flag = options.flag
        local location = options.location
        local default = options.default or false
        
        local Button = Instance.new("Frame")
        Button.Name = "Button"
        Button.Parent = Holder
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(1, 0, 0, 25)
        
        local Text = Instance.new("TextButton")
        Text.Name = "Text"
        Text.Parent = Button
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(1, 0, 1, 0)
        Text.Font = Enum.Font.GothamBold
        Text.Text = name
        Text.TextColor3 = default or Color3.fromRGB(255, 255, 255)
        Text.TextSize = 12
        Text.TextStrokeTransparency = 0.92
        Text.TextXAlignment = Enum.TextXAlignment.Left
        
        location[flag] = Text
        
        Text.MouseButton1Click:Connect(function()
            task.spawn(callback)
        end)
        
        updateSize(25)
    end

    function Window:Toggle(name, options, callback)
        local default = options.default or false
        local location = options.location or {}
        local flag = options.flag or ""
        callback = callback or function() end
        
        location[flag] = default
        
        if default then
            task.spawn(callback)
        end

        local Toggle = Instance.new("Frame")
        Toggle.Name = "Toggle"
        Toggle.Parent = Holder
        Toggle.BackgroundTransparency = 1
        Toggle.Size = UDim2.new(1, 0, 0, 25)
        
        local ToggleHolder = Instance.new("Frame")
        ToggleHolder.Name = "ToggleHolder"
        ToggleHolder.Parent = Toggle
        ToggleHolder.AnchorPoint = Vector2.new(1, 0.5)
        ToggleHolder.BackgroundTransparency = 1
        ToggleHolder.Position = UDim2.new(1, 0, 0.5, 0)
        ToggleHolder.Size = UDim2.new(0, 25, 0, 25)
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Name = "ToggleButton"
        ToggleButton.Parent = ToggleHolder
        ToggleButton.BackgroundTransparency = 1
        ToggleButton.Size = UDim2.new(1, 0, 1, 0)
        ToggleButton.Font = Enum.Font.GothamBold
        ToggleButton.TextSize = 12
        ToggleButton.TextStrokeTransparency = 0.92
        ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
        
        if default then
            ToggleButton.Text = "On"
            ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
            ToggleButton.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
        else
            ToggleButton.Text = "Off"
            ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
            ToggleButton.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
        end

        local Text = Instance.new("TextButton")
        Text.Name = "Text"
        Text.Parent = Toggle
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(1, 0, 1, 0)
        Text.Font = Enum.Font.GothamBold
        Text.Text = name
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 12
        Text.TextStrokeTransparency = 0.92
        Text.TextXAlignment = Enum.TextXAlignment.Left

        local toggleInfo = {
            button = ToggleButton,
            location = location,
            flag = flag,
            callback = callback,
            name = name
        }
        table.insert(Window.ToggleButtons, toggleInfo)
        
        Window.ToggleElements[flag] = ToggleButton

        Text.MouseButton1Click:Connect(function()
            if ToggleButton.Text == "On" then
                ToggleButton.Text = "Off"
                location[flag] = false
                ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
                ToggleButton.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
            else
                ToggleButton.Text = "On"
                location[flag] = true
                ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
                ToggleButton.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
            end
            task.spawn(callback)
        end)
        
        updateSize(25)
        
        return ToggleButton
    end

    function Window:SetToggleState(flag, state)
        for _, toggle in pairs(Window.ToggleButtons) do
            if toggle.flag == flag then
                if state then
                    toggle.button.Text = "On"
                    toggle.button.TextColor3 = Color3.fromRGB(0, 255, 0)
                    toggle.button.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
                    toggle.location[toggle.flag] = true
                else
                    toggle.button.Text = "Off"
                    toggle.button.TextColor3 = Color3.fromRGB(255, 0, 0)
                    toggle.button.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
                    toggle.location[toggle.flag] = false
                end
                return true
            end
        end
        return false
    end
    
    function Window:UpdateToggleExternal(flag, state)
        local toggleElement = Window.ToggleElements[flag]
        if toggleElement then
            if state then
                toggleElement.Text = "On"
                toggleElement.TextColor3 = Color3.fromRGB(0, 255, 0)
                toggleElement.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
            else
                toggleElement.Text = "Off"
                toggleElement.TextColor3 = Color3.fromRGB(255, 0, 0)
                toggleElement.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
            end
            for _, toggle in pairs(Window.ToggleButtons) do
                if toggle.flag == flag then
                    toggle.location[toggle.flag] = state
                    break
                end
            end
        end
    end
    
    function Window:GetToggleState(flag)
        for _, toggle in pairs(Window.ToggleButtons) do
            if toggle.flag == flag then
                return toggle.location[toggle.flag]
            end
        end
        return nil
    end

    function Window:Slider(name, options, callback)
        local default = options.default or options.min or 0
        local min = options.min or 0
        local max = options.max or 1
        local location = options.location or {}
        local precise = options.precise or false
        local flag = options.flag or ""
        callback = callback or function() end

        local Slider = Instance.new("Frame")
        Slider.Name = "Slider"
        Slider.Size = UDim2.new(1, 0, 0, 30)
        Slider.BackgroundTransparency = 1
        Slider.Parent = Holder

        local Text = Instance.new("TextLabel")
        Text.Name = "Text"
        Text.Text = name
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 12
        Text.Font = Enum.Font.GothamBold
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(1, 0, 0, 14)
        Text.TextXAlignment = Enum.TextXAlignment.Left
        Text.Parent = Slider

        local SliderHolder = Instance.new("Frame")
        SliderHolder.Name = "SliderHolder"
        SliderHolder.BackgroundTransparency = 1
        SliderHolder.Position = UDim2.new(0, 0, 0, 15)
        SliderHolder.Size = UDim2.new(1, 0, 0, 15)
        SliderHolder.Parent = Slider

        local MainBar = Instance.new("ImageLabel")
        MainBar.Size = UDim2.new(1, -10, 0, 6)
        MainBar.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainBar.AnchorPoint = Vector2.new(0.5, 0.5)
        MainBar.Image = ASSET_ID
        MainBar.ImageColor3 = Color3.fromRGB(45, 45, 45)
        MainBar.ScaleType = Enum.ScaleType.Slice
        MainBar.SliceCenter = Rect.new(100, 100, 100, 100)
        MainBar.SliceScale = 0.12
        MainBar.BackgroundTransparency = 1
        MainBar.Parent = SliderHolder

        local Fill = Instance.new("ImageLabel")
        Fill.Size = UDim2.new(0, 0, 0, 6)
        Fill.Image = ASSET_ID
        Fill.ScaleType = Enum.ScaleType.Slice
        Fill.SliceCenter = Rect.new(100, 100, 100, 100)
        Fill.SliceScale = 0.12
        Fill.BackgroundTransparency = 1
        Fill.Parent = MainBar

        local Value = Instance.new("TextBox")
        Value.Size = UDim2.new(0.3, 0, 0, 14)
        Value.Position = UDim2.new(0.7, 0, 0, 0)
        Value.BackgroundTransparency = 1
        Value.TextColor3 = Color3.fromRGB(255, 255, 255)
        Value.Font = Enum.Font.GothamBold
        Value.TextSize = 12
        Value.TextXAlignment = Enum.TextXAlignment.Right
        Value.Parent = Slider

        local dragging = false
        local maxWidth = 134

        local function setValueFromWidth(width)
            width = math.clamp(width, 0, maxWidth)
            Fill.Size = UDim2.new(0, width, 0, 6)
            
            local percent = width / maxWidth
            local val = min + (max - min) * percent
            
            if precise then
                val = math.floor(val)
            else
                val = math.floor(val * 100) / 100
            end
            
            location[flag] = val
            Value.Text = tostring(val)
            
            task.spawn(callback, val)
        end

        MainBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    if not dragging then
                        conn:Disconnect()
                        return
                    end
                    local mouseX = UIS:GetMouseLocation().X
                    local start = MainBar.AbsolutePosition.X
                    setValueFromWidth(mouseX - start)
                end)
            end
        end)

        MainBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        Value.FocusLost:Connect(function()
            local val = tonumber(Value.Text) or default
            val = math.clamp(val, min, max)
            local percent = (val - min) / (max - min)
            setValueFromWidth(percent * maxWidth)
        end)

        location[flag] = default
        Value.Text = tostring(default)

        task.defer(function()
            local percent = (default - min) / (max - min)
            setValueFromWidth(percent * maxWidth)
        end)

        task.defer(function()
            updateSize(Slider.AbsoluteSize.Y)
        end)
    end

    function Window:Dropdown(name, options, callback)
        local location = options.location or {}
        local flag = options.flag or ""
        local dropdownType = options.Dropdown or false
        local playerList = options.PlayerList or false
        local searchEnabled = options.search or false
        callback = callback or function() end
        
        if playerList then
            options.list = {}
            for _, player in pairs(Players:GetChildren()) do
                table.insert(options.list, player.Name)
            end
        elseif type(options.list) ~= "table" then
            options.list = options.list:GetChildren()
        end
        
        location[flag] = options.list[1]
        
        local Dropdown = Instance.new("Frame")
        Dropdown.Name = "Dropdown"
        Dropdown.Parent = Holder
        Dropdown.BackgroundTransparency = 1
        Dropdown.Size = UDim2.new(1, 0, 0, 25)

        updateSize(25)

        local Text = Instance.new("TextButton")
        Text.Name = "Text"
        Text.Parent = Dropdown
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(1, 0, 1, 0)
        Text.Font = Enum.Font.GothamBold
        Text.Text = tostring(options.list[1])
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 12
        Text.TextStrokeTransparency = 0.92
        Text.TextXAlignment = Enum.TextXAlignment.Left

        local Button = Instance.new("Frame")
        Button.Name = "Button"
        Button.Parent = Dropdown
        Button.AnchorPoint = Vector2.new(1, 0.5)
        Button.BackgroundTransparency = 1
        Button.Position = UDim2.new(1, 0, 0.5, 0)
        Button.Size = UDim2.new(0, 25, 0, 25)

        local ArrowButton = Instance.new("ImageLabel")
        ArrowButton.Name = "ArrowButton"
        ArrowButton.Parent = Button
        ArrowButton.AnchorPoint = Vector2.new(0, 0.5)
        ArrowButton.BackgroundTransparency = 1
        ArrowButton.Position = UDim2.new(0, 0, 0.5, 0)
        ArrowButton.Size = UDim2.new(1, -5, 1, -5)
        ArrowButton.ZIndex = 2
        ArrowButton.Image = ARROW_DOWN_ID

        local DropdownHolder = Instance.new("ImageLabel")
        DropdownHolder.Name = "DropdownHolder"
        DropdownHolder.Parent = Holder
        DropdownHolder.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
        DropdownHolder.Visible = false
        DropdownHolder.Position = UDim2.new(0, 0, 0, 22)
        DropdownHolder.Size = UDim2.new(0, 140, 0, 1)
        DropdownHolder.ZIndex = 3
        DropdownHolder.BorderSizePixel = 0

        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Parent = DropdownHolder
        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.Size = UDim2.new(0, 137, 0, 100)
        ScrollingFrame.ScrollBarThickness = 4
        ScrollingFrame.ZIndex = 3
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

        local Layout = Instance.new("UIListLayout")
        Layout.Parent = ScrollingFrame
        Layout.SortOrder = Enum.SortOrder.LayoutOrder

        local SearchBox = Instance.new("TextBox")
        SearchBox.Parent = Text
        SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        SearchBox.Position = UDim2.new(0, 0, 0, 0)
        SearchBox.Size = UDim2.new(1, -25, 1, 0)
        SearchBox.Font = Enum.Font.GothamBold
        SearchBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
        SearchBox.PlaceholderText = name .. "..."
        SearchBox.Text = ""
        SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        SearchBox.TextSize = 12
        SearchBox.TextStrokeTransparency = 0.92
        SearchBox.TextXAlignment = Enum.TextXAlignment.Left
        SearchBox.Visible = false
        SearchBox.BorderSizePixel = 0

        local function fixCanvas()
            local amount = 0
            for _, v in pairs(ScrollingFrame:GetChildren()) do
                if v:IsA("TextButton") and v.Visible then
                    amount = amount + 1
                end
            end
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, amount * 20)
        end

        local function setVisibility(value)
            for _, v in pairs(ScrollingFrame:GetChildren()) do
                if v:IsA("TextButton") then
                    v.Visible = value
                end
            end
        end

        local dropdownUsable = true

        Text.MouseButton1Click:Connect(function()
            if not dropdownUsable then return end
            
            if ArrowButton.Rotation == 0 then
                ArrowButton.Rotation = 180
                DropdownHolder.LayoutOrder = tonumber(Dropdown.Name)
                DropdownHolder.Visible = true
                
                if searchEnabled then
                    SearchBox.Visible = true
                end
                
                DropdownHolder.Size = UDim2.new(0, 140, 0, 1)
                dropdownUsable = false
                DropdownHolder:TweenSize(UDim2.new(0, 140, 0, 100), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                Main:TweenSize(UDim2.new(0, 150, 0, Main.AbsoluteSize.Y + 100), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                task.wait(0.2)
                dropdownUsable = true
                setVisibility(true)
                
                if dropdownType == "Update" then
                    task.spawn(callback)
                end
                
                for _, v in pairs(options.list) do
                    local Option = Instance.new("TextButton")
                    Option.Name = tostring(v)
                    Option.Parent = ScrollingFrame
                    Option.BackgroundTransparency = 1
                    Option.Size = UDim2.new(0, 132, 0, 20)
                    Option.Font = Enum.Font.GothamBold
                    Option.Text = "  " .. tostring(v)
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 12
                    Option.TextStrokeTransparency = 0.92
                    Option.TextXAlignment = Enum.TextXAlignment.Left
                    Option.ZIndex = 3
                    
                    Option.MouseButton1Click:Connect(function()
                        location[flag] = v
                        Text.Text = tostring(location[flag])
                        
                        if dropdownType ~= "Update" then
                            task.spawn(callback)
                        end
                        
                        setVisibility(false)
                        
                        if searchEnabled then
                            SearchBox.Visible = false
                            SearchBox.Text = ""
                        end
                        
                        dropdownUsable = false
                        Main:TweenSize(UDim2.new(0, 150, 0, Main.AbsoluteSize.Y - 100), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                        DropdownHolder:TweenSize(UDim2.new(0, 140, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                        task.wait(0.2)
                        dropdownUsable = true
                        ArrowButton.Rotation = 0
                        DropdownHolder.Visible = false
                        
                        for _, child in pairs(ScrollingFrame:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        
                        if playerList then
                            options.list = {}
                            for _, player in pairs(Players:GetChildren()) do
                                table.insert(options.list, player.Name)
                            end
                        end
                    end)
                    fixCanvas()
                end
            else
                setVisibility(false)
                
                if searchEnabled then
                    SearchBox.Visible = false
                    SearchBox.Text = ""
                end
                
                dropdownUsable = false
                Main:TweenSize(UDim2.new(0, 150, 0, Main.AbsoluteSize.Y - 100), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                DropdownHolder:TweenSize(UDim2.new(0, 140, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                
                for _, child in pairs(ScrollingFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                task.wait(0.2)
                dropdownUsable = true
                ArrowButton.Rotation = 0
                DropdownHolder.Visible = false
                
                if playerList then
                    options.list = {}
                    for _, player in pairs(Players:GetChildren()) do
                        table.insert(options.list, player.Name)
                    end
                end
            end
        end)

        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            for _, v in pairs(ScrollingFrame:GetChildren()) do
                if v:IsA("TextButton") then
                    v.Visible = string.find(v.Text:lower(), SearchBox.Text:lower()) ~= nil
                    fixCanvas()
                end
            end
        end)
    end

    function Window:Bind(name, options, callback)
        local location = options.location or {}
        local flag = options.flag or ""
        local default = options.default or false
        callback = callback or function() end
        
        location[flag] = default
        
        local patterns = {{"Right", "R"}, {"Left", "L"}, {"Control", "Ctrl"}}
        
        local function formatKeyName(key)
            local name = string.sub(tostring(key.KeyCode), 14, 999)
            for _, pattern in pairs(patterns) do
                name = string.gsub(name, pattern[1], pattern[2])
            end
            return name
        end

        local Hotkey = Instance.new("Frame")
        Hotkey.Name = "Hotkey"
        Hotkey.Parent = Holder
        Hotkey.BackgroundTransparency = 1
        Hotkey.Size = UDim2.new(1, 0, 0, 25)
        
        local Key = Instance.new("TextButton")
        Key.Name = "Key"
        Key.Parent = Hotkey
        Key.BackgroundTransparency = 1
        Key.Position = UDim2.new(0.42, 0, 0, 0)
        Key.Size = UDim2.new(0.52, 0, 1, 0)
        Key.Font = Enum.Font.GothamBold
        Key.Text = default and formatKeyName({KeyCode = default}) or "F"
        Key.TextColor3 = Color3.fromRGB(255, 255, 255)
        Key.TextSize = 12
        Key.TextStrokeTransparency = 0.92
        Key.TextXAlignment = Enum.TextXAlignment.Right

        local Text = Instance.new("TextButton")
        Text.Name = "Text"
        Text.Parent = Hotkey
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(1, 0, 1, 0)
        Text.Font = Enum.Font.GothamBold
        Text.Text = name
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 12
        Text.TextStrokeTransparency = 0.92
        Text.TextXAlignment = Enum.TextXAlignment.Left

        local bindUsable = true
        local inputConnection

        inputConnection = UIS.InputBegan:Connect(function(key)
            if bindUsable and not UIS:GetFocusedTextBox() then
                if key.KeyCode == location[flag] then
                    task.spawn(callback)
                end
                if not Hotkey:IsDescendantOf(game) then
                    inputConnection:Disconnect()
                end
            end
        end)

        Text.MouseButton1Click:Connect(function()
            Key.Text = "..."
            bindUsable = false
            
            local tempConnection
            tempConnection = UIS.InputBegan:Connect(function(key)
                if key.KeyCode ~= Enum.KeyCode.Unknown and not UIS:GetFocusedTextBox() and key.KeyCode ~= Enum.KeyCode.Escape then
                    Key.Text = formatKeyName(key)
                    location[flag] = key.KeyCode
                    tempConnection:Disconnect()
                    task.wait(0.1)
                    bindUsable = true
                elseif key.KeyCode == Enum.KeyCode.Escape then
                    Key.Text = "nil"
                    location[flag] = nil
                    tempConnection:Disconnect()
                    task.wait(0.1)
                    bindUsable = true
                end
            end)
        end)

        updateSize(25)
    end

    function Window:Box(name, options, callback)
        local inputType = options.type or ""
        local default = options.default or false
        local placeholder = options.hold or "Text..."
        local location = options.location or {}
        local flag = options.flag or ""
        callback = callback or function() end

        local TextBox = Instance.new("Frame")
        TextBox.Name = "TextBox"
        TextBox.Parent = Holder
        TextBox.BackgroundTransparency = 1
        TextBox.Size = UDim2.new(1, 0, 0, 25)

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Parent = TextBox
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(0, 79, 1, 0)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.Text = name
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 12
        TextLabel.TextStrokeTransparency = 0.92
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        local Input = Instance.new("TextBox")
        Input.Parent = TextBox
        Input.BackgroundTransparency = 1
        Input.BorderSizePixel = 0
        Input.Position = UDim2.new(0.42, 0, 0, 0)
        Input.Size = UDim2.new(0, 76, 0, 25)
        Input.Font = Enum.Font.GothamBold
        Input.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
        Input.PlaceholderText = placeholder .. "..."
        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
        Input.TextSize = 12
        Input.TextStrokeTransparency = 0.92
        Input.TextXAlignment = Enum.TextXAlignment.Left

        if default then
            Input.Text = default
            location[flag] = default
        end

        Input:GetPropertyChangedSignal("Text"):Connect(function()
            if inputType == "number" and not tonumber(Input.Text) then
                Input.Text = Input.Text:gsub("%D+", "")
            end
        end)

        Input.FocusLost:Connect(function()
            location[flag] = Input.Text
            task.spawn(callback)
        end)

        updateSize(25)
    end

    function Window:Search(color)
        color = color or Color3.fromRGB(255, 255, 0)

        local Search = Instance.new("Frame")
        Search.Name = "Search"
        Search.Parent = Holder
        Search.BackgroundTransparency = 1
        Search.Size = UDim2.new(1, 0, 0, 25)
        
        local Text = Instance.new("TextBox")
        Text.Name = "Text"
        Text.Parent = Search
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(1, 0, 1, 0)
        Text.Font = Enum.Font.GothamBold
        Text.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
        Text.PlaceholderText = "Search"
        Text.Text = ""
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 12
        Text.TextStrokeTransparency = 0.92
        Text.TextXAlignment = Enum.TextXAlignment.Left

        local IconHolder = Instance.new("Frame")
        IconHolder.Name = "IconHolder"
        IconHolder.Parent = Search
        IconHolder.AnchorPoint = Vector2.new(1, 0.5)
        IconHolder.BackgroundTransparency = 1
        IconHolder.Position = UDim2.new(1, 0, 0.5, 0)
        IconHolder.Size = UDim2.new(0, 25, 0, 25)

        local SearchIcon = Instance.new("ImageLabel")
        SearchIcon.Name = "SearchIcon"
        SearchIcon.Parent = IconHolder
        SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
        SearchIcon.BackgroundTransparency = 1
        SearchIcon.Position = UDim2.new(0, 0, 0.5, 0)
        SearchIcon.Size = UDim2.new(1, -8, 1, -8)
        SearchIcon.ZIndex = 2
        SearchIcon.Image = SEARCH_ICON_ID

        Text:GetPropertyChangedSignal("Text"):Connect(function()
            local searchText = Text.Text:lower()
            for _, v in pairs(ScreenGui:GetDescendants()) do
                if (v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox")) 
                    and v ~= Text 
                    and searchText ~= "" 
                    and searchText ~= " " 
                    and v.Text ~= "Off" 
                    and v.Text ~= "On" then
                    
                    if string.find(v.Text:lower(), searchText) then
                        v.TextColor3 = color
                    else
                        v.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end)

        Text.Focused:Connect(function()
            Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        Text.FocusLost:Connect(function()
            Text.TextColor3 = Color3.fromRGB(200, 200, 200)
            for _, v in pairs(ScreenGui:GetDescendants()) do
                if (v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox")) 
                    and v.Text ~= "Off" 
                    and v.Text ~= "On" then
                    v.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end)

        updateSize(25)
    end

    function Window:Section(text)
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Name = "Section"
        SectionFrame.Parent = Holder
        SectionFrame.BackgroundTransparency = 1
        SectionFrame.BorderSizePixel = 0
        SectionFrame.Size = UDim2.new(1, 0, 0, 25)
        SectionFrame.ZIndex = 2
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Name = "SectionTitle"
        SectionTitle.Parent = SectionFrame
        SectionTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        SectionTitle.BorderSizePixel = 0
        SectionTitle.Position = UDim2.new(0, -5, 0, 0)
        SectionTitle.Size = UDim2.new(1, 5, 1, 0)
        SectionTitle.ZIndex = 2
        SectionTitle.Font = Enum.Font.GothamBold
        SectionTitle.Text = " " .. text
        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.TextSize = 13
        SectionTitle.TextStrokeTransparency = 0.92
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        local SectionMinimize = Instance.new("TextButton")
        SectionMinimize.Name = "SectionMinimize"
        SectionMinimize.Parent = SectionFrame
        SectionMinimize.AnchorPoint = Vector2.new(1, 0.5)
        SectionMinimize.BackgroundTransparency = 1
        SectionMinimize.Position = UDim2.new(1, 0, 0.5, 0)
        SectionMinimize.Size = UDim2.new(0, 25, 0, 25)
        SectionMinimize.ZIndex = 3
        SectionMinimize.Font = Enum.Font.GothamBold
        SectionMinimize.Text = "-"
        SectionMinimize.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionMinimize.TextSize = 12
        SectionMinimize.TextStrokeTransparency = 0.92
        
        local SectionGlow = Instance.new("ImageLabel")
        SectionGlow.Name = "SectionGlow"
        SectionGlow.Parent = SectionTitle
        SectionGlow.BackgroundTransparency = 1
        SectionGlow.BorderSizePixel = 0
        SectionGlow.Position = UDim2.new(0, -15, 0, -15)
        SectionGlow.Size = UDim2.new(1, 30, 1, 30)
        SectionGlow.Image = GLOW_ASSET_ID
        SectionGlow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        SectionGlow.ScaleType = Enum.ScaleType.Slice
        SectionGlow.SliceCenter = Rect.new(20, 20, 280, 280)

        local function setChildrenVisibility(value)
            for _, v in pairs(Holder:GetChildren()) do
                if v:IsA("Frame") or v:IsA("ImageLabel") then
                    if tonumber(v.Name) and tonumber(v.Name) > tonumber(SectionFrame.Name) 
                        and not v:FindFirstChild("SectionTitle") 
                        and v ~= SectionFrame then
                        v.Visible = value
                    elseif v:FindFirstChild("SectionTitle") 
                        and v ~= SectionFrame 
                        and tonumber(v.Name) > tonumber(SectionFrame.Name) then
                        return
                    end
                end
            end
        end

        local function getChildrenHeight()
            local height = 0
            for _, v in pairs(Holder:GetChildren()) do
                if v:IsA("Frame") or v:IsA("ImageLabel") then
                    if tonumber(v.Name) and tonumber(v.Name) > tonumber(SectionFrame.Name) 
                        and not v:FindFirstChild("SectionTitle") 
                        and v ~= SectionFrame then
                        if v:FindFirstChild("SliderHolder") then
                            height = height + 30
                        else
                            height = height + 25
                        end
                    elseif v:FindFirstChild("SectionTitle") 
                        and v ~= SectionFrame 
                        and tonumber(v.Name) > tonumber(SectionFrame.Name) then
                        return height
                    end
                end
            end
            return height
        end

        local function createAnimationFrame(height)
            local frame = Instance.new("Frame", Holder)
            frame.LayoutOrder = tonumber(SectionFrame.Name)
            frame.Size = UDim2.new(0, 140, 0, height)
            frame.BackgroundTransparency = 1
            return frame
        end

        local sectionMinimizeUsable = true

        SectionMinimize.MouseButton1Click:Connect(function()
            if not sectionMinimizeUsable then return end
            
            local childrenHeight = getChildrenHeight()
            
            if SectionMinimize.Text == "-" then
                SectionMinimize.Text = "+"
                setChildrenVisibility(false)
                local animFrame = createAnimationFrame(childrenHeight)
                
                sectionMinimizeUsable = false
                animFrame:TweenSize(UDim2.new(0, 150, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                Main:TweenSize(UDim2.new(0, 150, 0, Main.AbsoluteSize.Y - childrenHeight), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                task.wait(0.2)
                sectionMinimizeUsable = true
                animFrame:Destroy()
            else
                SectionMinimize.Text = "-"
                local animFrame = createAnimationFrame(0)
                
                sectionMinimizeUsable = false
                animFrame:TweenSize(UDim2.new(0, 150, 0, childrenHeight), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                Main:TweenSize(UDim2.new(0, 150, 0, Main.AbsoluteSize.Y + childrenHeight), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
                task.wait(0.2)
                sectionMinimizeUsable = true
                animFrame:Destroy()
                setChildrenVisibility(true)
            end
        end)

        updateSize(25)
    end

    function Window:Label(text)
        local Frame = Instance.new("Frame")
        Frame.Parent = Holder
        Frame.BackgroundTransparency = 1
        Frame.Size = UDim2.new(1, 0, 0, 25)

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Parent = Frame
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 12
        TextLabel.TextStrokeTransparency = 0.92
        TextLabel.Text = text

        updateSize(25)
    end

    function Window:String(text)
        if type(text) == "table" and text.string then
            text = text.string
        end
        return Window:Label(text)
    end

    return Window
end

return Lib
