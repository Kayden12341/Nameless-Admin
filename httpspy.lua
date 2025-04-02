local HttpSpy = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local Topbar = Instance.new("Frame")
local Icon = Instance.new("ImageLabel")
local Exit = Instance.new("TextButton")
local ExitCorner = Instance.new("UICorner")
local Minimize = Instance.new("TextButton")
local MinimizeCorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local MainContainer = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local UICorner_2 = Instance.new("UICorner")
local TemplateText = Instance.new("TextButton")
local TemplateCorner = Instance.new("UICorner")

function protectUI(sGui)
    local function blankfunction(...)
        return ...
    end

    local cloneref = cloneref or blankfunction

    local function SafeGetService(service)
        return cloneref(game:GetService(service)) or game:GetService(service)
    end

    local COREGUI = SafeGetService("CoreGui")
    local rPlayer = SafeGetService("Players"):FindFirstChildWhichIsA("Player")
    local coreGuiProtection = {}
    local RunService = SafeGetService("RunService")
    local LocalPlayer = SafeGetService("Players").LocalPlayer

    local function NAProtection(inst, var)
        if inst then
            if var then
                inst[var] = "\0"
                inst.Archivable = false
            else
                inst.Name = "\0"
                inst.Archivable = false
            end
        end
    end

    if (get_hidden_gui or gethui) then
        local hiddenUI = (get_hidden_gui or gethui)
        NAProtection(sGui)
        sGui.Parent = hiddenUI()
        return sGui
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
        NAProtection(sGui)
        syn.protect_gui(sGui)
        sGui.Parent = COREGUI
        return sGui
    elseif COREGUI:FindFirstChildWhichIsA("ScreenGui") then
        pcall(function()
            for _, v in pairs(sGui:GetDescendants()) do
                coreGuiProtection[v] = rPlayer.Name
            end
            sGui.DescendantAdded:Connect(function(v)
                coreGuiProtection[v] = rPlayer.Name
            end)
            coreGuiProtection[sGui] = rPlayer.Name

            local meta = getrawmetatable(game)
            local tostr = meta.__tostring
            setreadonly(meta, false)
            meta.__tostring = newcclosure(function(t)
                if coreGuiProtection[t] and not checkcaller() then
                    return coreGuiProtection[t]
                end
                return tostr(t)
            end)
        end)
        if not RunService:IsStudio() then
            local newGui = COREGUI:FindFirstChildWhichIsA("ScreenGui")
            newGui.DescendantAdded:Connect(function(v)
                coreGuiProtection[v] = rPlayer.Name
            end)
            for _, v in pairs(sGui:GetChildren()) do
                v.Parent = newGui
            end
            sGui = newGui
        end
        return sGui
    elseif COREGUI then
        NAProtection(sGui)
        sGui.Parent = COREGUI
        return sGui
    elseif LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        NAProtection(sGui)
        sGui.Parent = LocalPlayer:FindFirstChild("PlayerGui")
        return sGui
    else
        return nil
    end
end

HttpSpy.Name = "HttpSpy"
protectUI(HttpSpy)
HttpSpy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HttpSpy.ResetOnSpawn = false

Background.Name = "Background"
Background.Parent = HttpSpy
Background.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Background.BorderColor3 = Color3.fromRGB(139, 139, 139)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.5, -200, 0.5, -150)
Background.Size = UDim2.new(0, 400, 0, 300)
Background.Active = true
Background.Draggable = true

Topbar.Name = "Topbar"
Topbar.Parent = Background
Topbar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Topbar.Size = UDim2.new(1, 0, 0, 30)

Icon.Name = "Icon"
Icon.Parent = Topbar
Icon.AnchorPoint = Vector2.new(0, 0.5)
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.Position = UDim2.new(0, 10, 0.5, 0)
Icon.Size = UDim2.new(0, 16, 0, 16)
Icon.Image = "rbxassetid://6031280882" -- Network icon

Title.Name = "Title"
Title.Parent = Topbar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 35, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.SourceSansSemibold
Title.Text = "HTTP Spy"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18.000
Title.TextXAlignment = Enum.TextXAlignment.Left

Exit.Name = "Exit"
Exit.Parent = Topbar
Exit.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
Exit.Position = UDim2.new(1, -30, 0.5, -10)
Exit.Size = UDim2.new(0, 20, 0, 20)
Exit.Font = Enum.Font.GothamSemibold
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 14.000
Exit.MouseButton1Click:Connect(function()
    HttpSpy:Destroy()
end)

ExitCorner.CornerRadius = UDim.new(0, 4)
ExitCorner.Parent = Exit

Minimize.Name = "Minimize"
Minimize.Parent = Topbar
Minimize.BackgroundColor3 = Color3.fromRGB(75, 75, 255)
Minimize.Position = UDim2.new(1, -60, 0.5, -10)
Minimize.Size = UDim2.new(0, 20, 0, 20)
Minimize.Font = Enum.Font.GothamSemibold
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextSize = 18.000
Minimize.MouseButton1Click:Connect(function()
    MainContainer.Visible = not MainContainer.Visible
end)

MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = Minimize

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Background

MainContainer.Name = "MainContainer"
MainContainer.Parent = Background
MainContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainContainer.BorderSizePixel = 0
MainContainer.Position = UDim2.new(0, 5, 0, 35)
MainContainer.Size = UDim2.new(1, -10, 1, -40)
MainContainer.BottomImage = "rbxassetid://6889858496"
MainContainer.MidImage = "rbxassetid://6889858039"
MainContainer.ScrollBarThickness = 4
MainContainer.TopImage = "rbxassetid://6889857425"
MainContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
MainContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
MainContainer.ScrollingDirection = Enum.ScrollingDirection.Y

UIListLayout.Parent = MainContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

UICorner_2.CornerRadius = UDim.new(0, 6)
UICorner_2.Parent = MainContainer

TemplateText.Name = "TemplateText"
TemplateText.Parent = MainContainer
TemplateText.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TemplateText.BorderSizePixel = 0
TemplateText.Size = UDim2.new(1, -10, 0, 30)
TemplateText.Font = Enum.Font.SourceSans
TemplateText.Text = "template"
TemplateText.TextColor3 = Color3.fromRGB(255, 255, 255)
TemplateText.TextSize = 14.000
TemplateText.TextWrapped = true
TemplateText.TextXAlignment = Enum.TextXAlignment.Left
TemplateText.TextYAlignment = Enum.TextYAlignment.Center
TemplateText.Visible = false
TemplateText.AutomaticSize = Enum.AutomaticSize.Y
TemplateText.Position = UDim2.new(0, 5, 0, 0)

TemplateCorner.CornerRadius = UDim.new(0, 4)
TemplateCorner.Parent = TemplateText

local function updateCanvasSize()
    local contentSize = UIListLayout.AbsoluteContentSize
    MainContainer.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
end

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

local function Log(text, headers)
    local Label = TemplateText:Clone()
    Label.Visible = true
    
    if headers and type(headers) == "table" then 
        local headerText = " (HEADERS: "
        for Index, Value in next, headers do 
            headerText = headerText .. tostring(Index) .. ": " .. tostring(Value) .. ", "
        end
        headerText = headerText:sub(1, -3) .. ")"
        text = text .. headerText
    end
    
    Label.Text = text 
    Label.Parent = MainContainer
    
    Label.MouseButton1Click:Connect(function()
        setclipboard(text)
    end)
    
    updateCanvasSize()
    return Label
end

local oldHttpGet
oldHttpGet = hookfunction(game.HttpGet, function(self, url, ...)
    Log("HttpGet: " .. tostring(url))
    return oldHttpGet(self, url, ...)
end)

local oldHttpPost
oldHttpPost = hookfunction(game.HttpPost, function(self, url, data, ...)
    Log("HttpPost: " .. tostring(url))
    return oldHttpPost(self, url, data, ...)
end)

local oldHttpGetAsync
oldHttpGetAsync = hookfunction(game.HttpGetAsync, function(self, url, ...)
    Log("HttpGetAsync: " .. tostring(url))
    return oldHttpGetAsync(self, url, ...)
end)

local oldHttpPostAsync
oldHttpPostAsync = hookfunction(game.HttpPostAsync, function(self, url, data, ...)
    Log("HttpPostAsync: " .. tostring(url))
    return oldHttpPostAsync(self, url, data, ...)
end)

local success, result = pcall(function()
    if syn and syn.request then 
        local oldSynRequest = syn.request
        syn.request = function(data)
            Log("syn.request: " .. tostring(data.Url) .. " (" .. (data.Method or "GET") .. ")", data.Headers)
            return oldSynRequest(data)
        end
        return true
    elseif request then
        local oldRequest = request
        request = function(data)
            Log("request: " .. tostring(data.Url) .. " (" .. (data.Method or "GET") .. ")", data.Headers)
            return oldRequest(data)
        end
        return true
    elseif http and http.request then
        local oldHttpRequest = http.request
        http.request = function(data)
            Log("http.request: " .. tostring(data.Url) .. " (" .. (data.Method or "GET") .. ")", data.Headers)
            return oldHttpRequest(data)
        end
        return true
    elseif http_request then
        local oldHttpRequest = http_request
        http_request = function(data)
            Log("http_request: " .. tostring(data.Url) .. " (" .. (data.Method or "GET") .. ")", data.Headers)
            return oldHttpRequest(data)
        end
        return true
    end
    return false
end)

if not success or not result then
    Log("WARNING: Could not hook request function. Your exploit might not be fully supported.")
end

Log("HTTP Spy initialized. Click on any request to copy it to clipboard.")