--cracked by piscar.
local _task = task

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LP = LocalPlayer
local player = LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

local MAX_WAIT_TIME = 600
local CHECK_INTERVAL = 0.1
local CLICK_INTERVAL = 2.5

-- Safe wrapper for deprecated firesignal/getconnections APIs
local function safeFireSignal(signal)
    if not signal then return false end
    pcall(function()
        if firesignal then
            firesignal(signal)
        elseif signal.Fire then
            signal:Fire()
        end
    end)
    return true
end

local function safeGetConnections(signal)
    if not signal then return {} end
    local connections = {}
    pcall(function()
        if getconnections then
            connections = getconnections(signal)
        elseif signal.GetConnections then
            connections = signal:GetConnections()
        end
    end)
    return connections or {}
end

local function clickButtonSafe(button)
    if button and button:IsA("GuiButton") then
        pcall(function()
            for _, connection in pairs(safeGetConnections(button.MouseButton1Click)) do
                pcall(function() connection:Fire() end)
            end
            for _, connection in pairs(safeGetConnections(button.Activated)) do
                pcall(function() connection:Fire() end)
            end
        end)
    end
end

local function checkButton(path)
    local success, result = pcall(function()
        local obj = PlayerGui
        for _, name in ipairs(path) do
            obj = obj:FindFirstChild(name)
            if not obj then
                return nil
            end
        end
        return obj
    end)
    return success and result or nil
end

local function isButtonActive(button)
    if not button then return false end
    local visible = button.Visible
    local enabled = true
    if button:IsA("GuiButton") then
        enabled = button.Active or not button:GetAttribute("Disabled")
    end
    local parent = button.Parent
    while parent and parent ~= PlayerGui do
        if parent:IsA("GuiObject") and not parent.Visible then
            return false
        end
        parent = parent.Parent
    end
    return visible and enabled
end
spawn(function()
    local startTime = tick()
    local buttonsFound = false

    while tick() - startTime < MAX_WAIT_TIME do
        wait(CHECK_INTERVAL)
        local button1 = checkButton({"LoadingScreen", "Frames", "Gamemodes", "MainGame", "Play"})
        local button2 = checkButton({"LoadingScreen", "Frames", "Main", "Play"})
        if button1 or button2 then
            buttonsFound = true
            break
        end
    end

    if not buttonsFound then
        return
    end

    local lastClickTime = 0
    while true do
        wait(CHECK_INTERVAL)
        local button1 = checkButton({"LoadingScreen", "Frames", "Gamemodes", "MainGame", "Play"})
        local button2 = checkButton({"LoadingScreen", "Frames", "Main", "Play"})
        if not button1 and not button2 then
            break
        end
        if tick() - lastClickTime >= CLICK_INTERVAL then
            local clicked = false
            if button1 and isButtonActive(button1) then
                clickButtonSafe(button1)
                clicked = true
            end
            if button2 and isButtonActive(button2) then
                clickButtonSafe(button2)
                clicked = true
            end
            if clicked then
                lastClickTime = tick()
            end
        end
    end
end)

if getgenv().RAILhub_YBA_Loaded then
    warn("[RAILhub] Script already running.")
    return
end
getgenv().RAILhub_YBA_Loaded = true
local MacLib
do
    local code = game:HttpGet("https://pastebin.com/raw/YQni2KG9")
    code = code:gsub('globe%s*=%s*"rbxassetid://%d+"', 'globe = "rbxassetid://4677859281"')
    code = code:gsub('globe%s*=%s*"%d+"', 'globe = "rbxassetid://4677859281"')
    MacLib = loadstring(code)()
end

local genv = (getgenv and getgenv()) or _G
getgenv().ItemStickConnections = getgenv().ItemStickConnections or {}
getgenv().InstantMethod = getgenv().InstantMethod or "Down"
getgenv().SafePlaceCollectionMode = getgenv().SafePlaceCollectionMode or "Batch Collect"

local runtimeEnv = (getgenv and getgenv()) or _G
local runtimeKey = "__YBA_RUNTIME"
local previousRuntime = runtimeEnv[runtimeKey]
if type(previousRuntime) == "table" and type(previousRuntime.Shutdown) == "function" then
    previousRuntime:Shutdown()
end
local runtime = { Stopped = false, Guis = {} }
runtimeEnv[runtimeKey] = runtime
function runtime:Shutdown()
    if self.Stopped then
        return
    end
    pcall(function()
        if type(runtime._itemFarmStop) == "function" then
            runtime._itemFarmStop()
        end
    end)
    self.Stopped = true
    for _, g in ipairs(self.Guis) do
        if g and g.Parent then
            g:Destroy()
        end
    end
end

do
    local roots = {}
    roots[#roots + 1] = (gethui and gethui()) or game:GetService("CoreGui")
    local pg = LP and LP:FindFirstChildOfClass("PlayerGui")
    if pg then
        roots[#roots + 1] = pg
    end
    for _, root in ipairs(roots) do
        for _, gui in ipairs(root:GetChildren()) do
            if gui:IsA("ScreenGui") then
                if gui.Name == "RAILhubToggle" or gui.Name == "RAILhubWatermark" then
                    gui:Destroy()
                end
            end
        end
    end
end

local function extractInviteCode(invite)
    if type(invite) ~= "string" then
        return nil
    end
    local code = invite:gsub("^%s+", ""):gsub("%s+$", "")
    code = code:gsub("^https?://", ""):gsub("^www%.", "")
    code = code:gsub("^discord%.gg/", ""):gsub("^discord%.com/invite/", "")
    code = code:gsub("^invite/", "")
    code = code:gsub("[/?#].*$", "")
    if code == "" then
        return nil
    end
    return code
end

local function openDiscordInvite(code)
    if type(code) ~= "string" or code == "" then
        return false
    end
    local req = (syn and syn.request) or http_request or request or (http and http.request)
    local openUrl = openbrowser or (syn and syn.open_url)
    if req then
        local body = HttpService:JSONEncode({
            cmd = "INVITE_BROWSER",
            nonce = HttpService:GenerateGUID(false),
            args = { code = code },
        })
        for port = 6463, 6472 do
            local ok, res = pcall(function()
                return req({
                    Url = ("http://127.0.0.1:%d/rpc?v=1"):format(port),
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["Origin"] = "https://discord.com",
                    },
                    Body = body,
                })
            end)
            if ok and res and (res.StatusCode == 200 or res.StatusCode == 204) then
                return true
            end
        end
    end
    if openUrl then
        openUrl("https://discord.gg/" .. code)
        return true
    end
    return false
end

local function openDiscordLink(invite)
    if invite and invite ~= "" then
        if setclipboard then
            setclipboard(invite)
        elseif toclipboard then
            toclipboard(invite)
        end
        local code = extractInviteCode(invite)
        if code then
            openDiscordInvite(code)
        end
    end
end
local Window
local function ybaNotify(title, msg)
    local notifyWindow = Window or getgenv().RAILhubWindow or _G.RAILhubWindow
    if notifyWindow and type(notifyWindow.Notify) == "function" then
        pcall(function()
            notifyWindow:Notify({
                Title = tostring(title or "RAIL Hub"),
                Description = tostring(msg or ""),
                Lifetime = 5
            })
        end)
    end
    warn(("[YBA] %s — %s"):format(tostring(title or "notify"), tostring(msg)))
end

local settingsFolderName = "RAILhubYBA"
local settingsFileName = settingsFolderName .. "/custom_flags.json"

local CFG = {
    AutoExecute = true,
    SaveSettings = true,
    AutoRetry = true,
    ItemFarmEnabled = false,
    StandFarmEnabled = false,
    PilotEnabled = false,
    AntiAfk = true,
}

local antiAfkConn = nil
local function enableAntiAfk()
    if antiAfkConn then antiAfkConn:Disconnect() end
    antiAfkConn = RunService.Heartbeat:Connect(function()
        pcall(function()
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.W, false, game); _task.wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.W, false, game)
            end
        end)
    end)
end

local function disableAntiAfk()
    if antiAfkConn then
        antiAfkConn:Disconnect()
        antiAfkConn = nil
    end
end; _task.spawn(function() _task.wait(1) 
    local ok, shouldEnable = pcall(function() return getSavedFlag("AA", true) end)
    if ok and shouldEnable and type(enableAntiAfk) == "function" then
        pcall(enableAntiAfk)
    end
end)

local function normalizeJsonValue(v, seen)
    local t = type(v)
    if t == "nil" or t == "boolean" or t == "number" or t == "string" then return v end
    if t == "userdata" then return tostring(v) end
    if t ~= "table" then return tostring(v) end
    seen = seen or {}
    if seen[v] then return nil end
    seen[v] = true
    local isArr = true
    local max = 0
    for k in pairs(v) do
        if type(k) ~= "number" or k < 1 or k % 1 ~= 0 then isArr = false; break end
        if k > max then max = k end
    end
    local out = {}
    if isArr then
        for i = 1, max do out[i] = normalizeJsonValue(v[i], seen) end
    else
        for k, e in pairs(v) do out[tostring(k)] = normalizeJsonValue(e, seen) end
    end
    seen[v] = nil
    return out
end

local function ensureSettingsFolder()
    if type(isfolder) == "function" and type(makefolder) == "function" then
        if not isfolder(settingsFolderName) then makefolder(settingsFolderName) end
    end
end

local function readSettingsFile()
    if type(readfile) ~= "function" or type(isfile) ~= "function" then 
        warn("[YBA] Settings: readfile/isfile not available")
        return nil 
    end
    if not isfile(settingsFileName) then 
        warn("[YBA] Settings: File not found: " .. settingsFileName)
        return nil 
    end
    local ok, raw = pcall(readfile, settingsFileName)
    if not ok or type(raw) ~= "string" or raw == "" then 
        warn("[YBA] Settings: Failed to read file")
        return nil 
    end
    local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then 
        warn("[YBA] Settings: Invalid JSON data")
        return nil 
    end
    warn("[YBA] Settings: Loaded successfully - " .. #HttpService:JSONEncode(data) .. " bytes")
    return data
end

local function writeSettingsFile(t)
    if type(writefile) ~= "function" then return false end
    ensureSettingsFolder()
    local ok, payload = pcall(function() return HttpService:JSONEncode(normalizeJsonValue(t or {})) end)
    if not ok or type(payload) ~= "string" then return false end
    return pcall(writefile, settingsFileName, payload)
end

local function loadCustomFlags()
    local data = readSettingsFile()
    return type(data) == "table" and data or {}
end

local SavedFlags = loadCustomFlags()

local function setSavedFlag(k, v)
    SavedFlags[k] = v
    if CFG.SaveSettings or k == "SS" or k == "AE" or k == "AR" then
        writeSettingsFile(SavedFlags)
        warn("[YBA] Saved flag: " .. k .. " = " .. tostring(v))
    end
end

local function getSavedFlag(k, def)
    if SavedFlags[k] == nil then return def end
    return SavedFlags[k]
end

local function setupAutoReload()
    local enabled = getSavedFlag("AE", true)
    CFG.AutoExecute = enabled
    warn("[YBA] AutoReload: enabled=" .. tostring(enabled))
    if not enabled then
        if getgenv then getgenv().RAILHUB_AUTOEXEC = nil end
        warn("[YBA] AutoReload: disabled")
        return
    end
    -- Re-execute this readable local copy after teleport.  The original used a
    -- mutable remote loader here, which could silently replace this source.
    local payload = [[
local ok, source = pcall(readfile, "RAILhub_YBA_NORMAL.lua")
if ok and type(source) == "string" and #source > 0 then
    local chunk = loadstring(source, "@RAILhub_YBA_NORMAL.lua")
    if chunk then chunk() end
end
]]
    if getgenv then getgenv().RAILHUB_AUTOEXEC = payload end
    warn("[YBA] AutoReload: payload set")
    if queue_on_teleport and payload then
        pcall(function()
            queue_on_teleport(payload)
        end)
        warn("[YBA] AutoReload: queued for teleport")
    else
        warn("[YBA] AutoReload: queue_on_teleport NOT AVAILABLE - executor doesn't support it")
    end
end

local function applySavedConfig()
    local f = SavedFlags
    -- ALWAYS apply these core settings
    if f.SS ~= nil then CFG.SaveSettings = f.SS end
    if f.AE ~= nil then CFG.AutoExecute = f.AE end
    if f.AR ~= nil then CFG.AutoRetry = f.AR end
    -- Only apply other settings if SaveSettings is enabled
    if not CFG.SaveSettings then return end
    if f.IF ~= nil then CFG.ItemFarmEnabled = f.IF end
    if f.SF ~= nil then CFG.StandFarmEnabled = f.SF end
    if f.PE ~= nil then CFG.PilotEnabled = f.PE end
    if f.AA ~= nil then CFG.AntiAfk = f.AA end
    if f.SHF ~= nil then serverHopFarmEnabled = f.SHF end
    -- Load Auto Prestige webhook if saved
    if f.APWH ~= nil and type(f.APWH) == "string" and f.APWH ~= "" then
        getgenv().webhook = f.APWH
    end
    warn("[YBA] All settings applied from file")
end

-- Apply saved config IMMEDIATELY on script load
applySavedConfig()

-- Setup auto reload immediately if enabled
setupAutoReload()

-- ============================================================
-- BLOCK 1: Item data, sell, ESP, noclip, teleport, item farm
-- do..end reduces local register count for old executors
-- ============================================================
do

local items = {}
local maxLimits = {
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
    ["Christmas Present"] = 999,
}
local nonSellable = { "Blue Candy", "Red Candy", "Green Candy", "Yellow Candy", "Lucky Arrow", "Lucky Stone Mask", "Christmas Present" }
local itemOptions = {}
local seen = {}
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

local function updateItems()
    items = {}
    for itemName in pairs(maxLimits) do
        items[itemName] = 0
    end
    local function countInContainer(container)
        if not container then
            return
        end
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

local function findSellRemote()
    local success, result = pcall(function()
        local plr = game.Players.LocalPlayer
        if plr and plr.Character then
            for _, obj in pairs(plr.Character:GetChildren()) do
                if obj:IsA("RemoteEvent") then
                    return obj
                end
            end
        end
    end)
    if success and result then return result end
    
    -- Fallback search in workspace and services
    local places = { game.Workspace, game:GetService("ReplicatedStorage"), game:GetService("Players") }
    for _, place in pairs(places) do
        if place then
            local ok, descendants = pcall(function() return place:GetDescendants() end)
            if ok and descendants then
                for _, obj in pairs(descendants) do
                    if obj:IsA("RemoteEvent") then
                        local nameLower = obj.Name:lower()
                        if nameLower:find("remote") or nameLower:find("remoteevent") or 
                           nameLower:find("sell") or nameLower:find("server") or nameLower:find("_ev") then
                            return obj
                        end
                    end
                end
            end
        end
    end
    
    -- Last resort: any RemoteEvent in workspace
    local ok, children = pcall(function() return game.Workspace:GetChildren() end)
    if ok then
        for _, obj in pairs(children) do
            if obj:IsA("RemoteEvent") then
                return obj
            end
        end
    end
    
    return nil
end

local function sellItem(item)
    if not item then
        return false, "No item provided"
    end
    
    local itemName = typeof(item) == "Instance" and item.Name or item
    if table.find(nonSellable, itemName) then
        ybaNotify("YBA Script", "Cannot sell " .. itemName .. " as it is not sellable.")
        return false, "Item is not sellable"
    end
    
    local plr = game.Players.LocalPlayer
    if not plr then
        return false, "Local player not found"
    end
    
    local instanceToSell
    if typeof(item) == "Instance" then
        instanceToSell = item
    elseif typeof(item) == "string" then
        instanceToSell = plr.Backpack:FindFirstChild(item) or (plr.Character and plr.Character:FindFirstChild(item))
    else
        return false, "Invalid item type"
    end
    
    if not instanceToSell or not instanceToSell.Parent then
        return false, "Item not found or has no parent"
    end
    
    local plrName = plr.Name
    local living = game.Workspace:FindFirstChild("Living") or game.Workspace
    local target = nil
    if living then
        target = living:FindFirstChild(plrName) or living
    else
        target = game.Workspace
    end
    
    local ok, err = pcall(function()
        instanceToSell.Parent = target
    end)
    if not ok then
        warn("[Sell] Failed to move item to target: " .. tostring(err))
        return false, err
    end
    
    local args = {
        [1] = "EndDialogue",
        [2] = {
            ["NPC"] = "Merchant",
            ["Option"] = "Option2",
            ["Dialogue"] = "Dialogue5",
        },
    }
    
    local fired = false
    local remote = findSellRemote()
    if remote then
        local ok2, err2 = pcall(function()
            remote:FireServer(unpack(args))
        end)
        if ok2 then
            fired = true
        else
            warn("[Sell] Failed to fire remote: " .. tostring(err2))
        end
    end
    
    if not fired and plr.Character then
        local r = plr.Character:FindFirstChildWhichIsA("RemoteEvent")
        if r then
            local ok3, err3 = pcall(function()
                r:FireServer(unpack(args))
            end)
            if ok3 then
                fired = true
            else
                warn("[Sell] Failed to fire character remote: " .. tostring(err3))
            end
        end
    end
    
    if not fired and plr.Character and plr.Character:FindFirstChild("RemoteEvent") then
        local ok4, err4 = pcall(function()
            plr.Character.RemoteEvent:FireServer(unpack(args))
        end)
        if ok4 then
            fired = true
        else
            warn("[Sell] Failed to fire RemoteEvent: " .. tostring(err4))
        end
    end; _task.wait(0.12)
    return fired, fired and nil or "Failed to fire any remote event"
end

local autoSellMax = false
local function checkAndSellMax()
    local soldSummary = {}
    local tempCounts = {}
    for name in pairs(maxLimits) do
        tempCounts[name] = 0
    end
    local containers = { player.Backpack }
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
        ybaNotify("YBA Script", "Auto sold: " .. table.concat(parts, ", "))
    end
end

local worthlessItems = {"Gold Coin", "Diamond", "Quinton's Glove", "Zeppeli's Hat", "Caesar's Headband", "Ancient Scroll"}

local function sellAll(itemName)
    updateItems()
    local count = items[itemName] or 0
    if count == 0 then
        ybaNotify("YBA Script", "No " .. itemName .. " found.")
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
    ybaNotify("YBA Script", "Sold " .. sold .. " " .. itemName .. (sold > 1 and "s" or "") .. ".")
end

local function sellAllSelected(selectedItems)
    updateItems()
    local total = 0
    for _, itemName in ipairs(selectedItems) do
        total = total + (items[itemName] or 0)
    end
    if total == 0 then
        ybaNotify("YBA Script", "No selected items found.")
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
    ybaNotify("YBA Script", "Sold " .. sold .. " selected item" .. (sold > 1 and "s" or "") .. ".")
end

local function sellAllWorthless()
    updateItems()
    local total = 0
    for _, itemName in ipairs(worthlessItems) do
        total = total + (items[itemName] or 0)
    end
    if total == 0 then
        ybaNotify("YBA Script", "No worthless items found.")
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
    ybaNotify("YBA Script", "Sold " .. sold .. " worthless item" .. (sold > 1 and "s" or "") .. ".")
end

local function sellInventory()
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
    ybaNotify("YBA Script", "Sold " .. sold .. " item" .. (sold > 1 and "s" or "") .. " from inventory.")
end

local instantPickup = false
local instantPickupConnection = nil
local defaultHoldDuration = 0.5
local instantPickupBusy = false
local instantPickupLast = 0
local instantPickupCooldown = 0.35
local instantPickupRange = 12
local function getItemContainer()
    local spawns = game.Workspace:FindFirstChild("Item_Spawns")
    if not spawns then
        return nil
    end
    return spawns:FindFirstChild("Items")
end
local function setPromptsInstant(instant)
    local container = getItemContainer()
    if not container then
        return
    end
    for _, v in pairs(container:GetChildren()) do
        local prox = v:FindFirstChild("ProximityPrompt")
        if prox then
            pcall(function()
                prox.HoldDuration = defaultHoldDuration
            end)
        end
    end
end
local function enableInstantPickup()
    instantPickup = true
    setPromptsInstant(true)
    local container = getItemContainer()
    if container then
        instantPickupConnection = container.ChildAdded:Connect(function(v) _task.wait(0.05)
            if not instantPickup or instantPickupBusy or tick() - instantPickupLast < instantPickupCooldown then
                return
            end
            local prox = v:FindFirstChild("ProximityPrompt")
            local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
            if prox and part and part.Transparency < 1 then
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if not hrp or (part.Position - hrp.Position).Magnitude > instantPickupRange then
                    return
                end
                instantPickupBusy = true
                instantPickupLast = tick()
                pcall(function()
                    activatePrompt(prox, defaultHoldDuration, true)
                end)
                instantPickupBusy = false
            end
        end)
    end
end
local function disableInstantPickup()
    instantPickup = false
    instantPickupBusy = false
    setPromptsInstant(false)
    if instantPickupConnection then
        instantPickupConnection:Disconnect()
        instantPickupConnection = nil
    end
end

getgenv().ItemESPData = getgenv().ItemESPData or {enabled = false, guis = {}, conns = {}, selected = {}}
local function itemESPAllows(itemName)
    local selected = getgenv().ItemESPData.selected or {}
    return #selected == 0 or table.find(selected, itemName)
end
clearItemESP = function()
    for item, gui in pairs(getgenv().ItemESPData.guis) do
        if gui then pcall(function() gui:Destroy() end) end
        getgenv().ItemESPData.guis[item] = nil
    end
    for i, conn in pairs(getgenv().ItemESPData.conns) do
        if conn then pcall(function() conn:Disconnect() end) end
        getgenv().ItemESPData.conns[i] = nil
    end
end
refreshItemESP = function()
    local data = getgenv().ItemESPData
    local container = getItemContainer()
    if not data.enabled or not container then
        clearItemESP()
        return
    end
    for _, v in pairs(container:GetChildren()) do
        local prox = v:FindFirstChild("ProximityPrompt")
        local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
        local gui = data.guis[v]
        local itemName = tostring(prox and (prox.ObjectText or v.Name) or v.Name)
        if prox and part and part.Transparency < 1 and itemESPAllows(itemName) then
            if not gui or not gui.Parent then
                gui = Instance.new("BillboardGui")
                gui.Name = "RailHubItemESP"
                gui.Size = UDim2.fromOffset(180, 24)
                gui.StudsOffset = Vector3.new(0, 2.5, 0)
                gui.AlwaysOnTop = true
                local txt = Instance.new("TextLabel")
                txt.Name = "Label"
                txt.BackgroundTransparency = 1
                txt.Size = UDim2.fromScale(1, 1)
                txt.Font = Enum.Font.GothamBold
                txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                txt.TextStrokeTransparency = 0
                txt.TextScaled = true
                txt.Parent = gui
                gui.Parent = part
                data.guis[v] = gui
            end
            gui.Label.Text = itemName
        elseif gui then
            pcall(function() gui:Destroy() end)
            data.guis[v] = nil
        end
    end
    for item, gui in pairs(data.guis) do
        if not item or not item.Parent or not item:IsDescendantOf(container) then
            if gui then pcall(function() gui:Destroy() end) end
            data.guis[item] = nil
        end
    end
end
setItemESPFilter = function(selectedItems)
    getgenv().ItemESPData.selected = selectedItems or {}; _task.defer(refreshItemESP)
end
setItemESP = function(on)
    getgenv().ItemESPData.enabled = on
    clearItemESP()
    if not on then
        return
    end
    refreshItemESP()
    local container = getItemContainer()
    if container then
        table.insert(getgenv().ItemESPData.conns, container.ChildAdded:Connect(function() _task.defer(refreshItemESP) end))
        table.insert(getgenv().ItemESPData.conns, container.ChildRemoved:Connect(function() _task.defer(refreshItemESP) end))
    end
end

getgenv().PlayerESPData = getgenv().PlayerESPData or {
    enabled = false,
    showChams = getSavedFlag("PESP_CH", true),
    showNames = getSavedFlag("PESP_NM", true),
    showDistance = getSavedFlag("PESP_DS", true),
    highlights = {},
    labels = {},
    conns = {}
}
local function clearPlayerESP()
    local data = getgenv().PlayerESPData
    for _, obj in pairs(data.highlights) do
        if obj then pcall(function() obj:Destroy() end) end
    end
    for _, obj in pairs(data.labels) do
        if obj then pcall(function() obj:Destroy() end) end
    end
    for _, conn in pairs(data.conns) do
        if conn then pcall(function() conn:Disconnect() end) end
    end
    data.highlights = {}
    data.labels = {}
    data.conns = {}
end

local function refreshPlayerESP()
    local data = getgenv().PlayerESPData
    if not data.enabled then
        clearPlayerESP()
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local head = char and char:FindFirstChild("Head")
            local alive = hrp and hum and hum.Health > 0
            if alive then
                local hl = data.highlights[plr]
                if not hl or not hl.Parent then
                    hl = Instance.new("Highlight")
                    hl.Name = "RAILhubPlayerESP"
                    hl.FillColor = Color3.fromRGB(255, 90, 90)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.65
                    hl.OutlineTransparency = 0.1
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    data.highlights[plr] = hl
                end
                hl.Parent = char
                hl.Adornee = char

                local gui = data.labels[plr]
                if not gui or not gui.Parent then
                    gui = Instance.new("BillboardGui")
                    gui.Name = "RAILhubPlayerLabel"
                    gui.Size = UDim2.fromOffset(200, 36)
                    gui.StudsOffset = Vector3.new(0, 3, 0)
                    gui.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel")
                    txt.Name = "Label"
                    txt.BackgroundTransparency = 1
                    txt.Size = UDim2.fromScale(1, 1)
                    txt.Font = Enum.Font.GothamBold
                    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                    txt.TextStrokeTransparency = 0
                    txt.TextScaled = true
                    txt.Parent = gui
                    data.labels[plr] = gui
                end
                gui.Parent = head or hrp
                local localHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                local dist = localHrp and math.floor((hrp.Position - localHrp.Position).Magnitude) or 0
                gui.Label.Text = string.format("%s\n[%dm]", plr.Name, dist)
            else
                if data.highlights[plr] then pcall(function() data.highlights[plr]:Destroy() end) end
                if data.labels[plr] then pcall(function() data.labels[plr]:Destroy() end) end
                data.highlights[plr] = nil
                data.labels[plr] = nil
            end
        end
    end
end

local function setPlayerESP(on)
    local data = getgenv().PlayerESPData
    data.enabled = on
    clearPlayerESP()
    if not on then
        return
    end
    refreshPlayerESP()
    table.insert(data.conns, Players.PlayerAdded:Connect(function() _task.defer(refreshPlayerESP) end))
    table.insert(data.conns, Players.PlayerRemoving:Connect(function(plr)
        if data.highlights[plr] then pcall(function() data.highlights[plr]:Destroy() end) end
        if data.labels[plr] then pcall(function() data.labels[plr]:Destroy() end) end
        data.highlights[plr] = nil
        data.labels[plr] = nil
    end))
    table.insert(data.conns, RunService.RenderStepped:Connect(function()
        refreshPlayerESP()
    end))
end
-- Export so block 2 can access these local functions
getgenv()._YBA_setPlayerESP = setPlayerESP
getgenv()._YBA_refreshPlayerESP = refreshPlayerESP

local function getSkinChancesLabel()
    local hud = PlayerGui:FindFirstChild("HUD")
    local main = hud and hud:FindFirstChild("Main")
    local frames = main and main:FindFirstChild("Frames")
    local store = frames and frames:FindFirstChild("Store")
    local list = store and store:FindFirstChild("List")
    local standShop = list and list:FindFirstChild("StandShop")
    return standShop and standShop:FindFirstChild("SkinChances1")
end

local noclipEnabled = false
local originalCollides = {}
local noclipConn = nil
local currentNoclipChar = nil 

local function enforceNoclipForCharacter(char)
    if not char then
        return
    end
    originalCollides = {}
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            originalCollides[part] = part.CanCollide
            part.CanCollide = false
        end
    end
    currentNoclipChar = char
end

local function enableNoclip()
    if noclipEnabled then
        return
    end
    local char = player.Character
    if not char or not char.Parent then
        noclipEnabled = true
        return
    end
    originalCollides = {}
    enforceNoclipForCharacter(char)
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    noclipConn = RunService.Stepped:Connect(function()
        local c = player.Character
        if not c then
            return
        end
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then
                if p.CanCollide then
                    p.CanCollide = false
                end
            end
        end
    end)
    noclipEnabled = true
end

local function disableNoclip()
    if not noclipEnabled and not noclipConn then
        return
    end
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end

    for part, originalValue in pairs(originalCollides) do
        if part and part.Parent and part:IsA("BasePart") then
            pcall(function()
                part.CanCollide = originalValue
            end)
        end
    end
    local char = player.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and (p.Name == "UpperTorso" or p.Name == "HumanoidRootPart") then
                pcall(function()
                    p.CanCollide = true
                end)
            end
        end
    end

    originalCollides = {}
    currentNoclipChar = nil
    noclipEnabled = false
end

local virtualAnchor = Instance.new("Part")
virtualAnchor.Anchored = true
virtualAnchor.CanCollide = false
virtualAnchor.Transparency = 1
virtualAnchor.Size = Vector3.new(1, 1, 1)
virtualAnchor.Parent = game.Workspace.Terrain

local function cleanupItemStick(onlyInactive)
    if onlyInactive then
        -- Clean only inactive/orphaned connections
        local activeConnections = {}
        for i, data in ipairs(getgenv().ItemStickConnections) do
            local isAlive = true
            if data.conn and not data.conn.Connected then
                isAlive = false
            end
            if data.targetPart and not data.targetPart.Parent then
                isAlive = false
            end
            if isAlive then
                table.insert(activeConnections, data)
            else
                -- Cleanup orphaned
                pcall(function() if data.conn then data.conn:Disconnect() end end)
                pcall(function() if data.alignPos then data.alignPos:Destroy() end end)
                pcall(function() if data.alignOri then data.alignOri:Destroy() end end)
                pcall(function() if data.attA then data.attA:Destroy() end end)
                pcall(function() if data.attB then data.attB:Destroy() end end)
            end
        end
        getgenv().ItemStickConnections = activeConnections
    else
        -- Full cleanup
        for _, data in pairs(getgenv().ItemStickConnections) do
            if data.alignPos then
                pcall(function()
                    data.alignPos:Destroy()
                end)
            end
            if data.alignOri then
                pcall(function()
                    data.alignOri:Destroy()
                end)
            end
            if data.attA then
                pcall(function()
                    data.attA:Destroy()
                end)
            end
            if data.attB then
                pcall(function()
                    data.attB:Destroy()
                end)
            end
            if data.conn then
                pcall(function()
                    data.conn:Disconnect()
                end)
            end
        end
        getgenv().ItemStickConnections = {}
    end
end

local directTeleportAllowed = true -- set to false in block 2 if bypass failed
getgenv()._YBA_directTP = true -- shared flag, updated after bypass attempt
local moveTween = nil
local moveTweenSpeed = 500

local function getTargetPart(target)
    if typeof(target) ~= "Instance" then
        return nil
    end
    if target:IsA("ProximityPrompt") then
        target = target.Parent
    end
    if target and target:IsA("Attachment") then
        target = target.Parent
    end
    if not target then
        return nil
    end
    if target:IsA("BasePart") then
        return target
    end
    return target:FindFirstChildOfClass("MeshPart") or target:FindFirstChildOfClass("Part") or target.PrimaryPart
end

local function getTargetCFrame(target, offset)
    offset = offset or Vector3.zero
    if typeof(target) == "Vector3" then
        return CFrame.new(target + offset)
    end
    if typeof(target) == "CFrame" then
        return target + offset
    end
    local part = getTargetPart(target)
    return part and (part.CFrame + offset) or nil
end

local function getSafeItemOffset(targetPart)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local fromPos = hrp and hrp.Position or (targetPart.Position + Vector3.new(0, 0, -1))
    local flat = Vector3.new(targetPart.Position.X - fromPos.X, 0, targetPart.Position.Z - fromPos.Z)
    local dir = flat.Magnitude > 0.01 and flat.Unit or Vector3.new(0, 0, -1)
    return (-dir * 2.75) + Vector3.new(0, 2.5, 0)
end

local function stopMoveTween()
    if moveTween then
        pcall(function()
            moveTween:Cancel()
        end)
        moveTween = nil
    end
end

local function zeroRootVelocity(hrp)
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

local function waitForPlayerTeleportCooldown()
    local tpReadyAt = getgenv()._tpCooldownUntil
    if tpReadyAt and tick() < tpReadyAt then
        _task.wait(tpReadyAt - tick())
    end
end

local function markPlayerTeleported()
    getgenv()._tpCooldownUntil = tick() + 0.45
end

-- Cancellable tween move — stops immediately if predicate returns true.
-- Only one tween runs at a time — calling this cancels any previous tween.
local _tweenBusy = false
local function tweenMoveTo(hrp, goal, speed, cancelPredicate)
    -- Cancel any existing tween first — prevents parallel tweens causing spin/jitter
    stopMoveTween()
    _tweenBusy = false -- reset in case previous was interrupted
    local dist = (hrp.Position - goal.Position).Magnitude
    if dist < 1 then return true end
    local time = math.clamp(dist / speed, 0.05, 3)
    local currentTween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = goal})
    moveTween = currentTween
    _tweenBusy = true
    currentTween:Play()
    -- Poll every frame so we can cancel immediately when predicate fires
    while currentTween.PlaybackState == Enum.PlaybackState.Playing do
        _task.wait()
        if cancelPredicate and cancelPredicate() then
            currentTween:Cancel()
            if moveTween == currentTween then moveTween = nil end
            currentTween:Destroy()
            _tweenBusy = false
            return false -- cancelled
        end
    end
    if moveTween == currentTween then moveTween = nil end
    currentTween:Destroy()
    _tweenBusy = false
    return true -- completed
end

-- Short-range threshold for instant CFrame when no bypass
local INSTANT_TP_THRESHOLD = 12
getgenv()._YBA_maxTPDist = INSTANT_TP_THRESHOLD

local function moveCharacterTo(target, offset)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local goal = getTargetCFrame(target, offset)
    if not hrp or not goal then
        return false
    end
    local dist = (hrp.Position - goal.Position).Magnitude
    if dist < 1 then
        stopMoveTween()
        zeroRootVelocity(hrp)
        return true
    end
    if getgenv()._YBA_directTP then
        -- Bypass active: direct CFrame with cooldown (original behaviour)
        waitForPlayerTeleportCooldown()
        hrp.CFrame = goal
        zeroRootVelocity(hrp)
        markPlayerTeleported()
        return true
    end
    -- No bypass: Tween at 500 studs/sec, no cooldown
    local ok = tweenMoveTo(hrp, goal, moveTweenSpeed, nil)
    zeroRootVelocity(hrp)
    return ok
end

local function activatePrompt(prompt, holdTime, noMove)
    if typeof(prompt) ~= "Instance" or not prompt:IsA("ProximityPrompt") then
        return false
    end
    local promptPart = getTargetPart(prompt)
    if promptPart and not noMove then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local maxDist = (prompt.MaxActivationDistance > 0 and prompt.MaxActivationDistance or 10) - 0.5
        if not hrp or (promptPart.Position - hrp.Position).Magnitude > maxDist then
            moveCharacterTo(promptPart, Vector3.new(0, 0.1, 0))
        end
    end

    -- Method 1: fireproximityprompt (works on most executors including low-UNC)
    local firedViaFPP = false
    if type(fireproximityprompt) == "function" then
        pcall(function()
            fireproximityprompt(prompt)
            firedViaFPP = true
        end)
    end

    -- Method 2: firesignal (high-UNC executors)
    if not firedViaFPP then
        pcall(function()
            if type(firesignal) == "function" then
                firesignal(prompt.Triggered, player)
            end
        end)
        pcall(function()
            if type(firesignal) == "function" then
                firesignal(prompt.PromptTriggered, player)
            end
        end)
    end

    -- Method 3: InputHoldBegin/End + VIM key simulation (fallback)
    pcall(function() prompt:InputHoldBegin() end)

    local duration = holdTime
    if duration == nil or duration <= 0 or duration > 1 then
        duration = prompt.HoldDuration
    end
    if duration <= 0 then duration = 0.5 end

    local key = UIS.KeyboardEnabled and prompt.KeyboardKeyCode or prompt.GamepadKeyCode
    if key == Enum.KeyCode.Unknown then key = Enum.KeyCode.E end

    pcall(function()
        if VIM and VIM.SendKeyEvent then
            VIM:SendKeyEvent(true, key, false, game)
        end
    end); _task.wait(duration > 0 and duration or 0.05)
    pcall(function()
        if VIM and VIM.SendKeyEvent then
            VIM:SendKeyEvent(false, key, false, game)
        end
    end)

    pcall(function() prompt:InputHoldEnd() end)
    pcall(function()
        if type(firesignal) == "function" then
            firesignal(prompt.TriggerEnded, player)
        end
    end)
    return true
end

local function isItemTarget(target)
    if typeof(target) ~= "Instance" then
        return false
    end
    local itemsFolder = game.Workspace:FindFirstChild("Item_Spawns") and game.Workspace.Item_Spawns:FindFirstChild("Items")
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

local farmRoamMinX, farmRoamMaxX = -702.137085, 975.83844
local farmRoamMinZ, farmRoamMaxZ = -805.215942, 468.16217
local farmRoamY = 46
local function getRandomFarmRoamCFrame()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    local look = hrp and hrp.CFrame.LookVector or Vector3.new(0, 0, -1)
    look = Vector3.new(look.X, 0, look.Z)
    if look.Magnitude < 0.01 then
        look = Vector3.new(0, 0, -1)
    else
        look = look.Unit
    end
    local x = farmRoamMinX + math.random() * (farmRoamMaxX - farmRoamMinX)
    local z = farmRoamMinZ + math.random() * (farmRoamMaxZ - farmRoamMinZ)
    local pos = Vector3.new(x, farmRoamY, z)
    return CFrame.lookAt(pos, pos + look)
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
        moveCharacterTo(target)
        return
    elseif typeof(target) == "CFrame" then
        moveCharacterTo(target)
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
        moveCharacterTo(targetPart.Position)
        return
    end
    local method = getgenv().InstantMethod or "Up"
    if method == "Up" then
        moveCharacterTo(targetPart.Position)
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
            isTempPart = false,
        }
        if #getgenv().ItemStickConnections > 10 then
            cleanupItemStick(true)
        end
        table.insert(getgenv().ItemStickConnections, stickData)
        local worldPos = targetPart.Position - Vector3.new(0, STICK_DISTANCE, 0)
        moveCharacterTo(CFrame.new(worldPos) * CFrame.Angles(0, hrp.CFrame.Y, 0))
        local stickConn = RunService.Heartbeat:Connect(function()
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

local waitingPosition = getRandomFarmRoamCFrame()

local function teleportToWaiting()
    if not player.Character or not player.Character.HumanoidRootPart then
        return
    end
    waitingPosition = getRandomFarmRoamCFrame()
    moveCharacterTo(waitingPosition)
end

local function instantTravelTo(target, waitTime)
    if not player.Character or not player.Character.HumanoidRootPart then
        return
    end
    local targetPos = typeof(target) == "Vector3" and target or target.Position
    moveCharacterTo(targetPos)
    if waitTime then
        _task.wait(waitTime)
    end
end

local function collectItemLikeNormalFarm(itemModel)
    if typeof(itemModel) ~= "Instance" or not itemModel.Parent then
        return false
    end

    local itemPart = itemModel:FindFirstChildOfClass("MeshPart") or itemModel:FindFirstChildOfClass("Part")
    local proxPrompt = itemModel:FindFirstChild("ProximityPrompt")
    if not itemPart or not proxPrompt then
        return false
    end

    local originalMethod = getgenv().InstantMethod
    if getgenv().InstantMethod == "Down" then
        getgenv().InstantMethod = "Up"
        cleanupItemStick()
    end

    if instantPickup then
        instantTravelTo(itemPart); _task.wait(0.3)
        checkAndSellMax()
        activatePrompt(proxPrompt, 0)
    else
        travelToInstant(itemPart); _task.wait(0.2)
        checkAndSellMax()
        activatePrompt(proxPrompt, 4); _task.wait(0.1)
        if itemModel:IsDescendantOf(game.Workspace) then
            activatePrompt(proxPrompt, 4)
        end
    end

    if originalMethod == "Down" then
        getgenv().InstantMethod = "Down"
    end

    checkAndSellMax(); _task.wait(0.2)
    return true
end

local normalFarmOn = false
local selectedFarmItems = {}

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

-- Server Hop Farm variables
local serverHopFarmEnabled = false
local serverHopMaxRetries = 10
local serverHopWaitTime = 3
local serverHopRetryAttempts = 3

-- Server Hop Farm functions
local function getRandomServers(count)
    local req = (syn and syn.request) or http_request or request or (http and http.request)
    if not req then
        warn("[ServerHop] HTTP request function not available")
        return {}
    end
    
    local servers = {}
    local pages = math.ceil(count / 100)
    
    local cursor = ""
    for page = 1, pages do
        local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100"):format(game.PlaceId)
        if cursor ~= "" then
            url = url .. "&cursor=" .. cursor
        end
        local ok, res = pcall(req, {
            Url = url,
            Method = "GET",
        })
        
        if ok and res and res.StatusCode == 200 then
            local data = HttpService:JSONDecode(res.Body)
            if data.data then
                for _, server in ipairs(data.data) do
                    if server.id ~= game.JobId and server.playing and server.maxPlayers and server.playing < server.maxPlayers then
                        table.insert(servers, server)
                    end
                end
            end
            if data.nextPageCursor then
                cursor = data.nextPageCursor
            else
                break
            end
        else
            break
        end
    end
    
    -- Shuffle and return random servers
    local shuffled = {}
    local indices = {}
    for i = 1, #servers do
        table.insert(indices, i)
    end
    
    -- Fisher-Yates shuffle
    for i = #indices, 2, -1 do
        local j = math.random(1, i)
        indices[i], indices[j] = indices[j], indices[i]
    end
    
    for i = 1, math.min(count, #indices) do
        table.insert(shuffled, servers[indices[i]])
    end
    
    return shuffled
end

local function serverHopToRandom()
    local servers = getRandomServers(300)
    
    if #servers == 0 then
        warn("[ServerHop] No servers found, using fallback teleport")
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
        return true
    end
    
    for attempt = 1, math.min(serverHopMaxRetries, #servers) do
        local server = servers[attempt]
        warn("[ServerHop] Attempting to join server: " .. server.id .. " (Attempt " .. attempt .. "/" .. serverHopMaxRetries .. ")")
        
        local success = pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, LP)
        end)
        
        if success then
            warn("[ServerHop] Teleport initiated to server: " .. server.id)
            return true
        end
        
        warn("[ServerHop] Attempt " .. attempt .. " failed, trying next server..."); _task.wait(0.5)
    end
    
    -- If all attempts failed, try random teleport
    warn("[ServerHop] All server attempts failed, using random teleport")
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    return false
end

local teleportConnection
teleportConnection = game:GetService("TeleportService").TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
    if player == LP then
        warn("[ServerHop] Teleport failed (" .. tostring(teleportResult) .. "): " .. tostring(errorMessage))
        pcall(function() game:GetService("GuiService"):ClearError() end)
        warn("[ServerHop] Retrying immediately..."); _task.wait(0.5)
        serverHopToRandom()
    end
end)

local function checkItemOnMap(itemName)
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local itemsFolder = game.Workspace:FindFirstChild("Item_Spawns") and game.Workspace.Item_Spawns:FindFirstChild("Items")
    if not itemsFolder then return false end
    
    for _, v in pairs(itemsFolder:GetChildren()) do
        local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
        local prox = v:FindFirstChild("ProximityPrompt")
        if itemPart and prox and itemPart.Transparency < 1 then
            local itemObjName = prox.ObjectText
            if itemObjName == itemName then
                return true
            end
        end
    end
    
    return false
end

local function waitForItemAndServerHop(itemName)
    if not serverHopFarmEnabled then return false end
    
    warn("[ServerHop] Waiting " .. serverHopWaitTime .. " seconds for item: " .. itemName)
    
    -- Wait for specified time
    for i = 1, serverHopWaitTime do
        if not serverHopFarmEnabled or not normalFarmOn then
            return false
        end
        
        if checkItemOnMap(itemName) then
            warn("[ServerHop] Item found: " .. itemName)
            return true
        end; _task.wait(1)
    end
    
    -- Item not found, server hop
    warn("[ServerHop] Item not found after " .. serverHopWaitTime .. " seconds, initiating server hop")
    
    for retry = 1, serverHopRetryAttempts do
        warn("[ServerHop] Retry attempt " .. retry .. "/" .. serverHopRetryAttempts)
        
        local success = serverHopToRandom()
        if success then
            -- Wait for character to load after teleport
            _task.wait(2)
            
            -- Check if we're at safe position
            local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - waitingPosition.Position).Magnitude
                if dist > 50 then
                    teleportToWaiting(); _task.wait(0.5)
                end
            end
            
            -- Check again for item
            _task.wait(1)
            if checkItemOnMap(itemName) then
                warn("[ServerHop] Item found after server hop: " .. itemName)
                return true
            end
        end
        
        if retry < serverHopRetryAttempts then
            _task.wait(1)
        end
    end
    
    warn("[ServerHop] All retry attempts exhausted for item: " .. itemName)
    return false
end

local function normalFarm()
    local loopStartTime = tick()
    local maxLoopTime = 3600 -- 1 hour max
    local iterationCount = 0
    local maxIterations = 50000 -- Safety limit

    while normalFarmOn do
        iterationCount = iterationCount + 1
        if iterationCount > maxIterations then
            warn("[Farm] normalFarm: Max iterations reached, stopping to prevent freeze")
            normalFarmOn = false
            break
        end
        if tick() - loopStartTime > maxLoopTime then
            warn("[Farm] normalFarm: Max loop time reached, restarting")
            loopStartTime = tick()
            iterationCount = 0
        end

        if not player.Character or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0 then
            wait(0.5)
            continue
        end
        local foundItem = false
        while normalFarmOn do
            iterationCount = iterationCount + 1
            if iterationCount > maxIterations then
                warn("[Farm] normalFarm inner: Max iterations reached, stopping")
                normalFarmOn = false
                break
            end

            local v = findLuckyArrow() or findNearestItem(selectedFarmItems)
            if not v then
                break
            end
            foundItem = true
            local itemPart = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part")
            local proxPrompt = v:FindFirstChild("ProximityPrompt")
            local originalMethod = getgenv().InstantMethod
            if getgenv().InstantMethod == "Down" then
                getgenv().InstantMethod = "Up"
                cleanupItemStick()
            end
            if instantPickup then
                instantTravelTo(itemPart)
                wait(0.5)
                checkAndSellMax()
                activatePrompt(proxPrompt, 0)
            else
                travelToInstant(itemPart)
                wait(0.2)
                local hrp = player.Character.HumanoidRootPart
                if (itemPart.Position - hrp.Position).Magnitude < 5 then
                    checkAndSellMax()
                    activatePrompt(proxPrompt, 4)
                    wait(0.1)
                    if v:IsDescendantOf(game.Workspace) then
                        activatePrompt(proxPrompt, 4)
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
            teleportToWaiting()

            -- Roam map waiting for items.
            -- In Tween mode: fly between waypoints, cancel instantly when item appears.
            -- In direct TP mode: just wait in place.
            -- If serverHopFarmEnabled and no item found after 10s — hop to another server.
            local roamStart = tick()
            local SERVER_HOP_TIMEOUT = 10

            local function itemFoundOnMap()
                return (findLuckyArrow() or findNearestItem(selectedFarmItems)) ~= nil
            end

            if not getgenv()._YBA_directTP then
                -- Tween mode: roam with cancel predicate
                while normalFarmOn do
                    if itemFoundOnMap() then break end
                    if serverHopFarmEnabled and tick() - roamStart >= SERVER_HOP_TIMEOUT then
                        break
                    end
                    local hrp2 = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp2 then _task.wait(0.1) continue end
                    tweenMoveTo(hrp2, getRandomFarmRoamCFrame(), moveTweenSpeed, function()
                        return itemFoundOnMap()
                            or not normalFarmOn
                            or (serverHopFarmEnabled and tick() - roamStart >= SERVER_HOP_TIMEOUT)
                    end)
                end
            else
                -- Direct TP mode: keep teleporting to random spots while scanning
                while normalFarmOn and not itemFoundOnMap() do
                    if serverHopFarmEnabled and tick() - roamStart >= SERVER_HOP_TIMEOUT then
                        break
                    end
                    -- Teleport to a new random spot and wait a bit before checking again
                    teleportToWaiting()
                    local scanStart = tick()
                    while normalFarmOn and tick() - scanStart < 0.5 do
                        if itemFoundOnMap() then break end
                        if serverHopFarmEnabled and tick() - roamStart >= SERVER_HOP_TIMEOUT then break end; _task.wait(0.1)
                    end
                end
            end

            -- Server Hop: only if enabled AND no item found after timeout
            if serverHopFarmEnabled and not itemFoundOnMap() and tick() - roamStart >= SERVER_HOP_TIMEOUT then
                warn("[ServerHop] No items found in " .. SERVER_HOP_TIMEOUT .. "s, hopping server...")
                serverHopToRandom()
                roamStart = tick() -- Reset roamStart to avoid spamming teleport requests while waiting
                -- After hop, wait for character to load then continue farm loop
                _task.wait(3)
            end
        end
        -- No wait in Tween mode — loop immediately to pick up the item
        if getgenv()._YBA_directTP then
            _task.wait(0.5)
        end
    end
end

local normalCoroutine = nil
local function startFarming()
    normalFarmOn = true
    normalCoroutine = coroutine.wrap(normalFarm)()
    enableNoclip()
end

local function stopFarming()
    normalFarmOn = false
    setSavedFlag("IF", false)
    CFG.ItemFarmEnabled = false
    if normalCoroutine then
        coroutine.close(normalCoroutine)
        normalCoroutine = nil
    end; _task.defer(disableNoclip)
end

player.CharacterAdded:Connect(function(char) _task.defer(function()
        disableNoclip()
        pcall(function() if _G.YBAItemFarm and _G.YBAItemFarm.disableNoclip then _G.YBAItemFarm.disableNoclip() end end)
    end)
    if normalFarmOn then
        _task.wait(0.5)
        enableNoclip()
        if normalCoroutine then
            coroutine.close(normalCoroutine)
        end
        normalCoroutine = coroutine.wrap(normalFarm)()
    end
end)

_G.YBAItemFarm = {
    itemOptions = itemOptions,
    selectedFarmItems = selectedFarmItems,
    startFarming = startFarming,
    stopFarming = stopFarming,
    enableInstantPickup = enableInstantPickup,
    disableInstantPickup = disableInstantPickup,
    enableNoclip = enableNoclip,
    disableNoclip = disableNoclip,
    enableNoclipState = nil, -- populated in block 3
    disableNoclipState = nil,
    setAutoSellMax = function(v) autoSellMax = v end,
    getAutoSellMax = function() return autoSellMax end,
    sellAll = sellAll,
    sellAllSelected = sellAllSelected,
    sellAllWorthless = sellAllWorthless,
    sellInventory = sellInventory,
    enableAntiAfk = enableAntiAfk,
    disableAntiAfk = disableAntiAfk,
    enableServerHopFarm = function() serverHopFarmEnabled = true end,
    disableServerHopFarm = function() serverHopFarmEnabled = false end,
    isServerHopFarmEnabled = function() return serverHopFarmEnabled end,
}

getgenv().RAILhub_FixCollision = function()
    ybaNotify("YBA Script", "Fixing collision issues...")
    if _G.YBAItemFarm and _G.YBAItemFarm.disableNoclip then
        _G.YBAItemFarm.disableNoclip()
    end
    if _G.YBAItemFarm and _G.YBAItemFarm.disableNoclipState then
        _G.YBAItemFarm.disableNoclipState("stand")
        _G.YBAItemFarm.disableNoclipState("rib")
        _G.YBAItemFarm.disableNoclipState("shiny")
    end
    ybaNotify("YBA Script", "Noclip disabled. If still stuck, try rejoining.")
end

end -- END BLOCK 1

-- ============================================================
-- BLOCK 2: Bypass + Window + UI setup
-- ============================================================
do

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

    _task.wait(0.1)
end)

if bypassSuccess then
    ybaNotify("YBA Script", "Anti-teleport bypass loaded successfully")
    getgenv()._YBA_directTP = true
else
    ybaNotify("YBA Script", "Bypass failed — using Tween movement to avoid server kick")
    getgenv()._YBA_directTP = false
end

-- Image loading system (same as Bizarre Lineage)
local MENU_HEADER_IMAGE_URL = "https://iili.io/qaO4Dox.png"
local MENU_HEADER_IMAGE_DIR = "RAILhubAssets"
local MENU_HEADER_IMAGE_KEY = tostring(MENU_HEADER_IMAGE_URL):gsub("[^%w]", "_")
local MENU_HEADER_IMAGE_EXT = tostring(MENU_HEADER_IMAGE_URL):match("%.([%w]+)$")
if not MENU_HEADER_IMAGE_EXT or MENU_HEADER_IMAGE_EXT == "" then
    MENU_HEADER_IMAGE_EXT = "png"
end
local MENU_HEADER_IMAGE_FILE = MENU_HEADER_IMAGE_DIR .. "/menu_header_image_" .. MENU_HEADER_IMAGE_KEY .. "." .. MENU_HEADER_IMAGE_EXT

local function fetchUrl(url)
    local req = rawget(_G, "request") or rawget(_G, "http_request") or (syn and syn.request)
    if type(req) == "function" then
        local ok, res = pcall(req, { Url = url, Method = "GET" })
        local body = ok and res and (res.Body or res.body)
        if type(body) == "string" and body ~= "" then return body end
    end
    local ok, data = pcall(game.HttpGet, game, url)
    if ok and type(data) == "string" and data ~= "" then return data end
end

local function getMenuHeaderAsset(path)
    local fn = type(getcustomasset) == "function" and getcustomasset or type(getsynasset) == "function" and getsynasset
    if not fn then return end
    local ok, res = pcall(fn, path)
    if ok and type(res) == "string" and res ~= "" then return res end
end

local function resolveMenuHeaderImage()
    local cached = rawget(_G, "MenuHeaderImage")
    local cachedUrl = rawget(_G, "MenuHeaderImageUrl")
    if type(cached) == "string" and cached ~= "" and cachedUrl == MENU_HEADER_IMAGE_URL then
        if cached == MENU_HEADER_IMAGE_URL then
            return cached
        end
        if type(isfile) == "function" and isfile(MENU_HEADER_IMAGE_FILE) then
            return cached
        end
        if type(readfile) == "function" then
            local ok = pcall(readfile, MENU_HEADER_IMAGE_FILE)
            if ok then
                return cached
            end
        end
    end
    
    local asset = MENU_HEADER_IMAGE_URL
    if type(makefolder) == "function" then
        pcall(makefolder, MENU_HEADER_IMAGE_DIR)
    end
    
    local exists
    if type(readfile) == "function" then
        local ok, data = pcall(readfile, MENU_HEADER_IMAGE_FILE)
        exists = ok and type(data) == "string" and #data > 20
    elseif type(isfile) == "function" then
        exists = isfile(MENU_HEADER_IMAGE_FILE) == true
    end
    
    if type(writefile) == "function" and not exists then
        for _ = 1, 3 do
            local fresh = fetchUrl(MENU_HEADER_IMAGE_URL)
            if type(fresh) == "string" and #fresh > 20 then
                pcall(writefile, MENU_HEADER_IMAGE_FILE, fresh)
                exists = true
                break
            end; _task.wait(0.2)
        end
    end
    
    if exists then
        local res = getMenuHeaderAsset(MENU_HEADER_IMAGE_FILE)
        if type(res) == "string" and res ~= "" then
            asset = res
        elseif type(writefile) == "function" then
            local fresh = fetchUrl(MENU_HEADER_IMAGE_URL)
            if type(fresh) == "string" and #fresh > 20 then
                pcall(writefile, MENU_HEADER_IMAGE_FILE, fresh)
                local res2 = getMenuHeaderAsset(MENU_HEADER_IMAGE_FILE)
                if type(res2) == "string" and res2 ~= "" then asset = res2 end
            end
        end
    end
    
    _G.MenuHeaderImage = asset
    _G.MenuHeaderImageUrl = MENU_HEADER_IMAGE_URL
    return asset
end
-- Export for block 3
getgenv()._YBA_resolveMenuHeaderImage = resolveMenuHeaderImage

Window = MacLib:Window({
    Title = "RAIL|hub",
    Subtitle = "YBA",
    Size = UDim2.fromOffset(860, 620),
    DragStyle = 2,
    ShowUserInfo = true,
    Keybind = Enum.KeyCode.RightControl,
    AcrylicBlur = true,
})
getgenv().RAILhubWindow = Window
_G.RAILhubWindow = Window

do
    local gui = Instance.new("ScreenGui")
    gui.Name = "RAILhubToggle"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 50
    local ok = pcall(function()
        gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    end)
    if not ok then
        pcall(function()
            gui.Parent = LP:WaitForChild("PlayerGui")
        end)
    end
    runtime.Guis[#runtime.Guis + 1] = gui
    local btn = Instance.new("ImageButton")
    btn.Parent = gui
    btn.Size = UDim2.fromOffset(55, 55)
    btn.Position = UDim2.new(0, 348, 0, 286)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.BorderSizePixel = 0
    btn.Image = resolveMenuHeaderImage()
    btn.ImageColor3 = Color3.fromRGB(235, 235, 235)
    btn.Active = true
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    btn.MouseButton1Click:Connect(function()
        if Window then
            if type(Window.Toggle) == "function" then
                Window:Toggle()
                return
            end
            if type(Window.ToggleUI) == "function" then
                Window:ToggleUI()
                return
            end
            if type(Window.SetVisible) == "function" then
                Window:SetVisible(not (Window.Visible == true))
                return
            end
        end
        local root = (gethui and gethui()) or game:GetService("CoreGui")
        local titleText = Window.Settings and Window.Settings.Title or "RAIL|hub"
        for _, g in ipairs(root:GetChildren()) do
            if g:IsA("ScreenGui") then
                for _, d in ipairs(g:GetDescendants()) do
                    if d:IsA("TextLabel") and d.Text == titleText then
                        g.Enabled = not g.Enabled
                        return
                    end
                end
            end
        end
        if Window and Window.Frame then
            Window.Frame.Visible = not Window.Frame.Visible
        end
    end)
    local dragging = false
    local dragStart
    local startPos
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = btn.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging then
            return
        end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local globalSettings = {
    UIBlurToggle = Window:GlobalSetting({
        Name = "UI Transparency",
        Default = false,
        Callback = function(bool)
            Window:SetAcrylicBlurState(bool)
        end,
    }),
    ShowUserInfo = Window:GlobalSetting({
        Name = "User Info",
        Default = true,
        Callback = function(bool)
            if typeof(Window.SetUserInfoState) == "function" then
                Window:SetUserInfoState(bool)
            elseif typeof(Window.ToggleUserInfo) == "function" then
                Window:ToggleUserInfo(bool)
            else
                pcall(function()
                    if Window.Settings then
                        Window.Settings.ShowUserInfo = bool
                    end
                    if Window.Frame and Window.Frame:FindFirstChild("Bottom") then
                        local bottom = Window.Frame.Bottom
                        for _, child in pairs(bottom:GetChildren()) do
                            if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                                child.Visible = bool
                            elseif child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("TextButton") then
                                child.Visible = bool
                            elseif child:IsA("Frame") and (child.Name:find("User") or child.Name:find("Avatar") or child.Name:find("Profile")) then
                                child.Visible = bool
                            end
                        end
                        local bottomLeft = bottom:FindFirstChild("BottomLeft") or bottom:FindFirstChild("Left")
                        if bottomLeft then
                            bottomLeft.Visible = bool
                        end
                        if not bool then
                            local allHidden = true
                            for _, child in pairs(bottom:GetChildren()) do
                                if child.Visible then
                                    allHidden = false
                                    break
                                end
                            end
                            if allHidden then
                                bottom.Visible = false
                            end
                        else
                            bottom.Visible = true
                        end
                    end
                    if Window.Frame then
                        local stack = { Window.Frame }
                        while #stack > 0 do
                            local parent = table.remove(stack)
                            for _, child in pairs(parent:GetChildren()) do
                                if (child.Name:find("User") or child.Name:find("Avatar") or child.Name:find("Profile") or child.Name:find("Name"))
                                    and (child:IsA("Frame") or child:IsA("ImageLabel") or child:IsA("TextLabel") or child:IsA("ViewportFrame")) then
                                    child.Visible = bool
                                end
                                table.insert(stack, child)
                            end
                        end
                    end
                end)
            end
        end,
    }),
    Watermark = Window:GlobalSetting({
        Name = "Watermark",
        Default = true,
        Callback = function(bool)
            if _G.CustomWatermark then
                _G.CustomWatermark.Enabled = bool
            end
        end,
    }),
}
if _G.allvars and _G.allvars._rt then
    _G.allvars._rt.globalSettings = globalSettings
end; _task.spawn(function()
    if _G.CustomWatermark then
        return
    end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RAILhubWatermark"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ok = pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
    end)
    if not ok then
        pcall(function()
            screenGui.Parent = LP:WaitForChild("PlayerGui")
        end)
    end
    runtime.Guis[#runtime.Guis + 1] = screenGui
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "WatermarkFrame"
    mainFrame.Position = UDim2.new(0, 15, 0, 60)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.AutomaticSize = Enum.AutomaticSize.X
    mainFrame.Size = UDim2.new(0, 0, 0, 28)
    mainFrame.Parent = screenGui
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = mainFrame
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.PaddingTop = UDim.new(0, 4)
    padding.PaddingBottom = UDim.new(0, 4)
    padding.Parent = mainFrame
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(60, 60, 60)
    stroke.Parent = mainFrame
    local accentBar = Instance.new("Frame")
    accentBar.Name = "AccentBar"
    accentBar.Position = UDim2.new(0, 0, 0, 0)
    accentBar.Size = UDim2.new(1, 0, 0, 1)
    accentBar.BorderSizePixel = 0
    accentBar.BackgroundColor3 = Color3.fromRGB(113, 93, 255)
    accentBar.Parent = mainFrame
    local accentGradient = Instance.new("UIGradient")
    accentGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 102)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(113, 93, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 214, 160)),
    })
    accentGradient.Parent = accentBar
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = mainFrame
    textLabel.Size = UDim2.new(0, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 13
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.AutomaticSize = Enum.AutomaticSize.X
    local lastFrameTime = tick()
    local fps = 60
    local gradientOffset = 0
    RunService.RenderStepped:Connect(function()
        local now = tick()
        local delta = now - lastFrameTime
        lastFrameTime = now
        if delta > 0 then
            fps = math.clamp(math.floor(1 / delta), 1, 1000)
        end
        gradientOffset = (gradientOffset + delta * 0.1) % 1
        accentGradient.Offset = Vector2.new(gradientOffset, 0)
    end)
    RunService.Heartbeat:Connect(function()
        if screenGui.Enabled then
            textLabel.Text = string.format(
                "RAIL|hub | %s | %s | %d FPS",
                os.date("%H:%M:%S"),
                os.date("%d/%m/%Y"),
                fps
            )
        end
    end)
    _G.CustomWatermark = screenGui
    screenGui.Enabled = true
end)

TabGroup = Window:TabGroup()
Info = TabGroup:Tab({ Name = "Information", Image = "rbxassetid://80780628588275" })

infoLeft = Info:Section({ Side = "Left", Name = "Updates" })
infoRight = Info:Section({ Side = "Right", Name = "Links" })
infoLeft:Header({ Text = "Cracked by piscar.", AutoLocalize = false })
infoLeft:Header({ Text = "Last update: 20.07.2026", AutoLocalize = false })
infoRight:Header({ Text = "Links", AutoLocalize = false })
infoRight:Button({
    Name = "Discord Link",
    Callback = function()
        openDiscordLink("https://discord.gg/XC755YMZVs")
    end,
})

YF = _G.YBAItemFarm
toggleAutoPrestige = nil
FarmTab = TabGroup:Tab({ Name = "Farming", Image = "rbxassetid://4483345737" })
farmSec = FarmTab:Section({ Side = "Left", Name = "Auto farm items" })
autoPrestigeSec = FarmTab:Section({ Side = "Right", Name = "Auto Prestige" })
farmSec:Header({ Text = " Auto farm items", AutoLocalize = false })
autoPrestigeSec:Header({ Text = "Auto Prestige", AutoLocalize = false })
farmSec:Dropdown({
    Name = "Items (empty = all)",
    Options = (_G.YBAItemFarm and _G.YBAItemFarm.itemOptions) or {},
    Multi = true,
    Default = {},
    Callback = function(map)
        local sel = (_G.YBAItemFarm and _G.YBAItemFarm.selectedFarmItems) or {}
        for i = #sel, 1, -1 do
            table.remove(sel, i)
        end
        if type(map) == "table" then
            if map[1] ~= nil then
                for _, name in ipairs(map) do
                    if type(name) == "string" then
                        table.insert(sel, name)
                    end
                end
            else
                for name, on in pairs(map) do
                    if on == true and type(name) == "string" then
                        table.insert(sel, name)
                    end
                end
            end
        end
    end,
})

farmSec:Toggle({
    Name = "Enable farming",
    Default = getSavedFlag("IF", false),
    Callback = function(on)
        CFG.ItemFarmEnabled = on
        setSavedFlag("IF", on)
        local yf = _G.YBAItemFarm
        if on then
            if yf and yf.startFarming then
                yf.startFarming()
            else
                warn("[YBA] startFarming not available")
            end
            if not Workspace:FindFirstChild("WhitePad") then
                local pad = Instance.new("Part")
                pad.Size = Vector3.new(10000, 1, 10000)
                pad.Position = Vector3.new(-139.164612, 60.740036, -372.339508)
                pad.Anchored = true
                pad.CanCollide = true
                pad.Color = Color3.fromRGB(255, 255, 255)
                pad.Transparency = 0.95
                pad.Name = "WhitePad"
                pad.Parent = Workspace
                if not Workspace:FindFirstChild("UnderwhitePad") then
                    local u = Instance.new("Part")
                    u.Size = Vector3.new(10000, 1, 10000)
                    u.Position = Vector3.new(0, -45, 0)
                    u.Anchored = true
                    u.Color = Color3.fromRGB(255, 255, 255)
                    u.Transparency = 0.5
                    u.Name = "UnderwhitePad"
                    u.Parent = Workspace
                end
            end
        else
            local yf = _G.YBAItemFarm
            if yf and yf.stopFarming then yf.stopFarming() end
            local pad = Workspace:FindFirstChild("WhitePad")
            if pad then
                pad:Destroy()
            end
            local u = Workspace:FindFirstChild("UnderwhitePad")
            if u then
                u:Destroy()
            end
        end
    end,
})

farmSec:Toggle({
    Name = "Auto sell on stack limit",
    Default = getSavedFlag("ASM", false),
    Callback = function(on)
        local yf = _G.YBAItemFarm
        if yf and yf.setAutoSellMax then yf.setAutoSellMax(on) end
        setSavedFlag("ASM", on)
    end,
})
farmSec:Toggle({
    Name = "Server Hop Farm",
    Default = getSavedFlag("SHF", false),
    Callback = function(on)
        serverHopFarmEnabled = on
        setSavedFlag("SHF", on)
        if on then
            warn("[ServerHop] Server Hop Farm enabled")
        else
            warn("[ServerHop] Server Hop Farm disabled")
        end
    end,
})

farmSec:Toggle({
    Name = "Item ESP",
    Default = getSavedFlag("IESP", false),
    Callback = function(on)
        setSavedFlag("IESP", on)
        setItemESP(on)
    end,
})
autoPrestigeSec:Toggle({
    Name = "Auto Prestige",
    Default = getSavedFlag("AP", false),
    Callback = function(on)
        if toggleAutoPrestige then
            toggleAutoPrestige(on)
        else
            setSavedFlag("AP", on); _task.spawn(function()
                repeat _task.wait() until toggleAutoPrestige
                toggleAutoPrestige(on)
            end)
        end
    end,
})

-- Auto-start farming if it was enabled before save
if CFG.ItemFarmEnabled then
    _task.delay(2, function()
        warn("[YBA] Auto-starting item farm (was enabled before save)")
        local yf = _G.YBAItemFarm
        if yf and yf.startFarming then yf.startFarming() end
    end)
end

-- Apply auto sell setting if it was saved
if getSavedFlag("ASM", false) then
    local yf = _G.YBAItemFarm
    if yf and yf.setAutoSellMax then yf.setAutoSellMax(true) end
end
if getSavedFlag("IESP", false) then
    _task.defer(function()
        setItemESP(true)
    end)
end

VisualsTab = TabGroup:Tab({ Name = "Visuals", Image = "rbxassetid://7733960981" })
visualsSec = VisualsTab:Section({ Side = "Left", Name = "ESP" })
visualsSec:Header({ Text = "Player ESP", AutoLocalize = false })
visualsSec:Toggle({
    Name = "Enable Player ESP",
    Default = getSavedFlag("PESP", false),
    Callback = function(on)
        setSavedFlag("PESP", on)
        if getgenv()._YBA_setPlayerESP then getgenv()._YBA_setPlayerESP(on) end
    end,
})
visualsSec:Toggle({
    Name = "ESP Chams",
    Default = getSavedFlag("PESP_CH", true),
    Callback = function(on)
        setSavedFlag("PESP_CH", on)
        getgenv().PlayerESPData.showChams = on
        if getgenv()._YBA_refreshPlayerESP then _task.defer(getgenv()._YBA_refreshPlayerESP) end
    end,
})
visualsSec:Toggle({
    Name = "ESP Names",
    Default = getSavedFlag("PESP_NM", true),
    Callback = function(on)
        setSavedFlag("PESP_NM", on)
        getgenv().PlayerESPData.showNames = on
        if getgenv()._YBA_refreshPlayerESP then _task.defer(getgenv()._YBA_refreshPlayerESP) end
    end,
})
visualsSec:Toggle({
    Name = "ESP Distance",
    Default = getSavedFlag("PESP_DS", true),
    Callback = function(on)
        setSavedFlag("PESP_DS", on)
        getgenv().PlayerESPData.showDistance = on
        if getgenv()._YBA_refreshPlayerESP then _task.defer(getgenv()._YBA_refreshPlayerESP) end
    end,
})

local finishersSec = VisualsTab:Section({ Side = "Right", Name = "Custom Finishers" })
finishersSec:Header({ Text = "Finishers VFX", AutoLocalize = false })

local selectedFinisher = "Shiza"
finishersSec:Dropdown({
    Name = "Select Finisher",
    Options = {"Aincrad", "Announcer", "Bruh Moment", "Crumble", "Disintegrate", "GET OUT", "Gate of Babylon", "God's Lightning", "Huh #2", "Hyperlaser", "Killer Queen Detonate", "Lineage Wipe", "Minecraft", "None", "Pillarman", "Shiza", "Sub-Zero", "Tom", "Vampire Ripple", "Wither"},
    Default = "Shiza",
    Callback = function(v)
        selectedFinisher = v
    end,
})

getgenv().CustomFinisherEnabled = false

finishersSec:Toggle({
    Name = "Enable Custom Finisher",
    Default = false,
    Callback = function(on)
        getgenv().CustomFinisherEnabled = on
        
        if on and not getgenv().FinisherSystemHooked then
            getgenv().FinisherSystemHooked = true
            
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local LocalPlayer = game:GetService("Players").LocalPlayer

            local function safeGetInstances()
                if type(getinstances) == "function" then
                    return getinstances()
                else
                    local inst = {}
                    for _, v in pairs(game:GetDescendants()) do
                        table.insert(inst, v)
                    end
                    return inst
                end
            end

            local function hookRemote(remote)
                if not getgenv().HookedRemotes then getgenv().HookedRemotes = {} end
                if getgenv().HookedRemotes[remote] then return end
                getgenv().HookedRemotes[remote] = true
                
                remote.OnClientEvent:Connect(function(arg1, arg2)
                    if not getgenv().CustomFinisherEnabled then return end
                    
                    pcall(function()
                        if type(arg1) == "string" and string.find(arg1, "Finisher:") then
                            if type(arg2) == "table" then
                                local userStr = tostring(arg2.User)
                                if userStr == LocalPlayer.Name then
                                    local targetRoot = arg2.Origin
                                    if targetRoot and typeof(targetRoot) == "Instance" then
                                        local finisherName = selectedFinisher
                                        if finisherName == "None" or finisherName == "" then return end
                                        
                                        local vfxFinishers = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("VFX_Finishers")
                                        local finisherModuleScript = vfxFinishers:FindFirstChild(finisherName)

                                        if not finisherModuleScript then return end
                                        
                                        local finisherModule = require(finisherModuleScript)
                                        local setupData = {
                                            Client_Mod = {},
                                            Misc_Functions = workspace:FindFirstChild("IgnoreInstances") or workspace,
                                            VFX = ReplicatedStorage:FindFirstChild("Objects"),
                                            VFX_2 = ReplicatedStorage:FindFirstChild("Anims")
                                        }

                                        pcall(function()
                                            if finisherModule["Set Up"] then
                                                finisherModule["Set Up"](setupData)
                                            end
                                        end)

                                        local funcName = "Finisher: " .. finisherName
                                        local packet = {
                                            Origin = targetRoot,
                                            RespawnTime = 5
                                        }; _task.spawn(function()
                                            if finisherModule[funcName] then
                                                pcall(function()
                                                    finisherModule[funcName](packet)
                                                end)
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end)
                end)
            end

            for _, instance in pairs(safeGetInstances()) do
                if instance:IsA("RemoteEvent") then
                    hookRemote(instance)
                end
            end

            game.DescendantAdded:Connect(function(instance)
                if instance:IsA("RemoteEvent") then
                    hookRemote(instance)
                end
            end)
            
            warn("✅ Финишеры успешно инициализированы!")
        end
    end,
})

sellSec = FarmTab:Section({ Side = "Right", Name = "Sell items" })
sellSec:Header({ Text = "Sell items", AutoLocalize = false })
local sellItemName = ""
sellSec:Dropdown({
    Name = "Sell specific item",
    Options = (_G.YBAItemFarm and _G.YBAItemFarm.itemOptions) or {},
    Default = "",
    Callback = function(v)
        sellItemName = v or ""
    end,
})
sellSec:Button({
    Name = "Sell selected item",
    Callback = function()
        if sellItemName ~= "" then
            local yf = _G.YBAItemFarm
            if yf and yf.sellAll then yf.sellAll(sellItemName) end
        else
            ybaNotify("YBA Script", "Select an item first.")
        end
    end,
})
sellSec:Button({
    Name = "Sell All (entire inventory)",
    Callback = function()
        local yf = _G.YBAItemFarm
        if yf and yf.sellInventory then yf.sellInventory() end
    end,
})

end -- END BLOCK 2

-- ============================================================
-- BLOCK 3: Stand farm logic + Stand UI + Shop + Player + Settings
-- ============================================================
do

local standFarmRunning = false
local ribFarmRunning = false
local shinyFarmRunning = false
local standFarmTarget = {}
local shinyFarmTarget = {}
local keepAnyShiny = getSavedFlag("SKS", true)
local farmMethod = "Arrow"
local farmStats = { arrowsUsed = 0, rokasUsed = 0, ribsUsed = 0, luckyArrowsUsed = 0, standsGot = 0, startTime = 0 }
local standFarmRespawnConn = nil
local ribFarmRespawnConn = nil
local shinyFarmRespawnConn = nil

local function sfNotify(msg) ybaNotify("Stand Farm", msg) end

local function sfCountItem(Item)
    local Count = 0
    for _, v in pairs(LP.Backpack:GetChildren()) do if v.Name == Item then Count = Count + 1 end end
    local ch = LP.Character
    if ch then
        for _, v in pairs(ch:GetChildren()) do
            if v.Name == Item then Count = Count + 1 end
        end
    end
    return Count
end

local function sfGetMax(Item)
    local Max = {["Mysterious Arrow"]=25,["Rokakaka"]=25,["Diamond"]=30,["Gold Coin"]=45,["Pure Rokakaka"]=10,
        ["Stone Mask"]=10,["Rib Cage of The Saint's Corpse"]=10,["Steel Ball"]=10,["Ancient Scroll"]=10,
        ["Dio's Diary"]=10,["Caesar's Headband"]=10,["Christmas Present"]=45,["Quinton's Glove"]=10,["Lucky Arrow"]=10}
    local ok, has2x = pcall(function() return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(LP.UserId, 14597778) end)
    if ok and has2x then
        for k, v in pairs(Max) do Max[k] = v * 2 end
    end
    return Max[Item] or 999
end

local function sfCheckShiny()
    local ch = LP.Character
    if not ch then return "None" end
    local rf = ch:FindFirstChild("RemoteFunction") or ch:WaitForChild("RemoteFunction", 5)
    if not rf then return "None" end
    local ok, res = pcall(function() return rf:InvokeServer("ReturnStandSkin", "Stand") end)
    return ok and res or "None"
end

local function sfFindTable(tbl, value)
    if not tbl then return false end
    for _, v in ipairs(tbl) do if v == value then return true end end
    return false
end

local function sfLearnWorthiness()
    local ch = LP.Character
    if not ch then return false end
    local rf = ch:FindFirstChild("RemoteFunction")
    if not rf then
        local t = tick()
        while tick()-t < 5 do
            rf = ch:FindFirstChild("RemoteFunction")
            if rf and rf:IsA("RemoteFunction") then break end; _task.wait(0.1)
        end
    end
    if not rf or not rf:IsA("RemoteFunction") then return false end
    for _, skill in ipairs({"Worthiness","Worthiness II","Worthiness III","Worthiness IV","Worthiness V"}) do
        pcall(function() rf:InvokeServer("LearnSkill", {Skill=skill, SkillTreeType="Character"}) end); _task.wait(0.1)
    end
    return true
end

local function sfClickDialogue(dlgGui, char)
    pcall(function()
        repeat safeFireSignal(dlgGui.Frame.ClickContinue.MouseButton1Click); _task.wait(0.1)
        until dlgGui.Frame.Options:FindFirstChild("Option1")
        local opt1 = dlgGui.Frame.Options:FindFirstChild("Option1")
        if opt1 and opt1:FindFirstChild("TextButton") then
            local btn = opt1.TextButton
            pcall(function() for _, c in pairs(safeGetConnections(btn.MouseButton1Click)) do pcall(function() c:Fire() end) end end)
            safeFireSignal(btn.MouseButton1Click)
            safeFireSignal(btn.Activated)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,1); _task.wait(0.05)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,1)
            local re = char:FindFirstChild("RemoteEvent")
            if re then re:FireServer("EndDialogue",{NPC=dlgGui.Name,Option="Option1",Dialogue="Dialogue2"}) end
        end
        repeat safeFireSignal(dlgGui.Frame.ClickContinue.MouseButton1Click); _task.wait(0.1)
        until dlgGui.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
        safeFireSignal(dlgGui.Frame.ClickContinue.MouseButton1Click)
    end)
end

-- Universal item use. Tries the best method available for the current executor.
-- On normal executors (firesignal available): VIM click + firesignal (original behaviour).
-- On low-UNC executors (Solara): tool:Activate() loop + FireServer.
local function useItemDirect(itemName, npcName, dialogue, option)
    dialogue = dialogue or "Dialogue2"
    option = option or "Option1"
    local char = LP.Character
    local re = char and char:FindFirstChild("RemoteEvent")
    if not re then return false end

    local tool = LP.Backpack:FindFirstChild(itemName) or (char and char:FindFirstChild(itemName))
    if not tool then return false end

    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return false end

    -- Equip the tool
    pcall(function() hum:EquipTool(tool) end); _task.wait(0.08)

    -- Method A: VIM + firesignal (normal executors)
    if type(firesignal) == "function" then
        -- Open dialogue via VIM mouse click
        for i = 1, 3 do
            pcall(function()
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 8, 0, true, nil, 1)
            end); _task.wait(0.03)
        end
        -- Wait for DialogueGui
        local dlg = nil
        local t = tick()
        while tick() - t < 1.5 do
            dlg = LP.PlayerGui:FindFirstChild("DialogueGui")
            if dlg then break end; _task.wait(0.03)
        end
        if dlg then
            pcall(function()
                repeat safeFireSignal(dlg.Frame.ClickContinue.MouseButton1Click); _task.wait(0.03)
                until dlg.Frame.Options:FindFirstChild("Option1")
                local opt = dlg.Frame.Options:FindFirstChild("Option1")
                if opt and opt:FindFirstChild("TextButton") then
                    safeFireSignal(opt.TextButton.MouseButton1Click)
                    safeFireSignal(opt.TextButton.Activated)
                end
                repeat safeFireSignal(dlg.Frame.ClickContinue.MouseButton1Click); _task.wait(0.03)
                until dlg.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
                safeFireSignal(dlg.Frame.ClickContinue.MouseButton1Click)
            end)
        end
        pcall(function()
            re:FireServer("EndDialogue", {NPC = npcName, Option = option, Dialogue = dialogue})
        end)
        return true
    end

    -- Method B: tool:Activate() loop (low-UNC executors like Solara)
    local t = tick()
    repeat
        pcall(function() tool:Activate() end); _task.wait(0.05)
    until LP.PlayerGui:FindFirstChild("DialogueGui") or tick() - t > 1.5

    _task.wait(0.05)
    pcall(function()
        re:FireServer("EndDialogue", {NPC = npcName, Option = option, Dialogue = dialogue})
    end)

    -- Close any open dialogue
    _task.wait(0.05)
    local dlgGui = LP.PlayerGui:FindFirstChild("DialogueGui")
    if dlgGui then
        pcall(function()
            if type(safeFireSignal) == "function" then
                safeFireSignal(dlgGui.Frame.ClickContinue.MouseButton1Click)
            end
        end)
    end

    return true
end

local function sfUseRoka(maxRetries)
    maxRetries = maxRetries or 3
    local retries = 0
    local initialRokaCount = sfCountItem("Rokakaka")

    while retries < maxRetries and standFarmRunning do
        local oldStand = LP.PlayerStats and LP.PlayerStats.Stand.Value or "None"
        local currentRokaCount = sfCountItem("Rokakaka")
        if currentRokaCount < initialRokaCount then
            farmStats.rokasUsed = farmStats.rokasUsed + 1
            local t = tick()
            while tick() - t < 2 do
                local newStand = LP.PlayerStats and LP.PlayerStats.Stand.Value or "None"
                if oldStand ~= "None" and newStand == "None" then return true end; _task.wait(0.1)
            end
            return false
        end

        if sfCountItem("Rokakaka") == 0 then return false end

        useItemDirect("Rokakaka", "Rokakaka")

        local char = LP.Character
        local oldChar = char
        local t = tick()
        while tick() - t < 4 and LP.Character == oldChar and standFarmRunning do
            _task.wait(0.05)
        end
        if LP.Character then LP.Character:WaitForChild("RemoteFunction", 1) end
        local newStand = LP.PlayerStats and LP.PlayerStats.Stand.Value or "None"
        if oldStand ~= "None" and newStand == "None" then return true end
        retries = retries + 1
        sfNotify("Roka failed (attempt " .. retries .. "/" .. maxRetries .. ")")
    end
    return false
end

local function sfUseArrow(maxRetries)
    maxRetries = maxRetries or 3
    local retries = 0
    local initialArrowCount = sfCountItem("Mysterious Arrow")
    sfNotify("sfUseArrow called (have " .. initialArrowCount .. " arrows)")

    while retries < maxRetries and standFarmRunning do
        local currentArrowCount = sfCountItem("Mysterious Arrow")
        if currentArrowCount < initialArrowCount then
            farmStats.arrowsUsed = farmStats.arrowsUsed + 1
            sfNotify("Arrow consumed, waiting for stand...")
            local t = tick()
            while tick() - t < 2 do
                local newStand = LP.PlayerStats and LP.PlayerStats.Stand.Value or "None"
                if newStand ~= "None" then
                    farmStats.standsGot = farmStats.standsGot + 1
                    sfNotify("Stand appeared after arrow use!")
                    return true
                end; _task.wait(0.1)
            end
            sfNotify("Arrow used but no stand appeared")
            return false
        end

        local oldStand = LP.PlayerStats and LP.PlayerStats.Stand.Value or "None"
        if sfCountItem("Mysterious Arrow") == 0 then
            sfNotify("No arrow found in inventory")
            return false
        end

        useItemDirect("Mysterious Arrow", "Mysterious Arrow")

        local char = LP.Character
        local oldChar = char
        local t = tick()
        while tick() - t < 4 and LP.Character == oldChar and standFarmRunning do
            _task.wait(0.05)
        end
        if LP.Character then LP.Character:WaitForChild("RemoteFunction", 1) end
        local newStand = LP.PlayerStats and LP.PlayerStats.Stand.Value or "None"
        if newStand ~= "None" and newStand ~= oldStand then return true end
        retries = retries + 1
        sfNotify("Arrow failed to assign stand (attempt " .. retries .. "/" .. maxRetries .. ")")
    end
    return false
end

local function sfUseRib()
    local ch = LP.Character
    if not ch then return end
    local re = ch:FindFirstChild("RemoteEvent")
    if not re then return end
    farmStats.ribsUsed = farmStats.ribsUsed + 1
    useItemDirect("Rib Cage of The Saint's Corpse", "Rib Cage of The Saint's Corpse")
end

local function sfUseRokaDirect()
    return useItemDirect("Rokakaka", "Rokakaka")
end

local function skipCurrentShinyStand()
    local ps = LP:FindFirstChild("PlayerStats")
    local currentStand = ps and ps:FindFirstChild("Stand") and ps.Stand.Value or "None"
    if currentStand == "None" then
        ybaNotify("Stand Farm", "No stand to skip.")
        return
    end

    local shinyName = sfCheckShiny()
    if not shinyName or shinyName == "None" or shinyName == "" then
        ybaNotify("Stand Farm", "Current stand is not shiny.")
        return
    end

    if farmMethod == "Rib Cage" then
        if sfCountItem("Rib Cage of The Saint's Corpse") < 1 then
            ybaNotify("Stand Farm", "No Rib Cage available to skip shiny.")
            return
        end
        sfLearnWorthiness()
        sfUseRib()
        ybaNotify("Stand Farm", "Skipping shiny stand with Rib Cage...")
        return
    end

    if sfCountItem("Rokakaka") < 1 then
        ybaNotify("Stand Farm", "No Rokakaka available to skip shiny.")
        return
    end

    if sfUseRokaDirect() then
        ybaNotify("Stand Farm", "Skipping shiny stand with Rokakaka...")
    else
        ybaNotify("Stand Farm", "Failed to use Rokakaka.")
    end
end
local standFarmPosition = CFrame.new(
    914.264832, 126.484932, -194.080887,
    0.0349707194, 1.18272225e-09, 0.999388337,
    -5.95965366e-09, 1, -9.74905157e-10,
    -0.999388337, -5.9219154e-09, 0.0349707194
)

local safePosAnchor = Instance.new("Part")
safePosAnchor.Name = "StandFarmSafeAnchor"
safePosAnchor.Anchored = true
safePosAnchor.CanCollide = false
safePosAnchor.Transparency = 1
safePosAnchor.Size = Vector3.new(1, 1, 1)
safePosAnchor.CFrame = standFarmPosition
safePosAnchor.Parent = Workspace.Terrain

local function refreshFarmRoamPosition()
    local cf = getRandomFarmRoamCFrame()
    waitingPosition = cf
    standFarmPosition = cf
    safePosAnchor.CFrame = cf
    return cf
end

local function moveToFarmRoamPos()
    return moveCharacterTo(refreshFarmRoamPosition())
end

local function teleportToSafePos()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        _task.wait(0.1)
        moveCharacterTo(standFarmPosition)
    end
end

local standNcConn = nil
local standOriginalCollides = {}
local standNoclipChar = nil

-- Unified noclip management system
local noclipStates = {
    main = { conn = nil, originalCollides = {}, char = nil, enabled = false },
    stand = { conn = nil, originalCollides = {}, char = nil, enabled = false },
    rib = { conn = nil, originalCollides = {}, char = nil, enabled = false },
    shiny = { conn = nil, originalCollides = {}, char = nil, enabled = false },
}

local function enableNoclipState(stateName)
    local state = noclipStates[stateName]
    if not state then
        warn("[Noclip] Invalid state: " .. tostring(stateName))
        return
    end
    
    if state.conn then 
        state.conn:Disconnect() 
    end
    
    local ch = LP.Character
    if not ch then 
        state.enabled = true
        return 
    end
    
    state.originalCollides = {}
    for _, p in ipairs(ch:GetDescendants()) do
        if p:IsA("BasePart") then
            state.originalCollides[p] = p.CanCollide
            p.CanCollide = false
        end
    end
    state.char = ch

    state.conn = RunService.Stepped:Connect(function()
        local char = LP.Character
        if not char then return end
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then
                p.CanCollide = false
            end
        end
    end)
    state.enabled = true
end

local function disableNoclipState(stateName)
    local state = noclipStates[stateName]
    if not state then
        warn("[Noclip] Invalid state: " .. tostring(stateName))
        return
    end
    
    if state.conn then
        state.conn:Disconnect()
        state.conn = nil
    end
    
    for part, originalValue in pairs(state.originalCollides) do
        if part and part.Parent and part:IsA("BasePart") then
            pcall(function()
                part.CanCollide = originalValue
            end)
        end
    end
    
    local ch = LP.Character
    if ch then
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") and (p.Name == "UpperTorso" or p.Name == "HumanoidRootPart") then
                pcall(function()
                    p.CanCollide = true
                end)
            end
        end
    end

    state.originalCollides = {}
    state.char = nil
    state.enabled = false
end

-- Backward compatibility wrappers
local function standEnableNoclip() enableNoclipState("stand") end
local function standDisableNoclip() disableNoclipState("stand") end

-- Export noclip state functions so block 1 closures can use them
if _G.YBAItemFarm then
    _G.YBAItemFarm.enableNoclipState = enableNoclipState
    _G.YBAItemFarm.disableNoclipState = disableNoclipState
end

local function sfSendWebhook(standName, shinyName)
    local whUrl = getgenv().webhook
    if not whUrl or whUrl == "" then return end
    local httpFn = (syn and syn.request) or http_request or request or (http and http.request)
    if not httpFn then return end
    local msg = shinyName and shinyName ~= "None" and shinyName ~= ""
        and ("✨ **STAND FARM SUCCESS!** Got shiny " .. standName .. " [" .. shinyName .. "]!")
        or ("**STAND FARM SUCCESS!** Got " .. standName)
    pcall(function()
        httpFn({
            Url = whUrl,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                content = msg,
                username = "RAIL Hub Stand Farm",
            })
        })
    end)
end

local shinySoundAsset
local function getShinySoundAsset()
    if shinySoundAsset then
        return shinySoundAsset
    end
    local assetPath = settingsFolderName .. "/fears_notification.mp3"
    local assetLoader = getcustomasset or getsynasset
    if type(isfile) == "function" and isfile(assetPath) and assetLoader then
        local ok, asset = pcall(assetLoader, assetPath)
        if ok and type(asset) == "string" and asset ~= "" then
            shinySoundAsset = asset
            return shinySoundAsset
        end
    end
    if type(writefile) == "function" and assetLoader then
        ensureSettingsFolder()
        local ok = pcall(function()
            writefile(assetPath, game:HttpGet("https://www.myinstants.com/media/sounds/fears-to-fathom-notification-sound.mp3"))
        end)
        if ok then
            local ok2, asset = pcall(assetLoader, assetPath)
            if ok2 and type(asset) == "string" and asset ~= "" then
                shinySoundAsset = asset
                return shinySoundAsset
            end
        end
    end
    return nil
end

local function playShinyNotificationSound()
    local asset = getShinySoundAsset()
    if not asset then
        return
    end
    pcall(function()
        local sound = Instance.new("Sound")
        sound.Name = "RAILhubShinySound"
        sound.SoundId = asset
        sound.Volume = 5
        sound.Parent = game:GetService("SoundService")
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
        sound:Play()
    end)
end

local function sfCheckStandResult(s, sh)
    local t = #standFarmTarget > 0 and sfFindTable(standFarmTarget, s) or true
    local isSh = sh and sh ~= "None" and sh ~= ""
    -- Only re-check shiny if we don't have a cached result already
    if not isSh and (not sh or sh == "None" or sh == "") then
        _task.wait(0.12)
        sh = sfCheckShiny()
        isSh = sh and sh ~= "None" and sh ~= ""
    end
    if #standFarmTarget == 0 then
        if keepAnyShiny and isSh then
            sfNotify("✨ Got shiny stand: "..s.." ["..sh.."]! Keeping it.")
            playShinyNotificationSound()
            sfSendWebhook(s, sh)
            return "stop"
        end
        if not isSh then sfNotify("Got stand: "..s.." - continuing to farm"); end
        return "continue"
    end
    if t then
        if isSh then
            sfNotify("✨ Got target shiny stand: "..s.." ["..sh.."]!")
            playShinyNotificationSound()
            sfSendWebhook(s, sh)
            return "stop"
        end
        if keepAnyShiny then sfNotify("Got target stand: "..s.." - continuing to farm for shiny"); return "continue" end
        sfNotify("Got desired stand: "..s)
        sfSendWebhook(s, nil)
        return "stop"
    end
    if isSh and keepAnyShiny then
        sfNotify("✨ Got shiny non-target stand: "..s.." ["..sh.."]! Keeping it.")
        playShinyNotificationSound()
        sfSendWebhook(s, sh)
        return "stop"
    end
    return "continue"
end

local function sfUseResetItem(hasAnyStand, rokaCount, ribCount, arrowCount, maxArrows, maxRokas, maxRibs, ps)
    if hasAnyStand then
        if farmMethod == "Rib Cage" then
            if ribCount > 0 then
                sfLearnWorthiness()
                sfUseRib(); _task.wait(0.1)
                local t = tick()
                while tick() - t < 1.5 and standFarmRunning do
                    if ps.Stand.Value == "None" then break end; _task.wait(0.08)
                end
                return standFarmRunning
            end
        else
            if rokaCount > 0 then
                local success = sfUseRoka()
                if success then
                    local t = tick()
                    while tick() - t < 1.5 and standFarmRunning do
                        if ps.Stand.Value == "None" then break end; _task.wait(0.08)
                    end
                    return standFarmRunning
                else
                    sfNotify("Roka failed after retries - will farm more items")
                    return true -- continue loop to farm more rokakakas
                end
            end
        end
    end
    -- Try Lucky Arrow first if available (higher chance for rare stands)
    local luckyCount = sfCountItem("Lucky Arrow")
    if not hasAnyStand and luckyCount > 0 and farmMethod == "Lucky Arrow" then
        sfNotify("Using Lucky Arrow (no stand)...")
        local oldStand = ps.Stand.Value
        local arrow = LP.Backpack:FindFirstChild("Lucky Arrow") or LP.Character and LP.Character:FindFirstChild("Lucky Arrow")
        if arrow then
            local char = LP.Character
            local hum = char and char:FindFirstChildWhichIsA("Humanoid")
            local re = char and char:FindFirstChild("RemoteEvent")
            if hum and re then
                hum:EquipTool(arrow); _task.wait(0.08)
                for i = 1, 3 do
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,8,0,true,nil,1); _task.wait(0.03)
                end
                local dlg = nil
                local t = tick()
                while tick()-t < 1.5 do
                    dlg = LP.PlayerGui:FindFirstChild("DialogueGui")
                    if dlg then break end; _task.wait(0.03)
                end
                if dlg then
                    pcall(function()
                        repeat safeFireSignal(dlg.Frame.ClickContinue.MouseButton1Click); _task.wait(0.03)
                        until dlg.Frame.Options:FindFirstChild("Option1")
                        local opt = dlg.Frame.Options:FindFirstChild("Option1")
                        if opt and opt:FindFirstChild("TextButton") then
                            safeFireSignal(opt.TextButton.MouseButton1Click)
                            safeFireSignal(opt.TextButton.Activated)
                        end
                        repeat safeFireSignal(dlg.Frame.ClickContinue.MouseButton1Click); _task.wait(0.03)
                        until dlg.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
                        safeFireSignal(dlg.Frame.ClickContinue.MouseButton1Click)
                    end)
                end
                pcall(function() re:FireServer("EndDialogue",{NPC="Lucky Arrow",Option="Option1",Dialogue="Dialogue2"}) end)
                local oldChar = char
                t = tick()
                while tick()-t < 1.5 and LP.Character == oldChar and standFarmRunning do _task.wait(0.05) end
                if LP.Character then LP.Character:WaitForChild("RemoteFunction", 1) end
                local newStand = ps.Stand.Value
                if newStand ~= "None" and newStand ~= oldStand then
                    farmStats.luckyArrowsUsed = farmStats.luckyArrowsUsed + 1
                    farmStats.standsGot = farmStats.standsGot + 1
                    sfNotify("Lucky Arrow gave stand: " .. newStand)
                    return standFarmRunning
                end
            end
        end
    end
    if not hasAnyStand and arrowCount > 0 then
        sfNotify("Using Arrow (no stand)...")
        local success = sfUseArrow()
        if success then
            local t = tick()
            while tick() - t < 1.5 and standFarmRunning do
                if ps.Stand.Value ~= "None" then break end; _task.wait(0.08)
            end
            local newStand = ps.Stand.Value
            if newStand ~= "None" and farmMethod ~= "Rib Cage" then
                local newRokaCount = sfCountItem("Rokakaka")
                if newRokaCount > 0 then
                    local result = sfCheckStandResult(newStand, sfCheckShiny())
                    if result == "continue" then
                        sfNotify("Got stand from arrow, using roka immediately...")
                        local rokaOk = sfUseRoka()
                        if rokaOk then
                            local t2 = tick()
                            while tick() - t2 < 1.5 and standFarmRunning do
                                if ps.Stand.Value == "None" then break end; _task.wait(0.08)
                            end
                        end
                    end
                end
            end
            return standFarmRunning
        else
            sfNotify("Arrow failed - will try to farm items...")
        end
    end
    return true
end

local function sfFarmItemLoop(itemName, targetCount, maxCount)
    local collected = 0
    local batchStart = tick()
    while collected < targetCount and tick() - batchStart < 30 and standFarmRunning do
        if not standFarmRunning then break end
        local spawns = Workspace:FindFirstChild("Item_Spawns") and Workspace.Item_Spawns:FindFirstChild("Items")
        if not spawns then _task.wait(0.5) continue end
        local found = nil
        local minDist = math.huge
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then _task.wait(0.5) continue end
        for _, v in pairs(spawns:GetChildren()) do
            local prox = v:FindFirstChild("ProximityPrompt")
            local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChild("Part")
            if prox and part and part.Transparency < 1 and prox.ObjectText == itemName then
                local d = (part.Position - hrp.Position).Magnitude
                if d < minDist then minDist = d; found = v end
            end
        end
        if not found then
            if tick() - batchStart > 3 and collected >= 1 then break end; _task.wait(0.5)
            continue
        end
        local itemPart = found:FindFirstChildOfClass("MeshPart") or found:FindFirstChild("Part")
        local proxPrompt = found:FindFirstChild("ProximityPrompt")
        if not itemPart or not proxPrompt then _task.wait(0.2) continue end
        local countBefore = sfCountItem(itemName)
        sfNotify("Farming " .. itemName .. " (" .. countBefore .. ")")
        local originalMethod = getgenv().InstantMethod
        if getgenv().InstantMethod == "Down" then
            getgenv().InstantMethod = "Up"
            cleanupItemStick()
        end
        if instantPickup then
            instantTravelTo(itemPart); _task.wait(0.1)
            checkAndSellMax()
            activatePrompt(proxPrompt, 0, true)
        else
            travelToInstant(itemPart); _task.wait(0.15)
            checkAndSellMax()
            activatePrompt(proxPrompt, 4, true); _task.wait(0.1)
            if found:IsDescendantOf(game.Workspace) then
                activatePrompt(proxPrompt, 4, true)
            end
        end
        if originalMethod == "Down" then
            getgenv().InstantMethod = "Down"
        end
        checkAndSellMax(); _task.wait(0.2)
        local countAfter = sfCountItem(itemName)
        if countAfter > countBefore then
            collected = collected + (countAfter - countBefore)
        end
    end
    return collected
end

local function sfHandleItemFarm(hasAnyStand, rokaCount, ribCount, arrowCount, maxArrows, maxRokas, maxRibs)
    local maxRibsVal = maxLimits["Rib Cage of The Saint's Corpse"] or 10
    local needArrow = farmMethod ~= "Lucky Arrow" and arrowCount < maxArrows
    local needRoka = (farmMethod == "Arrow" or farmMethod == "Lucky Arrow") and rokaCount < maxRokas
    local needRib = farmMethod == "Rib Cage" and sfCountItem("Rib Cage of The Saint's Corpse") < maxRibsVal
    local needLucky = farmMethod == "Lucky Arrow" and sfCountItem("Lucky Arrow") < 1
    if not needRoka and not needRib and not needArrow and not needLucky then return end
    local itemName = nil
    -- Priority: Lucky Arrow > specific needs > fallback
    if farmMethod == "Lucky Arrow" and not hasAnyStand and needLucky then
        itemName = "Lucky Arrow"
    elseif farmMethod ~= "Lucky Arrow" and not hasAnyStand and arrowCount == 0 then
        itemName = "Mysterious Arrow"
    elseif hasAnyStand and needRib then
        itemName = "Rib Cage of The Saint's Corpse"
    elseif hasAnyStand and needRoka then
        itemName = "Rokakaka"
    elseif farmMethod ~= "Lucky Arrow" and not hasAnyStand and needArrow then
        itemName = "Mysterious Arrow"
    end
    if not itemName then
        if farmMethod == "Arrow" then
            itemName = rokaCount == 0 and "Rokakaka" or "Mysterious Arrow"
        elseif farmMethod == "Lucky Arrow" then
            itemName = rokaCount == 0 and "Rokakaka" or "Lucky Arrow"
        else
            itemName = "Rib Cage of The Saint's Corpse"
        end
    end
    sfNotify("Farming: " .. itemName)
    standEnableNoclip()
    local currentCount = sfCountItem(itemName)
    local maxCount = itemName == "Rokakaka" and maxRokas or (itemName == "Rib Cage of The Saint's Corpse" and maxRibsVal or (itemName == "Lucky Arrow" and sfGetMax("Lucky Arrow") or maxArrows))
    local targetCount = math.min(currentCount + 5, maxCount)
    local collected = 0
    if itemName ~= "Lucky Arrow" then
        collected = sfFarmItemLoop(itemName, targetCount - currentCount, maxCount)
    end
    -- Return to safe position after farming
    local ch2 = LP.Character
    if ch2 and ch2:FindFirstChild("HumanoidRootPart") then
        local hrp = ch2.HumanoidRootPart
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        moveCharacterTo(standFarmPosition)
    end
    if collected == 0 and sfCountItem(itemName) == 0 then
        local money = LP.PlayerStats and LP.PlayerStats.Money.Value or 0
        local re = LP.Character and LP.Character:FindFirstChild("RemoteEvent")
        if re then
            local shopItem = nil
            local itemPrice = 0
            if itemName == "Rokakaka" then
                shopItem = "1x Rokakaka"; itemPrice = 2500
            elseif itemName == "Mysterious Arrow" then
                shopItem = "1x Mysterious Arrow"; itemPrice = 750
            elseif itemName == "Lucky Arrow" then
                shopItem = "1x Lucky Arrow"; itemPrice = 75000
            end
            if shopItem and money >= itemPrice then
                local buyCount = math.min(math.floor(money / itemPrice), 5)
                sfNotify("Buying " .. buyCount .. "x " .. itemName .. " from shop...")
                for i = 1, buyCount do
                    pcall(function() re:FireServer("PurchaseShopItem",{ItemName=shopItem},1,2) end); _task.wait(0.15)
                end
            else
                _task.wait(0.2)
            end
        else
            _task.wait(0.2)
        end
    end
end

local function sfBuyMissingItem(itemName)
    local ch = LP.Character
    local re = ch and ch:FindFirstChild("RemoteEvent")
    if not re then
        return false
    end

    local shopItem, itemPrice
    if itemName == "Rokakaka" then
        shopItem, itemPrice = "1x Rokakaka", 2500
    elseif itemName == "Mysterious Arrow" then
        shopItem, itemPrice = "1x Mysterious Arrow", 750
    elseif itemName == "Lucky Arrow" then
        shopItem, itemPrice = "1x Lucky Arrow", 75000
    else
        return false
    end

    local money = LP.PlayerStats and LP.PlayerStats.Money.Value or 0
    if money < itemPrice then
        return false
    end

    local before = sfCountItem(itemName)
    local buyCount = math.min(math.floor(money / itemPrice), 5)
    sfNotify("Buying " .. buyCount .. "x " .. itemName .. " from shop...")
    for i = 1, buyCount do
        pcall(function() re:FireServer("PurchaseShopItem", {ItemName = shopItem}, 1, 2) end); _task.wait(0.15)
    end; _task.wait(0.2)
    return sfCountItem(itemName) > before
end

local function sfFocusedFarmMissingItems(getNeededItemsFn, getFocusItemsFn, duration)
    duration = duration or 30
    local finishAt = tick() + duration
    local foundAnyNeededOnMap = false
    while standFarmRunning and tick() < finishAt do
        local needed = getNeededItemsFn()
        if #needed == 0 then
            needed = getFocusItemsFn and getFocusItemsFn() or needed
            if #needed == 0 then
                _task.wait(0.1)
                continue
            end
        end

        local foundItem = false
        local spawns = Workspace:FindFirstChild("Item_Spawns") and Workspace.Item_Spawns:FindFirstChild("Items")
        local myHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")

        if spawns and myHrp then
            local nearest = nil
            local minDist = math.huge

            for _, v in pairs(spawns:GetChildren()) do
                local prox = v:FindFirstChild("ProximityPrompt")
                local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChild("Part")
                if prox and part and part.Transparency < 1 then
                    local objName = prox.ObjectText
                    local isNeeded = false
                    for _, n in ipairs(needed) do
                        if objName == n then
                            isNeeded = true
                            break
                        end
                    end
                    if isNeeded then
                        local d = (part.Position - myHrp.Position).Magnitude
                        if d < minDist then
                            minDist = d
                            nearest = v
                        end
                    end
                end
            end

            if nearest then
                foundItem = true
                foundAnyNeededOnMap = true
                collectItemLikeNormalFarm(nearest)
            end
        end

        if not foundItem then
            moveCharacterTo(getRandomFarmRoamCFrame()); _task.wait(0.1)
        end
    end

    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if standFarmRunning and hrp then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        moveCharacterTo(standFarmPosition)
    end
    return foundAnyNeededOnMap
end

local function standFarmLoop() _task.wait(0.15)
    teleportToSafePos(); _task.wait(0.05)
    if standFarmRespawnConn then standFarmRespawnConn:Disconnect() end
    standFarmRespawnConn = LP.CharacterAdded:Connect(function(newChar) _task.wait(0.05)
        local hrp = newChar:WaitForChild("HumanoidRootPart", 3)
        if hrp and standFarmRunning then
            moveCharacterTo(standFarmPosition)
        end
    end)
    local loopStartTime = tick()
    local iterationCount = 0
    while standFarmRunning do
        iterationCount = iterationCount + 1
        if iterationCount > 100000 then
            warn("[Farm] standFarmLoop: Max iterations reached, stopping")
            standFarmRunning = false
            standDisableNoclip()
            break
        end
        if tick() - loopStartTime > 7200 then
            warn("[Farm] standFarmLoop: Max loop time reached, restarting")
            standFarmRunning = false
            standDisableNoclip(); _task.wait(1)
            if getgenv().YBAItemFarm and getgenv().YBAItemFarm.startStandFarm then
                getgenv().YBAItemFarm.startStandFarm()
            end
            return
        end; _task.wait()
        local char = LP.Character
        if not char then
            local newChar = LP.CharacterAdded:Wait(); _task.wait(0.08)
            char = newChar or LP.Character
        end
        if not char then _task.wait(0.1) continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then
            sfNotify("Character dead, waiting for respawn...")
            local newChar = LP.CharacterAdded:Wait(); _task.wait(0.05)
            if standFarmRunning and newChar then
                local newHrp = newChar:WaitForChild("HumanoidRootPart", 3)
                if newHrp then moveCharacterTo(standFarmPosition) end
            end
            continue
        end
        if not char:FindFirstChild("RemoteFunction") then
            char:WaitForChild("RemoteFunction", 0.5)
            if not char:FindFirstChild("RemoteFunction") then continue end
        end
        local ps = LP:FindFirstChild("PlayerStats")
        if not ps then ps = LP:WaitForChild("PlayerStats", 1) end
        if not ps or not ps:FindFirstChild("Stand") then continue end
        if not char:FindFirstChild("WorthinessLearned") then
            sfLearnWorthiness()
            local m = Instance.new("BoolValue"); m.Name = "WorthinessLearned"; m.Value = true; m.Parent = char
        end
        local currentStand = ps.Stand.Value
        local hasAnyStand = currentStand ~= "None"
        if hasAnyStand then
            local currentShiny = sfCheckShiny()
            local result = sfCheckStandResult(currentStand, currentShiny)
            if result == "stop" then
                standFarmRunning = false
                if standFarmRespawnConn then standFarmRespawnConn:Disconnect() end
                standFarmRespawnConn = nil
                standDisableNoclip()
                break
            end
        end
        local arrowCount = sfCountItem("Mysterious Arrow")
        local rokaCount = sfCountItem("Rokakaka")
        local ribCount = sfCountItem("Rib Cage of The Saint's Corpse")
        local maxArrows = sfGetMax("Mysterious Arrow")
        local maxRokas = sfGetMax("Rokakaka")
        local maxRibs = maxLimits["Rib Cage of The Saint's Corpse"] or 10
        local cont = sfUseResetItem(hasAnyStand, rokaCount, ribCount, arrowCount, maxArrows, maxRokas, maxRibs, ps)
        if not cont then
            standDisableNoclip()
            return
        end
        local newRokaCount = sfCountItem("Rokakaka")
        local newArrowCount = sfCountItem("Mysterious Arrow")
        local newRibCount = sfCountItem("Rib Cage of The Saint's Corpse")
        local newStand = ps.Stand.Value
        local hasItemsForNextAction = false
        if farmMethod == "Rib Cage" then
            if newStand ~= "None" and newRibCount > 0 then hasItemsForNextAction = true end
            if newStand == "None" and newArrowCount > 0 then hasItemsForNextAction = true end
        elseif farmMethod == "Lucky Arrow" then
            if newStand ~= "None" and newRokaCount > 0 then hasItemsForNextAction = true end
            if newStand == "None" and sfCountItem("Lucky Arrow") > 0 then hasItemsForNextAction = true end
        else
            if newStand ~= "None" and newRokaCount > 0 then hasItemsForNextAction = true end
            if newStand == "None" and newArrowCount > 0 then hasItemsForNextAction = true end
        end
        if hasItemsForNextAction then
            continue
        end

        local function sfGetNeededItems()
            local needed = {}
            local st = ps.Stand.Value
            local haveArrow = sfCountItem("Mysterious Arrow")
            local haveRoka = sfCountItem("Rokakaka")
            local haveRib = sfCountItem("Rib Cage of The Saint's Corpse")
            if farmMethod == "Arrow" then
                if haveRoka < 1 then table.insert(needed, "Rokakaka") end
                if haveArrow < 1 then table.insert(needed, "Mysterious Arrow") end
            elseif farmMethod == "Lucky Arrow" then
                if haveRoka < 1 then table.insert(needed, "Rokakaka") end
            elseif farmMethod == "Rib Cage" then
                if haveRib < 1 then table.insert(needed, "Rib Cage of The Saint's Corpse") end
                if st == "None" and haveArrow < 1 then table.insert(needed, "Mysterious Arrow") end
            end
            return needed
        end

        local function sfGetFocusItems()
            if farmMethod == "Arrow" then
                return {"Rokakaka", "Mysterious Arrow"}
            elseif farmMethod == "Lucky Arrow" then
                return {"Rokakaka"}
            elseif farmMethod == "Rib Cage" then
                if ps.Stand.Value == "None" then
                    return {"Rib Cage of The Saint's Corpse", "Mysterious Arrow"}
                end
                return {"Rib Cage of The Saint's Corpse"}
            end
            return {}
        end

        if farmMethod == "Lucky Arrow" and sfCountItem("Lucky Arrow") == 0 then
            local money = LP.PlayerStats and LP.PlayerStats.Money.Value or 0
            if money >= 75000 then
                local re = LP.Character and LP.Character:FindFirstChild("RemoteEvent")
                if re then
                    local buyCount = math.min(math.floor(money / 75000), 25)
                    sfNotify("Buying " .. buyCount .. "x Lucky Arrow from shop...")
                    for i = 1, buyCount do
                        pcall(function() re:FireServer("PurchaseShopItem",{ItemName="1x Lucky Arrow"},1,2) end); _task.wait(0.15)
                    end; _task.wait(0.2)
                    if sfCountItem("Lucky Arrow") == 0 then
                        sfNotify("Lucky Arrow purchase failed - stopping farm.")
                        standFarmRunning = false
                        standDisableNoclip()
                        return
                    end
                else
                    sfNotify("RemoteEvent not found for Lucky Arrow purchase - stopping farm.")
                    standFarmRunning = false
                    standDisableNoclip()
                    return
                end
            else
                sfNotify("Not enough money for Lucky Arrow (need 75000, have " .. money .. ")! Farm paused.")
                standFarmRunning = false
                standDisableNoclip()
                return
            end
        end

        local foundNeededOnMap = true
        if #sfGetNeededItems() > 0 then
            foundNeededOnMap = sfFocusedFarmMissingItems(sfGetNeededItems, sfGetFocusItems, 30)
        end

        local stillNeeded = sfGetNeededItems()
        if #stillNeeded > 0 then
            if not foundNeededOnMap then
                for _, itemName in ipairs(stillNeeded) do
                    sfBuyMissingItem(itemName)
                end
            else
                sfHandleItemFarm(newStand ~= "None", newRokaCount, newRibCount, newArrowCount, maxArrows, maxRokas, maxRibs)
            end
        end
    end
    standDisableNoclip()
end

-- Rib Farm
local function ribFarmLoop()
    -- Use unified noclip system
    local function enableNoclipRib() enableNoclipState("rib") end
    local function disableNoclipRib() disableNoclipState("rib") end; _task.wait(0.15)
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        moveCharacterTo(standFarmPosition)
    end; _task.wait(0.1)

    if ribFarmRespawnConn then ribFarmRespawnConn:Disconnect() end
    ribFarmRespawnConn = LP.CharacterAdded:Connect(function(newChar) _task.wait(0.1)
        local newHrp = newChar:WaitForChild("HumanoidRootPart", 10)
        if newHrp and ribFarmRunning then
            moveCharacterTo(standFarmPosition)
        end
    end)

    local loopStartTime = tick()
    local maxLoopTime = 7200
    local iterationCount = 0
    local maxIterations = 100000

    while ribFarmRunning do
        iterationCount = iterationCount + 1
        if iterationCount > maxIterations then
            warn("[Farm] ribFarmLoop: Max iterations reached, stopping")
            ribFarmRunning = false
            disableNoclipRib()
            break
        end
        if tick() - loopStartTime > maxLoopTime then
            warn("[Farm] ribFarmLoop: Max loop time reached, restarting")
            ribFarmRunning = false
            disableNoclipRib(); _task.wait(1)
            if getgenv().YBAItemFarm and getgenv().YBAItemFarm.startRibFarm then
                getgenv().YBAItemFarm.startRibFarm()
            end
            return
        end; _task.wait()
        local char = LP.Character

        -- Handle respawn wait
        if not char then
            local newChar = LP.CharacterAdded:Wait(); _task.wait(0.5)
            char = newChar or LP.Character
        end

        if not char then _task.wait(0.5) continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then
            _task.wait(0.5)
            continue
        end

        -- Farm Rib Cage if needed
        if sfCountItem("Rib Cage of The Saint's Corpse") == 0 then
            local spawnedBack = false
            local spawns = Workspace:FindFirstChild("Item_Spawns") and Workspace.Item_Spawns:FindFirstChild("Items")
            if spawns then
                for _, v in pairs(spawns:GetChildren()) do
                    local prox = v:FindFirstChild("ProximityPrompt")
                    local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChild("Part")
                    if prox and part and prox.ObjectText == "Rib Cage of The Saint's Corpse" and part.Transparency < 1 then
                        local originalMethod = getgenv().InstantMethod
                        if getgenv().InstantMethod == "Down" then
                            getgenv().InstantMethod = "Up"
                            cleanupItemStick()
                        end
                        if instantPickup then
                            instantTravelTo(part); _task.wait(0.1)
                            activatePrompt(prox, 0, true)
                        else
                            travelToInstant(part)
                            activatePrompt(prox, 4, true); _task.wait(0.1)
                            if v:IsDescendantOf(game.Workspace) then
                                activatePrompt(prox, 4, true)
                            end
                        end
                        if originalMethod == "Down" then
                            getgenv().InstantMethod = "Down"
                        end; _task.wait(0.2)
                        spawnedBack = true
                    end
                end
            end
            -- Teleport back to safe position after farming ribs
            if spawnedBack then
                _task.wait(0.1)
                local ribHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if ribHrp then
                    moveCharacterTo(standFarmPosition)
                    ribHrp.AssemblyLinearVelocity = Vector3.zero
                end; _task.wait(0.1)
            end
        end

        -- Check current stand
        local ps = LP:FindFirstChild("PlayerStats")
        if not ps or not ps:FindFirstChild("Stand") then _task.wait(0.5) continue end
        local cs = ps.Stand.Value
        local csh = cs ~= "None" and sfCheckShiny() or "None"
        local isShiny = csh ~= "None" and csh ~= ""

        if cs == "None" then
            local ribCount = sfCountItem("Rib Cage of The Saint's Corpse")
            if ribCount > 0 then
                sfLearnWorthiness()
                sfUseRib(); _task.wait(0.15)
            else
                continue
            end
        else
        
        -- If we have a stand
            local isTarget = sfFindTable(standFarmTarget, cs)
            
            -- Got target stand
            if isTarget then
                if isShiny then
                    sfNotify("Got target shiny stand: " .. cs .. " [" .. csh .. "]!")
                    playShinyNotificationSound()
                else
                    sfNotify("Got target stand: " .. cs)
                end
                ribFarmRunning = false
                if ribFarmRespawnConn then ribFarmRespawnConn:Disconnect() end
                ribFarmRespawnConn = nil
                break
            end
            
            -- Got shiny but not target
            if keepAnyShiny and isShiny then
                sfNotify("✨ Got shiny stand: " .. cs .. " [" .. csh .. "]! Keeping it.")
                playShinyNotificationSound()
                ribFarmRunning = false
                if ribFarmRespawnConn then ribFarmRespawnConn:Disconnect() end
                ribFarmRespawnConn = nil
                break
            end
            
            -- Have stand but not target/shiny - need to reset
            -- But first check if we have rib to use
            local ribCount = sfCountItem("Rib Cage of The Saint's Corpse")
            if ribCount > 0 then
                sfLearnWorthiness()
                sfUseRib(); _task.wait(0.15)
            else
                -- No ribs, go farm them
                continue
            end
        end

        local ps2 = LP:FindFirstChild("PlayerStats")
        repeat _task.wait() until (ps2 and ps2:FindFirstChild("Stand") and ps2.Stand.Value ~= "None") or not ribFarmRunning
        _task.wait(0.15)
    end
    if ribFarmRespawnConn then ribFarmRespawnConn:Disconnect() end
    ribFarmRespawnConn = nil
end

-- Shiny Farm
local function shinyFarmLoop()
    -- Use unified noclip system
    local function enableNoclipShiny() enableNoclipState("shiny") end
    local function disableNoclipShiny() disableNoclipState("shiny") end; _task.wait(0.15)
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        moveCharacterTo(standFarmPosition)
    end; _task.wait(0.1)

    if shinyFarmRespawnConn then shinyFarmRespawnConn:Disconnect() end
    shinyFarmRespawnConn = LP.CharacterAdded:Connect(function(newChar) _task.wait(0.1)
        local newHrp = newChar:WaitForChild("HumanoidRootPart", 10)
        if newHrp and shinyFarmRunning then
            moveCharacterTo(standFarmPosition)
        end
    end)

    local loopStartTime = tick()
    local maxLoopTime = 7200
    local iterationCount = 0
    local maxIterations = 100000

    while shinyFarmRunning do
        iterationCount = iterationCount + 1
        if iterationCount > maxIterations then
            warn("[Farm] shinyFarmLoop: Max iterations reached, stopping")
            shinyFarmRunning = false
            disableNoclipShiny()
            break
        end
        if tick() - loopStartTime > maxLoopTime then
            warn("[Farm] shinyFarmLoop: Max loop time reached, restarting")
            shinyFarmRunning = false
            disableNoclipShiny(); _task.wait(1)
            if getgenv().YBAItemFarm and getgenv().YBAItemFarm.startShinyFarm then
                getgenv().YBAItemFarm.startShinyFarm()
            end
            return
        end; _task.wait(0.15)
        local char = LP.Character
        
        -- Handle respawn wait
        if not char then
            local newChar = LP.CharacterAdded:Wait(); _task.wait(0.5)
            char = newChar or LP.Character
        end
        
        if not char then _task.wait(0.5) continue end

        local ps3 = LP:FindFirstChild("PlayerStats")
        local standValue = ps3 and ps3:FindFirstChild("Stand") and ps3.Stand.Value or "None"
        
        local currentShiny = sfCheckShiny()
        if standValue ~= "None" and currentShiny ~= "None" and sfFindTable(shinyFarmTarget, currentShiny) then
            sfNotify("Got target shiny: " .. currentShiny)
            playShinyNotificationSound()
            shinyFarmRunning = false
            if shinyFarmRespawnConn then shinyFarmRespawnConn:Disconnect() end
            shinyFarmRespawnConn = nil
            break
        end
        local needArrow = sfCountItem("Mysterious Arrow") < 1
        local needRoka = sfCountItem("Rokakaka") < 1
        if needArrow or needRoka then
            if char:FindFirstChild("HumanoidRootPart") then
                local spawns = Workspace:FindFirstChild("Item_Spawns") and Workspace.Item_Spawns:FindFirstChild("Items")
                if spawns then
                    for _, v in pairs(spawns:GetChildren()) do
                        local prox = v:FindFirstChild("ProximityPrompt")
                        local part = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChild("Part")
                        local itemName = prox and prox.ObjectText
                        local shouldCollect = (needArrow and itemName == "Mysterious Arrow") or (needRoka and itemName == "Rokakaka")
                        if prox and part and part.Transparency < 1 and shouldCollect then
                            local originalMethod = getgenv().InstantMethod
                            if getgenv().InstantMethod == "Down" then
                                getgenv().InstantMethod = "Up"
                                cleanupItemStick()
                            end
                            if instantPickup then
                                instantTravelTo(part); _task.wait(0.1)
                                activatePrompt(prox, 0, true)
                            else
                                travelToInstant(part)
                                activatePrompt(prox, 4, true); _task.wait(0.1)
                                if v:IsDescendantOf(game.Workspace) then
                                    activatePrompt(prox, 4, true)
                                end
                            end
                            if originalMethod == "Down" then
                                getgenv().InstantMethod = "Down"
                            end; _task.wait(0.2)
                        end
                    end
                end
            end
        end
        if standValue ~= "None" then sfUseRoka() else sfUseArrow() end; _task.wait(0.15)
    end
    if shinyFarmRespawnConn then shinyFarmRespawnConn:Disconnect() end
    shinyFarmRespawnConn = nil
end

local function startStandFarm()
    if standFarmRunning then return end
    if #standFarmTarget == 0 and not keepAnyShiny then
        sfNotify("No stands selected - farming all stands (use Keep Any Shiny to stop on shinies)")
    end
    _G._farmDebugNotified = false -- Reset debug flag
    _G._standDebugDone = false -- Reset stand debug flag
    standFarmRunning = true; sfNotify("Stand farming started (Method: " .. farmMethod .. ")!"); _task.spawn(standFarmLoop)
end
local function stopStandFarm()
    standFarmRunning = false
    setSavedFlag("SF", false)
    CFG.StandFarmEnabled = false
    if standFarmRespawnConn then standFarmRespawnConn:Disconnect() end
    standFarmRespawnConn = nil

    -- Force disable noclip immediately when stopping
    _task.defer(standDisableNoclip)

    sfNotify("Stand farming stopped!")
end

-- Add cleanup function for external calls
getgenv().RAILhub_StandFarmCleanup = function()
    standFarmRunning = false
    if standFarmRespawnConn then standFarmRespawnConn:Disconnect() end
    standFarmRespawnConn = nil
    -- Note: noclip is cleaned up inside the loop when it exits
end
local function startRibFarm()
    if ribFarmRunning then return end
    ribFarmRunning = true; sfNotify("Rib farming started!"); _task.spawn(ribFarmLoop)
end
local function stopRibFarm()
    ribFarmRunning = false
    setSavedFlag("SF", false)
    CFG.StandFarmEnabled = false
    if ribFarmRespawnConn then ribFarmRespawnConn:Disconnect() end
    ribFarmRespawnConn = nil
    sfNotify("Rib farming stopped!")
end
local function startShinyFarm()
    if shinyFarmRunning then return end
    if #shinyFarmTarget == 0 then ybaNotify("Shiny Farm", "No shinies selected!"); return end
    shinyFarmRunning = true; sfNotify("Shiny farming started!"); _task.spawn(shinyFarmLoop)
end
local function stopShinyFarm()
    shinyFarmRunning = false
    setSavedFlag("SF", false)
    if shinyFarmRespawnConn then shinyFarmRespawnConn:Disconnect() end
    shinyFarmRespawnConn = nil
    sfNotify("Shiny farming stopped!")
end

_G.YBAItemFarm.standFarmTarget = standFarmTarget
_G.YBAItemFarm.shinyFarmTarget = shinyFarmTarget
_G.YBAItemFarm.setKeepAnyShiny = function(v) keepAnyShiny = v end
_G.YBAItemFarm.startStandFarm = startStandFarm
_G.YBAItemFarm.stopStandFarm = stopStandFarm
_G.YBAItemFarm.startRibFarm = startRibFarm
_G.YBAItemFarm.stopRibFarm = stopRibFarm
_G.YBAItemFarm.startShinyFarm = startShinyFarm
_G.YBAItemFarm.stopShinyFarm = stopShinyFarm

local allStands = {
    "Aerosmith",
    "Anubis",
    "Beach Boy",
    "Crazy Diamond",
    "Cream",
    "D4C",
    "Gold Experience",
    "Hermit Purple",
    "Hierophant Green",
    "Killer Queen",
    "King Crimson",
    "Magician's Red",
    "Mr. President",
    "Purple Haze",
    "Red Hot Chili Pepper",
    "Scary Monsters",
    "Silver Chariot",
    "Six Pistols",
    "Soft & Wet",
    "Star Platinum",
    "Sticky Fingers",
    "Stone Free",
    "The Hand",
    "The World",
    "The World Alternate Universe",
    "Tusk ACT 1",
    "White Album",
    "Whitesnake"
}

local allShinies = {
    "Action-Figure Platinum","Actually Red Hot Chili Pepper","Aerosmith Over Heaven",
    "All-Starsnake","Anti-Umbral","Asuna","Biblically Accurate Experience",
    "Blade Of The Exile","Casull","Charmy Green","Chromo","Comic Venom","Cracked World",
    "Crazy Ruby","Crazy Idol","Creeper Queen","D4She","Devil4c","Deimos Queen",
    "Deimos Snake","Eldritch Hierophant","Elizabeth Liones","Elucidator & Dark Repulser",
    "Emperor","Emperor OVA","Female The Hand","Frozone","Glock-18","Glock-18 Fade",
    "Gold Platinum","Golden Frieza","Gold & Wet","Headhunter","Heaven Spirit",
    "Tentacle Black","Tentacle Purple","Tentacle Yellow","Holly's Sickness",
    "Jade Peace","Jaguar Platinum","Kanshou & Bakuya","Kikoku","Killer Reveal",
    "King of The End","Linked Sword","Luffy Gear 4","Magellan","Magician's Red: Over Heaven",
    "Manga Crimson","Megumin","Mintsnake","Misaka Mikoto","Mr. Joestar","Ms. Aerosmith",
    "Neon Ascension","Neo World","Nerf Jolt","Nocturne","Nonosama Bo","ODM Gear",
    "OVA Silver Chariot","Old President","Pinky Fingers","Queen Crimson","Rock Unleashed",
    "Sakura","Shadow Killer Queen","Shadow The World","Sorcerer's Ember","Spider-Man",
    "Sasageyo","Star Platinum OVA","Star Striped Eagle","Star Waifu","Stone Platinum",
    "The Other Hand","The Waifu v2","The Waifu: Alternate Universe","The World: Greatest High",
    "The World 2","The World OVA","The World Ultimate","Toy Sticky Fingers","Tsunade",
    "Uber Spy","Whisper","Vanilla Ice Cream","Venom","Vinegar Crimson","Virus Vessel",
    "Jack-O-Platinum","Ghost World","Crazy Overseer","Tyrant Crimson","Jester Crimson",
    "Vexus Crimson","Pumpkin Patch","Cornsnake","Crimson Mist","Dead Experience",
    "Undead Hand","Undead Flare","Bloodthirster","Gold","Silver","Diamond","Platinum",
    "Rainbow","Crystal","Emerald","Ruby","Sapphire","Obsidian"
}

StandTab = TabGroup:Tab({ Name = "Stands", Image = "rbxassetid://98100463355335" })
standSec = StandTab:Section({ Side = "Left", Name = "Stand Farm" })
standSec:Header({ Text = "Farm stands", AutoLocalize = false })

standSec:Dropdown({
    Name = "Select Stands to Keep", Options = allStands, Multi = true, Default = {},
    Callback = function(map)
        local sel = _G.YBAItemFarm.standFarmTarget
        for i = #sel, 1, -1 do table.remove(sel, i) end
        if type(map) == "table" then
            if map[1] ~= nil then
                for _, n in ipairs(map) do
                    if type(n)=="string" then table.insert(sel, n) end
                end
            else
                for n, v in pairs(map) do
                    if v == true and type(n)=="string" then table.insert(sel, n) end
                end
            end
        end
        ybaNotify("Stand Farm", "Selected " .. #sel .. " stands: " .. table.concat(sel, ", "))
    end,
})

standSec:Toggle({
    Name = "Keep only Shiny", 
    Default = getSavedFlag("SKS", true),
    Callback = function(on) 
        keepAnyShiny = on 
        setSavedFlag("SKS", on)
    end,
})

standSec:Button({
    Name = "Skip current Shiny",
    Callback = function()
        skipCurrentShinyStand()
    end,
})

standSec:Toggle({
    Name = "Enable Farm", 
    Default = getSavedFlag("SF", false),
    Callback = function(on)
        setSavedFlag("SF", on)
        CFG.StandFarmEnabled = on
        if on then
            farmStats = { arrowsUsed = 0, rokasUsed = 0, ribsUsed = 0, luckyArrowsUsed = 0, standsGot = 0, startTime = tick() }
            if farmMethod == "Arrow" or farmMethod == "Lucky Arrow" then
                startStandFarm()
            else
                startRibFarm()
            end
        else
            stopStandFarm()
            stopRibFarm()
        end
    end,
})

-- Farm method dropdown (Arrow or Rib) with restart on change
standSec:Dropdown({
    Name = "Farm Method", 
    Options = {"Arrow", "Lucky Arrow", "Rib Cage"}, 
    Default = getSavedFlag("SFM", "Arrow"),
    Callback = function(v)
        local oldMethod = farmMethod
        farmMethod = v or "Arrow"
        setSavedFlag("SFM", farmMethod)
        -- Restart farm loop if currently farming
        if standFarmRunning or ribFarmRunning then
            local wasStandFarm = standFarmRunning
            stopStandFarm()
            stopRibFarm(); _task.wait(0.5)
            if farmMethod == "Rib Cage" then
                startRibFarm()
            else
                startStandFarm()
            end
        end
    end,
})

-- Auto-start stand farm if it was enabled before save
if CFG.StandFarmEnabled then
    _task.delay(3, function()
        warn("[YBA] Auto-starting stand farm (was enabled before save)")
        farmStats = { arrowsUsed = 0, rokasUsed = 0, ribsUsed = 0, luckyArrowsUsed = 0, standsGot = 0, startTime = tick() }
        if farmMethod == "Rib Cage" then
            startRibFarm()
        else
            startStandFarm()
        end
    end)
end

-- ============================================================
-- Stand Pilot - перенесено из yba source.lua
-- ============================================================

local pilotSec = StandTab:Section({ Side = "Right", Name = "Stand Pilot" })
pilotSec:Header({ Text = "Stand Pilot", AutoLocalize = false })

getgenv().standPilotActive = false
getgenv().pilotSpeed = 50
getgenv().PilotConfig = {
    Speed = 50,
    SpeedChangerEnabled = getSavedFlag("PSC", false),
    IsActive = false
}
local pilotConnections = {}
local standAnimController = nil

local function cleanupPilot()
    if not getgenv().PilotConfig.IsActive then return end

    -- Stop C-Moon Walk animation
    pcall(function()
        if standAnimController then
            for _, track in pairs(standAnimController:GetPlayingAnimationTracks()) do
                track:Stop(0.1)
            end
        end
    end)

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
        local character = LP.Character
        if character and character:FindFirstChild("FocusCam") then
            character.FocusCam:Destroy()
        end
    end)

    pcall(function()
        local character = LP.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end)

    pcall(function()
        local character = LP.Character
        if character and character:FindFirstChild("StandMorph") then
            local standHRP = character.StandMorph:FindFirstChild("HumanoidRootPart")
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local remoteFunc = character:FindFirstChild("RemoteFunction")
            if standHRP and hrp then
                moveCharacterTo(standHRP.CFrame)
            end
            if remoteFunc then
                remoteFunc:InvokeServer("ToggleStand", "Toggle")
            end
        end
    end)

    getgenv().PilotConfig.IsActive = false
    getgenv().standPilotActive = false
end

pilotSec:Toggle({
    Name = "Pilot Stand",
    Default = getSavedFlag("PE", false),
    Callback = function(value)
        setSavedFlag("PE", value)
        CFG.PilotEnabled = value
        local character = LP.Character
        if not character then
            ybaNotify("Stands", "Character not loaded!")
            return
        end

        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        local remoteFunc = character:FindFirstChild("RemoteFunction")

        if not hrp or not humanoid or not remoteFunc then
            ybaNotify("Stands", "Character not ready!")
            return
        end

        if getgenv().PilotConfig.IsActive then
            cleanupPilot()
            ybaNotify("Stands", "Stand Pilot disabled.")
            return
        end

        if not value then return end

        if not character:FindFirstChild("StandMorph") then
            remoteFunc:InvokeServer("ToggleStand", "Toggle")
            local waited = 0
            repeat _task.wait(0.1) waited = waited + 0.1 until character:FindFirstChild("StandMorph") or waited > 5
            if not character:FindFirstChild("StandMorph") then
                ybaNotify("Stands", "Failed to summon stand!")
                return
            end
        end

        local standMorph = character.StandMorph
        standAnimController = standMorph.AnimationController
        local standHRP = standMorph:WaitForChild("HumanoidRootPart", 3)

        if not standAnimController or not standHRP then
            ybaNotify("Stands", "Stand not properly loaded!")
            return
        end

        if getgenv().PilotConfig.SpeedChangerEnabled then
            standAnimController.WalkSpeed = getgenv().PilotConfig.Speed
        end

        getgenv().PilotConfig.IsActive = true
        getgenv().standPilotActive = true

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

        -- Load C-Moon Walk animation
        local cMoonAnim = Instance.new("Animation")
        cMoonAnim.AnimationId = "rbxassetid://5191325822"
        local cMoonTrack = nil
        
        pcall(function()
            if standAnimController then
                cMoonTrack = standAnimController:LoadAnimation(cMoonAnim)
                if cMoonTrack then
                    cMoonTrack.Priority = Enum.AnimationPriority.Action
                    cMoonTrack.Looped = true
                end
            end
        end)

        local isMoving = false
        
        table.insert(pilotConnections, humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
            if humanoid.Jump then
                standAnimController.Jump = true
            end; _task.wait()
        end))

        table.insert(pilotConnections, RunService.Heartbeat:Connect(function()
            if not character or not character.Parent then return end
            if not standMorph or not standMorph.Parent then
                pcall(function() remoteFunc:InvokeServer("ToggleStand", "Toggle") end)
                return
            end

            local moveDirection = workspace.CurrentCamera.CFrame:VectorToObjectSpace(humanoid.MoveDirection)
            standAnimController:Move(moveDirection, true)

            -- Play/Stop C-Moon Walk animation based on movement
            local isNowMoving = moveDirection.Magnitude > 0.1
            if isNowMoving and not isMoving then
                isMoving = true
                pcall(function()
                    if cMoonTrack and cMoonTrack.IsPlaying == false then
                        cMoonTrack:Play(0.2)
                    end
                end)
            elseif not isNowMoving and isMoving then
                isMoving = false
                pcall(function()
                    if cMoonTrack and cMoonTrack.IsPlaying then
                        cMoonTrack:Stop(0.2)
                    end
                end)
            end

            -- Ensure idle animation plays when standing still
            if not isNowMoving then
                pcall(function()
                    -- YBA stands have built-in idle, but let's make sure it's not blocked
                    if standAnimController and not standAnimController:IsPlaying() then
                        -- Let the default stand idle animation handle itself
                    end
                end)
            end

            if getgenv().PilotConfig.SpeedChangerEnabled then
                standAnimController.WalkSpeed = getgenv().PilotConfig.Speed
            end

            if standHRP and hrp then
                hrp.CFrame = standHRP.CFrame - Vector3.new(0, 25, 0)
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end))

        pcall(function()
            for _, v in pairs(standMorph.Parent:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("UnionOperation") then
                    game:GetService("PhysicsService"):SetPartCollisionGroup(v, "Players")
                end
            end
        end)

        ybaNotify("Stands", "Stand Pilot enabled!")
    end,
})

pilotSec:Toggle({
    Name = "Pilot Speed Changer",
    Default = getSavedFlag("PSC", false),
    Callback = function(value)
        setSavedFlag("PSC", value)
        getgenv().PilotConfig.SpeedChangerEnabled = value
        if value and standAnimController then
            standAnimController.WalkSpeed = getgenv().PilotConfig.Speed
            ybaNotify("Stands", "Speed changer " .. (value and "enabled" or "disabled"))
        end
    end,
})

pilotSec:Slider({
    Name = "Pilot Speed",
    Default = tonumber(getgenv().PilotConfig.Speed) or 50,
    Minimum = 0,
    Maximum = 200,
    DisplayMethod = "Value",
    Precision = 0,
    Callback = function(value)
        getgenv().PilotConfig.Speed = value
        if getgenv().PilotConfig.SpeedChangerEnabled and standAnimController and standAnimController.Parent then
            standAnimController.WalkSpeed = value
        end
    end,
    onInputComplete = function(value)
        ybaNotify("Stands", "Pilot speed set to: " .. value)
    end,
})

pilotSec:Toggle({
    Name = "Inf Pilot Range",
    Default = getSavedFlag("IPR", false),
    Callback = function(value)
        setSavedFlag("IPR", value)
        getgenv().infPilotRangeEnabled = value
        if value then
            ybaNotify("Stands", "Infinite Pilot Range enabled.")
            getgenv().infPilotRangeConnection = RunService.Heartbeat:Connect(function()
                pcall(function()
                    if LP.Character and LP.Character:FindFirstChild("StandMorph") then
                        local isPiloting = LP.Character.StandMorph:FindFirstChild("IsPiloting")
                        if isPiloting then
                            isPiloting.Value = 999999
                        end
                    end
                end)
            end)
        else
            ybaNotify("Stands", "Infinite Pilot Range disabled.")
            if getgenv().infPilotRangeConnection then
                getgenv().infPilotRangeConnection:Disconnect()
                getgenv().infPilotRangeConnection = nil
            end
        end
    end,
})

-- Auto-cleanup pilot on character respawn
LP.CharacterAdded:Connect(function()
    if getgenv().PilotConfig.IsActive then
        cleanupPilot()
        ybaNotify("Stands", "Stand Pilot auto-disabled (character respawned).")
    end
    if getgenv().infPilotRangeConnection then
        getgenv().infPilotRangeConnection:Disconnect()
        getgenv().infPilotRangeConnection = nil
    end
end)

pilotSec:Button({
    Name = "Force Cleanup Pilot",
    Callback = function()
        cleanupPilot()
        ybaNotify("Stands", "Pilot cleanup forced!")
    end,
})

-- ============================================================
-- Shop & Dialogues - перенесено из yba source.lua
-- ============================================================

ShopTab = TabGroup:Tab({ Name = "Shop", Image = "rbxassetid://128644648286811" })

itemsSec = ShopTab:Section({ Side = "Left", Name = "Items" })
itemsSec:Header({ Text = "Buy Items", AutoLocalize = false })

local function getChar()
    return LP.Character or LP.CharacterAdded:Wait()
end

itemsSec:Button({ Name = "Buy Rokakaka ($2,500)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Rokakaka"}, 1, 2); ybaNotify("Shop", "Bought Rokakaka") end
end})

itemsSec:Button({ Name = "Buy Pure Rokakaka ($4,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Pure Rokakaka"}, 1, 2); ybaNotify("Shop", "Bought Pure Rokakaka") end
end})

itemsSec:Button({ Name = "Buy Mysterious Arrow ($750)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Mysterious Arrow"}, 1, 2); ybaNotify("Shop", "Bought Mysterious Arrow") end
end})

itemsSec:Button({ Name = "Buy Lucky Arrow ($75,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Lucky Arrow"}, 1, 2); ybaNotify("Shop", "Bought Lucky Arrow") end
end})

itemsSec:Button({ Name = "Buy DIO's Diary ($20,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x DIO's Diary"}, 1, 2); ybaNotify("Shop", "Bought DIO's Diary") end
end})

itemsSec:Button({ Name = "Buy Rib Cage ($3,500)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Rib Cage of The Saint's Corpse"}, 1, 2); ybaNotify("Shop", "Bought Rib Cage") end
end})

itemsSec:Button({ Name = "Buy Left Arm ($15,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Left Arm of The Saint's Corpse"}, 1, 2); ybaNotify("Shop", "Bought Left Arm") end
end})

itemsSec:Button({ Name = "Buy Pelvis ($45,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Pelvis of The Saint's Corpse"}, 1, 2); ybaNotify("Shop", "Bought Pelvis") end
end})

itemsSec:Button({ Name = "Buy Heart ($45,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PurchaseShopItem", {ItemName="1x Heart of The Saint's Corpse"}, 1, 2); ybaNotify("Shop", "Bought Heart") end
end})

itemsSec:Button({ Name = "Buy Pizza ($50)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Pizza", Option="Option1", Dialogue="Dialogue2"}, 1, 2); ybaNotify("Shop", "Bought Pizza") end
end})

itemsSec:Button({ Name = "Buy Tea ($50)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Cafe", Option="Option1", Dialogue="Dialogue2"}, 1, 2); ybaNotify("Shop", "Bought Tea") end
end})

local specsSec = ShopTab:Section({ Side = "Right", Name = "Fighting Styles" })
specsSec:Header({ Text = "Buy Fighting Styles", AutoLocalize = false })

specsSec:Button({ Name = "Buy Hamon ($15,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Jonathan", Option="Option1", Dialogue="Dialogue5"}); ybaNotify("Shop", "Bought Hamon") end
end})

specsSec:Button({ Name = "Buy Boxing ($10,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Quinton", Option="Option1", Dialogue="Dialogue5"}); ybaNotify("Shop", "Bought Boxing") end
end})

specsSec:Button({ Name = "Buy Spin ($10,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Gyro", Option="Option1", Dialogue="Dialogue5"}); ybaNotify("Shop", "Bought Spin") end
end})

specsSec:Button({ Name = "Buy Vampire ($10,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Elder Vampire Roomy", Option="Option1", Dialogue="Dialogue5"}); ybaNotify("Shop", "Bought Vampire") end
end})

specsSec:Button({ Name = "Buy Pluck ($10,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Uzurashi", Option="Option1", Dialogue="Dialogue5"}); ybaNotify("Shop", "Bought Pluck") end
end})

specsSec:Button({ Name = "Buy Boxing Gloves ($1,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Boxing Gloves", Option="Option1", Dialogue="Dialogue1"}); ybaNotify("Shop", "Bought Boxing Gloves") end
end})

specsSec:Button({ Name = "Buy Sword ($1,000)", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("EndDialogue", {NPC="Pluck", Option="Option1", Dialogue="Dialogue1"}); ybaNotify("Shop", "Bought Sword") end
end})

local dialoguesSec = ShopTab:Section({ Side = "Right", Name = "Dialogues" })
dialoguesSec:Header({ Text = "Open Dialogues", AutoLocalize = false })

dialoguesSec:Button({ Name = "Halloween Event Dialogue", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue:FindFirstChild("Halloween Event")); ybaNotify("Shop", "Opened Halloween Shop") end
end})

dialoguesSec:Button({ Name = "Jesus Dialogue", Callback = function()
    local re = getChar():FindFirstChild("RemoteEvent")
    if re then re:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue.Jesus); ybaNotify("Shop", "Opened Jesus Dialogue") end
end})

-- Apply menu header image tweaks
local function applyMenuHeaderTweaks()
    local root = (gethui and gethui()) or game:GetService("CoreGui")
    local settings = Window and Window.Settings
    local titleText = (settings and settings.Title) or "RAIL|hub"
    local subtitleText = (settings and settings.Subtitle) or "YBA"
    local titleLabel
    
    for _, gui in ipairs(root:GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, d in ipairs(gui:GetDescendants()) do
                if d:IsA("TextLabel") and d.Text == titleText then
                    titleLabel = d
                    break
                end
            end
        end
        if titleLabel then break end
    end
    
    if not titleLabel then return false end
    
    local parent = titleLabel.Parent
    if not parent or not parent:IsA("GuiObject") then return false end
    
    local padding = parent:FindFirstChild("MenuHeaderPadding")
    if not padding then
        padding = Instance.new("UIPadding")
        padding.Name = "MenuHeaderPadding"
        padding.Parent = parent
    end
    padding.PaddingLeft = UDim.new(0, 40)
    
    titleLabel.AnchorPoint = Vector2.new(0, 0)
    titleLabel.TextSize = math.max(16, titleLabel.TextSize or 0)
    titleLabel:SetAttribute("WaveRawText", titleLabel.Text)
    
    local function ensureOffsets(lbl)
        if lbl:GetAttribute("MenuOffsetX") == nil then
            local pAbs = parent.AbsolutePosition
            local abs = lbl.AbsolutePosition
            lbl:SetAttribute("MenuOffsetX", math.floor(abs.X - pAbs.X + 0.5))
            lbl:SetAttribute("MenuOffsetY", math.floor(abs.Y - pAbs.Y + 0.5))
        end
        local x = lbl:GetAttribute("MenuOffsetX") or lbl.Position.X.Offset
        local y = lbl:GetAttribute("MenuOffsetY") or lbl.Position.Y.Offset
        lbl.Position = UDim2.new(0, x, 0, y)
    end
    ensureOffsets(titleLabel)
    
    for _, d in ipairs(parent:GetChildren()) do
        if d:IsA("TextLabel") and d.Text == subtitleText then
            d.AnchorPoint = Vector2.new(0, 0)
            ensureOffsets(d)
            break
        end
    end
    
    local imageName = "MenuLeftImage"
    local function findInfoHolder(root2)
        if not root2 then return end
        local base = root2:FindFirstChild("Base", true)
        local sidebar = base and base:FindFirstChild("Sidebar", true)
        local info = sidebar and sidebar:FindFirstChild("Information", true)
        local holder = info and info:FindFirstChild("InformationHolder", true)
        if holder then return holder end
        for _, d in ipairs(root2:GetDescendants()) do
            if d:IsA("Frame") and d.Name == "InformationHolder" then
                return d
            end
        end
    end
    
    local guiRoot = titleLabel:FindFirstAncestorWhichIsA("ScreenGui") or game:GetService("CoreGui")
    local infoHolder = findInfoHolder(guiRoot)
    
    local old = parent:FindFirstChild(imageName)
    if old then old:Destroy() end
    if infoHolder then
        old = infoHolder:FindFirstChild(imageName)
        if old then old:Destroy() end
    end
    
    local image = Instance.new("ImageLabel")
    image.Name = imageName
    image.BackgroundTransparency = 1
    image.Size = UDim2.new(0, 40, 0, 40)
    image.ScaleType = Enum.ScaleType.Crop
    image.ZIndex = titleLabel.ZIndex
    local corner = Instance.new("UICorner")
    corner.Parent = image
    image.Image = (getgenv()._YBA_resolveMenuHeaderImage and getgenv()._YBA_resolveMenuHeaderImage()) or ""
    image.AnchorPoint = Vector2.new(0, 0)
    
    if infoHolder then
        image.Parent = infoHolder
        image.Position = UDim2.new(0, -10, 1, -40)
    else
        image.Parent = titleLabel
        image.Position = UDim2.new(0, -50, 1, -12)
    end
    
    return true
end; _task.spawn(function()
    for _ = 1, 40 do
        if applyMenuHeaderTweaks() then return end; _task.wait(0.2)
    end
end)

-- Player Tab with BlockBot
PlayerTab = TabGroup:Tab({ Name = "Player", Image = "rbxassetid://80347609368420" })
blockBotSec = PlayerTab:Section({ Side = "Left", Name = "Block Bot" })
blockBotSettingsSec = PlayerTab:Section({ Side = "Right", Name = "Settings" })
blockBotSettingsSec:Header({ Text = "Movement", AutoLocalize = false })
getgenv().PlayerMoveCfg = getgenv().PlayerMoveCfg or {
    Speed = getSavedFlag("PMS", false),
    WalkSpeed = getSavedFlag("PWS", 35),
    JumpPower = getSavedFlag("PJP", 50),
    Fly = getSavedFlag("PFLY", false),
    FlySpeed = getSavedFlag("PFS", 75)
}
moveLoop = moveLoop or RunService.Heartbeat:Connect(function()
    local cfg = getgenv().PlayerMoveCfg
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hum then
        hum.UseJumpPower = true
    end
    if not hum or not hrp then
        return
    end
    if cfg.Fly then
        local cam = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame or hrp.CFrame
        local look = cam.LookVector
        local right = cam.RightVector
        local up = cam.UpVector
        local dir = Vector3.zero
        if look.Magnitude > 0 then look = look.Unit end
        if right.Magnitude > 0 then right = right.Unit end
        if up.Magnitude > 0 then up = up.Unit end
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += look end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= look end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += right end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= right end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += up end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= up end
        if dir.Magnitude > 0 then dir = dir.Unit * cfg.FlySpeed end
        hrp.AssemblyLinearVelocity = dir
        hum:ChangeState(Enum.HumanoidStateType.Freefall)
    elseif cfg.Speed and hum.MoveDirection.Magnitude > 0 then
        local dir = hum.MoveDirection.Unit * cfg.WalkSpeed
        hrp.AssemblyLinearVelocity = Vector3.new(dir.X, hrp.AssemblyLinearVelocity.Y, dir.Z)
    end
end)
blockBotSettingsSec:Toggle({
    Name = "Speed Changer",
    Default = getSavedFlag("PMS", false),
    Callback = function(v)
        getgenv().PlayerMoveCfg.Speed = v
        setSavedFlag("PMS", v)
    end,
})
blockBotSettingsSec:Slider({
    Name = "WalkSpeed",
    Default = getgenv().PlayerMoveCfg.WalkSpeed,
    Minimum = 0,
    Maximum = 200,
    DisplayMethod = "Value",
    Precision = 0,
    Callback = function(v)
        getgenv().PlayerMoveCfg.WalkSpeed = math.max(0, v)
        setSavedFlag("PWS", getgenv().PlayerMoveCfg.WalkSpeed)
    end,
    onInputComplete = function(v)
        ybaNotify("Player", "WalkSpeed: " .. v)
    end,
})
blockBotSettingsSec:Slider({
    Name = "JumpPower",
    Default = getgenv().PlayerMoveCfg.JumpPower,
    Minimum = 0,
    Maximum = 200,
    DisplayMethod = "Value",
    Precision = 0,
    Callback = function(v)
        getgenv().PlayerMoveCfg.JumpPower = math.max(0, v)
        setSavedFlag("PJP", getgenv().PlayerMoveCfg.JumpPower)
    end,
    onInputComplete = function(v)
        ybaNotify("Player", "JumpPower: " .. v)
    end,
})
blockBotSettingsSec:Toggle({
    Name = "Fly",
    Default = getSavedFlag("PFLY", false),
    Callback = function(v)
        getgenv().PlayerMoveCfg.Fly = v
        setSavedFlag("PFLY", v)
    end,
})
blockBotSettingsSec:Slider({
    Name = "Fly Speed",
    Default = getgenv().PlayerMoveCfg.FlySpeed,
    Minimum = 0,
    Maximum = 300,
    DisplayMethod = "Value",
    Precision = 0,
    Callback = function(v)
        getgenv().PlayerMoveCfg.FlySpeed = math.max(0, v)
        setSavedFlag("PFS", getgenv().PlayerMoveCfg.FlySpeed)
    end,
    onInputComplete = function(v)
ybaNotify("Player", "Fly Speed: " .. v)
    end,
})

-- Noclip Toggle
blockBotSettingsSec:Toggle({
    Name = "Noclip",
    Default = getSavedFlag("PNC", false),
    Callback = function(v)
        setSavedFlag("PNC", v)
        if v then
            _G.YBAItemFarm.enableNoclip()
        else
            _G.YBAItemFarm.disableNoclip()
        end
    end,
})

-- JumpBoost: обходной метод без прямого изменения JumpPower
local jumpBoostConn = nil
local function connectJumpBoost(char)
    if jumpBoostConn then jumpBoostConn:Disconnect() end
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end
    jumpBoostConn = hum:GetPropertyChangedSignal("Jump"):Connect(function()
        if hum.Jump then
            local cfg = getgenv().PlayerMoveCfg
            if cfg.JumpPower and cfg.JumpPower ~= 50 then
                RunService.RenderStepped:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, cfg.JumpPower, hrp.AssemblyLinearVelocity.Z)
                end
            end
        end
    end)
end
LP.CharacterAdded:Connect(connectJumpBoost)
if LP.Character then connectJumpBoost(LP.Character) end

-- Auto-apply noclip if was saved
if getSavedFlag("PNC", false) then
    _task.delay(1, function() _G.YBAItemFarm.enableNoclip() end)
end

do
-- BlockBot scope - all variables isolated in this block

blockBotSec:Header({ Text = "Block Bot", AutoLocalize = false })

-- BlockBot Variables
blockbot = false
reblocking = true
keepblock = false
projectiles_priority = false
unblocking = true
coliseumenabled = false
lboverriding = true
blockprocsuntil = 0
lastblock = 0
blockactions = false
blocked = false
lastboi = nil
lastbad = ""
lastbb = tick()

end

do
-- BlockBot Data Tables
blocks_perfect = {
    {"rbxassetid://7217913060", {def = 0.2}},
    "rbxassetid://4725629903",
    "rbxassetid://6032844827",
    "rbxassetid://163619849",
    {"rbxassetid://7217914447", {def = 0, chckfunc = function(p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if stand then
            local name = stand:FindFirstChild("Stand Name")
            return name and name.Value == "Star Platinum"
        end
        return false
    end}},
    {"rbxassetid://7217914447", {def = 0, chckfunc = function(p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if stand then
            local name = stand:FindFirstChild("Stand Name")
            return name and name.Value ~= "Star Platinum"
        end
        return false
    end}},
}

blocks_base = {
    {"rbxassetid://6032836072", {def = 0.3}},
    "rbxassetid://6034138660",
    {"rbxassetid://10459370874", {def = 0.35, addw = -0.35, dist = 15}},
    {"rbxassetid://12440326715", {addw = -0.1, dist = 15}},
    {"rbxassetid://74034132845527", {def = 0.4}},
}

blocks_UNBLOCK = {
    "rbxassetid://11876873350",
}

blocksanim_perfect = {
    {"rbxassetid://6048575522", {def = 0, chckfunc = function(_, p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if stand then
            local name = stand:FindFirstChild("Stand Name")
            return name and name.Value == "Star Platinum"
        end
        return false
    end}},
    {"rbxassetid://6048575522", {def = 0, chckfunc = function(_, p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if stand then
            local name = stand:FindFirstChild("Stand Name")
            return name and name.Value ~= "Star Platinum"
        end
        return false
    end}},
    {"rbxassetid://4211804997", {def = 0.3, chckfunc = function(_, p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if stand then
            local name = stand:FindFirstChild("Stand Name")
            return name and name.Value ~= "Tusk ACT 4"
        end
        return false
    end}},
    {"rbxassetid://13899360363", {def = 0.4}},
    {"rbxassetid://7189005773", {def = 0.3}},
    {"rbxassetid://6835249882", {def = 0.4}},
    {"rbxassetid://11886825775", {def = 0.3}},
    {"rbxassetid://4879759800", {def = 0.4}},
    {"rbxassetid://4825999731", {def = 0.5, dist = 160, chckfunc = function() return coliseumenabled end}},
    "rbxassetid://6704817082",
    "rbxassetid://6049426097",
    {"rbxassetid://6105486059", {}},
    {"rbxassetid://5303743107", {}},
    {"rbxassetid://7250792726", {def = 0.4}},
    "rbxassetid://4812642386",
    {"rbxassetid://6216052429", {def = 0.3, chckfunc = function(a) _task.wait(); return a.Speed > 1.39 end}},
    {"rbxassetid://6216052429", {}},
    {"rbxassetid://4096014941", {def = 0.4, chckfunc = function(a) _task.wait(); return a.Speed > 1.049 and a.Speed < 1.051 end}},
    {"rbxassetid://4096014941", {def = 0.4, chckfunc = function(a) return a.Speed > 1.074 and a.Speed < 1.076 end}},
    {"rbxassetid://4096014941", {def = 0.4, chckfunc = function(a, p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if stand then
            local name = stand:FindFirstChild("Stand Name")
            if name and name.Value == "Magician's Red" then return a.Speed == 1 end
        end
        return false
    end}},
    {"rbxassetid://4096014941", {def = 0.4, chckfunc = function(_, p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if stand then
            local name = stand:FindFirstChild("Stand Name")
            return name and name.Value == "Gold Experience"
        end
        return false
    end}},
    {"rbxassetid://4096014941", {def = 0.3, dist = 75, chckfunc = function(_, p)
        local stand = p.Parent:FindFirstChild("StandMorph")
        if not stand then return false end
        local name = stand:FindFirstChild("Stand Name")
        if not name or name.Value ~= "The Hand" then return false end; _task.wait()
        for _, child in ipairs(stand:GetChildren()) do
            if child:IsA("Sound") and child.SoundId == "rbxassetid://7217913060" then return false end
        end
        return true
    end}},
    {"rbxassetid://4096014941", {def = 0.4, chckfunc = function(a) return a.Speed > 1.09 and a.Speed < 1.11 end}},
    {"rbxassetid://4096014941", {def = 0.4, chckfunc = function(a) return a.Speed > 0.84 and a.Speed < 0.86 end}},
}

blocksanim_base = {
    {"rbxassetid://12733018380", {def = 0.35, dist = 15, addw = 1.1}},
    {"rbxassetid://12733022476", {coliseum = true, dist = 1000, addw = 0.3}},
    {"rbxassetid://4608512208", {addw = 0.25}},
    {"rbxassetid://5303988283", {def = 0.2}},
    {"rbxassetid://6780938176", {def = 0.2, addw = 0.3}},
    "rbxassetid://12292886724",
    {"rbxassetid://6277192242", {def = 0.2, dist = 50, addw = 1}},
    {"rbxassetid://6651725175", {addw = -0.1, dist = 40}},
    {"rbxassetid://6216058630", {def = 0, coliseum = true, dist = 60, addw = -0.1}},
    {"rbxassetid://10726619714", {def = 0.2, addw = 0.55}},
    {"rbxassetid://12293320463", {def = 0.3}},
    {"rbxassetid://6869896659", {def = 0.2, addw = 0.75}},
    {"rbxassetid://14174878575", {def = 0.3, addw = -0.1, dist = 70, coliseum = true}},
    {"rbxassetid://7189003645", {def = 0.3, addw = 0.2}},
    "rbxassetid://5793968491",
    {"rbxassetid://4595562165", {def = 0, addw = 0.3}},
    "rbxassetid://5227558947",
    {"rbxassetid://4133363765", {def = 0.6}},
    {"rbxassetid://4691787301", {def = 0.25, addw = 0.75, dist = 100, chckfunc = function(_, p) _task.wait()
        local grapple = p.Parent.RightHand:FindFirstChild("Grapple")
        if grapple then
            return grapple.Attachment1 == game.Players.LocalPlayer.Character.HumanoidRootPart.RootRigAttachment
        end
        return false
    end}},
    {"rbxassetid://12733016318", {def = 0.325, addw = -0.1, dist = 15, chckfunc = function(a) return a.Speed < 0.75 end}},
}

blocksanim_UNBLOCK = {
    "rbxassetid://12293318922",
    "rbxassetid://13819646949",
    "rbxassetid://6780937804",
    "rbxassetid://6780982308",
    {"rbxassetid://10443019808", {dist = 10}},
}

block_projectiles = {
    {"VisionPlunderBubble", "Core", 15, nil},
    {" SP Bullet", nil, 20, function(p) return p:FindFirstChild("Victim") end, false, true},
    {"Last Shot", nil, 20, nil, false, true},
    {"Main", nil, 25, function(p) return p:FindFirstChild("BloodTrail") end, true},
    {"HomingShard", nil, 20},
    {"Bullet", nil, 20, function(p)
        if p.Name:find("SP Bullet") or p.Name:find("SPBullet") then return false
        else return not p:FindFirstChild("Victim") end
    end},
    {"CrossFirePiece", nil, 40, function(p)
        local sparks = p:FindFirstChild("OnFireSparks")
        return sparks and sparks.Enabled
    end, true, true},
    {"Baseball3", nil, 20},
}

block_objects = {
    {"Wormhole", workspace, 7, function() return 0, 0, -(game.Players.LocalPlayer:GetNetworkPing() / 2), false end},
}

block_SPECIAL = {
    {"GroundIndicator", function(p)
        local settings = {def = 0, wt = 0, addw = -0.1}
        local clone = p:Clone()
        local size = 5 * 2
        clone.Size = Vector3.new(15 + size, 5, 40 + size)
        clone.CFrame = clone.CFrame * CFrame.new(0, 0, -12.5); _task.wait(0.15)
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local pos = hrp.Position
            local min = clone.Position - clone.Size/2
            local max = clone.Position + clone.Size/2
            if pos.X >= min.X and pos.X <= max.X and pos.Y >= min.Y and pos.Y <= max.Y and pos.Z >= min.Z and pos.Z <= max.Z then
                reqblock(settings.def, settings.wt, settings.addw, false)
            end
        end
        clone:Destroy()
        return true
    end},
    {"FloorDash", function(p)
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        if (hrp.Position - p.Position).Magnitude > 40 then return false end
        local settings = {def = 0, wt = 0, addw = 0.25}; _task.wait(0.2)
        reqblock(settings.def, settings.wt, settings.addw, false)
        return true
    end},
}

overriders = {
    ["rbxassetid://7217913060"] = {"rbxassetid://4096014941"},
}

end

do
-- BlockBot Helper Functions

local function getstandP(char)
    return char and char:FindFirstChild("StandMorph")
end

local function getstand(char)
    return char and char:FindFirstChild("StandMorph")
end

local function isTimeStop()
    return game.Lighting:FindFirstChild("TimeStop") and true or false
end

local function isRagdolled(char)
    if char then
        return char:FindFirstChild("RagdollParts") and true or false
    end
    return false
end

local function ping()
    return game.Players.LocalPlayer:GetNetworkPing()
end

local function block()
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    -- Already blocking — no need to re-fire
    if blocked then return end
    local blockingCap = char:FindFirstChild("Blocking_Capacity")
    if blockingCap and blockingCap.Value > 0 then
        blocked = true
        return
    end
    blocked = true
    local remote = char:FindFirstChild("RemoteEvent")
    if remote then
        -- Fire twice: once immediately, once after a frame to ensure server receives it
        remote:FireServer("StartBlocking", "pass"); _task.wait()
        remote:FireServer("StartBlocking", "pass")
    end
end

local function unblock(forced)
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    if not forced and keepblock and not isRagdolled(char) then
        return
    end
    -- Already unblocked — skip
    if not blocked then
        blockactions = false
        return
    end
    local remote = char:FindFirstChild("RemoteEvent")
    if remote then
        -- Fire twice is enough; 5x was excessive and caused lag
        remote:FireServer("StopBlocking", "pass"); _task.wait()
        remote:FireServer("StopBlocking", "pass")
    end
    blocked = false
    blockactions = false
end

function reqblock(def, waitTime, extraWait, isperfect, prio)
    if not blockbot then return end

    local prioVal = prio or 0

    -- Priority check: skip if a higher-priority block is already in progress
    if blockactions then
        local currentPrio = tonumber(blockactions)
        if currentPrio then
            if prioVal <= currentPrio then return end
        else
            -- blockactions is true (boolean), only override if we have explicit priority
            if prioVal == 0 then return end
        end
    end

    blockactions = prioVal

    local char = game.Players.LocalPlayer.Character
    local remote = char and char:FindFirstChild("RemoteEvent")
    if not remote then
        blockactions = false
        return
    end

    -- Cancel any ongoing M1 attack before blocking
    remote:FireServer("HoldAttack", {Bool = false, Type = "m1"})
    lastbb = tick()

    -- Handle perfect block re-block logic
    local selfChar = Workspace:FindFirstChild("Living") and Workspace.Living:FindFirstChild(game.Players.LocalPlayer.Name)
    local blockingCap = selfChar and selfChar:FindFirstChild("Blocking_Capacity")
    if blockingCap and blockingCap.Value > 0 and isperfect then
        if def < 0.2 or not reblocking then
            blockactions = false
            return
        end
        unblock(true)
    end

    lastblock = lastblock + 1
    local blockId = lastblock

    -- Wait for the attack animation to reach the blockable window
    if waitTime > 0 then
        _task.wait(waitTime)
    end

    -- Abort if a newer block request came in or time is stopped
    if (lboverriding and lastblock ~= blockId) or isTimeStop() then
        blockactions = false
        return
    end

    block()

    -- Hold block for the duration of the attack + ping compensation
    local holdTime = 0.4 + math.max(0.05, ping()) + (extraWait or 0); _task.wait(holdTime)

    if not lboverriding or lastblock == blockId then
        blockactions = false
        unblock(false)
    end
end

function frek()
    if blockbot then
        if unblocking then
            blockprocsuntil = tick() + 0.75
            lastblock = lastblock + 1
            local blockId = lastblock
            blockactions = true
            unblock(false, true); _task.wait(0.05)
            unblock(false, true); _task.wait(0.7)
            if lboverriding and lastblock ~= blockId then
            else
                blockactions = false
            end
        end
    end
end

local function checkdist(maxdist, part, part2)
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    if maxdist < (hrp.Position - part.Position).Magnitude then
        if part2 then
            if maxdist < (hrp.Position - part2.Position).Magnitude then
                return 0
            end
        else
            return 0
        end
    end
    return 1
end

local function checkOverride(soundId)
    if blockactions and overriders and overriders[lastbad] then
        for _, overrideId in ipairs(overriders[lastbad]) do
            if overrideId == soundId then return false end
        end
    end
    return true
end

-- Default max distances per block tier:
-- tblIdx 1 = perfect blocks (wider range ok, timing-based)
-- tblIdx 2 = base blocks (tight range — only block if enemy is actually close enough to hit)
-- tblIdx 3 = unblock triggers (no dist check needed)
local DIST_DEFAULT_PERFECT = 12
local DIST_DEFAULT_BASE    = 7

local function processBlockTable(p997, p998, p999, blockTables)
    local isperfect = false
    for tblIdx = 1, #blockTables do
        local tbl = blockTables[tblIdx]
        if tbl and type(tbl) == "table" then
            for _, entry in ipairs(tbl) do
                if type(entry) ~= "table" or (not entry[2].coliseum or coliseumenabled) then
                    local soundId = type(entry) ~= "table" and entry or entry[1]
                    if checkOverride(soundId) then
                        -- Pick default dist based on tier
                        local defaultDist = tblIdx == 1 and DIST_DEFAULT_PERFECT or DIST_DEFAULT_BASE
                        local maxDist = defaultDist
                        local checkFailed = false
                        if type(entry) == "table" then
                            if tblIdx == 1 then isperfect = true
                            elseif tblIdx == 2 then isperfect = false end
                            maxDist = (entry[2] and entry[2].dist) or defaultDist
                            if entry[2].chckfunc and not entry[2].chckfunc(p998) then checkFailed = true end
                        end
                        if not checkFailed and p997.SoundId == soundId then
                            if checkdist(maxDist, p998, p999) == 1 then
                                if tblIdx == 3 then return frek(), nil, nil end
                                local hasbarrage = false
                                for _, child in ipairs(p997.Parent:GetChildren()) do
                                    if string.find(string.lower(child.Name), "barrage") then hasbarrage = true; break end
                                end
                                if not hasbarrage then
                                    _G._blockEntry = entry
                                    return true, isperfect, entry
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false, isperfect, nil
end

local function processAnimTable(p997, p998, p999, animTables)
    local isperfect = false
    local animid = p997.Animation.AnimationId
    for tblIdx = 1, #animTables do
        local tbl = animTables[tblIdx]
        if tbl and type(tbl) == "table" then
            for _, entry in ipairs(tbl) do
                if type(entry) ~= "table" or (not entry[2].coliseum or coliseumenabled) then
                    local animId = type(entry) ~= "table" and entry or entry[1]
                    if checkOverride(animId) then
                        -- Pick default dist based on tier
                        local defaultDist = tblIdx == 1 and DIST_DEFAULT_PERFECT or DIST_DEFAULT_BASE
                        local maxDist = defaultDist
                        local checkFailed = false
                        if type(entry) == "table" then
                            if tblIdx == 1 then isperfect = true
                            elseif tblIdx == 2 then isperfect = false end
                            maxDist = entry[2].dist or defaultDist
                            if entry[2].chckfunc and not entry[2].chckfunc(p997, p998) then checkFailed = true end
                        end
                        if not checkFailed and animId == animid and checkdist(maxDist, p998, p999) == 1 then
                            if tblIdx == 3 then return frek(), nil, nil end
                            _G._blockEntry = entry
                            return true, isperfect, entry
                        end
                    end
                end
            end
        end
    end
    return false, isperfect, nil
end

function proroc(p997, p998, p999)
    if isTimeStop() then return end
    if isRagdolled(game.Players.LocalPlayer.Character) then return end
    if not blockbot then return end
    if blockprocsuntil > tick() then return end

    local parent = p998.Parent
    local isperfect = false
    local found = false
    local entry = nil

    if p997:IsA("Sound") then
        found, isperfect, entry = processBlockTable(p997, p998, p999, {blocks_perfect, blocks_base, blocks_UNBLOCK})
    elseif p997:IsA("AnimationTrack") then
        found, isperfect, entry = processAnimTable(p997, p998, p999, {blocksanim_perfect, blocksanim_base, blocksanim_UNBLOCK})
    end

    if found then
        lastboi = parent
        local extraWait = 0
        local baseDef, basePrio
        if type(entry) ~= "table" then
            baseDef = 0.4
            basePrio = 0
        else
            local entryData = entry[2]
            baseDef = entryData.def or 0.4
            extraWait = extraWait + (entryData.addw or 0)
            basePrio = entryData.prio or 0
        end
        lastbad = entry
        local finalWait = math.max(0, baseDef - ping())
        reqblock(baseDef, finalWait, extraWait, isperfect, basePrio)
    end
end

function handleproj(p1064)
    if blockbot and typeof(p1064) == "Instance" and p1064.Parent and block_projectiles and type(block_projectiles) == "table" then
        for _, proj in ipairs(block_projectiles) do
            if p1064.Name and p1064.Name:find(proj[1]) then
                local projPart = proj[2] == nil and p1064 or p1064[proj[2]]
                local checkFn = proj[4] or function() return true end
                if not projPart or not projPart.Parent or not projPart:IsA("BasePart") then
                    return
                end
                local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                while p1064.Parent and p1064:IsDescendantOf(workspace) and projPart.Parent and checkFn(p1064) do
                    local vel = projPart.AssemblyLinearVelocity
                    local pos = projPart.Position
                    local inRange = vel.Magnitude > 0.01 and ((hrp.Position - pos).Magnitude < proj[3] or (hrp.Position - (pos + vel.Unit * 10)).Magnitude < proj[3]) or (hrp.Position - pos).Magnitude < proj[3]
                    if inRange and (not blockactions or projectiles_priority) then
                        if blockactions then return end
                        lastblock = lastblock + 1
                        local blockId = lastblock
                        blockactions = projectiles_priority and 42000 or true
                        block()
                        local startTime = tick()
                        while p1064.Parent and p1064:IsDescendantOf(workspace) and projPart.Parent and (tick() - startTime < 0.75) and checkFn(p1064) do
                            local newPos = projPart.Position
                            local newVel = projPart.AssemblyLinearVelocity
                            local stillInRange = newVel.Magnitude > 0.01 and ((hrp.Position - newPos).Magnitude < proj[3] or (hrp.Position - (newPos + newVel.Unit * 10)).Magnitude < proj[3]) or (hrp.Position - newPos).Magnitude < proj[3]
                            if not stillInRange then break end; _task.wait()
                        end
                        local elapsed = tick() - startTime
                        if elapsed < 0.4321 then
                            _task.wait(0.4321 - elapsed)
                        end
                        if not isTimeStop() and (not lboverriding or lastblock == blockId) then
                            unblock(false)
                            blockactions = false
                        end
                    end; _task.wait()
                end
            end
        end
    end
end

function checkSpecial(p1085)
    if blockbot and typeof(p1085) == "Instance" and p1085.Parent and block_SPECIAL and type(block_SPECIAL) == "table" then
        for _, sp in ipairs(block_SPECIAL) do
            if p1085.Name and p1085.Name:find(sp[1]) then
                if sp[2](p1085) then return end
            end
        end
    end
end

function handleChildAdded(p1091)
    if not blockbot or not (typeof(p1091) == "Instance" and p1091.Parent) then return end
    if blockprocsuntil > tick() then return end
    -- No _task.wait() here — delay hurts reaction time
    if block_projectiles and type(block_projectiles) == "table" then
        for _, proj in ipairs(block_projectiles) do
            if p1091.Parent and p1091.Name and p1091.Name:find(proj[1]) then return handleproj(p1091) end
        end
    end
    if block_SPECIAL and type(block_SPECIAL) == "table" then
        for _, sp in ipairs(block_SPECIAL) do
            if p1091.Parent and p1091.Name and p1091.Name:find(sp[1]) then return checkSpecial(p1091) end
        end
    end
end

workspace.DescendantAdded:Connect(function(p1055)
    if typeof(p1055) ~= "Instance" or not p1055.Parent then
        return
    end
    if block_objects and type(block_objects) == "table" then
        for _, v1059 in ipairs(block_objects) do
            local localChar = game.Players.LocalPlayer.Character
            local root = localChar and (localChar.PrimaryPart or localChar:FindFirstChild("HumanoidRootPart"))
            if root and p1055:IsA("BasePart") and v1059[1] == p1055.Name and (v1059[2] == "any" or v1059[2] == p1055.Parent) and (root.Position - p1055.Position).Magnitude < v1059[3] then
                reqblock(v1059[4]())
            end
        end
    end
end)

workspace.ChildAdded:Connect(handleChildAdded)

pcall(function()
    workspace.IgnoreInstances.ChildAdded:Connect(handleChildAdded)
end)

local char = game.Players.LocalPlayer.Character
if char then
    char.ChildAdded:Connect(function(child)
        if child.Name == "RagdollParts" then
            lastblock = lastblock + 1
            blockprocsuntil = tick() + 0.2
            blockactions = false
            blocked = false
            unblock(false)
        end
    end)
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(newchar)
    newchar.ChildAdded:Connect(function(child)
        if child.Name == "RagdollParts" then
            lastblock = lastblock + 1
            blockprocsuntil = tick() + 0.2
            blockactions = false
            blocked = false
            unblock(false)
        end
    end)
end)

local function hookSound(char, sound)
    -- No artificial delay — process immediately for faster reaction
    local root = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if root then proroc(sound, root, nil) end
end

local function hookAnimator(char, animator) _task.wait(0.1)
    animator.AnimationPlayed:Connect(function(track)
        local root = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        if root then proroc(track, root, nil) end
    end)
end

local function setupHooks(char)
    if not char then return end
    char.DescendantAdded:Connect(function(desc)
        if desc:IsA("Sound") then
            hookSound(char, desc)
        elseif desc:IsA("Model") and desc.Name == "StandMorph" then
            _task.wait(0.15)
            desc.DescendantAdded:Connect(function(standDesc)
                if standDesc:IsA("Sound") then
                    hookSound(char, standDesc)
                elseif standDesc:IsA("Animator") then
                    hookAnimator(char, standDesc)
                end
            end)
        elseif desc:IsA("Animator") then
            hookAnimator(char, desc)
        end
    end)

    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local anim = hum:FindFirstChild("Animator")
        if anim then
            anim.AnimationPlayed:Connect(function(track)
                local root = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                if root then proroc(track, root, nil) end
            end)
        end
    end

    local stand = char:FindFirstChild("StandMorph")
    if stand then
        _task.wait(0.15)
        stand.DescendantAdded:Connect(function(standDesc)
            if standDesc:IsA("Sound") then
                hookSound(char, standDesc)
            elseif standDesc:IsA("Animator") then
                hookAnimator(char, standDesc)
            end
        end)
    end
end

local hookedPlayers = {}

function hookPlayer(plr)
    if plr == game.Players.LocalPlayer then return end
    -- Prevent double-hooking the same player
    if hookedPlayers[plr] then return end
    hookedPlayers[plr] = true
    if plr.Character then
        setupHooks(plr.Character)
    end
    plr.CharacterAdded:Connect(setupHooks)
    -- Clean up when player leaves
    plr.AncestryChanged:Connect(function()
        if not plr:IsDescendantOf(game) then
            hookedPlayers[plr] = nil
        end
    end)
end

for _, player in ipairs(game.Players:GetPlayers()) do
    hookPlayer(player)
end

game.Players.PlayerAdded:Connect(hookPlayer)

-- UI Controls
blockBotSec:Toggle({
    Name = "Enable BlockBot",
    Default = getSavedFlag("BB", false),
    Callback = function(value)
        setSavedFlag("BB", value)
        blockbot = value
        ybaNotify("BlockBot", value and "Enabled!" or "Disabled!")
    end
})

blockBotSec:Toggle({
    Name = "Allow re-blocking",
    Default = getSavedFlag("BB_RB", true),
    Callback = function(value)
        setSavedFlag("BB_RB", value)
        reblocking = value
    end
})

blockBotSec:Toggle({
    Name = "Keep block while holding F",
    Default = getSavedFlag("BB_KB", true),
    Callback = function(value)
        setSavedFlag("BB_KB", value)
        keepblock = value
    end
})

blockBotSec:Toggle({
    Name = "Unblocking",
    Default = getSavedFlag("BB_UB", true),
    Callback = function(value)
        setSavedFlag("BB_UB", value)
        unblocking = value
    end
})

blockBotSec:Toggle({
    Name = "Projectiles priority",
    Default = getSavedFlag("BB_PP", false),
    Callback = function(value)
        setSavedFlag("BB_PP", value)
        projectiles_priority = value
    end
})

blockBotSec:Toggle({
    Name = "Coliseum (1v1/2v2) mode",
    Default = getSavedFlag("BB_COL", false),
    Callback = function(value)
        setSavedFlag("BB_COL", value)
        coliseumenabled = value
    end
})

blockBotSec:Toggle({
    Name = "Block Beach Boy E and Y",
    Default = getSavedFlag("BB_ROD", false),
    Callback = function(value)
        setSavedFlag("BB_ROD", value)
        _G.rodblocking = value
    end
})

blockBotSec:Button({
    Name = "Re-hook Players",
    Callback = function()
        -- Clear hook cache so all players get re-hooked fresh
        hookedPlayers = {}
        for _, player in pairs(workspace.Living:GetChildren()) do
            local plr = game.Players:FindFirstChild(player.Name)
            if plr then
                _task.spawn(function()
                    if plr ~= game.Players.LocalPlayer then
                        hookPlayer(plr)
                    end
                end)
            end
        end
        ybaNotify("BlockBot", "Re-hooked all players!")
    end
})

end -- End of BlockBot scope

-- ==================== AUTO STORYLINE & PRESTIGE TAB ====================

-- Helper function to fire dialogue
local function FireDialogue(npc, dialogue, option)
    pcall(function()
        local char = LP.Character
        if char then
            local remote = char:FindFirstChild("RemoteEvent")
            if remote then
                remote:FireServer("EndDialogue", {
                    NPC = npc,
                    Dialogue = dialogue,
                    Option = option,
                })
            end
        end
    end)
end

-- Fire All Storyline Dialogues Function
local function FireAllStorylineDialogues()
    local storylines = {"#1","#1","#1","#2","#3","#3","#3","#4","#5","#6","#7","#8","#9","#10","#11","#11","#12","#14"}
    local dialogues = {"Dialogue2","Dialogue6","Dialogue6","Dialogue3","Dialogue3","Dialogue3","Dialogue6","Dialogue3","Dialogue5","Dialogue5","Dialogue5","Dialogue4","Dialogue7","Dialogue6","Dialogue8","Dialogue11","Dialogue3","Dialogue2"}
    for i = 1, 18 do
        FireDialogue("Storyline " .. storylines[i], dialogues[i], "Option1"); _task.wait(0.05)
    end
    ybaNotify("Storyline", "All storyline dialogues fired!")
end

-- Auto Prestige Variables
local autoPrestigeEnabled = false
local autoPrestigeSession = 0
local autoPrestigeStartData = {
    enabled = false,
    startTime = nil,
    startLevel = nil,
    startPrestige = nil,
    startDate = nil
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

    local payload = HttpService:JSONEncode(data)

    pcall(function()
        local requestFunc = syn and syn.request or http_request or request or http.request
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
    local currentLevel = player.PlayerStats.Level.Value
    local currentPrestige = player.PlayerStats.Prestige.Value
    local timestamp = getISO8601()

    local embed = {
        title = "RAILhub - Auto StoryLine",
        color = statusType == "started" and 3447003 or statusType == "completed" and 16776960 or statusType == "stopped" and 15158332 or 7498239,
        timestamp = timestamp,
        footer = {
            text = "RAILhub YBA Script - Auto StoryLine"
        },
        thumbnail = {
            url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
        }
    }

    if statusType == "started" then
        embed.description = "🟢 **Player Started Auto StoryLine**"
        embed.fields = {
            {name = "👤 Player", value = player.Name, inline = true},
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
            {name = "👤 Player", value = player.Name, inline = true},
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

        embed.description = "@everyone 🎉 **PLAYER COMPLETED AUTO STORYLINE!** 🎉\n\nGive him a slap on the ass! 👋🍑"
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
        title = "RAILhub - Auto StoryLine",
        description = p89,
        color = 7498239,
        timestamp = getISO8601()
    }
    sendWebhook({embeds = {embed}})
end

-- Main Auto Prestige Function
local function RunAutoPrestige()
    local mySession = autoPrestigeSession
    local function apAlive()
        return autoPrestigeEnabled and autoPrestigeSession == mySession
    end

    getgenv().waitUntilCollect = 0.5
    getgenv().sortOrder = "Asc"
    getgenv().lessPing = false
    getgenv().autoRequiem = true
    getgenv().NPCTimeOut = 15
    getgenv().HamonCharge = 90

    print("Auto Prestige 3 Started - Smart Storyline Check Mode");

    repeat
        _task.wait()
    until game:IsLoaded() and (game.Players.LocalPlayer and game.Players.LocalPlayer.Character)

    local vu81 = game.Players.LocalPlayer
    local vu82 = vu81.Character

    repeat
        _task.wait()
    until vu82:FindFirstChild("RemoteEvent") and vu82:FindFirstChild("RemoteFunction")

    local vu83 = vu82.RemoteFunction
    local vu84 = vu82.RemoteEvent
    local vu85 = vu82.PrimaryPart
    local vu86 = true

    if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
        ybaNotify("Auto Prestige", "Already max prestige and level!")
        autoPrestigeEnabled = false
        autoPrestigeRunning = false
        for k, v in pairs(prevAutoPrestigeEnv) do getgenv()[k] = v end
        getgenv().AutoPrestigeEnvBackup = nil
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
    end; _task.spawn(function()
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

    -- No floating platform needed — using standFarmPosition instead

    local function vu124(p118)
        local v122 = {
            Position = {},
            ProximityPrompt = {},
            Items = {}
        }
        local itemsFolder = game:GetService("Workspace"):FindFirstChild("Item_Spawns") and game:GetService("Workspace").Item_Spawns:FindFirstChild("Items")
        if not itemsFolder then return v122 end

        for _, v123 in pairs(itemsFolder:GetChildren()) do
            local prox = v123:FindFirstChild("ProximityPrompt")
            local mesh = v123:FindFirstChild("MeshPart") or v123:FindFirstChildOfClass("BasePart")
            if mesh and prox then
                -- Removed MaxActivationDistance == 8 check — Lighter and other items may differ
                if prox.ObjectText == p118 then
                    table.insert(v122.Items, prox.ObjectText)
                    table.insert(v122.ProximityPrompt, prox)
                    table.insert(v122.Position, mesh.CFrame)
                end
            end
        end
        return v122
    end

    local function vu131(p125)
        return sfCountItem(p125)
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
                v134:Activate(); _task.wait()
            until vu81.PlayerGui:FindFirstChild("DialogueGui")
            pcall(function()
                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.Options:WaitForChild("Option1").TextButton.MouseButton1Click)
                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
                repeat
                    _task.wait()
                until vu81.PlayerGui:WaitForChild("DialogueGui").Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
                firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
            end)
        end
        return true
    end

    local vu156

    local apStandBlacklist = {
        ["Anubis"] = true,
        ["Aerosmith"] = true,
        ["White Album"] = true,
        ["Six Pistols"] = true,
        ["Beach Boy"] = true,
        ["Mr. President"] = true,
        ["Tusk (Act 1)"] = true,
        ["Scary Monsters"] = true,
        ["Hermit Purple"] = true,
    }

    local _apLastTP = 0
    local function apWaitTPCooldown()
        if not getgenv()._YBA_directTP then return end -- no cooldown for Tween
        local now = tick()
        if now - _apLastTP < 0.4 then
            _task.wait(0.4 - (now - _apLastTP))
        end
    end
    local function apMarkTP()
        _apLastTP = tick()
    end
    local function apTeleport(hrp, cf)
        if not hrp or not cf then return end
        if getgenv()._YBA_directTP then
            -- Bypass active: direct CFrame (original behaviour)
            apWaitTPCooldown()
            hrp.CFrame = cf
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            apMarkTP()
        else
            -- No bypass: Tween at 500 studs/sec
            local dist = (hrp.Position - cf.Position).Magnitude
            if dist < 1 then return end
            local time = math.clamp(dist / 500, 0.05, 3)
            local tw = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = cf})
            tw:Play()
            tw.Completed:Wait()
            tw:Destroy()
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
    end

    local function apUseRoka()
        local roka = vu81.Backpack:FindFirstChild("Rokakaka") or (vu82 and vu82:FindFirstChild("Rokakaka"))
        if not roka then
            if vu81.PlayerStats.Money.Value >= 2500 then
                pcall(function()
                    vu84:FireServer("PurchaseShopItem", {ItemName = "1x Rokakaka"}, 1, 2)
                end); _task.wait(0.3)
                roka = vu81.Backpack:FindFirstChild("Rokakaka") or (vu82 and vu82:FindFirstChild("Rokakaka"))
            end
            if not roka then
                vu156("Rokakaka", 1); _task.wait(0.5)
                roka = vu81.Backpack:FindFirstChild("Rokakaka") or (vu82 and vu82:FindFirstChild("Rokakaka"))
            end
            if not roka then return false end
        end
        local oldStand = vu81.PlayerStats.Stand.Value
        useItemDirect("Rokakaka", "Rokakaka")
        local oldChar = vu82
        local t = tick()
        -- Wait up to 4s for respawn
        while tick() - t < 4 and vu81.Character == oldChar and apAlive() do _task.wait(0.05) end
        if vu81.Character and vu81.Character ~= oldChar then
            vu82 = vu81.Character
            vu83 = vu82:FindFirstChild("RemoteFunction")
            vu84 = vu82:FindFirstChild("RemoteEvent")
            vu85 = vu82.PrimaryPart
        end
        t = tick()
        while tick() - t < 3 and apAlive() do
            if vu81.PlayerStats.Stand.Value == "None" then return true end; _task.wait(0.1)
        end
        return vu81.PlayerStats.Stand.Value == "None"
    end
    local function apUseArrow(maxRetries)
        maxRetries = maxRetries or 5
        local retries = 0
        while retries < maxRetries and apAlive() do
            local oldStand = vu81.PlayerStats.Stand.Value
            local arrow = vu81.Backpack:FindFirstChild("Mysterious Arrow") or (vu82 and vu82:FindFirstChild("Mysterious Arrow"))
            if not arrow then
                if vu81.PlayerStats.Money.Value >= 750 then
                    pcall(function()
                        vu84:FireServer("PurchaseShopItem", {ItemName = "1x Mysterious Arrow"}, 1, 2)
                    end); _task.wait(0.3)
                    arrow = vu81.Backpack:FindFirstChild("Mysterious Arrow") or (vu82 and vu82:FindFirstChild("Mysterious Arrow"))
                end
                if not arrow then
                    vu156("Mysterious Arrow", 1); _task.wait(0.5)
                    arrow = vu81.Backpack:FindFirstChild("Mysterious Arrow") or (vu82 and vu82:FindFirstChild("Mysterious Arrow"))
                end
                if not arrow then return false end
            end
            useItemDirect("Mysterious Arrow", "Mysterious Arrow")
            local oldChar = vu82
            local t = tick()
            -- Wait up to 4s for respawn
            while tick() - t < 4 and vu81.Character == oldChar and apAlive() do _task.wait(0.05) end
            if vu81.Character and vu81.Character ~= oldChar then
                vu82 = vu81.Character
                vu83 = vu82:FindFirstChild("RemoteFunction")
                vu84 = vu82:FindFirstChild("RemoteEvent")
                vu85 = vu82.PrimaryPart
            end
            local newStand = vu81.PlayerStats.Stand.Value
            if newStand ~= "None" and newStand ~= oldStand then
                print("Got stand: " .. newStand)
                return true
            end
            retries = retries + 1
            _task.wait(0.3)
        end
        return false
    end
    local function vu136()
        -- Teleport to stand farm safe position
        apTeleport(vu81.Character.HumanoidRootPart, standFarmPosition)

        -- Only roll for a stand at level 2-3 if we don't have one yet
        -- After that, keep the stand for the entire prestige run
        if vu81.PlayerStats.Stand.Value == "None" and vu81.PlayerStats.Level.Value >= 2 then
            print("Level " .. vu81.PlayerStats.Level.Value .. " — rolling for initial stand")

            if not vu81.Character:FindFirstChild("WorthinessLearned") then
                sfLearnWorthiness()
                local m = Instance.new("BoolValue")
                m.Name = "WorthinessLearned"
                m.Value = true
                m.Parent = vu81.Character
            end

            local arrowAttempts = 0
            while vu81.PlayerStats.Stand.Value == "None" and arrowAttempts < 20 and apAlive() do
                apUseArrow(3)
                arrowAttempts = arrowAttempts + 1

                if vu81.PlayerStats.Stand.Value ~= "None" then
                    local stand = vu81.PlayerStats.Stand.Value
                    if apStandBlacklist[stand] then
                        -- Blacklisted stand — reroll with roka
                        print("Blacklisted stand: " .. stand .. " — rerolling")
                        ybaNotify("Auto Prestige", "Blacklisted: " .. stand .. " — rerolling...")
                        apUseRoka(); _task.wait(0.5)
                    else
                        -- Good stand — keep it for the whole run
                        print("Got initial stand: " .. stand .. " — keeping for full run")
                        ybaNotify("Auto Prestige", "Stand: " .. stand); _task.spawn(function()
                            local skills = {"Destructive Power I","Destructive Power II","Destructive Power III","Destructive Power IV","Destructive Power V"}
                            for _, skill in pairs(skills) do
                                vu83:InvokeServer("LearnSkill", {Skill = skill, SkillTreeType = "Stand"})
                            end
                        end); _task.wait(0.5)
                        break -- stop rolling, keep this stand
                    end
                end
            end
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
        end); _task.spawn(function()
            while not vu139 do
                _task.wait()
                pcall(function()
                    if pu137.Position[pu138] then
                        local hrp2 = game.Players.LocalPlayer.Character.HumanoidRootPart
                        -- Always direct CFrame for item pickup — short distance, no server kick
                        hrp2.CFrame = pu137.Position[pu138] - Vector3.new(0, 10, 0)
                    end
                end)
            end
        end); _task.wait(getgenv().waitUntilCollect); _task.spawn(function()
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
                                    end); _task.wait()
                                until not vu81.PlayerGui:FindFirstChild("ScreenGui")
                            end
                        end
                    end
                end
            end
        end); _task.spawn(function()
            for _ = vu140, 1, -1 do
                _task.wait(1)
            end
            if not vu139 then
                vu139 = true
            end
        end)

        while not vu139 do
            _task.wait()
        end
    end

    vu156 = function(p148, p149)
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

            local success = vu147(v150, i); _task.wait(0.5)
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
        local function findClosestNpcByName()
            local deadline = tick() + getgenv().NPCTimeOut
            repeat
                local bestNpc
                local bestDistance = math.huge
                if vu85 then
                    for _, npc in pairs(workspace.Living:GetChildren()) do
                        if npc.Name == p164 and npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                            local dist = (vu85.Position - npc.HumanoidRootPart.Position).Magnitude
                            if dist < bestDistance then
                                bestDistance = dist
                                bestNpc = npc
                            end
                        end
                    end
                end
                if bestNpc then
                    return bestNpc
                end; _task.wait(0.1)
            until tick() >= deadline or not apAlive()
            return nil
        end

        local vu168 = findClosestNpcByName()
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
                        -- Always use direct CFrame for NPC combat — short distances, no server kick
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
                    -- Always use direct CFrame for NPC combat — short distances, no server kick
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
                    elseif vu168.Humanoid.Health > 0 then
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
            _task.wait()
            if not vu168 or not vu168:FindFirstChild("HumanoidRootPart") then
                if v178 then v178:Disconnect() end
                v169 = false
                break
            end
            if p167 then
                pcall(p167, vu168)
            end; _task.spawn(v173); _task.spawn(v174); _task.spawn(v175)
        end
        return vu170
    end

    local function vu183() _task.spawn(function()
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
            "Find a Lighter for Abbacchio",
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

        vu160("Storyline #1", "Dialogue2", "Option1"); _task.wait(0.5)

        for _, questName in pairs(storylineQuests) do
            if vu184:FindFirstChild(questName) then
                return false
            end
        end

        return true
    end

    local function vampireFarmUntilMax()
        vu93("Farming vampires until max level...")
        ybaNotify("Auto Prestige", "Farming vampires until max level...")

        while apAlive() and vu81.PlayerStats.Level.Value < 50 do
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
                vu160("William Zeppeli", "Dialogue4", "Option1"); _task.wait(0.1)
            end

            getgenv().HamonCharge = 10
            vu179("Vampire", 15, false, function(vampire)
                pcall(function()
                    if vampire and vampire:FindFirstChild("HumanoidRootPart") then
                        local hrpV = vu81.Character.PrimaryPart
                        -- Always direct CFrame for NPC combat — short distance, no server kick
                        hrpV.CFrame = vampire.HumanoidRootPart.CFrame - Vector3.new(0, 15, 0)
                    end
                end)
            end); _task.wait(0.1)
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
        ybaNotify("Auto Prestige", "Prestiging to P" .. (currentPrestige + 1) .. "...")

        vu160("Prestige", "Dialogue2", "Option1")

        local startWait = tick()
        while tick() - startWait < 10 do
            if vu81.PlayerStats.Prestige.Value > currentPrestige then
                vu93("Prestiged successfully!")
                return true
            end; _task.wait(0.1)
        end

        return vu81.PlayerStats.Prestige.Value > currentPrestige
    end

    local function resetCharacter()
        vu93("Resetting character...")
        ybaNotify("Auto Prestige", "Resetting character...")

        local humanoid = vu81.Character and vu81.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end

        vu81.CharacterAdded:Wait(); _task.wait(3)

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
        if not apAlive() then return false end

        if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
            sendStatusWebhook("completed")

            vu93("MAXED! P3 L50")
            ybaNotify("Auto Prestige", "MAX PRESTIGE 3 LEVEL 50!")

            autoPrestigeEnabled = false
            pcall(function()
                delfile("AutoPres3_" .. vu81.Name .. ".txt")
            end)
            return false
        end

        if vu81.PlayerStats.Stand.Value == "None" and vu81.PlayerStats.Level.Value >= 2 then
            vu136(); _task.wait(1)
        end

        if vu81.PlayerStats.Stand.Value ~= "None" and vu82:FindFirstChild("RemoteFunction") and not (vu82:FindFirstChild("SummonedStand") and vu82.SummonedStand.Value) then
            vu83:InvokeServer("ToggleStand", "Toggle"); _task.wait(0.5)
        end

        vu183()

        if getgenv().autoRequiem and vu81.PlayerStats.Level.Value >= 25 and vu81.PlayerStats.Prestige.Value >= 1 then
            if vu81.Backpack:FindFirstChild("Requiem Arrow") then
                if vu81.PlayerStats.Stand.Value == "King Crimson" or vu81.PlayerStats.Stand.Value == "Star Platinum" then
                    apTeleport(vu81.Character.HumanoidRootPart, standFarmPosition)
                    local v186 = vu81.PlayerStats.Stand.Value
                    vu135("Requiem Arrow", "V")
                    repeat _task.wait() until vu81.PlayerStats.Stand.Value ~= v186
                    _task.wait(1)
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
                    vu84:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue:FindFirstChild("Lisa Lisa")); _task.wait(0.5)
                    pcall(function()
                        repeat
                            firesignal(vu81.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click); _task.wait(0.1)
                        until vu81.PlayerGui.DialogueGui.Frame.Options:FindFirstChild("Option1")

                        firesignal(vu81.PlayerGui.DialogueGui.Frame.Options.Option1.TextButton.MouseButton1Click)

                        repeat
                            firesignal(vu81.PlayerGui.DialogueGui.Frame.ClickContinue.MouseButton1Click); _task.wait(0.1)
                        until vu81.PlayerStats.Spec.Value ~= "None"
                    end); _task.wait(2)
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
            vu163(); _task.wait(0.1)
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
            -- Storyline #11: Find a Lighter for Abbacchio
            -- Fire the dialogue directly — no need to physically pick up the item
            ["Find a Lighter for Abbacchio"] = function()
                vu93("Finding Lighter for Abbacchio...")
                -- Try to pick up Lighter from map first
                local lighterData = vu124("Lighter")
                if #lighterData.Position > 0 then
                    vu156("Lighter", 1); _task.wait(0.5)
                end
                -- Fire storyline dialogue to advance quest regardless
                vu160("Storyline #11", "Dialogue8", "Option1"); _task.wait(0.3)
                vu160("Storyline #11", "Dialogue11", "Option1"); _task.wait(0.3)
                vu163()
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
                vu160("Storyline #14", "Dialogue7", "Option1"); _task.wait(2)
                return result
            end
        }

        for questName, handler in pairs(questHandlers) do
            if vu184:FindFirstChild(questName) then
                local result = handler()

                if questName == "Defeat Diavolo" and result then
                    vu93("Diablo defeated! Storyline complete.")
                    ybaNotify("Auto Prestige", "Storyline complete! Farming vampires...")

                    vampireFarmUntilMax()

                    if doPrestige() then
                        _task.wait(3)

                        vu86 = false
                        vu88 = tick()
                        vu93("Restarting storyline loop...")
                        ybaNotify("Auto Prestige", "Restarting storyline for next prestige!")
                        return doStorylineLoop()
                    else
                        if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
                            sendStatusWebhook("completed")

                            vu93("MAXED! P" .. vu81.PlayerStats.Prestige.Value .. " L" .. vu81.PlayerStats.Level.Value)
                            ybaNotify("Auto Prestige", "MAX PRESTIGE 3 LEVEL 50!")
                            autoPrestigeEnabled = false
                            pcall(function()
                                delfile("AutoPres3_" .. vu81.Name .. ".txt")
                            end)
                            return false
                        end
                    end

                    return true
                end; _task.wait(1)
                vu163()
                return doStorylineLoop()
            end
        end

        if #vu184:GetChildren() == 0 or vu184:FindFirstChild("Take down 3 vampires") then
            vampireFarmUntilMax()
            if doPrestige() then
                _task.wait(3)
                vu86 = false
                vu88 = tick()
                return doStorylineLoop()
            end
        end

        if vu81.PlayerStats.Level.Value == 50 then
            if vu81.PlayerStats.Prestige.Value >= 3 then
                sendStatusWebhook("completed")

                vu93("MAXED! P3 L50")
                ybaNotify("Auto Prestige", "MAX PRESTIGE 3 LEVEL 50!")
                autoPrestigeEnabled = false
                pcall(function()
                    delfile("AutoPres3_" .. vu81.Name .. ".txt")
                end)
                return false
            else
                if doPrestige() then
                    _task.wait(3)
                    vu86 = false
                    vu88 = tick()
                    return doStorylineLoop()
                end
            end
        end

        vu163(); _task.wait(1)
        return doStorylineLoop()
    end

    local function mainLoop()
        vu136(); _task.wait(1)

        if isStorylineCompleted() then
            vampireFarmUntilMax()

            if doPrestige() then
                _task.wait(3)

                return doStorylineLoop()
            else
                if vu81.PlayerStats.Level.Value == 50 and vu81.PlayerStats.Prestige.Value >= 3 then
                    sendStatusWebhook("completed")

                    vu93("MAXED! P3 L50")
                    ybaNotify("Auto Prestige", "MAX PRESTIGE 3 LEVEL 50!")
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
            ybaNotify("Auto Prestige", "Starting storyline...")
            return doStorylineLoop()
        end
    end

    local characterConnection
    characterConnection = game.Workspace.Living.ChildAdded:Connect(function(p194)
        if p194.Name == vu81.Name then
            if not apAlive() then
                if characterConnection then characterConnection:Disconnect() end
                return
            end
            if vu81.PlayerStats.Level.Value ~= 50 then
                _task.wait(2)
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

                if vu86 and apAlive() then
                    mainLoop()
                elseif apAlive() then
                    vu136()
                end
            end
        end
    end)

    local levelConnection
    levelConnection = vu81.PlayerStats.Level:GetPropertyChangedSignal("Value"):Connect(function()
        if not apAlive() then
            if levelConnection then levelConnection:Disconnect() end
            return
        end
        vu93("Level up! P" .. vu81.PlayerStats.Prestige.Value .. " L" .. vu81.PlayerStats.Level.Value)
        if vu81.PlayerStats.Level.Value >= 3 and vu81.PlayerStats.Stand.Value == "None" then
            _task.spawn(function() _task.wait(0.5)
                vu136()
            end)
        end
    end)

    local noClipConnection
    noClipConnection = vu81.CharacterAdded:Connect(function(char)
        if not apAlive() then
            if noClipConnection then noClipConnection:Disconnect() end
            return
        end; _task.wait(1)
        for _, v198 in pairs(char:GetDescendants()) do
            if v198:IsA("BasePart") and v198.CanCollide == true then
                v198.CanCollide = false
            end
        end
    end)

    local storyAnimConn
    local function connectStoryAnimDetector()
        if storyAnimConn then storyAnimConn:Disconnect() end
        local char = vu81.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        storyAnimConn = hum.AnimationPlayed:Connect(function(track)
            if not apAlive() then return end
            local animId = track.Animation and track.Animation.AnimationId
            if not animId then return end
            if animId == "rbxassetid://5157052272" or animId:find("5157052272") then
                vu93("Storyline completed animation detected - resetting to skip")
                ybaNotify("Auto Prestige", "Skipping storyline animation..."); _task.wait(0.1)
                resetCharacter(); _task.wait(1)
                connectStoryAnimDetector()
            end
        end)
    end
    connectStoryAnimDetector()

    vu81.CharacterAdded:Connect(function(newChar)
        if not apAlive() then return end; _task.wait(1)
        local hum = newChar:FindFirstChildOfClass("Humanoid")
        if hum then
            if storyAnimConn then storyAnimConn:Disconnect() end
            storyAnimConn = hum.AnimationPlayed:Connect(function(track)
                if not apAlive() then return end
                local animId = track.Animation and track.Animation.AnimationId
                if not animId then return end
                if animId == "rbxassetid://5157052272" or animId:find("5157052272") then
                    vu93("Storyline completed animation detected - resetting to skip")
                    ybaNotify("Auto Prestige", "Skipping storyline animation..."); _task.wait(0.1)
                    resetCharacter(); _task.wait(1)
                    connectStoryAnimDetector()
                end
            end)
        end
    end)

    for _, v198 in pairs(vu82:GetDescendants()) do
        if v198:IsA("BasePart") and v198.CanCollide == true then
            v198.CanCollide = false
        end
    end

    mainLoop()
end

toggleAutoPrestige = function(value)
    if value then
        autoPrestigeSession = autoPrestigeSession + 1
        setSavedFlag("AP", true)
        ybaNotify("Auto Prestige", "Firing all storyline dialogues first...")
        FireAllStorylineDialogues(); _task.wait(1)
        autoPrestigeEnabled = true
        autoPrestigeStartData = {
            enabled = true,
            startTime = tick(),
            startLevel = player.PlayerStats.Level.Value,
            startPrestige = player.PlayerStats.Prestige.Value,
            startDate = os.date("%Y-%m-%d %H:%M:%S")
        }
        sendStatusWebhook("started")
        ybaNotify("Auto Prestige", "Auto Storyline & Prestige Started!"); _task.spawn(function()
            local success, err = pcall(function()
                RunAutoPrestige()
            end)
            if not success then
                ybaNotify("Auto Prestige", "Error: " .. tostring(err))
                autoPrestigeEnabled = false
                setSavedFlag("AP", false)
            end
        end)
    else
        autoPrestigeEnabled = false
        setSavedFlag("AP", false)
        ybaNotify("Auto Prestige", "Auto Storyline & Prestige disabled.")
        if autoPrestigeStartData.enabled then
            sendStatusWebhook("stopped")
            autoPrestigeStartData.enabled = false
        end
    end
end

SettingsTab = TabGroup:Tab({ Name = "Settings", Image = "rbxassetid://7734053495" })
settingsSec = SettingsTab:Section({ Side = "Left", Name = "Script Settings" })
settingsSec:Header({ Text = "Settings", AutoLocalize = false })
settingsSec:Toggle({
    Name = "Save Settings",
    Default = getSavedFlag("SS", true),
    Callback = function(v)
        CFG.SaveSettings = v
        setSavedFlag("SS", v)
        warn("[YBA] Save Settings = " .. tostring(v))
    end,
})
settingsSec:Toggle({
    Name = "Auto Execute",
    Default = getSavedFlag("AE", true),
    Callback = function(v)
        CFG.AutoExecute = v
        setSavedFlag("AE", v)
        if v then
            setupAutoReload()
        else
            if getgenv then getgenv().RAILHUB_AUTOEXEC = nil end
        end
        warn("[YBA] Auto Execute = " .. tostring(v))
    end,
})

reconnectSec = SettingsTab:Section({ Side = "Right", Name = "Server" })
reconnectSec:Header({ Text = "Server", AutoLocalize = false })
reconnectSec:Button({
    Name = "Reconnect",
    Callback = function()
        ybaNotify("Settings", "Reconnecting to current server..."); _task.wait(0.5)
        local jobId = game.JobId
        if jobId and jobId ~= "" then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, LP)
        else
            ybaNotify("Settings", "Could not get server ID, rejoining...")
            game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
        end
    end,
})
reconnectSec:Button({
    Name = "Server Hop",
    Callback = function()
        ybaNotify("Settings", "Server hopping..."); _task.wait(0.5)
        local req = (syn and syn.request) or http_request or request or (http and http.request)
        if req then
            local ok, res = pcall(req, {
                Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
                Method = "GET",
            })
            if ok and res and res.StatusCode == 200 then
                local data = HttpService:JSONDecode(res.Body)
                if data.data and #data.data > 0 then
                    local currentId = game.JobId
                    for _, server in ipairs(data.data) do
                        if server.id ~= currentId and server.playing and server.playing < server.maxPlayers then
                            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, LP)
                            return
                        end
                    end
                end
            end
        end
        ybaNotify("Settings", "Server hop failed, trying random server...")
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end,
})
ybaNotify("YBA Script", "Script loaded successfully!")
warn("[YBA] Script execution completed.")

end -- END BLOCK 3

return
