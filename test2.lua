function Groupbox:CreateToggle(text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = ScrollingFrame
    ToggleFrame.Size = UDim2.new(1, -10, 0, 25)
    ToggleFrame.BackgroundTransparency = 1

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.Text = text
    ToggleLabel.Size = UDim2.new(0.85, -10, 1, 0) -- Deixa espaço para a caixa à direita
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleBox = Instance.new("TextButton")
    ToggleBox.Parent = ToggleFrame
    ToggleBox.Size = UDim2.new(0, 20, 0, 20) -- Tamanho da caixa quadrada
    ToggleBox.Position = UDim2.new(0.9, 0, 0.5, -10) -- Alinhamento à direita
    ToggleBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleBox.BorderSizePixel = 0
    ToggleBox.Text = ""
    
    -- Estilo arredondado para a caixa
    local ToggleBoxCorner = Instance.new("UICorner")
    ToggleBoxCorner.CornerRadius = UDim.new(0, 5)
    ToggleBoxCorner.Parent = ToggleBox

    local isToggled = false
    ToggleBox.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        callback(isToggled)
        ToggleBox.BackgroundColor3 = isToggled and Color3.fromRGB(75, 150, 255) or Color3.fromRGB(30, 30, 30)
    end)
end
