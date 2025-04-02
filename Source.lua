if getgenv().RealNamelessLoaded then return end

local req = request or http_request or (syn and syn.request) or function() end

function NACaller(pp)--helps me log better
	local s,err=pcall(pp)
	if not s then print("NA script err: "..err) end
end

NACaller(function() getgenv().RealNamelessLoaded=true end)
NACaller(function() getgenv().NATestingVer=false end)

NAbegin=tick()

function blankfunction(...)
	return ...
end

local cloneref = cloneref or blankfunction

function SafeGetService(service)
	return cloneref(game:GetService(service)) or game:GetService(service)
end

function isAprilFools()
	local d = os.date("*t")
	return (d.month == 4 and d.day == 1) or (getgenv and getgenv().ActivateAprilMode) or false
end

function MockText(text)
	local mockedText = ""
	local toggle = true
	for i = 1, #text do
		local char = text:sub(i, i)
		if char:match("%a") then
			mockedText = mockedText..(toggle and char:upper() or char:lower())
			toggle = not toggle
		else
			mockedText = mockedText..char
		end
	end
	return mockedText
end

function NAProtection(inst,var)
	if inst then
		if var then
			inst[var]="\0"
			inst.Archivable=false
		else
			inst.Name="\0"
			inst.Archivable=false
		end
	end
end

function NaProtectUI(sGui)
	local cGUI = SafeGetService("CoreGui")
	local rPlr = SafeGetService("Players"):FindFirstChildWhichIsA("Player")
	local cGUIProtect = {}
	local rService = SafeGetService("RunService")
	local lPlr = SafeGetService("Players").LocalPlayer

	if (get_hidden_gui or gethui) then
		local hiddenUI = (get_hidden_gui or gethui)
		NAProtection(sGui)
		sGui.Parent = hiddenUI()
		return sGui
	elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
		NAProtection(sGui)
		syn.protect_gui(sGui)
		sGui.Parent = cGUI
		return sGui
	elseif cGUI:FindFirstChildWhichIsA("ScreenGui") then
		pcall(function()
			for _, v in pairs(sGui:GetDescendants()) do
				cGUIProtect[v] = rPlr.Name
			end
			sGui.DescendantAdded:Connect(function(v)
				cGUIProtect[v] = rPlr.Name
			end)
			cGUIProtect[sGui] = rPlr.Name

			local meta = getrawmetatable(game)
			local tostr = meta.__tostring
			setreadonly(meta, false)
			meta.__tostring = newcclosure(function(t)
				if cGUIProtect[t] and not checkcaller() then
					return cGUIProtect[t]
				end
				return tostr(t)
			end)
		end)
		if not rService:IsStudio() then
			local newGui = cGUI:FindFirstChildWhichIsA("ScreenGui")
			newGui.DescendantAdded:Connect(function(v)
				cGUIProtect[v] = rPlr.Name
			end)
			for _, v in pairs(sGui:GetChildren()) do
				v.Parent = newGui
			end
			sGui = newGui
		end
		return sGui
	elseif cGUI then
		NAProtection(sGui)
		sGui.Parent = cGUI
		return sGui
	elseif lPlr and lPlr:FindFirstChild("PlayerGui") then
		NAProtection(sGui)
		sGui.Parent = lPlr:FindFirstChild("PlayerGui")
		return sGui
	else
		return nil
	end
end

--[[ Version ]]--
local curVer = isAprilFools() and string.format("%.1f", math.random() * 1000.0) or "2.3"

--[[ Brand ]]--
local mainName = 'Nameless Admin'
local testingName = 'NA Testing'
local adminName = 'NA'

function yayApril(t)
	local variants = {
		t and "Clueless Testing" or "Clueless Admin";
		t and "Gay Testing" or "Gay Admin";
		t and "Infinite Testing" or "Infinite Admin";
		t and "Sussy Testing" or "Sussy Admin";
		t and "Broken Testing" or "Broken Admin";
		t and "Shadow Testing" or "Shadow Admin";
		t and "Quirky Testing" or "Quirky Admin";
		t and "Zoomy Testing" or "Zoomy Admin";
		t and "Wacky Testing" or "Wacky Admin";
		t and "Booba Testing" or "Booba Admin";
		t and "Spicy Testing" or "Spicy Admin";
		t and "Meme Testing" or "Meme Admin";
		t and "Doofy Testing" or "Doofy Admin";
		t and "Silly Testing" or "Silly Admin";
		t and "Goblin Testing" or "Goblin Admin"
	}
	return variants[math.random(#variants)]
end

local function getSeasonEmoji()
	local date = os.date("*t")
	local month = date.month
	local day = date.day

	if month == 1 and day == 1 then
		return '🎉' -- New Year's Day
	elseif month == 2 and day >= 1 and day <= 21 then
		return '🧧' -- Chinese New Year
	elseif month == 2 and day == 14 then
		return '❤️' -- Valentine's Day
	elseif month == 3 and day == 17 then
		return '☘️' -- St. Patrick's Day
	elseif month == 4 and day >= 1 and day <= 15 then
		return '🥚' -- Easter
	elseif month == 5 then
		return '💐' -- Mother's Day
	elseif month == 6 then
		return '👔' -- Father's Day
	elseif month == 6 and day == 21 then
		return '☀️' -- Summer Solstice
	elseif month == 9 and day == 22 then
		return '🍂' -- Autumn Equinox
	elseif month == 10 and day == 31 then
		return '🎃' -- Halloween
	elseif month == 11 and day >= 22 and day <= 30 then
		return '🦃' -- Thanksgiving
	elseif month == 12 and day == 25 then
		return '🎄' -- Christmas
	elseif month == 12 and day == 31 then
		return '🎆' -- New Year's Eve
	elseif month == 12 or month == 1 or month == 2 then
		return '❄️' -- Winter
	elseif month == 3 or month == 4 or month == 5 then
		return '🌸' -- Spring
	elseif month == 6 or month == 7 or month == 8 then
		return '☀️' -- Summer
	elseif month == 9 or month == 10 or month == 11 then
		return '🍂' -- Autumn
	end

	return ''
end


if getgenv().NATestingVer then
	if isAprilFools() then
		testingName = yayApril(true)
		testingName = MockText(testingName)
	end
	adminName = testingName
else
	if isAprilFools() then
		mainName = yayApril(false)
		mainName = MockText(mainName)
	end
	adminName = mainName
end

if not gethui then
	getgenv().gethui=function()
		local h=(SafeGetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui") or SafeGetService("CoreGui") or Players.LocalPlayer:FindFirstChild("PlayerGui"))
		return h
	end
end

if (identifyexecutor():lower() == "solara" or identifyexecutor():lower() == "xeno") or not fireproximityprompt then
	getgenv().fireproximityprompt = function(pp)
		local originalEnabled = pp.Enabled
		local originalHoldDuration = pp.HoldDuration
		local originalRequiresLineOfSight = pp.RequiresLineOfSight

		pp.Enabled = true
		pp.HoldDuration = 0
		pp.RequiresLineOfSight = false

		task.wait(0.23)
		pp:InputHoldBegin()
		task.wait()
		pp:InputHoldEnd()

		pp.Enabled = originalEnabled
		pp.HoldDuration = originalHoldDuration
		pp.RequiresLineOfSight = originalRequiresLineOfSight
	end
end

local GetService=game.GetService

NA_storage=Instance.new("ScreenGui")--Stupid Ahh script removing folders

if not game:IsLoaded() then
	local waiting=Instance.new("Message")
	NaProtectUI(waiting)
	waiting.Text=adminName..' is waiting for the game to load'
	game.Loaded:Wait()
	waiting:Destroy()
end

local githubUrl = ''
local loader=''
local NAimageButton=nil

if getgenv().NATestingVer then
	loader=[[loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NA%20testing.lua"))();]]
	githubUrl="https://api.github.com/repos/ltseverydayyou/Nameless-Admin/commits?path=NA%20testing.lua"
else
	loader=[[loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))();]]
	githubUrl="https://api.github.com/repos/ltseverydayyou/Nameless-Admin/commits?path=Source.lua"
end

local queueteleport=(syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport) or function() end

--Notification library
local Notification=nil

repeat 
	local s,r=pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NamelessAdminNotifications.lua"))()
	end);

	if s then
		Notification=r;
	else
		warn("Couldn't load notification module, retrying...");
		task.wait();
	end
until Notification~=nil --waits for the module to load (cause loadstring takes ages)

local Notify=Notification.Notify;

function DoNotif(txt,dur,naem)
	if not dur then dur=5 end
	if not naem then naem=adminName end
	Notify({
		Description=txt;
		Title=naem;
		Duration=dur;
	});
end

wait();--added wait due to the Http being a bit delayed on returning (should fix the issue where Nameless Admin wouldn't load sometimes)

--Custom file functions checker checker
local CustomFunctionSupport=isfile and isfolder and writefile and readfile and listfiles;
local FileSupport=isfile and isfolder and writefile and readfile and makefolder;

--Creates folder & files for Prefix & Plugins
if FileSupport then
	if not isfolder("Nameless-Admin") then
		makefolder("Nameless-Admin")
	end

	if not isfile("Nameless-Admin/Prefix.txt") then
		writefile("Nameless-Admin/Prefix.txt", ";")
	end

	if not isfile("Nameless-Admin/ImageButtonSize.txt") then
		writefile("Nameless-Admin/ImageButtonSize.txt", "1")
	end
end

local prefixCheck = ";"
local NAScale = 1

if FileSupport then
	prefixCheck = readfile("Nameless-Admin/Prefix.txt")
	NAsavedScale = tonumber(readfile("Nameless-Admin/ImageButtonSize.txt"))

	if prefixCheck:match("[a-zA-Z0-9]") then
		prefixCheck = ";"
		writefile("Nameless-Admin/Prefix.txt", ";")
		DoNotif("Your prefix has been reset to the default (;) because it contained letters or numbers")
	end

	if NAsavedScale and NAsavedScale > 0 then
		NAScale = NAsavedScale
	else
		NAScale = 1
		writefile("Nameless-Admin/ImageButtonSize.txt", "1")
		DoNotif("ImageButton size has been reset to default due to invalid data.")
	end
else
	prefixCheck = ";"
	NAScale = 1
	DoNotif("Your exploit does not support read/write file")
end
--[[ PREFIX AND OTHER STUFF. ]]--
local opt={
	prefix=prefixCheck,
	tupleSeparator=',',
	ui={},
	keybinds={},
}

--[[ Update Logs ]]--
local updLogs = {}

local updDate="unknown" --month,day,year

pcall(function()
	local response = req({
		Url = githubUrl,
		Method = "GET"
	})

	if response and response.StatusCode == 200 then
		local json = SafeGetService("HttpService"):JSONDecode(response.Body)
		if json and json[1] and json[1].commit and json[1].commit.author and json[1].commit.author.date then
			local year, month, day = json[1].commit.author.date:match("(%d+)-(%d+)-(%d+)")
			updDate = month.."/"..day.."/"..year
		end
	end
end)

--[[ VARIABLES ]]--

local PlaceId,JobId,GameId=game.PlaceId,game.JobId,game.GameId
local Players=game:GetService("Players");
local UserInputService=SafeGetService("UserInputService");
local ProximityPromptService=SafeGetService("ProximityPromptService");
local TweenService=SafeGetService("TweenService");
local RunService=SafeGetService("RunService");
local TeleportService=SafeGetService("TeleportService");
local HttpService=SafeGetService('HttpService');
local StarterGui=SafeGetService("StarterGui");
local SoundService=SafeGetService("SoundService");
local Lighting=SafeGetService("Lighting");
local ReplicatedStorage=SafeGetService("ReplicatedStorage");
local GuiService=SafeGetService("GuiService");
local COREGUI=SafeGetService("CoreGui");
local AvatarEditorService = SafeGetService("AvatarEditorService");
local ChatService = SafeGetService("Chat");
local TextChatService = SafeGetService("TextChatService");
local CaptureService = SafeGetService("CaptureService");
local IsOnMobile=false--table.find({Enum.Platform.IOS,Enum.Platform.Android},UserInputService:GetPlatform());
local IsOnPC=false--table.find({Enum.Platform.Windows,Enum.Platform.UWP,Enum.Platform.Linux,Enum.Platform.SteamOS,Enum.Platform.OSX,Enum.Platform.Chromecast,Enum.Platform.WebOS},UserInputService:GetPlatform());
local sethidden=sethiddenproperty or set_hidden_property or set_hidden_prop
local Player=Players.LocalPlayer;
local plr=Players.LocalPlayer;
local PlrGui=Player:FindFirstChild("PlayerGui");
--local IYLOADED=false--This is used for the ;iy command that executes infinite yield commands using this admin command script (BTW)
local Character=Player.Character;
local Humanoid=Character and Character:FindFirstChildWhichIsA("Humanoid") or nil;
local LegacyChat=TextChatService.ChatVersion==Enum.ChatVersion.LegacyChatService
local FakeLag=false
local Loopvoid=false
local loopgrab=false
local Loopmute=false
local OrgDestroyHeight = SafeGetService("Workspace").FallenPartsDestroyHeight
local Watch=false
local Admin={}
local playerButtons={}
CoreGui=COREGUI;
_G.NAadminsLol={
	530829101; --Viper
	229501685; --legshot
	817571515; --Aimlock
	144324719; --Cosmic
	1844177730; --glexinator
	2624269701; --Akim
	2502806181; -- null
	1594235217; -- Purple
	1620986547; -- pc alt
}

if UserInputService.TouchEnabled then
	IsOnMobile=true
end

if UserInputService.KeyboardEnabled then
	IsOnPC=true
end

--[[ Some more variables ]]--

localPlayer=Player
LocalPlayer=Player
local character=Player.Character
local mouse=localPlayer:GetMouse()
local camera=SafeGetService("Workspace").CurrentCamera
local Commands,Aliases={},{}
local player,plr,lp=Players.LocalPlayer,Players.LocalPlayer,Players.LocalPlayer
local ctrlModule = nil

pcall(function()
	local player = Players.LocalPlayer
	local plrScripts = player:FindFirstChildOfClass("PlayerScripts")
	if plrScripts then
		local plrModule = plrScripts:WaitForChild("PlayerModule", 5)
		if plrModule then
			local modell = plrModule:WaitForChild("ControlModule", 5)
			if modell then
				ctrlModule = require(modell)
			end
		end
	end
end)

local bringc={}

--[[ Welcome Messages ]]--
local msg={
	"Hey";
	"Hello";
	"Hi";
	"Hi There";
	"Hola";
	"Welcome";
	"Greetings";
	"Good day";
	"Howdy";
	"Salutations";
	"Hey there";
	"What's up";
	"G'day";
	"Bonjour";
	"Ciao";
}

--[[ Prediction ]]--
function levenshtein(s,t)
	local d={}
	local lenS,lenT=#s,#t
	for i=0,lenS do
		d[i]={}
		d[i][0]=i
	end
	for j=0,lenT do
		d[0][j]=j
	end
	for i=1,lenS do
		for j=1,lenT do
			local cost=(s:sub(i,i)==t:sub(j,j)) and 0 or 1
			d[i][j]=math.min(d[i-1][j]+1,d[i][j-1]+1,d[i-1][j-1]+cost)
		end
	end
	return d[lenS][lenT]
end

function didYouMean(arg)
	local closer=nil
	local min=math.huge

	for cmd in pairs(Commands) do
		local j=levenshtein(arg,cmd)
		if j<min then
			min=j
			closer=cmd
		end
	end

	for alias in pairs(Aliases) do
		local j=levenshtein(arg,alias)
		if j<min then
			min=j
			closer=alias
		end
	end

	return closer
end

function isRelAdmin(Player)
	for _, id in ipairs(_G.NAadminsLol) do
		if Player.UserId == id then
			return true
		end
	end
	return false
end

function loadedResults(res)
	if res == nil or type(res) ~= "number" then 
		res = 0 
	end

	local sec = tonumber(res)
	local isNegative = sec < 0

	if isNegative then
		sec = math.abs(sec)
	end

	local days = math.floor(sec / 86400)
	local hr = math.floor((sec % 86400) / 3600)
	local min = math.floor((sec % 3600) / 60)
	local remain = sec % 60
	local ms = math.floor((remain % 1) * 1000)
	remain = math.floor(remain)

	local function formatTime(days, hr, min, remain, ms)
		if days > 0 then
			return string.format("%d:%02d:%02d:%02d.%03d | Days,Hours,Minutes,Seconds.Milliseconds", 
				days, hr, min, remain, ms)
		elseif hr > 0 then
			return string.format("%d:%02d:%02d.%03d | Hours,Minutes,Seconds.Milliseconds", 
				hr, min, remain, ms)
		elseif min > 0 then
			return string.format("%d:%02d.%03d | Minutes,Seconds.Milliseconds", 
				min, remain, ms)
		else
			return string.format("%d.%03d | Seconds.Milliseconds", 
				remain, ms)
		end
	end

	local formattedTime = formatTime(days, hr, min, remain, ms)

	if isNegative then
		formattedTime = "-"..formattedTime
	end

	return formattedTime
end


--[[ COMMAND FUNCTIONS ]]--
local commandcount=0
cmd={}
Loops = {}
cmd.add = function(aliases, info, func, requiresArguments)
	requiresArguments = requiresArguments or false
	for i, cmdName in pairs(aliases) do
		if i == 1 then
			Commands[cmdName:lower()] = {func, info, requiresArguments}
		else
			Aliases[cmdName:lower()] = {func, info, requiresArguments}
		end
	end
	commandcount = commandcount + 1
end

cmd.run = function(args)
	local caller, arguments = args[1], args
	table.remove(args, 1)

	local success, msg = pcall(function()
		local command = Commands[caller:lower()] or Aliases[caller:lower()]
		if command then
			command[1](unpack(arguments))
		else
			local closest = didYouMean(caller:lower())
			if closest then
				local commandFunc = Commands[closest] and Commands[closest][1] or Aliases[closest] and Aliases[closest][1]
				local requiresInput = Commands[closest] and Commands[closest][3] or Aliases[closest] and Aliases[closest][3]

				if requiresInput then
					Notify({
						Title = adminName,
						Description = "Command [ "..caller.." ] doesn't exist\nDid you mean [ "..closest.." ]?",
						InputField = true,
						Buttons = {
							{
								Text = "Submit",
								Callback = function(input)
									local parsedArguments = ParseArguments(input)
									if parsedArguments then
										task.spawn(function()
											commandFunc(unpack(parsedArguments))
										end)
									else
										task.spawn(function()
											commandFunc()
										end)
									end
								end
							},
							{
								Text = "Cancel",
								Callback = function() end
							}
						}
					})
				else
					Notify({
						Title = adminName,
						Description = "Command [ "..caller.." ] doesn't exist\nDid you mean [ "..closest.." ]?",
						Buttons = {
							{
								Text = "Run Command",
								Callback = function()
									task.spawn(function()
										commandFunc()
									end)
								end
							},
							{
								Text = "Cancel",
								Callback = function() end
							}
						}
					})
				end
			end
		end
	end)
	if not success then end
end

cmd.loop = function(commandName, args)
	local command = Commands[commandName:lower()] or Aliases[commandName:lower()]
	if not command then
		DoNotif("Command '"..commandName.."' does not exist.", 3)
		return
	end

	local loopKey = commandName:lower()

	if Loops[loopKey] then
		DoNotif("A loop for command '"..commandName.."' is already running.", 3)
		return
	end

	Notify({
		Title = "Set Loop Delay",
		Description = "Enter the delay (in seconds) for the loop of command: "..commandName,
		InputField = true,
		Buttons = {
			{
				Text = "Submit",
				Callback = function(input)
					local interval = tonumber(input) or 0
					if not interval or interval < 0 then
						DoNotif("Invalid delay. Loop not started.", 3)
						return
					end

					Loops[loopKey] = {
						command = command[1],
						interval = interval,
						args = args or {},
						running = true
					}

					task.spawn(function()
						while Loops[loopKey] and Loops[loopKey].running do
							Loops[loopKey].command(unpack(Loops[loopKey].args))
							task.wait(Loops[loopKey].interval)
						end
					end)

					DoNotif("Loop started for command: '"..commandName.."' with delay: "..interval.." seconds.", 3)
				end
			},
			{
				Text = "Cancel",
				Callback = function()
					DoNotif("Loop creation canceled.", 2)
				end
			}
		}
	})
end

cmd.stopLoop = function()
	if next(Loops) == nil then
		DoNotif("No active loops to stop.", 2)
		return
	end

	local buttons = {}
	for loopKey, loopData in pairs(Loops) do
		table.insert(buttons, {
			Text = "Stop '"..loopKey.."'",
			Callback = function()
				Loops[loopKey].running = false
				Loops[loopKey] = nil
				DoNotif("Loop '"..loopKey.."' has been stopped.", 3)
			end
		})
	end

	table.insert(buttons, {
		Text = "Cancel",
		Callback = function()
			DoNotif("No loops were stopped.", 2)
		end
	})

	Notify({
		Title = "Stop a Loop",
		Description = "Select a loop to stop:",
		Buttons = buttons
	})
end

function ParseArguments(input)
	if not input or input:match("^%s*$") then
		return nil
	end

	local args = {}
	for arg in string.gmatch(input, "[^%s]+") do
		table.insert(args, arg)
	end
	return args
end

function randomString()
	local length=math.random(10,20)
	local array={}
	for i=1,length do
		array[i]=string.char(math.random(32,126))
	end
	return table.concat(array)
end

--[[ Fully setup Nameless admin storage ]]
NA_storage.Name=randomString()
NaProtectUI(NA_storage)

--[[ LIBRARY FUNCTIONS ]]--
local lib={}
lib.wrap=function(f)
	return coroutine.wrap(f)()
end

local wrap=lib.wrap

local wait=function(int)
	if not int then int=0 end
	local t=tick()
	repeat
		RunService.Heartbeat:Wait(0)
	until (tick()-t) >=int
	return (tick()-t),t
end

function IsR15(plr)
	plr=(plr or Players.LocalPlayer)
	if plr then
		if plr.Character:FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
			return true
		end
	end
	return false
end

function IsR6(Player)
	Player=(Player or Players.LocalPlayer)
	if Player then
		if Player.Character.Humanoid.RigType==Enum.HumanoidRigType.R6 then
			return true
		end
	end
	return false
end

function rngMsg()
	return msg[math.random(1,#msg)]
end

function getRoot(char)
	return char:FindFirstChild("HumanoidRootPart") or 
		char:FindFirstChild("Torso") or 
		char:FindFirstChild("UpperTorso")
end

function getTorso(char)
	return char:FindFirstChild("Torso") or 
		char:FindFirstChild("UpperTorso") or 
		char:FindFirstChild("LowerTorso") or
		char:FindFirstChild("HumanoidRootPart")
end

function getChar()
	local player = Players.LocalPlayer
	return player.Character or player.CharacterAdded:Wait()
end

function getPlrChar(plr)
	return plr and plr.Character or nil
end

function getBp()
	local player = Players.LocalPlayer
	return player:FindFirstChildWhichIsA("Backpack")
end

function getHum()
	local char = getChar()
	return char and char:FindFirstChildWhichIsA("Humanoid") or nil
end

function getPlrHum(plr)
	local char = getPlrChar(plr)
	return char and char:FindFirstChildWhichIsA("Humanoid") or nil
end

function isNumber(str)
	if tonumber(str)~=nil or str=='inf' then
		return true
	end
end

function FindInTable(tbl,val)
	if tbl==nil then return false end
	for _,v in pairs(tbl) do
		if v==val then return true end
	end 
	return false
end

function GetInTable(Table,Name)
	for i=1,#Table do
		if Table[i]==Name then
			return i
		end
	end
	return false
end

function MouseButtonFix(button,clickCallback)
	local isHolding = false
	local holdThreshold = 0.35
	local mouseDownTime = 0

	button.MouseButton1Down:Connect(function()
		isHolding = false
		mouseDownTime = tick()
	end)

	button.MouseButton1Up:Connect(function()
		local holdDuration = tick() - mouseDownTime
		if holdDuration < holdThreshold and not isHolding then
			clickCallback()
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and input.UserInputState == Enum.UserInputState.Change then
			isHolding = true
		end
	end)
end

--[[ FUNCTION TO GET A PLAYER ]]--
getPlr = function(Name)
	local Players = SafeGetService("Players")
	local LocalPlayer = Players.LocalPlayer

	if not Name or Name == "" or Name:lower() == "me" then
		return LocalPlayer
	elseif Name:lower() == "random" then
		local otherPlayers = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				table.insert(otherPlayers, plr)
			end
		end
		if #otherPlayers > 0 then
			return otherPlayers[math.random(#otherPlayers)]
		end
	elseif Name:lower() == "friends" then
		local friends = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr:IsFriendsWith(LocalPlayer.UserId) and plr ~= LocalPlayer then
				table.insert(friends, plr)
			end
		end
		return friends
	elseif Name:lower() == "nonfriends" then
		local nonFriends = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if not plr:IsFriendsWith(LocalPlayer.UserId) and plr ~= LocalPlayer then
				table.insert(nonFriends, plr)
			end
		end
		return nonFriends
	elseif Name:lower() == "enemies" then
		local nonTeam = {}
		local team = LocalPlayer.Team
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Team ~= team and plr ~= LocalPlayer then
				table.insert(nonTeam, plr)
			end
		end
		return nonTeam
	elseif Name:lower() == "allies" then
		local teamBuddies = {}
		local team = LocalPlayer.Team
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Team == team and plr ~= LocalPlayer then
				table.insert(teamBuddies, plr)
			end
		end
		return teamBuddies
	elseif Name:lower() == "all" then
		return Players:GetPlayers()
	elseif Name:lower() == "others" then
		local otherPlayers = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				table.insert(otherPlayers, plr)
			end
		end
		return otherPlayers
	else
		Name = Name:lower():gsub("%s", "")
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Name:lower():match("^"..Name) then
				return plr
			elseif plr.DisplayName:lower():match("^"..Name) then
				return plr
			end
		end
	end
end

--[[ MORE VARIABLES ]]--
local plr=Player
speaker=Player
local char=plr.Character
local JSONEncode,JSONDecode=HttpService.JSONEncode,HttpService.JSONDecode
local con=game.Loaded.Connect
local LoadTime=tick();

NACaller(function()
	Players.LocalPlayer.CharacterAdded:Connect(function(c)
		character=c
		Character=c
		char=c
	end)
end)

local ESPenabled=false


function round(num,numDecimalPlaces)
	local mult=10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end

function placeName()
	while true do
		local success, page = pcall(function()
			return SafeGetService("AssetService"):GetGamePlacesAsync()
		end)

		if success then
			while true do
				for _, place in ipairs(page:GetCurrentPage()) do
					if place.PlaceId == PlaceId then
						return place.Name
					end
				end

				if page.IsFinished then
					break
				end

				local successAdvance = pcall(function()
					page:AdvanceToNextPageAsync()
				end)

				if not successAdvance then
					break
				end
			end
		end

		task.wait(.5)
	end
end

function removeESP()
	for _, child in pairs(COREGUI:GetChildren()) do
		if string.sub(child.Name, -4) == '_ESP' then
			child:Destroy()
		end
	end
end

function ESP(player)
	task.spawn(function()
		for _, child in pairs(COREGUI:GetChildren()) do
			if child.Name == player.Name..'_ESP' then
				child:Destroy()
			end
		end
		task.wait()

		local function createESP()
			if player.Character and player.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(player.Name..'_ESP') then
				local espHolder = Instance.new("Folder")
				espHolder.Name = player.Name..'_ESP'
				espHolder.Parent = COREGUI

				repeat task.wait(1) until player.Character and getRoot(player.Character) and player.Character:FindFirstChildOfClass("Humanoid")

				local highlight = Instance.new("Highlight")
				highlight.Name = player.Name
				highlight.Parent = espHolder
				highlight.Adornee = player.Character
				highlight.FillTransparency = 0.3
				highlight.OutlineTransparency = 0.1
				highlight.FillColor = Color3.fromRGB(0, 255, 0)

				if player.Character:FindFirstChild("Head") then
					local billboardGui = Instance.new("BillboardGui")
					local textLabel = Instance.new("TextLabel")

					billboardGui.Adornee = player.Character:FindFirstChild("Head")
					billboardGui.Name = player.Name
					billboardGui.Parent = espHolder
					billboardGui.Size = UDim2.new(0, 200, 0, 100)
					billboardGui.StudsOffset = Vector3.new(0, 2, 0)
					billboardGui.AlwaysOnTop = true

					textLabel.Parent = billboardGui
					textLabel.BackgroundTransparency = 1
					textLabel.Size = UDim2.new(1, 0, 1, 0)
					textLabel.Font = Enum.Font.GothamBold
					textLabel.TextSize = 14
					textLabel.TextStrokeTransparency = 0.2
					textLabel.TextYAlignment = Enum.TextYAlignment.Center

					local espLoop
					espLoop = RunService.RenderStepped:Connect(function()
						if COREGUI:FindFirstChild(player.Name..'_ESP') then
							if player.Character and getRoot(player.Character) and player.Character:FindFirstChildOfClass("Humanoid") then
								local health = math.floor(player.Character:FindFirstChildOfClass("Humanoid").Health)
								local maxHealth = math.floor(player.Character:FindFirstChildOfClass("Humanoid").MaxHealth)
								local teamColor = player.Team and player.Team.TeamColor.Color or Color3.fromRGB(255, 255, 255)

								local displayName = player.DisplayName == player.Name and '@'..player.Name or player.DisplayName..' (@'..player.Name..')'

								if Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
									local distance = math.floor((getRoot(Players.LocalPlayer.Character).Position - getRoot(player.Character).Position).magnitude)
									if player.Team then
										textLabel.Text = string.format("%s | Health: %d/%d | Studs: %d | Team: %s", displayName, health, maxHealth, distance, player.Team.Name)
									else
										textLabel.Text = string.format("%s | Health: %d/%d | Studs: %d", displayName, health, maxHealth, distance)
									end
									textLabel.TextColor3 = distance < 50 and Color3.fromRGB(255, 0, 0) or distance < 100 and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(0, 255, 0)
								else
									if player.Team then
										textLabel.Text = string.format("%s | Health: %d/%d | Team: %s", displayName, health, maxHealth, player.Team.Name)
									else
										textLabel.Text = string.format("%s | Health: %d/%d", displayName, health, maxHealth)
									end
									textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
								end

								highlight.FillColor = teamColor
							end
						else
							espLoop:Disconnect()
						end
					end)
				end
			end
		end

		createESP()

		local characterAddedConnection
		characterAddedConnection = player.CharacterAdded:Connect(function()
			if not ESPenabled then
				characterAddedConnection:Disconnect()
				return
			end

			for _, child in pairs(COREGUI:GetChildren()) do
				if child.Name == player.Name..'_ESP' then
					child:Destroy()
				end
			end

			task.wait(1)
			createESP()
		end)
	end)
end



local Signal1, Signal2 = nil, nil
local flyMobile, MobileWeld = nil, nil

function mobilefly(speed, vfly)
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	if flyMobile then flyMobile:Destroy() end
	flyMobile = Instance.new("Part", SafeGetService("Workspace").CurrentCamera)
	flyMobile.Name = randomString()
	flyMobile.Size, flyMobile.CanCollide = Vector3.new(0.05, 0.05, 0.05), false
	if MobileWeld then MobileWeld:Destroy() end
	MobileWeld = Instance.new("Weld", flyMobile)
	MobileWeld.Name = randomString()
	MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, character:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)

	if not flyMobile:FindFirstChildWhichIsA("BodyVelocity") then
		local bv = Instance.new("BodyVelocity", flyMobile)
		bv.Name = randomString()
		bv.MaxForce = Vector3.new(0, 0, 0)
		bv.Velocity = Vector3.new(0, 0, 0)
	end

	if not flyMobile:FindFirstChildWhichIsA("BodyGyro") then
		local bg = Instance.new("BodyGyro", flyMobile)
		bg.Name = randomString()
		bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.P = 1000
		bg.D = 50
	end

	Signal1 = LocalPlayer.CharacterAdded:Connect(function(newChar)
		if not flyMobile:FindFirstChildWhichIsA("BodyVelocity") then
			local bv = Instance.new("BodyVelocity", flyMobile)
			bv.Name = randomString()
			bv.MaxForce = Vector3.new(0, 0, 0)
			bv.Velocity = Vector3.new(0, 0, 0)
		end

		if not flyMobile:FindFirstChildWhichIsA("BodyGyro") then
			local bg = Instance.new("BodyGyro", flyMobile)
			bg.Name = randomString()
			bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.P = 1000
			bg.D = 50
		end

		if not flyMobile:FindFirstChildWhichIsA("Weld") then
			MobileWeld = Instance.new("Weld", flyMobile)
			MobileWeld.Name = randomString()
			MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, newChar:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)
		else
			MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, newChar:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)
		end
	end)

	local camera = SafeGetService("Workspace").CurrentCamera

	Signal2 = RunService.RenderStepped:Connect(function()
		local character = getChar()
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local bv = flyMobile and flyMobile:FindFirstChildWhichIsA("BodyVelocity")
		local bg = flyMobile and flyMobile:FindFirstChildWhichIsA("BodyGyro")

		if character and humanoid and flyMobile and MobileWeld and bv and bg then
			bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			if not vfly then
				humanoid.PlatformStand = true
			end

			bg.CFrame = camera.CFrame
			local direction = ctrlModule:GetMoveVector()
			local newVelocity = Vector3.new()

			if direction.X ~= 0 then
				newVelocity = newVelocity + camera.CFrame.RightVector * (direction.X * speed)
			end
			if direction.Z ~= 0 then
				newVelocity = newVelocity - camera.CFrame.LookVector * (direction.Z * speed)
			end

			bv.Velocity = newVelocity
		end
	end)
end

function unmobilefly()
	local char = getChar()
	if char and flyMobile then
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.PlatformStand = false
		end
		flyMobile:Destroy()
	end
	if Signal1 then Signal1:Disconnect() end
	if Signal2 then Signal2:Disconnect() end
end


function x(v)
	if v then
		for _,i in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier=0.5
			end
		end
	else
		for _,i in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier=0
			end
		end
	end
end

local cmdlp=Players.LocalPlayer

plr=cmdlp

local cmdm=plr:GetMouse()
local goofyFLY=nil
function sFLY(vfly)
	while not cmdlp or not cmdlp.Character or not cmdlp.Character:FindFirstChild('HumanoidRootPart') or not cmdlp.Character:FindFirstChild('Humanoid') or not cmdm do
		wait()
	end

	if goofyFLY then goofyFLY:Destroy() end

	goofyFLY = Instance.new("Part",SafeGetService("Workspace").CurrentCamera)
	goofyFLY.Name = randomString()
	goofyFLY.Size = Vector3.new(0.05, 0.05, 0.05)
	goofyFLY.CanCollide = false

	local CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
	local lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
	local SPEED = 0

	local function FLY()
		FLYING = true

		local BG = Instance.new('BodyGyro', goofyFLY)
		local BV = Instance.new('BodyVelocity', goofyFLY)
		local Weld = Instance.new("Weld", goofyFLY)

		BG.Name = randomString()
		BV.Name = randomString()
		Weld.Name = randomString()
		Weld.Part0 = goofyFLY
		Weld.Part1 = cmdlp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
		Weld.C0 = CFrame.new(0, 0, 0)
		BG.P = 9e4
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = goofyFLY.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

		spawn(function()
			while FLYING do
				if not vfly then
					cmdlp.Character:FindFirstChild("Humanoid").PlatformStand = true
				end

				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif SPEED ~= 0 then
					SPEED = 0
				end

				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					BV.velocity = ((SafeGetService("Workspace").CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) +
						((SafeGetService("Workspace").CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) -
							SafeGetService("Workspace").CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = { F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R }
				elseif SPEED ~= 0 then
					BV.velocity = ((SafeGetService("Workspace").CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) +
						((SafeGetService("Workspace").CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) -
							SafeGetService("Workspace").CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end

				BG.cframe = SafeGetService("Workspace").CurrentCamera.CoordinateFrame
				wait()
			end

			CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			cmdlp.Character.Humanoid.PlatformStand = false
		end)
	end

	cmdm.KeyDown:Connect(function(KEY)
		local key = KEY:lower()
		if key == 'w' then
			CONTROL.F = vfly and speedofthevfly or speedofthefly
		elseif key == 's' then
			CONTROL.B = vfly and -speedofthevfly or -speedofthefly
		elseif key == 'a' then
			CONTROL.L = vfly and -speedofthevfly or -speedofthefly
		elseif key == 'd' then
			CONTROL.R = vfly and speedofthevfly or speedofthefly
		elseif key == 'y' then
			CONTROL.Q = vfly and speedofthevfly * 2 or speedofthefly * 2
		elseif key == 't' then
			CONTROL.E = vfly and -speedofthevfly * 2 or -speedofthefly * 2
		end
	end)

	cmdm.KeyUp:Connect(function(KEY)
		local key = KEY:lower()
		if key == 'w' then
			CONTROL.F = 0
		elseif key == 's' then
			CONTROL.B = 0
		elseif key == 'a' then
			CONTROL.L = 0
		elseif key == 'd' then
			CONTROL.R = 0
		elseif key == 'y' then
			CONTROL.Q = 0
		elseif key == 't' then
			CONTROL.E = 0
		end
	end)

	FLY()
end


local tool=nil
spawn(function()
	repeat wait() until getChar()
	tool=getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool") or nil
end)

local nc=false
local ncLoop=nil
ncLoop=RunService.Stepped:Connect(function()
	if nc and getChar()~=nil then
		for _,v in pairs(getChar():GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide==true then
				v.CanCollide=false
			end
		end
	end
end)

local lp=Players.LocalPlayer

--[[ LIB FUNCTIONS ]]--
chatmsgshooks={}
Playerchats={}

lib.LocalPlayerChat=function(...)
	local args={...} 
	if TextChatService:FindFirstChild("TextChannels") then
		local sendto=TextChatService.TextChannels.RBXGeneral
		if args[2]~=nil and  args[2]~="All"  then
			if not Playerchats[args[2]] then
				for i,v in pairs(TextChatService.TextChannels:GetChildren()) do
					if string.find(v.Name,"RBXWhisper:") then
						if v:FindFirstChild(args[2]) and v:FindFirstChild(Players.LocalPlayer.Name) then
							if v[Players.LocalPlayer.Name].CanSend==false then
								continue
							end
							sendto=v
							Playerchats[args[2]]=v
							break
						end
					end
				end
			else
				sendto=Playerchats[args[2]]
			end
			if sendto==TextChatService.TextChannels.RBXGeneral then
				chatmsgshooks[args[1]]={args[1],args}
				task.spawn(function()
					TextChatService.TextChannels.RBXGeneral:SendAsync("/w @"..args[2])
				end)
				return "Hooking"
			end
		end
		sendto:SendAsync(args[1] or "")
	else
		if args[2] and args[2]~="All" then
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..args[2].." "..args[1] or "","All")
		else
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(args[1] or "","All")
		end
	end
end

if TextChatService:FindFirstChild("TextChannels") then
	TextChatService.TextChannels.ChildAdded:Connect(function(v)
		if string.find(v.Name,"RBXWhisper:") then
			task.wait(1)
			for id,va in pairs(chatmsgshooks) do
				if v:FindFirstChild(va[1]) and v:FindFirstChild(Players.LocalPlayer.Name) then
					if v[Players.LocalPlayer.Name].CanSend==false then
						continue
					end
					Playerchats[va[1]]=v
					chatmsgshooks[id]=nil
					lib.LocalPlayerChat(va[2])
					break
				end
			end
		end
	end)
end

lib.lpchat=lib.LocalPlayerChat

lib.lock=function(instance,par)
	locks[instance]=true
	instance.Parent=par or instance.Parent
	instance.Name="RightGrip"
end
local lock=lib.lock
local locks={}

lib.find=function(t,v)	--mmmmmm
	for i,e in pairs(t) do
		if i==v or e==v then
			return i
		end
	end
	return nil
end

lib.parseText = function(text, watch, rPlr)
	local parsed = {}
	if not text then return nil end
	local prefix
	if rPlr then
		if isRelAdmin(rPlr) and isRelAdmin(Players.LocalPlayer) then
			return nil
		elseif not isRelAdmin(rPlr) then
			prefix = ";"
		else
			prefix = watch
		end
		watch = prefix
	else
		prefix = watch
	end
	for arg in text:gmatch("[^"..watch.."]+") do
		arg = arg:gsub("-", "%%-")
		local pos = text:find(arg)
		arg = arg:gsub("%%", "")
		if pos then
			local find = text:sub(pos - prefix:len(), pos - 1)
			if (find == prefix and watch == prefix) or watch ~= prefix then
				table.insert(parsed, arg)
			end
		else
			table.insert(parsed, nil)
		end
	end
	return parsed
end

lib.parseCommand = function(text, rPlr)
	wrap(function()
		local commands
		if rPlr then
			if isRelAdmin(rPlr) and isRelAdmin(Players.LocalPlayer) then
				return
			end
			commands = lib.parseText(text, ";", rPlr)
		else
			commands = lib.parseText(text, opt.prefix)
		end
		for _, parsed in pairs(commands) do
			local args = {}
			for arg in parsed:gmatch("[^ ]+") do
				table.insert(args, arg)
			end
			cmd.run(args)
		end
	end)
end

local connections={}

lib.connect=function(name,connection)	--no :(
	connections[name..tostring(math.random(1000000,9999999))]=connection
	return connection
end

lib.disconnect=function(name)
	for title,connection in pairs(connections) do
		if title:find(name)==1 then
			connection:Disconnect()
		end
	end
end

local m=math			--prepare for annoying and unnecessary tool grip math
local rad=m.rad
local clamp=m.clamp
local sin=m.sin
local tan=m.tan
local cos=m.cos

--[[ COMMANDS ]]--

cmd.add({"url"},{"url <link>","Run the script using url"},function(...)
	local args={...}
	local code=table.concat(args, " ")

	loadstring(game:HttpGet(code))()
end,true)

cmd.add({"loadstring","ls"},{"loadstring <code> (ls)","Run the code using the loadstring"},function(...)
	local args = {...}
	local code = table.concat(args, " ")
	local fn, err = loadstring(code)
	if not fn then
		return false, "Error loading code: "..tostring(err)
	end
	local success, result = pcall(fn)
	if not success then
		return false, "Error executing code: "..tostring(result)
	end
	return true, result
end,true)

cmd.add({"executor","exec"},{"executor (exec)","Very simple executor"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NAexecutor.lua"))()
end)

cmd.add({"commandloop", "cmdloop"}, {"commandloop <command> {arguments} (cmdloop)", "Run a command on loop"}, function(...)
	local args = {...}
	local commandName = args[1]
	table.remove(args, 1)

	if not commandName then
		DoNotif("Command name is required.",3)
		return
	end

	cmd.loop(commandName, args)
end)

cmd.add({"stoploop"}, {"stoploop", "Stop a running loop"}, function()
	cmd.stopLoop()
end)

if IsOnMobile then
	local scaleFrame = nil
	cmd.add({"guiscale", "guisize", "gsize", "gscale"}, {"guiscale (guisize, gsize, gscale)", "Adjust the scale of the "..adminName.." button"}, function()
		if scaleFrame then scaleFrame:Destroy() scaleFrame=nil end
		scaleFrame = Instance.new("ScreenGui")
		local frame = Instance.new("Frame")
		local frameCorner = Instance.new("UICorner")
		local slider = Instance.new("Frame")
		local sliderCorner = Instance.new("UICorner")
		local progress = Instance.new("Frame")
		local progressCorner = Instance.new("UICorner")
		local knob = Instance.new("TextButton")
		local knobCorner = Instance.new("UICorner")
		local label = Instance.new("TextLabel")
		local closeButton = Instance.new("TextButton")
		local closeCorner = Instance.new("UICorner")

		local sizeRange = {0.5, 3}
		local minSize, maxSize = sizeRange[1], sizeRange[2]

		NaProtectUI(scaleFrame)
		frame.Parent = scaleFrame
		frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		frame.Size = UDim2.new(0, 400, 0, 120)
		frame.Position = UDim2.new(0.5,-283/2+5,0.5,-260/2+5)
		frame.BorderSizePixel = 0
		frame.BackgroundTransparency = 0.05

		frameCorner.CornerRadius = UDim.new(0.1, 0)
		frameCorner.Parent = frame

		slider.Parent = frame
		slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		slider.Size = UDim2.new(0.8, 0, 0.2, 0)
		slider.Position = UDim2.new(0.1, 0, 0.5, 0)
		slider.AnchorPoint = Vector2.new(0, 0.5)
		slider.BorderSizePixel = 0

		sliderCorner.CornerRadius = UDim.new(0.5, 0)
		sliderCorner.Parent = slider

		progress.Parent = slider
		progress.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		progress.Size = UDim2.new((NAScale - minSize) / (maxSize - minSize), 0, 1, 0)
		progress.BorderSizePixel = 0

		progressCorner.CornerRadius = UDim.new(0.5, 0)
		progressCorner.Parent = progress

		knob.Parent = slider
		knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		knob.Size = UDim2.new(0, 25, 1.5, 0)
		knob.Position = UDim2.new((NAScale - minSize) / (maxSize - minSize), 0, -0.25, 0)
		knob.Text = ""
		knob.BorderSizePixel = 0
		knob.AutoButtonColor = false

		knobCorner.CornerRadius = UDim.new(1, 0)
		knobCorner.Parent = knob

		label.Parent = frame
		label.BackgroundTransparency = 1
		label.Size = UDim2.new(1, 0, 0.3, 0)
		label.Position = UDim2.new(0, 0, 0.1, 0)
		label.Text = "Scale: "..string.format("%.2f", NAScale)
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.Font = Enum.Font.Gotham
		label.TextSize = 18
		label.TextXAlignment = Enum.TextXAlignment.Center

		closeButton.Parent = frame
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		closeButton.Size = UDim2.new(0, 30, 0, 30)
		closeButton.Position = UDim2.new(1, -40, 0, 10)
		closeButton.Text = "X"
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.Font = Enum.Font.Gotham
		closeButton.TextSize = 14
		closeButton.BorderSizePixel = 0

		closeCorner.CornerRadius = UDim.new(0.5, 0)
		closeCorner.Parent = closeButton

		local function update(scale)
			NAimageButton.Size = UDim2.new(0, 32 * scale, 0, 33 * scale)
			progress.Size = UDim2.new((scale - minSize) / (maxSize - minSize) + 0.05, 0, 1, 0)
			knob.Position = UDim2.new((scale - minSize) / (maxSize - minSize), 0, -0.25, 0)
			label.Text = "Scale: "..string.format("%.2f", scale)
		end

		update(NAScale)

		local dragging = false
		local dragInput
		local sliderStart, sliderWidth

		local UserInputService = UserInputService
		local RunService = RunService

		knob.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				sliderStart = slider.AbsolutePosition.X
				sliderWidth = slider.AbsoluteSize.X
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						if FileSupport then
							writefile("Nameless-Admin/ImageButtonSize.txt", tostring(NAScale))
						end
					end
				end)
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local mouseX = input.Position.X
				local relativePosition = (mouseX - sliderStart) / sliderWidth
				local newScale = math.clamp(relativePosition, 0, 1) * (maxSize - minSize) + minSize
				NAScale = math.clamp(newScale, minSize, maxSize)
				update(NAScale)
			end
		end)

		MouseButtonFix(closeButton,function()
			scaleFrame:Destroy()
		end)

		gui.draggable(frame)
	end)
end

cmd.add({"scripthub","hub"},{"scripthub (hub)","Thanks to scriptblox api"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/ScriptHubNA.lua"))()
end)

cmd.add({"resizechat","rc"},{"resizechat (rc)","Makes chat resizable and draggable"},function()
	require(ChatService.ClientChatModules.ChatSettings).WindowResizable=true
	require(ChatService.ClientChatModules.ChatSettings).WindowDraggable=true
end)

cmd.add({"prefix"},{"prefix <prefix>","Changes the admin prefix"},function(...)
	local PrefixChange = (...)

	if PrefixChange == nil then
		DoNotif("Please enter a valid prefix")
	elseif PrefixChange:match("[a-zA-Z0-9]") then
		DoNotif("Prefix cannot contain letters or numbers. Please choose a different prefix.")
	elseif PrefixChange == "[" then
		DoNotif("idk why but this prefix breaks changing the prefix so pick smthing else alr?")
	else
		opt.prefix = PrefixChange
		DoNotif("Prefix set to: "..PrefixChange)
	end
end,true)


cmd.add({"saveprefix"},{"saveprefix <prefix>","Saves the prefix to what u want"},function(...)
	if not FileSupport then return end
	local PrefixChange=(...)

	if PrefixChange==nil then
		DoNotif("Please enter a valid prefix")
	elseif PrefixChange:match("[a-zA-Z0-9]") then
		DoNotif("Prefix cannot contain letters or numbers. Please choose a different prefix.")
	elseif PrefixChange=="["then
		DoNotif("idk why but this prefix breaks changing the prefix so pick smthing else alr?")
	else
		writefile("Nameless-Admin/Prefix.txt",PrefixChange)
		opt.prefix=PrefixChange
		DoNotif("Prefix saved to: "..PrefixChange)
	end
end,true)

--[ UTILITY ]--

cmd.add({"chatlogs","clogs"},{"chatlogs (clogs)","Open the chat logs"},function()
	gui.chatlogs()
end)

cmd.add({"gotocampos","tocampos","tcp"},{"gotocampos (tocampos,tcp)","Teleports you to your camera position works with free cam but freezes you"},function()
	local player=Players.LocalPlayer
	local UserInputService=UserInputService
	function teleportPlayer()
		local character=player.Character or player.CharacterAdded:wait(1)
		local camera=SafeGetService("Workspace").CurrentCamera
		local cameraPosition=camera.CFrame.Position
		character:SetPrimaryPartCFrame(CFrame.new(cameraPosition))
	end
	local camera=SafeGetService("Workspace").CurrentCamera
	repeat wait() until camera.CFrame~=CFrame.new()

	teleportPlayer()
end)

cmd.add({"teleportgui","tpui","universeviewer","uviewer"},{"teleportgui (tpui,universeviewer,uviewer)","Gives an UI that grabs all places and teleports you by clicking a simple button"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/Universe%20Viewer"))();
end)

cmd.add({"serverremotespy","srs","sremotespy"},{"serverremotespy (srs,sremotespy)","Gives an UI that logs all the remotes being called from the server (thanks SolSpy lol)"},function()
	loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/Server%20Spy.lua?raw=spy"))()
end)

cmd.add({"updatelog","updlog","updates"},{"updatelog (updlog,updates)","show the update logs for Nameless Admin"},function()
	gui.updateLogs()
end)

cmd.add({"discord"}, {"discord", "Copy an invite link to the official Nameless Admin Discord server"}, function()
	local inviteLink = "https://discord.gg/zS7TpV3p64"

	if setclipboard then
		Notify({
			Title = "Discord",
			Description = inviteLink,
			Buttons = {
				{Text = "Copy Link", Callback = function() setclipboard(inviteLink) end},
				{Text = "Close", Callback = function() end}
			}
		})
	else
		Notify({
			Title = "Discord",
			Description = "Your exploit does not support setclipboard.\nPlease manually type the invite link: "..inviteLink,
			Buttons = {
				{Text = "Close", Callback = function() end}
			}
		})
	end
end)

cmd.add({"clickfling","mousefling"},{"mousefling (clickfling)","Fling a player by clicking them"},function()
	local Players=Players
	local Mouse=Players.LocalPlayer:GetMouse()

	Mouse.Button1Down:Connect(function()
		local Target=Mouse.Target
		if Target and Target.Parent and Target.Parent:IsA("Model") and Players:GetPlayerFromCharacter(Target.Parent) then
			local PlayerName=Players:GetPlayerFromCharacter(Target.Parent).Name
			local player=Players.LocalPlayer
			local Targets={PlayerName}

			local Players=Players
			local Player=Players.LocalPlayer

			local AllBool=false

			local GetPlayer=function(Name)
				Name=Name:lower()
				if Name=="all" or Name=="others" then
					AllBool=true
					return
				elseif Name=="random" then
					local GetPlayers=Players:GetPlayers()
					if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
					return GetPlayers[math.random(#GetPlayers)]
				elseif Name~="random" and Name~="all" and Name~="others" then
					for _,x in next,Players:GetPlayers() do
						if x~=Player then
							if x.Name:lower():match("^"..Name) then
								return x;
							elseif x.DisplayName:lower():match("^"..Name) then
								return x;
							end
						end
					end
				else
					return
				end
			end

			local Message=function(_Title,_Text,Time)
				print(_Title)
				print(_Text)
				print(Time)
			end

			local SkidFling=function(TargetPlayer)
				local Character=Player.Character
				local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
				local RootPart=Humanoid and Humanoid.RootPart

				local TCharacter=TargetPlayer.Character
				local THumanoid
				local TRootPart
				local THead
				local Accessory
				local Handle

				if TCharacter:FindFirstChildOfClass("Humanoid") then
					THumanoid=TCharacter:FindFirstChildOfClass("Humanoid")
				end
				if THumanoid and THumanoid.RootPart then
					TRootPart=THumanoid.RootPart
				end
				if TCharacter:FindFirstChild("Head") then
					THead=TCharacter:FindFirstChild("Head")
				end
				if TCharacter:FindFirstChildOfClass("Accessory") then
					Accessory=TCharacter:FindFirstChildOfClass("Accessory")
				end
				if Accessoy and Accessory:FindFirstChild("Handle") then
					Handle=Accessory.Handle
				end

				if Character and Humanoid and RootPart then
					if RootPart.Velocity.Magnitude<50 then
						getgenv().OldPos=RootPart.CFrame
					end
					if THumanoid and THumanoid.Sit and not AllBool then
					end
					if THead then
						SafeGetService("Workspace").CurrentCamera.CameraSubject=THead
					elseif not THead and Handle then
						SafeGetService("Workspace").CurrentCamera.CameraSubject=Handle
					elseif THumanoid and TRootPart then
						SafeGetService("Workspace").CurrentCamera.CameraSubject=THumanoid
					end
					if not TCharacter:FindFirstChildWhichIsA("BasePart") then
						return
					end

					local FPos=function(BasePart,Pos,Ang)
						RootPart.CFrame=CFrame.new(BasePart.Position)*Pos*Ang
						Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position)*Pos*Ang)
						RootPart.Velocity=Vector3.new(9e7,9e7*10,9e7)
						RootPart.RotVelocity=Vector3.new(9e8,9e8,9e8)
					end

					local SFBasePart=function(BasePart)
						local TimeToWait=2
						local Time=tick()
						local Angle=0

						repeat
							if RootPart and THumanoid then
								if BasePart.Velocity.Magnitude<50 then
									Angle=Angle+100

									FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(2.25,1.5,-2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(-2.25,-1.5,2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
									task.wait()
								else
									FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,-THumanoid.WalkSpeed),CFrame.Angles(0,0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,-TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(0,0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
									task.wait()

									FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
									task.wait()
								end
							else
								break
							end
						until BasePart.Velocity.Magnitude>500 or BasePart.Parent~=TargetPlayer.Character or TargetPlayer.Parent~=Players or not TargetPlayer.Character==TCharacter or THumanoid.Sit or Humanoid.Health <=0 or tick()>Time+TimeToWait
					end

					SafeGetService("Workspace").FallenPartsDestroyHeight=0/0

					local BV=Instance.new("BodyVelocity")
					BV.Name="EpixVel"
					BV.Parent=RootPart
					BV.Velocity=Vector3.new(9e8,9e8,9e8)
					BV.MaxForce=Vector3.new(1/0,1/0,1/0)

					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)

					if TRootPart and THead then
						if (TRootPart.CFrame.p-THead.CFrame.p).Magnitude>5 then
							SFBasePart(THead)
						else
							SFBasePart(TRootPart)
						end
					elseif TRootPart and not THead then
						SFBasePart(TRootPart)
					elseif not TRootPart and THead then
						SFBasePart(THead)
					elseif not TRootPart and not THead and Accessory and Handle then
						SFBasePart(Handle)
					else
					end

					BV:Destroy()
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
					SafeGetService("Workspace").CurrentCamera.CameraSubject=Humanoid

					repeat
						RootPart.CFrame=getgenv().OldPos*CFrame.new(0,.5,0)
						Character:SetPrimaryPartCFrame(getgenv().OldPos*CFrame.new(0,.5,0))
						Humanoid:ChangeState("GettingUp")
						table.foreach(Character:GetChildren(),function(_,x)
							if x:IsA("BasePart") then
								x.Velocity,x.RotVelocity=Vector3.new(),Vector3.new()
							end
						end)
						task.wait()
					until (RootPart.Position-getgenv().OldPos.p).Magnitude<25
					SafeGetService("Workspace").FallenPartsDestroyHeight=getgenv().FPDH
				else
				end
			end

			getgenv().Welcome=true
			if Targets[1] then for _,x in next,Targets do GetPlayer(x) end else return end

			if AllBool then
				for _,x in next,Players:GetPlayers() do
					SkidFling(x)
				end
			end

			for _,x in next,Targets do
				if GetPlayer(x) and GetPlayer(x)~=Player then
					if GetPlayer(x).UserId~=1414978355 then
						local TPlayer=GetPlayer(x)
						if TPlayer then
							SkidFling(TPlayer)
						end
					else
					end
				elseif not GetPlayer(x) and not AllBool then
				end
			end
		end
	end)
end)

cmd.add({"ping"},{"ping","Shows your ping"},function()
	local Ping = Instance.new("ScreenGui")
	local Pingtext = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local MinimizeButton = Instance.new("TextButton")
	local UICornerMinimize = Instance.new("UICorner")
	local CloseButton = Instance.new("TextButton")
	local UICornerClose = Instance.new("UICorner")

	Ping.Name = "Ping"
	NaProtectUI(Ping)
	Ping.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Ping.ResetOnSpawn = false

	Pingtext.Name = "Pingtext"
	Pingtext.Parent = Ping
	Pingtext.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	Pingtext.BackgroundTransparency = 0.2
	Pingtext.Position = UDim2.new(0, 0, 0, 48)
	Pingtext.Size = UDim2.new(0, 201, 0, 35)
	Pingtext.Font = Enum.Font.GothamSemibold
	Pingtext.Text = "Ping: --"
	Pingtext.TextColor3 = Color3.fromRGB(255, 255, 255)
	Pingtext.TextSize = 16
	Pingtext.TextXAlignment = Enum.TextXAlignment.Center
	Pingtext.TextWrapped = true

	CloseButton.Name = "CloseButton"
	CloseButton.Parent = Pingtext
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
	CloseButton.Size = UDim2.new(0, 20, 0, 20)
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 14
	CloseButton.ZIndex = 10

	UICornerClose.CornerRadius = UDim.new(0, 10)
	UICornerClose.Parent = CloseButton

	MinimizeButton.Name = "MinimizeButton"
	MinimizeButton.Parent = Pingtext
	MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
	MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
	MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.Text = "-"
	MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeButton.TextSize = 14
	MinimizeButton.ZIndex = 10

	UICornerMinimize.CornerRadius = UDim.new(0, 10)
	UICornerMinimize.Parent = MinimizeButton

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Pingtext

	UIStroke.Color = Color3.fromRGB(100, 100, 255)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = Pingtext

	local minimized = false
	MouseButtonFix(MinimizeButton, function()
		minimized = not minimized
		Pingtext.Size = minimized and UDim2.new(0, 201, 0, 20) or UDim2.new(0, 201, 0, 35)
		Pingtext.Text = minimized and "Ping" or "Ping: --"
	end)

	MouseButtonFix(CloseButton, function()
		Ping:Destroy()
	end)

	local RunService = RunService
	local lastUpdate = 0
	local updateInterval = 0.5

	RunService.RenderStepped:Connect(function()
		local currentTime = tick()
		if currentTime - lastUpdate >= updateInterval then
			local pingValue = SafeGetService("Stats").Network.ServerStatsItem["Data Ping"]
			local ping = tonumber(pingValue:GetValueString():match("%d+"))

			local color
			if ping <= 50 then
				color = Color3.fromRGB(0, 255, 100)
			elseif ping <= 100 then
				color = Color3.fromRGB(255, 255, 0)
			else
				color = Color3.fromRGB(255, 50, 50)
			end

			if not minimized then
				Pingtext.Text = "Ping: "..ping.." ms"
				Pingtext.TextColor3 = color
			end

			lastUpdate = currentTime
		end
	end)

	gui.draggable(Pingtext)
end)

cmd.add({"fps"},{"fps","Shows your fps"},function()
	local Fps = Instance.new("ScreenGui")
	local Fpstext = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local MinimizeButton = Instance.new("TextButton")
	local UICornerMinimize = Instance.new("UICorner")
	local CloseButton = Instance.new("TextButton")
	local UICornerClose = Instance.new("UICorner")

	Fps.Name = "Fps"
	NaProtectUI(Fps)
	Fps.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Fps.ResetOnSpawn = false

	Fpstext.Name = "Fpstext"
	Fpstext.Parent = Fps
	Fpstext.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	Fpstext.BackgroundTransparency = 0.2
	Fpstext.Position = UDim2.new(0, 0, 0, 6)
	Fpstext.Size = UDim2.new(0, 201, 0, 35)
	Fpstext.Font = Enum.Font.GothamSemibold
	Fpstext.Text = "FPS: --"
	Fpstext.TextColor3 = Color3.fromRGB(255, 255, 255)
	Fpstext.TextSize = 16
	Fpstext.TextXAlignment = Enum.TextXAlignment.Center
	Fpstext.TextWrapped = true

	CloseButton.Name = "CloseButton"
	CloseButton.Parent = Fpstext
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
	CloseButton.Size = UDim2.new(0, 20, 0, 20)
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 14
	CloseButton.ZIndex = 10

	UICornerClose.CornerRadius = UDim.new(0, 10)
	UICornerClose.Parent = CloseButton

	MinimizeButton.Name = "MinimizeButton"
	MinimizeButton.Parent = Fpstext
	MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
	MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
	MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.Text = "-"
	MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeButton.TextSize = 14
	MinimizeButton.ZIndex = 10

	UICornerMinimize.CornerRadius = UDim.new(0, 10)
	UICornerMinimize.Parent = MinimizeButton

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Fpstext

	UIStroke.Color = Color3.fromRGB(100, 100, 255)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = Fpstext

	local minimized = false
	MouseButtonFix(MinimizeButton, function()
		minimized = not minimized
		Fpstext.Size = minimized and UDim2.new(0, 201, 0, 20) or UDim2.new(0, 201, 0, 35)
		Fpstext.Text = minimized and "FPS" or "FPS: --"
	end)

	MouseButtonFix(CloseButton, function()
		Fps:Destroy()
	end)

	local RunService = RunService
	local frames = {}
	local lastUpdate = 0
	local updateInterval = 0.5

	RunService.RenderStepped:Connect(function(deltaTime)
		table.insert(frames, deltaTime)

		if #frames > 30 then
			table.remove(frames, 1)
		end

		local currentTime = tick()
		if currentTime - lastUpdate >= updateInterval then
			local sum = 0
			for _, frame in ipairs(frames) do
				sum = sum + frame
			end
			local avgFrameTime = sum / #frames
			local fps = math.round(1 / avgFrameTime)

			local color
			if fps >= 50 then
				color = Color3.fromRGB(0, 255, 100)
			elseif fps >= 30 then
				color = Color3.fromRGB(255, 255, 0)
			else
				color = Color3.fromRGB(255, 50, 50)
			end

			if not minimized then
				Fpstext.Text = "FPS: "..fps
				Fpstext.TextColor3 = color
			end

			lastUpdate = currentTime
		end
	end)

	gui.draggable(Fpstext)
end)

cmd.add({"stats"},{"stats","Shows both FPS and ping"},function()
	local PingFPS = Instance.new("ScreenGui")
	local PingFPSText = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local MinimizeButton = Instance.new("TextButton")
	local UICornerMinimize = Instance.new("UICorner")
	local CloseButton = Instance.new("TextButton")
	local UICornerClose = Instance.new("UICorner")

	PingFPS.Name = "PingFPS"
	NaProtectUI(PingFPS)
	PingFPS.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	PingFPS.ResetOnSpawn = false

	PingFPSText.Name = "PingFPSText"
	PingFPSText.Parent = PingFPS
	PingFPSText.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	PingFPSText.BackgroundTransparency = 0.2
	PingFPSText.Position = UDim2.new(0, 0, 0, 48)
	PingFPSText.Size = UDim2.new(0, 250, 0, 50)
	PingFPSText.Font = Enum.Font.GothamSemibold
	PingFPSText.Text = "Ping: -- ms | FPS: --"
	PingFPSText.TextColor3 = Color3.fromRGB(255, 255, 255)
	PingFPSText.TextSize = 14
	PingFPSText.TextXAlignment = Enum.TextXAlignment.Center
	PingFPSText.TextWrapped = true

	CloseButton.Name = "CloseButton"
	CloseButton.Parent = PingFPSText
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
	CloseButton.Size = UDim2.new(0, 20, 0, 20)
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 14
	CloseButton.ZIndex = 10

	UICornerClose.CornerRadius = UDim.new(0, 10)
	UICornerClose.Parent = CloseButton

	MinimizeButton.Name = "MinimizeButton"
	MinimizeButton.Parent = PingFPSText
	MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
	MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
	MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.Text = "-"
	MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeButton.TextSize = 14
	MinimizeButton.ZIndex = 10

	UICornerMinimize.CornerRadius = UDim.new(0, 10)
	UICornerMinimize.Parent = MinimizeButton

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = PingFPSText

	UIStroke.Color = Color3.fromRGB(100, 100, 255)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = PingFPSText

	local minimized = false
	MouseButtonFix(MinimizeButton, function()
		minimized = not minimized
		PingFPSText.Size = minimized and UDim2.new(0, 250, 0, 20) or UDim2.new(0, 250, 0, 50)
		PingFPSText.Text = minimized and "Ping/FPS" or "Ping: -- ms | FPS: --"
	end)

	MouseButtonFix(CloseButton, function()
		PingFPS:Destroy()
	end)

	local RunService = RunService
	local frames = {}
	local lastUpdate = 0
	local updateInterval = 0.5

	RunService.RenderStepped:Connect(function(deltaTime)
		table.insert(frames, deltaTime)

		if #frames > 30 then
			table.remove(frames, 1)
		end

		local currentTime = tick()
		if currentTime - lastUpdate >= updateInterval then
			local sum = 0
			for _, frame in ipairs(frames) do
				sum = sum + frame
			end
			local avgFrameTime = sum / #frames
			local fps = math.round(1 / avgFrameTime)

			local pingValue = SafeGetService("Stats").Network.ServerStatsItem["Data Ping"]
			local ping = tonumber(pingValue:GetValueString():match("%d+"))

			local pingColor
			if ping <= 50 then
				pingColor = Color3.fromRGB(0, 255, 100)
			elseif ping <= 100 then
				pingColor = Color3.fromRGB(255, 255, 0)
			else
				pingColor = Color3.fromRGB(255, 50, 50)
			end

			local fpsColor
			if fps >= 50 then
				fpsColor = Color3.fromRGB(0, 255, 100)
			elseif fps >= 30 then
				fpsColor = Color3.fromRGB(255, 255, 0)
			else
				fpsColor = Color3.fromRGB(255, 50, 50)
			end

			if not minimized then
				PingFPSText.Text = "Ping: "..ping.." ms | FPS: "..fps
				PingFPSText.TextColor3 = pingColor
			end

			lastUpdate = currentTime
		end
	end)

	gui.draggable(PingFPSText)
end)

cmd.add({"commands","cmds"},{"commands (cmds)","Open the command list"},function()
	gui.commands()
end)

--Mobile Commands for the screen
if IsOnMobile then
	cmd.add({"SensorRotationScreen","SensorScreen","SenScreen"},{"SensorRotaionScreen (SensorScreen or SenScreen)","Changes ScreenOrientation to Sensor"},function()
		PlrGui.ScreenOrientation=Enum.ScreenOrientation.Sensor
	end)

	cmd.add({"LandscapeRotationScreen","LandscapeScreen","LandScreen"},{"LandscapeRotaionScreen (LandscapeScreen or LandScreen)","Changes ScreenOrientation to Landscape Sensor"},function()
		PlrGui.ScreenOrientation=Enum.ScreenOrientation.LandscapeSensor
	end)

	cmd.add({"PortraitRotationScreen","PortraitScreen","Portscreen"},{"PortraitRotaionScreen (PortraitScreen or Portscreen)","Changes ScreenOrientation to Portrait"},function()
		PlrGui.ScreenOrientation=Enum.ScreenOrientation.Portrait
	end)

	cmd.add({"DefaultRotaionScreen","DefaultScreen","Defscreen"},{"DefaultRotaionScreen (DefaultScreen or Defscreen)","Changes ScreenOrientation to Portrait"},function()
		PlrGui.ScreenOrientation=StarterGui.ScreenOrientation 
	end)
end
cmd.add({"commandcount","cc"},{"commandcount (cc)","Counds how many commands NA has"},function()
	DoNotif(adminName.." currently has ".. commandcount.." commands")
end)

cmd.add({"flyfling"}, {"flyfling", "makes you fly and fling"}, function()
	cmd.run({'unwalkfling'})
	if IsOnMobile then
		unmobilefly()
	elseif IsOnPC then
		cmd.run({'unvfly'})
	end

	cmd.run({'walkfling'})
	if IsOnMobile then
		mobilefly(50, true)
	elseif IsOnPC then
		cmd.run({'vfly'})
	end
end)

cmd.add({"unflyfling"}, {"unflyfling", "stops fly and fling"}, function()
	cmd.run({'unwalkfling'})
	if IsOnMobile then
		unmobilefly()
	elseif IsOnPC then
		cmd.run({'unvfly'})
	end
end)

hiddenfling = false
flingConnection = nil

cmd.add({"walkfling", "wfling"}, {"walkfling (wfling)", "probably the best fling lol"}, function()
	if hiddenfling then return end

	DoNotif("Walkfling enabled")
	hiddenfling = true

	if not NA_storage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		local detection = Instance.new("Decal")
		detection.Name = "juisdfj0i32i0eidsuf0iok"
		detection.Parent = NA_storage
	end

	if flingConnection then
		flingConnection:Disconnect()
	end

	flingConnection = RunService.Heartbeat:Connect(function()
		if not hiddenfling then
			return
		end

		local lp = Players.LocalPlayer
		local character = lp.Character
		local hrp = getRoot(character)

		if character and hrp then
			local originalVelocity = hrp.Velocity
			hrp.Velocity = originalVelocity * 10000 + Vector3.new(0, 10000, 0)

			RunService.RenderStepped:Wait()
			if character and hrp then
				hrp.Velocity = originalVelocity
			end

			RunService.Stepped:Wait()
			if character and hrp then
				hrp.Velocity = originalVelocity + Vector3.new(0, 0.1, 0)
			end
		end
	end)

	local lp = Players.LocalPlayer
	lp.CharacterAdded:Connect(function()
		if hiddenfling then
			DoNotif("Re-enabling Walkfling")
		end
	end)
end)

cmd.add({"unwalkfling", "unwfling"}, {"unwalkfling (unwfling)", "stop the walkfling command"}, function()
	if not hiddenfling then return end

	DoNotif("Walkfling disabled")
	hiddenfling = false

	if flingConnection then
		flingConnection:Disconnect()
		flingConnection = nil
	end
end)

cmd.add({"rjre", "rejoinrefresh"}, {"rjre (rejoinrefresh)", "Rejoins and teleports you to your previous position"}, function()
	if not DONE then
		DONE = true
		local hrp = getRoot(getChar())

		if hrp then
			local tpScript = [[
                local success, error = pcall(function()
                    repeat task.wait() until game:IsLoaded()
                    local lp = SafeGetService('Players').LocalPlayer
                    local char
                    local startTime = tick()
                    repeat
                        char = lp.Character or lp.CharacterAdded:Wait()
                        task.wait(0.1)
                    until char or (tick() - startTime > 10)
                    
                    if not char then return end
                    
                    local humRP
                    startTime = tick()
                    repeat
                        humRP = char:FindFirstChild('HumanoidRootPart')
                        task.wait(0.1)
                    until humRP or (tick() - startTime > 10)
                    
                    if not humRP then return end
                    
                    local targetPos = Vector3.new(]]..tostring(hrp.Position)..[[)
                    local targetCFrame = CFrame.new(]]..tostring(hrp.CFrame)..[[)
                    
                    startTime = tick()
                    repeat
                        humRP.CFrame = targetCFrame
                        task.wait(0.1)
                    until (humRP.Position - targetPos).Magnitude < 10 or (tick() - startTime > 5)
                end)
            ]]

			queueteleport(tpScript)
		end

		task.spawn(function()
			local Players = Players
			local TeleportService = TeleportService
			local LocalPlayer = Players.LocalPlayer

			pcall(function()
				DoNotif("Rejoining back to the same position...")
			end)

			local success = pcall(function()
				if #Players:GetPlayers() <= 1 then
					LocalPlayer:Kick("\nRejoining...")
					task.wait(0.5)
					TeleportService:Teleport(PlaceId, LocalPlayer)
				else
					TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
				end
			end)

			if not success then
				task.wait(1)
				TeleportService:Teleport(PlaceId, LocalPlayer)
			end
		end)
	end
end)

cmd.add({"rejoin", "rj"}, {"rejoin (rj)", "Rejoin the game"}, function()
	local plrs = Players
	local tp = TeleportService
	local lp = plrs.LocalPlayer

	function tpError(err)
		DoNotif("Teleport failed: "..err)
	end

	tp.TeleportInitFailed:Connect(tpError)

	if #plrs:GetPlayers() <= 1 then
		lp:Kick("Rejoining...")
		wait()
		tp:TeleportCancel()
		local success, err = pcall(function()
			tp:Teleport(PlaceId)
		end)
		if not success then
			tpError(err)
		end
	else
		tp:TeleportCancel()
		local success, err = pcall(function()
			tp:TeleportToPlaceInstance(PlaceId, JobId, lp)
		end)
		if not success then
			tpError(err)
		end
	end

	wait()
	DoNotif("Rejoining...")
end)

cmd.add({"teleporttoplace","toplace","ttp"},{"teleporttoplace (PlaceId) (toplace,ttp)","Teleports you using PlaceId"},function(...)
	args={...}
	pId=tonumber(args[1])
	TeleportService:Teleport(pId)
end,true)

--made by the_king.78
cmd.add({"adonisbypass","bypassadonis","badonis","adonisb"},{"adonisbypass (bypassadonis,badonis,adonisb)","bypasses adonis admin detection"},function()
	local DebugFunc = getinfo or debug.getinfo
	local IsDebug = false
	local hooks = {}

	local DetectedMeth, KillMeth

	for index, value in getgc(true) do
		if typeof(value) == "table" then
			local detected = rawget(value, "Detected")
			local kill = rawget(value, "Kill")

			if typeof(detected) == "function" and not DetectedMeth then
				DetectedMeth = detected

				local hook
				hook = hookfunction(DetectedMeth, function(methodName, methodFunc, methodInfo)
					if methodName ~= "_" then
						if IsDebug then
							DoNotif("Adonis Detected\nMethod: "..tostring(methodName).."\nInfo: "..tostring(methodFunc))
						end
					end

					return true
				end)

				table.insert(hooks, DetectedMeth)
			end

			if rawget(value, "Variables") and rawget(value, "Process") and typeof(kill) == "function" and not KillMeth then
				KillMeth = kill
				local hook
				hook = hookfunction(KillMeth, function(killFunc)
					if IsDebug then
						DoNotif("Adonis tried to detect: "..tostring(killFunc))
					end
				end)

				table.insert(hooks, KillMeth)
			end
		end
	end

	local hook
	hook = hookfunction(getrenv().debug.info, newcclosure(function(...)
		local functionName, functionDetails = ...

		if DetectedMeth and functionName == DetectedMeth then
			if IsDebug or not IsDebug then
				DoNotif("Adonis was bypassed by the_king.78")
			end

			return coroutine.yield(coroutine.running())
		end

		return hook(...)
	end))
end)

--[ LOCALPLAYER ]--
function respawn()
	local characterFrame = getRoot(getChar()).CFrame
	local character = getChar()
	character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
	character:FindFirstChildOfClass("Humanoid").Health=0
	player.CharacterAdded:Wait()
	wait(0.2)
	getRoot(character).CFrame = characterFrame
end

abort=0
function getTools(amt)
	if not amt then amt=1 end
	toolAmount,grabbed=0,{}
	lastCF=character.PrimaryPart.CFrame
	ab=abort

	for i,v in pairs(localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren()) do
		if v:IsA("BackpackItem") then
			toolAmount=toolAmount+1
		end
	end
	if toolAmount >=amt then return localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren() end
	if not localPlayer:FindFirstChildWhichIsA("Backpack"):FindFirstChildWhichIsA("BackpackItem") then return end

	repeat
		repeat wait() until localPlayer:FindFirstChildWhichIsA("Backpack") or ab~=abort
		backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
		wrap(function()
			repeat wait() until backpack:FindFirstChildWhichIsA("BackpackItem")
			for _,tool in pairs(backpack:GetChildren()) do
				if #grabbed >=amt or ab~=abort then break end
				if tool:IsA("BackpackItem") then
					tool.Parent=localPlayer
					table.insert(grabbed,tool)
				end
			end
		end)

		respawn()
		wait(.1)
	until
	#grabbed >=amt or ab~=abort

	repeat wait() until localPlayer.Character and tostring(localPlayer.Character)~="respawn_" and localPlayer.Character==character
	wait(.2)

	repeat wait() until getBp() or ab~=abort
	backpack=getBp()
	for _,tool in pairs(grabbed) do
		if tool:IsA("BackpackItem") then
			tool.Parent=backpack
		end
	end
	wrap(function()
		repeat wait() until character.PrimaryPart
		wait(.2)
		character:SetPrimaryPartCFrame(lastCF)
	end)
	wait(.2)
	return grabbed
end

cmd.add({"accountage","accage"},{"accountage <player> (accage)","Tells the account age of a player in the server"},function(...)
	Username=(...)

	target=getPlr(Username)
	teller=target.AccountAge
	accountage="The account age of "..target.Name.." is "..teller

	wait();

	DoNotif(accountage)
end,true)

cmd.add({"hitboxes"},{"hitboxes","shows all the hitboxes"},function()
	settings():GetService("RenderSettings").ShowBoundingBoxes=true
end)

cmd.add({"unhitboxes"},{"unhitboxes","removes the hitboxes outline"},function()
	settings():GetService("RenderSettings").ShowBoundingBoxes=false
end)

cmd.add({"punch"},{"punch","punch tool that flings"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/punch",true))()
end)

vOn = false
vRAHH = nil
vFlyEnabled = false
vToggleKey = "v"
vFlySpeed = 1
vKeybindConn = nil

function toggleVFly()
	if vFlyEnabled then
		FLYING = false
		if IsOnMobile then
			unmobilefly()
		else
			cmdlp.Character.Humanoid.PlatformStand = false
			if goofyFLY then goofyFLY:Destroy() end
		end
		vFlyEnabled = false
	else
		FLYING = true
		if IsOnMobile then
			mobilefly(vFlySpeed, true)
		else
			sFLY(true)
		end
		vFlyEnabled = true
	end
end

function connectVFlyKey()
	if vKeybindConn then
		vKeybindConn:Disconnect()
	end
	vKeybindConn = cmdm.KeyDown:Connect(function(KEY)
		if KEY:lower() == vToggleKey then
			toggleVFly()
		end
	end)
end

cmd.add({"vfly", "vehiclefly"}, {"vehiclefly (vfly)", "be able to fly vehicles"}, function(...)
	local vFlySpeed = IsOnMobile and ((...) or 50) or ((...) or 1)
	connectVFlyKey()
	vFlyEnabled = true

	if IsOnMobile then
		wait()
		DoNotif(adminName.." detected mobile. vFly button added for easier use.")

		if vRAHH then
			vRAHH:Destroy()
			vRAHH = nil
		end

		vRAHH = Instance.new("ScreenGui")
		local btn = Instance.new("TextButton")
		local corner = Instance.new("UICorner")
		local aspect = Instance.new("UIAspectRatioConstraint")

		NaProtectUI(vRAHH)
		vRAHH.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		vRAHH.ResetOnSpawn = false

		btn.Parent = vRAHH
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		btn.BackgroundTransparency = 0.1
		btn.Position = UDim2.new(0.9, 0, 0.6, 0)
		btn.Size = UDim2.new(0.05, 0, 0.1, 0)
		btn.Font = Enum.Font.GothamBold
		btn.Text = "vFly"
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 18
		btn.TextWrapped = true
		btn.Active = true
		btn.TextScaled = true

		corner.CornerRadius = UDim.new(0.2, 0)
		corner.Parent = btn

		aspect.Parent = btn
		aspect.AspectRatio = 1.0

		coroutine.wrap(function()
			MouseButtonFix(btn,function()
				if not vOn then
					vOn = true
					btn.Text = "UnvFly"
					btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
					mobilefly(vFlySpeed, true)
					cmdlp.Character.Humanoid.PlatformStand = false
				else
					vOn = false
					btn.Text = "vFly"
					btn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
					unmobilefly()
				end
			end)
		end)()

		gui.draggable(btn)
	else
		FLYING = false
		cmdlp.Character.Humanoid.PlatformStand = false
		wait()

		DoNotif("Vehicle fly enabled. Press '"..vToggleKey:upper().."' to toggle vehicle flying.")
		sFLY(true)
		speedofthevfly = vFlySpeed
		speedofthefly = vFlySpeed
	end
end, true)

cmd.add({"unvfly", "unvehiclefly"}, {"unvehiclefly (unvfly)", "disable vehicle fly"}, function()
	wait()
	if IsOnMobile then
		DoNotif("Mobile vFly Disabled.")
		unmobilefly()
	else
		DoNotif("Not flying anymore")
		FLYING = false
		cmdlp.Character.Humanoid.PlatformStand = false
		if goofyFLY then goofyFLY:Destroy() end
	end
	vOn = false
	if vRAHH then
		vRAHH:Destroy()
		vRAHH = nil
	end
	if vKeybindConn then
		vKeybindConn:Disconnect()
		vKeybindConn = nil
	end
end)

if IsOnPC then
	cmd.add({"vflybind", "vflykeybind","bindvfly"}, {"vflybind (vflykeybind, bindvfly)", "set a custom keybind for the 'vFly' command"}, function(...)
		local newKey = (...):lower()
		if newKey == "" or newKey==nil then
			DoNotif("Please provide a keybind.")
			return
		end

		vToggleKey = newKey
		if vKeybindConn then
			vKeybindConn:Disconnect()
		end
		connectVFlyKey()

		DoNotif("vFly keybind set to '"..vToggleKey:upper().."'")
	end)
end

cmd.add({"equiptools","equipall"},{"equiptools","Equip all of your tools"},function()
	local backpack=getBp()
	if backpack then
		for _,tool in pairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent=character
			end
		end
	end
end)

cmd.add({"usetools","uset"},{"usetools (uset)","Equips all tools, uses them, and unequips them"},function()
	local backpack = getBp()
	local character = Players.LocalPlayer.Character
	local equippedTools = {}

	if not backpack or not character then
		DoNotif("Could not find backpack or character.")
		return
	end

	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			table.insert(equippedTools, tool)
		end
	end

	for _, tool in pairs(backpack:GetChildren()) do
		if tool:IsA("Tool") and not table.find(equippedTools, tool) then
			tool.Parent = character
		end
	end

	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			NACaller(function()
				tool:Activate()
			end)
		end
	end

	wait(1);

	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") and not table.find(equippedTools, tool) then
			tool.Parent = backpack
		end
	end

	for _, tool in pairs(equippedTools) do
		tool.Parent = character
	end
end)

cmd.add({"tweento","tweengoto"},{"tweengoto (tweento)","Teleportation method that bypassses some anticheats"},function(...)
	local Username=(...)


	char=Players.LocalPlayer

	TweenService=TweenService

	speaker=Players.LocalPlayer
	Players=Players

	local players=getPlr(Username)
	TweenService:Create(getRoot(speaker.Character),TweenInfo.new(2,Enum.EasingStyle.Linear),{CFrame=getRoot(players.Character).CFrame+Vector3.new(3,1,0)}):Play()

end,true)

cmd.add({"reach", "swordreach"}, {"reach [number] (swordreach)", "Extends sword reach in one direction"}, function(reachsize)
	reachsize = tonumber(reachsize) or 25

	local char = getChar()
	local bp = getBp()
	local Tool = char and char:FindFirstChildOfClass("Tool") or bp and bp:FindFirstChildOfClass("Tool")

	if not Tool then return end

	local toolHnld = Tool:FindFirstChild("Handle") or Tool:FindFirstChildWhichIsA("BasePart")
	if not toolHnld then return end

	if Tool:FindFirstChild("OGSize3") then
		toolHnld.Size = Tool.OGSize3.Value
		Tool.OGSize3:Destroy()
		if toolHnld:FindFirstChild("FunTIMES") then
			toolHnld.FunTIMES:Destroy()
		end
	end

	local val = Instance.new("Vector3Value", Tool)
	val.Name = "OGSize3"
	val.Value = toolHnld.Size

	local sb = Instance.new("SelectionBox")
	sb.Adornee = toolHnld
	sb.Name = "FunTIMES"
	sb.LineThickness = 0.01
	sb.Color3 = Color3.fromRGB(255, 0, 0)
	sb.Transparency = 0.7
	sb.Parent = toolHnld

	toolHnld.Massless = true
	toolHnld.Size = Vector3.new(toolHnld.Size.X, toolHnld.Size.Y, reachsize)
end,true)

cmd.add({"boxreach", "aura"}, {"boxreach [number] (aura)", "Creates a box-shaped hitbox around your tool"}, function(reachsize)
	reachsize = tonumber(reachsize) or 25

	local char = getChar()
	local bp = getBp()
	local Tool = char and char:FindFirstChildOfClass("Tool") or bp and bp:FindFirstChildOfClass("Tool")

	if not Tool then return end

	local toolHnld = Tool:FindFirstChild("Handle") or Tool:FindFirstChildWhichIsA("BasePart")
	if not toolHnld then return end

	if Tool:FindFirstChild("OGSize3") then
		toolHnld.Size = Tool.OGSize3.Value
		Tool.OGSize3:Destroy()
		if toolHnld:FindFirstChild("FunTIMES") then
			toolHnld.FunTIMES:Destroy()
		end
	end

	local val = Instance.new("Vector3Value", Tool)
	val.Name = "OGSize3"
	val.Value = toolHnld.Size

	local sb = Instance.new("SelectionBox")
	sb.Adornee = toolHnld
	sb.Name = "FunTIMES"
	sb.LineThickness = 0.01
	sb.Color3 = Color3.fromRGB(0, 0, 255)
	sb.Transparency = 0.7
	sb.Parent = toolHnld

	toolHnld.Massless = true
	toolHnld.Size = Vector3.new(reachsize, reachsize, reachsize)
end,true)

cmd.add({"resetreach", "normalreach", "unreach"}, {"resetreach (normalreach, unreach)", "Resets tool to normal size"}, function()
	local char = getChar()
	local bp = getBp()
	local Tool = char and char:FindFirstChildOfClass("Tool") or bp and bp:FindFirstChildOfClass("Tool")

	if not Tool then return end

	local toolHnld = Tool:FindFirstChild("Handle") or Tool:FindFirstChildWhichIsA("BasePart")
	if not toolHnld then return end

	if Tool:FindFirstChild("OGSize3") then
		toolHnld.Size = Tool.OGSize3.Value
		Tool.OGSize3:Destroy()
		if toolHnld:FindFirstChild("FunTIMES") then
			toolHnld.FunTIMES:Destroy()
		end
	end
end)

local AntiVoidConnect = nil

cmd.add({"antivoid"},{"antivoid","Prevents you from falling into the void by launching you upwards"},function()
	if AntiVoidConnect then
		AntiVoidConnect:Disconnect()
		AntiVoidConnect = nil
	end

	AntiVoidConnect = RunService.Stepped:Connect(function()
		local character = Players.LocalPlayer.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root and root.Position.Y <= OrgDestroyHeight + 25 then
			root.Velocity = Vector3.new(root.Velocity.X, root.Velocity.Y + 250, root.Velocity.Z)
		end
	end)

	DoNotif("AntiVoid Enabled", 3)
end)

cmd.add({"unantivoid"},{"unantivoid","Disables antivoid"},function()
	if AntiVoidConnect then
		AntiVoidConnect:Disconnect()
		AntiVoidConnect = nil
	end

	DoNotif("AntiVoid Disabled", 3)
end)

cmd.add({"droptools"},{"dropalltools","Drop all of your tools"},function()
	backpack=getBp()
	if backpack then
		for _,tool in pairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent=character
			end
		end
	end
	wait()
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent=SafeGetService("Workspace")
		end
	end
end)

cmd.add({"notools"},{"notools","Remove your tools"},function()
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Destroy()
		end
	end
	for _,tool in pairs(localPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Destroy()
		end
	end
end)

cmd.add({"breaklayeredclothing","blc"},{"breaklayeredclothing (blc)","Streches your layered clothing"},function()
	--its literally just leg resize with swim
	wait();

	DoNotif("Break layered clothing executed,if you havent already equip shirt,jacket,pants and shoes (Layered Clothing ones)")
	local swimming=false
	local RunService=RunService
	oldgrav=SafeGetService("Workspace").Gravity
	SafeGetService("Workspace").Gravity=0
	local char=getChar()
	local swimDied=function()
		SafeGetService("Workspace").Gravity=oldgrav
		swimming=false
	end
	Humanoid=char:FindFirstChildWhichIsA("Humanoid")
	gravReset=Humanoid.Died:Connect(swimDied)
	enums=Enum.HumanoidStateType:GetEnumItems()
	table.remove(enums,table.find(enums,Enum.HumanoidStateType.None))
	for i,v in pairs(enums) do
		Humanoid:SetStateEnabled(v,false)
	end
	Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	swimbeat=RunService.Heartbeat:Connect(function()
		pcall(function()
			getRoot(char).Velocity=((Humanoid.MoveDirection~=Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space)) and getRoot(char).Velocity or Vector3.new())
		end)
	end)
	swimming=true
	Clip=false
	wait(0.1)
	function NoclipLoop()
		if Clip==false and char~=nil then
			for _,child in pairs(char:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide==true then
					child.CanCollide=false
				end
			end
		end
	end
	Noclipping=RunService.Stepped:Connect(NoclipLoop)
	loadstring(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/leg%20resize'))()
end)

cmd.add({"fpsbooster","lowgraphics","boostfps","lowg"},{"fpsbooster (lowgraphics,boostfps,lowg)","Low graphics mode if the game is laggy"},function()
	local decalsYeeted = true
	local w = SafeGetService("Workspace")
	local l = SafeGetService("Lighting")
	local t = w.Terrain

	function optimizeInstance(v)
		if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsYeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("MeshPart") and decalsYeeted then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.TextureID = 10385902758728957
		elseif v:IsA("SpecialMesh") and decalsYeeted then
			v.TextureId = 0
		elseif v:IsA("ShirtGraphic") and decalsYeeted then
			v.Graphic = 0
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsYeeted then
			v[v.ClassName.."Template"] = 0
		end
	end

	sethiddenproperty(l, "Technology", 2)
	sethiddenproperty(t, "Decoration", false)
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = false
	l.FogEnd = 9e9
	l.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"

	for _, v in pairs(w:GetDescendants()) do
		optimizeInstance(v)
	end

	for _, e in pairs(l:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end

	w.DescendantAdded:Connect(function(v)
		task.wait()
		optimizeInstance(v)
	end)
end)

cmd.add({"antilag","boostfps"},{"antilag (boostfps)","Low Graphics"},function()
	_G.Settings={
		Players={
			["Ignore Me"]=true,
			["Ignore Others"]=true
		},
		Meshes={
			Destroy=false,
			LowDetail=true
		},
		Images={
			Invisible=true,
			LowDetail=true,
			Destroy=true,
		},
		Other={
			["No Particles"]=true,
			["No Camera Effects"]=true,
			["No Explosions"]=true,
			["No Clothes"]=true,
			["Low Water Graphics"]=true,
			["No Shadows"]=true,
			["Low Rendering"]=true,
			["Low Quality Parts"]=true
		}
	}
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/low%20detail"))()
end)

local annoyLoop = false

cmd.add({"annoy"},{"annoy <player>","Annoys the given player"},function(...)
	annoyLoop = false
	task.wait(.2);
	annoyLoop = true
	local user = (...)
	local target = getPlr(user)
	local character = getChar()
	local root = character and getRoot(character)
	local saveCFrame = root and root.CFrame

	if not target or not target.Character or not root then
		DoNotif("Target or your character is invalid.", 3)
		annoyLoop = false
		return
	end

	repeat
		task.wait(0.1)
		local targetRoot = getRoot(target.Character)
		if targetRoot then
			root.CFrame = targetRoot.CFrame + Vector3.new(math.random(-2, 2), math.random(0, 2), math.random(-2, 2))
		end
		RunService.RenderStepped:Wait()
	until not annoyLoop

	if saveCFrame then
		root.CFrame = saveCFrame
	end
end,true)

cmd.add({"unannoy"},{"unannoy","Stops the annoy command"},function()
	annoyLoop = false
end)

cmd.add({"deleteinvisparts","deleteinvisibleparts","dip"},{"deleteinvisparts (deleteinvisibleparts,dip)","Deletes invisible parts"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency==1 and v.CanCollide then
			v:Destroy()
		end
	end
end)

local shownParts={}

cmd.add({"invisibleparts","invisparts"},{"invisibleparts (invisparts)","Shows invisible parts"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency==1 then
			if not table.find(shownParts,v) then
				table.insert(shownParts,v)
			end
			v.Transparency=0
		end
	end
end)

cmd.add({"uninvisibleparts","uninvisparts"},{"uninvisibleparts (uninvisparts)","Makes parts affected by invisparts return to normal"},function()
	for i,v in pairs(shownParts) do
		v.Transparency=1
	end
	shownParts={}
end)

cmd.add({"replicationlag","backtrack"},{"replicationlag (backtrack)","Set IncomingReplicationLag"},function(...)
	local t={...}
	local args=t[1] or 0

	if tonumber(args) then
		settings():GetService("NetworkSettings").IncomingReplicationLag=args
	end
end,true)

cmd.add({"norender"},{"norender","Disable 3d Rendering to decrease the amount of CPU the client uses"},function()
	RunService:Set3dRenderingEnabled(false)
end)

cmd.add({"render"},{"render","Enable 3d Rendering"},function()
	RunService:Set3dRenderingEnabled(true)
end)

oofing=false

cmd.add({"loopoof"},{"loopoof","Loops everyones character sounds (everyone can hear)"},function()
	oofing=true
	repeat wait(0.1)
		for i,v in pairs(Players:GetPlayers()) do
			if v.Character~=nil and v.Character:FindFirstChild'Head' then
				for _,x in pairs(v.Character:FindFirstChild("Head"):GetChildren()) do
					if x:IsA'Sound' then x.Playing=true end
				end
			end
		end
	until oofing==false
end)

cmd.add({"unloopoof"},{"unloopoof","Stops the oof chaos"},function()
	oofing=false
end)

cmd.add({"strengthen"},{"strengthen","Makes your character more dense (CustomPhysicalProperties)"},function(...)
	local args={...}
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child.ClassName=="Part" then
			if args[1] then
				child.CustomPhysicalProperties=PhysicalProperties.new(args[1],0.3,0.5)
			else
				child.CustomPhysicalProperties=PhysicalProperties.new(100,0.3,0.5)
			end
		end
	end
end,true)

cmd.add({"unweaken","unstrengthen"},{"unweaken (unstrengthen)","Sets your characters CustomPhysicalProperties to default"},function()
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child.ClassName=="Part" then
			child.CustomPhysicalProperties=PhysicalProperties.new(0.7,0.3,0.5)
		end
	end
end)

cmd.add({"weaken"},{"weaken","Makes your character less dense"},function(...)
	local args={...}
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child.ClassName=="Part" then
			if args[1] then
				child.CustomPhysicalProperties=PhysicalProperties.new(-args[1],0.3,0.5)
			else
				child.CustomPhysicalProperties=PhysicalProperties.new(0,0.3,0.5)
			end
		end
	end
end,true)

cmd.add({"seat"},{"seat","Finds a seat and automatically sits on it"},function()
	local seats = {}
	for _, v in ipairs(game:GetDescendants()) do
		if v:IsA("Seat") then
			table.insert(seats, v)
		end
	end

	if #seats == 0 then
		DoNotif("No seats found in the game", 3)
		return
	end

	local humanoid = getChar() and getChar().Humanoid
	if not humanoid then
		DoNotif("Your character or humanoid is invalid", 3)
		return
	end

	for _ = 1, 8 do
		local randomSeat = seats[math.random(1, #seats)]
		randomSeat:Sit(humanoid)
		task.wait(0.07)
	end
end)

cmd.add({"copytools","ctools"},{"copytools <player> (ctools)","Copies the tools the given player has"},function(...)
	PLAYERNAMEHERE=(...)
	Target=getPlr(PLAYERNAMEHERE)
	for i,v in pairs(Target.Backpack:GetChildren()) do
		if v:IsA("Tool") or v:IsA('HopperBin') then
			v:Clone().Parent=Players.LocalPlayer:FindFirstChildOfClass("Backpack")
		end
	end
end,true)

cmd.add({"localtime", "yourtime"}, {"localtime (yourtime)", "Shows your current time"}, function()
	local time = os.date("*t")
	local clock = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec)

	DoNotif("Your Local Time Is: "..clock)
end)

cmd.add({"cartornado", "ctornado"}, {"cartornado (ctornado)", "Tornados a car just sit in the car"}, function()
	local SPart = Instance.new("Part")
	local Player = Players.LocalPlayer
	local RunService = RunService
	local Workspace = SafeGetService("Workspace")

	repeat RunService.RenderStepped:Wait() until Player.Character
	local Character = Player.Character

	SPart.Anchored = true
	SPart.CanCollide = true
	SPart.Parent = Workspace
	SPart.Size = Vector3.new(1, 100, 1)
	SPart.Transparency = 0.4

	RunService.Stepped:Connect(function()
		if Character and Character.PrimaryPart then
			local Ray = Ray.new(Character.PrimaryPart.Position + Character.PrimaryPart.CFrame.LookVector * 6, Vector3.new(0, -1, 0) * 4)
			local FPOR = Workspace:FindPartOnRayWithIgnoreList(Ray, {Character})

			if FPOR then
				SPart.CFrame = Character.PrimaryPart.CFrame + Character.PrimaryPart.CFrame.LookVector * 6
			end
		end
	end)

	SPart.Touched:Connect(function(hit)
		if hit:IsA("Seat") then
			local IsFlying = true
			local flyv = Instance.new("BodyVelocity")
			local flyg = Instance.new("BodyGyro")
			local Speed = 50
			local LastSpeed = Speed
			local maxspeed = 100
			local IsRunning = false
			local f = 0

			flyv.Parent = getTorso(Character)
			flyv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

			flyg.Parent = getTorso(Character)
			flyg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			flyg.P = 1000
			flyg.D = 50

			Character:WaitForChild("Humanoid").PlatformStand = true

			Character.Humanoid.Changed:Connect(function()
				IsRunning = Character.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0)
			end)

			spawn(function()
				while IsFlying do
					flyg.CFrame = Workspace.CurrentCamera.CFrame * CFrame.Angles(-math.rad(f * 50 * Speed / maxspeed), 0, 0)
					flyv.Velocity = Workspace.CurrentCamera.CFrame.LookVector * Speed
					wait(0.1)

					if Speed < 0 then
						Speed = 0
						f = 0
					end

					if IsRunning then
						Speed = LastSpeed
					else
						if Speed ~= 0 then
							LastSpeed = Speed
						end
						Speed = 0
					end
				end
			end)

			wait(0.3)
			hit:Sit(Character.Humanoid)
			SPart:Destroy()

			local seat = Character:FindFirstChildOfClass("Humanoid").SeatPart
			local vehicleModel = seat.Parent

			while vehicleModel.ClassName ~= "Model" do
				vehicleModel = vehicleModel.Parent
			end

			for _, v in pairs(vehicleModel:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide = false
				end
			end

			wait(0.2)
			Speed = 80

			local Spin = Instance.new("BodyAngularVelocity")
			Spin.Name = "Spinning"
			Spin.Parent = Character.PrimaryPart
			Spin.MaxTorque = Vector3.new(0, math.huge, 0)
			Spin.AngularVelocity = Vector3.new(0, 2000, 0)
		end
	end)
end)

cmd.add({"unspam","unlag","unchatspam","unanimlag","unremotespam"},{"unspam","Stop all attempts to lag/spam"},function()
	lib.disconnect("spam")
end)

cmd.add({"UNCTest","UNC"},{"UNCTest (UNC)","Test how many functions your executor supports"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/UNC%20test"))()
end)

cmd.add({"sUNCtest","sUNC"},{"sUNCtest (sUNC)","uses Super UNC test that test the functions if they're working"},function()
	getgenv().sUNCDebug = {
		["printcheckpoints"] = false,
		["delaybetweentests"] = 0
	}

	loadstring(game:HttpGet("https://script.sunc.su/"))()
end)

cmd.add({"vulnerabilitytest","vulntest"},{"vulnerabilitytest (vulntest)","Test if your executor is Vulnerable"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/VulnTest.lua"))()
end)

cmd.add({"respawn", "re"}, {"respawn", "Respawn your character"}, function()
	respawn()
end)

cmd.add({"antisit"},{"antisit","Prevents the player from sitting"},function()
	local character = Player.Character
	local humanoid = character and character:FindFirstChild("Humanoid")

	if not humanoid then
		DoNotif("Your character or humanoid is invalid", 3)
		return
	end

	humanoid:SetStateEnabled("Seated", false)
	humanoid.Sit = true

	DoNotif("Anti sit enabled", 3)
end)

cmd.add({"unantisit"},{"unantisit","Allows the player to sit again"},function()
	local character = Player.Character
	local humanoid = character and character:FindFirstChild("Humanoid")

	if not humanoid then
		DoNotif("Your character or humanoid is invalid", 3)
		return
	end

	humanoid:SetStateEnabled("Seated", true)
	humanoid.Sit = false

	DoNotif("Anti sit disabled", 3)
end)

cmd.add({"antikick", "nokick", "bypasskick", "bk"}, {"antikick (nokick, bypasskick, bk)", "Bypass Kick on Most Games"}, function()
	local getRawMetatable = (debug and debug.getmetatable) or getrawmetatable
	local setReadOnly = setreadonly or (
		make_writeable and function(table, readonly)
			if readonly then
				make_readonly(table)
			else
				make_writeable(table)
			end
		end
	)

	if not getRawMetatable or not setReadOnly then
		DoNotif("Required functions for metatable manipulation are not available")
		return
	end

	local player = Players.LocalPlayer
	if not player then
		DoNotif("LocalPlayer not found")
		return
	end

	local meta = getRawMetatable(game)
	if not meta then
		DoNotif("Failed to get the metatable of the game object.")
		return
	end

	local oldNamecall = meta.__namecall
	local oldIndex = meta.__index
	local oldNewIndex = meta.__newindex

	setReadOnly(meta, false)

	meta.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if typeof(method) == "string" then
			if (method:lower() == "kick") and self == player then
				DoNotif("A kick attempt was blocked.")
				return
			end
			if (method:lower() == "destroy") and self == player then
				DoNotif("An attempt to destroy you was blocked.")
				return
			end
		end
		return oldNamecall(self, ...)
	end)

	meta.__index = newcclosure(function(self, key)
		if self == player and key == "Kick" then
			DoNotif("An attempt to access Kick was blocked.")
			return function() end
		end
		if self == player and key == "Destroy" then
			DoNotif("An attempt to access Destroy was blocked.")
			return function() end
		end
		return oldIndex(self, key)
	end)

	meta.__newindex = newcclosure(function(self, key, value)
		if self == player and (key == "Kick" or key == "Destroy") then
			DoNotif("An attempt to overwrite "..key.." was blocked.")
			return
		end
		return oldNewIndex(self, key, value)
	end)

	setReadOnly(meta, true)
	DoNotif("Anti-Kick Enabled")
end)

cmd.add({"bypassteleport", "btp"}, {"bypassteleport (btp)", "Bypass Teleportation on Most Games"}, function()
	local getRawMetatable = (debug and debug.getmetatable) or getrawmetatable
	local setReadOnly = setreadonly or (
		make_writeable and function(table, readonly)
			if readonly then
				make_readonly(table)
			else
				make_writeable(table)
			end
		end
	)

	local localPlayer = Players.LocalPlayer
	local meta = getRawMetatable(game)
	local isCaller = checkcaller or is_protosmasher_caller
	local originalIndex = meta.__index
	local originalNewIndex = meta.__newindex

	setReadOnly(meta, false)

	meta.__newindex = newcclosure(function(self, property, value)
		if isCaller() then
			return originalNewIndex(self, property, value)
		end

		local objectName = tostring(self)
		if objectName == "HumanoidRootPart" or objectName == "Torso" or objectName == "UpperTorso" then
			if property == "CFrame" or property == "Position" then
				return true
			end
		end

		return originalNewIndex(self, property, value)
	end)

	setReadOnly(meta, true)

	DoNotif("Teleport bypass enabled.")
end)

cmd.add({"anticframeteleport","acframetp","acftp"},{"anticframeteleport (acframetp,acftp)","Prevents scripts from teleporting you by resetting your CFrame"},function()
	getgenv().acftp = true
	local player = Players.LocalPlayer
	local character = player and player.Character
	local root = character and getRoot(character)

	if not root then
		DoNotif("Your character or root part is invalid.", 3)
		return
	end

	DoNotif("Anti CFrame Teleport enabled", 3)

	local oldCFrame = root.CFrame
	con(root:GetPropertyChangedSignal("CFrame"), function()
		if getgenv().acftp then
			root.CFrame = oldCFrame
			task.wait()
		end
	end)

	while getgenv().acftp and root do
		oldCFrame = root.CFrame
		task.wait()
	end
end)

cmd.add({"unanticframeteleport","unacframetp","unacftp"},{"unanticframeteleport (unacframetp,unacftp)","Disables Anti CFrame Teleport"},function()
	getgenv().acftp = false
	DoNotif("Anti CFrame Teleport disabled", 3)
end)

cmd.add({"lay"},{"lay","zzzzzzzz"},function()
	local Human=getHum()
	if not Human then return end
	Human.Sit=true
	task.wait(.1)
	Human.RootPart.CFrame=Human.RootPart.CFrame*CFrame.Angles(math.pi*.5,0,0)
	for _,v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
	end
end)

cmd.add({"trip"},{"trip","get up NOW"},function()
	getChar():FindFirstChildOfClass("Humanoid"):ChangeState(0)
	getRoot(getChar()).Velocity=getRoot(getChar()).CFrame.LookVector*25
end)

local noTripCon = nil

cmd.add({"antitrip"}, {"antitrip", "no tripping today bruh"}, function()
	function antiTrip(char)
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = getRoot(char)

		if hum and root then
			if noTripCon then 
				noTripCon:Disconnect() 
				noTripCon = nil 
			end
			noTripCon = hum.FallingDown:Connect(function()
				root.Velocity = Vector3.new(0, 0, 0)
				hum:ChangeState(Enum.HumanoidStateType.GettingUp)
			end)
		end
	end

	if LocalPlayer.Character then 
		antiTrip(LocalPlayer.Character) 
	end
	LocalPlayer.CharacterAdded:Connect(function(char)
		antiTrip(char)
	end)
end)

cmd.add({"unantitrip"}, {"unantitrip", "tripping allowed now"}, function()
	if noTripCon then
		noTripCon:Disconnect()
		noTripCon = nil
	end
end)

cmd.add({"checkrfe"},{"checkrfe","Checks if the game has respect filtering enabled off"},function()
	if SoundService.RespectFilteringEnabled==true then
		DoNotif("Respect Filtering Enabled is on")
	else
		DoNotif("Respect Filtering Enabled is off")
	end
end)

cmd.add({"sit"},{"sit","Sit your player"},function()
	local hum=character:FindFirstChildWhichIsA("Humanoid")
	if hum then
		hum.Sit=true
	end
end)

cmd.add({"oldroblox"},{"oldroblox","Old skybox and studs"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") then
			local dec=Instance.new("Texture",v)
			dec.Texture="rbxassetid://48715260"
			dec.Face="Top"
			dec.StudsPerTileU="1"
			dec.StudsPerTileV="1"
			dec.Transparency=v.Transparency
			v.Material="Plastic"
			local dec2=Instance.new("Texture",v)
			dec2.Texture="rbxassetid://20299774"
			dec2.Face="Bottom"
			dec2.StudsPerTileU="1"
			dec2.StudsPerTileV="1"
			dec2.Transparency=v.Transparency
			v.Material="Plastic"
		end
	end
	Lighting.ClockTime=12
	Lighting.GlobalShadows=false
	Lighting.Outlines=false
	for i,v in pairs(Lighting:GetDescendants()) do
		if v:IsA("Sky") then
			v:Destroy()
		end
	end
	local sky=Instance.new("Sky",Lighting)
	sky.SkyboxBk="rbxassetid://161781263"
	sky.SkyboxDn="rbxassetid://161781258"
	sky.SkyboxFt="rbxassetid://161781261"
	sky.SkyboxLf="rbxassetid://161781267"
	sky.SkyboxRt="rbxassetid://161781268"
	sky.SkyboxUp="rbxassetid://161781260"
end)

cmd.add({"f3x","fex"},{"f3x","F3X for client"},function()
	loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

cmd.add({"harked","comet"},{"harked (comet)","Executes Comet which is like harked"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/comet"))();
end)

cmd.add({"triggerbot", "tbot"}, {"triggerbot (tbot)", "Executes a script that automatically clicks the mouse when the mouse is on a player"}, function()
	local ToggleKey = Enum.KeyCode.Z
	local FieldOfView = 10

	local Players = Players
	local RunService = RunService
	local UIS = UserInputService
	local Camera = SafeGetService("Workspace").CurrentCamera

	local Player = Players.LocalPlayer
	local Mouse = Player:GetMouse()
	local Toggled = false
	local Mode = "FFA"
	local LastMode = nil

	local GUI = Instance.new("ScreenGui")
	local On = Instance.new("TextLabel")
	local uicorner = Instance.new("UICorner")
	GUI.Name = "GUI"
	NaProtectUI(GUI)
	On.Name = "On"
	On.Parent = GUI
	On.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
	On.BackgroundTransparency = 0.14
	On.BorderSizePixel = 0
	On.Position = UDim2.new(0.88, 0, 0.33, 0)
	On.Size = UDim2.new(0, 160, 0, 20)
	On.Font = Enum.Font.SourceSans
	On.Text = "TriggerBot On: false (Key: Q)"
	On.TextColor3 = Color3.new(1, 1, 1)
	On.TextScaled = true
	On.TextSize = 14
	On.TextWrapped = true
	uicorner.Parent = On

	local function IsInFieldOfView(target)
		local targetPosition = target.Position
		local screenPoint, onScreen = Camera:WorldToScreenPoint(targetPosition)
		if onScreen then
			local mousePosition = Vector2.new(Mouse.X, Mouse.Y)
			local targetScreenPosition = Vector2.new(screenPoint.X, screenPoint.Y)
			local distance = (mousePosition - targetScreenPosition).Magnitude
			return distance <= FieldOfView
		end
		return false
	end

	local function IsEnemy(otherPlayer)
		if Mode == "FFA" then
			return true
		else
			return otherPlayer.Team ~= nil and Player.Team ~= nil and otherPlayer.Team ~= Player.Team
		end
	end

	local function GetClosestPlayer()
		for _, otherPlayer in pairs(Players:GetPlayers()) do
			if otherPlayer ~= Player and IsEnemy(otherPlayer) and otherPlayer.Character then
				for _, part in pairs(otherPlayer.Character:GetChildren()) do
					if part:IsA("BasePart") and IsInFieldOfView(part) then
						return otherPlayer
					end
				end
			end
		end
		return nil
	end

	local function Click()
		mouse1click()
	end

	local function CheckMode()
		if #Players:GetPlayers() > 0 and Players.LocalPlayer.Team == nil then
			Mode = "FFA"
		else
			Mode = "Team"
		end

		if Mode ~= LastMode then
			DoNotif("Mode changed to: "..Mode)
			LastMode = Mode
		end
	end

	UIS.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == ToggleKey then
			Toggled = not Toggled
			On.Text = "TriggerBot On: "..tostring(Toggled).." (Key: "..ToggleKey.Name..")"
		end
	end)

	RunService.RenderStepped:Connect(function()
		CheckMode()
		if Toggled then
			local targetPlayer = GetClosestPlayer()
			if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
				local humanoid = targetPlayer.Character.Humanoid
				if humanoid.Health > 0 then
					Click()
				end
			end
		end
	end)

	On.Text = "TriggerBot On: "..tostring(Toggled).." (Key: "..ToggleKey.Name..")"

	DoNotif("Advanced Trigger Bot Loaded")
end)

cmd.add({"nofog"},{"nofog","Removes all fog from the game"},function()
	local Lighting=Lighting
	Lighting.FogEnd=100000
	for i,v in pairs(Lighting:GetDescendants()) do
		if v:IsA("Atmosphere") then
			v:Destroy()
		end
	end
end)

stationaryRespawn = false
needsRespawning = false
hasPosition = false
spawnPosition = CFrame.new()

cmd.add({"setspawn", "spawnpoint", "ss"}, {"setspawn (spawnpoint, ss)", "Sets your spawn point to the current character's position"}, function()
	DoNotif("Spawn has been set")
	stationaryRespawn = true

	function handleRespawn()
		if stationaryRespawn and getChar().Humanoid.Health == 0 then
			if not hasPosition then
				spawnPosition = getRoot(getChar()).CFrame
				hasPosition = true
			end
			needsRespawning = true
		end

		if needsRespawning then
			getRoot(getChar()).CFrame = spawnPosition
		end
	end

	RunService.Stepped:Connect(handleRespawn)

	LocalPlayer.CharacterAdded:Connect(function()
		wait(0.6)
		needsRespawning = false
		hasPosition = false
	end)
end)

cmd.add({"disablespawn", "unsetspawn", "ds"}, {"disablespawn (unsetspawn, ds)", "Disables the previously set spawn point"}, function()
	DoNotif("Spawn point has been disabled")
	stationaryRespawn = false
	needsRespawning = false
	hasPosition = false
	spawnPosition = CFrame.new()
end)

cmd.add({"hamster"},{"hamster <number>","Hamster ball"},function(...)
	--[[ skidded ]]--
	local UserInputService=UserInputService
	local RunService=RunService
	local Camera=SafeGetService("Workspace").CurrentCamera

	local SPEED_MULTIPLIER=(...)
	local JUMP_POWER=60
	local JUMP_GAP=0.3

	if (...)==nil then
		SPEED_MULTIPLIER=30
	end

	local character=getChar()

	for i,v in ipairs(character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide=false
		end
	end

	local ball=getRoot(character)
	ball.Shape=Enum.PartType.Ball
	ball.Size=Vector3.new(5,5,5)
	local humanoid=character:WaitForChild("Humanoid")
	local params=RaycastParams.new()
	params.FilterType=Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances={character}

	local tc=RunService.RenderStepped:Connect(function(delta)
		ball.CanCollide=true
		humanoid.PlatformStand=true
		if UserInputService:GetFocusedTextBox() then return end
		if UserInputService:IsKeyDown("W") then
			ball.RotVelocity-=Camera.CFrame.RightVector*delta*SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("A") then
			ball.RotVelocity-=Camera.CFrame.LookVector*delta*SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("S") then
			ball.RotVelocity+=Camera.CFrame.RightVector*delta*SPEED_MULTIPLIER
		end
		if UserInputService:IsKeyDown("D") then
			ball.RotVelocity+=Camera.CFrame.LookVector*delta*SPEED_MULTIPLIER
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		local result=SafeGetService("Workspace"):Raycast(
			ball.Position,
			Vector3.new(
				0,
				-((ball.Size.Y/2)+JUMP_GAP),
				0
			),
			params
		)
		if result then
			ball.Velocity=ball.Velocity+Vector3.new(0,JUMP_POWER,0)
		end
	end)

	Camera.CameraSubject=ball
	humanoid.Died:Connect(function() tc:Disconnect() end)
end,true)

local antiAFKConnection = nil

cmd.add({"antiafk","noafk"},{"antiafk (noafk)","Prevents you from being kicked for being AFK"},function()
	if not antiAFKConnection then
		local player = Players.LocalPlayer
		local virtualUser = SafeGetService("VirtualUser")

		antiAFKConnection = player.Idled:Connect(function()
			virtualUser:Button2Down(Vector2.new(0, 0), SafeGetService("Workspace").CurrentCamera.CFrame)
			task.wait(1)
			virtualUser:Button2Up(Vector2.new(0, 0), SafeGetService("Workspace").CurrentCamera.CFrame)
		end)

		DoNotif("Anti AFK has been enabled")
	else
		DoNotif("Anti AFK is already enabled")
	end
end)

cmd.add({"unantiafk","unnoafk"},{"unantiafk (unnoafk)","Allows you to be kicked for being AFK"},function()
	if antiAFKConnection then
		antiAFKConnection:Disconnect()
		antiAFKConnection = nil
		DoNotif("Anti AFK has been disabled")
	else
		DoNotif("Anti AFK is already disabled")
	end
end)

local tpUI = nil

cmd.add({"clicktp", "tptool"}, {"clicktp (tptool)", "Teleport where your mouse is"}, function()
	local Players = SafeGetService("Players")
	local TweenService = SafeGetService("TweenService")
	local player = Players.LocalPlayer
	local mouse = player:GetMouse()

	if tpUI then tpUI:Destroy() tpUI = nil end

	tpUI = Instance.new("ScreenGui")
	tpUI.Name = randomString()
	NaProtectUI(tpUI)

	local clickTpButton = Instance.new("TextButton")
	clickTpButton.Size = UDim2.new(0, 130, 0, 40)
	clickTpButton.Position = UDim2.new(0.5, -140, 0, 10)
	clickTpButton.Text = "Enable Click TP"
	clickTpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	clickTpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	clickTpButton.BorderSizePixel = 0
	clickTpButton.Parent = tpUI

	local clickTpCorner = Instance.new("UICorner")
	clickTpCorner.CornerRadius = UDim.new(0, 10)
	clickTpCorner.Parent = clickTpButton

	local tweenTpButton = Instance.new("TextButton")
	tweenTpButton.Size = UDim2.new(0, 130, 0, 40)
	tweenTpButton.Position = UDim2.new(0.5, 10, 0, 10)
	tweenTpButton.Text = "Enable Tween TP"
	tweenTpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tweenTpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	tweenTpButton.BorderSizePixel = 0
	tweenTpButton.Parent = tpUI

	local tweenTpCorner = Instance.new("UICorner")
	tweenTpCorner.CornerRadius = UDim.new(0, 10)
	tweenTpCorner.Parent = tweenTpButton

	local clickTpEnabled = false
	local tweenTpEnabled = false

	MouseButtonFix(clickTpButton, function()
		clickTpEnabled = not clickTpEnabled
		tweenTpEnabled = false
		tweenTpButton.Text = "Enable Tween TP"
		clickTpButton.Text = clickTpEnabled and "Disable Click TP" or "Enable Click TP"
	end)

	MouseButtonFix(tweenTpButton, function()
		tweenTpEnabled = not tweenTpEnabled
		clickTpEnabled = false
		clickTpButton.Text = "Enable Click TP"
		tweenTpButton.Text = tweenTpEnabled and "Disable Tween TP" or "Enable Tween TP"
	end)

	local function CustomClick(onClick)
		local initialMousePosition = nil
		local dragThreshold = 10

		mouse.Button1Down:Connect(function()
			initialMousePosition = Vector2.new(mouse.X, mouse.Y)
		end)

		mouse.Button1Up:Connect(function()
			if initialMousePosition then
				local currentMousePosition = Vector2.new(mouse.X, mouse.Y)
				local distance = (currentMousePosition - initialMousePosition).Magnitude

				if distance <= dragThreshold then
					onClick(mouse)
				end
			end
			initialMousePosition = nil
		end)
	end

	CustomClick(function(mouse)
		if clickTpEnabled then
			local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
			local targetCFrame = CFrame.new(pos.X, pos.Y, pos.Z)
			getRoot(player.Character).CFrame = targetCFrame
		elseif tweenTpEnabled then
			local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
			local humanoidRootPart = getRoot(player.Character)
			local tweenInfo = TweenInfo.new(
				1,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
				0,
				false,
				0
			)
			local tween = TweenService:Create(humanoidRootPart, tweenInfo, {
				CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
			})
			tween:Play()
		end
	end)

	gui.draggable(clickTpButton)
	gui.draggable(tweenTpButton)
end)

cmd.add({"unclicktp", "untptool"}, {"unclicktp (untptool)", "Remove teleport buttons"}, function()
	if tpUI then tpUI:Destroy() tpUI = nil end
end)

cmd.add({"dex"},{"dex","Using this you can see the parts / guis / scripts etc with this. A really good and helpful script."},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/DexByMoonMobile"))()
end)

cmd.add({"Decompiler"},{"Decompiler","Allows you to decompile LocalScript/ModuleScript's"},function()
	task.spawn(function()
		assert(getscriptbytecode, "Exploit not supported.")

		local API: string = "http://api.plusgiant5.com/"

		local last_call = 0
		function call(konstantType: string, scriptPath: Script | ModuleScript | LocalScript): string
			local success: boolean, bytecode: string = pcall(getscriptbytecode, scriptPath)

			if (not success) then
				return
			end

			local time_elapsed = os.clock() - last_call
			if time_elapsed <= .5 then
				task.wait(.5 - time_elapsed)
			end
			local httpResult = req({
				Url = API..konstantType,
				Body = bytecode,
				Method = "POST",
				Headers = {
					["Content-Type"] = "text/plain"
				},
			})
			last_call = os.clock()

			if (httpResult.StatusCode ~= 200) then
				return
			else
				return httpResult.Body
			end
		end

		function decompile(scriptPath: Script | ModuleScript | LocalScript): string
			return call("/konstant/decompile", scriptPath)
		end

		function disassemble(scriptPath: Script | ModuleScript | LocalScript): string
			return call("/konstant/disassemble", scriptPath)
		end

		getgenv().decompile = decompile
		getgenv().disassemble = disassemble

		-- by lovrewe
	end)
	--loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/WompWomp.lua"))()
end)

cmd.add({"getidfromusername","gidu"},{"getidfromusername (gidu)","Copy a user's UserId by Username"}, function(thingy)
	local s,idd=pcall(function()
		return Players:GetUserIdFromNameAsync(tostring(thingy))
	end)

	if not s then return warn("err: "..tostring(idd)) end

	if not setclipboard then return DoNotif("no setclipboard") end
	setclipboard(tostring(idd))

	DoNotif("Copied "..tostring(thingy).."'s UserId: "..tostring(idd))
end,true)

cmd.add({"getuserfromid","guid"},{"getuserfromid (guid)","Copy a user's Username by ID"}, function(thingy)
	local s,naem=pcall(function()
		return Players:GetNameFromUserIdAsync(thingy)
	end)

	if not s then return warn("err: "..tostring(naem)) end

	if not setclipboard then return DoNotif("no setclipboard") end
	setclipboard(tostring(naem))

	DoNotif("Copied "..tostring(naem).."'s Username with ID of "..tostring(thingy))
end,true)

cmd.add({"synapsedex","sdex"},{"synapsedex (sdex)","Loads SynapseX's dex explorer"},function()
	local rng=Random.new()

	local charset={}
	for i=48,57 do table.insert(charset,string.char(i)) end
	for i=65,90 do table.insert(charset,string.char(i)) end
	for i=97,122 do table.insert(charset,string.char(i)) end
	function RandomCharacters(length)
		if length>0 then
			return RandomCharacters(length-1)..charset[rng:NextInteger(1,#charset)]
		else
			return ""
		end
	end

	local Dex=game:GetObjects("rbxassetid://9553291002")[1]
	Dex.Name=RandomCharacters(rng:NextInteger(5,20))
	NaProtectUI(Dex)

	function Load(Obj,Url)
		function GiveOwnGlobals(Func,Script)
			local Fenv={}
			local RealFenv={script=Script}
			local FenvMt={}
			FenvMt.__index=function(a,b)
				if RealFenv[b]==nil then
					return getfenv()[b]
				else
					return RealFenv[b]
				end
			end
			FenvMt.__newindex=function(a,b,c)
				if RealFenv[b]==nil then
					getfenv()[b]=c
				else
					RealFenv[b]=c
				end
			end
			setmetatable(Fenv,FenvMt)
			setfenv(Func,Fenv)
			return Func
		end

		function LoadScripts(Script)
			if Script.ClassName=="Script" or Script.ClassName=="LocalScript" then
				spawn(function()
					GiveOwnGlobals(loadstring(Script.Source,"="..Script:GetFullName()),Script)()
				end)
			end
			for i,v in pairs(Script:GetChildren()) do
				LoadScripts(v)
			end
		end

		LoadScripts(Obj)
	end

	Load(Dex)
end)

local antifling = nil

cmd.add({"antifling"},{"antifling","makes other players non-collidable with you"},function()
	if antifling then antifling:Disconnect() antifling=nil end
	antifling=RunService.Stepped:Connect(function()
		for _,plr in ipairs(Players:GetPlayers()) do
			if plr~=LocalPlayer and plr.Character then
				for _,p in ipairs(plr.Character:GetDescendants()) do
					if p:IsA("BasePart") then
						p.CanCollide=false
					end
				end
			end
		end
	end)
	DoNotif("Antifling Enabled")
end)

cmd.add({"unantifling"}, {"unantifling", "restores collision for other players"}, function()
	if antifling then antifling:Disconnect() antifling = nil end
	DoNotif("Antifling Disabled")
end)

cmd.add({"gravitygun"},{"gravitygun","Probably the best gravity gun script thats fe"},function()
	wait();
	DoNotif("Wait a few seconds for it to load")
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/gravity%20gun"))()
end)

cmd.add({"lockws","lockworkspace"},{"lockws (lockworkspace)","Locks the whole workspace"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		v.Locked=true
	end
end)

cmd.add({"unlockws","unlockworkspace"},{"unlockws (unlockworkspace)","Unlocks the whole workspace"},function()
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		v.Locked=false
	end
end)

local vehicleloopspeed

cmd.add({"vehiclespeed", "vspeed"}, {"vehiclespeed <amount> (vspeed)", "Change the vehicle speed"}, function(amount)
	if vehicleloopspeed then
		vehicleloopspeed:Disconnect()
		vehicleloopspeed = nil
	end

	local intens = tonumber(amount)
	if not intens or intens <= 0 then
		DoNotif("Invalid speed amount. Please provide a positive number.")
		return
	end

	vehicleloopspeed = RunService.Stepped:Connect(function()
		local subject = SafeGetService("Workspace").CurrentCamera.CameraSubject
		if subject and subject:IsA("Humanoid") and subject.SeatPart then
			subject.SeatPart:ApplyImpulse(subject.SeatPart.CFrame.LookVector * Vector3.new(intens, 0, intens))
		elseif subject and subject:IsA("BasePart") then
			subject:ApplyImpulse(subject.CFrame.LookVector * Vector3.new(intens, 0, intens))
		end
	end)

	DoNotif("Vehicle speed set to "..intens)
end,true)

cmd.add({"unvehiclespeed", "unvspeed"}, {"unvehiclespeed (unvspeed)", "Stops the vehiclespeed command"}, function()
	if vehicleloopspeed then
		vehicleloopspeed:Disconnect()
		vehicleloopspeed = nil
		DoNotif("Vehicle speed disabled")
	else
		DoNotif("Vehicle speed is not active")
	end
end)

local active=false
local players=Players
local camera=SafeGetService("Workspace").CurrentCamera

local uis=UserInputService

local active=false
function UpdateAutoRotate(BOOL)
	humanoid.AutoRotate=BOOL
end

local NA=false
local gg=nil
local gameSettings=UserSettings():GetService("UserGameSettings")
local JJ=nil

function EnableShiftlock()
	local i,k=pcall(function()
		return gameSettings.RotationType
	end)
	_=i
	gg=k
	if JJ then JJ:Disconnect() end
	JJ=RunService.RenderStepped:Connect(function()
		pcall(function()
			gameSettings.RotationType=Enum.RotationType.CameraRelative
		end)
	end)
	DoNotif("ShiftLock Enabled",2,"ShiftLock")
end

function DisableShiftlock()
	if JJ then
		pcall(function()
			gameSettings.RotationType=gg or Enum.RotationType.MovementRelative
		end)
		JJ:Disconnect()
	end
	DoNotif("ShiftLock Disabled",2,"ShiftLock")
end

cmd.add({"shiftlock","sl"},{"shiftlock (sl)","Enables shiftlock"},function()
	if IsOnMobile then
		loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/shiftlock?raw=true"))()
	else
		EnableShiftlock()
	end
end)

cmd.add({"unshiftlock","unsl"},{"unshiftlock (unsl)","Disables shiftlock"},function()
	if IsOnPC then
		DisableShiftlock()
	end
end)

-- loops soon i am just not bothered rn

cmd.add({"enable"}, {"enable", "Enables a specific CoreGui"}, function()
	Notify({
		Title = "Enable a Specific Core Gui Element",
		--Description = '',
		--Duration = 3,
		Buttons = {
			{Text = "Reset Button", Callback = function() StarterGui:SetCore("ResetButtonCallback", true) end};
			{Text = "Shiftlock", Callback = function() LocalPlayer.DevEnableMouseLock = true end};
			{Text = "Backpack", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true) end};
			{Text = "Chat", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/EnableChat.lua"))() end};
			{Text = "Health", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, true) end};
			{Text = "PlayerList (Leaderboard)", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true) end};
			{Text = "Emotes Menu", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true) end};
			{Text = "All CoreGui", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/EnableChat.lua"))() end};
			{Text = "Cancel", Callback = function() end};
		}
	})
end)

cmd.add({"disable"}, {"disable", "Disables a specific CoreGui"}, function()
	Notify({
		Title = "Disable a Specific Core Gui Element",
		--Description = '',
		--Duration = 3,
		Buttons = {
			{Text = "Reset Button", Callback = function() StarterGui:SetCore("ResetButtonCallback", false) end};
			{Text = "Shiftlock", Callback = function() LocalPlayer.DevEnableMouseLock = false end};
			{Text = "Backpack", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false) end};
			{Text = "Chat", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false) end};
			{Text = "Health", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false) end};
			{Text = "PlayerList (Leaderboard)", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false) end};
			{Text = "Emotes Menu", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false) end};
			{Text = "All CoreGui", Callback = function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end};
			{Text = "Cancel", Callback = function() end};
		}
	})
end)

cmd.add({"reverb", "reverbcontrol"}, {"reverb (reverbcontrol)", "Manage sound reverb settings"}, function()
	local reverbButtons = {}
	for _, reverbType in ipairs(Enum.ReverbType:GetEnumItems()) do
		table.insert(reverbButtons, {
			Text = reverbType.Name,
			Callback = function()
				SoundService.AmbientReverb = reverbType
			end
		})
	end

	table.insert(reverbButtons, {
		Text = "Cancel",
		Callback = function() end
	})

	Notify({
		Title = "Sound Reverb Options",
		Buttons = reverbButtons
	})
end)

cmd.add({"cam", "camera", "cameratype"}, {"cam (camera, cameratype)", "Manage camera type settings"}, function()
	local cameraTypeButtons = {}
	for _, cameraType in ipairs(Enum.CameraType:GetEnumItems()) do
		table.insert(cameraTypeButtons, {
			Text = cameraType.Name,
			Callback = function()
				SafeGetService("Workspace").CurrentCamera.CameraType = cameraType
			end
		})
	end

	table.insert(cameraTypeButtons, {
		Text = "Cancel",
		Callback = function() end
	})

	Notify({
		Title = "Camera Type Options",
		Buttons = cameraTypeButtons
	})
end)

cmd.add({"esp"}, {"esp", "locate where the players are"}, function()
	ESPenabled = true
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name ~= Players.LocalPlayer.Name then
			ESP(player)
		end
	end

	if not _G.ESPJoinConnection then
		_G.ESPJoinConnection = Players.PlayerAdded:Connect(function(player)
			if ESPenabled and player.Name ~= Players.LocalPlayer.Name then
				ESP(player)
			end
		end)
	end
end)

cmd.add({"locate"}, {"locate <username>", "locate where the players are"}, function(...)
	local username = (...)
	local target = getPlr(username)
	if target then
		ESP(target)
	end
end, true)

cmd.add({"unesp", "unlocate"}, {"unesp (unlocate)", "Disables esp"}, function()
	ESPenabled = false
	removeESP()

	if _G.ESPJoinConnection then
		_G.ESPJoinConnection:Disconnect()
		_G.ESPJoinConnection = nil
	end
end)

cmd.add({"crash"},{"crash","crashes ur client lol"},function()
	while true do end
end)

cmd.add({"creep","scare"},{"creep <player> (scare)","Teleports from a player behind them and under the floor to the top"},function(...)
	Players=Players
	HRP=getRoot(getChar()).Anchored

	Username=(...)

	local target=getPlr(Username)

	getRoot(getChar()).CFrame=target.Character.Humanoid.RootPart.CFrame*CFrame.new(0,-10,4)
	wait()
	if connections["noclip"] then lib.disconnect("noclip") return end
	lib.connect("noclip",RunService.Stepped:Connect(function()
		if not character then return end
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end))
	wait()
	getRoot(getChar()).Anchored=true
	wait()
	tweenService,tweenInfo=TweenService,TweenInfo.new(1000,Enum.EasingStyle.Linear)

	tween=tweenService:Create(getRoot(getChar()),tweenInfo,{CFrame=CFrame.new(0,10000,0)})
	tween:Play()
	wait(1.5)
	tween:Pause()
	getRoot(getChar()).Anchored=false
	wait()
	lib.disconnect("noclip")

end,true)

cmd.add({"netless","net"},{"netless (net)","Executes netless which makes scripts more stable"},function()
	for i,v in next,getChar():GetDescendants() do
		if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then 
			RunService.Heartbeat:connect(function()
				v.Velocity=Vector3.new(-30,0,0)
			end)
		end
	end

	wait();

	DoNotif("Netless has been activated,re-run this script if you die")
end)

cmd.add({"reset","die"},{"reset (die)","Makes your health be 0"},function()
	Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
	Player.Character:FindFirstChildOfClass("Humanoid").Health=0
end)

cmd.add({"bubblechat","bchat"},{"bubblechat (bchat)","Enables BubbleChat"},function()
	if LegacyChat then
		ChatService.BubbleChatEnabled = true
	else
		TextChatService.BubbleChatConfiguration.Enabled = true
	end
end)

cmd.add({"unbubblechat","unbchat"},{"unbubblechat (unbchat)","Disabled BubbleChat"},function()
	if LegacyChat then
		ChatService.BubbleChatEnabled = false
	else
		TextChatService.BubbleChatConfiguration.Enabled = false
	end
end)

local hastheyfixedit=nil

cmd.add({"saveinstance","savegame"},{"saveinstance (savegame)","if it bugs out try removing stuff from your AutoExec folder"},function()
	--saveinstance({})
	local Params={
		RepoURL="https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
		SSI="saveinstance",
	}
	local synsaveinstance=loadstring(game:HttpGet(Params.RepoURL..Params.SSI..".luau",true),Params.SSI)()
	local Options={}	
	if identifyexecutor()=="Fluxus" then
		Options={ IgnoreSpecialProperties=true }
	end
	synsaveinstance(Options)
end)

cmd.add({"admin"},{"admin","whitelist someone to allow them to use commands"},function(...)
	function ChatMessage(Message,Whisper)
		lib.LocalPlayerChat(Message,Whisper or "All")
	end
	local Player=getPlr(...)
	if Player~=nil and not Admin[Player.UserId] then
		Admin[Player.UserId]={Player=Player}
		ChatMessage("[Nameless Admin] You've got admin. Prefix: ';'",Player.Name)
		wait(0.2)
		ChatMessage("[Nameless Admin Commands] glue,unglue,fling,fling2,spinfling,unspinfling,fcd,fti,fpp,fireremotes,holdhat",Player.Name)
		ChatMessage("reset,commitoof,seizure,unseizure,toolorbit,lay,fall,toolspin,hatspin,sit,joke,kanye",Player.Name)
		DoNotif(Player.Name.." has now been whitelisted to use commands",15)
	else
		DoNotif("No player found")
	end
end,true)

cmd.add({"unadmin"},{"unadmin <player>","removes someone from being admin"},function(...)
	function ChatMessage(Message,Whisper)
		lib.LocalPlayerChat(Message,Whisper or "All")
	end
	local Player=getPlr(...)
	if Player~=nil and Admin[Player.UserId] then
		Admin[Player.UserId]=nil
		ChatMessage("You can no longer use commands",Player.Name)
		DoNotif(Player.Name.." is no longer an admin",15)
	else
		DoNotif("Player not found")
	end
end,true)

cmd.add({"partname","partpath","partgrabber"},{"partname (partpath,partgrabber)","gives a ui and allows you click on a part to grab it's path"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/PartGrabber.lua"))()
end)

-- patched (womp)
--[[cmd.add({"backdoor","backdoorscan"},{"backdoor (backdoorscan)","Scans for any backdoors using FraktureSS"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/Frakture"))()
end)]]

cmd.add({"jobid"},{"jobid","Copies your job id"},function()
	if setclipboard then
		setclipboard(tostring(JobId))
		wait();

		DoNotif("Copied your jobid ("..JobId..")")
	else
		DoNotif("Your executor does not support setclipboard")
	end
end)

cmd.add({"joinjobid","joinjid","jjobid","jjid"},{"joinjobid <jobid> (joinjid,jjobid,jjid)","Joins the job id you put in"},function(...)
	zeId={...}
	id=zeId[1]
	TeleportService:TeleportToPlaceInstance(PlaceId,id)
end,true)

cmd.add({"serverhop","shop"},{"serverhop (shop)","serverhop"},function()
	wait();

	DoNotif("Searching")
	local Number=0
	local SomeSRVS={}
	local found=0
	for _,v in ipairs(SafeGetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v)=="table" and v.maxPlayers>v.playing and v.id~=JobId then
			if v.playing>Number then
				Number=v.playing
				SomeSRVS[1]=v.id
				found=v.playing
			end
		end
	end
	if #SomeSRVS>0 then
		DoNotif("serverhopping | Player Count: "..found)
		TeleportService:TeleportToPlaceInstance(PlaceId,SomeSRVS[1])
	end
end)

cmd.add({"smallserverhop","sshop"},{"smallserverhop (sshop)","serverhop to a small server"},function()
	wait();

	DoNotif("Searching")

	local Number=math.huge
	local SomeSRVS={}
	local found=0

	for _,v in ipairs(SafeGetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v)=="table" and v.maxPlayers>v.playing and v.id~=JobId then
			if v.playing<Number then
				Number=v.playing
				SomeSRVS[1]=v.id
				found=v.playing
			end
		end
	end

	if #SomeSRVS>0 then
		DoNotif("serverhopping | Player Count: "..found)
		TeleportService:TeleportToPlaceInstance(PlaceId,SomeSRVS[1])
	end
end)

cmd.add({"pingserverhop","pshop"},{"pingserverhop (pshop)","serverhop to a server with the best ping"},function()
	wait();

	DoNotif("Searching for server with best ping")

	local Servers = JSONDecode(HttpService, game:HttpGetAsync("https://games.roblox.com/v1/games/".. PlaceId .."/servers/Public?sortOrder=Asc&limit=100")).data
	local BestPing = math.huge
	local BestJobId = nil

	if Servers and #Servers > 0 then
		for _, Server in next, Servers do
			if type(Server) == "table" and Server.id ~= JobId then
				local ping = Server.ping
				if ping and ping < BestPing then
					BestPing = ping
					BestJobId = Server.id
				end
			end
		end
	end

	if BestJobId then
		DoNotif(string.format("Serverhopping to server with ping: %s ms", tostring(BestPing)))
		TeleportService:TeleportToPlaceInstance(PlaceId, BestJobId)
	else
		DoNotif("No better server found")
	end
end)

local autorjthingy = nil

cmd.add({"autorejoin", "autorj"}, {"autorejoin", "Rejoins the server if you get kicked / disconnected"}, function()
	if autorjthingy then
		autorjthingy:Disconnect()
		autorjthingy = nil
	end

	function handleRejoin()
		if #Players:GetPlayers() <= 1 then
			Players.LocalPlayer:Kick("Rejoining...")
			wait()
			TeleportService:Teleport(PlaceId, Players.LocalPlayer)
		else
			TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
		end
	end

	local promptOverlay = COREGUI:FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay")
	if not promptOverlay then
		DoNotif("Error: Could not find promptOverlay!")
		return
	end

	autorjthingy = promptOverlay.DescendantAdded:Connect(function(descendant)
		if descendant.Name == "ErrorTitle" and descendant.Text:sub(1, 12) == "Disconnected" then
			handleRejoin()
			descendant:GetPropertyChangedSignal("Text"):Connect(function()
				if descendant.Text:sub(1, 12) == "Disconnected" then
					handleRejoin()
				end
			end)
		end
	end)

	DoNotif("Auto Rejoin is now enabled!")
end)

cmd.add({"unautorejoin", "unautorj"}, {"unautorejoin (unautorj)", "Disables auto rejoin command"}, function()
	if autorjthingy then
		autorjthingy:Disconnect()
		autorjthingy = nil
		DoNotif("Auto Rejoin is now disabled!")
	else
		DoNotif("Auto Rejoin is already disabled!")
	end
end)

dadojadoqwdqwd='© 2025 ltseverydayyou'

cmd.add({"functionspy"},{"functionspy","Check console"},function()
	local toLog={
		debug.getconstants;
		getconstants;
		debug.getconstant;
		getconstant;
		debug.setconstant;
		setconstant;
		debug.getupvalues;
		debug.getupvalue;
		getupvalues;
		getupvalue;
		debug.setupvalue;
		setupvalue;
		getsenv;
		getreg;
		getgc;
		getconnections;
		firesignal;
		fireclickdetector;
		fireproximityprompt;
		firetouchinterest;
		gethiddenproperty;
		sethiddenproperty;
		hookmetamethod;
		setnamecallmethod;
		getrawmetatable;
		setrawmetatable;
		setreadonly;
		isreadonly;
		debug.setmetatable;
	}

	local FunctionSpy=Instance.new("ScreenGui")
	local Main=Instance.new("Frame")
	local LeftPanel=Instance.new("ScrollingFrame")
	local UIListLayout=Instance.new("UIListLayout")
	local example=Instance.new("TextButton")
	local name=Instance.new("TextLabel")
	local UIPadding=Instance.new("UIPadding")
	local FakeTitle=Instance.new("TextButton")
	local Title=Instance.new("TextLabel")
	local clear=Instance.new("ImageButton")
	local RightPanel=Instance.new("ScrollingFrame")
	local output=Instance.new("TextLabel")
	local clear_2=Instance.new("TextButton")
	local copy=Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")

	FunctionSpy.Name="FunctionSpy"
	NaProtectUI(FunctionSpy)
	FunctionSpy.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

	Main.Name="Main"
	Main.Parent=FunctionSpy
	Main.BackgroundColor3=Color3.fromRGB(33,33,33)
	Main.BorderSizePixel=0
	Main.Position=UDim2.new(0,10,0,36)
	Main.Size=UDim2.new(0,536,0,328)
	Main.Active=true

	local function addRoundedCorners(instance, radius)
		local corner = UICorner:Clone()
		corner.CornerRadius = UDim.new(0, radius)
		corner.Parent = instance
	end

	local function addStroke(instance, color, thickness)
		local stroke = UIStroke:Clone()
		stroke.Color = color
		stroke.Thickness = thickness
		stroke.Parent = instance
	end

	addRoundedCorners(Main, 10)
	addStroke(Main, Color3.fromRGB(255, 255, 255), 2)

	LeftPanel.Name="LeftPanel"
	LeftPanel.Parent=Main
	LeftPanel.Active=true
	LeftPanel.BackgroundColor3=Color3.fromRGB(45,45,45)
	LeftPanel.BorderSizePixel=0
	LeftPanel.Size=UDim2.new(0.349999994,0,1,0)
	LeftPanel.CanvasSize=UDim2.new(0,0,0,0)
	LeftPanel.HorizontalScrollBarInset=Enum.ScrollBarInset.ScrollBar
	LeftPanel.ScrollBarThickness=3

	UIListLayout.Parent=LeftPanel
	UIListLayout.SortOrder=Enum.SortOrder.LayoutOrder
	UIListLayout.Padding=UDim.new(0,7)

	example.Name="example"
	example.Parent=LeftPanel
	example.BackgroundColor3=Color3.fromRGB(31,31,31)
	example.BorderSizePixel=0
	example.Position=UDim2.new(4.39481269e-08,0,0,0)
	example.Size=UDim2.new(0,163,0,19)
	example.Visible=false
	example.Font=Enum.Font.SourceSans
	example.Text=""
	example.TextColor3=Color3.fromRGB(0,0,0)
	example.TextSize=14.000
	example.TextXAlignment=Enum.TextXAlignment.Left

	name.Name="name"
	name.Parent=example
	name.BackgroundColor3=Color3.fromRGB(255,255,255)
	name.BackgroundTransparency=1.000
	name.BorderSizePixel=0
	name.Position=UDim2.new(0,10,0,0)
	name.Size=UDim2.new(1,-10,1,0)
	name.Font=Enum.Font.SourceSans
	name.TextColor3=Color3.fromRGB(255,255,255)
	name.TextSize=14.000
	name.TextXAlignment=Enum.TextXAlignment.Left

	UIPadding.Parent=LeftPanel
	UIPadding.PaddingBottom=UDim.new(0,7)
	UIPadding.PaddingLeft=UDim.new(0,7)
	UIPadding.PaddingRight=UDim.new(0,7)
	UIPadding.PaddingTop=UDim.new(0,7)

	FakeTitle.Name="FakeTitle"
	FakeTitle.Parent=Main
	FakeTitle.BackgroundColor3=Color3.fromRGB(40,40,40)
	FakeTitle.BorderSizePixel=0
	FakeTitle.Position=UDim2.new(0,225,0,-26)
	FakeTitle.Size=UDim2.new(0.166044772,0,0,26)
	FakeTitle.Font=Enum.Font.GothamMedium
	FakeTitle.Text="FunctionSpy"
	FakeTitle.TextColor3=Color3.fromRGB(255,255,255)
	FakeTitle.TextSize=14.000

	Title.Name="Title"
	Title.Parent=Main
	Title.BackgroundColor3=Color3.fromRGB(40,40,40)
	Title.BorderSizePixel=0
	Title.Position=UDim2.new(0,0,0,-26)
	Title.Size=UDim2.new(1,0,0,26)
	Title.Font=Enum.Font.GothamMedium
	Title.Text="FunctionSpy"
	Title.TextColor3=Color3.fromRGB(255,255,255)
	Title.TextSize=14.000
	Title.TextWrapped=true

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
	}
	gradient.Rotation = 45
	gradient.Parent = Title

	clear.Name="clear"
	clear.Parent=Title
	clear.BackgroundTransparency=1.000
	clear.Position=UDim2.new(1,-28,0,2)
	clear.Size=UDim2.new(0,24,0,24)
	clear.ZIndex=2
	clear.Image="rbxassetid://3926305904"
	clear.ImageRectOffset=Vector2.new(924,724)
	clear.ImageRectSize=Vector2.new(36,36)

	clear.MouseButton1Click:Connect(function()
		if _G.functionspy then
			_G.functionspy.shutdown()
		end
	end)

	RightPanel.Name="RightPanel"
	RightPanel.Parent=Main
	RightPanel.Active=true
	RightPanel.BackgroundColor3=Color3.fromRGB(35,35,35)
	RightPanel.BorderSizePixel=0
	RightPanel.Position=UDim2.new(0.349999994,0,0,0)
	RightPanel.Size=UDim2.new(0.649999976,0,1,0)
	RightPanel.CanvasSize=UDim2.new(0,0,0,0)
	RightPanel.HorizontalScrollBarInset=Enum.ScrollBarInset.ScrollBar
	RightPanel.ScrollBarThickness=3

	output.Name="output"
	output.Parent=RightPanel
	output.BackgroundColor3=Color3.fromRGB(255,255,255)
	output.BackgroundTransparency=1.000
	output.BorderColor3=Color3.fromRGB(27,42,53)
	output.BorderSizePixel=0
	output.Position=UDim2.new(0,10,0,10)
	output.Size=UDim2.new(1,-10,0.75,-10)
	output.Font=Enum.Font.GothamMedium
	output.Text=""
	output.TextColor3=Color3.fromRGB(255,255,255)
	output.TextSize=14.000
	output.TextScaled = true
	output.TextXAlignment=Enum.TextXAlignment.Left
	output.TextYAlignment=Enum.TextYAlignment.Top

	clear_2.Name="clear"
	clear_2.Parent=RightPanel
	clear_2.BackgroundColor3=Color3.fromRGB(30,30,30)
	clear_2.BorderSizePixel=0
	clear_2.Position=UDim2.new(0.0631457642,0,0.826219559,0)
	clear_2.Size=UDim2.new(0,140,0,33)
	clear_2.Font=Enum.Font.SourceSans
	clear_2.Text="Clear logs"
	clear_2.TextColor3=Color3.fromRGB(255,255,255)
	clear_2.TextSize=14.000

	copy.Name="copy"
	copy.Parent=RightPanel
	copy.BackgroundColor3=Color3.fromRGB(30,30,30)
	copy.BorderSizePixel=0
	copy.Position=UDim2.new(0.545350134,0,0.826219559,0)
	copy.Size=UDim2.new(0,140,0,33)
	copy.Font=Enum.Font.SourceSans
	copy.Text="Copy info"
	copy.TextColor3=Color3.fromRGB(255,255,255)
	copy.TextSize=14.000

	local function addHoverEffect(button)
		button.MouseEnter:Connect(function()
			button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end)
		button.MouseLeave:Connect(function()
			button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		end)
	end

	addHoverEffect(clear_2)
	addHoverEffect(copy)

	gui.draggable(Main,Title)

	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.Parent = Main
	shadow.BackgroundTransparency = 1
	shadow.Size = UDim2.new(1, 20, 1, 20)
	shadow.Position = UDim2.new(0, -10, 0, -10)
	shadow.Image = "rbxassetid://1316045217"
	shadow.ImageColor3 = Color3.new(0, 0, 0)
	shadow.ImageTransparency = 0.5
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(10, 10, 118, 118)

	function AKIHDI_fake_script()
		_G.functionspy={
			instance=Main.Parent;
			logging=true;
			connections={};
		}

		_G.functionspy.shutdown=function()
			for i,v in pairs(_G.functionspy.connections) do
				v:Disconnect()
			end
			_G.functionspy.connections={}
			_G.functionspy=nil
			Main.Parent:Destroy()
		end

		local connections={}

		local currentInfo=nil

		local getinfo = debug.getinfo or function(f)
			return {name = tostring(f)}
		end

		function log(name,text)
			local btn=Main.LeftPanel.example:Clone()
			btn.Parent=Main.LeftPanel
			btn.Name=name
			btn.name.Text=name
			btn.Visible=true
			table.insert(connections,MouseButtonFix(btn,function()
				Main.RightPanel.output.Text=text
				currentInfo=text
			end))
		end

		MouseButtonFix(clear,function()
			if _G.functionspy then
				_G.functionspy.shutdown()
			end
		end)

		MouseButtonFix(Main.RightPanel.copy,function()
			if currentInfo~=nil then
				setclipboard(tostring(currentInfo))
			end
		end)

		MouseButtonFix(Main.RightPanel.clear,function()
			for i,v in pairs(connections) do
				v:Disconnect()
			end
			for i,v in pairs(Main.LeftPanel:GetDescendants()) do
				if v:IsA("TextButton") and v.Visible==true then
					v:Destroy()
				end
			end
			Main.RightPanel.output.Text=""
			currentInfo=nil
		end)

		local hooked={}

		local Seralize
		local success, result = pcall(function()
			return loadstring(game:HttpGet('https://api.irisapp.ca/Scripts/SeralizeTable.lua',true))()
		end)

		if success then
			Seralize = result
		else
			Seralize = function(tbl, depth)
				if not tbl then return "nil" end
				if type(tbl) ~= "table" then return tostring(tbl) end

				depth = depth or 0
				if depth > 5 then return "..." end

				local indent = string.rep("    ", depth)
				local indent_inner = string.rep("    ", depth + 1)
				local result = "{\n"

				for k, v in pairs(tbl) do
					local key_str
					if type(k) == "string" then
						key_str = '["'..k..'"]'
					else
						key_str = "["..tostring(k).."]"
					end

					local value_str
					if type(v) == "table" then
						value_str = Seralize(v, depth + 1)
					elseif type(v) == "string" then
						value_str = '"'..v..'"'
					elseif type(v) == "function" then
						local info = debug.getinfo(v)
						value_str = "function "..(info.name or "").." "..tostring(v)
					else
						value_str = tostring(v)
					end

					result = result..indent_inner..key_str.." = "..value_str..",\n"
				end

				result = result..indent.."}"
				return result
			end
		end

		function GetFunctionInfo(func)
			if type(func) ~= "function" then return tostring(func) end

			local info = debug.getinfo(func)
			local result = "function"

			if info.name and info.name ~= "" then
				result = result.." "..info.name
			end

			result = result.." "..tostring(func).." {\n"
			result = result.."    source: "..(info.source or "unknown")..",\n"
			result = result.."    line: "..(info.linedefined or "?").." to "..(info.lastlinedefined or "?")..",\n"
			result = result.."    params: "..(info.nparams or "?")..(info.isvararg and " + vararg" or "")..",\n"

			local upvalues = ""
			local i = 1
			while true do
				local name, value = debug.getupvalue(func, i)
				if not name then break end

				local value_str
				if type(value) == "table" then
					value_str = "table: "..tostring(value)
				elseif type(value) == "function" then
					value_str = "function: "..tostring(value)
				elseif type(value) == "string" then
					value_str = '"'..value..'"'
				else
					value_str = tostring(value)
				end

				upvalues = upvalues.."        "..name.." = "..value_str..",\n"
				i = i + 1
			end

			if upvalues ~= "" then
				result = result.."    upvalues: {\n"..upvalues.."    },\n"
			end

			result = result.."}"
			return result
		end


		for i,v in next,toLog do
			if type(v)=="string" then
				local suc,err=pcall(function()
					local func = loadstring("return "..v)()
					if func then
						hooked[i]=hookfunction(func,function(...)
							local args={...}
							if _G.functionspy then
								pcall(function() 
									out=""
									out=out..(v..",Args-> {")..("\n"):format()
									for l,k in pairs(args) do
										if type(k)=="function" then
											out = out..("    ["..tostring(l).."] Type-> "..type(k)..",Info->\n        "..GetFunctionInfo(k))..("\n"):format()
										elseif type(k)=="table" then
											out = out..("    ["..tostring(l).."] Type-> "..type(k)..",Data->\n"..Seralize(k))..("\n"):format()
										elseif type(k)=="boolean" then
											out=out..("    ["..tostring(l).."] Value-> "..tostring(k).."-> "..type(k))..("\n"):format()
										elseif type(k)=="nil" then
											out=out..("    ["..tostring(l).."] null")..("\n"):format()
										elseif type(k)=="number" then
											out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
										else
											out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
										end
									end
									out=out..("},Result-> "..tostring(nil))..("\n"):format()
									if _G.functionspy.logging==true then
										log(v,out)
									end
								end)
							end
							return hooked[i](...)
						end)
					end
				end)
				if not suc then
					warn("Something went wrong while hooking "..v..". Error: "..err)
				end
			elseif type(v)=="function" then
				local suc,err=pcall(function()
					hooked[i]=hookfunction(v,function(...)
						local args={...}
						if _G.functionspy then
							pcall(function() 
								out=""
								local funcName = getinfo(v).name or "unknown"
								out=out..(funcName..",Args-> {")..("\n"):format()
								for l,k in pairs(args) do
									if type(k)=="function" then
										local funcInfo = getinfo(k)
										local funcName = funcInfo and funcInfo.name or "unknown"
										out=out..("    ["..tostring(l).."] "..tostring(k)..",Type-> "..type(k)..",Name-> "..funcName)..("\n"):format()
									elseif type(k)=="table" then
										out=out..("    ["..tostring(l).."] "..tostring(k)..",Type-> "..type(k)..",Data-> "..Seralize(k))..("\n"):format()
									elseif type(k)=="boolean" then
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k).."-> "..type(k))..("\n"):format()
									elseif type(k)=="nil" then
										out=out..("    ["..tostring(l).."] null")..("\n"):format()
									elseif type(k)=="number" then

										out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
									else
										out=out..("    ["..tostring(l).."] Value-> "..tostring(k)..",Type-> "..type(k))..("\n"):format()
									end
								end
								out=out..("},Result-> "..tostring(nil))..("\n"):format()
								if _G.functionspy.logging==true then
									log(funcName,out)
								end
							end)
						end
						return hooked[i](...)
					end)
				end)
				if not suc then
					local funcName = getinfo(v).name or "unknown"
					warn("Something went wrong while hooking "..funcName..". Error: "..err)
				end
			end
		end

	end
	coroutine.wrap(AKIHDI_fake_script)()
	function BIPVKVC_fake_script()
		local script=Instance.new('LocalScript',FakeTitle)

		table.insert(_G.functionspy.connections,FakeTitle.MouseEnter:Connect(function()
			if _G.functionspy.logging==true then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging==false then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		table.insert(_G.functionspy.connections,FakeTitle.MouseMoved:Connect(function()
			if _G.functionspy.logging==true then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging==false then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		table.insert(_G.functionspy.connections,MouseButtonFix(FakeTitle,function()
			_G.functionspy.logging=not _G.functionspy.logging
			if _G.functionspy.logging==true then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging==false then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		table.insert(_G.functionspy.connections,FakeTitle.MouseLeave:Connect(function()
			TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,1,1)}):Play()
		end))
	end
	coroutine.wrap(BIPVKVC_fake_script)()
	function PRML_fake_script()
		MouseButtonFix(clear,function()
			_G.functionspy.shutdown()
		end)
	end
	coroutine.wrap(PRML_fake_script)()
end)

mOn = false
mFlyBruh = nil
flyEnabled = false
toggleKey = "f"
flySpeed = 1
keybindConn = nil

function toggleFly()
	if flyEnabled then
		FLYING = false
		if IsOnMobile then
			unmobilefly()
		else
			cmdlp.Character.Humanoid.PlatformStand = false
			if goofyFLY then goofyFLY:Destroy() end
		end
		flyEnabled = false
	else
		FLYING = true
		if IsOnMobile then
			mobilefly(flySpeed)
		else
			sFLY()
		end
		flyEnabled = true
	end
end

function connectFlyKey()
	if keybindConn then
		keybindConn:Disconnect()
	end
	keybindConn = cmdm.KeyDown:Connect(function(KEY)
		if KEY:lower() == toggleKey then
			toggleFly()
		end
	end)
end

cmd.add({"fly"}, {"fly [speed]", "Enable flight"}, function(...)
	local flySpeed = IsOnMobile and ((...) or 50) or ((...) or 1)
	connectFlyKey()
	flyEnabled=true

	if IsOnMobile then
		wait()
		DoNotif(adminName.." detected mobile. Fly button added for easier use.")

		if mFlyBruh then
			mFlyBruh:Destroy()
			mFlyBruh = nil
		end

		mFlyBruh = Instance.new("ScreenGui")
		local btn = Instance.new("TextButton")
		local corner = Instance.new("UICorner")
		local aspect = Instance.new("UIAspectRatioConstraint")

		NaProtectUI(mFlyBruh)
		mFlyBruh.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		mFlyBruh.ResetOnSpawn = false

		btn.Parent = mFlyBruh
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		btn.BackgroundTransparency = 0.1
		btn.Position = UDim2.new(0.9, 0, 0.6, 0)
		btn.Size = UDim2.new(0.05, 0, 0.1, 0)
		btn.Font = Enum.Font.GothamBold
		btn.Text = "Fly"
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 18
		btn.TextWrapped = true
		btn.Active = true
		btn.TextScaled = true

		corner.CornerRadius = UDim.new(0.2, 0)
		corner.Parent = btn

		aspect.Parent = btn
		aspect.AspectRatio = 1.0

		coroutine.wrap(function()
			MouseButtonFix(btn,function()
				if not mOn then
					mOn = true
					btn.Text = "Unfly"
					btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
					mobilefly(flySpeed)
				else
					mOn = false
					btn.Text = "Fly"
					btn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
					unmobilefly()
				end
			end)
		end)()

		gui.draggable(btn)
	else
		FLYING = false
		cmdlp.Character.Humanoid.PlatformStand = false
		wait()

		DoNotif("Fly enabled. Press '"..toggleKey:upper().."' to toggle flying.")
		sFLY()
		speedofthevfly = flySpeed
		speedofthefly = flySpeed
	end
end, true)

cmd.add({"unfly"}, {"unfly", "Disable flight"}, function()
	wait()
	if IsOnMobile then
		DoNotif("Mobile Fly Disabled.")
		unmobilefly()
	else
		DoNotif("Not flying anymore")
		FLYING = false
		cmdlp.Character.Humanoid.PlatformStand = false
		if goofyFLY then goofyFLY:Destroy() end
	end
	mOn = false
	if mFlyBruh then
		mFlyBruh:Destroy()
		mFlyBruh = nil
	end
	if keybindConn then
		keybindConn:Disconnect()
		keybindConn = nil
	end
end)

if IsOnPC then
	cmd.add({"flybind", "flykeybind","bindfly"}, {"flybind (flykeybind, bindfly)", "set a custom keybind for the 'fly' command"}, function(...)
		local newKey = (...):lower()
		if newKey == "" or newKey==nil then
			DoNotif("Please provide a keybind.")
			return
		end

		toggleKey = newKey
		if keybindConn then
			keybindConn:Disconnect()
			keybindConn = nil
		end
		connectFlyKey()

		DoNotif("Fly keybind set to '"..toggleKey:upper().."'")
	end)
end

TFlyEnabled = false
tflyCORE = nil

cmd.add({"tfly", "tweenfly"}, {"tfly [speed] (tweenfly)", "Enables smooth flying"}, function(...)
	TFlyEnabled = true
	local speed = (...) or 2
	local e1, e2
	local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local mouse = LocalPlayer:GetMouse()

	tflyCORE = Instance.new("Part", SafeGetService("Workspace").CurrentCamera)
	tflyCORE:SetAttribute("tflyPart", true)
	tflyCORE.Size = Vector3.new(0.05, 0.05, 0.05)
	tflyCORE.CanCollide = false

	local keys = { w = false, a = false, s = false, d = false }

	if IsOnPC then
		e1 = mouse.KeyDown:Connect(function(key)
			if not tflyCORE or not tflyCORE.Parent then
				e1:Disconnect()
				e2:Disconnect()
				return
			end
			if keys[key] ~= nil then
				keys[key] = true
			end
		end)

		e2 = mouse.KeyUp:Connect(function(key)
			if keys[key] ~= nil then
				keys[key] = false
			end
		end)
	end

	local Weld = Instance.new("Weld", tflyCORE)
	Weld.Part0 = tflyCORE
	Weld.Part1 = Humanoid.RootPart
	Weld.C0 = CFrame.new(0, 0, 0)

	local pos = Instance.new("BodyPosition", tflyCORE)
	local gyro = Instance.new("BodyGyro", tflyCORE)
	pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	pos.position = tflyCORE.Position
	gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	gyro.cframe = tflyCORE.CFrame

	repeat
		wait()
		Humanoid.PlatformStand = true
		local newPosition = gyro.cframe - gyro.cframe.p + pos.position

		if IsOnPC then
			local camera = SafeGetService("Workspace").CurrentCamera
			if keys.w then
				newPosition = newPosition + camera.CoordinateFrame.LookVector * speed
			end
			if keys.s then
				newPosition = newPosition - camera.CoordinateFrame.LookVector * speed
			end
			if keys.d then
				newPosition = newPosition * CFrame.new(speed, 0, 0)
			end
			if keys.a then
				newPosition = newPosition * CFrame.new(-speed, 0, 0)
			end
		elseif IsOnMobile then
			local direction = ctrlModule:GetMoveVector()
			if direction.Magnitude > 0 then
				local camera = SafeGetService("Workspace").CurrentCamera
				newPosition = newPosition + (direction.X * camera.CFrame.RightVector * speed)
				newPosition = newPosition - (direction.Z * camera.CFrame.LookVector * speed)
			end
		end

		pos.position = newPosition.p
		gyro.cframe = SafeGetService("Workspace").CurrentCamera.CoordinateFrame
	until not TFlyEnabled

	if gyro then gyro:Destroy() end
	if pos then pos:Destroy() end
	Humanoid.PlatformStand = false
end, true)

cmd.add({"untfly", "untweenfly"}, {"untfly (untweenfly)", "Disables tween flying"}, function()
	TFlyEnabled = false
	for _, v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:GetAttribute("tflyPart") then
			v:Destroy()
		end
	end
end)

cmd.add({"noclip","nclip","nc"},{"noclip","Disable your player's collision"},function()
	if connections["noclip"] then lib.disconnect("noclip") return end
	lib.connect("noclip",RunService.Stepped:Connect(function()
		if not character then return end
		for i,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end))
end)

cmd.add({"clip","c"},{"clip","Enable your player's collision"},function()
	lib.disconnect("noclip")
end)

local bangCon
local originalPos

cmd.add({"antibang"}, {"antibang", "prevents users to bang you (still WORK IN PROGRESS)"}, function()
	if bangCon then
		bangCon:Disconnect()
		bangCon = nil
	end
	local root = getRoot(LocalPlayer.Character)
	if not root then return end
	originalPos = root.CFrame
	local orgHeight = SafeGetService("Workspace").FallenPartsDestroyHeight
	local anims = {"rbxassetid://5918726674", "rbxassetid://148840371", "rbxassetid://698251653", "rbxassetid://72042024"}
	local inVoid = false
	local targetPlayer = nil
	local toldNotif = false

	LocalPlayer.CharacterAdded:Connect(function(char)
		task.wait(1)
		root = getRoot(char)
	end)

	bangCon = game:GetService("RunService").Stepped:Connect(function()
		for _, p in pairs(game:GetService("Players"):GetPlayers()) do
			if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				if (p.Character.HumanoidRootPart.Position - root.Position).Magnitude <= 10 then
					local tracks = p.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()
					for _, t in pairs(tracks) do
						if table.find(anims, t.Animation.AnimationId) then
							if not inVoid then
								inVoid = true
								targetPlayer = p
								SafeGetService("Workspace").FallenPartsDestroyHeight = 0/1/0
								root.CFrame = CFrame.new(Vector3.new(0, orgHeight - 25, 0))
								if not toldNotif then
									toldNotif=true
									DoNotif("Antibang activated | Target: "..targetPlayer.Name,2)
								end
							end
						end
					end
				end
			end
		end

		if inVoid then
			local char = LocalPlayer.Character
			local r = char and char:FindFirstChild("HumanoidRootPart")
			if r and r.Position.Y <= orgHeight + 25 then
				r.Velocity = Vector3.new(r.Velocity.X, r.Velocity.Y + 10, r.Velocity.Z)
			end

			if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Humanoid") or targetPlayer.Character.Humanoid.Health <= 0 then
				inVoid = false
				targetPlayer = nil
				root.CFrame = originalPos
				root.Anchored=true
				task.wait();
				root.Anchored=false
				SafeGetService("Workspace").FallenPartsDestroyHeight = orgHeight
				if toldNotif then
					toldNotif=false
					DoNotif("Antibang deactivated",2)
				end
			end
		end
	end)
end)

cmd.add({"unantibang"}, {"unantibang", "disables antibang"}, function()
	if bangCon then
		bangCon:Disconnect()
		bangCon = nil
	end
end)

cmd.add({"orbit"}, {"orbit <player> <distance>", "Orbit around a player"}, function(p,d)
	lib.disconnect("orbit")
	local target = getPlr(p)
	if not target then return end

	local tchar, char = target.Character, character
	if not tchar or not char then return end

	local thrp = getRoot(tchar)
	local hrp = getRoot(char)
	if not thrp or not hrp then return end

	local dist = tonumber(d) or 4
	local sineX, sineZ = 0, math.pi / 2

	lib.connect("orbit", RunService.Stepped:Connect(function()
		if not (thrp.Parent and hrp.Parent) then
			lib.disconnect("orbit")
			return
		end

		sineX, sineZ = sineX + 0.05, sineZ + 0.05
		local sinX, sinZ = math.sin(sineX), math.sin(sineZ)

		hrp.Velocity = Vector3.zero
		hrp.CFrame = CFrame.new(sinX * dist, 0, sinZ * dist) *
			(hrp.CFrame - hrp.CFrame.p) +
			thrp.CFrame.p
	end))
end, true)

cmd.add({"uporbit"}, {"uporbit <player> <distance>", "Orbit around a player on the Y axis"}, function(p,d)
	lib.disconnect("orbit")
	local target = getPlr(p)
	if not target then return end

	local tchar, char = target.Character, character
	if not tchar or not char then return end

	local thrp = getRoot(tchar)
	local hrp = getRoot(char)
	if not thrp or not hrp then return end

	local dist = tonumber(d) or 4
	local sineX, sineY = 0, math.pi / 2

	lib.connect("orbit", RunService.Stepped:Connect(function()
		if not (thrp.Parent and hrp.Parent) then
			lib.disconnect("orbit")
			return
		end

		sineX, sineY = sineX + 0.05, sineY + 0.05
		local sinX, sinY = math.sin(sineX), math.sin(sineY)

		hrp.Velocity = Vector3.zero
		hrp.CFrame = CFrame.new(sinX * dist, sinY * dist, 0) *
			(hrp.CFrame - hrp.CFrame.p) +
			thrp.CFrame.p
	end))
end, true)

cmd.add({"unorbit"}, {"unorbit", "Stop orbiting"}, function()
	lib.disconnect("orbit")
end)

cmd.add({"freezewalk"},{"freezewalk","Freezes your character on the server but lets you walk on the client"},function()
	local Character=getChar()
	local Root=getRoot(Character)

	if IsR6(plr) then
		local Clone=Root:Clone()
		Root:Destroy()
		Clone.Parent=Character
	else
		Character.LowerTorso.Anchored=true
		Character.LowerTorso.Root:Destroy()
	end
	DoNotif("freezewalk is activated,reset to stop it")
end)

local fcpro=nil

cmd.add({"freecam","fc","fcam"},{"freecam [speed] (fc,fcam)","Enable free camera"},function(speed)
	if not speed then speed=5 end

	if connections["freecam"] then
		lib.disconnect("freecam")
		camera.CameraSubject = character
		wrap(function() character.PrimaryPart.Anchored = false end)
	end

	local dir={w=false,a=false,s=false,d=false}
	local cf=Instance.new("CFrameValue")
	local camPart=Instance.new("Part")
	camPart.Transparency=1
	camPart.Anchored=true
	camPart.CFrame=camera.CFrame
	wrap(function()
		character.PrimaryPart.Anchored=true
	end)

	lib.connect("freecam",RunService.RenderStepped:Connect(function()
		local primaryPart=camPart
		camera.CameraSubject=primaryPart

		local x,y,z=0,0,0
		if dir.w then z=-1*speed end
		if dir.a then x=-1*speed end
		if dir.s then z=1*speed end
		if dir.d then x=1*speed end
		if dir.q then y=1*speed end
		if dir.e then y=-1*speed end

		if IsOnMobile then
			local direction = ctrlModule:GetMoveVector()
			if direction.X ~= 0 then
				x = x + direction.X * speed
			end
			if direction.Z ~= 0 then
				z = z + direction.Z * speed
			end
		end

		primaryPart.CFrame=CFrame.new(
			primaryPart.CFrame.p,
			(camera.CFrame*CFrame.new(0,0,-100)).p
		)

		local moveDir=CFrame.new(x,y,z)
		cf.Value=cf.Value:lerp(moveDir,0.2)
		primaryPart.CFrame=primaryPart.CFrame:lerp(primaryPart.CFrame*cf.Value,0.2)
	end))

	lib.connect("freecam",UserInputService.InputBegan:Connect(function(input,event)
		if event then return end
		local code,codes=input.KeyCode,Enum.KeyCode
		if code==codes.W then
			dir.w=true
		elseif code==codes.A then
			dir.a=true
		elseif code==codes.S then
			dir.s=true
		elseif code==codes.D then
			dir.d=true
		elseif code==codes.Q then
			dir.q=true
		elseif code==codes.E then
			dir.e=true
		elseif code==codes.Space then
			dir.q=true
		end
	end))

	lib.connect("freecam",UserInputService.InputEnded:Connect(function(input,event)
		if event then return end
		local code,codes=input.KeyCode,Enum.KeyCode
		if code==codes.W then
			dir.w=false
		elseif code==codes.A then
			dir.a=false
		elseif code==codes.S then
			dir.s=false
		elseif code==codes.D then
			dir.d=false
		elseif code==codes.Q then
			dir.q=false
		elseif code==codes.E then
			dir.e=false
		elseif code==codes.Space then
			dir.q=false
		end
	end))
end,true)

cmd.add({"unfreecam","unfc","unfcam"},{"unfreecam (unfc,unfcam)","Disable free camera"},function()
	lib.disconnect("freecam")
	camera.CameraSubject=character
	wrap(function()
		character.PrimaryPart.Anchored=false
	end)
end)

cmd.add({"drophats"},{"drophats","Drop all of your hats"},function()
	for _,hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") then
			hat.Parent=SafeGetService("Workspace")
		end
	end
end)

function getAllTools()
	local tools={}
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	if backpack then
		for i,v in pairs(backpack:GetChildren()) do
			if v:IsA("Tool") then
				table.insert(tools,v)
			end
		end
	end
	for i,v in pairs(character:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(tools,v)
		end
	end
	return tools
end

cmd.add({"fakelag", "flag"}, {"fakelag (flag)", "fake lag"}, function()
	if FakeLag then return end
	FakeLag = true

	while FakeLag do
		local root = getRoot(getChar())
		if root then
			root.Anchored = true
			wait(0.05)
			root.Anchored = false
			wait(0.05)
		else
			FakeLag = false
		end
	end
end)

cmd.add({"unfakelag", "unflag"}, {"unfakelag (unflag)", "stops the fake lag command"}, function()
	FakeLag = false
end)

local r=math.rad
local center=CFrame.new(1.5,0.5,-1.5)

cmd.add({"hide","unshow"},{"hide <player> (unshow)","places the selected player to lighting"},function(...)
	wait();

	DoNotif("Hid the player")

	local Username=(...)
	local target=getPlr(Username)

	if Username=="all" or Username=="others" then
		for i,plrs in pairs(Players:GetChildren()) do
			if plrs.Name==Players.LocalPlayer.Name then
			else

				A_1="/mute "..plrs.Name..""
				A_2="All"

				lib.LocalPlayerChat(A_1,A_2)
				plrs.Character.Parent=Lighting
			end
		end
	else
		if target and target.Character then
			A_1="/mute "..plrs.Name..""
			A_2="All"

			lib.LocalPlayerChat(A_1,A_2)
			target.Character.Parent=Lighting
		end
	end
end,true)

cmd.add({"unhide","show"},{"show <player> (unhide)","places the selected player back to workspace"},function(...)



	wait();

	DoNotif("Unhid the player")

	local Username=(...)
	local target=getPlr(Username)

	if Username=="all" or Username=="others" then
		for i,plrs in pairs(Lighting:GetChildren()) do
			if plrs:IsA("Model") and plrs.PrimaryPart then

				A_1="/unmute "..plrs.Name..""
				A_2="All"

				lib.LocalPlayerChat(A_1,A_2)
				plrs.Parent=SafeGetService("Workspace")
			end
		end
	else
		if target and target.Character then
			target.Character.Parent=SafeGetService("Workspace")

			A_1="/mute "..target.Name..""
			A_2="All"

			lib.LocalPlayerChat(A_1,A_2)
		end
	end
end,true)

if IsOnPC then
	cmd.add({"aimbot","aimbotui","aimbotgui"},{"aimbot (aimbotui,aimbotgui)","aimbot and yeah"},function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/NewAimbot.lua"))()
		--loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/Aimbot.lua",true))()
	end)
end

cmd.add({"loopgrabtools"},{"loopgrabtools","Loop grabs dropped tools"},function()
	loopgrab=true
	repeat wait(1)
		local p=Players.LocalPlayer
		local c=p.Character
		if c and c:FindFirstChild("Humanoid") then
			for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
				if v:IsA("Tool") then
					c:FindFirstChild("Humanoid"):EquipTool(v)
				end
			end
		end
	until loopgrab==false
end)

cmd.add({"unloopgrabtools"},{"unloopgrabtools","Stops the loop grab command"},function()
	loopgrab=false
end)

cmd.add({"dance"},{"dance","Does a random dance"},function()
	dances={"248263260","27789359","45834924","28488254","33796059","30196114","52155728"}
	if getChar():FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
		dances={"4555808220","4555782893","3333432454","4049037604"}
	end
	if theanim then
		theanim:Stop()
		theanim:Destroy()
		local animation=Instance.new("Animation")
		animation.AnimationId="rbxassetid://"..dances[math.random(1,#dances)]
		theanim=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
		theanim:Play()
	else
		local animation=Instance.new("Animation")
		animation.AnimationId="rbxassetid://"..dances[math.random(1,#dances)]
		theanim=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
		theanim:Play()
	end
end)

cmd.add({"undance"},{"undance","Stops the dance command"},function()
	theanim:Stop()
	theanim:Destroy()
end)

cmd.add({"antichatlogs","antichatlogger"},{"antichatlogs (antichatlogger)","Prevents you from getting banning when typing unspeakable messages (game needs legacy chat service)"},function()
	if not LegacyChat then
		return DoNotif("Game doesn't use Legacy Chat Service")
	end
	local MsgPost, _ = pcall(function()
		rawset(require(LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("ChatScript").ChatMain),"MessagePosted", {
			["fire"] = function(msg)
				return msg
			end,
			["wait"] = function()
				return
			end,
			["connect"] = function()
				return
			end
		})
	end)
	DoNotif(MsgPost and "Enabled" or "Failed to enable antichatlogs")
end)

cmd.add({"animspoofer","animationspoofer","spoofanim","animspoof"},{"animationspoofer (animspoof,spoofanim)","Loads up an animation spoofer,spoofs animations that use rbxassetid"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Animation%20Spoofer"))()
end)

local animSpeed

cmd.add({"animationspeed", "animspeed"}, {"animationspeed <speed> (animspeed)", "speeds up your animations"}, function(speed)
	speed = tonumber(speed) or 1

	if animSpeed then
		animSpeed:Disconnect()
	end

	animSpeed = RunService.Heartbeat:Connect(function()
		local humanoid = getChar():FindFirstChildOfClass("Humanoid") or getChar():FindFirstChildOfClass("AnimationController")
		if humanoid then
			for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
				track:AdjustSpeed(speed)
			end
		end
	end)

	DoNotif("Animation speed set to "..speed)
end,true)

cmd.add({"unanimationspeed", "unanimspeed"}, {"unanimationspeed (unanimspeed)", "stops the animation speed loop"}, function()
	if animSpeed then
		animSpeed:Disconnect()
		animSpeed = nil
		DoNotif("Animation speed disabled")
	else
		DoNotif("No active animation speed to disable")
	end
end)

cmd.add({"placeid","pid"},{"placeid (pid)","Copies the PlaceId of the game you're in"},function()
	setclipboard(tostring(PlaceId))

	wait();

	DoNotif("Copied the game's PlaceId: "..PlaceId)
end)

cmd.add({"gameid","universeid","gid"},{"gameid (universeid,gid)","Copies the GameId/Universe Id of the game you're in"},function()
	setclipboard(tostring(GameId))

	wait();

	DoNotif("Copied the game's GameId: "..GameId)
end)

cmd.add({"placename","pname"},{"placename (pname)","Copies the game's place name to your clipboard"},function()
	placeNaem = placeName()
	setclipboard(placeNaem)

	wait();

	DoNotif("Copied the game's place name: "..placeNaem)
end)

function getTgt(user)
	if user == nil then
		user = plr.Name
	end
	return getPlr(user)
end

cmd.add({"copyname", "cname"}, {"copyname <player> (cname)", "Copies the username of the target"}, function(...)
	local usr = ...
	local tgt = getTgt(usr)

	setclipboard(tostring(tgt.Name))
	wait()
	DoNotif("Copied the username of "..tgt.DisplayName)
end, true)

cmd.add({"copydisplay", "cdisplay"}, {"copydisplay <player> (cdisplay)", "Copies the display name of the target"}, function(...)
	local usr = ...
	local tgt = getTgt(usr)

	setclipboard(tostring(tgt.DisplayName))
	wait()
	DoNotif("Copied the display name of "..tgt.Name)
end, true)

cmd.add({"copyid", "id"}, {"copyid <player> (id)", "Copies the UserId of the target"}, function(...)
	local usr = ...
	local tgt = getTgt(usr)

	setclipboard(tostring(tgt.UserId))
	wait()
	DoNotif("Copied the UserId of "..tgt.Name)
end, true)

--[ PLAYER ]--
function toggleKB(enable)
	local p = Players.LocalPlayer
	local hrp = getRoot(p.Character)
	local parts = SafeGetService("Workspace"):GetPartBoundsInRadius(hrp.Position, 10)
	for _, part in ipairs(parts) do
		if part:IsA("BasePart") then
			part.CanTouch = enable
		end
	end
end

cmd.add({"antikillbrick", "antikb"}, {"antikillbrick (antikb)", "Prevents kill bricks from killing you"}, function()
	toggleKB(false)
end)

cmd.add({"unantikillbrick", "unantikb"}, {"unantikillbrick (unantikb)", "Allows kill bricks to kill you"}, function()
	toggleKB(true)
end)

cmd.add({"height","hipheight","hh"},{"height <number> (hipheight,hh)","Changes your hipheight"},function(...)
	getHum().HipHeight=(...)
end,true)

cmd.add({"netbypass", "netb"}, {"netbypass (netb)", "Net bypass"}, function()
	wait()
	DoNotif("Netbypass enabled")
	local fenv = getfenv()
	local shp = fenv.sethiddenproperty or fenv.set_hidden_property or fenv.sethiddenprop or fenv.set_hidden_prop
	local ssr = fenv.setsimulationradius or fenv.setsimradius or fenv.set_simulation_radius
	net = shp and function(r) shp(lp, "SimulationRadius", r) end or ssr
end)

cmd.add({"day"},{"day","Makes it day"},function()
	Lighting.ClockTime=14
end)

cmd.add({"night"},{"night","Makes it night"},function()
	Lighting.ClockTime=0
end)

cmd.add({"chat", "message"}, {"chat <text> (message)", "Chats for you, useful if you're muted"}, function(...)
	local chatMessage = table.concat({...}, " ")
	local chatTarget = "All"
	lib.LocalPlayerChat(chatMessage, chatTarget)
end, true)

cmd.add({"privatemessage", "pm"}, {"privatemessage <player> <text> (pm)", "Sends a private message to a player"}, function(...)
	local args = {...}
	local Player = getPlr(args[1])

	if not Player then return end

	local message = ""

	for i = 2, #args do
		if i == 2 then
			message = tostring(args[i])
		else
			message = message.." "..tostring(args[i])
		end
	end

	if message == "" then return end

	local result = lib.LocalPlayerChat(message, Player.Name)

	if result == "Hooking" then
		task.wait(.3)
		lib.LocalPlayerChat(message, Player.Name)
	end
end,true)

cmd.add({"fixcam", "fix"}, {"fixcam", "Fix your camera"}, function()
	local ws = SafeGetService("Workspace")
	local plr = Players.LocalPlayer
	ws.CurrentCamera:Remove()
	wait(0.1)
	repeat wait() until plr.Character
	local cam = ws.CurrentCamera
	cam.CameraSubject = plr.Character:FindFirstChildWhichIsA("Humanoid")
	cam.CameraType = "Custom"
	plr.CameraMinZoomDistance = 0.5
	plr.CameraMaxZoomDistance = math.huge
	plr.CameraMode = "Classic"
	plr.Character:FindFirstChild("Head").Anchored = false
end)

cmd.add({"saw"}, {"saw <challenge>", "shush"}, function(...)
	local challenge = table.concat({...}, " ")
	_G.SawFinish = false

	function playSound(id, vol)
		local sfx = Instance.new("Sound")
		sfx.Parent = PlrGui
		sfx.SoundId = "rbxassetid://"..id
		sfx.Volume = vol or 1
		sfx:Play()
		sfx.Ended:Connect(function()
			sfx:Destroy()
		end)
	end

	function createUIElement(class, properties, parent)
		local element = Instance.new(class)
		for prop, value in pairs(properties) do
			element[prop] = value
		end
		if parent then element.Parent = parent end
		return element
	end

	local ScreenGui = createUIElement("ScreenGui", { Name = randomString() })

	NaProtectUI(ScreenGui)

	local background = createUIElement("Frame", {
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.5,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 0
	}, ScreenGui)

	coroutine.wrap(function()
		while not _G.SawFinish do
			background.BackgroundTransparency = math.random(3, 7) / 10
			task.wait(0.1)
		end
	end)()

	local imgLabel = createUIElement("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.1, 0),
		Size = UDim2.new(0, 150, 0, 150),
		Image = "rbxassetid://8747893766",
		ImageColor3 = Color3.fromRGB(255, 0, 0)
	}, ScreenGui)

	coroutine.wrap(function()
		while not _G.SawFinish do
			local newSize = math.random(140, 160)
			local newRotation = math.random(-10, 10)
			local tween = TweenService:Create(
				imgLabel,
				TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
				{ Size = UDim2.new(0, newSize, 0, newSize), Rotation = newRotation }
			)
			tween:Play()
			tween.Completed:Wait()
		end
	end)()

	local ttLabelLeft = createUIElement("TextLabel", {
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.3,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.new(0.3, 0, 0.1, 0),
		Font = Enum.Font.SciFi,
		Text = "Challenge: "..challenge,
		TextColor3 = Color3.fromRGB(255, 0, 0),
		TextSize = 24,
		TextWrapped = true,
		ZIndex = 2
	}, ScreenGui)

	local ttLabelRight = createUIElement("TextLabel", {
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.3,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Size = UDim2.new(0.3, 0, 0.1, 0),
		Font = Enum.Font.SciFi,
		Text = "Time Remaining: 180 seconds",
		TextColor3 = Color3.fromRGB(255, 0, 0),
		TextSize = 24,
		TextWrapped = true,
		ZIndex = 2
	}, ScreenGui)

	local dramaticLabel = createUIElement("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.7, 0),
		Size = UDim2.new(0.5, 0, 0.2, 0),
		Font = Enum.Font.SciFi,
		Text = "",
		TextColor3 = Color3.fromRGB(255, 0, 0),
		TextSize = 50,
		TextStrokeTransparency = 0.5,
		TextWrapped = true,
		ZIndex = 3
	}, ScreenGui)

	function flickerText()
		while not _G.SawFinish do
			ttLabelLeft.TextColor3 = Color3.fromRGB(math.random(200, 255), 0, 0)
			ttLabelRight.TextColor3 = Color3.fromRGB(math.random(200, 255), 0, 0)
			ttLabelLeft.Text = "Challenge: "..challenge:sub(1, math.random(1, #challenge))
			task.wait(math.random(5, 15) / 100)
		end
	end

	function dramaticCountdown(num)
		dramaticLabel.Text = tostring(num)
		playSound(138081500, 2)
		task.wait(1)
		dramaticLabel.Text = ""
	end

	function count()
		local num = 180
		while task.wait(1) do
			if not _G.SawFinish then
				if num > 0 then
					num = num - 1
					playSound(138081500, 1)
					ttLabelRight.Text = "Time Remaining: "..num.." seconds"
					if num == 30 or num == 20 or num == 10 then
						dramaticCountdown(num)
					elseif num <= 10 then
						dramaticLabel.Text = tostring(num)
						playSound(138081500, 2)
					end
				else
					Players.LocalPlayer:Kick("You Failed The Challenge")
				end
			else
				ttLabelLeft.Text = "You Survived... For Now"
				ttLabelRight.Text = ""
				dramaticLabel.Text = ""
				playSound(9125915751, 5)
				task.wait(2)
				ScreenGui:Destroy()
				break
			end
		end
	end

	coroutine.wrap(count)()
	coroutine.wrap(flickerText)()
end, true)

cmd.add({"jend"}, {"jend", "nil"}, function()
	_G.SawFinish = true
end)

cmd.add({"fling"}, {"fling <player>", "Fling the given player"}, function(plr)
	local player = LocalPlayer
	local mouse = player:GetMouse()
	local Targets = {plr}

	local Player = Players.LocalPlayer

	local AllBool = false

	local GetPlayer = function(Name)
		Name = Name:lower()
		if Name == "all" or Name == "others" then
			AllBool = true
			return
		elseif Name == "random" then
			local GetPlayers = Players:GetPlayers()
			if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
			return GetPlayers[math.random(#GetPlayers)]
		elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
			for _,x in next, Players:GetPlayers() do
				if x ~= Player then
					if x.Name:lower():match("^"..Name) then
						return x;
					elseif x.DisplayName:lower():match("^"..Name) then
						return x;
					end
				end
			end
		else
			return
		end
	end

	local Message = function(_Title, _Text, Time)
		print(_Title)
		print(_Text)
		print(Time)
	end

	local SkidFling = function(TargetPlayer)
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid and Humanoid.RootPart

		local TCharacter = TargetPlayer.Character
		local THumanoid
		local TRootPart
		local THead
		local Accessory
		local Handle

		if TCharacter:FindFirstChildOfClass("Humanoid") then
			THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
		end
		if THumanoid and THumanoid.RootPart then
			TRootPart = THumanoid.RootPart
		end
		if TCharacter:FindFirstChild("Head") then
			THead = TCharacter.Head
		end
		if TCharacter:FindFirstChildOfClass("Accessory") then
			Accessory = TCharacter:FindFirstChildOfClass("Accessory")
		end
		if Accessoy and Accessory:FindFirstChild("Handle") then
			Handle = Accessory.Handle
		end

		if Character and Humanoid and RootPart then
			if RootPart.Velocity.Magnitude < 50 then
				getgenv().OldPos = RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				SafeGetService("Workspace").CurrentCamera.CameraSubject = THead
			elseif not THead and Handle then
				SafeGetService("Workspace").CurrentCamera.CameraSubject = Handle
			elseif THumanoid and TRootPart then
				SafeGetService("Workspace").CurrentCamera.CameraSubject = THumanoid
			end
			if not TCharacter:FindFirstChildWhichIsA("BasePart") then
				return
			end

			local FPos = function(BasePart, Pos, Ang)
				RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
				Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
				RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
				RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
			end

			local SFBasePart = function(BasePart)
				local TimeToWait = 2
				local Time = tick()
				local Angle = 0

				repeat
					if RootPart and THumanoid then
						if BasePart.Velocity.Magnitude < 50 then
							Angle = Angle + 100

							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
						else
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
							task.wait()

							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
			end

			SafeGetService("Workspace").FallenPartsDestroyHeight = 0/0

			local BV = Instance.new("BodyVelocity")
			BV.Name = "EpixVel"
			BV.Parent = RootPart
			BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
			BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

			if TRootPart and THead then
				if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
					SFBasePart(THead)
				else
					SFBasePart(TRootPart)
				end
			elseif TRootPart and not THead then
				SFBasePart(TRootPart)
			elseif not TRootPart and THead then
				SFBasePart(THead)
			elseif not TRootPart and not THead and Accessory and Handle then
				SFBasePart(Handle)
			else
			end

			BV:Destroy()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			SafeGetService("Workspace").CurrentCamera.CameraSubject = Humanoid

			repeat
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(), function(_, x)
					if x:IsA("BasePart") then
						x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
					end
				end)
				task.wait()
			until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
			SafeGetService("Workspace").FallenPartsDestroyHeight = getgenv().FPDH
		else
		end
	end

	getgenv().Welcome = true
	if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

	if AllBool then
		for _,x in next, Players:GetPlayers() do
			SkidFling(x)
		end
	end

	for _,x in next, Targets do
		if GetPlayer(x) and GetPlayer(x) ~= Player then
			if GetPlayer(x).UserId ~= 1414978355 then
				local TPlayer = GetPlayer(x)
				if TPlayer then
					SkidFling(TPlayer)
				end
			else
			end
		elseif not GetPlayer(x) and not AllBool then
		end
	end
end,true)

--[[cmd.add({"commitoof","suicide","kys"},{"commitoof (suicide,kys)","FE KILL YOURSELF SCRIPT this will be bad when taken out of context"},function()
	local A_1="Okay.. i will do it."
	local A_2="All"
	lib.LocalPlayerChat(A_1,A_2)
	wait(1)
	local A_1="I will oof"
	local A_2="All"
	lib.LocalPlayerChat(A_1,A_2)
	wait(1)
	local A_1="Goodbye."
	local A_2="All"
	lib.LocalPlayerChat (A_1,A_2)
	wait(1)
	LocalPlayer=Players.LocalPlayer
	LocalPlayer.Character.Humanoid:MoveTo(getRoot(getChar()).Position+getRoot(getChar()).CFrame.lookVector*10)
	getChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	wait(0.5)
	getChar().Humanoid.Health=0
end)]]

cmd.add({"volume","vol"},{"volume <1-10> (vol)","Changes your volume"},function(vol)
	amount=vol/10
	UserSettings():GetService("UserGameSettings").MasterVolume=amount
end,true)

cmd.add({"sensitivity","sens"},{"sensitivity <1-10> (tr)","Changes your sensitivity"},function(ss)
	UserInputService.MouseDeltaSensitivity=ss
end,true)

cmd.add({"torandom","tr"},{"torandom (tr)","Teleports to a random player"},function()
	target=getPlr("random")
	getRoot(getChar()).CFrame=target.Character.Humanoid.RootPart.CFrame
end)

cmd.add({"goto","to","tp","teleport"},{"goto <player/X,Y,Z>","Teleport to the given player or X,Y,Z coordinates"},function(...)
	Username=(...)

	local target=getPlr(Username)
	getRoot(getChar()).CFrame=getPlrHum(target).RootPart.CFrame
end,true)

local StaringConnection = nil

cmd.add({"lookat", "stare"}, {"stare <player> (lookat)", "Stare at a player"}, function(...)
	local Username = (...)
	local Target = getPlr(Username)

	if StaringConnection then
		StaringConnection:Disconnect()
		StaringConnection = nil
	end

	if not (Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
	if not (Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")) then return end

	function Stare()
		if Players.LocalPlayer.Character.PrimaryPart and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
			local LocalCharPos = Players.LocalPlayer.Character.PrimaryPart.Position
			local TargetPos = Target.Character.HumanoidRootPart.Position
			local AdjustedTargetPos = Vector3.new(TargetPos.X, LocalCharPos.Y, TargetPos.Z)
			local NewCFrame = CFrame.new(LocalCharPos, AdjustedTargetPos)
			Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
		else
			if not Players:FindFirstChild(Target.Name) then
				StaringConnection:Disconnect()
				StaringConnection = nil
			end
		end
	end

	StaringConnection = RunService.RenderStepped:Connect(Stare)
end,true)

cmd.add({"unlookat", "unstare"}, {"unstare (unlookat)", "Stops staring"}, function()
	if StaringConnection then
		StaringConnection:Disconnect()
		StaringConnection = nil
	end
end)

local conn, loop, plrLeftCon = nil, nil, nil
local specGui, currentPlayerIndex = nil, 1

function cleanup()
	if conn then
		conn:Disconnect()
		conn = nil
	end
	if loop then
		coroutine.close(loop)
		loop = nil
	end
	if plrLeftCon then
		plrLeftCon:Disconnect()
		plrLeftCon = nil
	end
	if specGui then
		specGui:Destroy()
		specGui=nil
	end
	SafeGetService("Workspace").CurrentCamera.CameraSubject = getHum()
end

function spectatePlayer(targetPlayer)
	if not targetPlayer then return end

	if conn then
		conn:Disconnect()
		conn = nil
	end
	if loop then
		coroutine.close(loop)
		loop = nil
	end
	if plrLeftCon then
		plrLeftCon:Disconnect()
		plrLeftCon = nil
	end

	conn = targetPlayer.CharacterAdded:Connect(function(character)
		repeat wait() until character:FindFirstChildWhichIsA("Humanoid")
		SafeGetService("Workspace").CurrentCamera.CameraSubject = character:FindFirstChildWhichIsA("Humanoid")
	end)

	plrLeftCon = Players.PlayerRemoving:Connect(function(player)
		if player == targetPlayer then
			cleanup()
			DoNotif("Player left - camera reset")
		end
	end)

	loop = coroutine.create(function()
		while conn do
			if targetPlayer.Character and targetPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
				SafeGetService("Workspace").CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChildWhichIsA("Humanoid")
			end
			wait()
		end
	end)

	coroutine.resume(loop)
end

cmd.add({"watch", "view", "spectate"}, {"watch <Player> (view, spectate)", "Spectate player"}, function(...)
	cleanup()

	local targetPlayer = getPlr((...))
	if not targetPlayer then return end

	spectatePlayer(targetPlayer)
end, true)

cmd.add({"unwatch", "unview"}, {"unwatch (unview)", "Stop spectating"}, function()
	cleanup()
end)

local function createGui()
	if not specGui then
		specGui = Instance.new("ScreenGui")
		specGui.Name = "SpectateGui"
		NaProtectUI(specGui)
		specGui.ResetOnSpawn = false

		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 350, 0, 40)
		frame.Position = UDim2.new(0.5, -175, 1, -160)
		frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		frame.BorderSizePixel = 0
		frame.Parent = specGui

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 20)
		corner.Parent = frame

		gui.draggable(frame)

		local playerNameLabel = Instance.new("TextLabel")
		playerNameLabel.Size = UDim2.new(0.78, 0, 1, 0)
		playerNameLabel.Position = UDim2.new(0.06, 0, 0, 0)
		playerNameLabel.Text = "Spectating: None"
		playerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		playerNameLabel.BackgroundTransparency = 1
		playerNameLabel.Font = Enum.Font.GothamBold
		playerNameLabel.TextScaled = true
		playerNameLabel.Parent = frame

		local backButton = Instance.new("TextButton")
		backButton.Size = UDim2.new(0, 40, 0, 40)
		backButton.Position = UDim2.new(0, -18, 0, 0)
		backButton.Text = "<"
		backButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		backButton.Font = Enum.Font.GothamBold
		backButton.TextSize = 24
		backButton.Parent = frame

		local backCorner = Instance.new("UICorner")
		backCorner.CornerRadius = UDim.new(0, 10)
		backCorner.Parent = backButton

		local forwardButton = Instance.new("TextButton")
		forwardButton.Size = UDim2.new(0, 40, 0, 40)
		forwardButton.Position = UDim2.new(1, -22, 0, 0)
		forwardButton.Text = ">"
		forwardButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		forwardButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		forwardButton.Font = Enum.Font.GothamBold
		forwardButton.TextSize = 24
		forwardButton.Parent = frame

		local forwardCorner = Instance.new("UICorner")
		forwardCorner.CornerRadius = UDim.new(0, 10)
		forwardCorner.Parent = forwardButton

		local closeButton = Instance.new("TextButton")
		closeButton.Size = UDim2.new(0, 30, 0, 30)
		closeButton.Position = UDim2.new(1, -55, 0, 5)
		closeButton.Text = "X"
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.Font = Enum.Font.GothamBold
		closeButton.TextSize = 18
		closeButton.Parent = frame

		local closeCorner = Instance.new("UICorner")
		closeCorner.CornerRadius = UDim.new(0, 5)
		closeCorner.Parent = closeButton

		closeButton.MouseButton1Click:Connect(function()
			cleanup()
		end)

		local function updateSpectating()
			if #playerButtons == 0 then
				playerNameLabel.Text = "Spectating: None"
				return
			end
			local currentPlayer = playerButtons[currentPlayerIndex]
			local nameCheck = currentPlayer.DisplayName == currentPlayer.Name and '@'..currentPlayer.Name or currentPlayer.DisplayName..' (@'..currentPlayer.Name..')'
			playerNameLabel.Text = "Spectating: "..nameCheck
			spectatePlayer(currentPlayer)
		end

		MouseButtonFix(backButton, function()
			if #playerButtons == 0 then return end
			currentPlayerIndex = currentPlayerIndex - 1
			if currentPlayerIndex < 1 then
				currentPlayerIndex = #playerButtons
			end
			updateSpectating()
		end)

		MouseButtonFix(forwardButton, function()
			if #playerButtons == 0 then return end
			currentPlayerIndex = currentPlayerIndex + 1
			if currentPlayerIndex > #playerButtons then
				currentPlayerIndex = 1
			end
			updateSpectating()
		end)

		updateSpectating()
	end
end

cmd.add({"watch2", "view2", "spectate2"}, {"watch2 <Player> (view2, spectate2)", "Spectate player with GUI"}, function()
	cleanup()
	createGui()
end, true)

cmd.add({"unwatch2", "unview2"}, {"unwatch2 (unview2)", "Stop spectating with GUI"}, function()
	cleanup()
end)

cmd.add({"stealaudio","getaudio","steal","logaudio"},{"stealaudio <player> (getaudio,logaudio,steal)","Save all sounds a player is playing to a file -Cyrus"},function(p)
	wait()
	local player = getPlr(p)
	local audios = ""
	if player then
		local char = player.Character
		if char then
			for _, v in pairs(char:GetDescendants()) do
				if v:IsA("Sound") and v.Playing then
					audios = audios..("%s\n"):format(v.SoundId)
				end
			end
		end
	end
	if audios ~= "" then
		setclipboard(tostring(audios))
		DoNotif("Audio links have been copied to your clipboard.")
	end
end,true)

cmd.add({"follow","stalk","walk"},{"follow <player>","Follow a player wherever they go"},function(p)
	lib.disconnect("follow")
	local targetPlayer = getPlr(p)
	if not targetPlayer then
		DoNotif("Player not found or invalid.")
		return
	end
	lib.connect("follow",RunService.Stepped:Connect(function()
		print'began'
		local target = targetPlayer.Character
		if target and character then
			local hum = character:FindFirstChildWhichIsA("Humanoid")
			local targetPart = target:FindFirstChild("Head")
			if hum and targetPart then
				local targetPos = targetPart.Position
				hum:MoveTo(targetPos)
			else
				lib.disconnect("follow")
			end
		else
			lib.disconnect("follow")
		end
	end))
end,true)

cmd.add({"unfollow","unstalk","unwalk","unpathfind"},{"unfollow","Stop all attempts to follow a player"},function()
	lib.disconnect("follow")
end)

cmd.add({"pathfind"}, {"pathfind <player>", "Follow a player using the pathfinder API wherever they go"}, function(p)
	local targetPlayer = getPlr(p)
	if not targetPlayer then return end

	lib.disconnect("follow")
	local debounce = false

	lib.connect("follow", RunService.Stepped:Connect(function()
		if debounce then return end
		debounce = true

		local target = targetPlayer.Character
		local character = getChar()
		if not target or not character then
			debounce = false
			return
		end

		local hum = character:FindFirstChildWhichIsA("Humanoid")
		local main = target:FindFirstChild("HumanoidRootPart")
		if hum and main then
			local targetPart = main or target:FindFirstChild("Head")
			local targetPos = (targetPart.CFrame * CFrame.new(0, 0, -0.5)).p
			local PathService = SafeGetService("PathfindingService")
			local path = PathService:CreatePath({
				AgentRadius = 2,
				AgentHeight = 5,
				AgentCanJump = true
			})
			path:ComputeAsync(hum.RootPart.Position, targetPos)

			if path.Status ~= Enum.PathStatus.NoPath then
				local waypoints = path:GetWaypoints()
				for i, waypoint in pairs(waypoints) do
					if waypoint.Action == Enum.PathWaypointAction.Jump then
						hum:ChangeState(Enum.HumanoidStateType.Jumping)
						hum:MoveTo(waypoint.Position)
						hum.MoveToFinished:Wait()
					else
						hum:MoveTo(waypoint.Position)
						hum.MoveToFinished:Wait()
					end
				end
			else
				--print("No valid path found.")
			end
		end
		debounce = false
	end))
end,true)

cmd.add({"freeze","thaw","anchor","fr"},{"freeze (thaw,anchor,fr)","Freezes your character"},function()
	for _,char in ipairs(LocalPlayer.Character:GetChildren()) do
		if char:IsA("BasePart") then
			char.Anchored=true
		end
	end
end)

cmd.add({"unfreeze","unthaw","unanchor","unfr"},{"unfreeze (unthaw,unanchor,unfr)","Unfreezes your character"},function()
	for _,char in ipairs(LocalPlayer.Character:GetChildren()) do
		if char:IsA("BasePart") then
			char.Anchored=false
		end
	end
end)

cmd.add({"disableanimations","disableanims"},{"disableanimations (disableanims)","Freezes your animations"},function()
	getChar().Animate.Disabled=true
end)

cmd.add({"undisableanimations","undisableanims"},{"undisableanimations (undisableanims)","Unfreezes your animations"},function()
	getChar().Animate.Disabled=false
end)

cmd.add({"hatresize"},{"hatresize","Makes your hats very big r15 only"},function()

	wait();

	DoNotif("Hat resize loaded, rthro needed")

	loadstring(game:HttpGet('https://github.com/DigitalityScripts/roblox-scripts/raw/main/hat%20resize'))()

end)

cmd.add({"exit"},{"exit","Close down roblox"},function()
	game:Shutdown()
end)

cmd.add({"firekey","fkey"},{"firekey <key> (fkey)","makes you fire a keybind using VirtualInputManager"},function(...)
	local vim=SafeGetService("VirtualInputManager");
	local input = (...)
	local keyMap = {
		["leftcontrol"] = Enum.KeyCode.LeftControl,
		["rightcontrol"] = Enum.KeyCode.RightControl,
		["leftshift"] = Enum.KeyCode.LeftShift,
		["rightshift"] = Enum.KeyCode.RightShift,
		["leftalt"] = Enum.KeyCode.LeftAlt,
		["rightalt"] = Enum.KeyCode.RightAlt,
		["space"] = Enum.KeyCode.Space,
		["tab"] = Enum.KeyCode.Tab,
		["escape"] = Enum.KeyCode.Escape,
		["enter"] = Enum.KeyCode.Return,
		["backspace"] = Enum.KeyCode.Backspace
	}

	local keyCode

	if keyMap[input:lower()] then
		keyCode = keyMap[input:lower()]
	else
		keyCode = Enum.KeyCode[input:upper()]
	end

	if keyCode then
		vim:SendKeyEvent(true, keyCode, 0, game)
		vim:SendKeyEvent(false, keyCode, 0, game)
	end
end,true)

cmd.add({"loopfling"},{"loopfling <player>","Loop voids a player"},function(plr)
	local Targets={plr}

	Loopvoid=true
	repeat wait()
		local player=LocalPlayer
		local mouse=player:GetMouse()
		local Player=LocalPlayer

		local AllBool=false

		local GetPlayer = function(Name)
			Name = Name:lower()
			if Name == "all" or Name == "others" then
				AllBool = true
				return
			elseif Name == "random" then
				local GetPlayers = Players:GetPlayers()
				if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
				return GetPlayers[math.random(#GetPlayers)]
			elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
				for _,x in next, Players:GetPlayers() do
					if x ~= Player then
						if x.Name:lower():match("^"..Name) then
							return x;
						elseif x.DisplayName:lower():match("^"..Name) then
							return x;
						end
					end
				end
			else
				return
			end
		end

		local SkidFling=function(TargetPlayer)
			local Character=Player.Character
			local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")
			local RootPart=Humanoid and Humanoid.RootPart

			local TCharacter=TargetPlayer.Character
			local THumanoid
			local TRootPart
			local THead
			local Accessory
			local Handle

			if TCharacter:FindFirstChildOfClass("Humanoid") then
				THumanoid=TCharacter:FindFirstChildOfClass("Humanoid")
			end
			if THumanoid and THumanoid.RootPart then
				TRootPart=THumanoid.RootPart
			end
			if TCharacter:FindFirstChild("Head") then
				THead=TCharacter:FindFirstChild("Head")
			end
			if TCharacter:FindFirstChildOfClass("Accessory") then
				Accessory=TCharacter:FindFirstChildOfClass("Accessory")
			end
			if Accessoy and Accessory:FindFirstChild("Handle") then
				Handle=Accessory.Handle
			end

			if Character and Humanoid and RootPart then
				if RootPart.Velocity.Magnitude<50 then
					getgenv().OldPos=RootPart.CFrame
				end
				if THumanoid and THumanoid.Sit and not AllBool then
					return
				end
				if THead then
					SafeGetService("Workspace").CurrentCamera.CameraSubject=THead
				elseif not THead and Handle then
					SafeGetService("Workspace").CurrentCamera.CameraSubject=Handle
				elseif THumanoid and TRootPart then
					SafeGetService("Workspace").CurrentCamera.CameraSubject=THumanoid
				end
				if not TCharacter:FindFirstChildWhichIsA("BasePart") then
					return
				end

				local FPos=function(BasePart,Pos,Ang)
					RootPart.CFrame=CFrame.new(BasePart.Position)*Pos*Ang
					Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position)*Pos*Ang)
					RootPart.Velocity=Vector3.new(9e7,9e7*10,9e7)
					RootPart.RotVelocity=Vector3.new(9e8,9e8,9e8)
				end

				local SFBasePart=function(BasePart)
					local TimeToWait=2
					local Time=tick()
					local Angle=0

					repeat
						if RootPart and THumanoid then
							if BasePart.Velocity.Magnitude<50 then
								Angle=Angle+100

								FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(2.25,1.5,-2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(-2.25,-1.5,2.25)+THumanoid.MoveDirection*BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0)+THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle),0,0))
								task.wait()
							else
								FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,-THumanoid.WalkSpeed),CFrame.Angles(0,0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,THumanoid.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,-TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(0,0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,1.5,TRootPart.Velocity.Magnitude / 1.25),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
								task.wait()

								FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
								task.wait()
							end
						else
							break
						end
					until BasePart.Velocity.Magnitude>500 or BasePart.Parent~=TargetPlayer.Character or TargetPlayer.Parent~=Players or not TargetPlayer.Character==TCharacter or THumanoid.Sit or Humanoid.Health <=0 or tick()>Time+TimeToWait
				end

				SafeGetService("Workspace").FallenPartsDestroyHeight=0/0

				local BV=Instance.new("BodyVelocity")
				BV.Name="EpixVel"
				BV.Parent=RootPart
				BV.Velocity=Vector3.new(9e8,9e8,9e8)
				BV.MaxForce=Vector3.new(1/0,1/0,1/0)

				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)

				if TRootPart and THead then
					if (TRootPart.CFrame.p-THead.CFrame.p).Magnitude>5 then
						SFBasePart(THead)
					else
						SFBasePart(TRootPart)
					end
				elseif TRootPart and not THead then
					SFBasePart(TRootPart)
				elseif not TRootPart and THead then
					SFBasePart(THead)
				elseif not TRootPart and not THead and Accessory and Handle then
					SFBasePart(Handle)
				else
					return
				end

				BV:Destroy()
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
				SafeGetService("Workspace").CurrentCamera.CameraSubject=Humanoid

				repeat
					RootPart.CFrame=getgenv().OldPos*CFrame.new(0,.5,0)
					Character:SetPrimaryPartCFrame(getgenv().OldPos*CFrame.new(0,.5,0))
					Humanoid:ChangeState("GettingUp")
					table.foreach(Character:GetChildren(),function(_,x)
						if x:IsA("BasePart") then
							x.Velocity,x.RotVelocity=Vector3.new(),Vector3.new()
						end
					end)
					task.wait()
				until (RootPart.Position-getgenv().OldPos.p).Magnitude<25
				SafeGetService("Workspace").FallenPartsDestroyHeight=getgenv().FPDH
			else
				return
			end
		end

		if not Welcome then DoNotif("Enjoy!",5,"Script by AnthonyIsntHere") end
		getgenv().Welcome=true
		if Targets[1] then for _,x in next,Targets do GetPlayer(x) end else return end

		if AllBool then
			for _,x in next,Players:GetPlayers() do
				SkidFling(x)
			end
		end

		for _,x in next,Targets do
			if GetPlayer(x) and GetPlayer(x)~=Player then
				if GetPlayer(x).UserId~=1414978355 then
					local TPlayer=GetPlayer(x)
					if TPlayer then
						SkidFling(TPlayer)
					end
				end
			elseif not GetPlayer(x) and not AllBool then end
		end
	until Loopvoid==false
end,true)

cmd.add({"freegamepass", "freegp"}, {"freegamepass (freegp)", "Makes the client think you own every gamepass in the game"}, function()
	local mt = getrawmetatable(game)
	local oldNamecall = mt.__namecall
	local setReadOnly = setreadonly or make_writeable

	local MarketplaceService = SafeGetService("MarketplaceService")

	setReadOnly(mt, false)

	mt.__namecall = function(self, ...)
		local args = {...}
		local method = getnamecallmethod()

		if self == MarketplaceService and method == "UserOwnsGamePassAsync" then
			return true
		end

		return oldNamecall(self, ...)
	end

	setReadOnly(mt, true)

	DoNotif("Free gamepass has been executed. Keep in mind this won't always work.")
end)

local headSit, sitDied = nil, nil

cmd.add({"headsit"}, {"headsit <player>", "Head sit."}, function(p)
	local plr = getPlr(p)
	if not plr then return end

	local char = getChar()
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if headSit then
		headSit:Disconnect()
		headSit = nil
	end

	if sitDied then
		sitDied:Disconnect()
		sitDied = nil
	end

	local charRoot = getRoot(char)
	local plrRoot = getRoot(plr.Character)
	if not charRoot or not plrRoot then return end

	hum.Sit = true

	sitDied = hum.Died:Connect(function()
		if headSit then
			headSit:Disconnect()
			headSit = nil
		end
	end)

	local alignPos = charRoot:FindFirstChildOfClass("AlignPosition") or Instance.new("AlignPosition", charRoot)
	alignPos.Attachment0 = charRoot:FindFirstChild("RootAttachment") or Instance.new("Attachment", charRoot)
	alignPos.Attachment1 = plrRoot:FindFirstChild("RootAttachment") or Instance.new("Attachment", plrRoot)
	alignPos.RigidityEnabled = true
	alignPos.MaxForce = 100000
	alignPos.Responsiveness = 200
	alignPos.Attachment1.Position = Vector3.new(0, 1.6, 0.4)

	local alignOri = charRoot:FindFirstChildOfClass("AlignOrientation") or Instance.new("AlignOrientation", charRoot)
	alignOri.Attachment0 = charRoot:FindFirstChild("RootAttachment")
	alignOri.Attachment1 = plrRoot:FindFirstChild("RootAttachment")
	alignOri.RigidityEnabled = true
	alignOri.MaxTorque = 100000
	alignOri.Responsiveness = 200

	headSit = RunService.Heartbeat:Connect(function()
		if not SafeGetService("Players"):FindFirstChild(plr.Name) or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or hum.Sit == false then
			alignPos:Destroy()
			alignOri:Destroy()
			headSit:Disconnect()
			headSit = nil
		end
	end)
end,true)

cmd.add({"unheadsit"}, {"unheadsit", "Stop the headsit command."}, function()
	if headSit then
		headSit:Disconnect()
		headSit = nil
	end

	if sitDied then
		sitDied:Disconnect()
		sitDied = nil
	end

	local char = getChar()
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end

	local charRoot = getRoot(char)
	if charRoot then
		for _, child in ipairs(charRoot:GetChildren()) do
			if child:IsA("AlignPosition") or child:IsA("AlignOrientation") then
				child:Destroy()
			end
		end
	end
end)

cmd.add({"jump"},{"jump","jump."},function()
	getHum():ChangeState(Enum.HumanoidStateType.Jumping)
end)

local jL = nil

cmd.add({"loopjump","bhop"}, {"loopjump (bhop)", "Continuously jump."}, function()
	if jL then jL:Disconnect() end
	jL = RunService.Heartbeat:Connect(function()
		local h = getHum()
		if h and h:GetState() ~= Enum.HumanoidStateType.Freefall then
			h:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end)

cmd.add({"unloopjump","unbhop"}, {"unloopjump (unbhop)", "Stop continuous jumping."}, function()
	if jL then jL:Disconnect() jL = nil end
end)

local headStand,standDied=nil,nil

cmd.add({"headstand"}, {"headstand <player>", "Stand on someone's head."}, function(p)
	if headStand then headStand:Disconnect() headStand = nil end

	local plr = getPlr(p)
	if not plr then return end

	local char = getChar()
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	standDied = hum.Died:Connect(function()
		if headStand then headStand:Disconnect() headStand = nil end
	end)

	headStand = RunService.Heartbeat:Connect(function()
		if Players:FindFirstChild(plr.Name) and plr.Character and getRoot(plr.Character) and getRoot(char) then
			getRoot(char).CFrame = getRoot(plr.Character).CFrame * CFrame.new(0, 4.6, 0.4)
		else
			headStand:Disconnect()
			headStand = nil
		end
	end)
end,true)

cmd.add({"unheadstand"}, {"unheadstand", "Stop the headstand command."}, function()
	if headStand then headStand:Disconnect() headStand = nil end
	if standDied then standDied:Disconnect() standDied = nil end
end)

loopws = false
--wsLoop = nil
wsSignal = nil
getgenv().NamelessWs = nil
cmd.add({"loopwalkspeed", "loopws", "lws"}, {"loopwalkspeed <number> (loopws,lws)", "Loop walkspeed"}, function(...)
	val = {...}
	getgenv().NamelessWs = (val[1] or 16)
	loopws = true
	--if wsLoop then wsLoop:Disconnect() wsLoop = nil end
	if wsSignal then wsSignal:Disconnect() wsSignal = nil end

	if getHum() then
		wsSignal = getHum():GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if loopws then
				if getHum().WalkSpeed ~= getgenv().NamelessWs then
					getHum().WalkSpeed = getgenv().NamelessWs
				end
			end
		end)
	end

	--wsLoop = RunService.RenderStepped:Connect(function()
	if loopws and getHum() then
		getHum().WalkSpeed = getgenv().NamelessWs
	end
	--end)
end,true)

cmd.add({"unloopwalkspeed", "unloopws", "unlws"}, {"unloopwalkspeed <number> (unloopws,unlws)", "Disable loop walkspeed"}, function()
	loopws = false
	--if wsLoop then wsLoop:Disconnect() wsLoop = nil end
	if wsSignal then wsSignal:Disconnect() wsSignal = nil end
end)

loopjp = false
--jpLoop = nil
jpSignalPower = nil
jpSignalHeight = nil
getgenv().NamelessJP = nil
cmd.add({"loopjumppower", "loopjp", "ljp"}, {"loopjumppower <number> (loopjp,ljp)", "Loop JumpPower"}, function(...)
	val = {...}
	getgenv().NamelessJP = (val[1] or 50)
	loopjp = true
	--if jpLoop then jpLoop:Disconnect() jpLoop = nil end
	if jpSignalPower then jpSignalPower:Disconnect() jpSignalPower = nil end
	if jpSignalHeight then jpSignalHeight:Disconnect() jpSignalHeight = nil end

	if getHum() then
		jpSignalPower = getHum():GetPropertyChangedSignal("JumpPower"):Connect(function()
			if loopjp and getHum().UseJumpPower then
				if getHum().JumpPower ~= getgenv().NamelessJP then
					getHum().JumpPower = getgenv().NamelessJP
				end
			end
		end)
		jpSignalHeight = getHum():GetPropertyChangedSignal("JumpHeight"):Connect(function()
			if loopjp and not getHum().UseJumpPower then
				if getHum().JumpHeight ~= getgenv().NamelessJP then
					getHum().JumpHeight = getgenv().NamelessJP
				end
			end
		end)
	end

	--jpLoop = RunService.RenderStepped:Connect(function()
	if loopjp and getHum() then
		if getHum().UseJumpPower then
			getHum().JumpPower = getgenv().NamelessJP
		else
			getHum().JumpHeight = getgenv().NamelessJP
		end
	end
	--end)
end,true)

cmd.add({"unloopjumppower", "unloopjp", "unljp"}, {"unloopjumppower <number> (unloopjp,unljp)", "Disable loop walkspeed"}, function()
	loopjp = false
	--if jpLoop then jpLoop:Disconnect() jpLoop = nil end
	if jpSignalPower then jpSignalPower:Disconnect() jpSignalPower = nil end
	if jpSignalHeight then jpSignalHeight:Disconnect() jpSignalHeight = nil end
end)

cmd.add({"stopanimations","stopanims","stopanim","noanim"},{"stopanimations (stopanims,stopanim,noanim)","Stops running animations"},function()
	local Char=Players.LocalPlayer.Character
	local Hum=getHum() or Char:FindFirstChildOfClass("AnimationController")

	for i,v in next,Hum:GetPlayingAnimationTracks() do
		v:Stop()
	end
end)

loopwave=false
cmd.add({"loopwaveat","loopwat"},{"loopwaveat <player> (loopwat)","Wave to a player in a loop"},function(...)
	loopwave=true
	Player=(...)
	Target=getPlr(Player)
	local oldcframe=getRoot(getChar()).CFrame
	repeat wait(0.2)
		targetcframe=getRoot(Target.Character).CFrame
		WaveAnim=Instance.new("Animation")
		if getChar():FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
			WaveAnim.AnimationId="rbxassetid://507770239"
		else
			WaveAnim.AnimationId="rbxassetid://128777973"
		end
		getRoot(getChar()).CFrame=targetcframe*CFrame.new(0,0,-3)
		local CharPos=getChar().PrimaryPart.Position
		local tpos=getRoot(Target.Character).Position
		local TPos=Vector3.new(tpos.X,CharPos.Y,tpos.Z)
		local NewCFrame=CFrame.new(CharPos,TPos)
		Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
		wave=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(WaveAnim)
		wave:Play(-1,5,-1)
		wait(1.6)
		wave:Stop()
	until loopwave==false
	getRoot(getChar()).CFrame=oldcframe
end,true)

cmd.add({"unloopwaveat","unloopwat"},{"unloopwaveat <player> (unloopwat)","Stops the loopwaveat command"},function()
	loopwave=false
end)

cmd.add({"tools", "gears"}, {"tools <player> (gears)", "Copies tools from ReplicatedStorage and Lighting"}, function()
	function copyTools(source)
		for _, item in pairs(source:GetDescendants()) do
			if item:IsA('Tool') or item:IsA('HopperBin') then
				item:Clone().Parent = getBp()
			end
		end
	end

	copyTools(Lighting)
	copyTools(ReplicatedStorage)

	wait()
	DoNotif("Copied tools from ReplicatedStorage and Lighting", 3)
end)

cmd.add({"waveat","wat"},{"waveat <player> (wat)","Wave to a player"},function(...)
	--r6 / 128777973
	--r15 / 507770239
	Player=(...)
	Target=getPlr(Player)
	local oldcframe=getRoot(getChar()).CFrame
	targetcframe=getRoot(Target.Character).CFrame
	WaveAnim=Instance.new("Animation")
	if getChar():FindFirstChildOfClass('Humanoid').RigType==Enum.HumanoidRigType.R15 then
		WaveAnim.AnimationId="rbxassetid://507770239"
	else
		WaveAnim.AnimationId="rbxassetid://128777973"
	end
	getRoot(getChar()).CFrame=targetcframe*CFrame.new(0,0,-3)
	local CharPos=getChar().PrimaryPart.Position
	local tpos=Target.Character:FindFirstChild("HumanoidRootPart").Position
	local TPos=Vector3.new(tpos.X,CharPos.Y,tpos.Z)
	local NewCFrame=CFrame.new(CharPos,TPos)
	Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
	wave=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(WaveAnim)
	wave:Play(-1,5,-1)
	wait(1.6)
	wave:Stop()
	getRoot(getChar()).CFrame=oldcframe
end,true)

cmd.add({"headbang","mouthbang","hb","mb"},{"headbang <player> (mouthbang,hb,mb)","Bang them in the mouth because you are gay"},function(h,d)
	RunService=RunService

	speed=d

	if speed==nil then
		speed=10
	end

	Username=h

	local players=getPlr(Username)
	bangAnim=Instance.new("Animation")
	if not IsR15(Players.LocalPlayer) then
		bangAnim.AnimationId="rbxassetid://148840371"
	else
		bangAnim.AnimationId="rbxassetid://5918726674"
	end
	bang=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(bangAnim)
	bang:Play(.1,1,1)
	if speed then
		bang:AdjustSpeed(speed)
	else
		bang:AdjustSpeed(3)
	end
	local bangplr=players.Name
	bangDied=getChar():FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end)
	local bangOffet=CFrame.new(0,1,-1.1)
	bangLoop=RunService.Stepped:Connect(function()
		pcall(function()
			local otherRoot=Players[bangplr].Character:FindFirstChild("Head")
			getRoot(getChar()).CFrame=otherRoot.CFrame*bangOffet
			local CharPos=getChar().PrimaryPart.Position
			local tpos=getRoot(players.Character).Position
			local TPos=Vector3.new(tpos.X,CharPos.Y,tpos.Z)
			local NewCFrame=CFrame.new(CharPos,TPos)
			Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
		end)
	end)
end,true)

cmd.add({"unheadbang","unmouthbang","unhb","unmb"},{"unheadbang (unmouthbang,unhb,unmb)","Bang them in the mouth because you are gay"},function()
	if bangLoop then
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end
end)

cmd.add({"improvetextures"},{"improvetextures","Switches Textures"},function()
	sethidden(SafeGetService("MaterialService"), "Use2022Materials", true)
end)

cmd.add({"undotextures"},{"undotextures","Switches Textures"},function()
	sethidden(SafeGetService("MaterialService"), "Use2022Materials", false)
end)

cmd.add({"serverlist","serverlister","slist"},{"serverlist (serverlister,slist)","list of servers to join in"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/ServerLister.lua"))();
end)

cmd.add({"keyboard"},{"keyboard","provides a keyboard gui for mobile users"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/VirtualKeyboard.lua"))();
end)

local HumanModCons = {}

cmd.add({"edgejump", "ejump"}, {"edgejump (ejump)", "Automatically jumps when you get to the edge of an object"}, function()
	local Char = speaker.Character
	local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
	local currentState
	local previousState
	local lastCFrame

	local function edgeJump()
		if Char and Human then
			previousState = currentState
			currentState = Human:GetState()
			if previousState ~= currentState and currentState == Enum.HumanoidStateType.Freefall and previousState ~= Enum.HumanoidStateType.Jumping then
				local rootPart = getRoot(Char)
				rootPart.CFrame = lastCFrame
				rootPart.Velocity = Vector3.new(rootPart.Velocity.X, Human.JumpPower or Human.JumpHeight, rootPart.Velocity.Z)
			end
			lastCFrame = getRoot(Char).CFrame
		end
	end

	edgeJump()
	HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or RunService.RenderStepped:Connect(edgeJump)
	HumanModCons.ejCA = (HumanModCons.ejCA and HumanModCons.ejCA:Disconnect() and false) or speaker.CharacterAdded:Connect(function(newChar)
		Char = newChar
		Human = newChar:WaitForChild("Humanoid")
		edgeJump()
		HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or RunService.RenderStepped:Connect(edgeJump)
	end)
end)

cmd.add({"unedgejump", "noedgejump", "noejump", "unejump"}, {"unedgejump (noedgejump, noejump, unejump)", "Disables edgejump"}, function()
	if HumanModCons.ejLoop then
		HumanModCons.ejLoop:Disconnect()
		HumanModCons.ejLoop = nil
	end

	if HumanModCons.ejCA then
		HumanModCons.ejCA:Disconnect()
		HumanModCons.ejCA = nil
	end
end)

cmd.add({"equiptools","etools","equipt"},{"equiptools (etools,equipt)","Equips every tool in your inventory"},function()
	for i,v in pairs(LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = getChar()
		end
	end
end)
cmd.add({"unequiptools"},{"unequiptools","Unequips every tool you are currently holding"},function()
	if getChar() then
		getChar():FindFirstChildOfClass('Humanoid'):UnequipTools()
	end 
end)

cmd.add({"bang","fuck"},{"bang <player> <number>","Bangs the player by attaching to them"},function(h,d)	 
	speed=d

	if speed==nil then
		speed=10
	end
	Username=h
	local Target=getPlr(Username)
	bangAnim=Instance.new("Animation")
	if not IsR15(Players.LocalPlayer) then
		bangAnim.AnimationId="rbxassetid://148840371"
	else
		bangAnim.AnimationId="rbxassetid://5918726674"
	end
	bang=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(bangAnim)
	bang:Play(.1,1,1)
	if speed then
		bang:AdjustSpeed(speed)
	else
		bang:AdjustSpeed(3)
	end
	local bangplr=Target.Name
	bangDied=getChar():FindFirstChildOfClass'Humanoid'.Died:Connect(function()
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end)
	local bangOffet=CFrame.new(0,0,1.1)
	bangLoop=RunService.Stepped:Connect(function()
		pcall(function()
			local otherRoot=getRoot(Players[bangplr].Character)
			getRoot(getChar()).CFrame=otherRoot.CFrame*bangOffet
		end)
	end)
end,true)

glueloop=nil

cmd.add({"glue","loopgoto","lgoto"},{"glue <player> (loopgoto,lgoto)","Loop teleport to a player"},function(...)
	User=(...)
	Target=getPlr(User)
	if glueloop then glueloop:Disconnect() glueloop=nil end
	glueloop=RunService.RenderStepped:Connect(function()
		getRoot(getChar()).CFrame=getRoot(Target.Character).CFrame
	end)
end,true)

cmd.add({"unglue","unloopgoto","noloopgoto"},{"unglue (unloopgoto,noloopgoto)","Stops teleporting you to a player"},function()
	if glueloop then glueloop:Disconnect() glueloop=nil end
end)

cmd.add({"spook","scare"},{"spook <player> (scare)","Teleports next to a player for a few seconds"},function(...)
	Username=(...)
	Target=getPlr(Username)

	local oldCF=getRoot(getChar()).CFrame
	Target=getPlr(Username)    
	distancepl=2
	if Target.Character and Target.Character:FindFirstChild('Humanoid') then
		getRoot(getChar()).CFrame=getRoot(Target.Character).CFrame+ getRoot(Target.Character).CFrame.lookVector*distancepl
		getRoot(getChar()).CFrame=CFrame.new(getRoot(getChar()).Position,getRoot(Target.Character).Position)
		wait(.5)
		getRoot(getChar()).CFrame=oldCF
	end

end,true)

loopspook=false
cmd.add({"loopspook","loopscare"},{"loopspook <player> (loopscare)","Teleports next to a player for a few seconds and then again and again"},function(...)
	loopspook=true
	repeat wait()
		Username=(...)
		Target=getPlr(Username)

		local oldCF=getRoot(getChar()).CFrame
		Target=getPlr(Username)    
		distancepl=2
		if Target.Character and Target.Character:FindFirstChild('Humanoid') then
			getRoot(getChar()).CFrame=
				getRoot(Target.Character).CFrame+ getRoot(Target.Character).CFrame.lookVector*distancepl
			getRoot(getChar()).CFrame=CFrame.new(getRoot(getChar()).Position,getRoot(Target.Character).Position)
			wait(.5)
			getRoot(getChar()).CFrame=oldCF
		end
		wait(0.3)
	until loopspook==false
end,true)

cmd.add({"unloopspook","unloopscare"},{"unloopspook <player> (unloopscare)","Stops the loopspook command"},function()
	loopspook=false
end)

cmd.add({"unbang","unfuck"},{"unbang","Unbangs the player"},function()
	if bangLoop then
		bangLoop=bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end
end)

local Airwalker, awPart = nil, nil
local airwalk = {
	Vars = {
		keybinds = {
			Increase = Enum.KeyCode.E,
			Decrease = Enum.KeyCode.Q,
		},
		decrease = false,
		increase = false,
		offset = 0,
	},
	connections = {},
	guis = {},
}

cmd.add({"unairwalk", "unfloat", "unaw"}, {"unairwalk (unfloat, unaw)", "Stops the airwalk command"}, function()
	if Airwalker then Airwalker:Disconnect() Airwalker = nil end
	if awPart then awPart:Destroy() awPart = nil end
	for _, conn in pairs(airwalk.connections) do
		if conn then conn:Disconnect() end
	end
	airwalk.connections = {}
	for _, gui in pairs(airwalk.guis) do
		if gui then gui:Destroy() end
	end
	airwalk.guis = {}
	DoNotif("Airwalk: OFF")
end)

cmd.add({"airwalk", "float", "aw"}, {"airwalk (float, aw)", "Press space to go up, unairwalk to stop"}, function()
	DoNotif(IsOnMobile and "Airwalk: ON" or "Airwalk: ON (Q And E)")
	if Airwalker then Airwalker:Disconnect() Airwalker = nil end
	if awPart then awPart:Destroy() awPart = nil end

	function createButton(parent, text, position, callbackDown, callbackUp)
		local button = Instance.new("TextButton")
		button.Parent = parent
		button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		button.BackgroundTransparency = 0
		button.Position = position
		button.Size = UDim2.new(0.05, 0, 0.1, 0)
		button.Font = Enum.Font.SourceSansBold
		button.Text = text
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextSize = 18
		button.TextScaled = true
		button.AutoButtonColor = false

		local corner = Instance.new("UICorner", button)
		corner.CornerRadius = UDim.new(0.2, 0)

		local stroke = Instance.new("UIStroke", button)
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Thickness = 2

		local hoverEffect = function(isHovering)
			button.BackgroundColor3 = isHovering and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(45, 45, 45)
		end

		button.MouseEnter:Connect(function() hoverEffect(true) end)
		button.MouseLeave:Connect(function() hoverEffect(false) end)
		button.MouseButton1Down:Connect(callbackDown)
		button.MouseButton1Up:Connect(callbackUp)
		gui.draggable(button)

		return button
	end

	if IsOnMobile then
		local guiDown = Instance.new("ScreenGui", COREGUI)
		guiDown.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		guiDown.ResetOnSpawn = false
		airwalk.guis.down = guiDown
		createButton(guiDown, "DOWN", UDim2.new(0.9, 0, 0.7, 0), function() airwalk.Vars.decrease = true end, function() airwalk.Vars.decrease = false end)

		local guiUp = Instance.new("ScreenGui", COREGUI)
		guiUp.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		guiUp.ResetOnSpawn = false
		airwalk.guis.up = guiUp
		createButton(guiUp, "UP", UDim2.new(0.9, 0, 0.5, 0), function() airwalk.Vars.increase = true end, function() airwalk.Vars.increase = false end)
	else
		airwalk.connections.inputBegan = uis.InputBegan:Connect(function(input)
			if input.KeyCode == airwalk.Vars.keybinds.Increase then airwalk.Vars.increase = true end
			if input.KeyCode == airwalk.Vars.keybinds.Decrease then airwalk.Vars.decrease = true end
		end)
		airwalk.connections.inputEnded = uis.InputEnded:Connect(function(input)
			if input.KeyCode == airwalk.Vars.keybinds.Increase then airwalk.Vars.increase = false end
			if input.KeyCode == airwalk.Vars.keybinds.Decrease then airwalk.Vars.decrease = false end
		end)
	end

	awPart = Instance.new("Part", SafeGetService("Workspace"))
	awPart.Size = Vector3.new(7, 2, 3)
	awPart.CFrame = getRoot(getChar()).CFrame - Vector3.new(0, 4, 0)
	awPart.Transparency = 1
	awPart.Anchored = true
	airwalk.Y = getRoot(getChar()).CFrame.y

	Airwalker = RunService.RenderStepped:Connect(function()
		if not awPart then Airwalker:Disconnect() return end
		airwalk.Vars.offset = airwalk.Vars.decrease and 5 or (airwalk.Vars.increase and 3.5 or 4)
		if airwalk.Vars.offset == 4 then
			local smalldis = getRoot(getChar()).CFrame.y - airwalk.Y
			if smalldis < 0.01 then
				getRoot(getChar()).CFrame = CFrame.new(getRoot(getChar()).CFrame.X, airwalk.Y, getRoot(getChar()).CFrame.Z) * getRoot(getChar()).CFrame.Rotation
			end
		end
		airwalk.Y = getRoot(getChar()).CFrame.y
		awPart.CFrame = getRoot(getChar()).CFrame - Vector3.new(0, airwalk.Vars.offset, 0)
	end)
end)

cmd.add({"cbring", "clientbring"}, {"clientbring <player> (cbring)", "Brings the player on your client"}, function(...)
	local username = (...)

	if connections["noclip"] then
		lib.disconnect("noclip")
		return
	end

	lib.connect("noclip", RunService.Stepped:Connect(function()
		if not character then return end
		for _, descendant in pairs(character:GetDescendants()) do
			if descendant:IsA("BasePart") then
				descendant.CanCollide = false
			end
		end
	end))

	if username:lower() == "all" or username:lower() == "others" then
		bringc = RunService.RenderStepped:Connect(function()
			for _, target in pairs(Players:GetPlayers()) do
				if target.Name ~= Players.LocalPlayer.Name and target.Character then
					local targetRoot = getRoot(target.Character)
					local localRoot = getRoot(getChar())
					if targetRoot and localRoot then
						targetRoot.CFrame = localRoot.CFrame + localRoot.CFrame.LookVector * 5
					end
				end
			end
		end)
	else
		local target = getPlr(username)
		if not target then return end

		bringc = RunService.RenderStepped:Connect(function()
			if target.Character then
				local targetRoot = getRoot(target.Character)
				local localRoot = getRoot(getChar())
				if targetRoot and localRoot then
					targetRoot.CFrame = localRoot.CFrame + localRoot.CFrame.LookVector * 3
				end
			end
		end)
	end
end, true)

cmd.add({"uncbring", "unclientbring"}, {"unclientbring (uncbring)", "Disable Client bring command"}, function()
	if bringc then
		bringc:Disconnect()
		bringc = nil
	end

	if connections["noclip"] then
		lib.disconnect("noclip")
	end
end)

cmd.add({"mute","muteboombox"},{"mute <player> (muteboombox)","Mutes the players boombox"},function(...)
	Username=(...)
	if SoundService.RespectFilteringEnabled==true then

		wait();

		DoNotif("Boombox muted. Status: Client Sided")
		if Username:lower()=="all" or Username:lower()=="others" then
			local players=Players:GetPlayers()
			for _,player in ipairs(players) do
				for _,object in ipairs(player.Character:GetDescendants()) do
					if object:IsA("Sound") and object.Playing then
						object:Stop()
					end
				end
				local backpack=player:FindFirstChildOfClass("Backpack")
				if backpack then
					for _,object in ipairs(backpack:GetDescendants()) do
						if object:IsA("Sound") and object.Playing then
							object:Stop()
						end
					end
				end
			end			
		else
			local players=getPlr(Username)
			if players~=nil then
				for i,x in next,players.Character:GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
				for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
			end 
		end
	else
		wait();

		DoNotif("Boombox muted. Status: FE")
		if Username:lower()=="all" or Username:lower()=="others" then
			local players=Players:GetPlayers()
			for _,player in ipairs(players) do
				for _,object in ipairs(player.Character:GetDescendants()) do
					if object:IsA("Sound") and object.Playing then
						object:Stop()
					end
				end
				local backpack=player:FindFirstChildOfClass("Backpack")
				if backpack then
					for _,object in ipairs(backpack:GetDescendants()) do
						if object:IsA("Sound") and object.Playing then
							object:Stop()
						end
					end
				end
			end			
		else
			local players=getPlr(Username)
			if players~=nil then
				for i,x in next,players.Character:GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
				for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
			end 
		end
	end
end,true)

TPWalk = false
local TPWalkingConnection = nil

cmd.add({"tpwalk", "tpwalk"}, {"tpwalk <number>", "More undetectable walkspeed script"}, function(...)
	if TPWalk then
		TPWalk = false
		if TPWalkingConnection then
			TPWalkingConnection:Disconnect()
			TPWalkingConnection = nil
		end
	end

	TPWalk = true
	local Speed = ...

	TPWalkingConnection = RunService.Stepped:Connect(function(_, deltaTime)
		if TPWalk then
			local humanoid = getChar():FindFirstChildWhichIsA("Humanoid")
			if humanoid and humanoid.MoveDirection.Magnitude > 0 then
				local moveDirection = humanoid.MoveDirection
				local translation = moveDirection * (Speed or 1) * deltaTime * 10
				getChar():TranslateBy(translation)
			end
		end
	end)
end,true)

cmd.add({"untpwalk"}, {"untpwalk", "Stops the tpwalk command"}, function()
	TPWalk = false
	if TPWalkingConnection then
		TPWalkingConnection:Disconnect()
		TPWalkingConnection = nil
	end
end)

cmd.add({"loopmute","loopmuteboombox"},{"loopmute <player> (loopmuteboombox)","Loop mutes the players boombox"},function(...)
	Username=(...)
	if Username=="all" or Username=="others" then
		Loopmute=true
		repeat wait()
			local players=Players:GetPlayers()
			for _,player in ipairs(players) do
				for _,object in ipairs(player.Character:GetDescendants()) do
					if object:IsA("Sound") and object.Playing then
						object:Stop()
					end
				end
				local backpack=player:FindFirstChildOfClass("Backpack")
				if backpack then
					for _,object in ipairs(backpack:GetDescendants()) do
						if object:IsA("Sound") and object.Playing then
							object:Stop()
						end
					end
				end
			end	
		until Loopmute==false
	else
		Loopmute=true
		local players=getPlr(Username)
		repeat wait()

			if players~=nil then
				for i,x in next,players.Character:GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
				for i,x in next,players:FindFirstChildOfClass("Backpack"):GetDescendants() do
					if x:IsA("Sound") and x.Playing==true then
						x.Playing=false
					end
				end
			end 
		until Loopmute==false
		if SoundService.RespectFilteringEnabled==true then



			wait();

			DoNotif("Boombox glitched. Status: Client Sided")
		else
			if SoundService.RespectFilteringEnabled==false then

				wait();

				DoNotif("Boombox glitched. Status: FE")
			end
		end
	end
end,true)


cmd.add({"unloopmute","unloopmuteboombox"},{"unloopmute <player> (unloopmuteboombox)","Unloop mutes the players boombox"},function()
	Loopmute=false
	wait();
	DoNotif("Unloopmuted everyone")
end)

cmd.add({"getmass"},{"getmass <player>","Get your mass"},function(...)
	target=getPlr(...)
	local mass=getRoot(target.Character).AssemblyMass 
	wait();

	DoNotif(target.Name.."'s mass is "..mass)
end,true)

cmd.add({"equiptools"},{"equiptools","Equips every tool in your inventory at once"},function()
	for i,v in pairs(Player:FindFirstChildOfClass("Backpack"):GetChildren()) do
		if v:IsA("Tool") or v:IsA("HopperBin") then
			v.Parent=Player.Character
		end
	end
end)

cmd.add({"unequiptools"},{"unequiptools","Unequips every tool you are currently holding at once"},function()
	Player.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
end)

cmd.add({"unloopfling"},{"unloopfling","Stops loop flinging a player"},function()
	Loopvoid=false
end)

cmd.add({"inspect"}, {"inspect", "checks a user's items"}, function(args)
	local targetPlayers = getPlr(args[1] or LocalPlayer)

	for _, playerName in ipairs(targetPlayers) do
		local player = Players:FindFirstChild(playerName)
		if player then
			GuiService:CloseInspectMenu()
			GuiService:InspectPlayerFromUserId(player.UserId)
		else
			DoNotif("Player not found: "..tostring(playerName))
		end
	end
end, true)

cmd.add({"noprompt","nopurchaseprompts","noprompts"},{"noprompt (nopurchaseprompts,noprompts)","remove the stupid purchase prompt"},function()
	wait();

	COREGUI.PurchasePrompt.Enabled=false

	DoNotif("Purchase prompts have been disabled")
end)

cmd.add({"prompt","purchaseprompts","showprompts","showpurchaseprompts"},{"prompt (purchaseprompts,showprompts,showpurchaseprompts)","allows the stupid purchase prompt"},function()
	wait();

	COREGUI.PurchasePrompt.Enabled=true

	DoNotif("Purchase prompts have been enabled")
end)

cmd.add({"wallwalk"},{"wallwalk","Makes you walk on walls"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/WallWalk.lua"))() -- backup cause i don't trust pastebin
end)

local hiddenGUIS = {}

cmd.add({"hideguis"}, {"hideguis", "Hides GUIs"}, function()
	for _, guiElement in pairs(PlrGui:GetDescendants()) do
		if (guiElement:IsA("Frame") or guiElement:IsA("ImageLabel") or guiElement:IsA("ScrollingFrame")) and guiElement.Visible then
			guiElement.Visible = false
			if not table.find(hiddenGUIS, guiElement) then
				table.insert(hiddenGUIS, guiElement)
			end
		end
	end
end)

cmd.add({"showguis"}, {"showguis", "Shows GUIs that were hidden using hideguis"}, function()
	for _, guiElement in pairs(hiddenGUIS) do
		guiElement.Visible = true
	end
	hiddenGUIS = {}
end)

local spinThingy = nil
local spinPart = nil

cmd.add({"spin"}, {"spin {amount}", "Makes your character spin as fast as you want"}, function(...)
	wait()

	local spinSpeed = (...)
	if not spinSpeed then spinSpeed = 20 end

	if spinThingy then
		spinThingy:Destroy()
		spinThingy = nil
	end

	if spinPart then
		spinPart:Destroy()
		spinPart = nil
	end

	spinPart = Instance.new("Part")
	spinPart.Name = "SpinPart"
	spinPart.Anchored = false
	spinPart.CanCollide = false
	spinPart.Transparency = 1
	spinPart.Size = Vector3.new(1, 1, 1)
	spinPart.Parent = workspace.CurrentCamera
	spinPart.CFrame = getRoot(LocalPlayer.Character).CFrame

	spinThingy = Instance.new("BodyAngularVelocity")
	spinThingy.Name = "NamelessSpinner"
	spinThingy.Parent = spinPart
	spinThingy.MaxTorque = Vector3.new(0, math.huge, 0)
	spinThingy.AngularVelocity = Vector3.new(0, spinSpeed, 0)

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = spinPart
	weld.Part1 = getRoot(LocalPlayer.Character)
	weld.Parent = spinPart

	DoNotif("Spinning...")
end, true)

cmd.add({"unspin"}, {"unspin", "Makes your character unspin"}, function()
	wait()

	if spinThingy then
		spinThingy:Destroy()
		spinThingy = nil
	end

	if spinPart then
		spinPart:Destroy()
		spinPart = nil
	end

	DoNotif("Spin Disabled", 3)
end)

cmd.add({"notepad"},{"notepad","notepad for making scripts / etc"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NAnotepad.lua"))()
end)

cmd.add({"rc7"},{"rc7","RC7 Internal UI"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/rc%20sexy%207"))()
end)

cmd.add({"scriptviewer","viewscripts"},{"scriptviewer (viewscripts)","Can view scripts made by 0866"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/scriptviewer",true))()
end)

cmd.add({"hydroxide","hydro"},{"hydroxide (hydro)","executes hydroxide"},function()
	if IsOnMobile then
		local owner="Hosvile"
		local branch="revision"

		function webImport(file)
			return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/MC-Hydroxide/%s/%s.lua"):format(owner,branch,file)),file..'.lua')()
		end

		webImport("init")
		webImport("ui/main")
	else
		local owner="Upbolt"
		local branch="revision"

		function webImport(file)
			return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner,branch,file)),file..'.lua')()
		end

		webImport("init")
		webImport("ui/main")
	end
end)

cmd.add({"remotespy","simplespy","rspy"},{"remotespy (simplespy,rspy)","executes simplespy that supports both pc and mobile"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/simplee%20spyyy%20mobilee"))()
end)

cmd.add({"turtlespy","tspy"},{"turtlespy (tspy)","executes Turtle Spy that supports both pc and mobile"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/Turtle%20Spy.lua"))()
end)

cmd.add({"gravity","grav"},{"gravity <amount> (grav)","sets game gravity to whatever u want"},function(...)
	SafeGetService("Workspace").Gravity=(...)
end,true)

cmd.add({"fireclickdetectors","fcd","firecd"},{"fireclickdetectors (fcd,firecd)","Fires every click detector that's in workspace"},function()
	local ccamount=0
	for _,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("ClickDetector") then
			ccamount=ccamount+1
			fireclickdetector(v)
		end
	end

	wait();

	DoNotif("Fired "..ccamount.." amount of click detectors")
end)

cmd.add({"noclickdetectorlimits","nocdlimits","removecdlimits"},{"noclickdetectorlimits <limit> (nocdlimits,removecdlimits)","Sets all click detectors MaxActivationDistance to math.huge"},function(...)
	for i,v in ipairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("ClickDetector") then
			if (...) == nil then
				v.MaxActivationDistance=math.huge
			else
				v.MaxActivationDistance=(...)
			end
		end
	end
end,true)

cmd.add({"noproximitypromptlimits","nopplimits","removepplimits"},{"noproximitypromptlimits <limit> (nopplimits,removepplimits)","Sets all proximity prompts MaxActivationDistance to math.huge"},function(...)
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			if (...) == nil then
				v.MaxActivationDistance=math.huge
			else
				v.MaxActivationDistance=(...)
			end
		end
	end
end,true)

local doIpp=nil

cmd.add({"instantproximityprompts","instantpp","ipp"},{"instantproximityprompts (instantpp,ipp)","Disable the cooldown for proximity prompts"},function()
	if doIpp then doIpp:Disconnect() doIpp=nil end
	doIpp=ProximityPromptService.PromptButtonHoldBegan:Connect(function(pp)
		fireproximityprompt(pp,1)
	end)
end)

cmd.add({"uninstantproximityprompts","uninstantpp","unipp"},{"uninstantproximityprompts (uninstantpp,unipp)","Undo the cooldown removal"},function()
	if doIpp then doIpp:Disconnect() doIpp=nil end
end)

cmd.add({"light"}, {"light <range> <brightness>", "Gives your player dynamic light"}, function(range, brightness)
	range = tonumber(range) or 30
	brightness = tonumber(brightness) or 1

	local light = Instance.new("PointLight")
	light.Parent = getRoot(Player.Character)
	light.Range = range
	light.Brightness = brightness
end, true)

cmd.add({"unlight", "nolight"}, {"unlight (nolight)", "Removes dynamic light from your player"}, function()
	for _, descendant in pairs(Player.Character:GetDescendants()) do
		if descendant:IsA("PointLight") then
			descendant:Destroy()
		end
	end
end)

cmd.add({"lighting", "lightingcontrol"}, {"lighting (lightingcontrol)", "Manage lighting technology settings"}, function()
	local lightingButtons = {}
	for _, lightingType in ipairs(Enum.Technology:GetEnumItems()) do
		table.insert(lightingButtons, {
			Text = lightingType.Name,
			Callback = function()
				Lighting.Technology = lightingType
			end
		})
	end

	table.insert(lightingButtons, {
		Text = "Cancel",
		Callback = function() end
	})

	Notify({
		Title = "Lighting Technology Options",
		Buttons = lightingButtons
	})
end)

cmd.add({"tweengotocampos","tweentocampos","tweentcp"},{"tweengotocampos (tweentcp)","Another version of goto camera position but bypassing more anti-cheats"},function()
	local player=Players.LocalPlayer
	local UserInputService=UserInputService
	local TweenService=TweenService

	function teleportPlayer()
		local character=player.Character or player.CharacterAdded:wait(1)
		local camera=SafeGetService("Workspace").CurrentCamera
		local cameraPosition=camera.CFrame.Position

		local tween=TweenService:Create(character.PrimaryPart,TweenInfo.new(2),{
			CFrame=CFrame.new(cameraPosition)
		})

		tween:Play()
	end


	local camera=SafeGetService("Workspace").CurrentCamera
	repeat wait() until camera.CFrame~=CFrame.new()

	teleportPlayer()

end)

cmd.add({"delete", "remove", "del"}, {"delete {partname} (remove, del)", "Removes any part with a certain name from the workspace"}, function(...)
	local deleteCount = 0
	local args = {...}
	local targetName = table.concat(args, " ")

	for _, descendant in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if descendant.Name:lower() == targetName:lower() then
			descendant:Destroy()
			deleteCount = deleteCount + 1
		end
	end

	wait()

	if deleteCount > 0 then
		DoNotif("Deleted "..deleteCount.." instance(s) of '"..targetName.."'", 2.5)
	else
		DoNotif("'"..targetName.."' not found to delete", 2.5)
	end
end, true)

local autoRemover = {}
local autoRemoveConnection = nil

function handleDescendantAdd(part)
	if #autoRemover > 0 then
		if FindInTable(autoRemover, part.Name:lower()) then
			wait()
			part:Destroy()
		end
	else
		if autoRemoveConnection then
			autoRemoveConnection:Disconnect()
			autoRemoveConnection = nil
		end
	end
end

cmd.add({"autodelete", "autoremove", "autodel"}, {"autodelete {partname} (autoremove, autodel)", "Removes any part with a certain name from the workspace on loop"}, function(...)
	local args = {...}
	local targetName = table.concat(args, " "):lower()

	if not FindInTable(autoRemover, targetName) then
		table.insert(autoRemover, targetName)
		for _, part in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if part.Name:lower() == targetName then
				part:Destroy()
			end
		end
	end

	if not autoRemoveConnection then
		autoRemoveConnection = SafeGetService("Workspace").DescendantAdded:Connect(handleDescendantAdd)
	end

	wait()
	DoNotif("Auto deleting instances with name: "..targetName, 2.5)
end, true)

cmd.add({"unautodelete", "unautoremove", "unautodel"}, {"unautodelete {partname} (unautoremove, unautodel)", "Disables autodelete"}, function()
	if autoRemoveConnection then
		autoRemoveConnection:Disconnect()
		autoRemoveConnection = nil
	end
	autoRemover = {}
end)

cmd.add({"deleteclass", "removeclass", "dc"}, {"deleteclass {ClassName} (removeclass, dc)", "Removes any part with a certain classname from the workspace"}, function(...)
	local args = {...}
	local targetClass = args[1]:lower()
	local deleteCount = 0

	for _, part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part.ClassName:lower() == targetClass then
			part:Destroy()
			deleteCount = deleteCount + 1
		end
	end

	wait()
	if deleteCount > 0 then
		DoNotif("Deleted "..deleteCount.." instance(s) of class: "..targetClass, 2.5)
	else
		DoNotif("No instances of class: "..targetClass.." found to delete", 2.5)
	end
end, true)

local autoClassRemover = {}
local autoClassConnection = nil

function handleClassDescendantAdd(part)
	if #autoClassRemover > 0 then
		if FindInTable(autoClassRemover, part.ClassName:lower()) then
			wait()
			part:Destroy()
		end
	else
		if autoClassConnection then
			autoClassConnection:Disconnect()
			autoClassConnection = nil
		end
	end
end

cmd.add({"autodeleteclass", "autoremoveclass", "autodc"}, {"autodeleteclass {ClassName} (autoremoveclass, autodc)", "Removes any part with a certain classname from the workspace on loop"}, function(...)
	local args = {...}
	local targetClass = args[1]:lower()

	if not FindInTable(autoClassRemover, targetClass) then
		table.insert(autoClassRemover, targetClass)
		for _, part in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if part.ClassName:lower() == targetClass then
				part:Destroy()
			end
		end
	end

	if not autoClassConnection then
		autoClassConnection = SafeGetService("Workspace").DescendantAdded:Connect(handleClassDescendantAdd)
	end

	wait()
	DoNotif("Auto deleting instances with class: "..targetClass, 2.5)
end, true)

cmd.add({"unautodeleteclass", "unautoremoveclass", "unautodc"}, {"unautodeleteclass {ClassName} (unautoremoveclass, unautodc)", "Disables autodeleteclass"}, function()
	if autoClassConnection then
		autoClassConnection:Disconnect()
		autoClassConnection = nil
	end
	autoClassRemover = {}
end)

cmd.add({"chardelete", "charremove", "chardel", "cdelete", "cremove", "cdel"}, {"chardelete {partname} (charremove, chardel, cdelete, cremove, cdel)", "Removes any part with a certain name from your character"}, function(...)
	local args = {...}
	local targetName = table.concat(args, " "):lower()
	local deleteCount = 0

	for _, part in pairs(Player.Character:GetDescendants()) do
		if part.Name:lower() == targetName then
			part:Destroy()
			deleteCount = deleteCount + 1
		end
	end

	wait()
	if deleteCount > 0 then
		DoNotif("Deleted "..deleteCount.." instance(s) of '"..targetName.."' inside the character", 2.5)
	else
		DoNotif("'"..targetName.."' not found in the character", 2.5)
	end
end, true)

cmd.add({"chardeleteclass", "charremoveclass", "chardeleteclassname", "cdc"}, {"chardeleteclass {ClassName} (charremoveclass, chardeleteclassname, cdc)", "Removes any part with a certain classname from your character"}, function(...)
	local args = {...}
	local targetClass = args[1]:lower()
	local deleteCount = 0

	for _, part in pairs(Player.Character:GetDescendants()) do
		if part.ClassName:lower() == targetClass then
			part:Destroy()
			deleteCount = deleteCount + 1
		end
	end

	wait()
	if deleteCount > 0 then
		DoNotif("Deleted "..deleteCount.." instance(s) of class: "..targetClass.." inside the character", 2.5)
	else
		DoNotif("No instances of class: "..targetClass.." found in the character", 2.5)
	end
end, true)

cmd.add({"gotopart", "topart", "toprt"}, {"gotopart {partname} (topart, toprt)", "Teleports you to a part by name"}, function(...)
	local partName = table.concat({...}, " "):lower()

	for _, part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower() == partName then
			if getHum() then
				getHum().Sit = false
				wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(part:GetPivot())
			end
			wait(0.2)
		end
	end
end, true)

cmd.add({"tweengotopart", "tgotopart", "ttopart", "ttoprt"}, {"tweengotopart {partname} (tgotopart, ttopart, ttoprt)", "Tweens your character to a part by name"}, function(...)
	local partName = table.concat({...}, " "):lower()

	for _, part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower() == partName then
			if getHum() then
				getHum().Sit = false
				wait(0.1)
			end
			TweenService:Create(
				getRoot(getChar()),
				TweenInfo.new(1, Enum.EasingStyle.Linear),
				{CFrame = part.CFrame}
			):Play()
			wait(1)
		end
	end
end, true)

cmd.add({"gotopartclass", "gpc", "gotopartc", "gotoprtc"}, {"gotopartclass {classname} (gpc, gotopartc, gotoprtc)", "Teleports you to a part by classname"}, function(...)
	local className = ({...})[1]:lower()

	for _, part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.ClassName:lower() == className then
			if getHum() then
				getHum().Sit = false
				wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(part:GetPivot())
			end
			wait(0.2)
		end
	end
end, true)

cmd.add({"bringpart", "bpart", "bprt"}, {"bringpart {partname} (bpart, bprt)", "Brings a part to your character by name"}, function(...)
	local partName = table.concat({...}, " "):lower()

	for _, part in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower() == partName then
			if getChar() then
				part:PivotTo(getChar():GetPivot())
			end
		end
	end
end, true)

cmd.add({"bringmodel", "bmodel"}, {"bringmodel {modelname} (bmodel)", "Brings a model to your character by name"}, function(...)
	local modelName = table.concat({...}, " "):lower()

	for _, model in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if model:IsA("Model") and model.Name:lower() == modelName then
			if getChar() then
				model:PivotTo(getChar():GetPivot())
			end
		end
	end
end, true)

cmd.add({"gotomodel", "tomodel"}, {"gotomodel {modelname} (tomodel)", "Teleports you to a model by name"}, function(...)
	local modelName = table.concat({...}, " "):lower()

	for _, model in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if model:IsA("Model") and model.Name:lower() == modelName then
			if getHum() then
				getHum().Sit = false
				wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(model:GetPivot())
			end
			wait(0.2)
		end
	end
end, true)

function setHumanoidStates(humanoid, stateEnabled)
	local states = {
		Enum.HumanoidStateType.Climbing,
		Enum.HumanoidStateType.FallingDown,
		Enum.HumanoidStateType.Flying,
		Enum.HumanoidStateType.Freefall,
		Enum.HumanoidStateType.GettingUp,
		Enum.HumanoidStateType.Jumping,
		Enum.HumanoidStateType.Landed,
		Enum.HumanoidStateType.Physics,
		Enum.HumanoidStateType.PlatformStanding,
		Enum.HumanoidStateType.Ragdoll,
		Enum.HumanoidStateType.Running,
		Enum.HumanoidStateType.RunningNoPhysics,
		Enum.HumanoidStateType.Seated,
		Enum.HumanoidStateType.StrafingNoPhysics,
		Enum.HumanoidStateType.Swimming
	}

	for _, state in ipairs(states) do
		humanoid:SetStateEnabled(state, stateEnabled)
	end
end

local originalGravity = SafeGetService("Workspace").Gravity

cmd.add({"swim"}, {"swim {speed}", "Swim in the air"}, function(speed)
	local player = Players.LocalPlayer
	local humanoid = getHum()

	if humanoid then
		SafeGetService("Workspace").Gravity = 3.5
		setHumanoidStates(humanoid, false)
		humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
		humanoid.WalkSpeed = speed or 16
	else
		warn("Humanoid not found!")
	end
end, true)

cmd.add({"unswim"}, {"unswim", "Stops the swim script"}, function()
	local player = Players.LocalPlayer
	local humanoid = getHum()

	if humanoid then
		SafeGetService("Workspace").Gravity = originalGravity
		setHumanoidStates(humanoid, true)
		humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		humanoid.WalkSpeed = 16
	end
end)

local espList = {}
local partTrigger = nil
local espTriggers = {}

function createBox(part, color, transparency)
	local box = Instance.new("BoxHandleAdornment")
	box.Name = part.Name:lower().."_ESP"
	box.Parent = part
	box.Adornee = part
	box.AlwaysOnTop = true
	box.ZIndex = 0
	box.Size = part:IsA("BasePart") and part.Size or Vector3.new(4, 4, 4)
	box.Transparency = transparency or 0.45
	box.Color3 = color
	return box
end

function onPartAdded(part)
	if #espList > 0 then
		if table.find(espList, part.Name:lower()) then
			if part:IsA("BasePart") or part:IsA("Model") then
				createBox(part, Color3.fromRGB(50, 205, 50), 0.45)
			end
		end
	else
		if partTrigger then
			partTrigger:Disconnect()
			partTrigger = nil
		end
	end
end

function enableEsp(objType, color)
	for _, obj in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if obj:IsA(objType) then
			local parent = obj.Parent
			if parent and parent:IsA("BasePart") then
				createBox(parent, color, 0.45)
			end
		end
	end

	if not espTriggers[objType] then
		espTriggers[objType] = SafeGetService("Workspace").DescendantAdded:Connect(function(obj)
			if obj:IsA(objType) then
				local parent = obj.Parent
				if parent and parent:IsA("BasePart") then
					createBox(parent, color, 0.45)
				end
			end
		end)
	end
end

function disableEsp(objType)
	if espTriggers[objType] then
		espTriggers[objType]:Disconnect()
		espTriggers[objType] = nil
	end

	for _, obj in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if obj:IsA("BoxHandleAdornment") and obj.Name:sub(-4) == "_ESP" then
			local adornee = obj.Adornee
			if adornee and adornee:FindFirstChildOfClass(objType) then
				obj:Destroy()
			end
		end
	end
end

cmd.add({"pesp", "esppart", "partesp"}, {"pesp {partname} (esppart, partesp)", "Highlights specific parts by name"}, function(...)
	local args = {...}
	local partName = table.concat(args, " "):lower()

	if not table.find(espList, partName) then
		table.insert(espList, partName)

		for _, obj in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if obj.Name:lower() == partName then
				if obj:IsA("BasePart") or obj:IsA("Model") then
					createBox(obj, Color3.fromRGB(50, 205, 50), 0.45)
				end
			end
		end
	end

	if not partTrigger then
		partTrigger = SafeGetService("Workspace").DescendantAdded:Connect(onPartAdded)
	end
end, true)

cmd.add({"unpesp", "unesppart", "unpartesp"}, {"unpesp (unesppart, unpartesp)", "Removes ESP from specific parts added by pesp"}, function()
	for _, obj in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if obj:IsA("BoxHandleAdornment") and obj.Name:sub(-4) == "_ESP" then
			local adornee = obj.Adornee
			if adornee and table.find(espList, adornee.Name:lower()) then
				obj:Destroy()
			end
		end
	end

	espList = {}

	if partTrigger then
		partTrigger:Disconnect()
		partTrigger = nil
	end
end)

cmd.add({"touchesp", "tesp"}, {"touchesp (tesp)", "Highlights parts with TouchTransmitter"}, function()
	enableEsp("TouchTransmitter", Color3.fromRGB(255, 0, 0))
end)

cmd.add({"untouchesp", "untesp"}, {"untouchesp (untesp)", "Removes ESP from parts with TouchTransmitter"}, function()
	disableEsp("TouchTransmitter")
end)

cmd.add({"proximityesp", "prxesp", "proxiesp"}, {"proximityesp (prxesp, proxiesp)", "Highlights parts with ProximityPrompt"}, function()
	enableEsp("ProximityPrompt", Color3.fromRGB(0, 0, 255))
end)

cmd.add({"unproximityesp", "unprxesp", "unproxiesp"}, {"unproximityesp (unprxesp, unproxiesp)", "Removes ESP from parts with ProximityPrompt"}, function()
	disableEsp("ProximityPrompt")
end)

cmd.add({"clickesp", "cesp"}, {"clickesp (cesp)", "Highlights parts with ClickDetector"}, function()
	enableEsp("ClickDetector", Color3.fromRGB(255, 165, 0))
end)

cmd.add({"unclickesp", "uncesp"}, {"unclickesp (uncesp)", "Removes ESP from parts with ClickDetector"}, function()
	disableEsp("ClickDetector")
end)

cmd.add({"viewpart", "viewp", "vpart"}, {"viewpart {partname} (viewp, vpart)", "Views a part"}, function(...)
	local args = table.concat({...}, " "):lower()
	local camera = SafeGetService("Workspace").CurrentCamera

	for _, descendant in ipairs(SafeGetService("Workspace"):GetDescendants()) do
		if descendant.Name:lower() == args then
			if descendant:IsA("BasePart") then
				camera.CameraSubject = descendant
				return
			elseif descendant:IsA("Model") or descendant:IsA("Folder") then
				for _, child in ipairs(descendant:GetDescendants()) do
					if child:IsA("BasePart") then
						camera.CameraSubject = child
						return
					end
				end
			end
		end
	end
end, true)

cmd.add({"unviewpart", "unviewp"}, {"unviewpart (unviewp)", "Unviews the part"}, function()
	SafeGetService("Workspace").CurrentCamera.CameraSubject = getHum()
end)

cmd.add({"console"},{"console","Opens developer console"},function()
	StarterGui:SetCore("DevConsoleVisible",true)
end)

local isHitboxActive = false

cmd.add({"hitbox", "hbox"}, {"hitbox {amount}", "Modifies everyone's hitbox to the specified size"}, function(playerName, size)
	if isHitboxActive then
		isHitboxActive = false
	end

	local targetPlayer = getPlr(playerName)
	_G.HeadSize = size or 10
	_G.Disabled = true
	isHitboxActive = true

	local function modifyHitbox(character)
		local rootPart = getRoot(character)
		rootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
		rootPart.Transparency = 0.9
		rootPart.BrickColor = BrickColor.new("Really black")
		rootPart.Material = "Neon"
		rootPart.CanCollide = false
	end

	RunService.Stepped:Connect(function()
		if isHitboxActive then
			if playerName == "all" or playerName == "others" then
				for _, player in ipairs(SafeGetService('Players'):GetPlayers()) do
					if player.Name ~= SafeGetService('Players').LocalPlayer.Name then
						modifyHitbox(player.Character)
					end
				end
			else
				modifyHitbox(targetPlayer.Character)
			end
		end
	end)
end, true)

cmd.add({"unhitbox", "unhbox"}, {"unhitbox", "Disables hitbox modifications"}, function(playerName)
	local targetPlayer = getPlr(playerName)
	_G.HeadSize = 5
	_G.Disabled = false
	isHitboxActive = false

	local function resetHitbox(character)
		local rootPart = getRoot(character)
		rootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
		rootPart.Transparency = 1
		rootPart.BrickColor = BrickColor.new("Really black")
		rootPart.Material = "Neon"
		rootPart.CanCollide = false
	end

	if playerName == "all" or playerName == "others" then
		for _, player in ipairs(SafeGetService('Players'):GetPlayers()) do
			if player.Name ~= SafeGetService('Players').LocalPlayer.Name then
				resetHitbox(player.Character)
			end
		end
	else
		resetHitbox(targetPlayer.Character)
	end
end)

cmd.add({"breakcars", "bcars"}, {"breakcars (bcars)", "Breaks any car"}, function()
	DoNotif("Car breaker loaded, sit on a vehicle and be the driver")

	local UserInputService = UserInputService
	local Mouse = Players.LocalPlayer:GetMouse()
	local Workspace = SafeGetService("Workspace")
	local Folder = Instance.new("Folder", Workspace)
	local Part = Instance.new("Part", Folder)
	local Attachment1 = Instance.new("Attachment", Part)

	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1

	local UpdatedPosition = Mouse.Hit + Vector3.new(0, 5, 0)

	local function setupNetworkAccess()
		settings().Physics.AllowSleep = false
		while RunService.RenderStepped:Wait() do
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= Players.LocalPlayer then
					player.MaximumSimulationRadius = 0
					sethiddenproperty(player, "SimulationRadius", 0)
				end
			end
			Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
			setsimulationradius(math.huge)
		end
	end

	coroutine.wrap(setupNetworkAccess)()

	local function applyForceToPart(part)
		if part:IsA("Part") and not part.Anchored and not part.Parent:FindFirstChild("Humanoid") and not part.Parent:FindFirstChild("Head") and part.Name ~= "Handle" then
			Mouse.TargetFilter = part

			for _, child in ipairs(part:GetChildren()) do
				if child:IsA("BodyAngularVelocity") or child:IsA("BodyForce") or child:IsA("BodyGyro") or child:IsA("BodyPosition") or child:IsA("BodyThrust") or child:IsA("BodyVelocity") or child:IsA("RocketPropulsion") then
					child:Destroy()
				end
			end

			if part:FindFirstChild("Attachment") then
				part:FindFirstChild("Attachment"):Destroy()
			end
			if part:FindFirstChild("AlignPosition") then
				part:FindFirstChild("AlignPosition"):Destroy()
			end
			if part:FindFirstChild("Torque") then
				part:FindFirstChild("Torque"):Destroy()
			end

			part.CanCollide = false

			local torque = Instance.new("Torque", part)
			torque.Torque = Vector3.new(100000, 100000, 100000)

			local alignPosition = Instance.new("AlignPosition", part)
			local attachment2 = Instance.new("Attachment", part)

			torque.Attachment0 = attachment2
			alignPosition.MaxForce = math.huge
			alignPosition.MaxVelocity = math.huge
			alignPosition.Responsiveness = 200
			alignPosition.Attachment0 = attachment2
			alignPosition.Attachment1 = Attachment1
		end
	end

	for _, descendant in ipairs(Workspace:GetDescendants()) do
		applyForceToPart(descendant)
	end

	Workspace.DescendantAdded:Connect(function(descendant)
		applyForceToPart(descendant)
	end)

	UserInputService.InputBegan:Connect(function(input, isChatting)
		if input.KeyCode == Enum.KeyCode.E and not isChatting then
			UpdatedPosition = Mouse.Hit + Vector3.new(0, 5, 0)
		end
	end)

	spawn(function()
		while RunService.RenderStepped:Wait() do
			Attachment1.WorldCFrame = UpdatedPosition
		end
	end)
end)

cmd.add({"firetouchinterests", "fti"}, {"firetouchinterests (fti)", "Fires every Touch Interest that's in workspace"}, function()
	touchInterestCount = 0

	for _, descendant in ipairs(SafeGetService("Workspace"):GetDescendants()) do
		if descendant:IsA("TouchTransmitter") then
			touchInterestCount = touchInterestCount + 1

			task.spawn(function()
				firetouchinterest(getRoot(getChar()), descendant.Parent, 0) -- 0 is touch
				task.wait()
				firetouchinterest(getRoot(getChar()), descendant.Parent, 1) -- 1 is untouch
			end)

			local part = descendant:FindFirstAncestorWhichIsA("BasePart")
			if part then
				task.wait()
				local originalCFrame = part.CFrame
				part.CFrame = getRoot(getChar()).CFrame
				task.delay(0.1, function()
					part.CFrame = originalCFrame
				end)
			end
		end
	end

	wait()

	DoNotif("Fired "..touchInterestCount.." touch interests")
end)

local infJump = nil
local jumpFixy = nil

cmd.add({"infjump", "infinitejump"}, {"infjump (infinitejump)", "Makes you be able to jump infinitely"}, function()
	wait()

	DoNotif("Infinite Jump Enabled")

	local lastJumpTime = 0
	local jumpCooldown = 0.25

	local function fix()
		if infJump then
			infJump:Disconnect()
			infJump = nil
		end

		local hum = getHum()
		if not hum then
			local char = plr.Character or plr.CharacterAdded:Wait()
			hum = char:WaitForChild("Humanoid")
		end

		infJump = hum:GetPropertyChangedSignal("Jump"):Connect(function()
			if tick() - lastJumpTime > jumpCooldown then
				lastJumpTime = tick()
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	end

	fix()

	if jumpFixy then
		jumpFixy:Disconnect()
		jumpFixy = nil
	end

	jumpFixy = plr.CharacterAdded:Connect(fix)
end)

cmd.add({"uninfjump", "uninfinitejump"}, {"uninfjump (uninfinitejump)", "Makes you NOT be able to infinitely jump"}, function()
	wait()

	DoNotif("Infinite Jump Disabled", 3)

	if infJump then
		infJump:Disconnect()
		infJump = nil
	end

	if jumpFixy then
		jumpFixy:Disconnect()
		jumpFixy = nil
	end
end)

local flyjump=nil

cmd.add({"flyjump"},{"flyjump","Allows you to hold space to fly up"},function()

	wait();

	DoNotif("FlyJump Enabled",3)


	if flyjump then flyjump:Disconnect() end
	flyjump=UserInputService.JumpRequest:Connect(function()
		Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end)

cmd.add({"unflyjump","noflyjump"},{"unflyjump (noflyjump)","Disables flyjump"},function()

	wait();

	DoNotif("FlyJump Disabled",3)


	if flyjump then flyjump:Disconnect() end
end)

cmd.add({"xray","xrayon"},{"xray (xrayon)","Makes you be able to see through walls"},function()
	wait();

	DoNotif("Xray enabled")
	x(true)
end)

cmd.add({"unxray","xrayoff"},{"unxray (xrayoff)","Makes you not be able to see through walls"},function()
	wait();

	DoNotif("Xray disabled")
	x(false)
end)

cmd.add({"pastebinscraper","pastebinscrape"},{"pastebinscraper (pastebinscrape)","Scrapes paste bin posts"},function()
	wait();

	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/trash(paste)bin%20scrapper"))()
	COREGUI.Scraper["Pastebin Scraper"].BackgroundTransparency=0.5
	COREGUI.Scraper["Pastebin Scraper"].TextButton.Text="             ⭐ Pastebin Post Scraper ⭐"
	COREGUI.Scraper["Pastebin Scraper"].Content.Search.PlaceholderText="Search for a post here..."
	COREGUI.Scraper["Pastebin Scraper"].Content.Search.BackgroundTransparency=0.4
	DoNotif("Pastebin scraper loaded")
end)

cmd.add({"fullbright","fullb","fb"},{"fullbright (fullb,fb)","Makes games that are really dark to have no darkness and be really light"},function()
	if not _G.FullBrightExecuted then

		_G.FullBrightEnabled=false

		_G.NormalLightingSettings={
			Brightness=Lighting.Brightness,
			ClockTime=Lighting.ClockTime,
			FogEnd=Lighting.FogEnd,
			GlobalShadows=Lighting.GlobalShadows,
			Ambient=Lighting.Ambient
		}

		Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
			if Lighting.Brightness~=1 and Lighting.Brightness~=_G.NormalLightingSettings.Brightness then
				_G.NormalLightingSettings.Brightness=Lighting.Brightness
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				Lighting.Brightness=1
			end
		end)

		Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
			if Lighting.ClockTime~=12 and Lighting.ClockTime~=_G.NormalLightingSettings.ClockTime then
				_G.NormalLightingSettings.ClockTime=Lighting.ClockTime
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				Lighting.ClockTime=12
			end
		end)

		Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
			if Lighting.FogEnd~=786543 and Lighting.FogEnd~=_G.NormalLightingSettings.FogEnd then
				_G.NormalLightingSettings.FogEnd=Lighting.FogEnd
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				Lighting.FogEnd=786543
			end
		end)

		Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
			if Lighting.GlobalShadows~=false and Lighting.GlobalShadows~=_G.NormalLightingSettings.GlobalShadows then
				_G.NormalLightingSettings.GlobalShadows=Lighting.GlobalShadows
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				Lighting.GlobalShadows=false
			end
		end)

		Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
			if Lighting.Ambient~=Color3.fromRGB(178,178,178) and Lighting.Ambient~=_G.NormalLightingSettings.Ambient then
				_G.NormalLightingSettings.Ambient=Lighting.Ambient
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				Lighting.Ambient=Color3.fromRGB(178,178,178)
			end
		end)

		Lighting.Brightness=1
		Lighting.ClockTime=12
		Lighting.FogEnd=786543
		Lighting.GlobalShadows=false
		Lighting.Ambient=Color3.fromRGB(178,178,178)

		local LatestValue=true
		spawn(function()
			repeat
				wait()
			until _G.FullBrightEnabled
			while wait() do
				if _G.FullBrightEnabled~=LatestValue then
					if not _G.FullBrightEnabled then
						Lighting.Brightness=_G.NormalLightingSettings.Brightness
						Lighting.ClockTime=_G.NormalLightingSettings.ClockTime
						Lighting.FogEnd=_G.NormalLightingSettings.FogEnd
						Lighting.GlobalShadows=_G.NormalLightingSettings.GlobalShadows
						Lighting.Ambient=_G.NormalLightingSettings.Ambient
					else
						Lighting.Brightness=1
						Lighting.ClockTime=12
						Lighting.FogEnd=786543
						Lighting.GlobalShadows=false
						Lighting.Ambient=Color3.fromRGB(178,178,178)
					end
					LatestValue=not LatestValue
				end
			end
		end)
	end

	_G.FullBrightExecuted=true
	_G.FullBrightEnabled=not _G.FullBrightEnabled
end)

local dayCon=nil

cmd.add({"loopday","lday"},{"loopday (lday)","Sunshiiiine!"},function()
	if dayCon then
		dayCon:Disconnect()
	end

	Lighting.ClockTime = 14

	dayCon=Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
		if Lighting.ClockTime ~= 14 then
			Lighting.ClockTime = 14
		end
	end)
end)

cmd.add({"unloopday","unlday"},{"unloopday (unlday)","No more sunshine"},function()
	if dayCon then
		dayCon:Disconnect()
	end
end)

fbCon, fbCon1, fbCon2, fbCon3, fbCon4 = nil, nil, nil, nil, nil
nightCon, nightCon1, nightCon2, nightCon3, nightCon4 = nil, nil, nil, nil, nil

cmd.add({"loopfullbright", "loopfb", "lfb"}, {"loopfullbright (loopfb,lfb)", "Sunshiiiine!"}, function()
	if fbCon then fbCon:Disconnect() end
	if fbCon1 then fbCon1:Disconnect() end
	if fbCon2 then fbCon2:Disconnect() end
	if fbCon3 then fbCon3:Disconnect() end
	if fbCon4 then fbCon4:Disconnect() end

	Lighting.Brightness = 1
	Lighting.ClockTime = 12
	Lighting.FogEnd = 786543
	Lighting.GlobalShadows = false
	Lighting.Ambient = Color3.fromRGB(178, 178, 178)

	fbCon = Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
		if Lighting.Brightness ~= 1 then
			Lighting.Brightness = 1
		end
	end)
	fbCon1 = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
		if Lighting.ClockTime ~= 12 then
			Lighting.ClockTime = 12
		end
	end)
	fbCon2 = Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
		if Lighting.FogEnd ~= 786543 then
			Lighting.FogEnd = 786543
		end
	end)
	fbCon3 = Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
		if Lighting.GlobalShadows ~= false then
			Lighting.GlobalShadows = false
		end
	end)
	fbCon4 = Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
		if Lighting.Ambient ~= Color3.fromRGB(178, 178, 178) then
			Lighting.Ambient = Color3.fromRGB(178, 178, 178)
		end
	end)
end)

cmd.add({"unloopfullbright", "unloopfb", "unlfb"}, {"unloopfullbright (unloopfb,unlfb)", "No more sunshine"}, function()
	if fbCon then fbCon:Disconnect() end
	if fbCon1 then fbCon1:Disconnect() end
	if fbCon2 then fbCon2:Disconnect() end
	if fbCon3 then fbCon3:Disconnect() end
	if fbCon4 then fbCon4:Disconnect() end
end)

cmd.add({"loopnight", "loopn", "ln"}, {"loopnight (loopn,ln)", "Moonlight."}, function()
	if nightCon then nightCon:Disconnect() end
	if nightCon1 then nightCon1:Disconnect() end
	if nightCon2 then nightCon2:Disconnect() end
	if nightCon3 then nightCon3:Disconnect() end
	if nightCon4 then nightCon4:Disconnect() end

	Lighting.Brightness = 1
	Lighting.ClockTime = 0
	Lighting.FogEnd = 786543
	Lighting.GlobalShadows = false
	Lighting.Ambient = Color3.fromRGB(178, 178, 178)

	nightCon = Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
		if Lighting.Brightness ~= 1 then
			Lighting.Brightness = 1
		end
	end)
	nightCon1 = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
		if Lighting.ClockTime ~= 0 then
			Lighting.ClockTime = 0
		end
	end)
	nightCon2 = Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
		if Lighting.FogEnd ~= 786543 then
			Lighting.FogEnd = 786543
		end
	end)
	nightCon3 = Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
		if Lighting.GlobalShadows ~= false then
			Lighting.GlobalShadows = false
		end
	end)
	nightCon4 = Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
		if Lighting.Ambient ~= Color3.fromRGB(178, 178, 178) then
			Lighting.Ambient = Color3.fromRGB(178, 178, 178)
		end
	end)
end)

cmd.add({"unloopnight", "unloopn", "unln"}, {"unloopnight (unloopn,unln)", "No more moonlight."}, function()
	if nightCon then nightCon:Disconnect() end
	if nightCon1 then nightCon1:Disconnect() end
	if nightCon2 then nightCon2:Disconnect() end
	if nightCon3 then nightCon3:Disconnect() end
	if nightCon4 then nightCon4:Disconnect() end
end)

fogLoop=nil
fogCon=nil

cmd.add({"loopnofog","lnofog","lnf", "loopnf"},{"loopnofog (lnofog,lnf,loopnf)","See clearly forever!"},function()
	local Lighting=Lighting
	if fogLoop then
		fogLoop:Disconnect()
	end
	if fogCon then
		fogCon:Disconnect()
	end
	Lighting.FogEnd=786543
	function fogFunc()
		for i,v in pairs(Lighting:GetDescendants()) do
			if v:IsA("Atmosphere") then
				v:Destroy()
			end
		end
	end
	fogCon=Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
		if Lighting.FogEnd~=786543 then
			Lighting.FogEnd=786543
		end
	end)

	fogLoop = RunService.RenderStepped:Connect(fogFunc)
end)

cmd.add({"unloopnofog","unlnofog","unlnf","unloopnf"},{"unloopnofog (unlnofog,unlnf,unloopnf)","No more sight."},function()
	if fogLoop then
		fogLoop:Disconnect()
	end
	if fogCon then
		fogCon:Disconnect()
	end
end)

cmd.add({"brightness"},{"brightness","Changes the brightness lighting property"},function(...)
	Lighting.Brightness=(...)
end,true)

cmd.add({"globalshadows","gshadows"},{"globalshadows (gshadows)","Enables global shadows"},function()
	Lighting.GlobalShadows=true
end)

cmd.add({"unglobalshadows","nogshadows","ungshadows","noglobalshadows"},{"unglobalshadows (nogshadows,ungshadows,noglobalshadows)","Disables global shadows"},function()
	Lighting.GlobalShadows=false
end)

cmd.add({"fireproximityprompts","fpp","firepp"},{"fireproximityprompts (fpp,firepp)","Fires every Proximity Prompt that's in workspace"},function()
	fppamount=0
	for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			fppamount=fppamount+1
			fireproximityprompt(v,1)
		end
	end


	wait();

	DoNotif("Fired "..fppamount.." of proximity prompts")
end)

cmd.add({"unsuspendvc", "fixvc", "rejoinvc", "restorevc"},{"unsuspendvc (fixvc, rejoinvc, restorevc)","allows you to use Voice Chat again"},function(...)
	SafeGetService("VoiceChatService"):joinVoice()
end)

--[[cmd.add({"iy"},{"iy {command}","Executes infinite yield scripts"},function(...)
	if IYLOADED==false then
		function copytable(tbl) local copy={} for i,v in pairs(tbl) do copy[i]=v end return copy end
		local sandbox_env=copytable(getfenv())
		setmetatable(sandbox_env,{
			__index=function(self,i)
				if rawget(sandbox_env,i) then
					return rawget(sandbox_env,i)
				elseif getfenv()[i] then
					return getfenv()[i]
				end
			end
		})
		sandbox_env.game=nil
		iy,_=game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"):gsub("local Main","Main"):gsub("Players.LocalPlayer.Chatted","Funny=Players.LocalPlayer.Chatted"):gsub("local lastMessage","notify=_G.notify\nlocal lastMessage")
		setfenv(loadstring(iy),sandbox_env)()
		iy_cmds_table=sandbox_env.CMDs
		iy_gui=sandbox_env.Main
		iy_chathandler=sandbox_env.Funny
		execCmd=sandbox_env.execCmd
		iy_gui:Destroy()
		pcall(function()
			iy_chathandler:Disconnect()
		end)
		IYLOADED=true
	end
	execCmd((...))
end,true)]]

cmd.add({"firstp","1stp","firstperson","fp"},{"firstperson (1stp,firstp,fp)","Makes you go in first person mode"},function()
	Player.CameraMode="LockFirstPerson"
end)

cmd.add({"thirdp","3rdp","thirdperson"},{"thirdperson (3rdp,thirdp)","Makes you go in third person mode"},function()
	Player.CameraMaxZoomDistance=math.huge
	Player.CameraMode="Classic"
end)

cmd.add({"maxzoom"},{"maxzoom <amount>","Set your maximum camera distance"},function(...)
	local args={...}
	local num=args[1]

	if num==nil then
		num=math.huge
	else
		num=tonumber(num)
	end
	Players.LocalPlayer.CameraMaxZoomDistance=num
end,true)

cmd.add({"minzoom"},{"minzoom <amount>","Set your minimum camera distance"},function(...)
	local args={...}
	local num=args[1]

	if num==nil then
		num=0
	else
		num=tonumber(num)
	end
	Players.LocalPlayer.CameraMinZoomDistance=num
end,true)

cmd.add({"cameranoclip","camnoclip","cnoclip","nccam"},{"cameranoclip (camnoclip,cnoclip,nccam)","Makes your camera clip through walls"},function()
	SetConstant=(debug and debug.setconstant) or setconstant
	GetConstants=(debug and debug.getconstants) or getconstants
	if SetConstant or GetConstants or getgc then
		local Popper=Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
		for i,v in pairs(getgc()) do
			if type(v)=='function' and getfenv(v).script==Popper then
				for i,v1 in pairs(GetConstants(v)) do
					if tonumber(v1)==.25 then
						SetConstant(v,i,0)
					elseif tonumber(v1)==0 then
						SetConstant(v,i,.25)
					end
				end
			end
		end
	else
		wait();

		DoNotif("Sorry,your exploit does not support cameranoclip")
	end
end)

cmd.add({"uncameranoclip","uncamnoclip","uncnoclip","unnccam"},{"uncameranoclip (uncamnoclip,uncnoclip,unnccam)","Makes your camera not clip through walls"},function()
	local SetConstant=(debug and debug.setconstant) or setconstant
	local GetConstants=(debug and debug.getconstants) or getconstants
	if SetConstant or GetConstants or getgc then
		local Popper=Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
		for i,v in pairs(getgc()) do
			if type(v)=='function' and getfenv(v).script==Popper then
				for i,v1 in pairs(GetConstants(v)) do
					if tonumber(v1)==.25 then
						SetConstant(v,i,0)
					elseif tonumber(v1)==0 then
						SetConstant(v,i,.25)
					end
				end
			end
		end
	else
		wait();

		DoNotif("Sorry,your exploit does not support cameranoclip and uncameranoclip")
	end	
end)

cmd.add({"oganims"},{"oganims","Old animations from 2007"},function()



	wait();

	DoNotif("OG animations set")
	loadstring(game:HttpGet(('https://pastebin.com/raw/6GNkQUu6'),true))()
end)

cmd.add({"fakechat"},{"fakechat","Fake a chat gui"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/fake%20chatte"))()
end)

cmd.add({"fpscap"},{"fpscap <number>","Sets the fps cap to whatever you want"},function(...)
	setfpscap(...)
end,true)

cmd.add({"toolinvisible", "tinvis"}, {"toolinvisible (tinvis)", "Be invisible while still being able to use tools"}, function()
	local offset = 1100
	invisible = false
	local grips = {}
	local heldTool
	local gripChanged
	local handle
	local weld
	HH = getChar().Humanoid.HipHeight

	function setDisplayDistance(distance)
		for _, player in pairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
				player.Character:FindFirstChildWhichIsA("Humanoid").NameDisplayDistance = distance
				player.Character:FindFirstChildWhichIsA("Humanoid").HealthDisplayDistance = distance
			end
		end
	end

	local tool = Instance.new("Tool", Players.LocalPlayer.Backpack)
	tool.Name = "Turn Invisible"
	tool.RequiresHandle = false
	tool.CanBeDropped = false

	tool.Equipped:Connect(function()
		wait()
		if not invisible then
			invisible = true
			tool.Name = "Visible Enabled"

			if handle then
				handle:Destroy()
			end
			if weld then
				weld:Destroy()
			end

			handle = Instance.new("Part", SafeGetService("Workspace"))
			handle.Name = "Handle"
			handle.Transparency = 1
			handle.CanCollide = false
			handle.Size = Vector3.new(2, 1, 1)

			weld = Instance.new("Weld", handle)
			weld.Part0 = handle
			weld.Part1 = getRoot(getChar())
			weld.C0 = CFrame.new(0, offset - 1.5, 0)

			setDisplayDistance(offset + 100)
			SafeGetService("Workspace").CurrentCamera.CameraSubject = handle
			getRoot(getChar()).CFrame = getRoot(getChar()).CFrame * CFrame.new(0, offset, 0)
			getChar().Humanoid.HipHeight = offset
			getChar().Humanoid:ChangeState(11)

			for _, child in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
				if child:IsA("Tool") and child ~= tool then
					grips[child] = child.Grip
				end
			end
			if getHum() then
				getHum():SetStateEnabled("Seated", false)
				getHum().Sit = true
			end
		else
			invisible = false
			tool.Name = "Visible Disabled"

			if handle then
				handle:Destroy()
			end
			if weld then
				weld:Destroy()
			end

			for _, child in pairs(getChar():GetChildren()) do
				if child:IsA("Tool") then
					child.Parent = Players.LocalPlayer.Backpack
				end
			end

			for tool, grip in pairs(grips) do
				if tool then
					tool.Grip = grip
				end
			end

			heldTool = nil
			setDisplayDistance(100)
			SafeGetService("Workspace").CurrentCamera.CameraSubject = getChar().Humanoid
			getRoot(getChar()).CFrame = getRoot(getChar()).CFrame * CFrame.new(0, -offset, 0)
			getChar().Humanoid.HipHeight = HH

			if getHum() then
				getHum():SetStateEnabled("Seated", true)
				getHum().Sit = false
			end
		end

		tool.Parent = Players.LocalPlayer.Backpack
	end)

	getChar().ChildAdded:Connect(function(child)
		wait()
		if invisible and child:IsA("Tool") and child ~= heldTool and child ~= tool then
			heldTool = child
			local lastGrip = heldTool.Grip

			if not grips[heldTool] then
				grips[heldTool] = lastGrip
			end

			for _, track in pairs(getChar().Humanoid:GetPlayingAnimationTracks()) do
				track:Stop()
			end

			getChar().Animate.Disabled = true
			heldTool.Grip = heldTool.Grip * (CFrame.new(0, offset - 1.5, 1.5) * CFrame.Angles(math.rad(-90), 0, 0))
			heldTool.Parent = Players.LocalPlayer.Backpack
			heldTool.Parent = getChar()

			if gripChanged then
				gripChanged:Disconnect()
			end

			gripChanged = heldTool:GetPropertyChangedSignal("Grip"):Connect(function()
				wait()
				if not invisible then
					gripChanged:Disconnect()
				end

				if heldTool.Grip ~= lastGrip then
					lastGrip = heldTool.Grip * (CFrame.new(0, offset - 1.5, 1.5) * CFrame.Angles(math.rad(-90), 0, 0))
					heldTool.Grip = lastGrip
					heldTool.Parent = Players.LocalPlayer.Backpack
					heldTool.Parent = getChar()
				end
			end)
		end
	end)
end)

invisBtnlol = nil
invisKeybindConnection = nil
IsInvis = false
InvisibleCharacter = nil
OriginalPosition = nil
InvisBindLol = Enum.KeyCode.E

cmd.add({"invisible", "invis"}, {"invisible (invis)", "Sets invisibility to scare people or something"}, function()
	if invisKeybindConnection then return DoNotif("invis is already loaded bruh") end -- most stupidest check ever lmao
	local UIS = UserInputService
	local Player = Players.LocalPlayer
	local Character = Player.Character or Player.CharacterAdded:Wait()
	Character.Archivable = true
	OriginalPosition = getRoot(Character).CFrame

	local function TurnVisible()
		if not IsInvis then return end
		IsInvis = false
		OriginalPosition = getRoot(InvisibleCharacter).CFrame
		if invisKeybindConnection then
			invisKeybindConnection:Disconnect()
			invisKeybindConnection = nil
		end
		if invisBtnlol then
			invisBtnlol:Destroy()
			invisBtnlol = nil
		end
		if InvisibleCharacter then
			InvisibleCharacter:Destroy()
			InvisibleCharacter = nil
		end
		Player.Character = Character
		getRoot(Player.Character).CFrame=OriginalPosition
		Character.Parent = SafeGetService("Workspace")
		DoNotif("Invisibility has been turned off.")
		StarterGui:SetCore("ResetButtonCallback", true)
	end

	local function ToggleInvisibility()
		if not IsInvis then
			IsInvis = true
			InvisibleCharacter = Character:Clone()
			InvisibleCharacter.Parent = SafeGetService("Workspace")
			for _, v in pairs(InvisibleCharacter:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Transparency = v.Name:lower() == "humanoidrootpart" and 1 or 0.5
				end
			end
			local root = getRoot(Character)
			if root then
				OriginalPosition = root.CFrame
				root.CFrame = CFrame.new(0, 10000, 0)
			end
			wait(0.5)
			Character.Parent = Lighting
			if OriginalPosition then
				local invisRoot = getRoot(InvisibleCharacter)
				if invisRoot then
					invisRoot.CFrame = OriginalPosition
				end
			end
			Player.Character = InvisibleCharacter
			SafeGetService("Workspace").CurrentCamera.CameraSubject = InvisibleCharacter:FindFirstChildWhichIsA("Humanoid")
			DoNotif("You are now invisible.")
			StarterGui:SetCore("ResetButtonCallback", false)
		else
			TurnVisible()
		end
	end

	invisKeybindConnection = UIS.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == InvisBindLol and not gameProcessed then
			ToggleInvisibility()
		end
	end)

	local humanoid = Character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Died:Connect(function()
			TurnVisible()
		end)
	end

	if IsOnMobile then
		if invisBtnlol then invisBtnlol:Destroy() invisBtnlol = nil end
		invisBtnlol = Instance.new("ScreenGui")
		local TextButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

		NaProtectUI(invisBtnlol)
		invisBtnlol.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		TextButton.Parent = invisBtnlol
		TextButton.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
		TextButton.BackgroundTransparency = 0.14
		TextButton.Position = UDim2.new(0.9, 0, 0.8, 0)
		TextButton.Size = UDim2.new(0.1, 0, 0.1, 0)
		TextButton.Font = Enum.Font.SourceSansBold
		TextButton.Text = "Invisible"
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 15
		TextButton.TextWrapped = true
		TextButton.Active = true
		TextButton.TextScaled = true

		UICorner.Parent = TextButton
		UIAspectRatioConstraint.Parent = TextButton
		UIAspectRatioConstraint.AspectRatio = 1.0

		gui.draggable(TextButton)

		MouseButtonFix(TextButton,function()
			ToggleInvisibility()
			TextButton.Text = IsInvis and "Visible" or "Invisible"
		end)
	end

	wait()
	DoNotif("Invisible loaded, press "..InvisBindLol.Name.." to toggle or use the mobile button.")
end)

cmd.add({"invisbind", "invisiblebind","bindinvis"}, {"invisbind (invisiblebind, bindinvis)", "set a custom keybind for the 'Invisible' command"}, function(...)
	local args = {...}
	if args[1] then
		InvisBindLol = Enum.KeyCode[args[1]] or Enum.KeyCode[args[1]:upper()]
		if InvisBindLol then
			DoNotif("Invis bind set to "..InvisBindLol.Name)
		else
			DoNotif("Invalid keybind, defaulting to E")
			InvisBindLol = Enum.KeyCode.E
		end
	else
		DoNotif("No keybind provided")
	end
end)

cmd.add({"fireremotes", "fremotes", "frem"}, {"fireremotes (fremotes, frem)", "Fires every remote"}, function()
	remoteCount = 0

	for _, descendant in ipairs(game:GetDescendants()) do
		if not descendant:IsDescendantOf(COREGUI) then
			NACaller(function()
				if descendant:IsA("RemoteEvent") then
					pcall(function()
						descendant:FireServer()
					end)
					remoteCount = remoteCount + 1
				elseif descendant:IsA("RemoteFunction") then
					pcall(function()
						descendant:InvokeServer()
					end)
					remoteCount = remoteCount + 1
				end
			end)
		end
	end

	DoNotif("Fired "..remoteCount.." remotes")
end)

local fovcon = nil
local monitorcon = nil

cmd.add({"fov"},{"fov <number>","Makes your FOV to something custom you want (1-120 FOV)"},function(num)
	local field = tonumber(num) or 70
	local hh = TweenService:Create(
		SafeGetService("Workspace").CurrentCamera,
		TweenInfo.new(0, Enum.EasingStyle.Linear),
		{FieldOfView = field}
	)
	hh:Play()
end,true)

cmd.add({"loopfov","lfov"},{"loopfov <number> (lfov)","Makes your FOV to something custom you want (1-120 FOV) on loop"},function(num)
	local field = tonumber(num) or 70
	if fovcon then fovcon:Disconnect() fovcon = nil end
	if monitorcon then monitorcon:Disconnect() monitorcon = nil end

	fovcon = RunService.RenderStepped:Connect(function()
		local hh = TweenService:Create(
			SafeGetService("Workspace").CurrentCamera,
			TweenInfo.new(0, Enum.EasingStyle.Linear),
			{FieldOfView = field}
		)
		hh:Play()
	end)

	monitorcon = SafeGetService("Workspace").CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
		if SafeGetService("Workspace").CurrentCamera.FieldOfView ~= field then
			SafeGetService("Workspace").CurrentCamera.FieldOfView = field
		end
	end)
end,true)

cmd.add({"unloopfov","unlfov"},{"unloopfov (unlfov)","Stops the looped FOV"},function()
	if fovcon then fovcon:Disconnect() fovcon = nil end
	if monitorcon then monitorcon:Disconnect() monitorcon = nil end
end)

cmd.add({"homebrew"},{"homebrew","Executes homebrew admin"},function()
	_G.CustomUI=false
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
end)

cmd.add({"fatesadmin"},{"fatesadmin","Executes fates admin"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))();
end)

cmd.add({"savetools","stools"},{"savetools (stools)","puts your tools in players.localplayer"},function()
	for _,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		if (v:IsA("Tool")) then
			v.Parent=Players.LocalPlayer
		end
	end
end)

cmd.add({"loadtools","ltools"},{"loadtools (ltools)","puts your tools back in the backpack"},function()
	for _,v in pairs(Players.LocalPlayer:GetChildren()) do
		if (v:IsA("Tool")) then
			v.Parent=Players.LocalPlayer.Backpack
		end
	end
end)

cmd.add({"grabtools","gt"},{"grabtools","Grabs any dropped tools"},function()
	local p=Players.LocalPlayer
	local c=p.Character
	if c and c:FindFirstChild("Humanoid") then
		for i,v in pairs(SafeGetService("Workspace"):GetDescendants()) do
			if v:IsA("Tool") then
				c:FindFirstChild("Humanoid"):EquipTool(v)
			end
		end
	end
	wait();

	DoNotif("Grabbed all tools")
end)

cmd.add({"ws","speed","walkspeed"},{"walkspeed <number> (speed,ws)","Makes your WalkSpeed whatever you want"},function(...)
	local args={...}
	if args[2] then
		local speed=args[2] or 16
		if isNumber(speed) then
			getHum().WalkSpeed=speed
		end
	else
		local speed=args[1] or 16
		if isNumber(speed) then
			getHum().WalkSpeed=speed
		end
	end
end,true)

cmd.add({"jp","jumppower"},{"jumppower <number> (jp)","Makes your JumpPower whatever you want"},function(...)
	local args={...}
	local jpower=args[1] or 50
	if isNumber(jpower) then
		if getHum().UseJumpPower then
			getHum().JumpPower=jpower
		else
			getHum().JumpHeight=jpower
		end
	end
end,true)

cmd.add({"oofspam"},{"oofspam","Spams oof"},function()
	_G.enabled=true
	_G.speed=100
	local HRP=Humanoid.RootPart or Humanoid:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not _G.enabled then
		if Humanoid and Humanoid.Health <=0 then
			Humanoid:Destroy()
		end
		return
	end
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
	Humanoid.BreakJointsOnDeath=false
	Humanoid.RequiresNeck=false
	local con; con=RunService.Stepped:Connect(function()
		if not Humanoid then return con:Disconnect() end
		Humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end)
	LocalPlayer.Character=nil
	LocalPlayer.Character=Character
	task.wait(Players.RespawnTime+0.1)
	while task.wait(1/_G.speed) do
		Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	end
end)

cmd.add({"httpspy"},{"httspy","HTTP Spy"},function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/httpspy.lua'))()
end)

cmd.add({"keystroke"},{"keystroke","Executes a keystroke ui script"},function()
	loadstring(game:HttpGet("https://system-exodus.com/scripts/misc-releases/Keystrokes.lua",true))()
end)

cmd.add({"errorchat"},{"errorchat","Makes the chat error appear when roblox chat is slow"},function()
	for i=1,3 do 
		lib.LocalPlayerChat("\0","All")
	end
end)

-- [[ NPC SECTION ]] --

cmd.add({"flingnpcs"}, {"flingnpcs", "Flings NPCs"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			hum.HipHeight = 1024
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"flingnpcs"}, {"flingnpcs", "Flings NPCs"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			hum.HipHeight = 1024
		end
	end
	for _,hum in pairs(SafeGetService("workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"npcfollow"}, {"npcfollow", "Makes NPCS follow you"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			local targetPos = getRoot(LocalPlayer.Character).Position
			hum:MoveTo(targetPos)
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

npcfollowloop = false
cmd.add({"loopnpcfollow"}, {"loopnpcfollow", "Makes NPCS follow you in a loop"}, function()
	npcfollowloop = true

	repeat wait(0.1)
		local npcs = {}

		local function disappear(hum)
			if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
				table.insert(npcs,{hum,hum.HipHeight})
				local rootPart = getRoot(hum.Parent)
				local targetPos = getRoot(LocalPlayer.Character).Position
				hum:MoveTo(targetPos)
			end
		end
		for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
			disappear(hum)
		end
	until npcfollowloop == false
end)

cmd.add({"unloopnpcfollow"}, {"unloopnpcfollow", "Makes NPCS not follow you in a loop"}, function()
	npcfollowloop = false
end)

cmd.add({"sitnpcs"}, {"sitnpcs", "Makes NPCS sit"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				hum.Sit = true
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"unsitnpcs"}, {"unsitnpcs", "Makes NPCS unsit"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				hum.Sit = true
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"killnpcs"}, {"killnpcs", "Kills NPCs"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				hum.Health = 0
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"bringnpcs"}, {"bringnpcs", "Brings NPCs"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			table.insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				rootPart.CFrame = getRoot(LocalPlayer.Character).CFrame
			end      
		end
	end
	for _,hum in pairs(SafeGetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)


--[[ FUNCTIONALITY ]]--
localPlayer.Chatted:Connect(function(str)
	lib.parseCommand(str)
end)

--[[ Admin Player]]
function IsAdminAndRun(Message, Player)
	if Admin[Player.UserId] or isRelAdmin(Player) then
		lib.parseCommand(Message, Player)
	end
end

function CheckPermissions(Player)
	Player.Chatted:Connect(function(Message)
		IsAdminAndRun(Message,Player)
	end)
end

function Getmodel(id)
	local ob23e232323=nil
	s,r=pcall(function()
		ob23e232323=game:GetObjects(id)[1]
	end)
	if s and ob23e232323 then
		return ob23e232323
	end
	task.wait(1)
	warn("retrying")
	return Getmodel(id) 
end

--[[ GUI VARIABLES ]]--
local ScreenGui=Getmodel("rbxassetid://140418556029404")
local rPlayer=Players:FindFirstChildWhichIsA("Player")
local coreGuiProtection={}
if not RunService:IsStudio() then
else
	repeat wait() until player:FindFirstChild("AdminUI",true)
	ScreenGui=player:FindFirstChild("AdminUI",true)
end
repeat wait() until ScreenGui~=nil -- if it loads late then I'll just add this here

NaProtectUI(ScreenGui)

if ScreenGui then ScreenGui.DisplayOrder=9999 ScreenGui.ResetOnSpawn=false end
local description=ScreenGui:FindFirstChild("Description");
local cmdBar=ScreenGui:FindFirstChild("CmdBar");
local centerBar=cmdBar:FindFirstChild("CenterBar");
local cmdInput=centerBar:FindFirstChild("Input");
local cmdAutofill=cmdBar:FindFirstChild("Autofill");
local cmdExample=cmdAutofill:FindFirstChild("Cmd");
local leftFill=cmdBar:FindFirstChild("LeftFill");
local rightFill=cmdBar:FindFirstChild("RightFill");
local chatLogsFrame=ScreenGui:FindFirstChild("ChatLogs");
local chatLogs=chatLogsFrame:FindFirstChild("Container"):FindFirstChild("Logs");
local chatExample=chatLogs:FindFirstChild("TextLabel");
local commandsFrame=ScreenGui:FindFirstChild("Commands");
local commandsFilter=commandsFrame:FindFirstChild("Container"):FindFirstChild("Filter");
local commandsList=commandsFrame:FindFirstChild("Container"):FindFirstChild("List");
local commandExample=commandsList:FindFirstChild("TextLabel");
local UpdLogsFrame=ScreenGui:FindFirstChild("UpdLog");
local UpdLogsTitle=UpdLogsFrame:FindFirstChild("Topbar"):FindFirstChild("TopBar"):FindFirstChild("Title");
local UpdLogsList=UpdLogsFrame:FindFirstChild("Container"):FindFirstChild("List");
local UpdLogsLabel=UpdLogsList:FindFirstChildOfClass("TextLabel");
local resizeFrame=ScreenGui:FindFirstChild("Resizeable");
local resizeXY={
	Top        ={Vector2.new(0,-1),    Vector2.new(0,-1),    "rbxassetid://2911850935"},
	Bottom    ={Vector2.new(0,1),    Vector2.new(0,0),    "rbxassetid://2911850935"},
	Left    ={Vector2.new(-1,0),    Vector2.new(1,0),    "rbxassetid://2911851464"},
	Right    ={Vector2.new(1,0),    Vector2.new(0,0),    "rbxassetid://2911851464"},

	TopLeft        ={Vector2.new(-1,-1),    Vector2.new(1,-1),    "rbxassetid://2911852219"},
	TopRight    ={Vector2.new(1,-1),    Vector2.new(0,-1),    "rbxassetid://2911851859"},
	BottomLeft    ={Vector2.new(-1,1),    Vector2.new(1,0),    "rbxassetid://2911851859"},
	BottomRight    ={Vector2.new(1,1),    Vector2.new(0,0),    "rbxassetid://2911852219"},
}

cmdExample.Parent=nil
chatExample.Parent=nil
commandExample.Parent=nil
UpdLogsLabel.Parent=nil
resizeFrame.Parent=nil

	--[[pcall(function()
		for i,v in pairs(ScreenGui:GetDescendants()) do
			coreGuiProtection[v]=rPlayer.Name
		end
		ScreenGui.DescendantAdded:Connect(function(v)
			coreGuiProtection[v]=rPlayer.Name
		end)
		coreGuiProtection[ScreenGui]=rPlayer.Name
	
		local meta=getrawmetatable(game)
		local tostr=meta.__tostring
		setreadonly(meta,false)
		meta.__tostring=newcclosure(function(t)
			if coreGuiProtection[t] and not checkcaller() then
				return coreGuiProtection[t]
			end
			return tostr(t)
		end)
	end)
	if not RunService:IsStudio() then
		local newGui=COREGUI:FindFirstChildWhichIsA("ScreenGui")
		newGui.DescendantAdded:Connect(function(v)
			coreGuiProtection[v]=rPlayer.Name
		end)
		for i,v in pairs(ScreenGui:GetChildren()) do
			v.Parent=newGui
		end
		ScreenGui=newGui
	end]]

--[[ GUI FUNCTIONS ]]--
gui={}
gui.txtSize=function(ui,x,y)
	local textService=SafeGetService("TextService")
	return textService:GetTextSize(ui.Text,ui.TextSize,ui.Font,Vector2.new(x,y))
end
gui.commands = function()
	local cFrame, cList = commandsFrame, commandsList

	if not cFrame.Visible then
		cFrame.Visible = true
		cList.CanvasSize = UDim2.new(0, 0, 0, 0)
	end

	for _, v in ipairs(cList:GetChildren()) do
		if v:IsA("TextLabel") then v:Destroy() end
	end

	local yOffset = 5
	for cmdName, tbl in pairs(Commands) do
		local Cmd = commandExample:Clone()
		Cmd.Parent = cList
		Cmd.Name = cmdName
		Cmd.Text = " "..tbl[2][1]
		Cmd.Position = UDim2.new(0, 0, 0, yOffset)

		Cmd.MouseEnter:Connect(function()
			description.Visible = true
			description.Text = tbl[2][2]
		end)

		Cmd.MouseLeave:Connect(function()
			if description.Text == tbl[2][2] then
				description.Visible = false
				description.Text = ""
			end
		end)

		yOffset = yOffset + 20
	end

	cList.CanvasSize = UDim2.new(0, 0, 0, yOffset)
	cFrame.Position = UDim2.new(0.5, -283/2, 0.5, -260/2)
end
gui.chatlogs=function()
	if not chatLogsFrame.Visible then
		chatLogsFrame.Visible=true
	end
	chatLogsFrame.Position=UDim2.new(0.5,-283/2+5,0.5,-260/2+5)
end
gui.updateLogs=function()
	if not UpdLogsFrame.Visible and next(updLogs) then
		UpdLogsFrame.Visible=true
	elseif not next(updLogs) then
		DoNotif("no upd logs for now...")
	else
		warn("huh?")
	end
	UpdLogsFrame.Position=UDim2.new(0.5,-283/2+5,0.5,-260/2+5)
end

gui.tween=function(obj,style,direction,duration,goal)
	local tweenInfo=TweenInfo.new(duration,Enum.EasingStyle[style],Enum.EasingDirection[direction])
	local tween=TweenService:Create(obj,tweenInfo,goal)
	tween:Play()
	return tween
end

gui.resizeable = function(ui, min, max)
	min = min or Vector2.new(ui.AbsoluteSize.X, ui.AbsoluteSize.Y)
	max = max or Vector2.new(5000, 5000)

	local rgui = resizeFrame:Clone()
	rgui.Parent = ui

	local mode
	local UIPos
	local lastSize
	local lastPos = Vector2.new()
	local dragging = false

	local function updateResize(currentPos)
		if not dragging or not mode then return end

		local xy = resizeXY[mode.Name]
		if not xy then return end

		local delta = currentPos - lastPos

		local resizeDelta = Vector2.new(
			delta.X * xy[1].X,
			delta.Y * xy[1].Y
		)

		local newSize = Vector2.new(
			lastSize.X + resizeDelta.X,
			lastSize.Y + resizeDelta.Y
		)

		newSize = Vector2.new(
			math.clamp(newSize.X, min.X, max.X),
			math.clamp(newSize.Y, min.Y, max.Y)
		)

		ui.Size = UDim2.new(0, newSize.X, 0, newSize.Y)

		local newPos = UDim2.new(
			UIPos.X.Scale,
			UIPos.X.Offset,
			UIPos.Y.Scale,
			UIPos.Y.Offset
		)

		if xy[1].X < 0 then
			newPos = UDim2.new(
				newPos.X.Scale,
				UIPos.X.Offset + (lastSize.X - newSize.X),
				newPos.Y.Scale,
				newPos.Y.Offset
			)
		end

		if xy[1].Y < 0 then
			newPos = UDim2.new(
				newPos.X.Scale,
				newPos.X.Offset,
				newPos.Y.Scale,
				UIPos.Y.Offset + (lastSize.Y - newSize.Y)
			)
		end

		ui.Position = newPos
	end

	local connection = RunService.RenderStepped:Connect(function()
		if dragging then
			local currentPos = UserInputService:GetMouseLocation()
			updateResize(Vector2.new(currentPos.X, currentPos.Y))
		end
	end)

	for _, button in pairs(rgui:GetChildren()) do
		button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				mode = button
				dragging = true
				local currentPos = UserInputService:GetMouseLocation()
				lastPos = Vector2.new(currentPos.X, currentPos.Y)
				lastSize = ui.AbsoluteSize
				UIPos = ui.Position
			end
		end)

		button.InputEnded:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and mode == button then
				dragging = false
				mode = nil
				if mouse.Icon == resizeXY[button.Name][3] then
					mouse.Icon = ""
				end
			end
		end)

		button.MouseEnter:Connect(function()
			if resizeXY[button.Name] then
				mouse.Icon = resizeXY[button.Name][3]
			end
		end)

		button.MouseLeave:Connect(function()
			if not dragging and mouse.Icon == resizeXY[button.Name][3] then
				mouse.Icon = ""
			end
		end)
	end

	UserInputService.InputEnded:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and dragging then
			dragging = false
			mode = nil
			mouse.Icon = ""
		end
	end)

	return function()
		if connection then
			connection:Disconnect()
		end
	end
end

gui.draggable=function(ui, dragui)
	if not dragui then dragui = ui end
	local UserInputService = UserInputService

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		local newXOffset = startPos.X.Offset + delta.X
		local newYOffset = startPos.Y.Offset + delta.Y

		local screenSize = ui.Parent.AbsoluteSize
		local newXScale = startPos.X.Scale + (newXOffset / screenSize.X)
		local newYScale = startPos.Y.Scale + (newYOffset / screenSize.Y)

		ui.Position = UDim2.new(newXScale, 0, newYScale, 0)
	end

	dragui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = ui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	dragui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	ui.Active=true
end

gui.draggablev2=function(floght)
	floght.Active=true
	floght.Draggable=true
end

gui.menuify=function(menu)
	local exit=menu:FindFirstChild("Exit",true)
	local mini=menu:FindFirstChild("Minimize",true)
	local minimized=false
	local isAnimating = false
	local sizeX,sizeY=Instance.new("IntValue",menu),Instance.new("IntValue",menu)
	MouseButtonFix(mini,function()
		if isAnimating then return end

		minimized = not minimized
		isAnimating = true

		if minimized then
			sizeX.Value = menu.Size.X.Offset
			sizeY.Value = menu.Size.Y.Offset
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, 25)}).Completed:Connect(function()
				isAnimating = false
			end)
		else
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, sizeY.Value)}).Completed:Connect(function()
				isAnimating = false
			end)
		end
	end)
	MouseButtonFix(exit,function()
		menu.Visible=false
	end)
	gui.draggable(menu,menu.Topbar)
	menu.Visible=false
end
gui.menuifyv2=function(menu)
	local exit=menu:FindFirstChild("Exit",true)
	local mini=menu:FindFirstChild("Minimize",true)
	local clear=menu:FindFirstChild("Clear",true);
	local minimized=false
	local isAnimating = false
	local sizeX,sizeY=Instance.new("IntValue",menu),Instance.new("IntValue",menu)
	MouseButtonFix(mini,function()
		if isAnimating then return end

		minimized = not minimized
		isAnimating = true

		if minimized then
			sizeX.Value = menu.Size.X.Offset
			sizeY.Value = menu.Size.Y.Offset
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, 25)}).Completed:Connect(function()
				isAnimating = false
			end)
		else
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, sizeY.Value)}).Completed:Connect(function()
				isAnimating = false
			end)
		end
	end)
	MouseButtonFix(exit,function()
		menu.Visible=false
	end)
	if clear then 
		MouseButtonFix(clear,function()
			local t=menu:FindFirstChild("Container",true):FindFirstChildOfClass("ScrollingFrame"):FindFirstChildOfClass("UIListLayout",true)
			for _,v in ipairs(t.Parent:GetChildren()) do
				if v:IsA("TextLabel") then
					v:Destroy()
				end
			end
		end)
	end
	gui.draggable(menu,menu.Topbar)
	menu.Visible=false
end

gui.loadCommands=function()
	for i,v in pairs(cmdAutofill:GetChildren()) do
		if v.Name~="UIListLayout" then
			v:Remove()
		end
	end
	local last=nil
	local i=0
	for name,tbl in pairs(Commands) do
		local info=tbl[2]
		local btn=cmdExample:Clone()
		btn.Parent=cmdAutofill
		btn.Name=name
		btn.Input.Text=info[1]
		i=i+1

		local size=btn.Size
		btn.Size=UDim2.new(0,0,0,25)
		btn.Size=size
	end
end

gui.loadCommands()
for i,v in ipairs(cmdAutofill:GetChildren()) do
	if v:IsA("Frame") then
		v.Visible=false
	end
end
gui.barSelect=function(speed)
	centerBar.Visible=true
	gui.tween(centerBar,"Sine","Out",speed or 0.25,{Size=UDim2.new(0,250,1,15)})
	gui.tween(leftFill,"Quad","Out",speed or 0.3,{Position=UDim2.new(0,0,0.5,0)})
	gui.tween(rightFill,"Quad","Out",speed or 0.3,{Position=UDim2.new(1,0,0.5,0)})
end
gui.barDeselect=function(speed)
	gui.tween(centerBar,"Sine","Out",speed or 0.25,{Size=UDim2.new(0,250,0,0)})
	gui.tween(leftFill,"Sine","In",speed or 0.3,{Position=UDim2.new(-0.5,100,0.5,0)})
	gui.tween(rightFill,"Sine","In",speed or 0.3,{Position=UDim2.new(1.5,-100,0.5,0)})
	for i,v in ipairs(cmdAutofill:GetChildren()) do
		if v:IsA("Frame") then
			wrap(function()
				wait(math.random(1,200)/2000)
				gui.tween(v,"Back","In",0.35,{Size=UDim2.new(0,0,0,25)})
			end)
		end
	end
end

--[[ AUTOFILL SEARCHER ]]--
gui.searchCommands = function()
	local searchTerm = cmdInput.Text:gsub(";", ""):lower()
	local index = 0
	local lastFramePos
	local results = {}

	for _, frame in ipairs(cmdAutofill:GetChildren()) do
		if frame:IsA("Frame") then
			local cmdName = frame.Name:lower()
			local command = Commands[cmdName]

			if not command then continue end

			local displayName = command[2][1] or ""
			local score = 999
			local matchText = displayName

			if cmdName == searchTerm then
				score = 1
				matchText = cmdName
			elseif displayName:lower() == searchTerm then
				score = 1
				matchText = displayName
			elseif Aliases[searchTerm] and Aliases[searchTerm] == cmdName then
				score = 1
				matchText = searchTerm
			end

			if score == 999 and cmdName:sub(1, #searchTerm) == searchTerm then
				score = 2
				matchText = cmdName
			elseif score == 999 and displayName:lower():sub(1, #searchTerm) == searchTerm then
				score = 3
				matchText = displayName
			end

			if score == 999 then
				for alias, cmd in pairs(Aliases) do
					if cmd == cmdName and alias:sub(1, #searchTerm) == searchTerm then
						score = 3
						matchText = alias
						break
					end
				end
			end

			if score == 999 and #searchTerm >= 2 then
				if cmdName:find(searchTerm, 1, true) then
					score = 4
					matchText = cmdName
				elseif displayName:lower():find(searchTerm, 1, true) then
					score = 5
					matchText = displayName
				else
					for alias, cmd in pairs(Aliases) do
						if cmd == cmdName and alias:find(searchTerm, 1, true) then
							score = 5
							matchText = alias
							break
						end
					end
				end
			end

			if score == 999 and #searchTerm >= 2 then
				local cmdDistance = levenshtein(searchTerm, cmdName)
				local displayDistance = levenshtein(searchTerm, displayName:lower())

				local bestAlias, bestAliasDistance = "", math.huge
				for alias, cmd in pairs(Aliases) do
					if cmd == cmdName then
						local aliasDistance = levenshtein(searchTerm, alias)
						if aliasDistance < bestAliasDistance then
							bestAliasDistance = aliasDistance
							bestAlias = alias
						end
					end
				end

				if cmdDistance <= math.min(2, #searchTerm - 1) then
					score = 6 + cmdDistance
					matchText = cmdName
				elseif bestAliasDistance <= math.min(2, #searchTerm - 1) then
					score = 6 + bestAliasDistance
					matchText = bestAlias
				elseif displayDistance <= math.min(2, #searchTerm - 1) then
					score = 9 + displayDistance
					matchText = displayName
				end
			end

			if score < 999 then
				table.insert(results, {
					frame = frame,
					score = score,
					text = matchText,
					name = cmdName
				})
			end
		end
	end

	table.sort(results, function(a, b)
		if a.score == b.score then
			return a.name < b.name
		end
		return a.score < b.score
	end)

	for _, frame in ipairs(cmdAutofill:GetChildren()) do
		if frame:IsA("Frame") then
			frame.Visible = false
		end
	end

	for i, result in ipairs(results) do
		if i <= 5 then
			local frame = result.frame
			if result.text and result.text ~= "" then
				frame.Input.Text = result.text
				frame.Visible = true

				local newSize = UDim2.new(0.5, math.sqrt(i) * 125, 0, 25)
				local newYPos = (i - 1) * 28
				local newPosition = UDim2.new(0.5, 0, 0, newYPos)

				gui.tween(frame, "Quint", "Out", 0.3, {
					Size = newSize,
					Position = lastFramePos and newPosition or UDim2.new(0.5, 0, 0, newYPos),
				})

				lastFramePos = newPosition
				index = i
			else
				frame.Visible = false
			end
		end
	end
end

--[[ OPEN THE COMMAND BAR ]]--
mouse.KeyDown:Connect(function(k)
	if k:lower()==opt.prefix then
		gui.barSelect()
		cmdInput.Text=''
		cmdInput:CaptureFocus()
		wait();
		cmdInput.Text=''
	end
end)

--[[ CLOSE THE COMMAND BAR ]]--
cmdInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		wrap(function()
			lib.parseCommand(opt.prefix..cmdInput.Text)
		end)
	end
	gui.barDeselect()
end)

cmdInput:GetPropertyChangedSignal("Text"):Connect(function()
	gui.searchCommands()
end)

gui.barDeselect(0)
cmdBar.Visible=true
gui.menuifyv2(chatLogsFrame)
gui.menuify(commandsFrame)
gui.menuify(UpdLogsFrame)

--[[ GUI RESIZE FUNCTION ]]--

--table.find({Enum.Platform.IOS,Enum.Platform.Android},UserInputService:GetPlatform()) | searches if the player is on mobile.
gui.resizeable(chatLogsFrame)
gui.resizeable(commandsFrame)
gui.resizeable(UpdLogsFrame)

--[[ CMDS COMMANDS SEARCH FUNCTION ]]--
commandsFilter.Changed:Connect(function(p)
	if p ~= "Text" then return end

	local searchQuery = commandsFilter.Text:lower():gsub("%s+", "")
	if searchQuery == "" then
		for _, v in pairs(commandsList:GetChildren()) do
			if v:IsA("TextLabel") then
				v.Visible = true
			end
		end
		return
	end

	local results = {}

	for _, v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			local commandName = v.Name:lower()
			local command = Commands[commandName]
			if not command then continue end

			local displayName = command[2][1] or ""
			local score = 999

			if commandName == searchQuery then
				score = 1
			elseif displayName:lower() == searchQuery then
				score = 1
			elseif Aliases[searchQuery] and Aliases[searchQuery] == commandName then
				score = 1
			end

			if score == 999 then
				if commandName:sub(1, #searchQuery) == searchQuery then
					score = 2
				elseif displayName:lower():sub(1, #searchQuery) == searchQuery then
					score = 3
				else
					for alias, cmd in pairs(Aliases) do
						if cmd == commandName and alias:sub(1, #searchQuery) == searchQuery then
							score = 3
							break
						end
					end
				end
			end

			if score == 999 and #searchQuery >= 2 then
				if commandName:find(searchQuery, 1, true) then
					score = 4
				elseif displayName:lower():find(searchQuery, 1, true) then
					score = 5
				else
					for alias, cmd in pairs(Aliases) do
						if cmd == commandName and alias:find(searchQuery, 1, true) then
							score = 5
							break
						end
					end
				end
			end

			if score == 999 and #searchQuery >= 2 then
				local cmdDistance = levenshtein(searchQuery, commandName)
				local displayDistance = levenshtein(searchQuery, displayName:lower())

				local bestAlias, bestAliasDistance = "", math.huge
				for alias, cmd in pairs(Aliases) do
					if cmd == commandName then
						local aliasDistance = levenshtein(searchQuery, alias)
						if aliasDistance < bestAliasDistance then
							bestAliasDistance = aliasDistance
							bestAlias = alias
						end
					end
				end

				if cmdDistance <= math.min(2, #searchQuery - 1) then
					score = 6 + cmdDistance
				elseif bestAliasDistance <= math.min(2, #searchQuery - 1) then
					score = 6 + bestAliasDistance
				elseif displayDistance <= math.min(2, #searchQuery - 1) then
					score = 9 + displayDistance
				end
			end

			if score < 999 then
				table.insert(results, {
					label = v, 
					score = score,
					name = commandName
				})
			end
		end
	end

	table.sort(results, function(a, b)
		if a.score == b.score then
			return a.name < b.name
		end
		return a.score < b.score
	end)

	for _, v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			v.Visible = false
		end
	end

	for _, result in ipairs(results) do
		result.label.Visible = true
	end
end)

--[[ CHAT TO USE COMMANDS ]]--
function bindToChat(plr, msg)
	local chatMsg = chatExample:Clone()

	for i, v in pairs(chatLogs:GetChildren()) do
		if v:IsA("TextLabel") then
			v.LayoutOrder = v.LayoutOrder + 1
		end
	end

	chatMsg.Parent = chatLogs

	local displayName = plr.DisplayName or "Unknown"
	local userName = plr.Name or "Unknown"

	if displayName == userName then
		chatMsg.Text = ("@%s: %s"):format(userName, msg)
	else
		chatMsg.Text = ("%s [@%s]: %s"):format(displayName, userName, msg)
	end

	local txtSize = gui.txtSize(chatMsg, chatMsg.AbsoluteSize.X, 100)
	chatMsg.Size = UDim2.new(1, -5, 0, txtSize.Y)
end

for i,plr in pairs(Players:GetPlayers()) do
	table.insert(playerButtons, plr)
	if plr~=LocalPlayer then
		CheckPermissions(plr)
	end
	plr.Chatted:Connect(function(msg)
		bindToChat(plr,msg)
	end)
end

Players.PlayerAdded:Connect(function(plr)
	CheckPermissions(plr)
	table.insert(playerButtons, plr)
	if ESPenabled then
		repeat wait(1) until plr.Character
		ESP(plr)
	end
	plr.Chatted:Connect(function(msg)
		bindToChat(plr,msg)
	end)
end)

Players.PlayerRemoving:Connect(function(plr)
	for i, p in ipairs(playerButtons) do
		if p == plr then
			table.remove(playerButtons, i)
			break
		end
	end
end)

mouse.Move:Connect(function()
	description.Position=UDim2.new(0,mouse.X,0,mouse.Y)
	size=gui.txtSize(description,200,100)
	description.Size=UDim2.new(0,size.X,0,size.Y)
end)

RunService.Stepped:Connect(function()
	chatLogs.CanvasSize=UDim2.new(0,0,0,chatLogs:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
	commandsList.CanvasSize=UDim2.new(0,0,0,commandsList:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
	UpdLogsList.CanvasSize=UDim2.new(0,0,0,UpdLogsList:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y)
end)

NACaller(function()
	template=UpdLogsLabel
	list=UpdLogsList

	UpdLogsTitle.Text=UpdLogsTitle.Text.." "..updDate

	if next(updLogs) then
		for name,txt in pairs(updLogs) do
			local btn=template:Clone()
			btn.Parent=list
			btn.Name=name
			btn.Text="-"..txt
		end
	else
	end
end)

--[[ COMMAND BAR BUTTON ]]--
local TextLabel = Instance.new("TextLabel")
local Info = Instance.new("TextLabel")
local Info2 = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local ImageButton = Instance.new("ImageButton")
local UICorner2 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local Shadow = Instance.new("Frame")

Shadow.Parent = ScreenGui
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.8
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 5)
Shadow.Size = UDim2.new(0, 2, 0, 33)
Shadow.ZIndex = 9998

TextLabel.Parent = ScreenGui
TextLabel.Name = randomString()
TextLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TextLabel.BackgroundTransparency = 0.2
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.Size = UDim2.new(0, 2, 0, 33)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = getSeasonEmoji()..' '..adminName.." V"..curVer..' '..getSeasonEmoji()
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 20
TextLabel.TextWrapped = true
TextLabel.ZIndex = 9999

Info.Parent = ScreenGui
Info.Name = randomString()
Info.BackgroundTransparency = 1
Info.AnchorPoint = Vector2.new(0, 1)
Info.Position = UDim2.new(0, 10, 1, -10)
Info.Size = UDim2.new(0, 200, 0, 20)
Info.Font = Enum.Font.Gotham
Info.Text = getSeasonEmoji()..' '..adminName.." V"..curVer..' '..getSeasonEmoji().."\n"..dadojadoqwdqwd
Info.TextColor3 = Color3.fromRGB(255, 255, 255)
Info.TextTransparency = 0.5
Info.RichText = true
Info.TextSize = 14
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.ZIndex = 9999

Info2.Parent = ScreenGui
Info2.Name = randomString()
Info2.BackgroundTransparency = 1
Info2.AnchorPoint = Vector2.new(1, 1)
Info2.Position = UDim2.new(1, -10, 1, -10)
Info2.Size = UDim2.new(0, 200, 0, 20)
Info2.Font = Enum.Font.Gotham
Info2.Text = "Updated On: "..updDate.."\ndiscord.gg/zS7TpV3p64"
Info2.TextColor3 = Color3.fromRGB(255, 255, 255)
Info2.TextTransparency = 0.5
Info2.RichText = true
Info2.TextSize = 14
Info2.TextXAlignment = Enum.TextXAlignment.Right
Info2.ZIndex = 9999

ImageButton.Parent = ScreenGui
ImageButton.Name = randomString()
ImageButton.AnchorPoint = Vector2.new(0.5, 0)
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.5, 0, -0.2, 0)
ImageButton.Size = UDim2.new(0, 32 * NAScale, 0, 33 * NAScale)
ImageButton.Image = "rbxassetid://18567102564"
ImageButton.ZIndex = 9999

NAimageButton=ImageButton

UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = ImageButton

UICorner2.CornerRadius = UDim.new(0.2, 0)
UICorner2.Parent = TextLabel

UIGradient.Parent = TextLabel
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 170))
}

function Swoosh()
	ImageButton:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quint", 2, true)
	ImageButton:TweenSize(UDim2.new(0, 32 * NAScale, 0, 33 * NAScale), "Out", "Quint", 2, true)

	local tweenService = TweenService
	local rotationTween = tweenService:Create(ImageButton, TweenInfo.new(2, Enum.EasingStyle.Quint), {Rotation = isAprilFools() and math.random(1,1000) or 720})
	rotationTween:Play()

	gui.draggable(ImageButton)
end

function mainNameless()
	local txtLabel = TextLabel
	txtLabel.Size = UDim2.new(0, 2, 0, 33)
	txtLabel.BackgroundTransparency = 0.14

	local textWidth = SafeGetService("TextService"):GetTextSize(txtLabel.Text, txtLabel.TextSize, txtLabel.Font, Vector2.new(math.huge, math.huge)).X
	local newSize = UDim2.new(0, textWidth + 80, 0, 40)

	txtLabel:TweenSize(newSize, "Out", "Quint", 1, true)

	local tweenService = TweenService
	tweenService:Create(txtLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()

	if IsOnMobile then
		Swoosh()
	else
		ImageButton:Destroy()
	end

	wait(2)

	local fadeOut = tweenService:Create(txtLabel, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {TextTransparency = 1})
	local shrink = tweenService:Create(txtLabel, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
	local fadeOutShadow = tweenService:Create(Shadow, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {BackgroundTransparency = 1})

	fadeOut:Play()
	shrink:Play()
	fadeOutShadow:Play()

	fadeOut.Completed:Connect(function()
		txtLabel:Destroy()
		Shadow:Destroy()
	end)
end

coroutine.wrap(mainNameless)()

if IsOnMobile then
	MouseButtonFix(ImageButton,function()
		gui.barSelect()
		cmdInput.Text=''
		cmdInput:CaptureFocus()
	end)
end

--@ltseverydayyou (null)
--@Cosmella (Viper)

--original by @qipu | loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))();

NACaller(function()
	local NAresult = tick() - NAbegin
	local nameCheck = Player.DisplayName == Player.Name and '@'..Player.Name or Player.DisplayName..' (@'..Player.Name..')'

	delay(0.3, function()
		local executorName = identifyexecutor and identifyexecutor() or "Unknown"

		executorName = isAprilFools() and MockText(executorName) or executorName

		local welcomeMessage = "Welcome to "..adminName.." V"..curVer

		welcomeMessage = isAprilFools() and MockText(welcomeMessage) or welcomeMessage

		if identifyexecutor then
			DoNotif(welcomeMessage.."\nExecutor: "..executorName.."\nUpdated On: "..updDate.."\nTime Taken To Load: "..loadedResults(NAresult), 6, rngMsg().." "..nameCheck)
		else
			DoNotif(welcomeMessage.."\nUpdated On: "..updDate.."\nTime Taken To Load: "..loadedResults(NAresult), 6, rngMsg().." "..nameCheck)
		end

		local queueTitle = "Would you like to enable QueueOnTeleport?"
		local queueDescription = "With QueueOnTeleport "..adminName.." will automatically execute itself upon teleporting to a game or place."

		queueTitle = isAprilFools() and MockText(queueTitle) or queueTitle
		queueDescription = isAprilFools() and MockText(queueDescription) or queueDescription

		Notify({
			Title = queueTitle,
			Description = queueDescription,
			Buttons = {
				{Text = "Yes", Callback = function() queueteleport(loader) end},
				{Text = "No", Callback = function() end}
			}
		})

		task.wait(3)

		if IsOnPC then
			local keybindMessage = "Your Keybind Prefix: "..opt.prefix

			keybindMessage = isAprilFools() and MockText(keybindMessage) or keybindMessage

			DoNotif(keybindMessage, 10, adminName.." Keybind Prefix")
		end

		local updateLogMessage = 'Added "updlog" command (displays any new changes added into '..adminName..')'

		updateLogMessage = isAprilFools() and MockText(updateLogMessage) or updateLogMessage

		DoNotif(updateLogMessage, nil, "Info")
	end)

	if isAprilFools() then
		cmdInput.PlaceholderText = '🤡 '..adminName.." V"..curVer..' 🤡'
	else
		cmdInput.PlaceholderText = getSeasonEmoji()..' '..adminName.." V"..curVer..' '..getSeasonEmoji()
	end
end)

CaptureService.CaptureBegan:Connect(function()
	if NAimageButton then
		NAimageButton.Visible=false
	elseif Info then
		Info.Visible=false
	elseif Info2 then
		Info2.Visible=false
	end
end)

CaptureService.CaptureEnded:Connect(function()
	task.delay(0.1, function()
		if NAimageButton then
			NAimageButton.Visible=true
		elseif Info then
			Info.Visible=true
		elseif Info2 then
			Info2.Visible=true
		end
	end)
end)

print([[
	
███╗░░██╗░█████╗░███╗░░░███╗███████╗██╗░░░░░███████╗░██████╗░██████╗
████╗░██║██╔══██╗████╗░████║██╔════╝██║░░░░░██╔════╝██╔════╝██╔════╝
██╔██╗██║███████║██╔████╔██║█████╗░░██║░░░░░█████╗░░╚█████╗░╚█████╗░
██║╚████║██╔══██║██║╚██╔╝██║██╔══╝░░██║░░░░░██╔══╝░░░╚═══██╗░╚═══██╗
██║░╚███║██║░░██║██║░╚═╝░██║███████╗███████╗███████╗██████╔╝██████╔╝
╚═╝░░╚══╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚══════╝╚══════╝╚═════╝░╚═════╝░

░█████╗░██████╗░███╗░░░███╗██╗███╗░░██╗
██╔══██╗██╔══██╗████╗░████║██║████╗░██║
███████║██║░░██║██╔████╔██║██║██╔██╗██║
██╔══██║██║░░██║██║╚██╔╝██║██║██║╚████║
██║░░██║██████╔╝██║░╚═╝░██║██║██║░╚███║
╚═╝░░╚═╝╚═════╝░╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝
]])

math.randomseed(os.time())

task.spawn(function()
	while task.wait() do
		if getHum() then
			getHum().AutoJumpEnabled=false
			break
		end
	end
end)

task.spawn(function()
	while task.wait(1) do
		local currentTime = os.date("%H:%M:%S")
		Info2.Text = "Updated On: "..updDate.."\nCurrent Time: "..currentTime
	end
end)

task.spawn(function()
	Info.Text = getSeasonEmoji()..' '..adminName.." V"..curVer..' '..getSeasonEmoji().."\n"..dadojadoqwdqwd.."\nPlace: "..placeName()
end)

task.spawn(function()
	NACaller(function()--better saveinstance support
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/SaveInstance.lua"))();
	end)
end)