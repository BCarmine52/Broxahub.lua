local Library = {}

function Library:CreateWindow(title)
    title = title or "HUD"

    local Window = {}
    local GUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local TabBar = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")

    -- Configuração da ScreenGui
    GUI.Name = "CustomHUD"
    GUI.Parent = game.CoreGui
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    GUI.ResetOnSpawn = false

    -- Main Frame centralizado com animação de início e maior altura
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = GUI
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.fromScale(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 350, 0, 450) -- Aumentei a largura e a altura
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundTransparency = 0
    MainFrame.ClipsDescendants = true

    -- Cantos arredondados para o MainFrame
    local MainFrameCorner = Instance.new("UICorner")
    MainFrameCorner.CornerRadius = UDim.new(0, 10)
    MainFrameCorner.Parent = MainFrame

    -- Título centralizado em negrito
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- Botão de minimizar ajustado para a esquerda
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = MainFrame
    MinimizeButton.Text = "-"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0.87, 0, 0, 0)
    MinimizeButton.BorderSizePixel = 0

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 5)
    MinimizeCorner.Parent = MinimizeButton

    -- Minimização
    local isMinimized = false
    local MinimizeBox = Instance.new("TextButton")

    MinimizeBox.Name = "MinimizeBox"
    MinimizeBox.Parent = GUI
    MinimizeBox.Size = UDim2.new(0, 55, 0, 55)
    MinimizeBox.Position = MainFrame.Position
    MinimizeBox.Text = "BH"
    MinimizeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MinimizeBox.BorderSizePixel = 0
    MinimizeBox.Visible = false
    MinimizeBox.Font = Enum.Font.GothamBold
    MinimizeBox.TextSize = 14

    local MinimizeBoxCorner = Instance.new("UICorner")
    MinimizeBoxCorner.CornerRadius = UDim.new(0, 5)
    MinimizeBoxCorner.Parent = MinimizeBox

    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        MainFrame.Visible = not isMinimized
        MinimizeBox.Visible = isMinimized
    end)

    MinimizeBox.MouseButton1Click:Connect(function()
        isMinimized = false
        MainFrame.Visible = true
        MinimizeBox.Visible = false
    end)

    -- Arrastar para dispositivos móveis e desktop
    local dragging = false
    local dragStart
    local startPos

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

    MainFrame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            MinimizeBox.Position = MainFrame.Position
        end
    end)

    -- Tab Bar
    TabBar.Name = "TabBar"
    TabBar.Parent = MainFrame
    TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabBar.BorderSizePixel = 0
    TabBar.Position = UDim2.new(0, 0, 0, 30)
    TabBar.Size = UDim2.new(1, 0, 0, 25)

    local TabBarCorner = Instance.new("UICorner")
    TabBarCorner.CornerRadius = UDim.new(0, 10)
    TabBarCorner.Parent = TabBar

    -- Tab Container
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 65)
    TabContainer.Size = UDim2.new(1, 0, 1, -65)

    -- Layout for Tabs
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabBar
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)

    function Window:Unload()
        GUI:Destroy()
    end

    function Window:CreateTab(name)
        local Tab = {}
        name = name or "Tab"

        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Button"
        TabButton.Parent = TabBar
        TabButton.Text = name
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.BorderSizePixel = 0
        TabButton.AutoButtonColor = false

        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 5)
        TabButtonCorner.Parent = TabButton

        local TabFrame = Instance.new("Frame")
        TabFrame.Name = name .. "Content"
        TabFrame.Parent = TabContainer
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false

        local function updateTabSelection()
            for _, button in pairs(TabBar:GetChildren()) do
                if button:IsA("TextButton") then
                    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                end
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(75, 150, 255)
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(TabContainer:GetChildren()) do
                tab.Visible = false
            end
            TabFrame.Visible = true
            updateTabSelection()
        end)

        if #TabContainer:GetChildren() == 1 then
            TabFrame.Visible = true
            updateTabSelection()
        end

        function Tab:CreateGroupbox()
            local Groupbox = {}

            local Frame = Instance.new("Frame")
            Frame.Parent = TabFrame
            Frame.Position = UDim2.new(0, 0, 0, 0)
            Frame.Size = UDim2.new(1, 0, 1, 0)
            Frame.BackgroundTransparency = 1

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = Frame
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 5)

            function Groupbox:CreateToggleButton(text, callback)
                local ToggleButtonFrame = Instance.new("Frame")
                ToggleButtonFrame.Parent = Frame
                ToggleButtonFrame.Size = UDim2.new(1, -10, 0, 25)
                ToggleButtonFrame.BackgroundTransparency = 1

                local ToggleButtonLabel = Instance.new("TextLabel")
                ToggleButtonLabel.Parent = ToggleButtonFrame
                ToggleButtonLabel.Text = text
                ToggleButtonLabel.Size = UDim2.new(0.8, 0, 1, 0)
                ToggleButtonLabel.Position = UDim2.new(0.25, 0, 0, 0)
                ToggleButtonLabel.BackgroundTransparency = 1
                ToggleButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButtonLabel.Font = Enum.Font.GothamBold
                ToggleButtonLabel.TextSize = 14
                ToggleButtonLabel.TextXAlignment = Enum.TextXAlignment.Left

                local Toggle = Instance.new("TextButton")
                Toggle.Parent = ToggleButtonFrame
                Toggle.Size = UDim2.new(0, 20, 0, 20)
                Toggle.Position = UDim2.new(0.85, 0, 0.1, 0)
                Toggle.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
                Toggle.Text = ""
                Toggle.BorderSizePixel = 0

                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 5)
                ToggleCorner.Parent = Toggle

                local isToggled = false
                Toggle.MouseButton1Click:Connect(function()
                    isToggled = not isToggled
                    callback(isToggled)
                    Toggle.BackgroundColor3 = isToggled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(128, 128, 128)
                end)
            end

            return Groupbox
        end

        return Tab
    end

    -- Criando Tabs e Botões

    -- Tab Auto Farm
    local AutoFarmTab = Window:CreateTab("Auto Farm")
    local AutoFarmGroupbox = AutoFarmTab:CreateGroupbox("Auto Farm Options")
    AutoFarmGroupbox:CreateToggleButton("Baby Farm", function(isActive)
        if isActive then
            print("Baby Farm ativado!")
        else
            print("Baby Farm desativado!")
        end
    end)

    -- Tab Shop
    local ShopTab = Window:CreateTab("Shop")
    local ShopGroupbox = ShopTab:CreateGroupbox("Shop Options")
    ShopGroupbox:CreateButton("Open Shop", function() print("Shop opened!") end)
    ShopGroupbox:CreateToggle("Enable Item Buy", function(state) print("Item Buy toggled: " .. tostring(state)) end)

    -- Tab Config
    local ConfigTab = Window:CreateTab("Config")
    local ConfigGroupbox = ConfigTab:CreateGroupbox("Configuration Options")
    ConfigGroupbox:CreateButton("Save Config", function() print("Configuration saved!") end)
    ConfigGroupbox:CreateButton("Unload", function() Window:Unload() end)

    return Window
end

return Library
