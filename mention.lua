-- Methion Maximum compatibility build
--
-- The original source exceeded the 200-local-register limit in
-- older executor Luau compilers. The first top-level declarations
-- are intentionally environment globals in this build so their
-- values do not consume registers for the lifetime of the chunk.
WindUI = nil
do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    if ok then
        WindUI = result
    else
        local winduiCode = game:HttpGet("https://raw.githubusercontent.com/induchSandWitch/Methion/refs/heads/main/MethionUi")
        
        local oldMakeFolder = makefolder
        local oldWriteFile = writefile
        local oldIsFolder = isfolder
        local oldIsFile = isfile
        local oldReadFile = readfile
        local oldListFiles = listfiles
        
        getgenv().makefolder = function() return true end
        getgenv().writefile = function() return true end
        getgenv().isfolder = function() return false end
        getgenv().isfile = function() return false end
        getgenv().readfile = function() return "" end
        getgenv().listfiles = function() return {} end
        
        WindUI = loadstring(winduiCode)()
        
        getgenv().makefolder = oldMakeFolder
        getgenv().writefile = oldWriteFile
        getgenv().isfolder = oldIsFolder
        getgenv().isfile = oldIsFile
        getgenv().readfile = oldReadFile
        getgenv().listfiles = oldListFiles
    end
end
WindUI:Popup({
    Title = "Please Read Before Farming",
    Icon = "bird",
    Content = "This Script is a remake of azure. if you keeps getting kick it is either your wifi or you have a ***** executor. and remember if you got ban it is not our problem we didnt force you to use our script.",
    Buttons = {
        {
            Title = "Ok",
            Icon = "bird",
        }
    }
})
setclipboard("https://discord.gg/vCKZFjaTv4")
loadstring(game:HttpGet("https://raw.githubusercontent.com/weatherwess-lgtm/FlyToggle/refs/heads/main/Clipboard"))()
Window = WindUI:CreateWindow({
    Title = "YBA Script",
    Icon = "rbxthumb://type=Asset&id=92343328137209&w=150&h=150",
    Author = "cracked by piscar.",
    Folder = "yba_script",
    IconSize = 70,
    NewElements = true,
    HideSearchBar = false,
    Background = "rbxthumb://type=Asset&id=106644461650775&w=150&h=150",
    BackgroundImageTransparency = 0.8,
    Transparent = true,
    OpenButton = {
        Title = "Open Methion UI",
        CornerRadius = UDim.new(5,0),
        StrokeThickness = 4,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new(
            Color3.fromHex("#FFFFFF"),
            Color3.fromHex("#000000")
        )
    }
})
do
    Window:Tag({
        Title = "V1.6.66",
        Icon = "github",
        Color = Color3.fromHex("#000000")
    })
end
Window:SetToggleKey(Enum.KeyCode.K)
function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
local currentIndent = string.rep(" ", level * indent)
local nextIndent = string.rep(" ", (level + 1) * indent)
if luau_table == nil then
return "null"
end
local dataType = type(luau_table)
if dataType == "table" then
if visited[luau_table] then
return "\"[Circular Reference]\""
end
        visited[luau_table] = true
local isArray = true
local maxIndex = 0
for k, _ in pairs(luau_table) do
if type(k) == "number" and k > maxIndex then
                maxIndex = k
end
if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
break
end
end
local count = 0
for _ in pairs(luau_table) do
            count = count + 1
end
if count ~= maxIndex and isArray then
            isArray = false
end
if count == 0 then
return "{}"
end
if isArray then
if count == 0 then
return "[]"
end
local result = "[\n"
for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
if i < maxIndex then
                    result = result .. ","
end
                result = result .. "\n"
end
            result = result .. currentIndent .. "]"
return result
else
local result = "{\n"
local first = true
local keys = {}
for k in pairs(luau_table) do
                table.insert(keys, k)
end
            table.sort(keys, function(a, b)
if type(a) == type(b) then
return tostring(a) < tostring(b)
else
return type(a) < type(b)
end
end)
for _, k in ipairs(keys) do
local v = luau_table[k]
if not first then
                    result = result .. ",\n"
else
                    first = false
end
if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
end
                result = result .. parseJSON(v, indent, level + 1, visited)
end
            result = result .. "\n" .. currentIndent .. "}"
return result
end
elseif dataType == "string" then
local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
return "\"" .. escaped .. "\""
elseif dataType == "number" then
return tostring(luau_table)
elseif dataType == "boolean" then
return luau_table and "true" or "false"
elseif dataType == "function" then
return "\"function\""
else
return "\"" .. dataType .. "\""
end
end
function tableToClipboard(luau_table, indent)
    indent = indent or 4
local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
return jsonString
end
AboutTab = Window:Tab({
    Title = "About",
    Icon = "info",
})

AboutTab:Section({
    Title = "METHION YBA SCRIPT",
    TextSize = 28,
    FontWeight = Enum.FontWeight.Bold,
})

AboutTab:Paragraph({
    Animate = true,
    Title = "what's up",
    Desc = "made this script cause i got tired of grinding manually. it does what it says on the tin - farms items, does quests, teleports around. nothing fancy but it works.",
    TextSize = 16
})

AboutTab:Space()

AboutTab:Section({
    Title = "how to use this thing",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
})

AboutTab:Paragraph({
    Title = "Quest Farm",
    Desc = "set your target level and let it run. it'll pick quests automatically and level you up. works best if you actually set a reasonable target.",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "Item Farm",
    Desc = "turn it on, pick what items you want, go to a safe spot. it'll collect everything and go back to safety when done. don't stand in the open like an idiot.",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "Stand Farm",
    Desc = "pick the stand you want, set how many rokas/arrows to use. it'll keep rolling until you get it or run out. shiny mode if you care about that.",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "Teleports",
    Desc = "instant travel to most useful spots. faster than walking, obviously. use it for item farming or just getting around.",
    TextSize = 14
})

AboutTab:Space()

AboutTab:Section({
    Title = "heads up",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
})

AboutTab:Paragraph({
    Title = "don't be stupid",
    Desc = "this is a script for a roblox game. don't use it on your main account if you care about it. don't run it 24/7 in the same server. basic stuff.",
    TextSize = 14
})

AboutTab:Space()

AboutTab:Section({
    Title = "Discord",
    TextSize = 22,
    FontWeight = Enum.FontWeight.Bold,
})

AboutTab:Paragraph({
    Animate = true,
    Title = "join if you want updates or help",
    Desc = "i post updates there first and it's easier to help people when i can actually talk to them. also if something breaks i'll probably mention it there.",
    TextSize = 16
})

AboutTab:Button({
    Title = "Copy Discord Invite",
    Icon = "copy",
    Callback = function()
        setclipboard("https://discord.gg/vCKZFjaTv4")
        notify("Methion", "discord copied")
    end
})

AboutTab:Space()

AboutTab:Section({
    Title = "Credits",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
})

AboutTab:Paragraph({
    Title = "People who actually made this work",
    Desc = "",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "@ErasedDiablo - Owner",
    Desc = "runs the show, fixes stuff when it breaks at 3am",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "@Gaxhlol - Main Dev",
    Desc = "writes most of the code, complains about it constantly",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "@Kazakori - Dev Helper",
    Desc = "helps test and finds bugs by breaking everything",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "@Kaz - Former Dev",
    Desc = "helped early on, moved on to other stuff",
    TextSize = 14
})

AboutTab:Paragraph({
    Title = "@Findingwayto**** - Former Dev",
    Desc = "you know why the name is censored",
    TextSize = 14
})

AboutTab:Space()

AboutTab:Paragraph({
    Title = "UI",
    Desc = "uses WindUI by Footagesus - saved me from making my own ugly ui",
    TextSize = 14
})

AboutTab:Space()

AboutTab:Paragraph({
    Title = "version 1.6.66 | 2026",
    Desc = "if you're reading this on an older version, update it",
    TextSize = 12,
    TextTransparency = 0.5
})

WhatsNewTab = Window:Tab({
    Title = "Updates",
    Icon = "sigma",
})

WhatsNewTab:Section({
    Title = "v1.6.66",
    TextSize = 26,
    FontWeight = Enum.FontWeight.Bold,
})

WhatsNewTab:Paragraph({
    Animate = true,
    Title = "latest update",
    Desc = "fixed some bugs, added some stuff, the usual. should work better now.",
    TextSize = 15
})

WhatsNewTab:Space()

WhatsNewTab:Section({
    Title = "What's New",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
})

WhatsNewTab:Paragraph({
    Title = "Executor Detection",
    Desc = "detects what executor you're using and enables features based on that. unsupported ones get basic mode.",
    TextSize = 14
})

WhatsNewTab:Paragraph({
    Title = "Anti-Kick",
    Desc = "some stuff to stop you getting kicked as often. not perfect but helps.",
    TextSize = 14
})

WhatsNewTab:Paragraph({
    Title = "Safe Place Farming",
    Desc = "teleports to a safe spot to farm items so you don't get messed with",
    TextSize = 14
})

WhatsNewTab:Paragraph({
    Title = "Better Teleports",
    Desc = "smoother teleporting, less getting stuck or flung into the void",
    TextSize = 14
})

WhatsNewTab:Paragraph({
    Title = "Stand Farming",
    Desc = "target specific stands, shiny detection, auto roka/arrow management",
    TextSize = 14
})

WhatsNewTab:Paragraph({
    Title = "Auto-Sell",
    Desc = "sells items when inventory is full. won't sell important stuff unless you tell it to",
    TextSize = 14
})

WhatsNewTab:Paragraph({
    Title = "Quest Auto-Select",
    Desc = "picks the best quests for your level automatically",
    TextSize = 14
})

WhatsNewTab:Paragraph({
    Title = "FPS Booster",
    Desc = "removes effects to get more fps if your pc is struggling",
    TextSize = 14
})

WhatsNewTab:Space()

WhatsNewTab:Section({
    Title = "Fixes",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold,
})

WhatsNewTab:Paragraph({
    Title = "General",
    Desc = "fixed memory leaks, ui should be more responsive, item collection should be smoother",
    TextSize = 14
})

WhatsNewTab:Space()

WhatsNewTab:Section({
    Title = "Coming Soon",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold,
})

WhatsNewTab:Paragraph({
    Title = "SBR Stuff",
    Desc = "auto racing and other steel ball run features eventually",
    TextSize = 14
})

WhatsNewTab:Space()

WhatsNewTab:Paragraph({
    Title = "Build 1.6.66 | 2026",
    Desc = "update if you haven't already",
    TextSize = 12,
    TextTransparency = 0.4
})
FarmingTab = Window:Tab({ Title = "Item Farming", Icon = "philippine-peso" })
StandFarmTab = Window:Tab({ Title = "Stand Farm", Icon = "ghost" })
QuestTab = Window:Tab({ Title = "Quest", Icon = "list" })
SBRTab = Window:Tab({ Title = "SBR", Icon = "chess-knight" })
SellingTab = Window:Tab({ Title = "Selling", Icon = "dollar-sign" })
ShopTab = Window:Tab({ Title = "Shop", Icon = "shopping-cart" })
VisualTab = Window:Tab({ Title = "Visual", Icon = "eye" })
AdjustTab = Window:Tab({ Title = "Adjust", Icon = "sliders-horizontal" })
MiscTab = Window:Tab({ Title = "Misc", Icon = "settings-2" })
TrollingTab = Window:Tab({ Title = "Trolling", Icon = "smile-plus" })
KeybindsTab = Window:Tab({ Title = "Keybinds", Icon = "keyboard" })
GameTab = Window:Tab({ Title = "Game", Icon = "gamepad-2" })
SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })
player = game.Players.LocalPlayer
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
topGui = Instance.new("ScreenGui")
function notify(title, message)
title = title or "YBA Script"
    WindUI:Notify({
        Title = title,
        Content = message
    })
end
items = {}
maxLimits = {
["Mysterious Arrow"] = 25,
["Rokakaka"] = 25,
["Gold Coin"] = 45,
["Diamond"] = 25,
["Pure Rokakaka"] = 999,
["Quinton's Glove"] = 10,
["Steel Ball"] = 10,
["Rib Cage of The Saint's Corpse"] = 10,
["Zepellin's Headband"] = 10,
["Zeppeli's Hat"] = 10,
["Caesar's Headband"] = 10,
["Clackers"] = 10,
["Stone Mask"] = 10,
["Ancient Scroll"] = 10,
["Dio's Diary"] = 10,
["Lucky Stone Mask"] = 999,
["Lucky Arrow"] = 999,
["Gold Umbrella"] = 999,
["Christmas Present"] = 999
}
nonSellable = {"Blue Candy", "Red Candy", "Green Candy", "Yellow Candy", "Lucky Arrow", "Lucky Stone Mask", "Christmas Present"}
itemOptions = {}
seen = {}
for item in pairs(maxLimits) do
    table.insert(itemOptions, item)
    seen[item] = true
end
for _, candy in ipairs(nonSellable) do
    if not seen[candy] then
        table.insert(itemOptions, candy)
        seen[candy] = true
    end
end
table.sort(itemOptions)
worthlessItems = {"Gold Coin", "Diamond", "Quinton's Glove", "Zeppeli's Hat", "Caesar's Headband", "Ancient Scroll"}
function updateItems()
    items = {}
for itemName in pairs(maxLimits) do
        items[itemName] = 0
end
local function countInContainer(container)
if not container then return end
for _, item in pairs(container:GetChildren()) do
if item and item.Name and maxLimits[item.Name] then
                items[item.Name] = (items[item.Name] or 0) + 1
end
end
end
    countInContainer(player.Backpack)
if player.Character then
        countInContainer(player.Character)
end
end
function findSellRemote()
local plr = game.Players.LocalPlayer
if plr and plr.Character then
for _, obj in pairs(plr.Character:GetChildren()) do
if obj:IsA("RemoteEvent") then
return obj
end
end
end
local places = {game.Workspace, game.ReplicatedStorage, game:GetService("ReplicatedStorage"), game:GetService("Players")}
for _, place in pairs(places) do
if place then
for _, obj in pairs(place:GetDescendants()) do
if obj:IsA("RemoteEvent") and (obj.Name:lower():find("remote") or obj.Name:lower():find("remoteevent") or obj.Name:lower():find("sell") or obj.Name:lower():find("server") or obj.Name:lower():find("_ev")) then
return obj
end
end
end
end
for _, obj in pairs(game.Workspace:GetChildren()) do
if obj:IsA("RemoteEvent") then
return obj
end
end
return nil
end
function sellItem(item)
if not item then return false end
local itemName = typeof(item) == "Instance" and item.Name or item
if table.find(nonSellable, itemName) then
        notify("YBA Script", "Cannot sell " .. itemName .. " as it is not sellable.")
return false
end
local plr = game.Players.LocalPlayer
if not plr then return false end
local instanceToSell
if typeof(item) == "Instance" then
        instanceToSell = item
elseif typeof(item) == "string" then
        instanceToSell = plr.Backpack:FindFirstChild(item) or (plr.Character and plr.Character:FindFirstChild(item))
else
return false
end
if not instanceToSell or not instanceToSell.Parent then
return false
end
local plrName = plr.Name
local living = game.Workspace:FindFirstChild("Living") or game.Workspace
local target = nil
if living then
        target = living:FindFirstChild(plrName) or living
else
        target = game.Workspace
end
pcall(function()
        instanceToSell.Parent = target
end)
local args = {
[1] = "EndDialogue",
[2] = {
["NPC"] = "Merchant",
["Option"] = "Option2",
["Dialogue"] = "Dialogue5"
}
}
local fired = false
local ok, remote = pcall(findSellRemote)
if ok and remote then
pcall(function()
            remote:FireServer(unpack(args))
end)
        fired = true
else
if plr.Character then
local r = plr.Character:FindFirstChildWhichIsA("RemoteEvent")
if r then
pcall(function()
                    r:FireServer(unpack(args))
end)
                fired = true
end
end
end
pcall(function()
if not fired and plr.Character and plr.Character:FindFirstChild("RemoteEvent") then
            plr.Character.RemoteEvent:FireServer(unpack(args))
            fired = true
end
end)
wait(0.12)
return true
end
function sellAll(itemName)
    updateItems()
local count = items[itemName] or 0
if count == 0 then
        notify("YBA Script", "No " .. itemName .. " found.")
return
end
local sold = 0
while true do
local item = player.Backpack:FindFirstChild(itemName) or (player.Character and player.Character:FindFirstChild(itemName))
if not item then break end
if sellItem(item) then
            sold = sold + 1
else
break
end
end
    notify("YBA Script", "Sold " .. sold .. " " .. itemName .. (sold > 1 and "s" or "") .. ".")
end
function sellAllSelected(selectedItems)
    updateItems()
local total = 0
for _, itemName in ipairs(selectedItems) do
        total = total + (items[itemName] or 0)
end
if total == 0 then
        notify("YBA Script", "No selected items found.")
return
end
local sold = 0
for _, itemName in ipairs(selectedItems) do
while true do
local item = player.Backpack:FindFirstChild(itemName) or (player.Character and player.Character:FindFirstChild(itemName))
if not item then break end
if sellItem(item) then
                sold = sold + 1
else
break
end
end
end
    notify("YBA Script", "Sold " .. sold .. " selected item" .. (sold > 1 and "s" or "") .. ".")
end
function sellAllWorthless()
    updateItems()
local total = 0
for _, itemName in ipairs(worthlessItems) do
        total = total + (items[itemName] or 0)
end
if total == 0 then
        notify("YBA Script", "No worthless items found.")
return
end
local sold = 0
for _, itemName in ipairs(worthlessItems) do
while true do
local item = player.Backpack:FindFirstChild(itemName) or (player.Character and player.Character:FindFirstChild(itemName))
if not item then break end
if sellItem(item) then
                sold = sold + 1
else
break
end
end
end
    notify("YBA Script", "Sold " .. sold .. " worthless item" .. (sold > 1 and "s" or "") .. ".")
end
function sellInventory()
    updateItems()
local sold = 0
for itemName, count in pairs(items) do
if count > 0 and not table.find(nonSellable, itemName) then
while true do
local item = player.Backpack:FindFirstChild(itemName) or (player.Character and player.Character:FindFirstChild(itemName))
if not item then break end
if sellItem(item) then
                    sold = sold + 1
else
break
end
end
end
end
    notify("YBA Script", "Sold " .. sold .. " item" .. (sold > 1 and "s" or "") .. " from inventory.")
end
autoSellMax = false
function checkAndSellMax()
local soldSummary = {}
local tempCounts = {}
for name in pairs(maxLimits) do
        tempCounts[name] = 0
end
local containers = {player.Backpack}
if player.Character then
        table.insert(containers, player.Character)
end
for _, container in ipairs(containers) do
local children = container:GetChildren()
for _, item in ipairs(children) do
local name = item.Name
if maxLimits[name] then
                tempCounts[name] = tempCounts[name] + 1
if (tempCounts[name] >= (maxLimits[name] or 25)) and autoSellMax then
if sellItem(item) then
                        soldSummary[name] = (soldSummary[name] or 0) + 1
end
end
end
end
end
local totalSold = 0
local parts = {}
for name, n in pairs(soldSummary) do
        totalSold = totalSold + n
        table.insert(parts, n .. "x " .. name)
end
if totalSold > 0 then
local msg = "Auto sold: " .. table.concat(parts, ", ")
        notify("YBA Script", msg)
end
end
autoSellSelected = false
selectedAutoSellItems = {}
selectedSellAllItems = {}
lastAutoSellNotify = {}
player.Backpack.ChildAdded:Connect(function(item)
if autoSellMax then
        checkAndSellMax()
end
if autoSellSelected and table.find(selectedAutoSellItems, item.Name) then
wait(0.2)
local now = tick()
local last = lastAutoSellNotify[item.Name] or 0
if now - last >= 0.5 then
if sellItem(item) then
                notify("YBA Script", "Auto sold " .. item.Name .. " on pickup.")
                lastAutoSellNotify[item.Name] = now
end
end
end
end)
player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(item)
if autoSellMax then
            checkAndSellMax()
end
if autoSellSelected and table.find(selectedAutoSellItems, item.Name) then
wait(0.2)
local now = tick()
local last = lastAutoSellNotify[item.Name] or 0
if now - last >= 0.5 then
if sellItem(item) then
                    notify("YBA Script", "Auto sold " .. item.Name .. " on pickup.")
                    lastAutoSellNotify[item.Name] = now
end
end
end
end)
end)
noclipEnabled = false
originalCollides = {}
noclipConn = nil
function enforceNoclipForCharacter(char)
if not char then return end
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") then
            originalCollides[part] = part.CanCollide
            part.CanCollide = false
end
end
end
function enableNoclip()
if noclipEnabled then return end
local char = player.Character
if not char or not char.Parent then
        noclipEnabled = true
return
end
    originalCollides = {}
    enforceNoclipForCharacter(char)
if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    noclipConn = RunService.Stepped:Connect(function()
local c = player.Character
if not c then return end
for _, p in ipairs(c:GetDescendants()) do
if p:IsA("BasePart") then
if p.CanCollide then p.CanCollide = false end
end
end
end)
    noclipEnabled = true
end
function disableNoclip()
if not noclipEnabled then return end
if noclipConn then noclipConn:Disconnect() noclipConn = nil end
for part, val in pairs(originalCollides) do
if part and part.Parent and part:IsA("BasePart") then
pcall(function() part.CanCollide = val end)
end
end
    originalCollides = {}
    noclipEnabled = false
end
studMultiplier = 1
tweenMultiplier = 1
function travelToStud(target)
    if not player.Character or not player.Character.HumanoidRootPart then return end
    local hrp = player.Character.HumanoidRootPart
    local targetPos = typeof(target) == "Vector3" and target or target.Position
    local vector = targetPos - hrp.Position
    local length = vector.Magnitude
    local step_size = (afkFarmOn and 5 or 25) * studMultiplier
    local num_tp = math.ceil(length / step_size)
    if num_tp < 1 then num_tp = 1 end
    for i = 1, num_tp do
        if not player.Character or not player.Character.HumanoidRootPart then return end
        hrp.CFrame = hrp.CFrame + vector / num_tp
        wait(tpDelay)
    end
end
TweenService = game:GetService("TweenService")
RunService = game:GetService("RunService")

virtualAnchor = Instance.new("Part")
virtualAnchor.Anchored = true
virtualAnchor.CanCollide = false
virtualAnchor.Transparency = 1
virtualAnchor.Size = Vector3.new(1, 1, 1)
virtualAnchor.Parent = workspace.Terrain

currentConnection = nil
tweenMultiplier = 1

function travelToTween(target)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local humanoid = player.Character:FindFirstChild("Humanoid")
    local targetPos = typeof(target) == "Vector3" and target or target.Position
    
    if currentConnection then
        currentConnection:Disconnect()
        currentConnection = nil
    end
    
    virtualAnchor.CFrame = hrp.CFrame
    
    local distance = (targetPos - hrp.Position).Magnitude
    local effectiveSpeed = 200 * tweenMultiplier
    local time = math.max(distance / effectiveSpeed, 0.1)
    
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
    local targetCFrame = CFrame.new(targetPos) * CFrame.Angles(0, math.atan2(
        targetPos.X - hrp.Position.X, 
        targetPos.Z - hrp.Position.Z
    ), 0)
    
    local tween = TweenService:Create(virtualAnchor, tweenInfo, {CFrame = targetCFrame})
    
    currentConnection = RunService.Heartbeat:Connect(function()
        if hrp and virtualAnchor then
            hrp.CFrame = virtualAnchor.CFrame
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
    end)
    
    tween:Play()
    tween.Completed:Wait()
    
    if currentConnection then
        currentConnection:Disconnect()
        currentConnection = nil
    end
    
    if hrp then
        hrp.CFrame = targetCFrame
    end
end
getgenv().ItemStickConnections = getgenv().ItemStickConnections or {}

function cleanupItemStick()
    for _, data in pairs(getgenv().ItemStickConnections) do
        if data.alignPos then pcall(function() data.alignPos:Destroy() end) end
        if data.alignOri then pcall(function() data.alignOri:Destroy() end) end
        if data.attA then pcall(function() data.attA:Destroy() end) end
        if data.attB then pcall(function() data.attB:Destroy() end) end
        if data.conn then pcall(function() data.conn:Disconnect() end) end
    end
    getgenv().ItemStickConnections = {}
end

function isItemTarget(target)
    if typeof(target) ~= "Instance" then return false end
    
    local itemsFolder = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
    if itemsFolder and target:IsDescendantOf(itemsFolder) then
        return true
    end
    
    if target:FindFirstChild("ProximityPrompt") then
        return true
    end
    
    if target.Parent and target.Parent:FindFirstChild("ProximityPrompt") then
        return true
    end
    
    return false
end

local function travelToInstant(target)
    cleanupItemStick()

    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local hrp = player.Character.HumanoidRootPart
    local targetPart = nil
    local isItem = false

    if typeof(target) == "Vector3" then
        hrp.CFrame = CFrame.new(target)
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        return
    elseif typeof(target) == "CFrame" then
        hrp.CFrame = target
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        return
    elseif typeof(target) == "Instance" then
        isItem = isItemTarget(target)
        
        if target:IsA("BasePart") then
            targetPart = target
        elseif target:FindFirstChildOfClass("MeshPart") then
            targetPart = target:FindFirstChildOfClass("MeshPart")
        elseif target:FindFirstChildOfClass("Part") then
            targetPart = target:FindFirstChildOfClass("Part")
        elseif target.PrimaryPart then
            targetPart = target.PrimaryPart
        end
    else
        return
    end

    if not targetPart then return end

    if not isItem then
        hrp.CFrame = CFrame.new(targetPart.Position)
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        return
    end

    local method = getgenv().InstantMethod or "Up"
    
    if method == "Up" then
        hrp.CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 0.10, 0))
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        
    elseif method == "Down" then
        local STICK_DISTANCE = 8
        
        local attA = Instance.new("Attachment")
        attA.Name = "ItemStick_AttA"
        attA.Parent = hrp
        attA.WorldOrientation = Vector3.new(0, 0, 0)
        
        local attB = Instance.new("Attachment")
        attB.Name = "ItemStick_AttB"
        attB.Parent = targetPart
        attB.Position = Vector3.new(0, 0, 0)
        
        local alignPos = Instance.new("AlignPosition")
        alignPos.Name = "ItemStick_AlignPos"
        alignPos.Attachment0 = attA
        alignPos.Attachment1 = attB
        alignPos.MaxForce = 1e7
        alignPos.Responsiveness = 250
        alignPos.RigidityEnabled = false
        alignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
        alignPos.Parent = hrp
        
        local stickData = {
            alignPos = alignPos,
            attA = attA,
            attB = attB,
            targetPart = targetPart,
            isTempPart = false
        }
        table.insert(getgenv().ItemStickConnections, stickData)

        local worldPos = targetPart.Position - Vector3.new(0, STICK_DISTANCE, 0)
        hrp.CFrame = CFrame.new(worldPos) * CFrame.Angles(0, hrp.CFrame.Y, 0)

        local stickConn = game:GetService("RunService").Heartbeat:Connect(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                cleanupItemStick()
                return
            end
            
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            
            attA.WorldOrientation = Vector3.new(0, hrp.Orientation.Y, 0)
            
            if targetPart and targetPart.Parent then
                attB.WorldPosition = targetPart.Position - Vector3.new(0, STICK_DISTANCE, 0)
            else
                cleanupItemStick()
            end
        end)
        
        stickData.conn = stickConn
    end
end
local travelMethod = "Stud"
local function travelTo(target)
if travelMethod == "Stud" then
        travelToStud(target)
elseif travelMethod == "Tween" then
        travelToTween(target)
elseif travelMethod == "Instant" then
        travelToInstant(target)
end
end
local function teleportToRandom()
local map = game.Workspace:FindFirstChild("Map") or game.Workspace
local bounds = {
        minX = -590, maxX = 590,
        minZ = -520, maxZ = 530,
        y = 100
}
local randomX = math.random(bounds.minX, bounds.maxX)
local randomZ = math.random(bounds.minZ, bounds.maxZ)
if not player.Character or not player.Character.HumanoidRootPart then return end
local hrp = player.Character.HumanoidRootPart
    hrp.CFrame = CFrame.new(randomX, bounds.y, randomZ)
end
local function roamToRandom()
local map = game.Workspace:FindFirstChild("Map") or game.Workspace
local bounds = {
        minX = -590, maxX = 590,
        minZ = -520, maxZ = 530,
        y = 100
}
local randomX = math.random(bounds.minX, bounds.maxX)
local randomZ = math.random(bounds.minZ, bounds.maxZ)
local randomPos = Vector3.new(randomX, bounds.y, randomZ)
    travelTo(randomPos)
end
local normalFarmOn = false
local afkFarmOn = false
local selectedFarmItems = {}
local normalCoroutine = nil
local afkCoroutine = nil
local tpDelay = 0.05
local originalTpDelay = 0.05
local safePlaceFarmOn = false
local safePlaceCoroutine = nil
local safePlacePosition = Vector3.new(-47.261887, -33.486183, 90.047981)
getgenv().defaultSafePlacePosition = Vector3.new(-151.020264, 274.199310, 280.40679)
getgenv().newSafePlacePosition = Vector3.new(-47.261887, -33.486183, 90.047981)
getgenv().savedCoordinates = {}
getgenv().currentCoordSelection = "New"
local function findNearestItem(selectedItems)
    updateItems()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local minDist = math.huge
    local nearest = nil
    for _, v in pairs(game.Workspace.Item_Spawns.Items:GetChildren()) do
        local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
        local proxPrompt = v:FindFirstChild("ProximityPrompt")
        if itemPart and proxPrompt and itemPart.Transparency < 1 then
            local itemName = proxPrompt.ObjectText
            if (#selectedItems == 0 or table.find(selectedItems, itemName)) and (items[itemName] or 0) < (maxLimits[itemName] or math.huge) then
                local dist = (itemPart.Position - hrp.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = v
                end
            end
        end
    end
    return nearest
end
local function findLuckyArrow()
    local hrp = player.Character and player.Character.HumanoidRootPart
    if not hrp then return nil end
    local minDist = math.huge
    local nearest = nil
    for _, v in pairs(game.Workspace.Item_Spawns.Items:GetChildren()) do
        local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
        local prox = v:FindFirstChild("ProximityPrompt")
        if itemPart and prox and itemPart.Transparency < 1 and prox.ObjectText == "Lucky Arrow" then
            local dist = (itemPart.Position - hrp.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = v
            end
        end
    end
    return nearest
end
local function normalFarm()
while normalFarmOn do
if not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
wait(1)
            continue
end
local foundItem = false
while true do
    local v = findLuckyArrow() or findNearestItem(selectedFarmItems)
    if not v then break end
    foundItem = true
    local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
    local proxPrompt = v:FindFirstChild("ProximityPrompt")
    
    local originalMethod = getgenv().InstantMethod
    if travelMethod == "Instant" and getgenv().InstantMethod == "Down" then
        getgenv().InstantMethod = "Up"
        cleanupItemStick()
    end
    
      if instantPickup then
        instantTravelTo(itemPart)
        wait(1)
        checkAndSellMax()
        fireproximityprompt(proxPrompt, 0, true)
    else
        travelTo(itemPart)
        wait(0.2)
        local hrp = player.Character.HumanoidRootPart
        if (itemPart.Position - hrp.Position).Magnitude < 5 then
            checkAndSellMax()
            fireproximityprompt(proxPrompt, 4)
            wait(0.1)
            if v:IsDescendantOf(game.Workspace) then
                fireproximityprompt(proxPrompt, 4)
            end
        end
    end
    
    if originalMethod == "Down" then
        getgenv().InstantMethod = "Down"
    end
    
    checkAndSellMax()
    wait(0.2)
end
if not foundItem then
    teleportToRandom()
end
wait(0.2)
end
end
local function safePlaceFarm()
    while safePlaceFarmOn do
        if not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
            wait(1)
            continue
        end
        
        if getgenv().SafePlaceCollectionMode == "Batch Collect" then
            travelToInstant(safePlacePosition)
            wait(0.3)
            
            local itemsCollected = 0
            local maxBatchItems = 50
            
            while safePlaceFarmOn and itemsCollected < maxBatchItems do
                local v = findLuckyArrow() or findNearestItem(selectedFarmItems)
                
                if not v then
                    break
                end
                
                local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
                local proxPrompt = v:FindFirstChild("ProximityPrompt")
                
                if not itemPart or not proxPrompt then break end
                
                local itemName = proxPrompt.ObjectText
                if (items[itemName] or 0) >= (maxLimits[itemName] or math.huge) then
                    break
                end
                
                local originalCount = items[itemName] or 0
                
                if instantPickup and travelMethod == "Instant" then
                    instantTravelTo(itemPart)
                    
                    if getgenv().InstantMethod == "Down" then
                        wait(0.5)
                        local stickStart = tick()
                        while tick() - stickStart < 3 do
                            if not v or not v.Parent then break end
                            fireproximityprompt(proxPrompt, 0, true)
                            wait(0.1)
                            updateItems()
                            if (items[itemName] or 0) > originalCount then
                                break
                            end
                        end
                    else
                        wait(0.3)
                    end
                else
                    travelTo(itemPart)
                    wait(0.3)
                end
                
                checkAndSellMax()
                
                updateItems()
                if (items[itemName] or 0) <= originalCount then
                    for i = 1, 3 do
                        fireproximityprompt(proxPrompt, 0, true)
                        wait(0.1)
                    end
                end
                
                wait(0.2)
                checkAndSellMax()
                
                updateItems()
                local itemCollected = (items[itemName] or 0) > originalCount
                
                if itemCollected then
                    itemsCollected = itemsCollected + 1
                end
                
                wait(0.3)
            end
            
            if itemsCollected > 0 then
                travelToInstant(safePlacePosition)
                wait(0.6)
            else
                wait(0.5)
            end
            
        else
            travelToInstant(safePlacePosition)
            wait(0.3)
            
            local v = findLuckyArrow() or findNearestItem(selectedFarmItems)
            
            if not v then
                wait(0.5)
                continue
            end
            
            while safePlaceFarmOn and v do
                local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
                local proxPrompt = v:FindFirstChild("ProximityPrompt")
                
                if not itemPart or not proxPrompt then break end
                
                local itemName = proxPrompt.ObjectText
                if (items[itemName] or 0) >= (maxLimits[itemName] or math.huge) then
                    break
                end
                
                local originalCount = items[itemName] or 0
                
                if instantPickup and travelMethod == "Instant" then
                    instantTravelTo(itemPart)
                    
                    if getgenv().InstantMethod == "Down" then
                        wait(0.5)
                        local stickStart = tick()
                        while tick() - stickStart < 3 do
                            if not v or not v.Parent then break end
                            fireproximityprompt(proxPrompt, 0, true)
                            wait(0.1)
                            updateItems()
                            if (items[itemName] or 0) > originalCount then
                                break
                            end
                        end
                    else
                        wait(0.3)
                    end
                else
                    travelTo(itemPart)
                    wait(0.3)
                end
                
                checkAndSellMax()
                
                updateItems()
                if (items[itemName] or 0) <= originalCount then
                    for i = 1, 3 do
                        fireproximityprompt(proxPrompt, 0, true)
                        wait(0.1)
                    end
                end
                
                wait(0.2)
                checkAndSellMax()
                
                updateItems()
                local itemCollected = (items[itemName] or 0) > originalCount
                
                if itemCollected or not v or not v.Parent then
                    travelToInstant(safePlacePosition)
                    wait(0.6)
                    
                    v = findLuckyArrow() or findNearestItem(selectedFarmItems)
                    wait(0.6)
                else
                    wait(0.3)
                end
            end
            
            wait(0.5)
        end
    end
end
local function afkFarm()
while afkFarmOn do
if not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
wait(1)
            continue
end
local roaming = true
while roaming and afkFarmOn do
if not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
break
end
local foundItem = false
local v = findLuckyArrow() or findNearestItem(selectedFarmItems)
if v then
    foundItem = true
    roaming = false
    local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
    local proxPrompt = v:FindFirstChild("ProximityPrompt")
    
    local originalMethod = getgenv().InstantMethod
    if travelMethod == "Instant" and getgenv().InstantMethod == "Down" then
        getgenv().InstantMethod = "Up"
        cleanupItemStick()
    end
    
     if instantPickup then
        instantTravelTo(itemPart)
        wait(1)
        checkAndSellMax()
        fireproximityprompt(proxPrompt, 0, true)
    else
        travelTo(itemPart)
        wait(0.2)
        local hrp = player.Character.HumanoidRootPart
        if (itemPart.Position - hrp.Position).Magnitude < 5 then
            checkAndSellMax()
            fireproximityprompt(proxPrompt, 4)
            wait(0.1)
            if v:IsDescendantOf(game.Workspace) then
                fireproximityprompt(proxPrompt, 4)
            end
        end
    end
    
    if originalMethod == "Down" then
        getgenv().InstantMethod = "Down"
    end
    
    checkAndSellMax()
    roaming = true
end
if not foundItem then
    local hrp = player.Character.HumanoidRootPart
    local currentPos = hrp.Position
    local upPos = Vector3.new(currentPos.X, 100, currentPos.Z)
    travelTo(upPos)
    roamToRandom()
end
wait(0.25)
end
end
end
local function startFarming(method)
    if method == "Normal" then
        normalFarmOn = true
        normalCoroutine = coroutine.wrap(normalFarm)()
    elseif method == "AFK Farming" then
        afkFarmOn = true
        afkCoroutine = coroutine.wrap(afkFarm)()
    elseif method == "Safe Place" then
        safePlaceFarmOn = true
        safePlaceCoroutine = coroutine.wrap(safePlaceFarm)()
    end
    enableNoclip()
end
local function stopFarming()
    normalFarmOn = false
    afkFarmOn = false
    safePlaceFarmOn = false
    disableNoclip()
end
player.CharacterAdded:Connect(function(char)
    if normalFarmOn or afkFarmOn or safePlaceFarmOn then
        wait(2)
        enableNoclip()
        if normalFarmOn then
            if normalCoroutine then coroutine.close(normalCoroutine) end
            normalCoroutine = coroutine.wrap(normalFarm)()
        elseif afkFarmOn then
            if afkCoroutine then coroutine.close(afkCoroutine) end
            afkCoroutine = coroutine.wrap(afkFarm)()
        elseif safePlaceFarmOn then
            if safePlaceCoroutine then coroutine.close(safePlaceCoroutine) end
            safePlaceCoroutine = coroutine.wrap(safePlaceFarm)()
        end
    end
end)
local itemESP = false
local espConnection
local function addItemESP(v)
local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
local prox = v:FindFirstChild("ProximityPrompt")
if itemPart and prox and itemPart.Transparency < 1 then
local itemName = prox.ObjectText or "Unknown Item"
if not v:FindFirstChild("ItemESP") then
local hl = Instance.new("Highlight")
            hl.Name = "ItemESP"
            hl.FillTransparency = 0.7
            hl.FillColor = Color3.fromRGB(0, 255, 0)
            hl.OutlineTransparency = 0
            hl.OutlineColor = Color3.fromRGB(255, 0, 0)
            hl.Adornee = v
            hl.Parent = v
end
if not v:FindFirstChild("ItemESPName") then
local bb = Instance.new("BillboardGui")
            bb.Name = "ItemESPName"
            bb.Adornee = itemPart
            bb.Size = UDim2.new(0, 200, 0, 50)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = v
local tl = Instance.new("TextLabel")
            tl.Size = UDim2.new(1, 0, 1, 0)
            tl.BackgroundTransparency = 1
            tl.Text = itemName
            tl.TextColor3 = Color3.fromRGB(255, 255, 255)
            tl.TextSize = 24
            tl.TextStrokeTransparency = 0.5
            tl.Font = Enum.Font.SourceSansBold
            tl.Parent = bb
end
end
end
local function enableItemESP()
for _, v in pairs(game.Workspace.Item_Spawns.Items:GetChildren()) do
        addItemESP(v)
end
    espConnection = game.Workspace.Item_Spawns.Items.ChildAdded:Connect(function(v)
wait(0.1)
        addItemESP(v)
end)
end
local function disableItemESP()
for _, v in pairs(game.Workspace.Item_Spawns.Items:GetChildren()) do
local hl = v:FindFirstChild("ItemESP")
if hl then
            hl:Destroy()
end
local bb = v:FindFirstChild("ItemESPName")
if bb then
            bb:Destroy()
end
end
if espConnection then
        espConnection:Disconnect()
end
end
local playerESP = false
local playerESPConnections = {}
local function addPlayerESP(plr)
if plr == player then return end
if not plr.Character then return end
local char = plr.Character
local hl = Instance.new("Highlight")
    hl.Name = "PlayerESP"
    hl.FillTransparency = 0.7
    hl.FillColor = Color3.fromRGB(255, 0, 0)
    hl.OutlineTransparency = 0
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.Adornee = char
    hl.Parent = char
local bb = Instance.new("BillboardGui")
    bb.Name = "PlayerESPName"
    bb.Adornee = char:FindFirstChild("Head")
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.Parent = char
local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundTransparency = 1
    tl.Text = plr.Name
    tl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tl.TextSize = 24
    tl.TextStrokeTransparency = 0.5
    tl.Font = Enum.Font.SourceSansBold
    tl.Parent = bb
local conn = plr.CharacterAdded:Connect(function(newChar)
        hl.Adornee = newChar
        bb.Adornee = newChar:WaitForChild("Head")
end)
    table.insert(playerESPConnections, conn)
end
local function enablePlayerESP()
for _, plr in pairs(game.Players:GetPlayers()) do
        addPlayerESP(plr)
end
local addedConn = game.Players.PlayerAdded:Connect(function(plr)
        addPlayerESP(plr)
end)
    table.insert(playerESPConnections, addedConn)
end
local function disablePlayerESP()
for _, plr in pairs(game.Players:GetPlayers()) do
if plr.Character then
local hl = plr.Character:FindFirstChild("PlayerESP")
if hl then
                hl:Destroy()
end
local bb = plr.Character:FindFirstChild("PlayerESPName")
if bb then
                bb:Destroy()
end
end
end
for _, conn in pairs(playerESPConnections) do
        conn:Disconnect()
end
    playerESPConnections = {}
end
local itemNotifier = false
local notifierConnection
local function enableItemNotifier()
    notifierConnection = game.Workspace.Item_Spawns.Items.ChildAdded:Connect(function(v)
wait(0.1)
local prox = v:FindFirstChild("ProximityPrompt")
if prox then
local itemName = prox.ObjectText or "Unknown Item"
            notify("YBA Script", itemName .. " has spawned!")
end
end)
end
local function disableItemNotifier()
if notifierConnection then
        notifierConnection:Disconnect()
end
end
local instantPickup = false
local instantPickupConnection = nil
local defaultHoldDuration = 0.5
local function getItemContainer()
local spawns = workspace:FindFirstChild("Item_Spawns")
if not spawns then return nil end
return spawns:FindFirstChild("Items")
end
local function setPromptsInstant(instant)
local container = getItemContainer()
if not container then return end
for _, v in pairs(container:GetChildren()) do
local prox = v:FindFirstChild("ProximityPrompt")
if prox then
pcall(function() prox.HoldDuration = instant and 0 or defaultHoldDuration end)
end
end
end
local function enableInstantPickup()
    instantPickup = true
    setPromptsInstant(true)
local container = getItemContainer()
if container then
        instantPickupConnection = container.ChildAdded:Connect(function(v)
wait(0.05)
local prox = v:FindFirstChild("ProximityPrompt")
local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
if prox and part.Transparency < 1 then
pcall(function() prox.HoldDuration = 0 end)
pcall(function() fireproximityprompt(prox, 0) end)
end
end)
end
end
local function disableInstantPickup()
    instantPickup = false
    setPromptsInstant(false)
if instantPickupConnection then
        instantPickupConnection:Disconnect()
        instantPickupConnection = nil
end
end
local function instantTravelTo(target, waitTime)
    if not player.Character or not player.Character.HumanoidRootPart then return end
    local hrp = player.Character.HumanoidRootPart
    local targetPos = typeof(target) == "Vector3" and target or target.Position
    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 0.10, 0))
    
    if waitTime then
        wait(waitTime)
    end
end
local afkCameraOn = false
local originalCameraType = nil
local cameraConnection = nil
local cancelGui = nil
local function enableAFKCamera()
if not (normalFarmOn or afkFarmOn) then
        WindUI:Popup({
                Title = "Warning",
                Icon = "bird",
                Content = "Afk camera only works when farming is enabled",
                Buttons = {
                    {
                        Title = "Ok",
                        Icon = "cat",
                    }
                }
            })
        afkCameraToggle:Set(false)
return
end
    originalCameraType = workspace.CurrentCamera.CameraType
workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    cameraConnection = RunService.RenderStepped:Connect(function()
if player.Character and player.Character:FindFirstChild("Head") then
local head = player.Character.Head
local time = tick()
local radius = 10
local height = 15
local angle = time * 0.5
local offset = Vector3.new(math.sin(angle) * radius, height, math.cos(angle) * radius)
local camPos = head.Position + offset
local lookAt = head.Position
workspace.CurrentCamera.CFrame = CFrame.new(camPos, lookAt)
end
end)
    cancelGui = Instance.new("ScreenGui")
    cancelGui.Name = "CancelAFK"
    cancelGui.Parent = player.PlayerGui
    cancelGui.ResetOnSpawn = false
local cancelButton = Instance.new("TextButton")
    cancelButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    cancelButton.BorderSizePixel = 0
    cancelButton.Position = UDim2.new(0.5, -100, 0.9, -50)
    cancelButton.Size = UDim2.new(0, 200, 0, 50)
    cancelButton.Font = Enum.Font.SourceSansBold
    cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelButton.TextSize = 24
    cancelButton.Text = "Cancel AFK Camera"
    cancelButton.Parent = cancelGui
    cancelButton.MouseButton1Click:Connect(function()
        afkCameraToggle:Set(false)
end)
local uicorner = Instance.new("UICorner")
    uicorner.Parent = cancelButton
end
local function disableAFKCamera()
if originalCameraType then
workspace.CurrentCamera.CameraType = originalCameraType
end
if cameraConnection then
        cameraConnection:Disconnect()
end
if cancelGui then
        cancelGui:Destroy()
end
end
player.CharacterAdded:Connect(function(char)
if afkCameraOn then
wait(1)
end
end)
local farmMethod = "Normal"
FarmingTab:Dropdown({
    Flag = "FarmMethod",
    Title = "Farm Method",
    Values = {"Normal", "AFK Farming", "Safe Place"},
    Value = "Normal",
    Callback = function(option)
        farmMethod = option
    end
})
FarmingTab:Dropdown({
    Flag = "FarmItem",
    Title = "Select Item to Farm",
    SearchBarEnabled = true,
    Values = itemOptions,
    AllowNone = true,
    Multi = true,
    Callback = function(selected)
        selectedFarmItems = selected
end
})
FarmingTab:Dropdown({
    Flag = "TravelMethod",
    Title = "Travel Method",
    Values = {"Stud", "Tween", "Instant"},
    Value = "Stud",
    Callback = function(option)
        travelMethod = option
    end
})
local tpToItemsToggle = FarmingTab:Toggle({
    Flag = "TpToItems",
    Title = "Enable Farming",
    Default = false,
    Callback = function(value)
local method = farmMethod
        if value then
            notify("YBA Script", method .. " enabled.")
            startFarming(method)
            if not game.Workspace:FindFirstChild("WhitePad") then
                local pad = Instance.new("Part")
                pad.Size = Vector3.new(10000, 1, 10000)
                pad.Position = Vector3.new(-139.164612, 60.740036, -372.339508)
                pad.Anchored = true
                pad.CanCollide = true
                pad.Color = Color3.fromRGB(255, 255, 255)
                pad.Transparency = 0.95
                pad.Name = "WhitePad"
                pad.Parent = game.Workspace
                if not game.Workspace:FindFirstChild("UnderwhitePad") then
                local pad = Instance.new("Part")
                pad.Size = Vector3.new(10000, 1, 10000)
                pad.Position = Vector3.new(0, -45, 0)
                pad.Anchored = true
                pad.Color = Color3.fromRGB(255, 255, 255)
                pad.Transparency = 0.5
                pad.Name = "UnderwhitePad"
                pad.Parent = game.Workspace
            end
            end
        else
            notify("YBA Script", "Farming disabled.")
            stopFarming()
            local pad = game.Workspace:FindFirstChild("WhitePad")
            if pad then
                pad:Destroy()
                local underPad = game.Workspace:FindFirstChild("UnderwhitePad")
            if underPad then
                underPad:Destroy()
            end
            end
        end
    end
})
FarmingTab:Space()
FarmingTab:Section({
    Title = "Gamble",
})
local gambleOn = false
local lastGambleTime = 0
local gambleToggle = FarmingTab:Toggle({
    Flag = "Gamble",
    Title = "Enable",
    Default = false,
    Callback = function(value)
        gambleOn = value
        if value then
            notify("YBA Script", "Auto Gamble enabled.")
        else
            notify("YBA Script", "Auto Gamble disabled.")
        end
    end
})
spawn(function()
    while true do
        wait(0.5)
        if gambleOn then
            pcall(function()
                local hasGold = false
                local goldItem = player.Backpack:FindFirstChild("Gold Coin") or (player.Character and player.Character:FindFirstChild("Gold Coin"))
                if goldItem then
                    hasGold = true
                    if goldItem.Parent == player.Backpack then
                        goldItem.Parent = player.Character
                    end
                end
                local money = player.PlayerStats.Money.Value
                if hasGold and money >= 750 then
                    local remote = player.Character:FindFirstChild("RemoteEvent")
                    if remote then
                        remote:FireServer("DialogueInteracted", {
                            ["DialogueName"] = "Item Machine",
                            ["Speaker"] = "Item Machine"
                        })
                        remote:FireServer("EndDialogue", {
                            ["NPC"] = "Item Machine",
                            ["Option"] = "Option1",
                            ["Dialogue"] = "Dialogue1"
                        })
                        lastGambleTime = tick()
                    end
                    wait(3)
                end
            end)
        end
    end
end)
local autoSellMaxToggle = SellingTab:Toggle({
    Flag = "AutoSellMax",
    Title = "Auto Sell on Max",
    Default = false,
    Callback = function(value)
        autoSellMax = value
if autoSellMax then
            notify("YBA Script", "Auto Sell on Max enabled.")
            checkAndSellMax()
else
            notify("YBA Script", "Auto Sell on Max disabled.")
end
end
})
SellingTab:Space()
SellingTab:Dropdown({
    Flag = "AutoSellItems",
    Title = "Auto Sell Items (on Pickup)",
    SearchBarEnabled = true,
    Values = itemOptions,
    AllowNone = true,
    Multi = true,
    Callback = function(selected)
        selectedAutoSellItems = selected
end
})
local autoSellSelectedToggle = SellingTab:Toggle({
    Flag = "AutoSellSelected",
    Title = "Auto Sell Selected on Pickup",
    Default = false,
    Callback = function(value)
        autoSellSelected = value
if autoSellSelected then
            notify("YBA Script", "Auto Sell Selected enabled.")
else
            notify("YBA Script", "Auto Sell Selected disabled.")
end
end
})
SellingTab:Space()
SellingTab:Dropdown({
    Flag = "SellAllItems",
    Title = "Select Items to Sell All Now",
    SearchBarEnabled = true,
    Values = itemOptions,
    AllowNone = true,
    Multi = true,
    Callback = function(selected)
        selectedSellAllItems = selected
end
})
SellingTab:Button({
    Title = "Sell All Selected Now",
    Callback = function()
        sellAllSelected(selectedSellAllItems)
end
})
local autoSellAllSelectedLoop = false
local autoSellInterval = 3

SellingTab:Slider({
    Flag = "AutoSellInterval",
    Title = "Auto Sell Interval minutes",
    Step = 1,
    Value = {
        Min = 1,
        Max = 10,
        Default = 3
    },
    Callback = function(value)
        autoSellInterval = value
    end
})

SellingTab:Toggle({
    Flag = "AutoSellAllSelectedLoop",
    Title = "Auto Sell All Selected Loop",
    Default = false,
    Callback = function(value)
        autoSellAllSelectedLoop = value
        if value then
            notify("YBA Script", "Auto Sell enabled: Every " .. autoSellInterval .. " minute(s)")
            spawn(function()
                while autoSellAllSelectedLoop do
                    wait(autoSellInterval * 60)
                    if autoSellAllSelectedLoop and #selectedSellAllItems > 0 then
                        sellAllSelected(selectedSellAllItems)
                    end
                end
            end)
        else
            notify("YBA Script", "Auto Sell All Selected disabled.")
        end
    end
})
SellingTab:Space()
SellingTab:Button({
    Title = "Sell All Worthless Items",
    Callback = function()
        sellAllWorthless()
end
})
SellingTab:Space()
SellingTab:Button({
    Title = "Sell Inventory",
    Callback = function()
        sellInventory()
end
})
local itemESPToggle = VisualTab:Toggle({
    Flag = "ItemESP",
    Title = "Item ESP",
    Default = false,
    Callback = function(value)
        itemESP = value
if itemESP then
            notify("YBA Script", "Item ESP enabled.")
            enableItemESP()
else
            notify("YBA Script", "Item ESP disabled.")
            disableItemESP()
end
end
})
VisualTab:Space()
local playerESPToggle = VisualTab:Toggle({
    Flag = "PlayerESP",
    Title = "Player ESP",
    Default = false,
    Callback = function(value)
        playerESP = value
if playerESP then
            notify("YBA Script", "Player ESP enabled.")
            enablePlayerESP()
else
            notify("YBA Script", "Player ESP disabled.")
            disablePlayerESP()
end
end
})
VisualTab:Space()

getgenv().playerInfoESP = false
getgenv().playerInfoESPConnections = {}

VisualTab:Toggle({
    Flag = "PlayerInfoESP",
    Title = "ESP Players Info",
    Default = false,
    Callback = function(value)
        getgenv().playerInfoESP = value
        
        for _, conn in pairs(getgenv().playerInfoESPConnections or {}) do
            pcall(function() conn:Disconnect() end)
        end
        getgenv().playerInfoESPConnections = {}

        local function getPlayerStand(plr)
            if not plr:FindFirstChild("PlayerStats") then return "None" end
            if not plr.PlayerStats:FindFirstChild("Stand") then return "None" end
            return plr.PlayerStats.Stand.Value or "None"
        end

        local function getPlayerRace(plr)
            if not plr:FindFirstChild("PlayerStats") then return "Human" end
            if not plr.PlayerStats:FindFirstChild("Race") then return "Human" end
            return plr.PlayerStats.Race.Value or "Human"
        end

        local function createESPForPlayer(plr)
            if plr == player then return end
            if not plr.Character then return end
            
            local char = plr.Character
            local head = char:FindFirstChild("Head")
            if not head then return end
            
            local existing = head:FindFirstChild("PlayerInfoESP")
            if existing then existing:Destroy() end
            
            local bb = Instance.new("BillboardGui")
            bb.Name = "PlayerInfoESP"
            bb.Adornee = head
            bb.Size = UDim2.new(0, 200, 0, 50)
            bb.StudsOffset = Vector3.new(0, 4.5, 0)
            bb.AlwaysOnTop = true
            bb.Parent = head
            
            local tl = Instance.new("TextLabel")
            tl.Name = "StandLabel"
            tl.Size = UDim2.new(1, 0, 0.5, 0)
            tl.Position = UDim2.new(0, 0, 0, 0)
            tl.BackgroundTransparency = 1
            tl.Text = "Stand: " .. getPlayerStand(plr)
            tl.TextColor3 = Color3.fromRGB(255, 215, 0)
            tl.TextSize = 14
            tl.TextStrokeTransparency = 0.5
            tl.Font = Enum.Font.SourceSansBold
            tl.Parent = bb
            
            local tl2 = Instance.new("TextLabel")
            tl2.Name = "RaceLabel"
            tl2.Size = UDim2.new(1, 0, 0.5, 0)
            tl2.Position = UDim2.new(0, 0, 0.5, 0)
            tl2.BackgroundTransparency = 1
            tl2.Text = "Race: " .. getPlayerRace(plr)
            tl2.TextColor3 = Color3.fromRGB(0, 255, 255)
            tl2.TextSize = 14
            tl2.TextStrokeTransparency = 0.5
            tl2.Font = Enum.Font.SourceSansBold
            tl2.Parent = bb
            
            local conn = game:GetService("RunService").Heartbeat:Connect(function()
                if not plr or not plr.Parent then return end
                if not bb or not bb.Parent then return end
                
                if tl and tl.Parent then tl.Text = "Stand: " .. getPlayerStand(plr) end
                if tl2 and tl2.Parent then tl2.Text = "Race: " .. getPlayerRace(plr) end
            end)
            
            table.insert(getgenv().playerInfoESPConnections, conn)
        end

        if getgenv().playerInfoESP then
            notify("YBA Script", "Player Info ESP enabled - Showing Stand & Race!")
            
            for _, plr in pairs(game.Players:GetPlayers()) do
                createESPForPlayer(plr)
            end
            
            local addedConn = game.Players.PlayerAdded:Connect(function(plr)
                task.wait(1.5)
                if getgenv().playerInfoESP then
                    createESPForPlayer(plr)
                    
                    local charConn = plr.CharacterAdded:Connect(function(newChar)
                        task.wait(0.8)
                        if getgenv().playerInfoESP then
                            createESPForPlayer(plr)
                        end
                    end)
                    table.insert(getgenv().playerInfoESPConnections, charConn)
                end
            end)
            table.insert(getgenv().playerInfoESPConnections, addedConn)
            
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player then
                    local charConn = plr.CharacterAdded:Connect(function(newChar)
                        task.wait(0.8)
                        if getgenv().playerInfoESP then
                            createESPForPlayer(plr)
                        end
                    end)
                    table.insert(getgenv().playerInfoESPConnections, charConn)
                end
            end
            
        else
            notify("YBA Script", "Player Info ESP disabled.")
            
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("Head") then
                    local bb = plr.Character.Head:FindFirstChild("PlayerInfoESP")
                    if bb then bb:Destroy() end
                end
            end
        end
    end
})
VisualTab:Space()
local itemNotifierToggle = VisualTab:Toggle({
    Flag = "ItemNotifier",
    Title = "Item Spawn Notifier",
    Default = false,
    Callback = function(value)
        itemNotifier = value
if itemNotifier then
            notify("YBA Script", "Item Spawn Notifier enabled.")
            enableItemNotifier()
else
            notify("YBA Script", "Item Spawn Notifier disabled.")
            disableItemNotifier()
end
end
})
AdjustTab:Section({
    Title = "Stud"
})
AdjustTab:Slider({
    Title = "Stud Speed Adjustment (%)",
    Step = 1,
    Value = {
        Min = 0,
        Max = 200,
        Default = 100
    },
    Callback = function(value)
        studMultiplier = value / 100
    end
})
AdjustTab:Section({
    Title = "Tween"
})
AdjustTab:Slider({
    Title = "Tween Speed Adjustment (%)",
    Step = 1,
    Value = {
        Min = 0,
        Max = 200,
        Default = 100
    },
    Callback = function(value)
        tweenMultiplier = value / 100
    end
})
AdjustTab:Section({
    Title = "Tp Delay"
})
AdjustTab:Slider({
    Flag = "TpDelaySlider",
    Title = "Tp Delay (seconds)",
    Step = 0.01,
    Value = {
        Min = 0,
        Max = 1,
        Default = 0.05
    },
    Callback = function(value)
        tpDelay = value
    end
})
AdjustTab:Space()
AdjustTab:Section({
    Title = "Instant Method"
})

getgenv().InstantMethod = "Up"

AdjustTab:Dropdown({
    Flag = "ModifyInstantMethod",
    Title = "Modify Instant Method",
    Values = {"Up", "Down"},
    Value = "Up",
    Callback = function(selected)
        getgenv().InstantMethod = selected
        notify("YBA Script", "Instant method set to: " .. selected)
    end
})
AdjustTab:Space()
AdjustTab:Section({
    Title = "Safe Place Collection Mode"
})

getgenv().SafePlaceCollectionMode = "Back & Forth"

AdjustTab:Dropdown({
    Flag = "SafePlaceCollectionMode",
    Title = "Collection Mode",
    Values = {"Back & Forth", "Batch Collect"},
    Value = "Back & Forth",
    Callback = function(selected)
        getgenv().SafePlaceCollectionMode = selected
        if selected == "Batch Collect" then
            notify("YBA Script", "Batch Collect mode enabled! Will collect ALL items then return to safe place.")
        else
            notify("YBA Script", "Back & Forth mode enabled! Will return to safe place after each item.")
        end
    end
})
AdjustTab:Space()
AdjustTab:Section({
    Title = "Safe Place Position"
})

AdjustTab:Input({
    Flag = "SafePlaceCoordsInput",
    Title = "Enter Coordinates (X, Y, Z)",
    Placeholder = "e.g., 47.261887, -33.486183, 90.047981",
    Callback = function(value)
        if value and value ~= "" then
            local x, y, z = value:match("([-%d%.]+)%s*,%s*([-%d%.]+)%s*,%s*([-%d%.]+)")
            if x and y and z then
                safePlacePosition = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
                notify("YBA Script", "Coordinates updated to: " .. tostring(safePlacePosition))
            else
                notify("YBA Script", "Invalid format! Use: X, Y, Z")
            end
        end
    end
})

AdjustTab:Button({
    Title = "Update Coords (Current Position)",
    Callback = function()
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local pos = hrp.Position
            safePlacePosition = Vector3.new(pos.X, pos.Y, pos.Z)
            notify("YBA Script", "Set to current position: " .. string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z))
        else
            notify("YBA Script", "Character not loaded!")
        end
    end
})

AdjustTab:Dropdown({
    Flag = "CoordinatesSaver",
    Title = "Coordinates Saver",
    Values = {"Default", "New"},
    Value = "New",
    Callback = function(selected)
        if selected == "Default" then
            safePlacePosition = defaultSafePlacePosition
            notify("YBA Script", "Loaded Default coordinates")
        elseif selected == "New" then
            safePlacePosition = newSafePlacePosition
            notify("YBA Script", "Loaded New coordinates")
        end
    end
})

AdjustTab:Button({
    Title = "Save Coordinates",
    Callback = function()
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local pos = hrp.Position
            notify("YBA Script", "Current position: " .. string.format("%.6f, %.6f, %.6f", pos.X, pos.Y, pos.Z) .. " (Copy this to input above)")
        else
            notify("YBA Script", "Character not loaded!")
        end
    end
})

AdjustTab:Paragraph({
    Title = "Current Safe Place",
    Desc = "Check notifications for current coordinates when you click Save Coordinates",
    TextSize = 14
})
local antiAFKToggle = MiscTab:Toggle({
    Flag = "AntiAFK",
    Title = "Anti-AFK",
    Default = false,
    Callback = function(value)
if value then
            notify("YBA Script", "Anti-AFK enabled.")
spawn(function()
while value do
wait(300)
local vu = game:GetService("VirtualUser")
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new())
end
end)
else
            notify("YBA Script", "Anti-AFK disabled.")
end
end
})
MiscTab:Section({ Title = "FPS Booster" })

local fpsBoosterRunning = false
local fpsConnection = nil
local savedProperties = {}
local bloodConnections = {}

MiscTab:Toggle({
    Flag = "FPSBooster",
    Title = "Enable FPS Booster",
    Default = false,
    Callback = function(value)
        fpsBoosterRunning = value
        
        if value then
            local s, e = pcall(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local Lighting = game:GetService("Lighting")
                local Workspace = game:GetService("Workspace")
                local Debris = game:GetService("Debris")
                local localPlayer = Players.LocalPlayer
                
                savedProperties = {}
                bloodConnections = {}

                local function saveProp(inst, prop)
                    if not inst or not prop then return end
                    if not savedProperties[inst] then savedProperties[inst] = {} end
                    if savedProperties[inst][prop] == nil then
                        local ok, val = pcall(function() return inst[prop] end)
                        if ok then savedProperties[inst][prop] = val end
                    end
                end

                local function isBloodEffect(inst)
                    if not inst then return false end
                    local name = inst.Name:lower()
                    
                    if name:find("blood") or name:find("bleed") or name:find("wound") or 
                       name:find("gore") or name:find("splatter") or name:find("stain") or
                       name:find("hit") or name:find("impact") or name:find("damage") or
                       name:find("punch") or name:find("slash") or name:find("cut") then
                        return true
                    end
                    
                    if inst.Parent then
                        local parentName = inst.Parent.Name:lower()
                        if parentName:find("blood") or parentName:find("bleed") or 
                           parentName:find("wound") or parentName:find("gore") or
                           parentName:find("hitfx") or parentName:find("damagefx") or
                           parentName:find("combat") or parentName:find("fight") then
                            return true
                        end
                    end
                    
                    if inst:IsA("ParticleEmitter") then
                        local color = inst.Color
                        if color then
                            local keypoints = color.Keypoints
                            if keypoints and #keypoints > 0 then
                                local firstColor = keypoints[1].Value
                                if firstColor.R > 0.5 and firstColor.G < 0.3 and firstColor.B < 0.3 then
                                    return true
                                end
                            end
                        end
                    end
                    
                    return false
                end

                local function neutralize(inst, forceDestroy)
                    if not inst or not inst.Parent then return end
                    
                    if localPlayer.Character and inst:IsDescendantOf(localPlayer.Character) then
                        local isEffect = inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Beam") or 
                                        inst:IsA("Fire") or inst:IsA("Smoke") or inst:IsA("Sparkles") or
                                        inst:IsA("Decal") or inst:IsA("Texture") or inst:IsA("BillboardGui")
                        if not isEffect then return end
                    end
                    
                    local blood = isBloodEffect(inst)
                    
                    if inst:IsA("ParticleEmitter") then
                        saveProp(inst, "Enabled")
                        saveProp(inst, "Rate")
                        saveProp(inst, "Lifetime")
                        pcall(function() 
                            inst.Enabled = false
                            inst.Rate = 0
                            inst.Lifetime = NumberRange.new(0)
                        end)
                        if blood and forceDestroy then
                            pcall(function() inst:Destroy() end)
                        end
                    elseif inst:IsA("Trail") or inst:IsA("Beam") then
                        saveProp(inst, "Enabled")
                        pcall(function() inst.Enabled = false end)
                        if blood and forceDestroy then
                            pcall(function() inst:Destroy() end)
                        end
                    elseif inst:IsA("Fire") or inst:IsA("Smoke") or inst:IsA("Sparkles") then
                        saveProp(inst, "Enabled")
                        pcall(function() inst.Enabled = false end)
                    elseif inst:IsA("PointLight") or inst:IsA("SurfaceLight") or inst:IsA("SpotLight") then
                        saveProp(inst, "Enabled")
                        pcall(function() inst.Enabled = false end)
                    elseif inst:IsA("Decal") or inst:IsA("Texture") then
                        if blood then
                            saveProp(inst, "Transparency")
                            pcall(function() inst.Transparency = 1 end)
                        end
                    elseif inst:IsA("BasePart") and blood then
                        saveProp(inst, "Transparency")
                        saveProp(inst, "CanCollide")
                        pcall(function() 
                            inst.Transparency = 1
                            inst.CanCollide = false
                        end)
                        
                        for _, child in ipairs(inst:GetDescendants()) do
                            if child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Beam") or
                               child:IsA("Decal") or child:IsA("Texture") then
                                pcall(function() child:Destroy() end)
                            end
                        end
                    elseif inst:IsA("BillboardGui") or inst:IsA("SurfaceGui") then
                        if blood then
                            saveProp(inst, "Enabled")
                            pcall(function() inst.Enabled = false end)
                        end
                    end
                end

                local function destroyBlood()
                    for _, inst in ipairs(Workspace:GetDescendants()) do
                        if isBloodEffect(inst) then
                            pcall(function()
                                if inst:IsA("BasePart") then
                                    saveProp(inst, "CFrame")
                                    inst.CFrame = CFrame.new(0, -10000, 0)
                                end
                                neutralize(inst, true)
                            end)
                        end
                    end
                end

                for _, child in ipairs(Lighting:GetChildren()) do
                    if child:IsA("PostEffect") or child:IsA("Sky") or child:IsA("Atmosphere") then
                        saveProp(child, "Enabled")
                        pcall(function() child.Enabled = false end)
                    end
                end

                saveProp(Lighting, "GlobalShadows")
                saveProp(Lighting, "Brightness")
                saveProp(Lighting, "FogEnd")
                pcall(function() Lighting.GlobalShadows = false end)
                pcall(function() Lighting.Brightness = 1 end)
                pcall(function() Lighting.FogEnd = 9e9 end)

                for _, inst in ipairs(Workspace:GetDescendants()) do
                    pcall(function() neutralize(inst) end)
                end
                
                destroyBlood()

                fpsConnection = Workspace.DescendantAdded:Connect(function(inst)
                    task.wait(0.01)
                    pcall(function() 
                        neutralize(inst)
                        if isBloodEffect(inst) then
                            neutralize(inst, true)
                        end
                    end)
                end)
                
                local bloodConn = Workspace.DescendantAdded:Connect(function(inst)
                    task.wait(0.05)
                    pcall(function()
                        if isBloodEffect(inst) then
                            if inst:IsA("BasePart") then
                                inst.CFrame = CFrame.new(0, -10000, 0)
                            end
                            neutralize(inst, true)
                        end
                    end)
                end)
                table.insert(bloodConnections, bloodConn)
                
                local debrisConn = Debris.ItemAdded:Connect(function(item)
                    pcall(function()
                        if isBloodEffect(item) then
                            item:Destroy()
                        end
                    end)
                end)
                table.insert(bloodConnections, debrisConn)
            end)
            
            if s then
                notify("YBA Script", "FPS Booster enabled! Blood effects targeted.")
            else
                notify("YBA Script", "Error: " .. tostring(e))
            end
            
        else
            local s, e = pcall(function()
                if fpsConnection then
                    fpsConnection:Disconnect()
                    fpsConnection = nil
                end
                
                for _, conn in ipairs(bloodConnections) do
                    pcall(function() conn:Disconnect() end)
                end
                bloodConnections = {}
                
                for inst, props in pairs(savedProperties) do
                    if inst and inst.Parent then
                        for prop, val in pairs(props) do
                            pcall(function() inst[prop] = val end)
                        end
                    end
                end
                
                savedProperties = {}
            end)
            
            if s then
                notify("YBA Script", "FPS Booster disabled! Effects restored.")
            else
                notify("YBA Script", "Restore error: " .. tostring(e))
            end
        end
    end
})

MiscTab:Space()
local selectedSoundItems = {}
MiscTab:Dropdown({
    Flag = "SoundItem",
    Title = "Select Item for Sound",
    Values = itemOptions,
    AllowNone = true,
    Multi = true,
    Callback = function(selected)
        selectedSoundItems = selected
    end
})
local soundNotifier = false
local soundNotifierConnection
local function enableSoundNotifier()
    soundNotifierConnection = game.Workspace.Item_Spawns.Items.ChildAdded:Connect(function(v)
        wait(0.1)
        local prox = v:FindFirstChild("ProximityPrompt")
        if prox and table.find(selectedSoundItems, prox.ObjectText) then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://4590657391"
            sound.Volume = 1
            sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            sound:Play()
            sound.Ended:Connect(function()
                sound:Destroy()
            end)
        end
    end)
end
local function disableSoundNotifier()
    if soundNotifierConnection then
        soundNotifierConnection:Disconnect()
    end
end
local soundNotifierToggle = MiscTab:Toggle({
    Flag = "SoundNotifier",
    Title = "Sound Notifier",
    Default = false,
    Callback = function(value)
        soundNotifier = value
        if value then
            notify("YBA Script", "Sound Notifier enabled for selected items")
            enableSoundNotifier()
        else
            notify("YBA Script", "Sound Notifier disabled.")
            disableSoundNotifier()
        end
    end
})
MiscTab:Space()
MiscTab:Button({
    Title = "Open Jesus Dialogue",
    Callback = function()
        local remote = player.Character and player.Character:FindFirstChild("RemoteEvent")
        if remote then
            remote:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue.Jesus)
            notify("YBA Script", "Opened Jesus dialogue.")
        else
            notify("YBA Script", "RemoteEvent not found.")
        end
    end
})
MiscTab:Space()
MiscTab:Button({
    Title = "Anti Vamp Burn",
    Callback = function()
        spawn(function()
            repeat wait() until game:IsLoaded()
            local plr = game:GetService("Players").LocalPlayer;
            while wait() do pcall(function()
                if plr then
                    game:GetService("Players").LocalPlayer.PlayerStats.Race.Value = "Human"
                end
            end )
            end
        end)
        notify("YBA Script", "Anti Vamp Burn enabled.")
    end
})
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Azure = {Utils = {}}
Azure.Utils.__index = Azure.Utils
function Azure.Utils.MakeUtilController()
    local Utils = {
        Tasks = {};
        Ints = {};
        States = {};
    }
    return setmetatable(Utils, Azure.Utils)
end
function Azure.Utils:SetInt(Value, NewValue)
    if self.Ints[Value] then
        self.Ints[Value].Value = NewValue
    end
end
function Azure.Utils:GetInt(Value)
    return self.Ints[Value] and self.Ints[Value].Value or 0
end
function Azure.Utils:SetState(Value, NewValue)
    if self.States[Value] then
        self.States[Value].Value = NewValue
    end
end
function Azure.Utils:GetState(Value)
    return self.States[Value] and self.States[Value].Value or false
end
function Azure.Utils:AddTask(TaskName, Task)
    if not self.Tasks[TaskName] then
        self.Tasks[TaskName] = Task
    end
    return Task
end
function Azure.Utils:DisconnectTask(TaskName)
    if self.Tasks[TaskName] and self.Tasks[TaskName].Connected then
        self.Tasks[TaskName]:Disconnect()
        self.Tasks[TaskName] = nil
    end
end
function Azure.Utils:GetPlayer()
    return LocalPlayer
end
function Azure.Utils:GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
function Azure.Utils:GetHumanoid()
    local Character = self:GetCharacter()
    return Character and Character:FindFirstChildWhichIsA("Humanoid")
end
function Azure.Utils:GetHRP()
    local Character = self:GetCharacter()
    return Character and Character:FindFirstChild("HumanoidRootPart")
end
function Azure.Utils:GetStroke()
    local StrokeDir = 180
    local Anim = "6926086304"
  
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        StrokeDir = 90
        Anim = "6926086567"
    elseif UserInputService:IsKeyDown(Enum.KeyCode.D) then
        StrokeDir = -90
        Anim = "6926086883"
    elseif UserInputService:IsKeyDown(Enum.KeyCode.W) then
        StrokeDir = 0
        Anim = "6926086032"
    end
  
    return StrokeDir, Anim
end
local Util = Azure.Utils.MakeUtilController()
Util.Ints = {
    ["InfTick"] = {Value = tick()},
    ["InfDelay"] = {Value = 1},
    ["DashPower"] = {Value = 50}
}
Util.States = {
    ["Infinite Dash"] = {Value = false}
}
local DashAnims = Instance.new("Folder", workspace)
DashAnims.Name = "DashAnims_" .. Util:GetPlayer().UserId
MiscTab:Section({
    Title = "Infinite Dash",
})
local infiniteDashToggle = MiscTab:Toggle({
    Flag = "InfiniteDash",
    Title = "Infinite Dash",
    Default = false,
    Callback = function(State)
        Util:SetState("Infinite Dash", State)
      
        if State then
            local conn = UserInputService.InputBegan:Connect(function(Input, GameProcessed)
                if GameProcessed then return end
              
                local dashKey = Util:GetPlayer().PlayerStats.DashKey.Value
                if Input.KeyCode == Enum.KeyCode[dashKey] and (tick() - Util:GetInt("InfTick")) >= Util:GetInt("InfDelay") then
                    Util:SetInt("InfTick", tick())
                  
                    local humanoid = Util:GetHumanoid()
                    local hrp = Util:GetHRP()
                    if not humanoid or not hrp then return end
                  
                    local Dir, AnimID = Util:GetStroke()
                  
                    local anim = Instance.new("Animation")
                    anim.Name = "YBA_AntiCheat_Bypass_REAL"
                    anim.AnimationId = "rbxassetid://" .. AnimID
                    anim.Parent = DashAnims
                  
                    local track = humanoid:LoadAnimation(anim)
                    track:Play()
                  
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = (hrp.CFrame * CFrame.Angles(0, math.rad(Dir), 0)).lookVector * Util:GetInt("DashPower")
                    bv.MaxForce = Vector3.new(55555, 1000, 55555)
                    bv.Parent = hrp
                  
                    Debris:AddItem(bv, 0.25)
                end
            end)
          
            Util:AddTask("InfDash", conn)
        notify("YBA Script", "Infinite Dash: Enabled.")
        else
            Util:DisconnectTask("InfDash")
          
            for _, v in pairs(DashAnims:GetChildren()) do
                v:Destroy()
            end
          
        notify("YBA Script", "Infinite Dash: Disabled.")
        end
    end
})
MiscTab:Slider({
    Title = "Dash Power",
    Step = 1,
    Value = {Min=10, Max=1000, Default=50},
    Callback = function(Value)
        Util:SetInt("DashPower", math.clamp(Value, 10, 1000))
    end
})
MiscTab:Slider({
    Title = "Dash Delay",
    Step = 0.1,
    Value = {Min=0, Max=3.5, Default=1},
    Callback = function(Value)
        Util:SetInt("InfDelay", math.clamp(Value, 0, 3.5))
    end
})
MiscTab:Section({
    Title = "Speed",
})
MiscTab:Slider({
    Flag = "Speed",
    Title = "Speed Changer",
    Step = 1,
    Value = {
        Min = 0,
        Max = 200,
        Default = 16
    },
    Callback = function(value)
        local player = game.Players.LocalPlayer
        
        if not player.Character then return end
        
        getgenv().CustomWalkSpeed = value
        
        if getgenv().WalkspeedConnection then
            getgenv().WalkspeedConnection:Disconnect()
        end
        
        getgenv().WalkspeedConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local char = player.Character
            if not char or not char.Parent then
                return
            end
            
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum.WalkSpeed = getgenv().CustomWalkSpeed
            end
        end)
        
        if getgenv().WalkspeedCharConnection then
            getgenv().WalkspeedCharConnection:Disconnect()
        end
        
        getgenv().WalkspeedCharConnection = player.CharacterAdded:Connect(function(newChar)
            if getgenv().CustomWalkSpeed and getgenv().CustomWalkSpeed > 0 then
                local newHum = newChar:WaitForChild("Humanoid", 5)
                if newHum then
                    newHum.WalkSpeed = getgenv().CustomWalkSpeed
                end
            end
        end)
        
        local lastSpeedNotify = getgenv().LastSpeedNotify or 0
        local currentTime = tick()
        if currentTime - lastSpeedNotify >= 2 then
            getgenv().LastSpeedNotify = currentTime
            notify("YBA Script", "Walkspeed set to: " .. value)
        end
    end
})
MiscTab:Input({
    Flag = "CustomSpeedInput",
    Title = "Custom Speed Input",
    Placeholder = "Enter speed (1-5000)...",
    Callback = function(value)
        local speed = tonumber(value)
        if not speed then
            notify("YBA Script", "Invalid speed! Please enter a number.")
            return
        end
        
        speed = math.clamp(speed, 1, 5000)
        
        local player = game.Players.LocalPlayer
        if not player.Character then 
            notify("YBA Script", "Character not loaded!")
            return 
        end
        
        getgenv().CustomWalkSpeed = speed
        
        if getgenv().WalkspeedConnection then
            getgenv().WalkspeedConnection:Disconnect()
        end
        
        getgenv().WalkspeedConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local char = player.Character
            if not char or not char.Parent then
                return
            end
            
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum.WalkSpeed = getgenv().CustomWalkSpeed
            end
        end)
        
        if getgenv().WalkspeedCharConnection then
            getgenv().WalkspeedCharConnection:Disconnect()
        end
        
        getgenv().WalkspeedCharConnection = player.CharacterAdded:Connect(function(newChar)
            if getgenv().CustomWalkSpeed and getgenv().CustomWalkSpeed > 0 then
                local newHum = newChar:WaitForChild("Humanoid", 5)
                if newHum then
                    newHum.WalkSpeed = getgenv().CustomWalkSpeed
                end
            end
        end)
        
        pcall(function()
            local slider = MiscTab:FindFirstChild("Speed")
            if slider and slider.Set then
                slider:Set(math.min(speed, 200))
            end
        end)
        
        notify("YBA Script", "Custom walkspeed set to: " .. speed)
    end
})
MiscTab:Button({
    Title = "Reset Walkspeed",
    Callback = function()
        getgenv().CustomWalkSpeed = 16
        
        if getgenv().WalkspeedConnection then
            getgenv().WalkspeedConnection:Disconnect()
            getgenv().WalkspeedConnection = nil
        end
        
        local player = game.Players.LocalPlayer
        if player.Character then
            local hum = player.Character:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum.WalkSpeed = 16
            end
        end
        
        notify("YBA Script", "Walkspeed reset to default (16)")
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local BACK_DISTANCE = 2
local BACK_HEIGHT = 0.5
local PLAYER_HEIGHT = 20
local ALIGN_RESPONSIVENESS = 250
local ALIGN_MAX_FORCE = 1e7
local CHECK_SCAN_INTERVAL = 1.0
local SMOOTH_FALLBACK_ALPHA = 0.85
local scanTimer = 0
local modelCache = {}
local function isCharacterModel(m)
if not m or not m:IsA("Model") then return false end
return m:FindFirstChild("Humanoid") and m:FindFirstChild("HumanoidRootPart")
end
local function rebuildModelCache()
    modelCache = {}
for _, child in ipairs(workspace:GetChildren()) do
if isCharacterModel(child) then
            table.insert(modelCache, child)
else
for _, c2 in ipairs(child:GetChildren()) do
if isCharacterModel(c2) then table.insert(modelCache, c2) end
end
end
end
for _, pl in ipairs(Players:GetPlayers()) do
if pl ~= player and pl.Character and isCharacterModel(pl.Character) then
            table.insert(modelCache, pl.Character)
end
end
end
rebuildModelCache()
workspace.ChildAdded:Connect(function(c)
if isCharacterModel(c) then table.insert(modelCache, c) else
for _, c2 in ipairs(c:GetChildren()) do if isCharacterModel(c2) then table.insert(modelCache, c2) end end
end
end)
workspace.ChildRemoved:Connect(function(c)
for i = #modelCache, 1, -1 do if modelCache[i] == c then table.remove(modelCache, i) end end
end)
Players.PlayerAdded:Connect(function(pl)
    pl.CharacterAdded:Connect(function(ch)
if isCharacterModel(ch) then table.insert(modelCache, ch) end
end)
end)
Players.PlayerRemoving:Connect(function(pl)
if pl.Character then
for i = #modelCache, 1, -1 do if modelCache[i] == pl.Character then table.remove(modelCache, i) end end
end
end)
local function findClosestByName(name)
if not name or name == "" then return nil end
local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
if not root then return nil end
local rootPos = root.Position
local lower = name:lower()
local closest, minD = nil, math.huge
for _, pl in ipairs(Players:GetPlayers()) do
if pl ~= player and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
local match = false
if pl.Name:lower():find(lower) then match = true end
if pl.DisplayName and pl.DisplayName:lower():find(lower) then match = true end
if match then
local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
local hum = pl.Character:FindFirstChild("Humanoid")
if hrp and hum and hum.Health > 0 then
local d = (hrp.Position - rootPos).Magnitude
if d < minD then minD, closest = d, pl.Character end
end
end
end
end
for _, model in ipairs(modelCache) do
if model and model.Parent and model ~= player.Character then
if model.Name:lower():find(lower) then
local hrp = model:FindFirstChild("HumanoidRootPart")
local hum = model:FindFirstChild("Humanoid")
if hrp and hum and hum.Health > 0 then
local d = (hrp.Position - rootPos).Magnitude
if d < minD then minD, closest = d, model end
end
end
end
end
return closest
end
local function getStand()
local ch = player.Character
if not ch then return nil end
for _, child in ipairs(ch:GetChildren()) do
if child:IsA("Model") and child:FindFirstChild("HumanoidRootPart") and child ~= ch then
return child
end
end
return nil
end
local activeAligns = {}
local currentTargetForEntity = {}
local function cleanupAlignFor(entity)
if not entity then return end
local hrp = entity:FindFirstChild("HumanoidRootPart")
if hrp then
for _, c in ipairs(hrp:GetChildren()) do
if tostring(c.Name):match("^Stick_") then
                c:Destroy()
end
end
end
    activeAligns[entity] = nil
    currentTargetForEntity[entity] = nil
end
local function createAlignsFor(entity, targetHRP, stickMode)
if not entity or not targetHRP then return nil end
    cleanupAlignFor(entity)
local hrp = entity:FindFirstChild("HumanoidRootPart")
if not hrp then
        hrp = entity:FindFirstChild("Torso") or entity:FindFirstChild("UpperTorso")
end
if not hrp then
local ok
        ok, hrp = pcall(function() return entity:WaitForChild("HumanoidRootPart", 0.5) end)
if not ok then hrp = nil end
end
if not hrp then return nil end
local offset = Vector3.new(0,0,0)
if stickMode == "back" then
        offset = Vector3.new(0, BACK_HEIGHT, -BACK_DISTANCE)
end
local attA = Instance.new("Attachment")
    attA.Name = "Stick_AttA"
    attA.Parent = hrp
    attA.Position = Vector3.new(0,0,0)
local attB = Instance.new("Attachment")
    attB.Name = "Stick_AttB"
    attB.Parent = targetHRP
    attB.Position = offset
local alignPos = Instance.new("AlignPosition")
    alignPos.Name = "Stick_AlignPos"
    alignPos.Attachment0 = attA
    alignPos.Attachment1 = attB
    alignPos.MaxForce = ALIGN_MAX_FORCE
    alignPos.Responsiveness = ALIGN_RESPONSIVENESS
    alignPos.RigidityEnabled = false
    alignPos.Parent = hrp
local alignOri = Instance.new("AlignOrientation")
    alignOri.Name = "Stick_AlignOri"
    alignOri.Attachment0 = attA
    alignOri.Attachment1 = attB
    alignOri.MaxTorque = ALIGN_MAX_FORCE
    alignOri.Responsiveness = ALIGN_RESPONSIVENESS
    alignOri.Parent = hrp
    activeAligns[entity] = {attA = attA, attB = attB, alignPos = alignPos, alignOri = alignOri, stickMode = stickMode}
    currentTargetForEntity[entity] = targetHRP
if entity == player.Character then
notify("Sticker", "Player align applied (mode="..tostring(stickMode)..")")
end
return activeAligns[entity]
end
local function smoothFallback(entity, targetHRP, stickMode, isAlive)
local hrp = entity and entity:FindFirstChild("HumanoidRootPart")
if not hrp or not targetHRP then return end
local desiredPos
if stickMode == "back" then
        desiredPos = targetHRP.Position - targetHRP.CFrame.LookVector * BACK_DISTANCE + Vector3.new(0, BACK_HEIGHT, 0)
elseif stickMode == "Down" then
local height = isAlive and -PLAYER_HEIGHT or PLAYER_HEIGHT
        desiredPos = targetHRP.Position + Vector3.new(0, height, 0)
elseif stickMode == "Up" then
local height = isAlive and PLAYER_HEIGHT or -PLAYER_HEIGHT
        desiredPos = targetHRP.Position + Vector3.new(0, height, 0)
else
return
end
local look = -Vector3.new(targetHRP.CFrame.LookVector.X, 0, targetHRP.CFrame.LookVector.Z).Unit
local yaw = math.atan2(look.X, look.Z)
local desiredCFrame = CFrame.new(desiredPos) * CFrame.Angles(0, yaw, 0)
    hrp.CFrame = hrp.CFrame:Lerp(desiredCFrame, SMOOTH_FALLBACK_ALPHA)
end
local viewingPlayer = false
local viewTarget = nil
local viewConnection = nil
local prevCameraSubject = nil
local prevCameraType = nil
local focusCamValue = nil

local function enableViewPlayer(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then
        notify("View Player", "Target not found or missing HRP")
        return false
    end
    
    viewTarget = target
    viewingPlayer = true
    
    prevCameraSubject = camera.CameraSubject
    prevCameraType = camera.CameraType
    
    local character = player.Character
    if character then
        local old = character:FindFirstChild("FocusCam")
        if old then old:Destroy() end
        
        focusCamValue = Instance.new("ObjectValue")
        focusCamValue.Name = "FocusCam"
        focusCamValue.Value = target:FindFirstChild("HumanoidRootPart")
        focusCamValue.Parent = character
    end
    
    camera.CameraType = Enum.CameraType.Custom
    
    local targetHumanoid = target:FindFirstChildWhichIsA("Humanoid")
    if targetHumanoid then
        camera.CameraSubject = targetHumanoid
    end
    
    viewConnection = RunService.RenderStepped:Connect(function()
        if not viewingPlayer or not viewTarget or not viewTarget.Parent then return end
        
        local currentSubject = camera.CameraSubject
        local desiredSubject = viewTarget:FindFirstChildWhichIsA("Humanoid")
        
        if desiredSubject and currentSubject ~= desiredSubject then
            camera.CameraSubject = desiredSubject
        end
        
        if focusCamValue and focusCamValue.Parent then
            local hrp = viewTarget:FindFirstChild("HumanoidRootPart")
            if hrp then
                focusCamValue.Value = hrp
            end
        end
    end)
    
    notify("View Player", "Now viewing: " .. target.Name)
    return true
end

local function disableViewPlayer()
    viewingPlayer = false
    viewTarget = nil
    
    if viewConnection then
        viewConnection:Disconnect()
        viewConnection = nil
    end
    
    if focusCamValue then
        focusCamValue:Destroy()
        focusCamValue = nil
    end
    
    pcall(function()
        local char = player.Character
        if char and char:FindFirstChild("FocusCam") then
            char.FocusCam:Destroy()
        end
    end)
    
    pcall(function()
        if prevCameraSubject then
            camera.CameraSubject = prevCameraSubject
        else
            local char = player.Character
            if char then
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum then
                    camera.CameraSubject = hum
                end
            end
        end
        
        if prevCameraType then
            camera.CameraType = prevCameraType
        else
            camera.CameraType = Enum.CameraType.Custom
        end
    end)
    
    notify("View Player", "Camera restored")
end
local stickerEnabled = false
local viewEnabled = false
local method = "normal"
local targetName = ""
TrollingTab:Section({Title = "Trolling"})
TrollingTab:Input({
    Flag = "TargetName",
    Title = "Enter Player/Mob Name",
    Callback = function(value)
        targetName = value
    end
})
local stickerToggle = TrollingTab:Toggle({
    Flag = "Sticker",
    Title = "Sticker",
    Default = false,
    Callback = function(value)
        stickerEnabled = value
if stickerEnabled then
        notify("YBA Script", "Sticker enabled for: ".. (targetName ~= "" and targetName or "<empty>"))
if method == "Up" or method == "Down" then
            enableNoclip()
end
else
        notify("YBA Script", "Sticker disabled")
for entity, _ in pairs(activeAligns) do cleanupAlignFor(entity) end
        disableNoclip()
end
    end
})
local viewPlayerToggle = TrollingTab:Toggle({
    Flag = "ViewPlayer",
    Title = "View Player",
    Default = false,
    Callback = function(value)
        if value then
            local name = targetName
            if not name or name == "" then
                notify("View Player", "Enter a player name first!")
                viewPlayerToggle:Set(false)
                return
            end
            
            local target = findClosestByName(name)
            if not target then
                notify("View Player", "Player not found: " .. name)
                viewPlayerToggle:Set(false)
                return
            end
            
            local success = enableViewPlayer(target)
            if not success then
                viewPlayerToggle:Set(false)
            end
        else
            disableViewPlayer()
        end
    end
})
TrollingTab:Dropdown({
    Flag = "StickerMethod",
    Title = "Methods",
    Values = {"normal", "Down", "Up"},
    Value = "normal",
    Callback = function(option)
        method = option
        notify("YBA Script", "Method changed to: " .. method)
        if stickerEnabled then
            for entity, _ in pairs(activeAligns) do cleanupAlignFor(entity) end
        end
        if method ~= "Down" and method ~= "Up" then
            disableNoclip()
        end
    end
})
RunService.Heartbeat:Connect(function(dt)
    scanTimer = scanTimer + dt
if scanTimer >= CHECK_SCAN_INTERVAL then
        rebuildModelCache()
        scanTimer = 0
end
if viewingPlayer then
    if not viewTarget or not viewTarget.Parent or not viewTarget:FindFirstChild("HumanoidRootPart") then
        notify("View Player", "Target lost (left/died)")
        viewPlayerToggle:Set(false)
        disableViewPlayer()
    end
end
if not stickerEnabled then return end
local name = targetName
if not name or name == "" then return end
local stand = getStand()
if not stand then
return
end
local target = findClosestByName(name)
if not target then
    if next(activeAligns) ~= nil then
        notify("Sticker", "No alive target found (died?), turning off.")
        stickerToggle:Set(false)
        if viewEnabled then viewToggle:Set(false) end
        for entity,_ in pairs(activeAligns) do cleanupAlignFor(entity) end
    end
    return
end
local targetHRP = target:FindFirstChild("HumanoidRootPart")
local targetHum = target:FindFirstChild("Humanoid")
local isAlive = targetHum and targetHum.Health > 0
if not targetHRP or not targetHum then
for entity,_ in pairs(activeAligns) do cleanupAlignFor(entity) end
if method == "Down" or method == "Up" then enableNoclip() else disableNoclip() end
return
end
local myChar = player.Character
if stand and currentTargetForEntity[stand] ~= targetHRP then
local ok, res = pcall(createAlignsFor, stand, targetHRP, "back")
if not ok or not res then
            cleanupAlignFor(stand)
end
end
if method == "Down" or method == "Up" then
if currentTargetForEntity[myChar] ~= targetHRP then
local ok, res = pcall(createAlignsFor, myChar, targetHRP, method)
if not ok or not res then
                cleanupAlignFor(myChar)
end
end
else
        cleanupAlignFor(myChar)
        disableNoclip()
end
for entity, alignData in pairs(activeAligns) do
if alignData and alignData.attB and alignData.attB.Parent == targetHRP then
local desiredWorldPos
if alignData.stickMode == "back" then
                desiredWorldPos = targetHRP.Position - targetHRP.CFrame.LookVector * BACK_DISTANCE + Vector3.new(0, BACK_HEIGHT, 0)
elseif alignData.stickMode == "Down" then
local height = isAlive and -PLAYER_HEIGHT or PLAYER_HEIGHT
                desiredWorldPos = targetHRP.Position + Vector3.new(0, height, 0)
elseif alignData.stickMode == "Up" then
local height = isAlive and PLAYER_HEIGHT or -PLAYER_HEIGHT
                desiredWorldPos = targetHRP.Position + Vector3.new(0, height, 0)
end
if desiredWorldPos then
local localPos = targetHRP.CFrame:PointToObjectSpace(desiredWorldPos)
                alignData.attB.Position = localPos
end
else
pcall(smoothFallback, entity, targetHRP, alignData.stickMode, isAlive)
end
end
if (method == "Down" or method == "Up") and isAlive then
        enableNoclip()
else
if method ~= "Down" and method ~= "Up" then
            disableNoclip()
end
end
end)
TrollingTab:Space()
local flyEnabled = false
local flySpeed = 50
local flyBodyVelocity = nil
local flyBodyGyro = nil
local function enableFly()
    if flyEnabled then return end
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyBodyVelocity.Parent = hrp
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyBodyGyro.P = 100000
    flyBodyGyro.Parent = hrp
    flyEnabled = true
    notify("YBA Script", "Fly enabled.")
    spawn(function()
        while flyEnabled do
            if not char or not hrp then break end
            local moveDir = Vector3.new(0, 0, 0)
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                moveDir = moveDir + Vector3.new(0, 1, 0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDir = moveDir - Vector3.new(0, 1, 0)
            end
            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit * flySpeed
                flyBodyVelocity.Velocity = moveDir
                flyBodyGyro.CFrame = workspace.CurrentCamera.CFrame
            else
                flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            wait()
        end
    end)
end
local function disableFly()
    if not flyEnabled then return end
    if flyBodyVelocity then flyBodyVelocity:Destroy() end
    if flyBodyGyro then flyBodyGyro:Destroy() end
    flyEnabled = false
    notify("YBA Script", "Fly disabled.")
end
local flyToggle = TrollingTab:Toggle({
    Flag = "Fly",
    Title = "Enable Fly",
    Default = false,
    Callback = function(value)
        if value then
            enableFly()
        else
            disableFly()
        end
    end
})
local lastFlySpeedNotify = 0
local flySpeedSlider = TrollingTab:Slider({
    Flag = "FlySpeed",
    Title = "Fly Speed",
    Step = 1,
    Value = {
        Min = 1,
        Max = 400,
        Default = 50,
    },
    Callback = function(value)
        flySpeed = value
        if os.clock() - lastFlySpeedNotify > 1 then
            notify("YBA Script", "Fly speed set to " .. value)
            lastFlySpeedNotify = os.clock()
        end
    end
})
TrollingTab:Input({
    Flag = "CustomFlySpeed",
    Title = "Custom Fly Speed",
    Placeholder = "Enter 1-5000...",
    Callback = function(value)
        local speed = tonumber(value)
        if speed and speed > 0 and speed <= 5000 then
            flySpeed = speed
            notify("YBA Script", "Fly speed set to: " .. speed)
        else
            notify("Error", "Please enter a valid number between 1-5000!")
        end
    end
})

TrollingTab:Space()
getgenv().standPilotActive = false
getgenv().pilotSpeed = 16
getgenv().PilotConfig = {
    Speed = 50,
    SpeedChangerEnabled = false,
    IsActive = false
}
getgenv().pilotSpeed = 50
local pilotConnections = {}
local standAnimController = nil
local function cleanupPilot()
    if not getgenv().PilotConfig.IsActive then return end
  
    for _, conn in pairs(pilotConnections) do
        if conn and typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    pilotConnections = {}
    standAnimController = nil
  
    pcall(function()
        local tempStorage = game.ReplicatedStorage:FindFirstChild("TempStoragePilot")
        if tempStorage then
            for _, v in pairs(tempStorage:GetChildren()) do
                if v.Name == "Naples' Sewers" then
                    v.Parent = workspace.Locations
                end
            end
            tempStorage:Destroy()
        end
    end)
    
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("FocusCam") then
            character.FocusCam:Destroy()
        end
    end)
    
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end)
    
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("StandMorph") then
            local standHRP = character.StandMorph:FindFirstChild("HumanoidRootPart")
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local remoteFunc = character:FindFirstChild("RemoteFunction")
            if standHRP and hrp then
                hrp.CFrame = standHRP.CFrame
            end
            if remoteFunc then
                remoteFunc:InvokeServer("ToggleStand", "Toggle")
            end
        end
    end)
    
    getgenv().PilotConfig.IsActive = false
end

local pilotToggle = TrollingTab:Toggle({
    Flag = "PilotStand",
    Title = "Pilot Stand",
    Default = false,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then 
            notify("YBA Script", "Character not loaded!")
            pilotToggle:Set(false)
            return 
        end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        local remoteFunc = character:FindFirstChild("RemoteFunction")
        
        if not hrp or not humanoid or not remoteFunc then
            notify("YBA Script", "Character not ready!")
            pilotToggle:Set(false)
            return
        end
        
        if getgenv().PilotConfig.IsActive then
            cleanupPilot()
            notify("YBA Script", "Stand Pilot disabled.")
            return
        end
        
        if not value then return end
        
        if not character:FindFirstChild("StandMorph") then
            remoteFunc:InvokeServer("ToggleStand", "Toggle")
            local waited = 0
            repeat task.wait(0.1) waited = waited + 0.1 until character:FindFirstChild("StandMorph") or waited > 5
            if not character:FindFirstChild("StandMorph") then
                notify("YBA Script", "Failed to summon stand!")
                pilotToggle:Set(false)
                return
            end
        end
        
        local standMorph = character.StandMorph
        standAnimController = standMorph.AnimationController
        local standHRP = standMorph:WaitForChild("HumanoidRootPart", 3)
        
        if not standAnimController or not standHRP then
            notify("YBA Script", "Stand not properly loaded!")
            pilotToggle:Set(false)
            return
        end
        
        if getgenv().PilotConfig.SpeedChangerEnabled then
            standAnimController.WalkSpeed = getgenv().PilotConfig.Speed
        end
        
        getgenv().PilotConfig.IsActive = true
        
        local tempStorage = Instance.new("Folder", game.ReplicatedStorage)
        tempStorage.Name = "TempStoragePilot"
        
        pcall(function()
            for _, v in pairs(workspace.Locations:GetChildren()) do
                if v.Name == "Naples' Sewers" then
                    v.Parent = tempStorage
                end
            end
        end)
        
        local cameraValue = Instance.new("ObjectValue", standMorph.Parent)
        cameraValue.Name = "FocusCam"
        cameraValue.Value = standAnimController
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        pcall(function()
            local standAttach = standMorph.PrimaryPart:FindFirstChild("StandAttach")
            if standAttach then
                local alignOrient = standAttach:FindFirstChild("AlignOrientation")
                local alignPos = standAttach:FindFirstChild("AlignPosition")
                if alignOrient then alignOrient.Enabled = false end
                if alignPos then alignPos.Enabled = false end
            end
        end)
        
        table.insert(pilotConnections, humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
            if humanoid.Jump then
                standAnimController.Jump = true
            end
            task.wait()
        end))
        
        table.insert(pilotConnections, RunService.Heartbeat:Connect(function()
            if not character or not character.Parent then return end
            if not standMorph or not standMorph.Parent then
                pcall(function() remoteFunc:InvokeServer("ToggleStand", "Toggle") end)
                return
            end
            
            local moveDirection = workspace.CurrentCamera.CFrame:VectorToObjectSpace(humanoid.MoveDirection)
            standAnimController:Move(moveDirection, true)
            
            if getgenv().PilotConfig.SpeedChangerEnabled then
                standAnimController.WalkSpeed = getgenv().PilotConfig.Speed
            end
            
            if standHRP and hrp then
                hrp.CFrame = standHRP.CFrame - Vector3.new(0, 25, 0)
            end
        end))
        
        pcall(function()
            for _, v in pairs(standMorph.Parent:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("UnionOperation") then
                    game:GetService("PhysicsService"):SetPartCollisionGroup(v, "Players")
                end
            end
        end)
        
        notify("YBA Script", "Stand Pilot enabled!")
    end
})

local pilotSpeedToggle = TrollingTab:Toggle({
    Flag = "PilotSpeedChanger",
    Title = "Pilot Speed Changer",
    Default = false,
    Callback = function(value)
        getgenv().PilotConfig.SpeedChangerEnabled = value
        if value and standAnimController then
            standAnimController.WalkSpeed = getgenv().PilotConfig.Speed
            notify("YBA Script", "Speed changer " .. (value and "enabled" or "disabled"))
        end
    end
})

local pilotSlider = TrollingTab:Slider({
    Flag = "PilotSpeed",
    Title = "Pilot Speed",
    Step = 1,
    Value = {
        Min = 0,
        Max = 200,
        Default = 50
    },
    Callback = function(value)
        getgenv().PilotConfig.Speed = value
        if getgenv().PilotConfig.SpeedChangerEnabled and standAnimController and standAnimController.Parent then
            standAnimController.WalkSpeed = value
        end
    end
})
local infPilotRangeConnection = nil
local infPilotRangeEnabled = false

local infPilotRangeToggle = TrollingTab:Toggle({
    Flag = "InfPilotRange",
    Title = "Inf Pilot Range",
    Default = false,
    Callback = function(value)
        infPilotRangeEnabled = value
        if value then
            notify("YBA Script", "Infinite Pilot Range enabled.")
            infPilotRangeConnection = game:GetService("RunService").Heartbeat:Connect(function()
                pcall(function()
                    local player = game:GetService("Players").LocalPlayer
                    if player.Character and player.Character:FindFirstChild("StandMorph") then
                        local isPiloting = player.Character.StandMorph:FindFirstChild("IsPiloting")
                        if isPiloting then
                            isPiloting.Value = 999999
                        end
                    end
                end)
            end)
        else
            notify("YBA Script", "Infinite Pilot Range disabled.")
            if infPilotRangeConnection then
                infPilotRangeConnection:Disconnect()
                infPilotRangeConnection = nil
            end
        end
    end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if infPilotRangeEnabled and infPilotRangeConnection then
        infPilotRangeConnection:Disconnect()
        infPilotRangeConnection = nil
        wait(1)
        infPilotRangeConnection = game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                if player.Character and player.Character:FindFirstChild("StandMorph") then
                    local isPiloting = player.Character.StandMorph:FindFirstChild("IsPiloting")
                    if isPiloting then
                        isPiloting.Value = 999999
                    end
                end
            end)
        end)
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function()
  if getgenv().standPilotActive then
    cleanupPilot()
    notify("YBA Script", "Stand Pilot auto-disabled (character respawned).")
    pilotToggle:Set(false)
  end
end)
TrollingTab:Section({ Title = "Block Bot" })

getgenv().BlockBotEnabled = false
getgenv().BlockBotRehooked = false
getgenv().BlockBotFahhEnabled = false
getgenv().BlockBotHeavyRange = 25
getgenv().BlockBotColiseumMode = false
getgenv().BlockBotProjectilePriority = false
getgenv().BlockBotRodBlocking = false

TrollingTab:Button({
    Title = "Hook Players/Rehook",
    Callback = function()
        if getgenv().BlockBotConnections then
            for _, conn in pairs(getgenv().BlockBotConnections) do
                pcall(function() conn:Disconnect() end)
            end
        end
        getgenv().BlockBotConnections = {}

        getgenv().BlockBotRehooked = true
        getgenv().BlockBotEnabled = false

        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                pcall(function()
                    if getgenv().BlockBotHooks and getgenv().BlockBotHooks[player.Name] then
                        for _, hook in pairs(getgenv().BlockBotHooks[player.Name]) do
                            pcall(function() hook:Disconnect() end)
                        end
                    end
                end)
            end
        end
        getgenv().BlockBotHooks = {}

        notify("YBA Script", "Block Bot Rehooked! Click 'Enable' to activate.")
    end
})

TrollingTab:Toggle({
    Flag = "BlockBotFahhToggle",
    Title = "Fahh! (Perfect Block Sound)",
    Desc = "Plays sound when perfect blocking",
    Default = false,
    Callback = function(value)
        getgenv().BlockBotFahhEnabled = value
        notify("YBA Script", value and "Fahh! Enabled" or "Fahh! Disabled")
    end
})

TrollingTab:Slider({
    Flag = "BlockBotHeavyRangeSlider",
    Title = "Heavy Range",
    Desc = "Range to block heavy attacks",
    Step = 1,
    Value = {
        Min = 10,
        Max = 100,
        Default = 25,
    },
    Callback = function(value)
        getgenv().BlockBotHeavyRange = value
    end
})

TrollingTab:Toggle({
    Flag = "BlockBotToggle",
    Title = "Enable Block Bot",
    Default = false,
    Callback = function(value)
        getgenv().BlockBotEnabled = value

        if value then
            if not getgenv().BlockBotRehooked then
                notify("YBA Script", "Please click 'Rehook' first before enabling!")
                task.delay(0.1, function()
                    local toggle = TrollingTab:FindFirstChild("BlockBotToggle")
                    if toggle and toggle.Set then toggle:Set(false) end
                end)
                return
            end

            notify("YBA Script", "Block Bot Enabled!")

            task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local Workspace = game:GetService("Workspace")
                local LocalPlayer = Players.LocalPlayer
                local UserInputService = game:GetService("UserInputService")

                -- Sound setup for Fahh!
                local FahhSound = Instance.new("Sound")
                FahhSound.SoundId = "rbxassetid://92076037937225"
                FahhSound.Volume = 1
                FahhSound.Parent = game:GetService("SoundService")

                local blocks_perfect = {
                    {
                        'rbxassetid://7217913060',
                        {def = 0.25}, -- Increased from 0.2
                    },
                    'rbxassetid://4725629903',
                    'rbxassetid://6032844827',
                    'rbxassetid://163619849',
                    {
                        'rbxassetid://7217914447',
                        {
                            def = 0.05, -- Increased from 0
                            addw = 0.22, -- Star Finger delay buffer (increased from 0.15)
                            chckfunc = function(p30)
                                local _Parent = p30.Parent
                                local v32 = _Parent:FindFirstChild("StandMorph")
                                if v32 then
                                    local _StandName = v32:FindFirstChild('Stand Name')
                                    if _StandName then
                                        return _StandName.Value == 'Star Platinum'
                                    else
                                        return false
                                    end
                                else
                                    return false
                                end
                            end,
                        },
                    },
                    {
                        'rbxassetid://7217914447',
                        {
                            def = 0.05, -- Increased from 0
                            addw = 0.22, -- Star Finger delay buffer for non-SP (increased from 0.15)
                            chckfunc = function(p34)
                                local _Parent2 = p34.Parent
                                local v36 = _Parent2:FindFirstChild("StandMorph")
                                if v36 then
                                    local _StandName2 = v36:FindFirstChild('Stand Name')
                                    if _StandName2 then
                                        return _StandName2.Value ~= 'Star Platinum'
                                    else
                                        return false
                                    end
                                else
                                    return false
                                end
                            end,
                        },
                    },
                }

                local blocks_base = {
                    {
                        'rbxassetid://6032836072',
                        {def = 0.35}, -- Increased from 0.3
                    },
                    'rbxassetid://6034138660',
                    {
                        'rbxassetid://10459370874',
                        {
                            def = 0.4, -- Increased from 0.35
                            addw = -0.25, -- Adjusted from -0.35
                            dist = 15,
                        },
                    },
                    {
                        'rbxassetid://12440326715',
                        {
                            addw = 0.05, -- Adjusted from -0.1
                            dist = 15,
                        },
                    },
                    {
                        'rbxassetid://74034132845527',
                        {def = 0.45}, -- Increased from 0.4
                    },
                }

                local blocks_UNBLOCK = {
                    'rbxassetid://11876873350',
                }

                local blocksanim_perfect = {
                    {
                        'rbxassetid://6048575522',
                        {
                            def = 0.08, -- Increased from 0
                            addw = 0.35, -- R Barrage Finisher delay buffer (increased from 0.2)
                            chckfunc = function(_, p38)
                                local _Parent3 = p38.Parent
                                local v40 = _Parent3:FindFirstChild("StandMorph")
                                if v40 then
                                    local _StandName3 = v40:FindFirstChild('Stand Name')
                                    if _StandName3 then
                                        return _StandName3.Value == 'Star Platinum'
                                    else
                                        return false
                                    end
                                else
                                    return false
                                end
                            end,
                        },
                    },
                    {
                        'rbxassetid://6048575522',
                        {
                            def = 0.08, -- Increased from 0
                            addw = 0.35, -- R Barrage Finisher delay buffer for non-SP (increased from 0.2)
                            chckfunc = function(_, p42)
                                local _Parent4 = p42.Parent
                                local v44 = _Parent4:FindFirstChild("StandMorph")
                                if v44 then
                                    local _StandName4 = v44:FindFirstChild('Stand Name')
                                    if _StandName4 then
                                        return _StandName4.Value ~= 'Star Platinum'
                                    else
                                        return false
                                    end
                                else
                                    return false
                                end
                            end,
                        },
                    },
                    {
                        'rbxassetid://4211804997',
                        {
                            def = 0.35, -- Increased from 0.3
                            chckfunc = function(_, p46)
                                local _Parent5 = p46.Parent
                                local v48 = _Parent5:FindFirstChild("StandMorph")
                                if v48 then
                                    local _StandName5 = v48:FindFirstChild('Stand Name')
                                    if _StandName5 then
                                        return _StandName5.Value ~= 'Tusk ACT 4'
                                    else
                                        return false
                                    end
                                else
                                    return false
                                end
                            end,
                        },
                    },
                    {
                        'rbxassetid://13899360363',
                        {def = 0.45}, -- Increased from 0.4
                    },
                    {
                        'rbxassetid://7189005773',
                        {def = 0.35}, -- Increased from 0.3
                    },
                    {
                        'rbxassetid://6835249882',
                        {def = 0.45}, -- Increased from 0.4
                    },
                    {
                        'rbxassetid://11886825775',
                        {def = 0.35}, -- Increased from 0.3
                    },
                    {
                        'rbxassetid://4879759800',
                        {def = 0.45}, -- Increased from 0.4
                    },
                    {
                        'rbxassetid://4825999731',
                        {
                            def = 0.55, -- Increased from 0.5
                            dist = 160,
                            chckfunc = function(_, _)
                                return getgenv().BlockBotRodBlocking or getgenv().BlockBotColiseumMode
                            end,
                        },
                    },
                    'rbxassetid://6704817082',
                    'rbxassetid://6049426097',
                    {
                        'rbxassetid://6105486059',
                        {def = 0.1}, -- Added small def
                    },
                    {
                        'rbxassetid://5303743107',
                        {def = 0.1}, -- Added small def
                    },
                    {
                        'rbxassetid://7250792726',
                        {def = 0.45}, -- Increased from 0.4
                    },
                    'rbxassetid://4812642386',
                    {
                        'rbxassetid://6216052429',
                        {
                            def = 0.35, -- Increased from 0.3
                            chckfunc = function(p50, _)
                                task.wait()
                                return p50.Speed > 1.39
                            end,
                        },
                    },
                    {
                        'rbxassetid://6216052429',
                        {def = 0.1}, -- Added small def
                    },
                    {
                        'rbxassetid://4096014941',
                        {
                            def = 0.45, -- Increased from 0.4
                            chckfunc = function(p51, _)
                                task.wait()
                                return p51.Speed > 1.049 and p51.Speed < 1.051
                            end,
                        },
                    },
                    {
                        'rbxassetid://4096014941',
                        {
                            def = 0.45, -- Increased from 0.4
                            chckfunc = function(p52, _)
                                return p52.Speed > 1.074 and p52.Speed < 1.076
                            end,
                        },
                    },
                    {
                        'rbxassetid://4096014941',
                        {
                            def = 0.45, -- Increased from 0.4
                            chckfunc = function(p53, p54)
                                local _Parent6 = p54.Parent
                                local v56 = _Parent6:FindFirstChild("StandMorph")
                                if v56 then
                                    local _StandName6 = v56:FindFirstChild('Stand Name')
                                    if _StandName6 then
                                        if _StandName6.Value == "Magician's Red" then
                                            return p53.Speed == 1
                                        else
                                            return false
                                        end
                                    else
                                        return false
                                    end
                                else
                                    return false
                                end
                            end,
                        },
                    },
                    {
                        'rbxassetid://4096014941',
                        {
                            def = 0.45, -- Increased from 0.4
                            chckfunc = function(_, p58)
                                local _Parent7 = p58.Parent
                                local v60 = _Parent7:FindFirstChild("StandMorph")
                                if v60 then
                                    local _StandName7 = v60:FindFirstChild('Stand Name')
                                    if _StandName7 then
                                        return _StandName7.Value == 'Gold Experience'
                                    else
                                        return false
                                    end
                                else
                                    return false
                                end
                            end,
                        },
                    },
                    {
                        'rbxassetid://4096014941',
                        {
                            def = 0.35, -- Increased from 0.3
                            dist = 75,
                            chckfunc = function(_, p62)
                                local _Parent8 = p62.Parent
                                local v64 = _Parent8:FindFirstChild("StandMorph")
                                if not v64 then
                                    return false
                                end
                                local _StandName8 = v64:FindFirstChild('Stand Name')
                                if not _StandName8 then
                                    return false
                                end
                                if _StandName8.Value ~= 'The Hand' then
                                    return false
                                end
                                task.wait()
                                local v66, v67, v68 = ipairs(v64:GetChildren())
                                while true do
                                    local v69
                                    v68, v69 = v66(v67, v68)
                                    if v68 == nil then
                                        break
                                    end
                                    if v69:IsA('Sound') and v69.SoundId == 'rbxassetid://7217913060' then
                                        return false
                                    end
                                end
                                return true
                            end,
                        },
                    },
                    {
                        'rbxassetid://4096014941',
                        {
                            def = 0.45, -- Increased from 0.4
                            chckfunc = function(p70, _)
                                return p70.Speed > 1.09 and p70.Speed < 1.11
                            end,
                        },
                    },
                    {
                        'rbxassetid://4096014941',
                        {
                            def = 0.45, -- Increased from 0.4
                            chckfunc = function(p71, _)
                                return p71.Speed > 0.84 and p71.Speed < 0.86
                            end,
                        },
                    },
                }

                local blocksanim_base = {
                    {
                        'rbxassetid://12733018380',
                        {
                            def = 0.4, -- Increased from 0.35
                            dist = 15,
                            addw = 1.15, -- Increased from 1.1
                        },
                    },
                    {
                        'rbxassetid://12733022476',
                        {
                            coliseum = true,
                            dist = 1000,
                            addw = 0.35, -- Increased from 0.3
                        },
                    },
                    {
                        'rbxassetid://4608512208',
                        {addw = 0.3}, -- Increased from 0.25
                    },
                    {
                        'rbxassetid://5303988283',
                        {def = 0.25}, -- Increased from 0.2
                    },
                    {
                        'rbxassetid://6780938176',
                        {
                            def = 0.25, -- Increased from 0.2
                            addw = 0.35, -- Increased from 0.3
                        },
                    },
                    'rbxassetid://12292886724',
                    {
                        'rbxassetid://6277192242',
                        {
                            def = 0.25, -- Increased from 0.2
                            dist = 50,
                            addw = 1.05, -- Increased from 1
                        },
                    },
                    {
                        'rbxassetid://6651725175',
                        {
                            addw = 0.05, -- Adjusted from -0.1
                            dist = 40,
                        },
                    },
                    {
                        'rbxassetid://6216058630',
                        {
                            def = 0.05, -- Increased from 0
                            addw = 0.22, -- Increased from 0.15
                            coliseum = true,
                            dist = 60,
                        },
                    },
                    {
                        'rbxassetid://10726619714',
                        {
                            def = 0.25, -- Increased from 0.2
                            addw = 0.6, -- Increased from 0.55
                        },
                    },
                    {
                        'rbxassetid://12293320463',
                        {def = 0.35}, -- Increased from 0.3
                    },
                    {
                        'rbxassetid://6869896659',
                        {
                            def = 0.25, -- Increased from 0.2
                            addw = 0.8, -- Increased from 0.75
                        },
                    },
                    {
                        'rbxassetid://14174878575',
                        {
                            def = 0.35, -- Increased from 0.3
                            addw = 0.05, -- Adjusted from -0.1
                            dist = 70,
                            coliseum = true,
                        },
                    },
                    {
                        'rbxassetid://7189003645',
                        {
                            def = 0.35, -- Increased from 0.3
                            addw = 0.25, -- Increased from 0.2
                        },
                    },
                    'rbxassetid://5793968491',
                    {
                        'rbxassetid://4595562165',
                        {
                            def = 0.05, -- Increased from 0
                            addw = 0.25, -- Increased from 0.2
                        },
                    },
                    'rbxassetid://5227558947',
                    {
                        'rbxassetid://4133363765',
                        {def = 0.65}, -- Increased from 0.6
                    },
                    {
                        'rbxassetid://4691787301',
                        {
                            def = 0.3, -- Increased from 0.25
                            addw = 0.8, -- Increased from 0.75
                            dist = 100,
                            chckfunc = function(_, p72)
                                task.wait()
                                local _RightHand = p72.Parent:FindFirstChild("RightHand")
                                if not _RightHand then return false end
                                local _Grapple = _RightHand:FindFirstChild('Grape')
                                if _Grapple then
                                    return _Grapple.Attachment1 == LocalPlayer.Character.HumanoidRootPart.RootRigAttachment
                                else
                                    return false
                                end
                            end,
                        },
                    },
                    {
                        'rbxassetid://12733016318',
                        {
                            def = 0.375, -- Increased from 0.325
                            addw = 0.05, -- Adjusted from -0.1
                            dist = 15,
                            chckfunc = function(p74, _)
                                return p74.Speed < 0.75
                            end,
                        },
                    },
                }

                local blocksanim_UNBLOCK = {
                    'rbxassetid://12293318922',
                    'rbxassetid://13819646949',
                    'rbxassetid://6780937804',
                    'rbxassetid://6780982308',
                    {
                        'rbxassetid://10443019808',
                        {dist = 10},
                    },
                }

                local block_projectiles = {
                    {
                        'VisionPlunderBubble',
                        'Core',
                        15,
                        nil,
                    },
                    {
                        ' SP Bullet',
                        nil,
                        20,
                        function(p75)
                            return p75:FindFirstChild('Victim') and true or false
                        end,
                        false,
                        true,
                    },
                    {
                        'Last Shot',
                        nil,
                        20,
                        nil,
                        false,
                        true,
                    },
                    {
                        'Main',
                        nil,
                        25,
                        function(p76)
                            return p76:FindFirstChild('BloodTrail') and true or false
                        end,
                        true,
                    },
                    {
                        'HomingShard',
                        nil,
                        20,
                    },
                    {
                        'Bullet',
                        nil,
                        20,
                        function(p77)
                            if p77.Name:find('SP Bullet') or p77.Name:find('SPBullet') then
                                return false
                            else
                                return not p77:FindFirstChild('Victim')
                            end
                        end,
                    },
                    {
                        'CrossFirePiece',
                        nil,
                        40,
                        function(p78)
                            local _OnFireSparks = p78:FindFirstChild('OnFireSparks')
                            if _OnFireSparks then
                                return _OnFireSparks.Enabled
                            end
                            return false
                        end,
                        true,
                        true,
                    },
                    {
                        'Baseball3',
                        nil,
                        20,
                    },
                }

                local function ping()
                    return LocalPlayer:GetNetworkPing()
                end

                local blockprocsuntil = tick()
                local lastblock = 0
                local blockactions = false
                local lastboi = nil
                local lastbad = ''
                local lastbb = tick()
                local blocked = false
                local F = false
                local lboverriding = true
                local reblocking = true
                local keepblock = true
                local unblocking = true
                local projectiles_priority = false

                local function isTimeStop()
                    return game.Lighting:FindFirstChild('TimeStop') and true or false
                end

                local function isRagdolled(p1101)
                    if p1101 then
                        return p1101:FindFirstChild('RagdollParts') and true or false
                    else
                        return nil
                    end
                end

                local function block()
                    if LocalPlayer.Character then
                        blocked = true
                        LocalPlayer.Character:FindFirstChild('RemoteEvent'):FireServer('StartBlocking', 'pass')
                    end
                end

                local function unblock(p948, p949)
                    if p948 or (not F or (not keepblock or isRagdolled(LocalPlayer.Character))) then
                        if p948 and not (reblocking or isRagdolled(LocalPlayer.Character)) then
                            return 42
                        end

                        if not (p949 or p948) or isRagdolled(LocalPlayer.Character) then
                            blockactions = false
                        end

                        for _ = 1, 5 do
                            LocalPlayer.Character:FindFirstChild('RemoteEvent'):FireServer('StopBlocking', 'pass')
                        end
                        blocked = false
                    end
                end

                local function frek()
                    if getgenv().BlockBotEnabled then
                        if unblocking then
                            blockprocsuntil = tick() + 0.85 -- Increased from 0.75
                            lastblock = lastblock + 1
                            local v988 = lastblock
                            blockactions = true
                            unblock(false, true)
                            task.wait(0.06) -- Increased from 0.05
                            unblock(false, true)
                            task.wait(0.8) -- Increased from 0.7
                            if lboverriding and lastblock ~= v988 then
                                -- do nothing
                            else
                                blockactions = false
                            end
                        end
                    end
                end

                local function reqblock(p989, p990, p991, p992, p993)
                    if getgenv().BlockBotEnabled then
                        local v994 = p993 or 0

                        if blockactions then
                            if v994 and tonumber(blockactions) then
                                if v994 <= tonumber(blockactions) then
                                    return
                                end
                            elseif not blockactions then
                                return
                            end
                        end

                        blockactions = v994

                        LocalPlayer.Character:FindFirstChild('RemoteEvent'):FireServer('HoldAttack', {
                            Bool = false,
                            Type = 'm1',
                        })

                        lastbb = tick()

                        if LocalPlayer.Character:FindFirstChild('Blocking_Capacity') and LocalPlayer.Character.Blocking_Capacity.Value > 0 and p992 then
                            if p989 < 0.25 or not reblocking then -- Increased from 0.2
                                return
                            end
                            if unblock(true) == 42 then
                                return
                            end
                        end

                        lastblock = lastblock + 1
                        local v995 = lastblock

                        task.wait(p990)

                        if lboverriding and lastblock ~= v995 then
                            return
                        elseif isTimeStop() then
                            blockactions = false
                            return
                        else
                            block()

                            -- Play Fahh sound on perfect block
                            if p992 and getgenv().BlockBotFahhEnabled then
                                FahhSound:Stop()
                                FahhSound.TimePosition = 0
                                FahhSound:Play()
                            end

                            local v996 = 0.45 + math.max(0.15, ping()) + p991 -- Increased base from 0.4, min ping from 0.1
                            task.wait(v996)

                            if lboverriding and lastblock ~= v995 then
                                -- do nothing
                            else
                                blockactions = false
                                unblock(false)
                            end
                        end
                    end
                end

                local function proroc(p997, p998, p999)
                    if isTimeStop() then
                        return
                    end
                    if isRagdolled(LocalPlayer.Character) then
                        return
                    end
                    if not getgenv().BlockBotEnabled then
                        return
                    end
                    if blockprocsuntil > tick() then
                        return
                    end

                    local _Parent9 = p998.Parent
                    local v1001 = false
                    local v1002 = false

                    local function u1004(p1003)
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                        if not hrp then return 0 end
                        if p1003 < (p998.Position - hrp.Position).Magnitude then
                            if not p999 then
                                return 0
                            end
                            if p1003 < (p999.Position - hrp.Position).Magnitude then
                                return 0
                            end
                        end
                    end

                    local u1005 = false

                    local function v1007(p1006)
                        u1005 = false
                        if u1004(p1006) == 0 then
                            u1005 = true
                            task.wait(0.35) -- Increased from 0.3
                            if u1004(p1006) == 0 then
                                return 0
                            end
                        end
                    end

                    local v1008, v1009

                    -- Sound-based blocks
                    if p997:IsA('Sound') then
                        -- Perfect block hit sound check
                        if p997.SoundId == 'rbxassetid://5056859332' and lastboi == _Parent9 then
                            unblock(false)
                            return
                        end

                        local v1010, v1011, v1012 = ipairs({blocks_perfect, blocks_base, blocks_UNBLOCK})
                        v1008 = u1005

                        while true do
                            local v1013, v1014 = v1010(v1011, v1012)
                            if v1013 == nil then
                                v1009 = v1002
                                break
                            end

                            local v1015, v1016, v1017 = ipairs(v1014)
                            v1012 = v1013

                            while true do
                                v1017, v1009 = v1015(v1016, v1017)
                                if v1017 == nil then
                                    v1009 = v1002
                                    break
                                end

                                if type(v1009) ~= 'table' or (not v1009[2].coliseum or getgenv().BlockBotColiseumMode) then
                                    local v1018 = getgenv().BlockBotHeavyRange or 25
                                    local v1019 = false
                                    local v1020

                                    if type(v1009) ~= 'table' then
                                        v1020 = v1009
                                    else
                                        v1020 = v1009[1]
                                    end

                                    local v1021 = true

                                    -- Overrider check
                                    if blockactions and lastbad ~= '' and overriders[lastbad] then
                                        local v1022, v1023, v1024 = ipairs(overriders[lastbad])
                                        while true do
                                            local v1025
                                            v1024, v1025 = v1022(v1023, v1024)
                                            if v1024 == nil then
                                                break
                                            end
                                            if v1025 == v1020 then
                                                v1021 = false
                                                break
                                            end
                                        end
                                    end

                                    if v1021 then
                                        if type(v1009) == 'table' then
                                            if v1013 == 1 then
                                                v1001 = true
                                            elseif v1013 == 2 then
                                                v1001 = false
                                            end
                                            v1018 = v1009[2] and v1009[2].dist and v1009[2].dist or v1018
                                            if v1009[2].chckfunc and not v1009[2].chckfunc(p998) then
                                                v1019 = true
                                            end
                                        end

                                        if not v1019 and p997.SoundId == v1020 and (v1007(v1018) ~= 0 and 1 or 0) == 1 then
                                            if v1013 == 3 then
                                                return frek()
                                            end

                                            -- Barrage check
                                            local v1026, v1027, v1028 = ipairs(p997.Parent:GetChildren())
                                            while true do
                                                local v1030
                                                v1028, v1030 = v1026(v1027, v1028)
                                                if v1028 == nil then
                                                    break
                                                end
                                                if string.find(string.lower(v1030.Name), 'barrage') then
                                                    return
                                                end
                                            end

                                            break
                                        end
                                    end
                                end
                            end

                            if v1009 then
                                break
                            end
                            v1002 = v1009
                        end
                    else
                        v1008 = u1005
                        v1009 = v1002
                    end

                    local v1031

                    -- Animation-based blocks
                    if v1009 or not p997:IsA('AnimationTrack') then
                        v1031 = v1009
                    else
                        local _AnimationId = p997.Animation.AnimationId
                        local v1033, v1034, v1035 = ipairs({blocksanim_perfect, blocksanim_base, blocksanim_UNBLOCK})

                        while true do
                            local v1036
                            v1035, v1036 = v1033(v1034, v1035)
                            if v1035 == nil then
                                v1031 = v1009
                                break
                            end

                            local v1037, v1038, v1039 = ipairs(v1036)
                            local v1040 = v1035

                            while true do
                                v1039, v1031 = v1037(v1038, v1039)
                                if v1039 == nil then
                                    v1031 = v1009
                                    break
                                end

                                if type(v1031) ~= 'table' or (not v1031[2].coliseum or getgenv().BlockBotColiseumMode) then
                                    local v1041 = getgenv().BlockBotHeavyRange or 25
                                    local v1042 = false
                                    local v1043

                                    if type(v1031) ~= 'table' then
                                        v1043 = v1031
                                    else
                                        v1043 = v1031[1]
                                    end

                                    local v1044 = true

                                    -- Overrider check
                                    if blockactions and lastbad ~= '' and overriders[lastbad] then
                                        local v1045, v1046, v1047 = ipairs(overriders[lastbad])
                                        while true do
                                            local v1048
                                            v1047, v1048 = v1045(v1046, v1047)
                                            if v1047 == nil then
                                                break
                                            end
                                            if v1048 == v1043 then
                                                v1044 = false
                                                break
                                            end
                                        end
                                    end

                                    if v1044 then
                                        if type(v1031) == 'table' then
                                            if v1040 == 1 then
                                                v1001 = true
                                            elseif v1040 == 2 then
                                                v1001 = false
                                            end
                                            v1041 = v1031[2].dist or v1041
                                            if v1031[2].chckfunc and not v1031[2].chckfunc(p997, p998) then
                                                v1042 = true
                                            end
                                        end

                                        if not v1042 and (v1043 == _AnimationId and v1007(v1041) ~= 0) then
                                            if v1040 == 3 then
                                                return frek()
                                            end
                                            break
                                        end
                                    end
                                end
                            end

                            if v1031 then
                                break
                            end
                            v1009 = v1031
                        end
                    end

                    if v1031 then
                        lastboi = _Parent9

                        local v1049 = 0
                        local v1050, v1051

                        if type(v1031) ~= 'table' then
                            v1050 = 0.45 -- Increased from 0.4
                            v1051 = 0
                        else
                            local _ = v1031[1]
                            local v1052 = v1031[2]
                            v1050 = v1052.def or 0.45 -- Increased default from 0.4
                            v1049 = v1049 + (v1052.addw or 0)
                            v1051 = v1052.prio
                            if not v1051 then
                                v1051 = 0
                            end
                        end

                        lastbad = v1031

                        local v1053 = 0
                        if v1008 then
                            v1053 = v1053 + 0.35 -- Increased from 0.3
                        end

                        -- EXACT: math.max(0, defense - ping() - extra)
                        local v1054 = math.max(0, v1050 - ping() - v1053)

                        reqblock(v1050, v1054, v1049, v1001, v1051)
                    end
                end

                local function proc(p1060, p1061, p1062)
                    if getgenv().BlockBotEnabled then
                        local _ = p1061.Parent
                        return proroc(p1060, p1061, p1062)
                    end
                end

                local function nenrmesdfk(p1063)
                    if p1063.Name == 'RagdollParts' then
                        lastblock = lastblock + 1
                        blockprocsuntil = tick() + 0.25 -- Increased from 0.2
                        blockactions = false
                        blocked = false
                        unblock(false)
                    end
                end

                local function handleproj(p1064)
                    if getgenv().BlockBotEnabled then
                        local v1065, v1066, v1067 = ipairs(block_projectiles)
                        while true do
                            local u1068
                            v1067, u1068 = v1065(v1066, v1067)
                            if v1067 == nil then
                                break
                            end
                            if p1064.Name:find(u1068[1]) then
                                local u1069 = u1068[2] == nil and p1064 or p1064:FindFirstChild(u1068[2])
                                if not u1069 then return end

                                local v1070 = u1068[4] or function(_) return true end
                                if u1068[4] and not v1070(p1064) then continue end

                                local u1072 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                                if not u1072 then return end

                                local function v1081()
                                    local _AssemblyLinearVelocity = u1069.AssemblyLinearVelocity
                                    local v1074
                                    if _AssemblyLinearVelocity.Magnitude <= 0.01 then
                                        v1074 = u1069.Position
                                    else
                                        local _Unit = _AssemblyLinearVelocity.Unit
                                        local v1076 = math.atan2(_Unit.X, _Unit.Z)
                                        local v1077 = math.asin(-_Unit.Y)
                                        local v1078 = Vector3.new(math.sin(v1076) * math.cos(v1077), -math.sin(v1077), math.cos(v1076) * math.cos(v1077))
                                        v1074 = u1069.CFrame.Position
                                    end
                                    local _Magnitude = (u1072.Position - v1074).Magnitude
                                    return _Magnitude < u1068[3]
                                end

                                while p1064.Parent and p1064:IsDescendantOf(Workspace) do
                                    if v1081() and (not blockactions or projectiles_priority) then
                                        if blockactions and not projectiles_priority then return end

                                        lastblock = lastblock + 1
                                        local v1082 = lastblock
                                        blockactions = true

                                        if projectiles_priority then
                                            blockactions = 42000
                                        end

                                        block()

                                        local v1083 = tick()
                                        while p1064.Parent and (tick() - v1083 < 0.85) and (v1082 == lastblock or not lboverriding) and v1081() do -- Increased from 0.75
                                            task.wait()
                                        end

                                        if tick() - v1083 < 0.5 then -- Increased from 0.4321
                                            task.wait(0.5 - (tick() - v1083))
                                        end

                                        if not (lboverriding and lastblock ~= v1082) and not isTimeStop() then
                                            unblock(false)
                                            blockactions = false
                                        end
                                        return
                                    end
                                    task.wait()
                                end
                            end
                        end
                    end
                end

                local block_SPECIAL = {
                    {
                        'GroundIndicator',
                        function(p80)
                            warn('G I !!')
                            local v81 = {def = 0.05, wt = 0.05, addw = 0.15} -- Added small delays
                            local v82 = p80:Clone()
                            local v83 = 5 * 2
                            v82.Size = Vector3.new(15 + v83, 5, 40 + v83)
                            v82.CFrame = v82.CFrame * CFrame.new(0, 0, -12.5)
                            task.wait(0.2) -- Increased from 0.15

                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                            if hrp then
                                local pos = hrp.Position
                                local min = v82.Position - v82.Size/2
                                local max = v82.Position + v82.Size/2
                                if pos.X >= min.X and pos.X <= max.X and pos.Z >= min.Z and pos.Z <= max.Z then
                                    reqblock(v81.def, v81.wt, v81.addw, false)
                                end
                            end
                            v82:Destroy()
                            return true
                        end,
                    },
                    {
                        'FloorDash',
                        function(p84)
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                            if not hrp then return false end
                            if (hrp.Position - p84.Position).Magnitude > 40 then return false end
                            local v85 = {def = 0.05, wt = 0.05, addw = 0.4} -- Increased addw from 0.3
                            task.wait(0.25) -- Increased from 0.2
                            reqblock(v85.def, v85.wt, v85.addw, false)
                            return true
                        end,
                    },
                }

                local function u1090(p1085)
                    if getgenv().BlockBotEnabled then
                        local v1086, v1087, v1088 = ipairs(block_SPECIAL)
                        while true do
                            local v1089
                            v1088, v1089 = v1086(v1087, v1088)
                            if v1088 == nil then
                                break
                            end
                            if p1085.Name:find(v1089[1]) then
                                if v1089[2](p1085) then
                                    return
                                end
                            end
                        end
                    end
                end

                local function v1100(p1091)
                    if getgenv().BlockBotEnabled then
                        if blockprocsuntil <= tick() then
                            task.wait()
                            local v1092, v1093, v1094 = ipairs(block_projectiles)
                            while true do
                                local v1095
                                v1094, v1095 = v1092(v1093, v1094)
                                if v1094 == nil then
                                    break
                                end
                                if p1091.Name:find(v1095[1]) then
                                    return handleproj(p1091)
                                end
                            end

                            local v1096, v1097, v1098 = ipairs(block_SPECIAL)
                            while true do
                                local v1099
                                v1098, v1099 = v1096(v1097, v1098)
                                if v1098 == nil then
                                    break
                                end
                                if p1091.Name:find(v1099[1]) then
                                    return u1090(p1091)
                                end
                            end
                        end
                    end
                end

                local block_objects = {
                    {
                        'Wormhole',
                        Workspace,
                        7,
                        function()
                            return 0.05, 0.05, 0.15, false -- Added small delays
                        end,
                    },
                }

                Workspace.DescendantAdded:Connect(function(p1055)
                    local v1056, v1057, v1058 = ipairs(block_objects)
                    while true do
                        local v1059
                        v1058, v1059 = v1056(v1057, v1058)
                        if v1058 == nil then
                            break
                        end
                        if v1059[1] == p1055.Name and (v1059[2] == 'any' or v1059[2] == p1055.Parent) then
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                            if hrp and (p1055.Position - hrp.Position).Magnitude < v1059[3] then
                                local def, wt, addw, isPerf = v1059[4]()
                                reqblock(def, wt, addw, isPerf)
                            end
                        end
                    end
                end)

                Workspace.ChildAdded:Connect(v1100)
                if Workspace:FindFirstChild('IgnoreInstances') then
                    Workspace.IgnoreInstances.ChildAdded:Connect(v1100)
                end

                -- Input handling
                UserInputService.InputBegan:Connect(function(p945, p946)
                    if not p946 then
                        if p945.KeyCode == Enum.KeyCode.F then
                            F = true
                        end
                    end
                end)

                UserInputService.InputEnded:Connect(function(p947, _)
                    if p947.KeyCode == Enum.KeyCode.F then
                        F = false
                    end
                end)

                local hookz = {}

                local function procplayer(p1126)
                    if not p1126 or p1126 == LocalPlayer then return end

                    if hookz[p1126.Name] then
                        local v1127, v1128, v1129 = pairs(hookz[p1126.Name])
                        while true do
                            local v1130
                            v1129, v1130 = v1127(v1128, v1129)
                            if v1129 == nil then
                                break
                            end
                            v1130:Disconnect()
                        end
                    end

                    hookz[p1126.Name] = {}

                    local u1131 = Workspace:WaitForChild("Living"):FindFirstChild(p1126.Name)

                    if not u1131 then
                        local v1132 = tick()
                        while tick() - v1132 < 5 and not u1131 do
                            u1131 = Workspace.Living:FindFirstChild(p1126.Name)
                            task.wait(0.25)
                        end
                    end

                    if u1131 then
                        local _Humanoid = u1131:WaitForChild('Humanoid', 5)
                        local _Animator = _Humanoid and _Humanoid:WaitForChild('Animator', 5)

                        local function u1137(p1134)
                            if p1134 then
                                local v1136 = p1134.AnimationPlayed:Connect(function(p1135)
                                    proc(p1135, u1131.PrimaryPart, nil)
                                end)
                                table.insert(hookz[p1126.Name], v1136)
                            end
                        end

                        u1137(_Animator)

                        local v1141 = u1131.DescendantAdded:Connect(function(p1138)
                            if p1138.Name ~= 'Animator' or p1138.Parent ~= u1131 then
                                if p1138:IsA('Model') and p1138.Name == 'StandMorph' then
                                    task.wait(0.15) -- Increased from 0.1
                                    local _Animator2 = p1138:FindFirstChild('Animator', true)
                                    if not _Animator2 then
                                        local v1140 = tick()
                                        while tick() - v1140 < 3 and not _Animator2 do
                                            _Animator2 = p1138:FindFirstChild('Animator', true)
                                            task.wait(0.25)
                                        end
                                    end
                                    if _Animator2 then
                                        u1137(_Animator2)
                                    end
                                end
                                if p1138:IsA('Sound') then
                                    proc(p1138, u1131.PrimaryPart, nil)
                                end
                            end
                        end)

                        table.insert(hookz[p1126.Name], v1141)

                        if u1131:FindFirstChild('StandMorph') then
                            local _Animator3 = u1131.StandMorph:FindFirstChild('Animator', true)
                            if _Animator3 then
                                u1137(_Animator3)
                            else
                                local v1144 = tick()
                                while tick() - v1144 < 3 and (not _Animator3 and u1131:FindFirstChild('StandMorph')) do
                                    _Animator3 = u1131.StandMorph:FindFirstChild('Animator', true)
                                    task.wait(0.25)
                                end
                                if _Animator3 then
                                    u1137(_Animator3)
                                end
                            end
                        end
                    end
                end

                -- Hook all existing players
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        task.spawn(function()
                            procplayer(player)
                        end)
                    end
                end

                -- Hook new players
                local playerAddedConn = Players.PlayerAdded:Connect(function(player)
                    if player ~= LocalPlayer then
                        task.spawn(function()
                            procplayer(player)
                        end)
                    end
                end)
                table.insert(getgenv().BlockBotConnections, playerAddedConn)

                -- Local player character handling
                if LocalPlayer.Character then
                    LocalPlayer.Character.ChildAdded:Connect(nenrmesdfk)
                end

                local charAddedConn = LocalPlayer.CharacterAdded:Connect(function(char)
                    char.ChildAdded:Connect(nenrmesdfk)
                end)
                table.insert(getgenv().BlockBotConnections, charAddedConn)

                Workspace:WaitForChild('Living').ChildAdded:Connect(function(p1122)
                    if p1122.Name ~= LocalPlayer.Name then
                        if Players:FindFirstChild(p1122.Name) then
                            task.wait(1.1) -- Increased from 1
                            procplayer(Players:FindFirstChild(p1122.Name))
                        end
                    else
                        task.wait(1.1) -- Increased from 1
                        p1122.ChildAdded:Connect(nenrmesdfk)
                    end
                end)

            end)
        else
            notify("YBA Script", "Block Bot Disabled!")
            if getgenv().BlockBotConnections then
                for _, conn in pairs(getgenv().BlockBotConnections) do
                    pcall(function() conn:Disconnect() end)
                end
            end
            getgenv().BlockBotConnections = {}
        end
    end
})

TrollingTab:Toggle({
    Flag = "BlockBotProjectilePriorityToggle",
    Title = "Block incoming Projectiles",
    Default = false,
    Callback = function(value)
        getgenv().BlockBotProjectilePriority = value
        projectiles_priority = value
        notify("YBA Script", value and "Projectile Priority Enabled" or "Projectile Priority Disabled")
    end
})

TrollingTab:Toggle({
    Flag = "BlockBotRodBlockingToggle",
    Title = "Block ***** Boy heavy's",
    Default = false,
    Callback = function(value)
        getgenv().BlockBotRodBlocking = value
        notify("YBA Script", value and "Rod Blocking Enabled" or "Rod Blocking Disabled")
    end
})
do
    local KeybindsSection = KeybindsTab:Section({ Title = "Keybind Settings" })
    
    local KeybindStorage = {
        Fly = "",
        StandPilot = "",
        ItemFarm = "",
        InfDash = ""
    }
    
    local function handleKeybind(key, feature)
        if key == "" or key == nil then return end
        
        local success, err = pcall(function()
            if feature == "Fly" then
                local newValue = not flyEnabled
                flyToggle:Set(newValue)
            elseif feature == "StandPilot" then
                local newValue = not getgenv().PilotConfig.IsActive
                pilotToggle:Set(newValue)
            elseif feature == "ItemFarm" then
                local newValue = not normalFarmOn
                tpToItemsToggle:Set(newValue)
            elseif feature == "InfDash" then
                local currentState = Util:GetState("Infinite Dash")
                infiniteDashToggle:Set(not currentState)
            end
        end)
        
        if not success then
            warn("Keybind error for " .. feature .. ": " .. tostring(err))
        end
    end
    
    local KeybindConnections = {}
    
    local function setupKeybindListener(feature)
        if KeybindConnections[feature] then
            KeybindConnections[feature]:Disconnect()
            KeybindConnections[feature] = nil
        end
        
        local key = KeybindStorage[feature]
        if key == "" or key == nil then return end
        
        local keyCode = nil
        pcall(function()
            keyCode = Enum.KeyCode[key]
        end)
        
        if not keyCode then return end
        
        KeybindConnections[feature] = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == keyCode then
                handleKeybind(key, feature)
            end
        end)
    end
    
    KeybindsSection:Input({
        Flag = "KeybindFly",
        Title = "Fly Keybind",
        Placeholder = "Leave blank to disable...",
        Callback = function(value)
            local upperValue = string.upper(value)
            KeybindStorage.Fly = upperValue
            setupKeybindListener("Fly")
        end
    })
    
    KeybindsSection:Input({
        Flag = "KeybindStandPilot",
        Title = "Stand Pilot Keybind",
        Placeholder = "Leave blank to disable...",
        Callback = function(value)
            local upperValue = string.upper(value)
            KeybindStorage.StandPilot = upperValue
            setupKeybindListener("StandPilot")
        end
    })
    
    KeybindsSection:Input({
        Flag = "KeybindItemFarm",
        Title = "Item Farm Keybind",
        Placeholder = "Leave blank to disable...",
        Callback = function(value)
            local upperValue = string.upper(value)
            KeybindStorage.ItemFarm = upperValue
            setupKeybindListener("ItemFarm")
        end
    })
    
    KeybindsSection:Input({
        Flag = "KeybindInfDash",
        Title = "Infinite Dash Keybind",
        Placeholder = "Leave blank to disable...",
        Callback = function(value)
            local upperValue = string.upper(value)
            KeybindStorage.InfDash = upperValue
            setupKeybindListener("InfDash")
        end
    })
KeybindsSection:Input({
    Flag = "KeybindInvisibility",
    Title = "Invisibility Keybind",
    Placeholder = "Leave blank to disable...",
    Callback = function(value)
        local upperValue = string.upper(value)
        KeybindStorage.Invisibility = upperValue

        if upperValue ~= "" then
            if not getgenv().AdvancedInvisInitialized then
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer

                getgenv().IsInvisible = false
                getgenv().VisibleParts = {}
                getgenv().InvisConnections = {}

                local Character, Humanoid, HumanoidRootPart

                local function SetupCharacter()
                    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    Humanoid = Character:WaitForChild("Humanoid")
                    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    getgenv().VisibleParts = {}

                    for _, descendant in pairs(Character:GetDescendants()) do
                        if descendant:IsA("BasePart") and descendant.Transparency == 0 then
                            table.insert(getgenv().VisibleParts, descendant)
                        end
                    end
                end

                SetupCharacter()

                getgenv().InvisConnections[1] = RunService.Heartbeat:Connect(function()
                    if getgenv().IsInvisible and HumanoidRootPart and Humanoid then
                        local OriginalCFrame = HumanoidRootPart.CFrame
                        local OriginalCameraOffset = Humanoid.CameraOffset

                        local DownCFrame = OriginalCFrame * CFrame.new(0, -200000, 0)
                        HumanoidRootPart.CFrame = DownCFrame
                        Humanoid.CameraOffset = DownCFrame:ToObjectSpace(CFrame.new(OriginalCFrame.Position)).Position

                        RunService.RenderStepped:Wait()

                        HumanoidRootPart.CFrame = OriginalCFrame
                        Humanoid.CameraOffset = OriginalCameraOffset
                    end
                end)

                getgenv().InvisConnections[2] = LocalPlayer.CharacterAdded:Connect(function()
                    getgenv().IsInvisible = false
                    task.wait(0.5)
                    SetupCharacter()
                end)

                getgenv().AdvancedInvisInitialized = true
            end

            notify("YBA Script", "Invisibility keybind set: " .. upperValue)
        else
            notify("YBA Script", "Invisibility keybind cleared")
        end
    end
})

table.insert(KeybindConnections, game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    local key = KeybindStorage.Invisibility
    if not key or key == "" then return end

    local keyCode
    pcall(function()
        keyCode = Enum.KeyCode[key]
    end)

    if keyCode and input.KeyCode == keyCode then
        getgenv().IsInvisible = not getgenv().IsInvisible

        local transparency = getgenv().IsInvisible and 0.5 or 0
        for _, part in pairs(getgenv().VisibleParts or {}) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end

        notify("YBA Script", getgenv().IsInvisible and "Invisibility Enabled" or "Invisibility Disabled")
    end
end))
    
    KeybindsSection:Space()
    
    KeybindsSection:Button({
        Title = "Reset All Keybinds",
        Callback = function()
            for k, _ in pairs(KeybindStorage) do
                KeybindStorage[k] = ""
            end
            
            for feature, conn in pairs(KeybindConnections) do
                if conn then
                    conn:Disconnect()
                end
                KeybindConnections[feature] = nil
            end
            
            pcall(function()
                if KeybindsSection then
                    for _, element in pairs(KeybindsSection:GetChildren() or {}) do
                        if element and element.Clear then
                            element:Clear()
                        elseif element and element.Set then
                            element:Set("")
                        end
                    end
                end
            end)
            
            notify("YBA Script", "All keybinds have been reset!")
        end
    })
    
    game:GetService("CoreGui").ChildRemoved:Connect(function(child)
        if child.Name:find("WindUI") or child.Name:find("Azure") then
            for _, conn in pairs(KeybindConnections) do
                if conn then
                    pcall(function() conn:Disconnect() end)
                end
            end
        end
    end)
end
local ConfigTab = SettingsTab
local ConfigManager = Window.ConfigManager
local ConfigName = "default"
local ConfigManager = Window.ConfigManager
local ConfigNameInput = ConfigTab:Input({
    Flag = "ConfigName",
    Title = "Config Name",
    Icon = "file-cog",
    Callback = function(value)
        ConfigName = value
end
})

local AllConfigs = ConfigManager:AllConfigs()
local DefaultValue = table.find(AllConfigs, ConfigName) and ConfigName or nil
ConfigTab:Dropdown({
    Title = "All Configs",
    Desc = "Select existing configs",
    Values = AllConfigs,
    Value = DefaultValue,
    Callback = function(value)
        ConfigName = value
        ConfigNameInput:Set(value)
end
})
ConfigTab:Space()
ConfigTab:Button({
    Title = "Save Config",
    Icon = "",
    Justify = "Center",
    Callback = function()
        Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
if Window.CurrentConfig:Save() then
            WindUI:Notify({
                Title = "Config Saved",
                Desc = "Config '" .. ConfigName .. "' saved",
                Icon = "check",
})
end
end
})
ConfigTab:Space()
ConfigTab:Button({
    Title = "Load Config",
    Icon = "",
    Justify = "Center",
    Callback = function()
        Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
if Window.CurrentConfig:Load() then
            WindUI:Notify({
                Title = "Config Loaded",
                Desc = "Config '" .. ConfigName .. "' loaded",
                Icon = "refresh-cw",
})
end
end
})
ConfigTab:Space()
ConfigTab:Button({
    Title = "Trash All Saved Configs",
    Icon = "trash-2",
    Justify = "Center",
    Callback = function()
        local allConfigs = ConfigManager:AllConfigs()
        local deletedCount = 0
        local failedCount = 0
        
        for _, configName in ipairs(allConfigs) do
            if configName ~= "default" then
                local success = pcall(function()
                    return ConfigManager:DeleteConfig(configName)
                end)
                if success then
                    deletedCount = deletedCount + 1
                else
                    failedCount = failedCount + 1
                end
            else
                local success = pcall(function()
                    return ConfigManager:DeleteConfig(configName)
                end)
                if success then
                    deletedCount = deletedCount + 1
                end
            end
        end
        
        local updatedConfigs = ConfigManager:AllConfigs()
        pcall(function()
            ConfigNameInput:Set("")
        end)
        
        WindUI:Notify({
            Title = "Configs Deleted",
            Desc = "Deleted " .. deletedCount .. " config(s)" .. (failedCount > 0 and " | Failed: " .. failedCount or ""),
            Icon = "trash",
            Duration = 5
        })
        
        ConfigName = "default"
    end
})

SettingsTab:Space()
SettingsTab:Dropdown({
        Title = "Advanced Config",
        Values = {
            {
                Title = "New file",
                Desc = "Create a new file",
                Icon = "file-plus",
                Callback = function() 
                    print("Clicked 'New File'")
                end
            },
            {
                Title = "Copy link",
                Desc = "Copy the file link",
                Icon = "copy",
                Callback = function() 
                    print("Clicked 'Copy link'")
                end
            },
            {
                Title = "Edit file",
                Desc = "Allows you to edit the file",
                Icon = "file-pen",
                Callback = function() 
                    print("Clicked 'Edit file'")
                end
            },
            {
                Type = "Divider",
            },
            {
                Title = "Delete file",
                Desc = "Permanently delete the file",
                Icon = "trash",
                Callback = function() 
                    print("Clicked 'Delete file'")
                end
            },
        }
    })
SettingsTab:Space()
SettingsTab:Section({
    Title = "Test Bypass",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
})
SettingsTab:Paragraph({
    Title = "Bypass Tester",
    Desc = "Click the button below to test if your executor supports the bypass methods.",
})

SettingsTab:Button({
    Title = "Test Bypass",
    Callback = function()
        local bypassSuccess, bypassError = pcall(function()
            local oldMagnitude = hookmetamethod(Vector3.new(), "__index", newcclosure(function(self, index)
                local CallingScript = tostring(getcallingscript())
                if not checkcaller() and index == "magnitude" and CallingScript == "ItemSpawn" then
                    return 0
                end
                return oldMagnitude(self, index)
            end))
            
            local UzuKeeIsRetardedAndDoesntKnowHowToMakeAnAntiCheatOnTheServerSideAlsoVexStfuIKnowTheCodeIsBadYouDontNeedToTellMe = "  ___XP DE KEY"
            local oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                local Method = getnamecallmethod()
                local Args = {...}
                if not checkcaller() and rawequal(self.Name, "Returner") and rawequal(Args[1], "idklolbrah2de") then
                    return UzuKeeIsRetardedAndDoesntKnowHowToMakeAnAntiCheatOnTheServerSideAlsoVexStfuIKnowTheCodeIsBadYouDontNeedToTellMe
                end
                return oldNc(self, ...)
            end))
            
            wait(0.1)
        end)

        if bypassSuccess then
            WindUI:Popup({
                Title = "Executor Supported",
                Icon = "check-circle",
                Content = "Your executor supports the bypass methods! You can use the script with reduced kick chance.",
                Buttons = {
                    {
                        Title = "Ok",
                        Icon = "cat",
                    }
                }
            })
            notify("YBA Script", "Bypass test passed! Executor supported.")
        else
            WindUI:Popup({
                Title = "Executor Not Supported",
                Icon = "bird",
                Content = "What is the error: " .. tostring(bypassError),
                Buttons = {
                    {
                        Title = "Ok",
                        Icon = "cat",
                    }
                }
            })
            notify("YBA Script", "Bypass test failed. Executor not supported.")
        end
    end
})
ConfigTab:Space()
ConfigTab:Dropdown({
    Flag = "ThemeChanger",
    Title = "Theme Changer",
    Values = {"Dark", "Light", "Rose", "Sky", "Plant", "Red", "Indigo", "Amber", "Violet", "Emerald", "Midnight", "Crimson", "MonokaiPro", "CottonCandy", "Rainbow", "AzuresTheme", "MethionGradient"},
    SearchBarEnabled = true,
    Value = "MethionGradient",
    Callback = function(theme)
        pcall(function()
            WindUI:SetTheme(theme)
        end)
        notify("YBA Script", "Theme changed to " .. theme)
    end
})
ConfigTab:Section({
    Title = "Report / Feedback",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
})

ConfigTab:Paragraph({
    Title = "Report Something",
    Desc = "Report bugs, features that don't work, or suggest new features. We review all reports and will consider adding suggested features.",
    TextSize = 14
})

local reportWebhook = "https://discord.com/api/webhooks/1479673229915455529/OmWvkYJe1i7o2-3kyNnXlbyFuLoHUA_rwo4kitLFCmqBr8tQRdooKkH-XJaPiXzYtrt5"

ConfigTab:Input({
        Title = "Report / Feedback",
        Type = "Textarea",
        Icon = "mouse",
        Placeholder = "Describe the issue or suggest a feature...",
    Callback = function(value)
        if value and value ~= "" then
            local success, err = pcall(function()
                local HttpService = game:GetService("HttpService")
                local data = {
                    embeds = {{
                        title = "Methion YBA Script - Report",
                        description = value,
                        color = 0xff0000,
                        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                        fields = {
                            {
                                name = "Username",
                                value = game.Players.LocalPlayer.Name,
                                inline = true
                            },
                            {
                                name = "UserId",
                                value = tostring(game.Players.LocalPlayer.UserId),
                                inline = true
                            },
                            {
                                name = "Executor",
                                value = identifyexecutor() or "Unknown",
                                inline = true
                            }
                        }
                    }}
                }
                
                local jsonData = HttpService:JSONEncode(data)
                
                local requestFunc = syn and syn.request or http_request or request or HttpPost
                if requestFunc then
                    requestFunc({
                        Url = reportWebhook,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = jsonData
                    })
                    notify("YBA Script", "Report sent successfully! Thank you for your feedback.")
                else
                    notify("YBA Script", "Failed to send report - executor not supported")
                end
            end)
            
            if not success then
                notify("YBA Script", "Error sending report: " .. tostring(err))
            end
        end
    end
})
ConfigTab:Button({
    Title = "Sent",
    Callback = function()
        local ok, err = pcall(function()
            sendReport(reportText)
            reportText = ""
        end)
    end
})

ConfigTab:Space()
ConfigTab:Keybind({
        Flag = "KeybindTest",
        Title = "Keybind",
        Desc = "Press to change keybind ui",
        Value = "K",
        Callback = function(v)
            Window:SetToggleKey(Enum.KeyCode[v])
        end
})
SettingsTab:Space()
SettingsTab:Button({
        Title = "Destroy Window",
        Color = Color3.fromHex("#ff4830"),
        Justify = "Center",
        Icon = "shredder",
        IconAlign = "Left",
        Callback = function()
            Window:Destroy()
        end
    })
notify("YBA Script", "Script loaded successfully.")
local function LoadSBRFeatures()
    if not SBRTab then
        warn("SBR: SBRTab not found!")
        return
    end
    
    local isSBR = game.PlaceId == 4643697430
    
    if not isSBR then
        SBRTab:Section({ Title = "⚠️ In Progress" })
        SBRTab:Section({ Title = "Steel Ball Run is on progress please do not use while we work on it" })
        SBRTab:Button({
            Title = "Teleport to SBR",
            Locked = true,
            LockedTitle = "Please do not use while we work on it",
            Callback = function()
                game.TeleportService:Teleport(4643697430, game.Players.LocalPlayer)
            end
        })
        return
    end
    
    local success, err = pcall(function()
        local Azure = {Utils = {}}
        Azure.__index = Azure
        Azure.Utils.__index = Azure.Utils

        function Azure.Utils.MakeUtilController(Settings)
            local Utils = {
                Tasks = {}; Services = {}; States = {}; Ints = {}; 
                Strings = {}; Tables = {}; Settings = Settings or {ConfigName = "AzureV3/SBRConfig.json"};
            }
            Utils.Services = setmetatable({}, {__index = function(self, service)
                if rawget(self, service) then return rawget(self, service) end
                local GotService = game:GetService(service)
                self[service] = GotService
                return self[service]
            end})
            return setmetatable(Utils, Azure.Utils)
        end

        function Azure.Utils:MakeFolder()
            if isfolder("AzureV3") == false then makefolder("AzureV3") end
        end

        function Azure.Utils:ReadData()
            self:MakeFolder()
            local Data; pcall(function()
                Data = self.Services.HttpService:JSONDecode(readfile(self.Settings.ConfigName))
            end);
            Data = Data or {Int={}, State={}, String={}, Table={}}
            return {
                Data = Data;
                LoadData = function()
                    self:AddValues(self:ConvertConfig(Data))
                end;
            }
        end

        function Azure.Utils:WriteData(Data)
            self:MakeFolder()
            local StringData = self.Services.HttpService:JSONEncode(Data)
            pcall(function() writefile(self.Settings.ConfigName, StringData) end)
        end

        function Azure.Utils:ConvertConfig(Config)
            local RepTable = Config
            for i,v in pairs(RepTable) do
                for ValName, ValueTable in pairs(v) do
                    if ValueTable["Value"] ~= nil then
                        local Val = ValueTable.Value
                        ValueTable["Value"] = nil
                        ValueTable[1] = Val
                    end
                end
            end
            return RepTable
        end

        function Azure.Utils:AddValues(Values)
            for key, value in pairs(Values) do
                if key:lower() == "int" then
                    for i,v in pairs(Values[key]) do
                        self.Ints[i] = (type(v) == "number" and {["Value"] = v, ["SaveValue"] = false} or type(v) == "table" and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]})
                    end
                end
                if key:lower() == "state" then
                    for i,v in pairs(Values[key]) do
                        self.States[i] = (type(v) == "boolean" and {["Value"] = v, ["SaveValue"] = false} or type(v) == "table" and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]})
                    end
                end
                if key:lower() == "string" then
                    for i,v in pairs(Values[key]) do
                        self.Strings[i] = (type(v) == "string" and {["Value"] = v, ["Value"] = false} or type(v) == "table" and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]})
                    end
                end
                if key:lower() == "table" then
                    for i,v in pairs(Values[key]) do
                        self.Tables[i] = ((v["SaveValue"] and v["SaveValue"] == true) and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]} or {["Value"] = v, ["SaveValue"] = false})
                    end
                end
            end
        end

        function Azure.Utils:GetInt(Value) return self.Ints[Value] and self.Ints[Value].Value or 0 end
        function Azure.Utils:GetString(Value) return self.Strings[Value] and self.Strings[Value].Value or "" end
        function Azure.Utils:GetState(Value) return self.States[Value] and self.States[Value].Value or false end
        function Azure.Utils:GetTable(Value) return self.Tables[Value] and self.Tables[Value].Value or {} end
        function Azure.Utils:SetInt(Value, NewValue) if self.Ints[Value] then self.Ints[Value].Value = NewValue end end
        function Azure.Utils:SetState(Value, NewValue) if self.States[Value] then self.States[Value].Value = NewValue end end
        function Azure.Utils:SetTable(Value, NewValue) if self.Tables[Value] then self.Tables[Value].Value = NewValue end end
        function Azure.Utils:ChangeTable(Value, TableIndex, NewValue) if self.Tables[Value] then self.Tables[Value].Value[TableIndex] = NewValue end end
        function Azure.Utils:AddTask(TaskName, Task) if not self.Tasks[TaskName] then self.Tasks[TaskName] = Task end return Task end
        function Azure.Utils:IsTaskRunning(TaskName) return self.Tasks[TaskName] and self.Tasks[TaskName].Connected end
        function Azure.Utils:DisconnectTask(TaskName) if self:IsTaskRunning(TaskName) then self.Tasks[TaskName]:Disconnect(); self.Tasks[TaskName] = nil end end
        function Azure.Utils:GetService(Service) return self.Services[Service] end
        function Azure.Utils:GetPlayer() return self.Services.Players.LocalPlayer end
        function Azure.Utils:GetCharacter() return self:GetPlayer().Character or self:GetPlayer().CharacterAdded:Wait() end
        function Azure.Utils:GetHumanoid() local Character = self:GetCharacter(); return Character and Character:FindFirstChildWhichIsA("Humanoid") end
        function Azure.Utils:GetHRP() local Character = self:GetCharacter(); return Character and Character:FindFirstChild("HumanoidRootPart") end
        function Azure.Utils:IsSBR() return game.PlaceId == 4643697430 end
        function Azure.Utils:GetHorse() local Name = self:GetPlayer().Name; return workspace:FindFirstChild(Name .."'s Horse") end
        function Azure.Utils:Teleport(CF, Offset) local Character = self:GetCharacter(); local FinalCF = typeof(CF) == "Vector3" and CFrame.new(CF) or CF; if Character and Character.PrimaryPart then Character.PrimaryPart.CFrame = FinalCF + (Offset or Vector3.new(0, 0, 0)) end end

        local SBR_Util = Azure.Utils.MakeUtilController()
        SBR_Util:ReadData():LoadData()

        SBR_Util:AddValues{
            ["Int"] = {
                ["SBR_Delay_1"] = 5; ["SBR_Delay_2"] = 5; ["SBR_Delay_3"] = 5;
                ["SBR_Delay_4"] = 5; ["SBR_Delay_5"] = 5; ["SBR_Delay_Hide"] = 5;
                ["HorseWalkSpeed"] = 16; ["HorseJumpPower"] = 50;
            };
            ["State"] = {
                ["Use_Horse_ASBR"] = false; ["RedBarrierNoClip"] = false; ["PlayerESP"] = false;
            };
            ["String"] = {}; ["Table"] = {};
        }

        local SBRTeleports = {}
        pcall(function()
            SBRTeleports = {
                ["Stage 1 Barrier"] = workspace:FindFirstChild("Barriers"):FindFirstChild("1").CFrame,
                ["Stage 2 Barrier"] = workspace:FindFirstChild("Barriers"):FindFirstChild("2").CFrame,
                ["Stage 3 Barrier"] = workspace:FindFirstChild("Barriers"):FindFirstChild("3").CFrame,
                ["Stage 4 Barrier"] = workspace:FindFirstChild("Map"):FindFirstChild("NYC Bridge"):FindFirstChild("Start").CFrame,
                ["Normal Hide"] = workspace:FindFirstChild("Map"):FindFirstChild("NYC Bridge"):FindFirstChild("NYC Bridge"):FindFirstChild("Bridge"):FindFirstChild("MeshPart").CFrame,
                ["Finish Hide"] = workspace:FindFirstChild("Map"):FindFirstChild("NYC Bridge"):FindFirstChild("Start").CFrame - Vector3.new(0,30,0),
                ["Finish Line Barrier"] = workspace:FindFirstChild("Map"):FindFirstChild("NYC Bridge"):FindFirstChild("End_Line").CFrame + Vector3.new(0,100,0)
            };
        end)

        local SBRSettingsSection = SBRTab:Section({ Title = "SBR Settings" })
        local AutoSBRSection = SBRTab:Section({ Title = "Auto SBR" })
        local HorseControlsSection = SBRTab:Section({ Title = "Horse Controls" })
        local PlayerTeleportSection = SBRTab:Section({ Title = "Player Teleports" })
        local HorseTeleportSection = SBRTab:Section({ Title = "Horse Teleports" })

        SBRSettingsSection:Toggle({
            Flag = "SBR_PlayerESP",
            Title = "Player ESP",
            Default = false,
            Callback = function(value)
                SBR_Util:SetState("PlayerESP", value)
                if value then
                    local Folder = Instance.new("Folder", game.CoreGui); Folder.Name = "SBR_PlayerESP"
                    local function setupPlayer(plr)
                        if plr == SBR_Util:GetPlayer() then return end
                        local function onChar(Chars)
                            local Highlight = Instance.new("Highlight", Folder); Highlight.OutlineColor = Color3.fromRGB(255, 255, 255); Highlight.Adornee = Chars; Highlight.FillColor = Color3.fromRGB(255, 255, 255); Highlight.FillTransparency = 1
                            local BGui = Instance.new("BillboardGui", Folder); BGui.Adornee = Chars:WaitForChild("Head"); BGui.StudsOffset = Vector3.new(0, 3, 0); BGui.AlwaysOnTop = true; BGui.Size = UDim2.new(4, 0, 0.5, 0)
                            local TextLabel = Instance.new("TextLabel", BGui); TextLabel.Size = UDim2.new(1, 0, 1, 0); TextLabel.BackgroundTransparency = 1; TextLabel.Text = Chars.Name; TextLabel.Font = Enum.Font.Ubuntu; TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255); TextLabel.TextScaled = false
                        end
                        SBR_Util:AddTask("SBR_Chr_"..plr.Name, plr.CharacterAdded:Connect(onChar))
                        if plr.Character then onChar(plr.Character) end
                    end
                    for _, plr in pairs(game.Players:GetPlayers()) do setupPlayer(plr) end
                    SBR_Util:AddTask("SBR_Chr2", game.Players.PlayerAdded:Connect(setupPlayer))
                else
                    if game.CoreGui:FindFirstChild("SBR_PlayerESP") then game.CoreGui.SBR_PlayerESP:Destroy() end
                    SBR_Util:DisconnectTask("SBR_Chr2")
                    for _, plr in pairs(game.Players:GetPlayers()) do SBR_Util:DisconnectTask("SBR_Chr_"..plr.Name) end
                end
            end
        })

        SBRSettingsSection:Toggle({ Flag = "SBR_UseHorse", Title = "Use Horse for Auto SBR", Default = false, Callback = function(value) SBR_Util:SetState("Use_Horse_ASBR", value) end })
        SBRSettingsSection:Slider({ Flag = "SBR_Delay1", Title = "TP to 1st Barrier Delay", Step = 1, Value = {Min = 1, Max = 60, Default = 5}, Callback = function(value) SBR_Util:SetInt("SBR_Delay_1", value) end })
        SBRSettingsSection:Slider({ Flag = "SBR_Delay2", Title = "TP to 2nd Barrier Delay", Step = 1, Value = {Min = 1, Max = 60, Default = 5}, Callback = function(value) SBR_Util:SetInt("SBR_Delay_2", value) end })
        SBRSettingsSection:Slider({ Flag = "SBR_Delay3", Title = "TP to 3rd Barrier Delay", Step = 1, Value = {Min = 1, Max = 60, Default = 5}, Callback = function(value) SBR_Util:SetInt("SBR_Delay_3", value) end })
        SBRSettingsSection:Slider({ Flag = "SBR_Delay4", Title = "TP to Last Barrier Delay", Step = 1, Value = {Min = 1, Max = 60, Default = 5}, Callback = function(value) SBR_Util:SetInt("SBR_Delay_4", value) end })
        SBRSettingsSection:Slider({ Flag = "SBR_Delay5", Title = "TP to End Delay", Step = 1, Value = {Min = 1, Max = 20, Default = 5}, Callback = function(value) SBR_Util:SetInt("SBR_Delay_5", value) end })
        SBRSettingsSection:Slider({ Flag = "SBR_HideDelay", Title = "Hide Delay", Step = 1, Value = {Min = 1, Max = 10, Default = 5}, Callback = function(value) SBR_Util:SetInt("SBR_Delay_Hide", value) end })

        AutoSBRSection:Toggle({
            Flag = "SBR_AutoRace",
            Title = "Auto SBR",
            Default = false,
            Callback = function(value)
                if value then
                    local HRP = SBR_Util:GetState("Use_Horse_ASBR") and SBR_Util:GetHorse().HumanoidRootPart or SBR_Util:GetHRP()
                    if not HRP then notify("SBR", "Character not loaded!"); return end
                    HRP.CFrame = SBRTeleports["Normal Hide"]
                    repeat task.wait() until workspace.Barrier:FindFirstChild("StartBarrier") == nil
                    task.wait(SBR_Util:GetInt("SBR_Delay_1")); HRP.CFrame = SBRTeleports["Stage 1 Barrier"]
                    task.wait(SBR_Util:GetInt("SBR_Delay_Hide")); HRP.CFrame = SBRTeleports["Normal Hide"]
                    repeat task.wait() until workspace.Barriers:FindFirstChild("1") == nil
                    task.wait(SBR_Util:GetInt("SBR_Delay_2")); HRP.CFrame = SBRTeleports["Stage 2 Barrier"]
                    task.wait(SBR_Util:GetInt("SBR_Delay_Hide")); HRP.CFrame = SBRTeleports["Normal Hide"]
                    repeat task.wait() until workspace.Barriers:FindFirstChild("2") == nil
                    task.wait(SBR_Util:GetInt("SBR_Delay_3")); HRP.CFrame = SBRTeleports["Stage 3 Barrier"]
                    task.wait(SBR_Util:GetInt("SBR_Delay_Hide")); HRP.CFrame = SBRTeleports["Normal Hide"]
                    repeat task.wait() until workspace.Barriers:FindFirstChild("3") == nil
                    task.wait(SBR_Util:GetInt("SBR_Delay_4")); HRP.CFrame = SBRTeleports["Stage 4 Barrier"]
                    task.wait(SBR_Util:GetInt("SBR_Delay_Hide"))
                    repeat task.wait(); HRP.CFrame = SBRTeleports["Finish Hide"] until workspace.Barriers:FindFirstChild("4") == nil
                    task.wait(SBR_Util:GetInt("SBR_Delay_5")); HRP.CFrame = SBRTeleports["Stage 4 Barrier"]
                    task.wait(SBR_Util:GetInt("SBR_Delay_Hide")); HRP.CFrame = SBRTeleports["Finish Hide"]
                end
            end
        })

        AutoSBRSection:Toggle({
            Flag = "SBR_NoClip",
            Title = "Red Barrier No-Clip",
            Default = false,
            Callback = function(value)
                SBR_Util:SetState("RedBarrierNoClip", value)
                pcall(function()
                    for _, v in pairs(workspace.Barrier:GetChildren()) do v.CanCollide = not value end
                    for _, v in pairs(workspace.Barriers:GetChildren()) do v.CanCollide = not value end
                end)
            end
        })

        HorseControlsSection:Slider({ Flag = "SBR_HorseSpeed", Title = "Horse WalkSpeed", Step = 1, Value = {Min = 0, Max = 120, Default = 16}, Callback = function(value) SBR_Util:SetInt("HorseWalkSpeed", value); local horse = SBR_Util:GetHorse(); if horse then horse.Humanoid.WalkSpeed = value end end })
        HorseControlsSection:Slider({ Flag = "SBR_HorseJump", Title = "Horse JumpPower", Step = 1, Value = {Min = 0, Max = 100, Default = 50}, Callback = function(value) SBR_Util:SetInt("HorseJumpPower", value); local horse = SBR_Util:GetHorse(); if horse then horse.Humanoid.JumpPower = value; pcall(function() SBR_Util:DisconnectTask("HJP") end); SBR_Util:AddTask("HJP", game.UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent) if not gameProcessedEvent and inputObject.KeyCode == Enum.KeyCode.Space then local horse = SBR_Util:GetHorse(); if horse then horse.Humanoid.Jump = true end end end)) end end })
        HorseControlsSection:Button({ Flag = "SBR_TeleportHorse", Title = "Teleport Horse to Me", Callback = function() local horse = SBR_Util:GetHorse(); if horse then horse.PrimaryPart.CFrame = SBR_Util:GetHRP().CFrame else notify("SBR", "Horse not found!") end end })

        if SBRTeleports and next(SBRTeleports) then
            for place, cframe in pairs(SBRTeleports) do
                PlayerTeleportSection:Button({ Flag = "SBR_PTP_"..place, Title = place, Callback = function() local HRP = SBR_Util:GetHRP(); if HRP then HRP.CFrame = cframe else notify("SBR", "Character not loaded!") end end })
            end
        else
            PlayerTeleportSection:Section({ Title = "Teleports not loaded - try refreshing" })
        end

        PlayerTeleportSection:Button({ Flag = "SBR_PTP_Horse", Title = "Teleport to Horse", Callback = function() local horse = SBR_Util:GetHorse(); if horse and horse:FindFirstChild("HumanoidRootPart") then SBR_Util:GetHRP().CFrame = horse.HumanoidRootPart.CFrame else notify("SBR", "Horse not found!") end end })

        if SBRTeleports and next(SBRTeleports) then
            for place, cframe in pairs(SBRTeleports) do
                HorseTeleportSection:Button({ Flag = "SBR_HTP_"..place, Title = place, Callback = function() local horse = SBR_Util:GetHorse(); if horse then horse.PrimaryPart.CFrame = cframe else notify("SBR", "Horse not found!") end end })
            end
        else
            HorseTeleportSection:Section({ Title = "Teleports not loaded - try refreshing" })
        end
    end)
    
    if not success then
        warn("SBR Load Error: " .. tostring(err))
        SBRTab:Section({ Title = "⚠️ Error loading SBR features" })
        SBRTab:Section({ Title = "Error: " .. tostring(err) })
    end
end

LoadSBRFeatures()
local TeleportService = game:GetService("TeleportService")
spawn(function()
while true do
wait(1)
pcall(function()
local coreGui = game:GetService("CoreGui")
local prompt = coreGui:FindFirstChild("RobloxPromptGui")
if prompt then
local overlay = prompt:FindFirstChild("promptOverlay")
if overlay then
local errorPrompt = overlay:FindFirstChild("ErrorPrompt")
if errorPrompt and errorPrompt.Visible then
local titleFrame = errorPrompt:FindFirstChild("TitleFrame")
if titleFrame then
local errorTitle = titleFrame:FindFirstChild("ErrorTitle")
if errorTitle and (string.lower(errorTitle.Text):find("disconnect") or string.lower(errorTitle.Text):find("kicked")) then
                                notify("YBA Script", "Detected kick/disconnect. Rejoining the server...")
                                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end
end
                    end
                end
            end
        end)
    end
end)
Window:SetToggleKey(Enum.KeyCode.K)

do
    local function getCharacter()
        return player.Character or player.CharacterAdded:Wait()
    end
    
    local ItemsSection = ShopTab:Section({
        Title = "Items"
    })
    
    ItemsSection:Button({
        Title = "Buy Rokakaka ($2,500)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Rokakaka"}, 1, 2)
            notify("YBA Script", "Bought Rokakaka")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Pure Rokakaka ($4,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Pure Rokakaka"}, 1, 2)
            notify("YBA Script", "Bought Pure Rokakaka")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Mysterious Arrow ($750)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Mysterious Arrow"}, 1, 2)
            notify("YBA Script", "Bought Mysterious Arrow")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Lucky Arrow ($75,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Lucky Arrow"}, 1, 2)
            notify("YBA Script", "Bought Lucky Arrow")
        end
    })

local autoBuyLuckyArrow = false
local luckyArrowPrice = 75000

ItemsSection:Toggle({
    Flag = "AutoBuyLuckyArrow",
    Title = "Auto Buy Lucky Arrow",
    Default = false,
    Callback = function(value)
        autoBuyLuckyArrow = value
        if value then
            notify("YBA Script", "Auto Buy Lucky Arrow enabled! Will buy when money reaches $" .. luckyArrowPrice)
            
            spawn(function()
                while autoBuyLuckyArrow do
                    wait(1)
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        if not player then return end
                        
                        local stats = player:FindFirstChild("PlayerStats")
                        if not stats then return end
                        
                        local money = stats:FindFirstChild("Money")
                        if not money then return end
                        
                        local currentCount = 0
                        local maxLuckyArrows = 10
                        
                        local marketplaceService = game:GetService("MarketplaceService")
                        local has2x = pcall(function()
                            return marketplaceService:UserOwnsGamePassAsync(player.UserId, 14597778)
                        end) and marketplaceService:UserOwnsGamePassAsync(player.UserId, 14597778)
                        
                        if has2x then
                            maxLuckyArrows = 20
                        end
                        
                        if player.Backpack then
                            for _, item in pairs(player.Backpack:GetChildren()) do
                                if item.Name == "Lucky Arrow" then
                                    currentCount = currentCount + 1
                                end
                            end
                        end
                        
                        if player.Character then
                            for _, item in pairs(player.Character:GetChildren()) do
                                if item.Name == "Lucky Arrow" then
                                    currentCount = currentCount + 1
                                end
                            end
                        end
                        
                        if money.Value >= luckyArrowPrice and currentCount < maxLuckyArrows then
                            local char = player.Character
                            if char and char:FindFirstChild("RemoteEvent") then
                                char.RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Lucky Arrow"}, 1, 2)
                                notify("YBA Script", "Auto-bought Lucky Arrow! ($" .. luckyArrowPrice .. ") - Have: " .. (currentCount + 1) .. "/" .. maxLuckyArrows)
                                wait(2)
                            end
                        end
                    end)
                end
            end)
        else
            notify("YBA Script", "Auto Buy Lucky Arrow disabled.")
        end
    end
})
    
    ItemsSection:Button({
        Title = "Buy DIO's Diary ($20,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x DIO's Diary"}, 1, 2)
            notify("YBA Script", "Bought DIO's Diary")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Rib Cage ($3,500)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Rib Cage of The Saint's Corpse"}, 1, 2)
            notify("YBA Script", "Bought Rib Cage")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Left Arm ($15,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Left Arm of The Saint's Corpse"}, 1, 2)
            notify("YBA Script", "Bought Left Arm")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Pelvis ($45,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Pelvis of The Saint's Corpse"}, 1, 2)
            notify("YBA Script", "Bought Pelvis")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Heart ($45,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PurchaseShopItem", {["ItemName"] = "1x Heart of The Saint's Corpse"}, 1, 2)
            notify("YBA Script", "Bought Heart")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Mysterious Bow ($Idk?)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Mysterious Bow Seller", ["Dialogue"] = "Dialogue4", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Mysterious Bow")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Pizza ($50)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Pizza", ["Option"] = "Option1", ["Dialogue"] = "Dialogue2"}, 1, 2)
            notify("YBA Script", "Bought Pizza")
        end
    })
    
    ItemsSection:Button({
        Title = "Buy Tea ($50)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Cafe", ["Option"] = "Option1", ["Dialogue"] = "Dialogue2"}, 1, 2)
            notify("YBA Script", "Bought Tea")
        end
    })
    
    ShopTab:Space()
    
    local SpecsSection = ShopTab:Section({
        Title = "Fighting Styles"
    })
    
    SpecsSection:Button({
        Title = "Buy Hamon ($15,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["Dialogue"] = "Dialogue5", ["NPC"] = "Jonathan", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Hamon")
        end
    })
    
    SpecsSection:Button({
        Title = "Buy Boxing ($10,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["Dialogue"] = "Dialogue5", ["NPC"] = "Quinton", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Boxing")
        end
    })
    
    SpecsSection:Button({
        Title = "Buy Spin ($10,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["Dialogue"] = "Dialogue5", ["NPC"] = "Gyro", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Spin")
        end
    })
    
    SpecsSection:Button({
        Title = "Buy Vampire ($10,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["Dialogue"] = "Dialogue5", ["NPC"] = "Elder Vampire Roomy", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Vampire")
        end
    })
    
    SpecsSection:Button({
        Title = "Buy Pluck ($10,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["Dialogue"] = "Dialogue5", ["NPC"] = "Uzurashi", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Pluck")
        end
    })
    
    SpecsSection:Button({
        Title = "Buy Boxing Gloves ($1,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["Dialogue"] = "Dialogue1", ["NPC"] = "Boxing Gloves", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Boxing Gloves")
        end
    })
    
    SpecsSection:Button({
        Title = "Buy Sword ($1,000)",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("EndDialogue", {["Dialogue"] = "Dialogue1", ["NPC"] = "Pluck", ["Option"] = "Option1"})
            notify("YBA Script", "Bought Sword")
        end
    })

    ShopTab:Space()

    local DialoguesSection = ShopTab:Section({
        Title = "Halloween Dialogue"
    })
    
    DialoguesSection:Button({
        Title = "Halloween Event Dialogue",
        Callback = function()
            getCharacter().RemoteEvent:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue:FindFirstChild("Halloween Event"))
            notify("YBA Script", "Opened Halloween Shop")
        end
    })
    
    notify("YBA Script", "Shop tab loaded successfully!")
end
local function LoadStandFarmFeatures()
    local Azure = {Utils={}}
    Azure.__index = Azure
    Azure.Utils.__index = Azure.Utils
    
    local v3 = Vector3.new
    local cf = CFrame.new
    
    function Azure.Utils.MakeUtilController(Settings)
        local Utils = {
            Tasks = {};
            Tweens = {};
            Services = {};
            States = {};
            Ints = {};
            Strings = {};
            Tables = {};
            Settings = Settings or {ConfigName = "Azure/AzureConfig.json"};
        }
        Utils.Services = setmetatable({}, {__index = function(self, service)
            if rawget(self, service) then return rawget(self, service) end
            local GotService = game:GetService(service)
            self[service] = GotService
            return self[service]
        end})
        return setmetatable(Utils, Azure.Utils)
    end
    
    function Azure.Utils:GetService(Service) return self.Services[Service] end
    function Azure.Utils:GetPlayer() return self.Services.Players.LocalPlayer end
    function Azure.Utils:GetCharacter() return self:GetPlayer().Character or self:GetPlayer().CharacterAdded:Wait() end
    function Azure.Utils:GetHumanoid() local Character = self:GetCharacter(); return Character and Character:FindFirstChildWhichIsA("Humanoid") end
    function Azure.Utils:GetHRP() local Character = self:GetCharacter(); return Character and Character:FindFirstChild("HumanoidRootPart") end
    function Azure.Utils:GetRoot() local Character = self:GetCharacter(); return Character and Character:FindFirstChild("LowerTorso"):FindFirstChild("Root") end
    function Azure.Utils:HasStand() return self:GetPlayer().PlayerStats.Stand.Value ~= "None" end
    function Azure.Utils:CheckStand() return self:GetPlayer().PlayerStats.Stand.Value end
    function Azure.Utils:CheckShiny()
        local Character = self:GetCharacter()
        if not Character:FindFirstChild("RemoteFunction") then Character:WaitForChild("RemoteFunction") end
        if Character and Character:FindFirstChild("RemoteFunction") then
            return Character.RemoteFunction:InvokeServer("ReturnStandSkin", "Stand")
        else return "None" end
    end
    function Azure.Utils:HasShiny()
        local Character = self:GetCharacter()
        local ShinyThing = Character and Character:FindFirstChild("RemoteFunction") and Character.RemoteFunction:InvokeServer("ReturnStandSkin", "Stand")
        return ShinyThing ~= "None" and ShinyThing ~= nil
    end
    function Azure.Utils:CountItem(Item)
        local Backpack = self:GetPlayer().Backpack
        local Count = 0
        for _, v in pairs(Backpack:GetChildren()) do if v.Name == Item then Count = Count + 1 end end
        local Char = self:GetCharacter()
        if Char and Char:FindFirstChildWhichIsA("Tool") and Char:FindFirstChildWhichIsA("Tool").Name == Item then Count += 1 end
        return Count
    end
    function Azure.Utils:IsMax(Item)
        local Max = {
            ["Diamond"] = 30, ["Gold Coin"] = 45, ["Mysterious Arrow"] = 25, ["Pure Rokakaka"] = 10,
            ["Rokakaka"] = 25, ["Stone Mask"] = 10, ["Rib Cage of The Saint's Corpse"] = 10,
            ["Steel Ball"] = 10, ["Ancient Scroll"] = 10, ["Dio's Diary"] = 10, ["Caesar's Headband"] = 10,
            ["Christmas Present"] = 45, ["Quinton's Glove"] = 10, ["Lucky Arrow"] = 10
        }
        local gp = game:GetService("MarketplaceService")
        local has2x = gp and gp:UserOwnsGamePassAsync(self:GetPlayer().UserId, 14597778)
        if has2x then for i,v in pairs(Max) do Max[i] = v * 2 end end
        return self:CountItem(Item) >= (Max[Item] or 999)
    end
    function Azure.Utils:Teleport(CF, Offset)
        local Character = self:GetCharacter()
        local FinalCF = typeof(CF) == "Vector3" and cf(CF) or CF
        if Character and Character.PrimaryPart then
            Character.PrimaryPart.CFrame = FinalCF + (Offset or v3(0, 0, 0))
        end
    end
    function Azure.Utils:LearnSkills(Skills)
        if workspace.Living:FindFirstChild(self:GetPlayer().Name) and workspace.Living:FindFirstChild(self:GetPlayer().Name):FindFirstChild("RemoteFunction") then
            for _, v in pairs(Skills) do
                workspace.Living:WaitForChild(self:GetPlayer().Name, 15).RemoteFunction:InvokeServer("LearnSkill", {
                    ["Skill"] = v,
                    ["SkillTreeType"] = "Character",
                })
            end
        end
    end
    function Azure.Utils:Stats()
        repeat task.wait() until self:GetCharacter() and self:GetCharacter():FindFirstChild("RemoteEvent")
        local Skills = {"Agility I", "Agility II", "Agility III", "Worthiness"}
        if self:GetState("Rib Farm") or self:GetState("Rib Shiny Farm") then
            table.insert(Skills, #Skills+1, "Worthiness II")
            table.insert(Skills, #Skills+1, "Worthiness III")
            table.insert(Skills, #Skills+1, "Worthiness IV")
            table.insert(Skills, #Skills+1, "Worthiness V")
        end
        self:LearnSkills(Skills)
    end
    function Azure.Utils:UseRoka()
    if not self:GetPlayer().Backpack:FindFirstChild("Rokakaka") then return end
    if self:GetPlayer().PlayerStats.Stand.Value == "None" then return end
    
    local player = self:GetPlayer()
    local character = self:GetCharacter()
    local humanoid = self:GetHumanoid()
    
    if not humanoid then return end
    
    local roka = player.Backpack:FindFirstChild("Rokakaka")
    if not roka then return end
    
    humanoid:EquipTool(roka)
    task.wait(0.5)
    
    for i = 1, 10 do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.05)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
        task.wait(0.05)
    end
    
    task.wait(0.5)
    
    local startTime = tick()
    local dialogueGui = nil
    
    while tick() - startTime < 3 do
        dialogueGui = player.PlayerGui:FindFirstChild("DialogueGui")
        if dialogueGui then break end
        task.wait(0.1)
    end
    
    if not dialogueGui then 
        local remote = character:FindFirstChild("RemoteEvent")
        if remote then
            pcall(function()
                remote:FireServer("UseItem", roka)
            end)
        end
        task.wait(1)
        return
    end
    
    task.wait(0.3)
    
    local clicked = false
    local clickStart = tick()
    
    while tick() - clickStart < 3 and not clicked do
        local success, err = pcall(function()
            local frame = dialogueGui:FindFirstChild("Frame")
            if not frame then return end
            
            local options = frame:FindFirstChild("Options")
            if not options then return end
            
            local option1 = options:FindFirstChild("Option1")
            if not option1 then return end
            
            local textButton = option1:FindFirstChild("TextButton")
            if not textButton then return end
            
            for _, conn in pairs(getconnections(textButton.MouseButton1Click)) do
                conn:Fire()
            end
            
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
            
            local remote = character:FindFirstChild("RemoteEvent")
            if remote then
                remote:FireServer("EndDialogue", {
                    ["NPC"] = "Rokakaka",
                    ["Option"] = "Option1",
                    ["Dialogue"] = "Dialogue2"
                })
            end
            
            clicked = true
        end)
        
        if not success then
            warn("Click error:", err)
        end
        
        task.wait(0.1)
    end
    
    task.wait(0.5)
    startTime = tick()
    while tick() - startTime < 5 do
        if not player.PlayerGui:FindFirstChild("DialogueGui") then
            break
        end
        if player.Character ~= character then
            break
        end
        task.wait(0.1)
    end
    
    if player.Character == character then
        player.CharacterAdded:Wait()
    end
end
function Azure.Utils:UseArrow()
    if not self:GetPlayer().Backpack:FindFirstChild("Mysterious Arrow") then return end
    if self:GetPlayer().PlayerStats.Stand.Value ~= "None" then return end
    
    local player = self:GetPlayer()
    local character = self:GetCharacter()
    local humanoid = self:GetHumanoid()
    
    if not humanoid then return end
    
    local arrow = player.Backpack:FindFirstChild("Mysterious Arrow")
    if not arrow then return end
    
    humanoid:EquipTool(arrow)
    task.wait(0.5)
    
    local dialogueOpened = false
    local startTime = tick()
    
    while tick() - startTime < 10 and not dialogueOpened do
        for i = 1, 5 do
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
            task.wait(0.05)
        end
        
        task.wait(0.5)
        
        if player.PlayerGui:FindFirstChild("DialogueGui") then
            dialogueOpened = true
            break
        end
        
        task.wait(1)
    end
    
    if not dialogueOpened then 
        local remote = character:FindFirstChild("RemoteEvent")
        if remote then
            pcall(function()
                remote:FireServer("UseItem", arrow)
            end)
        end
        task.wait(2)
        return
    end
    
    local dialogueGui = player.PlayerGui:FindFirstChild("DialogueGui")
    local lastClickTime = 0
    
    while dialogueGui and dialogueGui.Parent and player.Character == character do
        if tick() - lastClickTime >= 1 then
            lastClickTime = tick()
            
            pcall(function()
                local frame = dialogueGui:FindFirstChild("Frame")
                if not frame then return end
                
                local options = frame:FindFirstChild("Options")
                if not options then return end
                
                local option1 = options:FindFirstChild("Option1")
                if not option1 then return end
                
                local textButton = option1:FindFirstChild("TextButton")
                if not textButton then return end
                
                for _, conn in pairs(getconnections(textButton.MouseButton1Click)) do
                    conn:Fire()
                end
                
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.05)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                
                local remote = character:FindFirstChild("RemoteEvent")
                if remote then
                    remote:FireServer("EndDialogue", {
                        ["NPC"] = "Mysterious Arrow",
                        ["Option"] = "Option1",
                        ["Dialogue"] = "Dialogue2"
                    })
                end
            end)
        end
        
        task.wait(0.1)
        dialogueGui = player.PlayerGui:FindFirstChild("DialogueGui")
    end
    
    if player.Character == character then
        player.CharacterAdded:Wait()
    end
end
    function Azure.Utils:UseRib()
        local Arguments = {
            [1] = "EndDialogue",
            [2] = {
                ["NPC"] = "Rib Cage of The Saint's Corpse",
                ["Option"] = "Option1",
                ["Dialogue"] = "Dialogue2"
            }
        }
        self:GetCharacter().RemoteEvent:FireServer(unpack(Arguments))
    end
    function Azure.Utils:Collect(Item)
        local Character = self:GetCharacter()
        local HRP = self:GetHRP()
        if not (Item and Item.PrimaryPart and Character and HRP) then return end
        local OldCF = HRP.CFrame
        local startTime = tick()
        
        local clipConn = game:GetService("RunService").Stepped:Connect(function()
            for _, v in pairs(Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
        end)
        
        HRP.CFrame = Item.PrimaryPart.CFrame - v3(0, 10, 0)
        task.wait(0.3)
        repeat
            fireproximityprompt(Item:FindFirstChild("ProximityPrompt"))
            if Item.Parent == workspace.Item_Spawns.Items then
                HRP.CFrame = Item.PrimaryPart.CFrame - v3(0, 10, 0)
            end
            task.wait()
        until Item.Parent ~= workspace.Item_Spawns.Items or tick() - startTime >= 3.5
        task.wait(0.6)
        HRP.CFrame = OldCF
        clipConn:Disconnect()
    end
    function Azure.Utils:AddTask(TaskName, Task)
        if not self.Tasks[TaskName] then self.Tasks[TaskName] = Task end
        return Task
    end
    function Azure.Utils:IsTaskRunning(TaskName) return self.Tasks[TaskName] and self.Tasks[TaskName].Connected end
    function Azure.Utils:DisconnectTask(TaskName) if self:IsTaskRunning(TaskName) then self.Tasks[TaskName]:Disconnect(); self.Tasks[TaskName] = nil end end
    function Azure.Utils:AddValues(Values)
        for key, value in pairs(Values) do
            if key:lower() == "int" then
                for i,v in pairs(Values[key]) do
                    self.Ints[i] = (type(v) == "number" and {["Value"] = v, ["SaveValue"] = false} or type(v) == "table" and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]})
                end
            end
            if key:lower() == "state" then
                for i,v in pairs(Values[key]) do
                    self.States[i] = (type(v) == "boolean" and {["Value"] = v, ["SaveValue"] = false} or type(v) == "table" and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]})
                end
            end
            if key:lower() == "string" then
                for i,v in pairs(Values[key]) do
                    self.Strings[i] = (type(v) == "string" and {["Value"] = v, ["SaveValue"] = false} or type(v) == "table" and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]})
                end
            end
            if key:lower() == "table" then
                for i,v in pairs(Values[key]) do
                    self.Tables[i] = ((v["SaveValue"] and v["SaveValue"] == true) and {["Value"] = v[1], ["SaveValue"] = v["SaveValue"]} or {["Value"] = v, ["SaveValue"] = false})
                end
            end
        end
    end
    function Azure.Utils:GetInt(Value) return self.Ints[Value] and self.Ints[Value].Value or 0 end
    function Azure.Utils:GetString(Value) return self.Strings[Value] and self.Strings[Value].Value or "" end
    function Azure.Utils:GetState(Value) return self.States[Value] and self.States[Value].Value or false end
    function Azure.Utils:GetTable(Value) return self.Tables[Value] and self.Tables[Value].Value or {} end
    function Azure.Utils:SetInt(Value, NewValue) if self.Ints[Value] then self.Ints[Value].Value = NewValue end end
    function Azure.Utils:SetState(Value, NewValue) if self.States[Value] then self.States[Value].Value = NewValue end end
    function Azure.Utils:SetTable(Value, NewValue) if self.Tables[Value] then self.Tables[Value].Value = NewValue end end
    function Azure.Utils:InsertTable(Value, InsertedValue) if self.Tables[Value] then table.insert(self.Tables[Value].Value, InsertedValue) end end
    function Azure.Utils:RemoveTable(Value, RemovedValue) if self.Tables[Value] then table.remove(self.Tables[Value].Value, table.find(self.Tables[Value].Value, RemovedValue)) end end
    function Azure.Utils:FindTable(Value, TableIndex) return table.find(self.Tables[Value].Value, TableIndex) end

    local Util = Azure.Utils.MakeUtilController()
    
    Util:AddValues{
        ["Int"] = {
            ["Speed"] = 16; ["Jump"] = 50; ["FlySpeed"] = 0.5; ["TSDelay"] = 0.8;
            ["Item Collection Delay"] = 0.6; ["Prediction Strength"] = 0.5; ["Stand Attach Distance"] = 2.5;
            ["InfTick"] = tick(); ["InfDelay"] = 1; ["DashPower"] = 50;
        };
        ["State"] = {
            ["Speed"] = false; ["Jump"] = false; ["God Mode"] = false; ["Anti Vamp Burn"] = false;
            ["Item ESP"] = false; ["Item Notify"] = false; ["Stand Farm"] = false; ["Rib Farm"] = false;
            ["Shiny Farm"] = false; ["Rib Shiny Farm"] = false; ["Safe Farm"] = false;
            ["Use Redeemed"] = false; ["Keep any shiny"] = false; ["Waiting"] = false;
            ["CompletedQuest"] = true; ["Auto Sprinting"] = false; ["View Stand"] = false;
            ["Follow Stand"] = false; ["Auto Sell"] = false; ["Infinite Dash"] = false;
        };
        ["String"] = {
            ["Stand"] = ""; ["Shiny"] = ""; ["Chosen Player"] = ""; ["TrollingPlayer"] = "";
            ["Pity"] = ""; ["Webhook"] = "";
        };
        ["Table"] = {
            Stands = {}; Shinys = {}; Queue = {}; AnimsList = {}; Poses = {};
            AnimsBlacklist = {"Ice Skating", "Stunned", "StandAppear", "StandDisappear"};
            AllMods = {}; AllItems = {"Christmas Present", "Mysterious Arrow", "Pure Rokakaka", "Rokakaka", "Diamond", "Lucky Arrow", "Lucky Stone Mask", "Dio's Diary", "Steel Ball", "Rib Cage of The Saint's Corpse", "Stone Mask", "Gold Coin", "Quinton's Glove", "Ancient Scroll"};
            AllStands = {"Whitesnake", "Stone Free", "Star Platinum", "The World", "Crazy Diamond", "Killer Queen", "Gold Experience", "King Crimson", "Silver Chariot", "Hermit Purple", "The Hand", "Purple Haze", "Cream", "Hierophant Green", "Magician's Red", "White Album", "Aerosmith", "Six Pistols", "Beach Boy", "Mr. President", "Sticky Fingers", "Anubis", "Red Hot Chili Pepper", "Scary Monsters", "The World Alternate Universe", "D4C", "Tusk ACT 1", "Soft & Wet"};
            AllShinys = {
                "Action-Figure Platinum", "Actually Red Hot Chili Pepper", "Aerosmith Over Heaven", "All-Starsnake", "Anti-Umbral", "Asuna", "Biblically Accurate Experience", "Blade Of The Exile", "Casull", "Charmy Green", "Chromo", "Comic Venom", "Cracked World", "Crazy Ruby", "Crazy Idol", "Creeper Queen", "D4She", "Devil4c", "Deimos Queen", "Deimos Snake", "Eldritch Hierophant", "Elizabeth Liones", "Elucidator & Dark Repulser", "Emperor", "Emperor OVA", "Female The Hand", "Frozone", "Glock-18", "Glock-18 Fade", "Gold Platinum", "Golden Frieza", "Gold & Wet", "Headhunter", "Heaven Spirit", "Tentacle Black", "Tentacle Purple", "Tentacle Yellow", "Holly's Sickness", "Jade Peace", "Jaguar Platinum", "Kanshou & Bakuya", "Kikoku", "Killer Reveal", "King of The End", "Linked Sword", "Luffy Gear 4", "Magellan", "Magician's Red: Over Heaven", "Manga Crimson", "Megumin", "Mintsnake", "Misaka Mikoto", "Mr. Joestar", "Ms. Aerosmith", "Neon Ascension", "Neo World", "Nerf Jolt", "Nocturne", "Nonosama Bo", "ODM Gear", "OVA Silver Chariot", "Old President", "Pinky Fingers", "Queen Crimson", "Rock Unleashed", "Sakura", "Shadow Killer Queen", "Shadow The World", "Sorcerer's Ember", "Spider-Man", "Sasageyo", "Star Platinum OVA", "Star Striped Eagle", "Star Waifu", "Stone Platinum", "The Other Hand", "The Waifu v2", "The Waifu: Alternate Universe", "The World: Greatest High", "The World 2", "The World OVA", "The World Ultimate", "Toy Sticky Fingers", "Tsunade", "Uber Spy", "Whisper", "Vanilla Ice Cream", "Venom", "Vinegar Crimson", "Virus Vessel", "Jack-O-Platinum", "Ghost World", "Crazy Overseer", "Tyrant Crimson", "Jester Crimson", "Vexus Crimson", "Pumpkin Patch", "Cornsnake", "Crimson Mist", "Dead Experience", "Undead Hand", "Undead Flare", "Bloodthirster"
            };
            Cache = {["Speed"] = 16; ["Jump"] = 50; ["Waypoint"] = nil; ["Spawnpoint"] = nil;};
            CachedAssets = {}; Keybinds = {}; ShinyToggles = {}; ItemSellToggles = {}; ChosenItemsToSell = {};
        };
    }
    
    if game.PlaceId ~= 2809202155 then
        local Folder = Instance.new("Folder", workspace)
        Folder.Name = "Item_Spawns"
        local Folder2 = Instance.new("Folder", Folder)
        Folder2.Name = "Items"
    end
    
    local MapFolder = Instance.new("Folder", workspace)
    for _, Part in workspace.Map:GetChildren() do
        task.spawn(function() Part.Parent = MapFolder end)
    end
    
    local StandFarmSettings = StandFarmTab:Section({ Title = "Stand Farm Settings" })
    local RibFarmSettings = StandFarmTab:Section({ Title = "Rib Farm Settings" })
    local ShinyFarmSettings = StandFarmTab:Section({ Title = "Shiny Farm Settings" })
    local standFarmRunning = false
    local ribFarmRunning = false
    local shinyFarmRunning = false
    local ribShinyFarmRunning = false
    
    local function AddToQueue(Item)
        local function Identify(Item)
            repeat task.wait() until Item:FindFirstChildWhichIsA("ProximityPrompt")
            for _, v in pairs(Item:GetChildren()) do
                if v:IsA("ProximityPrompt") and v.MaxActivationDistance > 0 then
                    return v.ObjectText
                end
            end
            return "Invalid Item"
        end
        
        local IdentifiedItem = Identify(Item)
        if IdentifiedItem ~= "Invalid Item" then
            repeat task.wait() until Item:FindFirstChild("ProximityPrompt")
            local ItemData = {CFrame = Item.PrimaryPart.CFrame, ItemName = IdentifiedItem, ItemModel = Item}
            local ESPPart = Instance.new("Part", workspace)
            ESPPart.Name = IdentifiedItem
            ESPPart.CFrame = ItemData.CFrame
            ESPPart.Anchored = true
            ESPPart.CanCollide = false
            ESPPart.Transparency = 1
            
            local Billboard = Instance.new("BillboardGui", ESPPart)
            Billboard.AlwaysOnTop = true
            Billboard.Size = UDim2.new(8, 0, 2, 0)
            Billboard.StudsOffset = Vector3.new(0, 2, 0)
            Billboard.Name = "AzureESP"
            Billboard.Enabled = false
            
            local ESPLabel = Instance.new("TextLabel", Billboard)
            ESPLabel.Size = UDim2.new(0, 100, 0, 100)
            ESPLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            ESPLabel.BackgroundTransparency = 1
            ESPLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            ESPLabel.Text = IdentifiedItem
            ESPLabel.TextColor3 = Color3.new(1, 1, 1)
            ESPLabel.TextStrokeTransparency = 0
            
            task.spawn(function()
                while task.wait(0.1) do
                    if Item.Parent == workspace.Item_Spawns.Items and Item.PrimaryPart then
                        Billboard.Enabled = true
                        ESPLabel.Text = IdentifiedItem .. " (" .. math.round((Util:GetHRP().Position - Item.PrimaryPart.Position).Magnitude) .. "m)"
                    else
                        ESPPart:Destroy()
                        break
                    end
                end
            end)
            
            Util:ChangeTable("Queue", Item:FindFirstChild("ProximityPrompt"), ItemData)
        end
    end
    
    StandFarmSettings:Toggle({
        Flag = "StandFarm_UseRedeemed",
        Title = "Use Redeemed Items",
        Default = false,
        Callback = function(State)
            Util:SetState("Use Redeemed", State)
        end
    })
    
    StandFarmSettings:Toggle({
        Flag = "StandFarm_KeepAnyShiny",
        Title = "Keep Any Shiny",
        Default = false,
        Callback = function(State)
            Util:SetState("Keep any shiny", State)
        end
    })
    
    StandFarmSettings:Toggle({
    Flag = "StandFarm_Enabled",
    Title = "Enable Stand Farm",
    Default = false,
    Callback = function(State)
        if State then
            local selectedStands = Util:GetTable("Stands")
            local keepAnyShiny = Util:GetState("Keep any shiny")
            
            if #selectedStands == 0 and not keepAnyShiny then
                notify("Stand Farm", "No stands selected! Please select stands to farm first, or enable 'Keep Any Shiny'")
                StandFarmSettings:Set("StandFarm_Enabled", false)
                return
            end
            
            if keepAnyShiny and #selectedStands == 0 then
                notify("Stand Farm", "Keep Any Shiny enabled - will farm for ANY shiny stand")
            end
            
            standFarmRunning = true
            notify("Stand Farm", "Stand farming started!")
            
            local function GetMax(Item)
                local Max = {
                    ["Mysterious Arrow"] = 25, ["Rokakaka"] = 25,
                    ["Diamond"] = 30, ["Gold Coin"] = 45, ["Pure Rokakaka"] = 10,
                    ["Stone Mask"] = 10, ["Rib Cage of The Saint's Corpse"] = 10,
                    ["Steel Ball"] = 10, ["Ancient Scroll"] = 10, ["Dio's Diary"] = 10,
                    ["Caesar's Headband"] = 10, ["Christmas Present"] = 45,
                    ["Quinton's Glove"] = 10, ["Lucky Arrow"] = 10
                }
                local gp = game:GetService("MarketplaceService")
                local has2x = gp and gp:UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 14597778)
                if has2x then 
                    for i,v in pairs(Max) do Max[i] = v * 2 end 
                end
                return Max[Item] or 999
            end
            
            local function CountItem(Item)
                local player = game.Players.LocalPlayer
                local Backpack = player.Backpack
                local Count = 0
                for _, v in pairs(Backpack:GetChildren()) do 
                    if v.Name == Item then Count = Count + 1 end 
                end
                local Char = player.Character
                if Char and Char:FindFirstChildWhichIsA("Tool") and Char:FindFirstChildWhichIsA("Tool").Name == Item then 
                    Count = Count + 1 
                end
                return Count
            end

            local function LearnWorthiness()
                local player = game.Players.LocalPlayer
                local Character = player.Character or player.CharacterAdded:Wait()
                local remoteFunc = Character:FindFirstChild("RemoteFunction")
                
                if not remoteFunc then 
                    notify("Stand Farm", "RemoteFunction not found, waiting...")
                    return false 
                end
                
                local worthinessSkills = {
                    "Worthiness", "Worthiness II", "Worthiness III", 
                    "Worthiness IV", "Worthiness V"
                }
                
                for _, skill in pairs(worthinessSkills) do
                    pcall(function()
                        remoteFunc:InvokeServer("LearnSkill", {
                            ["Skill"] = skill,
                            ["SkillTreeType"] = "Character"
                        })
                    end)
                    task.wait(0.1)
                end
                
                return true
            end
            
            local noclipEnabled = false
            local noclipConn = nil
            local function EnableNoclip()
                if noclipEnabled then return end
                local Character = game.Players.LocalPlayer.Character
                if not Character then return end
                noclipConn = game:GetService("RunService").Stepped:Connect(function()
                    for _, p in pairs(Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end)
                noclipEnabled = true
            end
            
            local function DisableNoclip()
                if noclipConn then noclipConn:Disconnect() end
                noclipEnabled = false
            end
            
                        task.spawn(function()
                local buyingCooldown = 0
                local lastItemFarm = 0
                local itemFarmDelay = 0.6
                
                local noclipConnection = nil
                local function enableNoclipNow()
                    if noclipConnection then
                        pcall(function() noclipConnection:Disconnect() end)
                    end
                    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                        local char = game.Players.LocalPlayer.Character
                        if not char then return end
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end)
                end
                
                local function disableNoclipNow()
                    if noclipConnection then
                        pcall(function() noclipConnection:Disconnect() end)
                        noclipConnection = nil
                    end
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = true
                            end
                        end
                    end
                end
                
                while standFarmRunning do
                    task.wait(0.5)

                    local player = game.Players.LocalPlayer
                    local Character = player.Character or player.CharacterAdded:Wait()
                    local HRP = Character:FindFirstChild("HumanoidRootPart")
                    if not HRP then continue end
                    
                    if not Character:FindFirstChild("WorthinessLearned") then
                        LearnWorthiness()
                        local marker = Instance.new("BoolValue")
                        marker.Name = "WorthinessLearned"
                        marker.Value = true
                        marker.Parent = Character
                    end
                    
                    local currentStand = player.PlayerStats.Stand.Value
                    local currentShiny = Util:CheckShiny()
                    
                    if currentStand ~= "None" then
                        local isTargetStand = Util:FindTable("Stands", currentStand)
                        local isShiny = currentShiny ~= "None" and currentShiny ~= nil and currentShiny ~= ""
                        
                        if isTargetStand then
                            if isShiny then
                                notify("Stand Farm", "Got desired SHINY: " .. currentStand .. " [" .. currentShiny .. "]!")
                            else
                                notify("Stand Farm", "Got desired stand: " .. currentStand)
                            end
                            standFarmRunning = false
                            StandFarmSettings:Set("StandFarm_Enabled", false)
                            disableNoclipNow()
                            break
                        end
                        
                        if keepAnyShiny and isShiny then
                            notify("Stand Farm", "Got shiny stand: " .. currentStand .. " [" .. currentShiny .. "]!")
                            standFarmRunning = false
                            StandFarmSettings:Set("StandFarm_Enabled", false)
                            disableNoclipNow()
                            break
                        end
                    end
                    
                    local arrowCount = CountItem("Mysterious Arrow")
                    local rokaCount = CountItem("Rokakaka")
                    local maxArrows = GetMax("Mysterious Arrow")
                    local maxRokas = GetMax("Rokakaka")
                    
                    if currentStand ~= "None" then
                        if rokaCount > 0 then
                            disableNoclipNow()
                            
                            local humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                            local roka = player.Backpack:FindFirstChild("Rokakaka") or Character:FindFirstChild("Rokakaka")
                            
                            if humanoid and roka then
                                humanoid:EquipTool(roka)
                                task.wait(0.5)
                                
                                for i = 1, 5 do
                                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 8, 0, true, nil, 1)
                                    task.wait(0.1)
                                end
                                
                                local dialogueGui = nil
                                local startTime = tick()
                                while tick() - startTime < 5 do
                                    dialogueGui = player.PlayerGui:FindFirstChild("DialogueGui")
                                    if dialogueGui then break end
                                    task.wait(0.1)
                                end
                                
                                if dialogueGui then
                                    pcall(function()
                                        repeat
                                            firesignal(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                                            task.wait(0.1)
                                        until dialogueGui.Frame.Options:FindFirstChild("Option1")
                                        
                                        firesignal(dialogueGui.Frame.Options.Option1.TextButton.MouseButton1Click)
                                        
                                        repeat
                                            firesignal(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                                            task.wait(0.1)
                                        until dialogueGui.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
                                        
                                        firesignal(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                                    end)
                                end
                                
                                task.wait(0.5)
                                player.CharacterAdded:Wait()
                                task.wait(1.5)
                            end
                            continue
                        end
                    end
                    
                    if currentStand == "None" and arrowCount > 0 then
                        disableNoclipNow()
                        
                        local humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                        local arrow = player.Backpack:FindFirstChild("Mysterious Arrow") or Character:FindFirstChild("Mysterious Arrow")
                        
                        if humanoid and arrow then
                            humanoid:EquipTool(arrow)
                            task.wait(0.5)
                            
                            for i = 1, 5 do
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 8, 0, true, nil, 1)
                                task.wait(0.1)
                            end
                            
                            local dialogueGui = nil
                            local startTime = tick()
                            while tick() - startTime < 5 do
                                dialogueGui = player.PlayerGui:FindFirstChild("DialogueGui")
                                if dialogueGui then break end
                                task.wait(0.1)
                            end
                            
                            if dialogueGui then
                                pcall(function()
                                    repeat
                                        firesignal(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                                        task.wait(0.1)
                                    until dialogueGui.Frame.Options:FindFirstChild("Option1")
                                    
                                    firesignal(dialogueGui.Frame.Options.Option1.TextButton.MouseButton1Click)
                                    
                                    repeat
                                        firesignal(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                                        task.wait(0.1)
                                    until dialogueGui.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
                                    
                                    firesignal(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                                end)
                            end
                            
                            task.wait(2)
                            
                            local newStand = player.PlayerStats.Stand.Value
                            if newStand ~= "None" then
                                local newShiny = Util:CheckShiny()
                                local isTarget = Util:FindTable("Stands", newStand)
                                local isShiny = newShiny ~= "None" and newShiny ~= nil
                                
                                if keepAnyShiny and isShiny then
                                    notify("Stand Farm", "Got shiny: " .. newStand .. "!")
                                    standFarmRunning = false
                                    StandFarmSettings:Set("StandFarm_Enabled", false)
                                    break
                                elseif isTarget and not keepAnyShiny then
                                    notify("Stand Farm", "Got target: " .. newStand)
                                    standFarmRunning = false
                                    StandFarmSettings:Set("StandFarm_Enabled", false)
                                    break
                                end
                            end
                            
                            if player.Character ~= Character then
                                player.CharacterAdded:Wait()
                                task.wait(1.5)
                            end
                        end
                        continue
                    end
                    
                    local needArrow = arrowCount < maxArrows
                    local needRoka = rokaCount < maxRokas
                    
                    if tick() - lastItemFarm < itemFarmDelay then
                        task.wait(itemFarmDelay - (tick() - lastItemFarm))
                    end
                    
                    if needArrow or needRoka then
                        lastItemFarm = tick()
                        local itemsFarmed = false
                        
                        enableNoclipNow()
                        task.wait(0.1)
                        
                        local spawns = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
                        if spawns then
                            for _, v in pairs(spawns:GetChildren()) do
                                if not standFarmRunning then break end
                                
                                arrowCount = CountItem("Mysterious Arrow")
                                rokaCount = CountItem("Rokakaka")
                                if arrowCount >= maxArrows and rokaCount >= maxRokas then
                                    break
                                end

                                local prox = v:FindFirstChild("ProximityPrompt")
                                local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChild("Part") or v.PrimaryPart

                                if prox and part and part.Transparency < 1 then
                                    local itemName = prox.ObjectText
                                    
                                    local needThisItem = false
                                    if itemName == "Mysterious Arrow" and arrowCount < maxArrows then
                                        needThisItem = true
                                    elseif itemName == "Rokakaka" and rokaCount < maxRokas then
                                        needThisItem = true
                                    end
                                    
                                    if needThisItem then
                                        itemsFarmed = true
                                        notify("Stand Farm", "Farming " .. itemName .. " (" .. CountItem(itemName) .. "/" .. (itemName == "Mysterious Arrow" and maxArrows or maxRokas) .. ")")
                                        
                                        local origCFrame = HRP.CFrame
                                        local targetPos = part.Position
                                        
                                        HRP.CFrame = CFrame.new(targetPos - Vector3.new(0, 6, 0))
                                        HRP.Velocity = Vector3.new(0, 0, 0)
                                        HRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                        
                                        task.wait(0.3)
                                        
                                        local stickStart = tick()
                                        local collected = false
                                        
                                        while tick() - stickStart < 3 do
                                            if not v or not v.Parent then
                                                collected = true
                                                break
                                            end
                                            
                                            if not part or not part.Parent then
                                                collected = true
                                                break
                                            end
                                            
                                            HRP.CFrame = CFrame.new(part.Position - Vector3.new(0, 6, 0))
                                            HRP.Velocity = Vector3.new(0, 0, 0)
                                            HRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                            
                                            pcall(function()
                                                fireproximityprompt(prox, 0, true)
                                            end)
                                            
                                            if CountItem(itemName) > (itemName == "Mysterious Arrow" and arrowCount or rokaCount) then
                                                collected = true
                                                break
                                            end
                                            
                                            task.wait(0.1)
                                        end
                                        
                                        HRP.CFrame = origCFrame
                                        HRP.Velocity = Vector3.new(0, 0, 0)
                                        HRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                        
                                        task.wait(0.5)
                                        
                                        arrowCount = CountItem("Mysterious Arrow")
                                        rokaCount = CountItem("Rokakaka")
                                    end
                                end
                            end
                        end
                        
                        disableNoclipNow()
                        
                        if not itemsFarmed and arrowCount == 0 and rokaCount == 0 and tick() > buyingCooldown then
                            local money = player.PlayerStats.Money.Value
                            local remote = Character:FindFirstChild("RemoteEvent")
                            
                            if money >= 3250 and remote then
                                notify("Stand Farm", "Buying items from shop...")
                                
                                remote:FireServer("PurchaseShopItem", {["ItemName"] = "1x Rokakaka"}, 1, 2)
                                task.wait(0.8)
                                
                                remote:FireServer("PurchaseShopItem", {["ItemName"] = "1x Mysterious Arrow"}, 1, 2)
                                task.wait(0.8)
                                
                                buyingCooldown = tick() + 5
                            elseif money < 3250 then
                                notify("Stand Farm", "Need more money to buy items!")
                                task.wait(5)
                            end
                        end
                    end
                end
                
                disableNoclipNow()
            end)
        else
            standFarmRunning = false
            notify("Stand Farm", "Stand farming stopped!")
        end
    end
})
    
    local standDropdown = StandFarmTab:Dropdown({
        Flag = "StandDropdown",
        Title = "Select Stands to Farm",
        Values = Util:GetTable("AllStands"),
        SearchBarEnabled = true,
        AllowNone = true,
        Multi = true,
        Callback = function(selected)
            Util:SetTable("Stands", selected)
        end
    })
    
    RibFarmSettings:Toggle({
        Flag = "RibFarm_Enabled",
        Title = "Enable Rib Farm",
        Default = false,
        Callback = function(State)
            if State then
                ribFarmRunning = true
                notify("Rib Farm", "Rib farming started!")
                
                local HRP = Util:GetHRP()
                
                task.spawn(function()
                    while ribFarmRunning do
                        task.wait()
                        if Util:CountItem("Rib Cage of The Saint's Corpse") == 0 then
                            FarmItems({"Rib Cage of The Saint's Corpse"})
                        end
                        
                        if Util:HasStand() and Util:FindTable("Stands", Util:CheckStand()) then
                            if not Util:GetState("Waiting") then
                                notify("Rib Farm", "You have the stand you wanted: " .. Util:CheckStand())
                                Util:SetState("Waiting", true)
                                ribFarmRunning = false
                                RibFarmSettings:Set("RibFarm_Enabled", false)
                                break
                            end
                        else
                            Util:SetState("Waiting", false)
                        end
                        
                        if ribFarmRunning then
                            Util:Stats()
                            Util:UseRib()
                            repeat task.wait() until Util:HasStand()
                        end
                    end
                end)
            else
                ribFarmRunning = false
                Util:DisconnectTask("SafeFarm")
                notify("Rib Farm", "Rib farming stopped!")
            end
        end
    })
    
    ShinyFarmSettings:Toggle({
        Flag = "ShinyFarm_Enabled",
        Title = "Enable Shiny Farm",
        Default = false,
        Callback = function(State)
            if State then
                shinyFarmRunning = true
                notify("Shiny Farm", "Shiny farming started!")
                
                local HRP = Util:GetHRP()
                
                task.spawn(function()
                    while shinyFarmRunning do
                        task.wait(0.1)
                        
                        if Util:CountItem("Mysterious Arrow") == 0 or Util:CountItem("Rokakaka") == 0 then
                            FarmItems({"Rokakaka", "Mysterious Arrow", "Lucky Arrow"})
                        end
                        
                        if Util:FindTable("ShinyToggles", Util:CheckShiny()) then
                            for _, Instance in pairs(Util:GetPlayer().PlayerGui.HUD.Main.Frames.Stands.ScrollingFrame:GetChildren()) do
                                if Instance:FindFirstChild("TextLabel") and string.find(Instance.TextLabel.Text, "None") then
                                    Util:GetCharacter().RemoteEvent:FireServer("SwapStand", tostring(Instance.Name))
                                    Util:GetPlayer().CharacterAdded:Wait()
                                    break
                                end
                            end
                            continue
                        end
                        
                        if Util:HasStand() and Util:HasShiny() and Util:FindTable("ShinyToggles", Util:CheckShiny()) then
                            if not Util:GetState("Waiting") then
                                notify("Shiny Farm", "You have the shiny you wanted: " .. Util:CheckShiny())
                                Util:SetState("Waiting", true)
                                shinyFarmRunning = false
                                ShinyFarmSettings:Set("ShinyFarm_Enabled", false)
                                break
                            else
                                continue
                            end
                        end
                        
                        Util:SetState("Waiting", false)
                        
                        if Util:HasStand() and ((Util:HasShiny() and not Util:FindTable("ShinyToggles", Util:CheckShiny())) or not Util:HasShiny()) then
                            Util:UseRoka()
                            repeat task.wait() until Util:GetCharacter() and Util:GetCharacter():FindFirstChild("RemoteEvent")
                        end
                        
                        if not Util:HasStand() and shinyFarmRunning then
                            Util:Stats()
                            Util:UseArrow()
                            repeat task.wait() until Util:HasStand()
                        end
                    end
                end)
            else
                shinyFarmRunning = false
                Util:DisconnectTask("SafeFarm")
                notify("Shiny Farm", "Shiny farming stopped!")
            end
        end
    })
    
    ShinyFarmSettings:Toggle({
        Flag = "RibShinyFarm_Enabled",
        Title = "Enable Rib Shiny Farm",
        Default = false,
        Callback = function(State)
            if State then
                ribShinyFarmRunning = true
                notify("Rib Shiny Farm", "Rib shiny farming started!")
                
                local HRP = Util:GetHRP()
                
                task.spawn(function()
                    while ribShinyFarmRunning do
                        task.wait()
                        if Util:CountItem("Rib Cage of The Saint's Corpse") == 0 then
                            FarmItems({"Rib Cage of The Saint's Corpse"})
                        end
                        
                        if Util:HasStand() and Util:FindTable("ShinyToggles", Util:CheckShiny()) then
                            if not Util:GetState("Waiting") then
                                notify("Rib Shiny Farm", "You have the shiny you wanted: " .. Util:CheckShiny())
                                Util:SetState("Waiting", true)
                                ribShinyFarmRunning = false
                                ShinyFarmSettings:Set("RibShinyFarm_Enabled", false)
                                break
                            else
                                continue
                            end
                        end
                        
                        Util:SetState("Waiting", false)
                        
                        if ribShinyFarmRunning then
                            Util:Stats()
                            Util:UseRib()
                            repeat task.wait() until Util:HasStand()
                        end
                    end
                end)
        else
                ribShinyFarmRunning = false
                Util:DisconnectTask("SafeFarm")
                notify("Rib Shiny Farm", "Rib shiny farming stopped!")
            end
        end
    })
    
    
    
    local shinyDropdown = ShinySelection:Dropdown({
        Flag = "ShinyDropdown",
        Title = "Select Shinies to Farm",
        Values = Util:GetTable("AllShinys"),
        Multi = true,
        Callback = function(selected)
            Util:SetTable("Shinys", selected)
        end
    })
    
    task.spawn(function()
        if workspace.Item_Spawns and workspace.Item_Spawns.Items then
            for _, v in pairs(workspace.Item_Spawns.Items:GetChildren()) do
                AddToQueue(v)
            end
            workspace.Item_Spawns.Items.ChildAdded:Connect(function(Child)
                task.wait(0.1)
                AddToQueue(Child)
            end)
        end
    end)
    
    notify("YBA Script", "Stand Farm features loaded successfully!")
end
local function LoadQuestFeatures()

    local function GetPlayer()
        return game.Players.LocalPlayer
    end

    local function GetCharacter()
        return GetPlayer().Character or GetPlayer().CharacterAdded:Wait()
    end

    local function GetHRP()
        local Character = GetCharacter()
        return Character and Character:FindFirstChild("HumanoidRootPart")
    end

    local function EquipStand()
    local Character = GetCharacter()
    if not Character then return end
    
    local shouldEquip = getgenv().QuestMethod == "With Stand"
    local hasStandSummoned = Character:FindFirstChild("SummonedStand") and Character.SummonedStand.Value
    
    if Character:FindFirstChild("RemoteFunction") then
        if shouldEquip and not hasStandSummoned then
            pcall(function()
                Character.RemoteFunction:InvokeServer("ToggleStand", "Toggle")
            end)
        elseif not shouldEquip and hasStandSummoned then
            pcall(function()
                Character.RemoteFunction:InvokeServer("ToggleStand", "Toggle")
            end)
        end
    end
end

local function HasStand()
    local player = GetPlayer()
    if player and player:FindFirstChild("PlayerStats") and player.PlayerStats:FindFirstChild("Stand") then
        local standValue = player.PlayerStats.Stand.Value
        if standValue ~= "None" and standValue ~= "" and standValue ~= nil then
            return true
        end
    end
    return false
end

local function CollectRokaArrow()    
    local blacklistedStands = {
        ["Six Pistols"] = true,
        ["Hermit Purple"] = true,
        ["Aerosmith"] = true,
        ["Beach Boy"] = true,
        ["Mr. President"] = true,
        ["White Album"] = true,
        ["Anubis"] = true,
        ["Tusk ACT 1"] = true,
    }
    
    local function LearnWorthiness()
        local Character = GetCharacter()
        if not Character or not Character:FindFirstChild("RemoteFunction") then return end
        
        local worthinessSkills = {"Worthiness", "Worthiness II", "Worthiness III", "Worthiness IV", "Worthiness V"}
        for _, skill in pairs(worthinessSkills) do
            pcall(function()
                Character.RemoteFunction:InvokeServer("LearnSkill", {
                    ["Skill"] = skill,
                    ["SkillTreeType"] = "Character"
                })
            end)
            task.wait(0.1)
        end
    end
    
    local targetItems = {"Rokakaka", "Mysterious Arrow"}
    local collected = {Rokakaka = false, ["Mysterious Arrow"] = false}
    
    local function CountItem(itemName)
        local count = 0
        local ply = GetPlayer()
        if ply and ply:FindFirstChild("Backpack") then
            for _, item in pairs(ply.Backpack:GetChildren()) do
                if item.Name == itemName then count = count + 1 end
            end
        end
        if ply and ply.Character then
            for _, item in pairs(ply.Character:GetChildren()) do
                if item.Name == itemName then count = count + 1 end
            end
        end
        return count
    end
    
    LearnWorthiness()
    task.wait(0.5)
    
    while getgenv().QuestFarmEnabled and not (collected.Rokakaka and collected["Mysterious Arrow"]) do
        local Character = GetCharacter()
        local HRP = GetHRP()
        if not Character or not HRP then task.wait(0.5) continue end
        
        if CountItem("Rokakaka") >= 1 then collected.Rokakaka = true end
        if CountItem("Mysterious Arrow") >= 1 then collected["Mysterious Arrow"] = true end
        
        if collected.Rokakaka and collected["Mysterious Arrow"] then break end
        
        local spawns = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
        if spawns then
            for _, v in pairs(spawns:GetChildren()) do
                if not getgenv().QuestFarmEnabled then return false end
                
                local prox = v:FindFirstChild("ProximityPrompt")
                local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChild("Part") or v:FindFirstChild("PrimaryPart")
                
                if prox and part and part.Transparency < 1 then
                    local itemName = prox.ObjectText
                    if table.find(targetItems, itemName) and not collected[itemName] then
                        
                        local oldCF = HRP.CFrame
                        HRP.CFrame = part.CFrame - Vector3.new(0, 3, 0)
                        task.wait(0.2)
                        
                        local noclipConn = game:GetService("RunService").Stepped:Connect(function()
                            for _, p in pairs(Character:GetDescendants()) do
                                if p:IsA("BasePart") then p.CanCollide = false end
                            end
                        end)
                        
                        for i = 1, 5 do
                            fireproximityprompt(prox, 0, true)
                            task.wait(0.1)
                        end
                        
                        noclipConn:Disconnect()
                        HRP.CFrame = oldCF
                        task.wait(0.3)
                        break
                    end
                end
            end
        end
        
        if not (collected.Rokakaka and collected["Mysterious Arrow"]) then
            local money = GetPlayer().PlayerStats.Money.Value
            local remote = Character:FindFirstChild("RemoteEvent")
            
            if money >= 3250 and remote then
                if not collected.Rokakaka then
                    remote:FireServer("PurchaseShopItem", {["ItemName"] = "1x Rokakaka"}, 1, 2)
                    task.wait(0.8)
                end
                if not collected["Mysterious Arrow"] then
                    remote:FireServer("PurchaseShopItem", {["ItemName"] = "1x Mysterious Arrow"}, 1, 2)
                    task.wait(0.8)
                end
            end
        end
        
        task.wait(0.5)
    end
    
    if collected.Rokakaka and collected["Mysterious Arrow"] then
        
        local maxAttempts = 100
        local attempts = 0
        
        while getgenv().QuestFarmEnabled and attempts < maxAttempts do
            attempts = attempts + 1
            local player = GetPlayer()
            if not player then task.wait(0.5) continue end
            
            local Character = GetCharacter()
            if not Character then task.wait(0.5) continue end
            
            local currentStand = "None"
            if player:FindFirstChild("PlayerStats") and player.PlayerStats:FindFirstChild("Stand") then
                currentStand = player.PlayerStats.Stand.Value
            end
            
            if currentStand ~= "None" then
                notify("YBA Script", "Got stand: " .. currentStand .. " (checking if valid)...")
                task.wait(0.5)
                
                if blacklistedStands[currentStand] then
                    notify("YBA Script", "Got blacklisted stand: " .. currentStand .. " - Rokaka'ing...")
                    
                    local roka = player.Backpack:FindFirstChild("Rokakaka") or Character:FindFirstChild("Rokakaka")
                    
                    if not roka then
                        notify("YBA Script", "No Rokakaka! Collecting more...")
                        collected.Rokakaka = false
                        collected["Mysterious Arrow"] = false
                        break
                    end
                    
                    local humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid and roka then
                        humanoid:EquipTool(roka)
                        task.wait(0.5)
                        
                        local remote = Character:FindFirstChild("RemoteEvent")
                        if remote then
                            remote:FireServer("UseItem", roka)
                        end
                        
                        for i = 1, 10 do
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 8, 0, true, nil, 1)
                            task.wait(0.1)
                        end
                        
                        local dialogueWaitTime = 0
                        local dialogueGui = nil
                        while dialogueWaitTime < 3 do
                            dialogueGui = player.PlayerGui:FindFirstChild("DialogueGui")
                            if dialogueGui then break end
                            task.wait(0.1)
                            dialogueWaitTime = dialogueWaitTime + 0.1
                        end
                        
                        if dialogueGui then
                            task.wait(0.5)
                            local options = dialogueGui:FindFirstChild("Options", true)
                            if options then
                                local option1 = options:FindFirstChild("Option1")
                                if option1 then
                                    local textBtn = option1:FindFirstChild("TextButton")
                                    if textBtn then
                                        for _, conn in pairs(getconnections(textBtn.MouseButton1Click)) do
                                            conn:Fire()
                                        end
                                    end
                                end
                            end
                        end
                        
                        player.CharacterAdded:Wait()
                        task.wait(1.5)
                        
                        LearnWorthiness()
                        task.wait(0.5)
                    end
                    continue
                else
                    task.wait(1)
                    return true
                end
            end
            
            if currentStand == "None" then
                local arrow = player.Backpack:FindFirstChild("Mysterious Arrow") or Character:FindFirstChild("Mysterious Arrow")
                
                if not arrow then
                    notify("YBA Script", "No arrows! Collecting more...")
                    collected.Rokakaka = false
                    collected["Mysterious Arrow"] = false
                    break
                end
                
                local humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid and arrow then
                    humanoid:EquipTool(arrow)
                    task.wait(0.5)
                    
                    local remote = Character:FindFirstChild("RemoteEvent")
                    if remote then
                        remote:FireServer("UseItem", arrow)
                    end
                    
                    for i = 1, 10 do
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 8, 0, true, nil, 1)
                        task.wait(0.1)
                    end
                    
                    local dialogueWaitTime = 0
                    local dialogueGui = nil
                    while dialogueWaitTime < 3 do
                        dialogueGui = player.PlayerGui:FindFirstChild("DialogueGui")
                        if dialogueGui then break end
                        task.wait(0.1)
                        dialogueWaitTime = dialogueWaitTime + 0.1
                    end
                    
                    if dialogueGui then
                        task.wait(0.5)
                        local options = dialogueGui:FindFirstChild("Options", true)
                        if options then
                            local option1 = options:FindFirstChild("Option1")
                            if option1 then
                                local textBtn = option1:FindFirstChild("TextButton")
                                if textBtn then
                                    for _, conn in pairs(getconnections(textBtn.MouseButton1Click)) do
                                        conn:Fire()
                                    end
                                end
                            end
                        end
                    end
                    
                    task.wait(2)
                    
                    local newStand = player.PlayerStats.Stand.Value
                    if newStand ~= "None" then
                        if not blacklistedStands[newStand] then
                            notify("YBA Script", "stand obtained: " .. newStand .. "! Farming...")
                            task.wait(1)
                            return true
                        end
                    end
                    
                    if player.Character ~= Character then
                        player.CharacterAdded:Wait()
                        task.wait(1.5)
                        LearnWorthiness()
                        task.wait(0.5)
                    end
                end
                continue
            end
            
            task.wait(0.5)
        end
        
        if attempts >= maxAttempts then
            notify("YBA Script", "Max attempts reached, stopping stand farm.")
            return false
        end
        
        if not (collected.Rokakaka and collected["Mysterious Arrow"]) then
            return false
        end
    end
    
    return false
end

    local function UseMove(Move)
        local Character = GetCharacter()
        if not Character then return end
        if Move:lower() == "m1" or Move:lower() == "m2" then
            if Character:FindFirstChild("RemoteFunction") then
                pcall(function() Character.RemoteFunction:InvokeServer("Attack", Move) end)
            end
        end
    end

    local function KillEnemy(Enemy)
        if not Enemy then return end
        local enemyHRP = Enemy:FindFirstChild("HumanoidRootPart")
        local enemyHumanoid = Enemy:FindFirstChildWhichIsA("Humanoid")
        local enemyHealth = Enemy:FindFirstChild("Health")
        if not (enemyHRP and enemyHumanoid and enemyHealth) or enemyHealth.Value <= 0 then
            return
        end

        local oldPos
        local hrp = GetHRP()
        if hrp then oldPos = hrp.CFrame end

        local FocusCam = nil

        while Enemy and Enemy.Parent and enemyHRP and enemyHumanoid and enemyHealth and enemyHealth.Value > 0 do
            if not getgenv().NPCFarmEnabled and not getgenv().QuestFarmEnabled then break end
            if getgenv().QuestFarmEnabled then
                local ply = GetPlayer()
                if ply and ply:FindFirstChild("PlayerStats") and ply.PlayerStats:FindFirstChild("QuestProgress") and ply.PlayerStats:FindFirstChild("QuestMaxProgress") then
                    if ply.PlayerStats.QuestProgress.Value >= ply.PlayerStats.QuestMaxProgress.Value then
                        getgenv().CompletedQuest = true
                        break
                    end
                end
            end

            enemyHRP = Enemy:FindFirstChild("HumanoidRootPart")
            enemyHumanoid = Enemy:FindFirstChildWhichIsA("Humanoid")
            enemyHealth = Enemy:FindFirstChild("Health")
            if not (enemyHRP and enemyHumanoid and enemyHealth) or enemyHealth.Value <= 0 then
                task.wait(0.215)
                break
            end

            local Character = GetCharacter()
            if Character and Character:FindFirstChildWhichIsA("Humanoid") and Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
if getgenv().QuestMethod == "With Stand" then
    if not HasStand() then
        local success = CollectRokaArrow()
        if not success then
            return
        end
    end
    EquipStand()
else
    EquipStand()
end

                if Character:FindFirstChild("FocusCam") == nil then
                    FocusCam = Instance.new("ObjectValue", Character)
                    FocusCam.Name = "FocusCam"
                    FocusCam.Value = enemyHRP
                else
                    local camVal = Character:FindFirstChild("FocusCam")
                    if camVal then camVal.Value = enemyHRP end
                end

                if GetPlayer().PlayerStats and GetPlayer().PlayerStats.Stand and GetPlayer().PlayerStats.Stand.Value ~= "None" and Character:FindFirstChild("StandMorph") and Character.StandMorph.PrimaryPart then
                    pcall(function()
                        Character.StandMorph.PrimaryPart.CFrame = enemyHRP.CFrame - enemyHRP.CFrame.LookVector * 1.1
                        if Character.PrimaryPart and Character.StandMorph.PrimaryPart then
                            Character.PrimaryPart.CFrame = Character.StandMorph.PrimaryPart.CFrame + Character.StandMorph.PrimaryPart.CFrame.LookVector * math.random(-3, -2) + Vector3.new(0, -35, 0)
                        end
                    end)
                else
                    if Character.PrimaryPart then
                        pcall(function() Character.PrimaryPart.CFrame = enemyHRP.CFrame - enemyHRP.CFrame.LookVector * 2.3 end)
                    end
                end

                task.spawn(function() UseMove("m1") end)
            elseif Character and Character:FindFirstChildWhichIsA("Humanoid") and Character:FindFirstChildWhichIsA("Humanoid").Health <= 0 then
                GetPlayer().CharacterAdded:Wait()
            end

            task.wait()
        end

        local hrp = GetHRP()
        if hrp then
            if Enemy and Enemy:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = CFrame.new(Enemy.HumanoidRootPart.Position + Vector3.new(0, 20, 0))
            elseif oldPos then
                hrp.CFrame = oldPos + Vector3.new(0, 15, 0)
            end
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
        
        task.wait(math.max(0.01, getgenv().QuestDelay or 0.1))
        
        pcall(function() if FocusCam then FocusCam:Destroy() end end)
    end

    local function GetQuest(NPC)
    if not NPC then return false end
    local DialogueNameObj = NPC:FindFirstChild("Dialogue")
    local Character = GetCharacter()
    if DialogueNameObj and Character and Character:FindFirstChild("RemoteEvent") then
        local DialogueName = DialogueNameObj.Value
        local Event = Character:FindFirstChild("RemoteEvent")
        
        local QuestDialogues = {
            "Dialogue1",
            "Dialogue2",
            "Dialogue3",
            "Dialogue4",
            "Dialogue5",
            "Dialogue6"
        }
        
        for _, dialogue in ipairs(QuestDialogues) do
            pcall(function()
                Event:FireServer("EndDialogue", {
                    ["NPC"] = DialogueName,
                    ["Option"] = "Option1",
                    ["Dialogue"] = dialogue
                })
            end)
            task.wait(0.1)
        end

        getgenv().CompletedQuest = false
        pcall(function() notify("YBA Script", "Quest taken: " .. NPC.Name) end)
        return true
    end
    return false
end

    local QuestInfo = {
        ["Officer Sam [Lvl. 1+]"] = { Enemy = "Thug" },
        ["Deputy Bertrude [Lvl. 10+]"] = { Enemy = "Corrupt Police" },
        ["Abbacchio's Partner [Lvl 15+]"] = { Enemy = "Alpha Thug" },
        ["Homeless Man Jill [Lvl. 15+]"] = { Item = "Gold Coin", Amount = 10 },
        ["Dracula [Lvl. 20+]"] = { Enemy = "Zombie Henchman" },
        ["William Zeppeli [Lvl. 25+]"] = { Enemy = "Vampire" },
        ["Doppio [Lvl. 30+]"] = { Enemy = "Dio" },
        ["Dio [Lvl. 35+]"] = { Enemy = "Jotaro" },
    }

    local function ParseQuests()
        local parsed = {}
        if workspace:FindFirstChild("Dialogues") then
            for _, v in pairs(workspace.Dialogues:GetChildren()) do
                if ((v.Name:find("Lvl")) or v.Name == "Jotaro") 
                    and not v.Name:find("Darius") 
                    and not v.Name:find("Pucci") 
                    and not v.Name:find("Kars") then
                    table.insert(parsed, v.Name)
                end
            end
        end
        table.sort(parsed)
        return parsed
    end

    local ParsedQuests = ParseQuests()
    if workspace:FindFirstChild("Dialogues") then
        workspace.Dialogues.ChildAdded:Connect(function(child)
            if child 
                and ((child.Name:find("Lvl")) or child.Name == "Jotaro") 
                and not child.Name:find("Darius") 
                and not child.Name:find("Pucci") 
                and not child.Name:find("Kars") then
                table.insert(ParsedQuests, child.Name)
            end
        end)
    end

    local function GetBestQuest()
        local player = GetPlayer()
        if not player or not player:FindFirstChild("PlayerStats") or not player.PlayerStats:FindFirstChild("Level") then
            return nil
        end
        local playerLevel = player.PlayerStats.Level.Value
        local bestQuest, highestReq = nil, -1
        for _, questName in pairs(ParsedQuests) do
            local levelReq = tonumber(questName:match("(%d+)"))
            if levelReq and levelReq <= playerLevel and levelReq > highestReq then
                highestReq = levelReq
                bestQuest = questName
            end
        end
        return bestQuest
    end

    local function UpdateNPCList(npcDropdown)
        local values = {}
        local seen = {}
        local living = workspace:FindFirstChild("Living")
        if living then
            for _, child in pairs(living:GetChildren()) do
                if child:FindFirstChild("Spawn") then
                    local name = child.Name or tostring(child)
                    if not seen[name] then
                        table.insert(values, name)
                        seen[name] = true
                    end
                end
            end
        end
        table.sort(values, function(a,b) return tostring(a) < tostring(b) end)
        if #values == 0 then values = {"No spawnable NPCs found"} end

        pcall(function()
            if npcDropdown then
                if type(npcDropdown.Refresh) == "function" then
                    npcDropdown:Refresh(values, values[1])
                elseif type(npcDropdown.Update) == "function" then
                    npcDropdown:Update({ Values = values, Value = values[1] })
                elseif type(npcDropdown.SetValues) == "function" then
                    npcDropdown:SetValues(values)
                end
            end
        end)

        if values[1] and values[1] ~= "No spawnable NPCs found" then
            getgenv().TargetNPC = values[1]
        else
            getgenv().TargetNPC = ""
        end
    end

    local QuestFarmSection = QuestTab:Section({ Title = "Quest Farm" })

    local questStatus = QuestFarmSection:Section({
        Title = "Status: Working",
        TextSize = 16,
        TextTransparency = 0.3
    })

    getgenv().QuestDelay = 0.6
    QuestFarmSection:Slider({
        Flag = "QuestDelay",
        Title = "Delay (seconds) - lower = faster",
        Locked = true,
        LockedTitle = "This Feature is locked",
        Min = 0.05,
        Max = 2,
        Default = getgenv().QuestDelay,
        Increment = 0.05,
        Callback = function(v)
            getgenv().QuestDelay = tonumber(v) or 0.6
        end
    })

    if #ParsedQuests == 0 then
        table.insert(ParsedQuests, "No quests available")
    end

    QuestFarmSection:Dropdown({
        Flag = "SelectedQuest",
        Title = "Select Quest",
        Values = ParsedQuests,
        Value = ParsedQuests[1] or "No quests available",
        Callback = function(selected)
            getgenv().SelectedQuest = selected
            if selected and selected ~= "" and selected ~= "No quests available" then
                pcall(function()
                    questStatus:Update({ Title = "Status: Ready" })
                end)
            else
                pcall(function()
                    questStatus:Update({ Title = "Status: Wait" })
                end)
            end
            notify("YBA Script", "Quest set to: " .. tostring(selected))
        end
    })

QuestFarmSection:Input({
    Flag = "ManualQuestInput",
    Title = "Or Enter Quest Name Manually",
    Placeholder = "e.g., Officer Sam [Lvl. 1+]",
    Callback = function(value)
        if value and value ~= "" then
            getgenv().SelectedQuest = value
            notify("YBA Script", "Manual quest set to: " .. value)
        end
    end
})

QuestFarmSection:Space()
QuestFarmSection:Space()
QuestFarmSection:Section({
    Title = "Auto Skill",
})

getgenv().AutoSkillEnabled = false
getgenv().AutoSkillKeys = {Enum.KeyCode.R}
getgenv().AutoSkillDelay = 0.1
getgenv().AutoSkillConnections = {}

local function stopAutoSkill()
    for _, conn in pairs(getgenv().AutoSkillConnections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    getgenv().AutoSkillConnections = {}
end

local function startAutoSkill()
    local player = game.Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    
    stopAutoSkill()
    
    local skillConn = RunService.RenderStepped:Connect(function()
        if not getgenv().AutoSkillEnabled then return end
        if #getgenv().AutoSkillKeys == 0 then return end
        
        local character = player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return end
        
        for _, keyCode in ipairs(getgenv().AutoSkillKeys) do
            VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        end
        
        task.wait(getgenv().AutoSkillDelay)
        
        for _, keyCode in ipairs(getgenv().AutoSkillKeys) do
            VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
        end
    end)
    
    table.insert(getgenv().AutoSkillConnections, skillConn)
end

QuestFarmSection:Dropdown({
    Flag = "AutoSkillKeys",
    Title = "Skill Keys",
    Locked = true,
    Values = {"E", "R", "T", "Y", "F", "G", "H", "Z", "X", "C", "V", "B", "N", "M", "Q", "L"},
    Multi = true,
    Callback = function(selected)
        local keyMap = {
            ["E"] = Enum.KeyCode.E, ["R"] = Enum.KeyCode.R, ["T"] = Enum.KeyCode.T,
            ["Y"] = Enum.KeyCode.Y, ["F"] = Enum.KeyCode.F, ["G"] = Enum.KeyCode.G,
            ["H"] = Enum.KeyCode.H, ["Z"] = Enum.KeyCode.Z, ["X"] = Enum.KeyCode.X,
            ["C"] = Enum.KeyCode.C, ["V"] = Enum.KeyCode.V, ["B"] = Enum.KeyCode.B,
            ["N"] = Enum.KeyCode.N, ["M"] = Enum.KeyCode.M, ["Q"] = Enum.KeyCode.Q,
            ["L"] = Enum.KeyCode.L
        }
        
        getgenv().AutoSkillKeys = {}
        for _, keyName in ipairs(selected) do
            local keyCode = keyMap[keyName]
            if keyCode then
                table.insert(getgenv().AutoSkillKeys, keyCode)
            end
        end
        
        local keyNames = {}
        for _, keyCode in ipairs(getgenv().AutoSkillKeys) do
            table.insert(keyNames, keyCode.Name)
        end
        
        if #keyNames > 0 then
            notify("YBA Script", "Auto Skill keys: " .. table.concat(keyNames, ", "))
        else
            notify("YBA Script", "No keys selected! Auto Skill will not work.")
        end
        
        if getgenv().AutoSkillEnabled then
            stopAutoSkill()
            if #getgenv().AutoSkillKeys > 0 then
                startAutoSkill()
            else
                getgenv().AutoSkillEnabled = false
                pcall(function()
                    local toggle = QuestFarmSection:FindFirstChild("AutoSkillToggle")
                    if toggle and toggle.Set then
                        toggle:Set(false)
                    end
                end)
            end
        end
    end
})

QuestFarmSection:Slider({
    Flag = "AutoSkillDelay",
    Title = "Hold Key",
    Step = 0.01,
    Value = { Min = 0.01, Max = 1.0, Default = 1 },
    Callback = function(value)
        getgenv().AutoSkillDelay = value
    end
})

QuestFarmSection:Toggle({
    Flag = "AutoSkillToggle",
    Title = "Enable Auto Skill",
    Locked = true,
    Default = false,
    Callback = function(value)
        getgenv().AutoSkillEnabled = value
        
        if value then
            if #getgenv().AutoSkillKeys == 0 then
                notify("YBA Script", "ERROR: No keys selected! Please select at least one key.")
                getgenv().AutoSkillEnabled = false
                task.delay(0.1, function()
                    pcall(function()
                        local toggle = QuestFarmSection:FindFirstChild("AutoSkillToggle")
                        if toggle and toggle.Set then
                            toggle:Set(false)
                        end
                    end)
                end)
                return
            end
            
            local keyNames = {}
            for _, keyCode in ipairs(getgenv().AutoSkillKeys) do
                table.insert(keyNames, keyCode.Name)
            end
            
            notify("YBA Script", "Auto Skill enabled! Keys: " .. table.concat(keyNames, ", "))
            startAutoSkill()
        else
            notify("YBA Script", "Auto Skill disabled.")
            stopAutoSkill()
        end
    end
})

QuestFarmSection:Button({
    Title = "Clear All Skill Keys",
    Callback = function()
        getgenv().AutoSkillKeys = {}
        
        if getgenv().AutoSkillEnabled then
            stopAutoSkill()
            getgenv().AutoSkillEnabled = false
            
            pcall(function()
                local toggle = QuestFarmSection:FindFirstChild("AutoSkillToggle")
                if toggle and toggle.Set then
                    toggle:Set(false)
                end
            end)
        end
        
        pcall(function()
            local dropdown = QuestFarmSection:FindFirstChild("AutoSkillKeys")
            if dropdown and dropdown.Set then
                dropdown:Set({})
            end
        end)
        
        notify("YBA Script", "All skill keys cleared! Select new keys to use Auto Skill.")
    end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if getgenv().AutoSkillEnabled and #getgenv().AutoSkillKeys > 0 then
        task.wait(1)
        stopAutoSkill()
        startAutoSkill()
    end
end)

game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name:find("WindUI") or child.Name:find("Methion") then
        stopAutoSkill()
    end
end)

getgenv().QuestMethod = "With Stand"

QuestFarmSection:Dropdown({
    Flag = "QuestMethod",
    Title = "Method",
    Values = {"With Stand", "Without Stand"},
    Value = "With Stand",
    Callback = function(selected)
        getgenv().QuestMethod = selected
        notify("YBA Script", "Quest Method set to: " .. selected)
    end
})

    local function UpdateQuestStatus()
        pcall(function()
            if not getgenv().QuestFarmEnabled then
                questStatus:Update({ Title = "Status: Idle" })
                return
            end
            local sel = getgenv().SelectedQuest
            if not sel or sel == "" or sel == "No quests available" then
                questStatus:Update({ Title = "Status: Wait (No selection)" })
                return
            end
            if getgenv().CompletedQuest then
                questStatus:Update({ Title = "Status: Ready" })
            else
                questStatus:Update({ Title = "Status: Farming (" .. (QuestInfo[sel] and (QuestInfo[sel].Enemy or QuestInfo[sel].Item) or "Quest") .. ")" })
            end
        end)
    end


local function GetPlayerLevel()
    local player = GetPlayer()
    if player and player:FindFirstChild("PlayerStats") and player.PlayerStats:FindFirstChild("Level") then
        return player.PlayerStats.Level.Value
    end
    return 0
end

local function GetQuestLevelRequirement(questName)
    if not questName then return 0 end
    local levelReq = tonumber(questName:match("(%d+)"))
    return levelReq or 0
end

local function GetBestAvailableQuest()
    local playerLevel = GetPlayerLevel()
    local bestQuest = nil
    local highestReq = -1
    
    for _, questName in pairs(ParsedQuests) do
        if questName ~= "No quests available" then
            local levelReq = GetQuestLevelRequirement(questName)
            if levelReq and levelReq <= playerLevel and levelReq > highestReq then
                highestReq = levelReq
                bestQuest = questName
            end
        end
    end
    return bestQuest
end

local function CanTakeQuest(questName)
    local playerLevel = GetPlayerLevel()
    local questLevel = GetQuestLevelRequirement(questName)
    return playerLevel >= questLevel
end


QuestFarmSection:Toggle({
    Flag = "QuestFarmEnabled",
    Title = "Enable Quest Farm",
    Default = false,
    Callback = function(value)
        getgenv().QuestFarmEnabled = value
        if value then
            notify("YBA Script", "Quest Farm started!")
            enableNoclip()
            
            getgenv().TargetQuestLevel = GetQuestLevelRequirement(getgenv().SelectedQuest)
            getgenv().LockedQuest = nil
            getgenv().IsRecovering = false
            
            local function GetPlayerLevel()
                local player = GetPlayer()
                if player and player:FindFirstChild("PlayerStats") and player.PlayerStats:FindFirstChild("Level") then
                    return player.PlayerStats.Level.Value
                end
                return 0
            end
            
            local function GetQuestLevelRequirement(questName)
                if not questName or questName == "No quests available" then return 0 end
                local levelReq = tonumber(questName:match("(%d+)"))
                return levelReq or 0
            end
            
            local function HasActiveQuest()
                local player = GetPlayer()
                if not player or not player:FindFirstChild("PlayerStats") then return false end
                
                local currentQuest = player.PlayerStats:FindFirstChild("CurrentQuest")
                local questProgress = player.PlayerStats:FindFirstChild("QuestProgress")
                local questMax = player.PlayerStats:FindFirstChild("QuestMaxProgress")
                
                if currentQuest and currentQuest.Value ~= "" and questProgress and questMax then
                    return questProgress.Value < questMax.Value
                end
                return false
            end
            
            local function IsQuestComplete()
                local player = GetPlayer()
                if not player or not player:FindFirstChild("PlayerStats") then return false end
                
                local currentQuest = player.PlayerStats:FindFirstChild("CurrentQuest")
                local questProgress = player.PlayerStats:FindFirstChild("QuestProgress")
                local questMax = player.PlayerStats:FindFirstChild("QuestMaxProgress")
                
                if currentQuest and currentQuest.Value ~= "" and questProgress and questMax then
                    return questProgress.Value >= questMax.Value
                end
                return false
            end
            
            local function IsPlayerReady()
                local player = GetPlayer()
                if not player then return false end
                
                local character = player.Character
                if not character then return false end
                
                local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                if not humanoid then return false end
                
                return humanoid.Health > 0
            end
            
            local function WaitForCharacter(timeout)
                timeout = timeout or 10
                local player = GetPlayer()
                if not player then return false end
                
                local start = tick()
                while tick() - start < timeout do
                    if player.Character then
                        local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            return true
                        end
                    end
                    task.wait(0.1)
                end
                return false
            end
            
            local function GetBestQuestForLevel(currentLevel)
                local bestQuest = nil
                local highestReq = -1
                
                for _, questName in pairs(ParsedQuests) do
                    if questName ~= "No quests available" then
                        local levelReq = GetQuestLevelRequirement(questName)
                        if levelReq and levelReq <= currentLevel and levelReq > highestReq then
                            highestReq = levelReq
                            bestQuest = questName
                        end
                    end
                end
                return bestQuest
            end
            
            local function GetOptimalQuestForProgression()
                local currentLevel = GetPlayerLevel()
                local targetLevel = getgenv().TargetQuestLevel or 35
                
                if currentLevel >= targetLevel then
                    if not getgenv().LockedQuest then
                        local bestQuest = nil
                        local closestDiff = math.huge
                        
                        for _, questName in pairs(ParsedQuests) do
                            if questName ~= "No quests available" then
                                local levelReq = GetQuestLevelRequirement(questName)
                                if levelReq and levelReq <= targetLevel then
                                    local diff = targetLevel - levelReq
                                    if diff < closestDiff then
                                        closestDiff = diff
                                        bestQuest = questName
                                    end
                                end
                            end
                        end
                        
                        if bestQuest then
                            getgenv().LockedQuest = bestQuest
                            return bestQuest
                        end
                    else
                        return getgenv().LockedQuest
                    end
                end
                
                return GetBestQuestForLevel(currentLevel)
            end
            
            local function UpdateQuestDropdown(newQuest)
                pcall(function()
                    for _, element in pairs(QuestFarmSection:GetChildren() or {}) do
                        if element.Flag == "SelectedQuest" or element.Title == "Select Quest" then
                            if element.Set then
                                element:Set(newQuest)
                            elseif element.Update then
                                element:Update({Value = newQuest})
                            end
                            break
                        end
                    end
                end)
            end
            
            local function EnsureStandForQuesting()
                local playerLevel = GetPlayerLevel()
                
                if getgenv().QuestMethod ~= "With Stand" then return true end
                if playerLevel < 3 then return true end
                
                local hasStand = HasStand()
                if hasStand then
                    EquipStand()
                    task.wait(0.5)
                    return true
                end
                
                notify("YBA Script", "Level " .. playerLevel .. " requires stand! Obtaining one...")
                
                local attempts = 0
                local maxAttempts = 3
                
                while attempts < maxAttempts do
                    attempts = attempts + 1
                    notify("YBA Script", "Stand attempt " .. attempts .. "/" .. maxAttempts)
                    
                    local success = CollectRokaArrow()
                    if success then
                        notify("YBA Script", "Roka/Arrow collected! Dying to get stand...")
                        
                        local character = GetCharacter()
                        local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                        end
                        
                        local player = GetPlayer()
                        if player then
                            player.CharacterAdded:Wait()
                            task.wait(3)
                            
                            local newHasStand = HasStand()
                            if newHasStand then
                                notify("YBA Script", "Stand obtained! Equipping...")
                                task.wait(1)
                                EquipStand()
                                task.wait(1)
                                
                                local character2 = GetCharacter()
                                if character2 then
                                    local standMorph = character2:FindFirstChild("StandMorph")
                                    if standMorph then
                                        notify("YBA Script", "Stand equipped successfully!")
                                        return true
                                    end
                                end
                            else
                                notify("YBA Script", "Stand not obtained, retrying...")
                            end
                        end
                    else
                        notify("YBA Script", "Failed to collect roka/arrow, retrying...")
                        task.wait(2)
                    end
                end
                
                notify("YBA Script", "Failed to obtain stand after " .. maxAttempts .. " attempts!")
                return false
            end
            
            local function HandleDeathRecovery()
                if getgenv().IsRecovering then return false end
                getgenv().IsRecovering = true
                
                notify("YBA Script", "Death detected! Recovering...")
                
                if not WaitForCharacter(15) then
                    notify("YBA Script", "Failed to respawn!")
                    getgenv().IsRecovering = false
                    return false
                end
                
                task.wait(2)
                
                enableNoclip()
                
                local playerLevel = GetPlayerLevel()
                if getgenv().QuestMethod == "With Stand" and playerLevel >= 3 then
                    local hasStand = HasStand()
                    if hasStand then
                        notify("YBA Script", "Re-equipping stand after death...")
                        EquipStand()
                        task.wait(1)
                    else
                        if not EnsureStandForQuesting() then
                            notify("YBA Script", "Warning: Could not re-obtain stand!")
                        end
                    end
                end
                
                if IsQuestComplete() then
                    getgenv().CompletedQuest = true
                elseif HasActiveQuest() then
                    getgenv().CompletedQuest = false
                else
                    getgenv().CompletedQuest = true
                end
                
                notify("YBA Script", "Recovery complete! Resuming farm...")
                getgenv().IsRecovering = false
                return true
            end
            
            local function InitializeQuestState()
                local player = GetPlayer()
                if not player or not player:FindFirstChild("PlayerStats") then 
                    getgenv().CompletedQuest = true
                    return 
                end
                
                local currentQuest = player.PlayerStats:FindFirstChild("CurrentQuest")
                local questProgress = player.PlayerStats:FindFirstChild("QuestProgress")
                local questMax = player.PlayerStats:FindFirstChild("QuestMaxProgress")
                local playerLevel = GetPlayerLevel()
                
                local selectedLevel = GetQuestLevelRequirement(getgenv().SelectedQuest)
                
                if selectedLevel > playerLevel then
                    local bestQuest = GetBestQuestForLevel(playerLevel)
                    if bestQuest then
                        getgenv().SelectedQuest = bestQuest
                        UpdateQuestDropdown(bestQuest)
                        notify("YBA Script", "Auto-adjusted to level " .. GetQuestLevelRequirement(bestQuest) .. " quest")
                    end
                end
                
                if currentQuest and currentQuest.Value ~= "" then
                    if questProgress and questMax then
                        if questProgress.Value >= questMax.Value then
                            getgenv().CompletedQuest = true
                            notify("YBA Script", "Current quest ready to turn in!")
                        else
                            getgenv().CompletedQuest = false
                            if QuestInfo[currentQuest.Value] then
                                getgenv().SelectedQuest = currentQuest.Value
                            end
                        end
                    else
                        getgenv().CompletedQuest = true
                    end
                else
                    getgenv().CompletedQuest = true
                end
            end
            
            local function HandleEarlyLevelFarming()
                local playerLevel = GetPlayerLevel()
                local hasStand = HasStand()
                
                if playerLevel > 2 or hasStand then return false end
                
                if getgenv().QuestMethod == "With Stand" then
                    notify("YBA Script", "Farming to level 3 for stand...")
                    local originalMethod = getgenv().QuestMethod
                    getgenv().QuestMethod = "Without Stand"
                    
                    getgenv().SelectedQuest = "Officer Sam [Lvl. 1+]"
                    
                    local startTime = tick()
                    local maxWait = 300
                    
                    while getgenv().QuestFarmEnabled and GetPlayerLevel() <= 2 and tick() - startTime < maxWait do
                        if not IsPlayerReady() then
                            HandleDeathRecovery()
                        end
                        
                        if getgenv().CompletedQuest then
                            local questNPC = workspace:FindFirstChild("Dialogues") and workspace.Dialogues:FindFirstChild("Officer Sam [Lvl. 1+]")
                            if questNPC then
                                pcall(function() GetQuest(questNPC) end)
                                getgenv().CompletedQuest = false
                            end
                        else
                            local living = workspace:FindFirstChild("Living")
                            if living then
                                for _, v in pairs(living:GetChildren()) do
                                    if not getgenv().QuestFarmEnabled then break end
                                    if v.Name == "Thug" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Health") and v.Health.Value > 0 then
                                        pcall(function() KillEnemy(v) end)
                                        task.wait(math.max(0.05, getgenv().QuestDelay))
                                        
                                        if GetPlayerLevel() >= 3 then break end
                                    end
                                end
                            end
                        end
                        
                        task.wait(0.1)
                    end
                    
                    if GetPlayerLevel() >= 3 then
                        notify("YBA Script", "Level 3 reached! Getting stand...")
                        
                        local standSuccess = false
                        local attempts = 0
                        
                        while not standSuccess and attempts < 3 do
                            attempts = attempts + 1
                            local success = CollectRokaArrow()
                            
                            if success then
                                local character = GetCharacter()
                                local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                                if humanoid then
                                    humanoid.Health = 0
                                end
                                
                                local player = GetPlayer()
                                player.CharacterAdded:Wait()
                                task.wait(3)
                                
                                if HasStand() then
                                    EquipStand()
                                    task.wait(1)
                                    standSuccess = true
                                    notify("YBA Script", "Stand obtained and equipped!")
                                end
                            else
                                task.wait(2)
                            end
                        end
                        
                        if not standSuccess then
                            notify("YBA Script", "Warning: Could not obtain stand!")
                        end
                    end
                    
                    getgenv().QuestMethod = originalMethod
                    getgenv().CompletedQuest = true
                    return true
                end
                
                return false
            end
            
            local function DoQuestFarm()
                local questName = getgenv().SelectedQuest
                local playerLevel = GetPlayerLevel()
                local questData = QuestInfo[questName]
                
                if not questData then
                    pcall(function() questStatus:Update({ Title = "Status: Invalid quest data" }) end)
                    return
                end
                
                if questData.Item then
                    pcall(function() questStatus:Update({ Title = "Status: Collecting " .. questData.Item }) end)
                    local itemName = questData.Item
                    local requiredAmount = questData.Amount or 1
                    
                    local function CountItems()
                        local current = 0
                        local ply = GetPlayer()
                        if not ply then return 0 end
                        
                        if ply:FindFirstChild("Backpack") then
                            for _, it in pairs(ply.Backpack:GetChildren()) do
                                if it.Name == itemName then current = current + 1 end
                            end
                        end
                        if ply.Character then
                            for _, it in pairs(ply.Character:GetChildren()) do
                                if it.Name == itemName then current = current + 1 end
                            end
                        end
                        return current
                    end
                    
                    if CountItems() >= requiredAmount then
                        getgenv().CompletedQuest = true
                        pcall(function() questStatus:Update({ Title = "Status: Items collected!" }) end)
                    else
                        local spawns = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
                        if spawns then
                            for _, v in pairs(spawns:GetChildren()) do
                                if not getgenv().QuestFarmEnabled then break end
                                
                                if not IsPlayerReady() then
                                    HandleDeathRecovery()
                                    break
                                end
                                
                                local prox = v:FindFirstChild("ProximityPrompt")
                                if prox and prox.ObjectText == itemName and v:FindFirstChild("PrimaryPart") then
                                    pcall(function()
                                        local HRP = GetHRP()
                                        if HRP and v.PrimaryPart then
                                            local OldCF = HRP.CFrame
                                            HRP.CFrame = v.PrimaryPart.CFrame - Vector3.new(0, 10, 0)
                                            task.wait(math.max(0.05, getgenv().QuestDelay))
                                            fireproximityprompt(prox, 0, true)
                                            task.wait(math.max(0.05, getgenv().QuestDelay))
                                            HRP.CFrame = OldCF
                                        end
                                    end)
                                    task.wait(math.max(0.05, getgenv().QuestDelay))
                                end
                            end
                        end
                    end
                    
                elseif questData.Enemy then
                    pcall(function() questStatus:Update({ Title = "Status: Farming " .. questData.Enemy .. " (Lvl " .. playerLevel .. ")" }) end)
                    local enemyName = questData.Enemy
                    local living = workspace:FindFirstChild("Living")
                    
                    if living then
                        local foundEnemy = false
                        for _, v in pairs(living:GetChildren()) do
                            if not getgenv().QuestFarmEnabled then break end
                            
                            if not IsPlayerReady() then
                                HandleDeathRecovery()
                                break
                            end
                            
                            if v.Name == enemyName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Health") and v.Health.Value > 0 then
                                foundEnemy = true
                                
                                if playerLevel >= 3 and not HasStand() and getgenv().QuestMethod == "With Stand" then
                                    break
                                end
                                
                                pcall(function() KillEnemy(v) end)
                                task.wait(math.max(0.05, getgenv().QuestDelay))
                            end
                        end
                        
                        if not foundEnemy then
                            task.wait(0.5)
                        end
                    end
                end
            end
            
            local questCompletedConn
            if GetPlayer().PlayerGui and GetPlayer().PlayerGui:FindFirstChild("HUD") then
                local hud = GetPlayer().PlayerGui.HUD
                questCompletedConn = hud.ChildAdded:Connect(function(Child)
                    if Child and Child.Name == "QuestCompleted" then
                        getgenv().CompletedQuest = true
                        pcall(function() questStatus:Update({ Title = "Status: Quest Completed!" }) end)
                        notify("YBA Script", "Quest completed!")
                    end
                end)
            end
            
            local deathConn
            local player = GetPlayer()
            if player then
                local function setupDeathDetection(char)
                    local humanoid = char:WaitForChild("Humanoid", 5)
                    if humanoid then
                        deathConn = humanoid.Died:Connect(function()
                            task.spawn(function()
                                task.wait(1)
                                if getgenv().QuestFarmEnabled then
                                    HandleDeathRecovery()
                                end
                            end)
                        end)
                    end
                end
                
                if player.Character then
                    setupDeathDetection(player.Character)
                end
                
                player.CharacterAdded:Connect(function(char)
                    if deathConn then
                        pcall(function() deathConn:Disconnect() end)
                    end
                    if getgenv().QuestFarmEnabled then
                        setupDeathDetection(char)
                    end
                end)
            end
            
            InitializeQuestState()
            
            if HandleEarlyLevelFarming() then
                InitializeQuestState()
            end
            
            task.spawn(function()
                while getgenv().QuestFarmEnabled do
                    
                    if not IsPlayerReady() then
                        HandleDeathRecovery()
                        task.wait(0.5)
                        continue
                    end
                    
                    local playerLevel = GetPlayerLevel()
                    
                    if not getgenv().LockedQuest then
                        local optimalQuest = GetOptimalQuestForProgression()
                        if optimalQuest and optimalQuest ~= getgenv().SelectedQuest then
                            getgenv().SelectedQuest = optimalQuest
                            UpdateQuestDropdown(optimalQuest)
                            notify("YBA Script", "Leveled up! Switched to " .. optimalQuest)
                            getgenv().CompletedQuest = true
                            task.wait(0.5)
                        end
                    end
                    
                    local selectedLevel = GetQuestLevelRequirement(getgenv().SelectedQuest)
                    if selectedLevel > playerLevel then
                        local bestQuest = GetBestQuestForLevel(playerLevel)
                        if bestQuest then
                            getgenv().SelectedQuest = bestQuest
                            UpdateQuestDropdown(bestQuest)
                            getgenv().CompletedQuest = true
                        end
                    end
                    
                    if getgenv().QuestMethod == "With Stand" then
                        if playerLevel >= 3 and not HasStand() then
                            if not EnsureStandForQuesting() then
                                task.wait(2)
                                continue
                            end
                        end
                        if IsPlayerReady() then
                            EquipStand()
                        end
                    end
                    
                    if IsQuestComplete() then
                        getgenv().CompletedQuest = true
                    elseif HasActiveQuest() then
                        getgenv().CompletedQuest = false
                    end
                    
                    if getgenv().CompletedQuest then
                        pcall(function() questStatus:Update({ Title = "Status: Taking quest..." }) end)
                        
                        local questName = getgenv().SelectedQuest
                        local questNPC = workspace:FindFirstChild("Dialogues") and workspace.Dialogues:FindFirstChild(questName)
                        
                        if questNPC then
                            local success = false
                            pcall(function() success = GetQuest(questNPC) end)
                            
                            if success then
                                getgenv().CompletedQuest = false
                                pcall(function() questStatus:Update({ Title = "Status: Quest accepted - " .. questName }) end)
                                task.wait(0.5)
                            else
                                pcall(function() questStatus:Update({ Title = "Status: Failed to take quest" }) end)
                                task.wait(1)
                            end
                        else
                            pcall(function() questStatus:Update({ Title = "Status: NPC not found - " .. questName }) end)
                            task.wait(1)
                        end
                    else
                        DoQuestFarm()
                    end
                    
                    task.wait(0.1)
                end
                
                pcall(function()
                    if questCompletedConn and type(questCompletedConn.Disconnect) == "function" then
                        questCompletedConn:Disconnect()
                    end
                    if deathConn and type(deathConn.Disconnect) == "function" then
                        deathConn:Disconnect()
                    end
                end)
                disableNoclip()
                pcall(function() questStatus:Update({ Title = "Status: Idle" }) end)
                notify("YBA Script", "Quest Farm stopped!")
            end)
            
        else
            pcall(function() questStatus:Update({ Title = "Status: Idle" }) end)
            notify("YBA Script", "Quest Farm stopped!")
            disableNoclip()
        end
    end
})

    QuestFarmSection:Space()

    local NpcFarmSection = QuestTab:Section({ Title = "NPC Farm" })

    getgenv().TargetNPC = ""
    getgenv().NPCFarmEnabled = false

    local npcDropdown = NpcFarmSection:Dropdown({
        Flag = "SelectedNPC",
        Title = "Select NPC",
        SearchBarEnabled = true,
        Values = {},        
        Value = "",         
        Callback = function(selected)
            if selected and selected ~= "" and selected ~= "No spawnable NPCs found" then
                getgenv().TargetNPC = selected
                notify("YBA Script", "Target NPC set to: " .. selected)
            else
                getgenv().TargetNPC = ""
            end
        end
    })
NpcFarmSection:Input({
    Flag = "ManualNPCInput",
    Title = "Or Enter NPC Name Manually",
    Placeholder = "e.g., Thug, Corrupt Police...",
    Callback = function(value)
        if value and value ~= "" then
            getgenv().TargetNPC = value
            notify("YBA Script", "Manual NPC target set to: " .. value)
        end
    end
})

    NpcFarmSection:Toggle({
        Flag = "NPCFarmEnabled",
        Title = "Enable NPC Farm",
        Default = false,
        Callback = function(value)
            getgenv().NPCFarmEnabled = value
            if value then
                notify("YBA Script", "NPC Farm started!")
            task.spawn(function()
                while getgenv().NPCFarmEnabled do
                    local target = getgenv().TargetNPC
                    local killedSomething = false
                    
                    if target and target ~= "" and target ~= "No spawnable NPCs found" then
                        local livingFolder = workspace:FindFirstChild("Living")
                        if livingFolder then
                            for _, v in pairs(livingFolder:GetChildren()) do
                                if not getgenv().NPCFarmEnabled then break end
                                if v.Name == target and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("Health") and v.Health.Value > 0 then
                                    killedSomething = true
                                    local success, err = pcall(function() KillEnemy(v) end)
                                    if not success then warn("NPC Farm Error:", err) end
                                    task.wait(0.3) -- Brief pause after kill
                                    break -- Kill one NPC per cycle to prevent overload
                                end
                            end
                        end
                    else
                        local livingFolder = workspace:FindFirstChild("Living")
                        if livingFolder then
                            for _, v in pairs(livingFolder:GetChildren()) do
                                if not getgenv().NPCFarmEnabled then break end
                                if v:FindFirstChild("Spawn") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Health") and v.Health.Value > 0 then
                                    killedSomething = true
                                    local success, err = pcall(function() KillEnemy(v) end)
                                    if not success then warn("NPC Farm Error:", err) end
                                    task.wait(0.3) -- Brief pause after kill
                                    break -- Kill one NPC per cycle to prevent overload
                                end
                            end
                        end
                    end
                    
                    -- CRITICAL: Prevent freeze when no NPCs found
                    if not killedSomething then
                        task.wait(0.5)
                    end
                end
            end)
            else
                notify("YBA Script", "NPC Farm stopped!")
            end
        end
    })
  
  QuestTab:Space()
  
QuestTab:Paragraph({
    Title = "💡 Tips",
    Desc = "if you want to automatickly farm it for you until 35 select 35\n\n" ..
           "did you know that the quest 25 kills you and we dont know why\n\n" ..
           "did you know the status isnt real?\n\n" ..
           "did you know the executor support works but we just dont want to unlock it\n\n" ..
           "did you know the owner of this script is a *****?\n\n" ..
           "did you know the quest Freezes your computer if not your a *****\n\n" ..
           "did you know you can put a player name on npc farm you can farm them what ever you want",
    TextSize = 14
})
QuestFarmSection:Space()

local AutoPrestigeSection = QuestTab:Section({ 
    Title = "Auto Story Line",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold,
})

AutoPrestigeSection:Paragraph({
    Title = "Do this:",
    Desc = "if your account is new to the game and auto prestige doesnt work try getting to level 3 and get yourself a stand or just enable quest farm with stand, Method to get to level 3 fast and try to enable the auto prestige again or if that doesnt work try making to the quest leaky eye luca make sure you have the quest and enable it' it should work..",
    TextSize = 14
})

AutoPrestigeSection:Space()

AutoPrestigeSection:Space()

local autoPrestigeStartData = {
    enabled = false,
    startTime = nil,
    startLevel = nil,
    startPrestige = nil,
    startDate = nil
}

local blacklistedStands = {
    ["Six Pistols"] = true,
    ["Hermit Purple"] = true,
    ["Aerosmith"] = true,
    ["Beach Boy"] = true,
    ["Mr. President"] = true,
    ["White Album"] = true,
    ["Anubis"] = true,
    ["Tusk ACT 1"] = true
}

local function formatTime(num, digits)
    return string.format("%0" .. digits .. "i", num)
end

local function getISO8601()
    local osDate = os.date("!*t")
    local year, mon, day = osDate["year"], osDate["month"], osDate["day"]
    local hour, min, sec = osDate["hour"], osDate["min"], osDate["sec"]
    return year .. "-" .. formatTime(mon, 2) .. "-" .. formatTime(day, 2) .. "T" .. formatTime(hour, 2) .. ":" .. formatTime(min, 2) .. ":" .. formatTime(sec, 2) .. "Z"
end

local function formatDuration(seconds)
    local hours = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, mins, secs)
end

local function sendWebhook(data)
    local webhookUrl = getgenv().webhook
    if not webhookUrl or webhookUrl == "" then return end
    
    local HttpService = game:GetService("HttpService")
    local payload = HttpService:JSONEncode(data)
    
    pcall(function()
        local requestFunc = syn and syn.request or http_request or request or HttpPost or http.request
        if requestFunc then
            requestFunc({
                Url = webhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = payload
            })
        end
    end)
end

local function sendStatusWebhook(statusType, extraData)
    local player = game.Players.LocalPlayer
    local currentLevel = player.PlayerStats.Level.Value
    local currentPrestige = player.PlayerStats.Prestige.Value
    local timestamp = getISO8601()
    
    local embed = {
        title = "Methion Hub - Auto StoryLine",
        color = statusType == "started" and 3447003 or statusType == "completed" and 16776960 or statusType == "stopped" and 15158332 or 7498239,
        timestamp = timestamp,
        footer = {
            text = "Methion YBA Script - Auto StoryLine"
        },
        thumbnail = {
            url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
        }
    }
    
    if statusType == "started" then
        embed.description = "🟢 **Player Started Auto StoryLine**"
        embed.fields = {
            {name = "⏰ Started At", value = os.date("%Y-%m-%d %H:%M:%S"), inline = true},
            {name = "📊 Starting Level", value = "Level " .. currentLevel, inline = true},
            {name = "🏅 Starting Prestige", value = "Prestige " .. currentPrestige, inline = true},
            {name = "🎯 Goal", value = "Prestige 3 Level 50", inline = true}
        }
        
    elseif statusType == "stopped" then
        local startLevel = autoPrestigeStartData.startLevel or "?"
        local startPrestige = autoPrestigeStartData.startPrestige or "?"
        local startTime = autoPrestigeStartData.startTime
        local duration = startTime and formatDuration(tick() - startTime) or "Unknown"
        
        embed.description = "🔴 **Player Stopped Auto StoryLine**"
        embed.fields = {
            {name = "⏰ Stopped At", value = os.date("%Y-%m-%d %H:%M:%S"), inline = true},
            {name = "⏱️ Duration", value = duration, inline = true},
            {name = "📊 Started At", value = "P" .. startPrestige .. " L" .. startLevel, inline = true},
            {name = "📈 Ended At", value = "P" .. currentPrestige .. " L" .. currentLevel, inline = true},
            {name = "📈 Progress", value = "Gained: P" .. (currentPrestige - (startPrestige or 0)) .. " L" .. (currentLevel - (startLevel or 0)), inline = true}
        }
        
    elseif statusType == "completed" then
        local startLevel = autoPrestigeStartData.startLevel or 1
        local startPrestige = autoPrestigeStartData.startPrestige or 0
        local startTime = autoPrestigeStartData.startTime
        local duration = startTime and formatDuration(tick() - startTime) or "Unknown"
        
        embed.description = "@everyone 🎉 **PLAYER COMPLETED AUTO STORYLINE!** 🎉\n\nGive him a slap on the *****! 👋🍑"
        embed.color = 16776960
        embed.fields = {
            {name = "👤 Player", value = player.Name, inline = true},
            {name = "🏆 Final Status", value = "MAXED P3 L50!", inline = true},
            {name = "⏱️ Total Time", value = duration, inline = true},
            {name = "📊 Journey", value = "From P" .. startPrestige .. " L" .. startLevel .. " → **P3 L50**", inline = false},
            {name = "🎯 Achievement", value = "Completed Full Storyline!", inline = true},
            {name = "⏰ Completed At", value = os.date("%Y-%m-%d %H:%M:%S"), inline = true}
        }
    end
    
    sendWebhook({embeds = {embed}})
end

local function vu93(p89)
    local embed = {
        title = "Methion Hub - Auto StoryLine",
        description = p89,
        color = 7498239,
        timestamp = getISO8601()
    }
    sendWebhook({embeds = {embed}})
end

local function GetPlayer()
    return game.Players.LocalPlayer
end

local function GetCharacter()
    return GetPlayer().Character or GetPlayer().CharacterAdded:Wait()
end

local function GetHRP()
    local Character = GetCharacter()
    return Character and Character:FindFirstChild("HumanoidRootPart")
end

local function HasStand()
    local player = GetPlayer()
    if player and player:FindFirstChild("PlayerStats") and player.PlayerStats:FindFirstChild("Stand") then
        local standValue = player.PlayerStats.Stand.Value
        if standValue ~= "None" and standValue ~= "" and standValue ~= nil then
            return true
        end
    end
    return false
end

local function GetPlayerLevel()
    local player = GetPlayer()
    if player and player:FindFirstChild("PlayerStats") and player.PlayerStats:FindFirstChild("Level") then
        return player.PlayerStats.Level.Value
    end
    return 0
end

local function CountItem(itemName)
    local count = 0
    local ply = GetPlayer()
    if ply and ply:FindFirstChild("Backpack") then
        for _, item in pairs(ply.Backpack:GetChildren()) do
            if item.Name == itemName then count = count + 1 end
        end
    end
    if ply and ply.Character then
        for _, item in pairs(ply.Character:GetChildren()) do
            if item.Name == itemName then count = count + 1 end
        end
    end
    return count
end

local function CollectRokaArrow()
    local player = GetPlayer()
    
    local function LearnWorthiness()
        local Character = GetCharacter()
        if not Character or not Character:FindFirstChild("RemoteFunction") then return end
        
        local worthinessSkills = {"Worthiness", "Worthiness II", "Worthiness III", "Worthiness IV", "Worthiness V"}
        for _, skill in pairs(worthinessSkills) do
            pcall(function()
                Character.RemoteFunction:InvokeServer("LearnSkill", {
                    ["Skill"] = skill,
                    ["SkillTreeType"] = "Character"
                })
            end)
            task.wait(0.1)
        end
    end
    
    LearnWorthiness()
    task.wait(0.5)
    
    local attempts = 0
    local maxAttempts = 50
    
    while attempts < maxAttempts do
        attempts = attempts + 1
        local currentLevel = GetPlayerLevel()
        local currentStand = player.PlayerStats.Stand.Value
        
        if currentLevel >= 3 and HasStand() then
            local standName = player.PlayerStats.Stand.Value
            if not blacklistedStands[standName] then
                notify("Auto Prestige", "Valid stand obtained: " .. standName)
                return true
            else
                notify("Auto Prestige", "Blacklisted stand: " .. standName .. " - Rolling again...")
            end
        end
        
        if HasStand() and blacklistedStands[player.PlayerStats.Stand.Value] then
            local roka = player.Backpack:FindFirstChild("Rokakaka") or player.Character:FindFirstChild("Rokakaka")
            if roka then
                local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    humanoid:EquipTool(roka)
                    task.wait(0.5)
                    local remote = player.Character:FindFirstChild("RemoteEvent")
                    if remote then
                        remote:FireServer("UseItem", roka)
                    end
                    
                    for i = 1, 10 do
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        task.wait(0.1)
                    end
                    
                    local dialogueWaitTime = 0
                    while dialogueWaitTime < 3 do
                        if player.PlayerGui:FindFirstChild("DialogueGui") then break end
                        task.wait(0.1)
                        dialogueWaitTime = dialogueWaitTime + 0.1
                    end
                    
                    if player.PlayerGui:FindFirstChild("DialogueGui") then
                        task.wait(0.5)
                        pcall(function()
                            local gui = player.PlayerGui.DialogueGui
                            if gui.Frame.Options:FindFirstChild("Option1") then
                                firesignal(gui.Frame.Options.Option1.TextButton.MouseButton1Click)
                            end
                        end)
                    end
                    
                    player.CharacterAdded:Wait()
                    task.wait(1.5)
                    LearnWorthiness()
                    task.wait(0.5)
                end
            else
                notify("Auto Prestige", "No Rokakaka to reset blacklisted stand! Collecting...")
            end
        end
        
        if not HasStand() or blacklistedStands[player.PlayerStats.Stand.Value] then
            local arrow = player.Backpack:FindFirstChild("Mysterious Arrow") or player.Character:FindFirstChild("Mysterious Arrow")
            
            if not arrow then
                local spawns = workspace:FindFirstChild("Item_Spawns") and workspace.Item_Spawns:FindFirstChild("Items")
                if spawns then
                    for _, v in pairs(spawns:GetChildren()) do
                        local prox = v:FindFirstChild("ProximityPrompt")
                        local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChild("Part") or v.PrimaryPart
                        
                        if prox and part and part.Transparency < 1 then
                            local itemName = prox.ObjectText
                            if itemName == "Mysterious Arrow" or itemName == "Rokakaka" then
                                if CountItem(itemName) < 1 then
                                    local Character = GetCharacter()
                                    local HRP = GetHRP()
                                    if HRP and part then
                                        local oldCF = HRP.CFrame
                                        HRP.CFrame = part.CFrame - Vector3.new(0, 5, 0)
                                        task.wait(0.3)
                                        
                                        local noclipConn = game:GetService("RunService").Stepped:Connect(function()
                                            for _, p in pairs(Character:GetDescendants()) do
                                                if p:IsA("BasePart") then p.CanCollide = false end
                                            end
                                        end)
                                        
                                        for i = 1, 5 do
                                            fireproximityprompt(prox, 0, true)
                                            task.wait(0.1)
                                        end
                                        
                                        noclipConn:Disconnect()
                                        HRP.CFrame = oldCF
                                        task.wait(0.3)
                                    end
                                end
                            end
                        end
                    end
                end
                
                if CountItem("Mysterious Arrow") == 0 and CountItem("Rokakaka") == 0 then
                    local money = player.PlayerStats.Money.Value
                    local Character = GetCharacter()
                    local remote = Character:FindFirstChild("RemoteEvent")
                    
                    if money >= 3250 and remote then
                        remote:FireServer("PurchaseShopItem", {["ItemName"] = "1x Rokakaka"}, 1, 2)
                        task.wait(0.5)
                        remote:FireServer("PurchaseShopItem", {["ItemName"] = "1x Mysterious Arrow"}, 1, 2)
                        task.wait(0.5)
                    end
                end
                
                arrow = player.Backpack:FindFirstChild("Mysterious Arrow") or player.Character:FindFirstChild("Mysterious Arrow")
            end
            
            if arrow then
                local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    humanoid:EquipTool(arrow)
                    task.wait(0.5)
                    local remote = player.Character:FindFirstChild("RemoteEvent")
                    if remote then
                        remote:FireServer("UseItem", arrow)
                    end
                    
                    for i = 1, 10 do
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        task.wait(0.1)
                    end
                    
                    local dialogueWaitTime = 0
                    while dialogueWaitTime < 3 do
                        if player.PlayerGui:FindFirstChild("DialogueGui") then break end
                        task.wait(0.1)
                        dialogueWaitTime = dialogueWaitTime + 0.1
                    end
                    
                    if player.PlayerGui:FindFirstChild("DialogueGui") then
                        task.wait(0.5)
                        pcall(function()
                            local gui = player.PlayerGui.DialogueGui
                            if gui.Frame.Options:FindFirstChild("Option1") then
                                firesignal(gui.Frame.Options.Option1.TextButton.MouseButton1Click)
                            end
                        end)
                    end
                    
                    task.wait(2)
                    
                    if player.Character ~= GetCharacter() then
                        player.CharacterAdded:Wait()
                        task.wait(1.5)
                        LearnWorthiness()
                        task.wait(0.5)
                    end
                end
            end
        end
        
        task.wait(0.5)
    end
    
    return false
end

local function FarmLevelOneQuest()
    local player = GetPlayer()
    notify("Auto Prestige", "Level 1-2 detected! Farming Officer Sam quest...")
    vu93("Starting Level 1 quest farming to reach level 3...")
    
    while GetPlayerLevel() < 3 do
        if not autoPrestigeEnabled then return false end
        
        local Character = GetCharacter()
        if not Character then task.wait(1) continue end
        
        local HRP = GetHRP()
        if not HRP then task.wait(1) continue end
        
        local questsFrame = player.PlayerGui.HUD.Main.Frames.Quest.Quests
        local hasQuest = false
        
        for _, quest in pairs(questsFrame:GetChildren()) do
            if quest.Name:find("Officer Sam") or quest.Name:find("Thug") then
                hasQuest = true
                break
            end
        end
        
        if not hasQuest then
            local questNPC = workspace:FindFirstChild("Dialogues") and workspace.Dialogues:FindFirstChild("Officer Sam [Lvl. 1+]")
            if questNPC then
                local Character = GetCharacter()
                local remote = Character:FindFirstChild("RemoteEvent")
                if remote then
                    local DialogueName = questNPC:FindFirstChild("Dialogue")
                    if DialogueName then
                        for i = 1, 6 do
                            remote:FireServer("EndDialogue", {
                                ["NPC"] = DialogueName.Value,
                                ["Option"] = "Option1",
                                ["Dialogue"] = "Dialogue" .. i
                            })
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        
        local living = workspace:FindFirstChild("Living")
        if living then
            for _, enemy in pairs(living:GetChildren()) do
                if enemy.Name == "Thug" and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Health") and enemy.Health.Value > 0 then
                    local enemyHRP = enemy.HumanoidRootPart
                    local oldPos = HRP.CFrame
                    
                    while enemy and enemy.Parent and enemy:FindFirstChild("Health") and enemy.Health.Value > 0 and GetPlayerLevel() < 3 do
                        if not autoPrestigeEnabled then return false end
                        
                        pcall(function()
                            HRP.CFrame = enemyHRP.CFrame - enemyHRP.CFrame.LookVector * 2
                            local Character = GetCharacter()
                            if Character and Character:FindFirstChild("RemoteFunction") then
                                Character.RemoteFunction:InvokeServer("Attack", "m1")
                            end
                        end)
                        task.wait(0.3)
                    end
                    
                    HRP.CFrame = oldPos
                    break
                end
            end
        end
        
        task.wait(0.5)
    end
    
    notify("Auto Prestige", "Level 3 reached! Now obtaining stand...")
    vu93("Level 3 reached! Collecting items and obtaining stand...")
    return true
end

local autoPrestigeEnabled = false
AutoPrestigeSection:Toggle({
    Flag = "AutoPrestigeEnabled",
    Title = "Enable Auto Prestige 3",
    Default = false,
    Callback = function(value)
        if value then
            autoPrestigeEnabled = true
            
            local player = GetPlayer()
            autoPrestigeStartData = {
                enabled = true,
                startTime = tick(),
                startLevel = player.PlayerStats.Level.Value,
                startPrestige = player.PlayerStats.Prestige.Value,
                startDate = os.date("%Y-%m-%d %H:%M:%S")
            }
            
            sendStatusWebhook("started")
            notify("YBA Script", "Auto Prestige 3 Started!")
            
            spawn(function()
                local success, err = pcall(function()
                    getgenv().waitUntilCollect = 0.5
                    getgenv().sortOrder = "Asc"
                    getgenv().lessPing = false
                    getgenv().autoRequiem = true
                    getgenv().NPCTimeOut = 15
                    getgenv().HamonCharge = 90
                    getgenv().webhook = getgenv().webhook or ""
                    
                    print("Auto Prestige 3 Started - Smart Storyline Check Mode");

                    repeat
                        task.wait()
                    until game:IsLoaded() and (game.Players.LocalPlayer and game.Players.LocalPlayer.Character)
                    
                    local vu81 = game.Players.LocalPlayer
                    local vu82 = vu81.Character
                    
                    repeat
                        task.wait()
                    until vu82:FindFirstChild("RemoteEvent") and vu82:FindFirstChild("RemoteFunction")
                    
                    local vu83 = vu82.RemoteFunction
                    local vu84 = vu82.RemoteEvent
                    local vu85 = vu82.PrimaryPart
                    local vu86 = true
                    
                    if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
                        notify("YBA Script", "Already max prestige and level!")
                        autoPrestigeEnabled = false
                        return
                    end

                    if not vu81.PlayerGui:FindFirstChild("HUD") then
                        game:GetService("ReplicatedStorage").Objects.HUD:Clone().Parent = vu81.PlayerGui
                    end
                    
                    vu84:FireServer("PressedPlay")
                    
                    if vu81.PlayerGui:FindFirstChild("LoadingScreen1") then
                        vu81.PlayerGui:FindFirstChild("LoadingScreen1"):Destroy()
                    end
                    if vu81.PlayerGui:FindFirstChild("LoadingScreen") then
                        vu81.PlayerGui:FindFirstChild("LoadingScreen"):Destroy()
                    end
                    
                    task.spawn(function()
                        local dof = game.Lighting:WaitForChild("DepthOfField", 10)
                        if dof then
                            dof:Destroy()
                        end
                    end)
                    
                    pcall(function()
                        workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_6.Size = Vector3.new(2048, 89, 2048)
                        workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_4.Size = Vector3.new(2048, 89, 2048)
                    end)
                    
                    local vu87 = {}
                    if not pcall(function()
                        vu87 = game:GetService("HttpService"):JSONDecode(readfile("AutoPres3_" .. vu81.Name .. ".txt"))
                    end) then
                        vu87 = {
                            Time = tick(),
                            Prestige = vu81.PlayerStats.Prestige.Value,
                            Level = vu81.PlayerStats.Level.Value
                        }
                        pcall(function()
                            writefile("AutoPres3_" .. vu81.Name .. ".txt", game:GetService("HttpService"):JSONEncode(vu87))
                        end)
                    end
                    
                    local vu88 = tick()
                    
                    pcall(function()
                        local vu94 = nil
                        vu94 = hookfunction(getrawmetatable(game.Players.LocalPlayer.Character.HumanoidRootPart.Position).__index, function(p95, p96)
                            return getcallingscript().Name == "ItemSpawn" and p96:lower() == "magnitude" and 0 or vu94(p95, p96)
                        end)
                    end)
                    
                    pcall(function()
                        local vu97 = nil
                        vu97 = hookmetamethod(game, "__namecall", newcclosure(function(p98, ...)
                            return getnamecallmethod() == "InvokeServer" and ({...})[1] == "idklolbrah2de" and "  ___XP DE KEY" or vu97(p98, ...)
                        end))
                    end)
                    
                    pcall(function()
                        hookfunction(workspace.Raycast, function() return nil end)
                    end)
                    
                    local v117 = Instance.new("Part")
                    v117.Name = "AutoPrestigePlatform"
                    v117.Parent = workspace
                    v117.Anchored = true
                    v117.Size = Vector3.new(25, 1, 25)
                    v117.Position = Vector3.new(500, 2000, 500)
                    v117.Transparency = 1
                    
                    local function vu124(p118)
                        local v122 = {
                            Position = {},
                            ProximityPrompt = {},
                            Items = {}
                        }
                        local itemsFolder = game:GetService("Workspace"):FindFirstChild("Item_Spawns") and game:GetService("Workspace").Item_Spawns:FindFirstChild("Items")
                        if not itemsFolder then return v122 end
                        
                        for _, v123 in pairs(itemsFolder:GetChildren()) do
                            if v123:FindFirstChild("MeshPart") and v123:FindFirstChild("ProximityPrompt") then
                                if v123.ProximityPrompt.ObjectText == p118 and v123.ProximityPrompt.MaxActivationDistance == 8 then
                                    table.insert(v122.Items, v123.ProximityPrompt.ObjectText)
                                    table.insert(v122.ProximityPrompt, v123.ProximityPrompt)
                                    table.insert(v122.Position, v123.MeshPart.CFrame)
                                end
                            end
                        end
                        return v122
                    end
                    
                    local function vu131(p125)
                        local v129 = 0
                        for _, v130 in pairs(vu81.Backpack:GetChildren()) do
                            if v130.Name == p125 then
                                v129 = v129 + 1
                            end
                        end
                        return v129
                    end
                    
                    local function vu135(p132, p133)
                        local v134 = vu81.Backpack:WaitForChild(p132, 5)
                        if not v134 then
                            return false
                        end
                        if p133 then
                            vu81.Character.Humanoid:EquipTool(v134)
                            vu81.Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill", {
                                Skill = "Worthiness " .. p133,
                                SkillTreeType = "Character"
                            })
                            repeat
                                v134:Activate()
                                task.wait()
                            until vu81.PlayerGui:FindFirstChild("DialogueGui")
                            
                            pcall(function()
                                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
                                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.Options:WaitForChild("Option1").TextButton.MouseButton1Click)
                                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
                                repeat
                                    task.wait()
                                until vu81.PlayerGui:WaitForChild("DialogueGui").Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
                                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
                            end)
                        end
                        return true
                    end
                    
                    local function vu136()
                        vu81.Character.HumanoidRootPart.CFrame = CFrame.new(500, 2010, 500)
                        
                        if vu81.PlayerStats.Stand.Value == "None" then
                            print("No stand, using Mysterious Arrow")
                            vu135("Mysterious Arrow", "II")
                            task.wait(0.5)
                            repeat task.wait() until vu81.PlayerStats.Stand.Value ~= "None"
                            print("Got stand: " .. vu81.PlayerStats.Stand.Value)
                        end
                        vu86 = true
                    end
                    
                    local function vu147(pu137, pu138)
                        local vu139 = false
                        local vu140 = getgenv().waitUntilCollect + 5
                        
                        if vu82:FindFirstChild("SummonedStand") and vu82.SummonedStand.Value then
                            vu83:InvokeServer("ToggleStand", "Toggle")
                        end
                        
                        local connection
                        connection = vu81.Backpack.ChildAdded:Connect(function()
                            vu139 = true
                            if connection then connection:Disconnect() end
                        end)
                        
                        task.spawn(function()
                            while not vu139 do
                                task.wait()
                                pcall(function()
                                    if pu137.Position[pu138] then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pu137.Position[pu138] - Vector3.new(0, 10, 0)
                                    end
                                end)
                            end
                        end)
                        
                        task.wait(getgenv().waitUntilCollect)
                        
                        task.spawn(function()
                            if pu137.ProximityPrompt[pu138] then
                                fireproximityprompt(pu137.ProximityPrompt[pu138])
                            end
                            
                            local v141 = vu81.PlayerGui:WaitForChild("ScreenGui", 5)
                            if v141 then
                                local v142 = v141:WaitForChild("Part")
                                if v142 then
                                    for _, v146 in pairs(v142:GetDescendants()) do
                                        if v146:FindFirstChild("Part") and v146:IsA("ImageButton") then
                                            local part = v146:WaitForChild("Part")
                                            if part and part.TextColor3 == Color3.new(0, 1, 0) then
                                                repeat
                                                    pcall(function()
                                                        firesignal(v146.MouseEnter)
                                                        firesignal(v146.MouseButton1Up)
                                                        firesignal(v146.MouseButton1Click)
                                                        firesignal(v146.Activated)
                                                    end)
                                                    task.wait()
                                                until not vu81.PlayerGui:FindFirstChild("ScreenGui")
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                        
                        task.spawn(function()
                            for _ = vu140, 1, -1 do
                                task.wait(1)
                            end
                            if not vu139 then
                                vu139 = true
                            end
                        end)
                        
                        while not vu139 do
                            task.wait()
                        end
                    end
                    
                    local function vu156(p148, p149)
                        local v150 = vu124(p148)
                        local currentCount = vu131(p148)
                        local targetCount = currentCount + p149
                        
                        local noclipConn = game:GetService("RunService").Stepped:Connect(function()
                            for _, v in pairs(vu82:GetDescendants()) do
                                if v:IsA("BasePart") then
                                    v.CanCollide = false
                                end
                            end
                        end)
                        
                        for i, _ in pairs(v150.Position) do
                            if vu131(p148) >= targetCount then
                                break
                            end
                            
                            local newCount = vu131(p148)
                            if newCount >= targetCount then
                                break
                            end
                            
                            local success = vu147(v150, i)
                            task.wait(0.5)
                        end
                        
                        if noclipConn then
                            noclipConn:Disconnect()
                        end
                        
                        for _, v in pairs(vu82:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = true
                            end
                        end
                        
                        return true
                    end
                    
                    local function vu160(p157, p158, p159)
                        vu84:FireServer("EndDialogue", {
                            NPC = p157,
                            Dialogue = p158,
                            Option = p159
                        })
                    end
                    
                    local function vu163()
                        local v161 = {
                            Storyline = {
                                "#1", "#1", "#1", "#2", "#3", "#3", "#3", "#4", "#5", "#6", "#7", "#8", "#9", "#10", "#11", "#11", "#12", "#14"
                            },
                            Dialogue = {
                                "Dialogue2", "Dialogue6", "Dialogue6", "Dialogue3", "Dialogue3", "Dialogue3", "Dialogue6", "Dialogue3", "Dialogue5", "Dialogue5", "Dialogue5", "Dialogue4", "Dialogue7", "Dialogue6", "Dialogue8", "Dialogue11", "Dialogue3", "Dialogue2"
                            }
                        }
                        for v162 = 1, 18 do
                            vu84:FireServer("EndDialogue", {
                                NPC = "Storyline " .. v161.Storyline[v162],
                                Dialogue = v161.Dialogue[v162],
                                Option = "Option1"
                            })
                        end
                    end
                    
                    local function vu179(p164, pu165, pu166, p167)
                        local vu168 = workspace.Living:WaitForChild(p164, getgenv().NPCTimeOut)
                        if not vu168 then
                            return false
                        end
                        
                        local v169 = true
                        local vu170 = false
                        local vu171 = nil
                        
                        local function v173()
                            pcall(function()
                                if vu81.PlayerStats.Stand.Value ~= "None" then
                                    if vu82:FindFirstChild("SummonedStand") and vu82.SummonedStand.Value and vu82:FindFirstChild("StandMorph") then
                                        vu82.StandMorph.PrimaryPart.CFrame = vu168.HumanoidRootPart.CFrame + vu168.HumanoidRootPart.CFrame.lookVector * -1.1
                                        vu85.CFrame = vu82.StandMorph.PrimaryPart.CFrame + vu82.StandMorph.PrimaryPart.CFrame.lookVector - Vector3.new(0, pu165, 0)
                                        
                                        if not vu82:FindFirstChild("FocusCam") then
                                            local v172 = Instance.new("ObjectValue", vu82)
                                            v172.Name = "FocusCam"
                                            v172.Value = vu82.StandMorph.PrimaryPart
                                        end
                                        if vu82:FindFirstChild("FocusCam") and vu82.FocusCam.Value ~= vu82.StandMorph.PrimaryPart then
                                            vu82.FocusCam.Value = vu82.StandMorph.PrimaryPart
                                        end
                                    else
                                        vu83:InvokeServer("ToggleStand", "Toggle")
                                    end
                                else
                                    vu85.CFrame = vu168.HumanoidRootPart.CFrame - Vector3.new(0, 5, 0)
                                end
                            end)
                        end
                        
                        local function v174()
                            if vu82:FindFirstChild("Hamon") then
                                if vu82.Hamon.Value <= getgenv().HamonCharge then
                                    vu83:InvokeServer("AssignSkillKey", {
                                        Type = "Spec",
                                        Key = "Enum.KeyCode.L",
                                        Skill = "Hamon Breathing"
                                    })
                                    vu82.RemoteEvent:FireServer("InputBegan", {
                                        Input = Enum.KeyCode.L
                                    })
                                end
                            end
                        end
                        
                        local function v175()
                            pcall(function()
                                if vu168 and vu168.Parent ~= nil and vu168:FindFirstChild("Humanoid") then
                                    if game:GetService("CollectionService"):HasTag(vu168, "Blocking") then
                                        vu84:FireServer("InputBegan", {Input = Enum.KeyCode.R})
                                    elseif vu168.Humanoid.Health > 1 then
                                        vu83:InvokeServer("Attack", "m1")
                                    end
                                end
                            end)
                        end
                        
                        local v177 = vu81.PlayerGui.HUD.Main.DropMoney.Money.ChildAdded:Connect(function(p176)
                            pcall(function()
                                if tonumber(string.match(p176.Name, "%d+")) and vu168 then
                                    vu170 = true
                                    if vu171 then vu171:Disconnect() end
                                    if not pu166 then
                                        vu168:Destroy()
                                    end
                                end
                            end)
                        end)
                        
                        local v178 = v177
                        while v169 do
                            task.wait()
                            if not vu168 or not vu168:FindFirstChild("HumanoidRootPart") then
                                if v178 then v178:Disconnect() end
                                v169 = false
                                break
                            end
                            if p167 then
                                pcall(p167)
                            end
                            task.spawn(v173)
                            task.spawn(v174)
                            task.spawn(v175)
                        end
                        return vu170
                    end
                    
                    local function vu183()
                        task.spawn(function()
                            local skills = {"Destructive Power I", "Destructive Power II", "Destructive Power III", "Destructive Power IV", "Destructive Power V"}
                            for _, skill in pairs(skills) do
                                vu83:InvokeServer("LearnSkill", {Skill = skill, SkillTreeType = "Stand"})
                            end
                            
                            if vu81.PlayerStats.Spec.Value == "Hamon (William Zeppeli)" then
                                vu83:InvokeServer("LearnSkill", {Skill = "Hamon Punch V", SkillTreeType = "Spec"})
                                vu83:InvokeServer("LearnSkill", {Skill = "Lung Capacity V", SkillTreeType = "Spec"})
                                vu83:InvokeServer("LearnSkill", {Skill = "Breathing Technique V", SkillTreeType = "Spec"})
                            end
                        end)
                    end
                    
                    local function isStorylineCompleted()
                        local vu184 = vu81.PlayerGui.HUD.Main.Frames.Quest.Quests
                        
                        local storylineQuests = {
                            "Help Giorno by Defeating Security Guards",
                            "Defeat Leaky Eye Luca",
                            "Defeat Bucciarati",
                            "Collect $5,000 To Cover For Popo's Real Fortune",
                            "Defeat Fugo And His Purple Haze",
                            "Defeat Pesci",
                            "Defeat Ghiaccio",
                            "Defeat Diavolo"
                        }
                        
                        for _, questName in pairs(storylineQuests) do
                            if vu184:FindFirstChild(questName) then
                                return false
                            end
                        end
                        
                        vu160("Storyline #1", "Dialogue2", "Option1")
                        task.wait(0.5)
                        
                        for _, questName in pairs(storylineQuests) do
                            if vu184:FindFirstChild(questName) then
                                return false
                            end
                        end
                        
                        return true
                    end
                    
                    local function vampireFarmUntilMax()
                        vu93("Farming vampires until max level...")
                        notify("YBA Script", "Farming vampires until max level...")
                        
                        while autoPrestigeEnabled and vu81.PlayerStats.Level.Value < 50 do
                            local currentLevel = vu81.PlayerStats.Level.Value
                            local currentPrestige = vu81.PlayerStats.Prestige.Value
                            local maxForPrestige = 35
                            if currentPrestige == 1 then maxForPrestige = 40
                            elseif currentPrestige == 2 then maxForPrestige = 45
                            elseif currentPrestige >= 3 then maxForPrestige = 50 end
                            
                            if currentLevel >= maxForPrestige then
                                vu93("Reached max level for P" .. currentPrestige .. ": L" .. currentLevel)
                                break
                            end
                            
                            local vu184 = vu81.PlayerGui.HUD.Main.Frames.Quest.Quests
                            if not vu184:FindFirstChild("Take down 3 vampires") then
                                vu160("William Zeppeli", "Dialogue4", "Option1")
                                task.wait(0.1)
                            end
                            
                            getgenv().HamonCharge = 10
                            vu179("Vampire", 15, false, function()
                                pcall(function()
                                    local vampire = workspace.Living:FindFirstChild("Vampire")
                                    if vampire and vampire:FindFirstChild("HumanoidRootPart") then
                                        vu81.Character.PrimaryPart.CFrame = vampire.HumanoidRootPart.CFrame - Vector3.new(0, 15, 0)
                                    end
                                end)
                            end)
                            
                            task.wait(0.1)
                        end
                        
                        vu93("Vampire farming complete! Level: " .. vu81.PlayerStats.Level.Value)
                        return true
                    end
                    
                    local function doPrestige()
                        local currentPrestige = vu81.PlayerStats.Prestige.Value
                        local currentLevel = vu81.PlayerStats.Level.Value
                        
                        local canPrestige = false
                        if currentPrestige == 0 and currentLevel >= 35 then canPrestige = true
                        elseif currentPrestige == 1 and currentLevel >= 40 then canPrestige = true
                        elseif currentPrestige == 2 and currentLevel >= 45 then canPrestige = true
                        end
                        
                        if not canPrestige then
                            return false
                        end
                        
                        vu93("Prestiging! P" .. currentPrestige .. " -> P" .. (currentPrestige + 1))
                        notify("YBA Script", "Prestiging to P" .. (currentPrestige + 1) .. "...")
                        
                        vu160("Prestige", "Dialogue2", "Option1")
                        
                        local startWait = tick()
                        while tick() - startWait < 10 do
                            if vu81.PlayerStats.Prestige.Value > currentPrestige then
                                vu93("Prestiged successfully!")
                                return true
                            end
                            task.wait(0.1)
                        end
                        
                        return vu81.PlayerStats.Prestige.Value > currentPrestige
                    end
                    
                    local function resetCharacter()
                        vu93("Resetting character...")
                        notify("YBA Script", "Resetting character...")
                        
                        local humanoid = vu81.Character and vu81.Character:FindFirstChildWhichIsA("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                        end
                        
                        vu81.CharacterAdded:Wait()
                        task.wait(3)
                        
                        vu82 = vu81.Character
                        if vu82 then
                            vu83 = vu82:WaitForChild("RemoteFunction", 5)
                            vu84 = vu82:WaitForChild("RemoteEvent", 5)
                            vu85 = vu82:WaitForChild("PrimaryPart", 5)
                        end
                        
                        for _, v198 in pairs(vu82:GetDescendants()) do
                            if v198:IsA("BasePart") and v198.CanCollide == true then
                                v198.CanCollide = false
                            end
                        end
                        
                        if not vu81.PlayerGui:FindFirstChild("HUD") then
                            game:GetService("ReplicatedStorage").Objects.HUD:Clone().Parent = vu81.PlayerGui
                        end
                        
                        return true
                    end
                    
                    local function doStorylineLoop()
                        if not autoPrestigeEnabled then return false end
                        
                        if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
                            sendStatusWebhook("completed")
                            
                            vu93("MAXED! P3 L50")
                            notify("YBA Script", "MAX PRESTIGE 3 LEVEL 50!")
                            
                            autoPrestigeEnabled = false
                            pcall(function()
                                delfile("AutoPres3_" .. vu81.Name .. ".txt")
                            end)
                            return false
                        end
                        
                        if vu81.PlayerStats.Stand.Value == "None" then
                            vu136()
                            task.wait(1)
                        end
                        
                        if vu82:FindFirstChild("RemoteFunction") and not (vu82:FindFirstChild("SummonedStand") and vu82.SummonedStand.Value) then
                            vu83:InvokeServer("ToggleStand", "Toggle")
                            task.wait(0.5)
                        end
                        
                        vu183()
                        
                         if getgenv().autoRequiem and vu81.PlayerStats.Level.Value >= 25 and vu81.PlayerStats.Prestige.Value >= 1 then
                            if vu81.Backpack:FindFirstChild("Requiem Arrow") then
                                if vu81.PlayerStats.Stand.Value == "King Crimson" or vu81.PlayerStats.Stand.Value == "Star Platinum" then
                                    vu81.Character.HumanoidRootPart.CFrame = CFrame.new(500, 2010, 500)
                                    local v186 = vu81.PlayerStats.Stand.Value
                                    vu135("Requiem Arrow", "V")
                                    repeat task.wait() until vu81.PlayerStats.Stand.Value ~= v186
                                    task.wait(1)
                                end
                            end
                        end
                        
                        if vu81.PlayerStats.Spec.Value == "None" and vu81.PlayerStats.Level.Value >= 25 then
                            if vu81.PlayerStats.Money.Value < 10000 then
                                vu93("Collecting money for Hamon...")
                                local itemsToSell = {"Mysterious Arrow", "Rokakaka", "Diamond", "Steel Ball", "Quinton's Glove", 
                                    "Pure Rokakaka", "Rib Cage of The Saint's Corpse", "Ancient Scroll", "Clackers", "Caesar's Headband"}
                                for _, item in pairs(itemsToSell) do
                                    if vu81.PlayerStats.Money.Value >= 10000 then break end
                                    vu156(item, 10)
                                    local tool = vu81.Backpack:FindFirstChild(item)
                                    if tool then
                                        vu81.Character.Humanoid:EquipTool(tool)
                                        vu160("Merchant", "Dialogue5", "Option2")
                                    end
                                end
                            end
                            
                            if vu81.PlayerStats.Money.Value >= 10000 then
                                if not vu81.Backpack:FindFirstChild("Zeppeli's Hat") then
                                    vu156("Zeppeli's Hat", 1)
                                end
                                
                                if vu81.Backpack:FindFirstChild("Zeppeli's Hat") then
                                    vu93("Buying Hamon...")
                                    vu81.Character.Humanoid:EquipTool(vu81.Backpack:FindFirstChild("Zeppeli's Hat"))
                                    vu84:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue:FindFirstChild("Lisa Lisa"))
                                    
                                    task.wait(0.5)
                                    pcall(function()
                                        repeat
                                            firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
                                            task.wait(0.1)
                                        until vu81.PlayerGui.DialogueGui.Frame.Options:FindFirstChild("Option1")
                                        
                                        firesignal(vu81.PlayerGui.DialogueGui.Frame.Options.Option1.TextButton.MouseButton1Click)
                                        
                                        repeat
                                            firesignal(vu81.PlayerGui.DialogueGui.Frame.ClickContinue.MouseButton1Click)
                                            task.wait(0.1)
                                        until vu81.PlayerStats.Spec.Value ~= "None"
                                    end)
                                    
                                    task.wait(2)
                                end
                            end
                        end
                        
                        local vu184 = vu81.PlayerGui.HUD.Main.Frames.Quest.Quests
                        local v185 = 0
                        
                        while #vu184:GetChildren() < 2 and v185 < 100 do
                            if not vu184:FindFirstChild("Take down 3 vampires") then
                                vu160("Storyline #1", "Dialogue2", "Option1")
                            end
                            pcall(function()
                                vu81.QuestsRemoteFunction:InvokeServer({"ReturnData"})
                            end)
                            vu163()
                            task.wait(0.1)
                            v185 = v185 + 1
                        end
                        
                        local questHandlers = {
                            ["Help Giorno by Defeating Security Guards"] = function()
                                vu93("Killing Security Guards...")
                                return vu179("Security Guard", 15)
                            end,
                            ["Defeat Leaky Eye Luca"] = function()
                                vu93("Killing Leaky Eye Luca...")
                                return vu179("Leaky Eye Luca", 15)
                            end,
                            ["Defeat Bucciarati"] = function()
                                vu93("Killing Bucciarati...")
                                return vu179("Bucciarati", 15)
                            end,
                            ["Collect $5,000 To Cover For Popo's Real Fortune"] = function()
                                if vu81.PlayerStats.Money.Value < 5000 then
                                    vu93("Collecting $5000...")
                                    local itemsToSell = {"Mysterious Arrow", "Rokakaka", "Diamond", "Steel Ball", "Quinton's Glove",
                                        "Pure Rokakaka", "Rib Cage of The Saint's Corpse", "Ancient Scroll", "Clackers", "Caesar's Headband"}
                                    for _, item in pairs(itemsToSell) do
                                        if vu81.PlayerStats.Money.Value >= 5000 then break end
                                        vu156(item, 10)
                                        local tool = vu81.Backpack:FindFirstChild(item)
                                        if tool then
                                            vu81.Character.Humanoid:EquipTool(tool)
                                            vu160("Merchant", "Dialogue5", "Option2")
                                            vu163()
                                        end
                                    end
                                end
                                return true
                            end,
                            ["Defeat Fugo And His Purple Haze"] = function()
                                vu93("Killing Fugo...")
                                return vu179("Fugo", 15)
                            end,
                            ["Defeat Pesci"] = function()
                                vu93("Killing Pesci...")
                                return vu179("Pesci", 15)
                            end,
                            ["Defeat Ghiaccio"] = function()
                                vu93("Killing Ghiaccio...")
                                return vu179("Ghiaccio", 15)
                            end,
                            ["Defeat Diavolo"] = function()
                                vu93("Killing Diavolo (Final Boss)...")
                                local result = vu179("Diavolo", 15)
                                vu160("Storyline #14", "Dialogue7", "Option1")
                                task.wait(2)
                                return result
                            end
                        }
                        
                        for questName, handler in pairs(questHandlers) do
                            if vu184:FindFirstChild(questName) then
                                local result = handler()
                                
                                if questName == "Defeat Diavolo" and result then
                                    vu93("Diablo defeated! Storyline complete.")
                                    notify("YBA Script", "Storyline complete! Farming vampires...")
                                    
                                    vampireFarmUntilMax()
                                    
                                    if doPrestige() then
                                        task.wait(3)
                                        
                                        vu86 = false
                                        vu88 = tick()
                                        vu93("Restarting storyline loop...")
                                        notify("YBA Script", "Restarting storyline for next prestige!")
                                        return doStorylineLoop()
                                    else
                                        if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
                                            sendStatusWebhook("completed")
                                            
                                            vu93("MAXED! P" .. vu81.PlayerStats.Prestige.Value .. " L" .. vu81.PlayerStats.Level.Value)
                                            notify("YBA Script", "MAX PRESTIGE 3 LEVEL 50!")
                                            autoPrestigeEnabled = false
                                            pcall(function()
                                                delfile("AutoPres3_" .. vu81.Name .. ".txt")
                                            end)
                                            return false
                                        end
                                    end
                                    
                                    return true
                                end
                                
                                task.wait(1)
                                vu163()
                                return doStorylineLoop()
                            end
                        end
                        
                        if #vu184:GetChildren() == 0 or vu184:FindFirstChild("Take down 3 vampires") then
                            vampireFarmUntilMax()
                            if doPrestige() then
                                task.wait(3)
                                vu86 = false
                                vu88 = tick()
                                return doStorylineLoop()
                            end
                        end
                        
                        if vu81.PlayerStats.Level.Value == 50 then
                            if vu81.PlayerStats.Prestige.Value >= 3 then
                                sendStatusWebhook("completed")
                                
                                vu93("MAXED! P3 L50")
                                notify("YBA Script", "MAX PRESTIGE 3 LEVEL 50!")
                                autoPrestigeEnabled = false
                                pcall(function()
                                    delfile("AutoPres3_" .. vu81.Name .. ".txt")
                                end)
                                return false
                            else
                                if doPrestige() then
                                    task.wait(3)
                                    vu86 = false
                                    vu88 = tick()
                                    return doStorylineLoop()
                                end
                            end
                        end
                        
                        vu163()
                        task.wait(1)
                        return doStorylineLoop()
                    end
                    
                    local function mainLoop()
                        -- NEW: Check if player is level 1-2, farm quest first
                        if GetPlayerLevel() < 3 then
                            FarmLevelOneQuest()
                        end
                        
                        -- NEW: Check if player has no stand or blacklisted stand
                        if GetPlayerLevel() >= 3 then
                            if not HasStand() or blacklistedStands[vu81.PlayerStats.Stand.Value] then
                                notify("Auto Prestige", "Obtaining valid stand...")
                                local success = CollectRokaArrow()
                                if not success then
                                    notify("Auto Prestige", "Failed to obtain stand! Retrying...")
                                    task.wait(2)
                                    return mainLoop()
                                end
                                notify("Auto Prestige", "Stand obtained! Resuming prestige...")
                            end
                        end
                        
                        vu136()
                        task.wait(1)
                        
                        if isStorylineCompleted() then
                            vampireFarmUntilMax()
                            
                            if doPrestige() then
                                task.wait(3)
                                
                                return doStorylineLoop()
                            else
                                if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
                                    sendStatusWebhook("completed")
                                    
                                    vu93("MAXED! P3 L50")
                                    notify("YBA Script", "MAX PRESTIGE 3 LEVEL 50!")
                                    autoPrestigeEnabled = false
                                    pcall(function()
                                        delfile("AutoPres3_" .. vu81.Name .. ".txt")
                                    end)
                                    return false
                                else
                                    return doStorylineLoop()
                                end
                            end
                        else
                            vu93("Storyline not complete. Starting storyline...")
                            notify("YBA Script", "Starting storyline...")
                            return doStorylineLoop()
                        end
                    end
                    
                    local characterConnection
                    characterConnection = game.Workspace.Living.ChildAdded:Connect(function(p194)
                        if p194.Name == vu81.Name then
                            if not autoPrestigeEnabled then
                                if characterConnection then characterConnection:Disconnect() end
                                return
                            end
                            if vu81.PlayerStats.Level.Value ~= 50 then
                                task.wait(2)
                                vu82 = vu81.Character
                                if vu82 then
                                    vu83 = vu82:FindFirstChild("RemoteFunction")
                                    vu84 = vu82:FindFirstChild("RemoteEvent")
                                    vu85 = vu82.PrimaryPart
                                end
                                
                                for _, v198 in pairs(vu82:GetDescendants()) do
                                    if v198:IsA("BasePart") and v198.CanCollide == true then
                                        v198.CanCollide = false
                                    end
                                end
                                
                                if vu86 then
                                    mainLoop()
                                else
                                    vu136()
                                end
                            end
                        end
                    end)
                    
                    local levelConnection
                    levelConnection = vu81.PlayerStats.Level:GetPropertyChangedSignal("Value"):Connect(function()
                        if not autoPrestigeEnabled then
                            if levelConnection then levelConnection:Disconnect() end
                            return
                        end
                        vu93("Level up! P" .. vu81.PlayerStats.Prestige.Value .. " L" .. vu81.PlayerStats.Level.Value)
                    end)
                    
                    local noClipConnection
                    noClipConnection = vu81.CharacterAdded:Connect(function(char)
                        if not autoPrestigeEnabled then
                            if noClipConnection then noClipConnection:Disconnect() end
                            return
                        end
                        task.wait(1)
                        for _, v198 in pairs(char:GetDescendants()) do
                            if v198:IsA("BasePart") and v198.CanCollide == true then
                                v198.CanCollide = false
                            end
                        end
                    end)
                    
                    for _, v198 in pairs(vu82:GetDescendants()) do
                        if v198:IsA("BasePart") and v198.CanCollide == true then
                            v198.CanCollide = false
                        end
                    end
                    
                    mainLoop()
                end)
                
                if not success then
                    notify("YBA Script", "Auto Prestige error: " .. tostring(err))
                    autoPrestigeEnabled = false
                end
            end)
            
        else
            autoPrestigeEnabled = false
            notify("YBA Script", "Auto Prestige 3 disabled.")
            
            if autoPrestigeStartData.enabled then
                sendStatusWebhook("stopped")
                autoPrestigeStartData.enabled = false
            end
        end
    end
})

local autoPresOnMax = false
QuestFarmSection:Toggle({
    Flag = "AutoPresOnMax",
    Title = "Auto Pres on Max (Legacy)",
    Default = false,
    Callback = function(value)
        autoPresOnMax = value
        if value then
            notify("YBA Script", "Auto Prestige (Legacy) enabled! Will prestige at max level (35/40/45)")
            spawn(function()
                while autoPresOnMax do
                    wait(2)
                    pcall(function()
                        local ps = player:FindFirstChild("PlayerStats")
                        if ps then
                            local level = ps:FindFirstChild("Level")
                            local prestige = ps:FindFirstChild("Prestige")
                            if level and prestige then
                                local canPres = false
                                if prestige.Value == 0 and level.Value >= 35 then canPres = true
                                elseif prestige.Value == 1 and level.Value >= 40 then canPres = true
                                elseif prestige.Value == 2 and level.Value >= 45 then canPres = true
                                end
                                
                                if canPres then
                                    local char = player.Character
                                    if char and char:FindFirstChild("RemoteEvent") then
                                        char.RemoteEvent:FireServer("EndDialogue", {
                                            NPC = "Prestige",
                                            Dialogue = "Dialogue2",
                                            Option = "Option1"
                                        })
                                        notify("YBA Script", "Auto Prestiged! Now Prestige " .. (prestige.Value + 1))
                                        wait(10)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            notify("YBA Script", "Auto Prestige (Legacy) disabled.")
        end
    end
})

QuestTab:Space()

    task.spawn(function()
        task.wait(0.5)
        UpdateNPCList(npcDropdown)
    end)

    getgenv().CompletedQuest = true
    getgenv().QuestFarmEnabled = false

    notify("YBA Script", "Quest & NPC Farm features loaded!")
end
do
    local GameSection = GameTab:Section({ Title = "World Settings" })
    
    local selectedWeather = nil
    local forceWeatherEnabled = false
    
    GameSection:Dropdown({
        Flag = "WeatherSelection",
        Title = "Select Weather",
        Values = {"Disable", "Foggy", "Rainy", "Snowy"},
        Value = "Disable",
        Callback = function(selected)
            selectedWeather = selected
            warn("Weather set to: " .. tostring(selected))
            if workspace:FindFirstChild("Weather") then
                workspace.Weather.Value = selected
            end
        end
    })
    
    spawn(function()
        while task.wait(0.1) do
            pcall(function()
                if forceWeatherEnabled and selectedWeather and workspace:FindFirstChild("Weather") then
                    if workspace.Weather.Value ~= selectedWeather then
                        workspace.Weather.Value = selectedWeather
                    end
                end
            end)
        end
    end)
    
    GameSection:Space()
    
    GameSection:Button({
        Title = "Rejoin Server",
        Callback = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
        end
    })
    
    GameSection:Button({
        Title = "Server Hop",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end
    })
    
    GameSection:Button({
        Title = "Join Small Server",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end
    })
    
    GameSection:Button({
        Title = "Join Mid Server",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end
    })
    
    GameSection:Button({
        Title = "Join Large Server",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end
    })
    
    GameSection:Dropdown({
        Flag = "RegionServers",
        Title = "Region Servers",
        SearchBarEnabled = true,
        Values = {"Auto", "US-East", "US-West", "EU-West", "Asia"},
        Value = "Auto",
        Callback = function(v) end
    })
    
    GameSection:Button({
        Title = "Join Region",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end
    })
end

LoadQuestFeatures()
local bypassSuccess, bypassError = pcall(function()
    local oldMagnitude = hookmetamethod(Vector3.new(), "__index", newcclosure(function(self, index)
        local CallingScript = tostring(getcallingscript())
        if not checkcaller() and index == "magnitude" and CallingScript == "ItemSpawn" then
            return 0
        end
        return oldMagnitude(self, index)
    end))
    
    local UzuKeeIsRetardedAndDoesntKnowHowToMakeAnAntiCheatOnTheServerSideAlsoVexStfuIKnowTheCodeIsBadYouDontNeedToTellMe = "  ___XP DE KEY"
    local oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local Method = getnamecallmethod()
        local Args = {...}
        if not checkcaller() and rawequal(self.Name, "Returner") and rawequal(Args[1], "idklolbrah2de") then
            return UzuKeeIsRetardedAndDoesntKnowHowToMakeAnAntiCheatOnTheServerSideAlsoVexStfuIKnowTheCodeIsBadYouDontNeedToTellMe
        end
        return oldNc(self, ...)
    end))
    
    getgenv().oldMagnitude = oldMagnitude
    getgenv().oldNc = oldNc
    
    wait(0.1)
end)

do
    Window:Tag({
        Title = bypassSuccess and "Supported" or "Unsupported",
        Icon = bypassSuccess and "check" or "x",
        Color = bypassSuccess and Color3.fromHex("#FFFFFF") or Color3.fromHex("#000000")
    })
end

if bypassSuccess then
    notify("YBA Script", "Bypasses loaded successfully.")
else
    notify("YBA Script", "Executor not supported - Some features disabled")
end

LoadStandFarmFeatures()