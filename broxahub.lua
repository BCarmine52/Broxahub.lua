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
    title = title or "Bracket Lib V2"
    color = color and Library:GetColor(color) or Color3.fromRGB(19, 119, 255)

    local WinTypes = {}
    local BracketV2 = Instance.new("ScreenGui")
    local core = Instance.new("Frame")
    local title_18 = Instance.new("TextLabel")
    local tabbar = Instance.new("Frame")
    local container = Instance.new("Frame")

    BracketV2.Name = title
    BracketV2.Parent = game.CoreGui
    BracketV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    core.Name = "core"
    core.Parent = BracketV2
    core.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    core.BorderColor3 = Color3.fromRGB(8, 8, 8)
    core.Position = UDim2.new(0.156, 0, 0.14, 0)
    core.Size = UDim2.new(0, 540, 0, 531)

    title_18.Name = "title"
    title_18.Parent = core
    title_18.BackgroundTransparency = 1
    title_18.Position = UDim2.new(0.02, 0, 0.01, 0)
    title_18.Size = UDim2.new(0, 521, 0, 23)
    title_18.Font = Enum.Font.SourceSans
    title_18.Text = title
    title_18.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_18.TextSize = 18
    title_18.TextXAlignment = Enum.TextXAlignment.Left

    tabbar.Name = "tabbar"
    tabbar.Parent = core
    tabbar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    tabbar.BorderColor3 = Color3.fromRGB(8, 8, 8)
    tabbar.Size = UDim2.new(0, 521, 0, 25)

    container.Name = "container"
    container.Parent = core
    container.BackgroundTransparency = 1
    container.Position = UDim2.new(0, 0, 0.05, 0)
    container.Size = UDim2.new(1, 0, 0.95, 0)

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
        tab.Font = Enum.Font.SourceSans
        tab.Text = name
        tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab.TextSize = 18

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
            groupbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            groupbox.Size = UDim2.new(1, 0, 0, 100)
            
            title.Name = "title"
            title.Parent = groupbox
            title.Text = name
            title.Size = UDim2.new(1, 0, 0, 20)
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.BackgroundTransparency = 1

            container.Name = "container"
            container.Parent = groupbox
            container.BackgroundTransparency = 1
            container.Position = UDim2.new(0, 0, 0, 20)
            container.Size = UDim2.new(1, 0, 1, -20)

            function GroupTypes:CreateButton(text, callback)
                local button = Instance.new("TextButton")
                button.Parent = container
                button.Text = text
                button.Size = UDim2.new(1, -10, 0, 30)
                button.Position = UDim2.new(0, 5, 0, #container:GetChildren() * 35)
                button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)

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
