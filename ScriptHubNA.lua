local r = request or http_request or (syn and syn.request) or function() end
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui")
sg.Parent = (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"))

local f = Instance.new("Frame")
f.Size = UDim2.new(0, 400, 0, 350)
f.Position = UDim2.new(0.5, -200, 0.5, -175)
f.BackgroundTransparency = 0.1
f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
f.BorderSizePixel = 0
f.Active = true
f.Selectable = true
f.ClipsDescendants = true
f.Parent = sg

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0, 50)
c.Parent = f

local tb = Instance.new("TextBox")
tb.Size = UDim2.new(0, 250, 0, 30)
tb.Position = UDim2.new(0.5, -125, 0, 20)
tb.PlaceholderText = "Enter search query"
tb.BackgroundTransparency = 0.5
tb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tb.BorderSizePixel = 0
tb.TextColor3 = Color3.fromRGB(255, 255, 255)
tb.Text = ""
tb.Parent = f

local tbc = Instance.new("UICorner")
tbc.CornerRadius = UDim.new(0, 15)
tbc.Parent = tb

local sb = Instance.new("TextButton")
sb.Size = UDim2.new(0, 100, 0, 30)
sb.Position = UDim2.new(0.5, -50, 0, 60)
sb.Text = "Search"
sb.BackgroundTransparency = 0.5
sb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
sb.BorderSizePixel = 0
sb.TextColor3 = Color3.fromRGB(255, 255, 255)
sb.Parent = f

local sbc = Instance.new("UICorner")
sbc.CornerRadius = UDim.new(0, 15)
sbc.Parent = sb

local sf = Instance.new("ScrollingFrame")
sf.Size = UDim2.new(0, 380, 0, 200)
sf.Position = UDim2.new(0, 10, 0, 100)
sf.BackgroundTransparency = 0.5
sf.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
sf.BorderSizePixel = 0
sf.ScrollBarThickness = 8
sf.CanvasSize = UDim2.new(0, 0, 0, 0)
sf.ClipsDescendants = true
sf.Parent = f

local sfc = Instance.new("UICorner")
sfc.CornerRadius = UDim.new(0, 20)
sfc.Parent = sf

local cb = Instance.new("TextButton")
cb.Size = UDim2.new(0, 30, 0, 30)
cb.Position = UDim2.new(1, -40, 0, 10)
cb.Text = "X"
cb.BackgroundTransparency = 0.5
cb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
cb.BorderSizePixel = 0
cb.TextColor3 = Color3.fromRGB(255, 255, 255)
cb.Parent = f

local cbc = Instance.new("UICorner")
cbc.CornerRadius = UDim.new(0, 15)
cbc.Parent = cb

local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 30, 0, 30)
mb.Position = UDim2.new(1, -80, 0, 10)
mb.Text = "-"
mb.BackgroundTransparency = 0.5
mb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mb.BorderSizePixel = 0
mb.TextColor3 = Color3.fromRGB(255, 255, 255)
mb.Parent = f

local mbc = Instance.new("UICorner")
mbc.CornerRadius = UDim.new(0, 15)
mbc.Parent = mb

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

f.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = f.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

f.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

uis.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local function toggleMin()
    local goal = {}
    if sf.Visible then
        goal.Size = UDim2.new(0, 400, 0, 50)
        sf.Visible = false
        tb.Visible = false
        sb.Visible = false
    else
        goal.Size = UDim2.new(0, 400, 0, 350)
        sf.Visible = true
        tb.Visible = true
        sb.Visible = true
    end

    local tween = ts:Create(f, TweenInfo.new(0.5), goal)
    tween:Play()
end

mb.MouseButton1Click:Connect(toggleMin)

cb.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

local function search(q)
    local url = "https://www.scriptblox.com/api/script/search?q=" .. q
    local res = r({
        Url = url,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"
        }
    })

    if res and res.Success then
        local results = res.Body
        local decoded = game:GetService("HttpService"):JSONDecode(results)
        if decoded and decoded.result and decoded.result.scripts then
            local scripts = {}
            for _, script in ipairs(decoded.result.scripts) do
                if script.slug and script.title and script.script then
                    table.insert(scripts, {
                        rawLink = script.script,
                        title = script.title,
                        key = script.key,
                        isUniversal = script.isUniversal,
                        isPatched = script.isPatched,
                        views = script.views
                    })
                end
            end

            if #scripts > 0 then
                sf:ClearAllChildren()
                sf.CanvasSize = UDim2.new(0, 0, 0, #scripts * 160)
                for i, script in ipairs(scripts) do
                    local b = Instance.new("TextButton")
                    b.Size = UDim2.new(0, 280, 0, 30)
                    b.Position = UDim2.new(0.5, -140, 0, (i - 1) * 160)
                    b.Text = script.title
                    b.BackgroundTransparency = 0.5
                    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    b.BorderSizePixel = 0
                    b.TextColor3 = Color3.fromRGB(255, 255, 255)
                    b.TextWrapped = true
                    b.Parent = sf

                    local bc = Instance.new("UICorner")
                    bc.CornerRadius = UDim.new(0, 15)
                    bc.Parent = b

                    local keyLabel = Instance.new("TextLabel")
                    keyLabel.Size = UDim2.new(0, 280, 0, 20)
                    keyLabel.Position = UDim2.new(0.5, -140, 0, (i - 1) * 160 + 40)
                    keyLabel.Text = "Key: " .. tostring(script.key)
                    keyLabel.BackgroundTransparency = 1
                    keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    keyLabel.Parent = sf

                    local isUniversalLabel = Instance.new("TextLabel")
                    isUniversalLabel.Size = UDim2.new(0, 280, 0, 20)
                    isUniversalLabel.Position = UDim2.new(0.5, -140, 0, (i - 1) * 160 + 60)
                    isUniversalLabel.Text = "Is Universal: " .. tostring(script.isUniversal)
                    isUniversalLabel.BackgroundTransparency = 1
                    isUniversalLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    isUniversalLabel.Parent = sf

                    local isPatchedLabel = Instance.new("TextLabel")
                    isPatchedLabel.Size = UDim2.new(0, 280, 0, 20)
                    isPatchedLabel.Position = UDim2.new(0.5, -140, 0, (i - 1) * 160 + 80)
                    isPatchedLabel.Text = "Is Patched: " .. tostring(script.isPatched)
                    isPatchedLabel.BackgroundTransparency = 1
                    isPatchedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    isPatchedLabel.Parent = sf

                    local viewsLabel = Instance.new("TextLabel")
                    viewsLabel.Size = UDim2.new(0, 280, 0, 20)
                    viewsLabel.Position = UDim2.new(0.5, -140, 0, (i - 1) * 160 + 100)
                    viewsLabel.Text = "Views: " .. tostring(script.views)
                    viewsLabel.BackgroundTransparency = 1
                    viewsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    viewsLabel.Parent = sf

                    b.MouseButton1Click:Connect(function()
                        loadstring(script.rawLink)()
                    end)
                end
            else
                sf:ClearAllChildren()
                local noResultsLabel = Instance.new("TextLabel")
                noResultsLabel.Size = UDim2.new(1, 0, 0, 30)
                noResultsLabel.Position = UDim2.new(0, 0, 0, 0)
                noResultsLabel.Text = "No ScriptBlox links found"
                noResultsLabel.BackgroundTransparency = 0.5
                noResultsLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                noResultsLabel.BorderSizePixel = 0
                noResultsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                noResultsLabel.Parent = sf
            end
        else
            sf:ClearAllChildren()
            local errorLabel = Instance.new("TextLabel")
            errorLabel.Size = UDim2.new(1, 0, 0, 30)
            errorLabel.Position = UDim2.new(0, 0, 0, 0)
            errorLabel.Text = "Failed to retrieve data from ScriptBlox"
            errorLabel.BackgroundTransparency = 0.5
            errorLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            errorLabel.BorderSizePixel = 0
            errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            errorLabel.Parent = sf
        end
    else
        sf:ClearAllChildren()
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(1, 0, 0, 30)
        errorLabel.Position = UDim2.new(0, 0, 0, 0)
        errorLabel.Text = "Failed to retrieve data from ScriptBlox"
        errorLabel.BackgroundTransparency = 0.5
        errorLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        errorLabel.BorderSizePixel = 0
        errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        errorLabel.Parent = sf
    end
end

sb.MouseButton1Click:Connect(function()
    local q = tb.Text
    if q ~= "" then
        search(q)
    else
        sf:ClearAllChildren()
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(1, 0, 0, 30)
        errorLabel.Position = UDim2.new(0, 0, 0, 0)
        errorLabel.Text = "Please enter a search query"
        errorLabel.BackgroundTransparency = 0.5
        errorLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        errorLabel.BorderSizePixel = 0
        errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        errorLabel.Parent = sf
    end
end)