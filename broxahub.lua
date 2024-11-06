-- Biblioteca ajustada
local Library = {}

function Library:GetColor(color, table)
    table = table or false
    if (color.R == nil) then return Color3.fromRGB(19, 119, 255) end

    local ColorRed = math.round(color.R * 255)
    local ColorGreen = math.round(color.G * 255)
    local ColorBlue = math.round(color.B * 255)

    if (table) then
        return {
            Red = ColorRed,
            Green = ColorGreen,
            Blue = ColorBlue,
        }
    else
        return Color3.fromRGB(ColorRed, ColorGreen, ColorBlue)
    end
end

function Library:GetSide(LeftSize, RightSize)
    if LeftSize - 1 > RightSize - 1 then
        return "Right"
    else
        return "Left"
    end
end

function Library:CreateWindow(title, color)
    title = title or "Bracket Lib V2"
    color = color and Library:GetColor(color) or Color3.fromRGB(19, 119, 255)

    -- Definindo variáveis e instâncias principais
    local WinTypes = {}
    local WindowDragging, SliderDragging, ColorPickerDragging = false, false, false
    local keybind = "RightControl"
    local cancbind = false

    -- Instâncias da janela
    local BracketV2 = Instance.new("ScreenGui")
    local core = Instance.new("Frame")
    local title_18 = Instance.new("TextLabel")
    local outlinecore = Instance.new("Frame")
    local inline = Instance.new("Frame")
    local inlineoutline = Instance.new("Frame")
    local inlinecore = Instance.new("Frame")
    local tabbar = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local container = Instance.new("Frame")

    -- Propriedades da Janela
    BracketV2.Name = title
    BracketV2.Parent = game.CoreGui
    BracketV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    core.Name = "core"
    core.Parent = BracketV2
    core.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    core.BorderColor3 = Color3.fromRGB(8, 8, 8)
    core.Position = UDim2.new(0.156000003, 0, 0.140000001, 0)
    core.Size = UDim2.new(0, 540, 0, 531)

    outlinecore.Name = "outlinecore"
    outlinecore.Parent = core
    outlinecore.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    outlinecore.BorderSizePixel = 0
    outlinecore.Position = UDim2.new(0, 1, 0, 1)
    outlinecore.Size = UDim2.new(0, 538, 0, 529)

    title_18.Name = "title"
    title_18.Parent = outlinecore
    title_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title_18.BackgroundTransparency = 1.000
    title_18.Position = UDim2.new(0.0185185187, 0, 0.00188323914, 0)
    title_18.Size = UDim2.new(0, 521, 0, 23)
    title_18.Font = Enum.Font.SourceSans
    title_18.Text = title
    title_18.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_18.TextSize = 18.000
    title_18.TextStrokeTransparency = 0.000
    title_18.TextXAlignment = Enum.TextXAlignment.Left

    inline.Name = "inline"
    inline.Parent = outlinecore
    inline.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    inline.BorderSizePixel = 0
    inline.Position = UDim2.new(0, 7, 0, 23)
    inline.Size = UDim2.new(0, 525, 0, 500)

    inlineoutline.Name = "inlineoutline"
    inlineoutline.Parent = inline
    inlineoutline.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    inlineoutline.BorderSizePixel = 0
    inlineoutline.Position = UDim2.new(0, 1, 0, 1)
    inlineoutline.Size = UDim2.new(0, 523, 0, 498)

    inlinecore.Name = "inlinecore"
    inlinecore.Parent = inlineoutline
    inlinecore.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    inlinecore.BorderSizePixel = 0
    inlinecore.Position = UDim2.new(0, 1, 0, 1)
    inlinecore.Size = UDim2.new(0, 521, 0, 496)

    tabbar.Name = "tabbar"
    tabbar.Parent = inlinecore
    tabbar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    tabbar.BorderColor3 = Color3.fromRGB(8, 8, 8)
    tabbar.Size = UDim2.new(0, 521, 0, 25)

    UIListLayout.Parent = tabbar
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    container.Name = "container"
    container.Parent = inlinecore
    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    container.BackgroundTransparency = 1.000
    container.BorderSizePixel = 0
    container.Position = UDim2.new(0, 0, 0.0504032262, 0)
    container.Size = UDim2.new(1, 0, 0.949596763, 0)

    -- Código para arrastar a janela
    local userinputservice = game:GetService("UserInputService")
    local dragInput, dragStart, startPos = nil, nil, nil

    core.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and userinputservice:GetFocusedTextBox() == nil then
            dragStart = input.Position
            startPos = core.Position
            WindowDragging = true
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    WindowDragging = false
                end
            end)
        end
    end)

    core.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    userinputservice.InputChanged:Connect(function(input)
        if input == dragInput and WindowDragging and not SliderDragging and not ColorPickerDragging then
            local Delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            core.Position = Position
        end
    end)

    userinputservice.InputBegan:Connect(function(input)
        if (cancbind) then
            if (input.KeyCode == Enum.KeyCode[keybind]) then
                BracketV2.Enabled = not BracketV2.Enabled
            end
        else
            if (input.KeyCode == Enum.KeyCode.RightControl) then
                BracketV2.Enabled = not BracketV2.Enabled
            end
        end
    end)

    -- Window Types
    function WinTypes:Destroy()
        BracketV2:Destroy()
    end

    function WinTypes:UpdateColor(newcolor)
        color = Library:GetColor(newcolor)
    end

    function WinTypes:UpdateBind(bind, custombind)
        keybind = bind
        cancbind = custombind
    end

    -- Adicione suas funções de interface aqui:
    -- Funções de CreateToggle, CreateButton, CreateDropdown, etc.

    return WinTypes, BracketV2
end

return Library
