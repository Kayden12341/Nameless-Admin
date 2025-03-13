local N = Instance.new("ScreenGui")
local M = Instance.new("Frame")
local UC = Instance.new("UICorner")
local UG = Instance.new("UIGradient")
local C = Instance.new("Frame")
local SF = Instance.new("ScrollingFrame")
local TB = Instance.new("TextBox")
local TBa = Instance.new("Frame")
local I = Instance.new("ImageLabel")
local EB = Instance.new("TextButton")
local MB = Instance.new("TextButton")
local T = Instance.new("TextLabel")

N.Name = "Notepad"
N.Parent = gethui() or (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui"))
N.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

M.Name = "Main"
M.Parent = N
M.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
M.BackgroundTransparency = 0.2
M.BorderSizePixel = 0
M.ClipsDescendants = true
M.AnchorPoint = Vector2.new(0.5, 0.5)
M.Position = UDim2.new(0.5, 0, 1.5, 0)
M.Size = UDim2.new(0, 402, 0, 235)
M.Active = true
M.Draggable = true

UC.CornerRadius = UDim.new(0, 20)
UC.Parent = M

UG.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(12, 4, 20)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(12, 4, 20))
}
UG.Parent = M

C.Name = "Container"
C.Parent = M
C.BackgroundTransparency = 1.0
C.Size = UDim2.new(1, 0, 1, 0)

SF.Parent = C
SF.Active = true
SF.BackgroundTransparency = 1.0
SF.BorderSizePixel = 0
SF.Position = UDim2.new(0.5, -201, 0, 35)
SF.Size = UDim2.new(0, 402, 1, -45)
SF.ScrollBarThickness = 3
SF.CanvasSize = UDim2.new(0, 0, 3, 0)

TB.Parent = SF
TB.BackgroundTransparency = 1.0
TB.Size = UDim2.new(1, 0, 0, 0)
TB.ClearTextOnFocus = false
TB.Font = Enum.Font.SourceSans
TB.MultiLine = true
TB.PlaceholderText = "Enter your text here."
TB.Text = ""
TB.TextColor3 = Color3.fromRGB(255, 255, 255)
TB.TextSize = 18.0
TB.TextXAlignment = Enum.TextXAlignment.Left
TB.TextYAlignment = Enum.TextYAlignment.Top
TB.Changed:Connect(function()
    TB.Size = UDim2.new(1, 0, 0, TB.TextBounds.Y)
    SF.CanvasSize = UDim2.new(0, 0, 0, TB.TextBounds.Y)
end)

TBa.Name = "TopBar"
TBa.Parent = M
TBa.BackgroundTransparency = 1.0
TBa.Size = UDim2.new(1, 0, 0, 25)

I.Name = "Icon"
I.Parent = TBa
I.AnchorPoint = Vector2.new(0, 0.5)
I.BackgroundTransparency = 1.0
I.Position = UDim2.new(0, 10, 0.5, 0)
I.Size = UDim2.new(0, 13, 0, 13)
I.Image = "rbxgameasset://Images/menuIcon"

EB.Name = "ExitButton"
EB.Parent = TBa
EB.BackgroundTransparency = 1.0
EB.BorderSizePixel = 0
EB.Position = UDim2.new(0.94, 0, 0, 0)
EB.Size = UDim2.new(0, 25, 1, 0)
EB.Font = Enum.Font.Gotham
EB.Text = "X"
EB.TextColor3 = Color3.fromRGB(255, 255, 255)
EB.TextSize = 13.0

MB.Name = "MinimizeButton"
MB.Parent = TBa
MB.BackgroundTransparency = 1.0
MB.BorderSizePixel = 0
MB.Position = UDim2.new(0.89, 0, 0, 0)
MB.Size = UDim2.new(0, 25, 1, 0)
MB.Font = Enum.Font.Gotham
MB.Text = "-"
MB.TextColor3 = Color3.fromRGB(255, 255, 255)
MB.TextSize = 18.0

T.Name = "Title"
T.Parent = TBa
T.AnchorPoint = Vector2.new(0.5, 0.5)
T.BackgroundTransparency = 1.0
T.Position = UDim2.new(0.5, 0, 0.5, 0)
T.Size = UDim2.new(0, 200, 1, 0)
T.Font = Enum.Font.SourceSansLight
T.Text = "Notepad"
T.TextColor3 = Color3.fromRGB(255, 255, 255)
T.TextSize = 17.0
T.TextWrapped = true

local function exitButtonClick()
    EB.MouseButton1Click:Connect(function()
        N:Destroy()
    end)
end
coroutine.wrap(exitButtonClick)()

local function minimizeButtonClick()
    local isMinimized = false
    MB.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        M:TweenSize(isMinimized and UDim2.new(0, 402, 0, 25) or UDim2.new(0, 402, 0, 235), "Out", "Quint", 1, true)
    end)
end
coroutine.wrap(minimizeButtonClick)()

local function initializeUI()
    M:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 1, true)
end
coroutine.wrap(initializeUI)()