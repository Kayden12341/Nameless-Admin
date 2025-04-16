--[[


─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████████████─██████████████─██████████████─██████████████────██████████████───██████──██████─██████████─██████─────────████████████───
─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██────██░░░░░░░░░░██───██░░██──██░░██─██░░░░░░██─██░░██─────────██░░░░░░░░████─
─██████░░██████─██░░██████████─██░░██████████─██████░░██████────██░░██████░░██───██░░██──██░░██─████░░████─██░░██─────────██░░████░░░░██─
─────██░░██─────██░░██─────────██░░██─────────────██░░██────────██░░██──██░░██───██░░██──██░░██───██░░██───██░░██─────────██░░██──██░░██─
─────██░░██─────██░░██████████─██░░██████████─────██░░██────────██░░██████░░████─██░░██──██░░██───██░░██───██░░██─────────██░░██──██░░██─
─────██░░██─────██░░░░░░░░░░██─██░░░░░░░░░░██─────██░░██────────██░░░░░░░░░░░░██─██░░██──██░░██───██░░██───██░░██─────────██░░██──██░░██─
─────██░░██─────██░░██████████─██████████░░██─────██░░██────────██░░████████░░██─██░░██──██░░██───██░░██───██░░██─────────██░░██──██░░██─
─────██░░██─────██░░██─────────────────██░░██─────██░░██────────██░░██────██░░██─██░░██──██░░██───██░░██───██░░██─────────██░░██──██░░██─
─────██░░██─────██░░██████████─██████████░░██─────██░░██────────██░░████████░░██─██░░██████░░██─████░░████─██░░██████████─██░░████░░░░██─
─────██░░██─────██░░░░░░░░░░██─██░░░░░░░░░░██─────██░░██────────██░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░████─
─────██████─────██████████████─██████████████─────██████────────████████████████─██████████████─██████████─██████████████─████████████───
─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


]]
if getgenv().RealNamelessLoaded then return end

local req = request or http_request or (syn and syn.request) or function() end

function NACaller(pp)--helps me log better
	local s,err=pcall(pp)
	if not s then print("NA script err: "..err) end
end

NACaller(function() getgenv().RealNamelessLoaded=true end)
NACaller(function() getgenv().NATestingVer=true end)

NAbegin=tick()
CMDAUTOFILL = {}

local Lower = string.lower;
local Split = string.split;
local Sub = string.sub;
local GSub = string.gsub;
local Find = string.find;
local Match = string.match;
local Format = string.format;
local Unpack = table.unpack;
local Insert = table.insert;
local Spawn = task.spawn;
local Delay = task.delay;
local Wait = task.wait;
local Discover = table.find;
local Concat = table.concat;

function blankfunction(...)
	return ...
end

local cloneref = cloneref or blankfunction

function SafeGetService(service)
	return cloneref(game:GetService(service)) or game:GetService(service)
end

function isAprilFools()
	local d = os.date("*t")
	return (d.month == 4 and d.day == 1) or getgenv().ActivateAprilMode or false
end

function MockText(text)
	local result = {}
	local toggle = true
	local glitchChars = {"̶", "̷", "̸", "̹", "̺", "̻", "͓", "͔", "͘", "͜", "͞", "͟", "͢"}

	math.randomseed(os.time())

	for i = 1, #text do
		local char = text:sub(i, i)
		if char:match("%a") then
			local transformed = toggle and char:upper() or char:lower()
			toggle = not toggle

			if math.random() < 0.5 then
				local glitch = glitchChars[math.random(#glitchChars)]
				transformed = transformed..glitch
			end

			Insert(result, transformed)
		else
			Insert(result, char)
		end
	end
	return Concat(result)
end

function randomString()
	local length = math.random(10, 20)
	local result = {}
	local glitchMarks = {"̶", "̷", "̸", "̹", "̺", "̻", "͓", "͔", "͘", "͜", "͞", "͟", "͢"}

	for i = 1, length do
		local char = string.char(math.random(32, 126))
		Insert(result, char)
		if math.random() < 0.5 then
			local numGlitches = math.random(1, 4)
			for j = 1, numGlitches do
				Insert(result, glitchMarks[math.random(#glitchMarks)])
			end
		end
	end

	if math.random() < 0.3 then
		Insert(result, utf8.char(math.random(0x0300, 0x036F)))
	end

	if math.random() < 0.1 then
		Insert(result, "\0")
	end

	if math.random() < 0.1 then
		Insert(result, string.rep("​", math.random(5, 20)))
	end

	if math.random() < 0.2 then
		Insert(result, utf8.char(0x202E))
	end

	return Concat(result)
end

function NAProtection(inst,var)
	if inst then
		if var then
			inst[var]=randomString()
			inst.Archivable=false
		else
			inst.Name=randomString()
			inst.Archivable=false
		end
	end
end

function NaProtectUI(sGui)
	local cGUI = SafeGetService("CoreGui")
	local lPlr = SafeGetService("Players").LocalPlayer

	if sGui:IsA("ScreenGui") then
		sGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
		sGui.DisplayOrder = 999999999
		sGui.ResetOnSpawn = false
		sGui.IgnoreGuiInset = true
	end


	if gethui then
		NAProtection(sGui)
		sGui.Parent = gethui()
		return sGui
	elseif cGUI and cGUI:FindFirstChild("RobloxGui") then
		NAProtection(sGui)
		sGui.Parent = cGUI:FindFirstChild("RobloxGui")
		return sGui
	elseif cGUI then
		NAProtection(sGui)
		sGui.Parent = cGUI
		return sGui
	elseif lPlr and lPlr:FindFirstChild("PlayerGui") then
		NAProtection(sGui)
		sGui.Parent = lPlr:FindFirstChild("PlayerGui")
		sGui.ResetOnSpawn = false
		return sGui
	else
		return nil
	end
end

function InstanceNew(c,p)
	local inst = Instance.new(c)
	if p then inst.Parent=p end
	inst.Name = randomString()
	return inst
end


--[[ Version ]]--
local curVer = isAprilFools() and Format("%d.%d.%d", math.random(1, 10), math.random(0, 99), math.random(0, 99)) or "2.4"

--[[ Brand ]]--
local mainName = 'Nameless Admin'
local testingName = 'NA Testing'
local adminName = 'NA'

-- Returns a single randomized name with the appropriate suffix
function yayApril(isTesting: boolean)
	local baseNames = {
		"Clueless", "Gay", "Infinite", "Sussy", "Broken", "Shadow", "Quirky",
		"Zoomy", "Wacky", "Booba", "Spicy", "Meme", "Doofy", "Silly",
		"Goblin", "Bingus", "Chonky", "Floofy", "Yeety", "Bonky", "Derpy",
		"Cheesy", "Nugget", "Funky", "Floppy", "Chunky", "Snazzy", "Wonky",
		"Goober", "Dorky"
	}

	local suffix = isTesting and "Testing" or "Admin"
	local name = baseNames[math.random(#baseNames)]

	return name.." "..suffix
end


function getSeasonEmoji()
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

if (identifyexecutor() == "Solara" or identifyexecutor() == "Xeno") or not fireproximityprompt then
    getgenv().fireproximityprompt=function(pp)
		local oldenabled=pp.Enabled
		local oldhold=pp.HoldDuration
		local oldrlos=pp.RequiresLineOfSight
		pp.Enabled=true
		pp.HoldDuration=0
		pp.RequiresLineOfSight=false
		Wait(.23)
		pp:InputHoldBegin()
		Wait()
		pp:InputHoldEnd()
		Wait(.1)
		pp.Enabled=pp.Enabled
		pp.HoldDuration=pp.HoldDuration
		pp.RequiresLineOfSight=pp.RequiresLineOfSight
	end
end

local GetService=game.GetService

NA_storage=InstanceNew("ScreenGui")--Stupid Ahh script removing folders

if not game:IsLoaded() then
	local waiting=InstanceNew("Message")
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
local Notification = nil

repeat
	local success, result = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NamelessAdminNotifications.lua"))()
	end)

	if success then
		Notification = result
	else
		warn("Failed to load notification module, retrying...")
		Wait(1)
	end
until Notification

local Notify = Notification.Notify

function DoNotif(text, duration, sender)
	text = text or "something"
	duration = duration or 5
	sender = sender or adminName

	Notify({
		Title = sender,
		Description = text,
		Duration = duration
	})
end

--Custom file functions checker checker
--local CustomFunctionSupport=isfile and isfolder and writefile and readfile and listfiles;
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

local lastPrefix = opt.prefix

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
local ProximityPromptService=game:GetService("ProximityPromptService");
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
local MarketplaceService = SafeGetService("MarketplaceService");
local TextService = SafeGetService("TextService")
local AvatarEditorService = SafeGetService("AvatarEditorService")
local IsOnMobile=false--Discover({Enum.Platform.IOS,Enum.Platform.Android},UserInputService:GetPlatform());
local IsOnPC=false--Discover({Enum.Platform.Windows,Enum.Platform.UWP,Enum.Platform.Linux,Enum.Platform.SteamOS,Enum.Platform.OSX,Enum.Platform.Chromecast,Enum.Platform.WebOS},UserInputService:GetPlatform());
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
local OrgDestroyHeight = game:GetService("Workspace").FallenPartsDestroyHeight
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
	2502806181; --null
	1594235217; --Purple
	1620986547; --pc alt
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
local camera=game:GetService("Workspace").CurrentCamera
local Commands,Aliases={},{}
local player,plr,lp=Players.LocalPlayer,Players.LocalPlayer,Players.LocalPlayer
local ctrlModule

pcall(function()
	local playerScripts = Players.LocalPlayer:FindFirstChildOfClass("PlayerScripts")

	if not playerScripts then return end

	local playerModule = playerScripts:WaitForChild("PlayerModule", 5)
	if not playerModule then return end

	local controlModule = playerModule:WaitForChild("ControlModule", 5)
	if not controlModule then return end

	ctrlModule = require(controlModule)
end)

local bringc={}

--[[ Welcome Messages ]]--
local msg = {
	"Hey!",
	"Hello!",
	"Hi there!",
	"Howdy!",
	"Yo!",
	"Sup!",
	"Heyo!",
	"Hiya!",
	"Hey, buddy!",
	"Nice to see you!",
	"Good to have you here!",
	"Glad you're here!",
	"Welcome aboard!",
	"Pleasure to meet you!",
	"What's up?",
	"How's it going?",
	"What's crackin'?",
	"What's poppin'?",
	"Hey, superstar!",
	"Hey, champ!",
	"Hey, legend!",
	"Welcome, friend!",
	"Welcome to the fam!",
	"Welcome to the party!",

	"Hola!",
	"Bonjour!",
	"Ciao!",
	"Namaste!",
	"G'day mate!",
	"Salutations!",
	"Greetings!",
	"Peace!",
	"Salute!",

	"Greetings, traveler!",
	"Greetings, Earthling!",
	"Ahoy!",
	"Welcome to the show!",
	"Boot sequence complete. Welcome!",
	"System online. Hello!",
	"Executor synced. Let's go!",
	"Ready for action!",
	"Initialization complete!",
	"Connected successfully!",
	"Teleportation successful!",
	"Code ready. Welcome!",
	"Admin mode: Activated.",
}

--[[ Prediction ]]--
function levenshtein(s, t)
	local lenS, lenT = #s, #t
	if lenS == 0 then return lenT end
	if lenT == 0 then return lenS end

	local d = {}

	for i = 0, lenS do
		d[i] = {}
		d[i][0] = i
	end
	for j = 1, lenT do
		d[0][j] = j
	end

	for i = 1, lenS do
		for j = 1, lenT do
			local cost = (s:sub(i, i) == t:sub(j, j)) and 0 or 1
			d[i][j] = math.min(
				d[i - 1][j] + 1,
				d[i][j - 1] + 1,
				d[i - 1][j - 1] + cost
			)
		end
	end

	return d[lenS][lenT]
end

function didYouMean(input)
	local bestMatch = nil
	local lowestDistance = math.huge

	local function cc(collection)
		for name in pairs(collection) do
			local distance = levenshtein(input, name)
			if distance < lowestDistance then
				lowestDistance = distance
				bestMatch = name
			end
		end
	end

	cc(Commands)
	cc(Aliases)

	return bestMatch
end

function isRelAdmin(Player)
	for _, id in ipairs(_G.NAadminsLol) do
		if Player.UserId == id then
			return true
		end
	end
	return false
end

function nameChecker(plr)
	return plr.DisplayName == plr.Name and '@'..plr.Name or plr.DisplayName..' (@'..plr.Name..')'
end

function loadedResults(res)
	local sec = tonumber(res) or 0
	local isNegative = sec < 0

	if isNegative then
		sec = math.abs(sec)
	end

	local days = math.floor(sec / 86400)
	local hours = math.floor((sec % 86400) / 3600)
	local minutes = math.floor((sec % 3600) / 60)
	local secondsFloat = sec % 60

	local seconds, fractional = math.modf(secondsFloat)
	local milliseconds = math.floor(fractional * 1000)

	local function formatTime()
		if days > 0 then
			return Format("%d:%02d:%02d:%02d.%03d | Days,Hours,Minutes,Seconds.Milliseconds",
				days, hours, minutes, seconds, milliseconds)
		elseif hours > 0 then
			return Format("%d:%02d:%02d.%03d | Hours,Minutes,Seconds.Milliseconds",
				hours, minutes, seconds, milliseconds)
		elseif minutes > 0 then
			return Format("%d:%02d.%03d | Minutes,Seconds.Milliseconds",
				minutes, seconds, milliseconds)
		else
			return Format("%d.%03d | Seconds.Milliseconds",
				seconds, milliseconds)
		end
	end

	local formatted = formatTime()
	return isNegative and ("-"..formatted) or formatted
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
										Spawn(function() commandFunc(unpack(parsedArguments)) end)
									else
										Spawn(function() commandFunc() end)
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
									Spawn(function()
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

	local function GenerateLoopKey(name, arguments)
		return name:lower().." "..Concat(arguments or {}, " ")
	end

	local function FormatArgs(arguments)
		if not arguments or #arguments == 0 then
			return "(no args)"
		end
		return Concat(arguments, ", ")
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
					if interval < 0 then
						DoNotif("Invalid delay. Loop not started.", 3)
						return
					end

					local loopKey = GenerateLoopKey(commandName, args)

					if Loops[loopKey] then
						DoNotif("A loop with these arguments is already running for '"..commandName.."'.", 3)
						return
					end

					Loops[loopKey] = {
						commandName = commandName,
						command = command[1],
						args = args or {},
						interval = interval,
						running = true
					}

					Spawn(function()
						while Loops[loopKey] and Loops[loopKey].running do
							pcall(function()
								Loops[loopKey].command(unpack(Loops[loopKey].args))
							end)
							Wait(Loops[loopKey].interval)
						end
					end)

					DoNotif("Loop started for '"..commandName.."' with delay: "..interval.."s. Args: "..FormatArgs(args), 3)
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

	local function FormatArgs(arguments)
		if not arguments or #arguments == 0 then
			return "(no args)"
		end
		return Concat(arguments, ", ")
	end

	local buttons = {}

	for loopKey, loopData in pairs(Loops) do
		local label = Format("'%s' | Args: %s | Delay: %ss", loopData.commandName, FormatArgs(loopData.args), loopData.interval)
		Insert(buttons, {
			Text = label,
			Callback = function()
				loopData.running = false
				Loops[loopKey] = nil
				DoNotif("Stopped loop: '"..loopData.commandName.."' with args: "..FormatArgs(loopData.args), 3)
			end
		})
	end

	Insert(buttons, {
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
		Insert(args, arg)
	end
	return args
end


--[[ Fully setup Nameless admin storage ]]
NaProtectUI(NA_storage)

--[[ LIBRARY FUNCTIONS ]]--
local lib={}
lib.wrap=function(f)
	return coroutine.wrap(f)()
end

local wrap=lib.wrap

function rngMsg()
	return msg[math.random(1,#msg)]
end

function getRoot(char)
	if char:IsA("Player") then char = char.Character end
	return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

function getTorso(char)
	if char:IsA("Player") then char = char.Character end
	return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")
end

function getChar()
	local player = Players.LocalPlayer
	return player.Character or player.CharacterAdded:Wait()
end

function getPlrChar(plr)
	local fix=plr:IsA("Player") and (plr and plr.Character) or plr or nil
	return fix
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

function IsR15(plr)
	plr=(plr or Players.LocalPlayer)
	if plr then
		if getPlrHum(plr).RigType==Enum.HumanoidRigType.R15 then
			return true
		end
	end
	return false
end

function IsR6(plr)
	plr=(plr or Players.LocalPlayer)
	if plr then
		if getPlrHum(plr).RigType==Enum.HumanoidRigType.R6 then
			return true
		end
	end
	return false
end

Foreach = function(Table, Func, Loop)
	for Index, Value in next, Table do
		pcall(function()
			if Loop and typeof(Value) == 'table' then
				for Index2, Value2 in next, Value do
					Func(Index2, Value2)
				end
			else
				Func(Index, Value)
			end
		end)
	end
end

CheckIfNPC = function(Character)
	if (Character and Character:IsA("Model")) and (Character:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(Character)) then
		return true
	end
end

FindInTable = function(tbl,val)
	if tbl==nil then return false end
	for _,v in pairs(tbl) do
		if v==val then return true end
	end
	return false
end

function MouseButtonFix(button,clickCallback)
	local isHolding = false
	local holdThreshold = 0.45
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
local PlayerArgs = {
	["all"] = function()
		return Players:GetPlayers()
	end,

	["others"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if Player ~= LocalPlayer then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,

	["me"] = function()
		return { LocalPlayer }
	end,

	["random"] = function()
		local Amount = Players:GetPlayers()

		return { Amount[math.random(1, #Amount)] }
	end,

	["npc"] = function()
		local Targets = {}

		Foreach(workspace:GetDescendants(), function(Index, Model)
			if CheckIfNPC(Model) then
				Insert(Targets, Model)
			end
		end)

		return Targets
	end,

	["seated"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if getPlrHum(Player.Character).Sit then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,

	["stood"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if not getPlrHum(Player.Character).Sit then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,

	["closest"] = function()
		local Targets = {}
		local ClosestDistance, ClosestPlayer = 9e9, nil

		Foreach(Players:GetPlayers(), function(Index, Player)
			local Distance = Player:DistanceFromCharacter(getRoot(Local.Character).Position)

			if Player ~= LocalPlayer and Distance < ClosestDistance then
				ClosestDistance = Distance
				ClosestPlayer = Player
			end
		end)

		return { ClosestPlayer }
	end,

	["farthest"] = function()
		local Targets = {}
		local FurthestDistance, FurthestPlayer = 0, nil

		Foreach(Players:GetPlayers(), function(Index, Player)
			local Distance = Player:DistanceFromCharacter(GetRoot(Local.Character).Position)

			if Player ~= LocalPlayer and Distance > FurthestDistance then
				FurthestDistance = Distance
				FurthestPlayer = Player
			end
		end)

		return { FurthestPlayer }
	end,

	["enemies"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if Player.Team ~= LocalPlayer.Team then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,

	["dead"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if GetHumanoid(Player.Character).Health == 0 then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,


	["alive"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if GetHumanoid(Player.Character).Health > 0 then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,

	["friends"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if Player:IsFriendsWith(LocalPlayer.UserId) and LocalPlayer ~= Player then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,

	["nonfriends"] = function()
		local Targets = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			if not Player:IsFriendsWith(LocalPlayer.UserId) and LocalPlayer ~= Player then
				Insert(Targets, Player)
			end
		end)

		return Targets
	end,
}

function getPlr(Target)
	local Target = Lower(Target);
	local Check = PlayerArgs[Target];

	if Check then
		return Check()
	else
		local Specific = {}

		Foreach(Players:GetPlayers(), function(Index, Player)
			local Name, Display = Lower(Player.Name), Lower(Player.DisplayName)

			if Sub(Name, 1, #Target) == Target then
				Insert(Specific, Player)

			elseif Sub(Display, 1, #Target) == Target then
				Insert(Specific, Player)
			end
		end)

		return Specific
	end
end

--[[ MORE VARIABLES ]]--
plr=Player
speaker=Player
char=plr.Character
local JSONEncode,JSONDecode=HttpService.JSONEncode,HttpService.JSONDecode

NACaller(function()
	Players.LocalPlayer.CharacterAdded:Connect(function(c)
		character=c
		Character=c
		char=c
	end)
end)

local ESPenabled=false
local chamsEnabled=false
espCONS = {}


function round(num,numDecimalPlaces)
	local mult=10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end

GaemInfo=MarketplaceService:GetProductInfo(PlaceId)

function placeName()
	--[[while true do
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

		Wait(.5)
	end]]
	return GaemInfo.Name
end

function placeCreator()
	return GaemInfo.Creator.Name
end

function storeESP(p, cType, conn)
	if not espCONS[p.Name] then
		espCONS[p.Name] = {}
	end
	Insert(espCONS[p.Name], {type = cType, connection = conn})
end

function discPlrESP(player)
	if espCONS[player.Name] then
		for _, entry in ipairs(espCONS[player.Name]) do
			if entry.connection then
				entry.connection:Disconnect()
			end
		end
		espCONS[player.Name] = nil
	end
	removeESPonLEAVE(player)
end

function removeAllESP()
	for _, child in pairs(COREGUI:GetChildren()) do
		if Sub(child.Name, -4) == '_ESP' then
			child:Destroy()
		end
	end
	for playerName, _ in pairs(espCONS) do
		espCONS[playerName] = nil
	end
end

function removeESPonLEAVE(plr)
	if plr then
		for _, child in pairs(COREGUI:GetChildren()) do
			if child.Name == plr.Name..'_ESP' then
				child:Destroy()
			end
		end
	end
end

function ESP(player, persistent)
	persistent = persistent or false
	Spawn(function()
		discPlrESP(player)

		for _, child in pairs(COREGUI:GetChildren()) do
			if child.Name == player.Name..'_ESP' then
				child:Destroy()
			end
		end
		Wait()

		local function createESP()
			if getPlrChar(player) and player.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(player.Name..'_ESP') then
				local espHolder = InstanceNew("Folder")
				espHolder.Name = player.Name..'_ESP'
				espHolder.Parent = COREGUI

				repeat Wait(1) until getPlrChar(player) and getRoot(getPlrChar(player)) and getPlrChar(player):FindFirstChildOfClass("Humanoid")

				local adornments = {}

				for _, part in pairs(getPlrChar(player):GetChildren()) do
					if part:IsA("BasePart") and not part:FindFirstChildOfClass("Accessory") then
						local boxAdornment = InstanceNew("BoxHandleAdornment")
						boxAdornment.Name = player.Name.."_Box"
						boxAdornment.Parent = espHolder
						boxAdornment.Adornee = part
						boxAdornment.AlwaysOnTop = true
						boxAdornment.ZIndex = 0
						boxAdornment.Size = part.Size
						boxAdornment.Color3 = Color3.fromRGB(0, 255, 0)
						boxAdornment.Transparency = 0.45
						Insert(adornments, boxAdornment)
					end
				end

				if getPlrChar(player):FindFirstChild("Head") then
					local billboardGui = InstanceNew("BillboardGui")
					local textLabel = InstanceNew("TextLabel")

					billboardGui.Adornee = getPlrChar(player):FindFirstChild("Head")
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
					textLabel.Visible = not chamsEnabled

					local espLoop
					espLoop = RunService.RenderStepped:Connect(function()
						if COREGUI:FindFirstChild(player.Name..'_ESP') then
							if getPlrChar(player) and getRoot(getPlrChar(player)) and getPlrChar(player):FindFirstChildOfClass("Humanoid") then
								local humanoid = getPlrChar(player):FindFirstChildOfClass("Humanoid")
								local health = math.floor(humanoid.Health)
								local maxHealth = math.floor(humanoid.MaxHealth)
					
								local hasTeamColor, teamColor = pcall(function() return player.Team.TeamColor.Color end)
								local teamColorFinal = hasTeamColor and teamColor or Color3.fromRGB(255, 255, 255)
					
								local userNaem = player:IsA("Model") and player.Name or nameChecker(player)
					
								if getPlrChar(Players.LocalPlayer) and getRoot(getPlrChar(Players.LocalPlayer)) and getPlrChar(Players.LocalPlayer):FindFirstChildOfClass("Humanoid") then
									local distance = math.floor((getRoot(getPlrChar(Players.LocalPlayer)).Position - getRoot(getPlrChar(player)).Position).magnitude)
					
									local hasTeamName, teamName = pcall(function() return player.Team.Name end)
									if hasTeamName then
										textLabel.Text = Format("%s | Health: %d/%d | Studs: %d | Team: %s", userNaem, health, maxHealth, distance, teamName)
									else
										textLabel.Text = Format("%s | Health: %d/%d | Studs: %d", userNaem, health, maxHealth, distance)
									end
					
									textLabel.TextColor3 = distance < 50 and Color3.fromRGB(255, 0, 0)
										or distance < 100 and Color3.fromRGB(255, 165, 0)
										or Color3.fromRGB(0, 255, 0)
								else
									local hasTeamName, teamName = pcall(function() return player.Team.Name end)
									if hasTeamName then
										textLabel.Text = Format("%s | Health: %d/%d | Team: %s", userNaem, health, maxHealth, teamName)
									else
										textLabel.Text = Format("%s | Health: %d/%d", userNaem, health, maxHealth)
									end
									textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
								end
					
								for _, adornment in pairs(adornments) do
									adornment.Color3 = teamColorFinal
								end
							end
						else
							espLoop:Disconnect()
						end
					end)
					storeESP(player, "renderStepped", espLoop)
				end
			end
		end

		createESP()
		if not player:IsA("Model") then
		local characterAddedConnection
		characterAddedConnection = player.CharacterAdded:Connect(function()
			if not ESPenabled and not persistent then
				characterAddedConnection:Disconnect()
				return
			end

			for _, child in pairs(COREGUI:GetChildren()) do
				if child.Name == player.Name..'_ESP' then
					child:Destroy()
				end
			end
			Wait(1)
			createESP()
		end)
		storeESP(player, "characterAdded", characterAddedConnection)
		end
	end)
end

local Signal1, Signal2 = nil, nil
local flyMobile, MobileWeld = nil, nil

function mobilefly(speed, vfly)
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	if flyMobile then flyMobile:Destroy() end
	flyMobile = InstanceNew("Part", game:GetService("Workspace").CurrentCamera)
	flyMobile.Size, flyMobile.CanCollide = Vector3.new(0.05, 0.05, 0.05), false
	if MobileWeld then MobileWeld:Destroy() end
	MobileWeld = InstanceNew("Weld", flyMobile)
	MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, character:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)

	if not flyMobile:FindFirstChildWhichIsA("BodyVelocity") then
		local bv = InstanceNew("BodyVelocity", flyMobile)
		bv.MaxForce = Vector3.new(0, 0, 0)
		bv.Velocity = Vector3.new(0, 0, 0)
	end

	if not flyMobile:FindFirstChildWhichIsA("BodyGyro") then
		local bg = InstanceNew("BodyGyro", flyMobile)
		bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.P = 1000
		bg.D = 50
	end

	Signal1 = LocalPlayer.CharacterAdded:Connect(function(newChar)
		if not flyMobile:FindFirstChildWhichIsA("BodyVelocity") then
			local bv = InstanceNew("BodyVelocity", flyMobile)
			bv.MaxForce = Vector3.new(0, 0, 0)
			bv.Velocity = Vector3.new(0, 0, 0)
		end

		if not flyMobile:FindFirstChildWhichIsA("BodyGyro") then
			local bg = InstanceNew("BodyGyro", flyMobile)
			bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.P = 1000
			bg.D = 50
		end

		if not flyMobile:FindFirstChildWhichIsA("Weld") then
			MobileWeld = InstanceNew("Weld", flyMobile)
			MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, newChar:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)
		else
			MobileWeld.Part0, MobileWeld.Part1, MobileWeld.C0 = flyMobile, newChar:FindFirstChildWhichIsA("Humanoid").RootPart, CFrame.new(0, 0, 0)
		end
	end)

	local camera = game:GetService("Workspace").CurrentCamera

	Signal2 = RunService.RenderStepped:Connect(function()
		local character = getChar()
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local bv = flyMobile and flyMobile:FindFirstChildWhichIsA("BodyVelocity")
		local bg = flyMobile and flyMobile:FindFirstChildWhichIsA("BodyGyro")

		if character and humanoid and flyMobile and MobileWeld and bv and bg then
			bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			if not vfly then
				getHum().PlatformStand = true
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
	if flyMobile then
		flyMobile:Destroy()
		getHum().PlatformStand = false
	end
	if Signal1 then Signal1:Disconnect() end
	if Signal2 then Signal2:Disconnect() end
end


function x(v)
	if v then
		for _,i in pairs(game:GetService("Workspace"):GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier=0.5
			end
		end
	else
		for _,i in pairs(game:GetService("Workspace"):GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier=0
			end
		end
	end
end

local cmdlp=Players.LocalPlayer

plr=cmdlp

local cmdm=plr:GetMouse()
goofyFLY=nil
function sFLY(vfly)
	while not cmdlp or not cmdlp.Character or not getRoot(cmdlp.Character) or not cmdlp.Character:FindFirstChild('Humanoid') or not cmdm do
		Wait()
	end

	if goofyFLY then goofyFLY:Destroy() end

	goofyFLY = InstanceNew("Part",game:GetService("Workspace").CurrentCamera)
	goofyFLY.Size = Vector3.new(0.05, 0.05, 0.05)
	goofyFLY.CanCollide = false

	local CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
	local lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
	local SPEED = 0

	local function FLY()
		FLYING = true

		local BG = InstanceNew('BodyGyro', goofyFLY)
		local BV = InstanceNew('BodyVelocity', goofyFLY)
		local Weld = InstanceNew("Weld", goofyFLY)

		Weld.Part0 = goofyFLY
		Weld.Part1 = cmdlp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
		Weld.C0 = CFrame.new(0, 0, 0)
		BG.P = 9e4
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = goofyFLY.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

		Spawn(function()
			while FLYING do
				if not vfly then
					getHum().PlatformStand = true
				end

				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif SPEED ~= 0 then
					SPEED = 0
				end

				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					BV.velocity = ((game:GetService("Workspace").CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) +
						((game:GetService("Workspace").CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) -
							game:GetService("Workspace").CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = { F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R }
				elseif SPEED ~= 0 then
					BV.velocity = ((game:GetService("Workspace").CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) +
						((game:GetService("Workspace").CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) -
							game:GetService("Workspace").CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end

				BG.cframe = game:GetService("Workspace").CurrentCamera.CoordinateFrame
				Wait()
			end

			CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			getHum().PlatformStand = false
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
	repeat Wait() until getChar()
	tool=getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool") or nil
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
					if Find(v.Name,"RBXWhisper:") then
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
				Spawn(function()
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
		if Find(v.Name,"RBXWhisper:") then
			Wait(1)
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
				Insert(parsed, arg)
			end
		else
			Insert(parsed, nil)
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
				Insert(args, arg)
			end
			cmd.run(args)
		end
	end)
end

local connections = {}

lib.connect = function(name, connection)
	connections[name] = connections[name] or {}
	Insert(connections[name], connection)
	return connection
end

lib.disconnect = function(name)
	if connections[name] then
		for _, conn in ipairs(connections[name]) do
			conn:Disconnect()
		end
		connections[name] = nil
	end
end

local m=math			--prepare for annoying and unnecessary tool grip math
local rad=m.rad
local clamp=m.clamp
local sin=m.sin
local tan=m.tan
local cos=m.cos

--[[ COMMANDS ]]--

cmd.add({"url"}, {"url <link>", "Run the script using URL"}, function(...)
	local args = {...}
	local link = Concat(args, " ")
	if not link or link == "" then
		return false, "Invalid URL"
	end

	local success, result = pcall(function()
		return game:HttpGet(link)
	end)

	if not success then
		return false, "Failed to fetch script: "..tostring(result)
	end

	local fn, loadErr = loadstring(result)
	if not fn then
		return false, "Error compiling script: "..tostring(loadErr)
	end

	local execSuccess, execResult = pcall(fn)
	if not execSuccess then
		return false, "Error running script: "..tostring(execResult)
	end

	return true, "Script executed successfully"
end, true)

cmd.add({"loadstring", "ls"}, {"loadstring <code> (ls)", "Run code using loadstring"}, function(...)
	local args = {...}
	local code = Concat(args, " ")
	if not code or code == "" then
		return false, "No code provided"
	end

	local fn, err = loadstring(code)
	if not fn then
		return false, "Error loading code: "..tostring(err)
	end

	local success, result = pcall(fn)
	if not success then
		return false, "Error executing code: "..tostring(result)
	end

	return true, result
end, true)

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
		scaleFrame = InstanceNew("ScreenGui")
		local frame = InstanceNew("Frame")
		local frameCorner = InstanceNew("UICorner")
		local slider = InstanceNew("Frame")
		local sliderCorner = InstanceNew("UICorner")
		local progress = InstanceNew("Frame")
		local progressCorner = InstanceNew("UICorner")
		local knob = InstanceNew("TextButton")
		local knobCorner = InstanceNew("UICorner")
		local label = InstanceNew("TextLabel")
		local closeButton = InstanceNew("TextButton")
		local closeCorner = InstanceNew("UICorner")

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
		label.Text = "Scale: "..Format("%.2f", NAScale)
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
			label.Text = "Scale: "..Format("%.2f", scale)
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

		gui.draggablev2(frame)
	end)
end

cmd.add({"scripthub","hub"},{"scripthub (hub)","Thanks to scriptblox api"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/ScriptHubNA.lua"))()
end)

cmd.add({"resizechat","rc"},{"resizechat (rc)","Makes chat resizable and draggable"},function()
	require(ChatService.ClientChatModules.ChatSettings).WindowResizable=true
	require(ChatService.ClientChatModules.ChatSettings).WindowDraggable=true
end)

cmd.add({"prefix"}, {"prefix <symbol>", "Changes the admin prefix"}, function(...)
	local newPrefix = (...)
	if not newPrefix or newPrefix == "" then
		DoNotif("Please enter a valid prefix")
	elseif utf8.len(newPrefix) > 1 then
		DoNotif("Prefix must be a single character (e.g. ; . !)")
	elseif newPrefix:match("[%w]") then
		DoNotif("Prefix cannot contain letters or numbers")
	elseif newPrefix:match("[%[%]%(%)%*%^%$%%{}<>]") then
		DoNotif("That symbol is not allowed as a prefix")
	elseif newPrefix:match("&amp;") or newPrefix:match("&lt;") or newPrefix:match("&gt;") or newPrefix:match("&quot;") or newPrefix:match("&#x27;") or newPrefix:match("&#x60;") then
		DoNotif("Encoded/HTML characters are not allowed as a prefix")
	else
		opt.prefix = newPrefix
		DoNotif("Prefix set to: "..newPrefix)
	end
end, true)

cmd.add({"saveprefix"}, {"saveprefix <symbol>", "Saves the prefix to a file and applies it"}, function(...)
	if not FileSupport then return end

	local newPrefix = (...)
	if not newPrefix or newPrefix == "" then
		DoNotif("Please enter a valid prefix")
	elseif utf8.len(newPrefix) > 1 then
		DoNotif("Prefix must be a single character (e.g. ; . !)")
	elseif newPrefix:match("[%w]") then
		DoNotif("Prefix cannot contain letters or numbers")
	elseif newPrefix:match("[%[%]%(%)%*%^%$%%{}<>]") then
		DoNotif("That symbol is not allowed as a prefix")
	elseif newPrefix:match("&amp;") or newPrefix:match("&lt;") or newPrefix:match("&gt;") or newPrefix:match("&quot;") or newPrefix:match("&#x27;") or newPrefix:match("&#x60;") then
		DoNotif("Encoded/HTML characters are not allowed as a prefix")
	else
		writefile("Nameless-Admin/Prefix.txt", newPrefix)
		opt.prefix = newPrefix
		DoNotif("Prefix saved to: "..newPrefix)
	end
end, true)

--[ UTILITY ]--

cmd.add({"chatlogs","clogs"},{"chatlogs (clogs)","Open the chat logs"},function()
	gui.chatlogs()
end)

cmd.add({"gotocampos","tocampos","tcp"},{"gotocampos (tocampos,tcp)","Teleports you to your camera position works with free cam but freezes you"},function()
	local player=Players.LocalPlayer
	local UserInputService=UserInputService
	function teleportPlayer()
		local character=player.Character or player.CharacterAdded:wait(1)
		local camera=game:GetService("Workspace").CurrentCamera
		local cameraPosition=camera.CFrame.Position
		character:SetPrimaryPartCFrame(CFrame.new(cameraPosition))
	end
	local camera=game:GetService("Workspace").CurrentCamera
	repeat Wait() until camera.CFrame~=CFrame.new()

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

cmd.add({"discord", "invite"}, {"discord (invite)", "Copy an invite link to the official Nameless Admin Discord server"}, function()
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

clickflingUI = nil
clickConnections = {}
clickflingEnabled = true

cmd.add({"clickfling","mousefling"}, {"clickfling (mousefling)", "Fling a player by clicking them"}, function()
	clickflingEnabled = true
	if clickflingUI then clickflingUI:Destroy() end
	for _, conn in ipairs(clickConnections) do
		if conn then
			conn:Disconnect()
		end
	end
	local Mouse = player:GetMouse()
	clickflingUI = InstanceNew("ScreenGui")
	NaProtectUI(clickflingUI)

	local toggleButton = InstanceNew("TextButton")
	toggleButton.Size = UDim2.new(0, 120, 0, 40)
	toggleButton.Text = "ClickFling: ON"
	toggleButton.Position = UDim2.new(0.5, -60, 0, 10)
	toggleButton.TextScaled = 16
	toggleButton.TextColor3 = Color3.new(1, 1, 1)
	toggleButton.Font = Enum.Font.GothamBold
	toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	toggleButton.BackgroundTransparency = 0.2
	toggleButton.Parent = clickflingUI

	local uiCorner = InstanceNew("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = toggleButton

	gui.draggablev2(toggleButton)

	MouseButtonFix(toggleButton, function()
		clickflingEnabled = not clickflingEnabled
		if clickflingEnabled then
			toggleButton.Text = "ClickFling: ON"
		else
			toggleButton.Text = "ClickFling: OFF"
		end
	end)

	local conn = Mouse.Button1Down:Connect(function()
		if not clickflingEnabled then return end
		local Target = Mouse.Target
		if Target and Target.Parent and Target.Parent:IsA("Model") and Players:GetPlayerFromCharacter(Target.Parent) then
			local PlayerName = Players:GetPlayerFromCharacter(Target.Parent).Name
			local player = Players.LocalPlayer
			local Targets = {PlayerName}
			local Players = game:GetService("Players")
			local Player = Players.LocalPlayer

			local AllBool = false

			local GetPlayer = function(Name)
				Name = Name:lower()
				if Name == "all" or Name == "others" then
					AllBool = true
					return
				elseif Name == "random" then
					local GetPlayers = Players:GetPlayers()
					if Discover(GetPlayers, Player) then table.remove(GetPlayers, Discover(GetPlayers, Player)) end
					return GetPlayers[math.random(#GetPlayers)]
				elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
					for _, x in next, Players:GetPlayers() do
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
					THead = TCharacter:FindFirstChild("Head")
				end
				if TCharacter:FindFirstChildOfClass("Accessory") then
					Accessory = TCharacter:FindFirstChildOfClass("Accessory")
				end
				if Accessory and Accessory:FindFirstChild("Handle") then
					Handle = Accessory.Handle
				end

				if Character and Humanoid and RootPart then
					if not getgenv().OldPos or RootPart.Velocity.Magnitude < 50 then
						getgenv().OldPos = RootPart.CFrame
					end
					if THumanoid and THumanoid.Sit and not AllBool then
					end
					if THead then
						game:GetService("Workspace").CurrentCamera.CameraSubject = THead
					elseif not THead and Handle then
						game:GetService("Workspace").CurrentCamera.CameraSubject = Handle
					elseif THumanoid and TRootPart then
						game:GetService("Workspace").CurrentCamera.CameraSubject = THumanoid
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

									FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
									Wait()
								else
									FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
									Wait()

									FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
									Wait()
								end
							else
								break
							end
						until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
					end

					game:GetService("Workspace").FallenPartsDestroyHeight = 0/0

					local BV = InstanceNew("BodyVelocity")
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
					end

					BV:Destroy()
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
					game:GetService("Workspace").CurrentCamera.CameraSubject = Humanoid

					repeat
						RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
						Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
						Humanoid:ChangeState("GettingUp")
						table.foreach(Character:GetChildren(), function(_, x)
							if x:IsA("BasePart") then
								x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
							end
						end)
						Wait()
					until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
					game:GetService("Workspace").FallenPartsDestroyHeight = getgenv().FPDH
				else
				end
			end

			getgenv().Welcome = true
			if Targets[1] then for _, x in next, Targets do GetPlayer(x) end else return end

			if AllBool then
				for _, x in next, Players:GetPlayers() do
					SkidFling(x)
				end
			end

			for _, x in next, Targets do
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
		end
	end)
	Insert(clickConnections, conn)
end)

cmd.add({"unclickfling", "unmousefling"}, {"unclickfling (unmousefling)","disables clickfling"}, function()
	clickflingEnabled = false
	if clickflingUI then clickflingUI:Destroy() end
	for _, conn in ipairs(clickConnections) do
		if conn then
			conn:Disconnect()
		end
	end
	clickConnections = {}
end)


cmd.add({"ping"}, {"ping", "Shows your ping"}, function()
	local function createWindow(position, maxSize, minSize, defaultText)
		local screenGui = InstanceNew("ScreenGui")
		NaProtectUI(screenGui)
		screenGui.ResetOnSpawn = false

		local window = InstanceNew("TextLabel")
		window.Parent = screenGui
		window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
		window.BackgroundTransparency = 0.2
		window.Position = position
		window.Size = maxSize
		window.Font = Enum.Font.GothamSemibold
		window.Text = defaultText
		window.TextColor3 = Color3.fromRGB(255, 255, 255)
		window.TextSize = 16
		window.TextXAlignment = Enum.TextXAlignment.Center
		window.TextWrapped = true

		local uiCorner = InstanceNew("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 10)
		uiCorner.Parent = window

		local uiStroke = InstanceNew("UIStroke")
		uiStroke.Color = Color3.fromRGB(100, 100, 255)
		uiStroke.Thickness = 1.5
		uiStroke.Parent = window

		local closeButton = InstanceNew("TextButton")
		closeButton.Parent = window
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
		closeButton.Position = UDim2.new(1, -25, 0.5, -10)
		closeButton.Size = UDim2.new(0, 20, 0, 20)
		closeButton.Font = Enum.Font.GothamBold
		closeButton.Text = "X"
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.TextSize = 14
		closeButton.ZIndex = 10

		local closeUICorner = InstanceNew("UICorner")
		closeUICorner.CornerRadius = UDim.new(0, 10)
		closeUICorner.Parent = closeButton

		local minimizeButton = InstanceNew("TextButton")
		minimizeButton.Parent = window
		minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
		minimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
		minimizeButton.Size = UDim2.new(0, 20, 0, 20)
		minimizeButton.Font = Enum.Font.GothamBold
		minimizeButton.Text = "-"
		minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		minimizeButton.TextSize = 14
		minimizeButton.ZIndex = 10

		local minUICorner = InstanceNew("UICorner")
		minUICorner.CornerRadius = UDim.new(0, 10)
		minUICorner.Parent = minimizeButton

		return {
			screenGui = screenGui,
			window = window,
			closeButton = closeButton,
			minimizeButton = minimizeButton,
			maxSize = maxSize,
			minSize = minSize,
			defaultText = defaultText,
			minimized = false
		}
	end

	local function setupMinimize(guiElements)
		MouseButtonFix(guiElements.minimizeButton, function()
			guiElements.minimized = not guiElements.minimized
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local targetSize = guiElements.minimized and guiElements.minSize or guiElements.maxSize
			local tween = TweenService:Create(guiElements.window, tweenInfo, {Size = targetSize})
			tween:Play()
			if guiElements.minimized then
				local title = guiElements.defaultText:match("^(%S+)")
				guiElements.window.Text = title
			else
				guiElements.window.Text = guiElements.defaultText
			end
		end)
	end

	local function setupClose(guiElements)
		MouseButtonFix(guiElements.closeButton, function()
			guiElements.screenGui:Destroy()
		end)
	end

	local function setupDraggable(guiElements)
		gui.draggablev2(guiElements.window)
	end
	local guiElements = createWindow(UDim2.new(0, 0, 0, 48), UDim2.new(0, 201, 0, 35), UDim2.new(0, 201, 0, 20), "Ping: --")
	setupMinimize(guiElements)
	setupClose(guiElements)
	setupDraggable(guiElements)
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

			if not guiElements.minimized then
				guiElements.window.Text = "Ping: "..ping.." ms"
				guiElements.window.TextColor3 = color
			end

			lastUpdate = currentTime
		end
	end)
end)

cmd.add({"fps"}, {"fps", "Shows your fps"}, function()
	local function createWindow(position, maxSize, minSize, defaultText)
		local screenGui = InstanceNew("ScreenGui")
		NaProtectUI(screenGui)
		screenGui.ResetOnSpawn = false

		local window = InstanceNew("TextLabel")
		window.Parent = screenGui
		window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
		window.BackgroundTransparency = 0.2
		window.Position = position
		window.Size = maxSize
		window.Font = Enum.Font.GothamSemibold
		window.Text = defaultText
		window.TextColor3 = Color3.fromRGB(255, 255, 255)
		window.TextSize = 16
		window.TextXAlignment = Enum.TextXAlignment.Center
		window.TextWrapped = true

		local uiCorner = InstanceNew("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 10)
		uiCorner.Parent = window

		local uiStroke = InstanceNew("UIStroke")
		uiStroke.Color = Color3.fromRGB(100, 100, 255)
		uiStroke.Thickness = 1.5
		uiStroke.Parent = window

		local closeButton = InstanceNew("TextButton")
		closeButton.Parent = window
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
		closeButton.Position = UDim2.new(1, -25, 0.5, -10)
		closeButton.Size = UDim2.new(0, 20, 0, 20)
		closeButton.Font = Enum.Font.GothamBold
		closeButton.Text = "X"
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.TextSize = 14
		closeButton.ZIndex = 10

		local closeUICorner = InstanceNew("UICorner")
		closeUICorner.CornerRadius = UDim.new(0, 10)
		closeUICorner.Parent = closeButton

		local minimizeButton = InstanceNew("TextButton")
		minimizeButton.Parent = window
		minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
		minimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
		minimizeButton.Size = UDim2.new(0, 20, 0, 20)
		minimizeButton.Font = Enum.Font.GothamBold
		minimizeButton.Text = "-"
		minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		minimizeButton.TextSize = 14
		minimizeButton.ZIndex = 10

		local minUICorner = InstanceNew("UICorner")
		minUICorner.CornerRadius = UDim.new(0, 10)
		minUICorner.Parent = minimizeButton

		return {
			screenGui = screenGui,
			window = window,
			closeButton = closeButton,
			minimizeButton = minimizeButton,
			maxSize = maxSize,
			minSize = minSize,
			defaultText = defaultText,
			minimized = false
		}
	end

	local function setupMinimize(guiElements)
		MouseButtonFix(guiElements.minimizeButton, function()
			guiElements.minimized = not guiElements.minimized
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local targetSize = guiElements.minimized and guiElements.minSize or guiElements.maxSize
			local tween = TweenService:Create(guiElements.window, tweenInfo, {Size = targetSize})
			tween:Play()
			if guiElements.minimized then
				local title = guiElements.defaultText:match("^(%S+)")
				guiElements.window.Text = title
			else
				guiElements.window.Text = guiElements.defaultText
			end
		end)
	end

	local function setupClose(guiElements)
		MouseButtonFix(guiElements.closeButton, function()
			guiElements.screenGui:Destroy()
		end)
	end

	local function setupDraggable(guiElements)
		gui.draggablev2(guiElements.window)
	end
	local guiElements = createWindow(UDim2.new(0, 0, 0, 6), UDim2.new(0, 201, 0, 35), UDim2.new(0, 201, 0, 20), "FPS: --")
	setupMinimize(guiElements)
	setupClose(guiElements)
	setupDraggable(guiElements)
	local frames = {}
	local lastUpdate = 0
	local updateInterval = 0.5

	RunService.RenderStepped:Connect(function(deltaTime)
		Insert(frames, deltaTime)
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

			if not guiElements.minimized then
				guiElements.window.Text = "FPS: "..fps
				guiElements.window.TextColor3 = color
			end

			lastUpdate = currentTime
		end
	end)
end)

cmd.add({"stats"}, {"stats", "Shows both FPS and ping"}, function()
	local function createWindow(position, maxSize, minSize, defaultText)
		local screenGui = InstanceNew("ScreenGui")
		NaProtectUI(screenGui)
		screenGui.ResetOnSpawn = false

		local window = InstanceNew("TextLabel")
		window.Parent = screenGui
		window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
		window.BackgroundTransparency = 0.2
		window.Position = position
		window.Size = maxSize
		window.Font = Enum.Font.GothamSemibold
		window.Text = defaultText
		window.TextColor3 = Color3.fromRGB(255, 255, 255)
		window.TextSize = 14
		window.TextXAlignment = Enum.TextXAlignment.Center
		window.TextWrapped = true

		local uiCorner = InstanceNew("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 10)
		uiCorner.Parent = window

		local uiStroke = InstanceNew("UIStroke")
		uiStroke.Color = Color3.fromRGB(100, 100, 255)
		uiStroke.Thickness = 1.5
		uiStroke.Parent = window

		local closeButton = InstanceNew("TextButton")
		closeButton.Parent = window
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
		closeButton.Position = UDim2.new(1, -25, 0.5, -10)
		closeButton.Size = UDim2.new(0, 20, 0, 20)
		closeButton.Font = Enum.Font.GothamBold
		closeButton.Text = "X"
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.TextSize = 14
		closeButton.ZIndex = 10

		local closeUICorner = InstanceNew("UICorner")
		closeUICorner.CornerRadius = UDim.new(0, 10)
		closeUICorner.Parent = closeButton

		local minimizeButton = InstanceNew("TextButton")
		minimizeButton.Parent = window
		minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
		minimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
		minimizeButton.Size = UDim2.new(0, 20, 0, 20)
		minimizeButton.Font = Enum.Font.GothamBold
		minimizeButton.Text = "-"
		minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		minimizeButton.TextSize = 14
		minimizeButton.ZIndex = 10

		local minUICorner = InstanceNew("UICorner")
		minUICorner.CornerRadius = UDim.new(0, 10)
		minUICorner.Parent = minimizeButton

		return {
			screenGui = screenGui,
			window = window,
			closeButton = closeButton,
			minimizeButton = minimizeButton,
			maxSize = maxSize,
			minSize = minSize,
			defaultText = defaultText,
			minimized = false
		}
	end

	local function setupMinimize(guiElements)
		MouseButtonFix(guiElements.minimizeButton, function()
			guiElements.minimized = not guiElements.minimized
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local targetSize = guiElements.minimized and guiElements.minSize or guiElements.maxSize
			local tween = TweenService:Create(guiElements.window, tweenInfo, {Size = targetSize})
			tween:Play()
			if guiElements.minimized then
				local title = guiElements.defaultText:match("^(%S+)")
				guiElements.window.Text = title
			else
				guiElements.window.Text = guiElements.defaultText
			end
		end)
	end

	local function setupClose(guiElements)
		MouseButtonFix(guiElements.closeButton, function()
			guiElements.screenGui:Destroy()
		end)
	end

	local function setupDraggable(guiElements)
		gui.draggablev2(guiElements.window)
	end
	local guiElements = createWindow(UDim2.new(0, 0, 0, 48), UDim2.new(0, 250, 0, 50), UDim2.new(0, 250, 0, 20), "Ping: -- ms | FPS: --")
	setupMinimize(guiElements)
	setupClose(guiElements)
	setupDraggable(guiElements)
	local frames = {}
	local lastUpdate = 0
	local updateInterval = 0.5

	RunService.RenderStepped:Connect(function(deltaTime)
		Insert(frames, deltaTime)
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

			if not guiElements.minimized then
				guiElements.window.Text = "Ping: "..ping.." ms | FPS: "..fps
				guiElements.window.TextColor3 = pingColor
			end

			lastUpdate = currentTime
		end
	end)
end)


cmd.add({"commands","cmds"},{"commands (cmds)","Open the command list"},function()
	gui.commands()
end)

debugUI = nil
debugChar = nil

cmd.add({"chardebug", "cdebug"}, {"chardebug (cdebug)", "debug your character"}, function()
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	local workspaceService = game:GetService("Workspace")

	if debugUI then
		debugUI:Destroy()
		debugUI = nil
	end
	if debugChar then
		debugChar:Disconnect()
		debugChar = nil
	end
	local debugChar = LocalPlayer.CharacterAdded:Connect(function(cc)
		humanoid=cc:WaitForChild("Humanoid")
		rootPart=cc:WaitForChild("HumanoidRootPart")
	end)

	debugUI = InstanceNew("ScreenGui")
	NaProtectUI(debugUI)

	local container = InstanceNew("Frame")
	container.Size = UDim2.new(0, 520, 0, 300)
	container.Position = UDim2.new(0.5, -260, 0.2, 0)
	container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	container.BackgroundTransparency = 0.3
	container.BorderSizePixel = 0
	container.Parent = debugUI

	local containerCorner = InstanceNew("UICorner")
	containerCorner.CornerRadius = UDim.new(0.1, 0)
	containerCorner.Parent = container

	local header = InstanceNew("TextLabel")
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundTransparency = 1
	header.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	header.Text = "Debug Information"
	header.TextColor3 = Color3.new(1, 1, 1)
	header.Font = Enum.Font.Code
	header.TextScaled = true
	header.Parent = container

	local minimizeButton = InstanceNew("TextButton")
	minimizeButton.Size = UDim2.new(0, 40, 0, 40)
	minimizeButton.Position = UDim2.new(1, -40, 0, 0)
	minimizeButton.BackgroundTransparency = 1
	minimizeButton.Text = "-"
	minimizeButton.TextScaled = true
	minimizeButton.TextColor3 = Color3.new(1, 1, 1)
	minimizeButton.Font = Enum.Font.Code
	minimizeButton.Parent = header

	gui.draggablev2(container)

	local labelsInfo = {
		{name = "VelocityLabel", text = "Velocity\nX: 0.00\nY: 0.00\nZ: 0.00"},
		{name = "PositionLabel", text = "Position\nX: 0.00\nY: 0.00\nZ: 0.00"},
		{name = "HealthLabel", text = "Health\n0.00 / 0.00"},
		{name = "FOVLabel", text = "FOV\n0.00"},
		{name = "StateLabel", text = "State\nUnknown"},
		{name = "ToolLabel", text = "Tool\nNone"},
		{name = "JumpPowerLabel", text = "Jump Power\n0.00"},
		{name = "WalkSpeedLabel", text = "Walk Speed\n0.00"}
	}

	local labelObjects = {}
	local labelWidth = 250
	local labelHeight = 50
	local spacing = 10
	local numColumns = 2
	local startX = 10
	local startY = header.Size.Y.Offset + 10

	for i, info in ipairs(labelsInfo) do
		local column = ((i - 1) % numColumns)
		local row = math.floor((i - 1) / numColumns)
		local label = InstanceNew("TextLabel")
		label.Size = UDim2.new(0, labelWidth, 0, labelHeight)
		label.Position = UDim2.new(0, startX + column * (labelWidth + spacing), 0, startY + row * (labelHeight + spacing))
		label.BackgroundTransparency = 0.2
		label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextXAlignment = Enum.TextXAlignment.Center
		label.TextYAlignment = Enum.TextYAlignment.Center
		label.Font = Enum.Font.Code
		label.TextSize = 16
		label.TextScaled = true
		label.ClipsDescendants = true
		label.Text = info.text
		label.Parent = container

		local corner = InstanceNew("UICorner")
		corner.CornerRadius = UDim.new(0.2, 0)
		corner.Parent = label

		labelObjects[info.name] = label
	end

	local isMinimized = false
	MouseButtonFix(minimizeButton,function()
		isMinimized = not isMinimized
		if isMinimized then
			for _, label in pairs(labelObjects) do
				label.Visible = false
			end
			container.Size = UDim2.new(0, 520, 0, 40)
			minimizeButton.Text = "+"
		else
			for _, label in pairs(labelObjects) do
				label.Visible = true
			end
			container.Size = UDim2.new(0, 520, 0, 300)
			minimizeButton.Text = "-"
		end
	end)

	local function updateDebugInfo()
		local velocity = rootPart.Velocity
		local position = rootPart.Position
		local health = humanoid.Health
		local maxHealth = humanoid.MaxHealth
		local fov = workspaceService.CurrentCamera.FieldOfView
		local state = humanoid:GetState()
		local tool = character:FindFirstChildOfClass("Tool") and character:FindFirstChildOfClass("Tool").Name or "None"
		local jumpPower = humanoid.JumpPower
		local walkSpeed = humanoid.WalkSpeed

		labelObjects["VelocityLabel"].Text = Format("Velocity\nX: %.2f\nY: %.2f\nZ: %.2f", velocity.X, velocity.Y, velocity.Z)
		labelObjects["PositionLabel"].Text = Format("Position\nX: %.2f\nY: %.2f\nZ: %.2f", position.X, position.Y, position.Z)
		labelObjects["HealthLabel"].Text = Format("Health\n%.2f / %.2f", health, maxHealth)
		labelObjects["FOVLabel"].Text = Format("FOV\n%.2f", fov)
		labelObjects["StateLabel"].Text = Format("State\n%s", tostring(state))
		labelObjects["ToolLabel"].Text = Format("Tool\n%s", tool)
		labelObjects["JumpPowerLabel"].Text = Format("Jump Power\n%.2f", jumpPower)
		labelObjects["WalkSpeedLabel"].Text = Format("Walk Speed\n%.2f", walkSpeed)
	end

	RunService:BindToRenderStep("UpdateDebugInfo", Enum.RenderPriority.Last.Value, updateDebugInfo)
end)

cmd.add({"unchardebug", "uncdebug"}, {"unchardebug (uncdebug)", "disable character debug"}, function()
	if debugUI then
		debugUI:Destroy()
		debugUI = nil
	end
	if debugChar then
		debugChar:Disconnect()
		debugChar = nil
	end
	RunService:UnbindFromRenderStep("UpdateDebugInfo")
end)

cmd.add({"naked"}, {"naked", "no clothing gang"}, function()
	for _,clothes in ipairs(LocalPlayer.Character:GetChildren()) do
		if clothes:IsA("Shirt") or clothes:IsA("Pants") or clothes:IsA("ShirtGraphic") then
			clothes:Destroy()
		end
	end
end)

sRoles = {"mod", "admin", "staff", "dev", "founder", "owner", "supervis", "manager", "management", "executive", "president", "chairman", "chairwoman", "chairperson", "director"}

groupRole = function(player)
	local role = player:GetRoleInGroup(game.CreatorId)
	local info = {Role = role, IsStaff = false}
	if player:IsInGroup(1200769) then
		info.Role = "Roblox Employee"
		info.IsStaff = true
	end
	for _, staffRole in pairs(sRoles) do
		if Find(Lower(role), staffRole) then
			info.IsStaff = true
		end
	end
	return info
end

staffNotifier = nil

cmd.add({"trackstaff"}, {"trackstaff", "Track and notify when a staff member joins the server"}, function()
	if staffNotifier then
		staffNotifier:Disconnect()
	end
	if game.CreatorType == Enum.CreatorType.Group then
		local staffList = {}
		staffNotifier = Players.PlayerAdded:Connect(function(player)
			local info = groupRole(player)
			if info.IsStaff then
				DoNotif(formatUsername(player).." is a "..info.Role)
			end
		end)
		for _, player in pairs(Players:GetPlayers()) do
			local info = groupRole(player)
			if info.IsStaff then
				Insert(staffList, formatUsername(player).." is a "..info.Role)
			end
		end
		DoNotif(#staffList > 0 and Concat(staffList, ",\n") or "Tracking enabled")
	else
		DoNotif("Game is not owned by a Group")
	end
end)

cmd.add({"stoptrackstaff", "untrackstaff"}, {"stoptrackstaff (untrackstaff)", "Stop tracking staff members"}, function()
	if staffNotifier then
		staffNotifier:Disconnect()
	end
	DoNotif("Tracking disabled")
end)

cmd.add({"deletevelocity", "dv", "removevelocity", "removeforces"}, {"deletevelocity (dv, removevelocity, removeforces)", "removes any velocity/force instanceson your character"}, function()
	for _,vel in pairs(LocalPlayer.Character:GetDescendants()) do
		if vel:IsA("BodyVelocity") or vel:IsA("BodyGyro") or vel:IsA("RocketPropulsion") or vel:IsA("BodyThrust") or vel:IsA("BodyAngularVelocity") or vel:IsA("AngularVelocity") or vel:IsA("BodyForce") or vel:IsA("VectorForce") or vel:IsA("LineForce") then
			vel:Destroy()
		end
	end
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
	DoNotif(adminName.." currently has "..commandcount.." commands")
end)

cmd.add({"flyfling","ff"}, {"flyfling (ff)", "makes you fly and fling"}, function()
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

cmd.add({"unflyfling","unff"}, {"unflyfling (unff)", "stops fly and fling"}, function()
	cmd.run({'unwalkfling'})
	if IsOnMobile then
		unmobilefly()
	elseif IsOnPC then
		cmd.run({'unvfly'})
	end
end)

hiddenfling = false
walkFLINGER = nil
connFIXER = nil

cmd.add({"walkfling", "wfling", "wf"}, {"walkfling (wfling,wf)", "probably the best fling lol"}, function()
	if hiddenfling then return end

	DoNotif("Walkfling enabled",2)
	hiddenfling = true

	if not NA_storage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		local detection = InstanceNew("Decal")
		detection.Name = "juisdfj0i32i0eidsuf0iok"
		detection.Parent = NA_storage
	end

	if walkFLINGER then
		walkFLINGER:Disconnect()
	end

	walkFLINGER = RunService.Heartbeat:Connect(function()
		if not hiddenfling then return end

		local lp = Players.LocalPlayer
		local character = lp and lp.Character
		local hrp = character and getRoot(character)
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
	if lp then
		if connFIXER then
			connFIXER:Disconnect()
		end

		connFIXER = lp.CharacterAdded:Connect(function()
			if hiddenfling then
				DoNotif("Re-enabling Walkfling")
			end
		end)
	end
end)

cmd.add({"unwalkfling", "unwfling", "unwf"}, {"unwalkfling (unwfling,unwf)", "stop the walkfling command"}, function()
	if not hiddenfling then return end

	DoNotif("Walkfling disabled",2)
	hiddenfling = false

	if walkFLINGER then
		walkFLINGER:Disconnect()
		walkFLINGER = nil
	end

	if connFIXER then
		connFIXER:Disconnect()
		connFIXER = nil
	end
end)

cmd.add({"rjre", "rejoinrefresh"}, {"rjre (rejoinrefresh)", "Rejoins and teleports you to your previous position"}, function()
	if not DONE then
		DONE = true
		local hrp = getRoot(LocalPlayer.Character)

		if hrp then
			local tpScript = Format([[
                local success, err = pcall(function()
                    repeat Wait() until game:IsLoaded()
                    local lp = game:GetService("Players").LocalPlayer
                    local char
                    local startTime = tick()
                    repeat
                        char = lp.Character or lp.CharacterAdded:Wait()
                        Wait(0.1)
                    until char or (tick() - startTime > 10)
                    
                    if not char then return end
                    
                    local humRP
                    startTime = tick()
                    repeat
                        humRP = char:FindFirstChild("HumanoidRootPart")
                        Wait(0.1)
                    until humRP or (tick() - startTime > 10)
                    
                    if not humRP then return end
                    
                    local targetPos = Vector3.new(%s)
                    local targetCFrame = CFrame.new(%s)
                    
                    startTime = tick()
                    repeat
                        humRP.CFrame = targetCFrame
                        Wait(0.1)
                    until (humRP.Position - targetPos).Magnitude < 10 or (tick() - startTime > 5)
                end)
            ]], tostring(hrp.Position), tostring(hrp.CFrame))

			queueteleport(tpScript)
		end

		Spawn(function()
			pcall(function()
				DoNotif("Rejoining back to the same position...")
			end)

			local success = pcall(function()
				if #Players:GetPlayers() <= 1 then
					LocalPlayer:Kick("\nRejoining...")
					Wait(0.5)
					TeleportService:Teleport(PlaceId, LocalPlayer)
				else
					TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
				end
			end)

			if not success then
				Wait(1)
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
		Wait()
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

	Wait()
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

				Insert(hooks, DetectedMeth)
			end

			if rawget(value, "Variables") and rawget(value, "Process") and typeof(kill) == "function" and not KillMeth then
				KillMeth = kill
				local hook
				hook = hookfunction(KillMeth, function(killFunc)
					if IsDebug then
						DoNotif("Adonis tried to detect: "..tostring(killFunc))
					end
				end)

				Insert(hooks, KillMeth)
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
	local oldChar = getChar()
	local rootPart = getRoot(oldChar)
	if not rootPart then return end

	local respawnCFrame = rootPart.CFrame

	local humanoid = oldChar:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		humanoid.Health = 0
	end

	local newChar = player.CharacterAdded:Wait()
	newChar:WaitForChild("HumanoidRootPart")

	Wait(0.2)

	local newRoot = getRoot(newChar)
	if newRoot then
		local startTime = tick()
		local teleportThreshold = 15

		while tick() - startTime < 0.4 do
			if (newRoot.Position - respawnCFrame.Position).Magnitude > teleportThreshold then
				newRoot.CFrame = respawnCFrame
				startTime = tick()
			end
			Wait(0.1)
		end
	end
end

cmd.add({"accountage","accage"},{"accountage <player> (accage)","Tells the account age of a player in the server"},function(...)
	Username=(...)

	target=getPlr(Username)
	for _, plr in next, target do
		teller=plr.AccountAge
		accountage="The account age of "..nameChecker(plr).." is "..teller

		Wait();

		DoNotif(accountage)
	end
end,true)

cmd.add({"hitboxes"},{"hitboxes","shows all the hitboxes"},function()
	settings():GetService("RenderSettings").ShowBoundingBoxes=true
end)

cmd.add({"unhitboxes"},{"unhitboxes","removes the hitboxes outline"},function()
	settings():GetService("RenderSettings").ShowBoundingBoxes=false
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
			getHum().PlatformStand = false
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
	local arg = (...) or nil
	vFlySpeed = IsOnMobile and (arg or 50) or (arg or 1)
	connectVFlyKey()
	vFlyEnabled = true
	if IsOnMobile then
		Wait()
		DoNotif(adminName.." detected mobile. vFly button added for easier use.",2)
		if vRAHH then
			vRAHH:Destroy()
			vRAHH = nil
		end
		cmd.run({"unfly",''})
		vRAHH = InstanceNew("ScreenGui")
		local btn = InstanceNew("TextButton")
		local speedBox = InstanceNew("TextBox")
		local toggleBtn = InstanceNew("TextButton")
		local corner = InstanceNew("UICorner")
		local corner2 = InstanceNew("UICorner")
		local corner3 = InstanceNew("UICorner")
		local aspect = InstanceNew("UIAspectRatioConstraint")
		NaProtectUI(vRAHH)
		vRAHH.ResetOnSpawn = false
		btn.Parent = vRAHH
		btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
		btn.BackgroundTransparency = 0.1
		btn.Position = UDim2.new(0.9,0,0.5,0)
		btn.Size = UDim2.new(0.08,0,0.1,0)
		btn.Font = Enum.Font.GothamBold
		btn.Text = "vFly"
		btn.TextColor3 = Color3.fromRGB(255,255,255)
		btn.TextSize = 18
		btn.TextWrapped = true
		btn.Active = true
		btn.TextScaled = true
		corner.CornerRadius = UDim.new(0.2,0)
		corner.Parent = btn
		aspect.Parent = btn
		aspect.AspectRatio = 1.0
		speedBox.Parent = vRAHH
		speedBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
		speedBox.BackgroundTransparency = 0.1
		speedBox.AnchorPoint = Vector2.new(0.5, 0)
		speedBox.Position = UDim2.new(0.5, 0, 0, 10)
		speedBox.Size = UDim2.new(0, 75, 0, 35)
		speedBox.Font = Enum.Font.GothamBold
		speedBox.Text = tostring(vFlySpeed)
		speedBox.TextColor3 = Color3.fromRGB(255,255,255)
		speedBox.TextSize = 18
		speedBox.TextWrapped = true
		speedBox.ClearTextOnFocus = false
		speedBox.PlaceholderText = "Speed"
		speedBox.Visible = false
		corner2.CornerRadius = UDim.new(0.2,0)
		corner2.Parent = speedBox
		toggleBtn.Parent = btn
		toggleBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
		toggleBtn.BackgroundTransparency = 0.1
		toggleBtn.Position = UDim2.new(0.8,0,-0.1,0)
		toggleBtn.Size = UDim2.new(0.4,0,0.4,0)
		toggleBtn.Font = Enum.Font.SourceSans
		toggleBtn.Text = "+"
		toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
		toggleBtn.TextScaled = true
		toggleBtn.TextWrapped = true
		toggleBtn.Active = true
		toggleBtn.AutoButtonColor = true
		corner3.CornerRadius = UDim.new(1,0)
		corner3.Parent = toggleBtn
		MouseButtonFix(toggleBtn, function()
			speedBox.Visible = not speedBox.Visible
			toggleBtn.Text = speedBox.Visible and "-" or "+"
		end)
		coroutine.wrap(function()
			MouseButtonFix(btn, function()
				if not vOn then
					local newSpeed = tonumber(speedBox.Text) or vFlySpeed
					vFlySpeed = newSpeed
					speedBox.Text = tostring(vFlySpeed)
					vOn = true
					btn.Text = "UnvFly"
					btn.BackgroundColor3 = Color3.fromRGB(0,170,0)
					mobilefly(vFlySpeed, true)
					getHum().PlatformStand = false
				else
					vOn = false
					btn.Text = "vFly"
					btn.BackgroundColor3 = Color3.fromRGB(170,0,0)
					unmobilefly()
				end
			end)
		end)()
		gui.draggablev2(btn)
		gui.draggablev2(speedBox)
	else
		FLYING = false
		getHum().PlatformStand = false
		Wait()
		DoNotif("Vehicle fly enabled. Press '"..vToggleKey:upper().."' to toggle vehicle flying.")
		sFLY(true)
		speedofthevfly = vFlySpeed
		speedofthefly = vFlySpeed
	end
end, true)

cmd.add({"unvfly", "unvehiclefly"}, {"unvehiclefly (unvfly)", "disable vehicle fly"}, function(bool)
	Wait()
	if IsOnMobile then
		if not bool then
			DoNotif("Mobile vFly Disabled.",2)
		end
		unmobilefly()
	else
		DoNotif("Not flying anymore",2)
		FLYING = false
		getHum().PlatformStand = false
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
			Insert(equippedTools, tool)
		end
	end

	for _, tool in pairs(backpack:GetChildren()) do
		if tool:IsA("Tool") and not Discover(equippedTools, tool) then
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
		if tool:IsA("Tool") and not Discover(equippedTools, tool) then
			tool.Parent = backpack
		end
	end

	for _, tool in pairs(equippedTools) do
		tool.Parent = character
	end
end)

cmd.add({"tweento","tweengoto", "tgoto"}, {"tweengoto <player> (tweento, tgoto)", "Teleportation method that bypasses some anticheats"}, function(...)
	local Username = (...)
	local speaker = Players.LocalPlayer

	local target = getPlr(Username)
	for _, plr in next, target do
		if not plr or not plr.Character then return end

		TweenService:Create(getRoot(speaker.Character), TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = getRoot(plr.Character).CFrame}):Play()
	end
end, true)


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

	local val = InstanceNew("Vector3Value", Tool)
	val.Name = "OGSize3"
	val.Value = toolHnld.Size

	local sb = InstanceNew("SelectionBox")
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

	local val = InstanceNew("Vector3Value", Tool)
	val.Name = "OGSize3"
	val.Value = toolHnld.Size

	local sb = InstanceNew("SelectionBox")
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
		local root = character and getRoot(character)
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

cmd.add({"antivoid2"},{"antivoid2","sets FallenPartsDestroyHeight to -inf"},function()
	game:GetService("Workspace").FallenPartsDestroyHeight = -9e9
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
	Wait()
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent=game:GetService("Workspace")
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

-- leg resize sureeee
--[[cmd.add({"breaklayeredclothing","blc"},{"breaklayeredclothing (blc)","Streches your layered clothing"},function()
	Wait();

	DoNotif("Break layered clothing executed,if you havent already equip shirt,jacket,pants and shoes (Layered Clothing ones)")
	local swimming=false
	local RunService=RunService
	oldgrav=game:GetService("Workspace").Gravity
	game:GetService("Workspace").Gravity=0
	local char=getChar()
	local swimDied=function()
		game:GetService("Workspace").Gravity=oldgrav
		swimming=false
	end
	Humanoid=char:FindFirstChildWhichIsA("Humanoid")
	gravReset=Humanoid.Died:Connect(swimDied)
	enums=Enum.HumanoidStateType:GetEnumItems()
	table.remove(enums,Discover(enums,Enum.HumanoidStateType.None))
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
end)]]

cmd.add({"fpsbooster","lowgraphics","boostfps","lowg"},{"fpsbooster (lowgraphics, boostfps, lowg)","Enables low graphics mode to improve performance."},function()
	local decalsEnabled = false
	local w = game:GetService("Workspace")
	local l = SafeGetService("Lighting")
	local t = w.Terrain

	local function optimizeInstance(v)
		if v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.Reflectance = 0
			if v:IsA("MeshPart") and not decalsEnabled then v.TextureID = "" end
		elseif v:IsA("Decal") or v:IsA("Texture") then
			if not decalsEnabled then v.Transparency = 1 end
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("SpecialMesh") and not decalsEnabled then
			v.TextureId = ""
		elseif v:IsA("ShirtGraphic") and not decalsEnabled then
			v.Graphic = ""
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and not decalsEnabled then
			pcall(function() v[v.ClassName.."Template"] = "" end)
		end
	end

	pcall(function() sethiddenproperty(l,"Technology",Enum.Technology.Compatibility) end)
	pcall(function() sethiddenproperty(t,"Decoration",false) end)
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = false
	l.FogEnd = math.huge
	l.Brightness = 0
	pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)

	for _,v in ipairs(w:GetDescendants()) do optimizeInstance(v) end
	for _,e in ipairs(l:GetChildren()) do
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
	local gui = InstanceNew("ScreenGui")
	gui.Name = "AntiLagGUI"
	gui.ResetOnSpawn = false
	NaProtectUI(gui)

	local frame = InstanceNew("Frame")
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Size = UDim2.new(0.3, 0, 0.5, 0)
	frame.Position = UDim2.new(0.5, 0, 0.35, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Parent = gui

	local topbar = InstanceNew("Frame")
	topbar.Name = "TopBar"
	topbar.Size = UDim2.new(1, 0, 0, 30)
	topbar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	topbar.BorderSizePixel = 0
	topbar.Parent = frame

	local title = InstanceNew("TextLabel")
	title.Text = "AntiLag Settings"
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 18
	title.TextColor3 = Color3.new(1,1,1)
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, -60, 1, 0)
	title.Position = UDim2.new(0, 10, 0, 0)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = topbar

	local closeBtn = InstanceNew("TextButton")
	closeBtn.Size = UDim2.new(0, 24, 0, 24)
	closeBtn.Position = UDim2.new(1, -28, 0, 3)
	closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.new(1, 1, 1)
	closeBtn.Font = Enum.Font.SourceSansBold
	closeBtn.TextSize = 16
	closeBtn.Parent = topbar

	local minimizeBtn = InstanceNew("TextButton")
	minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
	minimizeBtn.Position = UDim2.new(1, -56, 0, 3)
	minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	minimizeBtn.Text = "-"
	minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
	minimizeBtn.Font = Enum.Font.SourceSansBold
	minimizeBtn.TextSize = 16
	minimizeBtn.Parent = topbar

	local content = InstanceNew("Frame")
	content.Name = "Content"
	content.Size = UDim2.new(1, 0, 1, -30)
	content.Position = UDim2.new(0, 0, 0, 30)
	content.BackgroundTransparency = 1
	content.Parent = frame

	local scrollingFrame = InstanceNew("ScrollingFrame", content)
	scrollingFrame.Size = UDim2.new(1, 0, 1, -60)
	scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrollingFrame.ScrollBarThickness = 6
	scrollingFrame.BackgroundTransparency = 1

	local layout = InstanceNew("UIListLayout", scrollingFrame)
	layout.Padding = UDim.new(0, 5)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	local padding = InstanceNew("UIPadding", scrollingFrame)
	padding.PaddingTop = UDim.new(0, 10)
	padding.PaddingBottom = UDim.new(0, 10)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)

	local defaultSettings = {
		Players = {
			["Ignore Me"] = true,
			["Ignore Others"] = true
		},
		Meshes = {
			Destroy = false,
			LowDetail = true
		},
		Images = {
			Invisible = true,
			LowDetail = true,
			Destroy = true
		},
		Other = {
			["No Particles"] = true,
			["No Camera Effects"] = true,
			["No Explosions"] = true,
			["No Clothes"] = true,
			["Low Water Graphics"] = true,
			["No Shadows"] = true,
			["Low Rendering"] = true,
			["Low Quality Parts"] = true
		}
	}

	local userSettings = table.clone(defaultSettings)

	local function updateCanvas()
		task.wait()
		scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
	end

	local function createSection(sectionName, keys)
		local dropdown = InstanceNew("TextButton")
		dropdown.Size = UDim2.new(1, -10, 0, 32)
		dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		dropdown.TextColor3 = Color3.new(1, 1, 1)
		dropdown.Font = Enum.Font.SourceSansBold
		dropdown.TextSize = 20
		dropdown.Text = "▼ "..sectionName
		dropdown.AutoButtonColor = false
		dropdown.Parent = scrollingFrame

		local container = InstanceNew("Frame")
		container.Size = UDim2.new(1, -10, 0, 0)
		container.BackgroundTransparency = 1
		container.ClipsDescendants = true
		container.Parent = scrollingFrame

		local subLayout = InstanceNew("UIListLayout", container)
		subLayout.Padding = UDim.new(0, 4)
		subLayout.SortOrder = Enum.SortOrder.LayoutOrder

		local isOpen = false

		local function updateDropdown()
			container.Size = UDim2.new(1, -10, 0, isOpen and #keys * 36 or 0)
			dropdown.Text = (isOpen and "▲ " or "▼ ")..sectionName
			updateCanvas()
		end

		for _, key in pairs(keys) do
			local btn = InstanceNew("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 32)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 18
			btn.AutoButtonColor = false
			btn.Text = key..": "..tostring(userSettings[sectionName][key])
			btn.BackgroundColor3 = userSettings[sectionName][key] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(120, 30, 30)
			btn.Parent = container

			MouseButtonFix(btn,function()
				userSettings[sectionName][key] = not userSettings[sectionName][key]
				btn.Text = key..": "..tostring(userSettings[sectionName][key])
				btn.BackgroundColor3 = userSettings[sectionName][key] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(120, 30, 30)
			end)
		end

		MouseButtonFix(dropdown,function()
			isOpen = not isOpen
			updateDropdown()
		end)

		updateDropdown()
	end

	for section, data in pairs(userSettings) do
		local keys = {}
		for k in pairs(data) do Insert(keys, k) end
		createSection(section, keys)
	end

	local runBtn = InstanceNew("TextButton")
	runBtn.Size = UDim2.new(1, -20, 0, 45)
	runBtn.Position = UDim2.new(0, 10, 1, -50)
	runBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	runBtn.TextColor3 = Color3.new(1, 1, 1)
	runBtn.Font = Enum.Font.SourceSansBold
	runBtn.TextSize = 20
	runBtn.Text = "Run AntiLag"
	runBtn.Parent = content

	MouseButtonFix(runBtn,function()
		getgenv().Settings = userSettings
		gui:Destroy()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/low%20detail"))()
	end)

	MouseButtonFix(closeBtn,function()
		gui:Destroy()
	end)

	local minimized = false
	MouseButtonFix(minimizeBtn,function()
		minimized = not minimized
		content.Visible = not minimized
		minimizeBtn.Text = minimized and "+" or "-"
	end)
	gui.draggablev2(frame)
end)

local annoyLoop = false

cmd.add({"annoy"}, {"annoy <player>", "Annoys the given player"}, function(...)
	if annoyLoop then
		DoNotif("Already annoying someone. Use :unannoy first.", 3)
		return
	end

	annoyLoop = false
	Wait(0.2)
	annoyLoop = true

	local user = ...
	local targets = getPlr(user)

	if #targets == 0 then
		DoNotif("No target found.", 3)
		return
	end

	local target = targets[1]
	if not target.Character or not getRoot(target.Character) then
		DoNotif("Target has no character or root part.", 3)
		annoyLoop = false
		return
	end

	local myChar = getChar()
	local myRoot = myChar and getRoot(myChar)
	local originalCFrame = myRoot and myRoot.CFrame

	if not myRoot then
		DoNotif("Your character has no root part.", 3)
		annoyLoop = false
		return
	end

	math.randomseed(tick())

	repeat
		Wait(0.05)

		local targetChar = target.Character
		local targetRoot = targetChar and getRoot(targetChar)
		myChar = getChar()
		myRoot = myChar and getRoot(myChar)

		if not targetRoot or not myRoot then
			break
		end

		local offset = Vector3.new(math.random(-3,3), math.random(0,2), math.random(-3,3))
		myRoot.CFrame = targetRoot.CFrame + offset

		RunService.RenderStepped:Wait()
	until not annoyLoop

	if myRoot and originalCFrame then
		myRoot.CFrame = originalCFrame
	end
end, true)

cmd.add({"unannoy"}, {"unannoy", "Stops the annoy command"}, function()
	annoyLoop = false
end)

cmd.add({"deleteinvisparts","deleteinvisibleparts","dip"},{"deleteinvisparts (deleteinvisibleparts,dip)","Deletes invisible parts"},function()
	for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency==1 and v.CanCollide then
			v:Destroy()
		end
	end
end)

local shownParts = {}

cmd.add({"invisibleparts","invisparts"},{"invisibleparts (invisparts)","Shows invisible parts"},function()
	for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency == 1 then
			local alreadyShown = false
			for _, p in ipairs(shownParts) do
				if p == v then
					alreadyShown = true
					break
				end
			end
			if not alreadyShown then
				Insert(shownParts, v)
			end
			v.Transparency = 0
		end
	end
end)

cmd.add({"uninvisibleparts","uninvisparts"},{"uninvisibleparts (uninvisparts)","Makes parts affected by invisparts return to normal"},function()
	for _, v in ipairs(shownParts) do
		if v and v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
	table.clear(shownParts)
end)

cmd.add({"replicationlag", "backtrack"}, {"replicationlag (backtrack)", "Set IncomingReplicationLag"}, function(num)
	settings():GetService("NetworkSettings").IncomingReplicationLag = tonumber(num) or 0
end, true)

cmd.add({"sleepon"}, {"sleepon", "Enable AllowSleep"}, function()
	settings():GetService("PhysicsSettings").AllowSleep = true
end, true)

cmd.add({"unsleepon"}, {"unsleepon", "Disable AllowSleep"}, function()
	settings():GetService("PhysicsSettings").AllowSleep = false
end, true)

cmd.add({"throttle"}, {"throttle", "Set PhysicsEnvironmentalThrottle (1 = default, 2 = disabled)"}, function(num)
	settings():GetService("PhysicsSettings").PhysicsEnvironmentalThrottle = tonumber(num) or 1
end, true)

cmd.add({"quality"}, {"quality", "Set Rendering QualityLevel (0-10)"}, function(level)
	settings().Rendering.QualityLevel = tonumber(level) or 5
end, true)

cmd.add({"logphysics"}, {"logphysics", "Enable Physics Error Logging"}, function()
	settings():GetService("NetworkSettings").PrintPhysicsErrors = true
end, true)

cmd.add({"nologphysics"}, {"nologphysics", "Disable Physics Error Logging"}, function()
	settings():GetService("NetworkSettings").PrintPhysicsErrors = false
end, true)

cmd.add({"norender"},{"norender","Disable 3d Rendering to decrease the amount of CPU the client uses"},function()
	RunService:Set3dRenderingEnabled(false)
end)

cmd.add({"render"},{"render","Enable 3d Rendering"},function()
	RunService:Set3dRenderingEnabled(true)
end)

oofing = false

cmd.add({"loopoof"},{"loopoof","Loops everyone's character sounds (everyone can hear)"},function()
	oofing = true
	repeat Wait(0.1)
		for _, player in ipairs(Players:GetPlayers()) do
			local char = player.Character
			local head = char and char:FindFirstChild("Head")
			if head then
				for _, child in ipairs(head:GetChildren()) do
					if child:IsA("Sound") and not child.Playing then
						child.Playing = true
					end
				end
			end
		end
	until not oofing
end)

cmd.add({"unloopoof"},{"unloopoof","Stops the oof chaos"},function()
	oofing = false
end)

cmd.add({"strengthen"},{"strengthen","Makes your character more dense (CustomPhysicalProperties)"},function(...)
	local args={...}
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child:IsA("BasePart") then
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
		if child:IsA("BasePart") then
			child.CustomPhysicalProperties=PhysicalProperties.new(0.7,0.3,0.5)
		end
	end
end)

cmd.add({"weaken"},{"weaken","Makes your character less dense"},function(...)
	local args={...}
	for _,child in pairs(Player.Character:GetDescendants()) do
		if child:IsA("BasePart") then
			if args[1] then
				child.CustomPhysicalProperties=PhysicalProperties.new(-args[1],0.3,0.5)
			else
				child.CustomPhysicalProperties=PhysicalProperties.new(0,0.3,0.5)
			end
		end
	end
end,true)

cmd.add({"seat"}, {"seat", "Finds a seat and automatically sits on it"}, function()
	local character = getChar()
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and getRoot(character)

	if not humanoid or not root then
		DoNotif("Your character or humanoid is invalid", 3)
		return
	end

	local seats = {}
	for _, v in ipairs(game:GetDescendants()) do
		if v:IsA("Seat") and not v.Occupant then
			Insert(seats, v)
		end
	end

	if #seats == 0 then
		DoNotif("No available seats found in the game", 3)
		return
	end

	table.sort(seats, function(a, b)
		return (a.Position - root.Position).Magnitude < (b.Position - root.Position).Magnitude
	end)

	local seat = seats[1]
	if seat then
		seat:Sit(humanoid)
		DoNotif("Sat in the nearest seat", 2)
	else
		DoNotif("Failed to sit in a seat", 3)
	end
end)

cmd.add({"vehicleseat", "vseat"}, {"vehicleseat (vseat)", "Sits you in a vehicle seat, useful for trying to find cars in games"}, function()
	local character = getChar()
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and getRoot(character)

	if not humanoid or not root then
		DoNotif("Your character or humanoid is invalid", 3)
		return
	end

	local vehicleSeats = {}
	for _, v in ipairs(game:GetDescendants()) do
		if v:IsA("VehicleSeat") and not v.Occupant then
			Insert(vehicleSeats, v)
		end
	end

	if #vehicleSeats == 0 then
		DoNotif("No available VehicleSeats found in the game", 3)
		return
	end

	table.sort(vehicleSeats, function(a, b)
		return (a.Position - root.Position).Magnitude < (b.Position - root.Position).Magnitude
	end)

	local vseat = vehicleSeats[1]
	if vseat then
		vseat:Sit(humanoid)
		DoNotif("Sat in the nearest VehicleSeat", 2)
	else
		DoNotif("Failed to sit in a VehicleSeat", 3)
	end
end)

cmd.add({"copytools","ctools"},{"copytools <player> (ctools)","Copies the tools the given player has"},function(...)
	local targets = getPlr(...)
	local lp = Players.LocalPlayer
	if not lp then return end
	local backpack = lp:FindFirstChildOfClass("Backpack")
	if not backpack then return end
	for _,plr in ipairs(targets) do
		local tBackpack = plr:FindFirstChildOfClass("Backpack")
		if tBackpack then
			for _,tool in ipairs(tBackpack:GetChildren()) do
				if tool:IsA("Tool") or tool:IsA("HopperBin") then
					tool:Clone().Parent = backpack
				end
			end
		end
	end
end,true)

cmd.add({"localtime", "yourtime"}, {"localtime (yourtime)", "Shows your current time"}, function()
	local time = os.date("*t")
	local clock = Format("%02d:%02d:%02d", time.hour, time.min, time.sec)
	DoNotif("Your Local Time Is: "..clock)
end)

cmd.add({"localdate", "yourdate"}, {"localdate (yourdate)", "Shows your current date"}, function()
	local time = os.date("*t")
	local dateStr = Format("%02d/%02d/%04d", time.day, time.month, time.year)
	DoNotif("Your Local Date Is: "..dateStr)
end)

cmd.add({"cartornado", "ctornado"}, {"cartornado (ctornado)", "Tornados a car just sit in the car"}, function()
	local Player = Players.LocalPlayer
	local RunService = RunService
	local Workspace = game:GetService("Workspace")

	repeat RunService.RenderStepped:Wait() until Player.Character
	local Character = Player.Character

	local SPart = InstanceNew("Part")
	SPart.Anchored = true
	SPart.CanCollide = true
	SPart.Size = Vector3.new(1, 100, 1)
	SPart.Transparency = 0.4
	SPart.Parent = Workspace

	RunService.Stepped:Connect(function()
		local hum = Character and getHum()
		if hum and Character.PrimaryPart then
			local rayOrigin = Character.PrimaryPart.Position + Character.PrimaryPart.CFrame.LookVector * 6
			local rayDir = Vector3.new(0, -4, 0)
			local ray = Ray.new(rayOrigin, rayDir)
			local part = Workspace:FindPartOnRayWithIgnoreList(ray, {Character})
			if part then
				SPart.CFrame = Character.PrimaryPart.CFrame + Character.PrimaryPart.CFrame.LookVector * 6
			end
		end
	end)

	SPart.Touched:Connect(function(hit)
		if not hit:IsA("Seat") then return end

		local torso = getTorso(Character)
		if not torso then return end

		local hum = Character:FindFirstChildOfClass("Humanoid")
		if not hum then return end

		local flyv = InstanceNew("BodyVelocity")
		local flyg = InstanceNew("BodyGyro")
		local speed = 50
		local lastSpeed = speed
		local maxSpeed = 100
		local isRunning = false
		local f = 0
		local isFlying = true

		flyv.Parent = torso
		flyv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

		flyg.Parent = torso
		flyg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		flyg.P = 1000
		flyg.D = 50

		hum.PlatformStand = true

		hum.Changed:Connect(function()
			isRunning = hum.MoveDirection.Magnitude > 0
		end)

		Spawn(function()
			while isFlying do
				flyg.CFrame = Workspace.CurrentCamera.CFrame * CFrame.Angles(-math.rad(f * 50 * speed / maxSpeed), 0, 0)
				flyv.Velocity = Workspace.CurrentCamera.CFrame.LookVector * speed
				Wait(0.1)

				if speed < 0 then
					speed = 0
					f = 0
				end

				if isRunning then
					speed = lastSpeed
				else
					if speed ~= 0 then
						lastSpeed = speed
					end
					speed = 0
				end
			end
		end)

		Wait(0.3)
		hit:Sit(hum)
		SPart:Destroy()

		local seat = hum.SeatPart
		if not seat then return end

		local vehicleModel = seat.Parent
		while vehicleModel and not vehicleModel:IsA("Model") do
			vehicleModel = vehicleModel.Parent
		end

		if vehicleModel then
			for _, v in pairs(vehicleModel:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide = false
				end
			end
		end

		Wait(0.2)
		speed = 80

		local spin = InstanceNew("BodyAngularVelocity")
		spin.MaxTorque = Vector3.new(0, math.huge, 0)
		spin.AngularVelocity = Vector3.new(0, 2000, 0)
		spin.Parent = Character.PrimaryPart
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

cmd.add({"respawn", "re"}, {"respawn (re)", "Respawn your character"}, function()
	respawn()
end)

antiSITcon = nil

cmd.add({"antisit"},{"antisit","Prevents the player from sitting"},function()
	local function noSit(character)
		local humanoid = character:WaitForChild("Humanoid", 5)
		if humanoid then
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			humanoid.Sit = true
		end
	end

	if LocalPlayer.Character then
		noSit(LocalPlayer.Character)
	end

	if antiSITcon then
		antiSITcon:Disconnect()
		antiSITcon = nil
	end

	antiSITcon = LocalPlayer.CharacterAdded:Connect(noSit)
	DoNotif("Anti sit enabled", 3)
end)

cmd.add({"unantisit"},{"unantisit","Allows the player to sit again"},function()
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		humanoid.Sit = false
	end

	if antiSITcon then
		antiSITcon:Disconnect()
		antiSITcon = nil
	end

	DoNotif("Anti sit disabled", 3)
end)

cmd.add({"antikick", "nokick", "bypasskick", "bk"}, {"antikick (nokick, bypasskick, bk)", "Bypass Kick on Most Games"}, function()
	local getRawMetatable = (debug and debug.getmetatable) or getrawmetatable
	local setReadOnly = setreadonly or (
		make_writeable and function(t, readOnly)
			if readOnly then
				make_readonly(t)
			else
				make_writeable(t)
			end
		end
	)

	if not getRawMetatable or not setReadOnly or not newcclosure then
		DoNotif("Required metatable functions are not available", 3)
		return
	end

	local meta = getRawMetatable(game)
	if not meta then
		DoNotif("Failed to get the metatable of the game object", 3)
		return
	end

	local oldNamecall = meta.__namecall
	local oldIndex = meta.__index
	local oldNewIndex = meta.__newindex

	setReadOnly(meta, false)

	meta.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if method and self == player then
			local m = method:lower()
			if m == "kick" then
				DoNotif("A kick attempt was blocked.")
				return
			elseif m == "destroy" then
				DoNotif("An attempt to destroy the player was blocked.")
				return
			end
		end
		return oldNamecall(self, ...)
	end)

	meta.__index = newcclosure(function(self, key)
		if self == player then
			if key == "Kick" then
				DoNotif("Access to Kick was blocked.")
				return function() end
			elseif key == "Destroy" then
				DoNotif("Access to Destroy was blocked.")
				return function() end
			end
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

acftpCON = {}
acftpCONN = nil
acftpCFrames = {}

cmd.add({"anticframeteleport","acframetp","acftp"},{"anticframeteleport (acframetp,acftp)","Prevents scripts from teleporting you by resetting your CFrame"},function()
	for _, con in pairs(acftpCON) do
		con:Disconnect()
	end
	acftpCON = {}
	acftpCFrames = {}

	if acftpCONN then acftpCONN:Disconnect() acftpCONN = nil end

	local character = LocalPlayer and LocalPlayer.Character
	if not character then
		DoNotif("Your character is invalid.", 3)
		return
	end

	for _, part in pairs(character:GetChildren()) do
		if part:IsA("BasePart") then
			acftpCFrames[part] = part.CFrame
			acftpCON[part] = part:GetPropertyChangedSignal("CFrame"):Connect(function()
				if part:IsDescendantOf(character) and part.CFrame ~= acftpCFrames[part] then
					part.CFrame = acftpCFrames[part]
				end
			end)
		end
	end

	acftpCONN = RunService.RenderStepped:Connect(function()
		for part in pairs(acftpCFrames) do
			if part and part:IsDescendantOf(character) then
				acftpCFrames[part] = part.CFrame
			end
		end
	end)

	DoNotif("Anti CFrame Teleport enabled", 3)
end)

cmd.add({"unanticframeteleport","unacframetp","unacftp"},{"unanticframeteleport (unacframetp,unacftp)","Disables Anti CFrame Teleport"},function()
	for _, con in pairs(acftpCON) do
		con:Disconnect()
	end
	acftpCON = {}
	acftpCFrames = {}

	if acftpCONN then
		acftpCONN:Disconnect()
		acftpCONN = nil
	end

	DoNotif("Anti CFrame Teleport disabled", 3)
end)

cmd.add({"lay"},{"lay","zzzzzzzz"},function()
	local Human=getHum()
	if not Human then return end
	Human.Sit=true
	Wait(.1)
	Human.RootPart.CFrame=Human.RootPart.CFrame*CFrame.Angles(math.pi*.5,0,0)
	for _,v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
	end
end)

cmd.add({"trip"},{"trip","get up NOW"},function()
	getChar():FindFirstChildOfClass("Humanoid"):ChangeState(0)
	getRoot(getChar()).Velocity=getRoot(getChar()).CFrame.LookVector*25
end)

noTripCon = nil
charTRIP = nil

cmd.add({"antitrip"}, {"antitrip", "no tripping today bruh"}, function()
	local function doTRIPPER(char)
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = getRoot(char)
		if not (hum and root) then return end

		if noTripCon then
			noTripCon:Disconnect()
		end

		noTripCon = hum.FallingDown:Connect(function()
			root.Velocity = Vector3.zero
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end)
	end

	if LocalPlayer.Character then
		doTRIPPER(LocalPlayer.Character)
	end

	if charTRIP then
		charTRIP:Disconnect()
	end

	charTRIP = LocalPlayer.CharacterAdded:Connect(doTRIPPER)
	DoNotif("Antitrip Enabled",2)
end)

cmd.add({"unantitrip"}, {"unantitrip", "tripping allowed now"}, function()
	if noTripCon then
		noTripCon:Disconnect()
		noTripCon = nil
	end
	if charTRIP then
		charTRIP:Disconnect()
		charTRIP = nil
	end
	DoNotif("Antitrip Disabled",2)
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
	for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("BasePart") then
			local dec=InstanceNew("Texture",v)
			dec.Texture="rbxassetid://48715260"
			dec.Face="Top"
			dec.StudsPerTileU="1"
			dec.StudsPerTileV="1"
			dec.Transparency=v.Transparency
			v.Material="Plastic"
			local dec2=InstanceNew("Texture",v)
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
	local sky=InstanceNew("Sky",Lighting)
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
	local Camera = game:GetService("Workspace").CurrentCamera

	local Player = Players.LocalPlayer
	local Mouse = Player:GetMouse()
	local Toggled = false
	local Mode = "FFA"
	local LastMode = nil

	local GUI = InstanceNew("ScreenGui")
	local On = InstanceNew("TextLabel")
	local uicorner = InstanceNew("UICorner")
	NaProtectUI(GUI)
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
		if stationaryRespawn and getHum() and getHum().Health == 0 then
			if not hasPosition then
				spawnPosition = getRoot(getChar()).CFrame
				hasPosition = true
			end
			needsRespawning = true
		end

		if needsRespawning then
			if getChar() and getRoot(getChar()) then getRoot(getChar()).CFrame = spawnPosition end
		end
	end

	RunService.Stepped:Connect(handleRespawn)

	LocalPlayer.CharacterAdded:Connect(function()
		Wait(0.6)
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

cmd.add({"hamster"}, {"hamster <number>", "Hamster ball"}, function(...)
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local Camera = game:GetService("Workspace").CurrentCamera

	local SPEED_MULTIPLIER = (...) or 30
	local JUMP_POWER = 60
	local JUMP_GAP = 0.3

	local character = game:GetService("Players").LocalPlayer.Character

	for i, v in ipairs(character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end

	local ball = getRoot(character)
	ball.Shape = Enum.PartType.Ball
	ball.Size = Vector3.new(5, 5, 5)
	local humanoid = character:WaitForChild("Humanoid")

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances = {character}

	local tc = RunService.RenderStepped:Connect(function(delta)
		ball.CanCollide = true
		humanoid.PlatformStand = true
		if UserInputService:GetFocusedTextBox() then return end

		if IsOnMobile then
			local direction = ctrlModule:GetMoveVector()
			if direction.Magnitude > 0 then
				local right = Camera.CFrame.RightVector
				local forward = Camera.CFrame.LookVector
				ball.RotVelocity = ball.RotVelocity + (-right * direction.Z * delta * SPEED_MULTIPLIER)
				ball.RotVelocity = ball.RotVelocity + (forward * direction.X * delta * SPEED_MULTIPLIER)
			end
		else
			if UserInputService:IsKeyDown("W") then
				ball.RotVelocity -= Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
			end
			if UserInputService:IsKeyDown("A") then
				ball.RotVelocity -= Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
			end
			if UserInputService:IsKeyDown("S") then
				ball.RotVelocity += Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
			end
			if UserInputService:IsKeyDown("D") then
				ball.RotVelocity += Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
			end
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		local result = game:GetService("Workspace"):Raycast(
			ball.Position,
			Vector3.new(0, -((ball.Size.Y / 2) + JUMP_GAP), 0),
			params
		)
		if result then
			ball.Velocity = ball.Velocity + Vector3.new(0, JUMP_POWER, 0)
		end
	end)

	Camera.CameraSubject = ball
	humanoid.Died:Connect(function() tc:Disconnect() end)
end, true)

local antiAFKConnection = nil

cmd.add({"antiafk","noafk"},{"antiafk (noafk)","Prevents you from being kicked for being AFK"},function()
	if not antiAFKConnection then
		local player = Players.LocalPlayer
		local virtualUser = SafeGetService("VirtualUser")

		antiAFKConnection = player.Idled:Connect(function()
			virtualUser:Button2Down(Vector2.new(0, 0), game:GetService("Workspace").CurrentCamera.CFrame)
			Wait(1)
			virtualUser:Button2Up(Vector2.new(0, 0), game:GetService("Workspace").CurrentCamera.CFrame)
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
tpConnections = {}

cmd.add({"clicktp", "tptool"}, {"clicktp (tptool)", "Teleport where your mouse is"}, function()
	local TweenService = SafeGetService("TweenService")
	local player = Players.LocalPlayer
	local mouse = player:GetMouse()
	if tpUI then
		tpUI:Destroy()
		tpUI = nil
		for _, conn in ipairs(tpConnections) do
			conn:Disconnect()
		end
		tpConnections = {}
	end

	tpUI = InstanceNew("ScreenGui")
	NaProtectUI(tpUI)

	local clickTpButton = InstanceNew("TextButton")
	clickTpButton.Size = UDim2.new(0, 130, 0, 40)
	clickTpButton.AnchorPoint = Vector2.new(0.5, 0)
	clickTpButton.Position = UDim2.new(0.45, 0, 0.1, 0)
	clickTpButton.Text = "Enable Click TP"
	clickTpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	clickTpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	clickTpButton.BorderSizePixel = 0
	clickTpButton.Parent = tpUI

	local clickTpCorner = InstanceNew("UICorner")
	clickTpCorner.CornerRadius = UDim.new(0, 10)
	clickTpCorner.Parent = clickTpButton

	local tweenTpButton = InstanceNew("TextButton")
	tweenTpButton.Size = UDim2.new(0, 130, 0, 40)
	tweenTpButton.AnchorPoint = Vector2.new(0.5, 0)
	tweenTpButton.Position = UDim2.new(0.55, 0, 0.1, 0)
	tweenTpButton.Text = "Enable Tween TP"
	tweenTpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tweenTpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	tweenTpButton.BorderSizePixel = 0
	tweenTpButton.Parent = tpUI

	local tweenTpCorner = InstanceNew("UICorner")
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
		local downConn = mouse.Button1Down:Connect(function()
			initialMousePosition = Vector2.new(mouse.X, mouse.Y)
		end)
		Insert(tpConnections, downConn)

		local upConn = mouse.Button1Up:Connect(function()
			if initialMousePosition then
				local currentMousePosition = Vector2.new(mouse.X, mouse.Y)
				local distance = (currentMousePosition - initialMousePosition).Magnitude
				if distance <= dragThreshold then
					onClick(mouse)
				end
			end
			initialMousePosition = nil
		end)
		Insert(tpConnections, upConn)
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

	gui.draggablev2(clickTpButton)
	gui.draggablev2(tweenTpButton)
end)

cmd.add({"unclicktp", "untptool"}, {"unclicktp (untptool)", "Remove teleport buttons"}, function()
	if tpUI then
		tpUI:Destroy()
		tpUI = nil
	end
	for _, conn in ipairs(tpConnections) do
		conn:Disconnect()
	end
	tpConnections = {}
end)

cmd.add({"dex"},{"dex","Using this you can see the parts / guis / scripts etc with this. A really good and helpful script."},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/DexByMoonMobile"))()
end)

cmd.add({"Decompiler"},{"Decompiler","Allows you to decompile LocalScript/ModuleScript's"},function()
	Spawn(function()
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
				Wait(.5 - time_elapsed)
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
	for i=48,57 do Insert(charset,string.char(i)) end
	for i=65,90 do Insert(charset,string.char(i)) end
	for i=97,122 do Insert(charset,string.char(i)) end
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

local aFLING = {on = false, c = {}}
function addFLINGER(c) Insert(aFLING.c, c) end

cmd.add({"antifling"}, {"antifling", "makes other players non-collidable with you"}, function()
	if aFLING.on then for _, cn in ipairs(aFLING.c) do cn:Disconnect() end aFLING.c = {} end
	aFLING.on = true
	addFLINGER(RunService.Stepped:Connect(function()
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= LocalPlayer and pl.Character then
				for _, p in ipairs(pl.Character:GetDescendants()) do
					if p:IsA("BasePart") then p.CanCollide = false end
				end
			end
		end
	end))
	local function setNo(p)
		if p:IsA("BasePart") then
			p.CanCollide = false
			addFLINGER(p:GetPropertyChangedSignal("CanCollide"):Connect(function()
				if p.CanCollide then p.CanCollide = false end
			end))
		end
	end
	local function hook(c)
		for _, p in ipairs(c:GetDescendants()) do setNo(p) end
		addFLINGER(c.DescendantAdded:Connect(setNo))
	end
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl ~= LocalPlayer then
			if pl.Character then hook(pl.Character) end
			addFLINGER(pl.CharacterAdded:Connect(hook))
		end
	end
	addFLINGER(Players.PlayerAdded:Connect(function(pl)
		if pl ~= LocalPlayer then addFLINGER(pl.CharacterAdded:Connect(hook)) end
	end))
	DoNotif("Antifling Enabled")
end)

cmd.add({"unantifling"}, {"unantifling", "restores collision for other players"}, function()
	if aFLING.on then
		for _, cn in ipairs(aFLING.c) do cn:Disconnect() end
		aFLING.c = {}
		aFLING.on = false
	end
	DoNotif("Antifling Disabled")
end)

cmd.add({"gravitygun"},{"gravitygun","Probably the best gravity gun script thats fe"},function()
	Wait();
	DoNotif("Wait a few seconds for it to load")
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/gravity%20gun"))()
end)

cmd.add({"lockws","lockworkspace"},{"lockws (lockworkspace)","Locks the whole workspace"},function()
	for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
		v.Locked=true
	end
end)

cmd.add({"unlockws","unlockworkspace"},{"unlockws (unlockworkspace)","Unlocks the whole workspace"},function()
	for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
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
		local subject = game:GetService("Workspace").CurrentCamera.CameraSubject
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
local camera=game:GetService("Workspace").CurrentCamera

local uis=UserInputService

local active=false
function UpdateAutoRotate(BOOL)
	humanoid.AutoRotate=BOOL
end

local GameSettings = UserSettings():GetService("UserGameSettings")

local ShiftLockConnection = nil
local OriginalRotationType = nil
local ShiftLockEnabled = false

function EnableShiftLock()
	if ShiftLockEnabled then return end

	local success, currentRotation = pcall(function()
		return GameSettings.RotationType
	end)

	if success then
		OriginalRotationType = currentRotation
	end

	ShiftLockConnection = RunService.RenderStepped:Connect(function()
		pcall(function()
			GameSettings.RotationType = Enum.RotationType.CameraRelative
		end)
	end)

	ShiftLockEnabled = true
	DoNotif("ShiftLock Enabled", 2)
end

function DisableShiftLock()
	if not ShiftLockEnabled then return end

	if ShiftLockConnection then
		ShiftLockConnection:Disconnect()
		ShiftLockConnection = nil
	end

	pcall(function()
		GameSettings.RotationType = OriginalRotationType or Enum.RotationType.MovementRelative
	end)

	ShiftLockEnabled = false
	DoNotif("ShiftLock Disabled", 2)
end

cmd.add({"shiftlock","sl"}, {"shiftlock (sl)", "Toggles shiftlock"}, function()
	if IsOnMobile then
		loadstring(game:HttpGet("https://github.com/ltseverydayyou/uuuuuuu/blob/main/shiftlock?raw=true"))()
	else
		EnableShiftLock()
	end
end)

cmd.add({"unshiftlock","unsl"}, {"unshiftlock (unsl)", "Disables shiftlock"}, function()
	if IsOnPC then
		DisableShiftLock()
	end
end)

-- if you're reading this use the command 'cmdloop enable' to enable the command loop
-- example 'cmdloop enable shiftlock hidden' (hides notification to display) or set hidden to just anything as long as argument 2 is not empty 💀

cmd.add({"enable"}, {"enable", "Enables a specific CoreGui"}, function(...)
	local args = {...}
	local enableName = args[1]
	local hiddenNotif = args[2] -- scuffed way lmao
	local buttons = {}

	for _, coreGuiType in ipairs(Enum.CoreGuiType:GetEnumItems()) do
		Insert(buttons, {
			Text = coreGuiType.Name,
			Callback = function()
				StarterGui:SetCoreGuiEnabled(coreGuiType, true)
				if coreGuiType == Enum.CoreGuiType.Chat or coreGuiType == Enum.CoreGuiType.All then
					loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/EnableChat.lua"))()
				end
			end
		})
	end

	Insert(buttons, {
		Text = "Shiftlock",
		Callback = function()
			LocalPlayer.DevEnableMouseLock = true
		end
	})

	if enableName and enableName ~= "" then
		local found = false
		for _, button in ipairs(buttons) do
			if Match(button.Text:lower(), enableName:lower()) then
				button.Callback()
				if not hiddenNotif then
					DoNotif("CoreGui Enabled: "..button.Text.." has been enabled.", 3)
				end
				found = true
				break
			end
		end
		if not found then
			DoNotif("No matching CoreGui element found for: "..enableName, 3)
		end
	else
		Insert(buttons, {
			Text = "Cancel",
			Callback = function() end
		})
		Notify({
			Title = "Enable a Specific Core Gui Element",
			Buttons = buttons
		})
	end
end, true)

cmd.add({"disable"}, {"disable", "Disables a specific CoreGui"}, function(...)
	local args = {...}
	local disableName = args[1]
	local hiddenNotif = args[2] -- scuffed way lmao
	local buttons = {}

	for _, coreGuiType in ipairs(Enum.CoreGuiType:GetEnumItems()) do
		Insert(buttons, {
			Text = coreGuiType.Name,
			Callback = function()
				StarterGui:SetCoreGuiEnabled(coreGuiType, false)
			end
		})
	end

	Insert(buttons, {
		Text = "Shiftlock",
		Callback = function()
			LocalPlayer.DevEnableMouseLock = false
		end
	})

	if disableName and disableName ~= "" then
		local found = false
		for _, button in ipairs(buttons) do
			if Match(button.Text:lower(), disableName:lower()) then
				button.Callback()
				if not hiddenNotif then
					DoNotif("CoreGui Disabled: "..button.Text.." has been disabled.", 3)
				end
				found = true
				break
			end
		end
		if not found then
			DoNotif("No matching CoreGui element found for: "..disableName, 3)
		end
	else
		Insert(buttons, {
			Text = "Cancel",
			Callback = function() end
		})
		Notify({
			Title = "Disable a Specific Core Gui Element",
			Buttons = buttons
		})
	end
end,true)

cmd.add({"reverb", "reverbcontrol"}, {"reverb (reverbcontrol)", "Manage sound reverb settings"}, function()
	local reverbButtons = {}
	for _, reverbType in ipairs(Enum.ReverbType:GetEnumItems()) do
		Insert(reverbButtons, {
			Text = reverbType.Name,
			Callback = function()
				SoundService.AmbientReverb = reverbType
			end
		})
	end

	Insert(reverbButtons, {
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
		Insert(cameraTypeButtons, {
			Text = cameraType.Name,
			Callback = function()
				game:GetService("Workspace").CurrentCamera.CameraType = cameraType
			end
		})
	end

	Insert(cameraTypeButtons, {
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
	chamsEnabled = false
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name ~= Players.LocalPlayer.Name then
			ESP(player)
		end
	end

	if not getgenv().ESPJoinConnection then
		getgenv().ESPJoinConnection = Players.PlayerAdded:Connect(function(player)
			if ESPenabled and player.Name ~= Players.LocalPlayer.Name then
				ESP(player)
			end
		end)
	end
end)

cmd.add({"chams"}, {"chams", "ESP but without the text :shock:"}, function()
	ESPenabled = true
	chamsEnabled = true
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name ~= Players.LocalPlayer.Name then
			ESP(player)
		end
	end

	if not getgenv().ESPJoinConnection then
		getgenv().ESPJoinConnection = Players.PlayerAdded:Connect(function(player)
			if ESPenabled and player.Name ~= Players.LocalPlayer.Name then
				ESP(player)
			end
		end)
	end
end)

cmd.add({"locate"}, {"locate <username>", "locate where the players are"}, function(...)
	local username = (...)
	local target = getPlr(username)
	for _, plr in next, target do
		if plr then
			ESP(plr, true)
		end
	end
end, true)

cmd.add({"unesp", "unchams"}, {"unesp (unchams)", "Disables esp/chams"}, function()
	ESPenabled = false
	chamsEnabled = false
	removeAllESP()

	if getgenv().ESPJoinConnection then
		getgenv().ESPJoinConnection:Disconnect()
		getgenv().ESPJoinConnection = nil
	end
end)

cmd.add({"unlocate"}, {"unlocate <player>"}, function(username)
	local target = getPlr(username)
	for _, plr in next, target do
		if plr then
			discPlrESP(plr)
		end
	end
end, true)

cmd.add({"crash"},{"crash","crashes ur client lol"},function()
	while true do end
end)

cmd.add({"creep", "scare"}, {"creep <player> (scare)", "Teleports from a player behind them and under the floor to the top"}, function(...)
	local username = ...
	local targets = getPlr(username)
	if #targets == 0 then
		DoNotif("No target found.", 3)
		return
	end

	local target = targets[1]
	local character = getChar()
	if not character then
		DoNotif("Your character is invalid.", 3)
		return
	end

	local root = getRoot(character)
	if not root then
		DoNotif("Your character's root is invalid.", 3)
		return
	end

	if not target.Character or not target.Character:FindFirstChild("Humanoid") or not target.Character:FindFirstChild("Humanoid").RootPart then
		DoNotif("Target's character is invalid.", 3)
		return
	end

	root.CFrame = target.Character.Humanoid.RootPart.CFrame * CFrame.new(0, -10, 4)
	Wait()

	if connections and connections["noclip"] then
		lib.disconnect("noclip")
	end

	lib.connect("noclip", RunService.Stepped:Connect(function()
		local char = getChar()
		if not char then return end
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end))
	Wait()

	root.Anchored = true
	Wait()

	local tweenService = TweenService
	local tweenInfo = TweenInfo.new(1000, Enum.EasingStyle.Linear)
	local tween = tweenService:Create(root, tweenInfo, {CFrame = CFrame.new(0, 10000, 0)})
	tween:Play()
	wait(1.5)
	tween:Pause()

	root.Anchored = false
	Wait()

	lib.disconnect("noclip")
end, true)

cmd.add({"netless","net"},{"netless (net)","Executes netless which makes scripts more stable"},function()
	for i,v in next,getChar():GetDescendants() do
		if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then 
			RunService.Heartbeat:connect(function()
				v.Velocity=Vector3.new(-30,0,0)
			end)
		end
	end

	Wait();

	DoNotif("Netless has been activated,re-run this script if you die")
end)

cmd.add({"reset","die"},{"reset (die)","Makes your health be 0"},function()
	Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
	Player.Character:FindFirstChildOfClass("Humanoid").Health=0
end)

cmd.add({"runanim", "playanim", "anim"}, {"runanim <id> (playanim,anim)", "Plays an animation by ID"}, function(id)
	local hum = getHum()
	if not hum then return end

	local a = hum:FindFirstChildOfClass("Animator") or InstanceNew("Animator", hum)
	local anim = InstanceNew("Animation")
	anim.AnimationId = "rbxassetid://"..tostring(id)

	local t = a:LoadAnimation(anim)
	t:Play()

	Delay(t.Length, function()
		t:Stop()
		t:Destroy()
		anim:Destroy()
	end)
end,true)

local storedAnims = {}

cmd.add({"setkiller", "killeranim"}, {"setkiller (killeranim)", "Sets killer animation set"}, function()
	if not IsR6() then DoNotif("command requires R6") return end
	local hum = getHum()
	if not hum then return end

	local animate = hum.Parent:FindFirstChild("Animate")
	if not animate then return end

	if not storedAnims[hum] then
		local store = {}
		for _, obj in pairs(animate:GetChildren()) do
			if obj:IsA("StringValue") then
				local anim = obj:FindFirstChildWhichIsA("Animation")
				if anim then
					store[obj.Name] = anim.AnimationId
				end
			end
		end
		storedAnims[hum] = store
	end

	local function setAnim(name, id)
		local obj = animate:FindFirstChild(name)
		if obj and obj:IsA("StringValue") then
			local anim = obj:FindFirstChildWhichIsA("Animation")
			if anim then
				anim.AnimationId = "rbxassetid://"..tostring(id)
			end
		end
	end

	setAnim("walk", 252557606)
	setAnim("run", 252557606)
	setAnim("jump", 165167557)
	setAnim("fall", 97170520)
end)

cmd.add({"setpsycho", "psychoanim"}, {"setpsycho (psychoanim)", "Sets psycho animation set"}, function()
	if not IsR6() then DoNotif("command requires R6") return end
	local hum = getHum()
	if not hum then return end

	local animate = hum.Parent:FindFirstChild("Animate")
	if not animate then return end

	if not storedAnims[hum] then
		local store = {}
		for _, obj in pairs(animate:GetChildren()) do
			if obj:IsA("StringValue") then
				local anim = obj:FindFirstChildWhichIsA("Animation")
				if anim then
					store[obj.Name] = anim.AnimationId
				end
			end
		end
		storedAnims[hum] = store
	end

	local function setAnim(name, id)
		local obj = animate:FindFirstChild(name)
		if obj and obj:IsA("StringValue") then
			local anim = obj:FindFirstChildWhichIsA("Animation")
			if anim then
				anim.AnimationId = "rbxassetid://"..tostring(id)
			end
		end
	end

	setAnim("idle", 33796059)
	setAnim("walk", 95415492)
	setAnim("run", 95415492)
	setAnim("jump", 165167557)
	setAnim("fall", 97170520)

	local animator = hum:FindFirstChildOfClass("Animator")
	if not animator then return end

	Spawn(function()
		while hum and hum.Parent and hum.Health > 0 do
			for _, track in pairs(animator:GetPlayingAnimationTracks()) do
				if track.Animation.AnimationId == "rbxassetid://33796059" and track.Speed < 50 then
					track:AdjustSpeed(50)
				end
			end
			Wait(0.2)
		end
	end)
end)

cmd.add({"resetanims", "defaultanims", "animsreset"}, {"resetanims (defaultanims,animsreset)", "Restores your previous animations"}, function()
	if not IsR6() then DoNotif("command requires R6") return end
	local hum = getHum()
	if not hum then return end

	local animate = hum.Parent:FindFirstChild("Animate")
	if not animate then return end

	local store = storedAnims[hum]
	if not store then return end

	for name, id in pairs(store) do
		local obj = animate:FindFirstChild(name)
		if obj and obj:IsA("StringValue") then
			local anim = obj:FindFirstChildWhichIsA("Animation")
			if anim then
				anim.AnimationId = id
			end
		end
	end

	storedAnims[hum] = nil
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
	for _, plr in next, Player do
		if plr~=nil and not Admin[plr.UserId] then
			Admin[plr.UserId]={plr=plr}
			ChatMessage("[Nameless Admin] You've got admin. Prefix: ';'",plr.Name)
			wait(0.2)
			DoNotif(nameChecker(plr).." has now been whitelisted to use commands",15)
		else
			DoNotif("No player found")
		end
	end
end,true)

cmd.add({"unadmin"},{"unadmin <player>","removes someone from being admin"},function(...)
	function ChatMessage(Message,Whisper)
		lib.LocalPlayerChat(Message,Whisper or "All")
	end
	local Player=getPlr(...)
	for _, plr in next, Player do
		if plr~=nil and Admin[plr.UserId] then
			Admin[plr.UserId]=nil
			ChatMessage("You can no longer use commands",plr.Name)
			DoNotif(nameChecker(plr).." is no longer an admin",15)
		else
			DoNotif("Player not found")
		end
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
		Wait();

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
	Wait();

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
	Wait();

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
	Wait();

	DoNotif("Searching for server with best ping")

	local Servers = JSONDecode(HttpService, game:HttpGetAsync("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
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
		DoNotif(Format("Serverhopping to server with ping: %s ms", tostring(BestPing)))
		TeleportService:TeleportToPlaceInstance(PlaceId, BestJobId)
	else
		DoNotif("No better server found")
	end
end)

autoRejoinConnection = nil

cmd.add({"autorejoin", "autorj"}, {"autorejoin (autorj)", "Rejoins the server if you get kicked / disconnected"}, function()
	if autoRejoinConnection then
		autoRejoinConnection:Disconnect()
		autoRejoinConnection = nil
	end

	local function handleRejoin()
		if #Players:GetPlayers() <= 1 then
			Players.LocalPlayer:Kick("Rejoining...")
			Wait()
			TeleportService:Teleport(PlaceId, Players.LocalPlayer)
		else
			TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
		end
	end

	autoRejoinConnection = GuiService.ErrorMessageChanged:Connect(function()
		Spawn(handleRejoin)
	end)

	DoNotif("Auto Rejoin is now enabled!")
end)

cmd.add({"unautorejoin", "unautorj"}, {"unautorejoin (unautorj)", "Disables auto rejoin command"}, function()
	if autoRejoinConnection then
		autoRejoinConnection:Disconnect()
		autoRejoinConnection = nil
		DoNotif("Auto Rejoin is now disabled!")
	else
		DoNotif("Auto Rejoin is already disabled!")
	end
end)

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

	local FunctionSpy=InstanceNew("ScreenGui")
	local Main=InstanceNew("Frame")
	local LeftPanel=InstanceNew("ScrollingFrame")
	local UIListLayout=InstanceNew("UIListLayout")
	local example=InstanceNew("TextButton")
	local name=InstanceNew("TextLabel")
	local UIPadding=InstanceNew("UIPadding")
	local FakeTitle=InstanceNew("TextButton")
	local Title=InstanceNew("TextLabel")
	local clear=InstanceNew("ImageButton")
	local RightPanel=InstanceNew("ScrollingFrame")
	local output=InstanceNew("TextLabel")
	local clear_2=InstanceNew("TextButton")
	local copy=InstanceNew("TextButton")
	local UICorner = InstanceNew("UICorner")
	local UIStroke = InstanceNew("UIStroke")

	NaProtectUI(FunctionSpy)

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

	local function addStroke(instance, color, thick)
		local stroke = UIStroke:Clone()
		stroke.Color = color
		stroke.Thickness = thick
		stroke.Parent = instance
	end

	addRoundedCorners(Main, 10)
	addStroke(Main, Color3.fromRGB(255, 255, 255), 2)

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

	FakeTitle.Parent=Main
	FakeTitle.BackgroundColor3=Color3.fromRGB(40,40,40)
	FakeTitle.BorderSizePixel=0
	FakeTitle.Position=UDim2.new(0,225,0,-26)
	FakeTitle.Size=UDim2.new(0.166044772,0,0,26)
	FakeTitle.Font=Enum.Font.GothamMedium
	FakeTitle.Text="FunctionSpy"
	FakeTitle.TextColor3=Color3.fromRGB(255,255,255)
	FakeTitle.TextSize=14.000

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

	local gradient = InstanceNew("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
	}
	gradient.Rotation = 45
	gradient.Parent = Title

	clear.Parent=Title
	clear.BackgroundTransparency=1.000
	clear.Position=UDim2.new(1,-28,0,2)
	clear.Size=UDim2.new(0,24,0,24)
	clear.ZIndex=2
	clear.Image="rbxassetid://3926305904"
	clear.ImageRectOffset=Vector2.new(924,724)
	clear.ImageRectSize=Vector2.new(36,36)

	MouseButtonFix(clear,function()
		if getgenv().functionspy then
			getgenv().functionspy.shutdown()
		end
	end)

	RightPanel.Parent=Main
	RightPanel.Active=true
	RightPanel.BackgroundColor3=Color3.fromRGB(35,35,35)
	RightPanel.BorderSizePixel=0
	RightPanel.Position=UDim2.new(0.349999994,0,0,0)
	RightPanel.Size=UDim2.new(0.649999976,0,1,0)
	RightPanel.CanvasSize=UDim2.new(0,0,0,0)
	RightPanel.HorizontalScrollBarInset=Enum.ScrollBarInset.ScrollBar
	RightPanel.ScrollBarThickness=3

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

	clear_2.Parent=RightPanel
	clear_2.BackgroundColor3=Color3.fromRGB(30,30,30)
	clear_2.BorderSizePixel=0
	clear_2.Position=UDim2.new(0.0631457642,0,0.826219559,0)
	clear_2.Size=UDim2.new(0,140,0,33)
	clear_2.Font=Enum.Font.SourceSans
	clear_2.Text="Clear logs"
	clear_2.TextColor3=Color3.fromRGB(255,255,255)
	clear_2.TextSize=14.000

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

	gui.draggablev2(Main,Title)

	local shadow = InstanceNew("ImageLabel")
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
		getgenv().functionspy={
			instance=Main.Parent;
			logging=true;
			connections={};
		}

		getgenv().functionspy.shutdown=function()
			for i,v in pairs(getgenv().functionspy.connections) do
				v:Disconnect()
			end
			getgenv().functionspy.connections={}
			getgenv().functionspy=nil
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
			Insert(connections,MouseButtonFix(btn,function()
				Main.RightPanel.output.Text=text
				currentInfo=text
			end))
		end

		MouseButtonFix(clear,function()
			if getgenv().functionspy then
				getgenv().functionspy.shutdown()
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
							if getgenv().functionspy then
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
									if getgenv().functionspy.logging==true then
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
						if getgenv().functionspy then
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
								if getgenv().functionspy.logging==true then
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
		local script=InstanceNew('LocalScript',FakeTitle)

		Insert(getgenv().functionspy.connections,FakeTitle.MouseEnter:Connect(function()
			if getgenv().functionspy.logging==true then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif getgenv().functionspy.logging==false then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		Insert(getgenv().functionspy.connections,FakeTitle.MouseMoved:Connect(function()
			if getgenv().functionspy.logging==true then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif getgenv().functionspy.logging==false then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		Insert(getgenv().functionspy.connections,MouseButtonFix(FakeTitle,function()
			getgenv().functionspy.logging=not getgenv().functionspy.logging
			if getgenv().functionspy.logging==true then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(0,1,0)}):Play()
			elseif getgenv().functionspy.logging==false then
				TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,0,0)}):Play()
			end
		end))

		Insert(getgenv().functionspy.connections,FakeTitle.MouseLeave:Connect(function()
			TweenService:Create(FakeTitle.Parent.Title,TweenInfo.new(0.3),{TextColor3=Color3.new(1,1,1)}):Play()
		end))
	end
	coroutine.wrap(BIPVKVC_fake_script)()
	function PRML_fake_script()
		MouseButtonFix(clear,function()
			getgenv().functionspy.shutdown()
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
			getHum().PlatformStand = false
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
	local arg = (...) or nil
	flySpeed = IsOnMobile and (arg or 50) or (arg or 1)
	connectFlyKey()
	flyEnabled = true
	if IsOnMobile then
		Wait()
		DoNotif(adminName.." detected mobile. Fly button added for easier use.",2)
		if mFlyBruh then
			mFlyBruh:Destroy()
			mFlyBruh = nil
		end
		cmd.run({"unvfly",''})
		mFlyBruh = InstanceNew("ScreenGui")
		local btn = InstanceNew("TextButton")
		local speedBox = InstanceNew("TextBox")
		local toggleBtn = InstanceNew("TextButton")
		local corner = InstanceNew("UICorner")
		local corner2 = InstanceNew("UICorner")
		local corner3 = InstanceNew("UICorner")
		local aspect = InstanceNew("UIAspectRatioConstraint")
		NaProtectUI(mFlyBruh)
		mFlyBruh.ResetOnSpawn = false
		btn.Parent = mFlyBruh
		btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
		btn.BackgroundTransparency = 0.1
		btn.Position = UDim2.new(0.9,0,0.5,0)
		btn.Size = UDim2.new(0.08,0,0.1,0)
		btn.Font = Enum.Font.GothamBold
		btn.Text = "Fly"
		btn.TextColor3 = Color3.fromRGB(255,255,255)
		btn.TextSize = 18
		btn.TextWrapped = true
		btn.Active = true
		btn.TextScaled = true
		corner.CornerRadius = UDim.new(0.2,0)
		corner.Parent = btn
		aspect.Parent = btn
		aspect.AspectRatio = 1.0
		speedBox.Parent = mFlyBruh
		speedBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
		speedBox.BackgroundTransparency = 0.1
		speedBox.AnchorPoint = Vector2.new(0.5, 0)
		speedBox.Position = UDim2.new(0.5, 0, 0, 10)
		speedBox.Size = UDim2.new(0, 75, 0, 35)
		speedBox.Font = Enum.Font.GothamBold
		speedBox.Text = tostring(flySpeed)
		speedBox.TextColor3 = Color3.fromRGB(255,255,255)
		speedBox.TextSize = 18
		speedBox.TextWrapped = true
		speedBox.ClearTextOnFocus = false
		speedBox.PlaceholderText = "Speed"
		speedBox.Visible = false
		corner2.CornerRadius = UDim.new(0.2,0)
		corner2.Parent = speedBox
		toggleBtn.Parent = btn
		toggleBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
		toggleBtn.BackgroundTransparency = 0.1
		toggleBtn.Position = UDim2.new(0.8,0,-0.1,0)
		toggleBtn.Size = UDim2.new(0.4,0,0.4,0)
		toggleBtn.Font = Enum.Font.SourceSans
		toggleBtn.Text = "+"
		toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
		toggleBtn.TextScaled = true
		toggleBtn.TextWrapped = true
		toggleBtn.Active = true
		toggleBtn.AutoButtonColor = true
		corner3.CornerRadius = UDim.new(1,0)
		corner3.Parent = toggleBtn
		MouseButtonFix(toggleBtn, function()
			speedBox.Visible = not speedBox.Visible
			toggleBtn.Text = speedBox.Visible and "-" or "+"
		end)
		coroutine.wrap(function()
			MouseButtonFix(btn, function()
				if not mOn then
					local newSpeed = tonumber(speedBox.Text) or flySpeed
					flySpeed = newSpeed
					speedBox.Text = tostring(flySpeed)
					mOn = true
					btn.Text = "Unfly"
					btn.BackgroundColor3 = Color3.fromRGB(0,170,0)
					mobilefly(flySpeed)
				else
					mOn = false
					btn.Text = "Fly"
					btn.BackgroundColor3 = Color3.fromRGB(170,0,0)
					unmobilefly()
				end
			end)
		end)()
		gui.draggablev2(btn)
		gui.draggablev2(speedBox)
	else
		FLYING = false
		getHum().PlatformStand = false
		Wait()
		DoNotif("Fly enabled. Press '"..toggleKey:upper().."' to toggle flying.")
		sFLY()
		speedofthevfly = flySpeed
		speedofthefly = flySpeed
	end
end, true)

cmd.add({"unfly"}, {"unfly", "Disable flight"}, function(bool)
	Wait()
	if IsOnMobile then
		if not bool then
			DoNotif("Mobile Fly Disabled.",2)
		end
		unmobilefly()
	else
		DoNotif("Not flying anymore",2)
		FLYING = false
		getHum().PlatformStand = false
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

	tflyCORE = InstanceNew("Part", game:GetService("Workspace").CurrentCamera)
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

	local Weld = InstanceNew("Weld", tflyCORE)
	Weld.Part0 = tflyCORE
	Weld.Part1 = Humanoid.RootPart
	Weld.C0 = CFrame.new(0, 0, 0)

	local pos = InstanceNew("BodyPosition", tflyCORE)
	local gyro = InstanceNew("BodyGyro", tflyCORE)
	pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	pos.position = tflyCORE.Position
	gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	gyro.cframe = tflyCORE.CFrame

	repeat
		Wait()
		Humanoid.PlatformStand = true
		local newPosition = gyro.cframe - gyro.cframe.p + pos.position

		if IsOnPC then
			local camera = game:GetService("Workspace").CurrentCamera
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
				local camera = game:GetService("Workspace").CurrentCamera
				newPosition = newPosition + (direction.X * camera.CFrame.RightVector * speed)
				newPosition = newPosition - (direction.Z * camera.CFrame.LookVector * speed)
			end
		end

		pos.position = newPosition.p
		gyro.cframe = game:GetService("Workspace").CurrentCamera.CoordinateFrame
	until not TFlyEnabled

	if gyro then gyro:Destroy() end
	if pos then pos:Destroy() end
	Humanoid.PlatformStand = false
end, true)

cmd.add({"untfly", "untweenfly"}, {"untfly (untweenfly)", "Disables tween flying"}, function()
	TFlyEnabled = false
	for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
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

bangCon = nil
originalPos = nil
platformPart = nil
activationTime = nil

cmd.add({"antibang"}, {"antibang", "prevents users to bang you (still WORK IN PROGRESS)"}, function()
	if bangCon then
		bangCon:Disconnect()
		bangCon = nil
	end
	local root = getRoot(LocalPlayer.Character)
	if not root then return end
	originalPos = root.CFrame
	local orgHeight = game:GetService("Workspace").FallenPartsDestroyHeight
	local anims = {"rbxassetid://5918726674", "rbxassetid://148840371", "rbxassetid://698251653", "rbxassetid://72042024", "rbxassetid://189854234", "rbxassetid://106772613", "rbxassetid://10714360343"}
	local inVoid = false
	local targetPlayer = nil
	local toldNotif = false
	local activationTime = nil

	LocalPlayer.CharacterAdded:Connect(function(char)
		Wait(1)
		root = getRoot(char)
	end)

	bangCon = game:GetService("RunService").Stepped:Connect(function()
		for _, p in pairs(game:GetService("Players"):GetPlayers()) do
			if p ~= LocalPlayer and p.Character and getRoot(p.Character) then
				if (getRoot(p.Character).Position - root.Position).Magnitude <= 10 then
					local tracks = p.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()
					for _, t in pairs(tracks) do
						if Discover(anims, t.Animation.AnimationId) then
							if not inVoid then
								inVoid = true
								activationTime = tick()
								targetPlayer = p
								game:GetService("Workspace").FallenPartsDestroyHeight = 0/1/0
								platformPart = InstanceNew("Part")
								platformPart.Size = Vector3.new(9999, 1, 9999)
								platformPart.Anchored = true
								platformPart.CanCollide = true
								platformPart.Transparency = 1
								platformPart.Position = Vector3.new(0, orgHeight - 30, 0)
								platformPart.Parent = game:GetService("Workspace").CurrentCamera
								root.CFrame = CFrame.new(Vector3.new(0, orgHeight - 25, 0))
								if not toldNotif then
									toldNotif = true
									DoNotif("Antibang activated | Target: "..nameChecker(targetPlayer), 2)
								end
							end
						end
					end
				end
			end
		end

		if inVoid then
			if (not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Humanoid") or targetPlayer.Character.Humanoid.Health <= 0)
				or (activationTime and tick() - activationTime >= 10) then
				inVoid = false
				targetPlayer = nil
				root.CFrame = originalPos
				root.Anchored = true
				Wait()
				root.Anchored = false
				game:GetService("Workspace").FallenPartsDestroyHeight = orgHeight
				if platformPart then
					platformPart:Destroy()
					platformPart = nil
				end
				if toldNotif then
					toldNotif = false
					if activationTime and tick() - activationTime >= 10 then
						DoNotif("Antibang deactivated (timeout)", 2)
					else
						DoNotif("Antibang deactivated", 2)
					end
				end
			end
		end
	end)
	DoNotif("Antibang Enabled",3)
end)

cmd.add({"unantibang"}, {"unantibang", "disables antibang"}, function()
	if bangCon then
		bangCon:Disconnect()
		bangCon = nil
	end
	if platformPart then
		platformPart:Destroy()
		platformPart = nil
	end
	DoNotif("Antibang Disabled",3)
end)

cmd.add({"orbit"}, {"orbit <player> <distance>", "Orbit around a player"}, function(p, d)
	lib.disconnect("orbit")
	local targets = getPlr(p)
	if #targets == 0 then return end
	local target = targets[1]
	local tchar = target.Character
	local char = getChar()
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
		hrp.CFrame = CFrame.new(sinX * dist, 0, sinZ * dist) * (hrp.CFrame - hrp.CFrame.p) + thrp.CFrame.p
	end))
end, true)

cmd.add({"uporbit"}, {"uporbit <player> <distance>", "Orbit around a player on the Y axis"}, function(p, d)
	lib.disconnect("orbit")
	local targets = getPlr(p)
	if #targets == 0 then return end
	local target = targets[1]
	local tchar = target.Character
	local char = getChar()
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
		hrp.CFrame = CFrame.new(sinX * dist, sinY * dist, 0) * (hrp.CFrame - hrp.CFrame.p) + thrp.CFrame.p
	end))
end, true)

cmd.add({"unorbit"}, {"unorbit", "Stop orbiting"}, function()
	lib.disconnect("orbit")
end)

cmd.add({"freezewalk"},{"freezewalk","Freezes your character on the server but lets you walk on the client"},function()
	local Character=getChar()
	local Root=getRoot(Character)

	if IsR6() then
		local Clone=Root:Clone()
		Root:Destroy()
		Clone.Parent=Character
	else
		Character.LowerTorso.Anchored=true
		Character.LowerTorso.Root:Destroy()
	end
	DoNotif("freezewalk is activated,reset to stop it")
end)

fcBTNTOGGLE= nil

cmd.add({"freecam","fc","fcam"},{"freecam [speed] (fc,fcam)","Enable free camera"},function(...)
	argg=(...)
	local speed=argg or 5

	if connections["freecam"] then
		lib.disconnect("freecam")
		camera.CameraSubject = character
		wrap(function() character.PrimaryPart.Anchored = false end)
	end

	if fcBTNTOGGLE then fcBTNTOGGLE:Destroy() fcBTNTOGGLE=nil end

	function runFREECAM()
		local dir={w=false,a=false,s=false,d=false}
		local cf=InstanceNew("CFrameValue")
		local camPart=InstanceNew("Part")
		camPart.Transparency=1
		camPart.Anchored=true
		camPart.CFrame=camera.CFrame
		wrap(function()
			character.PrimaryPart.Anchored=true
		end)

		lib.connect("freecam",RunService.RenderStepped:Connect(function(dt)
			local primaryPart=camPart
			camera.CameraSubject=primaryPart

			local x,y,z=0,0,0
			if dir.w then z=-1*speed end
			if dir.a then x=-1*speed end
			if dir.s then z=1*speed end
			if dir.d then x=1*speed end
			if dir.q then y=-1*speed end
			if dir.e then y=1*speed end

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
	end

	if IsOnMobile then
		if fcBTNTOGGLE then fcBTNTOGGLE:Destroy() fcBTNTOGGLE = nil end

		fcBTNTOGGLE = InstanceNew("ScreenGui")
		local btn = InstanceNew("TextButton")
		local speedBox = InstanceNew("TextBox")
		local toggleBtn = InstanceNew("TextButton")
		local corner = InstanceNew("UICorner")
		local corner2 = InstanceNew("UICorner")
		local corner3 = InstanceNew("UICorner")
		local aspect = InstanceNew("UIAspectRatioConstraint")

		NaProtectUI(fcBTNTOGGLE)
		fcBTNTOGGLE.ResetOnSpawn = false

		btn.Parent = fcBTNTOGGLE
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		btn.BackgroundTransparency = 0.1
		btn.Position = UDim2.new(0.9, 0, 0.5, 0)
		btn.Size = UDim2.new(0.08, 0, 0.1, 0)
		btn.Font = Enum.Font.GothamBold
		btn.Text = "FC"
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 18
		btn.TextWrapped = true
		btn.Active = true
		btn.TextScaled = true

		corner.CornerRadius = UDim.new(0.2, 0)
		corner.Parent = btn

		aspect.Parent = btn
		aspect.AspectRatio = 1.0

		speedBox.Parent = fcBTNTOGGLE
		speedBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
		speedBox.BackgroundTransparency = 0.1
		speedBox.AnchorPoint = Vector2.new(0.5, 0)
		speedBox.Position = UDim2.new(0.5, 0, 0, 10)
		speedBox.Size = UDim2.new(0, 75, 0, 35)
		speedBox.Font = Enum.Font.GothamBold
		speedBox.Text = tostring(speed)
		speedBox.TextColor3 = Color3.fromRGB(255,255,255)
		speedBox.TextSize = 18
		speedBox.TextWrapped = true
		speedBox.ClearTextOnFocus = false
		speedBox.PlaceholderText = "Speed"
		speedBox.Visible = false

		corner2.CornerRadius = UDim.new(0.2, 0)
		corner2.Parent = speedBox

		toggleBtn.Parent = btn
		toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		toggleBtn.BackgroundTransparency = 0.1
		toggleBtn.Position = UDim2.new(0.9, 0, -0.1, 0)
		toggleBtn.Size = UDim2.new(0.4, 0, 0.4, 0)
		toggleBtn.Font = Enum.Font.SourceSans
		toggleBtn.Text = "+"
		toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggleBtn.TextSize = 14
		toggleBtn.TextWrapped = true
		toggleBtn.Active = true
		toggleBtn.AutoButtonColor = true

		corner3.CornerRadius = UDim.new(1, 0)
		corner3.Parent = toggleBtn

		MouseButtonFix(toggleBtn, function()
			speedBox.Visible = not speedBox.Visible
			toggleBtn.Text = speedBox.Visible and "-" or "+"
		end)

		coroutine.wrap(function()
			MouseButtonFix(btn, function()
				if not mOn then
					local newSpeed = tonumber(speedBox.Text) or 5
					if newSpeed then
						speed = newSpeed
						speedBox.Text = tostring(speed)
					else
						speed = 5
						speedBox.Text = tostring(speed)
					end
					mOn = true
					btn.Text = "UNFC"
					btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
					runFREECAM()
				else
					mOn = false
					btn.Text = "FC"
					btn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
					if connections["freecam"] then
						lib.disconnect("freecam")
					end
					camera.CameraSubject = character
					wrap(function() character.PrimaryPart.Anchored = false end)
				end
			end)
		end)()

		gui.draggablev2(btn)
		gui.draggablev2(speedBox)
	else
		DoNotif("Freecam is activated, use WASD to move around", 2)
		runFREECAM()
	end	
end,true)

cmd.add({"unfreecam","unfc","unfcam"},{"unfreecam (unfc,unfcam)","Disable free camera"},function()
	lib.disconnect("freecam")
	camera.CameraSubject=character
	wrap(function()
		character.PrimaryPart.Anchored=false
	end)
	if fcBTNTOGGLE then fcBTNTOGGLE:Destroy() fcBTNTOGGLE = nil end
end)

cmd.add({"nohats","drophats"},{"nohats (drophats)","Drop all of your hats"},function()
	for _,hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") then
			hat:FindFirstChildWhichIsA("Weld",true):Destroy()
		end
	end
end)

function getAllTools()
	local tools={}
	local backpack=localPlayer:FindFirstChildWhichIsA("Backpack")
	if backpack then
		for i,v in pairs(backpack:GetChildren()) do
			if v:IsA("Tool") then
				Insert(tools,v)
			end
		end
	end
	for i,v in pairs(character:GetChildren()) do
		if v:IsA("Tool") then
			Insert(tools,v)
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
			Wait(0.05)
			root.Anchored = false
			Wait(0.05)
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

cmd.add({"hide", "unshow"}, {"hide <player> (unshow)", "places the selected player to lighting"}, function(...)
	Wait()
	DoNotif("Hid the player")
	local Username = (...)
	local target = getPlr(Username)
	for _, plr in next, target do
		if plr and plr.Character then
			local A_1 = "/mute "..plr.Name
			local A_2 = "All"
			lib.LocalPlayerChat(A_1, A_2)
			plr.Character.Parent = Lighting
		end
	end
end, true)

cmd.add({"unhide", "show"}, {"show <player> (unhide)", "places the selected player back to workspace"}, function(...)
	Wait()
	DoNotif("Unhid the player")
	local Username = (...)
	local target = getPlr(Username)
	for _, plr in next, target do
		if plr and plr.Character then
			local A_1 = "/unmute "..plr.Name
			local A_2 = "All"
			lib.LocalPlayerChat(A_1, A_2)
			plr.Character.Parent = game:GetService("Workspace")
		end
	end
end, true)

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
			for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
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
		local animation=InstanceNew("Animation")
		animation.AnimationId="rbxassetid://"..dances[math.random(1,#dances)]
		theanim=getChar():FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
		theanim:Play()
	else
		local animation=InstanceNew("Animation")
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

cmd.add({"animspoofer","animationspoofer","spoofanim","animspoof"},{"animspoofer (animationspoofer,spoofanim,animspoof)","Loads up an animation spoofer,spoofs animations that use rbxassetid"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Animation%20Spoofer"))()
end)

local transCONN

cmd.add({"bodytransparency","btransparency", "bodyt"}, {"bodytransparency <number> (btransparency,bodyt)", "Sets LocalTransparencyModifier of bodyparts to whatever number you put (0-1)"}, function(v)
	local vv = tonumber(v) or 0
	if transCONN then transCONN:Disconnect() end

	transCONN = RunService.RenderStepped:Connect(function()
		local char = LocalPlayer.Character
		if char then
			for _, p in ipairs(char:GetChildren()) do
				if p:IsA("BasePart") and p.Name:lower() ~= "head" then
					p.LocalTransparencyModifier = vv
				end
			end
		end
	end)

	DoNotif("Body transparency set to "..vv,1.5)
end)

cmd.add({"unbodytransparency", "unbtransparency", "unbodyt"}, {"unbodytransparency (unbtransparency,unbodyt)", "Stops transparency loop"}, function()
	if transCONN then
		transCONN:Disconnect()
		transCONN = nil
	else
		DoNotif("No loop running",2)
	end
end)

local animCONN

cmd.add({"animationspeed", "animspeed", "aspeed"}, {"animationspeed <speed> (animspeed,aspeed)", "Adjusts the speed of currently playing animations"}, function(speed)
	local targetSpeed = tonumber(speed) or 1

	if animCONN then
		animCONN:Disconnect()
	end

	animCONN = RunService.Heartbeat:Connect(function()
		local character = getChar()
		local humanoid = character:FindFirstChildOfClass("Humanoid") or character:FindFirstChildOfClass("AnimationController")
		if humanoid then
			for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
				if track and track:IsA("AnimationTrack") then
					track:AdjustSpeed(targetSpeed)
				end
			end
		end
	end)

	DoNotif("Animation speed set to "..targetSpeed)
end, true)

cmd.add({"unanimationspeed", "unanimspeed", "unaspeed"}, {"unanimationspeed (unanimspeed,unaspeed)", "Stops the animation speed adjustment loop"}, function()
	if animCONN then
		animCONN:Disconnect()
		animCONN = nil
		DoNotif("Animation speed disabled")
	else
		DoNotif("No active animation speed to disable")
	end
end)

cmd.add({"placeid","pid"},{"placeid (pid)","Copies the PlaceId of the game you're in"},function()
	setclipboard(tostring(PlaceId))

	Wait();

	DoNotif("Copied the game's PlaceId: "..PlaceId)
end)

cmd.add({"gameid","universeid","gid"},{"gameid (universeid,gid)","Copies the GameId/Universe Id of the game you're in"},function()
	setclipboard(tostring(GameId))

	Wait();

	DoNotif("Copied the game's GameId: "..GameId)
end)

cmd.add({"firework"}, {"firework", "pop"}, function()
	local character = LocalPlayer.Character
	if not character then return end

	local root = getRoot(character)
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if not root or not humanoid then return end

	humanoid.PlatformStand = true

	local part = InstanceNew("Part")
	part.Size = Vector3.new(0.1, 0.1, 0.1)
	part.Transparency = 1
	part.Anchored = false
	part.CanCollide = false
	part.Parent = game:GetService("Workspace").CurrentCamera

	local weld = InstanceNew("Weld")
	weld.Part0 = part
	weld.Part1 = root
	weld.C0 = CFrame.new()
	weld.Parent = part

	local bv = Instance.new("BodyVelocity")
	bv.Velocity = Vector3.new(0, 50, 0)
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Parent = part

	local bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bg.P = 10000
	bg.D = 0
	bg.Parent = part

	local spinTime = 3
	local spinSpeed = 720
	local startTime = tick()
	local angle = 0

	local connection
	connection = RunService.Heartbeat:Connect(function(dt)
		if tick() - startTime > spinTime then
			connection:Disconnect()
			bv:Destroy()
			bg:Destroy()
			part:Destroy()

			local explosion = Instance.new("Explosion")
			explosion.Position = root.Position
			explosion.BlastRadius = 6
			explosion.BlastPressure = 500000
			explosion.Parent = game:GetService("Workspace")

			humanoid.Health = 0
			return
		end

		angle += math.rad(spinSpeed * dt)
		bg.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, angle, 0)
	end)
end)

cmd.add({"placename","pname"},{"placename (pname)","Copies the game's place name to your clipboard"},function()
	placeNaem = placeName()
	setclipboard(placeNaem)

	Wait();

	DoNotif("Copied the game's place name: "..placeNaem)
end)

cmd.add({"gameinfo","ginfo"},{"gameinfo (ginfo)","shows info about the game you're playing"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/GameInfo.lua"))()
end)

cmd.add({"copyname", "cname"}, {"copyname <player> (cname)", "Copies the username of the target"}, function(...)
	local usr = ...
	local tgt = getPlr(usr)

	for _, plr in next, tgt do
		setclipboard(tostring(plr.Name))
		Wait()
		DoNotif("Copied the username of "..nameChecker(plr))
	end
end, true)

cmd.add({"copydisplay", "cdisplay"}, {"copydisplay <player> (cdisplay)", "Copies the display name of the target"}, function(...)
	local usr = ...
	local tgt = getPlr(usr)

	for _, plr in next, tgt do
		setclipboard(tostring(plr.DisplayName))
		Wait()
		DoNotif("Copied the display name of "..nameChecker(plr))
	end
end, true)

cmd.add({"copyid", "id"}, {"copyid <player> (id)", "Copies the UserId of the target"}, function(...)
	local usr = ...
	local tgt = getPlr(usr)

	for _, plr in next, tgt do
		setclipboard(tostring(plr.UserId))
		Wait()
		DoNotif("Copied the UserId of "..nameChecker(plr))
	end
end, true)

--[ PLAYER ]--
function toggleKB(enable)
	local p = Players.LocalPlayer
	local hrp = getRoot(p.Character)
	local parts = game:GetService("Workspace"):GetPartBoundsInRadius(hrp.Position, 10)
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
	Wait()
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
	local chatMessage = Concat({...}, " ")
	local chatTarget = "All"
	lib.LocalPlayerChat(chatMessage, chatTarget)
end, true)

cmd.add({"privatemessage", "pm"}, {"privatemessage <player> <text> (pm)", "Sends a private message to a player"}, function(...)
	local args = {...}
	local Player = getPlr(args[1])

	for _, plr in next, Player do
		local chatMessage = Concat(args, " ", 2)
		local chatTarget = plr.Name
		local result = lib.LocalPlayerChat(chatMessage, chatTarget)
		if result == "Hooking" then
			Wait(.5)
			lib.LocalPlayerChat(chatMessage, chatTarget)
		end
	end
end,true)

cmd.add({"fixcam", "fix"}, {"fixcam", "Fix your camera"}, function()
	local ws = game:GetService("Workspace")
	local plr = Players.LocalPlayer
	ws.CurrentCamera:Remove()
	wait(0.1)
	repeat Wait() until plr.Character
	local cam = ws.CurrentCamera
	cam.CameraSubject = plr.Character:FindFirstChildWhichIsA("Humanoid")
	cam.CameraType = "Custom"
	plr.CameraMinZoomDistance = 0.5
	plr.CameraMaxZoomDistance = math.huge
	plr.CameraMode = "Classic"
	plr.Character:FindFirstChild("Head").Anchored = false
end)

cmd.add({"saw"}, {"saw <challenge>", "shush"}, function(...)
	local challenge = Concat({...}, " ")
	getgenv().SawFinish = false

	local function playSound(id, vol)
		local sfx = InstanceNew("Sound")
		sfx.Parent = PlrGui
		sfx.SoundId = "rbxassetid://"..id
		sfx.Volume = vol or 1
		sfx:Play()
		sfx.Ended:Connect(function()
			sfx:Destroy()
		end)
	end

	local function createUIElement(class, properties, parent)
		local element = InstanceNew(class)
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
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 0
	}, ScreenGui)

	local bgTween = TweenService:Create(
		background,
		TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ BackgroundTransparency = 0.5 }
	)
	bgTween:Play()

	local progressBar = createUIElement("Frame", {
		BackgroundColor3 = Color3.fromRGB(50, 50, 50),
		Position = UDim2.new(0.25, 0, 0.05, 0),
		Size = UDim2.new(0.5, 0, 0.03, 0),
		BorderSizePixel = 0,
		ZIndex = 2
	}, ScreenGui)

	local progressFill = createUIElement("Frame", {
		BackgroundColor3 = Color3.fromRGB(255, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		BorderSizePixel = 0,
		ZIndex = 3
	}, progressBar)

	local imgLabel = createUIElement("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.1, 0),
		Size = UDim2.new(0, 150, 0, 150),
		Image = "rbxassetid://8747893766",
		ImageColor3 = Color3.fromRGB(255, 0, 0),
		ZIndex = 2
	}, ScreenGui)

	coroutine.wrap(function()
		while not getgenv().SawFinish do
			local newSize = math.random(140, 160)
			local newRotation = math.random(-10, 10)
			local tween = TweenService:Create(
				imgLabel,
				TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
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
		Position = UDim2.new(0.05, 0, 0.5, 0),
		Size = UDim2.new(0.4, 0, 0.1, 0),
		Font = Enum.Font.SciFi,
		Text = "Challenge: "..challenge,
		TextColor3 = Color3.fromRGB(255, 0, 0),
		TextSize = 24,
		TextWrapped = true,
		ZIndex = 3
	}, ScreenGui)

	local ttLabelRight = createUIElement("TextLabel", {
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.3,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(0.95, 0, 0.5, 0),
		Size = UDim2.new(0.4, 0, 0.1, 0),
		Font = Enum.Font.SciFi,
		Text = "Time Remaining: 180 seconds",
		TextColor3 = Color3.fromRGB(255, 0, 0),
		TextSize = 24,
		TextWrapped = true,
		ZIndex = 3
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
		ZIndex = 4
	}, ScreenGui)

	local function flickerText()
		while not getgenv().SawFinish do
			local newColor = Color3.fromRGB(math.random(200, 255), 0, 0)
			ttLabelLeft.TextColor3 = newColor
			ttLabelRight.TextColor3 = newColor
			ttLabelLeft.Text = "Challenge: "..challenge:sub(1, math.random(1, #challenge))
			Wait(math.random(0.05, 0.15))
		end
	end

	local function dramaticCountdown(num)
		dramaticLabel.Text = tostring(num)
		playSound(138081500, 2)
		Wait(1)
		dramaticLabel.Text = ""
	end

	local function count()
		local num = 180
		while Wait(1) do
			if not getgenv().SawFinish then
				if num > 0 then
					num = num - 1
					playSound(138081500, 1)
					ttLabelRight.Text = "Time Remaining: "..num.." seconds"

					local progress = num / 180
					local tween = TweenService:Create(
						progressFill,
						TweenInfo.new(1, Enum.EasingStyle.Linear),
						{ Size = UDim2.new(progress, 0, 1, 0) }
					)
					tween:Play()

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
				Wait(2)
				ScreenGui:Destroy()
				break
			end
		end
	end

	coroutine.wrap(count)()
	coroutine.wrap(flickerText)()
end, true)

cmd.add({"jend"}, {"jend", "nil"}, function()
	getgenv().SawFinish = true
end)

attachedPart=nil

cmd.add({"fling"}, {"fling <player>", "Fling the given player"}, function(plr)
	local mouse = LocalPlayer:GetMouse()
	local Targets = {plr}
	local Players = game:GetService("Players")
	local Player = Players.LocalPlayer
	local AllBool = false
	local GetPlayer = function(Name)
		Name = Name:lower()
		if Name == "all" or Name == "others" then
			AllBool = true
			return
		elseif Name == "random" then
			local GetPlayers = Players:GetPlayers()
			if Discover(GetPlayers, Player) then table.remove(GetPlayers, Discover(GetPlayers, Player)) end
			return GetPlayers[math.random(#GetPlayers)]
		elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
			for _, x in next, Players:GetPlayers() do
				if x ~= Player then
					if x.Name:lower():match("^"..Name) then
						return x
					elseif x.DisplayName:lower():match("^"..Name) then
						return x
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
		if attachedPart then attachedPart:Destroy() attachedPart=nil end
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local HRP = Humanoid and Humanoid.RootPart
		local camera = game:GetService("Workspace").CurrentCamera
		attachedPart = InstanceNew("Part")
		attachedPart.Size = Vector3.new(1, 1, 1)
		attachedPart.Transparency = 1
		attachedPart.CanCollide = false
		attachedPart.Anchored = false
		attachedPart.Parent = camera
		local weld = InstanceNew("WeldConstraint")
		weld.Part0 = HRP
		weld.Part1 = attachedPart
		weld.Parent = attachedPart
		local bodyGyro = InstanceNew("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
		bodyGyro.D = 1000
		bodyGyro.P = 2000
		bodyGyro.Parent = attachedPart
		local RootPart = HRP
		local TCharacter = TargetPlayer.Character
		local THumanoid, TRootPart, THead, Accessory, Handle
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
		if Accessory and Accessory:FindFirstChild("Handle") then
			Handle = Accessory.Handle
		end
		if Character and Humanoid and HRP then
			if not getgenv().OldPos or RootPart.Velocity.Magnitude < 50 then
				getgenv().OldPos = RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				game:GetService("Workspace").CurrentCamera.CameraSubject = THead
			elseif not THead and Handle then
				game:GetService("Workspace").CurrentCamera.CameraSubject = Handle
			elseif THumanoid and TRootPart then
				game:GetService("Workspace").CurrentCamera.CameraSubject = THumanoid
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
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
							Wait()
						else
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
							Wait()
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							Wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
				if attachedPart then attachedPart:Destroy() attachedPart=nil end
			end
			game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
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
			end
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			game:GetService("Workspace").CurrentCamera.CameraSubject = Humanoid
			repeat
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(), function(_, x)
					if x:IsA("BasePart") then
						x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
					end
				end)
				Wait()
			until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
			game:GetService("Workspace").FallenPartsDestroyHeight = getgenv().FPDH
			attachedPart:Destroy()
		end
	end
	getgenv().Welcome = true
	if Targets[1] then for _, x in next, Targets do GetPlayer(x) end else return end
	if AllBool then
		for _, x in next, Players:GetPlayers() do
			SkidFling(x)
		end
	end
	for _, x in next, Targets do
		if GetPlayer(x) and GetPlayer(x) ~= Player then
			if GetPlayer(x).UserId ~= 1414978355 then
				local TPlayer = GetPlayer(x)
				if TPlayer then
					SkidFling(TPlayer)
				end
			end
		end
	end
end, true)

cmd.add({"commitoof", "suicide", "kys"}, {"commitoof (suicide, kys)", "FE dramatic oof sequence"}, function()
	local p = Players.LocalPlayer
	local c = p.Character or p.CharacterAdded:Wait()
	local h = c:FindFirstChildWhichIsA("Humanoid")

	lib.LocalPlayerChat("Okay.. I will do it.", "All")
	Wait(1)
	lib.LocalPlayerChat("I will oof", "All")
	Wait(1)
	lib.LocalPlayerChat("Goodbye.", "All")
	Wait(1)

	local r = getRoot(c)
	h:MoveTo(r.Position + r.CFrame.LookVector * 10)
	h:ChangeState(Enum.HumanoidStateType.Jumping)
	Wait(0.5)
	cmd.run({'die'})
end)

cmd.add({"volume","vol"},{"volume <1-10> (vol)","Changes your volume"},function(vol)
	amount=vol/10
	UserSettings():GetService("UserGameSettings").MasterVolume=amount
end,true)

cmd.add({"sensitivity","sens"},{"sensitivity <1-10> (tr)","Changes your sensitivity"},function(ss)
	UserInputService.MouseDeltaSensitivity=ss
end,true)

cmd.add({"torandom","tr"},{"torandom (tr)","Teleports to a random player"},function()
	target=getPlr("random")
	for _, plr in next, target do
		getRoot(getChar()).CFrame=getPlrHum(plr).RootPart.CFrame
	end
end)

cmd.add({"goto","to","tp","teleport"},{"goto <player/X,Y,Z>","Teleport to the given player or X,Y,Z coordinates"},function(...)
	Username=(...)

	local target=getPlr(Username)
	for _, plr in next, target do
		getRoot(getChar()).CFrame=getPlrHum(plr).RootPart.CFrame
	end
end,true)

local StaringConnection = nil

cmd.add({"lookat", "stare"}, {"stare <player> (lookat)", "Stare at a player"}, function(...)
	local Username = (...)
	local Target = getPlr(Username)
	for _, plr in next, Target do
		if StaringConnection then
			StaringConnection:Disconnect()
			StaringConnection = nil
		end
		if not (Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character)) then return end
		if not (plr and plr.Character and getRoot(plr.Character)) then return end
		function Stare()
			if Players.LocalPlayer.Character.PrimaryPart and plr.Character and getRoot(plr.Character) then
				local LocalCharPos = Players.LocalPlayer.Character.PrimaryPart.Position
				local TargetPos = getRoot(plr.Character).Position
				local AdjustedTargetPos = Vector3.new(TargetPos.X, LocalCharPos.Y, TargetPos.Z)
				local NewCFrame = CFrame.new(LocalCharPos, AdjustedTargetPos)
				Players.LocalPlayer.Character:SetPrimaryPartCFrame(NewCFrame)
			else
				if not Players:FindFirstChild(plr.Name) then
					StaringConnection:Disconnect()
					StaringConnection = nil
				end
			end
		end
		StaringConnection = RunService.RenderStepped:Connect(Stare)
	end
end, true)

cmd.add({"unlookat", "unstare"}, {"unstare (unlookat)", "Stops staring"}, function()
	if StaringConnection then
		StaringConnection:Disconnect()
		StaringConnection = nil
	end
end)

local nearCON = nil

cmd.add({"starenear", "stareclosest"}, {"starenear (stareclosest)", "Stare at the closest player"}, function()
	if nearCON then
		nearCON:Disconnect()
		nearCON = nil
	end

	local function getClosest()
		local lp = Players.LocalPlayer
		local char = lp.Character
		if not (char and getRoot(char)) then return nil end

		local closest, dist = nil, math.huge
		local pos = getRoot(char).Position

		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= lp and p.Character and getRoot(p.Character) then
				local pPos = getRoot(p.Character).Position
				local d = (pPos - pos).Magnitude
				if d < dist then
					dist = d
					closest = p
				end
			end
		end

		return closest
	end

	local function stare()
		local lp = Players.LocalPlayer
		local char = lp.Character
		if not (char and char.PrimaryPart) then return end

		local target = getClosest()
		if target and getRoot(target.Character) then
			local pos = char.PrimaryPart.Position
			local tPos = getRoot(target.Character).Position
			local lookAt = Vector3.new(tPos.X, pos.Y, tPos.Z)
			char:SetPrimaryPartCFrame(CFrame.new(pos, lookAt))
		end
	end

	nearCON = RunService.RenderStepped:Connect(stare)
end)

cmd.add({"unstarenear", "unstareclosest"}, {"unstarenear (unstareclosest)", "Stop staring at closest player"}, function()
	if nearCON then
		nearCON:Disconnect()
		nearCON = nil
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
	game:GetService("Workspace").CurrentCamera.CameraSubject = getHum()
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
		repeat Wait() until character:FindFirstChildWhichIsA("Humanoid")
		game:GetService("Workspace").CurrentCamera.CameraSubject = character:FindFirstChildWhichIsA("Humanoid")
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
				game:GetService("Workspace").CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChildWhichIsA("Humanoid")
			end
			Wait()
		end
	end)

	coroutine.resume(loop)
end

cmd.add({"watch", "view", "spectate"}, {"watch <Player> (view, spectate)", "Spectate player"}, function(...)
	cleanup()

	local targetPlayer = getPlr((...))
	for _, plr in next, targetPlayer do
		if not plr then return end
		spectatePlayer(plr)
	end
end, true)

cmd.add({"unwatch", "unview"}, {"unwatch (unview)", "Stop spectating"}, function()
	cleanup()
end)

function createSpecUI()
	if not specGui then
		specGui = InstanceNew("ScreenGui")
		NaProtectUI(specGui)
		specGui.ResetOnSpawn = false

		local frame = InstanceNew("Frame")
		frame.Size = UDim2.new(0, 350, 0, 40)
		frame.Position = UDim2.new(0.5, -175, 1, -160)
		frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		frame.BorderSizePixel = 0
		frame.Parent = specGui

		local corner = InstanceNew("UICorner")
		corner.CornerRadius = UDim.new(0, 20)
		corner.Parent = frame

		gui.draggablev2(frame)

		local backButton = InstanceNew("TextButton")
		backButton.Size = UDim2.new(0, 40, 0, 40)
		backButton.Position = UDim2.new(0, -18, 0, 0)
		backButton.Text = "<"
		backButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		backButton.Font = Enum.Font.GothamBold
		backButton.TextSize = 24
		backButton.Parent = frame

		local backCorner = InstanceNew("UICorner")
		backCorner.CornerRadius = UDim.new(0, 10)
		backCorner.Parent = backButton

		local forwardButton = InstanceNew("TextButton")
		forwardButton.Size = UDim2.new(0, 40, 0, 40)
		forwardButton.Position = UDim2.new(1, -22, 0, 0)
		forwardButton.Text = ">"
		forwardButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		forwardButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		forwardButton.Font = Enum.Font.GothamBold
		forwardButton.TextSize = 24
		forwardButton.Parent = frame

		local forwardCorner = InstanceNew("UICorner")
		forwardCorner.CornerRadius = UDim.new(0, 10)
		forwardCorner.Parent = forwardButton

		local dropdownLabel = InstanceNew("TextLabel")
		dropdownLabel.Size = UDim2.new(0.76, 0, 1, 0)
		dropdownLabel.Position = UDim2.new(0.08, 0, 0, 0)
		dropdownLabel.BackgroundTransparency = 1
		dropdownLabel.Text = "Spectating: None"
		dropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		dropdownLabel.Font = Enum.Font.GothamBold
		dropdownLabel.TextScaled = true
		dropdownLabel.Parent = frame

		local dropCorner = InstanceNew("UICorner")
		dropCorner.CornerRadius = UDim.new(0, 10)
		dropCorner.Parent = dropdownLabel

		local closeButton = InstanceNew("TextButton")
		closeButton.Size = UDim2.new(0, 30, 0, 30)
		closeButton.Position = UDim2.new(1, -55, 0, 5)
		closeButton.Text = "X"
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.Font = Enum.Font.GothamBold
		closeButton.TextSize = 18
		closeButton.Parent = frame

		local closeCorner = InstanceNew("UICorner")
		closeCorner.CornerRadius = UDim.new(0, 5)
		closeCorner.Parent = closeButton

		MouseButtonFix(closeButton,function()
			cleanup()
		end)

		local toggleDropdownButton = InstanceNew("TextButton")
		toggleDropdownButton.Size = UDim2.new(0, 30, 0, 20)
		toggleDropdownButton.Position = UDim2.new(0.5, -15, 1, 5)
		toggleDropdownButton.Text = "v"
		toggleDropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		toggleDropdownButton.TextColor3 = Color3.new(1, 1, 1)
		toggleDropdownButton.Font = Enum.Font.GothamBold
		toggleDropdownButton.TextSize = 18
		toggleDropdownButton.Parent = frame

		local toggleCorner = InstanceNew("UICorner")
		toggleCorner.CornerRadius = UDim.new(0, 6)
		toggleCorner.Parent = toggleDropdownButton

		local dropdownOpen = false
		local dropdownList

		local function updateSpectating()
			if #playerButtons == 0 then
				dropdownLabel.Text = "Spectating: None"
				return
			end
			local currentPlayer = playerButtons[currentPlayerIndex]
			local nameCheck = nameChecker(currentPlayer)
			dropdownLabel.Text = "Spectating: "..nameCheck
			if currentPlayer == game.Players.LocalPlayer then
				dropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
			else
				dropdownLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
			end
			spectatePlayer(currentPlayer)

			if dropdownOpen and dropdownList then
				for _, child in pairs(dropdownList:GetChildren()) do
					if child:IsA("TextButton") then
						local idx = child:GetAttribute("PlayerIndex")
						if idx then
							local playerRef = playerButtons[idx]
							if playerRef then
								if playerRef == game.Players.LocalPlayer then
									child.TextColor3 = Color3.fromRGB(255, 255, 0)
								elseif playerRef == currentPlayer then
									child.TextColor3 = Color3.fromRGB(0, 162, 255)
								else
									child.TextColor3 = Color3.fromRGB(255, 255, 255)
								end
							end
						end
					end
				end
			end
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

		MouseButtonFix(toggleDropdownButton,function()
			if dropdownOpen then
				if dropdownList then
					local closeTween = TweenService:Create(dropdownList, TweenInfo.new(0.25), { Size = UDim2.new(1, 0, 0, 0) })
					local moveToggle = TweenService:Create(toggleDropdownButton, TweenInfo.new(0.25), { Position = UDim2.new(0.5, -15, 1, 5) })
					closeTween:Play()
					moveToggle:Play()
					closeTween.Completed:Wait()
					dropdownList:Destroy()
					dropdownList = nil
				end
				toggleDropdownButton.Text = "v"
				dropdownOpen = false
			else
				dropdownList = InstanceNew("ScrollingFrame")
				local totalHeight = #playerButtons * 30
				local listHeight = math.min(totalHeight, 150)
				dropdownList.Size = UDim2.new(1, 0, 0, 0)
				dropdownList.Position = UDim2.new(0, 0, 1, 0)
				dropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				dropdownList.BorderSizePixel = 0
				dropdownList.ScrollBarThickness = 5
				dropdownList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
				dropdownList.ClipsDescendants = true
				dropdownList.Parent = frame

				local listCorner = InstanceNew("UICorner")
				listCorner.CornerRadius = UDim.new(0, 10)
				listCorner.Parent = dropdownList

				local listLayout = InstanceNew("UIListLayout")
				listLayout.SortOrder = Enum.SortOrder.LayoutOrder
				listLayout.Parent = dropdownList

				local openTween = TweenService:Create(dropdownList, TweenInfo.new(0.25), { Size = UDim2.new(1, 0, 0, listHeight) })
				local moveToggle = TweenService:Create(toggleDropdownButton, TweenInfo.new(0.25), { Position = UDim2.new(0.5, -15, 1, listHeight + 10) })

				openTween:Play()
				moveToggle:Play()

				toggleDropdownButton.Text = "^"
				dropdownOpen = true

				for i, player in ipairs(playerButtons) do
					local playerButton = InstanceNew("TextButton")
					playerButton.Size = UDim2.new(1, 0, 0, 30)
					playerButton.LayoutOrder = i
					playerButton.Text = ""
					playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
					playerButton.Font = Enum.Font.Gotham
					playerButton.TextScaled = true
					playerButton.Parent = dropdownList
					playerButton:SetAttribute("PlayerIndex", i)

					local headshot = InstanceNew("ImageLabel")
					headshot.Size = UDim2.new(0, 30, 0, 30)
					headshot.Position = UDim2.new(0, 0, 0, 0)
					headshot.BackgroundTransparency = 1
					headshot.Parent = playerButton
					local thumbType = Enum.ThumbnailType.HeadShot
					local thumbSize = Enum.ThumbnailSize.Size420x420
					headshot.Image = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)

					local nameLabel = InstanceNew("TextLabel")
					nameLabel.Size = UDim2.new(1, -35, 1, 0)
					nameLabel.Position = UDim2.new(0, 35, 0, 0)
					nameLabel.BackgroundTransparency = 1
					nameLabel.Text = nameChecker(player)
					nameLabel.Font = Enum.Font.Gotham
					nameLabel.TextScaled = true
					if player == Players.LocalPlayer then
						nameLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
					elseif playerButtons[currentPlayerIndex] == player then
						nameLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
					else
						nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
					nameLabel.Parent = playerButton

					MouseButtonFix(playerButton,function()
						currentPlayerIndex = i
						updateSpectating()
					end)
				end
			end
		end)

		updateSpectating()
	end
end

cmd.add({"watch2", "view2", "spectate2"}, {"watch2 <Player> (view2, spectate2)", "Spectate player with GUI"}, function()
	cleanup()
	createSpecUI()
end)

cmd.add({"unwatch2", "unview2"}, {"unwatch2 (unview2)", "Stop spectating with GUI"}, function()
	cleanup()
end)

cmd.add({"stealaudio", "getaudio", "steal", "logaudio"}, {"stealaudio <player> (getaudio,logaudio,steal)", "Save all sounds a player is playing to a file -Cyrus"}, function(p)
	Wait()
	local players = getPlr(p)
	for _, plr in next, players do
		if not plr then
			DoNotif("Player not found.")
			return
		end
		local char = plr.Character
		if not char then
			DoNotif("Character not found for player "..nameChecker(plr))
			return
		end
		local audioList = {}
		for _, songer in pairs(char:GetDescendants()) do
			if songer:IsA("Sound") and songer.Playing then
				Insert(audioList, songer.SoundId)
			end
		end
		if #audioList > 0 then
			local audios = Concat(audioList, "\n")
			setclipboard(audios)
			DoNotif("Audio links have been copied to your clipboard.")
		else
			DoNotif("No playing audio found for player "..nameChecker(plr))
		end
	end
end, true)

cmd.add({"follow", "stalk", "walk"}, {"follow <player>", "Follow a player wherever they go"}, function(p)
	lib.disconnect("follow")
	local targetPlayers = getPlr(p)
	for _, plr in next, targetPlayers do
		if not plr then
			DoNotif("Player not found or invalid.")
			return
		end
		lib.connect("follow", RunService.Stepped:Connect(function()
			local target = plr.Character
			local character = getChar()
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
	end
end, true)

cmd.add({"unfollow", "unstalk", "unwalk", "unpathfind"}, {"unfollow", "Stop all attempts to follow a player"}, function()
	lib.disconnect("follow")
end)

PROXIMITY_RADIUS = 15
lastDistances = {}
ISfollowing = false
followTarget = nil
followConnection = nil
flwCharAdd = nil

cmd.add({"autofollow", "autostalk", "proxfollow"}, {"autofollow (autostalk,proxfollow)", "Automatically follow any player who comes close"}, function()
	lib.disconnect("autofollow")
	if followConnection then followConnection:Disconnect() followConnection = nil end
	if flwCharAdd then flwCharAdd:Disconnect() flwCharAdd = nil end
	lastDistances = {}
	ISfollowing = false
	followTarget = nil

	lib.connect("autofollow", RunService.Stepped:Connect(function()
		if ISfollowing then return end

		local myChar = getChar()
		local myRoot = getRoot(myChar)
		local myHum = myChar and myChar:FindFirstChildWhichIsA("Humanoid")
		if not (myChar and myRoot and myHum) then return end

		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				local char = plr.Character
				local root = getRoot(char)
				if char and root then
					local currentDist = (myRoot.Position - root.Position).Magnitude
					local lastDist = lastDistances[plr]

					if lastDist and lastDist > PROXIMITY_RADIUS and currentDist < PROXIMITY_RADIUS and currentDist < lastDist then
						ISfollowing = true
						followTarget = plr

						local function setupFollow(char)
							local targetRoot = getRoot(char)
							if not targetRoot then return end

							if followConnection then followConnection:Disconnect() end
							followConnection = RunService.Stepped:Connect(function()
								if myChar and myHum and targetRoot and char and char.Parent then
									myHum:MoveTo(targetRoot.Position)
								else
									if followConnection then followConnection:Disconnect() followConnection = nil end
									if flwCharAdd then flwCharAdd:Disconnect() flwCharAdd = nil end
									ISfollowing = false
									followTarget = nil
								end
							end)

							local hum = char:FindFirstChildWhichIsA("Humanoid")
							if hum then
								hum.Died:Connect(function()
									if followConnection then followConnection:Disconnect() followConnection = nil end
									ISfollowing = false
									followTarget = nil
								end)
							end
						end

						if plr.Character then
							setupFollow(plr.Character)
						end

						if flwCharAdd then flwCharAdd:Disconnect() end
						flwCharAdd = plr.CharacterAdded:Connect(function(newChar)
							Wait(0.1)
							setupFollow(newChar)
						end)

						break
					end

					lastDistances[plr] = currentDist
				end
			end
		end
	end))
end)

cmd.add({"unautofollow", "stopautofollow", "unproxfollow"}, {"unautofollow (stopautofollow,unproxfollow)", "Stop automatically following nearby players"}, function()
	lib.disconnect("autofollow")
	if followConnection then followConnection:Disconnect() followConnection = nil end
	if flwCharAdd then flwCharAdd:Disconnect() flwCharAdd = nil end
	lastDistances = {}
	ISfollowing = false
	followTarget = nil
end)

cmd.add({"pathfind"}, {"pathfind <player>", "Follow a player using the pathfinder API wherever they go"}, function(p)
	local targetPlayers = getPlr(p)
	for _, plr in next, targetPlayers do
		if not plr then return end
		lib.disconnect("follow")
		local debounce = false
		lib.connect("follow", RunService.Stepped:Connect(function()
			if debounce then return end
			debounce = true
			local target = plr.Character
			local character = getChar()
			if not target or not character then
				debounce = false
				return
			end
			local hum = character:FindFirstChildWhichIsA("Humanoid")
			local main = getRoot(target)
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
				end
			end
			debounce = false
		end))
	end
end, true)

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

cmd.add({"blackhole"}, {"blackhole", "Makes unanchored parts teleport to the black hole"}, function()
	local UserInputService = game:GetService("UserInputService")
	local Mouse = LocalPlayer:GetMouse()
	local Folder = InstanceNew("Folder", game:GetService("Workspace"))
	local Part = InstanceNew("Part", Folder)
	local Attachment1 = InstanceNew("Attachment", Part)
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1
	local Updated = Mouse.Hit + Vector3.new(0, 5, 0)

	local NetworkAccess = coroutine.create(function()
		settings().Physics.AllowSleep = false
		while RunService.RenderStepped:Wait() do
			for _, Players in next, game:GetService("Players"):GetPlayers() do
				if Players ~= LocalPlayer then
					Players.MaximumSimulationRadius = 0
					sethiddenproperty(Players, "SimulationRadius", 0)
				end
			end
			LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
		end
	end)
	coroutine.resume(NetworkAccess)

	local function ForcePart(v)
		if v:IsA("Part") and v.Anchored == false and v.Parent:FindFirstChild("Humanoid") == nil and v.Parent:FindFirstChild("Head") == nil and v.Name ~= "Handle" then
			Mouse.TargetFilter = v
			for _, x in next, v:GetChildren() do
				if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
					x:Destroy()
				end
			end
			if v:FindFirstChild("Attachment") then
				v:FindFirstChild("Attachment"):Destroy()
			end
			if v:FindFirstChild("AlignPosition") then
				v:FindFirstChild("AlignPosition"):Destroy()
			end
			if v:FindFirstChild("Torque") then
				v:FindFirstChild("Torque"):Destroy()
			end
			v.CanCollide = false
			local Torque = InstanceNew("Torque", v)
			Torque.Torque = Vector3.new(100000, 100000, 100000)
			local AlignPosition = InstanceNew("AlignPosition", v)
			local Attachment2 = InstanceNew("Attachment", v)
			Torque.Attachment0 = Attachment2
			AlignPosition.MaxForce = 9999999999999999
			AlignPosition.MaxVelocity = math.huge
			AlignPosition.Responsiveness = 200
			AlignPosition.Attachment0 = Attachment2
			AlignPosition.Attachment1 = Attachment1
		end
	end

	for _, v in next, game:GetService("Workspace"):GetDescendants() do
		ForcePart(v)
	end

	game:GetService("Workspace").DescendantAdded:Connect(function(v)
		ForcePart(v)
	end)

	UserInputService.InputBegan:Connect(function(Key, Chat)
		if Key.KeyCode == Enum.KeyCode.E and not Chat and not IsOnMobile then
			Updated = Mouse.Hit + Vector3.new(0, 5, 0)
		end
	end)

	if IsOnMobile then
		local sGUI=InstanceNew("ScreenGui")
		NaProtectUI(sGUI)
		UICorner = InstanceNew("UICorner")
		local button = InstanceNew("TextButton")
		button.Text = "Move Blackhole"
		button.AnchorPoint = Vector2.new(0.5,0)
		button.Size = UDim2.new(0, 150, 0, 40)
		button.Position = UDim2.new(0.5, 0, 0.9, 0)
		button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
		button.TextColor3 = Color3.new(1, 1, 1)
		button.Font = Enum.Font.SourceSansBold
		button.TextSize = 18
		button.Parent=sGUI

		UICorner.CornerRadius = UDim.new(0.25, 0)
		UICorner.Parent = button
		
		MouseButtonFix(button,function()
			Updated = Mouse.Hit + Vector3.new(0, 5, 0)
		end)

		gui.draggablev2(button)
	end

	Spawn(function()
		while RunService.RenderStepped:Wait() do
			Attachment1.WorldCFrame = Updated
		end
	end)

	wait()

	DoNotif("Blackhole has been loaded, "..(IsOnMobile and "tap the button to move it" or "press E to change the position to where your mouse is"))
end)

cmd.add({"disableanimations","disableanims"},{"disableanimations (disableanims)","Freezes your animations"},function()
	getChar().Animate.Disabled=true
end)

cmd.add({"undisableanimations","undisableanims"},{"undisableanimations (undisableanims)","Unfreezes your animations"},function()
	getChar().Animate.Disabled=false
end)

cmd.add({"hatresize"},{"hatresize","Makes your hats very big r15 only"},function()

	Wait();

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

LOOPPROTECT = nil

cmd.add({"loopfling"}, {"loopfling <player>", "Loop voids a player"}, function(plr)
	local Targets = {plr}
	Loopvoid = true
	repeat Wait()
		local mouse = LocalPlayer:GetMouse()
		local Player = game:GetService("Players").LocalPlayer
		local AllBool = false
		local GetPlayer = function(Name)
			Name = Name:lower()
			if Name == "all" or Name == "others" then
				AllBool = true
				return
			elseif Name == "random" then
				local GetPlayers = Players:GetPlayers()
				if Discover(GetPlayers, Player) then table.remove(GetPlayers, Discover(GetPlayers, Player)) end
				return GetPlayers[math.random(#GetPlayers)]
			elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
				for _, x in next, Players:GetPlayers() do
					if x ~= Player then
						if x.Name:lower():match("^"..Name) then
							return x
						elseif x.DisplayName:lower():match("^"..Name) then
							return x
						end
					end
				end
			else
				return
			end
		end
		local SkidFling = function(TargetPlayer)
			if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
			local Character = Player.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local HRP = Humanoid and Humanoid.RootPart
			local camera = game:GetService("Workspace").CurrentCamera
			LOOPPROTECT = InstanceNew("Part")
			LOOPPROTECT.Size = Vector3.new(1, 1, 1)
			LOOPPROTECT.Transparency = 1
			LOOPPROTECT.CanCollide = false
			LOOPPROTECT.Anchored = false
			LOOPPROTECT.Parent = camera
			local weld = InstanceNew("WeldConstraint")
			weld.Part0 = HRP
			weld.Part1 = LOOPPROTECT
			weld.Parent = LOOPPROTECT
			local bodyGyro = InstanceNew("BodyGyro")
			bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
			bodyGyro.D = 1000
			bodyGyro.P = 2000
			bodyGyro.Parent = LOOPPROTECT
			local RootPart = HRP
			local TCharacter = TargetPlayer.Character
			local THumanoid, TRootPart, THead, Accessory, Handle
			if not TCharacter then if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end return end
			if TCharacter:FindFirstChildOfClass("Humanoid") then
				THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
			end
			if THumanoid and THumanoid.RootPart then
				TRootPart = THumanoid.RootPart
			end
			if TCharacter:FindFirstChild("Head") then
				THead = TCharacter:FindFirstChild("Head")
			end
			if TCharacter:FindFirstChildOfClass("Accessory") then
				Accessory = TCharacter:FindFirstChildOfClass("Accessory")
			end
			if Accessory and Accessory:FindFirstChild("Handle") then
				Handle = Accessory.Handle
			end
			if Character and Humanoid and HRP then
				if not getgenv().OldPos or RootPart.Velocity.Magnitude < 50 then
					getgenv().OldPos = RootPart.CFrame
				end
				if THumanoid and THumanoid.Sit and not AllBool then
					return
				end
				if THead then
					game:GetService("Workspace").CurrentCamera.CameraSubject = THead
				elseif not THead and Handle then
					game:GetService("Workspace").CurrentCamera.CameraSubject = Handle
				elseif THumanoid and TRootPart then
					game:GetService("Workspace").CurrentCamera.CameraSubject = THumanoid
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
								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
								Wait()
							else
								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
								Wait()
								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								Wait()
							end
						else
							break
						end
					until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
					if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
				end
				game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
				local BV = InstanceNew("BodyVelocity")
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
					return
				end
				BV:Destroy()
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				game:GetService("Workspace").CurrentCamera.CameraSubject = Humanoid
				repeat
					RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
					Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
					Humanoid:ChangeState("GettingUp")
					table.foreach(Character:GetChildren(), function(_, x)
						if x:IsA("BasePart") then
							x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
						end
					end)
					Wait()
				until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
				game:GetService("Workspace").FallenPartsDestroyHeight = getgenv().FPDH
				if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end
			else
				return
			end
		end
		if not Welcome then DoNotif("Enjoy!", 5, "Script by AnthonyIsntHere") end
		getgenv().Welcome = true
		if Targets[1] then for _, x in next, Targets do GetPlayer(x) end else return end
		if AllBool then
			for _, x in next, Players:GetPlayers() do
				SkidFling(x)
			end
		end
		for _, x in next, Targets do
			if GetPlayer(x) and GetPlayer(x) ~= Player then
				if GetPlayer(x).UserId ~= 1414978355 then
					local TPlayer = GetPlayer(x)
					if TPlayer then
						SkidFling(TPlayer)
					end
				end
			elseif not GetPlayer(x) and not AllBool then
			end
		end
	until Loopvoid == false
end, true)

cmd.add({"unloopfling"}, {"unloopfling", "Stops loop flinging a player"}, function()
	Loopvoid = false
	repeat Wait() if LOOPPROTECT then LOOPPROTECT:Destroy() LOOPPROTECT = nil end until LOOPPROTECT == nil
end)

cmd.add({"freegamepass", "freegp"},{"freegamepass (freegp)", "Returns true if the UserOwnsGamePassAsync function gets used"},function()
    local Hook
    Hook = hookfunction(MarketplaceService.UserOwnsGamePassAsync, newcclosure(function(self, ...)
        return true
    end))

    DoNotif("✅ Free gamepasses enabled! Rejoin to disable. Note: This only works in some games.")
end)

--[[cmd.add({"freedevproduct", "freedp"},{"freedevproduct (freedp)", "Simulates a successful Developer Product purchase"},function()
    hookfunction(MarketplaceService.PromptProductPurchase, newcclosure(function(self, player, productId, ...)
        if player == LocalPlayer then
        DoNotif("✅ Simulated dev product purchase for ProductId: "..tostring(productId))

        local success, err = pcall(function()
                local ReceiptInfo = {
                    PlayerId = player.UserId,
                    ProductId = productId,
                    CurrencySpent = 0,
                    PlaceIdWherePurchased = PlaceId,
                    PurchaseId = HttpService:GenerateGUID(false)
                }

                if typeof(getgenv().ProcessReceipt) == "function" then
                    getgenv().ProcessReceipt(ReceiptInfo)
                elseif typeof(getgenv().ProcessReceipt) == "function" then
                    getgenv().ProcessReceipt(ReceiptInfo)
                end
            end)

            if not success then
                warn("⚠️ Could not simulate ProcessReceipt: "..tostring(err))
            end
        end
        return
    end))

    DoNotif("🟢 Fake dev product purchase enabled! Use in games with local handlers.")
end)]]

cmd.add({"listen"}, {"listen <player>", "Listen to your target's voice chat"}, function(plr)
	local trg = getPlr(plr)

	for _, plr in next, trg do
		local Root = getRoot(plr.Character)
		if Root then
			SoundService:SetListener(Enum.ListenerType.ObjectPosition, Root)
		end
	end
end,true)

cmd.add({"unlisten"}, {"unlisten", "Stops listening"}, function()
	SoundService:SetListener(Enum.ListenerType.Camera)
end)

cmd.add({"lockmouse", "lockm"}, {"lockmouse (lockm)", "Locks your mouse in the center"}, function()
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end)

cmd.add({"unlockmouse", "unlockm"}, {"unlockmouse (unlockm)", "Unlocks your mouse"}, function()
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end)

headSit, sitDied, platformParts = nil, nil, {}

cmd.add({"headsit"}, {"headsit <player>", "Head sit."}, function(p)
	local ppp = getPlr(p)
	for _, plr in next, ppp do
		if not plr then return end
		local char = getChar()
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not hum then return end
		if headSit then headSit:Disconnect() headSit = nil end
		if sitDied then sitDied:Disconnect() sitDied = nil end
		local charRoot = getRoot(char)
		local target = plr.Character
		if not charRoot or not target then return end
		hum.Sit = true
		sitDied = hum.Died:Connect(function()
			if headSit then headSit:Disconnect() headSit = nil end
			for _, part in pairs(platformParts) do
				part:Destroy()
			end
			platformParts = {}
			if sitDied then sitDied:Disconnect() sitDied = nil end
		end)
		for _, part in pairs(platformParts) do
			part:Destroy()
		end
		platformParts = {}
		local thick = 1
		local halfWidth = 2
		local halfDepth = 2
		local halfHeight = 3
		local walls = {
			{offset = CFrame.new(0, 0, halfDepth + thick/500), size = Vector3.new(4, 6, thick)},
			{offset = CFrame.new(0, 0, -(halfDepth + thick/500)), size = Vector3.new(4, 6, thick)},
			{offset = CFrame.new(halfWidth + thick/500, 0, 0), size = Vector3.new(thick, 6, 4)},
			{offset = CFrame.new(-(halfWidth + thick/500), 0, 0), size = Vector3.new(thick, 6, 4)},
			{offset = CFrame.new(0, halfHeight + thick/500, 0), size = Vector3.new(4, thick, 4)},
			{offset = CFrame.new(0, -(halfHeight + thick/500), 0), size = Vector3.new(4, thick, 4)}
		}
		for i, wall in ipairs(walls) do
			local part = InstanceNew("Part")
			part.Size = wall.size
			part.Anchored = true
			part.CanCollide = true
			part.Transparency = 1
			part.Parent = game:GetService("Workspace").CurrentCamera
			Insert(platformParts, part)
		end
		headSit = RunService.Heartbeat:Connect(function()
			if not SafeGetService("Players"):FindFirstChild(plr.Name) or not plr.Character or not plr.Character:FindFirstChild("Head") or hum.Sit == false then
				if headSit then headSit:Disconnect() headSit = nil end
				if sitDied then sitDied:Disconnect() sitDied = nil end
				for _, part in pairs(platformParts) do
					part:Destroy()
				end
				platformParts = {}
			else
				local targetHead = plr.Character:FindFirstChild("Head")
				charRoot.CFrame = targetHead.CFrame * CFrame.new(0, 1.6, 0.4)
				for i, wall in ipairs(walls) do
					platformParts[i].CFrame = charRoot.CFrame * wall.offset
				end
			end
		end)
	end
end, true)

cmd.add({"unheadsit"}, {"unheadsit", "Stop the headsit command."}, function()
	if headSit then headSit:Disconnect() headSit = nil end
	if sitDied then sitDied:Disconnect() sitDied = nil end
	for _, part in pairs(platformParts) do
		part:Destroy()
	end
	platformParts = {}
	local char = getChar()
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
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

headStand, standDied, standParts = nil, nil, {}

cmd.add({"headstand"}, {"headstand <player>", "Stand on someone's head."}, function(p)
	if headStand then headStand:Disconnect() headStand = nil end
	local targets = getPlr(p)
	if #targets == 0 then return end
	local plr = targets[1]
	local char = getChar()
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	standDied = hum.Died:Connect(function()
		if headStand then headStand:Disconnect() headStand = nil end
		for _, part in pairs(standParts) do
			part:Destroy()
		end
		standParts = {}
		if standDied then standDied:Disconnect() standDied = nil end
	end)
	for _, part in pairs(standParts) do
		part:Destroy()
	end
	standParts = {}
	local thick = 1
	local halfWidth = 2
	local halfDepth = 2
	local halfHeight = 3
	local walls = {
		{offset = CFrame.new(0, 0, halfDepth + thick/500), size = Vector3.new(4, 6, thick)},
		{offset = CFrame.new(0, 0, -(halfDepth + thick/500)), size = Vector3.new(4, 6, thick)},
		{offset = CFrame.new(halfWidth + thick/500, 0, 0), size = Vector3.new(thick, 6, 4)},
		{offset = CFrame.new(-(halfWidth + thick/500), 0, 0), size = Vector3.new(thick, 6, 4)},
		{offset = CFrame.new(0, halfHeight + thick/500, 0), size = Vector3.new(4, thick, 4)},
		{offset = CFrame.new(0, -(halfHeight + thick/500), 0), size = Vector3.new(4, thick, 4)}
	}
	for i, wall in ipairs(walls) do
		local part = InstanceNew("Part")
		part.Size = wall.size
		part.Anchored = true
		part.CanCollide = true
		part.Transparency = 1
		part.Parent = game:GetService("Workspace").CurrentCamera
		Insert(standParts, part)
	end
	headStand = RunService.Heartbeat:Connect(function()
		local plrCharacter = plr.Character
		if Players:FindFirstChild(plr.Name) and plrCharacter and getRoot(plrCharacter) and getRoot(char) then
			local charRoot = getRoot(char)
			charRoot.CFrame = getRoot(plrCharacter).CFrame * CFrame.new(0, 4.6, 0.4)
			for i, wall in ipairs(walls) do
				standParts[i].CFrame = charRoot.CFrame * wall.offset
			end
		else
			if headStand then headStand:Disconnect() headStand = nil end
			if standDied then standDied:Disconnect() standDied = nil end
			for _, part in pairs(standParts) do
				part:Destroy()
			end
			standParts = {}
		end
	end)
end, true)

cmd.add({"unheadstand"}, {"unheadstand", "Stop the headstand command."}, function()
	if headStand then headStand:Disconnect() headStand = nil end
	if standDied then standDied:Disconnect() standDied = nil end
	for _, part in pairs(standParts) do
		part:Destroy()
	end
	standParts = {}
end)

local loopws = false
local loopjp = false
local WScons = {}
local JPcons = {}

getgenv().NamelessWs = nil
getgenv().NamelessJP = nil

cmd.add({"loopwalkspeed", "loopws", "lws"}, {"loopwalkspeed <number> (loopws,lws)", "Loop walkspeed"}, function(...)
	local val = tonumber(...) or 16
	getgenv().NamelessWs = val
	loopws = true

	for _, conn in ipairs(WScons) do conn:Disconnect() end
	table.clear(WScons)

	local function getHum()
		local char = LocalPlayer and LocalPlayer.Character
		return char and char:FindFirstChildOfClass("Humanoid")
	end

	local function applyWS()
		local hum = getHum()
		if hum then
			hum.WalkSpeed = val
			Insert(WScons, hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				if loopws and hum.WalkSpeed ~= val then
					hum.WalkSpeed = val
				end
			end))
		end
	end

	applyWS()

	Insert(WScons, LocalPlayer.CharacterAdded:Connect(function()
		repeat Wait() until getHum()
		if loopws then applyWS() end
	end))
end, true)

cmd.add({"unloopwalkspeed", "unloopws", "unlws"}, {"unloopwalkspeed (unloopws,unlws)", "Disable loop walkspeed"}, function()
	loopws = false
	for _, conn in ipairs(WScons) do conn:Disconnect() end
	table.clear(WScons)
end)

cmd.add({"loopjumppower", "loopjp", "ljp"}, {"loopjumppower <number> (loopjp,ljp)", "Loop JumpPower"}, function(...)
	local val = tonumber(...) or 50
	getgenv().NamelessJP = val
	loopjp = true

	for _, conn in ipairs(JPcons) do conn:Disconnect() end
	table.clear(JPcons)

	local function getHum()
		local char = LocalPlayer and LocalPlayer.Character
		return char and char:FindFirstChildOfClass("Humanoid")
	end

	local function applyJP()
		local hum = getHum()
		if not hum then return end

		if hum.UseJumpPower then
			hum.JumpPower = val
			Insert(JPcons, hum:GetPropertyChangedSignal("JumpPower"):Connect(function()
				if loopjp and hum.JumpPower ~= val then
					hum.JumpPower = val
				end
			end))
		else
			hum.JumpHeight = val
			Insert(JPcons, hum:GetPropertyChangedSignal("JumpHeight"):Connect(function()
				if loopjp and hum.JumpHeight ~= val then
					hum.JumpHeight = val
				end
			end))
		end
	end

	applyJP()

	Insert(JPcons, LocalPlayer.CharacterAdded:Connect(function()
		repeat Wait() until getHum()
		if loopjp then applyJP() end
	end))
end, true)

cmd.add({"unloopjumppower", "unloopjp", "unljp"}, {"unloopjumppower (unloopjp,unljp)", "Disable loop jump power"}, function()
	loopjp = false
	for _, conn in ipairs(JPcons) do conn:Disconnect() end
	table.clear(JPcons)
end)

cmd.add({"stopanimations", "stopanims", "stopanim", "noanim"}, {"stopanimations (stopanims,stopanim,noanim)", "Stops running animations"}, function()
	local char = Players.LocalPlayer and Players.LocalPlayer.Character
	local hum = getHum() or (char and char:FindFirstChildOfClass("AnimationController"))
	if not hum then return end

	for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
		track:Stop()
	end
end)

loopwave = false

cmd.add({"loopwaveat", "loopwat"}, {"loopwaveat <player> (loopwat)", "Wave to a player in a loop"}, function(...)
	loopwave = true
	local playerName = (...)
	local targets = getPlr(playerName)
	for _, plr in next, targets do
		local char = getChar()
		local oldCFrame = getRoot(char).CFrame
		repeat
			Wait(0.2)
			local targetCFrame = getRoot(plr.Character).CFrame
			local waveAnim = InstanceNew("Animation")
			if char:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
				waveAnim.AnimationId = "rbxassetid://507770239"
			else
				waveAnim.AnimationId = "rbxassetid://128777973"
			end
			getRoot(char).CFrame = targetCFrame * CFrame.new(0, 0, -3)
			local charPos = char.PrimaryPart.Position
			local tpos = getRoot(plr.Character).Position
			local newCFrame = CFrame.new(charPos, Vector3.new(tpos.X, charPos.Y, tpos.Z))
			Players.LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame)
			local wave = char:FindFirstChildOfClass("Humanoid"):LoadAnimation(waveAnim)
			wave:Play(-1, 5, -1)
			Wait(1.6)
			wave:Stop()
		until not loopwave
		getRoot(char).CFrame = oldCFrame
	end
end, true)

cmd.add({"unloopwaveat", "unloopwat"}, {"unloopwaveat <player> (unloopwat)", "Stops the loopwaveat command"}, function()
	loopwave = false
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

	Wait()
	DoNotif("Copied tools from ReplicatedStorage and Lighting", 3)
end)

cmd.add({"waveat", "wat"}, {"waveat <player> (wat)", "Wave to a player"}, function(...)
	local playerName = (...)
	local targets = getPlr(playerName)
	if #targets == 0 then return end
	local plr = targets[1]
	local char = getChar()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local localRoot = getRoot(char)
	local oldCFrame = localRoot.CFrame
	local targetRoot = getRoot(plr.Character)
	if targetRoot then
		localRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -3)
		local charPos = char.PrimaryPart.Position
		local targetHRP = getRoot(plr.Character)
		if targetHRP then
			local newCFrame = CFrame.new(charPos, Vector3.new(targetHRP.Position.X, charPos.Y, targetHRP.Position.Z))
			Players.LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame)
		end
		local waveAnim = InstanceNew("Animation")
		if IsR15() then
			waveAnim.AnimationId = "rbxassetid://507770239"
		else
			waveAnim.AnimationId = "rbxassetid://128777973"
		end
		local wave = humanoid:LoadAnimation(waveAnim)
		wave:Play(-1, 5, -1)
		wait(1.6)
		wave:Stop()
		localRoot.CFrame = oldCFrame
	end
end, true)

bang, bangAnim, bangLoop, bangDied, bangParts = nil, nil, nil, nil, {}

cmd.add({"headbang", "mouthbang", "headfuck", "mouthfuck", "facebang", "facefuck", "hb", "mb"}, {"headbang <player> (mouthbang,headfuck,mouthfuck,facebang,facefuck,hb,mb)", "Bang them in the mouth because you are gay"}, function(h, d)
	local speed = d or 10
	local username = h
	local players = getPlr(username)
	if #players == 0 then return end
	local plr = players[1]
	bangAnim = InstanceNew("Animation")
	if not IsR15(Players.LocalPlayer) then
		bangAnim.AnimationId = "rbxassetid://148840371"
	else
		bangAnim.AnimationId = "rbxassetid://5918726674"
	end
	local humanoid = getChar():FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	bang = humanoid:LoadAnimation(bangAnim)
	bang:Play(0.1, 1, 1)
	bang:AdjustSpeed(speed)
	local bangplr = plr.Name
	bangDied = humanoid.Died:Connect(function()
		if bangLoop then
			bangLoop:Disconnect()
		end
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
		for _, part in pairs(bangParts) do
			part:Destroy()
		end
		bangParts = {}
	end)
	for _, part in pairs(bangParts) do
		part:Destroy()
	end
	bangParts = {}
	local thick = 0.2
	local halfWidth = 2
	local halfDepth = 2
	local halfHeight = 3
	local walls = {
		{offset = CFrame.new(0, 0, halfDepth + thick/500), size = Vector3.new(4, 6, thick)},
		{offset = CFrame.new(0, 0, -(halfDepth + thick/500)), size = Vector3.new(4, 6, thick)},
		{offset = CFrame.new(halfWidth + thick/500, 0, 0), size = Vector3.new(thick, 6, 4)},
		{offset = CFrame.new(-(halfWidth + thick/500), 0, 0), size = Vector3.new(thick, 6, 4)},
		{offset = CFrame.new(0, halfHeight + thick/500, 0), size = Vector3.new(4, thick, 4)},
		{offset = CFrame.new(0, -(halfHeight + thick/500), 0), size = Vector3.new(4, thick, 4)}
	}
	for i, wall in ipairs(walls) do
		local part = InstanceNew("Part")
		part.Size = wall.size
		part.Anchored = true
		part.CanCollide = true
		part.Transparency = 1
		part.Parent = game:GetService("Workspace").CurrentCamera
		Insert(bangParts, part)
	end
	local bangOffset = CFrame.new(0, 1, -1.1)
	bangLoop = RunService.Stepped:Connect(function()
		pcall(function()
			local targetCharacter = Players[bangplr].Character
			if targetCharacter then
				local otherHead = targetCharacter:FindFirstChild("Head")
				local localRoot = getRoot(getChar())
				if otherHead and localRoot then
					localRoot.CFrame = otherHead.CFrame * bangOffset
				end
				local charPos = getChar().PrimaryPart.Position
				local targetRoot = getRoot(plr.Character)
				if targetRoot then
					local newCFrame = CFrame.new(charPos, Vector3.new(targetRoot.Position.X, charPos.Y, targetRoot.Position.Z))
					Players.LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame)
				end
				for i, wall in ipairs(walls) do
					bangParts[i].CFrame = localRoot.CFrame * wall.offset
				end
			end
		end)
	end)
end, true)

cmd.add({"unheadbang", "unmouthbang", "unhb", "unmb"}, {"unheadbang (unmouthbang,unhb,unmb)", "Stops headbang"}, function()
	if bangLoop then
		bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
	end
	for _, part in pairs(bangParts) do
		part:Destroy()
	end
	bangParts = {}
end)

jerkAnim, jerkTrack, jerkLoop, jerkDied, jerkParts = nil, nil, nil, nil, {}

cmd.add({"jerkuser", "jorkuser"}, {"jerkuser <player> (jorkuser)", "Lay under them and vibe"}, function(h, d)
	if not IsR6() then DoNotif("command requires R6",3) return end
	local username = h
	local players = getPlr(username)
	if #players == 0 then return end
	local plr = players[1]

	local char = getChar()
	if not char then return end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	jerkAnim = InstanceNew("Animation")
	jerkAnim.AnimationId = "rbxassetid://95383980"
	jerkTrack = humanoid:LoadAnimation(jerkAnim)
	jerkTrack.Looped = true
	jerkTrack:Play()

	humanoid.Sit = true
	Wait(0.1)

	local root = getRoot(char)
	if not root then return end

	root.CFrame = root.CFrame * CFrame.Angles(math.pi * 0.5, math.pi, 0)

	for _, part in pairs(jerkParts) do
		part:Destroy()
	end
	jerkParts = {}
	
	local thick = 0.2
	local halfWidth = 2
	local halfDepth = 2
	local halfHeight = 3
	local walls = {
		{offset = CFrame.new(0, 0, halfDepth + thick / 500), size = Vector3.new(4, 6, thick)},
		{offset = CFrame.new(0, 0, -(halfDepth + thick / 500)), size = Vector3.new(4, 6, thick)},
		{offset = CFrame.new(halfWidth + thick / 500, 0, 0), size = Vector3.new(thick, 6, 4)},
		{offset = CFrame.new(-(halfWidth + thick / 500), 0, 0), size = Vector3.new(thick, 6, 4)},
		{offset = CFrame.new(0, halfHeight + thick / 500, 0), size = Vector3.new(4, thick, 4)},
		{offset = CFrame.new(0, -(halfHeight + thick / 500), 0), size = Vector3.new(4, thick, 4)}
	}
	
	for i, wall in ipairs(walls) do
		local part = InstanceNew("Part")
		part.Size = wall.size
		part.Anchored = true
		part.CanCollide = true
		part.Transparency = 1
		part.Parent = game:GetService("Workspace").CurrentCamera
		Insert(jerkParts, part)
	end

	local jerkOffset = CFrame.new(0, -2.5, -0.25) * CFrame.Angles(math.pi * 0.5, 0, math.pi)
	jerkLoop = RunService.Stepped:Connect(function()
		pcall(function()
			for i, wall in ipairs(walls) do
				jerkParts[i].CFrame = root.CFrame * wall.offset
			end
			local targetChar = plr.Character
			local targetRoot = targetChar and getRoot(targetChar)
			if targetRoot then
				root.CFrame = targetRoot.CFrame * jerkOffset
			end
		end)
	end)

	jerkDied = humanoid.Died:Connect(function()
		if jerkLoop then jerkLoop:Disconnect() end
		if jerkTrack then jerkTrack:Stop() end
		if jerkAnim then jerkAnim:Destroy() end
		for _, part in pairs(jerkParts) do
			part:Destroy()
		end
		jerkParts = {}
	end)
end, true)

cmd.add({"unjerkuser", "unjorkuser"}, {"unjerkuser (unjorkuser)", "Stop the jerk user action"}, function()
	if jerkLoop then jerkLoop:Disconnect() end
	if jerkTrack then jerkTrack:Stop() end
	if jerkAnim then jerkAnim:Destroy() end
	if jerkDied then jerkDied:Disconnect() end

	local char = getChar()
	local root = char and getRoot(char)
	if root then
		root.CFrame = root.CFrame * CFrame.Angles(0, math.pi, 0)
	end

	local humanoid = char and char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Sit = false
	end

	for _, part in pairs(jerkParts) do
		part:Destroy()
	end
	jerkParts = {}
end)

suckLOOP = nil
suckANIM = nil
suckDIED = nil
doSUCKING = nil
SUCKYSUCKY = {}

cmd.add({"suck", "dicksuck"}, {"suck <player> <number> (dicksuck)", "suck it"}, function(h, d)
    if suckLOOP then
        suckLOOP = nil
    end
    if doSUCKING then
        doSUCKING:Stop()
    end
    if suckANIM then
        suckANIM:Destroy()
    end
    if suckDIED then
        suckDIED:Disconnect()
    end
    for _, p in pairs(SUCKYSUCKY) do
        p:Destroy()
    end
    SUCKYSUCKY = {}
    
    local speed = d or 10
    local tweenDuration = 1 / speed
    local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local username = h
    local targets = getPlr(username)
    if #targets == 0 then return end
    local plr = targets[1]
    
    suckANIM = InstanceNew("Animation")
    local isR15 = IsR15(Players.LocalPlayer)
    if not isR15 then
        suckANIM.AnimationId = "rbxassetid://189854234"
    else
        suckANIM.AnimationId = "rbxassetid://5918726674"
    end
    local hum = getChar():FindFirstChildOfClass("Humanoid")
    doSUCKING = hum:LoadAnimation(suckANIM)
    doSUCKING:Play(0.1, 1, 1)
    doSUCKING:AdjustSpeed(speed)
    
    suckDIED = hum.Died:Connect(function()
        if suckLOOP then
            suckLOOP = nil
        end
        doSUCKING:Stop()
        suckANIM:Destroy()
        if suckDIED then
            suckDIED:Disconnect()
        end
        for _, part in pairs(SUCKYSUCKY) do
            part:Destroy()
        end
        SUCKYSUCKY = {}
    end)
    
    local thick = 0.2
    local halfWidth = 2
    local halfDepth = 2
    local halfHeight = 3
    local walls = {
        {offset = CFrame.new(0, 0, halfDepth + thick/500), size = Vector3.new(4, 6, thick)},
        {offset = CFrame.new(0, 0, -(halfDepth + thick/500)), size = Vector3.new(4, 6, thick)},
        {offset = CFrame.new(halfWidth + thick/500, 0, 0), size = Vector3.new(thick, 6, 4)},
        {offset = CFrame.new(-(halfWidth + thick/500), 0, 0), size = Vector3.new(thick, 6, 4)},
        {offset = CFrame.new(0, halfHeight + thick/500, 0), size = Vector3.new(4, thick, 4)},
        {offset = CFrame.new(0, -(halfHeight + thick/500), 0), size = Vector3.new(4, thick, 4)}
    }
    for i, wall in ipairs(walls) do
        local part = InstanceNew("Part")
        part.Size = wall.size
        part.Anchored = true
        part.CanCollide = true
        part.Transparency = 1
        part.Parent = game:GetService("Workspace").CurrentCamera
        Insert(SUCKYSUCKY, part)
    end
    
    suckLOOP = coroutine.wrap(function()
        while true do
            local targetCharacter = plr.Character
            local localCharacter = getChar()
            if targetCharacter and getRoot(targetCharacter) and localCharacter and getRoot(localCharacter) then
                local targetHRP = getRoot(targetCharacter)
                local localHRP = getRoot(localCharacter)
                local forwardCFrame = targetHRP.CFrame * CFrame.new(0, -2.3, -2.5) * CFrame.Angles(0, math.pi, 0)
                local backwardCFrame = targetHRP.CFrame * CFrame.new(0, -2.3, -1.3) * CFrame.Angles(0, math.pi, 0)
                local tweenForward = TweenService:Create(
                    localHRP,
                    TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {CFrame = forwardCFrame}
                )
                tweenForward:Play()
                tweenForward.Completed:Wait()
                local tweenBackward = TweenService:Create(
                    localHRP,
                    TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {CFrame = backwardCFrame}
                )
                tweenBackward:Play()
                tweenBackward.Completed:Wait()
                for i, wall in ipairs(walls) do
                    SUCKYSUCKY[i].CFrame = localHRP.CFrame * wall.offset
                end
            else
                break
            end
        end
    end)
    suckLOOP()
end, true)

cmd.add({"unsuck", "undicksuck"}, {"unsuck (undicksuck)", "no more fun"}, function()
    if suckLOOP then
        suckLOOP = nil
    end
    if doSUCKING then
        doSUCKING:Stop()
    end
    if suckANIM then
        suckANIM:Destroy()
    end
    if suckDIED then
        suckDIED:Disconnect()
    end
    for _, p in pairs(SUCKYSUCKY) do
        p:Destroy()
    end
    SUCKYSUCKY = {}
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

HumanModCons = {}

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

bangLoop = nil
bangAnim = nil
bangDied = nil
doBang = nil
BANGPARTS = {}

cmd.add({"bang", "fuck"}, {"bang <player> <number> (fuck)", "fucks the player by attaching to them"}, function(h, d)
    if bangLoop then
        bangLoop:Disconnect()
    end
    if doBang then
        doBang:Stop()
    end
    if bangAnim then
        bangAnim:Destroy()
    end
    if bangDied then
        bangDied:Disconnect()
    end
    for _, p in pairs(BANGPARTS) do
        p:Destroy()
    end
    BANGPARTS = {}
    
    local speed = d or 10
    local username = h
    local targets = getPlr(username)
    if #targets == 0 then return end
    local plr = targets[1]
    
    bangAnim = InstanceNew("Animation")
    if not IsR15(Players.LocalPlayer) then
        bangAnim.AnimationId = "rbxassetid://148840371"
    else
        bangAnim.AnimationId = "rbxassetid://5918726674"
    end
    local hum = getChar():FindFirstChildOfClass("Humanoid")
    doBang = hum:LoadAnimation(bangAnim)
    doBang:Play(0.1, 1, 1)
    doBang:AdjustSpeed(speed)
    
    local bangplr = plr.Name
    bangDied = hum.Died:Connect(function()
        if bangLoop then
            bangLoop:Disconnect()
        end
        doBang:Stop()
        bangAnim:Destroy()
        if bangDied then
            bangDied:Disconnect()
        end
        for _, part in pairs(BANGPARTS) do
            part:Destroy()
        end
        BANGPARTS = {}
    end)
    
    local thick = 0.2
    local halfWidth = 2
    local halfDepth = 2
    local halfHeight = 3
    local walls = {
        {offset = CFrame.new(0, 0, halfDepth + thick/500), size = Vector3.new(4, 6, thick)},
        {offset = CFrame.new(0, 0, -(halfDepth + thick/500)), size = Vector3.new(4, 6, thick)},
        {offset = CFrame.new(halfWidth + thick/500, 0, 0), size = Vector3.new(thick, 6, 4)},
        {offset = CFrame.new(-(halfWidth + thick/500), 0, 0), size = Vector3.new(thick, 6, 4)},
        {offset = CFrame.new(0, halfHeight + thick/500, 0), size = Vector3.new(4, thick, 4)},
        {offset = CFrame.new(0, -(halfHeight + thick/500), 0), size = Vector3.new(4, thick, 4)}
    }
    for i, wall in ipairs(walls) do
        local part = InstanceNew("Part")
        part.Size = wall.size
        part.Anchored = true
        part.CanCollide = true
        part.Transparency = 1
        part.Parent = game:GetService("Workspace").CurrentCamera
        Insert(BANGPARTS, part)
    end

    local bangOffset = CFrame.new(0, 0, 1.1)
    bangLoop = RunService.Stepped:Connect(function()
        pcall(function()
            local targetRoot = getRoot(Players[bangplr].Character)
            local localRoot = getRoot(getChar())
            if targetRoot and localRoot then
                localRoot.CFrame = targetRoot.CFrame * bangOffset
                for i, wall in ipairs(walls) do
                    BANGPARTS[i].CFrame = localRoot.CFrame * wall.offset
                end
            end
        end)
    end)
end, true)

cmd.add({"unbang", "unfuck"}, {"unbang (unfuck)", "Unbangs the player"}, function()
    if bangLoop then
        bangLoop:Disconnect()
    end
    if doBang then
        doBang:Stop()
    end
    if bangAnim then
        bangAnim:Destroy()
    end
    if bangDied then
        bangDied:Disconnect()
    end
    for _, p in pairs(BANGPARTS) do
        p:Destroy()
    end
    BANGPARTS = {}
end)

inversebangLoop = nil
inversebangAnim = nil
inversebangAnim2 = nil
inversebangDied = nil
doInversebang = nil
doInversebang2 = nil
INVERSEBANGPARTS = {}

cmd.add({"inversebang", "ibang", "inverseb"}, {"inversebang <player> <number> (inversebang/inverseb)", "you're the one getting fucked today ;)"},function(h, d)
    if inversebangLoop then
        inversebangLoop = nil
    end
    if doInversebang then
        doInversebang:Stop()
    end
    if inversebangAnim then
        inversebangAnim:Destroy()
    end
    if inversebangAnim2 then
        inversebangAnim2:Destroy()
    end
    if inversebangDied then
        inversebangDied:Disconnect()
    end
    for _, p in pairs(INVERSEBANGPARTS) do
        p:Destroy()
    end
    INVERSEBANGPARTS = {}
    
    local speed = d or 10
    local username = h
    local targets = getPlr(username)
    if #targets == 0 then return end
    local plr = targets[1]
    
    inversebangAnim = InstanceNew("Animation")
    local isR15 = IsR15(Players.LocalPlayer)
    if not isR15 then
        inversebangAnim.AnimationId = "rbxassetid://189854234"
        inversebangAnim2 = InstanceNew("Animation")
        inversebangAnim2.AnimationId = "rbxassetid://106772613"
    else
        inversebangAnim.AnimationId = "rbxassetid://10714360343"
        inversebangAnim2 = nil
    end
    local hum = getChar():FindFirstChildOfClass("Humanoid")
    doInversebang = hum:LoadAnimation(inversebangAnim)
    doInversebang:Play(0.1, 1, 1)
    doInversebang:AdjustSpeed(speed)
    if not isR15 and inversebangAnim2 then
        doInversebang2 = hum:LoadAnimation(inversebangAnim2)
        doInversebang2:Play(0.1, 1, 1)
        doInversebang2:AdjustSpeed(speed)
    end
    
    inversebangDied = hum.Died:Connect(function()
        if inversebangLoop then
            inversebangLoop = nil
        end
        doInversebang:Stop()
        if doInversebang2 then
            doInversebang2:Stop()
        end
        inversebangAnim:Destroy()
        if inversebangDied then
            inversebangDied:Disconnect()
        end
        for _, part in pairs(INVERSEBANGPARTS) do
            part:Destroy()
        end
        INVERSEBANGPARTS = {}
    end)
    
    local thick = 0.2
    local halfWidth = 2
    local halfDepth = 2
    local halfHeight = 3
    local walls = {
        {offset = CFrame.new(0, 0, halfDepth + thick/500), size = Vector3.new(4, 6, thick)},
        {offset = CFrame.new(0, 0, -(halfDepth + thick/500)), size = Vector3.new(4, 6, thick)},
        {offset = CFrame.new(halfWidth + thick/500, 0, 0), size = Vector3.new(thick, 6, 4)},
        {offset = CFrame.new(-(halfWidth + thick/500), 0, 0), size = Vector3.new(thick, 6, 4)},
        {offset = CFrame.new(0, halfHeight + thick/500, 0), size = Vector3.new(4, thick, 4)},
        {offset = CFrame.new(0, -(halfHeight + thick/500), 0), size = Vector3.new(4, thick, 4)}
    }
    for i, wall in ipairs(walls) do
        local part = InstanceNew("Part")
        part.Size = wall.size
        part.Anchored = true
        part.CanCollide = true
        part.Transparency = 1
        part.Parent = game:GetService("Workspace").CurrentCamera
        Insert(INVERSEBANGPARTS, part)
    end

    local bangOffset = CFrame.new(0, 0, 1.1)
    
    inversebangLoop = coroutine.wrap(function()
        while true do
            local targetCharacter = plr.Character
            local localCharacter = getChar()
            if targetCharacter and getRoot(targetCharacter) and localCharacter and getRoot(localCharacter) then
                local targetHRP = getRoot(targetCharacter)
                local localHRP = getRoot(localCharacter)
                local forwardCFrame = targetHRP.CFrame * CFrame.new(0, 0, -2.5)
                local backwardCFrame = targetHRP.CFrame * CFrame.new(0, 0, -1.3)
                local tweenForward = TweenService:Create(
                    localHRP,
                    TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {CFrame = forwardCFrame}
                )
                tweenForward:Play()
                tweenForward.Completed:Wait()
                local tweenBackward = TweenService:Create(
                    localHRP,
                    TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {CFrame = backwardCFrame}
                )
                tweenBackward:Play()
                tweenBackward.Completed:Wait()
                for i, wall in ipairs(walls) do
                    INVERSEBANGPARTS[i].CFrame = localHRP.CFrame * wall.offset
                end
            else
                break
            end
        end
    end)
    inversebangLoop()
end, true)

cmd.add({"uninversebang", "unibang", "uninverseb"}, {"uninversebang (unibang)", "no more fun"}, function()
    if inversebangLoop then
        inversebangLoop = nil
    end
    if doInversebang then
        doInversebang:Stop()
    end
    if doInversebang2 then
        doInversebang2:Stop()
    end
    if inversebangAnim then
        inversebangAnim:Destroy()
    end
    if inversebangDied then
        inversebangDied:Disconnect()
    end
    for _, p in pairs(INVERSEBANGPARTS) do
        p:Destroy()
    end
    INVERSEBANGPARTS = {}
end)

sussyID = "rbxassetid://106772613"
susTrack, susCONN = nil, nil

cmd.add({"suslay", "laysus"}, {"suslay (laysus)", "Lay down in a suspicious way"}, function()
	if not IsR6() then return DoNotif("R6 only") end

	if susTrack then
		susTrack:Stop()
		susTrack = nil
	end

	if susCONN then
		susCONN:Disconnect()
		susCONN = nil
	end

	local hum = getHum()
	local root = hum.RootPart

	hum.Sit = true
	Wait(0.1)
	root.CFrame *= CFrame.Angles(math.pi * 0.5, 0, 0)

	for _, a in ipairs(hum:GetPlayingAnimationTracks()) do
		a:Stop()
	end

	local anim = InstanceNew("Animation")
	anim.AnimationId = sussyID
	susTrack = hum:LoadAnimation(anim)
	susTrack:Play()

	susCONN = hum:GetPropertyChangedSignal("Jump"):Connect(function()
		if susTrack then
			susTrack:Stop()
			susTrack = nil
		end
		if susCONN then
			susCONN:Disconnect()
			susCONN = nil
		end
	end)
end)

cmd.add({"unsuslay"}, {"unsuslay", "Stand up from the sussy lay"}, function()
	getHum():ChangeState(Enum.HumanoidStateType.Jumping)

	if susTrack then
		susTrack:Stop()
		susTrack = nil
	end

	if susCONN then
		susCONN:Disconnect()
		susCONN = nil
	end
end)

cmd.add({"jerk", "jork"}, {"jerk (jork)", "jorking it"}, function()
	local plr = LocalPlayer
	local bp = plr:FindFirstChildWhichIsA("Backpack")

	local tool = InstanceNew("Tool")
	tool.Name = "Jerking: OFF"
	tool.ToolTip = "i am jorking it"
	tool.RequiresHandle = false
	tool.Parent = bp

	local active, track = false, nil
	local hum = getChar():FindFirstChildOfClass("Humanoid")

	local function updateHum()
		hum = getChar():FindFirstChildOfClass("Humanoid")
	end
	if not hum then updateHum() end

	local function stop()
		active = false
		if track then
			pcall(function() track:Stop() end)
			track = nil
		end
	end

	local function play()
		if not active or not hum then return end
		if not track then
			local anim = InstanceNew("Animation")
			anim.AnimationId = IsR15() and "rbxassetid://698251653" or "rbxassetid://72042024"
			track = hum:LoadAnimation(anim)
			track.Looped = true
		end
		track:Play(0.1, 1, 1)
		track:AdjustSpeed(IsR15() and 0.7 or 0.65)
	end

	tool.Equipped:Connect(function()
		active = true
		tool.Name = "Jerking: ON"
		play()
	end)

	tool.Unequipped:Connect(function()
		tool.Name = "Jerking: OFF"
		stop()
	end)

	plr.CharacterAdded:Connect(updateHum)
	if hum then hum.Died:Connect(stop) end
end)

huggiePARTS = {}
platCON = nil
hugConnections = {}
hugUI = nil
currentHugTracks = {}
currentHugTarget = nil
hugFromFront = false
hugModeEnabled = false

cmd.add({"hug", "clickhug"}, {"hug (clickhug)", "huggies time (click on a target to hug)"}, function()
	if IsR6() then
		local mouse = LocalPlayer:GetMouse()

		for _, conn in pairs(hugConnections) do if conn then conn:Disconnect() end end
		for _, track in pairs(currentHugTracks) do pcall(function() track:Stop() end) end
		currentHugTracks = {}
		hugConnections = {}
		if hugUI then hugUI:Destroy() end
		hugFromFront = false
		currentHugTarget = nil
		if platCON then platCON:Disconnect() platCON = nil end
		for _, part in pairs(huggiePARTS) do part:Destroy() end
		huggiePARTS = {}

		hugUI = InstanceNew("ScreenGui")
		hugUI.Name = "HugModeUI"
		NaProtectUI(hugUI)

		local toggleHugButton = InstanceNew("TextButton")
		toggleHugButton.AnchorPoint = Vector2.new(0.5, 0)
		toggleHugButton.Size = UDim2.new(0, 150, 0, 50)
		toggleHugButton.Position = UDim2.new(0.4, 0, 0.1, 0)
		toggleHugButton.Text = "Hug Mode: OFF"
		toggleHugButton.TextSize = 14
		toggleHugButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		toggleHugButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggleHugButton.Parent = hugUI

		local sideToggleButton = InstanceNew("TextButton")
		sideToggleButton.AnchorPoint = Vector2.new(0.5, 0)
		sideToggleButton.Size = UDim2.new(0, 150, 0, 50)
		sideToggleButton.Position = UDim2.new(0.6, 0, 0.1, 0)
		sideToggleButton.Text = "Hug Side: Back"
		sideToggleButton.TextSize = 14
		sideToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		sideToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		sideToggleButton.Parent = hugUI

		local uiCorner = InstanceNew("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 8)
		uiCorner.Parent = toggleHugButton

		local sideUICorner = InstanceNew("UICorner")
		sideUICorner.CornerRadius = UDim.new(0, 8)
		sideUICorner.Parent = sideToggleButton

		gui.draggablev2(toggleHugButton)
		gui.draggablev2(sideToggleButton)

		hugModeEnabled = false

		local function performHug(targetCharacter)
			currentHugTarget = targetCharacter

			local offsetDistance = 1.5
			local targetHRP = getRoot(targetCharacter)
			local localCharacter = LocalPlayer.Character
			if not localCharacter then return end
			local localHRP = getRoot(localCharacter)
			if targetHRP and localHRP then
				local offset = (hugFromFront and (targetHRP.CFrame.LookVector * offsetDistance)) or (-(targetHRP.CFrame.LookVector * offsetDistance))
				local initialHugPos = targetHRP.Position + offset
				localHRP.CFrame = CFrame.new(initialHugPos, targetHRP.Position)
				local humanoid = getPlrHum(localCharacter)
				if humanoid then
					local anim1 = InstanceNew("Animation")
					anim1.AnimationId = "rbxassetid://283545583"
					local track1 = humanoid:LoadAnimation(anim1)
					local anim2 = InstanceNew("Animation")
					anim2.AnimationId = "rbxassetid://225975820"
					local track2 = humanoid:LoadAnimation(anim2)
					Insert(currentHugTracks, track1)
					Insert(currentHugTracks, track2)
					track1:Play()
					track2:Play()

					if #huggiePARTS == 0 then
						local thick = 0.2
						local halfWidth = 2
						local halfDepth = 2
						local halfHeight = 3
						local walls = {
							{offset = CFrame.new(0, 0, halfDepth + thick/500), size = Vector3.new(4, 6, thick)},
							{offset = CFrame.new(0, 0, -(halfDepth + thick/500)), size = Vector3.new(4, 6, thick)},
							{offset = CFrame.new(halfWidth + thick/500, 0, 0), size = Vector3.new(thick, 6, 4)},
							{offset = CFrame.new(-(halfWidth + thick/500), 0, 0), size = Vector3.new(thick, 6, 4)},
							{offset = CFrame.new(0, halfHeight + thick/500, 0), size = Vector3.new(4, thick, 4)},
							{offset = CFrame.new(0, -(halfHeight + thick/500), 0), size = Vector3.new(4, thick, 4)}
						}
						for i, wall in ipairs(walls) do
							local part = InstanceNew("Part")
							part.Size = wall.size
							part.Anchored = true
							part.CanCollide = true
							part.Transparency = 1
							part.Parent = game:GetService("Workspace").CurrentCamera
							Insert(huggiePARTS, part)
						end
						platCON = RunService.Heartbeat:Connect(function()
							local charRoot = getRoot(LocalPlayer.Character)
							if charRoot then
								for i, wall in ipairs(walls) do
									huggiePARTS[i].CFrame = charRoot.CFrame * wall.offset
								end
							end
						end)
						Insert(hugConnections, platCON)
					end

					Spawn(function()
						while hugModeEnabled and targetCharacter and getRoot(targetCharacter) and (currentHugTarget == targetCharacter) do
							targetHRP = getRoot(targetCharacter)
							offset = (hugFromFront and (targetHRP.CFrame.LookVector * offsetDistance)) or (-(targetHRP.CFrame.LookVector * offsetDistance))
							local newHugPos = targetHRP.Position + offset
							if localHRP then
								localHRP.CFrame = CFrame.new(newHugPos, targetHRP.Position)
							end
							Wait()
						end
					end)
				end
			end
		end

		local conn1 = MouseButtonFix(toggleHugButton, function()
			hugModeEnabled = not hugModeEnabled
			if hugModeEnabled then
				toggleHugButton.Text = "Hug Mode: ON"
			else
				toggleHugButton.Text = "Hug Mode: OFF"
				for _, track in pairs(currentHugTracks) do pcall(function() track:Stop() end) end
				currentHugTracks = {}
				currentHugTarget = nil
				for _, part in pairs(huggiePARTS) do part:Destroy() end
				huggiePARTS = {}
				if platCON then platCON:Disconnect() platCON = nil end
			end
		end)
		Insert(hugConnections, conn1)

		local conn2 = MouseButtonFix(sideToggleButton, function()
			hugFromFront = not hugFromFront
			sideToggleButton.Text = (hugFromFront and "Hug Side: Front") or "Hug Side: Back"
		end)
		Insert(hugConnections, conn2)

		local conn3 = LocalPlayer:GetMouse().Button1Down:Connect(function()
			if not hugModeEnabled then return end
			local target = mouse.Target
			if target and target.Parent then
				local targetPlayer = Players:GetPlayerFromCharacter(target.Parent)
				if targetPlayer and targetPlayer ~= LocalPlayer and targetPlayer.Character then
					performHug(targetPlayer.Character)
				end
			end
		end)
		Insert(hugConnections, conn3)
	else
		DoNotif("command requires R6")
	end
end)

cmd.add({"unhug"}, {"unhug", "no huggies :("}, function()
	for _, conn in pairs(hugConnections) do if conn then conn:Disconnect() end end
	for _, track in pairs(currentHugTracks) do pcall(function() track:Stop() end) end
	currentHugTracks = {}
	hugConnections = {}
	currentHugTarget = nil
	hugFromFront = false
	hugModeEnabled = false
	if platCON then platCON:Disconnect() platCON = nil end
	for _, part in pairs(huggiePARTS) do part:Destroy() end
	huggiePARTS = {}
	if hugUI then hugUI:Destroy() hugUI = nil end
end)

glueloop = {}

cmd.add({"glue", "loopgoto", "lgoto"}, {"glue <player> (loopgoto,lgoto)", "Loop teleport to a player"}, function(...)
	local user = (...)
	local targets = getPlr(user)
	for _, plr in next, targets do
		if glueloop[plr] then
			glueloop[plr]:Disconnect()
			glueloop[plr] = nil
		end
		glueloop[plr] = RunService.RenderStepped:Connect(function()
			local char = plr.Character
			if char then
				local targetRoot = getRoot(char)
				local localRoot = getRoot(getChar())
				if targetRoot and localRoot then
					localRoot.CFrame = targetRoot.CFrame
				end
			end
		end)
	end
end, true)

cmd.add({"unglue", "unloopgoto", "noloopgoto"}, {"unglue (unloopgoto,noloopgoto)", "Stops teleporting you to a player"}, function()
	for _, connection in pairs(glueloop) do
		connection:Disconnect()
	end
	glueloop = {}
end)

glueBACKER = {}

cmd.add({"glueback", "loopbehind", "lbehind"}, {"glueback <player> (loopbehind,lbehind)", "Loop teleport behind a player"}, function(...)
	local input = (...)
	local players = getPlr(input)
	for _, target in next, players do
		if glueBACKER[target] then
			glueBACKER[target]:Disconnect()
			glueBACKER[target] = nil
		end
		glueBACKER[target] = RunService.RenderStepped:Connect(function()
			local targetChar = target.Character
			if targetChar then
				local targetRoot = getRoot(targetChar)
				local localRoot = getRoot(getChar())
				if targetRoot and localRoot then
					local cf = targetRoot.CFrame * CFrame.new(0, 0, 3)
					localRoot.CFrame = CFrame.new(cf.Position, targetRoot.Position)
				end
			end
		end)
	end
end, true)

cmd.add({"unglueback", "unloopbehind", "unlbehind"}, {"unglueback (unloopbehind,unlbehind)", "Stops teleporting you to a player"}, function()
	for _, conn in pairs(glueBACKER) do
		conn:Disconnect()
	end
	glueBACKER = {}
end)

cmd.add({"spook", "scare"}, {"spook <player> (scare)", "Teleports next to a player for a few seconds"}, function(...)
	local username = (...)
	local targets = getPlr(username)
	for _, plr in next, targets do
		local char = getChar()
		local root = getRoot(char)
		local oldCF = root.CFrame  
		local distancepl = 2
		if plr.Character and plr.Character:FindFirstChild("Humanoid") then
			local targetRoot = getRoot(plr.Character)
			if targetRoot then
				root.CFrame = targetRoot.CFrame + targetRoot.CFrame.LookVector * distancepl
				root.CFrame = CFrame.new(root.Position, targetRoot.Position)
				wait(0.5)
				root.CFrame = oldCF
			end
		end
	end
end, true)

loopspook = false

cmd.add({"loopspook", "loopscare"}, {"loopspook <player> (loopscare)", "Teleports next to a player repeatedly"}, function(...)
	local t = getPlr(...)
	loopspook = true

	Spawn(function()
		while loopspook do
			for _, p in ipairs(t) do
				local lc = getChar()
				local lr = getRoot(lc)
				if p.Character and p.Character:FindFirstChild("Humanoid") then
					local tr = getRoot(p.Character)
					if lr and tr then
						local old = lr.CFrame
						lr.CFrame = tr.CFrame + tr.CFrame.LookVector * 2
						lr.CFrame = CFrame.new(lr.Position, tr.Position)
						Wait(0.5)
						lr.CFrame = old
					end
				end
			end
			Wait(0.3)
		end
	end)
end, true)

cmd.add({"unloopspook", "unloopscare"}, {"unloopspook (unloopscare)", "Stops the loopspook command"}, function()
	loopspook = false
end)

Airwalker, awPart = nil, nil
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

cmd.add({"airwalk", "float", "aw"}, {"airwalk (float, aw)", "Press space to go up, unairwalk to stop"}, function()
	DoNotif(IsOnMobile and "Airwalk: ON" or "Airwalk: ON (Q And E)")
	if Airwalker then Airwalker:Disconnect() Airwalker = nil end
	if awPart then awPart:Destroy() awPart = nil end

	function createButton(parent, text, position, callbackDown, callbackUp)
		local button = InstanceNew("TextButton")
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

		local corner = InstanceNew("UICorner", button)
		corner.CornerRadius = UDim.new(0.2, 0)

		local stroke = InstanceNew("UIStroke", button)
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Thickness = 2

		local hoverEffect = function(isHovering)
			button.BackgroundColor3 = isHovering and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(45, 45, 45)
		end

		button.MouseEnter:Connect(function() hoverEffect(true) end)
		button.MouseLeave:Connect(function() hoverEffect(false) end)
		button.MouseButton1Down:Connect(callbackDown)
		button.MouseButton1Up:Connect(callbackUp)
		gui.draggablev2(button)

		return button
	end

	if IsOnMobile then
		local guiDown = InstanceNew("ScreenGui")
		NaProtectUI(guiDown)
		guiDown.ResetOnSpawn = false
		airwalk.guis.down = guiDown
		createButton(guiDown, "DOWN", UDim2.new(0.9, 0, 0.7, 0), function() airwalk.Vars.decrease = true end, function() airwalk.Vars.decrease = false end)

		local guiUp = InstanceNew("ScreenGui")
		NaProtectUI(guiUp)
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

	awPart = InstanceNew("Part", game:GetService("Workspace"))
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

bringc = {}

cmd.add({"cbring", "clientbring"}, {"clientbring <player> (cbring)", "Brings the player on your client"}, function(...)
	local username = (...)
	local target = getPlr(username)
	if connections["noclip"] then
		lib.disconnect("noclip")
		return
	end
	lib.connect("noclip", RunService.Stepped:Connect(function()
		local char = getChar()
		if not char then return end
		for _, descendant in pairs(char:GetDescendants()) do
			if descendant:IsA("BasePart") then
				descendant.CanCollide = false
			end
		end
	end))
	for _, plr in next, target do
		if not plr then return end
		local conn = RunService.RenderStepped:Connect(function()
			if plr.Character then
				local targetRoot = getRoot(plr.Character)
				local localRoot = getRoot(getChar())
				if targetRoot and localRoot then
					targetRoot.CFrame = localRoot.CFrame + localRoot.CFrame.LookVector * 3
				end
			end
		end)
		Insert(bringc, conn)
	end
end, true)

cmd.add({"uncbring", "unclientbring"}, {"unclientbring (uncbring)", "Disable Client bring command"}, function()
	for _, conn in ipairs(bringc) do
		conn:Disconnect()
	end
	bringc = {}
	if connections["noclip"] then
		lib.disconnect("noclip")
	end
end)

cmd.add({"mute", "muteboombox"}, {"mute <player> (muteboombox)", "Mutes the player's boombox"}, function(...)
	local uuuu = ...
	local pp = getPlr(uuuu)

	local function NONOSOUND(container)
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("Sound") and descendant.Playing then
				descendant.Playing = false
			end
		end
	end

	for _, plr in ipairs(pp) do
		if plr and plr.Character then
			NONOSOUND(plr.Character)
		end

		local BK = plr:FindFirstChildOfClass("Backpack")
		if BK then
			NONOSOUND(BK)
		end
	end
end, true)

TPWalk = false
TPWalkingConnection = nil

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

muteLOOP = {}

cmd.add({"loopmute", "loopmuteboombox"}, {"loopmute <player> (loopmuteboombox)", "Loop mutes the player's boombox"}, function(...)
	local u = ...
	local pls = getPlr(u)

	local function mute(p)
		if p and p.Character then
			for _, d in ipairs(p.Character:GetDescendants()) do
				if d:IsA("Sound") and d.Playing then
					d.Playing = false
				end
			end
		end
		local bp = p:FindFirstChildOfClass("Backpack")
		if bp then
			for _, d in ipairs(bp:GetDescendants()) do
				if d:IsA("Sound") and d.Playing then
					d.Playing = false
				end
			end
		end
	end

	for _, p in ipairs(pls) do
		local id = p.UserId
		if not muteLOOP[id] then
			muteLOOP[id] = Spawn(function()
				while p and p.Parent do
					mute(p)
					Wait(1)
				end
				muteLOOP[id] = nil
			end)
			DoNotif("Loopmuted "..p.Name)
		else
			DoNotif(p.Name.." already loopmuted")
		end
	end
end, true)

cmd.add({"unloopmute", "unloopmuteboombox"}, {"unloopmute <player> (unloopmuteboombox)", "Unloop mutes the player's boombox"}, function(...)
	local u = ...
	local pls = getPlr(u)

	for _, p in ipairs(pls) do
		local id = p.UserId
		local t = muteLOOP[id]
		if t then
			coroutine.close(t)
			muteLOOP[id] = nil
			DoNotif("Unloopmuted "..p.Name)
		else
			DoNotif(p.Name.." not loopmuted")
		end
	end
end, true)

cmd.add({"getmass"},{"getmass <player>","Get your mass"},function(...)
	target=getPlr(...)
	for _, plr in next, target do
		local mass=getRoot(plr.Character).AssemblyMass 
		Wait();

		DoNotif(plr.Name.."'s mass is "..mass)
	end
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

cmd.add({"removeterrain", "rterrain", "noterrain"},{"removeterrain (rterrain, noterrain)","clears terrain"},function()
	game:GetService("Workspace"):FindFirstChildOfClass('Terrain'):Clear()
end)

cmd.add({"clearnilinstances", "nonilinstances", "cni"},{"clearnilinstances (nonilinstances, cni)","Removes nil instances"},function()
	if getnilinstances then
		for _,nill in pairs(getnilinstances()) do
			nill:Destroy()
		end
	else
		DoNotif("Your exploit does not support getnilinstances")
	end
end)

cmd.add({"inspect"}, {"inspect", "checks a user's items"}, function(args)
	local targetPlayers = getPlr(args)

	for _, plr in next, targetPlayers do
		GuiService:CloseInspectMenu()
		GuiService:InspectPlayerFromUserId(plr.UserId)
	end
end, true)

cmd.add({"noprompt","nopurchaseprompts","noprompts"},{"noprompt (nopurchaseprompts,noprompts)","remove the stupid purchase prompt"},function()
	Wait();

	COREGUI.PurchasePrompt.Enabled=false

	DoNotif("Purchase prompts have been disabled")
end)

cmd.add({"prompt","purchaseprompts","showprompts","showpurchaseprompts"},{"prompt (purchaseprompts,showprompts,showpurchaseprompts)","allows the stupid purchase prompt"},function()
	Wait();

	COREGUI.PurchasePrompt.Enabled=true

	DoNotif("Purchase prompts have been enabled")
end)

cmd.add({"wallwalk"},{"wallwalk","Makes you walk on walls"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/WallWalk.lua"))() -- backup cause i don't trust pastebin
end)

hiddenGUIS = {}

cmd.add({"hideguis"}, {"hideguis", "Hides GUIs"}, function()
	for _, guiElement in pairs(PlrGui:GetDescendants()) do
		if (guiElement:IsA("Frame") or guiElement:IsA("ImageLabel") or guiElement:IsA("ScrollingFrame")) and guiElement.Visible then
			guiElement.Visible = false
			if not Discover(hiddenGUIS, guiElement) then
				Insert(hiddenGUIS, guiElement)
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

spinThingy = nil
spinPart = nil

cmd.add({"spin"}, {"spin {amount}", "Makes your character spin as fast as you want"}, function(...)
	Wait()

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

	spinPart = InstanceNew("Part")
	spinPart.Anchored = false
	spinPart.CanCollide = false
	spinPart.Transparency = 1
	spinPart.Size = Vector3.new(1, 1, 1)
	spinPart.Parent = workspace.CurrentCamera
	spinPart.CFrame = getRoot(LocalPlayer.Character).CFrame

	spinThingy = InstanceNew("BodyAngularVelocity")
	spinThingy.Parent = spinPart
	spinThingy.MaxTorque = Vector3.new(0, math.huge, 0)
	spinThingy.AngularVelocity = Vector3.new(0, spinSpeed, 0)

	local weld = InstanceNew("WeldConstraint")
	weld.Part0 = spinPart
	weld.Part1 = getRoot(LocalPlayer.Character)
	weld.Parent = spinPart

	DoNotif("Spinning...")
end, true)

cmd.add({"unspin"}, {"unspin", "Makes your character unspin"}, function()
	Wait()

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
		local owner = "Hosvile"
		local branch = "revision"

		local function webImport(file)
			return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/MC-Hydroxide/%s/%s.lua"):format(owner, branch, file)), file..'.lua')()
		end

		webImport("init")
		webImport("ui/main")
	else
		local owner="Upbolt"
		local branch="revision"

		local function webImport(file)
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
	game:GetService("Workspace").Gravity=(...)
end,true)

cmd.add({"fireclickdetectors","fcd","firecd"},{"fireclickdetectors (fcd,firecd)","Fires every click detector that's in workspace"},function()
	local ccamount=0
	for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("ClickDetector") then
			ccamount=ccamount+1
			fireclickdetector(v)
		end
	end

	Wait();

	DoNotif("Fired "..ccamount.." amount of click detectors")
end)

cmd.add({"noclickdetectorlimits","nocdlimits","removecdlimits"},{"noclickdetectorlimits <limit> (nocdlimits,removecdlimits)","Sets all click detectors MaxActivationDistance to math.huge"},function(...)
	for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
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
	for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			if (...) == nil then
				v.MaxActivationDistance=math.huge
			else
				v.MaxActivationDistance=(...)
			end
		end
	end
end,true)

doIpp=nil

cmd.add({"instantproximityprompts","instantpp","ipp"},{"instantproximityprompts (instantpp,ipp)","Disable the cooldown for proximity prompts"},function()
	if doIpp then doIpp:Disconnect() doIpp=nil end
	doIpp=ProximityPromptService.PromptButtonHoldBegan:Connect(function(pp)
		fireproximityprompt(pp,1)
	end)
end)

cmd.add({"uninstantproximityprompts","uninstantpp","unipp"},{"uninstantproximityprompts (uninstantpp,unipp)","Undo the cooldown removal"},function()
	if doIpp then doIpp:Disconnect() doIpp=nil end
end)

cmd.add({"r6"},{"r6","Shows a prompt that will switch your character rig type into R6"},function()
	AvatarEditorService:PromptSaveAvatar(getPlrHum(LocalPlayer).HumanoidDescription,Enum.HumanoidRigType.R6)
	AvatarEditorService.PromptSaveAvatarCompleted:Wait()
	Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
	Player.Character:FindFirstChildOfClass("Humanoid").Health=0
end)

cmd.add({"r15"},{"r15","Shows a prompt that will switch your character rig type into R15"},function()
	AvatarEditorService:PromptSaveAvatar(getPlrHum(LocalPlayer).HumanoidDescription,Enum.HumanoidRigType.R15)
	AvatarEditorService.PromptSaveAvatarCompleted:Wait()
	Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
	Player.Character:FindFirstChildOfClass("Humanoid").Health=0
end)

cmd.add({"maxslopeangle", "msa"}, {"maxslopeangle (msa)", "Changes your character's MaxSlopeAngle"}, function(...)
	local args = {...}
	local amount = tonumber(args[1]) or 89

	local humanoid = getHum()
	if humanoid and humanoid:IsA("Humanoid") then
		humanoid.MaxSlopeAngle = amount
		DoNotif(Format("Set MaxSlopeAngle to %s", tostring(amount)), 2)
	else
		DoNotif("Humanoid not found or invalid.", 2)
	end
end,true)

goedMoed = nil

cmd.add({"godmode", "god"}, {"godmode (god)", "Toggles invincibility"}, function()
	local humanoid = getHum()
	if humanoid then
		if goedMoed then goedMoed:Disconnect() goedMoed=nil end
		goedMoed=humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if humanoid.Health ~= humanoid.MaxHealth then
				humanoid.Health = humanoid.MaxHealth
			end
		end)
		humanoid.Health = humanoid.MaxHealth
		DoNotif("Godmode ON", 2)
	else
		DoNotif("Humanoid not found", 2)
	end
end)

cmd.add({"ungodmode", "ungod"}, {"ungodmode (ungod)", "Disables invincibility"}, function()
	if goedMoed then goedMoed:Disconnect() goedMoed=nil DoNotif("Godmode OFF", 2) end
end)

cmd.add({"controllock", "ctrllock"}, {"controllock (ctrllock)", "Sets your Shiftlock keybinds to the control keys"}, function()
	local player = Players.LocalPlayer
	local mouseLockController = player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
	local boundKeys = mouseLockController:WaitForChild("BoundKeys")

	boundKeys.Value = "LeftControl,RightControl"

	DoNotif("Set your Shiftlock keybinds to Ctrl")
end)

cmd.add({"resetlock"}, {"resetlock", "Resets your Shiftlock keybinds to default (LeftShift)"}, function()
	local player = game.Players.LocalPlayer
	local mouseLockController = player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
	local boundKeys = mouseLockController:WaitForChild("BoundKeys")

	boundKeys.Value = "LeftShift,RightShift"

	DoNotif("Reset your Shiftlock keybinds to Shift")
end)

cmd.add({"autoreport"}, {"autoreport", "Automatically reports players to get them banned"}, function()
	local ReportKeywords = {
		kid = "Bullying",
		youtube = "Offsite Links",
		date = "Dating",
		hack = "Cheating/Exploiting",
		idiot = "Bullying",
		fat = "Bullying",
		exploit = "Cheating/Exploiting",
		cheat = "Cheating/Exploiting",
		noob = "Bullying",
		clown = "Bullying",
	}

	local function CheckIfReportable(message)
		message = message:lower()
		for keyword, reason in pairs(ReportKeywords) do
			if message:find(keyword) then
				return keyword, reason
			end
		end
		return nil, nil
	end

	local function MonitorPlayerChat(player)
		if player == LocalPlayer then return end

		player.Chatted:Connect(function(message)
			local keyword, reason = CheckIfReportable(message)
			if keyword and reason then
				DoNotif(Format("Reported %s", nameChecker(player)).." | "..Format("Reason - %s", reason))

				if reportplayer then
					reportplayer(player, reason, Format("Saying %s", keyword))
				else
					game:GetService("Players"):ReportAbuse(player, reason, Format("Saying %s", keyword))
				end
			end
		end)
	end

	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		MonitorPlayerChat(player)
	end

	game:GetService("Players").PlayerAdded:Connect(function(player)
		MonitorPlayerChat(player)
	end)
end)

cmd.add({"light"}, {"light <range> <brightness>", "Gives your player dynamic light"}, function(range, brightness)
	range = tonumber(range) or 30
	brightness = tonumber(brightness) or 1

	local light = InstanceNew("PointLight")
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
		Insert(lightingButtons, {
			Text = lightingType.Name,
			Callback = function()
				Lighting.Technology = lightingType
			end
		})
	end

	Insert(lightingButtons, {
		Text = "Cancel",
		Callback = function() end
	})

	Notify({
		Title = "Lighting Technology Options",
		Buttons = lightingButtons
	})
end)

cmd.add({"friend"}, {"friend", "Sends a friend request to your target"}, function(p)
	local Targets = getPlr(p)

	for Index, Target in next, Targets do
		LocalPlayer:RequestFriendship(Target)
	end
end)

cmd.add({"tweengotocampos","tweentocampos","tweentcp"},{"tweengotocampos (tweentcp)","Another version of goto camera position but bypassing more anti-cheats"},function()
	local player=Players.LocalPlayer
	local UserInputService=UserInputService
	local TweenService=TweenService

	function teleportPlayer()
		local character=player.Character or player.CharacterAdded:wait(1)
		local camera=game:GetService("Workspace").CurrentCamera
		local cameraPosition=camera.CFrame.Position

		local tween=TweenService:Create(character.PrimaryPart,TweenInfo.new(2),{
			CFrame=CFrame.new(cameraPosition)
		})

		tween:Play()
	end


	local camera=game:GetService("Workspace").CurrentCamera
	repeat Wait() until camera.CFrame~=CFrame.new()

	teleportPlayer()

end)

cmd.add({"delete", "remove", "del"}, {"delete {partname} (remove, del)", "Removes any part with a certain name from the workspace"}, function(...)
	local deleteCount = 0
	local args = {...}
	local targetName = Concat(args, " ")

	for _, d in pairs(game:GetService("Workspace"):GetDescendants()) do
		if d.Name:lower() == targetName:lower() then
			d:Destroy()
			deleteCount = deleteCount + 1
		end
	end

	Wait()

	if deleteCount > 0 then
		DoNotif("Deleted "..deleteCount.." instance(s) of '"..targetName.."'", 2.5)
	else
		DoNotif("'"..targetName.."' not found to delete", 2.5)
	end
end, true)

cmd.add({"deletefind", "removefind", "delfind"}, {"deletefind {partname} (removefind, delfind)", "Removes any part with a name containing the given text from the workspace"}, function(...)
	local deFind = 0
	local targetName = Concat({...}, " "):lower()

	for _, d in pairs(game:GetService("Workspace"):GetDescendants()) do
		if d.Name:lower():find(targetName) then
			d:Destroy()
			deFind = deFind + 1
		end
	end

	Wait()

	if deFind > 0 then
		DoNotif("Deleted "..deFind.." instance(s) containing '"..targetName.."'", 2.5)
	else
		DoNotif("No instances found containing '"..targetName.."'", 2.5)
	end
end, true)

cmd.add({"deletelighting", "removelighting", "removel", "ldel"},{"deletelighting (removelighting, removel, ldel)","Removes all descendants (objects) within Lighting."},function()
    for _, l in ipairs(game:GetService("Lighting"):GetDescendants()) do
        l:Destroy()
    end
end)

autoRemover = {}
autoRemoveConnection = nil

function handleDescendantAdd(part)
	if #autoRemover > 0 then
		if FindInTable(autoRemover, part.Name:lower()) then
			Wait()
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
	local targetName = Concat(args, " "):lower()

	if not FindInTable(autoRemover, targetName) then
		Insert(autoRemover, targetName)
		for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
			if part.Name:lower() == targetName then
				part:Destroy()
			end
		end
	end

	if not autoRemoveConnection then
		autoRemoveConnection = game:GetService("Workspace").DescendantAdded:Connect(handleDescendantAdd)
	end

	Wait()
	DoNotif("Auto deleting instances with name: "..targetName, 2.5)
end, true)

cmd.add({"unautodelete", "unautoremove", "unautodel"}, {"unautodelete {partname} (unautoremove, unautodel)", "Disables autodelete"}, function()
	if autoRemoveConnection then
		autoRemoveConnection:Disconnect()
		autoRemoveConnection = nil
	end
	autoRemover = {}
end)

autoFinder = {}
finderConn = nil

function onAdd(obj)
	if #autoFinder > 0 then
		for _, kw in pairs(autoFinder) do
			if obj.Name:lower():find(kw) then
				Wait()
				obj:Destroy()
				break
			end
		end
	else
		if finderConn then
			finderConn:Disconnect()
			finderConn = nil
		end
	end
end

cmd.add({"autodeletefind", "autoremovefind", "autodelfind"}, {"autodeletefind {name} (autoremovefind, autodelfind)", "Auto removes parts with names containing text"}, function(...)
	local args = {...}
	local kw = Concat(args, " "):lower()

	if not FindInTable(autoFinder, kw) then
		Insert(autoFinder, kw)
		for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
			if obj.Name:lower():find(kw) then
				obj:Destroy()
			end
		end
	end

	if not finderConn then
		finderConn = game:GetService("Workspace").DescendantAdded:Connect(onAdd)
	end

	Wait()
	DoNotif("Auto deleting parts containing: "..kw, 2.5)
end, true)

cmd.add({"unautodeletefind", "unautoremovefind", "unautodelfind"}, {"unautodeletefind (unautoremovefind,unautodelfind)", "Stops autodeletefind"}, function()
	if finderConn then
		finderConn:Disconnect()
		finderConn = nil
	end
	autoFinder = {}
end)

cmd.add({"deleteclass", "removeclass", "dc"}, {"deleteclass {ClassName} (removeclass, dc)", "Removes any part with a certain classname from the workspace"}, function(...)
	local args = {...}
	local targetClass = args[1]:lower()
	local deleteCount = 0

	for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
		if part.ClassName:lower() == targetClass then
			part:Destroy()
			deleteCount = deleteCount + 1
		end
	end

	Wait()
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
			Wait()
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
		Insert(autoClassRemover, targetClass)
		for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
			if part.ClassName:lower() == targetClass then
				part:Destroy()
			end
		end
	end

	if not autoClassConnection then
		autoClassConnection = game:GetService("Workspace").DescendantAdded:Connect(handleClassDescendantAdd)
	end

	Wait()
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
	local targetName = Concat(args, " "):lower()
	local deleteCount = 0

	for _, part in pairs(Player.Character:GetDescendants()) do
		if part.Name:lower() == targetName then
			part:Destroy()
			deleteCount = deleteCount + 1
		end
	end

	Wait()
	if deleteCount > 0 then
		DoNotif("Deleted "..deleteCount.." instance(s) of '"..targetName.."' inside the character", 2.5)
	else
		DoNotif("'"..targetName.."' not found in the character", 2.5)
	end
end, true)

cmd.add({"chardeletefind", "charremovefind", "chardelfind", "cdeletefind", "cremovefind", "cdelfind"}, {"chardeletefind {name} (charremovefind, chardelfind, cdeletefind, cremovefind, cdelfind)", "Removes parts in your character with names containing text"}, function(...)
	local args = {...}
	local kw = Concat(args, " "):lower()
	local count = 0

	for _, obj in pairs(Player.Character:GetDescendants()) do
		if obj.Name:lower():find(kw) then
			obj:Destroy()
			count = count + 1
		end
	end

	Wait()
	if count > 0 then
		DoNotif("Deleted "..count.." instance(s) containing '"..kw.."' in character", 2.5)
	else
		DoNotif("Nothing found containing '"..kw.."' in character", 2.5)
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

	Wait()
	if deleteCount > 0 then
		DoNotif("Deleted "..deleteCount.." instance(s) of class: "..targetClass.." inside the character", 2.5)
	else
		DoNotif("No instances of class: "..targetClass.." found in the character", 2.5)
	end
end, true)

cmd.add({"gotopart", "topart", "toprt"}, {"gotopart {partname} (topart, toprt)", "Teleports you to a part by name"}, function(...)
	local partName = Concat({...}, " "):lower()

	for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower() == partName then
			if getHum() then
				getHum().Sit = false
				Wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(part:GetPivot())
			end
			Wait(0.2)
		end
	end
end, true)

cmd.add({"tweengotopart", "tgotopart", "ttopart", "ttoprt"}, {"tweengotopart {partname} (tgotopart, ttopart, ttoprt)", "Tweens your character to a part by name"}, function(...)
	local partName = Concat({...}, " "):lower()

	for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower() == partName then
			if getHum() then
				getHum().Sit = false
				Wait(0.1)
			end
			TweenService:Create(
				getRoot(getChar()),
				TweenInfo.new(1, Enum.EasingStyle.Linear),
				{CFrame = part.CFrame}
			):Play()
			Wait(1)
		end
	end
end, true)

cmd.add({"gotopartfind", "topartfind", "toprtfind"}, {"gotopartfind {name} (topartfind, toprtfind)", "Teleports you to a part with a name containing the given text"}, function(...)
	local name = Concat({...}, " "):lower()

	for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower():find(name) then
			if getHum() then
				getHum().Sit = false
				Wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(part:GetPivot())
			end
			Wait(0.2)
		end
	end
end, true)

cmd.add({"tweengotopartfind", "tgotopartfind", "ttopartfind", "ttoprtfind"}, {"tweengotopartfind {name} (tgotopartfind, ttopartfind, ttoprtfind)", "Tweens your character to a part with a name containing the given text"}, function(...)
	local name = Concat({...}, " "):lower()

	for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower():find(name) then
			if getHum() then
				getHum().Sit = false
				Wait(0.1)
			end
			TweenService:Create(
				getRoot(getChar()),
				TweenInfo.new(1, Enum.EasingStyle.Linear),
				{CFrame = part.CFrame}
			):Play()
			Wait(1)
		end
	end
end, true)

cmd.add({"gotopartclass", "gpc", "gotopartc", "gotoprtc"}, {"gotopartclass {classname} (gpc, gotopartc, gotoprtc)", "Teleports you to a part by classname"}, function(...)
	local className = ({...})[1]:lower()

	for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.ClassName:lower() == className then
			if getHum() then
				getHum().Sit = false
				Wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(part:GetPivot())
			end
			Wait(0.2)
		end
	end
end, true)

cmd.add({"bringpart", "bpart", "bprt"}, {"bringpart {partname} (bpart, bprt)", "Brings a part to your character by name"}, function(...)
	local partName = Concat({...}, " "):lower()

	for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
		if part:IsA("BasePart") and part.Name:lower() == partName then
			if getChar() then
				part:PivotTo(getChar():GetPivot())
			end
		end
	end
end, true)

cmd.add({"bringmodel", "bmodel"}, {"bringmodel {modelname} (bmodel)", "Brings a model to your character by name"}, function(...)
	local modelName = Concat({...}, " "):lower()

	for _, model in pairs(game:GetService("Workspace"):GetDescendants()) do
		if model:IsA("Model") and model.Name:lower() == modelName then
			if getChar() then
				model:PivotTo(getChar():GetPivot())
			end
		end
	end
end, true)

cmd.add({"gotomodel", "tomodel"}, {"gotomodel {modelname} (tomodel)", "Teleports you to a model by name"}, function(...)
	local modelName = Concat({...}, " "):lower()

	for _, model in pairs(game:GetService("Workspace"):GetDescendants()) do
		if model:IsA("Model") and model.Name:lower() == modelName then
			if getHum() then
				getHum().Sit = false
				Wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(model:GetPivot())
			end
			Wait(0.2)
		end
	end
end, true)

cmd.add({"bringmodelfind", "bmodelfind"}, {"bringmodelfind {name} (bmodelfind)", "Brings a model to your character if its name contains the given text"}, function(...)
	local name = Concat({...}, " "):lower()

	for _, model in pairs(game:GetService("Workspace"):GetDescendants()) do
		if model:IsA("Model") and model.Name:lower():find(name) then
			if getChar() then
				model:PivotTo(getChar():GetPivot())
			end
		end
	end
end, true)

cmd.add({"gotomodelfind", "tomodelfind"}, {"gotomodelfind {name} (tomodelfind)", "Teleports you to a model whose name contains the given text"}, function(...)
	local name = Concat({...}, " "):lower()

	for _, model in pairs(game:GetService("Workspace"):GetDescendants()) do
		if model:IsA("Model") and model.Name:lower():find(name) then
			if getHum() then
				getHum().Sit = false
				Wait(0.1)
			end
			if getChar() then
				getChar():PivotTo(model:GetPivot())
			end
			Wait(0.2)
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

local originalGravity = game:GetService("Workspace").Gravity

cmd.add({"swim"}, {"swim {speed}", "Swim in the air"}, function(speed)
	local player = Players.LocalPlayer
	local humanoid = getHum()

	if humanoid then
		game:GetService("Workspace").Gravity = 3.5
		setHumanoidStates(humanoid, false)
		humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
		humanoid.WalkSpeed = speed or 16
	end
end, true)

cmd.add({"unswim"}, {"unswim", "Stops the swim script"}, function()
	local player = Players.LocalPlayer
	local humanoid = getHum()

	if humanoid then
		game:GetService("Workspace").Gravity = originalGravity
		setHumanoidStates(humanoid, true)
		humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		humanoid.WalkSpeed = 16
	end
end)

cmd.add({"swordfighter", "sfighter", "swordf", "swordbot", "sf"},{"swordfighter (sfighter, swordf, swordbot, sf)", "Activates a sword fighting bot that engages in automated PvP combat"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/refs/heads/main/Sword%20Fight%20Bot"))()
end)

local espList = {}
touchESPList = {}
proximityESPList = {}
clickESPList = {}
local partTrigger = nil
local espTriggers = {}

function createBox(part, color, transparency)
	local box = InstanceNew("BoxHandleAdornment")
	box.Name = part.Name:lower().."_ESP"
	box.Parent = part
	box.Adornee = part
	box.AlwaysOnTop = true
	box.ZIndex = 0
	if part:IsA("BasePart") then
		box.Size = part.Size
	elseif part:FindFirstChildWhichIsA("BasePart") then
		box.Size = part:FindFirstChildWhichIsA("BasePart").Size
	else
		box.Size = Vector3.new(4, 4, 4)
	end

	box.Transparency = transparency or 0.45
	box.Color3 = color
	return box
end

function onPartAdded(part)
	if #espList > 0 then
		if Discover(espList, part.Name:lower()) then
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

function enableEsp(objType, color, list)
	for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
		if obj:IsA(objType) then
			local parent = obj.Parent
			if parent and (parent:IsA("BasePart") or parent:IsA("Model")) then
				if not Discover(list, parent) then
					Insert(list, parent)
					createBox(parent, color, 0.45)
				end
			end
		end
	end

	if not espTriggers[objType] then
		espTriggers[objType] = game:GetService("Workspace").DescendantAdded:Connect(function(obj)
			if obj:IsA(objType) then
				local parent = obj.Parent
				if parent and (parent:IsA("BasePart") or parent:IsA("Model")) then
					if not Discover(list, parent) then
						Insert(list, parent)
						createBox(parent, color, 0.45)
					end
				end
			end
		end)
	end
end

function disableEsp(objType, list)
	if espTriggers[objType] then
		espTriggers[objType]:Disconnect()
		espTriggers[objType] = nil
	end

	for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
		if obj:IsA("BoxHandleAdornment") and obj.Name:sub(-4) == "_ESP" then
			local adornee = obj.Adornee
			if adornee and Discover(list, adornee) then
				obj:Destroy()
			end
		end
	end

	table.clear(list)
end

cmd.add({"pesp", "esppart", "partesp"}, {"pesp {partname} (esppart, partesp)", "Highlights specific parts by name"}, function(...)
	local args = {...}
	local partName = Concat(args, " "):lower()

	if not Discover(espList, partName) then
		Insert(espList, partName)

		for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
			if obj.Name:lower() == partName then
				if obj:IsA("BasePart") or obj:IsA("Model") then
					createBox(obj, Color3.fromRGB(50, 205, 50), 0.45)
				end
			end
		end
	end

	if not partTrigger then
		partTrigger = game:GetService("Workspace").DescendantAdded:Connect(onPartAdded)
	end
end, true)

cmd.add({"unpesp", "unesppart", "unpartesp"}, {"unpesp (unesppart, unpartesp)", "Removes ESP from specific parts added by pesp"}, function()
	for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
		if obj:IsA("BoxHandleAdornment") and obj.Name:sub(-4) == "_ESP" then
			local adornee = obj.Adornee
			if adornee and Discover(espList, adornee.Name:lower()) then
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
	enableEsp("TouchTransmitter", Color3.fromRGB(255, 0, 0), touchESPList)
end)

cmd.add({"untouchesp", "untesp"}, {"untouchesp (untesp)", "Removes ESP from parts with TouchTransmitter"}, function()
	disableEsp("TouchTransmitter", touchESPList)
end)

cmd.add({"proximityesp", "prxesp", "proxiesp"}, {"proximityesp (prxesp, proxiesp)", "Highlights parts with ProximityPrompt"}, function()
	enableEsp("ProximityPrompt", Color3.fromRGB(0, 0, 255), proximityESPList)
end)

cmd.add({"unproximityesp", "unprxesp", "unproxiesp"}, {"unproximityesp (unprxesp, unproxiesp)", "Removes ESP from parts with ProximityPrompt"}, function()
	disableEsp("ProximityPrompt", proximityESPList)
end)

cmd.add({"clickesp", "cesp"}, {"clickesp (cesp)", "Highlights parts with ClickDetector"}, function()
	enableEsp("ClickDetector", Color3.fromRGB(255, 165, 0), clickESPList)
end)

cmd.add({"unclickesp", "uncesp"}, {"unclickesp (uncesp)", "Removes ESP from parts with ClickDetector"}, function()
	disableEsp("ClickDetector", clickESPList)
end)

cmd.add({"viewpart", "viewp", "vpart"}, {"viewpart {partName} (viewp, vpart)", "Focuses camera on a part, model, or folder"},function(...)
        local partName = Concat({...}, " "):lower()
        local ws = game:GetService("Workspace")
        local camera = ws.CurrentCamera

        for _, obj in ipairs(ws:GetDescendants()) do
            if obj.Name:lower() == partName then
                if obj:IsA("BasePart") then
                    camera.CameraSubject = obj
                    return
                elseif obj:IsA("Model") or obj:IsA("Folder") then
                    for _, child in ipairs(obj:GetDescendants()) do
                        if child:IsA("BasePart") then
                            camera.CameraSubject = child
                            return
                        end
                    end
                end
            end
        end

        DoNotif("No matching part, model, or folder with a BasePart found named '"..partName.."'")
end,true)

cmd.add({"unviewpart", "unviewp"}, {"unviewpart (unviewp)", "Resets the camera to the local humanoid"}, function()
    local camera = game:GetService("Workspace").CurrentCamera
    local humanoid = getHum()
    if humanoid then
        camera.CameraSubject = humanoid
    end
end)

cmd.add({"viewpartfind", "viewpfind", "vpartfind"}, {"viewpartfind {name} (viewpfind, vpartfind)", "Focuses camera on a part, model, or folder with name containing the given text"}, function(...)
	local name = Concat({...}, " "):lower()
	local ws = game:GetService("Workspace")
	local cam = ws.CurrentCamera

	for _, obj in ipairs(ws:GetDescendants()) do
		if obj.Name:lower():find(name) then
			if obj:IsA("BasePart") then
				cam.CameraSubject = obj
				return
			elseif obj:IsA("Model") or obj:IsA("Folder") then
				for _, child in ipairs(obj:GetDescendants()) do
					if child:IsA("BasePart") then
						cam.CameraSubject = child
						return
					end
				end
			end
		end
	end

	DoNotif("No part, model, or folder containing '"..name.."' with a BasePart found")
end, true)

cmd.add({"unviewpart", "unviewp"}, {"unviewpart (unviewp)", "Resets the camera to the local humanoid"}, function()
	local cam = game:GetService("Workspace").CurrentCamera
	local hum = getHum()
	if hum then
		cam.CameraSubject = hum
	end
end)

cmd.add({"console", "debug"},{"console (debug)","Opens developer console"},function()
	StarterGui:SetCore("DevConsoleVisible",true)
end)

local ogSIZES = {}
local hbCON = {}

cmd.add({"hitbox", "hbox"}, {"hitbox {amount}", "Modifies everyone's hitbox to the specified size"}, function(playerName, size)
	local targetPlayers = getPlr(playerName)
	local hitboxSize = tonumber(size) or 10

	for _, plr in pairs(targetPlayers) do
		local character = plr.Character
		local root = character and getRoot(character)
		if root then
			if not ogSIZES[plr] then
				ogSIZES[plr] = root.Size
			end

			root.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
			root.Transparency = 0.9
			root.BrickColor = BrickColor.new("Really black")
			root.Material = Enum.Material.Neon

			if hbCON[plr] then
				hbCON[plr]:Disconnect()
			end

			hbCON[plr] = RunService.Stepped:Connect(function()
				local r = plr.Character and getRoot(plr.Character)
				if r then
					r.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
					r.Transparency = 0.9
					r.BrickColor = BrickColor.new("Really black")
					r.Material = Enum.Material.Neon
				end
			end)
		end
	end
end, true)

cmd.add({"unhitbox", "unhbox"}, {"unhitbox", "Disables hitbox modifications"}, function(playerName)
	local targetPlayers = getPlr(playerName)

	for _, plr in pairs(targetPlayers) do
		local character = plr.Character
		local root = character and getRoot(character)
		if root then
			local original = ogSIZES[plr] or Vector3.new(2, 2, 1)
			root.Size = original
			root.Transparency = 1
			root.BrickColor = BrickColor.new("Really black")
			root.Material = Enum.Material.Neon
		end

		if hbCON[plr] then
			hbCON[plr]:Disconnect()
			hbCON[plr] = nil
		end

		ogSIZES[plr] = nil
	end
end)

cmd.add({"breakcars", "bcars"}, {"breakcars (bcars)", "Breaks any car"}, function()
	DoNotif("Car breaker loaded, sit on a vehicle and be the driver")

	local Player = Players.LocalPlayer
	local Mouse = Player:GetMouse()
	local Workspace = game:GetService("Workspace")
	local RunService = RunService
	local UserInputService = UserInputService

	local Folder = InstanceNew("Folder")
	Folder.Parent = Workspace

	local Part = InstanceNew("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1
	Part.Size = Vector3.new(1, 1, 1)
	Part.Parent = Folder

	local Attachment1 = InstanceNew("Attachment")
	Attachment1.Parent = Part

	local UpdatedPosition = Mouse.Hit + Vector3.new(0, 5, 0)

	Spawn(function()
		while Wait() do
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= Player then
					player.MaximumSimulationRadius = 0
					sethiddenproperty(player, "SimulationRadius", 0)
				end
			end
			Player.MaximumSimulationRadius = math.pow(math.huge, math.huge)
			setsimulationradius(math.huge)
		end
	end)

	local function applyForceToPart(part)
		if not part:IsA("BasePart") or part.Anchored then return end
		if part.Name == "Handle" then return end
		local parent = part.Parent
		if parent:FindFirstChildOfClass("Humanoid") or parent:FindFirstChild("Head") then return end

		Mouse.TargetFilter = part

		for _, v in ipairs(part:GetChildren()) do
			if v:IsA("BodyAngularVelocity") or v:IsA("BodyForce") or v:IsA("BodyGyro")
			or v:IsA("BodyPosition") or v:IsA("BodyThrust") or v:IsA("BodyVelocity")
			or v:IsA("RocketPropulsion") or v:IsA("Torque") or v:IsA("AlignPosition")
			or v:IsA("Attachment") then
				v:Destroy()
			end
		end

		part.CanCollide = false

		local torque = InstanceNew("Torque")
		torque.Torque = Vector3.new(100000, 100000, 100000)
		torque.Parent = part

		local alignPosition = InstanceNew("AlignPosition")
		alignPosition.MaxForce = math.huge
		alignPosition.MaxVelocity = math.huge
		alignPosition.Responsiveness = 200
		alignPosition.Parent = part

		local attachment2 = InstanceNew("Attachment")
		attachment2.Parent = part

		torque.Attachment0 = attachment2
		alignPosition.Attachment0 = attachment2
		alignPosition.Attachment1 = Attachment1
	end

	for _, descendant in ipairs(Workspace:GetDescendants()) do
		applyForceToPart(descendant)
	end

	Workspace.DescendantAdded:Connect(applyForceToPart)

	UserInputService.InputBegan:Connect(function(input, isChatting)
		if input.KeyCode == Enum.KeyCode.E and not isChatting then
			UpdatedPosition = Mouse.Hit + Vector3.new(0, 5, 0)
		end
	end)

	Spawn(function()
		while Wait() do
			Attachment1.WorldCFrame = UpdatedPosition
		end
	end)
end)

cmd.add({"firetouchinterests", "fti"}, {"firetouchinterests (fti)", "Fires every Touch Interest that's in workspace"}, function()
	local char = getChar()
	local root = char and getRoot(char)

	local count = 0
	local toucher = {}

	for _, des in ipairs(game:GetService("Workspace"):GetDescendants()) do
		if des:IsA("TouchTransmitter") then
			local pp = des.Parent
			if pp and pp:IsA("BasePart") then
				Insert(toucher, pp)
				count += 1
			end
		end
	end

	for _, part in ipairs(toucher) do
		coroutine.wrap(function()
			local originalCFrame = part.CFrame
			part.CFrame = root.CFrame

			firetouchinterest(root, part, 0)
			Wait()
			firetouchinterest(root, part, 1)

			Delay(0.1, function()
				part.CFrame = originalCFrame
			end)
		end)()
	end

	Wait()
	DoNotif("Fired "..count.." touch interests")
end)

local jumpyCON = nil
local jumpyChar = nil

cmd.add({"infjump", "infinitejump"}, {"infjump (infinitejump)", "Enables infinite jumping"}, function()
	Wait()
	DoNotif("Infinite Jump Enabled",2)

	local function getHumanoid()
		local character = plr.Character or plr.CharacterAdded:Wait()
		return character:WaitForChild("Humanoid")
	end

	local function enableInfiniteJump()
		if jumpyCON then
			jumpyCON:Disconnect()
			jumpyCON = nil
		end

		local debounce = false
		local humanoid = getHumanoid()

		jumpyCON = UserInputService.JumpRequest:Connect(function()
			if not debounce and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
				debounce = true
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

				Delay(0.25, function()
					debounce = false
				end)
			end
		end)
	end

	enableInfiniteJump()

	if jumpyChar then
		jumpyChar:Disconnect()
	end

	jumpyChar = plr.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid")
		enableInfiniteJump()
	end)
end)

cmd.add({"uninfjump", "uninfinitejump"}, {"uninfjump (uninfinitejump)", "Disables infinite jumping"}, function()
	Wait()
	DoNotif("Infinite Jump Disabled", 2)

	if jumpyCON then
		jumpyCON:Disconnect()
		jumpyCON = nil
	end

	if jumpyChar then
		jumpyChar:Disconnect()
		jumpyChar = nil
	end
end)

local flyjump=nil

cmd.add({"flyjump"},{"flyjump","Allows you to hold space to fly up"},function()

	Wait();

	DoNotif("FlyJump Enabled",3)


	if flyjump then flyjump:Disconnect() end
	flyjump=UserInputService.JumpRequest:Connect(function()
		Player.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end)

cmd.add({"unflyjump","noflyjump"},{"unflyjump (noflyjump)","Disables flyjump"},function()

	Wait();

	DoNotif("FlyJump Disabled",3)


	if flyjump then flyjump:Disconnect() end
end)

cmd.add({"xray","xrayon"},{"xray (xrayon)","Makes you be able to see through walls"},function()
	Wait();

	DoNotif("Xray enabled")
	x(true)
end)

cmd.add({"unxray","xrayoff"},{"unxray (xrayoff)","Makes you not be able to see through walls"},function()
	Wait();

	DoNotif("Xray disabled")
	x(false)
end)

cmd.add({"pastebinscraper","pastebinscrape"},{"pastebinscraper (pastebinscrape)","Scrapes paste bin posts"},function()
	Wait();

	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/trash(paste)bin%20scrapper"))()
	COREGUI.Scraper["Pastebin Scraper"].BackgroundTransparency=0.5
	COREGUI.Scraper["Pastebin Scraper"].TextButton.Text="             ⭐ Pastebin Post Scraper ⭐"
	COREGUI.Scraper["Pastebin Scraper"].Content.Search.PlaceholderText="Search for a post here..."
	COREGUI.Scraper["Pastebin Scraper"].Content.Search.BackgroundTransparency=0.4
	DoNotif("Pastebin scraper loaded")
end)

cmd.add({"fullbright","fullb","fb"},{"fullbright (fullb,fb)","Makes games that are really dark to have no darkness and be really light"},function()
	if not getgenv().FullBrightExecuted then

		getgenv().FullBrightEnabled=false

		getgenv().NormalLightingSettings={
			Brightness=Lighting.Brightness,
			ClockTime=Lighting.ClockTime,
			FogEnd=Lighting.FogEnd,
			GlobalShadows=Lighting.GlobalShadows,
			Ambient=Lighting.Ambient
		}

		Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
			if Lighting.Brightness~=1 and Lighting.Brightness~=getgenv().NormalLightingSettings.Brightness then
				getgenv().NormalLightingSettings.Brightness=Lighting.Brightness
				if not getgenv().FullBrightEnabled then
					repeat
						Wait()
					until getgenv().FullBrightEnabled
				end
				Lighting.Brightness=1
			end
		end)

		Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
			if Lighting.ClockTime~=12 and Lighting.ClockTime~=getgenv().NormalLightingSettings.ClockTime then
				getgenv().NormalLightingSettings.ClockTime=Lighting.ClockTime
				if not getgenv().FullBrightEnabled then
					repeat
						Wait()
					until getgenv().FullBrightEnabled
				end
				Lighting.ClockTime=12
			end
		end)

		Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
			if Lighting.FogEnd~=786543 and Lighting.FogEnd~=getgenv().NormalLightingSettings.FogEnd then
				getgenv().NormalLightingSettings.FogEnd=Lighting.FogEnd
				if not getgenv().FullBrightEnabled then
					repeat
						Wait()
					until getgenv().FullBrightEnabled
				end
				Lighting.FogEnd=786543
			end
		end)

		Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
			if Lighting.GlobalShadows~=false and Lighting.GlobalShadows~=getgenv().NormalLightingSettings.GlobalShadows then
				getgenv().NormalLightingSettings.GlobalShadows=Lighting.GlobalShadows
				if not getgenv().FullBrightEnabled then
					repeat
						Wait()
					until getgenv().FullBrightEnabled
				end
				Lighting.GlobalShadows=false
			end
		end)

		Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
			if Lighting.Ambient~=Color3.fromRGB(178,178,178) and Lighting.Ambient~=getgenv().NormalLightingSettings.Ambient then
				getgenv().NormalLightingSettings.Ambient=Lighting.Ambient
				if not getgenv().FullBrightEnabled then
					repeat
						Wait()
					until getgenv().FullBrightEnabled
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
				Wait()
			until getgenv().FullBrightEnabled
			while Wait() do
				if getgenv().FullBrightEnabled~=LatestValue then
					if not getgenv().FullBrightEnabled then
						Lighting.Brightness=getgenv().NormalLightingSettings.Brightness
						Lighting.ClockTime=getgenv().NormalLightingSettings.ClockTime
						Lighting.FogEnd=getgenv().NormalLightingSettings.FogEnd
						Lighting.GlobalShadows=getgenv().NormalLightingSettings.GlobalShadows
						Lighting.Ambient=getgenv().NormalLightingSettings.Ambient
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

	getgenv().FullBrightExecuted=true
	getgenv().FullBrightEnabled=not getgenv().FullBrightEnabled
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
	for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			fppamount=fppamount+1
			fireproximityprompt(v,1)
		end
	end


	Wait();

	DoNotif("Fired "..fppamount.." of proximity prompts")
end)

cmd.add({"gamma", "exposure"},{"gamma (exposure)","gamma vision (real)"},function(num)
	expose = tonumber(num) or 0
	Lighting.ExposureCompensation = expose
end)

cmd.add({"unsuspendvc", "fixvc", "rejoinvc", "restorevc"},{"unsuspendvc (fixvc, rejoinvc, restorevc)","allows you to use Voice Chat again"},function(...)
	SafeGetService("VoiceChatService"):joinVoice()

	if typeof(onVoiceModerated) ~= "RBXScriptConnection" then
        onVoiceModerated = SafeGetService("VoiceChatInternal").LocalPlayerModerated:Connect(function()
            Wait(1)
            SafeGetService("VoiceChatService"):joinVoice()
        end)
    end
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
		iy,_=game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"):gsub("local Main","Main"):gsub("Players.LocalPlayer.Chatted","Funny=Players.LocalPlayer.Chatted"):gsub("local lastMessage","notify=getgenv().notify\nlocal lastMessage")
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

cmd.add({"maxzoom"},{"maxzoom <amount>","Set your maximum camera distance"},function(num)
	local num=tonumber(num) or 128
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

cmd.add({"cameranoclip","camnoclip","cnoclip","nccam"},{"cameranoclip (camnoclip,cnoclip,nccam)","Makes your camera clip through walls"}, function()
	local player = Players.LocalPlayer
	local camera = game:GetService("Workspace").CurrentCamera

	local SetConstant = (debug and debug.setconstant) or setconstant
	local GetConstants = (debug and debug.getconstants) or getconstants
	local HasAdvancedAccess = (getgc and SetConstant and GetConstants)

	if HasAdvancedAccess then
		local PlayerModule = player:FindFirstChild("PlayerScripts") and player.PlayerScripts:FindFirstChild("PlayerModule")
		local Popper = PlayerModule and PlayerModule:FindFirstChild("CameraModule") and PlayerModule.CameraModule:FindFirstChild("ZoomController") and PlayerModule.CameraModule.ZoomController:FindFirstChild("Popper")

		if Popper then
			for i, v in pairs(getgc()) do
				if type(v) == "function" and getfenv(v).script == Popper then
					for i2, v2 in pairs(GetConstants(v)) do
						if tonumber(v2) == 0.25 then
							SetConstant(v, i2, 0)
						elseif tonumber(v2) == 0 then
							SetConstant(v, i2, 0.25)
						end
					end
				end
			end
		end
	else
		if _G._noclipConnection then _G._noclipConnection:Disconnect() end
		if _G._noclipInput then _G._noclipInput:Disconnect() end
		if _G._noclipZoom then _G._noclipZoom:Disconnect() end
		if _G._noclipBegin then _G._noclipBegin:Disconnect() end
		if _G._noclipEnd then _G._noclipEnd:Disconnect() end

		local rootPart = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
		local zoom = (camera.CFrame.Position - rootPart.Position).Magnitude
		local minZoom = player.CameraMinZoomDistance
		local maxZoom = player.CameraMaxZoomDistance
		local rotationX, rotationY = 0, 0
		local sensitivity = 0.2
		local rotating = false

		camera.CameraType = Enum.CameraType.Scriptable
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default

		_G._noclipBegin = UserInputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				rotating = true
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
			end
		end)

		_G._noclipEnd = UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				rotating = false
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end
		end)

		_G._noclipInput = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement and rotating then
				rotationX -= input.Delta.X * sensitivity
				rotationY = math.clamp(rotationY + input.Delta.Y * sensitivity, -80, 80)
			end
		end)

		_G._noclipZoom = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseWheel then
				zoom = math.clamp(zoom - input.Position.Z * 2, minZoom, maxZoom)
			end
		end)

		_G._noclipConnection = RunService.RenderStepped:Connect(function()
			local targetPos = rootPart.Position + Vector3.new(0, 2, 0)
			local rot = CFrame.Angles(0, math.rad(rotationX), 0) * CFrame.Angles(math.rad(rotationY), 0, 0)
			local camPos = targetPos + rot:VectorToWorldSpace(Vector3.new(0, 0, -zoom))
			camera.CFrame = CFrame.new(camPos, targetPos)
		end)
	end
end)

cmd.add({"uncameranoclip","uncamnoclip","uncnoclip","unnccam"},{"uncameranoclip (uncamnoclip,uncnoclip,unnccam)","Restores normal camera"}, function()
	local player = Players.LocalPlayer
	local camera = game:GetService("Workspace").CurrentCamera

	local SetConstant = (debug and debug.setconstant) or setconstant
	local GetConstants = (debug and debug.getconstants) or getconstants
	local HasAdvancedAccess = (getgc and SetConstant and GetConstants)

	if HasAdvancedAccess then
		local PlayerModule = player:FindFirstChild("PlayerScripts") and player.PlayerScripts:FindFirstChild("PlayerModule")
		local Popper = PlayerModule and PlayerModule:FindFirstChild("CameraModule") and PlayerModule.CameraModule:FindFirstChild("ZoomController") and PlayerModule.CameraModule.ZoomController:FindFirstChild("Popper")

		if Popper then
			for i, v in pairs(getgc()) do
				if type(v) == "function" and getfenv(v).script == Popper then
					for i2, v2 in pairs(GetConstants(v)) do
						if tonumber(v2) == 0.25 then
							SetConstant(v, i2, 0)
						elseif tonumber(v2) == 0 then
							SetConstant(v, i2, 0.25)
						end
					end
				end
			end
		end
	else
		if _G._noclipConnection then _G._noclipConnection:Disconnect() _G._noclipConnection = nil end
		if _G._noclipInput then _G._noclipInput:Disconnect() _G._noclipInput = nil end
		if _G._noclipZoom then _G._noclipZoom:Disconnect() _G._noclipZoom = nil end
		if _G._noclipBegin then _G._noclipBegin:Disconnect() _G._noclipBegin = nil end
		if _G._noclipEnd then _G._noclipEnd:Disconnect() _G._noclipEnd = nil end

		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		camera.CameraType = Enum.CameraType.Custom

		local scripts = player:FindFirstChild("PlayerScripts")
		if scripts then
			local existingModule = scripts:FindFirstChild("PlayerModule")
			if existingModule then existingModule:Destroy() end

			local starterModule = game:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts"):FindFirstChild("PlayerModule")
			if starterModule then
				local newModule = starterModule:Clone()
				newModule.Parent = scripts
			end
		end
	end
end)

cmd.add({"oganims"},{"oganims","Old animations from 2007"},function()
	Wait();
	DoNotif("OG animations set")
	loadstring(game:HttpGet(('https://pastebin.com/raw/6GNkQUu6'),true))()
end)

cmd.add({"fakechat"},{"fakechat","Fake a chat gui"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/fake%20chatte"))()
end)

cmd.add({"fpscap"},{"fpscap <number>","Sets the fps cap to whatever you want"},function(arg)
	local cap = tonumber(arg)
	if cap then
		setfpscap(math.clamp(cap, 1, 999))
	else
		DoNotif("invalid input",1.3)
	end
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

	local tool = InstanceNew("Tool", Players.LocalPlayer.Backpack)
	tool.Name = "Turn Invisible"
	tool.RequiresHandle = false
	tool.CanBeDropped = false

	tool.Equipped:Connect(function()
		Wait()
		if not invisible then
			invisible = true
			tool.Name = "Visible Enabled"

			if handle then
				handle:Destroy()
			end
			if weld then
				weld:Destroy()
			end

			handle = InstanceNew("Part", game:GetService("Workspace"))
			handle.Name = "Handle"
			handle.Transparency = 1
			handle.CanCollide = false
			handle.Size = Vector3.new(2, 1, 1)

			weld = InstanceNew("Weld", handle)
			weld.Part0 = handle
			weld.Part1 = getRoot(getChar())
			weld.C0 = CFrame.new(0, offset - 1.5, 0)

			setDisplayDistance(offset + 100)
			game:GetService("Workspace").CurrentCamera.CameraSubject = handle
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
			game:GetService("Workspace").CurrentCamera.CameraSubject = getChar().Humanoid
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
		Wait()
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
				Wait()
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
		Character.Parent = game:GetService("Workspace")
		DoNotif("Invisibility has been turned off.")
		StarterGui:SetCore("ResetButtonCallback", true)
	end

	local function ToggleInvisibility()
		if not IsInvis then
			IsInvis = true
			InvisibleCharacter = Character:Clone()
			InvisibleCharacter.Parent = game:GetService("Workspace")
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
			game:GetService("Workspace").CurrentCamera.CameraSubject = InvisibleCharacter:FindFirstChildWhichIsA("Humanoid")
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
		invisBtnlol = InstanceNew("ScreenGui")
		local TextButton = InstanceNew("TextButton")
		local UICorner = InstanceNew("UICorner")
		local UIAspectRatioConstraint = InstanceNew("UIAspectRatioConstraint")

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

		gui.draggablev2(TextButton)

		MouseButtonFix(TextButton,function()
			ToggleInvisibility()
			TextButton.Text = IsInvis and "Visible" or "Invisible"
		end)
	end

	Wait()
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
	local remoteCount = 0

	for _, descendant in ipairs(game:GetDescendants()) do
		if not descendant:IsDescendantOf(COREGUI) then
			NACaller(function()
				if descendant:IsA("RemoteEvent") then
					if pcall(function() descendant:FireServer() end) then
						remoteCount += 1
					end
				elseif descendant:IsA("RemoteFunction") then
					if pcall(function() descendant:InvokeServer() end) then
						remoteCount += 1
					end
				end
			end)
		end
	end

	DoNotif("Fired "..remoteCount.." remotes")
end)

local fovcon = nil
local monitorcon = nil

cmd.add({"fov"}, {"fov <number>", "Sets your FOV to a custom value (1–120)"}, function(num)
	local field = math.clamp(tonumber(num) or 70, 1, 120)
	local cam = Workspace.CurrentCamera
	TweenService:Create(cam, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {FieldOfView = field}):Play()
end, true)

cmd.add({"loopfov", "lfov"}, {"loopfov <number> (lfov)", "Loops your FOV to stay at a custom value (1–120)"}, function(num)
	local field = math.clamp(tonumber(num) or 70, 1, 120)
	local cam = Workspace.CurrentCamera

	if fovcon then fovcon:Disconnect() fovcon = nil end
	if monitorcon then monitorcon:Disconnect() monitorcon = nil end

	fovcon = RunService.RenderStepped:Connect(function()
		if cam.FieldOfView ~= field then
			cam.FieldOfView = field
		end
	end)

	monitorcon = cam:GetPropertyChangedSignal("FieldOfView"):Connect(function()
		if cam.FieldOfView ~= field then
			cam.FieldOfView = field
		end
	end)
end, true)

cmd.add({"unloopfov", "unlfov"}, {"unloopfov (unlfov)", "Stops the looped FOV"}, function()
	if fovcon then fovcon:Disconnect() fovcon = nil end
	if monitorcon then monitorcon:Disconnect() monitorcon = nil end
end)

cmd.add({"homebrew"},{"homebrew","Executes homebrew admin"},function()
	getgenv().CustomUI=false
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
end)

cmd.add({"fatesadmin"},{"fatesadmin","Executes fates admin"},function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))();
end)

storedTools = {}

cmd.add({"savetools", "stools"}, {"savetools (stools)", "Saves your tools to memory"}, function()
	storedTools = {}

	for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			local clonedTool = tool:Clone()
			Insert(storedTools, clonedTool)
		end
	end

	for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
		if tool:IsA("Tool") then
			local clonedTool = tool:Clone()
			Insert(storedTools, clonedTool)
		end
	end

	DoNotif("Tools saved: "..#storedTools,2)
end)

cmd.add({"loadtools", "ltools"}, {"loadtools (ltools)", "Restores your saved tools to your backpack"}, function()
	for _, tool in pairs(storedTools) do
		if not LocalPlayer.Backpack:FindFirstChild(tool.Name) then
			local clonedTool = tool:Clone()
			clonedTool.Parent = LocalPlayer.Backpack
		end
	end

	DoNotif("Tools loaded: "..#storedTools,2)
end)

local noEQ = nil
local humEQ = nil

cmd.add({"preventtools", "noequip", "antiequip"}, {"preventtools (noequip,antiequip)", "Prevents any item from being equipped"}, function()
	local p = Players.LocalPlayer
	local c = p.Character
	if noEQ then noEQ:Disconnect() noEQ = nil end
	if humEQ then humEQ:Disconnect() humEQ = nil end

	local h = c and c:FindFirstChildWhichIsA("Humanoid")
	if not h then return end

	h:UnequipTools()

	local function onTool(t)
		if t:IsA("Tool") then
			t.Enabled = false
			task.defer(function()
				h:UnequipTools()
				DoNotif("Tool "..t.Name.." blocked", 2)
			end)
		end
	end

	noEQ = c.ChildAdded:Connect(onTool)
	humEQ = h.ChildAdded:Connect(onTool)

	DoNotif("Tool prevention on", 3)
end)

cmd.add({"unpreventtools", "unnoequip", "unantiequip"}, {"unpreventtools (unnoequip,unantiequip)", "Self-explanatory"}, function()
	if noEQ then noEQ:Disconnect() noEQ = nil end
	if humEQ then humEQ:Disconnect() humEQ = nil end
	DoNotif("Tool prevention off", 2)
end)

cmd.add({"ws", "speed", "walkspeed"}, {"walkspeed <number> (speed,ws)", "Sets your WalkSpeed"}, function(...)
	local a = {...}
	local s = tonumber(a[2] or a[1]) or 16
	local h = getHum()
	if s and h then
		h.WalkSpeed = s
	end
end, true)

cmd.add({"jp", "jumppower"}, {"jumppower <number> (jp)", "Sets your JumpPower"}, function(...)
	local a = {...}
	local j = tonumber(a[1]) or 50
	local h = getHum()
	if j and h then
		if h.UseJumpPower then
			h.JumpPower = j
		else
			h.JumpHeight = j
		end
	end
end, true)

cmd.add({"oofspam"},{"oofspam","Spams oof"},function()
	getgenv().enabled=true
	getgenv().speed=100
	local HRP=Humanoid.RootPart or getRoot(Humanoid.Parent)
	if not Humanoid or not getgenv().enabled then
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
	Wait(Players.RespawnTime+0.1)
	while Wait(1/getgenv().speed) do
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
			Insert(npcs,{hum,hum.HipHeight})
			hum.HipHeight = 1024
		end
	end
	for _,hum in pairs(game:GetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"flingnpcs"}, {"flingnpcs", "Flings NPCs"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			Insert(npcs,{hum,hum.HipHeight})
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
			Insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			local targetPos = getRoot(LocalPlayer.Character).Position
			hum:MoveTo(targetPos)
		end
	end
	for _,hum in pairs(game:GetService("Workspace"):GetDescendants()) do
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
				Insert(npcs,{hum,hum.HipHeight})
				local rootPart = getRoot(hum.Parent)
				local targetPos = getRoot(LocalPlayer.Character).Position
				hum:MoveTo(targetPos)
			end
		end
		for _,hum in pairs(game:GetService("Workspace"):GetDescendants()) do
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
			Insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				hum.Sit = true
			end
		end
	end
	for _,hum in pairs(game:GetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"unsitnpcs"}, {"unsitnpcs", "Makes NPCS unsit"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			Insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				hum.Sit = true
			end
		end
	end
	for _,hum in pairs(game:GetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"killnpcs"}, {"killnpcs", "Kills NPCs"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			Insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				hum.Health = 0
			end
		end
	end
	for _,hum in pairs(game:GetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

cmd.add({"bringnpcs"}, {"bringnpcs", "Brings NPCs"}, function()
	local npcs = {}

	local function disappear(hum)
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			Insert(npcs,{hum,hum.HipHeight})
			local rootPart = getRoot(hum.Parent)
			if rootPart then
				rootPart.CFrame = getRoot(LocalPlayer.Character).CFrame
			end
		end
	end
	for _,hum in pairs(game:GetService("Workspace"):GetDescendants()) do
		disappear(hum)
	end
end)

bringingNpcs = false
bringNPClooper = nil
npcCache = {}

cmd.add({"loopbringnpcs", "lbnpcs"}, {"loopbringnpcs (lbnpcs)", "Loops NPC bringing"}, function()
	if bringingNpcs then return end
	bringingNpcs = true

	table.clear(npcCache)
	for _, hum in ipairs(game:GetService("Workspace"):GetDescendants()) do
		if hum:IsA("Humanoid") and not Players:GetPlayerFromCharacter(hum.Parent) then
			Insert(npcCache, hum)
		end
	end

	bringNPClooper = coroutine.create(function()
		while bringingNpcs do
			for _, hum in ipairs(npcCache) do
				if hum.Parent and hum.Health > 0 then
					local model = hum.Parent
					local rootPart = getRoot(model)
					if rootPart and LocalPlayer.Character and getRoot(LocalPlayer.Character) then
						rootPart.CFrame = getRoot(LocalPlayer.Character).CFrame
					end
					for _, part in ipairs(model:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end
			Wait()
		end
	end)

	coroutine.resume(bringNPClooper)
end)

cmd.add({"unloopbringnpcs", "unlbnpcs"}, {"unloopbringnpcs (unlbnpcs)", "Stops NPC bring loop"}, function()
	if not bringingNpcs then return end
	bringingNpcs = false
	bringNPClooper = nil
end)

cmd.add({"gotonpcs"}, {"gotonpcs", "Teleports to each NPC"}, function()
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local npcs = {}
	for _, d in pairs(game:GetService("Workspace"):GetDescendants()) do
		if d:IsA("Humanoid") and not Players:GetPlayerFromCharacter(d.Parent) then
			local root = getRoot(d.Parent)
			if root then
				Insert(npcs, root)
			end
		end
	end
	Spawn(function()
		for _, npcRoot in ipairs(npcs) do
			local char = LocalPlayer.Character
			if char and getRoot(char) then
				getRoot(char).CFrame = npcRoot.CFrame + Vector3.new(0, 3, 0)
			end
		end
	end)
end)

local NPCControl = {
	Enabled = false,
	Connection = nil,
	CurrentTarget = nil,
	MoveCooldown = 0
}

cmd.add({"actnpc"}, {"actnpc", "Start acting like an NPC"}, function()
	if NPCControl.Enabled then return end
	NPCControl.Enabled = true

	local function moveToRandom()
		local char = LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local root = getRoot(char)
		if not (char and hum and root) then return end

		local randomOffset = Vector3.new(math.random(-30, 30), 0, math.random(-30, 30))
		local targetPos = root.Position + randomOffset

		NPCControl.CurrentTarget = targetPos
		hum:MoveTo(targetPos)

		DoNotif("Moving to: "..Format("X: %.0f, Y: %.0f, Z: %.0f", targetPos.X, targetPos.Y, targetPos.Z), 1.5)
	end

	NPCControl.Connection = RunService.Heartbeat:Connect(function(dt)
		local char = LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local root = getRoot(char)
		if not (char and hum and root) then return end

		NPCControl.MoveCooldown -= dt
		NPCControl._jumpCooldown = (NPCControl._jumpCooldown or 0) - dt
		NPCControl._moveTimeout = (NPCControl._moveTimeout or 0) + dt

		if hum.Sit then
			DoNotif("Sitting detected — jumping to escape", 1.5)
			hum.Sit = false
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			NPCControl._jumpCooldown = 1.5
			return
		end

		if NPCControl.CurrentTarget and (root.Position - NPCControl.CurrentTarget).Magnitude < 2 then
			DoNotif("Reached target", 1.5)
			NPCControl.CurrentTarget = nil
		end

		if not NPCControl.CurrentTarget or NPCControl._moveTimeout > 5 then
			if NPCControl._moveTimeout > 5 then
				DoNotif("Stuck — retrying new path", 1.5)
			end
			if NPCControl.MoveCooldown <= 0 then
				moveToRandom()
				NPCControl.MoveCooldown = math.random(2, 4)
				NPCControl._moveTimeout = 0
			end
		end

		local forward = root.CFrame.LookVector
		local origin = root.Position + Vector3.new(0, 2, 0)
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist
		rayParams.FilterDescendantsInstances = {char}
		local result = Workspace:Raycast(origin, forward * 3 + Vector3.new(0, -2, 0), rayParams)

		if result and NPCControl._jumpCooldown <= 0 then
			local part = result.Instance
			local model = part:FindFirstAncestorOfClass("Model")
			local isPlayerChar = model and Players:GetPlayerFromCharacter(model)

			if part.CanCollide and not isPlayerChar then
				if hum:GetState() == Enum.HumanoidStateType.Running then
					DoNotif("Obstacle detected — jumping", 1.5)
					hum:ChangeState(Enum.HumanoidStateType.Jumping)
					NPCControl._jumpCooldown = 1.5
				end
			end
		end
	end)
end)

cmd.add({"unactnpc", "stopnpc"}, {"unactnpc (stopnpc)", "Stop acting like an NPC"}, function()
	if not NPCControl.Enabled then return end
	NPCControl.Enabled = false
	if NPCControl.Connection then
		NPCControl.Connection:Disconnect()
		NPCControl.Connection = nil
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
	Wait(1)
	warn("retrying")
	return Getmodel(id) 
end

--[[ GUI VARIABLES ]]--
local ScreenGui=Getmodel("rbxassetid://140418556029404")
local rPlayer=Players:FindFirstChildWhichIsA("Player")
local coreGuiProtection={}
if not RunService:IsStudio() then
else
	repeat Wait() until player:FindFirstChild("AdminUI",true)
	ScreenGui=player:FindFirstChild("AdminUI",true)
end
repeat Wait() until ScreenGui~=nil -- if it loads late then I'll just add this here

NaProtectUI(ScreenGui)

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
	Top = {Vector2.new(0,-1),    Vector2.new(0,-1),    "rbxassetid://2911850935"},
	Bottom = {Vector2.new(0,1),    Vector2.new(0,0),    "rbxassetid://2911850935"},
	Left = {Vector2.new(-1,0),    Vector2.new(1,0),    "rbxassetid://2911851464"},
	Right = {Vector2.new(1,0),    Vector2.new(0,0),    "rbxassetid://2911851464"},

	TopLeft = {Vector2.new(-1,-1),    Vector2.new(1,-1),    "rbxassetid://2911852219"},
	TopRight = {Vector2.new(1,-1),    Vector2.new(0,-1),    "rbxassetid://2911851859"},
	BottomLeft = {Vector2.new(-1,1),    Vector2.new(1,0),    "rbxassetid://2911851859"},
	BottomRight = {Vector2.new(1,1),    Vector2.new(0,0),    "rbxassetid://2911852219"},
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
	local textService=TextService
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
	cFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
end
gui.chatlogs=function()
	if not chatLogsFrame.Visible then
		chatLogsFrame.Visible=true
	end
	chatLogsFrame.Position=UDim2.new(0.5,0,0.5,0)
end
gui.updateLogs=function()
	if not UpdLogsFrame.Visible and next(updLogs) then
		UpdLogsFrame.Visible=true
	elseif not next(updLogs) then
		DoNotif("no upd logs for now...")
	else
		warn("huh?")
	end
	UpdLogsFrame.Position=UDim2.new(0.5,0,0.5,0)
end

gui.tween = function(obj, style, direction, duration, goal, callback)
	style = style or "Sine"
	direction = direction or "Out"
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle[style], Enum.EasingDirection[direction])
	local tween = TweenService:Create(obj, tweenInfo, goal)
	if callback then tween.Completed:Connect(callback) end
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
	local UserInputService = game:GetService("UserInputService")
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
	ui.Active = true
end

gui.draggablev2 = function(ui, dragui)
	if not dragui then 
		dragui = ui 
	end
	local UserInputService = game:GetService("UserInputService")

	local screenGui = ui:FindFirstAncestorWhichIsA("ScreenGui") or ui.Parent

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		local parentSize = screenGui.AbsoluteSize
		local uiSize = ui.AbsoluteSize

		local newXScale = startPos.X.Scale + (delta.X / parentSize.X)
		local newYScale = startPos.Y.Scale + (delta.Y / parentSize.Y)

		local anchor = ui.AnchorPoint
		local minX = anchor.X * (uiSize.X / parentSize.X)
		local maxX = 1 - (1 - anchor.X) * (uiSize.X / parentSize.X)
		local minY = anchor.Y * (uiSize.Y / parentSize.Y)
		local maxY = 1 - (1 - anchor.Y) * (uiSize.Y / parentSize.Y)

		newXScale = math.clamp(newXScale, minX, maxX)
		newYScale = math.clamp(newYScale, minY, maxY)

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

	local function onScreenSizeChanged()
		local parentSize = screenGui.AbsoluteSize
		local uiSize = ui.AbsoluteSize
		local currentPos = ui.Position

		local anchor = ui.AnchorPoint
		local minX = anchor.X * (uiSize.X / parentSize.X)
		local maxX = 1 - (1 - anchor.X) * (uiSize.X / parentSize.X)
		local minY = anchor.Y * (uiSize.Y / parentSize.Y)
		local maxY = 1 - (1 - anchor.Y) * (uiSize.Y / parentSize.Y)

		local newXScale = math.clamp(currentPos.X.Scale, minX, maxX)
		local newYScale = math.clamp(currentPos.Y.Scale, minY, maxY)

		ui.Position = UDim2.new(newXScale, 0, newYScale, 0)
	end

	screenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(onScreenSizeChanged)

	ui.Active = true
end


gui.menuify = function(menu)
	if menu:IsA("Frame") then menu.AnchorPoint=Vector2.new(0.5,0) end
	local exitButton = menu:FindFirstChild("Exit", true)
	local minimizeButton = menu:FindFirstChild("Minimize", true)
	local minimized = false
	local isAnimating = false
	local sizeX = InstanceNew("IntValue", menu)
	local sizeY = InstanceNew("IntValue", menu)

	local function toggleMinimize()
		if isAnimating then return end
		minimized = not minimized
		isAnimating = true

		if minimized then
			sizeX.Value = menu.Size.X.Offset
			sizeY.Value = menu.Size.Y.Offset
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, 25)})
				.Completed:Connect(function()
					isAnimating = false
				end)
		else
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, sizeY.Value)})
				.Completed:Connect(function()
					isAnimating = false
				end)
		end
	end

	MouseButtonFix(minimizeButton, toggleMinimize)
	MouseButtonFix(exitButton, function()
		menu.Visible = false
	end)
	gui.draggablev2(menu, menu.Topbar)
	menu.Visible = false
end

gui.menuifyv2 = function(menu)
	if menu:IsA("Frame") then menu.AnchorPoint=Vector2.new(0.5,0) end
	local exitButton = menu:FindFirstChild("Exit", true)
	local minimizeButton = menu:FindFirstChild("Minimize", true)
	local clearButton = menu:FindFirstChild("Clear", true)
	local minimized = false
	local isAnimating = false
	local sizeX = InstanceNew("IntValue", menu)
	local sizeY = InstanceNew("IntValue", menu)

	local function toggleMinimize()
		if isAnimating then return end
		minimized = not minimized
		isAnimating = true

		if minimized then
			sizeX.Value = menu.Size.X.Offset
			sizeY.Value = menu.Size.Y.Offset
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, 25)})
				.Completed:Connect(function()
					isAnimating = false
				end)
		else
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, sizeY.Value)})
				.Completed:Connect(function()
					isAnimating = false
				end)
		end
	end

	MouseButtonFix(minimizeButton, toggleMinimize)
	MouseButtonFix(exitButton, function()
		menu.Visible = false
	end)

	if clearButton then
		MouseButtonFix(clearButton, function()
			local container = menu:FindFirstChild("Container", true)
			if container then
				local scrollingFrame = container:FindFirstChildOfClass("ScrollingFrame")
				if scrollingFrame then
					local layout = scrollingFrame:FindFirstChildOfClass("UIListLayout", true)
					if layout then
						for _, v in ipairs(layout.Parent:GetChildren()) do
							if v:IsA("TextLabel") then
								v:Destroy()
							end
						end
					end
				end
			end
		end)
	end

	gui.draggablev2(menu, menu.Topbar)
	menu.Visible = false
end

gui.loadCommands = function()
	for i, v in pairs(cmdAutofill:GetChildren()) do
		if v.Name ~= "UIListLayout" then
			v:Remove()
		end
	end

	CMDAUTOFILL = {}

	local last = nil
	local i = 0
	for name, tbl in pairs(Commands) do
		local info = tbl[2]
		local btn = cmdExample:Clone()
		btn.Parent = cmdAutofill
		btn.Name = name
		btn.Input.Text = info[1]
		i = i + 1

		local size = btn.Size
		btn.Size = UDim2.new(0, 0, 0, 25)
		btn.Size = size

		Insert(CMDAUTOFILL, btn)
	end
end

gui.loadCommands()

for i, v in ipairs(CMDAUTOFILL) do
	if v:IsA("Frame") then
		v.Visible = false
	end
end

gui.barSelect = function(speed)
	speed = speed or 0.4
	centerBar.Visible = true

	centerBar.Size = UDim2.new(0, 0, 1, 15)
	gui.tween(centerBar, "Back", "Out", speed, {Size = UDim2.new(0, 250, 1, 15)})

	leftFill.Position = UDim2.new(-0.3, 0, 0.5, 0)
	rightFill.Position = UDim2.new(1.3, 0, 0.5, 0)

	gui.tween(leftFill, "Elastic", "Out", speed, {Position = UDim2.new(0, 0, 0.5, 0)})
	gui.tween(rightFill, "Elastic", "Out", speed, {Position = UDim2.new(1, 0, 0.5, 0)})
end

gui.barDeselect = function(speed)
	speed = speed or 0.4

	gui.tween(centerBar, "Sine", "InOut", speed, {Size = UDim2.new(0, 250, 0, 0)})
	gui.tween(leftFill, "Cubic", "InOut", speed, {Position = UDim2.new(-0.5, 100, 0.5, 0)})
	gui.tween(rightFill, "Cubic", "InOut", speed, {Position = UDim2.new(1.5, -100, 0.5, 0)})

	for i, v in ipairs(cmdAutofill:GetChildren()) do
		if v:IsA("Frame") then
			wrap(function()
				Wait(math.random(50, 120) / 1000)
				gui.tween(v, "Exponential", "In", 0.3, {Size = UDim2.new(0, 0, 0, 25)})
			end)
		end
	end
end

--[[ AUTOFILL SEARCHER ]]--
searchedSEARCH=false
gui.searchCommands = function()
	local searchTerm = cmdInput.Text:gsub(";", ""):lower()

	if searchTerm:find("%s") then
		if not searchedSEARCH then
			for _, frame in ipairs(CMDAUTOFILL) do
				frame.Visible = false
			end
			searchedSEARCH=true
		end
		return
	end

	local index = 0
	local lastFramePos
	local results = {}
	local searchTermLength = #searchTerm
	searchedSEARCH=false

	for _, frame in ipairs(CMDAUTOFILL) do
		local cmdName = frame.Name:lower()
		local command = Commands[cmdName]
		if not command then continue end

		local displayName = command[2][1] or ""
		local score = 999
		local matchText = displayName

		if cmdName == searchTerm or displayName:lower() == searchTerm or 
			(Aliases[searchTerm] and Aliases[searchTerm] == cmdName) then
			score = 1
			matchText = cmdName
		elseif cmdName:sub(1, searchTermLength) == searchTerm then
			score = 2
			matchText = cmdName
		elseif displayName:lower():sub(1, searchTermLength) == searchTerm then
			score = 3
			matchText = displayName
		else
			for alias, cmd in pairs(Aliases) do
				if cmd == cmdName and alias:sub(1, searchTermLength) == searchTerm then
					score = 3
					matchText = alias
					break
				end
			end
		end

		if score == 999 and searchTermLength >= 2 then
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

		if score == 999 and searchTermLength >= 2 then
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

			local allowedDistance = math.min(2, searchTermLength - 1)
			if cmdDistance <= allowedDistance then
				score = 6 + cmdDistance
				matchText = cmdName
			elseif bestAliasDistance <= allowedDistance then
				score = 6 + bestAliasDistance
				matchText = bestAlias
			elseif displayDistance <= allowedDistance then
				score = 9 + displayDistance
				matchText = displayName
			end
		end

		if score < 999 then
			Insert(results, {
				frame = frame,
				score = score,
				text = matchText,
				name = cmdName
			})
		end
	end

	table.sort(results, function(a, b)
		if a.score == b.score then
			return a.name < b.name
		end
		return a.score < b.score
	end)

	for _, frame in ipairs(CMDAUTOFILL) do
		frame.Visible = false
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
					Position = lastFramePos and newPosition or UDim2.new(0.5, 0, 0, newYPos)
				})

				lastFramePos = newPosition
			else
				frame.Visible = false
			end
		end
	end
end

--[[ OPEN THE COMMAND BAR ]]--
mouse.KeyDown:Connect(function(k)
	if k:lower()==opt.prefix then
		Wait();
		gui.barSelect()
		cmdInput.Text=''
		cmdInput:CaptureFocus()
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

--Discover({Enum.Platform.IOS,Enum.Platform.Android},UserInputService:GetPlatform()) | searches if the player is on mobile.
if IsOnPC then
	gui.resizeable(chatLogsFrame)
	gui.resizeable(commandsFrame)
	gui.resizeable(UpdLogsFrame)
end

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
				Insert(results, {
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

	for _, v in pairs(chatLogs:GetChildren()) do
		if v:IsA("TextLabel") then
			v.LayoutOrder = v.LayoutOrder + 1
		end
	end

	chatMsg.Parent = chatLogs

	local displayName = plr.DisplayName or "Unknown"
	local userName = plr.Name or "Unknown"

	local isNAadmin = false
	if _G.NAadminsLol then
		for _, id in ipairs(_G.NAadminsLol) do
			if plr.UserId == id then
				isNAadmin = true
				break
			end
		end
	end

	if isNAadmin then
		chatMsg:Destroy()
	else
		if displayName == userName then
			chatMsg.Text = ("@%s: %s"):format(userName, msg)
		else
			chatMsg.Text = ("%s [@%s]: %s"):format(displayName, userName, msg)
		end

		if plr == LocalPlayer then
			chatMsg.TextColor3 = Color3.fromRGB(0, 0, 155)
		elseif LocalPlayer:IsFriendsWith(plr.UserId) then
			chatMsg.TextColor3 = Color3.fromRGB(255, 255, 0)
		end
	end

	local txtSize = gui.txtSize(chatMsg, chatMsg.AbsoluteSize.X, 100)
	chatMsg.Size = UDim2.new(1, -5, 0, txtSize.Y)

	local MAX_MESSAGES = 50
	local chatFrames = {}
	for _, v in pairs(chatLogs:GetChildren()) do
		if v:IsA("TextLabel") then
			Insert(chatFrames, v)
		end
	end

	table.sort(chatFrames, function(a, b)
		return a.LayoutOrder < b.LayoutOrder
	end)

	if #chatFrames > MAX_MESSAGES then
		for i = MAX_MESSAGES + 1, #chatFrames do
			chatFrames[i]:Destroy()
		end
	end
end

function setupPlayer(plr)
	plr.Chatted:Connect(function(msg)
		bindToChat(plr, msg)
	end)

	Insert(playerButtons, plr)

	if plr ~= LocalPlayer then
		CheckPermissions(plr)
	end

	if ESPenabled then
		spawn(function()
			repeat wait(1) until plr.Character
			ESP(plr)
		end)
	end
end

for _, plr in pairs(Players:GetPlayers()) do
	setupPlayer(plr)
end

Players.PlayerAdded:Connect(setupPlayer)

Players.PlayerRemoving:Connect(function(plr)
	local index = Discover(playerButtons, plr)
	if index then
		table.remove(playerButtons, index)
	end
	removeESPonLEAVE(plr)
end)

mouse.Move:Connect(function()
	description.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
	local newSize = gui.txtSize(description, 200, 100)
	description.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
end)

function updateCanvasSize(frame)
	local layout = frame:FindFirstChildOfClass("UIListLayout")
	if layout then
		frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
	end
end

RunService.Stepped:Connect(function()
	updateCanvasSize(chatLogs)
	updateCanvasSize(commandsList)
	updateCanvasSize(UpdLogsList)
end)

RunService.RenderStepped:Connect(function()
	local p = opt.prefix

	local function isInvalid(prefix)
		return not prefix
			or utf8.len(prefix) ~= 1
			or prefix:match("[%w]")
			or prefix:match("[%[%]%(%)%*%^%$%%{}<>]")
			or prefix:match("&amp;") or prefix:match("&lt;") or prefix:match("&gt;")
			or prefix:match("&quot;") or prefix:match("&#x27;") or prefix:match("&#x60;")
	end

	if isInvalid(p) then
		if opt.prefix ~= ";" then
			opt.prefix = ";"
			DoNotif("Invalid prefix detected. Resetting to default ';'")
			lastPrefix = ";"

			if FileSupport and isfile("Nameless-Admin/Prefix.txt") then
				local filePrefix = readfile("Nameless-Admin/Prefix.txt")
				if isInvalid(filePrefix) then
					writefile("Nameless-Admin/Prefix.txt", ";")
				end
			end
		end
	else
		lastPrefix = p
	end
end)

NACaller(function()
	local template = UpdLogsLabel
	local list = UpdLogsList

	UpdLogsTitle.Text = UpdLogsTitle.Text.." "..updDate

	if next(updLogs) then
		for name, txt in pairs(updLogs) do
			local btn = template:Clone()
			btn.Parent = list
			btn.Name = name
			btn.Text = "-"..txt
		end
	end
end)

--[[ COMMAND BAR BUTTON ]]--
local TextLabel = InstanceNew("TextLabel")
local UICorner = InstanceNew("UICorner")
local UIStroke = InstanceNew("UIStroke")
local UIGradient = InstanceNew("UIGradient")
local ImageButton = InstanceNew("ImageButton")
local UICorner2 = InstanceNew("UICorner")

TextLabel.Parent = ScreenGui
TextLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel.BackgroundTransparency = 1
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.Size = UDim2.new(0, 0, 0, 0)
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = getSeasonEmoji().." "..adminName.." V"..curVer.." "..getSeasonEmoji()
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 22
TextLabel.TextWrapped = true
TextLabel.TextStrokeTransparency = 0.8
TextLabel.TextTransparency = 1
TextLabel.ZIndex = 9999

UICorner2.CornerRadius = UDim.new(0.25, 0)
UICorner2.Parent = TextLabel

UIStroke.Parent = TextLabel
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(0, 0, 0)
UIStroke.Transparency = 0.6
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

UIGradient.Parent = TextLabel
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 170))
}
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.5, 0.3),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Rotation = 45

ImageButton.Parent = ScreenGui
ImageButton.BackgroundTransparency = 1
ImageButton.AnchorPoint = Vector2.new(0.5, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.5, 0, -1, 0)
ImageButton.Size = UDim2.new(0, 32 * NAScale, 0, 33 * NAScale)
ImageButton.Image = "rbxassetid://77352376040674"
ImageButton.ZIndex = 9999

UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = ImageButton

NAimageButton = ImageButton

if IsOnMobile then
	ImageButton.MouseEnter:Connect(function()
		TweenService:Create(ImageButton, TweenInfo.new(0.25), {
			Size = UDim2.new(0, 34 * NAScale, 0, 35 * NAScale)
		}):Play()
	end)
	ImageButton.MouseLeave:Connect(function()
		TweenService:Create(ImageButton, TweenInfo.new(0.25), {
			Size = UDim2.new(0, 32 * NAScale, 0, 33 * NAScale)
		}):Play()
	end)
end

function Swoosh()
	local targetRotation = isAprilFools() and math.random(1, 1000) or 720
	TweenService:Create(ImageButton, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = targetRotation}):Play()
	gui.draggablev2(ImageButton)
end

function mainNameless()
	local txtLabel = TextLabel

	local textWidth = TextService:GetTextSize(txtLabel.Text, txtLabel.TextSize, txtLabel.Font, Vector2.new(math.huge, math.huge)).X
	local finalSize = UDim2.new(0, textWidth + 80, 0, 40)

	local appearTween = TweenService:Create(txtLabel, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
		Size = finalSize,
		BackgroundTransparency = 0.14,
		TextTransparency = 0,
	})

	local riseTween = TweenService:Create(txtLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 0.5, -10)
	})

	appearTween:Play()
	riseTween:Play()

	if IsOnMobile then
		ImageButton.Size = UDim2.new(0, 0, 0, 0)
		ImageButton.Position = UDim2.new(0.5, 0, -0.1, -20)
		ImageButton.ImageTransparency = 1

		local appearTween = TweenService:Create(ImageButton, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 32 * NAScale, 0, 33 * NAScale),
			Position = UDim2.new(0.5, 0, 0.1, 0),
			ImageTransparency = 0
		})
		appearTween:Play()
		Swoosh()
	else
		ImageButton:Destroy()
	end

	Wait(2.5)

	local fadeOutTween = TweenService:Create(txtLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
		TextTransparency = 1,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 20),
		Size = UDim2.new(0, 0, 0, 0)
	})

	fadeOutTween:Play()

	fadeOutTween.Completed:Connect(function()
		txtLabel:Destroy()
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
	local nameCheck = nameChecker(Player)

	local function maybeMock(text)
		return isAprilFools() and MockText(text) or text
	end

	Delay(0.3, function()
		local executorName = identifyexecutor and identifyexecutor() or "Unknown"
		local welcomeMessage = "Welcome to "..adminName.." V"..curVer

		executorName = maybeMock(executorName)
		welcomeMessage = maybeMock(welcomeMessage)

		local notifBody = welcomeMessage..
			(identifyexecutor and ("\nExecutor: "..executorName) or "")..
			"\nUpdated on: "..updDate..
			"\nTime Taken To Load: "..loadedResults(NAresult)

		DoNotif(notifBody, 6, rngMsg().." "..nameCheck)

		Notify({
			Title = maybeMock("Would you like to enable QueueOnTeleport?"),
			Description = maybeMock("With QueueOnTeleport, "..adminName.." will automatically execute itself upon teleporting to a game or place."),
			Buttons = {
				{Text = "Yes", Callback = function() queueteleport(loader) end},
				{Text = "No", Callback = function() end}
			}
		})

		Wait(1)

		if IsOnPC then
			local keybindMessage = maybeMock("Your Keybind Prefix: "..opt.prefix)
			DoNotif(keybindMessage, 10, adminName.." Keybind Prefix")
		end

		Wait(2)

		--[[local updateLogMessage = maybeMock('Added "updlog" command (displays any new changes added into '..adminName..')')
		DoNotif(updateLogMessage, nil, "Info")]]
	end)
	cmdInput.ZIndex = 10
	cmdInput.PlaceholderText = isAprilFools() and '🤡 '..adminName.." V"..curVer..' 🤡' or getSeasonEmoji()..' '..adminName.." V"..curVer..' '..getSeasonEmoji()
end)

CaptureService.CaptureBegan:Connect(function()
	if NAimageButton then
		NAimageButton.Visible=false
	end
end)

CaptureService.CaptureEnded:Connect(function()
	Delay(0.1, function()
		if NAimageButton then
			NAimageButton.Visible=true
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

if isAprilFools() then queueteleport("getgenv().ActivateAprilMode=true") end

math.randomseed(os.time())

Spawn(function()
	while Wait() do
		if getHum() then
			getHum().AutoJumpEnabled=false
			break
		end
	end
end)

Spawn(function() -- innit
	cmdBar.Name = randomString()
	chatLogsFrame.Name = randomString()
	commandsFrame.Name = randomString()
	UpdLogsFrame.Name = randomString()
	resizeFrame.Name = randomString()
	description.Name = randomString()
end)

Spawn(function()
	NACaller(function()--better saveinstance support
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/SaveInstance.lua"))();
	end)
end)