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

function Library:CreateWindow(title, color)
    title = title or "HUD"
    color = color and Library:GetColor(color) or Color3.fromRGB(34, 87, 122)

    local WinTypes = {}
    local BracketV2 = Instance.new("ScreenGui")
    local core = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local tabbar = Instance.new("Frame")
    local container = Instance.new("Frame")

    BracketV2.Name = title
    BracketV2.Parent = game.CoreGui
    BracketV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    core.Name = "core"
    core.Parent = BracketV2
    core.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    core.BorderSizePixel = 0
    core.Position = UDim2.new(0.2, 0, 0.2, 0)
    core.Size = UDim2.new(0, 600, 0, 400)
    core.BackgroundTransparency = 0.1
    core.ClipsDescendants = true
    core.AnchorPoint = Vector2.new(0.5, 0.5)

    titleLabel.Name = "titleLabel"
    titleLabel.Parent = core
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0.02, 0, 0.01, 0)
    titleLabel.Size = UDim2.new(0.96, 0, 0.1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = color
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center

    tabbar.Name = "tabbar"
    tabbar.Parent = core
    tabbar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    tabbar.BorderSizePixel = 0
    tabbar.Position = UDim2.new(0, 0, 0.1, 0)
    tabbar.Size = UDim2.new(1, 0, 0.1, 0)
    tabbar.BackgroundTransparency = 0.2

    container.Name = "container"
    container.Parent = core
    container.BackgroundTransparency = 1
    container.Position = UDim2.new(0, 0, 0.2, 0)
    container.Size = UDim2.new(1, 0, 0.8, 0)

    function WinTypes:CreateTab(name)
        local TabTypes = {}
        local tab = Instance.new("TextButton")
        local Pattern = Instance.new("Frame")
        local Left = Instance.new("Frame")
        local Right = Instance.new("Frame")

        tab.Name = "tab"
        tab.Parent = tabbar
        tab.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        tab.BorderSizePixel = 0
        tab.Size = UDim2.new(0, tabbar.AbsoluteSize.X / (#tabbar:GetChildren() + 1), 0, 25)
        tab.Font = Enum.Font.Gotham
        tab.Text = name
        tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab.TextSize = 14

        Pattern.Name = "container"
        Pattern.Parent = container
        Pattern.BackgroundTransparency = 1
        Pattern.Size = UDim2.new(1, 0, 1, 0)
        Pattern.Visible = false

        Left.Name = "Left"
        Left.Parent = Pattern
        Left.Size = UDim2.new(0.5, -5, 1, 0)
        Left.BackgroundTransparency = 1

        Right.Name = "Right"
        Right.Parent = Pattern
        Right.Position = UDim2.new(0.5, 5, 0, 0)
        Right.Size = UDim2.new(0.5, -5, 1, 0)
        Right.BackgroundTransparency = 1

        tab.MouseButton1Click:Connect(function()
            Pattern.Visible = true
            for _, otherTab in pairs(container:GetChildren()) do
                if otherTab ~= Pattern then
                    otherTab.Visible = false
                end
            end
        end)

        if #tabbar:GetChildren() == 1 then
            Pattern.Visible = true
        end

        function TabTypes:CreateGroupbox(name, side)
            local GroupTypes = {}
            local groupbox = Instance.new("Frame")
            local title = Instance.new("TextLabel")
            local container = Instance.new("Frame")

            groupbox.Name = name
            groupbox.Parent = side == "Right" and Right or Left
            groupbox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            groupbox.BorderSizePixel = 0
            groupbox.Size = UDim2.new(1, -10, 0, 150)
            groupbox.Position = UDim2.new(0, 5, 0, 10)
            groupbox.BackgroundTransparency = 0.1

            title.Name = "title"
            title.Parent = groupbox
            title.Text = name
            title.Size = UDim2.new(1, 0, 0, 20)
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Font = Enum.Font.GothamSemibold
            title.BackgroundTransparency = 1

            container.Name = "container"
            container.Parent = groupbox
            container.BackgroundTransparency = 1
            container.Position = UDim2.new(0, 0, 0, 25)
            container.Size = UDim2.new(1, 0, 1, -25)

            function GroupTypes:CreateButton(text, callback)
                local button = Instance.new("TextButton")
                button.Parent = container
                button.Text = text
                button.Size = UDim2.new(1, -10, 0, 30)
                button.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 35)
                button.BackgroundColor3 = Color3.fromRGB(34, 87, 122)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.Font = Enum.Font.Gotham
                button.TextSize = 14
                button.BorderSizePixel = 0

                button.MouseButton1Click:Connect(callback)
            end

            function GroupTypes:CreateToggle(text, callback)
                local toggle = Instance.new("TextButton")
                local isEnabled = false

                toggle.Parent = container
                toggle.Text = text
                toggle.Size = UDim2.new(1, -10, 0, 30)
                toggle.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 35)
                toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                toggle.Font = Enum.Font.Gotham
                toggle.TextSize = 14
                toggle.BorderSizePixel = 0

                toggle.MouseButton1Click:Connect(function()
                    isEnabled = not isEnabled
                    callback(isEnabled)
                    toggle.BackgroundColor3 = isEnabled and Color3.fromRGB(19, 119, 255) or Color3.fromRGB(80, 80, 80)
                end)
            end

            function GroupTypes:CreateDropdown(text, options, callback)
                local dropdown = Instance.new("TextButton")
                dropdown.Parent = container
                dropdown.Text = text
                dropdown.Size = UDim2.new(1, -10, 0, 30)
                dropdown.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 35)
                dropdown.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.Font = Enum.Font.Gotham
                dropdown.TextSize = 14
                dropdown.BorderSizePixel = 0

                local list = Instance.new("Frame")
                list.Parent = dropdown
                list.Visible = false
                list.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                list.Position = UDim2.new(0, 0, 1, 0)
                list.Size = UDim2.new(1, 0, 0, #options * 30)

                for _, option in pairs(options) do
                    local optionButton = Instance.new("TextButton")
                    optionButton.Parent = list
                    optionButton.Text = option
                    optionButton.Size = UDim2.new(1, -10, 0, 30)
                    optionButton.Position = UDim2.new(0, 5, 0, (#list:GetChildren() - 1) * 35)
                    optionButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    optionButton.Font = Enum.Font.Gotham
                    optionButton.TextSize = 14
                    optionButton.BorderSizePixel = 0

                    optionButton.MouseButton1Click:Connect(function()
                        callback(option)
                        dropdown.Text = text .. ": " .. option
                        list.Visible = false
                    end)
                end

                dropdown.MouseButton1Click:Connect(function()
                    list.Visible = not list.Visible
                end)
            end

            return GroupTypes
        end

        return TabTypes
    end

    return WinTypes, BracketV2
end

return Library
