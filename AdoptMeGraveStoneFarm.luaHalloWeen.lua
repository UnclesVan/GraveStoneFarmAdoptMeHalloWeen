local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
local titleLabel = Instance.new("TextLabel", frame)
local checkBox = Instance.new("TextButton", frame)
local closeButton = Instance.new("TextButton", frame)
local scrollingTextLabel = Instance.new("TextLabel", frame)
local inDevelopmentLabel = Instance.new("TextLabel", frame)
local arrowLabel = Instance.new("TextLabel", frame)
local arrowTextLabel = Instance.new("TextLabel", frame)
local quoteLabel = Instance.new("TextLabel", frame)

-- GUI Properties
frame.Size = UDim2.new(0.4, 0, 0.4, 0)
frame.Position = UDim2.new(0.5, -200, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundTransparency = 0.5
frame.ClipsDescendants = true

-- Title Label Properties
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Position = UDim2.new(0, 0, 0.05, 0)
titleLabel.Text = "Simple Gravestone Farm"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 47

-- In Development Label Properties
inDevelopmentLabel.Size = UDim2.new(1, 0, 0.1, 0)
inDevelopmentLabel.Position = UDim2.new(0, 0, 0.25, 0)
inDevelopmentLabel.Text = "In Development"
inDevelopmentLabel.TextColor3 = Color3.fromRGB(255, 165, 0)  -- Orange
inDevelopmentLabel.BackgroundTransparency = 1
inDevelopmentLabel.Font = Enum.Font.SourceSansBold
inDevelopmentLabel.TextSize = 24

-- Checkbox Properties
checkBox.Size = UDim2.new(0.3, 0, 0.1, 0)
checkBox.Position = UDim2.new(0.15, 0, 0.4, 0)
checkBox.Text = "Enable Teleport"
checkBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
checkBox.TextColor3 = Color3.new(1, 1, 1)
checkBox.BorderSizePixel = 0

-- Close Button Properties
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 10)
closeButton.Text = "✖"
closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)  -- Dark Red
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BorderSizePixel = 0

-- Scrolling Text Properties
scrollingTextLabel.Size = UDim2.new(1, 0, 0.1, 0)
scrollingTextLabel.Position = UDim2.new(0, 0, 0.15, 0)
scrollingTextLabel.Text = "🎃 Enjoy the Halloween event! 🎃"
scrollingTextLabel.TextColor3 = Color3.fromRGB(255, 165, 0)  -- Orange
scrollingTextLabel.BackgroundTransparency = 1
scrollingTextLabel.Font = Enum.Font.SourceSans
scrollingTextLabel.TextSize = 24

-- Arrow Label Properties (Left Arrow)
arrowLabel.Size = UDim2.new(0.1, 0, 0.1, 0)
arrowLabel.Position = UDim2.new(0.55, 0, 0.4, 0)
arrowLabel.Text = "⬅️"
arrowLabel.BackgroundTransparency = 1
arrowLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White
arrowLabel.Font = Enum.Font.SourceSans
arrowLabel.TextSize = 20

-- Arrow Text Label Properties
arrowTextLabel.Size = UDim2.new(0.4, 0, 0.1, 0)
arrowTextLabel.Position = UDim2.new(0.62, 0, 0.4, 0)
arrowTextLabel.Text = "Press this to teleport to graves"
arrowTextLabel.BackgroundTransparency = 1
arrowTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White
arrowTextLabel.Font = Enum.Font.SourceSans
arrowTextLabel.TextSize = 20

-- Quote Label Properties
quoteLabel.Size = UDim2.new(1, 0, 0.1, 0)
quoteLabel.Position = UDim2.new(0, 0, 0.55, 0)  -- Positioned below other UI elements
quoteLabel.Text = "Random Quote: \"Life is but a dream.\""
quoteLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White
quoteLabel.BackgroundTransparency = 1
quoteLabel.Font = Enum.Font.SourceSans
quoteLabel.TextSize = 20

local teleporting = false  -- Flag to control teleportation

-- Function to teleport to gravestones
local function teleportToGravestones()
    local gravestonesFolder = workspace:FindFirstChild("Interiors") and
                              workspace.Interiors:FindFirstChild("MainMap!Fall") and
                              workspace.Interiors["MainMap!Fall"].Event.Halloween2024.Graveyard.Gravestones

    if gravestonesFolder then
        for _, gravestone in ipairs(gravestonesFolder:GetChildren()) do
            local interactionPart = gravestone:FindFirstChild("InteractionPart")
            if interactionPart and interactionPart:IsA("Part") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = interactionPart.CFrame
                task.wait(2)  -- Slower teleport (2 seconds delay)
                if not teleporting then
                    break  -- Exit the loop if teleporting is disabled
                end
            end
        end
    else
        warn("Gravestones folder not found!")
    end
end

-- Toggle checkbox text and appearance
checkBox.MouseButton1Click:Connect(function()
    if checkBox.Text == "Enable Teleport" then
        checkBox.Text = "✔ Enabled"
        checkBox.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Green when checked
        teleporting = true  -- Start teleporting
        teleportToGravestones()  -- Teleport to gravestones when checked
    else
        checkBox.Text = "Enable Teleport"
        checkBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)  -- Gray when unchecked
        teleporting = false  -- Stop teleporting
    end
end)

-- Close the GUI when the close button is clicked
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Make GUI draggable
local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- Function to scroll text
local function scrollText()
    while true do
        for i = 0, 100 do
            scrollingTextLabel.Position = UDim2.new(-1 + (i / 100) * 2, 0, 0.15, 0)  -- Move towards the center
            task.wait(0.05)  -- Adjust speed here if needed
        end
        scrollingTextLabel.Position = UDim2.new(1, 0, 0.15, 0)  -- Reset position to start off-screen to the right
    end
end

scrollText()  -- Start scrolling text
