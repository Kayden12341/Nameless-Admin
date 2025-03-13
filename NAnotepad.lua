local Notepad = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Container = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local ScrollingFrame = Instance.new("ScrollingFrame")
local TextBox = Instance.new("TextBox")
local Topbar = Instance.new("Frame")
local Icon = Instance.new("ImageLabel")
local Exit = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local Minimize = Instance.new("TextButton")
local ImageLabel_2 = Instance.new("ImageLabel")
local TopBar = Instance.new("Frame")
local ImageLabel_3 = Instance.new("ImageLabel")
local ImageLabel_4 = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local UIGradient_2 = Instance.new("UIGradient")

Notepad.Name = "Notepad"
Notepad.Parent = gethui() or (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui"))
Notepad.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = Notepad
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BackgroundTransparency = 0.140
Main.BorderColor3 = Color3.fromRGB(139, 139, 139)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Position = UDim2.new(0.307999998, 0, 1.26199996, 0)
Main.Size = UDim2.new(0, 402, 0, 235)

Container.Name = "Container"
Container.Parent = Main
Container.AnchorPoint = Vector2.new(0.5, 1)
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.BackgroundTransparency = 0.500
Container.BorderColor3 = Color3.fromRGB(255, 255, 255)
Container.BorderSizePixel = 0
Container.ClipsDescendants = true
Container.Position = UDim2.new(0.5, 0, 0.995999992, -5)
Container.Size = UDim2.new(1, -10, 1.00800002, -30)

UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = Container

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(12, 4, 20)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(12, 4, 20)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(12, 4, 20))}
UIGradient.Parent = Container

ScrollingFrame.Parent = Container
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1.000
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(-1.55701926e-07, 0, 0, 0)
ScrollingFrame.Size = UDim2.new(0, 386, 0, 202)
ScrollingFrame.ScrollBarThickness = 3

TextBox.Parent = ScrollingFrame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.Position = UDim2.new(0.0103625357, 0, 0.0120885866, 0)
TextBox.Size = UDim2.new(0, 376, 0, 201)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.SourceSans
TextBox.MultiLine = true
TextBox.PlaceholderText = "Enter you text here."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 18.000
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top

Topbar.Name = "Topbar"
Topbar.Parent = Main
Topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Topbar.BackgroundTransparency = 1.000
Topbar.Size = UDim2.new(1, 0, 0, 25)

Icon.Name = "Icon"
Icon.Parent = Topbar
Icon.AnchorPoint = Vector2.new(0, 0.5)
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.Position = UDim2.new(0, 10, 0.5, 0)
Icon.Size = UDim2.new(0, 13, 0, 13)
Icon.Image = "rbxgameasset://Images/menuIcon"

Exit.Name = "Exit"
Exit.Parent = Topbar
Exit.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Exit.BackgroundTransparency = 0.500
Exit.BorderSizePixel = 0
Exit.Position = UDim2.new(0.870000005, 0, 0, 0)
Exit.Size = UDim2.new(-0.00899999961, 40, 1.04299998, -10)
Exit.Font = Enum.Font.Gotham
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 13.000

ImageLabel.Parent = Exit
ImageLabel.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(0.999998331, 0, 0, 0)
ImageLabel.Size = UDim2.new(0, 9, 0, 16)
ImageLabel.Image = "http://www.roblox.com/asset/?id=8650484523"
ImageLabel.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel.ImageTransparency = 0.500

Minimize.Name = "Minimize"
Minimize.Parent = Topbar
Minimize.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Minimize.BackgroundTransparency = 0.500
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0.804174006, 0, 0, 0)
Minimize.Size = UDim2.new(0.00100000005, 27, 1.04299998, -10)
Minimize.Font = Enum.Font.Gotham
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextSize = 18.000

ImageLabel_2.Parent = Minimize
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.Position = UDim2.new(-0.441000015, 0, 0, 0)
ImageLabel_2.Size = UDim2.new(0, 12, 0, 16)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=10555881849"
ImageLabel_2.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel_2.ImageTransparency = 0.500

TopBar.Name = "TopBar"
TopBar.Parent = Topbar
TopBar.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
TopBar.BackgroundTransparency = 0.500
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0.265715331, 0, -0.00352294743, 0)
TopBar.Size = UDim2.new(0, 186, 0, 16)

ImageLabel_3.Parent = TopBar
ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_3.BackgroundTransparency = 1.000
ImageLabel_3.Position = UDim2.new(1, 0, 0.0590000004, 0)
ImageLabel_3.Size = UDim2.new(0, 12, 0, 15)
ImageLabel_3.Image = "http://www.roblox.com/asset/?id=8650484523"
ImageLabel_3.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel_3.ImageTransparency = 0.500

ImageLabel_4.Parent = TopBar
ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_4.BackgroundTransparency = 1.000
ImageLabel_4.Position = UDim2.new(-0.0817726701, 0, 0, 0)
ImageLabel_4.Size = UDim2.new(0, 16, 0, 16)
ImageLabel_4.Image = "http://www.roblox.com/asset/?id=10555881849"
ImageLabel_4.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel_4.ImageTransparency = 0.500

Title.Name = "Title"
Title.Parent = TopBar
Title.AnchorPoint = Vector2.new(0, 0.5)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Position = UDim2.new(-0.150533721, 32, 0.415876389, 0)
Title.Size = UDim2.new(0.522161067, 80, 1.11675644, -7)
Title.Font = Enum.Font.SourceSansLight
Title.Text = "Notepad"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17.000
Title.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0, 9)
UICorner_2.Parent = Main

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(12, 4, 20)), ColorSequenceKeypoint.new(0.38, Color3.fromRGB(4, 4, 4)), ColorSequenceKeypoint.new(0.52, Color3.fromRGB(4, 4, 4)), ColorSequenceKeypoint.new(0.68, Color3.fromRGB(4, 4, 4)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(12, 4, 20))}
UIGradient_2.Parent = Main

local function exitbtn()
	Exit.MouseButton1Click:Connect(function()
		Exit.Parent.Parent.Parent:Destroy()
	end)
end
coroutine.wrap(exitbtn)()
local function minimizetoggl()
	p = false
	Minimize.MouseButton1Click:Connect(function()
		if not p then
			p = not p
			Minimize.Parent.Parent:TweenSize(UDim2.new(0, 402, 0, 20), "Out", "Quint", 1, true)
		else
			p = not p
			Minimize.Parent.Parent:TweenSize(UDim2.new(0, 402, 0, 235), "Out", "Quint", 1, true)
		end
	end)
end
coroutine.wrap(minimizetoggl)()
local function uifuncs()
	Main.Active = true
	Main.Parent.ResetOnSpawn = false
	Main.Draggable = true
end
coroutine.wrap(uifuncs)()
local function iappear()
	Main:TweenPosition(UDim2.new(0.308, 0,0.262, 0), "Out", "Quint",1,true)
end
coroutine.wrap(iappear)()