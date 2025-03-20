if getgenv().prtGrabLoaded then return print('Part Grabber is already running') end
getgenv().prtGrabLoaded = true

-- Improved UI and functionality for Part Grabber
local prtGrab = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Container = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local grab = Instance.new("TextButton")
local Found = Instance.new("TextLabel")
local del = Instance.new("TextButton")
local copy = Instance.new("TextButton")
local Topbar = Instance.new("Frame")
local Icon = Instance.new("ImageLabel")
local Exit = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local UIGradient_2 = Instance.new("UIGradient")
local UIStroke = Instance.new("UIStroke")
local StatusLabel = Instance.new("TextLabel")

-- Set up the ScreenGui
prtGrab.Name = "prtGrab"
prtGrab.Parent = gethui() or (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui"))
prtGrab.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
prtGrab.ResetOnSpawn = false

-- Main frame setup
Main.Name = "Main"
Main.Parent = prtGrab
Main.Active = true
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Draggable = true
Main.Position = UDim2.new(0.5, 0, 3, 0)
Main.Size = UDim2.new(0, 420, 0, 180)

-- Add a stroke to the main frame
UIStroke.Parent = Main
UIStroke.Color = Color3.fromRGB(60, 60, 255)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Container setup
Container.Name = "Container"
Container.Parent = Main
Container.AnchorPoint = Vector2.new(0.5, 1)
Container.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Container.BorderSizePixel = 0
Container.ClipsDescendants = true
Container.Position = UDim2.new(0.5, 0, 1, -5)
Container.Size = UDim2.new(1, -10, 1, -35)

UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = Container

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 25, 35)), 
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 20, 30)), 
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 25))
}
UIGradient.Parent = Container

-- Status label
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = Container
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
StatusLabel.BackgroundTransparency = 0.7
StatusLabel.BorderSizePixel = 0
StatusLabel.Position = UDim2.new(0.5, 0, 0.05, 0)
StatusLabel.Size = UDim2.new(0.9, 0, 0, 25)
StatusLabel.AnchorPoint = Vector2.new(0.5, 0)
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.Text = "Click on a part to select it"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
StatusLabel.TextSize = 14

-- Path display
Found.Name = "Found"
Found.Parent = Container
Found.Active = true
Found.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Found.BorderColor3 = Color3.fromRGB(60, 60, 255)
Found.BorderSizePixel = 1
Found.Position = UDim2.new(0.05, 0, 0.25, 0)
Found.Size = UDim2.new(0.9, 0, 0, 35)
Found.Font = Enum.Font.Code
Found.Text = ". . ."
Found.TextColor3 = Color3.fromRGB(220, 220, 255)
Found.TextScaled = true
Found.TextWrapped = true
Found.TextXAlignment = Enum.TextXAlignment.Center
Found.TextYAlignment = Enum.TextYAlignment.Center
Found.ClipsDescendants = true

-- Copy path button
grab.Name = "grab"
grab.Parent = Container
grab.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
grab.BorderSizePixel = 0
grab.Position = UDim2.new(0.05, 0, 0.65, 0)
grab.Size = UDim2.new(0.28, 0, 0, 35)
grab.Font = Enum.Font.GothamBold
grab.Text = "Copy Path"
grab.TextColor3 = Color3.fromRGB(220, 220, 255)
grab.TextSize = 14
grab.AutoButtonColor = true

-- Copy instance button
copy.Name = "copy"
copy.Parent = Container
copy.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
copy.BorderSizePixel = 0
copy.Position = UDim2.new(0.36, 0, 0.65, 0)
copy.Size = UDim2.new(0.28, 0, 0, 35)
copy.Font = Enum.Font.GothamBold
copy.Text = "Copy Instance"
copy.TextColor3 = Color3.fromRGB(220, 220, 255)
copy.TextSize = 14
copy.AutoButtonColor = true

-- Delete part button
del.Name = "del"
del.Parent = Container
del.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
del.BorderSizePixel = 0
del.Position = UDim2.new(0.67, 0, 0.65, 0)
del.Size = UDim2.new(0.28, 0, 0, 35)
del.Font = Enum.Font.GothamBold
del.Text = "Delete Part"
del.TextColor3 = Color3.fromRGB(255, 220, 220)
del.TextSize = 14
del.AutoButtonColor = true

-- Add corner radius to buttons
for _, button in pairs({grab, del, copy}) do
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
end

-- Topbar setup
Topbar.Name = "Topbar"
Topbar.Parent = Main
Topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Topbar.Size = UDim2.new(1, 0, 0, 30)

Icon.Name = "Icon"
Icon.Parent = Topbar
Icon.AnchorPoint = Vector2.new(0, 0.5)
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.Position = UDim2.new(0, 10, 0.5, 0)
Icon.Size = UDim2.new(0, 16, 0, 16)
Icon.Image = "rbxassetid://7733658504"

Exit.Name = "Exit"
Exit.Parent = Topbar
Exit.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Exit.BackgroundTransparency = 0.5
Exit.BorderSizePixel = 0
Exit.Position = UDim2.new(1, -30, 0, 0)
Exit.Size = UDim2.new(0, 30, 1, 0)
Exit.Font = Enum.Font.GothamBold
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 14.000
Exit.AutoButtonColor = true

Minimize.Name = "Minimize"
Minimize.Parent = Topbar
Minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
Minimize.BackgroundTransparency = 0.5
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(1, -60, 0, 0)
Minimize.Size = UDim2.new(0, 30, 1, 0)
Minimize.Font = Enum.Font.GothamBold
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextSize = 18.000
Minimize.AutoButtonColor = true

TopBar.Name = "TopBar"
TopBar.Parent = Topbar
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0, 30, 0, 0)
TopBar.Size = UDim2.new(1, -90, 1, 0)

Title.Name = "Title"
Title.Parent = TopBar
Title.AnchorPoint = Vector2.new(0, 0.5)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 10, 0.5, 0)
Title.Size = UDim2.new(1, -20, 1, -5)
Title.Font = Enum.Font.GothamBold
Title.Text = "Part Grabber v2.0"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.TextSize = 16.000
Title.TextXAlignment = Enum.TextXAlignment.Left

UICorner_2.CornerRadius = UDim.new(0, 9)
UICorner_2.Parent = Main

UIGradient_2.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 40)), 
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(25, 25, 35)), 
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 30, 40))
}
UIGradient_2.Parent = Main

-- Variables
local selectedPart = nil
local selectionBox = nil
local mouseConnection = nil

-- Functions
local function GetInstancePath(obj)
    local path = {}
    
    local function isService(obj)
        return obj.Parent == game and obj ~= game
    end
    
    if isService(obj) then
        table.insert(path, string.format('game:GetService("%s")', obj.ClassName))
    else
        while obj and obj.Parent do
            local name = obj.Name
            if name:match("^[%a_][%w_]*$") then
                table.insert(path, 1, "."..name)
            else
                table.insert(path, 1, string.format('["%s"]', name:gsub('"', '\\"')))
            end
            
            if isService(obj.Parent) then
                table.insert(path, 1, string.format('game:GetService("%s")', obj.Parent.ClassName))
                break
            end
            
            obj = obj.Parent
        end
    end
    
    return table.concat(path):gsub("^%.", "")
end

local function highlightPart(part)
    if selectionBox then selectionBox:Destroy() end
    
    selectionBox = Instance.new("SelectionBox")
    selectionBox.Adornee = part
    selectionBox.Name = "PartGrabberSelection"
    selectionBox.LineThickness = 0.03
    selectionBox.Color3 = Color3.fromRGB(60, 120, 255)
    selectionBox.SurfaceTransparency = 0.8
    selectionBox.SurfaceColor3 = Color3.fromRGB(60, 120, 255)
    selectionBox.Parent = part
    
    -- Add pulse animation
    spawn(function()
        local t = 0
        while selectionBox and selectionBox.Parent do
            t = t + 0.05
            selectionBox.Color3 = Color3.fromHSV(0.6, 0.7 + math.sin(t*2)*0.3, 1)
            wait(0.03)
        end
    end)
end

local function selectPart()
    local player = game:GetService("Players").LocalPlayer
    local mouse = player:GetMouse()
    
    if mouse.Target then
        selectedPart = mouse.Target
        Found.Text = " "..GetInstancePath(selectedPart)
        StatusLabel.Text = "Part selected: " .. selectedPart.Name
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        highlightPart(selectedPart)
    else
        StatusLabel.Text = "No part selected"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

-- Setup mouse connection
local function setupMouseConnection()
    local player = game:GetService("Players").LocalPlayer
    local mouse = player:GetMouse()
    
    mouse.TargetFilter = nil
    
    if mouseConnection then mouseConnection:Disconnect() end
    mouseConnection = mouse.Button1Down:Connect(selectPart)
end

-- Button functions
grab.MouseButton1Click:Connect(function()
    if Found.Text ~= ". . ." then
        setclipboard(Found.Text)
        StatusLabel.Text = "Path copied to clipboard!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        -- Flash effect
        grab.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        wait(0.3)
        grab.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    else
        StatusLabel.Text = "No part selected to copy"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

copy.MouseButton1Click:Connect(function()
    if selectedPart then
        local success, result = pcall(function()
            local instanceInfo = {
                ClassName = selectedPart.ClassName,
                Name = selectedPart.Name,
                Position = tostring(selectedPart.Position),
                Size = tostring(selectedPart.Size),
                Anchored = tostring(selectedPart.Anchored),
                CanCollide = tostring(selectedPart.CanCollide),
                Transparency = tostring(selectedPart.Transparency),
                Material = tostring(selectedPart.Material),
                Color = tostring(selectedPart.Color)
            }
            
            local infoText = "Instance Info:\n"
            for prop, value in pairs(instanceInfo) do
                infoText = infoText .. prop .. ": " .. value .. "\n"
            end
            
            return infoText
        end)
        
        if success then
            setclipboard(result)
            StatusLabel.Text = "Instance info copied to clipboard!"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            -- Flash effect
            copy.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
            wait(0.3)
            copy.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        else
            StatusLabel.Text = "Error copying instance info"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    else
        StatusLabel.Text = "No part selected to copy"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

del.MouseButton1Click:Connect(function()
    if selectedPart then
        local success, err = pcall(function()
            selectedPart:Destroy()
        end)
        
        if success then
            StatusLabel.Text = "Part deleted successfully"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            Found.Text = ". . ."
            selectedPart = nil
            if selectionBox then selectionBox:Destroy() selectionBox = nil end
            
            -- Flash effect
            del.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
            wait(0.3)
            del.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        else
            StatusLabel.Text = "Error deleting part: " .. tostring(err):sub(1, 30)
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    else
        StatusLabel.Text = "No part selected to delete"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

Exit.MouseButton1Click:Connect(function()
    prtGrab:Destroy()
    if mouseConnection then mouseConnection:Disconnect() end
    if selectionBox then selectionBox:Destroy() end
    selectedPart = nil
    getgenv().prtGrabLoaded = false
    
    -- Clean up any remaining UI elements
    for _, v in pairs(game:GetDescendants()) do
        if v.Name == "PartGrabberSelection" and v:IsA("SelectionBox") then
            v:Destroy()
        end
    end
end)

local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        Main:TweenSize(UDim2.new(0, 420, 0, 30), "Out", "Quint", 0.5, true)
        Minimize.Text = "+"
    else
        Main:TweenSize(UDim2.new(0, 420, 0, 180), "Out", "Quint", 0.5, true)
        Minimize.Text = "-"
    end
end)

-- Make the main frame draggable
Main.Active = true
Main.Draggable = true

-- Initial animation
Main:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 1, true)

-- Setup the mouse connection
setupMouseConnection()

-- Add hover effects to buttons
for _, button in pairs({grab, del, copy, Exit, Minimize}) do
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
    end)
end