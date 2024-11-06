local Library = {}

function Library:CreateWindow(title)
    title = title or "HUD"

    local Window = {}
    local GUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local TabBar = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    -- Screen GUI
    GUI.Name = "CustomHUD"
    GUI.Parent = game.CoreGui
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = GUI
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.Size = UDim2.new(0, 350, 0, 250)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.ClipsDescendants = true
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

    -- Title Label
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.Size = UDim2.new(0.8, 0, 0, 30)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- Minimize and Unload Buttons
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = MainFrame
    MinimizeButton.Text = "-"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
    MinimizeButton.BorderSizePixel = 0

    local UnloadButton = Instance.new("TextButton")
    UnloadButton.Name = "UnloadButton"
    UnloadButton.Parent = MainFrame
    UnloadButton.Text = "X"
    UnloadButton.Font = Enum.Font.GothamBold
    UnloadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    UnloadButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    UnloadButton.Size = UDim2.new(0, 30, 0, 30)
    UnloadButton.Position = UDim2.new(0.88, 0, 0, 0)
    UnloadButton.BorderSizePixel = 0

    -- Tab Bar
    TabBar.Name = "TabBar"
    TabBar.Parent = MainFrame
    TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabBar.BorderSizePixel = 0
    TabBar.Position = UDim2.new(0, 0, 0, 30)
    TabBar.Size = UDim2.new(1, 0, 0, 25)

    -- Tab Container
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 55)
    TabContainer.Size = UDim2.new(1, 0, 1, -55)

    -- Layout for Tabs
    UIListLayout.Parent = TabBar
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 0)  -- Remove padding para compactar

    -- Minimize and Unload functionality
    local isMinimized = false
    local MinimizeBox = Instance.new("TextButton")
    
    MinimizeBox.Name = "MinimizeBox"
    MinimizeBox.Parent = GUI
    MinimizeBox.Size = UDim2.new(0, 100, 0, 30)
    MinimizeBox.Position = MainFrame.Position
    MinimizeBox.Text = "Open HUD"
    MinimizeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MinimizeBox.BorderSizePixel = 0
    MinimizeBox.Visible = false
    MinimizeBox.Font = Enum.Font.GothamBold
    MinimizeBox.TextSize = 14

    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        MainFrame.Visible = not isMinimized
        MinimizeBox.Visible = isMinimized
    end)

    UnloadButton.MouseButton1Click:Connect(function()
        GUI:Destroy()
    end)

    MinimizeBox.MouseButton1Click:Connect(function()
        isMinimized = false
        MainFrame.Visible = true
        MinimizeBox.Visible = false
    end)

    -- Dragging functionality for MainFrame
    local dragging = false
    local dragStart
    local startPos

    TitleLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TitleLabel.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            MinimizeBox.Position = MainFrame.Position
        end
    end)

    -- Dragging functionality for MinimizeBox
    MinimizeBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MinimizeBox.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    MinimizeBox.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            MinimizeBox.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    function Window:CreateTab(name)
        local Tab = {}
        name = name or "Tab"

        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Button"
        TabButton.Parent = TabBar
        TabButton.Text = name
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.BorderSizePixel = 0
        TabButton.AutoButtonColor = false

        -- Tab Content
        local TabFrame = Instance.new("Frame")
        TabFrame.Name = name .. "Content"
        TabFrame.Parent = TabContainer
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(TabContainer:GetChildren()) do
                tab.Visible = false
            end
            TabFrame.Visible = true
        end)

        if #TabContainer:GetChildren() == 1 then
            TabFrame.Visible = true
        end

        function Tab:CreateGroupbox(name)
            local Groupbox = {}
            name = name or ""

            local GroupboxFrame = Instance.new("Frame")
            GroupboxFrame.Name = name
            GroupboxFrame.Parent = TabFrame
            GroupboxFrame.Size = UDim2.new(1, -10, 0, 100)
            GroupboxFrame.Position = UDim2.new(0, 5, 0, 0) -- Removendo espaçamento extra
            GroupboxFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            GroupboxFrame.BorderSizePixel = 0

            local ContentFrame = Instance.new("Frame")
            ContentFrame.Parent = GroupboxFrame
            ContentFrame.Position = UDim2.new(0, 0, 0, 0)
            ContentFrame.Size = UDim2.new(1, 0, 1, -20)
            ContentFrame.BackgroundTransparency = 1

            function Groupbox:CreateButton(text, callback)
                local Button = Instance.new("TextButton")
                Button.Parent = ContentFrame
                Button.Text = text
                Button.Size = UDim2.new(1, -10, 0, 25)
                Button.Position = UDim2.new(0, 5, 0, #ContentFrame:GetChildren() * 30)
                Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 14
                Button.BorderSizePixel = 0
                Button.MouseButton1Click:Connect(callback)
            end

            function Groupbox:CreateToggle(text, callback)
                local Toggle = Instance.new("TextButton")
                Toggle.Parent = ContentFrame
                Toggle.Text = text
                Toggle.Size = UDim2.new(1, -10, 0, 25)
                Toggle.Position = UDim2.new(0, 5, 0, #ContentFrame:GetChildren() * 30)
                Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.Font = Enum.Font.Gotham
                Toggle.TextSize = 14
                Toggle.BorderSizePixel = 0
                local isToggled = false
                Toggle.MouseButton1Click:Connect(function()
                    isToggled = not isToggled
                    callback(isToggled)
                    Toggle.BackgroundColor3 = isToggled and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(30, 30, 30)
                end)
            end

            function Groupbox:CreateDropdown(text, options, callback)
                local Dropdown = Instance.new("TextButton")
                Dropdown.Parent = ContentFrame
                Dropdown.Text = text
                Dropdown.Size = UDim2.new(1, -10, 0, 25)
                Dropdown.Position = UDim2.new(0, 5, 0, #ContentFrame:GetChildren() * 30)
                Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
                Dropdown.Font = Enum.Font.Gotham
                Dropdown.TextSize = 14
                Dropdown.BorderSizePixel = 0

                local DropdownList = Instance.new("Frame")
                DropdownList.Parent = Dropdown
                DropdownList.Size = UDim2.new(1, 0, 0, #options * 25)
                DropdownList.Position = UDim2.new(0, 0, 1, 0)
                DropdownList.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                DropdownList.Visible = false

                for _, option in pairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Parent = DropdownList
                    OptionButton.Text = option
                    OptionButton.Size = UDim2.new(1, -10, 0, 25)
                    OptionButton.Position = UDim2.new(0, 5, 0, (#DropdownList:GetChildren() - 1) * 25)
                    OptionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.TextSize = 14
                    OptionButton.BorderSizePixel = 0
                    OptionButton.MouseButton1Click:Connect(function()
                        callback(option)
                        Dropdown.Text = text .. ": " .. option
                        DropdownList.Visible = false
                    end)
                end

                Dropdown.MouseButton1Click:Connect(function()
                    DropdownList.Visible = not DropdownList.Visible
                end)
            end

            return Groupbox
        end

        return Tab
    end

    return Window
end

return Library
