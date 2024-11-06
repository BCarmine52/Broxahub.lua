local Library = {}

function Library:CreateWindow(title)
    title = title or "HUD"

    local Window = {}
    local GUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local TabBar = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")

    -- Configuração da ScreenGui para dispositivos móveis e PC
    GUI.Name = "CustomHUD"
    GUI.Parent = game.CoreGui
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    GUI.ResetOnSpawn = false

    -- Main Frame centralizado com animação de início
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = GUI
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.fromScale(0.5, 0.5)  -- Centraliza a HUD no meio da tela
    MainFrame.Size = UDim2.new(0, 310, 0, 0)  -- Começa com altura 0 para a animação
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)  -- Garante centralização ao redor do ponto médio
    MainFrame.BackgroundTransparency = 0
    MainFrame.ClipsDescendants = true

    -- Animação de início
    MainFrame:TweenSize(UDim2.new(0, 310, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)

    -- Cantos arredondados para o MainFrame
    local MainFrameCorner = Instance.new("UICorner")
    MainFrameCorner.CornerRadius = UDim.new(0, 10)
    MainFrameCorner.Parent = MainFrame

    -- Título
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, -40, 0, 30)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- Botão de minimizar
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = MainFrame
    MinimizeButton.Text = "-"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0.92, 0, 0, 0)
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
    TabContainer.Position = UDim2.new(0, 0, 0, 55)
    TabContainer.Size = UDim2.new(1, 0, 1, -55)

    -- Layout for Tabs
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabBar
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)

    -- Função para descarregar a HUD
    function Window:Unload()
        GUI:Destroy()
    end

    function Window:CreateTab(name)
        local Tab = {}
        name = name or "Tab"

        -- Tab Button com animação de seleção
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

        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 5)
        TabButtonCorner.Parent = TabButton

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

            -- Animação de seleção de tab com mudança de cor
            for _, button in pairs(TabBar:GetChildren()) do
                if button:IsA("TextButton") then
                    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                end
            end

            TabButton:TweenBackgroundColor3(Color3.fromRGB(75, 150, 255), "Out", "Quad", 0.3, true)
        end)

        if #TabContainer:GetChildren() == 1 then
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(75, 150, 255)  -- Define a primeira tab como ativa
        end

        function Tab:CreateGroupbox()
            local Groupbox = {}

            -- Scrolling Frame para permitir rolagem nos botões
            local ScrollingFrame = Instance.new("ScrollingFrame")
            ScrollingFrame.Parent = TabFrame
            ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
            ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
            ScrollingFrame.BackgroundTransparency = 1
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
            ScrollingFrame.ScrollBarThickness = 10

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = ScrollingFrame
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 5)

            function Groupbox:CreateButton(text, callback)
                local Button = Instance.new("TextButton")
                Button.Parent = ScrollingFrame
                Button.Text = text
                Button.Size = UDim2.new(1, -10, 0, 25)
                Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 14
                Button.BorderSizePixel = 0
                Button.MouseButton1Click:Connect(callback)

                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 5)
                ButtonCorner.Parent = Button
            end

            function Groupbox:CreateToggle(text, callback)
                local Toggle = Instance.new("TextButton")
                Toggle.Parent = ScrollingFrame
                Toggle.Text = text
                Toggle.Size = UDim2.new(1, -10, 0, 25)
                Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.Font = Enum.Font.Gotham
                Toggle.TextSize = 14
                Toggle.BorderSizePixel = 0
                local isToggled = false

                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 5)
                ToggleCorner.Parent = Toggle

                Toggle.MouseButton1Click:Connect(function()
                    isToggled = not isToggled
                    callback(isToggled)
                    Toggle.BackgroundColor3 = isToggled and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(30, 30, 30)
                end)
            end

            return Groupbox
        end

        return Tab
    end

    return Window
end

return Library
