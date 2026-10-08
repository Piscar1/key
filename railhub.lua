--cracked by piscar
local sourceContext = {}
sourceContext.playersService = game:GetService("Players")
sourceContext.player = sourceContext.playersService.LocalPlayer or (function()
  local LocalPlayer = sourceContext.playersService.LocalPlayer
  local timestamp2 = tick()
  while not LocalPlayer and tick() - timestamp2 < 10 do
    LocalPlayer = sourceContext.playersService.LocalPlayer
    if LocalPlayer then break end
    task.wait(0.05)
  end
  return LocalPlayer
end)()
sourceContext.entry, sourceContext.entry2 = sourceContext.player, sourceContext.player
sourceContext.playerGui = sourceContext.player and sourceContext.player:FindFirstChild("PlayerGui") or nil
sourceContext.httpServiceService2 = game:GetService("HttpService")
sourceContext.runServiceService = game:GetService("RunService")
sourceContext.userInputServiceService = game:GetService("UserInputService")
sourceContext.tweenServiceService = game:GetService("TweenService")
sourceContext.virtualInputManagerService = game:GetService("VirtualInputManager")
sourceContext.parent = game:GetService("Workspace")
sourceContext.gameReference = game
sourceContext.gameReference = sourceContext.gameReference:GetService("CollectionService")
function sourceContext.callback2(a)
  pcall(function()
    if type(makefolder) == "function" and type(isfolder) == "function" and not isfolder("RAILhubYBA") then makefolder("RAILhubYBA") end
    local Text3 = os.date("[%H:%M:%S] ") .. tostring(a) .. "\n"
    if type(appendfile) == "function" then
      appendfile("RAILhubYBA/boot_log.txt", Text3)
    elseif type(writefile) == "function" then
      local Text4 = ""
      Text4 = type(isfile) == "function" and isfile("RAILhubYBA/boot_log.txt") and type(readfile) == "function" and (readfile("RAILhubYBA/boot_log.txt") or "") or ""
      writefile("RAILhubYBA/boot_log.txt", Text4 .. Text3)
    end
  end)
end
pcall(function()
  if type(writefile) == "function" then
    if type(makefolder) == "function" and type(isfolder) == "function" and not isfolder("RAILhubYBA") then makefolder("RAILhubYBA") end
    writefile("RAILhubYBA/boot_log.txt", os.date([[=== exec start %Y-%m-%d %H:%M:%S ===
]]))
  end
end)
sourceContext.callback2("exec start")
function sourceContext.callback3()
  return sourceContext.playersService.LocalPlayer or sourceContext.player or sourceContext.player or sourceContext.player or sourceContext.playersService.LocalPlayer
end
function sourceContext.callback4()
  local entry = sourceContext.callback3()
  if entry then return entry:FindFirstChild("PlayerGui") or entry.WaitForChild and entry:WaitForChild("PlayerGui", 5) end
  return nil
end
sourceContext.enabled2, sourceContext.enabled3 = true, false
function sourceContext.callback5(a)
  if not (sourceContext.enabled2 and not sourceContext.enabled3) then return end
  if not (getgenv and getgenv()._YBA_HasEverLoaded) then return end
  local lowerResult = tostring(a or ""):lower()
  local findResult = lowerResult:find("teleport", 1, true)
  if findResult or lowerResult:find("http error", 1, true) or lowerResult:find("processing", 1, true) then return end
  sourceContext.enabled3 = true
  pcall(function()
    if sendReconnectKickWebhook then sendReconnectKickWebhook(tostring(a or "Auto Rejoin on Error / Kick")) end
  end)
  pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)
  task.wait(10)
  sourceContext.enabled3 = false
end
pcall(function()
  game:GetService("GuiService").ErrorMessageChanged:Connect(function() sourceContext.callback5("ErrorMessageChanged") end)
end)
pcall(function()
  local robloxPromptGui = (gethui and gethui() or game:GetService("CoreGui")):FindFirstChild("RobloxPromptGui")
  if robloxPromptGui then
    robloxPromptGui.DescendantAdded:Connect(function(a)
      if a:IsA("TextLabel") and (string.find(string.lower(a.Text), "kicked") or string.find(string.lower(a.Text), "error") or string.find(string.lower(a.Text), "disconnected")) and not string.find(string.lower(a.Text), "teleport") then
        sourceContext.callback5(a.Text)
      end
    end)
  end
end)
function sourceContext.callback6(a)
  if a then
    local enabled4 = false
    pcall(function()
      if type(firesignal) == "function" then
        firesignal(a)
        enabled4 = true
      end
    end)
    if not enabled4 then
      pcall(function()
        local getSignalCons = getconnections or get_signal_cons
        if getSignalCons then
          local entries = getSignalCons(a)
          if entries and #entries > 0 then
            for k, v in ipairs(entries) do
              if v.Fire then
                v:Fire()
                enabled4 = true
              elseif v.Function and type(v.Function) == "function" then
                v.Function()
                enabled4 = true
              end
            end
          end
        end
      end)
    end
    return enabled4
  end
  return false
end
function sourceContext.callback7(a)
  if a then
    local entries = {}
    pcall(function()
      if getconnections then
        entries = getconnections(a)
      elseif a.GetConnections then entries = a:GetConnections() end
    end)
    return entries or {}
  end
  return {}
end
function sourceContext.callback8(entries2, b)
  if type(table.find) == "function" then return table.find(entries2, b) end
  if type(entries2) == "table" then
    for k, v in ipairs(entries2) do if v == b then return k end end
    return nil
  end
  return nil
end
function sourceContext.callback9(a)
  if a then
    local enabled5, a2 = false, a
    if not a:IsA("GuiButton") and not a:IsA("TextButton") and not a:IsA("ImageButton") then
      local guiButton = nil
      pcall(function() guiButton = a:FindFirstChildWhichIsA("GuiButton", true) end)
      a2 = guiButton or a2
    end
    pcall(function()
      if type(firesignal) == "function" then
        if a2:IsA("GuiButton") and a2.MouseButton1Click then
          firesignal(a2.MouseButton1Click)
          enabled5 = true
        end
        if a2.Activated then
          firesignal(a2.Activated)
          enabled5 = true
        end
      end
    end)
    pcall(function()
      local getSignalCons = getconnections or get_signal_cons
      if getSignalCons and a2:IsA("GuiButton") then
        if a2.MouseButton1Click then
          local entries2 = getSignalCons(a2.MouseButton1Click)
          if entries2 and #entries2 > 0 then
            for k, v in ipairs(entries2) do
              if v.Fire then
                v:Fire()
                enabled5 = true
              elseif v.Function and type(v.Function) == "function" then
                v.Function()
                enabled5 = true
              end
            end
          end
        end
        if a2.Activated then
          local entries3 = getSignalCons(a2.Activated)
          if entries3 and #entries3 > 0 then
            for k2, v2 in ipairs(entries3) do
              if v2.Fire then
                v2:Fire()
                enabled5 = true
              elseif v2.Function and type(v2.Function) == "function" then
                v2.Function()
                enabled5 = true
              end
            end
          end
        end
      end
    end)
    pcall(function()
      local virtualInputManagerService2 = game:GetService("VirtualInputManager")
      if virtualInputManagerService2 and a2:IsA("GuiObject") then
        local AbsolutePosition = a2.AbsolutePosition
        local AbsoluteSize = a2.AbsoluteSize
        if AbsolutePosition and AbsoluteSize and AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
          local floor = math.floor
          floor = floor(AbsolutePosition.X + AbsoluteSize.X / 2)
          local floor2 = math.floor
          floor2 = floor2(AbsolutePosition.Y + AbsoluteSize.Y / 2)
          if floor > 0 and floor2 > 0 then
            virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, true, game, 1)
            virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, false, game, 1)
            enabled5 = true
          end
        end
      end
    end)
    return enabled5
  end
  return false
end
function sourceContext.callback10(a)
  if a then return sourceContext.callback9(a) end
  return false
end
function sourceContext.callback11(a) sourceContext.callback9(a) end
function sourceContext.callback12()
  local localPlayer2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
  if localPlayer2 then
    local playerGui2 = sourceContext.callback4 and sourceContext.callback4() or localPlayer2 and localPlayer2:FindFirstChild("PlayerGui")
    if playerGui2 then
      if not playerGui2:FindFirstChild("LoadingScreen1") and not playerGui2:FindFirstChild("BlackScreen") then
        local loadingScreen = playerGui2:FindFirstChild("LoadingScreen")
        if loadingScreen and loadingScreen.Enabled then return false end
        local hUD = playerGui2:FindFirstChild("HUD")
        if hUD and hUD:IsA("ScreenGui") and hUD.Enabled then return true end
        return false
      end
      return false
    end
    return false
  end
  return false
end
function sourceContext.callback13(a)
  if a then
    if a.Visible then
      local Parent = a.Parent
      local localPlayer2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
      local playerGui2 = sourceContext.callback4 and sourceContext.callback4() or localPlayer2 and localPlayer2:FindFirstChild("PlayerGui")
      while Parent do
        if Parent == playerGui2 or Parent == game then break end
        if Parent:IsA("ScreenGui") and not Parent.Enabled then return false end
        if Parent:IsA("GuiObject") and not Parent.Visible then return false end
        Parent = Parent.Parent
      end
      return true
    end
    return false
  end
  return false
end
function sourceContext.getPlayButton(a)
  local entries2 = {}
  if a then
    local loadingScreen = a:FindFirstChild("LoadingScreen")
    if loadingScreen then
      local entry = loadingScreen:FindFirstChild("Frames") or loadingScreen
      local gamemodes = entry:FindFirstChild("Gamemodes")
      if gamemodes then
        local mainGame = gamemodes:FindFirstChild("MainGame")
        if mainGame then
          local play = mainGame:FindFirstChild("Play")
          play = play or mainGame:FindFirstChildWhichIsA("GuiButton", true) or mainGame:IsA("GuiButton") and mainGame
          if play and sourceContext.callback13(play) then table.insert(entries2, play) end
        end
        local play2 = gamemodes:FindFirstChild("Play", true)
        if play2 and sourceContext.callback13(play2) and not table.find(entries2, play2) then table.insert(entries2, play2) end
      end
      local main = entry:FindFirstChild("Main")
      if main then
        local play3 = main:FindFirstChild("Play")
        if play3 and sourceContext.callback13(play3) then table.insert(entries2, play3) end
      end
      if #entries2 == 0 then
        for k, v in ipairs(entry:GetDescendants()) do
          if v.Name == "Play" and (v:IsA("GuiButton") or v:IsA("GuiObject")) and sourceContext.callback13(v) then
            table.insert(entries2, v)
            break
          end
        end
      end
      return entries2
    end
    return entries2
  end
  return entries2
end
function sourceContext.callback14()
  local localPlayer2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
  if localPlayer2 then
    local playerGui2 = sourceContext.callback4 and sourceContext.callback4() or localPlayer2 and localPlayer2:FindFirstChild("PlayerGui")
    if playerGui2 then
      local loadingScreen1 = playerGui2:FindFirstChild("LoadingScreen1")
      if loadingScreen1 and loadingScreen1.Enabled then return false end
      local blackScreen = playerGui2:FindFirstChild("BlackScreen")
      if blackScreen and blackScreen.Enabled then return false end
      local entry = sourceContext.getPlayButton(playerGui2)
      if entry and #entry > 0 then return false end
      local loadingScreen = playerGui2:FindFirstChild("LoadingScreen")
      if loadingScreen and loadingScreen.Enabled then
        local frames = loadingScreen:FindFirstChild("Frames")
        if frames and frames:IsA("GuiObject") and frames.Visible then return false end
      end
      local hUD = playerGui2:FindFirstChild("HUD")
      if hUD and hUD:IsA("ScreenGui") and hUD.Enabled then
        local living = workspace:FindFirstChild("Living")
        if living then
          local findFirstChildResult = living:FindFirstChild(localPlayer2.Name)
          if findFirstChildResult and findFirstChildResult.Parent and findFirstChildResult.Parent == living then
            local humanoid = findFirstChildResult:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart = findFirstChildResult:FindFirstChild("HumanoidRootPart")
            if humanoid and humanoidRootPart and not (humanoid.Health <= 0) then
              if humanoidRootPart.Anchored then return false end
              return true
            end
            return false
          end
          return false
        end
        return false
      end
      return false
    end
    return false
  end
  return false
end
function sourceContext.callback15(a)
  if not (a and a.Parent) then return end
  pcall(function()
    if not a:FindFirstChild("SkipCutscene") then
      local new = Instance.new("BoolValue")
      new.Name = "SkipCutscene"
      new.Value = false
      new.Parent = a
    end
  end)
end
function sourceContext.callback16()
  pcall(function()
    local localPlayer2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
    local playerGui2 = sourceContext.callback4 and sourceContext.callback4() or localPlayer2 and localPlayer2:FindFirstChild("PlayerGui")
    if not playerGui2 then return end
    local loadingScreen1 = playerGui2:FindFirstChild("LoadingScreen1")
    if loadingScreen1 then
      sourceContext.callback15(loadingScreen1)
      loadingScreen1.ChildRemoved:Connect(function(a)
        if a.Name == "SkipCutscene" and loadingScreen1.Parent then task.defer(function() sourceContext.callback15(loadingScreen1) end) end
      end)
    end
    playerGui2.ChildAdded:Connect(function(a)
      if a.Name == "LoadingScreen1" then
        sourceContext.callback15(a)
        a.ChildRemoved:Connect(function(b)
          if b.Name == "SkipCutscene" and a.Parent then task.defer(function() sourceContext.callback15(a) end) end
        end)
      end
    end)
  end)
end
task.spawn(sourceContext.callback16)
function sourceContext.callback17(a)
  pcall(function()
    if not a then return end
    sourceContext.callback2(string.format("PLAY-INFO: Name=%s, Class=%s, Path=%s, Pos=(%d,%d), Size=(%d,%d)", a.Name, a.ClassName, a:GetFullName(), a.AbsolutePosition.X, a.AbsolutePosition.Y, a.AbsoluteSize.X, a.AbsoluteSize.Y))
    for k, v in ipairs(a:GetChildren()) do sourceContext.callback2(string.format("  child: %s (%s)", v.Name, v.ClassName)) end
    local getSignalCons = getconnections or get_signal_cons
    if getSignalCons then
      local entry = ipairs
      local settings2 = { [1] = "MouseButton1Click", [2] = "Activated", [3] = "MouseButton1Down", [4] = "MouseButton1Up" }
      for k2, v2 in entry(settings2) do
        local pcallResult, entry2 = pcall(function() return a[v2] end)
        if pcallResult and entry2 then
          local entry3 = getSignalCons
          entry3 = getSignalCons(entry2)
          if entry3 and #entry3 > 0 then sourceContext.callback2(string.format("  sig %s has %d conns", v2, #entry3)) end
        end
      end
    end
  end)
end
function sourceContext.callback18(entry)
  if entry then
    local entries2 = {}
    if entry:IsA("GuiButton") then table.insert(entries2, entry) end
    for k, v in ipairs(entry:GetChildren()) do if v:IsA("GuiButton") and not table.find(entries2, v) then table.insert(entries2, v) end end
    if #entries2 == 0 then
      local guiButton2 = entry:FindFirstChildWhichIsA("GuiButton", true)
      if guiButton2 then table.insert(entries2, guiButton2) end
    end
    if #entries2 == 0 and entry.Parent and entry.Parent:IsA("GuiButton") then table.insert(entries2, entry.Parent) end
    if #entries2 == 0 then table.insert(entries2, entry) end
    local enabled6 = false
    for k2, v2 in ipairs(entries2) do
      if v2:IsA("GuiButton") and type(firesignal) == "function" then
        pcall(function()
          if v2.MouseButton1Click then
            firesignal(v2.MouseButton1Click)
            enabled6 = true
          end
          if v2.Activated then
            firesignal(v2.Activated)
            enabled6 = true
          end
          if v2.MouseButton1Up then
            firesignal(v2.MouseButton1Up)
            enabled6 = true
          end
        end)
      end
      local getconnections2 = getconnections
      getconnections2 = getconnections2 or get_signal_cons
      if getconnections2 and v2:IsA("GuiButton") then
        pcall(function()
          local entry = ipairs
          local settings2 = { [1] = "MouseButton1Click", [2] = "Activated", [3] = "MouseButton1Up", [4] = "MouseButton1Down" }
          for k2, v3 in entry(settings2) do
            local pcallResult, entry2 = pcall(function() return v2[v3] end)
            if pcallResult and entry2 then
              local getconnections2Result = getconnections2(entry2)
              if getconnections2Result and #getconnections2Result > 0 then
                for k, v in ipairs(getconnections2Result) do
                  if v.Fire then
                    pcall(function() v:Fire() end)
                    enabled6 = true
                  elseif v.Function and type(v.Function) == "function" then
                    pcall(v.Function)
                    enabled6 = true
                  end
                end
              end
            end
          end
        end)
      end
      pcall(function()
        if v2:IsA("GuiObject") then
          local AbsolutePosition = v2.AbsolutePosition
          local AbsoluteSize = v2.AbsoluteSize
          if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
            local virtualInputManagerService2 = game:GetService("VirtualInputManager")
            if virtualInputManagerService2 then
              local getGuiInsetResult = game:GetService("GuiService"):GetGuiInset()
              local floor = math.floor(AbsolutePosition.X + AbsoluteSize.X / 2)
              local floor2 = math.floor(AbsolutePosition.Y + AbsoluteSize.Y / 2)
              virtualInputManagerService2:SendMouseMoveEvent(floor, floor2, game)
              virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, true, game, 1)
              task.wait(0.04)
              virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, false, game, 1)
              if getGuiInsetResult.Y > 0 then
                local floor3 = math.floor(getGuiInsetResult.Y)
                floor3 = floor2 + floor3
                virtualInputManagerService2:SendMouseMoveEvent(floor, floor3, game)
                virtualInputManagerService2:SendMouseButtonEvent(floor, floor3, 0, true, game, 1)
                task.wait(0.04)
                virtualInputManagerService2:SendMouseButtonEvent(floor, floor3, 0, false, game, 1)
              end
              enabled6 = true
            end
          end
        end
      end)
      pcall(function()
        if v2:IsA("GuiObject") then
          local virtualUserService = game:GetService("VirtualUser")
          if virtualUserService then
            virtualUserService:CaptureController()
            local AbsolutePosition = v2.AbsolutePosition
            local AbsoluteSize = v2.AbsoluteSize
            if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
              local new = Vector2.new(math.floor(AbsolutePosition.X + AbsoluteSize.X / 2), math.floor(AbsolutePosition.Y + AbsoluteSize.Y / 2))
              virtualUserService:ClickButton1(new)
              enabled6 = true
            end
          end
        end
      end)
    end
    pcall(function()
      local player2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
      local findFirstChildResult = player2 and (player2.Character or workspace:FindFirstChild("Living") and workspace.Living:FindFirstChild(player2.Name))
      if findFirstChildResult then
        local remoteEvent = findFirstChildResult:FindFirstChild("RemoteEvent")
        if remoteEvent then remoteEvent:FireServer("PressedPlay") end
      end
    end)
    return enabled6
  end
  return false
end
sourceContext.enabled7 = false
function sourceContext.callback19()
  local playerGui2, entry, count, enabled8, ipairsResult, entry2, entry3
  local parent2
  if sourceContext.enabled7 then return end
  sourceContext.enabled7 = true
  if sourceContext.callback14 and sourceContext.callback14() then
    if getgenv then getgenv()._YBA_HasEverLoaded = true end
    sourceContext.enabled7 = false
    return true
  end
  sourceContext.callback2("AutoPlay: waiting for game to load to menu...")
  local player2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
  if not sourceContext.callback4 or not sourceContext.callback4() then
    if player2 then
      playerGui2 = player2:FindFirstChild("PlayerGui")
    else

    end
  end
  local timestamp2 = tick()
  sourceContext.callback16()
  while tick() - timestamp2 < 60 do
    if sourceContext.callback14 and sourceContext.callback14() then
      if getgenv then getgenv()._YBA_HasEverLoaded = true end
      sourceContext.callback2("AutoPlay: already in main game")
      sourceContext.enabled7 = false
      return true
    end
    local playerGui3 = sourceContext.callback4 and sourceContext.callback4() or player2 and player2:FindFirstChild("PlayerGui")
    if playerGui3 then
      local loadingScreen12 = playerGui3:FindFirstChild("LoadingScreen1")
      if loadingScreen12 then sourceContext.callback15(loadingScreen12) end
      local entry4 = sourceContext.getPlayButton(playerGui3)
      if entry4 and #entry4 > 0 then
        sourceContext.callback2("AutoPlay: menu detected")
        break
      end
      local loadingScreen = playerGui3:FindFirstChild("LoadingScreen")
      if not loadingScreen12 and loadingScreen and loadingScreen.Enabled then
        sourceContext.callback2("AutoPlay: menu detected")
        break
      end
    end
    task.wait(0.3)
  end
  task.wait(0.5)
  sourceContext.callback2("AutoPlay: attempting to click Play button...")
  count, enabled8 = 0, false
  while count < 30 do
    if sourceContext.callback14 and sourceContext.callback14() then
      sourceContext.callback2("AutoPlay: successfully loaded into main game!")
      if getgenv then getgenv()._YBA_HasEverLoaded = true end
      sourceContext.enabled7 = false
      return true
    end
    parent2 = sourceContext.callback4 and sourceContext.callback4() or player2 and player2:FindFirstChild("PlayerGui")
    local entries2 = sourceContext.getPlayButton(parent2)
    if entries2 and #entries2 > 0 then
      ipairsResult, entry2, entry3 = ipairs(entries2)
      for k, v in ipairsResult, entry2, entry3 do
        count = count + 1
        if not enabled8 then
          enabled8 = true
          sourceContext.callback17(v)
        end
        sourceContext.callback18(v)
        task.wait(0.15)
      end
    else
      count = count + 1
      pcall(function()
        local findFirstChildResult = player2 and (player2.Character or workspace:FindFirstChild("Living") and workspace.Living:FindFirstChild(player2.Name))
        if findFirstChildResult then
          local remoteEvent = findFirstChildResult:FindFirstChild("RemoteEvent")
          if remoteEvent then remoteEvent:FireServer("PressedPlay") end
        end
      end)
    end
    if count >= 4 and parent2 then
      local loadingScreen2 = parent2:FindFirstChild("LoadingScreen")
      if loadingScreen2 and loadingScreen2.Enabled then
        pcall(function()
          sourceContext.callback2("AutoPlay: applying proven YBA game entry fallback (PressedPlay + HUD clone)...")
          local findFirstChildResult = player2 and (player2.Character or workspace:FindFirstChild("Living") and workspace.Living:FindFirstChild(player2.Name))
          if findFirstChildResult then
            local remoteEvent = findFirstChildResult:FindFirstChild("RemoteEvent")
            if remoteEvent then remoteEvent:FireServer("PressedPlay") end
          end
          if not parent2:FindFirstChild("HUD") then
            local objects = game:GetService("ReplicatedStorage"):FindFirstChild("Objects")
            local hUD = objects and objects:FindFirstChild("HUD")
            if hUD then hUD:Clone().Parent = parent2 end
          end
          local loadingScreen12 = parent2:FindFirstChild("LoadingScreen1")
          if loadingScreen12 then
            pcall(function() loadingScreen12.Enabled = false end)
            pcall(function() loadingScreen12:Destroy() end)
          end
          if loadingScreen2 then
            pcall(function() loadingScreen2.Enabled = false end)
            pcall(function() loadingScreen2:Destroy() end)
          end
          local loadingScreen = workspace:FindFirstChild("LoadingScreen")
          if loadingScreen and loadingScreen:FindFirstChild("Song") then pcall(function() loadingScreen.Song:Destroy() end) end
          local lightingService = game:GetService("Lighting")
          lightingService = lightingService:FindFirstChild("DepthOfField")
          if lightingService then pcall(function() lightingService:Destroy() end) end
        end)
      end
    end
    task.wait(0.5)
  end
  local timestamp3 = tick()
  while tick() - timestamp3 < 30 do
    if sourceContext.callback14 and sourceContext.callback14() then
      if getgenv then getgenv()._YBA_HasEverLoaded = true end
      sourceContext.callback2("AutoPlay: successfully loaded into main game!")
      sourceContext.enabled7 = false
      return true
    end
    task.wait(0.4)
  end
  sourceContext.enabled7 = false
  return sourceContext.callback14 and sourceContext.callback14() or false
end
task.spawn(function() pcall(sourceContext.callback19) end)
task.spawn(function()
  while not sourceContext.callback14 or not sourceContext.callback14() do task.wait(1) end
  if getgenv then getgenv()._YBA_HasEverLoaded = true end
  sourceContext.callback2("FIRST SPAWN (strict main game) reached")
end)
function sourceContext.callback20()
  if sourceContext.callback14 and sourceContext.callback14() then
    if isAutoFarming == true then return true end
    if SF and SF.standFarmRunning == true then return true end
    if CFG and (CFG.ItemFarmEnabled == true or CFG.StandFarmEnabled == true) then return true end
    if AutoPrestige ~= true and autoStoryLine ~= true then
      if sellingBusy ~= true and (not getgenv or getgenv()._YBA_SellingBusy ~= true) then
        if isEatingRoka ~= true and (not getgenv or getgenv()._YBA_IsEatingRoka ~= true) then return false end
        return true
      end
      return true
    end
    return true
  end
  return false
end
function sourceContext.callback21(a)
  if not a then return end
  pcall(function()
    local frame = a:FindFirstChild("Frame")
    frame = frame or a:FindFirstChildWhichIsA("Frame") or a
    if not (frame and frame.Visible) then return end
    local clickContinue = frame:FindFirstChild("ClickContinue", true)
    if clickContinue and clickContinue.Visible then sourceContext.callback9(clickContinue) end
    local dialogueFrame = frame:FindFirstChild("DialogueFrame", true)
    if dialogueFrame and dialogueFrame:IsA("GuiObject") then sourceContext.callback9(dialogueFrame) end
    local virtualInputManagerService2 = game:GetService("VirtualInputManager")
    if virtualInputManagerService2 then
      local AbsolutePosition = frame.AbsolutePosition
      local AbsoluteSize = frame.AbsoluteSize
      if AbsoluteSize and AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
        local floor = math.floor
        floor = floor(AbsolutePosition.X + AbsoluteSize.X / 2)
        local floor2 = math.floor
        floor2 = floor2(AbsolutePosition.Y + AbsoluteSize.Y / 2)
        if floor > 0 and floor2 > 0 then
          virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, true, game, 1)
          virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, false, game, 1)
        end
      end
    end
  end)
end
task.spawn(function()
  while true do
    task.wait(0.15)
    pcall(function()
      if not sourceContext.callback20() then return end
      local playerGui2 = sourceContext.player and (sourceContext.player:FindFirstChild("PlayerGui") or pcall(function() return sourceContext.player.PlayerGui end) and sourceContext.player.PlayerGui)
      if not playerGui2 then return end
      local entry = ipairs
      local settings2 = { [1] = "DialogueGui", [2] = "Dialogue", [3] = "NPCDialogue" }
      for k2, v2 in entry(settings2) do
        local findFirstChildResult = playerGui2:FindFirstChild(v2)
        if findFirstChildResult and (findFirstChildResult.Enabled or findFirstChildResult:FindFirstChild("Frame") and findFirstChildResult.Frame.Visible) then
          local FindFirstChild = findFirstChildResult.FindFirstChild
          FindFirstChild = FindFirstChild(findFirstChildResult, "Frame") or findFirstChildResult
          if FindFirstChild and FindFirstChild.Visible then
            local options = FindFirstChild:FindFirstChild("Options")
            local enabled8
            if options and options.Visible then
              local ipairsResult, entry2, entry3 = ipairs(options:GetChildren())
              enabled8 = false
              for k, v in ipairsResult, entry2, entry3 do
                if v:IsA("GuiObject") and v.Visible and v.Name ~= "UIListLayout" and v.Name ~= "UIPadding" and v.Name ~= "UIGridLayout" then
                  enabled8 = true
                  break
                end
              end
            else
              enabled8 = false
            end
            if not enabled8 then sourceContext.callback21(findFirstChildResult) end
          end
        end
      end
    end)
  end
end)
function sourceContext.callback22()
  pcall(function()
    local player3 = game.Players.LocalPlayer or sourceContext.player
    local character = player3 and player3.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid:UnequipTools() end
    local playerGui2 = player3 and player3:FindFirstChild("PlayerGui")
    if not playerGui2 then return end
    local virtualInputManagerService2 = game:GetService("VirtualInputManager")
    local virtualUserService = game:GetService("VirtualUser")
    local CurrentCamera = workspace.CurrentCamera
    local newResult = CurrentCamera and CurrentCamera.ViewportSize or Vector2.new(1024, 768)
    local floor = math.floor(newResult.X / 2)
    local floor2 = math.floor(newResult.Y * 0.72)
    for i = 1, 3 do
      local enabled8 = false
      local ipairsResult, entry, entry2 = ipairs({ [1] = "DialogueGui", [2] = "Dialogue", [3] = "NPCDialogue" })
      for k, v in ipairsResult, entry, entry2 do
        local findFirstChildResult = playerGui2:FindFirstChild(v)
        if findFirstChildResult and (findFirstChildResult.Enabled or findFirstChildResult:FindFirstChild("Frame") and findFirstChildResult.Frame.Visible) then
          enabled8 = true
          local FindFirstChild = findFirstChildResult.FindFirstChild
          FindFirstChild = FindFirstChild(findFirstChildResult, "Frame") or findFirstChildResult
          local clickContinue = FindFirstChild:FindFirstChild("ClickContinue", true)
          if clickContinue then sourceContext.callback9(clickContinue) end
          local dialogueFrame = FindFirstChild:FindFirstChild("DialogueFrame", true)
          if dialogueFrame then sourceContext.callback9(dialogueFrame) end
        end
      end
      if virtualInputManagerService2 then
        virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, true, game, 1)
        virtualInputManagerService2:SendMouseButtonEvent(floor, floor2, 0, false, game, 1)
        virtualInputManagerService2:SendMouseButtonEvent(floor, math.floor(newResult.Y * 0.5), 0, true, game, 1)
        virtualInputManagerService2:SendMouseButtonEvent(floor, math.floor(newResult.Y * 0.5), 0, false, game, 1)
      end
      if virtualUserService then
        pcall(function()
          virtualUserService:CaptureController()
          virtualUserService:ClickButton1(Vector2.new(floor, floor2))
        end)
      end
      if not enabled8 and i > 1 then break end
      sourceContext.runServiceService.Heartbeat:Wait()
    end
    local entry3 = ipairs
    local settings2 = { [1] = "DialogueGui", [2] = "Dialogue", [3] = "NPCDialogue" }
    for k2, v2 in entry3(settings2) do
      local findFirstChildResult2 = playerGui2:FindFirstChild(v2)
      if findFirstChildResult2 then
        if findFirstChildResult2:FindFirstChild("Frame") then findFirstChildResult2.Frame.Visible = false end
        findFirstChildResult2.Enabled = false
      end
    end
    if humanoid then humanoid:UnequipTools() end
  end)
end
function sourceContext.callback23(a) if a then sourceContext.callback9(a) end end
sourceContext.connectResult = nil
function sourceContext.callback24(a)
  pcall(function()
    if getconnections then for k, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do if a then v:Disable() else v:Enable() end end end
  end)
  if a then
    if not sourceContext.connectResult then
      sourceContext.connectResult = game:GetService("Players").LocalPlayer.Idled:Connect(function()
        pcall(function()
          game:GetService("VirtualUser"):CaptureController()
          game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
      end)
    end
  elseif sourceContext.connectResult then
    sourceContext.connectResult:Disconnect()
    sourceContext.connectResult = nil
  end
end
pcall(function() sourceContext.callback24(not getSavedFlag or getSavedFlag("AA", true) or true) end)
function sourceContext.callback25()
  local pcallResult, entry = pcall(function()
    local statsService = game:GetService("Stats")
    local network = statsService and statsService:FindFirstChild("Network")
    local serverStatsItem = network and network:FindFirstChild("ServerStatsItem")
    local dataPing = serverStatsItem and serverStatsItem:FindFirstChild("Data Ping")
    if not (dataPing and dataPing.GetValue) then return end
    return dataPing:GetValue()
  end)
  if pcallResult and type(entry) == "number" and entry > 0 then return entry end
  return 100
end
function sourceContext.callback26(entry)
  local number = tonumber(entry)
  entry = if number then number else 0.45
  number = sourceContext.callback25
  number = sourceContext.callback25()
  return entry + number / 1000 * (number < 60 and 0.6 or 0.3)
end
sourceContext.enabled8, sourceContext.enabled9 = false, false
sourceContext.getgenv2 = getgenv()
sourceContext.getgenv2._YBA_SellingBusy = false
sourceContext.getgenv2 = getgenv
sourceContext.getgenv2 = sourceContext.getgenv2()
sourceContext.getgenv2._YBA_IsEatingRoka = false
function sourceContext.getgenv2()
  local player3 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
  if player3 then
    local findFirstChildResult = player3.Character or workspace:FindFirstChild("Living") and workspace.Living:FindFirstChild(player3.Name)
    if findFirstChildResult and findFirstChildResult.Parent and (not workspace:FindFirstChild("Living") or findFirstChildResult.Parent == workspace.Living) then
      local humanoid = findFirstChildResult:FindFirstChildOfClass("Humanoid")
      local humanoidRootPart = findFirstChildResult:FindFirstChild("HumanoidRootPart")
      if humanoid and humanoidRootPart and not (humanoid.Health <= 0) then
        if humanoid:GetState() == Enum.HumanoidStateType.Dead then return true end
        return false
      end
      return true
    end
    return true
  end
  return true
end
function sourceContext.callback27(a)
  a = a or 0.5
  if sourceContext.getgenv2() then
    warn("[Respawn] Player is dead or despawned. Pausing farm and waiting for respawn...")
    if cleanupItemStick then pcall(cleanupItemStick) end
    if stopMoveTween then pcall(stopMoveTween) end
    local player3 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
    while sourceContext.getgenv2() do task.wait(0.1) end
    local clock = os.clock()
    while os.clock() - clock < 15 do
      local findFirstChildResult = player3 and (player3.Character or workspace:FindFirstChild("Living") and workspace.Living:FindFirstChild(player3.Name))
      local humanoid = findFirstChildResult and findFirstChildResult:FindFirstChildOfClass("Humanoid")
      local humanoidRootPart = findFirstChildResult and findFirstChildResult:FindFirstChild("HumanoidRootPart")
      if findFirstChildResult and humanoid and humanoidRootPart and humanoid.Health > 0 and (not workspace:FindFirstChild("Living") or findFirstChildResult.Parent == workspace.Living) then
        break
      end
      task.wait(0.05)
    end
    task.wait(a)
    warn("[Respawn] Character fully respawned! Waited " .. tostring(a) .. "s. Resuming farm.")
    return true
  end
  return true
end
pcall(function()
  local function callback(a)
    if not a then return end
    local humanoid = a:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    humanoid.Died:Connect(function()
      local Text3 = getgenv and getgenv()._YBA_LastSellItem or "?"
      local count = -1
      pcall(function()
        local count2 = getgenv and getgenv()._YBA_LastSellTick or 0
        count = tick() - (count2 or 0)
      end)
      local Text4 = "?"
      pcall(function() Text4 = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "?" end)
      warn(string.format("[DeathDbg] DIED selling=%s eating=%s lastSell=%s %.1fs ago stand=%s pos=%s hp=%s", tostring(sourceContext.enabled9 or getgenv and getgenv()._YBA_SellingBusy), tostring(sourceContext.enabled8 or getgenv and getgenv()._YBA_IsEatingRoka), tostring(Text3), tonumber(count) or -1, tostring(Text4), tostring((function()
        local humanoidRootPart = a:FindFirstChild("HumanoidRootPart")
        return humanoidRootPart and humanoidRootPart.Position or nil
      end)()), tostring((function()
        local humanoid = a:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.Health .. "/" .. humanoid.MaxHealth or nil
      end)())))
    end)
  end
  local player3 = sourceContext.playersService.LocalPlayer or sourceContext.player
  if player3 then
    if player3.Character then callback(player3.Character) end
    player3.CharacterAdded:Connect(function(a)
      task.wait(0.5)
      callback(a)
    end)
  end
end)
sourceContext.count2 = 0
function sourceContext.callback28()
  if not sourceContext.enabled8 and (not SF or not SF.isEatingRoka) and not getgenv()._YBA_IsEatingRoka then
    if not sourceContext.enabled9 and not getgenv()._YBA_SellingBusy then
      if sourceContext.getgenv2() then return true end
      local player3 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
      local findFirstChildResult = player3 and (player3.Character or workspace:FindFirstChild("Living") and workspace.Living:FindFirstChild(player3.Name))
      local humanoidRootPart = findFirstChildResult and findFirstChildResult:FindFirstChild("HumanoidRootPart")
      if humanoidRootPart and humanoidRootPart.Anchored == true then return true end
      local playerGui2 = sourceContext.callback4 and sourceContext.callback4() or player3 and player3:FindFirstChild("PlayerGui")
      local dialogueGui = playerGui2 and playerGui2:FindFirstChild("DialogueGui")
      if dialogueGui and dialogueGui.Enabled and dialogueGui:FindFirstChild("Frame") and dialogueGui.Frame.Visible then
        local timestamp2 = tick()
        if sourceContext.count2 == 0 then
          sourceContext.count2 = timestamp2
        elseif timestamp2 - sourceContext.count2 > 4 then
          if sourceContext.callback20 and sourceContext.callback20() and sourceContext.callback22 then pcall(sourceContext.callback22) end
          sourceContext.count2 = 0
          return false
        end
        return true
      end
      sourceContext.count2 = 0
      return false
    end
    return true
  end
  return true
end
function sourceContext.callback29(a)
  a = tostring(a or "None")
  if a ~= "Beach Boy" and a ~= "Anubis" then return 3.8 end
  return 6.8
end
sourceContext.RAILhub_YBA_Loaded = getgenv()
sourceContext.RAILhub_YBA_Loaded = sourceContext.RAILhub_YBA_Loaded.RAILhub_YBA_Loaded
if sourceContext.RAILhub_YBA_Loaded then
  local entry3 = sourceContext.callback4 and sourceContext.callback4() or sourceContext.playerGui
  local hUD, hUDText
  if entry3 then hUD, hUDText = entry3:FindFirstChild("HUD"), "HUD" else hUD, hUDText = entry3, nil end
  if hUD and hUD:IsA("ScreenGui") and hUD.Enabled then
    local _lastRunningWarn = getgenv()
    _lastRunningWarn = _lastRunningWarn._lastRunningWarn
    _lastRunningWarn = _lastRunningWarn or 0
    if tick() - _lastRunningWarn > 5 then
      getgenv()._lastRunningWarn = tick()
      warn("[RAILhub] Script already running.")
    end
    return
  end
end
sourceContext.environment = getgenv()
sourceContext.environment.RAILhub_YBA_Loaded = true
sourceContext.environment = "RAILhubYBA"
sourceContext.customFlagsJsonText = sourceContext.environment .. "/custom_flags.json"
sourceContext.settings2 = {
  AutoExecute = true, SaveSettings = true, AutoRetry = true, ItemFarmEnabled = false, StandFarmEnabled = false,
  PilotEnabled = false, AntiAfk = true,
}
function sourceContext.normalizeJsonValue(entries2, b)
  local typeResult2 = type(entries2)
  if typeResult2 ~= "nil" and typeResult2 ~= "boolean" and typeResult2 ~= "number" and typeResult2 ~= "string" then
    if typeResult2 == "userdata" then return tostring(entries2) end
    if typeResult2 == "table" then
      b = b or {}
      if b[entries2] then return nil end
      b[entries2] = true
      local enabled10, count3 = true, 0
      for entry in pairs(entries2) do
        if type(entry) ~= "number" or entry < 1 or entry % 1 ~= 0 then
          enabled10 = false
          break
        end
        if count3 < entry then count3 = entry end
      end
      local entries3 = {}
      if enabled10 then
        for i = 1, count3 do entries3[i] = sourceContext.normalizeJsonValue(entries2[i], b) end
      else
        for k, v in pairs(entries2) do entries3[tostring(k)] = sourceContext.normalizeJsonValue(v, b) end
      end
      b[entries2] = nil
      return entries3
    end
    return tostring(entries2)
  end
  return entries2
end
function sourceContext.callback30()
  if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder(sourceContext.environment) then makefolder(sourceContext.environment) end
end
function sourceContext.callback31()
  if type(readfile) == "function" and type(isfile) == "function" then
    if isfile(sourceContext.customFlagsJsonText) then
      local pcallResult, entry = pcall(readfile, sourceContext.customFlagsJsonText)
      if pcallResult and type(entry) == "string" and entry ~= "" then
        local pcallResult2, entry2 = pcall(function() return sourceContext.httpServiceService2:JSONDecode(entry) end)
        if pcallResult2 and type(entry2) == "table" then return entry2 end
        return nil
      end
      return nil
    end
    return nil
  end
  return nil
end
function sourceContext.callback32(a)
  if type(writefile) == "function" then
    sourceContext.callback30()
    local pcallResult, entry2 = pcall(function() return sourceContext.httpServiceService2:JSONEncode(sourceContext.normalizeJsonValue(a or {})) end)
    if pcallResult and type(entry2) == "string" then return pcall(writefile, sourceContext.customFlagsJsonText, entry2) end
    return false
  end
  return false
end
function sourceContext.callback33()
  local entry2 = sourceContext.callback31()
  return type(entry2) == "table" and entry2 or {}
end
sourceContext.entry4 = sourceContext.callback33()
sourceContext.callback2("settings loaded")
sourceContext.enabled10 = false
pcall(function()
  if type(isfile) == "function" and isfile(sourceContext.environment .. "/NO_AUTOSTART.txt") then sourceContext.enabled10 = true end
  if getgenv and getgenv().RAILHUB_SAFE_MODE then sourceContext.enabled10 = true end
end)
if sourceContext.enabled10 then
  warn("[YBA] SAFE MODE: all autostarts disabled (NO_AUTOSTART.txt present)")
  sourceContext.callback2("SAFE MODE on: autostarts disabled")
end
sourceContext.enabled11 = false
pcall(function()
  if type(isfile) == "function" and isfile(sourceContext.environment .. "/NO_UI.txt") then sourceContext.enabled11 = true end
  if getgenv and getgenv().RAILHUB_HEADLESS then sourceContext.enabled11 = true end
end)
if sourceContext.enabled11 then
  warn("[YBA] HEADLESS MODE: exiting, game loading untouched")
  sourceContext.callback2("HEADLESS on: exiting before MacLib/UI/hooks/farms")
  return
end
function sourceContext.callback34(a, b)
  sourceContext.entry4[a] = b
  if sourceContext.settings2.SaveSettings or a == "SS" or a == "AE" or a == "AR" then sourceContext.callback32(sourceContext.entry4) end
end
function sourceContext.callback35(a, b)
  if sourceContext.entry4[a] == nil then return b end
  return sourceContext.entry4[a]
end
function sourceContext.callback36()
  if type(sourceContext.entry4) == "table" then
    if type(table.clear) == "function" then table.clear(sourceContext.entry4) else for entry2 in pairs(sourceContext.entry4) do sourceContext.entry4[entry2] = nil end end
  end
  pcall(function()
    if type(delfile) == "function" and type(isfile) == "function" and isfile(sourceContext.customFlagsJsonText) then
      delfile(sourceContext.customFlagsJsonText)
    elseif type(writefile) == "function" then sourceContext.callback32({}) end
  end)
  sourceContext.settings2.SaveSettings = true
  sourceContext.settings2.AutoExecute = true
  sourceContext.settings2.AutoRetry = true
  sourceContext.settings2.ItemFarmEnabled = false
  sourceContext.settings2.StandFarmEnabled = false
  sourceContext.settings2.PilotEnabled = false
  sourceContext.settings2.AntiAfk = true
end
function sourceContext.getAutoExecuteDirectory()
  return syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport or krnl and krnl.queue_on_teleport or delta and delta.queue_on_teleport or queue_on_teleport or getgenv and getgenv().queue_on_teleport or identifyexecutor and getgenv and getgenv().queue_on_teleport
end
sourceContext.count3 = 0
function sourceContext.setAutoExecute()
  -- Remote auto-reload would restore the removed authorization block.
  sourceContext.settings2.AutoExecute = false
  if getgenv then getgenv().RAILHUB_AUTOEXEC = nil end
end
pcall(function()
  local localPlayer2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
  if localPlayer2 and localPlayer2.OnTeleport then
    localPlayer2.OnTeleport:Connect(function(a)
      if (a == Enum.TeleportState.Started or a == 0) and sourceContext.setAutoExecute then pcall(sourceContext.setAutoExecute, true) end
    end)
  end
end)
function applySavedConfig()
  if sourceContext.entry4.SS ~= nil then sourceContext.settings2.SaveSettings = sourceContext.entry4.SS end
  if sourceContext.entry4.AE ~= nil then sourceContext.settings2.AutoExecute = sourceContext.entry4.AE end
  if sourceContext.entry4.AR ~= nil then sourceContext.settings2.AutoRetry = sourceContext.entry4.AR end
  if not sourceContext.settings2.SaveSettings then return end
  if sourceContext.entry4.IF ~= nil then sourceContext.settings2.ItemFarmEnabled = sourceContext.entry4.IF end
  if sourceContext.entry4.SF ~= nil then sourceContext.settings2.StandFarmEnabled = sourceContext.entry4.SF end
  if sourceContext.entry4.PE ~= nil then sourceContext.settings2.PilotEnabled = sourceContext.entry4.PE end
  if sourceContext.entry4.AA ~= nil then sourceContext.settings2.AntiAfk = sourceContext.entry4.AA end
  if sourceContext.entry4.APWH ~= nil and type(sourceContext.entry4.APWH) == "string" and sourceContext.entry4.APWH ~= "" then
    getgenv().webhook = sourceContext.entry4.APWH
  end
end
applySavedConfig()
sourceContext.setAutoExecute()
if not sourceContext.callback14 or not sourceContext.callback14() then
  sourceContext.callback2("Waiting for strict main game before initializing RAILhub UI & features...")
  local timestamp2 = tick()
  repeat
    if sourceContext.callback14 and sourceContext.callback14() then break end
    task.wait(0.5)
  until tick() - timestamp2 > 180
  sourceContext.callback2("Warning: Timed out waiting for main game, forcing UI initialization")
end
sourceContext.callback2("In main game! Proceeding with MacLib & UI init...")
sourceContext.entry5 = nil
function sourceContext.loadMacLib()
  local settings3 = {
    [1] = "https://raw.githubusercontent.com/AZX0OZ/maclib/refs/heads/main/maclib",
    [2] = "https://cdn.jsdelivr.net/gh/AZX0OZ/maclib@main/maclib",
  }
  for k, v in ipairs(settings3) do
    local pcallResult, entry3 = pcall(function() return game:HttpGet(v) end)
    if pcallResult and type(entry3) == "string" and #entry3 > 1000 and not entry3:find("429: Too Many Requests") and not entry3:find("<html") then return entry3 end
  end
  return nil
end
sourceContext.getgenv5 = sourceContext.callback2
sourceContext.callback2("downloading maclib...")
sourceContext.getgenv5 = sourceContext.loadMacLib
sourceContext.getgenv5 = sourceContext.loadMacLib()
if not sourceContext.getgenv5 then
  getgenv().RAILhub_YBA_Loaded = nil
  warn("[RAILhub] Failed to download MacLib from GitHub!")
  return
end
sourceContext.loadstring2 = sourceContext.getgenv5:gsub('globe%s*=%s*"rbxassetid://%d+"', 'globe = "rbxassetid://4677859281"')
sourceContext.getgenv5 = sourceContext.loadstring2
sourceContext.loadstring2 = sourceContext.loadstring2:gsub('globe%s*=%s*"%d+"', 'globe = "rbxassetid://4677859281"')
sourceContext.getgenv5 = sourceContext.loadstring2
sourceContext.loadstring2 = sourceContext.loadstring2:gsub("isSelected%s*=%s*%(DropdownFunctions%.Settings%.Default%s*==%s*i%)%s*and%s*true%s*or%s*false", "isSelected = ((DropdownFunctions.Settings.Default == i) or (DropdownFunctions.Settings.Default == v)) and true or false")
sourceContext.getgenv5 = sourceContext.loadstring2
sourceContext.getgenv5 = sourceContext.loadstring2:gsub("isSelected%s*=%s*table%.find%(DropdownFunctions%.Settings%.Default,%s*v%)%s*and%s*true%s*or%s*false", 'isSelected = ((type(DropdownFunctions.Settings.Default) == "table" and (table.find(DropdownFunctions.Settings.Default, v) ~= nil or DropdownFunctions.Settings.Default[v] == true)) or DropdownFunctions.Settings.Default == v) and true or false')
sourceContext.entry5 = loadstring(sourceContext.getgenv5)()
sourceContext.loadstring2 = sourceContext.callback2
sourceContext.callback2("maclib loaded")
if not getgenv or not getgenv() then local _ = _G end
getgenv().ItemStickConnections = getgenv().ItemStickConnections or {}
getgenv().InstantMethod = sourceContext.callback35 and sourceContext.callback35("FarmPosMethod", "Up") or getgenv().InstantMethod or "Up"
getgenv().SafePlaceCollectionMode = getgenv().SafePlaceCollectionMode or "Batch Collect"
sourceContext.getgenv5 = getgenv
sourceContext.getgenv5 = sourceContext.getgenv5 and getgenv() or _G
sourceContext.yBARUNTIME = sourceContext.getgenv5.__YBA_RUNTIME
sourceContext.yBARUNTIME2 = type(sourceContext.yBARUNTIME)
if sourceContext.yBARUNTIME2 == "table" and type(sourceContext.yBARUNTIME.Shutdown) == "function" then sourceContext.yBARUNTIME:Shutdown() end
sourceContext.yBARUNTIME2 = { Stopped = false }
sourceContext.extractInviteCode = {}
sourceContext.yBARUNTIME2.Guis = sourceContext.extractInviteCode
sourceContext.getgenv5.__YBA_RUNTIME = sourceContext.yBARUNTIME2
function sourceContext.extractInviteCode(a)
  if a.Stopped then return end
  pcall(function()
    if type(sourceContext.yBARUNTIME2._itemFarmStop) == "function" then sourceContext.yBARUNTIME2._itemFarmStop() end
  end)
  a.Stopped = true
  for k, v in ipairs(a.Guis) do if v and v.Parent then v:Destroy() end end
end
sourceContext.yBARUNTIME2.Shutdown = sourceContext.extractInviteCode
sourceContext.extractInviteCode = {}
sourceContext.extractInviteCode[#sourceContext.extractInviteCode + 1] = gethui and gethui() or game:GetService("CoreGui")
sourceContext.playerGui2 = sourceContext.player and sourceContext.player:FindFirstChildOfClass("PlayerGui")
if sourceContext.playerGui2 then sourceContext.extractInviteCode[#sourceContext.extractInviteCode + 1] = sourceContext.playerGui2 end
sourceContext.copyDiscordLink, sourceContext.entry8, sourceContext.entry9 = ipairs(sourceContext.extractInviteCode)
for k2, v2 in sourceContext.copyDiscordLink, sourceContext.entry8, sourceContext.entry9 do
  local ipairsResult, entry10, entry11 = ipairs(v2:GetChildren())
  for k, v in ipairsResult, entry10, entry11 do if v:IsA("ScreenGui") and (v.Name == "RAILhubToggle" or v.Name == "RAILhubWatermark") then v:Destroy() end end
end
function sourceContext.extractInviteCode(a)
  if type(a) == "string" then
    local normalizedText2 = a:gsub("^%s+", ""):gsub("%s+$", ""):gsub("^https?://", "")
    normalizedText2 = normalizedText2:gsub("^www%.", "")
    normalizedText2 = normalizedText2:gsub("^discord%.gg/", "")
    normalizedText2 = normalizedText2:gsub("^discord%.com/invite/", "")
    normalizedText2 = normalizedText2:gsub("^invite/", "")
    normalizedText2 = normalizedText2:gsub("[/?#].*$", "")
    if normalizedText2 == "" then return nil end
    return normalizedText2
  end
  return nil
end
function sourceContext.copyDiscordInvite(code)
  if type(code) ~= "string" or code == "" then return false end
  local copy = setclipboard or toclipboard
  if type(copy) ~= "function" then return false end
  return pcall(copy, "https://discord.gg/" .. code)
end
function sourceContext.copyDiscordLink(a)
  if a and a ~= "" then
    if setclipboard then
      setclipboard(a)
    elseif toclipboard then toclipboard(a) end
    local entry3 = sourceContext.extractInviteCode(a)
    if entry3 then sourceContext.copyDiscordInvite(entry3) end
  end
end
sourceContext.RAILhubWindow = nil
sourceContext.entry9 = nil
function sourceContext.notify(a, b)
  local rAILhubWindow = sourceContext.RAILhubWindow or getgenv().RAILhubWindow or _G.RAILhubWindow
  if rAILhubWindow and type(rAILhubWindow.Notify) == "function" then
    pcall(function()
      local Notify = rAILhubWindow.Notify
      local entries2 = {}
      entries2.Title = tostring(a or "RAIL Hub")
      entries2.Description = tostring(b or "")
      entries2.Lifetime = 5
      Notify(rAILhubWindow, entries2)
    end)
  end
end
sourceContext.settings3 = {
  
  Enabled = sourceContext.callback35 and sourceContext.callback35("WH_Enabled", true) or not sourceContext.callback35 or sourceContext.callback35("WH_PingRare", true) or true,
  Url = sourceContext.callback35 and sourceContext.callback35("WH_Url", "") or sourceContext.callback35 and sourceContext.callback35("APWH", "") or "",
  UserId = sourceContext.callback35 and sourceContext.callback35("WH_UserId", "") or "",
  Language = sourceContext.callback35 and sourceContext.callback35("WH_Lang", "English") or "English",
  HideUser = sourceContext.callback35 and sourceContext.callback35("WH_HideUser", false) or false,
  NotifyItem = not sourceContext.callback35 or sourceContext.callback35("WH_NotifyItem", true) or true,
  NotifyStand = not sourceContext.callback35 or sourceContext.callback35("WH_NotifyStand", true) or true,
  NotifyPrestige = not sourceContext.callback35 or sourceContext.callback35("WH_NotifyPrestige", true) or true,
  NotifyStaff = not sourceContext.callback35 or sourceContext.callback35("WH_NotifyStaff", true) or true,
  NotifyKick = not sourceContext.callback35 or sourceContext.callback35("WH_NotifyKick", true) or true,
  NotifyMilestone = sourceContext.callback35("WH_NotifyMilestone", true) ~= false,
}
function sourceContext.callback37() return sourceContext.settings3.Language == "Русский" end
sourceContext.entries2 = {}
sourceContext.enabled12 = false
function sourceContext.callback38()
  return syn and syn.request or http_request or request or http and http.request
end
function sourceContext.callback39()
  if sourceContext.enabled12 or #sourceContext.entries2 == 0 then return end
  sourceContext.enabled12 = true
  task.spawn(function()
    local entry3 = sourceContext.callback38()
    while #sourceContext.entries2 > 0 do
      local remove = table.remove(sourceContext.entries2, 1)
      if entry3 and sourceContext.settings3.Url and sourceContext.settings3.Url ~= "" and sourceContext.settings3.Url:find("^https?://") then
        pcall(entry3, {
          Url = sourceContext.settings3.Url, Method = "POST", Headers = { ["Content-Type"] = "application/json" },
          Body = sourceContext.httpServiceService2:JSONEncode(remove),
        })
      end
      task.wait(1)
    end
    sourceContext.enabled12 = false
  end)
end
function sourceContext.callback40(entry3)
  if not sourceContext.settings3.Enabled then return end
  if not (sourceContext.settings3.Url and sourceContext.settings3.Url ~= "" and sourceContext.settings3.Url:find("^https?://")) then return end
  table.insert(sourceContext.entries2, entry3)
  sourceContext.callback39()
end
function sourceContext.callback41()
  local LocalPlayer = game:GetService("Players")
  LocalPlayer = LocalPlayer.LocalPlayer
  LocalPlayer = LocalPlayer or sourceContext.player or sourceContext.player
  local unknownText = LocalPlayer and LocalPlayer.Name or "Unknown"
  local entry3 = LocalPlayer and LocalPlayer.DisplayName or unknownText
  if sourceContext.settings3.HideUser then return ("||%s (%s)||").format("||%s (%s)||", unknownText, entry3) end
  return ("%s (%s)").format("%s (%s)", unknownText, entry3)
end
function sourceContext.callback42(entry3)
  local gsub22
  local tostring2 = tonumber(entry3)
  entry3 = if tostring2 then tostring2 else 0
  tostring2 = tostring
  tostring2 = tostring2(entry3)
  repeat
    local gsub, gsub2 = string.gsub(tostring2, "^(-?%d+)(%d%d%d)", "%1,%2")
    gsub22 = gsub2
    tostring2 = gsub
  until gsub22 == 0
  return tostring2
end
function sourceContext.callback43()
  local LocalPlayer = game:GetService("Players").LocalPlayer
  LocalPlayer = LocalPlayer or sourceContext.player or sourceContext.player
  local playerStats = LocalPlayer and LocalPlayer:FindFirstChild("PlayerStats")
  local money = playerStats and playerStats:FindFirstChild("Money")
  return money and money.Value or 0
end
function sourceContext.callback44()
  local count4 = 0
  local LocalPlayer = game:GetService("Players")
  LocalPlayer = LocalPlayer.LocalPlayer
  LocalPlayer = LocalPlayer or sourceContext.player or sourceContext.player
  if LocalPlayer then
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
      local pcallResult, entries3 = pcall(function() return backpack:GetChildren() end)
      if pcallResult and entries3 then for k, v in ipairs(entries3) do if v and v.Name == "Lucky Arrow" then count4 = count4 + 1 end end end
    end
    local Character = LocalPlayer.Character
    if Character then
      local pcallResult2, entries4 = pcall(function() return Character:GetChildren() end)
      if pcallResult2 and entries4 then for k2, v2 in ipairs(entries4) do if v2 and v2.Name == "Lucky Arrow" then count4 = count4 + 1 end end end
    end
  end
  return count4
end
function sourceContext.callback45(a, b)
  if not sourceContext.settings3.Enabled then return end
  local settings4 = { username = "RAIL Hub", embeds = { [1] = a } }
  if b and sourceContext.settings3.UserId and sourceContext.settings3.UserId ~= "" then settings4.content = ("<@%s>"):format(sourceContext.settings3.UserId) end
  sourceContext.callback40(settings4)
end
function sourceContext.sendTestWebhook()
  local entry3 = sourceContext.callback37()
  local settings4 = { title = entry3 and "[RAIL Hub] Вебхук подключен" or "[RAIL Hub] Webhook Connected", color = 3066993 }
  local fields4 = {}
  local settings5 = { name = entry3 and "Статус" or "Status", value = entry3 and "Успешно подключено" or "Connected successfully", inline = true }
  local settings6 = { name = entry3 and "Игрок" or "Player", value = sourceContext.callback41(), inline = true }
  local settings7
  settings7 = { name = entry3 and "Игра" or "Game", value = "Your Bizarre Adventure", inline = true }
  local settings8 = { name = entry3 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
  fields4[1] = settings5
  fields4[2] = settings6
  fields4[3] = settings7
  fields4[4] = settings8
  settings4.fields = fields4
  settings4.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
  fields4 = os
  fields4 = fields4.date
  settings5 = "!%Y-%m-%dT%H:%M:%SZ"
  settings4.timestamp = fields4("!%Y-%m-%dT%H:%M:%SZ")
  fields4 = sourceContext.callback45
  settings5 = settings4
  settings6 = false
  sourceContext.callback45(settings4, false)
  fields4 = true
  return true
end
function sourceContext.sendItemPickupWebhook(a, b, c)
  if not sourceContext.settings3.NotifyItem then return end
  do
    local luckyStoneMaskText = a == "Lucky Arrow" or a == "Lucky Stone Mask"
    if not luckyStoneMaskText then return end
    local entry3 = sourceContext.callback37()
    local settings4 = { title = entry3 and "[RAIL Hub] Легендарный предмет" or "[RAIL Hub] Legendary Item", color = 15844367 }
    local fields4 = {}
    local settings5 = { name = entry3 and "Предмет" or "Item", value = tostring(a), inline = true }
    local settings6
    settings6 = { name = entry3 and "Количество" or "Amount", value = ("%d / %d").format("%d / %d", b or 1, c or 9), inline = true }
    local settings7
    settings7 = { name = entry3 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
    local settings8
    settings8 = { name = entry3 and "Игрок" or "Player", value = sourceContext.callback41(), inline = true }
    local settings9
    settings9 = { name = entry3 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
    fields4[1] = settings5
    fields4[2] = settings6
    fields4[3] = settings7
    fields4[4] = settings8
    fields4[5] = settings9
    settings4.fields = fields4
    settings4.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
    fields4 = os
    fields4 = fields4.date
    settings5 = "!%Y-%m-%dT%H:%M:%SZ"
    settings4.timestamp = fields4("!%Y-%m-%dT%H:%M:%SZ")
    fields4 = sourceContext.callback45
    settings5 = settings4
    settings6 = true
    sourceContext.callback45(settings4, true)
    return
  end
end
function sourceContext.sendStandWebhook(a, b)
  if not sourceContext.settings3.NotifyStand then return end
  local a3 = b and b ~= "None" and b ~= "" and b ~= a
  if not a3 then return end
  local entry3 = sourceContext.callback37()
  local settings4 = { title = "[RAIL Hub] Shiny Stand", color = 10181046 }
  local fields4 = {}
  local settings5 = { name = entry3 and "Стенд" or "Stand", value = tostring(a or "None"), inline = true }
  local settings6
  settings6 = { name = entry3 and "Скин" or "Skin", value = tostring(b or "None"), inline = true }
  local settings7
  settings7 = { name = entry3 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
  local settings8
  settings8 = { name = entry3 and "Игрок" or "Player", value = sourceContext.callback41(), inline = true }
  local settings9
  settings9 = { name = entry3 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
  fields4[1] = settings5
  fields4[2] = settings6
  fields4[3] = settings7
  fields4[4] = settings8
  fields4[5] = settings9
  settings4.fields = fields4
  settings4.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
  fields4 = os
  fields4 = fields4.date
  settings5 = "!%Y-%m-%dT%H:%M:%SZ"
  settings4.timestamp = fields4("!%Y-%m-%dT%H:%M:%SZ")
  fields4 = sourceContext.callback45
  settings5 = settings4
  settings6 = true
  sourceContext.callback45(settings4, true)
end
function sourceContext.sendMilestoneWebhook(a, b)
  if not sourceContext.settings3.NotifyMilestone then return end
  local settings4 = { title = "[RAIL Hub] Goal Reached: 9 Lucky + $1M", color = 15844367 }
  local fields4 = {}
  local settings5 = { name = "Lucky Arrows", value = ("%d / 9").format("%d / 9", a or 9), inline = true }
  local settings6
  settings6 = { name = "Balance", value = ("$%s").format("$%s", sourceContext.callback42(b or sourceContext.callback43())), inline = true }
  local settings7
  settings7 = { name = "Player", value = sourceContext.callback41(), inline = true }
  local settings8
  settings8 = { name = "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
  fields4[1] = settings5
  fields4[2] = settings6
  fields4[3] = settings7
  fields4[4] = settings8
  settings4.fields = fields4
  settings4.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
  fields4 = os
  fields4 = fields4.date
  settings5 = "!%Y-%m-%dT%H:%M:%SZ"
  settings4.timestamp = fields4("!%Y-%m-%dT%H:%M:%SZ")
  fields4 = sourceContext.callback45
  settings5 = settings4
  settings6 = true
  sourceContext.callback45(settings4, true)
end
task.spawn(function()
  while true do
    task.wait(10)
    pcall(function()
      if sourceContext.settings3.Enabled then
        if sourceContext.settings3.NotifyMilestone then
          if not (sourceContext.settings3.Url and sourceContext.settings3.Url ~= "") then return end
          local count4 = sourceContext.callback44 and sourceContext.callback44() or 0
          local count5 = sourceContext.callback43 and sourceContext.callback43() or 0
          if count4 >= 9 and count5 >= 1000000 then
            if not getgenv()._YBA_MilestonePinged then
              getgenv()._YBA_MilestonePinged = true
              sourceContext.sendMilestoneWebhook(count4, count5)
            end
          else
            getgenv()._YBA_MilestonePinged = false
          end
          return
        end
        getgenv()._YBA_MilestonePinged = false
        return
      end
      getgenv()._YBA_MilestonePinged = false
    end)
  end
end)
function sourceContext.sendStaffDetectedWebhook(a)
  local text4, text5, entry3, settings4, fields4, settings5, settings6, settings7, sText, entry5, settings8, text6, entry8
  if not sourceContext.settings3.NotifyStaff then return end
  text4 = typeof(a) == "Instance" and a.Name or tostring(a or "Unknown")
  entry3 = sourceContext.callback37()
  settings4 = { title = entry3 and "[RAIL Hub] Стафф Детектор" or "[RAIL Hub] Staff Detected", color = 15158332 }
  fields4 = {}
  settings5 = { name = entry3 and "Модератор" or "Staff Member", value = text4, inline = true }
  settings6 = { name = entry3 and "Действие" or "Action", value = entry3 and "Оповещение безопасности" or "Security Alert", inline = true }
  settings7 = { name = entry3 and "Баланс" or "Balance" }
  sText = "$%s"
  settings7.value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43()))
  settings7.inline = true
  sText = { name = entry3 and "Игрок" or "Player", value = sourceContext.callback41(), inline = true }
  settings8 = { name = entry3 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
  fields4[1] = settings5
  fields4[2] = settings6
  fields4[3] = settings7
  fields4[4] = sText
  fields4[5] = settings8
  settings4.fields = fields4
  settings4.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
  settings4.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
  fields4 = sourceContext.callback45
  sourceContext.callback45(settings4, true)
end
function sourceContext.sendPrestigeWebhook(a, b, c, d)
  if not sourceContext.settings3.NotifyPrestige then return end
  local entry3 = sourceContext.callback37()
  local entry5 = nil
  if c then
    local settings4 = { title = entry3 and "[RAIL Hub] Auto Prestige Завершен" or "[RAIL Hub] Auto Prestige Completed", color = 15844367 }
    local fields4 = {}
    local settings5 = {
      name = entry3 and "Статус" or "Status",
      value = entry3 and "Максимальный уровень 50 / Престиж 3 (50/3)" or "Max Level 50 / Prestige 3 (50/3)",
      inline = true,
    }
    local settings6 = { name = entry3 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
    local settings7
    settings7 = { name = entry3 and "Время" or "Time Taken", value = tostring(d or "Unknown"), inline = true }
    local settings8
    settings8 = { name = entry3 and "Игрок" or "Player", value = sourceContext.callback41(), inline = true }
    local settings9
    settings9 = { name = entry3 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
    fields4[1] = settings5
    fields4[2] = settings6
    fields4[3] = settings7
    fields4[4] = settings8
    fields4[5] = settings9
    settings4.fields = fields4
    settings4.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
    fields4 = os
    fields4 = fields4.date
    settings5 = "!%Y-%m-%dT%H:%M:%SZ"
    settings4.timestamp = fields4("!%Y-%m-%dT%H:%M:%SZ")
    entry5 = settings4
  else
    local settings10 = { title = "[RAIL Hub] Auto Prestige", color = 3447003 }
    local fields5 = {}
    local settings11 = { name = entry3 and "Престиж" or "Prestige", value = ("Prestige %d").format("Prestige %d", a or 1), inline = true }
    local settings12
    settings12 = { name = entry3 and "Уровень" or "Level", value = ("Level %d").format("Level %d", b or 1), inline = true }
    local settings13
    settings13 = { name = entry3 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
    local settings14
    settings14 = { name = entry3 and "Игрок" or "Player", value = sourceContext.callback41(), inline = true }
    local settings15
    settings15 = { name = entry3 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
    fields5[1] = settings11
    fields5[2] = settings12
    fields5[3] = settings13
    fields5[4] = settings14
    fields5[5] = settings15
    settings10.fields = fields5
    settings10.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
    fields5 = os
    fields5 = fields5.date
    settings11 = "!%Y-%m-%dT%H:%M:%SZ"
    settings10.timestamp = fields5("!%Y-%m-%dT%H:%M:%SZ")
    entry5 = settings10
  end
  sourceContext.callback45(entry5, true)
end
function sourceContext.sendReconnectKickWebhook2(a, b)
  if not sourceContext.settings3.NotifyKick then return end
  local entry3 = sourceContext.callback37()
  local kickedReconnectingText = b or a and tostring(a):find("Server") and "Server Hopping" or "Kicked / Reconnecting"
  local settings4 = { title = entry3 and "[RAIL Hub] Реконнект / Кик" or "[RAIL Hub] Reconnect / Kick", color = 15105570 }
  local fields4 = {}
  local settings5 = { name = entry3 and "Действие" or "Action", value = tostring(kickedReconnectingText), inline = true }
  local settings6
  settings6 = { name = entry3 and "Причина" or "Reason", value = tostring(a or "Auto Reconnect"), inline = true }
  local settings7
  settings7 = { name = entry3 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
  local settings8
  settings8 = { name = entry3 and "Лаки стрелы" or "Lucky Arrows", value = ("%d / 9"):format(sourceContext.callback44()), inline = true }
  local settings9
  settings9 = { name = entry3 and "Игрок" or "Player", value = sourceContext.callback41(), inline = true }
  local settings10
  settings10 = { name = entry3 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
  fields4[1] = settings5
  fields4[2] = settings6
  fields4[3] = settings7
  fields4[4] = settings8
  fields4[5] = settings9
  fields4[6] = settings10
  settings4.fields = fields4
  settings4.footer = { text = "RAIL Hub | Your Bizarre Adventure" }
  fields4 = os
  fields4 = fields4.date
  settings5 = "!%Y-%m-%dT%H:%M:%SZ"
  settings4.timestamp = fields4("!%Y-%m-%dT%H:%M:%SZ")
  fields4 = sourceContext.callback45
  settings5 = settings4
  settings6 = false
  sourceContext.callback45(settings4, false)
end
getgenv().sendItemPickupWebhook = sourceContext.sendItemPickupWebhook
getgenv().sendStandWebhook = sourceContext.sendStandWebhook
getgenv().sendMilestoneWebhook = sourceContext.sendMilestoneWebhook
getgenv().sendStaffDetectedWebhook = sourceContext.sendStaffDetectedWebhook
getgenv().sendPrestigeWebhook = sourceContext.sendPrestigeWebhook
getgenv().sendReconnectKickWebhook = sourceContext.sendReconnectKickWebhook2
getgenv().sendTestWebhook = sourceContext.sendTestWebhook
sourceContext.connectResult2 = nil
function sourceContext.enableAntiAfk()
  pcall(function()
    local getSignalCons = getconnections or get_signal_cons
    if getSignalCons and sourceContext.player and sourceContext.player.Idled then
      for k, v in pairs(getSignalCons(sourceContext.player.Idled)) do
        if v.Disable then
          v:Disable()
        elseif v.Disconnect then v:Disconnect() end
      end
    end
  end)
  if sourceContext.connectResult2 then
    sourceContext.connectResult2:Disconnect()
    sourceContext.connectResult2 = nil
  end
  if sourceContext.player and sourceContext.player.Idled then
    sourceContext.connectResult2 = sourceContext.player.Idled:Connect(function()
      pcall(function()
        local virtualUserService2 = game:GetService("VirtualUser")
        if virtualUserService2 then
          virtualUserService2:CaptureController()
          virtualUserService2:ClickButton2(Vector2.zero)
        end
      end)
    end)
  end
end
function sourceContext.disableAntiAfk()
  if sourceContext.connectResult2 then
    sourceContext.connectResult2:Disconnect()
    sourceContext.connectResult2 = nil
  end
  pcall(function()
    local getSignalCons = getconnections or get_signal_cons
    if getSignalCons and sourceContext.player and sourceContext.player.Idled then
      for k, v in pairs(getSignalCons(sourceContext.player.Idled)) do if v.Enable then v:Enable() end end
    end
  end)
end
sourceContext.environment2 = getgenv()
sourceContext.environment2.enableAntiAfk = sourceContext.enableAntiAfk
sourceContext.environment2 = getgenv
sourceContext.environment2 = sourceContext.environment2()
sourceContext.environment2.disableAntiAfk = sourceContext.disableAntiAfk
sourceContext.environment2 = task
sourceContext.environment2 = sourceContext.environment2.spawn
sourceContext.environment2(function()
  task.wait(1)
  local pcallResult, entry3 = pcall(function() return sourceContext.callback35("AA", true) end)
  if pcallResult and entry3 and type(sourceContext.enableAntiAfk) == "function" then pcall(sourceContext.enableAntiAfk) end
end)
sourceContext.environment2 = {}
sourceContext.settings4 = {
  ["А"] = "а", ["Б"] = "б", ["В"] = "в", ["Г"] = "г", ["Д"] = "д", ["Е"] = "е", ["Ё"] = "ё", ["Ж"] = "ж",
  ["З"] = "з", ["И"] = "и", ["Й"] = "й", ["К"] = "к", ["Л"] = "л", ["М"] = "м", ["Н"] = "н", ["О"] = "о",
  ["П"] = "п", ["Р"] = "р", ["С"] = "с", ["Т"] = "т", ["У"] = "у", ["Ф"] = "ф", ["Х"] = "х", ["Ц"] = "ц",
  ["Ч"] = "ч", ["Ш"] = "ш", ["Щ"] = "щ", ["Ъ"] = "ъ", ["Ы"] = "ы", ["Ь"] = "ь", ["Э"] = "э", ["Ю"] = "ю",
  ["Я"] = "я",
}
function sourceContext.utf8Lower(a)
  if a then
    local lowerResult = tostring(a):lower()
    for k, v in pairs(sourceContext.settings4) do lowerResult = lowerResult:gsub(k, v) end
    return lowerResult
  end
  return ""
end
sourceContext.environment2.utf8Lower = sourceContext.utf8Lower
sourceContext.entries3 = {}
function sourceContext.normalizeItemName(a)
  if a then
    local typeofResult = typeof(a)
    typeofResult = typeofResult == "Instance" and a.Name or tostring(a)
    local entry3 = sourceContext.entries3[typeofResult]
    if entry3 then return entry3 end
    local normalizedText2 = typeofResult:gsub("^%s+", ""):gsub("%s+$", "")
    local utf8LowerResult = sourceContext.utf8Lower(normalizedText2)
    local entry5 = normalizedText2
    local findResult = utf8LowerResult:find("lucky", 1, true)
    if findResult and utf8LowerResult:find("arrow", 1, true) or utf8LowerResult:find("счастлив", 1, true) and utf8LowerResult:find("стрел", 1, true) then
      entry5 = "Lucky Arrow"
    elseif utf8LowerResult:find("lucky", 1, true) and utf8LowerResult:find("mask", 1, true) or utf8LowerResult:find("счастлив", 1, true) and utf8LowerResult:find("маск", 1, true) then
      entry5 = "Lucky Stone Mask"
    elseif utf8LowerResult:find("requiem", 1, true) and utf8LowerResult:find("arrow", 1, true) or utf8LowerResult:find("радужн", 1, true) or utf8LowerResult:find("реквием", 1, true) then
      entry5 = "Requiem Arrow"
    elseif utf8LowerResult == "stand arrow" or utf8LowerResult:find("stand arrow", 1, true) or utf8LowerResult:find("standarrow", 1, true) or utf8LowerResult:find("stand", 1, true) and utf8LowerResult:find("arrow", 1, true) and not utf8LowerResult:find("mysterious", 1, true) or utf8LowerResult:find("quest arrow", 1, true) or utf8LowerResult:find("questarrow", 1, true) or utf8LowerResult:find("стенд", 1, true) and utf8LowerResult:find("стрел", 1, true) or utf8LowerResult:find("стрела стенда", 1, true) or utf8LowerResult:find("стендовая", 1, true) or utf8LowerResult:find("стенд стрела", 1, true) then
      entry5 = "Stand Arrow"
    elseif utf8LowerResult:find("left arm", 1, true) or utf8LowerResult:find("левая рука", 1, true) or utf8LowerResult:find("рука", 1, true) and utf8LowerResult:find("труп", 1, true) then
      entry5 = "Left Arm of The Saint's Corpse"
    elseif utf8LowerResult:find("heart", 1, true) or utf8LowerResult:find("сердц", 1, true) and (utf8LowerResult:find("труп", 1, true) or utf8LowerResult:find("свят", 1, true)) then
      entry5 = "Heart of The Saint's Corpse"
    elseif utf8LowerResult:find("pelvis", 1, true) or utf8LowerResult:find("таз", 1, true) and (utf8LowerResult:find("труп", 1, true) or utf8LowerResult:find("свят", 1, true)) then
      entry5 = "Pelvis of The Saint's Corpse"
    elseif utf8LowerResult:find("eye of", 1, true) or utf8LowerResult:find("глаз", 1, true) and (utf8LowerResult:find("труп", 1, true) or utf8LowerResult:find("свят", 1, true)) or utf8LowerResult:find("око", 1, true) then
      entry5 = "Eye of The Saint's Corpse"
    elseif utf8LowerResult:find("pure", 1, true) and (utf8LowerResult:find("roka", 1, true) or utf8LowerResult:find("fruit", 1, true)) or utf8LowerResult:find("чист", 1, true) and utf8LowerResult:find("рока", 1, true) then
      entry5 = "Pure Rokakaka"
    elseif utf8LowerResult:find("roka", 1, true) or utf8LowerResult:find("рока", 1, true) then
      entry5 = "Rokakaka"
    elseif utf8LowerResult:find("rib", 1, true) or utf8LowerResult:find("ребр", 1, true) or utf8LowerResult:find("клетк", 1, true) then
      entry5 = "Rib Cage of The Saint's Corpse"
    elseif utf8LowerResult ~= "mysterious arrow" and not utf8LowerResult:find("mysterious", 1, true) and not utf8LowerResult:find("мистическ", 1, true) and not utf8LowerResult:find("мистери", 1, true) and not utf8LowerResult:find("стоячая", 1, true) and (not utf8LowerResult:find("arrow", 1, true) or utf8LowerResult:find("stand", 1, true) or utf8LowerResult:find("lucky", 1, true) or utf8LowerResult:find("requiem", 1, true) or utf8LowerResult:find("quest", 1, true)) and (not utf8LowerResult:find("стрел", 1, true) or utf8LowerResult:find("стенд", 1, true) or utf8LowerResult:find("счастлив", 1, true) or utf8LowerResult:find("радужн", 1, true) or utf8LowerResult:find("реквием", 1, true)) then
      if utf8LowerResult:find("stone mask", 1, true) or utf8LowerResult:find("vampire mask", 1, true) or utf8LowerResult:find("маска", 1, true) or utf8LowerResult:find("mask", 1, true) and not utf8LowerResult:find("lucky", 1, true) then
        entry5 = "Stone Mask"
      elseif utf8LowerResult:find("dio", 1, true) or utf8LowerResult:find("diary", 1, true) or utf8LowerResult:find("дио", 1, true) or utf8LowerResult:find("дневник", 1, true) then
        entry5 = "Dio's Diary"
      elseif utf8LowerResult:find("quinton", 1, true) or utf8LowerResult:find("glove", 1, true) or utf8LowerResult:find("перчатк", 1, true) or utf8LowerResult:find("квинтон", 1, true) then
        entry5 = "Quinton's Glove"
      elseif utf8LowerResult:find("ancient scroll", 1, true) or utf8LowerResult:find("scroll", 1, true) or utf8LowerResult:find("свиток", 1, true) or utf8LowerResult:find("древн", 1, true) then
        entry5 = "Ancient Scroll"
      elseif utf8LowerResult:find("steel", 1, true) or utf8LowerResult:find("ball", 1, true) or utf8LowerResult:find("стальн", 1, true) or utf8LowerResult:find("шар", 1, true) then
        entry5 = "Steel Ball"
      elseif utf8LowerResult:find("clacker", 1, true) or utf8LowerResult:find("клакер", 1, true) then
        entry5 = "Clackers"
      elseif utf8LowerResult:find("zeppeli", 1, true) and utf8LowerResult:find("hat", 1, true) or utf8LowerResult:find("шляп", 1, true) and utf8LowerResult:find("цеппел", 1, true) then
        entry5 = "Zeppeli's Hat"
      elseif utf8LowerResult:find("zepellin", 1, true) and utf8LowerResult:find("headband", 1, true) or utf8LowerResult:find("повязк", 1, true) and utf8LowerResult:find("цеппел", 1, true) then
        entry5 = "Zepellin's Headband"
      elseif utf8LowerResult:find("caesar", 1, true) and utf8LowerResult:find("headband", 1, true) or utf8LowerResult:find("повязк", 1, true) and utf8LowerResult:find("цезар", 1, true) or utf8LowerResult:find("повязк", 1, true) or utf8LowerResult:find("headband", 1, true) then
        entry5 = "Caesar's Headband"
      elseif utf8LowerResult:find("gold coin", 1, true) or utf8LowerResult == "coin" or utf8LowerResult:find("coin", 1, true) or utf8LowerResult:find("монет", 1, true) then
        entry5 = "Gold Coin"
      elseif utf8LowerResult:find("diamond", 1, true) or utf8LowerResult:find("бриллиант", 1, true) or utf8LowerResult:find("алмаз", 1, true) then
        entry5 = "Diamond"
      elseif utf8LowerResult:find("umbrella", 1, true) or utf8LowerResult:find("зонт", 1, true) then
        entry5 = "Gold Umbrella"
      elseif utf8LowerResult:find("present", 1, true) or utf8LowerResult:find("подарок", 1, true) or utf8LowerResult:find("gift", 1, true) then
        entry5 = "Christmas Present"
      elseif utf8LowerResult:find("candy", 1, true) or utf8LowerResult:find("конфет", 1, true) or utf8LowerResult:find("леден", 1, true) then entry5 = "Candy" end
    else
      entry5 = "Mysterious Arrow"
    end
    findResult = sourceContext.entries3
    sourceContext.entries3[typeofResult] = entry5
    return entry5
  end
  return ""
end
sourceContext.environment2.normalizeItemName = sourceContext.normalizeItemName
sourceContext.entries4 = {}
sourceContext.maxLimits = {
  ["Mysterious Arrow"] = 25, Rokakaka = 25, ["Gold Coin"] = 45, Diamond = 25, ["Pure Rokakaka"] = 10,
  ["Quinton's Glove"] = 10, ["Steel Ball"] = 10, ["Rib Cage of The Saint's Corpse"] = 10,
  ["Zepellin's Headband"] = 10, ["Zeppeli's Hat"] = 10, ["Caesar's Headband"] = 10, Clackers = 10,
  ["Stone Mask"] = 10, ["Ancient Scroll"] = 10, ["Dio's Diary"] = 10, ["Lucky Stone Mask"] = 9,
  ["Lucky Arrow"] = 9, ["Gold Umbrella"] = 999, ["Christmas Present"] = 999,
}
sourceContext.environment2.maxLimits = sourceContext.maxLimits
sourceContext.nonFarmableItems = {
  ["Pelvis of The Saint's Corpse"] = true, ["Requiem Arrow"] = true, ["Stand Arrow"] = true, Umbrella = true,
  ["Eye of The Saint's Corpse"] = true, ["Gold Umbrella"] = true, ["Heart of The Saint's Corpse"] = true,
  ["Left Arm of The Saint's Corpse"] = true,
}
sourceContext.environment2.nonFarmableItems = sourceContext.nonFarmableItems
sourceContext.entries5 = {}
sourceContext.nonFarmableItems = "Blue Candy"
sourceContext.entries5[1] = "Blue Candy"
sourceContext.entries5[2] = "Red Candy"
sourceContext.entries5[3] = "Green Candy"
sourceContext.entries5[4] = "Yellow Candy"
sourceContext.entries5[5] = "Candy"
sourceContext.entries5[6] = "Lucky Arrow"
sourceContext.entries5[7] = "Lucky Stone Mask"
sourceContext.entries5[8] = "Christmas Present"
sourceContext.entries5[9] = "Gold Umbrella"
sourceContext.entries5[10] = "Umbrella"
sourceContext.entries5[11] = "Requiem Arrow"
sourceContext.entries5[12] = "Stand Arrow"
sourceContext.entries5[13] = "Left Arm of The Saint's Corpse"
sourceContext.entries5[14] = "Heart of The Saint's Corpse"
sourceContext.entries5[15] = "Pelvis of The Saint's Corpse"
sourceContext.entries5[16] = "Eye of The Saint's Corpse"
function sourceContext.sfCountItem2(a)
  if a then
    local normalizeItemNameResult = sourceContext.normalizeItemName(a)
    local count4 = 0
    local LocalPlayer = game:GetService("Players")
    LocalPlayer = LocalPlayer.LocalPlayer
    LocalPlayer = LocalPlayer or sourceContext.player or sourceContext.player
    if LocalPlayer then
      local backpack2 = LocalPlayer:FindFirstChild("Backpack") or pcall(function() return LocalPlayer.Backpack end) and LocalPlayer.Backpack
      if backpack2 then
        local pcallResult, entries6 = pcall(function() return backpack2:GetChildren() end)
        if pcallResult and entries6 then
          for k, v in ipairs(entries6) do
            if v and (v:IsA("Tool") or v.Name) and sourceContext.normalizeItemName(v.Name) == normalizeItemNameResult then count4 = count4 + 1 end
          end
        end
      end
      local Character = LocalPlayer.Character
      if Character then
        local pcallResult2, entries7 = pcall(function() return Character:GetChildren() end)
        if pcallResult2 and entries7 then
          for k2, v2 in ipairs(entries7) do
            if v2 and v2:IsA("Tool") and sourceContext.normalizeItemName(v2.Name) == normalizeItemNameResult then count4 = count4 + 1 end
          end
        end
      end
    end
    return count4
  end
  return 0
end
sourceContext.environment2.sfCountItem = sourceContext.sfCountItem2
function sourceContext.callback46(a)
  if a then
    local utf8LowerResult = sourceContext.utf8Lower(tostring(typeof(a) == "Instance" and a.Name or a))
    local normalizeItemNameResult = sourceContext.normalizeItemName(a)
    if normalizeItemNameResult ~= "Lucky Arrow" and normalizeItemNameResult ~= "Lucky Stone Mask" and normalizeItemNameResult ~= "Requiem Arrow" and normalizeItemNameResult ~= "Stand Arrow" and normalizeItemNameResult ~= "Left Arm of The Saint's Corpse" and normalizeItemNameResult ~= "Heart of The Saint's Corpse" and normalizeItemNameResult ~= "Pelvis of The Saint's Corpse" and normalizeItemNameResult ~= "Eye of The Saint's Corpse" and normalizeItemNameResult ~= "Christmas Present" and normalizeItemNameResult ~= "Candy" and normalizeItemNameResult ~= "Gold Umbrella" and normalizeItemNameResult ~= "Umbrella" then
      if utf8LowerResult ~= "stand arrow" and not utf8LowerResult:find("stand arrow", 1, true) and not utf8LowerResult:find("standarrow", 1, true) and (not utf8LowerResult:find("stand", 1, true) or not utf8LowerResult:find("arrow", 1, true) or utf8LowerResult:find("mysterious", 1, true)) and not utf8LowerResult:find("quest arrow", 1, true) and not utf8LowerResult:find("questarrow", 1, true) and (not utf8LowerResult:find("стенд", 1, true) or not utf8LowerResult:find("стрел", 1, true)) and not utf8LowerResult:find("стрела стенда", 1, true) and not utf8LowerResult:find("стендовая", 1, true) and not utf8LowerResult:find("стенд стрела", 1, true) then
        local findResult = utf8LowerResult:find("umbrella", 1, true)
        if not findResult and not utf8LowerResult:find("зонт", 1, true) then
          local findResult2 = utf8LowerResult:find("lucky", 1, true)
          if not findResult2 and not utf8LowerResult:find("счастлив", 1, true) then
            local findResult3 = utf8LowerResult:find("requiem", 1, true)
            if not findResult3 and not utf8LowerResult:find("радужн", 1, true) and not utf8LowerResult:find("реквием", 1, true) then
              local findResult4 = utf8LowerResult:find("pelvis", 1, true)
              if not findResult4 and not utf8LowerResult:find("heart", 1, true) and not utf8LowerResult:find("left arm", 1, true) and not utf8LowerResult:find("eye of", 1, true) and not utf8LowerResult:find("таз", 1, true) and not utf8LowerResult:find("сердц", 1, true) and not utf8LowerResult:find("левая рука", 1, true) and not utf8LowerResult:find("глаз", 1, true) and not utf8LowerResult:find("око", 1, true) then
                local findResult5 = utf8LowerResult:find("candy", 1, true)
                if not findResult5 and not utf8LowerResult:find("конфет", 1, true) and not utf8LowerResult:find("леден", 1, true) then
                  for k, v in ipairs(sourceContext.entries5) do
                    if v:lower() == utf8LowerResult or v == normalizeItemNameResult or sourceContext.normalizeItemName and sourceContext.normalizeItemName(v) == normalizeItemNameResult then
                      return true
                    end
                  end
                  return false
                end
                return true
              end
              return true
            end
            return true
          end
          return true
        end
        return true
      end
      return true
    end
    return true
  end
  return true
end
sourceContext.entries6 = nil
itemOptions = {}
sourceContext.entries6 = {}
sourceContext.pairsResult, sourceContext.entry12, sourceContext.entry13 = pairs(sourceContext.maxLimits)
for entry14 in sourceContext.pairsResult, sourceContext.entry12, sourceContext.entry13 do
  if entry14 ~= "Arrow" then
    table.insert(itemOptions, entry14)
    sourceContext.entries6[entry14] = true
  end
end
sourceContext.pairsResult, sourceContext.entry12, sourceContext.entry13 = ipairs(sourceContext.entries5)
for k3, v3 in sourceContext.pairsResult, sourceContext.entry12, sourceContext.entry13 do
  if not sourceContext.entries6[v3] then
    table.insert(itemOptions, v3)
    sourceContext.entries6[v3] = true
  end
end
table.sort(itemOptions)
for i = #itemOptions, 1, -1 do
  local normalizeItemNameResult = sourceContext.normalizeItemName and sourceContext.normalizeItemName(itemOptions[i]) or itemOptions[i]
  if sourceContext.environment2 and sourceContext.environment2.nonFarmableItems and sourceContext.environment2.nonFarmableItems[normalizeItemNameResult] then
    table.remove(itemOptions, i)
  end
end
sellSpecificOptions = {}
sourceContext.ipairsResult2, sourceContext.entry15, sourceContext.savedASM = ipairs(itemOptions)
for k4, v4 in sourceContext.ipairsResult2, sourceContext.entry15, sourceContext.savedASM do
  local entry16 = sourceContext.callback46
  entry16 = sourceContext.callback46(v4)
  if not entry16 then table.insert(sellSpecificOptions, v4) end
end
table.sort(sellSpecificOptions)
sellBlacklistOptions = {}
sourceContext.ipairsResult2 = ipairs
sourceContext.ipairs3Result = nil
sourceContext.ipairs3Result, sourceContext.entry15, sourceContext.savedASM = sourceContext.ipairsResult2(itemOptions)
for k5, v5 in sourceContext.ipairs3Result, sourceContext.entry15, sourceContext.savedASM do
  local entry17 = sourceContext.callback46
  entry17 = sourceContext.callback46(v5)
  if not entry17 then table.insert(sellBlacklistOptions, v5) end
end
table.sort(sellBlacklistOptions)
function sourceContext.ipairs3Result()
  sourceContext.entries4 = {}
  if sourceContext.maxLimits then
    local pairsResult, entry3, entry5 = pairs(sourceContext.maxLimits)
    for entry8 in pairsResult, entry3, entry5 do sourceContext.entries4[entry8] = 0 end
  end
  local function callback8(a, b)
    if not (a and typeof(a) == "Instance") then return end
    local pcallResult, entries6 = pcall(function() return a:GetChildren() end)
    if not (pcallResult and entries6) then return end
    for k, v in ipairs(entries6) do
      if v and v.Name and (not b or v:IsA("Tool")) then
        local normalizeItemNameResult = sourceContext.normalizeItemName(v.Name)
        sourceContext.entries4[normalizeItemNameResult] = (sourceContext.entries4[normalizeItemNameResult] or 0) + 1
      end
    end
  end
  local LocalPlayer = game:GetService("Players")
  LocalPlayer = LocalPlayer.LocalPlayer
  LocalPlayer = LocalPlayer or sourceContext.player or sourceContext.player
  if LocalPlayer then
    local Character = LocalPlayer
    local FindFirstChild = Character.FindFirstChild
    FindFirstChild = FindFirstChild(Character, "Backpack") or pcall(function() return LocalPlayer.Backpack end) and LocalPlayer.Backpack
    if FindFirstChild then callback8(FindFirstChild, false) end
    Character = LocalPlayer.Character
    if Character then callback8(Character, true) end
  end
end
function sourceContext.entry15()
  local LocalPlayer = game:GetService("Players")
  LocalPlayer = LocalPlayer.LocalPlayer
  LocalPlayer = LocalPlayer or sourceContext.player or sourceContext.player
  local entries6 = {}
  local entries7 = {}
  local function callback8(a, _)
    if not (a and typeof(a) == "Instance") then return end
    local pcallResult, entries8 = pcall(function() return a:GetChildren() end)
    if not (pcallResult and entries8) then return end
    for k, v in ipairs(entries8) do
      if v and v:IsA("Tool") and v.Name then
        local rawName = v.Name
        local normName = sourceContext.normalizeItemName(rawName)
        if not sourceContext.callback46(rawName) and not sourceContext.callback46(normName) then
          if not entries7[normName] then
            local settings5 = { normName = normName, rawName = rawName, count = 0 }
            entries7[normName] = settings5
            table.insert(entries6, settings5)
          end
          entries7[normName].count = entries7[normName].count + 1
        end
      end
    end
  end
  if LocalPlayer then
    local Character = LocalPlayer
    local FindFirstChild = Character.FindFirstChild
    FindFirstChild = FindFirstChild(Character, "Backpack") or pcall(function() return LocalPlayer.Backpack end) and LocalPlayer.Backpack
    if FindFirstChild then callback8(FindFirstChild, false) end
    Character = LocalPlayer.Character
    if Character then callback8(Character, true) end
  end
  return entries6
end
function sellItem(a, b)
  if a then
    if sourceContext.enabled9 then
      local clock = os.clock()
      while sourceContext.enabled9 and os.clock() - clock < 1 do sourceContext.runServiceService.Heartbeat:Wait() end
      if sourceContext.enabled9 then return false, "Selling already in progress" end
    end
    if sourceContext.enabled8 or getgenv and getgenv()._YBA_IsEatingRoka or SF and SF.isEatingRoka then
      local clock2 = os.clock()
      while (sourceContext.enabled8 or getgenv and getgenv()._YBA_IsEatingRoka or SF and SF.isEatingRoka) and os.clock() - clock2 < 2 do
        sourceContext.runServiceService.Heartbeat:Wait()
      end
      if sourceContext.enabled8 or getgenv and getgenv()._YBA_IsEatingRoka or SF and SF.isEatingRoka then return false, "Roka in use, sale skipped" end
    end
    sourceContext.enabled9 = true
    local getgenv4
    getgenv()._YBA_SellingBusy = true
    getgenv()._YBA_LastSellItem = tostring(a)
    getgenv4 = getgenv
    getgenv4 = getgenv4()
    local _YBA_LastSellTick = tick()
    getgenv4._YBA_LastSellTick = _YBA_LastSellTick
    getgenv4 = cleanupItemStick
    if getgenv4 then cleanupItemStick() end
    if stopMoveTween then stopMoveTween() end
    getgenv4 = pcall
    function _YBA_LastSellTick()
      local skipTolbl_13, skipTolbl_22, skipTolbl_57, skipTolbl_217, skipTolbl_240, skipTolbl_392, skipTolbl_424, skipTolbl_533, skipTolbl_634, skipTolbl_869, skipTolbl_737, skipTolbl_739, skipTolbl_773 = false, false, false, false, false, false, false, false, false, false, false, false, false
      local typeof2, a3, player3, entry3, cannotSellText, tostring3, entry5, remoteEventText, a4, backpack3, entry8, dialogueGuiText, findFirstChild, entry9, entry10, toolText, toolText2, frameText, optionsText, isA, entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText
      typeof2 = typeof
      a3 = a
      typeof2 = typeof2(a)
      if typeof2 == "Instance" then
        typeof2 = a
        typeof2 = a.Name
        if typeof2 then skipTolbl_13 = true end
      end
      if not skipTolbl_13 then typeof2 = tostring end
      if not skipTolbl_13 then a3 = a end
      if not skipTolbl_13 then typeof2 = typeof2(a3) end
      skipTolbl_13 = false
      a3 = sourceContext.normalizeItemName
      if sourceContext.normalizeItemName then
        a3 = sourceContext.normalizeItemName
        player3 = typeof2
        a3 = sourceContext.normalizeItemName(typeof2)
        if a3 then skipTolbl_22 = true end
      end
      if not skipTolbl_22 then a3 = typeof2 end
      skipTolbl_22 = false
      player3 = sourceContext.callback46
      entry3 = typeof2
      player3 = sourceContext.callback46(typeof2)
      if not player3 then
        player3 = sourceContext.callback46
        entry3 = a3
        player3 = sourceContext.callback46(a3)
        if not player3 then
          player3 = typeof
          entry3 = a
          player3 = player3(a)
          if player3 ~= "Instance" then skipTolbl_57 = true end
          if not skipTolbl_57 then player3 = sourceContext.callback46 end
          if not skipTolbl_57 then entry3 = a end
          if not skipTolbl_57 then player3 = player3(entry3) end
          if not skipTolbl_57 then if not player3 then skipTolbl_57 = true end end
        end
      end
      if not skipTolbl_57 then player3 = sourceContext.notify end
      if not skipTolbl_57 then
        if player3 then
          player3 = sourceContext.notify
          entry3 = "YBA Script"
          cannotSellText = "Cannot sell "
          tostring3 = tostring
          entry5 = a3
          tostring3 = tostring3(a3)
          entry5 = " (Item is protected)."
          cannotSellText = "Cannot sell " .. tostring3 .. " (Item is protected)."
          sourceContext.notify("YBA Script", cannotSellText)
        end
      end
      if not skipTolbl_57 then player3 = false end
      if not skipTolbl_57 then entry3 = "Item is protected and cannot be sold" end
      if not skipTolbl_57 then return player3, entry3 end
      skipTolbl_57 = false
      player3 = game
      player3 = player3.Players
      player3 = player3.LocalPlayer
      if not player3 then player3 = sourceContext.player end
      if not player3 then
        entry3 = false
        cannotSellText = "Local player not found"
        return false, "Local player not found"
      end
      entry3 = player3.Character
      if not entry3 then
        cannotSellText = false
        tostring3 = "Character not found"
        return false, "Character not found"
      end
      tostring3 = entry3
      cannotSellText = entry3.FindFirstChildOfClass
      entry5 = "Humanoid"
      cannotSellText = cannotSellText(entry3, "Humanoid")
      if not cannotSellText then
        tostring3 = entry3
        cannotSellText = entry3.FindFirstChild
        entry5 = "Humanoid"
        cannotSellText = cannotSellText(entry3, "Humanoid")
      end
      if not cannotSellText then
        tostring3 = false
        entry5 = "Humanoid not found"
        return false, "Humanoid not found"
      end
      entry5 = entry3
      tostring3 = entry3.FindFirstChild
      remoteEventText = "RemoteEvent"
      tostring3 = tostring3(entry3, "RemoteEvent")
      if not tostring3 then
        entry5 = false
        remoteEventText = "RemoteEvent not found"
        return false, "RemoteEvent not found"
      end
      entry5 = nil
      remoteEventText = typeof
      a4 = a
      remoteEventText = remoteEventText(a)
      if remoteEventText == "Instance" then
        remoteEventText = sourceContext.callback46
        a4 = a
        remoteEventText = sourceContext.callback46(a)
        if not remoteEventText then
          remoteEventText = sourceContext.callback46
          a4 = a
          a4 = a.Name
          remoteEventText = sourceContext.callback46(a4)
          if not remoteEventText then entry5 = a end
        end
      else
        remoteEventText = typeof
        a4 = a
        remoteEventText = remoteEventText(a)
        if remoteEventText == "string" then
          remoteEventText = ipairs
          a4 = {}
          backpack3 = player3.Backpack
          entry8 = entry3
          a4[1] = backpack3
          a4[2] = entry3
          remoteEventText, a4, backpack3 = remoteEventText(a4)
          for entry13, entry14 in remoteEventText, a4, backpack3 do
            if entry14 then
              entry9 = entry14
              findFirstChild = entry14.FindFirstChild
              entry10 = typeof2
              findFirstChild = findFirstChild(entry14, typeof2)
              if findFirstChild then
                entry10 = findFirstChild
                entry9 = findFirstChild.IsA
                toolText = "Tool"
                entry9 = entry9(entry10, toolText)
                if entry9 then
                  entry9 = sourceContext.callback46
                  entry10 = findFirstChild
                  entry9 = sourceContext.callback46(entry10)
                  if not entry9 then
                    entry9 = sourceContext.callback46
                    entry10 = findFirstChild.Name
                    entry9 = sourceContext.callback46(entry10)
                    if not entry9 then
                      entry5 = findFirstChild
                      break
                    end
                  end
                end
              end
              entry10 = entry14
              entry9 = entry14.FindFirstChild
              toolText = a3
              entry9 = entry9(entry14, toolText)
              if entry9 then
                toolText = entry9
                entry10 = entry9.IsA
                toolText2 = "Tool"
                entry10 = entry10(toolText, "Tool")
                if entry10 then
                  entry10 = sourceContext.callback46
                  toolText = entry9
                  entry10 = sourceContext.callback46(toolText)
                  if not entry10 then
                    entry10 = sourceContext.callback46
                    toolText = entry9.Name
                    entry10 = sourceContext.callback46(toolText)
                    if not entry10 then
                      entry5 = entry9
                      break
                    end
                  end
                end
              end
              entry10 = ipairs
              toolText2 = entry14
              toolText = entry14.GetChildren
              toolText, toolText2, frameText, optionsText, isA, entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText = toolText(entry14)
              entry10, toolText, toolText2 = entry10(toolText, toolText2, frameText, optionsText, isA, entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText)
              for entry16, entry17 in entry10, toolText, toolText2 do
                entry11 = entry17
                isA = entry17.IsA
                toolText3 = "Tool"
                isA = isA(entry17, "Tool")
                if isA then
                  isA = sourceContext.callback46
                  entry11 = entry17
                  isA = sourceContext.callback46(entry17)
                  if not isA then
                    isA = sourceContext.callback46
                    entry11 = entry17.Name
                    isA = sourceContext.callback46(entry11)
                    if not isA then
                      isA = sourceContext.normalizeItemName
                      if sourceContext.normalizeItemName then
                        isA = sourceContext.normalizeItemName
                        entry11 = entry17.Name
                        isA = sourceContext.normalizeItemName(entry11)
                        if isA == a3 then
                          entry5 = entry17
                          break
                        end
                      end
                    end
                  end
                end
              end
              if entry5 then break end
            end
          end
        end
      end
      if entry5 then
        remoteEventText = entry5.Parent
        if remoteEventText then skipTolbl_217 = true end
      end
      if not skipTolbl_217 then remoteEventText = false end
      if not skipTolbl_217 then a4 = "Item not found" end
      if not skipTolbl_217 then return remoteEventText, a4 end
      skipTolbl_217 = false
      remoteEventText = sourceContext.callback46
      a4 = entry5
      remoteEventText = sourceContext.callback46(entry5)
      if not remoteEventText then
        remoteEventText = sourceContext.callback46
        a4 = entry5.Name
        remoteEventText = sourceContext.callback46(a4)
        if not remoteEventText then
          remoteEventText = sourceContext.normalizeItemName
          if not sourceContext.normalizeItemName then skipTolbl_240 = true end
          if not skipTolbl_240 then remoteEventText = sourceContext.callback46 end
          if not skipTolbl_240 then a4 = sourceContext.normalizeItemName end
          if not skipTolbl_240 then backpack3 = entry5.Name end
          if not skipTolbl_240 then
            a4, backpack3, entry8, dialogueGuiText, findFirstChild, entry9, entry10, toolText, toolText2, frameText, optionsText, isA, entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText = a4(backpack3)
          end
          if not skipTolbl_240 then
            remoteEventText = remoteEventText(a4, backpack3, entry8, dialogueGuiText, findFirstChild, entry9, entry10, toolText, toolText2, frameText, optionsText, isA, entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText)
          end
          if not skipTolbl_240 then if not remoteEventText then skipTolbl_240 = true end end
        end
      end
      if not skipTolbl_240 then remoteEventText = false end
      if not skipTolbl_240 then a4 = "Item is protected and cannot be sold" end
      if not skipTolbl_240 then return remoteEventText, a4 end
      skipTolbl_240 = false
      function remoteEventText(entry3)
        local Text3, entry5, entry8, entry9
        if not entry3 then
          Text3 = ""
          return Text3
        end
        Text3 = {}
        entry5 = pcall
        function entry8()
          local skipTolbl_22, skipTolbl_49 = false, false
          local entry5, entry8, textLabelText, entry9, entry10, isA, entry11, textLabelText2
          entry5 = entry3
          entry8 = entry3
          entry5 = entry3.IsA
          textLabelText = "TextLabel"
          entry5 = entry5(entry3, "TextLabel")
          if not entry5 then
            entry5 = entry3
            entry8 = entry3
            entry5 = entry3.IsA
            textLabelText = "TextButton"
            entry5 = entry5(entry3, "TextButton")
            if not entry5 then skipTolbl_22 = true end
          end
          if not skipTolbl_22 then entry5 = table end
          if not skipTolbl_22 then entry5 = entry5.insert end
          if not skipTolbl_22 then entry8 = Text3 end
          if not skipTolbl_22 then textLabelText = entry3 end
          if not skipTolbl_22 then textLabelText = textLabelText.Text end
          if not skipTolbl_22 then if not textLabelText then textLabelText = "" end end
          if not skipTolbl_22 then entry5(entry8, textLabelText) end
          skipTolbl_22 = false
          entry5 = ipairs
          entry8 = entry3
          textLabelText = entry3
          entry8 = entry3.GetDescendants
          entry8, textLabelText, entry9, entry10, isA, entry11, textLabelText2 = entry8(entry3)
          entry5, entry8, textLabelText = entry5(entry8, textLabelText, entry9, entry10, isA, entry11, textLabelText2)
          for entry12, entry13 in entry5, entry8, textLabelText do
            entry11 = entry13
            isA = entry13.IsA
            textLabelText2 = "TextLabel"
            isA = isA(entry13, "TextLabel")
            if not isA then
              entry11 = entry13
              isA = entry13.IsA
              textLabelText2 = "TextButton"
              isA = isA(entry13, "TextButton")
              if not isA then skipTolbl_49 = true end
            end
            if not skipTolbl_49 then isA = entry13.Text end
            if not skipTolbl_49 then
              if isA then
                isA = entry13.Text
                if isA ~= "" then
                  isA = table
                  isA = isA.insert
                  entry11 = Text3
                  textLabelText2 = entry13.Text
                  isA(entry11, textLabelText2)
                end
              end
            end
            skipTolbl_49 = false
          end
        end
        entry5(entry8)
        entry5 = table
        entry5 = entry5.concat
        entry5 = entry5(Text3, " ")
        entry8 = entry5
        return entry5.lower(entry5)
      end
      function a4(entry5)
        local enabled13, entry8, entry9, entry10
        if not entry5 then
          enabled13 = false
          return enabled13
        end
        enabled13 = entry5
        entry8 = pcall
        function entry9()
          local entry5, entry8, entry9, entry10
          entry5 = enabled13
          entry8 = entry5
          entry5 = entry5.IsA
          entry5 = entry5(entry8, "GuiButton")
          if not entry5 then
            entry5 = enabled13
            entry8 = entry5
            entry5 = entry5.FindFirstChildWhichIsA
            entry5 = entry5(entry8, "GuiButton", true)
            if not entry5 then entry5 = enabled13 end
            enabled13 = entry5
          end
        end
        entry8(entry9)
        entry9 = enabled13
        entry8 = enabled13.IsA
        entry8 = entry8(entry9, "GuiButton")
        if entry8 then
          entry8 = type
          entry9 = firesignal
          entry8 = entry8(entry9)
          if entry8 == "function" then
            entry8 = pcall
            function entry9()
              local entry5, entry8
              firesignal(enabled13.MouseButton1Click)
            end
            entry8 = entry8(entry9)
            if entry8 then
              entry9 = true
              return true
            end
          end
        end
        entry9 = enabled13
        entry8 = enabled13.IsA
        entry8 = entry8(entry9, "GuiObject")
        if entry8 then
          entry8 = pcall
          function entry9()
            local skipTolbl_14 = false
            local entry5, entry8, x, buttonHasNoSizeText, entry9, entry10, entry11, entry12, entry13, entry14, entry16, entry17
            entry5 = enabled13
            entry5 = entry5.AbsolutePosition
            entry8 = enabled13
            entry8 = entry8.AbsoluteSize
            x = entry8.X
            if not (x <= 0) then
              x = entry8.Y
              if not (x <= 0) then skipTolbl_14 = true end
            end
            if not skipTolbl_14 then x = error end
            if not skipTolbl_14 then buttonHasNoSizeText = "button has no size" end
            if not skipTolbl_14 then x(buttonHasNoSizeText) end
            skipTolbl_14 = false
            x = math
            x = x.floor
            x = x(entry5.X + entry8.X / 2)
            buttonHasNoSizeText = math
            buttonHasNoSizeText = buttonHasNoSizeText.floor
            buttonHasNoSizeText = buttonHasNoSizeText(entry5.Y + entry8.Y / 2)
            sourceContext.callGetItemComponents.SendMouseButtonEvent(sourceContext.callGetItemComponents, x, buttonHasNoSizeText, 0, true, game, 1)
            sourceContext.callGetItemComponents.SendMouseButtonEvent(sourceContext.callGetItemComponents, x, buttonHasNoSizeText, 0, false, game, 1)
          end
          entry8 = entry8(entry9)
          if entry8 then
            entry9 = true
            return true
          end
        end
        entry8 = false
        return false
      end
      backpack3 = player3.PlayerGui
      entry8 = backpack3
      backpack3 = backpack3.FindFirstChild
      dialogueGuiText = "DialogueGui"
      backpack3 = backpack3(entry8, "DialogueGui")
      if backpack3 then
        dialogueGuiText = backpack3
        entry8 = backpack3.FindFirstChild
        findFirstChild = "Frame"
        entry8 = entry8(backpack3, findFirstChild)
        if entry8 then
          entry8 = backpack3.Frame
          entry8 = entry8.Visible
          if entry8 then
            entry8 = backpack3.Frame
            dialogueGuiText = entry8
            entry8 = entry8.FindFirstChild
            findFirstChild = "Options"
            entry8 = entry8(dialogueGuiText, findFirstChild)
            if entry8 then
              entry8 = backpack3.Frame
              entry8 = entry8.Options
              dialogueGuiText = entry8
              entry8 = entry8.FindFirstChild
              findFirstChild = "Option1"
              entry8 = entry8(dialogueGuiText, findFirstChild)
              if not entry8 then
                entry8 = backpack3.Frame
                entry8 = entry8.Options
                dialogueGuiText = entry8
                entry8 = entry8.FindFirstChild
                findFirstChild = "Option2"
                entry8 = entry8(dialogueGuiText, findFirstChild)
              end
            end
            dialogueGuiText = entry8 or dialogueGuiText
            if entry8 then
              findFirstChild = entry8
              dialogueGuiText = entry8.FindFirstChild
              entry9 = "TextButton"
              dialogueGuiText = dialogueGuiText(findFirstChild, "TextButton")
            end
            if dialogueGuiText then
              findFirstChild = a4
              entry9 = dialogueGuiText
              findFirstChild(dialogueGuiText)
            end
            findFirstChild = backpack3.Frame
            entry9 = findFirstChild
            findFirstChild = findFirstChild.FindFirstChild
            entry10 = "ClickContinue"
            findFirstChild = findFirstChild(entry9, "ClickContinue")
            if findFirstChild then
              entry9 = findFirstChild.Visible
              if entry9 then
                entry9 = a4
                entry10 = findFirstChild
                a4(entry10)
              end
            end
            entry9 = sourceContext.runServiceService
            entry9 = sourceContext.runServiceService.Heartbeat
            entry10 = entry9
            entry9 = entry9.Wait
            entry9(entry10)
          end
        end
      end
      entry8 = entry5.Parent
      if entry8 ~= entry3 then
        dialogueGuiText = cannotSellText
        entry8 = cannotSellText.EquipTool
        findFirstChild = entry5
        entry8(cannotSellText, findFirstChild)
        entry8 = os
        entry8 = entry8.clock
        entry8 = entry8()
        while true do
          dialogueGuiText = entry5.Parent
          if dialogueGuiText == entry3 then break end
          dialogueGuiText = os
          dialogueGuiText = dialogueGuiText.clock
          dialogueGuiText = dialogueGuiText()
          dialogueGuiText = dialogueGuiText - entry8
          if not (dialogueGuiText < 0.4) then break end
          dialogueGuiText = sourceContext.runServiceService
          dialogueGuiText = sourceContext.runServiceService.Heartbeat
          findFirstChild = dialogueGuiText
          dialogueGuiText = dialogueGuiText.Wait
          dialogueGuiText(findFirstChild)
        end
      end
      entry8 = entry5.Parent
      if entry8 ~= entry3 then
        entry8 = false
        dialogueGuiText = "Failed to equip item"
        return false, "Failed to equip item"
      end
      entry8 = game
      dialogueGuiText = entry8
      entry8 = entry8.GetService
      findFirstChild = "ReplicatedStorage"
      entry8 = entry8(dialogueGuiText, findFirstChild)
      dialogueGuiText = entry8
      entry8 = entry8.FindFirstChild
      findFirstChild = "Dialogue"
      entry8 = entry8(dialogueGuiText, findFirstChild)
      if entry8 then
        entry8 = game
        entry8 = entry8.ReplicatedStorage
        entry8 = entry8.Dialogue
        dialogueGuiText = entry8
        entry8 = entry8.FindFirstChild
        findFirstChild = "Merchant"
        entry8 = entry8(dialogueGuiText, findFirstChild)
      end
      if entry8 then
        findFirstChild = tostring3
        dialogueGuiText = tostring3.FireServer
        entry9 = "PromptTriggered"
        entry10 = entry8
        dialogueGuiText(findFirstChild, "PromptTriggered", entry8)
      else
        dialogueGuiText = workspace
        findFirstChild = dialogueGuiText
        dialogueGuiText = dialogueGuiText.FindFirstChild
        entry9 = "Dialogues"
        dialogueGuiText = dialogueGuiText(findFirstChild, "Dialogues")
        if dialogueGuiText then
          dialogueGuiText = workspace
          dialogueGuiText = dialogueGuiText.Dialogues
          findFirstChild = dialogueGuiText
          dialogueGuiText = dialogueGuiText.FindFirstChild
          entry9 = "ShiftPlox, The Travelling Merchant"
          dialogueGuiText = dialogueGuiText(findFirstChild, "ShiftPlox, The Travelling Merchant")
        end
        findFirstChild = dialogueGuiText or findFirstChild
        if dialogueGuiText then
          entry9 = dialogueGuiText
          findFirstChild = dialogueGuiText.FindFirstChildWhichIsA
          entry10 = "ProximityPrompt"
          toolText = true
          findFirstChild = findFirstChild(dialogueGuiText, "ProximityPrompt", toolText)
        end
        if findFirstChild then
          entry9 = fireproximityprompt
          if entry9 then
            entry9 = pcall
            function entry10()
              local entry5, entry8
              fireproximityprompt(findFirstChild)
            end
            entry9(entry10)
          end
        end
      end
      dialogueGuiText = 1
      findFirstChild = os
      findFirstChild = findFirstChild.clock
      findFirstChild = findFirstChild()
      findFirstChild = findFirstChild + 8
      entry9 = b
      if b ~= false then
        entry9 = "all"
        skipTolbl_392 = true
      end
      if not skipTolbl_392 then entry9 = "one" end
      skipTolbl_392 = false
      while true do
        entry10 = os
        entry10 = entry10.clock
        entry10 = entry10()
        if not (findFirstChild > entry10 and dialogueGuiText <= 3) then break end
        while true do
          entry10 = player3.PlayerGui
          toolText = entry10
          entry10 = entry10.FindFirstChild
          toolText2 = "DialogueGui"
          entry10 = entry10(toolText, "DialogueGui")
          toolText = entry10 or toolText
          if entry10 then
            toolText = entry10.Enabled
            if toolText then
              toolText2 = entry10
              toolText = entry10.FindFirstChild
              frameText = "Frame"
              toolText = toolText(entry10, "Frame")
            end
          end
          if toolText then
            toolText2 = toolText.Visible
            if toolText2 then skipTolbl_424 = true end
          end
          if not skipTolbl_424 then if 3 <= dialogueGuiText then break end end
          if not skipTolbl_424 then toolText2 = sourceContext.runServiceService end
          if not skipTolbl_424 then toolText2 = toolText2.Heartbeat end
          if not skipTolbl_424 then frameText = toolText2 end
          if not skipTolbl_424 then toolText2 = toolText2.Wait end
          if not skipTolbl_424 then toolText2(frameText) end
          if not skipTolbl_424 then break end
          skipTolbl_424 = false
          frameText = toolText
          toolText2 = toolText.FindFirstChild
          optionsText = "Options"
          toolText2 = toolText2(frameText, "Options")
          frameText = toolText2 or frameText
          if toolText2 then frameText = toolText2.Visible end
          if not frameText then
            isA = toolText
            optionsText = toolText.FindFirstChild
            entry11 = "ClickContinue"
            optionsText = optionsText(isA, "ClickContinue")
            if optionsText then
              isA = optionsText.Visible
              if isA then
                isA = a4
                entry11 = optionsText
                a4(optionsText)
              end
            else
              entry11 = toolText
              isA = toolText.FindFirstChild
              toolText3 = "DialogueFrame"
              isA = isA(entry11, "DialogueFrame")
              if isA then
                entry11 = isA.Visible
                if entry11 then
                  entry11 = a4
                  toolText3 = isA
                  a4(isA)
                end
              else
                entry11 = a4
                toolText3 = toolText
                a4(toolText3)
              end
            end
            isA = pcall
            function entry11()
              local entry5, entry8, x, mathLibrary, entry9, entry10, entry11, entry12, entry13, entry14, entry16, entry17
              entry5 = toolText
              entry5 = entry5.AbsolutePosition
              entry8 = toolText
              entry8 = entry8.AbsoluteSize
              if entry8 then
                x = entry8.X
                if 0 < x then
                  x = entry8.Y
                  if 0 < x then
                    x = math
                    x = x.floor
                    x = x(entry5.X + entry8.X / 2)
                    mathLibrary = math
                    mathLibrary = mathLibrary.floor
                    mathLibrary = mathLibrary(entry5.Y + entry8.Y / 2)
                    sourceContext.callGetItemComponents.SendMouseButtonEvent(sourceContext.callGetItemComponents, x, mathLibrary, 0, true, game, 1)
                    sourceContext.callGetItemComponents.SendMouseButtonEvent(sourceContext.callGetItemComponents, x, mathLibrary, 0, false, game, 1)
                  end
                end
              end
            end
            isA(entry11)
            isA = task
            isA = isA.wait
            entry11 = 0.04
            isA(0.04)
            isA = player3.PlayerGui
            entry11 = isA
            isA = isA.FindFirstChild
            toolText3 = "DialogueGui"
            isA = isA(entry11, "DialogueGui")
            entry10 = isA
            toolText = isA or toolText
            if isA then
              isA = isA.Enabled
              toolText = isA or toolText
              if isA then
                entry11 = entry10
                isA = entry10.FindFirstChild
                toolText3 = "Frame"
                isA = isA(entry10, "Frame")
                toolText = isA
              end
            end
            if toolText then
              entry11 = toolText
              isA = toolText.FindFirstChild
              toolText3 = "Options"
              isA = isA(entry11, "Options")
              toolText2 = isA
              frameText = isA or frameText
              if isA then frameText = isA.Visible end
            end
          end
          if frameText then
            if dialogueGuiText == 1 then
              optionsText = nil
              isA = ipairs
              toolText3 = toolText2
              entry11 = toolText2.GetChildren
              entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText = entry11(toolText2)
              isA, entry11, toolText3 = isA(entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText)
              for entry18, entry19 in isA, entry11, toolText3 do
                entry12 = entry19
                findFirstChild2 = entry19.FindFirstChild
                textButtonText = "TextButton"
                enabled13 = true
                findFirstChild2 = findFirstChild2(entry19, "TextButton", true)
                if not findFirstChild2 then findFirstChild2 = entry19 end
                entry12 = remoteEventText
                textButtonText = entry19
                entry12 = remoteEventText(entry19)
                enabled13 = entry12
                textButtonText = entry12.find
                sellText = "sell"
                textButtonText = textButtonText(entry12, "sell")
                if not textButtonText then
                  enabled13 = entry12
                  textButtonText = entry12.find
                  sellText = "\208\191\209\128\208\190\208\180\208\176\209\130\209\140"
                  textButtonText = textButtonText(entry12, "\208\191\209\128\208\190\208\180\208\176\209\130\209\140")
                  if not textButtonText then
                    enabled13 = entry12
                    textButtonText = entry12.find
                    sellText = "\208\191\209\128\208\190\208\180\208\176\208\188"
                    textButtonText = textButtonText(entry12, "\208\191\209\128\208\190\208\180\208\176\208\188")
                    if not textButtonText then
                      enabled13 = entry12
                      textButtonText = entry12.find
                      sellText = "buy"
                      textButtonText = textButtonText(entry12, "buy")
                      if not textButtonText then skipTolbl_533 = true end
                    end
                  end
                end
                if not skipTolbl_533 then optionsText = findFirstChild2 end
                if not skipTolbl_533 then break end
                skipTolbl_533 = false
              end
              if optionsText then
                isA = a4
                entry11 = optionsText
                a4(optionsText)
                dialogueGuiText = 2
                isA = task
                isA = isA.wait
                entry11 = 0.06
                isA(0.06)
                isA = player3.PlayerGui
                entry11 = isA
                isA = isA.FindFirstChild
                toolText3 = "DialogueGui"
                isA = isA(entry11, "DialogueGui")
                entry11 = isA or entry11
                if isA then
                  entry11 = isA.Enabled
                  if entry11 then
                    toolText3 = isA
                    entry11 = isA.FindFirstChild
                    frameText2 = "Frame"
                    entry11 = entry11(isA, "Frame")
                  end
                end
                if entry11 then
                  toolText3 = entry11.Visible
                  if toolText3 then
                    frameText2 = entry11
                    toolText3 = entry11.FindFirstChild
                    clickContinueText = "ClickContinue"
                    toolText3 = toolText3(entry11, "ClickContinue")
                    if toolText3 then
                      frameText2 = toolText3.Visible
                      if frameText2 then
                        frameText2 = a4
                        clickContinueText = toolText3
                        a4(toolText3)
                      end
                    end
                    clickContinueText = entry11
                    frameText2 = entry11.FindFirstChild
                    findFirstChild2 = "DialogueFrame"
                    frameText2 = frameText2(entry11, "DialogueFrame")
                    if frameText2 then
                      clickContinueText = frameText2.Visible
                      if clickContinueText then
                        clickContinueText = a4
                        findFirstChild2 = frameText2
                        a4(frameText2)
                      end
                    else
                      clickContinueText = a4
                      findFirstChild2 = entry11
                      a4(entry11)
                    end
                  end
                end
              end
            elseif dialogueGuiText == 2 then
              optionsText = nil
              isA = ipairs
              toolText3 = toolText2
              entry11 = toolText2.GetChildren
              entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText = entry11(toolText2)
              isA, entry11, toolText3 = isA(entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText)
              for entry20, entry21 in isA, entry11, toolText3 do
                entry12 = entry21
                findFirstChild2 = entry21.FindFirstChild
                textButtonText = "TextButton"
                enabled13 = true
                findFirstChild2 = findFirstChild2(entry21, "TextButton", true)
                if not findFirstChild2 then findFirstChild2 = entry21 end
                entry12 = remoteEventText
                textButtonText = entry21
                entry12 = remoteEventText(entry21)
                enabled13 = entry12
                textButtonText = entry12.find
                sellText = "deal"
                textButtonText = textButtonText(entry12, "deal")
                if not textButtonText then
                  enabled13 = entry12
                  textButtonText = entry12.find
                  sellText = "\209\129\208\180\208\181\208\187\208\186\208\176"
                  textButtonText = textButtonText(entry12, "\209\129\208\180\208\181\208\187\208\186\208\176")
                  if not textButtonText then
                    enabled13 = entry12
                    textButtonText = entry12.find
                    sellText = "\209\129\208\190\208\179\208\187\208\176\209\129"
                    textButtonText = textButtonText(entry12, "\209\129\208\190\208\179\208\187\208\176\209\129")
                    if not textButtonText then
                      enabled13 = entry12
                      textButtonText = entry12.find
                      sellText = "\208\180\208\190\208\179\208\190\208\178\208\190\209\128"
                      textButtonText = textButtonText(entry12, "\208\180\208\190\208\179\208\190\208\178\208\190\209\128")
                      if not textButtonText then
                        enabled13 = entry12
                        textButtonText = entry12.find
                        sellText = "\208\180\208\176"
                        textButtonText = textButtonText(entry12, "\208\180\208\176")
                        if not textButtonText then skipTolbl_634 = true end
                      end
                    end
                  end
                end
                if not skipTolbl_634 then optionsText = findFirstChild2 end
                if not skipTolbl_634 then break end
                skipTolbl_634 = false
              end
              if optionsText then
                isA = a4
                entry11 = optionsText
                a4(optionsText)
                dialogueGuiText = 3
                isA = task
                isA = isA.wait
                entry11 = 0.06
                isA(0.06)
                isA = player3.PlayerGui
                entry11 = isA
                isA = isA.FindFirstChild
                toolText3 = "DialogueGui"
                isA = isA(entry11, "DialogueGui")
                entry11 = isA or entry11
                if isA then
                  entry11 = isA.Enabled
                  if entry11 then
                    toolText3 = isA
                    entry11 = isA.FindFirstChild
                    frameText2 = "Frame"
                    entry11 = entry11(isA, "Frame")
                  end
                end
                if entry11 then
                  toolText3 = entry11.Visible
                  if toolText3 then
                    frameText2 = entry11
                    toolText3 = entry11.FindFirstChild
                    clickContinueText = "ClickContinue"
                    toolText3 = toolText3(entry11, "ClickContinue")
                    if toolText3 then
                      frameText2 = toolText3.Visible
                      if frameText2 then
                        frameText2 = a4
                        clickContinueText = toolText3
                        a4(toolText3)
                      end
                    end
                    clickContinueText = entry11
                    frameText2 = entry11.FindFirstChild
                    findFirstChild2 = "DialogueFrame"
                    frameText2 = frameText2(entry11, "DialogueFrame")
                    if frameText2 then
                      clickContinueText = frameText2.Visible
                      if clickContinueText then
                        clickContinueText = a4
                        findFirstChild2 = frameText2
                        a4(frameText2)
                      end
                    else
                      clickContinueText = a4
                      findFirstChild2 = entry11
                      a4(entry11)
                    end
                  end
                end
              end
            else
              if dialogueGuiText ~= 3 then skipTolbl_869 = true end
              if not skipTolbl_869 then optionsText = nil end
              if not skipTolbl_869 then isA = ipairs end
              if not skipTolbl_869 then toolText3 = toolText2 end
              if not skipTolbl_869 then entry11 = toolText2.GetChildren end
              if not skipTolbl_869 then
                entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText = entry11(toolText3)
              end
              if not skipTolbl_869 then
                isA, entry11, toolText3 = isA(entry11, toolText3, frameText2, clickContinueText, findFirstChild2, entry12, textButtonText, enabled13, sellText)
              end
              if not skipTolbl_869 then
                for entry22, entry23 in isA, entry11, toolText3 do
                  entry12 = entry23
                  findFirstChild2 = entry23.FindFirstChild
                  textButtonText = "TextButton"
                  enabled13 = true
                  findFirstChild2 = findFirstChild2(entry23, "TextButton", true)
                  if not findFirstChild2 then findFirstChild2 = entry23 end
                  entry12 = remoteEventText
                  textButtonText = entry23
                  entry12 = remoteEventText(entry23)
                  enabled13 = entry12
                  textButtonText = entry12.find
                  sellText = entry9
                  textButtonText = textButtonText(entry12, entry9)
                  if not textButtonText then
                    if entry9 == "all" then
                      enabled13 = entry12
                      textButtonText = entry12.find
                      sellText = "\208\178\209\129\208\181"
                      textButtonText = textButtonText(entry12, "\208\178\209\129\208\181")
                      if textButtonText then skipTolbl_737 = true end
                      if not skipTolbl_737 then enabled13 = entry12 end
                      if not skipTolbl_737 then textButtonText = entry12.find end
                      if not skipTolbl_737 then sellText = "\208\178\209\129\209\145" end
                      if not skipTolbl_737 then textButtonText = textButtonText(enabled13, sellText) end
                      if not skipTolbl_737 then if textButtonText then skipTolbl_737 = true end end
                    end
                    if not skipTolbl_737 then if entry9 ~= "one" then skipTolbl_739 = true end end
                    if not (skipTolbl_737 or skipTolbl_739) then enabled13 = entry12 end
                    if not (skipTolbl_737 or skipTolbl_739) then textButtonText = entry12.find end
                    if not (skipTolbl_737 or skipTolbl_739) then sellText = "\208\190\208\180\208\184\208\189" end
                    if not (skipTolbl_737 or skipTolbl_739) then textButtonText = textButtonText(enabled13, sellText) end
                    if not (skipTolbl_737 or skipTolbl_739) then
                      if not textButtonText then
                        enabled13 = entry12
                        textButtonText = entry12.find
                        sellText = "\208\190\208\180\208\189\209\131"
                        textButtonText = textButtonText(entry12, "\208\190\208\180\208\189\209\131")
                        if not textButtonText then skipTolbl_739 = true end
                      end
                    end
                  end
                  skipTolbl_737 = false
                  if not skipTolbl_739 then optionsText = findFirstChild2 end
                  if not skipTolbl_739 then break end
                  skipTolbl_739 = false
                end
              end
              if not skipTolbl_869 then
                if not optionsText then
                  isA = b
                  if b ~= false then
                    entry11 = toolText2
                    isA = toolText2.FindFirstChild
                    toolText3 = "Option6"
                    isA = isA(toolText2, "Option6")
                    entry11 = isA or toolText2
                    if isA then
                      toolText3 = isA
                      entry11 = isA.FindFirstChild
                      frameText2 = "TextButton"
                      entry11 = entry11(isA, "TextButton")
                    end
                    if entry11 then
                      toolText3 = remoteEventText
                      frameText2 = isA
                      toolText3 = remoteEventText(isA)
                      frameText2 = toolText3
                      toolText3 = toolText3.find
                      clickContinueText = "all"
                      toolText3 = toolText3(frameText2, "all")
                      if not toolText3 then
                        toolText3 = remoteEventText
                        frameText2 = isA
                        toolText3 = remoteEventText(isA)
                        frameText2 = toolText3
                        toolText3 = toolText3.find
                        clickContinueText = "\208\178\209\129\208\181"
                        toolText3 = toolText3(frameText2, "\208\178\209\129\208\181")
                        if not toolText3 then skipTolbl_773 = true end
                      end
                      if not skipTolbl_773 then optionsText = entry11 end
                    end
                  end
                end
              end
              skipTolbl_773 = false
              if not skipTolbl_869 then
                if optionsText then
                  isA = a4
                  entry11 = optionsText
                  a4(optionsText)
                  dialogueGuiText = 4
                  isA = task
                  isA = isA.wait
                  entry11 = 0.06
                  isA(0.06)
                  isA = player3.PlayerGui
                  entry11 = isA
                  isA = isA.FindFirstChild
                  toolText3 = "DialogueGui"
                  isA = isA(entry11, "DialogueGui")
                  entry11 = isA or entry11
                  if isA then
                    entry11 = isA.Enabled
                    if entry11 then
                      toolText3 = isA
                      entry11 = isA.FindFirstChild
                      frameText2 = "Frame"
                      entry11 = entry11(isA, "Frame")
                    end
                  end
                  if entry11 then
                    toolText3 = entry11.Visible
                    if toolText3 then
                      frameText2 = entry11
                      toolText3 = entry11.FindFirstChild
                      clickContinueText = "ClickContinue"
                      toolText3 = toolText3(entry11, "ClickContinue")
                      if toolText3 then
                        frameText2 = toolText3.Visible
                        if frameText2 then
                          frameText2 = a4
                          clickContinueText = toolText3
                          a4(toolText3)
                        end
                      else
                        clickContinueText = entry11
                        frameText2 = entry11.FindFirstChild
                        findFirstChild2 = "DialogueFrame"
                        frameText2 = frameText2(entry11, "DialogueFrame")
                        if frameText2 then
                          clickContinueText = frameText2.Visible
                          if clickContinueText then
                            clickContinueText = a4
                            findFirstChild2 = frameText2
                            a4(frameText2)
                          end
                        else
                          clickContinueText = a4
                          findFirstChild2 = entry11
                          a4(entry11)
                        end
                      end
                    end
                  end
                  break
                end
              end
            end
          else
            isA = toolText
            optionsText = toolText.FindFirstChild
            entry11 = "ClickContinue"
            optionsText = optionsText(isA, "ClickContinue")
            if optionsText then
              isA = optionsText.Visible
              if isA then
                isA = a4
                entry11 = optionsText
                a4(optionsText)
                isA = task
                isA = isA.wait
                entry11 = 0.04
                isA(0.04)
                if optionsText then
                  isA = optionsText.Visible
                  if isA then
                    isA = a4
                    entry11 = optionsText
                    a4(optionsText)
                  end
                end
              end
            else
              entry11 = toolText
              isA = toolText.FindFirstChild
              toolText3 = "DialogueFrame"
              isA = isA(entry11, "DialogueFrame")
              if isA then
                entry11 = isA.Visible
                if entry11 then
                  entry11 = a4
                  toolText3 = isA
                  a4(isA)
                end
              else
                entry11 = a4
                toolText3 = toolText
                a4(toolText3)
              end
            end
          end
          skipTolbl_869 = false
          optionsText = sourceContext.runServiceService
          optionsText = sourceContext.runServiceService.Heartbeat
          isA = optionsText
          optionsText = optionsText.Wait
          optionsText(isA)
          break
        end
      end
      entry10 = player3.PlayerGui
      toolText = entry10
      entry10 = entry10.FindFirstChild
      toolText2 = "DialogueGui"
      entry10 = entry10(toolText, "DialogueGui")
      toolText = entry10 or toolText
      if entry10 then
        toolText = entry10.Enabled
        if toolText then
          toolText2 = entry10
          toolText = entry10.FindFirstChild
          frameText = "Frame"
          toolText = toolText(entry10, "Frame")
        end
      end
      if toolText then
        toolText2 = toolText.Visible
        if toolText2 then
          frameText = toolText
          toolText2 = toolText.FindFirstChild
          optionsText = "ClickContinue"
          toolText2 = toolText2(frameText, "ClickContinue")
          if toolText2 then
            frameText = toolText2.Visible
            if frameText then
              frameText = a4
              optionsText = toolText2
              a4(toolText2)
            end
          end
        end
      end
      toolText2 = os
      toolText2 = toolText2.clock
      toolText2 = toolText2()
      while true do
        frameText = os
        frameText = frameText.clock
        frameText = frameText()
        frameText = frameText - toolText2
        if not (frameText < 0.6) then break end
        frameText = entry5 or frameText
        if entry5 then
          frameText = entry5.Parent
          if frameText then
            frameText = entry5.Parent
            frameText = frameText == entry3
          end
        end
        if not frameText then break end
        optionsText = player3.PlayerGui
        isA = optionsText
        optionsText = optionsText.FindFirstChild
        entry11 = "DialogueGui"
        optionsText = optionsText(isA, "DialogueGui")
        isA = optionsText or isA
        if optionsText then
          isA = optionsText.Enabled
          if isA then
            entry11 = optionsText
            isA = optionsText.FindFirstChild
            toolText3 = "Frame"
            isA = isA(optionsText, "Frame")
          end
        end
        if isA then
          entry11 = isA.Visible
          if entry11 then
            toolText3 = isA
            entry11 = isA.FindFirstChild
            frameText2 = "ClickContinue"
            entry11 = entry11(isA, "ClickContinue")
            if entry11 then
              toolText3 = entry11.Visible
              if toolText3 then
                toolText3 = a4
                frameText2 = entry11
                a4(entry11)
              end
            end
          end
        end
        entry11 = sourceContext.runServiceService
        entry11 = sourceContext.runServiceService.Heartbeat
        toolText3 = entry11
        entry11 = entry11.Wait
        entry11(toolText3)
      end
      frameText = entry5 or frameText
      if entry5 then
        frameText = entry5.Parent
        if frameText then
          frameText = entry5.Parent
          frameText = frameText == entry3
        end
      end
      return not frameText or 4 <= dialogueGuiText
    end
    local entry5, entry8 = getgenv4(_YBA_LastSellTick)
    sourceContext.enabled9 = false
    getgenv()._YBA_SellingBusy = false
    if entry5 then return entry8 end
    return false, entry8
  end
  return false, "No item provided"
end
sourceContext.savedASM = sourceContext.callback35("ASM", false)
autoSellMax = sourceContext.savedASM
sourceContext.savedASM = sourceContext.callback35
sourceContext.savedASM = sourceContext.savedASM("ABLA", false)
autoBuyLuckyArrow = sourceContext.savedASM
sourceContext.savedASM = 9
function checkAndBuyLuckyArrow()
  if not autoBuyLuckyArrow then return end
  local LocalPlayer = game:GetService("Players")
  LocalPlayer = LocalPlayer.LocalPlayer
  LocalPlayer = LocalPlayer or sourceContext.player or sourceContext.player
  local playerStats = LocalPlayer and LocalPlayer:FindFirstChild("PlayerStats")
  local count4 = playerStats and playerStats:FindFirstChild("Money") and playerStats.Money.Value or 0
  if count4 < 75000 then return end
  local character = LocalPlayer and LocalPlayer.Character
  local remoteEvent = character and character:FindFirstChild("RemoteEvent")
  if not remoteEvent then return end
  local function callback8()
    local count4 = 0
    local backpack3 = LocalPlayer and LocalPlayer:FindFirstChild("Backpack")
    if backpack3 then
      local pcallResult, entries8 = pcall(function() return backpack3:GetChildren() end)
      if pcallResult and entries8 then
        for k, v in ipairs(entries8) do if v and sourceContext.normalizeItemName(v.Name) == "Lucky Arrow" then count4 = count4 + 1 end end
      end
    end
    if character then
      local pcallResult2, entries9 = pcall(function() return character:GetChildren() end)
      if pcallResult2 and entries9 then
        for k2, v2 in ipairs(entries9) do
          if v2 and v2:IsA("Tool") and sourceContext.normalizeItemName(v2.Name) == "Lucky Arrow" then count4 = count4 + 1 end
        end
      end
    end
    return count4
  end
  local entry5 = callback8()
  if sourceContext.savedASM <= entry5 then return end
  local min = math.min(math.floor(count4 / 75000), sourceContext.savedASM - entry5)
  if min <= 0 then return end
  if sourceContext.notify then sourceContext.notify("YBA Script", "Buying " .. min .. "x Lucky Arrow (" .. entry5 .. "/" .. sourceContext.savedASM .. ")") end
  for i = 1, min do
    pcall(function() remoteEvent:FireServer("PurchaseShopItem", { ItemName = "1x Lucky Arrow" }, 1, 2) end)
    task.wait(0.15)
  end
end
function isAutoSellBlacklisted(a)
  local sellBlacklist2 = sellBlacklist or _G.YBAItemFarm and _G.YBAItemFarm.sellBlacklist
  if sellBlacklist2 and #sellBlacklist2 ~= 0 then
    local a3 = sourceContext.normalizeItemName and sourceContext.normalizeItemName(a) or a
    for k, v in ipairs(sellBlacklist2) do if v == a or sourceContext.normalizeItemName and sourceContext.normalizeItemName(v) == a3 then return true end end
    return false
  end
  return false
end
function checkAndSellMax()
  local pcallResult, entry5 = pcall(function()
    if not autoSellMax then return end
    local count4 = sourceContext.callback43 and sourceContext.callback43() or 0
    if count4 >= 1000000 then return end
    if sourceContext.ipairs3Result then sourceContext.ipairs3Result() end
    if not (sourceContext.entries4 and sourceContext.maxLimits) then return end
    do
      local enabled14 = false
      local pairsResult, entry5, entry8 = pairs(sourceContext.entries4)
      for k, v in pairsResult, entry5, entry8 do
        if (sourceContext.maxLimits[k] or 25) <= v and (not sourceContext.callback46 or not sourceContext.callback46(k)) and not isAutoSellBlacklisted(k) then
          enabled14 = true
          break
        end
      end
      if not enabled14 then return end
      if cleanupItemStick then pcall(cleanupItemStick) end
      local entries8 = {}
      local count5 = 0
      for k2, v2 in pairs(sourceContext.entries4) do
        if (sourceContext.maxLimits[k2] or 25) <= v2 and (not sourceContext.callback46 or not sourceContext.callback46(k2)) and not isAutoSellBlacklisted(k2) then
          local sellItemResult = sellItem and sellItem(k2, true)
          if sellItemResult then
            entries8[k2] = v2
            count5 = count5 + v2
            task.wait(0.05)
          end
        end
      end
      if count5 > 0 then
        local entries9 = {}
        for k3, v3 in pairs(entries8) do table.insert(entries9, v3 .. "x " .. k3) end
        if sourceContext.notify then sourceContext.notify("YBA Script", "Auto sold: " .. table.concat(entries9, ", ")) end
      end
      return
    end
  end)
  if not pcallResult and entry5 then warn("[AutoSell] Error in checkAndSellMax: " .. tostring(entry5)) end
end
sourceContext.settings5 = { [1] = "Gold Coin", [2] = "Diamond", [3] = "Quinton's Glove", [4] = "Zeppeli's Hat", [5] = "Caesar's Headband", [6] = "Ancient Scroll" }
function sellAll(a)
  if not (a and a ~= "") then return end
  local normalizeItemNameResult = sourceContext.normalizeItemName(a)
  if sourceContext.ipairs3Result then sourceContext.ipairs3Result() end
  local count4 = sourceContext.sfCountItem2 and sourceContext.sfCountItem2(normalizeItemNameResult) or sourceContext.entries4 and sourceContext.entries4[normalizeItemNameResult] or 0
  if count4 == 0 then
    if sourceContext.notify then sourceContext.notify("YBA Script", "No " .. tostring(normalizeItemNameResult) .. " found.") end
    return
  end
  if sourceContext.callback46 and (sourceContext.callback46(normalizeItemNameResult) or sourceContext.callback46(a)) then
    if sourceContext.notify then sourceContext.notify("YBA Script", "Cannot sell " .. tostring(normalizeItemNameResult) .. " (Item is protected).") end
    return
  end
  local sellItemResult = sellItem and sellItem(normalizeItemNameResult, true)
  if sellItemResult then
    if sourceContext.notify then
      sourceContext.notify("YBA Script", "Sold all (" .. count4 .. ") " .. tostring(normalizeItemNameResult) .. (count4 > 1 and "s" or "") .. ".")
    end
    task.wait(0.05)
  elseif sourceContext.notify then sourceContext.notify("YBA Script", "Failed to sell " .. tostring(normalizeItemNameResult) .. ": " .. tostring("unknown")) end
end
function sellAllSelected(entries8)
  if sourceContext.ipairs3Result then sourceContext.ipairs3Result() end
  local count4 = 0
  local entries9 = {}
  if entries8 then
    for k, v in ipairs(entries8) do
      local normalizeItemNameResult = sourceContext.normalizeItemName(v)
      local count5 = sourceContext.sfCountItem2 and sourceContext.sfCountItem2(normalizeItemNameResult) or sourceContext.entries4 and sourceContext.entries4[normalizeItemNameResult] or 0
      if count5 > 0 and (not sourceContext.callback46 or not sourceContext.callback46(normalizeItemNameResult) and not sourceContext.callback46(v)) then
        local sellItemResult = sellItem and sellItem(normalizeItemNameResult, true)
        local count6 = count5 - (sourceContext.sfCountItem2 and sourceContext.sfCountItem2(normalizeItemNameResult) or 0)
        if count6 <= 0 and sellItemResult then count6 = count5 end
        if count6 > 0 or sellItemResult then
          count4 = count4 + (count6 > 0 and count6 or 1)
          local insert, entry5 = table.insert, entries9
          insert(entries9, (count6 > 0 and count6 or 1) .. "x " .. normalizeItemNameResult)
          task.wait(0.05)
        end
      end
    end
  end
  if count4 == 0 then
    if sourceContext.notify then sourceContext.notify("YBA Script", "No selected items found to sell.") end
  elseif sourceContext.notify then sourceContext.notify("YBA Script", "Sold selected items: " .. table.concat(entries9, ", ")) end
end
function sellAllWorthless() sellAllSelected(sourceContext.settings5) end
function sellInventory()
  if sourceContext.ipairs3Result then sourceContext.ipairs3Result() end
  local entries8 = sourceContext.entry15 and sourceContext.entry15() or {}
  if #entries8 == 0 and sourceContext.entries4 then
    for k, v in pairs(sourceContext.entries4) do
      if v > 0 and (not sourceContext.callback46 or not sourceContext.callback46(k)) then table.insert(entries8, { normName = k, rawName = k, count = v }) end
    end
  end
  if #entries8 == 0 then
    if sourceContext.notify then sourceContext.notify("YBA Script", "No sellable items in inventory.") end
    return
  end
  local count4 = 0
  local entries9 = {}
  for k2, v2 in ipairs(entries8) do
    local normName = v2.normName
    local normName2 = v2.rawName or normName
    if not sourceContext.callback46(normName) and not sourceContext.callback46(normName2) then
      if sourceContext.getgenv2 and sourceContext.getgenv2() then sourceContext.callback27(0.5) end
      local count5 = sourceContext.sfCountItem2 and sourceContext.sfCountItem2(normName) or v2.count or 0
      if count5 > 0 then
        local sellItemResult = sellItem and sellItem(normName, true)
        local count6 = count5 - (sourceContext.sfCountItem2 and sourceContext.sfCountItem2(normName) or 0)
        if count6 <= 0 and sellItemResult then count6 = count5 end
        if count6 > 0 or sellItemResult then
          count4 = count4 + (count6 > 0 and count6 or 1)
          local insert, entry5 = table.insert, entries9
          insert(entries9, (count6 > 0 and count6 or 1) .. "x " .. normName)
          task.wait(0.08)
        end
      end
    end
  end
  if sourceContext.ipairs3Result then sourceContext.ipairs3Result() end
  if count4 == 0 then
    if sourceContext.notify then sourceContext.notify("YBA Script", "No sellable items were sold.") end
  elseif sourceContext.notify then sourceContext.notify("YBA Script", "Sold from inventory: " .. table.concat(entries9, ", ")) end
end
sourceContext.enabled14 = false
function sourceContext.startItemFarm()
  if sourceContext.enabled14 then return end
  sourceContext.enabled14 = true
  local function callback8(a)
    if a and a:IsA("Tool") then
      local Name = a.Name
      local Name2 = sourceContext.normalizeItemName and sourceContext.normalizeItemName(Name) or Name
      if sourceContext.sendItemPickupWebhook and Name then
        sourceContext.sendItemPickupWebhook(Name2, sourceContext.sfCountItem2 and sourceContext.sfCountItem2(Name2) or 1, sourceContext.maxLimits and (sourceContext.maxLimits[Name2] or sourceContext.maxLimits[Name]) or 25)
      end
      if autoSellMax then
        local count4 = sourceContext.callback43 and sourceContext.callback43() or 0
        if count4 < 1000000 and not sourceContext.enabled9 and sourceContext.maxLimits and (sourceContext.maxLimits[Name2] or sourceContext.maxLimits[Name]) then
          task.wait(0.3)
          pcall(checkAndSellMax)
        end
      end
    end
  end
  local function callback10(a)
    if not a then return end
    a.ChildAdded:Connect(callback8)
  end
  local function callback11(a)
    if not a then return end
    a.ChildAdded:Connect(callback8)
  end
  callback10(sourceContext.player:FindFirstChild("Backpack") or sourceContext.player:WaitForChild("Backpack", 3))
  if sourceContext.player.Character then callback11(sourceContext.player.Character) end
  sourceContext.player.CharacterAdded:Connect(function(a)
    task.wait(0.5)
    callback11(a)
    callback10(sourceContext.player:FindFirstChild("Backpack"))
  end)
  task.spawn(function()
    while true do
      task.wait(5)
      if autoSellMax and not sourceContext.enabled9 then pcall(checkAndSellMax) end
    end
  end)
end
sourceContext.startItemFarm()
sourceContext.environment2.itemOptions = itemOptions
sourceContext.environment2.sellSpecificOptions = sellSpecificOptions
sourceContext.environment2.sellBlacklistOptions = sellBlacklistOptions
sourceContext.environment2.sellItem = sellItem
sourceContext.environment2.sellAll = sellAll
sourceContext.environment2.sellAllSelected = sellAllSelected
sourceContext.environment2.sellAllWorthless = sellAllWorthless
sourceContext.environment2.sellInventory = sellInventory
sourceContext.environment2.checkAndBuyLuckyArrow = checkAndBuyLuckyArrow
sourceContext.environment2.checkAndSellMax = checkAndSellMax
do
  local enabled15, connectResult3, count4, enabled16 = false, nil, 0.5, false
  local count5 = 0
  local function callback47()
    local Workspace = game.Workspace
    Workspace = Workspace:FindFirstChild("Item_Spawns")
    if Workspace then return Workspace:FindFirstChild("Items") end
    return nil
  end
  local function callback48(_)
    local entry5 = callback47()
    if not entry5 then return end
    for k, v in pairs(entry5:GetChildren()) do
      local proximityPrompt = v:FindFirstChild("ProximityPrompt")
      if proximityPrompt then pcall(function() proximityPrompt.HoldDuration = 0.5 end) end
    end
  end
  function enableInstantPickup()
    enabled15 = true
    callback48(true)
    local entry5 = callback47()
    if entry5 then
      connectResult3 = entry5.ChildAdded:Connect(function(a)
        task.wait(0.05)
        if not (enabled15 and not enabled16 and not (tick() - count5 < 0.35)) then return end
        local Parent = a
        local proximityPrompt2 = a:FindFirstChildWhichIsA("ProximityPrompt", true) or a.Parent and a.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
        Parent = nil
        if a:IsA("BasePart") then
          Parent = a
        else
          local ipairsResult, entry5, entry8 = ipairs(a:GetDescendants())
          for k, v in ipairsResult, entry5, entry8 do
            if v:IsA("BasePart") and v.Transparency < 1 then
              Parent = v
              break
            end
          end
          if not Parent and proximityPrompt2 and proximityPrompt2.Parent and proximityPrompt2.Parent:IsA("BasePart") then
            Parent = proximityPrompt2.Parent
          elseif not Parent then Parent = a:FindFirstChildWhichIsA("BasePart", true) end
        end
        if proximityPrompt2 and Parent then
          local humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
          if not humanoidRootPart or 12 < (Parent.Position - humanoidRootPart.Position).Magnitude then return end
          enabled16 = true
          count5 = tick()
          pcall(function() activatePrompt(proximityPrompt2, 0.5, true) end)
          enabled16 = false
        end
      end)
    end
  end
  function disableInstantPickup()
    enabled15 = false
    enabled16 = false
    callback48(false)
    if connectResult3 then
      connectResult3:Disconnect()
      connectResult3 = nil
    end
  end
  local environment3 = getgenv()
  local ItemESPData = getgenv()
  ItemESPData = ItemESPData.ItemESPData
  if not ItemESPData then ItemESPData = { enabled = false, guis = {}, conns = {}, selected = {}, selectedLookup = {}, hasFilter = false } end
  environment3.ItemESPData = ItemESPData
  environment3 = getgenv
  environment3 = environment3()
  environment3 = environment3.ItemESPData
  local entry18 = tonumber
  local entry19
  entry19 = if sourceContext.callback35 then sourceContext.callback35("IESPSize", 14) else sourceContext.callback35
  environment3.textSize = entry18(entry19) or 14
  function environment3(entries8)
    local selectedLookup = {}
    local hasFilter = false
    if entries8 and #entries8 > 0 then
      for k, v in ipairs(entries8) do
        selectedLookup[sourceContext.normalizeItemName(v)] = true
        selectedLookup[tostring(v)] = true
        hasFilter = true
      end
    end
    getgenv().ItemESPData.selectedLookup = selectedLookup
    getgenv().ItemESPData.hasFilter = hasFilter
  end
  local function callback49(a)
    local ItemESPData = getgenv()
    ItemESPData = ItemESPData.ItemESPData
    if ItemESPData.hasFilter then
      local normalizeItemNameResult = sourceContext.normalizeItemName(a)
      return ItemESPData.selectedLookup[normalizeItemNameResult] == true or ItemESPData.selectedLookup[a] == true
    end
    return true
  end
  local function callback50(a)
    if isItemAvailable then
      local pcallResult, entry5 = pcall(isItemAvailable, a)
      if pcallResult then return entry5 and true or false end
    end
    return true
  end
  local function callback51(a) return tostring(a or ""):lower():find("lucky", 1, true) ~= nil end
  local function callback52(a)
    local proximityPrompt3 = a:FindFirstChildWhichIsA("ProximityPrompt", true) or a.Parent and a.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
    local a3 = nil
    if a:IsA("BasePart") then
      a3 = a
    else
      if a:IsA("Model") and a.PrimaryPart then
        a3 = a.PrimaryPart
      else
        local ipairsResult, entry5, entry8 = ipairs(a:GetChildren())
        for k, v in ipairsResult, entry5, entry8 do
          if v:IsA("BasePart") and v.Transparency < 1 then
            a3 = v
            break
          end
        end
        if not a3 and proximityPrompt3 and proximityPrompt3.Parent and proximityPrompt3.Parent:IsA("BasePart") then
          a3 = proximityPrompt3.Parent
        elseif not a3 then a3 = a:FindFirstChildWhichIsA("BasePart", true) end
      end
    end
    return a3, proximityPrompt3
  end
  local function callback53(a)
    local ItemESPData = getgenv()
    ItemESPData = ItemESPData.ItemESPData
    local gui = ItemESPData.guis[a]
    if gui then
      pcall(gui.Destroy, gui)
      ItemESPData.guis[a] = nil
    end
  end
  function getEspParent()
    local playerGui2
    pcall(function()
      local LocalPlayer = game:GetService("Players").LocalPlayer
      playerGui2 = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end)
    if playerGui2 then return playerGui2 end
    local getHiddenGuiResult = nil
    pcall(function() getHiddenGuiResult = gethui and gethui() or get_hidden_gui and get_hidden_gui() end)
    if getHiddenGuiResult and typeof(getHiddenGuiResult) == "Instance" then return getHiddenGuiResult end
    return game:GetService("CoreGui")
  end
  function parentEspGui(a)
    if a then
      pcall(function() a.Parent = getEspParent() end)
      if a.Parent == nil then
        pcall(function()
          local Parent = gethui and gethui() or get_hidden_gui and get_hidden_gui()
          if Parent and typeof(Parent) == "Instance" then a.Parent = Parent end
        end)
      end
      if a.Parent == nil then pcall(function() a.Parent = game:GetService("CoreGui") end) end
      return a.Parent ~= nil
    end
    return false
  end
  local function callback54(a)
    local ItemESPData = getgenv()
    ItemESPData = ItemESPData.ItemESPData
    if not (ItemESPData.enabled and a and a.Parent) then return end
    if callback50(a) then
      local Parent = ItemESPData.guis[a]
      if Parent and Parent.Parent then return end
      local Adornee, entry5, entry8 = nil, nil, nil
      if getItemComponents then
        local pcallResult, entry9, entry10, entry11 = pcall(getItemComponents, a)
        if pcallResult and entry9 and entry10 then Adornee, entry5, entry8 = entry9, entry10, entry11 end
      end
      if not (entry5 and Adornee) then Adornee, entry5 = callback52(a) end
      if entry5 and Adornee then
        if entry5.Enabled ~= false and not (Adornee.Transparency >= 1) and Adornee:IsDescendantOf(workspace) then
          local Name
          Name = if entry8 then entry8 else if entry5.ObjectText then if entry5.ObjectText == "" then a.Name else entry5.ObjectText or a.Name else a.Name
          local Text = sourceContext.normalizeItemName(Name)
          if callback49(Text) then
            local TextColor3 = callback51(Text) and Color3.fromRGB(255, 220, 0) or Color3.fromRGB(255, 255, 255)
            local TextSize = ItemESPData.textSize or 14
            Parent = Instance.new("BillboardGui")
            Parent.Name = "RailHubItemESP"
            Parent.Size = UDim2.fromOffset(200, TextSize + 12)
            Parent.StudsOffset = Vector3.new(0, 2.5, 0)
            Parent.AlwaysOnTop = true
            Parent.Adornee = Adornee
            local new = Instance.new("TextLabel")
            new.Name = "Label"
            new.BackgroundTransparency = 1
            new.Size = UDim2.fromScale(1, 1)
            new.Font = Enum.Font.GothamBold
            new.TextColor3 = TextColor3
            new.TextStrokeTransparency = 0
            new.TextScaled = false
            new.TextSize = TextSize
            new.Text = Text
            new.Parent = Parent
            if parentEspGui(Parent) then ItemESPData.guis[a] = Parent else pcall(Parent.Destroy, Parent) end
            return
          end
          callback53(a)
          return
        end
        callback53(a)
        return
      end
      callback53(a)
      return
    end
    callback53(a)
  end
  function clearItemESP()
    local ItemESPData = getgenv().ItemESPData
    for k, v in pairs(ItemESPData.guis) do
      if v then pcall(v.Destroy, v) end
      ItemESPData.guis[k] = nil
    end
    for k2, v2 in pairs(ItemESPData.conns) do
      if v2 then pcall(v2.Disconnect, v2) end
      ItemESPData.conns[k2] = nil
    end
  end
  function refreshItemESP()
    local ItemESPData = getgenv().ItemESPData
    local entry5 = callback47()
    if ItemESPData.enabled and entry5 then
      environment3(ItemESPData.selected)
      local entries8 = {}
      for k, v in ipairs(entry5:GetChildren()) do
        entries8[v] = true
        callback54(v)
      end
      for k2, v2 in pairs(ItemESPData.guis) do
        if not entries8[k2] or not k2.Parent then
          if v2 then pcall(v2.Destroy, v2) end
          ItemESPData.guis[k2] = nil
        end
      end
      return
    end
    clearItemESP()
  end
  function setItemESPFilter(a)
    getgenv().ItemESPData.selected = a or {}
    environment3(getgenv().ItemESPData.selected)
    clearItemESP()
    task.defer(refreshItemESP)
  end
  function setItemESPTextSize(textSize)
    local getgenv4
    textSize = math.clamp(math.floor(tonumber(textSize) or 14), 8, 28)
    getgenv4 = getgenv
    getgenv4 = getgenv4()
    getgenv4 = getgenv4.ItemESPData
    if getgenv4 then
      getgenv4.textSize = textSize
      for k, v in pairs(getgenv4.guis) do
        pcall(function()
          v.Size = UDim2.fromOffset(200, textSize + 12)
          local label = v:FindFirstChild("Label")
          if label then label.TextSize = textSize end
        end)
      end
    end
    pcall(function() sourceContext.callback34("IESPSize", textSize) end)
    return textSize
  end
  function setItemESP(enabled)
    local ItemESPData = getgenv()
    ItemESPData = ItemESPData.ItemESPData
    ItemESPData.enabled = enabled
    clearItemESP()
    if enabled then
      environment3(ItemESPData.selected)
      refreshItemESP()
      local entry5 = callback47()
      if entry5 then
        table.insert(ItemESPData.conns, entry5.ChildAdded:Connect(function(a)
          task.delay(0.05, function() if ItemESPData.enabled and a and a.Parent then callback54(a) end end)
        end))
        table.insert(ItemESPData.conns, entry5.ChildRemoved:Connect(function(a) callback53(a) end))
      end
      if not ItemESPData.loopRunning then
        ItemESPData.loopRunning = true
        task.spawn(function()
          while ItemESPData.enabled do
            task.wait(2)
            if ItemESPData.enabled then pcall(refreshItemESP) end
          end
          ItemESPData.loopRunning = false
        end)
      end
      return
    end
    ItemESPData.loopRunning = false
  end
  sourceContext.environment2.enableInstantPickup = enableInstantPickup
  sourceContext.environment2.disableInstantPickup = disableInstantPickup
  sourceContext.environment2.clearItemESP = clearItemESP
  sourceContext.environment2.refreshItemESP = refreshItemESP
  sourceContext.environment2.setItemESPFilter = setItemESPFilter
  sourceContext.environment2.setItemESP = setItemESP
  sourceContext.environment2.setItemESPTextSize = setItemESPTextSize
end
sourceContext.entries8 = {}
sourceContext.StabilityControlEnabled, sourceContext.referToWitheredText, sourceContext.pyreizText, sourceContext.michDrajoText, sourceContext.HUDHealthEnabled = "v_cks", "ReferToWithered", "Pyreiz", "MichDrajo", "ElmoNYC"
sourceContext.entries8[1] = "UzuKee"
sourceContext.entries8[2] = "BLOODTARO"
sourceContext.entries8[3] = "Dxscape"
sourceContext.entries8[4] = "Myst_Ari"
sourceContext.entries8[5] = "eurycIea"
sourceContext.entries8[6] = "v_cks"
sourceContext.entries8[7] = "ezguap"
sourceContext.entries8[8] = "Tsuzutou"
sourceContext.entries8[9] = "ReferToWithered"
sourceContext.entries8[10] = "Illus0"
sourceContext.entries8[11] = "Pyreiz"
sourceContext.entries8[12] = "VoidedFlame"
sourceContext.entries8[13] = "ROUXABOUT"
sourceContext.entries8[14] = "mixeriiiiiing"
sourceContext.entries8[15] = "MichDrajo"
sourceContext.entries8[16] = "hayst4"
sourceContext.entries8[17] = "ElmoNYC"
sourceContext.entries8[18] = "Core_CorruptionF"
sourceContext.entries8[19] = "Brillcake"
sourceContext.entries8[20] = "AxionTheRevenant"
sourceContext.entries8[21] = "sammyj0n"
sourceContext.entries8[22] = "ViveLesPatat"
sourceContext.entries8[23] = "Zimvasion"
sourceContext.entries8[24] = "vertiify"
sourceContext.entries8[25] = "redfoxP"
sourceContext.entries8[26] = "cakesucker05"
sourceContext.entries8[27] = "00kamiMio"
sourceContext.entries8[28] = "itscanii"
sourceContext.entries8[29] = "SirDeviloper"
sourceContext.entries8[30] = "0nkka"
sourceContext.entries8[31] = "Ramdharam"
sourceContext.entries8[32] = "Olliebutheskenny"
sourceContext.entries8[33] = "cswag_code"
sourceContext.entries8[34] = "TwoGio"
sourceContext.entries8[35] = "KoleRTX2"
sourceContext.entries8[36] = "Wilpuri"
sourceContext.entries8[37] = "remendyy"
sourceContext.entries8[38] = "SpaceNuggies"
sourceContext.entries8[39] = "CrimsonBeheIit"
sourceContext.entries8[40] = "warycoolio"
sourceContext.entries9 = {}
sourceContext.ipairsResult3, sourceContext.environment4, sourceContext.staffDetectorDataText = ipairs(sourceContext.entries8)
for k6, v6 in sourceContext.ipairsResult3, sourceContext.environment4, sourceContext.staffDetectorDataText do sourceContext.entries9[v6:lower()] = true end
function sourceContext.ipairsResult3(a)
  if a then
    local lowerResult = tostring(a.Name):lower()
    local lowerResult2 = tostring(a.DisplayName):lower()
    return sourceContext.entries9[lowerResult] == true or sourceContext.entries9[lowerResult2] == true
  end
  return false
end
sourceContext.environment4 = getgenv()
sourceContext.staffDetectorDataText = "StaffDetectorData"
sourceContext.StaffDetectorData = getgenv()
sourceContext.StaffDetectorData = sourceContext.StaffDetectorData.StaffDetectorData
if not sourceContext.StaffDetectorData then
  sourceContext.StaffDetectorData = {
    autoKick = sourceContext.callback35("StaffAutoKick", true),
    espEnabled = sourceContext.callback35("StaffESP", true), highlights = {}, labels = {}, conns = {},
  }
end
sourceContext.environment4.StaffDetectorData = sourceContext.StaffDetectorData
function sourceContext.environment4(a)
  if not (a and a ~= sourceContext.player) then return end
  if sourceContext.ipairsResult3(a) then
    if sourceContext.sendStaffDetectedWebhook then sourceContext.sendStaffDetectedWebhook(a) end
    if getgenv().StaffDetectorData.autoKick then
      local Name = a.Name
      task.delay(0.1, function() sourceContext.player:Kick("Found Mod: " .. Name .. " | Reason: Anti-Staff Auto Kick") end)
    end
  end
end
sourceContext.environment5 = getgenv()
sourceContext.StabilityControlEnabled = sourceContext.callback35
sourceContext.StabilityControlEnabled = sourceContext.callback35("StabilityControl", true)
sourceContext.environment5.StabilityControlEnabled = sourceContext.StabilityControlEnabled
sourceContext.environment5 = 30
sourceContext.table2 = table
sourceContext.StabilityControlEnabled = "create"
sourceContext.createResult = sourceContext.table2.create(sourceContext.environment5, 0.016)
sourceContext.count6 = 0
sourceContext.count7 = 0
sourceContext.Heartbeat = sourceContext.runServiceService.Heartbeat
sourceContext.Heartbeat.Connect(sourceContext.Heartbeat, function(a)
  sourceContext.count6 = sourceContext.count6 % sourceContext.environment5 + 1
  sourceContext.createResult[sourceContext.count6] = a
  if sourceContext.count7 < sourceContext.environment5 then sourceContext.count7 = sourceContext.count7 + 1 end
end)
function sourceContext.Heartbeat()
  if getgenv().StabilityControlEnabled then
    if sourceContext.count7 < 10 then return false end
    local count4, count8 = 0, 0
    for i = 1, sourceContext.count7 do
      local entry5 = sourceContext.createResult[i]
      count4 = count4 + entry5
      if entry5 > 0.1 then count8 = count8 + 1 end
    end
    if not (count4 / sourceContext.count7 > 0.08) and not (count8 > 2) then return true end
    return false
  end
  return true
end
function sourceContext.callback55()
  local pcallResult, entry5 = pcall(function()
    local statsService = game:GetService("Stats")
    local network = statsService and statsService:FindFirstChild("Network")
    local serverStatsItem = network and network:FindFirstChild("ServerStatsItem")
    local dataPing = serverStatsItem and serverStatsItem:FindFirstChild("Data Ping")
    if not dataPing then return end
    return dataPing:GetValue()
  end)
  if pcallResult and type(entry5) == "number" and entry5 > 0 then return entry5 end
  return 100
end
function sourceContext.pyreizText(entry5)
  local number = tonumber(entry5)
  entry5 = if number then number else 0.45
  number = sourceContext.callback55
  number = sourceContext.callback55()
  return entry5 + number / 1000 * (number < 60 and 0.6 or 0.3)
end
function sourceContext.callback56()
  local StaffDetectorData = getgenv().StaffDetectorData
  for k, v in pairs(StaffDetectorData.highlights) do if v then pcall(v.Destroy, v) end end
  for k2, v2 in pairs(StaffDetectorData.labels) do if v2 then pcall(v2.Destroy, v2) end end
  StaffDetectorData.highlights = {}
  StaffDetectorData.labels = {}
end
function refreshStaffESP()
  local StaffDetectorData = getgenv()
  StaffDetectorData = StaffDetectorData.StaffDetectorData
  if StaffDetectorData.espEnabled and (not getgenv().PlayerESPData or not getgenv().PlayerESPData.enabled) then
    local entries8 = {}
    for k, v in ipairs(sourceContext.playersService:GetPlayers()) do
      if v ~= sourceContext.player and sourceContext.ipairsResult3(v) then
        entries8[v] = true
        local Adornee = v.Character
        local humanoidRootPart = Adornee and Adornee:FindFirstChild("HumanoidRootPart")
        local humanoid = Adornee and Adornee:FindFirstChildOfClass("Humanoid")
        local head = Adornee and Adornee:FindFirstChild("Head")
        if humanoidRootPart and humanoid and humanoid.Health > 0 then
          local highlight = StaffDetectorData.highlights[v]
          if highlight and highlight.Parent then
            highlight.Adornee = Adornee
          else
            highlight = Instance.new("Highlight")
            highlight.Name = "RAILhubStaffESP"
            local parentEspGui2
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 40, 40)
            highlight.FillTransparency = 0.35
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Adornee = Adornee
            parentEspGui2 = parentEspGui
            parentEspGui2 = parentEspGui2(highlight)
            if parentEspGui2 then StaffDetectorData.highlights[v] = highlight else pcall(highlight.Destroy, highlight) end
          end
          highlight.Enabled = true
          local Parent = StaffDetectorData.labels[v]
          if Parent and Parent.Parent then
            Parent.Adornee = head or humanoidRootPart
          else
            Parent = Instance.new("BillboardGui")
            Parent.Name = "RAILhubStaffLabel"
            Parent.Size = UDim2.fromOffset(200, 50)
            Parent.StudsOffset = Vector3.new(0, 3.5, 0)
            Parent.AlwaysOnTop = true
            Parent.Adornee = head or humanoidRootPart
            local new = Instance.new("TextLabel")
            new.Name = "Label"
            new.BackgroundTransparency = 1
            new.Size = UDim2.fromScale(1, 1)
            new.Font = Enum.Font.GothamBold
            new.TextColor3 = Color3.fromRGB(255, 40, 40)
            new.TextStrokeTransparency = 0
            new.TextSize = 15
            new.Text = [[🚨 ADMIN 🚨
]] .. v.Name
            new.Parent = Parent
            if parentEspGui(Parent) then StaffDetectorData.labels[v] = Parent else pcall(Parent.Destroy, Parent) end
          end
          Parent.Enabled = true
        else
          if StaffDetectorData.highlights[v] then
            pcall(StaffDetectorData.highlights[v].Destroy, StaffDetectorData.highlights[v])
            StaffDetectorData.highlights[v] = nil
          end
          if StaffDetectorData.labels[v] then
            pcall(StaffDetectorData.labels[v].Destroy, StaffDetectorData.labels[v])
            StaffDetectorData.labels[v] = nil
          end
        end
      end
    end
    for k2, v2 in pairs(StaffDetectorData.highlights) do
      if not entries8[k2] then
        if v2 then pcall(v2.Destroy, v2) end
        StaffDetectorData.highlights[k2] = nil
      end
    end
    for k3, v3 in pairs(StaffDetectorData.labels) do
      if not entries8[k3] then
        if v3 then pcall(v3.Destroy, v3) end
        StaffDetectorData.labels[k3] = nil
      end
    end
    return
  end
  sourceContext.callback56()
end
sourceContext.ipairsResult4, sourceContext.entry20, sourceContext.connectText = ipairs(sourceContext.playersService.GetPlayers(sourceContext.playersService))
for k7, v7 in sourceContext.ipairsResult4, sourceContext.entry20, sourceContext.connectText do sourceContext.environment4(v7) end
sourceContext.ipairsResult4 = sourceContext.playersService.PlayerAdded
sourceContext.connectText = "Connect"
sourceContext.entry20 = sourceContext.ipairsResult4
sourceContext.entry20.Connect(sourceContext.entry20, function(a)
  sourceContext.environment4(a)
  a.CharacterAdded:Connect(function()
    task.delay(0.5, function()
      sourceContext.environment4(a)
      if getgenv().StaffDetectorData.espEnabled then refreshStaffESP() end
    end)
  end)
end)
sourceContext.ipairsResult4 = getgenv
sourceContext.ipairsResult4 = sourceContext.ipairsResult4()
sourceContext.PlayerESPData = getgenv()
sourceContext.PlayerESPData = sourceContext.PlayerESPData.PlayerESPData
if not sourceContext.PlayerESPData then
  sourceContext.PlayerESPData = {
    enabled = false, showChams = sourceContext.callback35("PESP_CH", true),
    showNames = sourceContext.callback35("PESP_NM", true), showDistance = sourceContext.callback35("PESP_DS", true),
    showStand = sourceContext.callback35("PESP_ST", true), showSpec = sourceContext.callback35("PESP_SP", true),
    showHealth = sourceContext.callback35("PESP_HP", true), highlights = {}, labels = {}, conns = {},
  }
end
sourceContext.ipairsResult4.PlayerESPData = sourceContext.PlayerESPData
function sourceContext.ipairsResult4()
  local PlayerESPData = getgenv().PlayerESPData
  for k, v in pairs(PlayerESPData.highlights) do if v then pcall(v.Destroy, v) end end
  for k2, v2 in pairs(PlayerESPData.labels) do if v2 then pcall(v2.Destroy, v2) end end
  for k3, v3 in pairs(PlayerESPData.conns) do if v3 then pcall(v3.Disconnect, v3) end end
  PlayerESPData.highlights = {}
  PlayerESPData.labels = {}
  PlayerESPData.conns = {}
end
function sourceContext.callback57(a, b)
  local PlayerESPData = getgenv()
  PlayerESPData = PlayerESPData.PlayerESPData
  if not (PlayerESPData.enabled and a ~= sourceContext.player) then return end
  local Adornee = a.Character
  local humanoidRootPart = Adornee and Adornee:FindFirstChild("HumanoidRootPart")
  local humanoid = Adornee and Adornee:FindFirstChildOfClass("Humanoid")
  local head = Adornee and Adornee:FindFirstChild("Head")
  local count4 = humanoidRootPart and humanoid and humanoid.Health > 0
  if count4 then
    local entry5 = sourceContext.ipairsResult3(a)
    local highlight = PlayerESPData.highlights[a]
    if highlight and highlight.Parent then
      highlight.FillColor = entry5 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 90, 90)
      highlight.OutlineColor = entry5 and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(255, 255, 255)
      highlight.FillTransparency = entry5 and 0.35 or 0.65
      highlight.OutlineTransparency = entry5 and 0 or 0.1
      highlight.Adornee = Adornee
    else
      highlight = Instance.new("Highlight")
      highlight.Name = "RAILhubPlayerESP"
      highlight.FillColor = entry5 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 90, 90)
      highlight.OutlineColor = entry5 and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(255, 255, 255)
      highlight.FillTransparency = entry5 and 0.35 or 0.65
      highlight.OutlineTransparency = entry5 and 0 or 0.1
      highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      highlight.Adornee = Adornee
      if parentEspGui(highlight) then PlayerESPData.highlights[a] = highlight else pcall(highlight.Destroy, highlight) end
    end
    highlight.Enabled = PlayerESPData.showChams == true or entry5
    local Parent = PlayerESPData.labels[a]
    if Parent and Parent.Parent then
      Parent.Adornee = head or humanoidRootPart
      local label = Parent:FindFirstChild("Label")
      if label then
        label.TextColor3 = entry5 and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(255, 255, 255)
        label.TextSize = entry5 and 15 or 13
      end
    else
      Parent = Instance.new("BillboardGui")
      Parent.Name = "RAILhubPlayerLabel"
      Parent.Size = UDim2.fromOffset(200, 60)
      Parent.StudsOffset = Vector3.new(0, 3, 0)
      Parent.AlwaysOnTop = true
      Parent.Adornee = head or humanoidRootPart
      local new = Instance.new("TextLabel")
      new.Name = "Label"
      new.BackgroundTransparency = 1
      new.Size = UDim2.fromScale(1, 1)
      new.Font = Enum.Font.GothamBold
      new.TextColor3 = entry5 and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(255, 255, 255)
      new.TextStrokeTransparency = 0
      new.TextScaled = false
      new.TextSize = entry5 and 15 or 13
      new.Parent = Parent
      if parentEspGui(Parent) then PlayerESPData.labels[a] = Parent else pcall(Parent.Destroy, Parent) end
    end
    local entries8 = {}
    if entry5 then table.insert(entries8, "🚨 ADMIN 🚨") end
    if PlayerESPData.showNames then table.insert(entries8, a.Name) end
    if PlayerESPData.showHealth then table.insert(entries8, string.format("HP: [%d/%d]", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))) end
    local playerStats = a:FindFirstChild("PlayerStats")
    if playerStats then
      local stand = playerStats:FindFirstChild("Stand")
      local spec = playerStats:FindFirstChild("Spec")
      local entry8
      entry8 = if PlayerESPData.showStand and stand and stand.Value and stand.Value ~= "None" and stand.Value ~= "" then stand.Value or nil else nil
      local entry9
      entry9 = if PlayerESPData.showSpec and spec and spec.Value and spec.Value ~= "None" and spec.Value ~= "" then spec.Value or nil else nil
      if entry8 and entry9 then
        table.insert(entries8, string.format("[%s | %s]", entry8, entry9))
      elseif entry8 then
        table.insert(entries8, string.format("[%s]", entry8))
      elseif entry9 then table.insert(entries8, string.format("[%s]", entry9)) end
    end
    if PlayerESPData.showDistance and b then table.insert(entries8, string.format("[%dm]", math.floor((humanoidRootPart.Position - b.Position).Magnitude))) end
    local label2 = Parent:FindFirstChild("Label")
    if label2 then label2.Text = table.concat(entries8, "\n") end
    Parent.Enabled = #entries8 > 0
    return
  end
  if PlayerESPData.highlights[a] then
    pcall(PlayerESPData.highlights[a].Destroy, PlayerESPData.highlights[a])
    PlayerESPData.highlights[a] = nil
  end
  if PlayerESPData.labels[a] then
    pcall(PlayerESPData.labels[a].Destroy, PlayerESPData.labels[a])
    PlayerESPData.labels[a] = nil
  end
end
function refreshPlayerESP()
  local PlayerESPData = getgenv()
  PlayerESPData = PlayerESPData.PlayerESPData
  if PlayerESPData.enabled then
    local Character = sourceContext.player.Character
    local humanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local entries8 = {}
    for k, v in ipairs(sourceContext.playersService:GetPlayers()) do
      if v ~= sourceContext.player then
        entries8[v] = true
        sourceContext.callback57(v, humanoidRootPart)
      end
    end
    for k2, v2 in pairs(PlayerESPData.highlights) do
      if not entries8[k2] then
        if v2 then pcall(v2.Destroy, v2) end
        PlayerESPData.highlights[k2] = nil
      end
    end
    for k3, v3 in pairs(PlayerESPData.labels) do
      if not entries8[k3] then
        if v3 then pcall(v3.Destroy, v3) end
        PlayerESPData.labels[k3] = nil
      end
    end
    return
  end
  sourceContext.ipairsResult4()
end
function setPlayerESP(enabled)
  local PlayerESPData = getgenv()
  PlayerESPData = PlayerESPData.PlayerESPData
  PlayerESPData.enabled = enabled
  sourceContext.ipairsResult4()
  if enabled then
    refreshPlayerESP()
    table.insert(PlayerESPData.conns, sourceContext.playersService.PlayerAdded:Connect(function() task.defer(refreshPlayerESP) end))
    table.insert(PlayerESPData.conns, sourceContext.playersService.PlayerRemoving:Connect(function(a)
      if PlayerESPData.highlights[a] then
        pcall(PlayerESPData.highlights[a].Destroy, PlayerESPData.highlights[a])
        PlayerESPData.highlights[a] = nil
      end
      local labels = PlayerESPData.labels
      if labels[a] then
        pcall(PlayerESPData.labels[a].Destroy, PlayerESPData.labels[a])
        PlayerESPData.labels[a] = nil
      end
    end))
    task.spawn(function()
      while PlayerESPData.enabled do
        refreshPlayerESP()
        task.wait(0.25)
      end
    end)
    return
  end
  if getgenv().StaffDetectorData.espEnabled then refreshStaffESP() end
end
sourceContext.task3 = nil
getgenv().HUDHealthEnabled = sourceContext.callback35("HUD_HP", true)
sourceContext.task3 = task
sourceContext.task3 = sourceContext.task3.spawn
function sourceContext.callback58()
  local enabled17 = false
  while true do
    if getgenv().HUDHealthEnabled then
      enabled17 = true
      pcall(function()
        local PlayerGui = sourceContext.player.PlayerGui
        PlayerGui = PlayerGui:FindFirstChild("HUD")
        PlayerGui = PlayerGui and sourceContext.player.PlayerGui.HUD:FindFirstChild("Main") and sourceContext.player.PlayerGui.HUD.Main:FindFirstChild("Indicators") and sourceContext.player.PlayerGui.HUD.Main.Indicators:FindFirstChild("Bars")
        if PlayerGui then
          local entry5 = PlayerGui:GetChildren()[6]
          if entry5 and entry5:IsA("TextLabel") then
            local Character = sourceContext.player.Character
            local humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if humanoid then entry5.Text = string.format("[%d/%d]", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth)) end
          end
        end
      end)
      task.wait(0.1)
    else
      if enabled17 then
        enabled17 = false
        pcall(function()
          local entry5 = sourceContext.player.PlayerGui.HUD.Main.Indicators.Bars:GetChildren()[6]
          if entry5 and entry5:IsA("TextLabel") and entry5.Text:match("%[%d+/%d+%]") then entry5.Text = "H E A L T H" end
        end)
      end
      task.wait(0.5)
    end
  end
end
sourceContext.task3(sourceContext.callback58)
getgenv()._YBA_setPlayerESP = setPlayerESP
getgenv()._YBA_refreshPlayerESP = refreshPlayerESP
sourceContext.task3 = sourceContext.callback35
if sourceContext.callback35("PESP", false) then task.defer(function() setPlayerESP(true) end) end
function sourceContext.getSkinChancesLabel()
  local hUD = sourceContext.playerGui:FindFirstChild("HUD")
  local main = hUD and hUD:FindFirstChild("Main")
  local frames = main and main:FindFirstChild("Frames")
  local store = frames and frames:FindFirstChild("Store")
  local entry5 = store and store:FindFirstChild("List")
  local standShop = entry5 and entry5:FindFirstChild("StandShop")
  return standShop and standShop:FindFirstChild("SkinChances1")
end
sourceContext.environment2.refreshStaffESP = refreshStaffESP
sourceContext.environment2.refreshPlayerESP = refreshPlayerESP
sourceContext.environment2.setPlayerESP = setPlayerESP
do
  local settings6 = { main = false, farm = false, stand = false, rib = false, shiny = false, prestige = false, quest = false }
  local connectResult4, enabled17 = nil, false
  local entries10 = {}
  local a3, connectResult5 = nil, nil
  local function callback59(a)
    if table.clear then table.clear(entries10) else for entry5 in pairs(entries10) do entries10[entry5] = nil end end
    a3 = a
    if not (a and a.Parent) then return end
    for k, v in ipairs(a:GetDescendants()) do if v:IsA("BasePart") then entries10[#entries10 + 1] = v end end
  end
  local function callback60(a)
    if a3 == a and #entries10 > 0 then return end
    if connectResult5 then
      pcall(function() connectResult5:Disconnect() end)
      connectResult5 = nil
    end
    callback59(a)
    if a then
      pcall(function()
        connectResult5 = a.DescendantAdded:Connect(function(b)
          if b:IsA("BasePart") then
            entries10[#entries10 + 1] = b
            pcall(function() b.CanCollide = false end)
          end
        end)
      end)
    end
  end
  function isAnyNoclipActive()
    for k, v in pairs(settings6) do if v == true then return true end end
    return false
  end
  function restoreCharacterCollisions(a)
    a = a or sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
    if not (a and a.Parent) then return end
    local settings7 = { Torso = true, UpperTorso = true, LowerTorso = true, Head = true }
    for k, v in ipairs(a:GetDescendants()) do
      if v:IsA("BasePart") then if settings7[v.Name] then pcall(function() v.CanCollide = true end) else pcall(function() v.CanCollide = false end) end end
    end
    local rootPart = a:FindFirstChild("HumanoidRootPart")
    if rootPart then
      pcall(function()
        rootPart.CanCollide = false
        if rootPart.AssemblyLinearVelocity.Y < -20 then
          rootPart.AssemblyLinearVelocity = Vector3.new(rootPart.AssemblyLinearVelocity.X, 0, rootPart.AssemblyLinearVelocity.Z)
        end
      end)
    end
    local humanoid = a:FindFirstChildOfClass("Humanoid")
    if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end) end
  end
  local function callback61(a)
    if not (a and a.Parent) then return end
    callback60(a)
    for i = 1, #entries10 do
      local entry5 = entries10[i]
      if entry5 and entry5.Parent and entry5.CanCollide then pcall(function() entry5.CanCollide = false end) end
    end
  end
  local function callback62()
    if connectResult4 then return end
    connectResult4 = sourceContext.runServiceService.Stepped:Connect(function()
      if isAnyNoclipActive() then
        local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
        if character2 and character2.Parent then
          if a3 ~= character2 then callback60(character2) end
          for i = 1, #entries10 do
            local entry8 = entries10[i]
            if entry8 and entry8.Parent and entry8.CanCollide then pcall(function() entry8.CanCollide = false end) end
          end
        end
        return
      end
      if connectResult4 then
        connectResult4:Disconnect()
        connectResult4 = nil
      end
    end)
  end
  local function callback63()
    if connectResult4 then
      connectResult4:Disconnect()
      connectResult4 = nil
    end
    local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
    restoreCharacterCollisions(character2)
  end
  function enableNoclip(a)
    local entry9
    a = type(a) == "string" and a or "main"
    entry9 = settings6
    settings6[a] = true
    entry9 = true
    entry9 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
    if entry9 then callback61(entry9) end
    callback62()
  end
  function disableNoclip(a)
    if a ~= true and a ~= "force" then
      settings6[type(a) == "string" and a or "main"] = false
      if not normalFarmOn then settings6.farm = false end
      if not isAnyNoclipActive() then callback63() end
      return
    end
    for entry9 in pairs(settings6) do settings6[entry9] = false end
    callback63()
  end
  function enableNoclipState(a) enableNoclip(tostring(a or "stand")) end
  function disableNoclipState(a) disableNoclip(tostring(a or "stand")) end
  sourceContext.environment2.isAnyNoclipActive = isAnyNoclipActive
  sourceContext.environment2.restoreCharacterCollisions = restoreCharacterCollisions
  sourceContext.environment2.enableNoclip = enableNoclip
  sourceContext.environment2.disableNoclip = disableNoclip
  sourceContext.environment2.enableNoclipState = enableNoclipState
  sourceContext.environment2.disableNoclipState = disableNoclipState
end
do
  local function callback64(...)
    return sourceContext.environment2.normalizeItemName and sourceContext.environment2.normalizeItemName(...)
  end
  do
    local function callback65(...)
      return sourceContext.environment2.sfCountItem and sourceContext.environment2.sfCountItem(...)
    end
    local _ = sourceContext.environment2.maxLimits
  end
  local getgenv9 = getgenv()
  getgenv9.ItemStickConnections = getgenv().ItemStickConnections or {}
  function getgenv9()
    for k, v in pairs(getgenv().ItemStickConnections) do
      if type(v) == "table" then
        if v.conn then pcall(function() v.conn:Disconnect() end) end
        if v.alignPos then pcall(function() v.alignPos:Destroy() end) end
        if v.attA then pcall(function() v.attA:Destroy() end) end
        if v.attB then pcall(function() v.attB:Destroy() end) end
      elseif typeof(v) == "RBXScriptConnection" then pcall(function() v:Disconnect() end) end
    end
    getgenv().ItemStickConnections = {}
  end
  cleanupItemStick = getgenv9
  getgenv9 = getgenv
  getgenv9 = getgenv9()
  getgenv9._YBA_bypassSuccess = false
  function getgenv9()
    local savedFarmTravelMethod = sourceContext.callback35 and sourceContext.callback35("FarmTravelMethod")
    if savedFarmTravelMethod then return savedFarmTravelMethod end
    local savedUseTeleportFarm = sourceContext.callback35 and sourceContext.callback35("UseTeleportFarm")
    if savedUseTeleportFarm == nil then return "Teleport" end
    return savedUseTeleportFarm and "Teleport" or "Tween"
  end
  getgenv9 = getgenv9()
  local environment6 = getgenv()
  environment6._YBA_directTP = getgenv9 == "Teleport"
  local entry21, count8 = nil, 425
  local function getTargetPart(a)
    if typeof(a) == "Instance" then
      local IsA = a.IsA
      local Parent
      Parent = if IsA(a, "ProximityPrompt") then a.Parent else a
      a = Parent
      local Parent2
      Parent2 = if Parent then if Parent:IsA("Attachment") then Parent.Parent else Parent else Parent
      a = Parent2
      if Parent2 then
        if Parent2:IsA("BasePart") then return Parent2 end
        return Parent2:FindFirstChildOfClass("MeshPart") or Parent2:FindFirstChildOfClass("Part") or Parent2.PrimaryPart
      end
      return nil
    end
    return nil
  end
  local function callback66(a, b)
    b = b or Vector3.zero
    if typeof(a) == "Vector3" then return CFrame.new(a + b) end
    if typeof(a) == "CFrame" then return a + b end
    local rootPart2 = getTargetPart(a)
    return rootPart2 and rootPart2.CFrame + b or nil
  end
  local entries11 = {}
  local count9 = 0
  local function callback67(a)
    local entry9 = entries11[a]
    if entry9 and entry9.prompt and entry9.prompt.Parent and entry9.prompt:IsDescendantOf(workspace) and entry9.part and entry9.part.Parent and entry9.part:IsDescendantOf(workspace) then
      return entry9
    end
    return nil
  end
  do
    local function callback68(a, part, prompt, name)
      if entries11[a] == nil then count9 = count9 + 1 end
      if count9 > 500 then
        for k, v in pairs(entries11) do
          if type(k) == "userdata" or typeof(k) == "Instance" then
            if not k.Parent or not k:IsDescendantOf(workspace) then
              entries11[k] = nil
              count9 = count9 - 1
            end
          else
            entries11[k] = nil
            count9 = count9 - 1
          end
        end
      end
      entries11[a] = { part = part, prompt = prompt, name = name }
    end
    function getItemComponents(a)
      if a and a.Parent and a:IsDescendantOf(workspace) then
        local entry9 = callback67(a)
        if entry9 and entry9.prompt.Enabled ~= false and entry9.part.Transparency < 1 then return entry9.part, entry9.prompt, entry9.name end
        local proximityPrompt3 = a:FindFirstChildWhichIsA("ProximityPrompt", true) or a.Parent and a.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
        if proximityPrompt3 and proximityPrompt3.Enabled ~= false then
          local a4, a5 = nil, a
          local isA = a.IsA
          if isA(a, "BasePart") then
            a4 = a
          else
            if a:IsA("Model") then
              for k, v in ipairs(a:GetDescendants()) do
                if v:IsA("BasePart") and v:IsDescendantOf(workspace) and v.Transparency < 1 then
                  a4 = v
                  break
                end
              end
              if not a4 then
                if proximityPrompt3.Parent and proximityPrompt3.Parent:IsA("BasePart") and proximityPrompt3.Parent:IsDescendantOf(workspace) then
                  a4 = proximityPrompt3.Parent
                elseif a.PrimaryPart and a.PrimaryPart:IsDescendantOf(workspace) then
                  a4 = a.PrimaryPart
                else
                  for k2, v2 in ipairs(a:GetDescendants()) do
                    if v2:IsA("BasePart") and v2:IsDescendantOf(workspace) then
                      a4 = v2
                      break
                    end
                  end
                end
              end
            end
          end
          if not a4 and proximityPrompt3.Parent and proximityPrompt3.Parent:IsA("BasePart") and proximityPrompt3.Parent:IsDescendantOf(workspace) then
            a4 = proximityPrompt3.Parent
          end
          if a4 and a4.Parent and a4:IsDescendantOf(workspace) then
            isA = if proximityPrompt3.ObjectText and proximityPrompt3.ObjectText ~= "" then proximityPrompt3.ObjectText or a.Name else a.Name
            local entry10 = sourceContext.environment2 and sourceContext.environment2.normalizeItemName or callback64
            local entry11 = entry10 and entry10(isA) or isA
            callback68(a, a4, proximityPrompt3, entry11)
            return a4, proximityPrompt3, entry11
          end
          return nil, nil, nil
        end
        return nil, nil, nil
      end
      if entries11[a] ~= nil then
        entries11[a] = nil
        count9 = math.max(0, count9 - 1)
      end
      return nil, nil, nil
    end
    local function callback69(a)
      local humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
      local newResult = humanoidRootPart and humanoidRootPart.Position or a.Position + Vector3.new(0, 0, -1)
      local new = Vector3.new(a.Position.X - newResult.X, 0, a.Position.Z - newResult.Z)
      return -(new.Magnitude > 0.01 and new.Unit or Vector3.new(0, 0, -1)) * 2.75 + Vector3.new(0, 2.5, 0)
    end
  end
  local connectResult6, entry22 = nil, nil
  local function callback70()
    if connectResult6 then
      pcall(function() connectResult6:Disconnect() end)
      connectResult6 = nil
    end
    if entry22 then
      pcall(function() entry22:Disconnect() end)
      entry22 = nil
    end
  end
  function stopMoveTween()
    callback70()
    if entry21 then
      pcall(function() entry21:Cancel() end)
      pcall(function() entry21:Destroy() end)
      entry21 = nil
    end
    _tweenBusy = false
    local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
    if character2 then
      local rootPart2 = character2:FindFirstChild("HumanoidRootPart")
      if rootPart2 then
        pcall(function()
          rootPart2.AssemblyLinearVelocity = Vector3.zero
          rootPart2.AssemblyAngularVelocity = Vector3.zero
        end)
      end
    end
  end
  function zeroRootVelocity(a)
    if not a then return end
    pcall(function()
      a.AssemblyLinearVelocity = Vector3.zero
      a.AssemblyAngularVelocity = Vector3.zero
    end)
  end
  function wakeUpPhysicsAndSync()
    local character2 = sourceContext.player and sourceContext.player.Character
    local rootPart3 = character2 and character2:FindFirstChild("HumanoidRootPart")
    local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")
    if rootPart3 and humanoid2 and humanoid2.Health > 0 then
      pcall(function()
        humanoid2:ChangeState(Enum.HumanoidStateType.Running)
        rootPart3.AssemblyLinearVelocity = Vector3.new(0, 0.05, 0)
      end)
      for i = 1, 5 do sourceContext.runServiceService.Heartbeat:Wait() end
      pcall(function()
        rootPart3.AssemblyLinearVelocity = Vector3.zero
        rootPart3.AssemblyAngularVelocity = Vector3.zero
      end)
    end
  end
  task.spawn(function()
    while true do
      task.wait(2)
      pcall(function()
        if not (sourceContext.callback20 and sourceContext.callback20()) then return end
        if not sourceContext.callback28() and not _tweenBusy and not sourceContext.enabled9 and (not getgenv or not getgenv()._YBA_SellingBusy) then
          local character2 = sourceContext.player and sourceContext.player.Character
          local rootPart4 = character2 and character2:FindFirstChild("HumanoidRootPart")
          local humanoid3 = character2 and character2:FindFirstChildOfClass("Humanoid")
          if rootPart4 and humanoid3 and humanoid3.Health > 0 and humanoid3:GetState() ~= Enum.HumanoidStateType.Seated and not humanoid3.Sit and rootPart4.AssemblyLinearVelocity.Magnitude < 0.05 then
            rootPart4.AssemblyLinearVelocity = Vector3.new(0, 0.02, 0)
          end
        end
      end)
    end
  end)
  function isItemAvailable(a)
    if a then
      if typeof(a) == "Instance" then
        if a.Parent and a:IsDescendantOf(workspace) then
          local entry9 = callback67(a)
          if entry9 then
            if entry9.prompt.Enabled == false then return false end
            if a:IsA("BasePart") then return a.Transparency < 1 end
            if entry9.part.Transparency < 1 then return true end
          else
            local proximityPrompt3 = a:FindFirstChildWhichIsA("ProximityPrompt", true) or a.Parent and a.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
            if proximityPrompt3 and (not proximityPrompt3.Parent or not proximityPrompt3:IsDescendantOf(workspace) or proximityPrompt3.Enabled == false) then
              return false
            end
            if a:IsA("BasePart") then return a.Transparency < 1 end
          end
          if a:IsA("Model") then
            local enabled17, enabled18 = false, false
            for k, v in ipairs(a:GetDescendants()) do
              if v:IsA("BasePart") and v:IsDescendantOf(workspace) then
                enabled18 = true
                if v.Transparency < 1 then
                  enabled17 = true
                  break
                end
              end
            end
            if enabled18 and not enabled17 then return false end
          end
          return true
        end
        if entries11[a] ~= nil then
          entries11[a] = nil
          count9 = math.max(0, count9 - 1)
        end
        return false
      end
      return true
    end
    return false
  end
  do
    local function callback71()
      local _tpCooldownUntil = getgenv()._tpCooldownUntil
      if _tpCooldownUntil and tick() < _tpCooldownUntil then task.wait(_tpCooldownUntil - tick()) end
    end
    local function callback72() getgenv()._tpCooldownUntil = tick() + 0.45 end
  end
  local function callback73(a, entry9, c, d)
    if a and a.Parent then
      stopMoveTween()
      local Magnitude = a.Position - entry9.Position
      Magnitude = Magnitude.Magnitude
      if Magnitude < 1 then
        zeroRootVelocity(a)
        return true
      end
      enableNoclip(normalFarmOn and "farm" or SF and SF.standFarmRunning and "stand" or "main")
      local Parent = a.Parent
      zeroRootVelocity(a)
      local clamp = math.clamp(Magnitude / math.max(c or 425 or 425, 50), 0.05, 3)
      local createResult2 = sourceContext.tweenServiceService:Create(a, TweenInfo.new(clamp, Enum.EasingStyle.Linear), { CFrame = entry9 })
      entry21 = createResult2
      local enabled17 = false
      local entries8 = {}
      pcall(function()
        for k, v in ipairs(Parent:GetDescendants()) do if v:IsA("BasePart") then entries8[#entries8 + 1] = v end end
      end)
      local connectResult7 = nil
      pcall(function()
        connectResult7 = Parent.DescendantAdded:Connect(function(b) if b:IsA("BasePart") then entries8[#entries8 + 1] = b end end)
      end)
      entry22 = connectResult7
      connectResult6 = sourceContext.runServiceService.Stepped:Connect(function()
        if Parent and Parent.Parent and a and a.Parent then
          for i = 1, #entries8 do
            local entry9 = entries8[i]
            if entry9 and entry9.Parent and entry9.CanCollide then pcall(function() entry9.CanCollide = false end) end
          end
          pcall(function()
            a.AssemblyLinearVelocity = Vector3.zero
            a.AssemblyAngularVelocity = Vector3.zero
          end)
          if d and d() then enabled17 = true end
          return
        end
        enabled17 = true
      end)
      createResult2:Play()
      while createResult2.PlaybackState == Enum.PlaybackState.Playing and not enabled17 do
        task.wait()
        if d and d() then
          enabled17 = true
          break
        end
      end
      callback70()
      if enabled17 then
        pcall(function() createResult2:Cancel() end)
        pcall(function() createResult2:Destroy() end)
        if entry21 == createResult2 then entry21 = nil end
        zeroRootVelocity(a)
        return false
      end
      pcall(function() createResult2:Destroy() end)
      if entry21 == createResult2 then entry21 = nil end
      zeroRootVelocity(a)
      return true
    end
    return false
  end
  local environment7 = getgenv()
  environment7._YBA_maxTPDist = 12
  function environment7(a, b, c)
    if sourceContext.callback28() then return false end
    local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
    if character2 and character2.Parent and character2.Parent == workspace.Living then
      local humanoid3 = character2:FindFirstChildOfClass("Humanoid")
      if humanoid3 and not (humanoid3.Health <= 0) then
        local rootPart4 = character2:FindFirstChild("HumanoidRootPart")
        local cFrame = callback66(a, b)
        if rootPart4 and cFrame then
          if (rootPart4.Position - cFrame.Position).Magnitude < 1 then
            stopMoveTween()
            zeroRootVelocity(rootPart4)
            return true
          end
          local _YBA_directTP = getgenv()
          _YBA_directTP = _YBA_directTP._YBA_directTP
          if _YBA_directTP then
            rootPart4.CFrame = cFrame
            zeroRootVelocity(rootPart4)
            return true
          end
          local entry10 = callback73(rootPart4, cFrame, 425, function()
            if sourceContext.callback28() then return true end
            if c and c() then return true end
            return false
          end)
          if rootPart4 and rootPart4.Parent then zeroRootVelocity(rootPart4) end
          return entry10
        end
        return false
      end
      return false
    end
    return false
  end
  moveCharacterTo = environment7
  function environment7(a, b, c)
    if typeof(a) == "Instance" and a:IsA("ProximityPrompt") then
      local entry10 = getTargetPart(a)
      if entry10 and not c then
        local humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
        local count4 = a.MaxActivationDistance > 0 and a.MaxActivationDistance or 10
        count4 = count4 - 0.5
        if not humanoidRootPart or count4 < (entry10.Position - humanoidRootPart.Position).Magnitude then moveCharacterTo(entry10, Vector3.new(0, 0.1, 0)) end
      end
      local enabled18 = false
      if type(fireproximityprompt) == "function" then
        pcall(function()
          fireproximityprompt(a)
          enabled18 = true
        end)
      end
      if not enabled18 then
        pcall(function() if type(firesignal) == "function" then firesignal(a.Triggered, sourceContext.player) end end)
        pcall(function() if type(firesignal) == "function" then firesignal(a.PromptTriggered, sourceContext.player) end end)
      end
      pcall(function() a:InputHoldBegin() end)
      local HoldDuration = b
      if b == nil or b <= 0 or b > 1 then HoldDuration = a.HoldDuration end
      HoldDuration = HoldDuration <= 0 and 0.5 or HoldDuration
      local E = sourceContext.userInputServiceService.KeyboardEnabled and a.KeyboardKeyCode or a.GamepadKeyCode
      if E == Enum.KeyCode.Unknown then E = Enum.KeyCode.E end
      pcall(function()
        if sourceContext.virtualInputManagerService and sourceContext.virtualInputManagerService.SendKeyEvent then
          sourceContext.virtualInputManagerService:SendKeyEvent(true, E, false, game)
        end
      end)
      task.wait(HoldDuration > 0 and HoldDuration or 0.05)
      pcall(function()
        if sourceContext.virtualInputManagerService and sourceContext.virtualInputManagerService.SendKeyEvent then
          sourceContext.virtualInputManagerService:SendKeyEvent(false, E, false, game)
        end
      end)
      pcall(function() a:InputHoldEnd() end)
      pcall(function() if type(firesignal) == "function" then firesignal(a.TriggerEnded, sourceContext.player) end end)
      return true
    end
    return false
  end
  activatePrompt = environment7
  environment7 = "moveCharacterTo"
  sourceContext.environment2.moveCharacterTo = moveCharacterTo
  sourceContext.environment2.stopMoveTween = stopMoveTween
  sourceContext.environment2.zeroRootVelocity = zeroRootVelocity
  sourceContext.environment2.wakeUpPhysicsAndSync = wakeUpPhysicsAndSync
  sourceContext.environment2.activatePrompt = activatePrompt
  sourceContext.environment2.isItemAvailable = isItemAvailable
  sourceContext.environment2.cleanupItemStick = cleanupItemStick
  sourceContext.environment2.getItemComponents = getItemComponents
end
function sourceContext.callNormalizeItemName(...) return sourceContext.environment2.normalizeItemName(...) end
function sourceContext.callSfCountItem(...) return sourceContext.environment2.sfCountItem(...) end
function sourceContext.callGetItemComponents(...) return sourceContext.environment2.getItemComponents(...) end
function sourceContext.checkAndSellMax2(...) return sourceContext.environment2.checkAndSellMax(...) end
function sourceContext.callCheckAndBuyLuckyArrow(...)
  return sourceContext.environment2.checkAndBuyLuckyArrow(...)
end
function sourceContext.moveCharacterTo2(...) return sourceContext.environment2.moveCharacterTo(...) end
function sourceContext.callStopMoveTween(...) return sourceContext.environment2.stopMoveTween(...) end
function sourceContext.callZeroRootVelocity(...) return sourceContext.environment2.zeroRootVelocity(...) end
function sourceContext.callWakeUpPhysicsAndSync(...) return sourceContext.environment2.wakeUpPhysicsAndSync(...) end
function sourceContext.activatePrompt2(...) return sourceContext.environment2.activatePrompt(...) end
function sourceContext.callIsItemAvailable(...) return sourceContext.environment2.isItemAvailable(...) end
function sourceContext.cleanupItemStick2(...) return sourceContext.environment2.cleanupItemStick(...) end
function sourceContext.enableNoclip2(...) return sourceContext.environment2.enableNoclip(...) end
sourceContext.maxLimits2 = sourceContext.environment2.maxLimits
function sourceContext.callback74(a)
  if typeof(a) == "Instance" then
    local Workspace = game.Workspace
    Workspace = Workspace:FindFirstChild("Item_Spawns")
    Workspace = Workspace and game.Workspace.Item_Spawns:FindFirstChild("Items")
    if Workspace and a:IsDescendantOf(Workspace) then return true end
    if a:FindFirstChild("ProximityPrompt") then return true end
    if a.Parent and a.Parent:FindFirstChild("ProximityPrompt") then return true end
    return false
  end
  return false
end
sourceContext.count10, sourceContext.count11, sourceContext.count12, sourceContext.count13 = -702.137085, 975.83844, -805.215942, 468.16217
function getRandomFarmRoamCFrame()
  local rootPart4 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
  local newResult = rootPart4 and rootPart4.CFrame.LookVector or Vector3.new(0, 0, -1)
  local new = Vector3.new(newResult.X, 0, newResult.Z)
  local Unit
  Unit = if new.Magnitude < 0.01 then Vector3.new(0, 0, -1) else new.Unit
  local entry10 = sourceContext.count10 + math.random() * (975.83844 - sourceContext.count10)
  local entry11 = sourceContext.count12 + math.random() * (468.16217 - sourceContext.count12)
  local new2 = Vector3.new(entry10, 65 + math.random() * 10, entry11)
  return CFrame.lookAt(new2, new2 + Unit)
end
function waitForGameLoad()
  if not sourceContext.callback14 or not sourceContext.callback14() then task.spawn(function() pcall(sourceContext.callback19) end) end
  local timestamp2 = tick()
  while tick() - timestamp2 < 120 do
    if sourceContext.callback14 and sourceContext.callback14() then return true end
    task.wait(0.5)
  end
  if sourceContext.callback14 and sourceContext.callback14() then return true end
  warn("[YBA] Game load timeout: Character took too long.")
  return false
end
function getRandomSkyCFrame()
  local rootPart4 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
  local newResult = rootPart4 and rootPart4.CFrame.LookVector or Vector3.new(0, 0, -1)
  local new = Vector3.new(newResult.X, 0, newResult.Z)
  local Unit
  Unit = if new.Magnitude < 0.01 then Vector3.new(0, 0, -1) else new.Unit
  local entry10 = sourceContext.count10 + math.random() * (975.83844 - sourceContext.count10)
  local entry11 = sourceContext.count12 + math.random() * (468.16217 - sourceContext.count12)
  local new2 = Vector3.new(entry10, 65 + math.random() * 10, entry11)
  return CFrame.lookAt(new2, new2 + Unit)
end
function cleanupFarmPads()
  pcall(function()
    local whitePad = sourceContext.parent:FindFirstChild("WhitePad")
    if whitePad then whitePad:Destroy() end
    local underwhitePad = sourceContext.parent:FindFirstChild("UnderwhitePad")
    if underwhitePad then underwhitePad:Destroy() end
    local yBAFloatPadFarm = sourceContext.parent:FindFirstChild("YBA_FloatPad_Farm")
    if yBAFloatPadFarm then yBAFloatPadFarm:Destroy() end
  end)
end
function sourceContext.callback75(_) cleanupFarmPads() end
function randomSkyRoam(a)
  a = a or 5
  local timestamp2 = tick()
  sourceContext.enableNoclip2(normalFarmOn and "farm" or "main")
  while tick() - timestamp2 < a do
    local rootPart4 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
    if rootPart4 then
      local cFrame = getRandomSkyCFrame()
      sourceContext.callback75(cFrame.Position)
      if getgenv()._YBA_directTP then
        rootPart4.CFrame = cFrame
        rootPart4.AssemblyLinearVelocity = Vector3.zero
        rootPart4.AssemblyAngularVelocity = Vector3.zero
      else
        sourceContext.moveCharacterTo2(cFrame)
      end
    end
    task.wait(0.3125)
  end
end
function sourceContext.callback76(a, b)
  local Character = sourceContext.player.Character
  if Character then
    local rootPart4 = Character:FindFirstChild("HumanoidRootPart")
    if rootPart4 then
      local pcallResult, cFrame = pcall(function() return b:GetModelCFrame() - Vector3.new(0, 7.5, 0) end)
      if pcallResult and cFrame then
        rootPart4.CFrame = cFrame
        local timestamp2 = tick()
        repeat
          task.wait()
          rootPart4.CFrame = cFrame
          local Position = rootPart4.Position
          local p = b:GetModelCFrame()
          p = p.p
        until (Position - p).Magnitude <= 40 or not b.Parent or tick() - timestamp2 > 3
        if b.Parent then
          task.wait(sourceContext.callback26(0.5))
          local timestamp3 = tick()
          repeat
            pcall(function()
              if a and a:FindFirstChild("RemoteEvent") then
                a.RemoteEvent:FireServer()
              elseif a then fireproximityprompt(a, 0, true) end
            end)
            task.wait(0.1)
          until not b.Parent or not b:FindFirstChild("ProximityPrompt") or tick() - timestamp3 > 3.5
          return true
        end
        return false
      end
      return false
    end
    return false
  end
  return false
end
function travelToInstant(cFrame)
  if sourceContext.getgenv2() then
    sourceContext.callback27(0.5)
    return false
  end
  if sourceContext.callback28() then return false end
  sourceContext.cleanupItemStick2()
  sourceContext.enableNoclip2(normalFarmOn and "farm" or SF and SF.standFarmRunning and "stand" or "main")
  local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
  if character2 and character2.Parent and character2.Parent == workspace.Living then
    local humanoid3 = character2:FindFirstChildOfClass("Humanoid")
    if humanoid3 and not (humanoid3.Health <= 0) then
      local rootPart4 = character2:FindFirstChild("HumanoidRootPart")
      if rootPart4 then
        local PrimaryPart, Parent = nil, nil
        if typeof(cFrame) == "Vector3" then
          if getgenv()._YBA_directTP then
            rootPart4.CFrame = CFrame.new(cFrame)
            sourceContext.callZeroRootVelocity(rootPart4)
            return true
          end
          sourceContext.enableNoclip2(normalFarmOn and "farm" or "main")
          return tweenMoveTo(rootPart4, CFrame.new(cFrame), moveTweenSpeed, nil)
        end
        if typeof(cFrame) == "CFrame" then
          if getgenv()._YBA_directTP then
            rootPart4.CFrame = cFrame
            sourceContext.callZeroRootVelocity(rootPart4)
            return true
          end
          sourceContext.enableNoclip2(normalFarmOn and "farm" or "main")
          return tweenMoveTo(rootPart4, cFrame, moveTweenSpeed, nil)
        end
        if typeof(cFrame) == "Instance" then
          local entry10 = sourceContext.callback74(cFrame)
          if cFrame:IsA("BasePart") then
            PrimaryPart = cFrame
            Parent = cFrame.Parent
          else
            if cFrame:FindFirstChildOfClass("MeshPart") then
              PrimaryPart = cFrame:FindFirstChildOfClass("MeshPart")
              Parent = cFrame
            else
              if cFrame:FindFirstChildOfClass("Part") then
                PrimaryPart = cFrame:FindFirstChildOfClass("Part")
                Parent = cFrame
              elseif cFrame.PrimaryPart then
                PrimaryPart = cFrame.PrimaryPart
                Parent = cFrame
              end
            end
          end
          if PrimaryPart and PrimaryPart.Parent then
            if entry10 then
              local proximityPrompt3
              proximityPrompt3 = if PrimaryPart.Parent then PrimaryPart.Parent:FindFirstChildWhichIsA("ProximityPrompt", true) else nil
              if not proximityPrompt3 and PrimaryPart:FindFirstChildWhichIsA("ProximityPrompt", true) then
                proximityPrompt3 = PrimaryPart:FindFirstChildWhichIsA("ProximityPrompt", true)
              end
              if sourceContext.callIsItemAvailable(Parent or PrimaryPart) then
                local lowerResult = tostring(getgenv().InstantMethod or sourceContext.callback35 and sourceContext.callback35("FarmPosMethod", "Up") or "Up"):lower()
                local count4 = lowerResult == "down" and -7 or lowerResult == "def" and 0 or 7
                local Position = PrimaryPart.Position
                local cFrame2
                Position = Position + Vector3.new(0, count4, 0)
                cFrame2 = CFrame
                cFrame2 = cFrame2.new
                cFrame2 = cFrame2(Position)
                local Angles = CFrame.Angles(0, rootPart4.CFrame.Y, 0)
                cFrame2 = cFrame2 * Angles
                function Angles()
                  if sourceContext.callIsItemAvailable(Parent or PrimaryPart) then
                    if proximityPrompt3 and (not proximityPrompt3.Parent or not proximityPrompt3:IsDescendantOf(workspace) or proximityPrompt3.Enabled == false) then
                      return true
                    end
                    if PrimaryPart and (not PrimaryPart.Parent or not PrimaryPart:IsDescendantOf(workspace)) then return true end
                    if normalFarmOn == false and standFarmRunning == false and ribFarmRunning == false and shinyFarmRunning == false then return true end
                    return false
                  end
                  return true
                end
                local _YBA_directTP = getgenv()
                _YBA_directTP = _YBA_directTP._YBA_directTP
                if _YBA_directTP then
                  rootPart4.CFrame = cFrame2
                  sourceContext.callZeroRootVelocity(rootPart4)
                else
                  sourceContext.enableNoclip2(normalFarmOn and "farm" or "main")
                  local tweenMoveToResult = tweenMoveTo(rootPart4, cFrame2, moveTweenSpeed, Angles)
                  if not tweenMoveToResult or Angles() then
                    sourceContext.cleanupItemStick2()
                    sourceContext.callZeroRootVelocity(rootPart4)
                    return false
                  end
                end
                if sourceContext.callIsItemAvailable(Parent or PrimaryPart) and PrimaryPart.Parent then
                  local conn = game:GetService("RunService")
                  conn = conn.Heartbeat
                  local conn2 = conn
                  conn = conn.Connect
                  conn = conn(conn2, function()
                    if sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart") then
                      if PrimaryPart and PrimaryPart.Parent and sourceContext.callIsItemAvailable(Parent or PrimaryPart) then
                        rootPart4.CFrame = CFrame.new(PrimaryPart.Position + Vector3.new(0, count4, 0)) * CFrame.Angles(0, rootPart4.CFrame.Y, 0)
                        rootPart4.AssemblyLinearVelocity = Vector3.zero
                        rootPart4.AssemblyAngularVelocity = Vector3.zero
                      else
                        sourceContext.cleanupItemStick2()
                      end
                      return
                    end
                    sourceContext.cleanupItemStick2()
                  end)
                  table.insert(getgenv().ItemStickConnections, { conn = conn })
                  if proximityPrompt3 then
                    task.spawn(function()
                      local entry10 = sourceContext.callback26(0.35)
                      if entry10 > 0 then task.wait(entry10) end
                      local timestamp2 = tick()
                      while PrimaryPart and PrimaryPart.Parent do
                        if not sourceContext.callIsItemAvailable(Parent or PrimaryPart) or sourceContext.enabled9 or getgenv()._YBA_SellingBusy then break end
                        pcall(function()
                          if proximityPrompt3:FindFirstChild("RemoteEvent") then proximityPrompt3.RemoteEvent:FireServer() else fireproximityprompt(proximityPrompt3, 0, true) end
                        end)
                        task.wait(0.1)
                        if tick() - timestamp2 > 4 then break end
                      end
                    end)
                  end
                  return true
                end
                sourceContext.cleanupItemStick2()
                sourceContext.callZeroRootVelocity(rootPart4)
                return false
              end
              return false
            end
            local _YBA_directTP2 = getgenv()
            _YBA_directTP2 = _YBA_directTP2._YBA_directTP
            if _YBA_directTP2 then
              rootPart4.CFrame = CFrame.new(PrimaryPart.Position)
              sourceContext.callZeroRootVelocity(rootPart4)
              return true
            end
            sourceContext.enableNoclip2(normalFarmOn and "farm" or "main")
            return tweenMoveTo(rootPart4, CFrame.new(PrimaryPart.Position), moveTweenSpeed, function()
              return not PrimaryPart or not PrimaryPart.Parent or not PrimaryPart:IsDescendantOf(workspace)
            end)
          end
          return false
        end
        return false
      end
      return false
    end
    return false
  end
  return false
end
sourceContext.randomFarmRoamCFrame = getRandomFarmRoamCFrame()
function sourceContext.callback77()
  sourceContext.cleanupItemStick2()
  if not (sourceContext.player.Character and sourceContext.player.Character.HumanoidRootPart) then return end
  sourceContext.randomFarmRoamCFrame = getRandomFarmRoamCFrame()
  sourceContext.callback75(nil)
  sourceContext.moveCharacterTo2(sourceContext.randomFarmRoamCFrame)
end
function instantTravelTo(a, b)
  local travelToInstantResult = travelToInstant(a)
  if b and travelToInstantResult then task.wait(b) end
  return travelToInstantResult
end
function collectSingleItemNormal(_lastItemTarget)
  if sourceContext.getgenv2() then
    sourceContext.callback27(0.5)
    return false
  end
  if not sourceContext.callback28() and not sourceContext.enabled9 and not getgenv()._YBA_SellingBusy then
    if sourceContext.callIsItemAvailable(_lastItemTarget) then
      if sourceContext.checkAndSellMax2 then pcall(sourceContext.checkAndSellMax2) end
      if sourceContext.getgenv2() then
        sourceContext.callback27(0.5)
        return false
      end
      if not sourceContext.callback28() and not sourceContext.enabled9 and not getgenv()._YBA_SellingBusy then
        local _lastItemTargetTime = os.clock()
        local _lastItemTarget2 = getgenv()
        _lastItemTarget2 = _lastItemTarget2._lastItemTarget
        if _lastItemTarget2 and getgenv()._lastItemTarget == _lastItemTarget then
          local getgenv4
          getgenv()._lastItemTargetAttempts = (getgenv()._lastItemTargetAttempts or 1) + 1
          getgenv4 = getgenv
          getgenv4 = getgenv4()
          getgenv4 = getgenv4._lastItemTargetTime
          getgenv4 = _lastItemTargetTime - getgenv4
          if getgenv4 > 8 or getgenv()._lastItemTargetAttempts > 5 then
            warn("[Farm] Stuck on item for 8s / 5 attempts. Temporarily ignoring for 15s...")
            getgenv()._blacklistedItems = getgenv()._blacklistedItems or {}
            getgenv()._blacklistedItems[_lastItemTarget] = _lastItemTargetTime + 15
            getgenv()._lastItemTarget = nil
            getgenv()._lastItemTargetAttempts = 0
            sourceContext.cleanupItemStick2()
            return false
          end
        else
          getgenv()._lastItemTarget = _lastItemTarget
          getgenv()._lastItemTargetTime = _lastItemTargetTime
          getgenv()._lastItemTargetAttempts = 1
        end
        local entry10 = sourceContext.callGetItemComponents
        local proximityPrompt4, entry11
        entry10, proximityPrompt4, entry11 = sourceContext.callGetItemComponents(_lastItemTarget)
        if not (entry10 and proximityPrompt4) then
          entry10 = entry10 or _lastItemTarget:FindFirstChildWhichIsA("BasePart", true) or _lastItemTarget.PrimaryPart
          if not proximityPrompt4 then proximityPrompt4 = _lastItemTarget:FindFirstChildWhichIsA("ProximityPrompt", true) end
        end
        if entry10 and proximityPrompt4 and sourceContext.callIsItemAvailable(_lastItemTarget) then
          local entry12 = sourceContext.callback26(0.35)
          if instantPickup then
            local instantTravelToResult = instantTravelTo(entry10)
            if not (instantTravelToResult and sourceContext.callIsItemAvailable(_lastItemTarget)) then
              sourceContext.cleanupItemStick2()
              return false
            end
            task.wait(entry12)
            if sourceContext.enabled9 or getgenv()._YBA_SellingBusy or sourceContext.callback28() or not sourceContext.callIsItemAvailable(_lastItemTarget) then
              sourceContext.cleanupItemStick2()
              return false
            end
            if type(fireproximityprompt) == "function" then pcall(function() fireproximityprompt(proximityPrompt4, 0, true) end) end
            sourceContext.activatePrompt2(proximityPrompt4, 0)
          else
            local travelToInstantResult = travelToInstant(entry10)
            if not (travelToInstantResult and sourceContext.callIsItemAvailable(_lastItemTarget)) then
              sourceContext.cleanupItemStick2()
              return false
            end
            task.wait(entry12)
            if sourceContext.enabled9 or getgenv()._YBA_SellingBusy or sourceContext.callback28() or not sourceContext.callIsItemAvailable(_lastItemTarget) then
              sourceContext.cleanupItemStick2()
              return false
            end
            local humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart and (entry10.Position - humanoidRootPart.Position).Magnitude <= 15 then
              if type(fireproximityprompt) == "function" then pcall(function() fireproximityprompt(proximityPrompt4, 0, true) end) end
              sourceContext.activatePrompt2(proximityPrompt4, 0.4)
            end
          end
          local timestamp2 = tick()
          while tick() - timestamp2 < 1 do
            if not (sourceContext.callIsItemAvailable(_lastItemTarget) and not sourceContext.callback28()) then break end
            local task2 = type(fireproximityprompt)
            if task2 == "function" then pcall(function() fireproximityprompt(proximityPrompt4, 0, true) end) end
            task.wait(0.1)
          end
          sourceContext.callCheckAndBuyLuckyArrow()
          task.wait(0.1)
          sourceContext.cleanupItemStick2()
          return not sourceContext.callIsItemAvailable(_lastItemTarget)
        end
        return false
      end
      return false
    end
    return false
  end
  return false
end
function collectItemLikeNormalFarm(a) return collectSingleItemNormal(a) end
function farmItemByName(itemName, targetCount, shouldContinue)
  local skipTolbl_17, skipTolbl_129, skipTolbl_149, skipTolbl_290, skipTolbl_209, skipTolbl_234, skipTolbl_259, skipTolbl_284 = false, false, false, false, false, false, false, false
  local tick3, count8, entry10, entry11, entry12, itemName2, entry13, itemSpawnsText, humanoidRootPartText, entry14, player3, player4, entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3
  if not targetCount then targetCount = 1 end
  tick3 = tick
  tick3 = tick3()
  count8 = 0
  entry10 = nil
  entry11 = nil
  entry12 = sourceContext.callSfCountItem
  if sourceContext.callSfCountItem then
    entry12 = sourceContext.callSfCountItem
    itemName2 = itemName
    entry12 = sourceContext.callSfCountItem(itemName)
    if entry12 then skipTolbl_17 = true end
  end
  if not skipTolbl_17 then entry12 = itemName end
  skipTolbl_17 = false
  while targetCount > count8 do
    itemName2 = tick
    itemName2 = itemName2()
    itemName2 = itemName2 - tick3
    if not (itemName2 < 30) then break end
    if shouldContinue then
      itemName2 = shouldContinue
      itemName2 = shouldContinue()
      if not itemName2 then

      end
    else
      itemName2 = sourceContext.getgenv2
      itemName2 = itemName2()
      if itemName2 then

      else
        itemName2 = game
        itemName2 = itemName2.Workspace
        entry13 = itemName2
        itemName2 = itemName2.FindFirstChild
        itemSpawnsText = "Item_Spawns"
        itemName2 = itemName2(entry13, "Item_Spawns")
        if itemName2 then
          itemName2 = game
          itemName2 = itemName2.Workspace
          itemName2 = itemName2.Item_Spawns
          entry13 = itemName2
          itemName2 = itemName2.FindFirstChild
          itemSpawnsText = "Items"
          itemName2 = itemName2(entry13, "Items")
        end
        if not itemName2 then
          entry13 = task
          entry13 = entry13.wait
          itemSpawnsText = 0.5
          entry13(0.5)
        else
          entry13 = sourceContext.player
          entry13 = sourceContext.player.Character
          if entry13 then
            entry13 = sourceContext.player
            entry13 = sourceContext.player.Character
            itemSpawnsText = entry13
            entry13 = entry13.FindFirstChild
            humanoidRootPartText = "HumanoidRootPart"
            entry13 = entry13(itemSpawnsText, "HumanoidRootPart")
          end
          if not entry13 then
            itemSpawnsText = task
            itemSpawnsText = itemSpawnsText.wait
            humanoidRootPartText = 0.5
            itemSpawnsText(0.5)
          else
            itemSpawnsText = nil
            humanoidRootPartText = math
            humanoidRootPartText = humanoidRootPartText.huge
            entry14 = pairs
            player4 = itemName2
            player3 = itemName2.GetChildren
            player3, player4, entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3 = player3(itemName2)
            entry14, player3, player4 = entry14(player3, player4, entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3)
            for entry20, entry23 in entry14, player3, player4 do
              getgenv4 = getgenv
              getgenv4 = getgenv4()
              getgenv4 = getgenv4._blacklistedItems
              if getgenv4 then
                getgenv4 = getgenv
                getgenv4 = getgenv4()
                getgenv4 = getgenv4._blacklistedItems
                getgenv4 = getgenv4[entry23]
                if getgenv4 then
                  getgenv4 = os
                  getgenv4 = getgenv4.clock
                  getgenv4 = getgenv4()
                  getgenv6 = getgenv
                  getgenv6 = getgenv6()
                  getgenv6 = getgenv6._blacklistedItems
                  getgenv6 = getgenv6[entry23]
                  if not getgenv6 then getgenv6 = 0 end
                  if getgenv4 < getgenv6 then

                  else
                    getgenv4 = getgenv
                    getgenv4 = getgenv4()
                    getgenv4 = getgenv4._blacklistedItems
                    getgenv4[entry23] = nil
                    getgenv4 = sourceContext.callCheckAndBuyLuckyArrow
                    getgenv6 = entry23
                    getgenv4, getgenv6, name2 = sourceContext.callCheckAndBuyLuckyArrow(entry23)
                    if getgenv4 and getgenv6 then
                      entry18 = sourceContext.callback74
                      entry19 = entry23
                      entry18 = sourceContext.callback74(entry23)
                      if entry18 then
                        entry18 = sourceContext.callSfCountItem
                        if sourceContext.callSfCountItem then
                          entry18 = sourceContext.callSfCountItem
                          entry19 = name2
                          entry18 = sourceContext.callSfCountItem(name2)
                          if entry18 then skipTolbl_129 = true end
                        end
                        if not skipTolbl_129 then entry18 = name2 end
                        skipTolbl_129 = false
                        if entry18 ~= entry12 and name2 ~= itemName then
                          entry19 = entry23.Name
                          if not entry19 then skipTolbl_149 = true end
                          if not skipTolbl_149 then entry19 = sourceContext.callSfCountItem end
                          if not skipTolbl_149 then name3 = entry23.Name end
                          if not skipTolbl_149 then entry19 = entry19(name3) end
                          if not skipTolbl_149 then if entry19 ~= entry12 then skipTolbl_149 = true end end
                        end
                        if not skipTolbl_149 then entry19 = getgenv4.Position end
                        if not skipTolbl_149 then name3 = entry13.Position end
                        if not skipTolbl_149 then entry19 = entry19 - name3 end
                        if not skipTolbl_149 then entry19 = entry19.Magnitude end
                        if not skipTolbl_149 then
                          if humanoidRootPartText > entry19 then
                            humanoidRootPartText = entry19
                            itemSpawnsText = entry23
                          end
                        end
                      end
                    end
                  end
                end
              end
              skipTolbl_149 = false
            end
            if not itemSpawnsText then
              entry14 = tick
              entry14 = entry14()
              entry14 = entry14 - tick3
              if 3 < entry14 and 1 <= count8 then

              else
                entry14 = task
                entry14 = entry14.wait
                player3 = 0.5
                entry14(0.5)
              end
            else
              if itemSpawnsText ~= entry10 then
                entry10 = itemSpawnsText
                entry14 = tick
                entry14 = entry14()
                entry11 = entry14
              elseif entry11 then
                entry14 = tick
                entry14 = entry14()
                entry14 = entry14 - entry11
                if 10 < entry14 then
                  entry14 = warn
                  player3 = "[farmItemByName] Stuck on item for 10s, skipping"
                  entry14("[farmItemByName] Stuck on item for 10s, skipping")
                  entry10 = nil
                  entry11 = nil
                  entry14 = task
                  entry14 = entry14.wait
                  player3 = 0.5
                  entry14(0.5)
                  skipTolbl_290 = true
                end
              end
              if not skipTolbl_290 then entry14 = 0 end
              if not skipTolbl_290 then player3 = pairs end
              if not skipTolbl_290 then player4 = sourceContext.player end
              if not skipTolbl_290 then player4 = player4.Backpack end
              if not skipTolbl_290 then entry16 = player4 end
              if not skipTolbl_290 then player4 = player4.GetChildren end
              if not skipTolbl_290 then player4, entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3 = player4(entry16) end
              if not skipTolbl_290 then player3, player4, entry16 = player3(player4, entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3) end
              if not skipTolbl_290 then
                for entry24, entry25 in player3, player4, entry16 do
                  getgenv6 = entry25.Name
                  if getgenv6 ~= itemName then
                    getgenv6 = sourceContext.callSfCountItem
                    if not sourceContext.callSfCountItem then skipTolbl_209 = true end
                    if not skipTolbl_209 then getgenv6 = sourceContext.callSfCountItem end
                    if not skipTolbl_209 then name2 = entry25.Name end
                    if not skipTolbl_209 then getgenv6 = getgenv6(name2) end
                    if not skipTolbl_209 then if getgenv6 ~= entry12 then skipTolbl_209 = true end end
                  end
                  if not skipTolbl_209 then entry14 = entry14 + 1 end
                  skipTolbl_209 = false
                end
              end
              if not skipTolbl_290 then player3 = sourceContext.player end
              if not skipTolbl_290 then player3 = player3.Character end
              if not skipTolbl_290 then
                if player3 then
                  player3 = pairs
                  player4 = sourceContext.player
                  player4 = sourceContext.player.Character
                  entry16 = player4
                  player4 = player4.GetChildren
                  player4, entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3 = player4(entry16)
                  player3, player4, entry16 = player3(player4, entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3)
                  for entry26, entry27 in player3, player4, entry16 do
                    getgenv6 = entry27.Name
                    if getgenv6 ~= itemName then
                      getgenv6 = sourceContext.callSfCountItem
                      if not sourceContext.callSfCountItem then skipTolbl_234 = true end
                      if not skipTolbl_234 then getgenv6 = sourceContext.callSfCountItem end
                      if not skipTolbl_234 then name2 = entry27.Name end
                      if not skipTolbl_234 then getgenv6 = getgenv6(name2) end
                      if not skipTolbl_234 then if getgenv6 ~= entry12 then skipTolbl_234 = true end end
                    end
                    if not skipTolbl_234 then entry14 = entry14 + 1 end
                    skipTolbl_234 = false
                  end
                end
              end
              if not skipTolbl_290 then player3 = collectSingleItemNormal end
              if not skipTolbl_290 then player4 = itemSpawnsText end
              if not skipTolbl_290 then player3(player4) end
              if not skipTolbl_290 then player3 = 0 end
              if not skipTolbl_290 then player4 = pairs end
              if not skipTolbl_290 then entry16 = sourceContext.player end
              if not skipTolbl_290 then entry16 = entry16.Backpack end
              if not skipTolbl_290 then entry17 = entry16 end
              if not skipTolbl_290 then entry16 = entry16.GetChildren end
              if not skipTolbl_290 then entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3 = entry16(entry17) end
              if not skipTolbl_290 then player4, entry16, entry17 = player4(entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3) end
              if not skipTolbl_290 then
                for entry28, entry29 in player4, entry16, entry17 do
                  name2 = entry29.Name
                  if name2 ~= itemName then
                    name2 = sourceContext.callSfCountItem
                    if not sourceContext.callSfCountItem then skipTolbl_259 = true end
                    if not skipTolbl_259 then name2 = sourceContext.callSfCountItem end
                    if not skipTolbl_259 then entry18 = entry29.Name end
                    if not skipTolbl_259 then name2 = name2(entry18) end
                    if not skipTolbl_259 then if name2 ~= entry12 then skipTolbl_259 = true end end
                  end
                  if not skipTolbl_259 then player3 = player3 + 1 end
                  skipTolbl_259 = false
                end
              end
              if not skipTolbl_290 then player4 = sourceContext.player end
              if not skipTolbl_290 then player4 = player4.Character end
              if not skipTolbl_290 then
                if player4 then
                  player4 = pairs
                  entry16 = sourceContext.player
                  entry16 = sourceContext.player.Character
                  entry17 = entry16
                  entry16 = entry16.GetChildren
                  entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3 = entry16(entry17)
                  player4, entry16, entry17 = player4(entry16, entry17, getgenv4, getgenv6, name2, entry18, entry19, name3)
                  for entry30, entry31 in player4, entry16, entry17 do
                    name2 = entry31.Name
                    if name2 ~= itemName then
                      name2 = sourceContext.callSfCountItem
                      if not sourceContext.callSfCountItem then skipTolbl_284 = true end
                      if not skipTolbl_284 then name2 = sourceContext.callSfCountItem end
                      if not skipTolbl_284 then entry18 = entry31.Name end
                      if not skipTolbl_284 then name2 = name2(entry18) end
                      if not skipTolbl_284 then if name2 ~= entry12 then skipTolbl_284 = true end end
                    end
                    if not skipTolbl_284 then player3 = player3 + 1 end
                    skipTolbl_284 = false
                  end
                end
              end
              if not skipTolbl_290 then
                if entry14 < player3 then
                  player4 = player3 - entry14
                  count8 = count8 + player4
                end
              end
            end
          end
        end
      end
    end
    skipTolbl_290 = false
  end
  return count8
end
normalFarmOn = false
function sourceContext.enabled19()
  local savedSelectedFarmItems = sourceContext.callback35 and sourceContext.callback35("SelectedFarmItems")
  if type(savedSelectedFarmItems) == "table" then
    local entries12 = {}
    for k, v in ipairs(savedSelectedFarmItems) do if type(v) == "string" then table.insert(entries12, v) end end
    return entries12
  end
  return {}
end
selectedFarmItems = sourceContext.enabled19()
sourceContext.enabled19 = false
sourceContext.length = #selectedFarmItems
for i2 = sourceContext.length, 1, -1 do
  local entry23 = sourceContext.callNormalizeItemName and sourceContext.callNormalizeItemName(selectedFarmItems[i2]) or selectedFarmItems[i2]
  if sourceContext.environment2 and sourceContext.environment2.nonFarmableItems and sourceContext.environment2.nonFarmableItems[entry23] then
    table.remove(selectedFarmItems, i2)
    sourceContext.enabled19 = true
  end
end
if sourceContext.enabled19 then pcall(function() sourceContext.callback34("SelectedFarmItems", selectedFarmItems) end) end
function sourceContext.entry24()
  local savedSLBL = sourceContext.callback35 and sourceContext.callback35("SLBL")
  if type(savedSLBL) == "table" then
    local entries12 = {}
    for k, v in ipairs(savedSLBL) do if type(v) == "string" and not ((tostring(v))):lower():find("lucky") then table.insert(entries12, v) end end
    return entries12
  end
  return {}
end
sourceContext.entry24 = sourceContext.entry24()
sellBlacklist = sourceContext.entry24
function sourceContext.entry24(entries12)
  local humanoidRootPart, Workspace, items, huge, clock, entry10, entry11, entry12, entry13, entry14, entry16, ipairsResult, entry17, entry18
  humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
  if humanoidRootPart then
    items = game.Workspace:FindFirstChild("Item_Spawns") and game.Workspace.Item_Spawns:FindFirstChild("Items")
    if items then
      for i = 1, 2 do
        if i == 2 then
          pcall(function()
            local _blacklistedItems = getgenv()
            _blacklistedItems = _blacklistedItems._blacklistedItems
            if type(_blacklistedItems) == "table" then
              local clock = os.clock()
              for k, v in pairs(_blacklistedItems) do
                local enabled19 = false
                pcall(function() if not k.Parent or not k:IsDescendantOf(workspace) then enabled19 = true end end)
                if enabled19 or type(v) == "number" and v <= clock then _blacklistedItems[k] = nil end
              end
            end
          end)
        end
        huge = math.huge
        local v22 = nil
        clock = os.clock()
        for k2, v2 in pairs(items:GetChildren()) do
          if i == 1 and getgenv()._blacklistedItems and getgenv()._blacklistedItems[v2] then
            local environment6 = getgenv()
            environment6 = environment6._blacklistedItems
            environment6 = environment6[v2]
            if not (clock < environment6) then getgenv()._blacklistedItems[v2] = nil end
          end
          entry12, entry13, entry14 = sourceContext.callGetItemComponents(v2)
          if entry12 and entry13 and sourceContext.callIsItemAvailable(v2) then
            entry16 = sourceContext.callNormalizeItemName and sourceContext.callNormalizeItemName(entry14) or entry14
            if not sourceContext.environment2 or not sourceContext.environment2.nonFarmableItems or not sourceContext.environment2.nonFarmableItems[entry16] then
              local count8 = sourceContext.callSfCountItem and sourceContext.callSfCountItem(entry14) or 0
              local count11 = sourceContext.maxLimits2 and (sourceContext.maxLimits2[entry14] or sourceContext.callNormalizeItemName and sourceContext.maxLimits2[sourceContext.callNormalizeItemName(entry14)]) or 25
              if not isAutoSellBlacklisted or not isAutoSellBlacklisted(entry14) or not (count11 <= count8) then
                local count13 = #entries12 == 0
                local entry19
                if count13 then
                  entry19 = count13
                else
                  local entry20 = sourceContext.callNormalizeItemName and sourceContext.callNormalizeItemName(entry14) or entry14
                  ipairsResult, entry17, entry18 = ipairs(entries12)
                  entry19 = count13
                  for k, v in ipairsResult, entry17, entry18 do
                    if sourceContext.callNormalizeItemName and sourceContext.callNormalizeItemName(v) == entry20 or v == entry14 then
                      entry19 = true
                      break
                    end
                  end
                end
                if entry19 and count8 < count11 then
                  local Magnitude = entry12.Position - humanoidRootPart.Position
                  Magnitude = Magnitude.Magnitude
                  if Magnitude < huge then huge, v22 = Magnitude, v2 end
                end
              end
            end
          end
        end
        if v22 then return v22 end
      end
      return nil
    end
    return nil
  end
  return nil
end
findNearestItem = sourceContext.entry24
function sourceContext.entry24()
  local humanoidRootPart, Workspace, items, huge, clock, entry10, entry11, entry12, entry13, entry14, Magnitude, count8
  humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character.HumanoidRootPart
  if humanoidRootPart then
    items = game.Workspace:FindFirstChild("Item_Spawns") and game.Workspace.Item_Spawns:FindFirstChild("Items")
    if items then
      for i = 1, 2 do
        if i == 2 then
          pcall(function()
            local _blacklistedItems = getgenv()
            _blacklistedItems = _blacklistedItems._blacklistedItems
            if type(_blacklistedItems) == "table" then
              local clock = os.clock()
              for k, v in pairs(_blacklistedItems) do
                local enabled20 = false
                pcall(function() if not k.Parent or not k:IsDescendantOf(workspace) then enabled20 = true end end)
                if enabled20 or type(v) == "number" and v <= clock then _blacklistedItems[k] = nil end
              end
            end
          end)
        end
        huge = math.huge
        local v14 = nil
        clock = os.clock()
        for k, v in pairs(items:GetChildren()) do
          if i == 1 and getgenv()._blacklistedItems and getgenv()._blacklistedItems[v] then
            local environment6 = getgenv()
            environment6 = environment6._blacklistedItems
            environment6 = environment6[v]
            if not (clock < environment6) then getgenv()._blacklistedItems[v] = nil end
          end
          entry12, entry13, entry14 = sourceContext.callGetItemComponents(v)
          if entry12 and entry13 and sourceContext.callIsItemAvailable(v) and (entry14 == "Lucky Arrow" or v.Name and v.Name:find("Lucky Arrow")) then
            if isAutoSellBlacklisted and isAutoSellBlacklisted(entry14) then
              Magnitude = sourceContext.callSfCountItem and sourceContext.callSfCountItem(entry14) or 0
              count8 = sourceContext.maxLimits2 and sourceContext.maxLimits2[entry14] or 9
              if not (count8 <= Magnitude) then

              end
            end
            Magnitude = entry12.Position - humanoidRootPart.Position
            Magnitude = Magnitude.Magnitude
            if Magnitude < huge then huge, v14 = Magnitude, v end
          end
        end
        if v14 then return v14 end
      end
      return nil
    end
    return nil
  end
  return nil
end
findLuckyArrow = sourceContext.entry24
sourceContext.entry24 = sourceContext.callback35
serverHopFarmEnabled = sourceContext.callback35("SHF", true)
sourceContext.entry24 = 10
function sourceContext.callback78()
  if readfile and isfile and isfile("rbxcache/active_servers.json") then
    local pcallResult, entry10 = pcall(readfile, "rbxcache/active_servers.json")
    if pcallResult and type(entry10) == "string" and entry10 ~= "" then
      local pcallResult2, entries12 = pcall(function() return sourceContext.httpServiceService2:JSONDecode(entry10) end)
      if pcallResult2 and type(entries12) == "table" then
        local time = os.time()
        local entries13 = {}
        for k, v in pairs(entries12) do if type(v) == "table" and v.time and time - v.time < 180 then entries13[tostring(k)] = v end end
        return entries13
      end
      return {}
    end
    return {}
  end
  return {}
end
function sourceContext.callback79(a, b)
  if not (a and a ~= "") then return end
  local entry11 = sourceContext.callback78()
  entry11[tostring(a)] = { account = tostring(b or sourceContext.player and sourceContext.player.Name or "Account"), time = os.time() }
  pcall(function()
    if makefolder and (not isfolder or not isfolder("rbxcache")) then pcall(makefolder, "rbxcache") end
    if writefile then writefile("rbxcache/active_servers.json", sourceContext.httpServiceService2:JSONEncode(entry11)) end
  end)
end
task.spawn(function()
  while true do
    if game.JobId and game.JobId ~= "" then
      local entry12, LocalPlayer, Name
      LocalPlayer = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
      local entry13 = pcall
      local JobId = game.JobId
      Name = if LocalPlayer then LocalPlayer.Name else LocalPlayer
      entry13(sourceContext.callback79, JobId, Name)
    end
    task.wait(30)
  end
end)
function sourceContext.callback80()
  return syn and syn.request or http and http.request or fluxus and fluxus.request or krnl and krnl.request or delta and delta.request or identifyexecutor and (http_request or request) or http_request or request
end
function sourceContext.callback81(a)
  local entry12 = sourceContext.callback80()
  if entry12 then
    local entry13 = sourceContext.callback78()
    local entries12 = {}
    local entries13 = {}
    a = a or 30
    local clamp = math.clamp(math.ceil(a / 100), 1, 3)
    local Text5 = ""
    local settings7 = { [1] = "Desc", [2] = "Asc" }
    local randomResult = math.random(1, #settings7)
    randomResult = settings7[randomResult]
    for i = 1, clamp do
      local Url = ("https://games.roproxy.com/v1/games/%d/servers/Public?sortOrder=%s&limit=100"):format(game.PlaceId, randomResult)
      if Text5 ~= "" then Url = Url .. "&cursor=" .. Text5 end
      local entry14 = pcall
      local settings8 = { Url = Url, Method = "GET" }
      local response
      entry14, response = entry14(entry12, settings8)
      if not (entry14 and response and response.StatusCode == 200) then
        local formatResult = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&limit=100"):format(game.PlaceId, randomResult)
        Url = formatResult
        if Text5 ~= "" then Url = formatResult .. "&cursor=" .. Text5 end
        local pcallResult, entry16 = pcall(entry12, { Url = Url, Method = "GET" })
        response = entry16
        entry14 = pcallResult
      end
      if not entry14 or not response or response.StatusCode ~= 200 or not response.Body then break end
      local pcallResult2, entry17 = pcall(function() return sourceContext.httpServiceService2:JSONDecode(response.Body) end)
      if not pcallResult2 or not entry17 or not entry17.data or type(entry17.data) ~= "table" then break end
      for k, v in ipairs(entry17.data) do
        if v and v.id and v.id ~= game.JobId and v.playing and v.maxPlayers and v.playing <= math.max(1, v.maxPlayers - 2) and v.playing > 0 then
          table.insert(entries13, v)
          local text4 = tostring(v.id)
          text4 = entry13[text4]
          if not text4 then table.insert(entries12, v) end
        end
      end
      if not entry17.nextPageCursor or tostring(entry17.nextPageCursor) == "" then break end
      Text5 = tostring(entry17.nextPageCursor)
    end
    local entry18 = #entries12 > 0 and entries12 or entries13
    local entries14 = {}
    local entries15 = {}
    for i2 = 1, #entry18 do table.insert(entries15, i2) end
    for i3 = #entries15, 2, -1 do
      local random = math.random(1, i3)
      local entry19 = entries15[random]
      entries15[random] = entries15[i3]
      entries15[i3] = entry19
    end
    for i4 = 1, math.min(a, #entries15) do table.insert(entries14, entry18[entries15[i4]]) end
    return entries14
  end
  warn("[ServerHop] HTTP request function not available on this executor")
  return {}
end
sourceContext.count14 = 0
sourceContext.enabled21 = false
function serverHopToRandom()
  local timestamp2 = tick()
  if not sourceContext.enabled3 and not (timestamp2 - sourceContext.count14 < 5) then
    sourceContext.enabled3 = true
    sourceContext.count14 = timestamp2
    sourceContext.enabled2 = false
    if sourceContext.setAutoExecute then pcall(sourceContext.setAutoExecute) end
    local localPlayer2 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
    local entries12 = sourceContext.callback81(30)
    if entries12 and #entries12 > 0 then
      local JobId = game.JobId
      for k, v in ipairs(entries12) do
        local max = math.max
        max = max(1, (v.maxPlayers or 16) - 2)
        if v.id ~= JobId and v.playing and v.playing <= max then
          if sourceContext.sendReconnectKickWebhook2 then pcall(sourceContext.sendReconnectKickWebhook2, "Server Hop to " .. v.id) end
          local entry12 = pcall
          local id = v.id
          entry12(sourceContext.callback79, id, localPlayer2 and localPlayer2.Name)
          local enabled22 = false
          local entry13 = pcall
          function id()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, localPlayer2)
            enabled22 = true
          end
          entry13(id)
          if enabled22 then
            task.wait(6)
            return true
          end
        end
      end
    end
    if sourceContext.sendReconnectKickWebhook2 then pcall(sourceContext.sendReconnectKickWebhook2, "Server Hop (Random Teleport)") end
    pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer2) end)
    task.wait(6)
    return true
  end
  return false
end
if _G.__RAILHUB_TELEPORT_CONN then
  pcall(function() _G.__RAILHUB_TELEPORT_CONN:Disconnect() end)
  _G.__RAILHUB_TELEPORT_CONN = nil
end
if getgenv and getgenv().__RAILHUB_TELEPORT_CONN then
  pcall(function() getgenv().__RAILHUB_TELEPORT_CONN:Disconnect() end)
  getgenv().__RAILHUB_TELEPORT_CONN = nil
end
sourceContext.rAILHUBTELEPORTCONN = nil
pcall(function()
  sourceContext.rAILHUBTELEPORTCONN = game:GetService("TeleportService").TeleportInitFailed:Connect(function(a, b, c)
    local localPlayer3 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or game:GetService("Players").LocalPlayer
    if a == localPlayer3 or not a then
      warn("[ServerHop] Teleport failed (" .. tostring(b) .. "): " .. tostring(c))
      pcall(function() game:GetService("GuiService"):ClearError() end)
      if sourceContext.enabled21 then return end
      sourceContext.enabled21 = true
      sourceContext.enabled3 = true
      sourceContext.enabled2 = false
      task.spawn(function()
        task.wait(b == Enum.TeleportResult.IsTeleporting and 10 or b == Enum.TeleportResult.Failure and 8 or 7)
        sourceContext.enabled3 = false
        sourceContext.enabled21 = false
        sourceContext.enabled2 = true
        serverHopToRandom()
      end)
    end
  end)
  _G.__RAILHUB_TELEPORT_CONN = sourceContext.rAILHUBTELEPORTCONN
  if getgenv then getgenv().__RAILHUB_TELEPORT_CONN = sourceContext.rAILHUBTELEPORTCONN end
end)
function checkItemOnMap(a)
  local humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
  if humanoidRootPart then
    local Workspace = game.Workspace
    Workspace = Workspace:FindFirstChild("Item_Spawns")
    Workspace = Workspace and game.Workspace.Item_Spawns:FindFirstChild("Items")
    if Workspace then
      local a4 = sourceContext.callNormalizeItemName and sourceContext.callNormalizeItemName(a) or a
      for k, v in pairs(Workspace:GetChildren()) do
        local entry12, entry13, entry14 = sourceContext.callGetItemComponents(v)
        if entry12 and entry13 and sourceContext.callIsItemAvailable(v) and (sourceContext.callNormalizeItemName and sourceContext.callNormalizeItemName(entry14) == a4 or entry14 == a or v.Name and sourceContext.callNormalizeItemName(v.Name) == a4) then
          return true
        end
      end
      return false
    end
    return false
  end
  return false
end
function sourceContext.callback82(a)
  local enabled23
  if serverHopFarmEnabled then
    waitForGameLoad()
    local max = math.max(4.5, 5)
    local timestamp2 = tick()
    while true do
      if not (tick() - timestamp2 < max) then
        enabled23 = false
        break
      end
      if not serverHopFarmEnabled or not normalFarmOn then return false end
      if tick() - timestamp2 >= 5 and checkItemOnMap(a) then
        enabled23 = true
        break
      end
      local rootPart5 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
      if rootPart5 then
        local cFrame = getRandomSkyCFrame()
        sourceContext.callback75(cFrame.Position)
        local _YBA_directTP = getgenv()
        _YBA_directTP = _YBA_directTP._YBA_directTP
        if _YBA_directTP then
          rootPart5.CFrame = cFrame
          rootPart5.AssemblyLinearVelocity = Vector3.zero
          rootPart5.AssemblyAngularVelocity = Vector3.zero
        else
          sourceContext.moveCharacterTo2(cFrame)
        end
      end
      task.wait(0.4375)
    end
    if enabled23 then return true end
    for i = 1, 3 do
      local serverHopToRandomResult = serverHopToRandom()
      if serverHopToRandomResult then
        task.wait(10)
        return true
      end
      if i < 3 then task.wait(3) end
    end
    warn("[ServerHop] All retry attempts exhausted for item: " .. a)
    return false
  end
  return false
end
function sourceContext.callback83()
  local timestamp2, serverHopToRandomResult, player3, humanoidRootPart
  if waitForGameLoad() then
    timestamp2 = tick()
    local count8, count11 = 0, 50000
    while normalFarmOn do
      count8 = count8 + 1
      if 50000 < count8 then
        normalFarmOn = false
      else
        if 3600 < tick() - timestamp2 then timestamp2, count8 = tick(), 0 end
        if sourceContext.getgenv2() then sourceContext.callback27(0.5) end
        if sourceContext.callback28() or sourceContext.enabled9 or getgenv()._YBA_SellingBusy then
          task.wait(0.2)
        else
          if sourceContext.checkAndSellMax2 then pcall(sourceContext.checkAndSellMax2) end
          while normalFarmOn do
            if sourceContext.getgenv2() then
              sourceContext.callback27(0.5)
              break
            end
            if sourceContext.callback28() or sourceContext.enabled9 or getgenv()._YBA_SellingBusy then
              task.wait(0.2)
              break
            end
            count8 = count8 + 1
            if 50000 < count8 then
              normalFarmOn = false
              break
            end
            if sourceContext.checkAndSellMax2 then pcall(sourceContext.checkAndSellMax2) end
            local findNearestItemResult = findLuckyArrow() or findNearestItem(selectedFarmItems)
            if not findNearestItemResult then
              getgenv()._lastItemTarget = nil
              break
            end
            collectSingleItemNormal(findNearestItemResult)
            task.wait(0.05)
          end
          if normalFarmOn then
            randomSkyRoam(3.25)
            local function callback12()
              if sourceContext.checkAndSellMax2 then pcall(sourceContext.checkAndSellMax2) end
              return (findLuckyArrow() or findNearestItem(selectedFarmItems)) ~= nil
            end
            if not callback12() then
              if serverHopFarmEnabled then
                serverHopToRandomResult = serverHopToRandom()
                if serverHopToRandomResult then
                  task.wait(10)
                  continue
                end
                task.wait(4)
                continue
              end
              local environment6 = getgenv()
              if environment6._YBA_directTP then
                while normalFarmOn do
                  if serverHopFarmEnabled then
                    serverHopToRandom()
                    task.wait(10)
                    break
                  end
                  if callback12() then break end
                  local player4 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or sourceContext.player
                  local rootPart5 = player4 and player4.Character and player4.Character:FindFirstChild("HumanoidRootPart")
                  if rootPart5 then
                    rootPart5.CFrame = getRandomFarmRoamCFrame()
                    rootPart5.AssemblyLinearVelocity = Vector3.zero
                    rootPart5.AssemblyAngularVelocity = Vector3.zero
                    task.wait(0.1)
                  end
                  task.wait(0.3)
                end
              else
                while normalFarmOn do
                  if serverHopFarmEnabled then
                    serverHopToRandom()
                    task.wait(10)
                  elseif not callback12() then
                    player3 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or sourceContext.player
                    humanoidRootPart = player3 and player3.Character and player3.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                      tweenMoveTo(humanoidRootPart, getRandomFarmRoamCFrame(), moveTweenSpeed, function() return callback12() or not normalFarmOn or serverHopFarmEnabled end)
                      task.wait(0.5)
                      continue
                    end
                    task.wait(0.1)
                    continue
                  end
                end
              end
              continue
            end
          end
        end
      end
    end
    return
  end
  if sourceContext.callback14 and sourceContext.callback14() then
    if serverHopFarmEnabled then
      warn("[Farm] Game failed to load. Hopping server...")
      serverHopToRandom()
    else
      warn("[Farm] Game failed to load. Stopping farm.")
      normalFarmOn = false
    end
    return
  end
  normalFarmOn = false
end
sourceContext.spawnResult = nil
function startFarming()
  if sourceContext.callback14 and sourceContext.callback14() then
    getgenv()._YBA_startFarmingWaiting = false
    sourceContext.callback2("item farm STARTED (in main game)")
    if sourceContext.callWakeUpPhysicsAndSync then pcall(sourceContext.callWakeUpPhysicsAndSync) end
    if not normalFarmOn then
      pcall(function()
        local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
        local rootPart5 = character2 and character2:FindFirstChild("HumanoidRootPart")
        local humanoid3 = character2 and character2:FindFirstChildOfClass("Humanoid")
        if rootPart5 and humanoid3 and humanoid3.Health > 0 then getgenv()._YBA_FarmReturnPos = rootPart5.CFrame end
      end)
    end
    normalFarmOn = true
    sourceContext.callback34("IF", true)
    sourceContext.settings2.ItemFarmEnabled = true
    if not sourceContext.parent:FindFirstChild("WhitePad") then
      local new = Instance.new("Part")
      new.Size = Vector3.new(10000, 1, 10000)
      new.Position = Vector3.new(-139.164612, 60.740036, -372.339508)
      new.Anchored = true
      new.CanCollide = true
      new.Color = Color3.fromRGB(255, 255, 255)
      new.Transparency = 0.95
      new.Name = "WhitePad"
      new.Parent = sourceContext.parent
    end
    if not sourceContext.parent:FindFirstChild("UnderwhitePad") then
      local new2 = Instance.new("Part")
      new2.Size = Vector3.new(10000, 1, 10000)
      new2.Position = Vector3.new(0, -45, 0)
      new2.Anchored = true
      new2.CanCollide = true
      new2.Color = Color3.fromRGB(255, 255, 255)
      new2.Transparency = 0.5
      new2.Name = "UnderwhitePad"
      new2.Parent = sourceContext.parent
    end
    if sourceContext.spawnResult then
      pcall(task.cancel, sourceContext.spawnResult)
      sourceContext.spawnResult = nil
    end
    sourceContext.spawnResult = task.spawn(sourceContext.callback83)
    sourceContext.enableNoclip2("farm")
    return
  end
  if getgenv()._YBA_startFarmingWaiting then return end
  getgenv()._YBA_startFarmingWaiting = true
  task.spawn(function()
    local timestamp2 = tick()
    while tick() - timestamp2 < 180 do
      task.wait(1)
      if sourceContext.callback14 and sourceContext.callback14() then break end
    end
    getgenv()._YBA_startFarmingWaiting = false
    if sourceContext.callback14 and sourceContext.callback14() then startFarming() end
  end)
end
function stopFarming()
  local enabled23 = normalFarmOn == true
  normalFarmOn = false
  sourceContext.callback34("IF", false)
  sourceContext.settings2.ItemFarmEnabled = false
  sourceContext.callStopMoveTween()
  sourceContext.cleanupItemStick2()
  cleanupFarmPads()
  disableNoclip("farm")
  if not sourceContext.callback35 or not sourceContext.callback35("PNC", false) then
    disableNoclip("main")
    disableNoclip(true)
    local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
    restoreCharacterCollisions(character2)
  end
  if sourceContext.spawnResult then
    pcall(task.cancel, sourceContext.spawnResult)
    sourceContext.spawnResult = nil
  end
  if enabled23 then
    local cFrame = getgenv and getgenv()._YBA_FarmReturnPos
    if getgenv then getgenv()._YBA_FarmReturnPos = nil end
    if cFrame then
      task.spawn(function()
        task.wait(0.3)
        pcall(function()
          if sourceContext.callback14 and sourceContext.callback14() and not sourceContext.getgenv2() then
            local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
            local rootPart5 = character2 and character2:FindFirstChild("HumanoidRootPart")
            if rootPart5 then
              if getgenv()._YBA_directTP then
                rootPart5.CFrame = cFrame
                if sourceContext.callZeroRootVelocity then sourceContext.callZeroRootVelocity(rootPart5) end
              elseif sourceContext.moveCharacterTo2 then sourceContext.moveCharacterTo2(cFrame) else rootPart5.CFrame = cFrame end
            end
          end
        end)
      end)
    end
  end
end
pcall(function()
  local entry12 = sourceContext.callback3 and sourceContext.callback3() or sourceContext.player or sourceContext.player
  if entry12 then
    entry12.CharacterAdded:Connect(function(_)
      if sourceContext.callback14 and sourceContext.callback14() then
        sourceContext.callStopMoveTween()
        sourceContext.cleanupItemStick2()
        local enabled23 = normalFarmOn == true or sourceContext.callback35 and sourceContext.callback35("PNC", false) == true
        if enabled23 then task.defer(function() sourceContext.enableNoclip2(normalFarmOn and "farm" or "main") end) else task.defer(function() disableNoclip(true) end) end
        if normalFarmOn then
          task.wait(0.5)
          sourceContext.enableNoclip2("farm")
          if sourceContext.spawnResult then
            pcall(task.cancel, sourceContext.spawnResult)
            sourceContext.spawnResult = nil
          end
          sourceContext.spawnResult = task.spawn(sourceContext.callback83)
        end
        return
      end
      task.spawn(function()
        local timestamp2 = tick()
        while tick() - timestamp2 < 120 do
          task.wait(1)
          if sourceContext.callback14 and sourceContext.callback14() then break end
        end
        if normalFarmOn and sourceContext.callback14 and sourceContext.callback14() then
          task.wait(0.5)
          sourceContext.enableNoclip2("farm")
          if sourceContext.spawnResult then
            pcall(task.cancel, sourceContext.spawnResult)
            sourceContext.spawnResult = nil
          end
          sourceContext.spawnResult = task.spawn(sourceContext.callback83)
        end
      end)
    end)
  end
end)
sourceContext._G3 = _G
sourceContext.rAILhubFixCollision = {
  itemOptions = itemOptions, sellSpecificOptions = sellSpecificOptions,
  sellBlacklistOptions = sellBlacklistOptions, selectedFarmItems = selectedFarmItems,
  sellBlacklist = sellBlacklist, startFarming = startFarming, stopFarming = stopFarming,
  cleanupItemStick = function() if sourceContext.cleanupItemStick2 then sourceContext.cleanupItemStick2() end end,
  cleanupFarmPads = function() if cleanupFarmPads then cleanupFarmPads() end end,
  enableInstantPickup = enableInstantPickup, disableInstantPickup = disableInstantPickup,
  enableNoclip = sourceContext.enableNoclip2, disableNoclip = disableNoclip,
  enableNoclipState = enableNoclipState, disableNoclipState = disableNoclipState,
  restoreCollisions = restoreCharacterCollisions, isNoclipActive = isAnyNoclipActive,
  setFarmMethod = function(InstantMethod) getgenv().InstantMethod = InstantMethod end,
  getFarmMethod = function() return getgenv().InstantMethod end, setAutoSellMax = function(a) autoSellMax = a end,
  getAutoSellMax = function() return autoSellMax end,
  setAutoBuyLuckyArrow = function(a) autoBuyLuckyArrow = a end,
  getAutoBuyLuckyArrow = function() return autoBuyLuckyArrow end, sellAll = sellAll,
  sellAllSelected = sellAllSelected, sellAllWorthless = sellAllWorthless, sellInventory = sellInventory,
  checkAndSellMax = sourceContext.checkAndSellMax2, sellItem = sellItem,
  enableAntiAfk = sourceContext.enableAntiAfk, disableAntiAfk = sourceContext.disableAntiAfk,
  enableServerHopFarm = function() serverHopFarmEnabled = true end,
  disableServerHopFarm = function() serverHopFarmEnabled = false end,
  isServerHopFarmEnabled = function() return serverHopFarmEnabled end,
}
sourceContext._G3.YBAItemFarm = sourceContext.rAILhubFixCollision
if getgenv then getgenv().YBAItemFarm = _G.YBAItemFarm end
sourceContext.getgenv7 = getgenv()
function sourceContext.rAILhubFixCollision()
  sourceContext.notify("YBA Script", "Fixing collision issues...")
  disableNoclip(true)
  if _G.YBAItemFarm and _G.YBAItemFarm.disableNoclip then _G.YBAItemFarm.disableNoclip(true) end
  if sourceContext.callback34 then sourceContext.callback34("PNC", false) end
  restoreCharacterCollisions(sourceContext.player.Character or sourceContext.player.Character)
  sourceContext.notify("YBA Script", "Collision restored & Noclip reset.")
end
sourceContext.getgenv7.RAILhub_FixCollision = sourceContext.rAILhubFixCollision
getgenv()._YBA_Exports = {
  findNearestItem = findNearestItem, collectSingleItemNormal = collectSingleItemNormal,
  checkAndSellMax = sourceContext.checkAndSellMax2, enableNoclip = sourceContext.enableNoclip2,
  disableNoclip = disableNoclip, enableNoclipState = enableNoclipState, disableNoclipState = disableNoclipState,
  restoreCollisions = restoreCharacterCollisions, isNoclipActive = isAnyNoclipActive,
  cleanupItemStick = sourceContext.cleanupItemStick2, moveCharacterTo = sourceContext.moveCharacterTo2,
  activatePrompt = sourceContext.activatePrompt2, getRandomFarmRoamCFrame = getRandomFarmRoamCFrame,
  travelToInstant = travelToInstant, instantTravelTo = instantTravelTo,
  collectItemLikeNormalFarm = collectItemLikeNormalFarm, farmItemByName = farmItemByName,
  serverHopToRandom = serverHopToRandom, waitForGameLoad = waitForGameLoad, randomSkyRoam = randomSkyRoam,
  maxLimits = sourceContext.maxLimits2,
}
sourceContext.getgenv7 = "getRandomFarmRoamCFrame"
sourceContext.environment2.getRandomFarmRoamCFrame = getRandomFarmRoamCFrame
sourceContext.environment2.waitForGameLoad = waitForGameLoad
sourceContext.environment2.getRandomSkyCFrame = getRandomSkyCFrame
sourceContext.environment2.cleanupFarmPads = cleanupFarmPads
sourceContext.environment2.randomSkyRoam = randomSkyRoam
sourceContext.environment2.travelToInstant = travelToInstant
sourceContext.environment2.instantTravelTo = instantTravelTo
sourceContext.environment2.collectSingleItemNormal = collectSingleItemNormal
sourceContext.environment2.collectItemLikeNormalFarm = collectItemLikeNormalFarm
sourceContext.environment2.farmItemByName = farmItemByName
sourceContext.environment2.findNearestItem = findNearestItem
sourceContext.environment2.findLuckyArrow = findLuckyArrow
sourceContext.environment2.serverHopToRandom = serverHopToRandom
sourceContext.environment2.checkItemOnMap = checkItemOnMap
sourceContext.environment2.startFarming = startFarming
sourceContext.environment2.stopFarming = stopFarming
function sourceContext.environment2.serverHopFarmEnabled() return serverHopFarmEnabled end
function sourceContext.environment2.getServerHopFarmEnabled() return serverHopFarmEnabled end
sourceContext.enabled23 = false
pcall(function()
  if type(isfile) == "function" and isfile(sourceContext.environment .. "/NO_HOOKS.txt") then sourceContext.enabled23 = true end
  if getgenv and getgenv().RAILHUB_NO_HOOKS then sourceContext.enabled23 = true end
end)
if sourceContext.enabled23 then sourceContext.callback2("NO_HOOKS on: skipping bypass hooks") end
sourceContext.pcallResult = pcall(function()
  if sourceContext.enabled23 then error("hooks disabled by NO_HOOKS.txt") end
  local oldMagnitude2 = hookmetamethod(Vector3.new(), "__index", newcclosure(function(a, b)
    local text4 = tostring(getcallingscript())
    local checkcallerResult = checkcaller()
    if not checkcallerResult and b == "magnitude" and text4 == "ItemSpawn" then return 0 end
    return oldMagnitude(a, b)
  end))
  local oldNc2 = hookmetamethod(game, "__namecall", newcclosure(function(a, ...)
    local getnamecallmethodResult = getnamecallmethod()
    local settings7 = { ... }
    if not checkcaller() and rawequal(a.Name, "Returner") and rawequal(settings7[1], "idklolbrah2de") then return "  ___XP DE KEY" end
    return oldNc(a, ...)
  end))
  pcall(function()
    local oldConcat = hookmetamethod(game, "__concat", newcclosure(function(a, b)
      return (typeof(a) == "Instance" and a.Name or tostring(a)) .. (typeof(b) == "Instance" and b.Name or tostring(b))
    end))
    getgenv().oldConcat = oldConcat
  end)
  getgenv().oldMagnitude = oldMagnitude2
  getgenv().oldNc = oldNc2
  task.wait(0.1)
end)
if sourceContext.pcallResult then
  local getgenv10 = sourceContext.notify
  sourceContext.notify("YBA Script", "Anti-teleport bypass loaded successfully")
  getgenv10 = getgenv
  getgenv10 = getgenv10()
  getgenv10._YBA_bypassSuccess = true
  getgenv10 = if sourceContext.callback35 then sourceContext.callback35("FarmTravelMethod") else sourceContext.callback35
  if getgenv10 then getgenv()._YBA_directTP = getgenv10 == "Teleport" else getgenv()._YBA_directTP = sourceContext.callback35("UseTeleportFarm", true) end
else
  sourceContext.notify("YBA Script", "Bypass failed - using Tween movement to avoid server kick")
  getgenv()._YBA_bypassSuccess = false
  getgenv()._YBA_directTP = false
end
sourceContext.httpsIiliIoQaO4DoxText, sourceContext.rAILhubAssetsText = "https://iili.io/qaO4Dox.png", "RAILhubAssets"
sourceContext.normalizedText2 = tostring("https://iili.io/qaO4Dox.png"):gsub("[^%w]", "_")
sourceContext.match = tostring("https://iili.io/qaO4Dox.png")
sourceContext.match = sourceContext.match.match(sourceContext.match, "%.([%w]+)$")
sourceContext.match = not (sourceContext.match and sourceContext.match ~= "") and "png" or sourceContext.match
sourceContext.entry25, sourceContext.match2 = sourceContext.normalizedText2, sourceContext.match
sourceContext.match3 = "RAILhubAssets" .. "/menu_header_image_" .. sourceContext.entry25 .. "." .. sourceContext.match
function sourceContext.callback84(Url)
  local rawgetResult = rawget(_G, "request")
  rawgetResult = rawgetResult or rawget(_G, "http_request") or syn and syn.request
  if type(rawgetResult) == "function" then
    local pcallResult, response2 = pcall(rawgetResult, { Url = Url, Method = "GET" })
    local body = pcallResult and response2 and (response2.Body or response2.body)
    if type(body) == "string" and body ~= "" then return body end
  end
  local pcallResult2, entry12 = pcall(game.HttpGet, game, Url)
  if not (pcallResult2 and type(entry12) == "string" and entry12 ~= "") then return end
  return entry12
end
function sourceContext.entry25(a)
  local typeResult2 = type(getcustomasset)
  typeResult2 = typeResult2 == "function" and getcustomasset or type(getsynasset) == "function" and getsynasset
  if not typeResult2 then return end
  local pcallResult, entry12 = pcall(typeResult2, a)
  if not (pcallResult and type(entry12) == "string" and entry12 ~= "") then return end
  return entry12
end
function sourceContext._YBA_resolveMenuHeaderImage()
  local rawgetResult = rawget(_G, "MenuHeaderImage")
  local rawgetResult2 = rawget(_G, "MenuHeaderImageUrl")
  if type(rawgetResult) == "string" and rawgetResult ~= "" and rawgetResult2 == "https://iili.io/qaO4Dox.png" then
    if rawgetResult == "https://iili.io/qaO4Dox.png" then return rawgetResult end
    if type(isfile) == "function" and isfile(sourceContext.match3) then return rawgetResult end
    if type(readfile) == "function" and pcall(readfile, sourceContext.match3) then return rawgetResult end
  end
  local MenuHeaderImage = "https://iili.io/qaO4Dox.png"
  if type(makefolder) == "function" then pcall(makefolder, "RAILhubAssets") end
  local entry12 = nil
  local type2 = type(readfile)
  if type2 == "function" then
    local entry13
    if entry13 then
      local entry14
      entry12 = if type(entry14) == "string" then #entry14 > 20 else false
    else
      entry12 = entry13
    end
  elseif type(isfile) == "function" then entry12 = isfile(sourceContext.match3) == true end
  type2 = type
  type2 = type2(writefile)
  local entry16
  if type2 ~= "function" or entry12 then
    entry16 = entry12
  else
    entry16 = entry12
    for i = 1, 3 do
      local entry17 = sourceContext.callback84("https://iili.io/qaO4Dox.png")
      if type(entry17) == "string" and #entry17 > 20 then
        pcall(writefile, sourceContext.match3, entry17)
        entry16 = true
        break
      end
      task.wait(0.2)
    end
  end
  if entry16 then
    local entry18 = sourceContext.entry25(sourceContext.match3)
    if type(entry18) == "string" and entry18 ~= "" then
      MenuHeaderImage = entry18
    elseif type(writefile) == "function" then
      local entry19 = sourceContext.callback84("https://iili.io/qaO4Dox.png")
      if type(entry19) == "string" and #entry19 > 20 then
        pcall(writefile, sourceContext.match3, entry19)
        local entry20 = sourceContext.entry25(sourceContext.match3)
        if type(entry20) == "string" and entry20 ~= "" then MenuHeaderImage = entry20 end
      end
    end
  end
  _G.MenuHeaderImage = MenuHeaderImage
  _G.MenuHeaderImageUrl = "https://iili.io/qaO4Dox.png"
  return MenuHeaderImage
end
getgenv()._YBA_resolveMenuHeaderImage = sourceContext._YBA_resolveMenuHeaderImage
sourceContext.currentCamera = sourceContext.parent.CurrentCamera
sourceContext.count15 = sourceContext.currentCamera and sourceContext.currentCamera.ViewportSize.X or 1920
sourceContext.count16 = sourceContext.currentCamera and sourceContext.currentCamera.ViewportSize.Y or 1080
if sourceContext.count15 == 0 or sourceContext.count16 == 0 then sourceContext.count15, sourceContext.count16 = 1920, 1080 end
sourceContext.count17 = sourceContext.count15 * 0.95
sourceContext.count18 = sourceContext.count16 * 0.95
sourceContext.clamp = math.clamp(math.min(sourceContext.count17 / 868, sourceContext.count18 / 650), 0.5, 1)
sourceContext.entry26 = sourceContext.callback35
sourceContext.entry26 = sourceContext.callback35("MenuScale", sourceContext.clamp)
sourceContext.entry27 = sourceContext.callback35
sourceContext.entry27 = sourceContext.callback35("MenuScale")
if sourceContext.entry27 == nil then sourceContext.callback34("MenuScale", sourceContext.entry26) end
sourceContext.RAILhubWindow = sourceContext.entry5.Window(sourceContext.entry5, {
  Title = "RAIL|hub", Subtitle = "YBA", Size = UDim2.fromOffset(868, 650), DragStyle = 2, ShowUserInfo = true,
  Keybind = Enum.KeyCode.RightControl, AcrylicBlur = true,
})
sourceContext.entry27 = type
sourceContext.entry27 = sourceContext.entry27(sourceContext.RAILhubWindow.SetScale)
if sourceContext.entry27 == "function" then sourceContext.RAILhubWindow.SetScale(sourceContext.RAILhubWindow, sourceContext.entry26) end
getgenv().RAILhubWindow = sourceContext.RAILhubWindow
_G.RAILhubWindow = sourceContext.RAILhubWindow
if sourceContext.callback35 and sourceContext.callback35("UI_Open", true) == false then pcall(function() sourceContext.RAILhubWindow:SetState(false) end) end
sourceContext.Parent2 = nil
do
  pcall(function()
    local savedUIPos = sourceContext.callback35 and sourceContext.callback35("UI_Pos")
    local base = sourceContext.RAILhubWindow and (sourceContext.RAILhubWindow.Frame or sourceContext.RAILhubWindow.Base)
    if type(savedUIPos) == "table" and #savedUIPos == 4 and base then
      local count8 = tonumber(savedUIPos[1]) or 0.5
      local clamp = tonumber(savedUIPos[2]) or 0
      local count11 = tonumber(savedUIPos[3]) or 0.5
      local clamp2 = tonumber(savedUIPos[4]) or 0
      local currentCamera = workspace and workspace.CurrentCamera
      local count13 = currentCamera and currentCamera.ViewportSize.X or 1920
      local count15 = currentCamera and currentCamera.ViewportSize.Y or 1080
      if count13 and count13 > 0 then clamp = math.clamp(clamp, -count13 / 2, count13 / 2) end
      if count15 and count15 > 0 then clamp2 = math.clamp(clamp2, -count15 / 2, count15 / 2) end
      base.Position = UDim2.new(count8, clamp, count11, clamp2)
    end
  end)
  do
    local GetState2, concat2 = nil, nil
    task.spawn(function()
      while true do
        task.wait(3)
        pcall(function()
          if not sourceContext.RAILhubWindow then return end
          if type(sourceContext.RAILhubWindow.GetState) == "function" then
            local RAILhubWindow2 = sourceContext.RAILhubWindow
            local GetState = RAILhubWindow2.GetState
            GetState = GetState(RAILhubWindow2) and true or false
            if GetState ~= GetState2 then
              GetState2 = GetState
              sourceContext.callback34("UI_Open", GetState)
            end
          end
          local base = sourceContext.RAILhubWindow.Frame or sourceContext.RAILhubWindow.Base
          if base and base.Position then
            local Position = base.Position
            local concat = table.concat({ tostring(Position.X.Scale), tostring(Position.X.Offset), tostring(Position.Y.Scale), tostring(Position.Y.Offset) }, ",")
            if concat ~= concat2 then
              concat2 = concat
              local entries12 = {}
              local Scale = Position.X.Scale
              local Offset = Position.X.Offset
              local Scale2 = Position.Y.Scale
              local Offset2 = Position.Y.Offset
              entries12[1] = Scale
              entries12[2] = Offset
              entries12[3] = Scale2
              entries12[4] = Offset2
              Scale = nil
              Offset = nil
              Scale2 = nil
              Offset2 = nil
              sourceContext.callback34("UI_Pos", entries12)
            end
          end
        end)
      end
    end)
  end
  task.spawn(function()
    task.wait(0.5)
    pcall(function()
      if sourceContext.RAILhubWindow and type(sourceContext.RAILhubWindow.GetState) == "function" and type(sourceContext.RAILhubWindow.SetState) == "function" and sourceContext.RAILhubWindow:GetState() then
        sourceContext.RAILhubWindow:SetState(false)
      end
    end)
    local timestamp2 = tick()
    while tick() - timestamp2 < 300 do
      task.wait(1)
      if sourceContext.callback14 and sourceContext.callback14() then break end
    end
    if sourceContext.callback14 and sourceContext.callback14() then
      pcall(function()
        if sourceContext.RAILhubWindow and type(sourceContext.RAILhubWindow.GetState) == "function" and type(sourceContext.RAILhubWindow.SetState) == "function" then
          local enabled24 = true
          pcall(function() enabled24 = sourceContext.callback35("UI_Open", true) ~= false end)
          if sourceContext.RAILhubWindow:GetState() ~= enabled24 then sourceContext.RAILhubWindow:SetState(enabled24) end
        end
      end)
    end
  end)
  local function addStaticKeyLabels()
    local guiRoot = gethui and gethui() or game:GetService("CoreGui")
    local userFrame
    for _, gui in ipairs(guiRoot:GetChildren()) do
      if gui:IsA("ScreenGui") and (gui.Name == "MacLib" or gui:FindFirstChild("Base", true)) then
        userFrame = gui:FindFirstChild("UserAndDisplayFrame", true)
        if userFrame then break end
      end
    end
    if not userFrame then return false end
    local displayName = userFrame:FindFirstChild("DisplayName")
    local username = userFrame:FindFirstChild("Username")
    local fontSource = displayName or username
    if not fontSource then return false end
    userFrame.AutomaticSize = Enum.AutomaticSize.Y
    userFrame.ClipsDescendants = false
    if displayName then displayName.LayoutOrder = 1 end
    if username then
      username.Visible = false
      username.Size = UDim2.fromScale(0, 0)
    end
    local labels = {
      { name = "KeyTypeLabel", text = "key type: Cracked by piscar ", order = 2 },
      { name = "KeyTimeLabel", text = "time: lifetime", order = 3 },
    }
    for _, settings in ipairs(labels) do
      local label = userFrame:FindFirstChild(settings.name) or Instance.new("TextLabel")
      label.Name = settings.name
      label.LayoutOrder = settings.order
      label.AutomaticSize = Enum.AutomaticSize.XY
      label.BackgroundTransparency = 1
      label.BorderSizePixel = 0
      label.Size = UDim2.fromScale(1, 0)
      label.Font = fontSource.Font
      if fontSource.FontFace then label.FontFace = fontSource.FontFace end
      label.TextSize = 11
      label.TextColor3 = Color3.fromRGB(175, 175, 175)
      label.TextTransparency = 0.2
      label.TextXAlignment = Enum.TextXAlignment.Left
      label.TextYAlignment = Enum.TextYAlignment.Top
      label.Text = settings.text
      label.Parent = userFrame
    end
    return true
  end
  task.spawn(function()
    for _ = 1, 40 do
      local ok, ready = pcall(addStaticKeyLabels)
      if ok and ready then return end
      task.wait(0.2)
    end
  end)
  sourceContext.Parent2 = Instance.new("ScreenGui")
  sourceContext.Parent2.Name = "RAILhubToggle"
  sourceContext.Parent2.ResetOnSpawn = false
  sourceContext.Parent2.IgnoreGuiInset = true
  sourceContext.Parent2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  sourceContext.Parent2.DisplayOrder = 50
  if not (pcall(function() sourceContext.Parent2.Parent = gethui and gethui() or game:GetService("CoreGui") end) and sourceContext.Parent2.Parent) then
    pcall(function()
      sourceContext.Parent2.Parent = sourceContext.callback4() or sourceContext.player and (sourceContext.player:FindFirstChild("PlayerGui") or sourceContext.player.WaitForChild and sourceContext.player:WaitForChild("PlayerGui", 5))
    end)
  end
end
sourceContext.yBARUNTIME2.Guis[#sourceContext.yBARUNTIME2.Guis + 1] = sourceContext.Parent2
sourceContext.Parent = Instance.new("ImageButton")
sourceContext.Parent.Parent = sourceContext.Parent2
sourceContext.Parent.Size = UDim2.fromOffset(55, 55)
sourceContext.Parent.Position = UDim2.new(0.15, 0, 0.15, 0)
sourceContext.Parent.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sourceContext.Parent.BorderSizePixel = 0
sourceContext.Parent.Image = sourceContext._YBA_resolveMenuHeaderImage and sourceContext._YBA_resolveMenuHeaderImage() or getgenv()._YBA_resolveMenuHeaderImage and getgenv()._YBA_resolveMenuHeaderImage() or "https://iili.io/qaO4Dox.png"
sourceContext.Parent.ImageColor3 = Color3.fromRGB(235, 235, 235)
sourceContext.Parent.Active = true
sourceContext.new = Instance.new("UICorner")
sourceContext.new.CornerRadius = UDim.new(0, 10)
sourceContext.new.Parent = sourceContext.Parent
sourceContext.enabled25, sourceContext.enabled26 = false, false
sourceContext.a4, sourceContext.position, sourceContext.position2 = nil, nil, nil
sourceContext.InputBegan = sourceContext.Parent.InputBegan
sourceContext.InputBegan.Connect(sourceContext.InputBegan, function(a)
  if a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch then
    sourceContext.enabled25 = true
    sourceContext.enabled26 = false
    sourceContext.position = a.Position
    sourceContext.position2 = sourceContext.Parent.Position
    a.Changed:Connect(function() if a.UserInputState == Enum.UserInputState.End then sourceContext.enabled25 = false end end)
  end
end)
sourceContext.InputBegan = "InputChanged"
sourceContext.inputChanged = sourceContext.Parent.InputChanged
sourceContext.inputChanged.Connect(sourceContext.inputChanged, function(a)
  if a.UserInputType == Enum.UserInputType.MouseMovement or a.UserInputType == Enum.UserInputType.Touch then sourceContext.a4 = a end
end)
sourceContext.inputChanged = "InputChanged"
sourceContext.inputChanged2 = sourceContext.userInputServiceService.InputChanged
sourceContext.inputChanged2.Connect(sourceContext.inputChanged2, function(a)
  if a == sourceContext.a4 and sourceContext.enabled25 then
    local entry16 = a.Position - sourceContext.position
    if entry16.Magnitude > 5 then
      sourceContext.enabled26 = true
      sourceContext.Parent.Position = UDim2.new(sourceContext.position2.X.Scale, sourceContext.position2.X.Offset + entry16.X, sourceContext.position2.Y.Scale, sourceContext.position2.Y.Offset + entry16.Y)
    end
  end
end)
sourceContext.inputChanged2 = "MouseButton1Click"
sourceContext.mouseButton1Click = sourceContext.Parent.MouseButton1Click
sourceContext.mouseButton1Click.Connect(sourceContext.mouseButton1Click, function()
  if sourceContext.enabled26 then
    sourceContext.enabled26 = false
    return
  end
  if sourceContext.RAILhubWindow then
    if type(sourceContext.RAILhubWindow.SetState) == "function" and type(sourceContext.RAILhubWindow.GetState) == "function" then
      sourceContext.RAILhubWindow:SetState(not sourceContext.RAILhubWindow:GetState())
      return
    end
    if type(sourceContext.RAILhubWindow.Toggle) == "function" then
      sourceContext.RAILhubWindow:Toggle()
      return
    end
    if type(sourceContext.RAILhubWindow.ToggleUI) == "function" then
      sourceContext.RAILhubWindow:ToggleUI()
      return
    end
    if type(sourceContext.RAILhubWindow.SetVisible) == "function" then
      sourceContext.RAILhubWindow:SetVisible(sourceContext.RAILhubWindow.Visible ~= true)
      return
    end
  end
  local coreGuiService = gethui and gethui() or game:GetService("CoreGui")
  local rAILHubText = sourceContext.RAILhubWindow and sourceContext.RAILhubWindow.Settings and sourceContext.RAILhubWindow.Settings.Title or "RAIL|hub"
  for k2, v2 in ipairs(coreGuiService:GetChildren()) do
    if v2:IsA("ScreenGui") then
      for k, v in ipairs(v2:GetDescendants()) do
        if v:IsA("TextLabel") and v.Text == rAILHubText then
          v2.Enabled = not v2.Enabled
          return
        end
      end
    end
  end
  if sourceContext.RAILhubWindow and sourceContext.RAILhubWindow.Frame then sourceContext.RAILhubWindow.Frame.Visible = not sourceContext.RAILhubWindow.Frame.Visible end
end)
sourceContext.enabled27 = false
sourceContext.position3, sourceContext.position4 = nil, nil
sourceContext.InputBegan2 = sourceContext.Parent.InputBegan
sourceContext.InputBegan2.Connect(sourceContext.InputBegan2, function(a)
  if a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch then
    sourceContext.enabled27 = true
    sourceContext.position3 = a.Position
    sourceContext.position4 = sourceContext.Parent.Position
  end
end)
sourceContext.InputBegan2 = "InputChanged"
sourceContext.inputChanged3 = sourceContext.userInputServiceService.InputChanged
sourceContext.inputChanged3.Connect(sourceContext.inputChanged3, function(a)
  if not sourceContext.enabled27 then return end
  if a.UserInputType == Enum.UserInputType.MouseMovement or a.UserInputType == Enum.UserInputType.Touch then
    local entry16 = a.Position - sourceContext.position3
    sourceContext.Parent.Position = UDim2.new(sourceContext.position4.X.Scale, sourceContext.position4.X.Offset + entry16.X, sourceContext.position4.Y.Scale, sourceContext.position4.Y.Offset + entry16.Y)
  end
end)
sourceContext.inputChanged3 = "InputEnded"
sourceContext.inputEnded = sourceContext.userInputServiceService.InputEnded
sourceContext.inputEnded.Connect(sourceContext.inputEnded, function(a)
  if a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch then sourceContext.enabled27 = false end
end)
sourceContext.globalSettings = {}
sourceContext.RAILhubWindow2 = sourceContext.RAILhubWindow
sourceContext.globalSetting = sourceContext.RAILhubWindow2.GlobalSetting
sourceContext.uITransparencyOptions = { Name = "UI Transparency" }
sourceContext.callback95 = sourceContext.callback35("UIBlur", false)
sourceContext.uITransparencyOptions.Default = sourceContext.callback95
function sourceContext.callback95(a)
  sourceContext.callback34("UIBlur", a)
  sourceContext.RAILhubWindow:SetAcrylicBlurState(a)
end
sourceContext.uITransparencyOptions.Callback = sourceContext.callback95
sourceContext.globalSettings.UIBlurToggle = sourceContext.globalSetting(sourceContext.RAILhubWindow2, sourceContext.uITransparencyOptions)
sourceContext.uITransparencyOptions = "GlobalSetting"
sourceContext.RAILhubWindow2 = sourceContext.RAILhubWindow
sourceContext.globalSetting = sourceContext.RAILhubWindow2.GlobalSetting
sourceContext.userInfoOptions = { Name = "User Info" }
sourceContext.callback95 = sourceContext.callback35
sourceContext.callback95 = sourceContext.callback35("ShowUserInfo", true)
sourceContext.userInfoOptions.Default = sourceContext.callback95
function sourceContext.callback95(a)
  sourceContext.callback34("ShowUserInfo", a)
  if typeof(sourceContext.RAILhubWindow.SetUserInfoState) == "function" then
    sourceContext.RAILhubWindow:SetUserInfoState(a)
  elseif typeof(sourceContext.RAILhubWindow.ToggleUserInfo) == "function" then
    sourceContext.RAILhubWindow:ToggleUserInfo(a)
  else
    pcall(function()
      if sourceContext.RAILhubWindow.Settings then sourceContext.RAILhubWindow.Settings.ShowUserInfo = a end
      if sourceContext.RAILhubWindow.Frame and sourceContext.RAILhubWindow.Frame:FindFirstChild("Bottom") then
        local Bottom = sourceContext.RAILhubWindow.Frame.Bottom
        for k, v in pairs(Bottom:GetChildren()) do
          if v:IsA("ImageLabel") or v:IsA("ImageButton") then
            v.Visible = a
          elseif v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
            v.Visible = a
          elseif v:IsA("Frame") and (v.Name:find("User") or v.Name:find("Avatar") or v.Name:find("Profile")) then v.Visible = a end
        end
        local FindFirstChild = Bottom.FindFirstChild
        FindFirstChild = FindFirstChild(Bottom, "BottomLeft") or Bottom:FindFirstChild("Left")
        if FindFirstChild then FindFirstChild.Visible = a end
        if a then
          Bottom.Visible = true
        else
          local enabled28 = true
          for k2, v2 in pairs(Bottom:GetChildren()) do
            if v2.Visible then
              enabled28 = false
              break
            end
          end
          if enabled28 then Bottom.Visible = false end
        end
      end
      if sourceContext.RAILhubWindow.Frame then
        local settings7 = { [1] = sourceContext.RAILhubWindow.Frame }
        while #settings7 > 0 do
          local remove = table.remove(settings7)
          for k3, v3 in pairs(remove:GetChildren()) do
            local name2 = v3.Name
            name2 = name2:find("User")
            if (name2 or v3.Name:find("Avatar") or v3.Name:find("Profile") or v3.Name:find("Name")) and (v3:IsA("Frame") or v3:IsA("ImageLabel") or v3:IsA("TextLabel") or v3:IsA("ViewportFrame")) then
              v3.Visible = a
            end
            table.insert(settings7, v3)
          end
        end
      end
    end)
  end
end
sourceContext.userInfoOptions.Callback = sourceContext.callback95
sourceContext.globalSettings.ShowUserInfo = sourceContext.globalSetting(sourceContext.RAILhubWindow2, sourceContext.userInfoOptions)
sourceContext.userInfoOptions = "GlobalSetting"
sourceContext.RAILhubWindow2 = sourceContext.RAILhubWindow
sourceContext.globalSetting = sourceContext.RAILhubWindow2.GlobalSetting
sourceContext.settings7 = { Name = "Watermark" }
sourceContext.callback95 = sourceContext.callback35
sourceContext.callback95 = sourceContext.callback35("ShowWatermark", true)
sourceContext.settings7.Default = sourceContext.callback95
function sourceContext.callback95(Enabled)
  sourceContext.callback34("ShowWatermark", Enabled)
  if _G.CustomWatermark then _G.CustomWatermark.Enabled = Enabled end
end
sourceContext.settings7.Callback = sourceContext.callback95
sourceContext.globalSettings.Watermark = sourceContext.globalSetting(sourceContext.RAILhubWindow2, sourceContext.settings7)
sourceContext._G2 = _G
sourceContext.globalSetting = "allvars"
if sourceContext._G2.allvars and _G.allvars._rt then _G.allvars._rt.globalSettings = sourceContext.globalSettings end
task.spawn(function()
  if _G.CustomWatermark then return end
  local customWatermark
  do
    customWatermark = Instance.new("ScreenGui")
    customWatermark.Name = "RAILhubWatermark"
    customWatermark.ResetOnSpawn = false
    customWatermark.IgnoreGuiInset = true
    customWatermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local pcallResult = pcall(function() customWatermark.Parent = gethui and gethui() or game:GetService("CoreGui") end)
    if not (pcallResult and customWatermark.Parent) then
      pcall(function()
        customWatermark.Parent = sourceContext.callback4() or sourceContext.player and (sourceContext.player:FindFirstChild("PlayerGui") or sourceContext.player.WaitForChild and sourceContext.player:WaitForChild("PlayerGui", 5))
      end)
    end
  end
  sourceContext.yBARUNTIME2.Guis[#sourceContext.yBARUNTIME2.Guis + 1] = customWatermark
  local Parent = Instance.new("Frame")
  Parent.Name = "WatermarkFrame"
  local instance
  Parent.Position = UDim2.new(0, 15, 0, 60)
  Parent.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
  Parent.BorderSizePixel = 0
  Parent.AutomaticSize = Enum.AutomaticSize.X
  Parent.Size = UDim2.new(0, 0, 0, 28)
  Parent.Parent = customWatermark
  instance = Instance
  instance = instance.new
  instance = instance("UICorner")
  local CornerRadius
  instance.CornerRadius = UDim.new(0, 6)
  instance.Parent = Parent
  CornerRadius = Instance
  CornerRadius = CornerRadius.new
  CornerRadius = CornerRadius("UIPadding")
  local instance2
  CornerRadius.PaddingLeft = UDim.new(0, 10)
  CornerRadius.PaddingRight = UDim.new(0, 10)
  CornerRadius.PaddingTop = UDim.new(0, 4)
  CornerRadius.PaddingBottom = UDim.new(0, 4)
  CornerRadius.Parent = Parent
  instance2 = Instance
  instance2 = instance2.new
  instance2 = instance2("UIStroke")
  instance2.Thickness = 1
  local parent3
  instance2.Color = Color3.fromRGB(60, 60, 60)
  instance2.Parent = Parent
  parent3 = Instance
  parent3 = parent3.new
  parent3 = parent3("Frame")
  parent3.Name = "AccentBar"
  local backgroundColor3 = UDim2.new(0, 0, 0, 0)
  parent3.Position = backgroundColor3
  backgroundColor3 = UDim2
  backgroundColor3 = backgroundColor3.new
  backgroundColor3 = backgroundColor3(1, 0, 0, 1)
  parent3.Size = backgroundColor3
  parent3.BorderSizePixel = 0
  backgroundColor3 = Color3
  backgroundColor3 = backgroundColor3.fromRGB
  backgroundColor3 = backgroundColor3(113, 93, 255)
  parent3.BackgroundColor3 = backgroundColor3
  parent3.Parent = Parent
  backgroundColor3 = Instance
  backgroundColor3 = backgroundColor3.new
  backgroundColor3 = backgroundColor3("UIGradient")
  local Color = ColorSequence.new
  local automaticSize = {}
  local new = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 102))
  local new2 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(113, 93, 255))
  automaticSize[1] = new
  automaticSize[2] = new2
  automaticSize[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 214, 160))
  new = nil
  new2 = nil
  Color = Color(automaticSize)
  backgroundColor3.Color = Color
  backgroundColor3.Parent = parent3
  Color = Instance
  Color = Color.new
  Color = Color("TextLabel")
  Color.Parent = Parent
  automaticSize = UDim2.new(0, 0, 1, 0)
  Color.Size = automaticSize
  Color.BackgroundTransparency = 1
  automaticSize = Color3
  automaticSize = automaticSize.new
  automaticSize = automaticSize(1, 1, 1)
  Color.TextColor3 = automaticSize
  automaticSize = Enum
  automaticSize = automaticSize.Font.Gotham
  Color.Font = automaticSize
  Color.TextSize = 13
  automaticSize = Enum
  automaticSize = automaticSize.TextXAlignment.Left
  Color.TextXAlignment = automaticSize
  automaticSize = Enum
  automaticSize = automaticSize.AutomaticSize.X
  Color.AutomaticSize = automaticSize
  local timestamp2 = tick()
  local count11 = 60
  local count13 = 0
  local count15 = 0
  local count16 = 0
  sourceContext.runServiceService.RenderStepped:Connect(function()
    local timestamp3 = tick()
    local entry16 = timestamp3 - timestamp2
    timestamp2 = timestamp3
    if entry16 > 0 then count11 = math.clamp(math.floor(1 / entry16), 1, 1000) end
    if timestamp3 - count15 >= 0.1 then
      count15 = timestamp3
      count13 = (count13 + 0.01) % 1
      backgroundColor3.Offset = Vector2.new(count13, 0)
    end
  end)
  sourceContext.runServiceService.Heartbeat:Connect(function()
    local timestamp3 = tick()
    if timestamp3 - count16 < 0.33 then return end
    count16 = timestamp3
    if customWatermark.Enabled then Color.Text = string.format("RAIL|hub | %s | %s | %d FPS", os.date("%H:%M:%S"), os.date("%d/%m/%Y"), count11) end
  end)
  _G.CustomWatermark = customWatermark
  customWatermark.Enabled = true
end)
sourceContext.globalSetting = sourceContext.RAILhubWindow
sourceContext.TabGroup = sourceContext.globalSetting.TabGroup(sourceContext.globalSetting)
sourceContext.entries12 = {}
sourceContext.callback95 = "Tab"
sourceContext.entries12.Info = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "Information", Image = "rbxassetid://80780628588275" })
sourceContext.entries12.Farming = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "Farming", Image = "rbxassetid://4483345737" })
sourceContext.entries12.Visuals = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "Visuals", Image = "rbxassetid://7733960981" })
sourceContext.entries12.Stands = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "Stands", Image = "rbxassetid://98100463355335" })
sourceContext.entries12.Shop = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "Shop", Image = "rbxassetid://128644648286811" })
sourceContext.entries12.Player = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "Player", Image = "rbxassetid://80347609368420" })
sourceContext.entries12.PvP = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "PvP", Image = "rbxassetid://7734053495" })
sourceContext.entries12.Webhooks = sourceContext.TabGroup.Tab(sourceContext.TabGroup, { Name = "Webhooks", Image = "rbxassetid://7733960981" })
sourceContext.settings7 = sourceContext.TabGroup.Tab
sourceContext.settings7 = sourceContext.settings7(sourceContext.TabGroup, { Name = "Settings", Image = "rbxassetid://7734053495" })
sourceContext.entries12.Settings = sourceContext.settings7
sourceContext.entry28 = pcall
function sourceContext.settings7()
  if sourceContext.entries12 and sourceContext.entries12.Info and type(sourceContext.entries12.Info.Select) == "function" then
    sourceContext.entries12.Info:Select()
  elseif sourceContext.entries12 and sourceContext.entries12.Farming and type(sourceContext.entries12.Farming.Select) == "function" then
    sourceContext.entries12.Farming:Select()
  end
end
sourceContext.entry28(sourceContext.settings7)
sourceContext.info, sourceContext.sectionText = sourceContext.entries12.Info, "Section"
sourceContext.sectionResult = sourceContext.info.Section(sourceContext.info, { Side = "Left", Name = "Updates" })
sourceContext.sectionResult2 = sourceContext.info.Section(sourceContext.info, { Side = "Right", Name = "Links" })
sourceContext.sectionResult.Header(sourceContext.sectionResult, { Text = "Version: 0.1.9.1", AutoLocalize = false })
sourceContext.sectionResult.Header(sourceContext.sectionResult, { Text = "Last update: 06.10.2026", AutoLocalize = false })
sourceContext.sectionResult2.Header(sourceContext.sectionResult2, { Text = "Links", AutoLocalize = false })
sourceContext.Button = sourceContext.sectionResult2.Button
sourceContext.Button(sourceContext.sectionResult2, { Name = "Discord Link", Callback = function() sourceContext.copyDiscordLink("https://discord.gg/67UTqK8su5") end })
sourceContext._ = _G.YBAItemFarm
do
  local Farming2, sectionText2 = sourceContext.entries12.Farming, "Section"
  sourceContext.Button = Farming2.Section(Farming2, { Side = "Left", Name = "Auto farm items" })
  local section = Farming2.Section(Farming2, { Side = "Right", Name = "Auto Prestige" })
  sourceContext.Button.Header(sourceContext.Button, { Text = " Auto farm items", AutoLocalize = false })
  section.Header(section, { Text = "Auto Prestige", AutoLocalize = false })
  local dropdown
  sourceContext.Button.Dropdown(sourceContext.Button, {
    Name = "Items (empty = all)", Options = _G.YBAItemFarm and _G.YBAItemFarm.itemOptions or {}, Multi = true,
    Default = sourceContext.callback35 and sourceContext.callback35("SelectedFarmItems", {}) or {},
    Callback = function(a)
      local entries13 = _G.YBAItemFarm and _G.YBAItemFarm.selectedFarmItems or {}
      for i = #entries13, 1, -1 do table.remove(entries13, i) end
      if type(a) == "table" then
        if a[1] == nil then
          for k2, v2 in pairs(a) do if v2 == true and type(k2) == "string" then table.insert(entries13, k2) end end
        else
          for k, v in ipairs(a) do if type(v) == "string" then table.insert(entries13, v) end end
        end
      end
      sourceContext.callback34("SelectedFarmItems", entries13)
    end,
  })
  dropdown = sourceContext.Button.Dropdown
  local travelMethodOptions = { Name = "Travel Method" }
  local callback96 = { [1] = "Teleport", [2] = "Tween" }
  travelMethodOptions.Options = callback96
  function callback96()
    local savedFarmTravelMethod = sourceContext.callback35 and sourceContext.callback35("FarmTravelMethod")
    if savedFarmTravelMethod then return savedFarmTravelMethod end
    local savedUseTeleportFarm = sourceContext.callback35 and sourceContext.callback35("UseTeleportFarm")
    if savedUseTeleportFarm == nil then return "Teleport" end
    return savedUseTeleportFarm and "Teleport" or "Tween"
  end
  callback96 = callback96()
  travelMethodOptions.Default = callback96
  function callback96(a)
    sourceContext.callback34("FarmTravelMethod", a)
    sourceContext.callback34("UseTeleportFarm", a == "Teleport")
    getgenv()._YBA_directTP = a == "Teleport"
  end
  travelMethodOptions.Callback = callback96
  dropdown(sourceContext.Button, travelMethodOptions)
  travelMethodOptions = "Dropdown"
  dropdown = sourceContext.Button.Dropdown
  local farmPositionModeOptions = { Name = "Farm Position Mode", Options = { [1] = "Up", [2] = "Def", [3] = "Down" } }
  callback96 = sourceContext.callback35
  callback96 = sourceContext.callback35("FarmPosMethod", "Up")
  farmPositionModeOptions.Default = callback96
  function callback96(InstantMethod)
    sourceContext.callback34("FarmPosMethod", InstantMethod)
    getgenv().InstantMethod = InstantMethod
  end
  farmPositionModeOptions.Callback = callback96
  dropdown(sourceContext.Button, farmPositionModeOptions)
  farmPositionModeOptions = "Toggle"
  dropdown = sourceContext.Button.Toggle
  local enableFarmingOptions = { Name = "Enable farming" }
  callback96 = sourceContext.callback35
  callback96 = sourceContext.callback35("IF", false)
  enableFarmingOptions.Default = callback96
  function callback96(ItemFarmEnabled)
    sourceContext.settings2.ItemFarmEnabled = ItemFarmEnabled
    sourceContext.callback34("IF", ItemFarmEnabled)
    local YBAItemFarm = _G.YBAItemFarm
    if ItemFarmEnabled then
      if YBAItemFarm and YBAItemFarm.startFarming then YBAItemFarm.startFarming() else warn("[YBA] startFarming not available") end
      if not sourceContext.parent:FindFirstChild("WhitePad") then
        local new = Instance.new("Part")
        new.Size = Vector3.new(10000, 1, 10000)
        new.Position = Vector3.new(-139.164612, 60.740036, -372.339508)
        new.Anchored = true
        new.CanCollide = true
        new.Color = Color3.fromRGB(255, 255, 255)
        new.Transparency = 0.95
        new.Name = "WhitePad"
        new.Parent = sourceContext.parent
      end
      if not sourceContext.parent:FindFirstChild("UnderwhitePad") then
        local new2 = Instance.new("Part")
        new2.Size = Vector3.new(10000, 1, 10000)
        new2.Position = Vector3.new(0, -45, 0)
        new2.Anchored = true
        new2.CanCollide = true
        new2.Color = Color3.fromRGB(255, 255, 255)
        new2.Transparency = 0.5
        new2.Name = "UnderwhitePad"
        new2.Parent = sourceContext.parent
      end
    else
      if YBAItemFarm and YBAItemFarm.stopFarming then
        YBAItemFarm.stopFarming()
      elseif stopFarming then stopFarming() end
      if cleanupItemStick then
        cleanupItemStick()
      elseif YBAItemFarm and YBAItemFarm.cleanupItemStick then YBAItemFarm.cleanupItemStick() end
      if cleanupFarmPads then
        cleanupFarmPads()
      elseif YBAItemFarm and YBAItemFarm.cleanupFarmPads then YBAItemFarm.cleanupFarmPads() end
      if not sourceContext.callback35 or not sourceContext.callback35("PNC", false) then
        if YBAItemFarm and YBAItemFarm.disableNoclip then
          YBAItemFarm.disableNoclip(true)
        elseif disableNoclip then disableNoclip(true) end
        local character2 = sourceContext.player and sourceContext.player.Character or sourceContext.player and sourceContext.player.Character
        if restoreCharacterCollisions then restoreCharacterCollisions(character2) end
      end
    end
  end
  enableFarmingOptions.Callback = callback96
  dropdown(sourceContext.Button, enableFarmingOptions)
  enableFarmingOptions = "Toggle"
  dropdown = sourceContext.Button.Toggle
  local autoSellOnStackLimitOptions = { Name = "Auto sell on stack limit" }
  callback96 = sourceContext.callback35
  callback96 = sourceContext.callback35("ASM", false)
  autoSellOnStackLimitOptions.Default = callback96
  function callback96(a)
    local YBAItemFarm = _G.YBAItemFarm
    if YBAItemFarm and YBAItemFarm.setAutoSellMax then YBAItemFarm.setAutoSellMax(a) end
    sourceContext.callback34("ASM", a)
    if a then task.spawn(function() if YBAItemFarm and YBAItemFarm.checkAndSellMax then YBAItemFarm.checkAndSellMax() end end) end
  end
  autoSellOnStackLimitOptions.Callback = callback96
  dropdown(sourceContext.Button, autoSellOnStackLimitOptions)
  autoSellOnStackLimitOptions = "Dropdown"
  dropdown = sourceContext.Button.Dropdown
  local neverAutoSellEmptySellOptions = { Name = "Never auto-sell (empty = sell all)", Options = _G.YBAItemFarm and _G.YBAItemFarm.sellBlacklistOptions or {} }
  callback96 = true
  neverAutoSellEmptySellOptions.Multi = true
  neverAutoSellEmptySellOptions.Default = sourceContext.callback35 and sourceContext.callback35("SLBL", {}) or {}
  function neverAutoSellEmptySellOptions.Callback(a)
    local entries13 = _G.YBAItemFarm and _G.YBAItemFarm.sellBlacklist or {}
    for i = #entries13, 1, -1 do table.remove(entries13, i) end
    if type(a) == "table" then
      if a[1] == nil then
        for k2, v2 in pairs(a) do if v2 == true and type(k2) == "string" then table.insert(entries13, k2) end end
      else
        for k, v in ipairs(a) do if type(v) == "string" then table.insert(entries13, v) end end
      end
    end
    sourceContext.callback34("SLBL", entries13)
  end
  dropdown(sourceContext.Button, neverAutoSellEmptySellOptions)
  neverAutoSellEmptySellOptions = "Toggle"
  dropdown = sourceContext.Button.Toggle
  local autoBuyLuckyArrowKOptions = { Name = "Auto buy Lucky Arrow (75k)" }
  callback96 = sourceContext.callback35
  callback96 = sourceContext.callback35("ABLA", false)
  autoBuyLuckyArrowKOptions.Default = callback96
  function callback96(a)
    local YBAItemFarm = _G.YBAItemFarm
    if YBAItemFarm and YBAItemFarm.setAutoBuyLuckyArrow then YBAItemFarm.setAutoBuyLuckyArrow(a) end
    sourceContext.callback34("ABLA", a)
  end
  autoBuyLuckyArrowKOptions.Callback = callback96
  dropdown(sourceContext.Button, autoBuyLuckyArrowKOptions)
  autoBuyLuckyArrowKOptions = "Toggle"
  dropdown = sourceContext.Button.Toggle
  local serverHopFarmOptions = { Name = "Server Hop Farm" }
  callback96 = sourceContext.callback35
  callback96 = sourceContext.callback35("SHF", true)
  serverHopFarmOptions.Default = callback96
  function callback96(a)
    if a then
      if _G.YBAItemFarm and _G.YBAItemFarm.enableServerHopFarm then _G.YBAItemFarm.enableServerHopFarm() end
    elseif _G.YBAItemFarm and _G.YBAItemFarm.disableServerHopFarm then _G.YBAItemFarm.disableServerHopFarm() end
    sourceContext.callback34("SHF", a)
  end
  serverHopFarmOptions.Callback = callback96
  dropdown(sourceContext.Button, serverHopFarmOptions)
  serverHopFarmOptions = "Toggle"
  dropdown = sourceContext.Button.Toggle
  local itemESPOptions = { Name = "Item ESP" }
  callback96 = sourceContext.callback35
  callback96 = sourceContext.callback35("IESP", false)
  itemESPOptions.Default = callback96
  function callback96(a)
    sourceContext.callback34("IESP", a)
    setItemESP(a)
  end
  itemESPOptions.Callback = callback96
  dropdown(sourceContext.Button, itemESPOptions)
  itemESPOptions = "Slider"
  dropdown = sourceContext.Button.Slider
  local itemESPTextSizeOptions = { Name = "Item ESP Text Size", Default = tonumber(sourceContext.callback35("IESPSize", 14)) or 14 }
  callback96 = 8
  itemESPTextSizeOptions.Minimum = 8
  itemESPTextSizeOptions.Maximum = 28
  itemESPTextSizeOptions.DisplayMethod = "Value"
  itemESPTextSizeOptions.Precision = 0
  function itemESPTextSizeOptions.Callback(a) setItemESPTextSize(a) end
  dropdown(sourceContext.Button, itemESPTextSizeOptions)
  itemESPTextSizeOptions = "Toggle"
  dropdown = section.Toggle
  local autoPrestigeOptions = { Name = "Auto Prestige" }
  callback96 = sourceContext.callback35
  callback96 = sourceContext.callback35("AP", false)
  autoPrestigeOptions.Default = callback96
  function callback96(a)
    local toggleAutoPrestige2 = getgenv and getgenv().RAILhub_ToggleAutoPrestige or _G.toggleAutoPrestige or nil
    if toggleAutoPrestige2 then
      toggleAutoPrestige2(a)
    else
      sourceContext.callback34("AP", a)
      if a then
        task.spawn(function()
          local timestamp3 = tick()
          local toggleAutoPrestige2 = nil
          while tick() - timestamp3 < 15 do
            toggleAutoPrestige2 = getgenv and getgenv().RAILhub_ToggleAutoPrestige or _G.toggleAutoPrestige or nil
            if toggleAutoPrestige2 then break end
            task.wait(0.1)
          end
          if toggleAutoPrestige2 then toggleAutoPrestige2(true) end
        end)
      end
    end
  end
  autoPrestigeOptions.Callback = callback96
  dropdown(section, autoPrestigeOptions)
  if (sourceContext.settings2.ItemFarmEnabled or sourceContext.callback35("IF", false)) and not sourceContext.enabled10 then
    sourceContext.callback2("autostart scheduled: item farm")
    task.delay(1.5, function()
      local YBAItemFarm = _G.YBAItemFarm
      if YBAItemFarm and YBAItemFarm.startFarming then
        YBAItemFarm.startFarming()
      elseif startFarming then startFarming() end
    end)
  end
  dropdown = sourceContext.callback35
  autoPrestigeOptions = false
  dropdown = sourceContext.callback35("ASM", false)
  if dropdown then
    local YBAItemFarm = _G.YBAItemFarm
    if YBAItemFarm and YBAItemFarm.setAutoSellMax then YBAItemFarm.setAutoSellMax(true) end
  end
  if sourceContext.callback35("ABLA", false) then
    local YBAItemFarm2 = _G.YBAItemFarm
    if YBAItemFarm2 and YBAItemFarm2.setAutoBuyLuckyArrow then YBAItemFarm2.setAutoBuyLuckyArrow(true) end
  end
  if sourceContext.callback35("IESP", false) then task.defer(function() setItemESP(true) end) end
end
sourceContext.Visuals = sourceContext.entries12.Visuals
sourceContext.Farming, sourceContext.sectionText3, sourceContext.Visuals2 = sourceContext.entries12.Farming, "Section", sourceContext.Visuals
sourceContext.section2 = sourceContext.Visuals.Section(sourceContext.Visuals, { Side = "Left", Name = "ESP" })
sourceContext.section2.Header(sourceContext.section2, { Text = "Player ESP", AutoLocalize = false })
sourceContext.section3 = sourceContext.section2.Toggle
sourceContext.enablePlayerESPOptions = { Name = "Enable Player ESP" }
sourceContext.callback97 = sourceContext.callback35
sourceContext.callback97 = sourceContext.callback35("PESP", false)
sourceContext.enablePlayerESPOptions.Default = sourceContext.callback97
function sourceContext.callback97(a)
  sourceContext.callback34("PESP", a)
  if getgenv()._YBA_setPlayerESP then getgenv()._YBA_setPlayerESP(a) end
end
sourceContext.enablePlayerESPOptions.Callback = sourceContext.callback97
sourceContext.section3(sourceContext.section2, sourceContext.enablePlayerESPOptions)
sourceContext.enablePlayerESPOptions = "Toggle"
sourceContext.section3 = sourceContext.section2.Toggle
sourceContext.eSPChamsOptions = { Name = "ESP Chams" }
sourceContext.callback97 = sourceContext.callback35
sourceContext.callback97 = sourceContext.callback35("PESP_CH", true)
sourceContext.eSPChamsOptions.Default = sourceContext.callback97
function sourceContext.callback97(showChams)
  sourceContext.callback34("PESP_CH", showChams)
  getgenv().PlayerESPData.showChams = showChams
  if getgenv()._YBA_refreshPlayerESP then task.defer(getgenv()._YBA_refreshPlayerESP) end
end
sourceContext.eSPChamsOptions.Callback = sourceContext.callback97
sourceContext.section3(sourceContext.section2, sourceContext.eSPChamsOptions)
sourceContext.eSPChamsOptions = "Toggle"
sourceContext.section3 = sourceContext.section2.Toggle
sourceContext.eSPNamesOptions = { Name = "ESP Names" }
sourceContext.callback97 = sourceContext.callback35
sourceContext.callback97 = sourceContext.callback35("PESP_NM", true)
sourceContext.eSPNamesOptions.Default = sourceContext.callback97
function sourceContext.callback97(showNames)
  sourceContext.callback34("PESP_NM", showNames)
  getgenv().PlayerESPData.showNames = showNames
  if getgenv()._YBA_refreshPlayerESP then task.defer(getgenv()._YBA_refreshPlayerESP) end
end
sourceContext.eSPNamesOptions.Callback = sourceContext.callback97
sourceContext.section3(sourceContext.section2, sourceContext.eSPNamesOptions)
sourceContext.eSPNamesOptions = "Toggle"
sourceContext.section3 = sourceContext.section2.Toggle
sourceContext.eSPDistanceOptions = { Name = "ESP Distance" }
sourceContext.callback97 = sourceContext.callback35
sourceContext.callback97 = sourceContext.callback35("PESP_DS", true)
sourceContext.eSPDistanceOptions.Default = sourceContext.callback97
function sourceContext.callback97(showDistance)
  sourceContext.callback34("PESP_DS", showDistance)
  getgenv().PlayerESPData.showDistance = showDistance
  if getgenv()._YBA_refreshPlayerESP then task.defer(getgenv()._YBA_refreshPlayerESP) end
end
sourceContext.eSPDistanceOptions.Callback = sourceContext.callback97
sourceContext.section3(sourceContext.section2, sourceContext.eSPDistanceOptions)
sourceContext.eSPDistanceOptions = "Toggle"
sourceContext.section3 = sourceContext.section2.Toggle
sourceContext.eSPStandOptions = { Name = "ESP Stand" }
sourceContext.callback97 = sourceContext.callback35
sourceContext.callback97 = sourceContext.callback35("PESP_ST", true)
sourceContext.eSPStandOptions.Default = sourceContext.callback97
function sourceContext.callback97(showStand)
  sourceContext.callback34("PESP_ST", showStand)
  getgenv().PlayerESPData.showStand = showStand
  if getgenv()._YBA_refreshPlayerESP then task.defer(getgenv()._YBA_refreshPlayerESP) end
end
sourceContext.eSPStandOptions.Callback = sourceContext.callback97
sourceContext.section3(sourceContext.section2, sourceContext.eSPStandOptions)
sourceContext.eSPStandOptions = "Toggle"
sourceContext.section3 = sourceContext.section2.Toggle
sourceContext.eSPSpecOptions = { Name = "ESP Spec" }
sourceContext.callback97 = sourceContext.callback35
sourceContext.callback97 = sourceContext.callback35("PESP_SP", true)
sourceContext.eSPSpecOptions.Default = sourceContext.callback97
function sourceContext.callback97(showSpec)
  sourceContext.callback34("PESP_SP", showSpec)
  getgenv().PlayerESPData.showSpec = showSpec
  if getgenv()._YBA_refreshPlayerESP then task.defer(getgenv()._YBA_refreshPlayerESP) end
end
sourceContext.eSPSpecOptions.Callback = sourceContext.callback97
sourceContext.section3(sourceContext.section2, sourceContext.eSPSpecOptions)
sourceContext.eSPSpecOptions = "Toggle"
sourceContext.section3 = sourceContext.section2.Toggle
sourceContext.eSPHealthOptions = { Name = "ESP Health" }
sourceContext.callback97 = sourceContext.callback35
sourceContext.callback97 = sourceContext.callback35("PESP_HP", true)
sourceContext.eSPHealthOptions.Default = sourceContext.callback97
function sourceContext.callback97(showHealth)
  sourceContext.callback34("PESP_HP", showHealth)
  getgenv().PlayerESPData.showHealth = showHealth
  if getgenv()._YBA_refreshPlayerESP then task.defer(getgenv()._YBA_refreshPlayerESP) end
end
sourceContext.eSPHealthOptions.Callback = sourceContext.callback97
sourceContext.section3(sourceContext.section2, sourceContext.eSPHealthOptions)
sourceContext.eSPHealthOptions = "Section"
sourceContext.section3 = sourceContext.Visuals.Section(sourceContext.Visuals, { Side = "Right", Name = "World & Weather" })
sourceContext.eSPHealthOptions = sourceContext.section3
sourceContext.section3.Header(sourceContext.section3, { Text = "Weather", AutoLocalize = false })
sourceContext.entries13 = {}
sourceContext.eSPHealthOptions = "FogColor"
sourceContext.section4 = nil
sourceContext.entries13.FogColor = game:GetService("Lighting").FogColor
sourceContext.section4 = game
sourceContext.callback97 = sourceContext.section4
sourceContext.entries13.FogEnd = sourceContext.section4.GetService(sourceContext.section4, "Lighting").FogEnd
sourceContext.section4 = game
sourceContext.callback97 = sourceContext.section4
sourceContext.entries13.FogStart = sourceContext.section4.GetService(sourceContext.section4, "Lighting").FogStart
function sourceContext.callback98()
  pcall(function()
    local modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
    local rain = modules and modules:FindFirstChild("Rain")
    if rain then
      local requireResult = require(rain)
      if requireResult and type(requireResult.Disable) == "function" then requireResult:Disable() end
    end
  end)
  pcall(function()
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera then
      local yBARainSphere = CurrentCamera:FindFirstChild("YBA_RainSphere")
      if yBARainSphere then yBARainSphere:Destroy() end
      local yBASnowEmitter = CurrentCamera:FindFirstChild("YBA_SnowEmitter")
      if yBASnowEmitter then yBASnowEmitter:Destroy() end
    end
  end)
  pcall(function()
    local lightingService2 = game:GetService("Lighting")
    lightingService2.FogColor = sourceContext.entries13.FogColor or Color3.fromRGB(192, 192, 192)
    lightingService2.FogEnd = sourceContext.entries13.FogEnd or 100000
    lightingService2.FogStart = sourceContext.entries13.FogStart or 0
  end)
end
sourceContext.section4 = getgenv
sourceContext.section4 = sourceContext.section4()
sourceContext.weatherCfgText = "WeatherCfg"
sourceContext.WeatherCfg = getgenv()
sourceContext.WeatherCfg = sourceContext.WeatherCfg.WeatherCfg
if not sourceContext.WeatherCfg then
  sourceContext.WeatherCfg = { Enabled = sourceContext.callback35("WEATHER_ENABLED", false), Selected = sourceContext.callback35("WEATHER_SELECTED", "None") }
end
sourceContext.section4.WeatherCfg = sourceContext.WeatherCfg
sourceContext.weatherCfgText = sourceContext.section3
sourceContext.section4 = sourceContext.section3.Toggle
sourceContext.enableWeatherChangerOptions = { Name = "Enable Weather Changer" }
sourceContext.callback99 = sourceContext.callback35
sourceContext.callback99 = sourceContext.callback35("WEATHER_ENABLED", false)
sourceContext.enableWeatherChangerOptions.Default = sourceContext.callback99
function sourceContext.callback99(Enabled)
  sourceContext.callback34("WEATHER_ENABLED", Enabled)
  getgenv().WeatherCfg.Enabled = Enabled
  if not Enabled then sourceContext.callback98() end
end
sourceContext.enableWeatherChangerOptions.Callback = sourceContext.callback99
sourceContext.section4(sourceContext.section3, sourceContext.enableWeatherChangerOptions)
sourceContext.enableWeatherChangerOptions = "Dropdown"
sourceContext.weatherCfgText = sourceContext.section3
sourceContext.section4 = sourceContext.section3.Dropdown
sourceContext.selectWeatherOptions = { Name = "Select Weather", Options = { [1] = "Rain", [2] = "Snow" } }
sourceContext.callback99 = sourceContext.callback35
sourceContext.callback99 = sourceContext.callback35("WEATHER_SELECTED", "None")
sourceContext.selectWeatherOptions.Default = sourceContext.callback99
function sourceContext.callback99(Selected)
  sourceContext.callback34("WEATHER_SELECTED", Selected)
  getgenv().WeatherCfg.Selected = Selected
  sourceContext.callback98()
end
sourceContext.selectWeatherOptions.Callback = sourceContext.callback99
sourceContext.section4(sourceContext.section3, sourceContext.selectWeatherOptions)
sourceContext.section4 = task
sourceContext.section4 = sourceContext.section4.spawn
function sourceContext.weatherCfgText()
  while true do
    task.wait(1)
    pcall(function()
      if getgenv().WeatherCfg.Enabled then
        local environment6 = getgenv()
        environment6 = environment6.WeatherCfg.Selected
        if environment6 == "Rain" then
          local requireResult = require(game:GetService("ReplicatedStorage").Modules.Rain)
          requireResult:Enable()
          requireResult:SetIntensityRatio(1)
          local lightingService2 = game:GetService("Lighting")
          lightingService2.FogColor = Color3.fromRGB(0, 0, 0)
          lightingService2.FogEnd = 1050
          lightingService2.FogStart = 0
          local Parent3 = workspace.CurrentCamera
          local Parent4 = Parent3 and Parent3:FindFirstChild("YBA_RainSphere")
          if not Parent4 and Parent3 then
            Parent4 = Instance.new("Part")
            Parent4.Name = "YBA_RainSphere"
            Parent4.Shape = Enum.PartType.Ball
            Parent4.Size = Vector3.new(2100, 2100, 2100)
            Parent4.Color = Color3.fromRGB(0, 0, 0)
            Parent4.Material = Enum.Material.SmoothPlastic
            Parent4.CanCollide = false
            Parent4.Anchored = true
            Parent4.CastShadow = false
            local new = Instance.new("SpecialMesh")
            new.MeshType = Enum.MeshType.FileMesh
            new.MeshId = "rbxassetid://4371999088"
            new.Scale = Vector3.new(10.5, 10.5, 10.5)
            new.Parent = Parent4
            Parent4.Parent = Parent3
          end
          if Parent4 and Parent3 then Parent4.CFrame = Parent3.CFrame end
        elseif environment6 == "Snow" then
          local Parent = workspace.CurrentCamera
          local snowingEffect = game:GetService("ReplicatedStorage").Objects:FindFirstChild("SnowingEffect")
          if snowingEffect and Parent then
            local Parent2 = Parent:FindFirstChild("YBA_SnowEmitter")
            if not Parent2 then
              Parent2 = Instance.new("Part")
              Parent2.Name = "YBA_SnowEmitter"
              Parent2.Transparency = 1
              Parent2.CanCollide = false
              Parent2.Anchored = true
              Parent2.Size = Vector3.new(100, 1, 100)
              Parent2.Parent = Parent
              for k, v in pairs(snowingEffect:GetChildren()) do
                if v:IsA("ParticleEmitter") then
                  local cloneResult = v:Clone()
                  cloneResult.Parent = Parent2
                  cloneResult.Enabled = true
                end
              end
            end
            Parent2.CFrame = Parent.CFrame * CFrame.new(0, 50, -20)
            for k2, v2 in pairs(Parent2:GetChildren()) do if v2:IsA("ParticleEmitter") then v2.Enabled = true end end
          end
          local lightingService3 = game:GetService("Lighting")
          lightingService3.FogColor = Color3.fromRGB(255, 255, 255)
          lightingService3.FogEnd = 1500
          lightingService3.FogStart = 10
        end
      else
        local currentCamera = workspace.CurrentCamera
        if currentCamera and (currentCamera:FindFirstChild("YBA_RainSphere") or currentCamera:FindFirstChild("YBA_SnowEmitter")) then sourceContext.callback98() end
      end
    end)
  end
end
sourceContext.section4(sourceContext.weatherCfgText)
sourceContext.selectWeatherOptions = "Section"
sourceContext.weatherCfgText = sourceContext.Visuals
sourceContext.section4 = sourceContext.Visuals.Section
sourceContext.section4 = sourceContext.section4(sourceContext.Visuals, { Side = "Right", Name = "Custom Finishers" })
sourceContext.selectWeatherOptions = sourceContext.section4
sourceContext.section4.Header(sourceContext.section4, { Text = "Finishers changer", AutoLocalize = false })
sourceContext.weatherCfgText = sourceContext.callback35
sourceContext.selectWeatherOptions = "PSelectFinisher"
sourceContext.savedPSelectFinisher = sourceContext.callback35("PSelectFinisher", "Shiza")
function sourceContext.callback100()
  local environment6 = getgenv()
  environment6 = environment6.FinisherSystemHooked
  if environment6 then return end
  environment6 = getgenv()
  environment6.FinisherSystemHooked = true
  environment6 = game
  local entry16 = environment6
  environment6 = entry16.GetService
  environment6 = environment6(entry16, "ReplicatedStorage")
  local LocalPlayer = game:GetService("Players")
  LocalPlayer = LocalPlayer.LocalPlayer
  local function callback23()
    if type(getinstances) == "function" then return getinstances() end
    local entries14 = {}
    local entry16 = pairs
    local gameReference = game
    for k, v in entry16(gameReference:GetDescendants()) do table.insert(entries14, v) end
    return entries14
  end
  local function callback33(a)
    if not (a and a:IsA("RemoteEvent")) then return end
    if not getgenv().HookedRemotes then getgenv().HookedRemotes = {} end
    if getgenv().HookedRemotes[a] then return end
    local onClientEvent
    getgenv().HookedRemotes[a] = true
    onClientEvent = a.OnClientEvent
    onClientEvent.Connect(onClientEvent, function(b, b2)
      if not getgenv().CustomFinisherEnabled then return end
      pcall(function()
        if type(b) == "string" and string.find(b, "Finisher:") and type(b2) == "table" then
          local User = b2.User
          local enabled28
          if tostring(User) == LocalPlayer.Name then
            enabled28 = true
          elseif User == LocalPlayer then
            enabled28 = true
          elseif LocalPlayer.Character then
            if User == LocalPlayer.Character then
              enabled28 = true
            else
              local Character = LocalPlayer.Character
              enabled28 = if Character then if type(User) == "userdata" then User.Parent == LocalPlayer.Character else false else Character
            end
          else
            local Character2 = LocalPlayer.Character
            enabled28 = if Character2 then if type(User) == "userdata" then User.Parent == LocalPlayer.Character else false else Character2
          end
          if enabled28 then
            local savedPSelectFinisher2 = sourceContext.savedPSelectFinisher or sourceContext.callback35("PSelectFinisher", "Shiza")
            if savedPSelectFinisher2 == "None" or savedPSelectFinisher2 == "" then return end
            local modules = environment6:FindFirstChild("Modules")
            modules = modules and environment6.Modules:FindFirstChild("VFX_Finishers")
            modules = modules or environment6:WaitForChild("Modules", 3) and environment6.Modules:WaitForChild("VFX_Finishers", 3)
            if not modules then return end
            local findFirstChildResult = modules:FindFirstChild(savedPSelectFinisher2)
            if not findFirstChildResult then return end
            local requireResult = require(findFirstChildResult)
            local entry16 = "Finisher: " .. savedPSelectFinisher2
            if requireResult and requireResult[entry16] then task.spawn(function() pcall(function() requireResult[entry16](b2) end) end) end
          end
        end
      end)
    end)
  end
  local pairsResult, entry18, entry19
  pairsResult, entry18, entry19 = pairs(callback23())
  for k, v in pairsResult, entry18, entry19 do if v:IsA("RemoteEvent") then callback33(v) end end
  game.DescendantAdded:Connect(function(a) if a:IsA("RemoteEvent") then callback33(a) end end)
  LocalPlayer.CharacterAdded:Connect(function(a)
    task.wait(0.2)
    local remoteEvent2 = a:FindFirstChild("RemoteEvent") or a:WaitForChild("RemoteEvent", 2)
    if remoteEvent2 then callback33(remoteEvent2) end
  end)
  if LocalPlayer.Character then
    local Character = LocalPlayer.Character
    Character = Character:FindFirstChild("RemoteEvent")
    if Character then callback33(Character) end
  end
end
sourceContext.callback99 = sourceContext.section4
sourceContext.default = sourceContext.section4.Dropdown
sourceContext.selectFinisherOptions = {
  Name = "Select Finisher",
  Options = {
    [1] = "Aincrad", [2] = "Announcer", [3] = "Bruh Moment", [4] = "Crumble", [5] = "Disintegrate", [6] = "GET OUT",
    [7] = "Gate of Babylon", [8] = "God's Lightning", [9] = "Huh #2", [10] = "Hyperlaser",
    [11] = "Killer Queen Detonate", [12] = "Lineage Wipe", [13] = "Minecraft", [14] = "None", [15] = "Pillarman",
    [16] = "Shiza", [17] = "Sub-Zero", [18] = "Tom", [19] = "Vampire Ripple", [20] = "Wither",
  },
}
sourceContext.callback101 = nil
sourceContext.callback101 = sourceContext.callback35
sourceContext.callback101 = sourceContext.callback35("PSelectFinisher", "Shiza")
sourceContext.selectFinisherOptions.Default = sourceContext.callback101
function sourceContext.callback101(a)
  sourceContext.savedPSelectFinisher = a
  sourceContext.callback34("PSelectFinisher", a)
end
sourceContext.selectFinisherOptions.Callback = sourceContext.callback101
sourceContext.default(sourceContext.section4, sourceContext.selectFinisherOptions)
sourceContext.default = sourceContext.callback35
sourceContext.callback99 = "PEnableFinisher"
sourceContext.default = sourceContext.callback35("PEnableFinisher", false)
getgenv().CustomFinisherEnabled = sourceContext.default
if sourceContext.default then task.spawn(sourceContext.callback100) end
sourceContext.Text5 = nil
sourceContext.selectFinisherOptions = sourceContext.section4
sourceContext.toggle = sourceContext.section4.Toggle
sourceContext.entries14 = {}
sourceContext.callback101 = "Enable Finisher changer"
sourceContext.entries14.Name = "Enable Finisher changer"
sourceContext.entries14.Default = sourceContext.default
function sourceContext.entries14.Callback(CustomFinisherEnabled)
  getgenv().CustomFinisherEnabled = CustomFinisherEnabled
  sourceContext.callback34("PEnableFinisher", CustomFinisherEnabled)
  if CustomFinisherEnabled then sourceContext.callback100() end
end
sourceContext.toggle(sourceContext.section4, sourceContext.entries14)
sourceContext.entries14 = "Section"
sourceContext.selectFinisherOptions = sourceContext.Farming
sellSec = sourceContext.Farming.Section(sourceContext.Farming, { Side = "Right", Name = "Sell items" })
sourceContext.toggle = sellSec
sourceContext.selectFinisherOptions = sourceContext.toggle
sourceContext.toggle.Header(sourceContext.toggle, { Text = "Sell items", AutoLocalize = false })
sourceContext.Text5 = sourceContext.callback35 and sourceContext.callback35("SellSpecificItem", "") or ""
sourceContext.sellSec2 = sellSec
sourceContext.dropdown2 = sourceContext.sellSec2.Dropdown
sourceContext.sellSpecificItemOptions = {
  Name = "Sell specific item",
  Options = _G.YBAItemFarm and _G.YBAItemFarm.sellSpecificOptions or sourceContext.environment2 and sourceContext.environment2.sellSpecificOptions or {},
}
sourceContext.callback102 = sourceContext.callback35("SellSpecificItem", "")
sourceContext.sellSpecificItemOptions.Default = sourceContext.callback102
function sourceContext.callback102(a)
  sourceContext.Text5 = a or ""
  sourceContext.callback34("SellSpecificItem", sourceContext.Text5)
end
sourceContext.sellSpecificItemOptions.Callback = sourceContext.callback102
sourceContext.dropdown2(sourceContext.sellSec2, sourceContext.sellSpecificItemOptions)
sourceContext.dropdown2 = sellSec
sourceContext.sellSpecificItemOptions = "Button"
sourceContext.button = sourceContext.dropdown2.Button
sourceContext.sellSelectedItemOptions = { Name = "Sell selected item" }
function sourceContext.callback102()
  if sourceContext.Text5 == "" then
    sourceContext.notify("YBA Script", "Select an item first.")
  else
    local YBAItemFarm = _G.YBAItemFarm
    if YBAItemFarm and YBAItemFarm.sellAll then YBAItemFarm.sellAll(sourceContext.Text5) end
  end
end
sourceContext.sellSelectedItemOptions.Callback = sourceContext.callback102
sourceContext.button(sourceContext.dropdown2, sourceContext.sellSelectedItemOptions)
sourceContext.button = sellSec
sourceContext.sellSelectedItemOptions = "Button"
sourceContext.button2 = sourceContext.button.Button
sourceContext.sellAllItemsOptions = { Name = "Sell All Items" }
function sourceContext.callback102()
  local YBAItemFarm = _G.YBAItemFarm
  if YBAItemFarm and YBAItemFarm.sellInventory then YBAItemFarm.sellInventory() end
end
sourceContext.sellAllItemsOptions.Callback = sourceContext.callback102
sourceContext.button2(sourceContext.button, sourceContext.sellAllItemsOptions)
sourceContext.settings8 = {
  
  ["Officer Sam [Lvl. 1+]"] = { displayName = "Officer Sam [Lvl. 1+] (Thug)", enemy = "Thug", minLvl = 1, npc = "Officer Sam [Lvl. 1+]", questTitle = "Take down 5 thugs" },
  ["Deputy Bertrude [Lvl. 10+]"] = {
    displayName = "Deputy Bertrude [Lvl. 10+] (Corrupt Police)", enemy = "Corrupt Police", minLvl = 10,
    npc = "Deputy Bertrude [Lvl. 10+]", questTitle = "Take down 5 corrupt police",
  },
  ["Abbacchio's Partner [Lvl. 15+]"] = {
    displayName = "Abbacchio's Partner [Lvl. 15+] (Alpha Thug)", enemy = "Alpha Thug", minLvl = 15,
    npc = "Abbacchio's Partner [Lvl 15+]", questTitle = "Take down 5 alpha thugs",
  },
  ["Dracula [Lvl. 20+]"] = {
    displayName = "Dracula [Lvl. 20+] (Zombie Henchman)", enemy = "Zombie Henchman", minLvl = 20,
    npc = "Dracula [Lvl. 20+]", questTitle = "Take down 5 zombies",
  },
  ["William Zeppeli [Lvl. 25+]"] = {
    displayName = "William Zeppeli [Lvl. 25+] (Vampire)", enemy = "Vampire", minLvl = 25,
    npc = "William Zeppeli [Lvl. 25+]", questTitle = "Take down 3 vampires",
  },
  
  ["Doppio [Lvl. 30+]"] = { displayName = "Doppio [Lvl. 30+] (DIO)", enemy = "DIO", minLvl = 30, npc = "Doppio [Lvl. 30+]", questTitle = "Defeat DIO" },
  ["DIO [Lvl. 35+]"] = { displayName = "DIO [Lvl. 35+] (Jotaro)", enemy = "Jotaro", minLvl = 35, npc = "DIO [Lvl. 35+]", questTitle = "Defeat Jotaro" },
  ["Jotaro [Lvl. 40+]"] = {
    displayName = "Jotaro [Lvl. 40+] (Heaven Ascended DIO)", enemy = "Heaven Ascended DIO", minLvl = 40,
    npc = "Jotaro (Tallest Peak)", questTitle = "Defeat Heaven Ascended DIO",
  },
  Jotaro = {
    displayName = "Jotaro [Lvl. 40+] (Heaven Ascended DIO)", enemy = "Heaven Ascended DIO", minLvl = 40,
    npc = "Jotaro (Tallest Peak)", questTitle = "Defeat Heaven Ascended DIO",
  },
  ["Path to Heaven"] = {
    displayName = "Jotaro [Lvl. 40+] (Heaven Ascended DIO)", enemy = "Heaven Ascended DIO", minLvl = 40,
    npc = "Jotaro (Tallest Peak)", questTitle = "Defeat Heaven Ascended DIO",
  },
}
sourceContext.Options = {}
sourceContext.sellAllItemsOptions = "Officer Sam [Lvl. 1+] (Thug)"
sourceContext.callback102 = "Abbacchio's Partner [Lvl. 15+] (Alpha Thug)"
sourceContext.Options[1] = "Officer Sam [Lvl. 1+] (Thug)"
sourceContext.Options[2] = "Deputy Bertrude [Lvl. 10+] (Corrupt Police)"
sourceContext.Options[3] = "Abbacchio's Partner [Lvl. 15+] (Alpha Thug)"
sourceContext.Options[4] = "Dracula [Lvl. 20+] (Zombie Henchman)"
sourceContext.Options[5] = "William Zeppeli [Lvl. 25+] (Vampire)"
sourceContext.Options[6] = "Doppio [Lvl. 30+] (DIO)"
sourceContext.Options[7] = "DIO [Lvl. 35+] (Jotaro)"
sourceContext.Options[8] = "Jotaro [Lvl. 40+] (Heaven Ascended DIO)"
sourceContext.Options2 = {
  [1] = "Thug", [2] = "Alpha Thug", [3] = "Corrupt Police", [4] = "Zombie Henchman", [5] = "Vampire", [6] = "DIO",
  [7] = "Heaven Ascended DIO", [8] = "Jotaro", [9] = "Jotaro (Part 6)", [10] = "Security Guard",
  [11] = "Leaky Eye Luca", [12] = "Bucciarati", [13] = "Pesci", [14] = "Ghiaccio", [15] = "Diavolo",
}
sourceContext.enabled28, sourceContext.enabled29 = false, false
if not sourceContext.callback35 or not sourceContext.callback35("QF_AutoChoose", false) then

end
sourceContext.Default = sourceContext.callback35 and sourceContext.callback35("QF_Quest", sourceContext.Options[1]) or sourceContext.Options[1]
sourceContext.Default2 = sourceContext.callback35 and sourceContext.callback35("QF_TargetNPC", "Thug") or "Thug"
function sourceContext.callback103(a)
  if enableNoclip then
    enableNoclip(a)
  elseif _G.YBAItemFarm and _G.YBAItemFarm.enableNoclip then
    _G.YBAItemFarm.enableNoclip(a)
  else
    local _YBA_Exports = getgenv()
    _YBA_Exports = _YBA_Exports._YBA_Exports
    if _YBA_Exports and getgenv()._YBA_Exports.enableNoclip then getgenv()._YBA_Exports.enableNoclip(a) end
  end
end
function sourceContext.callback104(a)
  if disableNoclip then
    disableNoclip(a)
  elseif _G.YBAItemFarm and _G.YBAItemFarm.disableNoclip then
    _G.YBAItemFarm.disableNoclip(a)
  else
    local _YBA_Exports = getgenv()
    _YBA_Exports = _YBA_Exports._YBA_Exports
    if _YBA_Exports and getgenv()._YBA_Exports.disableNoclip then getgenv()._YBA_Exports.disableNoclip(a) end
  end
end
function sourceContext.callback105(a)
  if a then
    for k, v in pairs(sourceContext.settings8) do
      if v.displayName == a or k == a or k:lower() == a:lower() or v.displayName:lower() == a:lower() then return k end
    end
    for k2, v2 in pairs(sourceContext.settings8) do
      local lowerResult = a:lower()
      local find = lowerResult.find
      find = find(lowerResult, v2.enemy:lower(), 1, true)
      if find or lowerResult:find(k2:lower(), 1, true) or v2.npc and lowerResult:find(v2.npc:lower(), 1, true) then return k2 end
    end
    return "Officer Sam [Lvl. 1+]"
  end
  return "Officer Sam [Lvl. 1+]"
end
function sourceContext.callback106(entry18)
  local minLvl = tonumber(entry18)
  entry18 = if minLvl then minLvl else 1
  minLvl = -1
  local officerSamLvlText = "Officer Sam [Lvl. 1+]"
  for k, v in pairs(sourceContext.settings8) do if v.minLvl and v.minLvl <= entry18 and minLvl < v.minLvl then minLvl, officerSamLvlText = v.minLvl, k end end
  return officerSamLvlText
end
function sourceContext.callback107(_, _)
  local playerGui3 = sourceContext.player:FindFirstChild("PlayerGui")
  if playerGui3 then
    local FindFirstChild = playerGui3.FindFirstChild
    FindFirstChild = FindFirstChild(playerGui3, "DialogueGui") or playerGui3:FindFirstChild("Dialogue")
    if not FindFirstChild then
      local ipairsResult, entry18, entry19 = ipairs(playerGui3:GetChildren())
      for k, v in ipairsResult, entry18, entry19 do
        if v:IsA("ScreenGui") and v.Enabled and v.Name:lower():find("dialog") then
          FindFirstChild = v
          break
        end
      end
    end
    local enabled30, enabled31 = false, false
    if FindFirstChild and FindFirstChild.Enabled then
      local frame = FindFirstChild:FindFirstChild("Frame")
      frame = frame or FindFirstChild:FindFirstChildWhichIsA("Frame") or FindFirstChild
      if frame and frame.Visible then
        local dialogueFrame = frame:FindFirstChild("DialogueFrame", true)
        local Text6 = ""
        if dialogueFrame then
          local ipairsResult2, entry20, entry23 = ipairs(dialogueFrame:GetDescendants())
          for k2, v2 in ipairsResult2, entry20, entry23 do if v2:IsA("TextLabel") and v2.Text ~= "" then Text6 = Text6 .. " " .. v2.Text:lower() end end
        end
        local find
        enabled31 = (Text6:find("remember") or Text6:find("promised") or Text6:find("already") or Text6:find("come back once") or Text6:find("found all 4")) and true or false
        find = Text6.find
        find = find(Text6, "too weak")
        if find or Text6:find("prestige 1") then
          warn("[Quest Farm] Player must be Prestige 1+ and have a Stand to take this quest.")
          enabled31 = true
        end
        find = Text6.find
        find = find(Text6, "combat") or Text6:find("в бою")
        if find then
          local clickContinue = frame:FindFirstChild("ClickContinue", true)
          if clickContinue then sourceContext.callback9(clickContinue) end
          task.wait(2)
          return false, false, true
        end
        local options = frame:FindFirstChild("Options", true)
        local btn = nil
        if options and options.Visible then
          local entries14 = {}
          local ipairsResult5, entry24, entry26 = ipairs(options:GetChildren())
          for k4, v4 in ipairsResult5, entry24, entry26 do
            if v4:IsA("GuiObject") and v4.Visible and v4.Name ~= "UIListLayout" and v4.Name ~= "UIPadding" and v4.Name ~= "UIGridLayout" then
              local textButton = v4:FindFirstChildWhichIsA("TextButton", true)
              textButton = textButton or v4:FindFirstChildWhichIsA("GuiButton", true) or v4:IsA("GuiButton") and v4
              local Text2 = ""
              if textButton and textButton:IsA("TextButton") and textButton.Text and textButton.Text ~= "" then Text2 = textButton.Text end
              if Text2 == "" then
                local ipairsResult6, entry27, entry28 = ipairs(v4:GetDescendants())
                for k3, v3 in ipairsResult6, entry27, entry28 do
                  if (v3:IsA("TextLabel") or v3:IsA("TextButton")) and v3.Text and v3.Text ~= "" then
                    Text2 = v3.Text
                    break
                  end
                end
              end
              local normalizedText2 = Text2:lower():gsub("^%s+", ""):gsub("%s+$", "")
              local findResult = normalizedText2:find("no problem")
              findResult = findResult or normalizedText2:find("thank you") or normalizedText2:find("nevermind") or normalizedText2:find("no thanks") or normalizedText2:find("bye")
              local isDots = normalizedText2 == "..."
              if not findResult then
                table.insert(entries14, { obj = v4, btn = textButton or v4, isDots = isDots, y = v4.AbsolutePosition and v4.AbsolutePosition.Y or 9999 })
              end
            end
          end
          if #entries14 > 0 then
            local entries15 = {}
            local ipairsResult7, entry29, entry30 = ipairs(entries14)
            for k5, v5 in ipairsResult7, entry29, entry30 do if not v5.isDots then table.insert(entries15, v5) end end
            ipairsResult7 = #entries15 > 0 and entries15 or entries14
            table.sort(ipairsResult7, function(a, b) return a.y < b.y end)
            btn = ipairsResult7[1].btn
          end
        end
        if btn then
          sourceContext.callback9(btn)
          enabled30 = true
          task.wait(0.08)
          sourceContext.callback21(FindFirstChild)
        else
          sourceContext.callback21(FindFirstChild)
          enabled30 = true
          task.wait(0.04)
        end
      end
    end
    local ipairsResult8, entry31, entry32 = ipairs(playerGui3:GetChildren())
    for k6, v6 in ipairsResult8, entry31, entry32 do
      if v6:IsA("ScreenGui") and v6.Enabled and v6 ~= FindFirstChild then
        local Name = v6.Name
        Name = Name:lower()
        if Name:find("dialog") or Name:find("quest") then
          local option1 = v6:FindFirstChild("Option1", true)
          if option1 and option1.Visible then
            sourceContext.callback9(option1)
            enabled30 = true
          end
          local clickContinue2 = v6:FindFirstChild("ClickContinue", true)
          if clickContinue2 and clickContinue2.Visible then
            sourceContext.callback9(clickContinue2)
            enabled30 = true
          end
        end
      end
    end
    return enabled30, enabled31
  end
  return false
end
function sourceContext.callback108(a)
  local dialogues = workspace:FindFirstChild("Dialogues")
  if dialogues then
    if a and a ~= "" then
      local findFirstChildResult = dialogues:FindFirstChild(a)
      if findFirstChildResult then return findFirstChildResult end
      local function callback23(b)
        if b then return tostring(b):lower():gsub("[%p%s]+", " "):gsub("^%s+", ""):gsub("%s+$", "") end
        return ""
      end
      local entry18 = callback23
      entry18 = callback23(a)
      local normalizedText2 = tostring(a):lower():gsub("[%s%p]+", "")
      local ipairsResult, entry19, entry20 = ipairs(dialogues:GetChildren())
      for k, v in ipairsResult, entry19, entry20 do
        if (v:IsA("Model") or v:IsA("Folder") or v:FindFirstChildWhichIsA("BasePart")) and v.Name:lower():gsub("[%s%p]+", "") == normalizedText2 then return v end
      end
      local entries14 = {}
      local abbacchioText, doppioText = "abbacchio", "doppio"
      entries14[1] = "dracula"
      entries14[2] = "sam"
      entries14[3] = "bertrude"
      entries14[4] = "abbacchio"
      entries14[5] = "zeppeli"
      entries14[6] = "doppio"
      entries14[7] = "jotaro"
      entries14[8] = "jill"
      entries14[9] = "luca"
      entries14[10] = "pucci"
      entries14[11] = "darius"
      entries14[12] = "kars"
      entries14[13] = "bucciarati"
      entries14[14] = "giorno"
      local findResult = entry18:find("heaven")
      findResult = findResult or entry18:find("ascen") or entry18:find("oh") or entry18:find("tallest") or entry18:find("peak") or entry18:find("corpse")
      local findResult2 = (entry18 == "dio" or entry18:find("^dio") or normalizedText2:find("^dio")) and not findResult
      local find = entry18.find
      find = find(entry18, "6") or entry18:find("p6")
      local ipairsResult2, entry23, entry24 = ipairs(dialogues:GetChildren())
      for k3, v3 in ipairsResult2, entry23, entry24 do
        local Name, entry26 = v3.Name, callback23
        entry26 = callback23(Name)
        local normalizedText3 = Name:lower():gsub("[%s%p]+", "")
        if findResult then
          if entry26:find("tallest") or entry26:find("peak") or entry26:find("heaven") or entry26:find("ascen") or entry26:find("oh") then return v3 end
        elseif findResult2 then
          if (entry26 == "dio" or entry26:find("^dio") or normalizedText3:find("^dio")) and not entry26:find("heaven") and not entry26:find("ascen") and not entry26:find("oh") and not entry26:find("tallest") and not entry26:find("peak") then
            return v3
          end
        elseif find then
          if entry26:find("jotaro") and (entry26:find("6") or entry26:find("p6")) then return v3 end
        else
          if entry26 == entry18 or entry26:find(entry18, 1, true) or entry18:find(entry26, 1, true) then return v3 end
          for k2, v2 in ipairs(entries14) do
            local findResult3 = entry18:find(v2, 1, true)
            if findResult3 and entry26:find(v2, 1, true) then return v3 end
          end
        end
      end
      local matchResult = entry18:match("^(%w+)")
      if matchResult and #matchResult >= 3 then
        for k4, v4 in ipairs(dialogues:GetChildren()) do
          local entry27 = callback23
          entry27 = callback23(v4.Name)
          entry27 = entry27:find(matchResult, 1, true)
          if entry27 then return v4 end
        end
      end
      return nil
    end
    return nil
  end
  return nil
end
function sourceContext.callback109(a)
  if a and a ~= "" and a ~= "None" then
    local lowerResult = a:lower()
    if not lowerResult:find("corrupt") and not lowerResult:find("police") and not lowerResult:find("bertrude") then
      if not lowerResult:find("alpha") and not lowerResult:find("abbacchio") then
        if not lowerResult:find("thug") and not lowerResult:find("sam") then
          if not lowerResult:find("zombie") and not lowerResult:find("dracula") and not lowerResult:find("henchman") then
            if not lowerResult:find("vampire") and not lowerResult:find("zeppeli") then
              if not lowerResult:find("heaven") and not lowerResult:find("ascend") and not lowerResult:find(" oh") and not lowerResult:find("corpse") and not lowerResult:find("path to heaven") then
                if not lowerResult:find("dio") and not lowerResult:find("doppio") then
                  if lowerResult:find("jotaro") then return "Jotaro" end
                  return nil
                end
                return "DIO"
              end
              return "Heaven Ascended DIO"
            end
            return "Vampire"
          end
          return "Zombie Henchman"
        end
        return "Thug"
      end
      return "Alpha Thug"
    end
    return "Corrupt Police"
  end
  return nil
end
function sourceContext.callback110(a, b, c)
  if a and a ~= "" and a ~= "None" then
    if b then
      local normalizedText2 = a:lower():gsub("[%p%s]+", " "):gsub("^%s+", ""):gsub("%s+$", "")
      local lowerResult = (b.enemy or ""):lower()
      local lowerResult2 = (c or ""):lower()
      local findResult = lowerResult:find("alpha", 1, true)
      findResult = findResult ~= nil or lowerResult2:find("alpha", 1, true) ~= nil
      local findResult2 = lowerResult:find("thug", 1, true)
      findResult2 = (findResult2 ~= nil or lowerResult2:find("thug", 1, true) ~= nil) and not findResult
      local find = lowerResult
      local find2 = lowerResult.find
      find2 = find2(lowerResult, "police", 1, true)
      find2 = find2 ~= nil or lowerResult:find("corrupt", 1, true) ~= nil or lowerResult2:find("corrupt", 1, true) ~= nil or lowerResult2:find("police", 1, true) ~= nil or lowerResult2:find("bertrude", 1, true) ~= nil
      local find3 = lowerResult
      find = lowerResult.find
      find = find(lowerResult, "zombie", 1, true)
      find = find ~= nil or lowerResult:find("henchman", 1, true) ~= nil or lowerResult2:find("dracula", 1, true) ~= nil or lowerResult2:find("zombie", 1, true) ~= nil
      local find4 = lowerResult
      find3 = lowerResult.find
      find3 = find3(lowerResult, "vampire", 1, true)
      find3 = find3 ~= nil or lowerResult2:find("zeppeli", 1, true) ~= nil or lowerResult2:find("vampire", 1, true) ~= nil
      local find5 = lowerResult
      find4 = lowerResult.find
      find4 = find4(lowerResult, "heaven", 1, true)
      find4 = find4 ~= nil or lowerResult:find("ascend", 1, true) ~= nil or lowerResult2:find("heaven", 1, true) ~= nil or lowerResult2:find("40") ~= nil
      local find6 = lowerResult
      find5 = lowerResult.find
      find5 = find5(lowerResult, "dio", 1, true)
      if find5 == nil then
        if lowerResult2:find("doppio", 1, true) == nil then
          local findResult3 = lowerResult2:find("^dio", 1, true)
          find5 = if findResult3 then if lowerResult2:find("35") then false else if lowerResult:find("jotaro", 1, true) then false else not find4 else findResult3
        else
          find5 = not find4
        end
      else
        find5 = not find4
      end
      local find7 = lowerResult
      find6 = lowerResult.find
      find6 = find6(lowerResult, "jotaro", 1, true)
      if find6 == nil then
        if lowerResult2:find("35") then
          find6 = if find4 then false else if lowerResult:find("6", 1, true) == nil then lowerResult:find("p6", 1, true) == nil else false
        else
          local findResult4 = lowerResult2:find("dio", 1, true)
          if findResult4 then
            local findResult5 = lowerResult:find("jotaro", 1, true)
            find6 = if findResult5 then if find4 then false else if lowerResult:find("6", 1, true) == nil then lowerResult:find("p6", 1, true) == nil else false else findResult5
          else
            find6 = findResult4
          end
        end
      else
        find6 = if find4 then false else if lowerResult:find("6", 1, true) == nil then lowerResult:find("p6", 1, true) == nil else false
      end
      local find8 = normalizedText2
      find7 = normalizedText2.find
      find7 = find7(normalizedText2, "alpha", 1, true)
      find7 = find7 ~= nil
      local find9 = normalizedText2
      find8 = normalizedText2.find
      find8 = find8(normalizedText2, "thug", 1, true)
      find8 = if find8 == nil then false else not find7
      local find10 = normalizedText2
      find9 = normalizedText2.find
      find9 = find9(normalizedText2, "police", 1, true)
      find9 = find9 ~= nil or normalizedText2:find("corrupt", 1, true) ~= nil or normalizedText2:find("bertrude", 1, true) ~= nil
      local find11 = normalizedText2
      find10 = normalizedText2.find
      find10 = find10(normalizedText2, "zombie", 1, true)
      find10 = find10 ~= nil or normalizedText2:find("dracula", 1, true) ~= nil or normalizedText2:find("henchman", 1, true) ~= nil
      local find12 = normalizedText2
      find11 = normalizedText2.find
      find11 = find11(normalizedText2, "vampire", 1, true)
      find11 = find11 ~= nil or normalizedText2:find("zeppeli", 1, true) ~= nil
      local find13 = normalizedText2
      find12 = normalizedText2.find
      find12 = find12(normalizedText2, "heaven", 1, true)
      find12 = find12 ~= nil or normalizedText2:find("ascend", 1, true) ~= nil or normalizedText2:find(" oh", 1, true) ~= nil or normalizedText2:find("over heaven", 1, true) ~= nil or normalizedText2:find("corpse", 1, true) ~= nil or normalizedText2:find("path to heaven", 1, true) ~= nil or normalizedText2:find("saint", 1, true) ~= nil
      local find14 = normalizedText2
      find13 = normalizedText2.find
      find13 = find13(normalizedText2, "dio", 1, true)
      find13 = (find13 ~= nil or normalizedText2:find("doppio", 1, true) ~= nil) and not find12
      find14 = normalizedText2.find
      find14 = find14(normalizedText2, "jotaro", 1, true)
      find14 = find14 ~= nil and normalizedText2:find("6", 1, true) == nil and normalizedText2:find("p6", 1, true) == nil and normalizedText2:find("kujo", 1, true) == nil and not find12
      if findResult and find7 then return true end
      if findResult2 and find8 then return true end
      if find2 and find9 then return true end
      if find and find10 then return true end
      if find3 and find11 then return true end
      if find4 and find12 then return true end
      if find5 and find13 then return true end
      if find6 and find14 then return true end
      return false
    end
    return false
  end
  return false
end
function sourceContext.callback111()
  local entries14 = {}
  local playerGui3 = sourceContext.player:FindFirstChild("PlayerGui")
  local quests = playerGui3 and playerGui3:FindFirstChild("HUD") and playerGui3.HUD:FindFirstChild("Main") and playerGui3.HUD.Main:FindFirstChild("Frames") and playerGui3.HUD.Main.Frames:FindFirstChild("Quest") and playerGui3.HUD.Main.Frames.Quest:FindFirstChild("Quests")
  if quests then
    for k, v in ipairs(quests:GetChildren()) do
      if v:IsA("GuiObject") and v.Visible and v.Name ~= "Sample" then
        local name = v.Name
        local progress = v:FindFirstChild("Progress")
        local curProg, maxProg = (progress and progress.Text or ""):match("(%d+)%s*/%s*(%d+)")
        curProg = tonumber(curProg) or 0
        maxProg = tonumber(maxProg) or 0
        table.insert(entries14, { name = name, frame = v, curProg = curProg, maxProg = maxProg, isCompleted = maxProg > 0 and maxProg <= curProg })
      end
    end
  end
  return entries14
end
function sourceContext.callback112(a, b)
  if a then
    local entries14 = sourceContext.callback111()
    for k, v in ipairs(entries14) do if sourceContext.callback110(v.name, a, b) and not v.isCompleted then return true, v.curProg, v.maxProg end end
    local playerStats = sourceContext.player:FindFirstChild("PlayerStats")
    local Text6 = playerStats and playerStats:FindFirstChild("Quest") and playerStats.Quest.Value or ""
    local count17 = playerStats and playerStats:FindFirstChild("QuestProgress") and playerStats.QuestProgress.Value or 0
    local count18 = playerStats and playerStats:FindFirstChild("QuestMaxProgress") and playerStats.QuestMaxProgress.Value or 0
    if sourceContext.callback110(Text6, a, b) then
      local entry18 = count18 > 0 and count18 <= count17
      if not entry18 then return true, count17, count18 end
    end
    return false, 0, 0
  end
  return false, 0, 0
end
function sourceContext.callback113(a, b, c)
  if sourceContext.callback112(b, c) then return true end
  local v14 = sourceContext.callback108(a)
  if not v14 then
    local entries14 = {}
    local nPCs = workspace:FindFirstChild("NPCs")
    local living = workspace:FindFirstChild("Living")
    local workspace3 = workspace
    entries14[1] = nPCs
    entries14[2] = living
    entries14[3] = workspace3
    nPCs = ipairs
    living = entries14
    local ipairs2Result, entry18, entry19 = nPCs(entries14)
    for k2, v2 in ipairs2Result, entry18, entry19 do
      if v2 and not v14 then
        local ipairsResult, entry20, entry23 = ipairs(v2:GetChildren())
        for k, v in ipairsResult, entry20, entry23 do
          if v:IsA("Model") and not sourceContext.playersService:GetPlayerFromCharacter(v) then
            local Name = v.Name
            Name = Name:lower()
            local lowerResult = tostring(a):lower()
            local findResult = Name:find(lowerResult, 1, true)
            if findResult or lowerResult:find(Name, 1, true) then
              v14 = v
              break
            end
          end
        end
      end
    end
  end
  if v14 then
    local rootPart5 = v14:FindFirstChild("HumanoidRootPart")
    rootPart5 = rootPart5 or v14.PrimaryPart or v14:FindFirstChild("Torso") or v14:FindFirstChild("UpperTorso") or v14:FindFirstChild("Head") or v14:FindFirstChildOfClass("BasePart")
    local Character = sourceContext.player.Character
    local rootPart6 = Character and Character:FindFirstChild("HumanoidRootPart")
    local humanoid3 = Character and Character:FindFirstChildOfClass("Humanoid")
    if rootPart6 and rootPart5 then
      sourceContext.callback103("quest")
      local cFrame2 = rootPart5.CFrame
      cFrame2 = cFrame2 + rootPart5.CFrame.LookVector * 3
      if moveCharacterTo then
        moveCharacterTo(cFrame2)
      elseif travelToInstant then travelToInstant(cFrame2) else rootPart6.CFrame = CFrame.new(cFrame2.Position, rootPart5.Position) end
      rootPart6.CFrame = CFrame.new(cFrame2.Position, rootPart5.Position)
      rootPart6.AssemblyLinearVelocity = Vector3.zero
      rootPart6.AssemblyAngularVelocity = Vector3.zero
      if humanoid3 then
        humanoid3.Jump = false
        pcall(function() humanoid3:ChangeState(Enum.HumanoidStateType.Running) end)
      end
      local function callback23()
        pcall(function()
          if rootPart6 and rootPart6.Parent then
            rootPart6.AssemblyLinearVelocity = Vector3.zero
            rootPart6.AssemblyAngularVelocity = Vector3.zero
          end
          if humanoid3 and humanoid3.Parent then humanoid3.Jump = false end
        end)
      end
      local proximityPrompt5 = v14:FindFirstChildWhichIsA("ProximityPrompt", true)
      local function callback58()
        if proximityPrompt5 then
          pcall(function() fireproximityprompt(proximityPrompt5) end)
          pcall(function()
            if type(firesignal) == "function" then firesignal(proximityPrompt5.Triggered, sourceContext.player) end
          end)
        end
      end
      local dialogue = v14:FindFirstChild("Dialogue")
      local name2 = dialogue and dialogue.Value or v14.Name
      local remoteEvent2 = Character and Character:FindFirstChild("RemoteEvent")
      task.wait(0.1)
      callback58()
      local tick2 = tick
      tick2 = tick2()
      local count17 = 0
      while tick() - tick2 < 6 do
        if sourceContext.enabled28 then

        end
        if humanoid3 then humanoid3.Jump = false end
        local entry24 = sourceContext.callback112(b, c)
        local playerGui3 = sourceContext.player:FindFirstChild("PlayerGui")
        local dialogue2 = playerGui3 and (playerGui3:FindFirstChild("DialogueGui") or playerGui3:FindFirstChild("Dialogue"))
        local visible = dialogue2 and dialogue2.Enabled and dialogue2:FindFirstChild("Frame") and dialogue2.Frame.Visible
        if entry24 and not visible then break end
        if visible then
          local entry26, entry27 = sourceContext.callback107(name2, remoteEvent2)
          if entry27 then
            pcall(function()
              local clickContinue = dialogue2.Frame:FindFirstChild("ClickContinue")
              if clickContinue then sourceContext.callback9(clickContinue) end
            end)
            break
          end
        elseif tick() - count17 > 0.4 then
          count17 = tick()
          callback58()
        end
        task.wait(0.05)
      end
      callback23()
      task.wait(0.05)
      sourceContext.callback107(name2, remoteEvent2)
      pcall(function()
        local playerGui3 = sourceContext.player:FindFirstChild("PlayerGui")
        local dialogueGui = playerGui3 and playerGui3:FindFirstChild("DialogueGui")
        if dialogueGui and dialogueGui:FindFirstChild("Frame") and dialogueGui.Frame.Visible then
          local clickContinue = dialogueGui.Frame:FindFirstChild("ClickContinue")
          if clickContinue then sourceContext.callback9(clickContinue) end
          local dialogueFrame = dialogueGui.Frame:FindFirstChild("DialogueFrame")
          if dialogueFrame then sourceContext.callback9(dialogueFrame) end
        end
      end)
      return true
    end
    return false
  end
  warn("[Quest Farm] Could not locate NPC for quest: " .. tostring(a))
  return false
end
function sourceContext.callback114(a)
  if a then return tostring(a):lower():gsub("[%p%s]+", " "):gsub("^%s+", ""):gsub("%s+$", "") end
  return ""
end
function sourceContext.callback115(a)
  if a then
    local lowerResult = tostring(a):lower()
    return lowerResult:find("heaven", 1, true) ~= nil or lowerResult:find("ascen", 1, true) ~= nil or lowerResult:find("dio oh", 1, true) ~= nil or lowerResult:find("over heaven", 1, true) ~= nil or lowerResult:find("dio (oh)", 1, true) ~= nil
  end
  return false
end
function sourceContext.callback116(a)
  if a then
    local lowerResult = tostring(a):lower()
    local findResult = lowerResult:find("heaven", 1, true)
    if not findResult and not lowerResult:find("ascen", 1, true) then
      if lowerResult ~= "jotaro kujo" and lowerResult:find("^jotaro kujo") == nil and lowerResult:find("jotaro kujo") == nil then
        return lowerResult:find("jotaro", 1, true) ~= nil and (lowerResult:find("kujo", 1, true) ~= nil or lowerResult:find("6", 1, true) ~= nil or lowerResult:find("p6", 1, true) ~= nil or lowerResult:find("part 6", 1, true) ~= nil or lowerResult:find("part6", 1, true) ~= nil)
      end
      return true
    end
    return false
  end
  return false
end
function sourceContext.callback117(a)
  if a then return tostring(a):lower():find("alpha", 1, true) ~= nil end
  return false
end
function sourceContext.callback118(a)
  if a then
    local normalizedText2 = tostring(a):lower():gsub("[%p%s]+", "")
    return normalizedText2 == "deo" or normalizedText2:find("^deo", 1, true) ~= nil
  end
  return false
end
function sourceContext.callback119(a)
  if a then return tostring(a):lower():find("diavolo", 1, true) ~= nil end
  return false
end
function sourceContext.callback120(a)
  if a then
    if not sourceContext.callback115(a) and not sourceContext.callback118(a) and not sourceContext.callback119(a) then
      local normalizedText2 = tostring(a):lower():gsub("[%p%s]+", " ")
      return normalizedText2 == "dio" or normalizedText2:find("^dio ") ~= nil or normalizedText2:find(" dio") ~= nil or normalizedText2:find("dio brando") ~= nil
    end
    return false
  end
  return false
end
function sourceContext.callback121(a)
  if a then
    if not sourceContext.callback116(a) and not sourceContext.callback115(a) then
      local lowerResult = tostring(a):lower()
      return (lowerResult == "jotaro" or lowerResult:find("^jotaro") ~= nil or lowerResult:find("jotaro %(") ~= nil or lowerResult:find("jotaro p3") ~= nil or lowerResult:find("jotaro part 3") ~= nil) and not lowerResult:find("kujo", 1, true) and not lowerResult:find("6", 1, true) and not lowerResult:find("p6", 1, true) and not lowerResult:find("heaven", 1, true)
    end
    return false
  end
  return false
end
function sourceContext.callback122(a, b)
  if a and b then
    if a == b then return true end
    local entry18 = sourceContext.callback114(a)
    local entry19 = sourceContext.callback114(b)
    if entry18 == entry19 then return true end
    local normalizedText2 = entry18:gsub("[%p]", "")
    local normalizedText3 = entry19:gsub("[%p]", "")
    if normalizedText2 == normalizedText3 then return true end
    local entry20 = sourceContext.callback115(b)
    local entry23 = sourceContext.callback115(a)
    if not entry20 and not entry23 then
      local entry24 = sourceContext.callback119(b)
      local entry26 = sourceContext.callback119(a)
      if not entry24 and not entry26 then
        local entry27 = sourceContext.callback118(b)
        local entry28 = sourceContext.callback118(a)
        if not entry27 and not entry28 then
          local entry29 = sourceContext.callback116(b)
          local entry30 = sourceContext.callback116(a)
          if not entry29 and not entry30 then
            local entry31 = sourceContext.callback121(b)
            local entry32 = sourceContext.callback121(a)
            if not entry31 and not entry32 then
              local entry33 = sourceContext.callback117(b)
              local entry34 = sourceContext.callback117(a)
              if not entry33 and not entry34 then
                local findResult = normalizedText3 == "thug" or normalizedText3:find("^thug") ~= nil
                local findResult2 = normalizedText2 == "thug" or normalizedText2:find("^thug") ~= nil
                if not findResult and not findResult2 then
                  local entry35 = sourceContext.callback120(b)
                  local entry36 = sourceContext.callback120(a)
                  if not entry35 and not entry36 then
                    if (normalizedText3:find("zombie") or normalizedText3:find("dracula")) and (normalizedText2:find("zombie") or normalizedText2:find("dracula")) then
                      return true
                    end
                    if normalizedText3:find("vampire") and normalizedText2:find("vampire") then return true end
                    if (normalizedText3:find("police") or normalizedText3:find("cop") or normalizedText3:find("bertrude")) and (normalizedText2:find("police") or normalizedText2:find("cop") or normalizedText2:find("bertrude")) then
                      return true
                    end
                    local findResult3 = normalizedText2:find(normalizedText3, 1, true)
                    if not findResult3 and not normalizedText3:find(normalizedText2, 1, true) then return false end
                    return true
                  end
                  return entry35 and entry36
                end
                return findResult and findResult2 and not entry33 and not entry34
              end
              return entry33 and entry34
            end
            return entry31 and entry32
          end
          return entry29 and entry30
        end
        return entry27 and entry28
      end
      return entry24 and entry26
    end
    return entry20 and entry23
  end
  return false
end
function sourceContext.callback123(a)
  if a and a.Parent then
    local humanoidRootPart = a:FindFirstChild("HumanoidRootPart")
    humanoidRootPart = humanoidRootPart or a.PrimaryPart or a:FindFirstChild("Torso") or a:FindFirstChild("UpperTorso") or a:FindFirstChild("Head")
    if humanoidRootPart and humanoidRootPart.Parent then
      local humanoid4 = a:FindFirstChildOfClass("Humanoid")
      local health = a:FindFirstChild("Health")
      local number = health and health:IsA("ValueBase") and tonumber(health.Value)
      if number and number <= 0 then return false end
      if humanoid4 then
        if humanoid4:GetState() == Enum.HumanoidStateType.Dead then return false end
        if number and number > 0 then return true end
        if humanoid4.Health <= 0 and humanoid4.MaxHealth > 0 then return false end
      end
      return true
    end
    return false
  end
  return false
end
sourceContext.settings9 = {
  ["Star Platinum"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Ora Kicks" },
  ["Star Platinum: The World"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Ora Kicks", [4] = "Skull Crusher" },
  ["The World"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Knives", [4] = "Kick Barrage" },
}
sourceContext.section5 = nil
sourceContext.section5 = {}
sourceContext.callback124 = "Chop"
sourceContext.section5[1] = "Stand Barrage"
sourceContext.section5[2] = "Stand Barrage Finisher"
sourceContext.section5[3] = "Knives"
sourceContext.section5[4] = "Gun"
sourceContext.section5[5] = "Chop"
sourceContext.settings9["The World: Alternate Universe"] = sourceContext.section5
sourceContext.settings9["King Crimson"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Chop" }
sourceContext.settings9["King Crimson Requiem"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Chop" }
sourceContext.settings9["Gold Experience"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Create Life" }
sourceContext.settings9["Gold Experience Requiem"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Scorpion Beam" }
sourceContext.settings9["Silver Chariot"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Million Pricks", [4] = "Last Shot" }
sourceContext.settings9["Chariot Requiem"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher" }
sourceContext.settings9["Crazy Diamond"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Bearing Shot", [4] = "Blood Slash" }
sourceContext.settings9["Crazy Diamond Requiem"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher" }
sourceContext.settings9["Diver Down"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher" }
sourceContext.settings9["Killer Queen"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher" }
sourceContext.settings9["Killer Queen: Bites the Dust"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher" }
sourceContext.settings9.Whitesnake = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Acid Spit" }
sourceContext.settings9["C-Moon"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Surface Inversion Punch" }
sourceContext.settings9["Made in Heaven"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Speed Slice" }
sourceContext.settings9.D4C = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher" }
sourceContext.settings9["D4C: Love Train"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher" }
sourceContext.settings9["Tusk Act 1"] = { [1] = "Nail Shots" }
sourceContext.settings9["Tusk Act 2"] = { [1] = "Nail Shots", [2] = "Golden Rectangle Nail" }
sourceContext.settings9["Tusk Act 3"] = { [1] = "Nail Shots", [2] = "Golden Rectangle Nail" }
sourceContext.settings9["Tusk Act 4"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Golden Rectangle Nail" }
sourceContext.settings9["Hermit Purple"] = { [1] = "Vine Slap", [2] = "Vine Trap" }
sourceContext.settings9["Magician's Red"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Crossfire Hurricane" }
sourceContext.settings9["Purple Haze"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Bulb Throw" }
sourceContext.settings9["Sticky Fingers"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Extend Arm" }
sourceContext.settings9["The Hand"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Erasure", [4] = "Erasure Pull" }
sourceContext.settings9["Sex Pistols"] = { [1] = "Multi Shot", [2] = "Auto Reload" }
sourceContext.settings9.Aerosmith = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Vola Barrage" }
sourceContext.settings9["Beach Boy"] = { [1] = "Hook Slash", [2] = "Auto Rod" }
sourceContext.settings9["Mr. President"] = {}
sourceContext.settings9.Anubis = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Cursed Blade" }
sourceContext.settings9["Red Hot Chili Pepper"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Lightning Jab" }
sourceContext.settings9["Soft & Wet"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Friction Plunder" }
sourceContext.settings9["Soft & Wet: Go Beyond"] = { [1] = "Stand Barrage", [2] = "Stand Barrage Finisher", [3] = "Go Beyond Bubble", [4] = "Explosive Spin" }
function sourceContext.callback125(enemy)
  local Character2 = sourceContext.player.Character
  if Character2 and Character2.Parent then
    local rootPart5 = Character2:FindFirstChild("HumanoidRootPart")
    local humanoid4 = Character2:FindFirstChildOfClass("Humanoid")
    if rootPart5 and humanoid4 and not (humanoid4.Health <= 0) then
      local remoteFunction = Character2:FindFirstChild("RemoteFunction")
      local remoteEvent2 = Character2:FindFirstChild("RemoteEvent")
      if remoteFunction and remoteEvent2 then
        local v14 = nil
        local huge = math.huge
        local entries14 = {}
        local living = workspace:FindFirstChild("Living")
        local mobSpawns2 = workspace:FindFirstChild("Mob_Spawns2")
        local nPCs = workspace:FindFirstChild("NPCs")
        local entities = workspace:FindFirstChild("Entities")
        local enemies = workspace:FindFirstChild("Enemies")
        local mobs = workspace:FindFirstChild("Mobs")
        local attachStandToTarget = workspace:FindFirstChild("Spawns")
        local map = workspace:FindFirstChild("Map")
        map = map and workspace.Map:FindFirstChild("NPCs")
        local map2 = workspace:FindFirstChild("Map")
        local spawns = map2 and workspace.Map:FindFirstChild("Spawns")
        local workspace5 = workspace
        entries14[1] = living
        entries14[2] = mobSpawns2
        entries14[3] = nPCs
        entries14[4] = entities
        entries14[5] = enemies
        entries14[6] = mobs
        entries14[7] = attachStandToTarget
        entries14[8] = map
        entries14[9] = spawns
        entries14[10] = workspace5
        local ipairsResult, entry18
        ipairsResult, entry18, nPCs = ipairs(entries14)
        entities = nil
        enemies = nil
        for k2, v2 in ipairsResult, entry18, nPCs do
          if v2 then
            local ipairsResult2, entry19, entry20 = ipairs(v2:GetChildren())
            for k, v in ipairsResult2, entry19, entry20 do
              if v:IsA("Model") and not sourceContext.playersService:GetPlayerFromCharacter(v) and sourceContext.callback122(v.Name, enemy) and sourceContext.callback123(v) then
                local humanoidRootPart = v:FindFirstChild("HumanoidRootPart")
                humanoidRootPart = humanoidRootPart or v.PrimaryPart or v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso") or v:FindFirstChild("Head")
                if humanoidRootPart then
                  local Magnitude = rootPart5.Position - humanoidRootPart.Position
                  Magnitude = Magnitude.Magnitude
                  if Magnitude < huge then
                    huge = Magnitude
                    v14 = v
                  end
                end
              end
            end
          end
        end
        if v14 then
          living = v14:FindFirstChild("HumanoidRootPart")
          local rootPart7 = living or v14.PrimaryPart or v14:FindFirstChild("Torso") or v14:FindFirstChild("UpperTorso") or v14:FindFirstChild("Head")
          if rootPart7 then
            sourceContext.callback103("quest")
            local settings7 = {
              None = true, ["Beach Boy"] = true, ["Sex Pistols"] = true, Anubis = true, ["Hermit Purple"] = true,
              ["Mr. President"] = true, ["White Album"] = true, ["Scary Monsters"] = true,
            }
            local playerStats = sourceContext.player:FindFirstChild("PlayerStats")
            local noneText = playerStats and playerStats:FindFirstChild("Stand") and playerStats.Stand.Value or "None"
            enemies = if noneText == "None" then false else not settings7[noneText]
            function mobs(a)
              local standMorph = a and a:FindFirstChild("StandMorph")
              if standMorph then
                return standMorph.PrimaryPart or standMorph:FindFirstChild("HumanoidRootPart") or standMorph:FindFirstChild("StandAttach") or standMorph:FindFirstChildWhichIsA("BasePart")
              end
              return nil
            end
            function attachStandToTarget(Enabled)
              local standMorph = Character2:FindFirstChild("StandMorph")
              local entry18 = mobs(Character2)
              local standAttach = entry18 and (entry18:FindFirstChild("StandAttach") or standMorph:FindFirstChild("StandAttach", true))
              if standAttach then
                local alignPosition = standAttach:FindFirstChildOfClass("AlignPosition")
                local alignOrientation = standAttach:FindFirstChildOfClass("AlignOrientation")
                if alignPosition then alignPosition.Enabled = Enabled end
                if alignOrientation then alignOrientation.Enabled = Enabled end
              end
            end
            local count17 = 0
            if enemies and Character2:FindFirstChild("SummonedStand") and not Character2.SummonedStand.Value then
              pcall(function() remoteFunction:InvokeServer("ToggleStand", "Toggle") end)
              map2 = tick()
              count17 = map2
              task.wait(0.15)
            end
            if enemies then
              map2 = attachStandToTarget
              map2(false)
            end
            spawns = sourceContext.callback29(noneText)
            workspace5 = rootPart7.Position
            local cFrame2 = rootPart7.CFrame
            local entry23 = mobs
            entry23 = entry23(Character2)
            local cFrame3
            cFrame3 = if enemies and entry23 then cFrame2 + cFrame2.LookVector * -1.1 - Vector3.new(0, 27, 0) else cFrame2 * CFrame.new(0, -spawns, 0) * CFrame.Angles(math.rad(90), 0, 0)
            rootPart5.CFrame = cFrame3
            rootPart5.AssemblyLinearVelocity = Vector3.zero
            rootPart5.AssemblyAngularVelocity = Vector3.zero
            local Heartbeat = sourceContext.runServiceService.Heartbeat
            Heartbeat = Heartbeat:Connect(function()
              local Parent = sourceContext.player.Character
              local rootPart5 = Parent and Parent:FindFirstChild("HumanoidRootPart")
              local Value = v14 and (v14:FindFirstChild("HumanoidRootPart") or v14.PrimaryPart or v14:FindFirstChild("Torso") or v14:FindFirstChild("UpperTorso") or v14:FindFirstChild("Head"))
              if rootPart5 and Value and Value.Parent and sourceContext.callback123(v14) then
                local rootPart8 = mobs(Parent)
                if enemies and rootPart8 then
                  attachStandToTarget(false)
                  rootPart8.CFrame = Value.CFrame - Value.CFrame.LookVector * 1.1
                  rootPart8.AssemblyLinearVelocity = Vector3.zero
                  rootPart8.AssemblyAngularVelocity = Vector3.zero
                  local findFirstChild2
                  rootPart5.CFrame = CFrame.new(workspace5 - Vector3.new(0, 27, 0)) * CFrame.Angles(math.rad(90), 0, 0)
                  rootPart5.AssemblyLinearVelocity = Vector3.zero
                  rootPart5.AssemblyAngularVelocity = Vector3.zero
                  findFirstChild2 = Parent.FindFirstChild
                  findFirstChild2 = findFirstChild2(Parent, "FocusCam")
                  if not findFirstChild2 then
                    findFirstChild2 = Instance.new("ObjectValue")
                    findFirstChild2.Name = "FocusCam"
                    findFirstChild2.Parent = Parent
                  end
                  findFirstChild2.Value = Value
                else
                  local findFirstChild3
                  rootPart5.CFrame = CFrame.new(Value.Position - Vector3.new(0, spawns, 0)) * CFrame.Angles(math.rad(90), 0, 0)
                  rootPart5.AssemblyLinearVelocity = Vector3.zero
                  rootPart5.AssemblyAngularVelocity = Vector3.zero
                  findFirstChild3 = Parent.FindFirstChild
                  findFirstChild3 = findFirstChild3(Parent, "FocusCam")
                  if not findFirstChild3 then
                    findFirstChild3 = Instance.new("ObjectValue")
                    findFirstChild3.Name = "FocusCam"
                    findFirstChild3.Parent = Parent
                  end
                  findFirstChild3.Value = Value
                end
              end
            end)
            local enabled30, connectResult8 = false, nil
            local count18 = playerStats and playerStats:FindFirstChild("QuestProgress") and playerStats.QuestProgress.Value or 0
            local Text6 = playerStats and playerStats:FindFirstChild("Quest") and playerStats.Quest.Value or ""
            local curProg = 0
            local ipairsResult5, entry24, count19 = ipairs(sourceContext.callback111())
            for k3, v3 in ipairsResult5, entry24, count19 do
              if sourceContext.callback110(v3.name, { enemy = enemy }, enemy) or sourceContext.callback122(v3.name, enemy) then
                curProg = v3.curProg
                break
              end
            end
            pcall(function()
              connectResult8 = sourceContext.player.PlayerGui.HUD.Main.DropMoney.Money.ChildAdded:Connect(function(a)
                local number = tonumber(string.match(a.Name, "%d+"))
                if number then enabled30 = true end
              end)
            end)
            local function callback23(a, b)
              task.spawn(function() pcall(function() if remoteFunction then remoteFunction:InvokeServer(a, b) end end) end)
            end
            local function callback58(a, b)
              task.spawn(function() pcall(function() if remoteEvent2 then remoteEvent2:FireServer(a, b) end end) end)
            end
            count19 = 0
            local count20 = tick() + 25
            local entry26, count21 = count17, 0
            while (sourceContext.enabled28 or sourceContext.enabled29) and tick() < count20 do
              local humanoid5 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("Humanoid")
              if not humanoid5 then break end
              if humanoid5.Health <= 0 then break end
              if enabled30 then break end
              if playerStats and playerStats:FindFirstChild("Quest") and playerStats.Quest.Value == Text6 and playerStats:FindFirstChild("QuestProgress") and count18 < playerStats.QuestProgress.Value then
                enabled30 = true
                break
              end
              if sourceContext.enabled28 and playerStats and playerStats:FindFirstChild("QuestProgress") and playerStats:FindFirstChild("QuestMaxProgress") and playerStats.QuestMaxProgress.Value > 0 and playerStats.QuestMaxProgress.Value <= playerStats.QuestProgress.Value then
                enabled30 = true
                break
              end
              for k4, v4 in ipairs(sourceContext.callback111()) do
                if (sourceContext.callback110(v4.name, { enemy = enemy }, enemy) or sourceContext.callback122(v4.name, enemy)) and (curProg < v4.curProg or v4.isCompleted) then
                  enabled30 = true
                  break
                end
              end
              if enabled30 then break end
              if not sourceContext.callback123(v14) then
                enabled30 = true
                break
              end
              local humanoid6 = v14:FindFirstChildOfClass("Humanoid")
              local health = v14:FindFirstChild("Health")
              if (not humanoid6 or not (humanoid6.Health <= 0) or not (humanoid6.MaxHealth > 0)) and (not health or not health:IsA("ValueBase") or not tonumber(health.Value) or not (tonumber(health.Value) <= 0)) then
                if enemies then
                  local Character = sourceContext.player.Character
                  local summonedStand = Character and Character:FindFirstChild("SummonedStand")
                  local enabled31 = summonedStand and summonedStand.Value == true
                  if not enabled31 and tick() - entry26 > 0.35 then
                    entry26 = tick()
                    pcall(function() if remoteFunction then remoteFunction:InvokeServer("ToggleStand", "Toggle") end end)
                  end
                end
                local collectionServiceService = game:GetService("CollectionService")
                if collectionServiceService:HasTag(v14, "Blocking") then
                  callback58("InputBegan", { Input = Enum.KeyCode.R })
                  callback23("Attack", "m2")
                else
                  local timestamp3 = tick()
                  if timestamp3 - count21 > 0.12 and noneText ~= "None" then
                    count21 = timestamp3
                    local entry27 = sourceContext.settings9[noneText]
                    if entry27 then
                      for k5, v5 in ipairs(entry27) do callback23("SpecialMove", { Skill = v5 }) end
                    else
                      callback23("SpecialMove", { Skill = "Stand Barrage" })
                      callback23("SpecialMove", { Skill = "Stand Barrage Finisher" })
                    end
                  end
                  for i = 1, 5 do callback23("Attack", "m1") end
                end
                local entry28 = playerStats and playerStats:FindFirstChild("Spec") and playerStats.Spec.Value
                local hamon = entry28 and entry28:lower():find("hamon") or Character2 and Character2:FindFirstChild("Hamon")
                if hamon and Character2:FindFirstChild("Hamon") and Character2.Hamon.Value < 80 then callback23("ChargeHamon") end
                task.wait()
              end
              enabled30 = true
              break
            end
            if connectResult8 then connectResult8:Disconnect() end
            if Heartbeat then Heartbeat:Disconnect() end
            pcall(function()
              local focusCam = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("FocusCam")
              if focusCam then focusCam:Destroy() end
            end)
            if enemies then attachStandToTarget(true) end
            pcall(function()
              local Character = sourceContext.player.Character
              local rootPart5 = Character and Character:FindFirstChild("HumanoidRootPart")
              if rootPart5 then
                local head = v14 and (v14:FindFirstChild("HumanoidRootPart") or v14.PrimaryPart or v14:FindFirstChild("Torso") or v14:FindFirstChild("Head"))
                local position5 = head and head.Position or rootPart7 and rootPart7.Position
                if position5 then rootPart5.CFrame = CFrame.new(position5 + Vector3.new(0, 3.5, 0)) else rootPart5.CFrame = rootPart5.CFrame + Vector3.new(0, 28, 0) end
                rootPart5.AssemblyLinearVelocity = Vector3.zero
                rootPart5.AssemblyAngularVelocity = Vector3.zero
              end
            end)
            return enabled30
          end
          return false
        end
        task.wait(0.2)
        return false
      end
      return false
    end
    return false
  end
  return false
end
sourceContext.section5 = sourceContext.Farming.Section
sourceContext.section5 = sourceContext.section5(sourceContext.Farming, { Side = "Right", Name = "Quest & NPC Farm" })
sourceContext.section5.Header(sourceContext.section5, { Text = "Quest Farm", AutoLocalize = false })
sourceContext.toggle2 = sourceContext.section5.Toggle
sourceContext.questFarmOptions = { Name = "Quest Farm" }
sourceContext.callback124 = sourceContext.callback35
sourceContext.callback124 = sourceContext.callback35("QF_Enabled", false)
sourceContext.questFarmOptions.Default = sourceContext.callback124
function sourceContext.callback124(a)
  sourceContext.enabled28 = a
  sourceContext.callback34("QF_Enabled", a)
  if a then
    if sourceContext.enabled29 then
      sourceContext.enabled29 = false
      sourceContext.callback34("QF_NpcFarm", false)
    end
    sourceContext.notify("Quest Farm", "Quest Farm started.")
    task.spawn(function()
      local count17, playerStats, entry18, entry19, entry20, entry23, entry24, entry26, entry27, entry28, entry29, entry30, entry31
      count17 = 0
      while sourceContext.enabled28 do
        playerStats = sourceContext.player:FindFirstChild("PlayerStats")
        if playerStats then
          entry18 = sourceContext.callback105(sourceContext.Default)
          entry19 = sourceContext.settings8[entry18] or sourceContext.settings8["Officer Sam [Lvl. 1+]"]
          entry20, entry23, entry24 = sourceContext.callback112(entry19, entry18)
          if entry20 then
            entry26 = count17
          else
            local timestamp3
            if tick() - count17 > 3 then
              timestamp3 = tick()
              sourceContext.notify("Quest Farm", "Taking quest from " .. tostring(entry19.npc))
            else
              timestamp3 = count17
            end
            sourceContext.callback113(entry19.npc, entry19, entry18)
            task.wait(0.1)
            entry27, entry28, entry29 = sourceContext.callback112(entry19, entry18)
            if not entry27 then
              task.wait(0.2)
              count17 = timestamp3
              continue
            end
            entry26 = timestamp3
          end
          sourceContext.callback125(entry19.enemy)
          task.wait(0.05)
          count17 = entry26
        else
          task.wait(0.5)
        end
      end
      sourceContext.callback104("quest")
      sourceContext.notify("Quest Farm", "Quest Farm stopped.")
    end)
  else
    sourceContext.callback104("quest")
    sourceContext.notify("Quest Farm", "Quest Farm disabled.")
  end
end
sourceContext.questFarmOptions.Callback = sourceContext.callback124
sourceContext.toggle2(sourceContext.section5, sourceContext.questFarmOptions)
sourceContext.questFarmOptions = "Dropdown"
sourceContext.toggle2 = sourceContext.section5.Dropdown
sourceContext.selectQuestOptions = { Name = "Select Quest", Options = sourceContext.Options, Default = sourceContext.Default }
function sourceContext.callback124(a)
  sourceContext.Default = a or sourceContext.Options[1]
  sourceContext.callback34("QF_Quest", sourceContext.Default)
end
sourceContext.selectQuestOptions.Callback = sourceContext.callback124
sourceContext.toggle2(sourceContext.section5, sourceContext.selectQuestOptions)
sourceContext.selectQuestOptions = "Header"
sourceContext.section5.Header(sourceContext.section5, { Text = "Direct NPC Farm", AutoLocalize = false })
sourceContext.toggle2 = sourceContext.section5.Toggle
sourceContext.farmTargetNPCOptions = { Name = "Farm Target NPC" }
sourceContext.callback124 = sourceContext.callback35
sourceContext.callback124 = sourceContext.callback35("QF_NpcFarm", false)
sourceContext.farmTargetNPCOptions.Default = sourceContext.callback124
function sourceContext.callback124(a)
  sourceContext.enabled29 = a
  sourceContext.callback34("QF_NpcFarm", a)
  if a then
    if sourceContext.enabled28 then
      sourceContext.enabled28 = false
      sourceContext.callback34("QF_Enabled", false)
    end
    sourceContext.notify("NPC Farm", "NPC Farm started for " .. tostring(sourceContext.Default2))
    task.spawn(function()
      while sourceContext.enabled29 do
        local entry18 = sourceContext.callback125(sourceContext.Default2)
        if entry18 then task.wait(0.05) else task.wait(0.3) end
      end
      sourceContext.callback104("quest")
      sourceContext.notify("NPC Farm", "NPC Farm stopped.")
    end)
  else
    sourceContext.callback104("quest")
    sourceContext.notify("NPC Farm", "NPC Farm disabled.")
  end
end
sourceContext.farmTargetNPCOptions.Callback = sourceContext.callback124
sourceContext.toggle2(sourceContext.section5, sourceContext.farmTargetNPCOptions)
sourceContext.farmTargetNPCOptions = "Dropdown"
sourceContext.toggle2 = sourceContext.section5.Dropdown
sourceContext.selectNPCOptions = { Name = "Select NPC", Options = sourceContext.Options2, Default = sourceContext.Default2 }
function sourceContext.callback124(a)
  sourceContext.Default2 = a or "Thug"
  sourceContext.callback34("QF_TargetNPC", sourceContext.Default2)
end
sourceContext.selectNPCOptions.Callback = sourceContext.callback124
sourceContext.toggle2 = sourceContext.toggle2(sourceContext.section5, sourceContext.selectNPCOptions)
npcDropdown = sourceContext.toggle2
sourceContext.toggle2 = { ["jotaro kujo"] = true }
sourceContext.ipairsResult5, sourceContext.entry29, sourceContext.entry30 = ipairs(sourceContext.Options2)
for k8, v8 in sourceContext.ipairsResult5, sourceContext.entry29, sourceContext.entry30 do
  local lowerResult = v8:lower()
  sourceContext.toggle2[lowerResult] = true
end
sourceContext.enabled31 = false
function sourceContext.entry29()
  if not (npcDropdown and not sourceContext.enabled31) then return end
  sourceContext.enabled31 = true
  local settings7 = {
    [1] = "stand", [2] = "morph", [3] = "clone", [4] = "camera", [5] = "tree", [6] = "punch", [7] = "victim",
    [8] = "effect", [9] = "part", [10] = "arm", [11] = "head", [12] = "debris",
  }
  local entries14 = {}
  local living = workspace:FindFirstChild("Living")
  local mobSpawns2 = workspace:FindFirstChild("Mob_Spawns2")
  local workspace4 = workspace
  entries14[1] = living
  entries14[2] = mobSpawns2
  entries14[3] = workspace4:FindFirstChild("NPCs")
  living = ipairs
  mobSpawns2 = entries14
  for k3, v3 in living(entries14) do
    if v3 then
      for k2, v2 in ipairs(v3:GetChildren()) do
        if v2:IsA("Model") and not sourceContext.playersService:GetPlayerFromCharacter(v2) and v2:FindFirstChildOfClass("Humanoid") then
          local normalizedText2 = v2.Name:gsub("^%s+", ""):gsub("%s+$", "")
          local lowerResult = normalizedText2:lower()
          if #normalizedText2 > 1 and not sourceContext.toggle2[lowerResult] then
            local enabled32 = false
            for k, v in ipairs(settings7) do
              local findResult = lowerResult:find(v, 1, true)
              if findResult then
                enabled32 = true
                break
              end
            end
            if not enabled32 then
              sourceContext.toggle2[lowerResult] = true
              table.insert(sourceContext.Options2, normalizedText2)
              pcall(function()
                if npcDropdown.InsertOptions then
                  local npcDropdown2 = npcDropdown
                  npcDropdown2.InsertOptions(npcDropdown2, { [1] = normalizedText2 })
                end
              end)
            end
          end
        end
      end
    end
  end
  living = false
  sourceContext.enabled31 = false
end
task.spawn(function()
  sourceContext.entry29()
  pcall(function()
    if workspace:FindFirstChild("Living") then
      workspace.Living.ChildAdded:Connect(function()
        task.wait(1.5)
        sourceContext.entry29()
      end)
    end
    if workspace:FindFirstChild("Mob_Spawns2") then
      workspace.Mob_Spawns2.ChildAdded:Connect(function()
        task.wait(1.5)
        sourceContext.entry29()
      end)
    end
  end)
end)
sourceContext.settings10 = { standFarmRunning = false, ribFarmRunning = false, shinyFarmRunning = false }
function sourceContext.entry31()
  local savedStandFarmKeep = sourceContext.callback35 and sourceContext.callback35("StandFarmKeep")
  if type(savedStandFarmKeep) == "table" then
    local entries14 = {}
    for k, v in ipairs(savedStandFarmKeep) do if type(v) == "string" then table.insert(entries14, v) end end
    return entries14
  end
  return {}
end
sourceContext.settings10.standFarmTarget = sourceContext.entry31()
sourceContext.settings10.shinyFarmTarget = {}
sourceContext.entry31 = sourceContext.callback35
sourceContext.settings10.keepAnyShiny = sourceContext.callback35("SKS", false)
sourceContext.settings10.farmMethod = sourceContext.callback35 and sourceContext.callback35("SFM", "Arrow") or "Arrow"
sourceContext.settings10.farmStats = { arrowsUsed = 0, rokasUsed = 0, ribsUsed = 0, luckyArrowsUsed = 0, standsGot = 0, startTime = 0 }
sourceContext.entry31 = nil
sourceContext.settings10.standFarmRespawnConn = nil
sourceContext.settings10.ribFarmRespawnConn = nil
sourceContext.settings10.shinyFarmRespawnConn = nil
function sourceContext.settings10.getFarmMethod() return sourceContext.settings10.farmMethod end
function sourceContext.settings10.setFarmMethod(a) sourceContext.settings10.farmMethod = a or "Arrow" end
function sourceContext.settings10.setKeepAnyShiny(keepAnyShiny)
  sourceContext.settings10.keepAnyShiny = keepAnyShiny
end
do
  local function callback126(...)
    return sourceContext.environment2.sfCountItem and sourceContext.environment2.sfCountItem(...)
  end
  local function callback127(...)
    return sourceContext.environment2.moveCharacterTo and sourceContext.environment2.moveCharacterTo(...)
  end
  local function callback128(...)
    return sourceContext.environment2.farmItemByName and sourceContext.environment2.farmItemByName(...)
  end
  local function callback129(...)
    return sourceContext.environment2.serverHopToRandom and sourceContext.environment2.serverHopToRandom(...)
  end
  local function callback130(...)
    return sourceContext.environment2.normalizeItemName and sourceContext.environment2.normalizeItemName(...)
  end
  local entries15 = sourceContext.environment2.maxLimits or {}
  local function callback131()
    return sourceContext.environment2.serverHopFarmEnabled and sourceContext.environment2.serverHopFarmEnabled() or not sourceContext.callback35 or sourceContext.callback35("SHF", true) or true
  end
  local function callback132(...)
    if not sourceContext.environment2.enableNoclipState then return end
    return sourceContext.environment2.enableNoclipState(...)
  end
  local function callback133(...)
    if not sourceContext.environment2.disableNoclipState then return end
    return sourceContext.environment2.disableNoclipState(...)
  end
  local function callback134(...)
    if not sourceContext.environment2.cleanupItemStick then return end
    return sourceContext.environment2.cleanupItemStick(...)
  end
  local standFarmPosition5 = CFrame.new(914.264832, 126.484932, -194.080887, 0.0349707194, 1.18272225e-9, 0.999388337, -5.95965366e-9, 1, -9.74905157e-10, -0.999388337, -5.9219154e-9, 0.0349707194)
  sourceContext.settings10.standFarmPosition = standFarmPosition5
  local function sfNotify(a) sourceContext.notify("Stand Farm", a) end
  sourceContext.settings10.sfNotify = sfNotify
  local function sfCheckShiny()
    local Character = sourceContext.player.Character
    if Character then
      local remoteFunction2 = Character:FindFirstChild("RemoteFunction") or Character:WaitForChild("RemoteFunction", 5)
      if remoteFunction2 then
        local pcallResult, entry18 = pcall(function() return remoteFunction2:InvokeServer("ReturnStandSkin", "Stand") end)
        return pcallResult and entry18 or "None"
      end
      return "None"
    end
    return "None"
  end
  sourceContext.settings10.sfCheckShiny = sfCheckShiny
  local function sfNormalizeStandName(a)
    if a then return tostring(a):lower():gsub("[^%a%d]", "") end
    return ""
  end
  sourceContext.settings10.sfNormalizeStandName = sfNormalizeStandName
  local function sfFindTable(entries14, b)
    if entries14 and type(entries14) == "table" then
      local sfNormalizeStandNameResult = sfNormalizeStandName(b)
      for k, v in ipairs(entries14) do if v == b or sfNormalizeStandName(v) == sfNormalizeStandNameResult then return true end end
      return false
    end
    return false
  end
  sourceContext.settings10.sfFindTable = sfFindTable
  function sfLearnWorthiness(a)
    local Character = sourceContext.player.Character
    if Character then
      if not a and Character:GetAttribute("WorthinessLearned") then return true end
      local remoteFunction3 = Character:FindFirstChild("RemoteFunction")
      if not remoteFunction3 then
        local timestamp3 = tick()
        while tick() - timestamp3 < 2 do
          remoteFunction3 = Character:FindFirstChild("RemoteFunction")
          if remoteFunction3 and remoteFunction3:IsA("RemoteFunction") then break end
          task.wait(0.05)
        end
      end
      if remoteFunction3 and remoteFunction3:IsA("RemoteFunction") then
        pcall(function() Character:SetAttribute("WorthinessLearned", true) end)
        local settings7 = { [1] = "Agility I", [2] = "Agility II", [3] = "Agility III", [4] = "Worthiness" }
        for k, v in ipairs(settings7) do
          pcall(function() remoteFunction3:InvokeServer("LearnSkill", { Skill = v, SkillTreeType = "Character" }) end)
          task.wait(0.03)
        end
        return true
      end
      return false
    end
    return false
  end
  local function callback135(a, b)
    pcall(function()
      local Text
      repeat
        sourceContext.callback6(a.Frame.ClickContinue.MouseButton1Click)
        task.wait(0.1)
        local Options2 = a.Frame.Options
        Options2 = Options2:FindFirstChild("Option1")
      until Options2
      local Options = a.Frame.Options
      Options = Options:FindFirstChild("Option1")
      if Options and Options:FindFirstChild("TextButton") then
        local TextButton = Options.TextButton
        pcall(function()
          for k, v in pairs(sourceContext.callback7(TextButton.MouseButton1Click)) do pcall(function() v:Fire() end) end
        end)
        sourceContext.callback6(TextButton.MouseButton1Click)
        sourceContext.callback6(TextButton.Activated)
        local remoteEvent3
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.05)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
        remoteEvent3 = b:FindFirstChild("RemoteEvent")
        if remoteEvent3 then remoteEvent3.FireServer(remoteEvent3, "EndDialogue", { NPC = a.Name, Option = "Option1", Dialogue = "Dialogue2" }) end
      end
      repeat
        sourceContext.callback6(a.Frame.ClickContinue.MouseButton1Click)
        task.wait(0.1)
        Text = a.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text
      until Text == "You"
      sourceContext.callback6(a.Frame.ClickContinue.MouseButton1Click)
    end)
  end
  function useItemDirect(a, b, c, d)
    c = c or "Dialogue2"
    d = d or "Option1"
    local Character = sourceContext.player.Character
    local remoteEvent3 = Character and Character:FindFirstChild("RemoteEvent")
    if remoteEvent3 then
      local findFirstChildResult = sourceContext.player.Backpack:FindFirstChild(a)
      findFirstChildResult = findFirstChildResult or Character and Character:FindFirstChild(a)
      if not findFirstChildResult and callback130 then
        local entry18 = callback130(a)
        local ipairsResult, entry19, entry20 = ipairs({ [1] = sourceContext.player.Backpack, [2] = Character })
        for k2, v2 in ipairsResult, entry19, entry20 do
          if v2 then
            for k, v in ipairs(v2:GetChildren()) do
              if v:IsA("Tool") and callback130(v.Name) == entry18 then
                findFirstChildResult = v
                break
              end
            end
          end
          if findFirstChildResult then break end
        end
      end
      if findFirstChildResult then
        local humanoid4 = Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid4 then
          pcall(function() humanoid4:EquipTool(findFirstChildResult) end)
          task.wait(0.06)
          if type(firesignal) == "function" then
            for i = 1, 3 do
              pcall(function() game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 8, 0, true, nil, 1) end)
              task.wait(0.03)
            end
            local dialogueGui = nil
            local timestamp3 = tick()
            while tick() - timestamp3 < 1.5 do
              dialogueGui = sourceContext.player.PlayerGui:FindFirstChild("DialogueGui")
              if dialogueGui then break end
              task.wait(0.03)
            end
            if dialogueGui then
              pcall(function()
                local Text
                repeat
                  sourceContext.callback6(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                  task.wait(0.03)
                  local Options = dialogueGui.Frame.Options
                  Options = Options:FindFirstChild("Option1")
                until Options
                local option1 = dialogueGui.Frame.Options:FindFirstChild("Option1")
                if option1 and option1:FindFirstChild("TextButton") then
                  sourceContext.callback6(option1.TextButton.MouseButton1Click)
                  sourceContext.callback6(option1.TextButton.Activated)
                end
                repeat
                  sourceContext.callback6(dialogueGui.Frame.ClickContinue.MouseButton1Click)
                  task.wait(0.03)
                  Text = dialogueGui.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text
                until Text == "You"
                sourceContext.callback6(dialogueGui.Frame.ClickContinue.MouseButton1Click)
              end)
            end
            pcall(function() remoteEvent3:FireServer("EndDialogue", { NPC = b or a, Option = d, Dialogue = c }) end)
            return true
          end
          local timestamp4 = tick()
          repeat
            pcall(function() findFirstChildResult:Activate() end)
            task.wait(0.05)
            local playerGui3 = sourceContext.player.PlayerGui
            local entry23 = playerGui3
            playerGui3 = playerGui3.FindFirstChild
          until playerGui3(entry23, "DialogueGui") or tick() - timestamp4 > 1.5
          task.wait(0.05)
          pcall(function() remoteEvent3:FireServer("EndDialogue", { NPC = b or a, Option = d, Dialogue = c }) end)
          task.wait(0.05)
          local dialogueGui2 = sourceContext.player.PlayerGui:FindFirstChild("DialogueGui")
          if dialogueGui2 then
            pcall(function()
              if type(sourceContext.callback6) == "function" then sourceContext.callback6(dialogueGui2.Frame.ClickContinue.MouseButton1Click) end
            end)
          end
          return true
        end
        return false
      end
      return false
    end
    return false
  end
  function sfUseRoka(a)
    a = a or 3
    if not sourceContext.enabled9 and not getgenv()._YBA_SellingBusy then
      local count17 = 0
      sourceContext.enabled8 = true
      getgenv()._YBA_IsEatingRoka = true
      if sourceContext.settings10 then sourceContext.settings10.isEatingRoka = true end
      local enabled32 = false
      pcall(function()
        while count17 < a and sourceContext.settings10.standFarmRunning do
          local noneText = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None"
          if noneText == "None" then
            enabled32 = true
            break
          end
          if callback126("Rokakaka") == 0 then
            enabled32 = false
            break
          end
          local Character = sourceContext.player.Character
          useItemDirect("Rokakaka", "Rokakaka")
          local timestamp3 = tick()
          while tick() - timestamp3 < 5 and sourceContext.settings10.standFarmRunning do
            local noneText2 = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None"
            if noneText2 == "None" then
              local tick3
              sourceContext.settings10.farmStats.rokasUsed = sourceContext.settings10.farmStats.rokasUsed + 1
              tick3 = tick
              tick3 = tick3()
              while tick() - tick3 < 8 and sourceContext.settings10.standFarmRunning do
                local FindFirstChild
                local Character2 = sourceContext.player.Character
                if Character2 then
                  FindFirstChild = Character2.FindFirstChild
                  FindFirstChild = FindFirstChild(Character2, "HumanoidRootPart")
                else
                  FindFirstChild = Character2
                end
                local humanoid5 = Character2 and Character2:FindFirstChildOfClass("Humanoid")
                if Character2 and Character2 ~= Character and FindFirstChild and humanoid5 and humanoid5.Health > 0 and Character2.Parent == workspace.Living then
                  local timestamp4 = tick()
                  while tick() - timestamp4 < 2 and sourceContext.settings10.standFarmRunning do
                    if sourceContext.player.Backpack and #sourceContext.player.Backpack:GetChildren() > 0 then break end
                    task.wait(0.1)
                  end
                  pcall(function()
                    FindFirstChild.CFrame = standFarmPosition5
                    FindFirstChild.AssemblyLinearVelocity = Vector3.zero
                    FindFirstChild.AssemblyAngularVelocity = Vector3.zero
                  end)
                  task.wait(0.1)
                  sfLearnWorthiness()
                  enabled32 = true
                  break
                end
                task.wait(0.1)
              end
              break
            end
            task.wait(0.1)
          end
          if enabled32 then break end
          count17 = count17 + 1
          task.wait(0.5)
        end
      end)
      task.wait(0.2)
      sourceContext.enabled8 = false
      getgenv()._YBA_IsEatingRoka = false
      if sourceContext.settings10 then sourceContext.settings10.isEatingRoka = false end
      return (sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None") == "None"
    end
    return false
  end
  function sfUseArrow(a)
    a = a or 5
    local count18 = 0
    while count18 < a and sourceContext.settings10.standFarmRunning do
      local noneText = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None"
      if noneText ~= "None" then return true end
      if callback126("Mysterious Arrow") == 0 then
        sfNotify("No arrow in inventory")
        return false
      end
      sfLearnWorthiness()
      local entry18 = callback126("Mysterious Arrow")
      useItemDirect("Mysterious Arrow", "Mysterious Arrow")
      local timestamp3 = tick()
      while tick() - timestamp3 < 3 and sourceContext.settings10.standFarmRunning do
        local noneText2 = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None"
        if noneText2 ~= "None" and noneText2 ~= noneText then
          sourceContext.settings10.farmStats.arrowsUsed = sourceContext.settings10.farmStats.arrowsUsed + 1
          sourceContext.settings10.farmStats.standsGot = sourceContext.settings10.farmStats.standsGot + 1
          sfNotify("Stand obtained: " .. noneText2)
          return true
        end
        task.wait(0.1)
      end
      local entry19 = callback126("Mysterious Arrow")
      if entry19 < entry18 then
        sourceContext.settings10.farmStats.arrowsUsed = sourceContext.settings10.farmStats.arrowsUsed + 1
        local tick2 = tick
        tick2 = tick2()
        while tick() - tick2 < 2 and sourceContext.settings10.standFarmRunning do
          local noneText3 = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None"
          if noneText3 ~= "None" then
            sourceContext.settings10.farmStats.standsGot = sourceContext.settings10.farmStats.standsGot + 1
            return true
          end
          task.wait(0.1)
        end
      else
        warn("[sfUseArrow] arrow NOT consumed (before=" .. tostring(entry18) .. " after=" .. tostring(entry19) .. "), Stand=" .. tostring(sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value))
      end
      count18 = count18 + 1
      task.wait(2)
    end
    return (sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None") ~= "None"
  end
  function sfUseRib()
    local Character = sourceContext.player.Character
    if not Character then return end
    if not Character:FindFirstChild("RemoteEvent") then return end
    sourceContext.settings10.farmStats.ribsUsed = sourceContext.settings10.farmStats.ribsUsed + 1
    useItemDirect("Rib Cage of The Saint's Corpse", "Rib Cage of The Saint's Corpse")
  end
  function sfUseRokaDirect()
    sourceContext.enabled8 = true
    local useItemDirectResult = useItemDirect("Rokakaka", "Rokakaka")
    task.spawn(function()
      task.wait(3)
      sourceContext.enabled8 = false
    end)
    return useItemDirectResult
  end
  function skipCurrentShinyStand()
    local playerStats = sourceContext.player:FindFirstChild("PlayerStats")
    local noneText = playerStats and playerStats:FindFirstChild("Stand") and playerStats.Stand.Value or "None"
    if noneText == "None" then
      sourceContext.notify("Stand Farm", "No stand to skip.")
      return
    end
    local sfCheckShinyResult = sfCheckShiny()
    if sfCheckShinyResult and sfCheckShinyResult ~= "None" and sfCheckShinyResult ~= "" then
      if sourceContext.settings10.farmMethod == "Rib Cage" then
        if callback126("Rib Cage of The Saint's Corpse") < 1 then
          sourceContext.notify("Stand Farm", "No Rib Cage available to skip shiny.")
          return
        end
        sfLearnWorthiness()
        sfUseRib()
        sourceContext.notify("Stand Farm", "Skipping shiny stand with Rib Cage...")
        return
      end
      if callback126("Rokakaka") < 1 then
        sourceContext.notify("Stand Farm", "No Rokakaka available to skip shiny.")
        return
      end
      if sfUseRokaDirect() then sourceContext.notify("Stand Farm", "Skipping shiny stand with Rokakaka...") else sourceContext.notify("Stand Farm", "Failed to use Rokakaka.") end
      return
    end
    sourceContext.notify("Stand Farm", "Current stand is not shiny.")
  end
  local sfBuyMissingItem2
  standFarmPosition5 = CFrame.new(914.264832, 126.484932, -194.080887, 0.0349707194, 1.18272225e-9, 0.999388337, -5.95965366e-9, 1, -9.74905157e-10, -0.999388337, -5.9219154e-9, 0.0349707194)
  safePosAnchor = Instance.new("Part")
  safePosAnchor.Name = "StandFarmSafeAnchor"
  safePosAnchor.Anchored = true
  safePosAnchor.CanCollide = false
  safePosAnchor.Transparency = 1
  safePosAnchor.Size = Vector3.new(1, 1, 1)
  safePosAnchor.CFrame = standFarmPosition5
  sfBuyMissingItem2 = safePosAnchor
  sfBuyMissingItem2.Parent = sourceContext.parent.Terrain
  function sfBuyMissingItem2()
    local cFrame2 = getRandomSkyCFrame()
    waitingPosition = cFrame2
    standFarmPosition5 = cFrame2
    safePosAnchor.CFrame = cFrame2
    return cFrame2
  end
  refreshFarmRoamPosition = sfBuyMissingItem2
  function sfBuyMissingItem2() return callback127(refreshFarmRoamPosition()) end
  moveToFarmRoamPos = sfBuyMissingItem2
  function sfBuyMissingItem2()
    local humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
      task.wait(0.1)
      callback127(standFarmPosition5)
    end
  end
  teleportToSafePos = sfBuyMissingItem2
  function sfBuyMissingItem2() callback132("stand") end
  standEnableNoclip = sfBuyMissingItem2
  function sfBuyMissingItem2() callback133("stand") end
  standDisableNoclip = sfBuyMissingItem2
  function sfBuyMissingItem2(a, b)
    local a5 = b and b ~= "None" and b ~= "" and b ~= a
    if a5 and sourceContext.sendStandWebhook then sourceContext.sendStandWebhook(a, b) end
  end
  sfSendWebhook = sfBuyMissingItem2
  function sfBuyMissingItem2()
    if shinySoundAsset then return shinySoundAsset end
    local fearsNotificationMp3Text = sourceContext.environment .. "/fears_notification.mp3"
    local getsynasset2 = getcustomasset or getsynasset
    if type(isfile) == "function" and isfile(fearsNotificationMp3Text) and getsynasset2 then
      local pcallResult, entry18 = pcall(getsynasset2, fearsNotificationMp3Text)
      if pcallResult and type(entry18) == "string" and entry18 ~= "" then
        shinySoundAsset = entry18
        return shinySoundAsset
      end
    end
    if type(writefile) == "function" and getsynasset2 then
      sourceContext.callback30()
      if pcall(function()
        writefile(fearsNotificationMp3Text, game:HttpGet("https://www.myinstants.com/media/sounds/fears-to-fathom-notification-sound.mp3"))
      end) then
        local pcallResult2, entry19 = pcall(getsynasset2, fearsNotificationMp3Text)
        if pcallResult2 and type(entry19) == "string" and entry19 ~= "" then
          shinySoundAsset = entry19
          return shinySoundAsset
        end
      end
    end
    return nil
  end
  getShinySoundAsset = sfBuyMissingItem2
  function sfBuyMissingItem2()
    local shinySoundAsset = getShinySoundAsset()
    if not shinySoundAsset then return end
    pcall(function()
      local new = Instance.new("Sound")
      new.Name = "RAILhubShinySound"
      new.SoundId = shinySoundAsset
      new.Volume = 5
      new.Parent = game:GetService("SoundService")
      new.Ended:Connect(function() new:Destroy() end)
      new:Play()
    end)
  end
  playShinyNotificationSound = sfBuyMissingItem2
  function sfBuyMissingItem2(a, b)
    if a and a ~= "None" and a ~= "" then
      local entries14 = sourceContext.settings10.standFarmTarget or {}
      local sfFindTableResult = #entries14 > 0 and sfFindTable(entries14, a)
      local Text6 = b and b ~= "None" and b ~= ""
      local entry18
      if Text6 or b and b ~= "None" and b ~= "" then
        entry18 = Text6
      else
        task.wait(0.12)
        b = sfCheckShiny()
        entry18 = if b then b ~= "None" and b ~= "" else b
      end
      if #entries14 == 0 then
        if entry18 then
          local a5, b3 = a, b
          sfNotify("✨ Got shiny stand: " .. a .. " [" .. b .. "]! Keeping it.")
          playShinyNotificationSound()
          sfSendWebhook(a, b)
          return "stop"
        end
        sfNotify("Got stand: " .. a .. " - continuing to farm")
        return "continue"
      end
      if sfFindTableResult then
        if entry18 then
          local a6, b4 = a, b
          sfNotify("✨ Got target shiny stand: " .. a .. " [" .. b .. "]!")
          playShinyNotificationSound()
          sfSendWebhook(a, b)
          return "stop"
        end
        if sourceContext.settings10.keepAnyShiny then
          sfNotify("Got target stand: " .. a .. " (non-shiny) - continuing for shiny")
          return "continue"
        end
        sfNotify("Got desired stand: " .. a)
        sfSendWebhook(a, nil)
        return "stop"
      end
      if entry18 then
        local a7, b5 = a, b
        sfNotify("✨ Got shiny non-target stand: " .. a .. " [" .. b .. "]! Keeping it.")
        playShinyNotificationSound()
        sfSendWebhook(a, b)
        return "stop"
      end
      return "continue"
    end
    return "continue"
  end
  sfCheckStandResult = sfBuyMissingItem2
  function sfBuyMissingItem2(a, b, c, d, _, _, _, h)
    if sourceContext.callback28() then return true end
    local Character = sourceContext.player.Character
    local humanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart and (humanoidRootPart.Position - standFarmPosition5.Position).Magnitude > 15 then
      callback127(standFarmPosition5)
      task.wait(0.1)
    end
    if a then
      if b > 0 then
        local sfUseRokaResult = sfUseRoka()
        if sfUseRokaResult then
          local timestamp3 = tick()
          while tick() - timestamp3 < 1.5 and sourceContext.settings10.standFarmRunning do
            if h.Stand.Value == "None" then break end
            task.wait(0.08)
          end
          return sourceContext.settings10.standFarmRunning
        end
        sfNotify("Roka failed after retries")
        return true
      end
      return true
    end
    if not a then
      if sourceContext.callback28() then return true end
      if callback126("Lucky Arrow") > 0 and sourceContext.settings10.farmMethod == "Lucky Arrow" then
        sfNotify("Using Lucky Arrow (no stand)...")
        local Value = h.Stand.Value
        local useItemDirectResult = useItemDirect("Lucky Arrow", "Lucky Arrow")
        if useItemDirectResult then
          local timestamp4 = tick()
          while tick() - timestamp4 < 2.5 and sourceContext.settings10.standFarmRunning and (h.Stand.Value == "None" or h.Stand.Value == Value) do
            task.wait(0.05)
          end
          local Value2 = h.Stand.Value
          if Value2 ~= "None" and Value2 ~= Value then
            sourceContext.settings10.farmStats.luckyArrowsUsed = sourceContext.settings10.farmStats.luckyArrowsUsed + 1
            sourceContext.settings10.farmStats.standsGot = sourceContext.settings10.farmStats.standsGot + 1
            sfNotify("Lucky Arrow gave stand: " .. Value2)
            if sfCheckStandResult(Value2, sfCheckShiny()) == "stop" then
              sourceContext.settings10.standFarmRunning = false
              if sourceContext.settings10.standFarmRespawnConn then sourceContext.settings10.standFarmRespawnConn:Disconnect() end
              sourceContext.settings10.standFarmRespawnConn = nil
              standDisableNoclip()
              return false
            end
            return sourceContext.settings10.standFarmRunning
          end
          sfNotify("Lucky Arrow failed to give stand")
          task.wait(1)
          return true
        end
        sfNotify("Lucky Arrow not found / failed to equip")
        task.wait(1)
        return true
      end
      if sourceContext.settings10.farmMethod == "Rib Cage" and c > 0 then
        sfNotify("Using Rib Cage (no stand)...")
        sfLearnWorthiness()
        sfUseRib()
        task.wait(0.1)
        local timestamp5 = tick()
        while tick() - timestamp5 < 2 and sourceContext.settings10.standFarmRunning and h.Stand.Value == "None" do task.wait(0.08) end
        local Value3 = h.Stand.Value
        if Value3 ~= "None" then
          local sfCheckStandResultResult = sfCheckStandResult(Value3, sfCheckShiny())
          if sfCheckStandResultResult == "stop" then
            sourceContext.settings10.standFarmRunning = false
            if sourceContext.settings10.standFarmRespawnConn then sourceContext.settings10.standFarmRespawnConn:Disconnect() end
            sourceContext.settings10.standFarmRespawnConn = nil
            standDisableNoclip()
            return false
          end
          if sfCheckStandResultResult == "continue" and callback126("Rokakaka") > 0 then
            sfNotify("Got stand from Rib, using roka immediately...")
            local sfUseRokaResult2 = sfUseRoka()
            if sfUseRokaResult2 then
              local timestamp6 = tick()
              while tick() - timestamp6 < 1.5 and sourceContext.settings10.standFarmRunning do
                if h.Stand.Value == "None" then break end
                task.wait(0.08)
              end
            end
          end
        end
        return sourceContext.settings10.standFarmRunning
      end
      if d > 0 then
        local entry18 = callback126("Mysterious Arrow")
        if entry18 == 0 then
          warn("[SF] sfUseResetItem: cached arrowCount=" .. tostring(d) .. " but live=0, skipping")
          return true
        end
        sfNotify("Using Arrow (no stand)...")
        local sfUseArrowResult = sfUseArrow()
        if sfUseArrowResult then
          local timestamp7 = tick()
          while tick() - timestamp7 < 1.5 and sourceContext.settings10.standFarmRunning and h.Stand.Value == "None" do task.wait(0.08) end
          local Value4 = h.Stand.Value
          if Value4 ~= "None" then
            local sfCheckStandResultResult2 = sfCheckStandResult(Value4, sfCheckShiny())
            if sfCheckStandResultResult2 == "stop" then
              sourceContext.settings10.standFarmRunning = false
              if sourceContext.settings10.standFarmRespawnConn then sourceContext.settings10.standFarmRespawnConn:Disconnect() end
              sourceContext.settings10.standFarmRespawnConn = nil
              standDisableNoclip()
              return false
            end
            if sfCheckStandResultResult2 == "continue" and callback126("Rokakaka") > 0 then
              sfNotify("Got stand from arrow, using roka immediately...")
              local sfUseRokaResult3 = sfUseRoka()
              if sfUseRokaResult3 then
                local timestamp8 = tick()
                while tick() - timestamp8 < 1.5 and sourceContext.settings10.standFarmRunning do
                  if h.Stand.Value == "None" then break end
                  task.wait(0.08)
                end
              end
            end
          end
          return sourceContext.settings10.standFarmRunning
        end
        sfNotify("Arrow failed to give stand")
        task.wait(2)
        return true
      end
    end
    return true
  end
  sfUseResetItem = sfBuyMissingItem2
  function sfBuyMissingItem2(a, b, _)
    return callback128(a, b, function() return sourceContext.settings10.standFarmRunning and not sourceContext.callback28() end)
  end
  sfFarmItemLoop = sfBuyMissingItem2
  function sfBuyMissingItem2(a, b, c, d, e, f, _)
    if sourceContext.callback28() then return end
    do
      local count18 = entries15["Rib Cage of The Saint's Corpse"] or 10
      local arrowText = sourceContext.settings10.farmMethod or "Arrow"
      local enabled33 = not (arrowText == "Lucky Arrow" or not (d < e))
      local f2 = (arrowText == "Arrow" or arrowText == "Lucky Arrow" or arrowText == "Rib Cage") and b < f
      local entry18 = arrowText == "Rib Cage" and callback126("Rib Cage of The Saint's Corpse") < count18
      local count19 = arrowText == "Lucky Arrow" and callback126("Lucky Arrow") < 1
      if not f2 and not entry18 and not enabled33 and not count19 then return end
      local luckyArrowText = nil
      if arrowText == "Lucky Arrow" and not a and count19 then
        luckyArrowText = "Lucky Arrow"
      elseif arrowText ~= "Arrow" or a or d ~= 0 then
        if arrowText ~= "Rib Cage" or a or c ~= 0 then
          if a and f2 then
            luckyArrowText = "Rokakaka"
          elseif arrowText == "Arrow" and not a and enabled33 then
            luckyArrowText = "Mysterious Arrow"
          elseif arrowText == "Rib Cage" and not a and entry18 then luckyArrowText = "Rib Cage of The Saint's Corpse" end
        else
          luckyArrowText = "Rib Cage of The Saint's Corpse"
        end
      else
        luckyArrowText = "Mysterious Arrow"
      end
      luckyArrowText = luckyArrowText or arrowText == "Arrow" and (b == 0 and "Rokakaka" or "Mysterious Arrow") or arrowText == "Lucky Arrow" and (b == 0 and "Rokakaka" or "Lucky Arrow") or b == 0 and "Rokakaka" or "Rib Cage of The Saint's Corpse"
      sfNotify("Farming: " .. luckyArrowText)
      standEnableNoclip()
      local entry19 = callback126(luckyArrowText)
      local e2 = luckyArrowText == "Rokakaka" and f or luckyArrowText == "Rib Cage of The Saint's Corpse" and count18 or luckyArrowText == "Lucky Arrow" and (entries15["Lucky Arrow"] or 9) or e
      local min = math.min(entry19 + 5, e2)
      local sfFarmItemLoopResult = luckyArrowText == "Lucky Arrow" and 0 or sfFarmItemLoop(luckyArrowText, min - entry19, e2)
      local Character = sourceContext.player.Character
      if Character and Character:FindFirstChild("HumanoidRootPart") then
        local HumanoidRootPart = Character.HumanoidRootPart
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        callback127(standFarmPosition5)
      end
      if sfFarmItemLoopResult == 0 and callback126(luckyArrowText) == 0 and not sourceContext.callback28() then
        local count20 = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Money.Value or 0
        local remoteEvent4 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("RemoteEvent")
        if remoteEvent4 then
          local xRokakakaText, count21 = nil, 0
          if luckyArrowText == "Rokakaka" then
            xRokakakaText = "1x Rokakaka"
            count21 = 2500
          elseif luckyArrowText == "Mysterious Arrow" then
            xRokakakaText = "1x Mysterious Arrow"
            count21 = 750
          elseif luckyArrowText == "Lucky Arrow" then
            xRokakakaText = "1x Lucky Arrow"
            count21 = 75000
          end
          if xRokakakaText and count21 <= count20 then
            local min2 = math.min(math.floor(count20 / count21), 5)
            sfNotify("Buying " .. min2 .. "x " .. luckyArrowText .. " from shop...")
            for i = 1, min2 do
              pcall(function() remoteEvent4:FireServer("PurchaseShopItem", { ItemName = xRokakakaText }, 1, 2) end)
              task.wait(0.15)
            end
          else
            task.wait(0.2)
          end
        else
          task.wait(0.2)
        end
      end
      return
    end
  end
  sfHandleItemFarm = sfBuyMissingItem2
  function sfBuyMissingItem2(a)
    if sourceContext.callback28() then return false end
    local Character = sourceContext.player.Character
    local remoteEvent5 = Character and Character:FindFirstChild("RemoteEvent")
    if remoteEvent5 then
      local xRokakakaText2, count18 = nil, nil
      if a == "Rokakaka" then
        xRokakakaText2, count18 = "1x Rokakaka", 2500
      elseif a == "Mysterious Arrow" then
        xRokakakaText2, count18 = "1x Mysterious Arrow", 750
      else
        if a ~= "Lucky Arrow" then return false end
        xRokakakaText2, count18 = "1x Lucky Arrow", 75000
      end
      local count19 = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Money.Value or 0
      if count19 < count18 then return false end
      local entry18 = callback126(a)
      local min = math.min(math.floor(count19 / count18), 5)
      sfNotify("Buying " .. min .. "x " .. a .. " from shop...")
      for i = 1, min do
        pcall(function() remoteEvent5:FireServer("PurchaseShopItem", { ItemName = xRokakakaText2 }, 1, 2) end)
        task.wait(0.15)
      end
      task.wait(0.2)
      return entry18 < callback126(a)
    end
    return false
  end
  sfBuyMissingItem = sfBuyMissingItem2
  function sfBuyMissingItem2(a, _, c)
    c = c or 20
    local tick2
    c = callback131() and 3.25 or c
    tick2 = tick
    tick2 = tick2() + c
    local enabled33 = false
    getgenv()._blacklistedItems = {}
    getgenv()._lastItemTarget = nil
    while sourceContext.settings10.standFarmRunning and tick() < tick2 and not sourceContext.callback28() do
      local aResult = a()
      if #aResult == 0 then break end
      local findNearestItem2 = findNearestItem or getgenv()._YBA_Exports and getgenv()._YBA_Exports.findNearestItem
      local collectSingleItemNormal2 = collectSingleItemNormal or getgenv()._YBA_Exports and getgenv()._YBA_Exports.collectSingleItemNormal
      local entry18
      entry18 = if findNearestItem2 then findNearestItem2(aResult) else findNearestItem2
      if not entry18 or sourceContext.callback28() then
        local getgenv3
        getgenv()._lastItemTarget = nil
        getgenv()._blacklistedItems = {}
        getgenv3 = sourceContext.callback28
        getgenv3 = sourceContext.callback28()
        if not getgenv3 then
          local randomSkyRoam2 = randomSkyRoam or getgenv()._YBA_Exports and getgenv()._YBA_Exports.randomSkyRoam
          if randomSkyRoam2 then
            randomSkyRoam2(2)
          else
            callback127(getRandomSkyCFrame())
            task.wait(0.625)
          end
        end
        task.wait(0.2)
      else
        enabled33 = true
        if collectSingleItemNormal2 then collectSingleItemNormal2(entry18) end
        task.wait(0.1)
      end
    end
    callback134()
    local rootPart5 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
    if sourceContext.settings10.standFarmRunning and rootPart5 then
      rootPart5.AssemblyLinearVelocity = Vector3.zero
      rootPart5.AssemblyAngularVelocity = Vector3.zero
      callback127(standFarmPosition5)
      task.wait(0.1)
    end
    return enabled33
  end
  sfFocusedFarmMissingItems = sfBuyMissingItem2
  sfBuyMissingItem2 = "standFarmPosition"
  sourceContext.settings10.standFarmPosition = standFarmPosition5
  sourceContext.settings10.teleportToSafePos = teleportToSafePos
  sourceContext.settings10.standEnableNoclip = standEnableNoclip
  sourceContext.settings10.standDisableNoclip = standDisableNoclip
  sourceContext.settings10.sfCheckStandResult = sfCheckStandResult
  sourceContext.settings10.sfUseResetItem = sfUseResetItem
  sourceContext.settings10.sfFocusedFarmMissingItems = sfFocusedFarmMissingItems
  sourceContext.settings10.sfBuyMissingItem = sfBuyMissingItem
  sourceContext.settings10.sfUseRib = sfUseRib
  sourceContext.settings10.playShinyNotificationSound = playShinyNotificationSound
  sourceContext.settings10.sfUseRoka = sfUseRoka
  sourceContext.settings10.sfUseArrow = sfUseArrow
  sourceContext.settings10.skipCurrentShinyStand = skipCurrentShinyStand
  sourceContext.settings10.sfLearnWorthiness = sfLearnWorthiness
end
do
  local function callTeleportToSafePos(...) return sourceContext.settings10.teleportToSafePos(...) end
  local function callStandDisableNoclip(...) return sourceContext.settings10.standDisableNoclip(...) end
  local function callStandEnableNoclip(...) return sourceContext.settings10.standEnableNoclip(...) end
  local function callSfCheckShiny(...) return sourceContext.settings10.sfCheckShiny(...) end
  local function callSfCheckStandResult(...) return sourceContext.settings10.sfCheckStandResult(...) end
  local function callSfCountItem2(...) return sourceContext.environment2.sfCountItem(...) end
  local function callSfLearnWorthiness(...) return sourceContext.settings10.sfLearnWorthiness(...) end
  local function callSfUseResetItem(...) return sourceContext.settings10.sfUseResetItem(...) end
  local function callSfFocusedFarmMissingItems(...)
    return sourceContext.settings10.sfFocusedFarmMissingItems(...)
  end
  local function callSfBuyMissingItem(...) return sourceContext.settings10.sfBuyMissingItem(...) end
  local function callSfNotify(...) return sourceContext.settings10.sfNotify(...) end
  local function callMoveCharacterTo(...) return sourceContext.environment2.moveCharacterTo(...) end
  local function callServerHopToRandom(...) return sourceContext.environment2.serverHopToRandom(...) end
  local function callWakeUpPhysicsAndSync2(...) return sourceContext.environment2.wakeUpPhysicsAndSync(...) end
  local maxLimits3 = sourceContext.environment2.maxLimits
  local standFarmPosition2 = sourceContext.settings10.standFarmPosition
  local _ = sourceContext.settings10.standFarmTarget
  local _ = sourceContext.settings10.shinyFarmTarget
  local function callback136()
    return sourceContext.settings10.getFarmMethod and sourceContext.settings10.getFarmMethod() or sourceContext.settings10.farmMethod or sourceContext.callback35 and sourceContext.callback35("SFM", "Arrow") or "Arrow"
  end
  local function callback137()
    local entry18, CharacterAdded2, standFarmRespawnConn2, tick2, count18, humanoid5, rootPart5, Position, Position2, Character4, FindFirstChild, Character5, FindFirstChild2, entry19, FindFirstChild3, Character6, GetAttribute, Value, entry20, entry23, entry24, entry26, count19, count20, count21, entry27, Position3, Position4, entry28, standFarmLoop, sfGetNeededItems, entry30, rootPart8, entries14, ipairsResult, entry31, entry32
    if not sourceContext.callback14 or not sourceContext.callback14() then
      local timestamp3 = tick()
      while tick() - timestamp3 < 180 and sourceContext.settings10.standFarmRunning do
        task.wait(0.5)
        if sourceContext.callback14 and sourceContext.callback14() then break end
      end
      if not sourceContext.callback14 or not sourceContext.callback14() then
        sourceContext.settings10.standFarmRunning = false
        return
      end
    end
    task.wait(0.15)
    callTeleportToSafePos()
    task.wait(0.05)
    if sourceContext.settings10.standFarmRespawnConn then sourceContext.settings10.standFarmRespawnConn:Disconnect() end
    sourceContext.settings10.standFarmRespawnConn = sourceContext.player.CharacterAdded:Connect(function(a)
      task.wait(0.1)
      if not (sourceContext.callback14 and sourceContext.callback14()) then return end
      local rootPart5 = a:WaitForChild("HumanoidRootPart", 5)
      if rootPart5 and sourceContext.settings10.standFarmRunning then
        callMoveCharacterTo(standFarmPosition2)
        rootPart5.AssemblyLinearVelocity = Vector3.zero
        rootPart5.AssemblyAngularVelocity = Vector3.zero
        task.wait(0.1)
        callSfLearnWorthiness()
      end
    end)
    tick2 = tick
    tick2 = tick2()
    count18 = 0
    while sourceContext.settings10.standFarmRunning do
      count18 = count18 + 1
      if count18 > 100000 then
        sourceContext.settings10.standFarmRunning = false
        callStandDisableNoclip()
      else
        if tick() - tick2 > 7200 then
          sourceContext.settings10.standFarmRunning = false
          callStandDisableNoclip()
          task.wait(1)
          local YBAItemFarm = getgenv()
          YBAItemFarm = YBAItemFarm.YBAItemFarm
          if YBAItemFarm and getgenv().YBAItemFarm.startStandFarm then getgenv().YBAItemFarm.startStandFarm() end
          return
        end
        task.wait(0.05)
        local Character = sourceContext.player.Character
        if not Character or not Character.Parent then
          local CharacterAdded = sourceContext.player.CharacterAdded
          CharacterAdded = CharacterAdded:Wait()
          task.wait(0.5)
          Character = if CharacterAdded then CharacterAdded else sourceContext.player.Character
        end
        if Character then
          humanoid5 = Character:FindFirstChildOfClass("Humanoid")
          rootPart5 = Character:FindFirstChild("HumanoidRootPart")
          if humanoid5 and not (humanoid5.Health <= 0) and rootPart5 then
            if sourceContext.callback28() then
              task.wait(0.3)
              continue
            end
            if sourceContext.player.Backpack and #sourceContext.player.Backpack:GetChildren() == 0 then
              local timestamp4 = tick()
              while tick() - timestamp4 < 1.5 and sourceContext.settings10.standFarmRunning do
                if sourceContext.player.Backpack and #sourceContext.player.Backpack:GetChildren() > 0 then break end
                task.wait(0.1)
              end
            end
            if sourceContext.callback28() then
              task.wait(0.3)
              continue
            end
            Position = rootPart5.Position
            Position2 = standFarmPosition2.Position
            if (Position - Position2).Magnitude > 25 then
              callMoveCharacterTo(standFarmPosition2)
              rootPart5.AssemblyLinearVelocity = Vector3.zero
              rootPart5.AssemblyAngularVelocity = Vector3.zero
              task.wait(0.1)
            end
            Character4 = Character
            FindFirstChild = Character4.FindFirstChild
            if not FindFirstChild(Character4, "RemoteFunction") then
              Character:WaitForChild("RemoteFunction", 0.5)
              Character5 = Character
              FindFirstChild2 = Character5.FindFirstChild
              if not FindFirstChild2(Character5, "RemoteFunction") then continue end
            end
            local playerStats = sourceContext.player:FindFirstChild("PlayerStats")
            playerStats = playerStats or sourceContext.player:WaitForChild("PlayerStats", 1)
            if playerStats then
              entry19 = playerStats
              FindFirstChild3 = entry19.FindFirstChild
              if FindFirstChild3(entry19, "Stand") then
                Character6 = Character
                GetAttribute = Character6.GetAttribute
                if not GetAttribute(Character6, "WorthinessLearned") then
                  callSfLearnWorthiness()
                  pcall(function() Character:SetAttribute("WorthinessLearned", true) end)
                end
                Value = playerStats.Stand.Value
                local noneText = Value ~= "None"
                if noneText and callSfCheckStandResult(Value, (callSfCheckShiny())) == "stop" then
                  sourceContext.settings10.standFarmRunning = false
                  if sourceContext.settings10.standFarmRespawnConn then sourceContext.settings10.standFarmRespawnConn:Disconnect() end
                  sourceContext.settings10.standFarmRespawnConn = nil
                  callStandDisableNoclip()
                  continue
                end
                entry20 = callSfCountItem2("Mysterious Arrow")
                entry23 = callSfCountItem2("Rokakaka")
                entry24 = callSfCountItem2("Rib Cage of The Saint's Corpse")
                entry26 = callSfCountItem2("Lucky Arrow")
                count19 = maxLimits3["Mysterious Arrow"] or 25
                count20 = maxLimits3.Rokakaka or 25
                count21 = maxLimits3["Rib Cage of The Saint's Corpse"] or 10
                entry27 = callback136()
                local enabled33
                enabled33 = if entry27 == "Arrow" then noneText and entry23 > 0 or not (noneText or not (entry20 > 0)) else if entry27 == "Lucky Arrow" then noneText and entry23 > 0 or not (noneText or not (entry26 > 0)) else entry27 == "Rib Cage" and (noneText and entry23 > 0 or not (noneText or not (entry24 > 0)))
                if enabled33 then
                  Position3 = rootPart5.Position
                  Position4 = standFarmPosition2.Position
                  if (Position3 - Position4).Magnitude > 15 then
                    callMoveCharacterTo(standFarmPosition2)
                    rootPart5.AssemblyLinearVelocity = Vector3.zero
                    rootPart5.AssemblyAngularVelocity = Vector3.zero
                    task.wait(0.1)
                  end
                  entry28 = callSfUseResetItem(noneText, entry23, entry24, entry20, count19, count20, count21, playerStats)
                  if not entry28 then
                    callStandDisableNoclip()
                    return
                  end
                  task.wait(0.1)
                  continue
                end
                if sourceContext.callback28() then
                  task.wait(0.3)
                  continue
                end
                function standFarmLoop()
                  local entries14 = {}
                  local Value = playerStats.Stand.Value
                  local entry18 = callSfCountItem2("Mysterious Arrow")
                  local entry19 = callSfCountItem2("Rokakaka")
                  local entry20 = callSfCountItem2("Rib Cage of The Saint's Corpse")
                  local entry23 = callSfCountItem2("Lucky Arrow")
                  local entry24 = callback136()
                  if entry24 == "Arrow" then
                    if Value == "None" then
                      if entry18 < 1 then table.insert(entries14, "Mysterious Arrow") end
                    elseif entry19 < 1 then table.insert(entries14, "Rokakaka") end
                  elseif entry24 == "Lucky Arrow" then
                    if Value == "None" then
                      if entry23 < 1 then table.insert(entries14, "Lucky Arrow") end
                    elseif entry19 < 1 then table.insert(entries14, "Rokakaka") end
                  elseif entry24 == "Rib Cage" then
                    if Value == "None" then
                      if entry20 < 1 then table.insert(entries14, "Rib Cage of The Saint's Corpse") end
                    elseif entry19 < 1 then table.insert(entries14, "Rokakaka") end
                  end
                  return entries14
                end
                function sfGetNeededItems()
                  local entry18 = callback136()
                  if entry18 == "Arrow" then return { [1] = "Rokakaka", [2] = "Mysterious Arrow" } end
                  if entry18 == "Lucky Arrow" then return { [1] = "Rokakaka" } end
                  if entry18 == "Rib Cage" then return { [1] = "Rokakaka", [2] = "Rib Cage of The Saint's Corpse" } end
                  return {}
                end
                if callback136() == "Lucky Arrow" and callSfCountItem2("Lucky Arrow") == 0 then
                  local count22 = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Money.Value or 0
                  if not (count22 >= 75000) then
                    callSfNotify("Not enough money for Lucky Arrow (need 75000, have " .. count22 .. ")! Farm paused.")
                    sourceContext.settings10.standFarmRunning = false
                    callStandDisableNoclip()
                    return
                  end
                  local Character2 = sourceContext.player.Character
                  Character2 = Character2 and sourceContext.player.Character:FindFirstChild("RemoteEvent")
                  if not Character2 then
                    callSfNotify("RemoteEvent not found for Lucky Arrow purchase - stopping farm.")
                    sourceContext.settings10.standFarmRunning = false
                    callStandDisableNoclip()
                    return
                  end
                  local count23 = maxLimits3["Lucky Arrow"] or 9
                  local min = math.min
                  min = min(math.floor(count22 / 75000), count23 - callSfCountItem2("Lucky Arrow"))
                  callSfNotify("Buying " .. min .. "x Lucky Arrow from shop...")
                  for i = 1, min do
                    pcall(function() Character2:FireServer("PurchaseShopItem", { ItemName = "1x Lucky Arrow" }, 1, 2) end)
                    task.wait(0.15)
                  end
                  task.wait(0.2)
                  if callSfCountItem2("Lucky Arrow") == 0 then
                    callSfNotify("Lucky Arrow purchase failed - stopping farm.")
                    sourceContext.settings10.standFarmRunning = false
                    callStandDisableNoclip()
                    return
                  end
                end
                if sourceContext.callback28() then
                  task.wait(0.3)
                  continue
                end
                if #standFarmLoop() > 0 and not sourceContext.callback28() then
                  callStandEnableNoclip()
                  entry30 = callSfFocusedFarmMissingItems(standFarmLoop, sfGetNeededItems, 15)
                  rootPart8 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
                  if rootPart8 then
                    callMoveCharacterTo(standFarmPosition2)
                    rootPart8.AssemblyLinearVelocity = Vector3.zero
                    rootPart8.AssemblyAngularVelocity = Vector3.zero
                    task.wait(0.1)
                  end
                  if sourceContext.callback28() then continue end
                  entries14 = standFarmLoop()
                  if #entries14 > 0 and not entry30 and not sourceContext.callback28() then
                    local enabled34 = false
                    ipairsResult, entry31, entry32 = ipairs(entries14)
                    for k, v in ipairsResult, entry31, entry32 do if callSfBuyMissingItem(v) then enabled34 = true end end
                    if not enabled34 and isServerHopFarmEnabled and isServerHopFarmEnabled() then
                      callSfNotify("No items on map and cannot buy. Hopping server...")
                      callServerHopToRandom()
                      task.wait(3)
                      continue
                    end
                  end
                end
                continue
              end
              continue
            end
            continue
          end
          task.wait(0.2)
        else
          task.wait(0.1)
        end
      end
    end
    callStandDisableNoclip()
  end
  function startStandFarm()
    if sourceContext.settings10.standFarmRunning then return end
    if sourceContext.callback14 and sourceContext.callback14() then
      local entry18
      getgenv()._YBA_startStandFarmWaiting = false
      sourceContext.callback2("stand farm STARTED (in main game)")
      if callWakeUpPhysicsAndSync2 then pcall(callWakeUpPhysicsAndSync2) end
      if #(sourceContext.settings10.standFarmTarget or {}) == 0 and not sourceContext.settings10.keepAnyShiny then
        callSfNotify("No stands selected - farming all stands (use Keep only Shiny to stop on shinies)")
      end
      _G._farmDebugNotified = false
      _G._standDebugDone = false
      entry18 = callback136()
      sourceContext.settings10.standFarmRunning = true
      callSfNotify("Stand farming started (Method: " .. tostring(entry18) .. ")!")
      task.spawn(callback137)
      return
    end
    if getgenv()._YBA_startStandFarmWaiting then return end
    getgenv()._YBA_startStandFarmWaiting = true
    task.spawn(function()
      local timestamp3 = tick()
      while tick() - timestamp3 < 180 do
        task.wait(1)
        if sourceContext.callback14 and sourceContext.callback14() then break end
      end
      getgenv()._YBA_startStandFarmWaiting = false
      if sourceContext.callback14 and sourceContext.callback14() then startStandFarm() end
    end)
  end
  function stopStandFarm()
    sourceContext.settings10.standFarmRunning = false
    sourceContext.callback34("SF", false)
    sourceContext.settings2.StandFarmEnabled = false
    if sourceContext.settings10.standFarmRespawnConn then sourceContext.settings10.standFarmRespawnConn:Disconnect() end
    sourceContext.settings10.standFarmRespawnConn = nil
    task.defer(callStandDisableNoclip)
    callSfNotify("Stand farming stopped!")
  end
  local environment8 = getgenv()
  function environment8.RAILhub_StandFarmCleanup()
    sourceContext.settings10.standFarmRunning = false
    if sourceContext.settings10.standFarmRespawnConn then sourceContext.settings10.standFarmRespawnConn:Disconnect() end
    sourceContext.settings10.standFarmRespawnConn = nil
  end
  environment8 = "startStandFarm"
  sourceContext.settings10.startStandFarm = startStandFarm
  sourceContext.settings10.stopStandFarm = stopStandFarm
end
do
  local function callSfCountItem3(...) return sourceContext.environment2.sfCountItem(...) end
  local function callSfLearnWorthiness2(...) return sourceContext.settings10.sfLearnWorthiness(...) end
  local function callSfUseRib(...) return sourceContext.settings10.sfUseRib(...) end
  local function callSfCheckShiny2(...) return sourceContext.settings10.sfCheckShiny(...) end
  local function callSfFindTable(...) return sourceContext.settings10.sfFindTable(...) end
  local function callSfNotify2(...) return sourceContext.settings10.sfNotify(...) end
  local function callPlayShinyNotificationSound(...)
    return sourceContext.settings10.playShinyNotificationSound(...)
  end
  local function callMoveCharacterTo2(...) return sourceContext.environment2.moveCharacterTo(...) end
  local function callFarmItemByName(...) return sourceContext.environment2.farmItemByName(...) end
  local function callServerHopToRandom2(...) return sourceContext.environment2.serverHopToRandom(...) end
  local function callback138()
    return sourceContext.environment2.serverHopFarmEnabled and sourceContext.environment2.serverHopFarmEnabled() or not sourceContext.callback35 or sourceContext.callback35("SHF", true) or true
  end
  local standFarmPosition3 = sourceContext.settings10.standFarmPosition
  local _ = sourceContext.settings10.standFarmTarget
  local _ = sourceContext.settings10.keepAnyShiny
  local function callback139()
    local entry18, entry19, humanoidRootPart, entry20, CharacterAdded2, ribFarmRespawnConn7, tick2, count18, Character2, humanoid5, playerStats2, Value, noneText, entry23, entry24, entry26, text4, entry27, entry28, entry30, text5, entry31, entry32, text6, entry33, entry34, entry35, text7, entry36, timestamp3, timestamp4
    if not sourceContext.callback14 or not sourceContext.callback14() then
      local timestamp5 = tick()
      while tick() - timestamp5 < 180 and sourceContext.settings10.ribFarmRunning do
        task.wait(0.5)
        if sourceContext.callback14 and sourceContext.callback14() then break end
      end
      if not sourceContext.callback14 or not sourceContext.callback14() then
        sourceContext.settings10.ribFarmRunning = false
        return
      end
    end
    function entry18() enableNoclipState("rib") end
    function entry19() disableNoclipState("rib") end
    task.wait(0.15)
    humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then callMoveCharacterTo2(standFarmPosition3) end
    task.wait(0.1)
    if sourceContext.settings10.ribFarmRespawnConn then sourceContext.settings10.ribFarmRespawnConn:Disconnect() end
    sourceContext.settings10.ribFarmRespawnConn = sourceContext.player.CharacterAdded:Connect(function(a)
      task.wait(0.1)
      if not (sourceContext.callback14 and sourceContext.callback14()) then return end
      local humanoidRootPart = a:WaitForChild("HumanoidRootPart", 10)
      if humanoidRootPart and sourceContext.settings10.ribFarmRunning then callMoveCharacterTo2(standFarmPosition3) end
    end)
    tick2 = tick
    tick2 = tick2()
    count18 = 0
    while sourceContext.settings10.ribFarmRunning do
      count18 = count18 + 1
      if 100000 < count18 then
        sourceContext.settings10.ribFarmRunning = false
        entry19()
      else
        if 7200 < tick() - tick2 then
          sourceContext.settings10.ribFarmRunning = false
          entry19()
          task.wait(1)
          local YBAItemFarm = getgenv()
          YBAItemFarm = YBAItemFarm.YBAItemFarm
          if YBAItemFarm and getgenv().YBAItemFarm.startRibFarm then getgenv().YBAItemFarm.startRibFarm() end
          return
        end
        task.wait()
        Character2 = sourceContext.player.Character
        local Character
        if Character2 then
          Character = Character2
        else
          local CharacterAdded = sourceContext.player.CharacterAdded
          CharacterAdded = CharacterAdded:Wait()
          task.wait(0.5)
          Character = if CharacterAdded then CharacterAdded else sourceContext.player.Character
        end
        if Character then
          humanoid5 = Character:FindFirstChildOfClass("Humanoid")
          if not humanoid5 or humanoid5.Health <= 0 then
            task.wait(0.5)
          else
            if callSfCountItem3("Rib Cage of The Saint's Corpse") == 0 then
              if callFarmItemByName("Rib Cage of The Saint's Corpse", 1, function() return sourceContext.settings10.ribFarmRunning end) > 0 then
                local rootPart5 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart5 then
                  callMoveCharacterTo2(standFarmPosition3)
                  rootPart5.AssemblyLinearVelocity = Vector3.zero
                end
                task.wait(0.1)
              elseif callback138() then
                callSfNotify2("No Rib Cages found. Hopping server...")
                callServerHopToRandom2()
                task.wait(3)
                continue
              end
            end
            playerStats2 = sourceContext.player:FindFirstChild("PlayerStats")
            if playerStats2 and playerStats2:FindFirstChild("Stand") then
              Value = playerStats2.Stand.Value
              noneText = Value == "None" and "None" or callSfCheckShiny2() or "None"
              if Value ~= "None" then
                if noneText ~= "None" and #(sourceContext.settings10.standFarmTarget or {}) == 0 and sourceContext.settings10.keepAnyShiny then
                  callSfNotify2("Got shiny stand: " .. Value .. " (" .. noneText .. ")! Keeping it.")
                  callPlayShinyNotificationSound()
                  sourceContext.settings10.ribFarmRunning = false
                  if sourceContext.settings10.ribFarmRespawnConn then sourceContext.settings10.ribFarmRespawnConn:Disconnect() end
                  sourceContext.settings10.ribFarmRespawnConn = nil
                  entry19()
                  continue
                end
                if callSfFindTable(sourceContext.settings10.standFarmTarget, Value) then
                  if not sourceContext.settings10.keepAnyShiny then
                    callSfNotify2("Got desired stand: " .. Value .. "! Keeping it.")
                    sourceContext.settings10.ribFarmRunning = false
                    if sourceContext.settings10.ribFarmRespawnConn then sourceContext.settings10.ribFarmRespawnConn:Disconnect() end
                    sourceContext.settings10.ribFarmRespawnConn = nil
                    entry19()
                    continue
                  end
                  if noneText ~= "None" then
                    callSfNotify2("Got target shiny stand: " .. Value .. " (" .. noneText .. ")! Keeping it.")
                    callPlayShinyNotificationSound()
                    sourceContext.settings10.ribFarmRunning = false
                    if sourceContext.settings10.ribFarmRespawnConn then sourceContext.settings10.ribFarmRespawnConn:Disconnect() end
                    sourceContext.settings10.ribFarmRespawnConn = nil
                    entry19()
                    continue
                  end
                  callSfNotify2("Got target stand: " .. Value .. " (non-shiny) - continuing for shiny")
                end
                if noneText ~= "None" and sourceContext.settings10.keepAnyShiny then
                  callSfNotify2("✨ Got shiny stand: " .. Value .. " (" .. noneText .. ")! Keeping it.")
                  callPlayShinyNotificationSound()
                  sourceContext.settings10.ribFarmRunning = false
                  if sourceContext.settings10.ribFarmRespawnConn then sourceContext.settings10.ribFarmRespawnConn:Disconnect() end
                  sourceContext.settings10.ribFarmRespawnConn = nil
                  entry19()
                  continue
                end
              end
              entry36 = callSfCountItem3("Rib Cage of The Saint's Corpse")
              if Value == "None" and entry36 > 0 then
                callSfLearnWorthiness2()
                callSfUseRib()
                task.wait(0.1)
                timestamp3 = tick()
                while tick() - timestamp3 < 2 do
                  if not sourceContext.settings10.ribFarmRunning then break end
                  if playerStats2.Stand.Value == "None" then
                    task.wait(0.08)
                    continue
                  end
                  break
                end
              elseif Value ~= "None" and callSfCountItem3("Rokakaka") > 0 then
                sfUseRoka()
                timestamp4 = tick()
                while tick() - timestamp4 < 1.5 do
                  if not sourceContext.settings10.ribFarmRunning then break end
                  if playerStats2.Stand.Value ~= "None" then
                    task.wait(0.08)
                    continue
                  end
                  break
                end
              elseif Value ~= "None" and callSfCountItem3("Rokakaka") == 0 then
                if callFarmItemByName("Rokakaka", 1, function() return sourceContext.settings10.ribFarmRunning end) > 0 then
                  local rootPart8 = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
                  if rootPart8 then
                    callMoveCharacterTo2(standFarmPosition3)
                    rootPart8.AssemblyLinearVelocity = Vector3.zero
                  end
                  task.wait(0.1)
                elseif serverHopFarmEnabled then
                  callSfNotify2("No Rokakaka found. Hopping server...")
                  callServerHopToRandom2()
                  task.wait(3)
                end
              end
            else
              task.wait(0.5)
            end
          end
        else
          task.wait(0.5)
        end
      end
    end
    if sourceContext.settings10.ribFarmRespawnConn then sourceContext.settings10.ribFarmRespawnConn:Disconnect() end
    sourceContext.settings10.ribFarmRespawnConn = nil
    entry19()
  end
  local function startRibFarm()
    if sourceContext.settings10.ribFarmRunning then return end
    if sourceContext.callback14 and sourceContext.callback14() then
      sourceContext.settings10.ribFarmRunning = true
      callSfNotify2("Rib farming started!")
      task.spawn(callback139)
      return
    end
    task.spawn(function()
      local timestamp3 = tick()
      while tick() - timestamp3 < 180 and (not sourceContext.callback14 or not sourceContext.callback14()) do task.wait(1) end
      if sourceContext.callback14 and sourceContext.callback14() then startRibFarm() end
    end)
  end
  local function stopRibFarm()
    sourceContext.settings10.ribFarmRunning = false
    sourceContext.callback34("SF", false)
    sourceContext.settings2.StandFarmEnabled = false
    if sourceContext.settings10.ribFarmRespawnConn then sourceContext.settings10.ribFarmRespawnConn:Disconnect() end
    sourceContext.settings10.ribFarmRespawnConn = nil
    callSfNotify2("Rib farming stopped!")
  end
  sourceContext.settings10.startRibFarm = startRibFarm
  sourceContext.settings10.stopRibFarm = stopRibFarm
end
do
  local function callSfCountItem4(...) return sourceContext.environment2.sfCountItem(...) end
  local function callSfCheckShiny3(...) return sourceContext.settings10.sfCheckShiny(...) end
  local function callSfFindTable2(...) return sourceContext.settings10.sfFindTable(...) end
  local function callSfNotify3(...) return sourceContext.settings10.sfNotify(...) end
  local function callPlayShinyNotificationSound2(...)
    return sourceContext.settings10.playShinyNotificationSound(...)
  end
  local function callMoveCharacterTo3(...) return sourceContext.environment2.moveCharacterTo(...) end
  local function callFarmItemByName2(...) return sourceContext.environment2.farmItemByName(...) end
  local function callServerHopToRandom3(...) return sourceContext.environment2.serverHopToRandom(...) end
  local function callback140()
    return sourceContext.environment2.serverHopFarmEnabled and sourceContext.environment2.serverHopFarmEnabled() or not sourceContext.callback35 or sourceContext.callback35("SHF", true) or true
  end
  local standFarmPosition4 = sourceContext.settings10.standFarmPosition
  local _ = sourceContext.settings10.shinyFarmTarget
  local function callSfUseRoka(...) return sourceContext.settings10.sfUseRoka(...) end
  local function callSfUseArrow(...) return sourceContext.settings10.sfUseArrow(...) end
  local function callback141()
    local entry18, entry19, humanoidRootPart, entry20, CharacterAdded2, shinyFarmRespawnConn4, tick2, count18, Character2, playerStats2, noneText, entry23
    if not sourceContext.callback14 or not sourceContext.callback14() then
      local timestamp3 = tick()
      while tick() - timestamp3 < 180 and sourceContext.settings10.shinyFarmRunning do
        task.wait(0.5)
        if sourceContext.callback14 and sourceContext.callback14() then break end
      end
      if not sourceContext.callback14 or not sourceContext.callback14() then
        sourceContext.settings10.shinyFarmRunning = false
        return
      end
    end
    function entry18() enableNoclipState("shiny") end
    function entry19() disableNoclipState("shiny") end
    task.wait(0.15)
    humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then callMoveCharacterTo3(standFarmPosition4) end
    task.wait(0.1)
    if sourceContext.settings10.shinyFarmRespawnConn then sourceContext.settings10.shinyFarmRespawnConn:Disconnect() end
    sourceContext.settings10.shinyFarmRespawnConn = sourceContext.player.CharacterAdded:Connect(function(a)
      task.wait(0.1)
      if not (sourceContext.callback14 and sourceContext.callback14()) then return end
      local humanoidRootPart = a:WaitForChild("HumanoidRootPart", 10)
      if humanoidRootPart and sourceContext.settings10.shinyFarmRunning then callMoveCharacterTo3(standFarmPosition4) end
    end)
    tick2 = tick
    tick2 = tick2()
    count18 = 0
    while sourceContext.settings10.shinyFarmRunning do
      count18 = count18 + 1
      if 100000 < count18 then
        sourceContext.settings10.shinyFarmRunning = false
        entry19()
      else
        if 7200 < tick() - tick2 then
          sourceContext.settings10.shinyFarmRunning = false
          entry19()
          task.wait(1)
          local YBAItemFarm = getgenv()
          YBAItemFarm = YBAItemFarm.YBAItemFarm
          if YBAItemFarm and getgenv().YBAItemFarm.startShinyFarm then getgenv().YBAItemFarm.startShinyFarm() end
          return
        end
        task.wait(0.15)
        Character2 = sourceContext.player.Character
        local Character
        if Character2 then
          Character = Character2
        else
          local CharacterAdded = sourceContext.player.CharacterAdded
          CharacterAdded = CharacterAdded:Wait()
          task.wait(0.5)
          Character = if CharacterAdded then CharacterAdded else sourceContext.player.Character
        end
        if Character then
          playerStats2 = sourceContext.player:FindFirstChild("PlayerStats")
          noneText = playerStats2 and playerStats2:FindFirstChild("Stand") and playerStats2.Stand.Value or "None"
          entry23 = callSfCheckShiny3()
          if noneText ~= "None" and entry23 ~= "None" and callSfFindTable2(sourceContext.settings10.shinyFarmTarget, entry23) then
            callSfNotify3("Got target shiny: " .. entry23)
            callPlayShinyNotificationSound2()
            sourceContext.settings10.shinyFarmRunning = false
            if sourceContext.settings10.shinyFarmRespawnConn then sourceContext.settings10.shinyFarmRespawnConn:Disconnect() end
            sourceContext.settings10.shinyFarmRespawnConn = nil
          else
            local count19 = callSfCountItem4("Mysterious Arrow") < 1
            local count20 = callSfCountItem4("Rokakaka") < 1
            if count19 or count20 then
              local enabled33 = count19 and callFarmItemByName2("Mysterious Arrow", 1, function() return sourceContext.settings10.shinyFarmRunning end) > 0 or false
              local enabled34
              enabled34 = if count20 and callFarmItemByName2("Rokakaka", 1, function() return sourceContext.settings10.shinyFarmRunning end) > 0 then true else enabled33
              if not enabled34 and callback140() then
                callSfNotify3("Required items not found. Hopping server...")
                callServerHopToRandom3()
                task.wait(3)
                continue
              end
            end
            if noneText == "None" then callSfUseArrow() else callSfUseRoka() end
            task.wait(0.15)
          end
        else
          task.wait(0.5)
        end
      end
    end
    if sourceContext.settings10.shinyFarmRespawnConn then sourceContext.settings10.shinyFarmRespawnConn:Disconnect() end
    sourceContext.settings10.shinyFarmRespawnConn = nil
  end
  local function startShinyFarm()
    if sourceContext.settings10.shinyFarmRunning then return end
    if #(sourceContext.settings10.shinyFarmTarget or {}) == 0 then
      sourceContext.notify("Shiny Farm", "No shinies selected!")
      return
    end
    if sourceContext.callback14 and sourceContext.callback14() then
      sourceContext.settings10.shinyFarmRunning = true
      callSfNotify3("Shiny farming started!")
      task.spawn(callback141)
      return
    end
    task.spawn(function()
      local timestamp3 = tick()
      while tick() - timestamp3 < 180 and (not sourceContext.callback14 or not sourceContext.callback14()) do task.wait(1) end
      if sourceContext.callback14 and sourceContext.callback14() then startShinyFarm() end
    end)
  end
  local function stopShinyFarm()
    sourceContext.settings10.shinyFarmRunning = false
    sourceContext.callback34("SF", false)
    if sourceContext.settings10.shinyFarmRespawnConn then sourceContext.settings10.shinyFarmRespawnConn:Disconnect() end
    sourceContext.settings10.shinyFarmRespawnConn = nil
    callSfNotify3("Shiny farming stopped!")
  end
  sourceContext.settings10.startShinyFarm = startShinyFarm
  sourceContext.settings10.stopShinyFarm = stopShinyFarm
  _G.YBAItemFarm.standFarmTarget = sourceContext.settings10.standFarmTarget
  _G.YBAItemFarm.shinyFarmTarget = sourceContext.settings10.shinyFarmTarget
  function _G.YBAItemFarm.setKeepAnyShiny(keepAnyShiny) sourceContext.settings10.keepAnyShiny = keepAnyShiny end
  function _G.YBAItemFarm.startStandFarm()
    if sourceContext.settings10.startStandFarm then sourceContext.settings10.startStandFarm() end
  end
  function _G.YBAItemFarm.stopStandFarm()
    if sourceContext.settings10.stopStandFarm then sourceContext.settings10.stopStandFarm() end
  end
  function _G.YBAItemFarm.startRibFarm()
    if sourceContext.settings10.startRibFarm then sourceContext.settings10.startRibFarm() end
  end
  function _G.YBAItemFarm.stopRibFarm()
    if sourceContext.settings10.stopRibFarm then sourceContext.settings10.stopRibFarm() end
  end
  function _G.YBAItemFarm.startShinyFarm()
    if sourceContext.settings10.startShinyFarm then sourceContext.settings10.startShinyFarm() end
  end
  function _G.YBAItemFarm.stopShinyFarm()
    if sourceContext.settings10.stopShinyFarm then sourceContext.settings10.stopShinyFarm() end
  end
end
do
  local function callback142(...)
    if sourceContext.settings10.startStandFarm then return sourceContext.settings10.startStandFarm(...) end
    if not (_G.YBAItemFarm and _G.YBAItemFarm.startStandFarm) then return end
    return _G.YBAItemFarm.startStandFarm(...)
  end
  local function callback143(...)
    if sourceContext.settings10.stopStandFarm then return sourceContext.settings10.stopStandFarm(...) end
    if not (_G.YBAItemFarm and _G.YBAItemFarm.stopStandFarm) then return end
    return _G.YBAItemFarm.stopStandFarm(...)
  end
  local function callback144(...)
    if sourceContext.settings10.startRibFarm then return sourceContext.settings10.startRibFarm(...) end
    if not (_G.YBAItemFarm and _G.YBAItemFarm.startRibFarm) then return end
    return _G.YBAItemFarm.startRibFarm(...)
  end
  local function callback145(...)
    if sourceContext.settings10.stopRibFarm then return sourceContext.settings10.stopRibFarm(...) end
    if not (_G.YBAItemFarm and _G.YBAItemFarm.stopRibFarm) then return end
    return _G.YBAItemFarm.stopRibFarm(...)
  end
  local function callback146(...)
    if not sourceContext.settings10.skipCurrentShinyStand then return end
    return sourceContext.settings10.skipCurrentShinyStand(...)
  end
  local Options3 = {
    [1] = "Aerosmith", [2] = "Anubis", [3] = "Beach Boy", [4] = "Crazy Diamond", [5] = "Cream", [6] = "Diver Down",
    [7] = "D4C", [8] = "Gold Experience", [9] = "Hermit Purple", [10] = "Hierophant Green", [11] = "Killer Queen",
    [12] = "King Crimson", [13] = "Magician's Red", [14] = "Mr. President", [15] = "Purple Haze",
    [16] = "Red Hot Chili Pepper", [17] = "Scary Monsters", [18] = "Silver Chariot", [19] = "Six Pistols",
    [20] = "Soft & Wet", [21] = "Star Platinum", [22] = "Sticky Fingers", [23] = "Stone Free", [24] = "The Hand",
    [25] = "The World", [26] = "The World Alternate Universe", [27] = "Tusk ACT 1", [28] = "White Album",
    [29] = "Whitesnake",
  }
  local settings11 = {
    [1] = "Action-Figure Platinum", [2] = "Actually Red Hot Chili Pepper", [3] = "Aerosmith Over Heaven",
    [4] = "All-Starsnake", [5] = "Anti-Umbral", [6] = "Asuna", [7] = "Biblically Accurate Experience",
    [8] = "Blade Of The Exile", [9] = "Casull", [10] = "Charmy Green", [11] = "Chromo", [12] = "Comic Venom",
    [13] = "Cracked World", [14] = "Crazy Ruby", [15] = "Crazy Idol", [16] = "Creeper Queen", [17] = "D4She",
    [18] = "Devil4c", [19] = "Deimos Queen", [20] = "Deimos Snake", [21] = "Eldritch Hierophant",
    [22] = "Elizabeth Liones", [23] = "Elucidator & Dark Repulser", [24] = "Emperor", [25] = "Emperor OVA",
    [26] = "Female The Hand", [27] = "Frozone", [28] = "Glock-18", [29] = "Glock-18 Fade", [30] = "Gold Platinum",
    [31] = "Golden Frieza", [32] = "Gold & Wet", [33] = "Headhunter", [34] = "Heaven Spirit",
    [35] = "Tentacle Black", [36] = "Tentacle Purple", [37] = "Tentacle Yellow", [38] = "Holly's Sickness",
    [39] = "Jade Peace", [40] = "Jaguar Platinum", [41] = "Kanshou & Bakuya", [42] = "Kikoku",
    [43] = "Killer Reveal", [44] = "King of The End", [45] = "Linked Sword", [46] = "Luffy Gear 4",
    [47] = "Magellan", [48] = "Magician's Red: Over Heaven", [49] = "Manga Crimson", [50] = "Megumin",
    [51] = "Mintsnake", [52] = "Misaka Mikoto", [53] = "Mr. Joestar", [54] = "Ms. Aerosmith",
    [55] = "Neon Ascension", [56] = "Neo World", [57] = "Nerf Jolt", [58] = "Nocturne", [59] = "Nonosama Bo",
    [60] = "ODM Gear", [61] = "OVA Silver Chariot", [62] = "Old President", [63] = "Pinky Fingers",
    [64] = "Queen Crimson", [65] = "Rock Unleashed", [66] = "Sakura", [67] = "Shadow Killer Queen",
    [68] = "Shadow The World", [69] = "Sorcerer's Ember", [70] = "Spider-Man", [71] = "Sasageyo",
    [72] = "Star Platinum OVA", [73] = "Star Striped Eagle", [74] = "Star Waifu", [75] = "Stone Platinum",
    [76] = "The Other Hand", [77] = "The Waifu v2", [78] = "The Waifu: Alternate Universe",
    [79] = "The World: Greatest High", [80] = "The World 2", [81] = "The World OVA", [82] = "The World Ultimate",
    [83] = "Toy Sticky Fingers", [84] = "Tsunade", [85] = "Uber Spy", [86] = "Whisper", [87] = "Vanilla Ice Cream",
    [88] = "Venom", [89] = "Vinegar Crimson", [90] = "Virus Vessel", [91] = "Jack-O-Platinum", [92] = "Ghost World",
    [93] = "Crazy Overseer", [94] = "Tyrant Crimson", [95] = "Jester Crimson", [96] = "Vexus Crimson",
    [97] = "Pumpkin Patch", [98] = "Cornsnake", [99] = "Crimson Mist", [100] = "Dead Experience",
  }
  local bloodthirsterText, callback147 = "Bloodthirster", "Platinum"
  local callback148, sapphireText = "Ruby", "Sapphire"
  settings11[101] = "Undead Hand"
  settings11[102] = "Undead Flare"
  settings11[103] = "Bloodthirster"
  settings11[104] = "Gold"
  settings11[105] = "Silver"
  settings11[106] = "Diamond"
  settings11[107] = "Platinum"
  settings11[108] = "Rainbow"
  settings11[109] = "Crystal"
  settings11[110] = "Emerald"
  settings11[111] = "Ruby"
  settings11[112] = "Sapphire"
  settings11[113] = "Obsidian"
  local Stands, sectionText4 = sourceContext.entries12.Stands, "Section"
  local section6 = Stands.Section(Stands, { Side = "Left", Name = "Stand Farm" })
  section6.Header(section6, { Text = "Farm stands", AutoLocalize = false })
  local section7
  section6.Dropdown(section6, {
    Name = "Select Stands to Keep", Options = Options3, Multi = true,
    Default = sourceContext.callback35 and sourceContext.callback35("StandFarmKeep", {}) or {},
    Callback = function(a)
      local standFarmTarget = _G.YBAItemFarm.standFarmTarget
      for i = #standFarmTarget, 1, -1 do table.remove(standFarmTarget, i) end
      if type(a) == "table" then
        if a[1] == nil then
          for k2, v2 in pairs(a) do if v2 == true and type(k2) == "string" then table.insert(standFarmTarget, k2) end end
        else
          for k, v in ipairs(a) do if type(v) == "string" then table.insert(standFarmTarget, v) end end
        end
      end
      sourceContext.callback34("StandFarmKeep", standFarmTarget)
      sourceContext.notify("Stand Farm", "Selected " .. #standFarmTarget .. " stands: " .. table.concat(standFarmTarget, ", "))
    end,
  })
  section7 = section6.Toggle
  local keepOnlyShinyOptions = { Name = "Keep only Shiny" }
  callback147 = sourceContext.callback35
  callback147 = sourceContext.callback35("SKS", false)
  keepOnlyShinyOptions.Default = callback147
  function callback147(a)
    if sourceContext.settings10.setKeepAnyShiny then sourceContext.settings10.setKeepAnyShiny(a) end
    if _G.YBAItemFarm and _G.YBAItemFarm.setKeepAnyShiny then _G.YBAItemFarm.setKeepAnyShiny(a) end
    sourceContext.callback34("SKS", a)
  end
  keepOnlyShinyOptions.Callback = callback147
  section7(section6, keepOnlyShinyOptions)
  keepOnlyShinyOptions = "Button"
  section7 = section6.Button
  local skipCurrentShinyOptions = { Name = "Skip current Shiny" }
  function callback147() callback146() end
  skipCurrentShinyOptions.Callback = callback147
  section7(section6, skipCurrentShinyOptions)
  skipCurrentShinyOptions = "Toggle"
  section7 = section6.Toggle
  local enableFarmOptions = { Name = "Enable Farm" }
  callback147 = sourceContext.callback35
  callback147 = sourceContext.callback35("SF", false)
  enableFarmOptions.Default = callback147
  function callback147(StandFarmEnabled)
    sourceContext.callback34("SF", StandFarmEnabled)
    sourceContext.settings2.StandFarmEnabled = StandFarmEnabled
    if StandFarmEnabled then
      farmStats = { arrowsUsed = 0, rokasUsed = 0, ribsUsed = 0, luckyArrowsUsed = 0, standsGot = 0, startTime = tick() }
      callback142()
    else
      callback143()
      callback145()
    end
  end
  enableFarmOptions.Callback = callback147
  section7(section6, enableFarmOptions)
  enableFarmOptions = "Dropdown"
  section7 = section6.Dropdown
  local farmMethodOptions = { Name = "Farm Method", Options = { [1] = "Arrow", [2] = "Lucky Arrow", [3] = "Rib Cage" } }
  callback147 = sourceContext.callback35
  callback147 = sourceContext.callback35("SFM", "Arrow")
  farmMethodOptions.Default = callback147
  function callback147(a)
    local arrowText = a or "Arrow"
    sourceContext.callback34("SFM", arrowText)
    if sourceContext.settings10.setFarmMethod then sourceContext.settings10.setFarmMethod(arrowText) end
    if sourceContext.settings10.standFarmRunning and sourceContext.settings10.standFarmRunning() or sourceContext.settings10.ribFarmRunning and sourceContext.settings10.ribFarmRunning() then
      callback143()
      callback145()
      task.wait(0.5)
      callback142()
    end
  end
  farmMethodOptions.Callback = callback147
  section7(section6, farmMethodOptions)
  if (sourceContext.settings2.StandFarmEnabled or sourceContext.callback35("SF", false)) and not sourceContext.enabled10 then
    sourceContext.callback2("autostart scheduled: stand farm")
    task.delay(3, function()
      farmStats = { arrowsUsed = 0, rokasUsed = 0, ribsUsed = 0, luckyArrowsUsed = 0, standsGot = 0, startTime = tick() }
      callback142()
    end)
  end
  farmMethodOptions = "Section"
  section7 = Stands.Section(Stands, { Side = "Right", Name = "Stand Pilot" })
  farmMethodOptions = section7
  section7.Header(section7, { Text = "Stand Pilot", AutoLocalize = false })
  local getgenv13 = getgenv()
  farmMethodOptions = "standPilotActive"
  getgenv13.standPilotActive = false
  getgenv().pilotSpeed = 50
  getgenv13 = getgenv
  getgenv13 = getgenv13()
  local PilotConfig = {}
  callback147 = "Speed"
  PilotConfig.Speed = sourceContext.callback35 and sourceContext.callback35("PilotSpeed", 50) or 50
  local speedChangerEnabled = sourceContext.callback35("PSC", false)
  PilotConfig.SpeedChangerEnabled = speedChangerEnabled
  speedChangerEnabled = false
  PilotConfig.IsActive = false
  getgenv13.PilotConfig = PilotConfig
  local entries16 = {}
  local humanoid5 = nil
  function PilotConfig()
    if not getgenv().PilotConfig.IsActive then return end
    pcall(function() if humanoid5 then for k, v in pairs(humanoid5:GetPlayingAnimationTracks()) do v:Stop(0.1) end end end)
    for k, v in pairs(entries16) do if v and typeof(v) == "RBXScriptConnection" then v:Disconnect() end end
    entries16 = {}
    humanoid5 = nil
    pcall(function()
      local ReplicatedStorage = game.ReplicatedStorage
      ReplicatedStorage = ReplicatedStorage:FindFirstChild("TempStoragePilot")
      if ReplicatedStorage then
        for k, v in pairs(ReplicatedStorage:GetChildren()) do if v.Name == "Naples' Sewers" then v.Parent = workspace.Locations end end
        ReplicatedStorage:Destroy()
      end
    end)
    pcall(function()
      local Character = sourceContext.player.Character
      if Character and Character:FindFirstChild("FocusCam") then Character.FocusCam:Destroy() end
    end)
    pcall(function()
      local Character = sourceContext.player.Character
      if Character then for k, v in pairs(Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = true end end end
    end)
    pcall(function()
      local Character = sourceContext.player.Character
      if Character and Character:FindFirstChild("StandMorph") then
        local rootPart5 = Character.StandMorph:FindFirstChild("HumanoidRootPart")
        local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        local remoteFunction4 = Character:FindFirstChild("RemoteFunction")
        if rootPart5 and humanoidRootPart then moveCharacterTo(rootPart5.CFrame) end
        if remoteFunction4 then remoteFunction4:InvokeServer("ToggleStand", "Toggle") end
      end
    end)
    getgenv().PilotConfig.IsActive = false
    getgenv().standPilotActive = false
  end
  speedChangerEnabled = section7
  local toggle3 = section7.Toggle
  local pilotStandOptions = { Name = "Pilot Stand" }
  callback148 = sourceContext.callback35
  callback148 = sourceContext.callback35("PE", false)
  pilotStandOptions.Default = callback148
  function callback148(PilotEnabled)
    sourceContext.callback34("PE", PilotEnabled)
    sourceContext.settings2.PilotEnabled = PilotEnabled
    local Character = sourceContext.player.Character
    if Character then
      local rootPart5 = Character:FindFirstChild("HumanoidRootPart")
      local humanoid6 = Character:FindFirstChild("Humanoid")
      local remoteFunction4 = Character:FindFirstChild("RemoteFunction")
      if rootPart5 and humanoid6 and remoteFunction4 then
        local environment7 = getgenv()
        environment7 = environment7.PilotConfig.IsActive
        if environment7 then
          PilotConfig()
          sourceContext.notify("Stands", "Stand Pilot disabled.")
          return
        end
        if not PilotEnabled then return end
        environment7 = Character.FindFirstChild
        if not environment7(Character, "StandMorph") then
          remoteFunction4:InvokeServer("ToggleStand", "Toggle")
          environment7 = 0
          repeat
            task.wait(0.1)
            environment7 = environment7 + 0.1
            local Character4 = Character
            local FindFirstChild = Character.FindFirstChild
          until FindFirstChild(Character4, "StandMorph") or environment7 > 5
          if not Character:FindFirstChild("StandMorph") then
            sourceContext.notify("Stands", "Failed to summon stand!")
            return
          end
        end
        environment7 = Character.StandMorph
        humanoid5 = environment7.AnimationController
        local rootPart8 = environment7:WaitForChild("HumanoidRootPart", 3)
        if humanoid5 and rootPart8 then
          local SpeedChangerEnabled = getgenv()
          SpeedChangerEnabled = SpeedChangerEnabled.PilotConfig.SpeedChangerEnabled
          if SpeedChangerEnabled then humanoid5.WalkSpeed = getgenv().PilotConfig.Speed end
          local parent3 = getgenv()
          parent3 = parent3.PilotConfig
          parent3.IsActive = true
          parent3 = getgenv
          parent3 = parent3()
          parent3.standPilotActive = true
          parent3 = Instance
          parent3 = parent3.new
          parent3 = parent3("Folder", game.ReplicatedStorage)
          parent3.Name = "TempStoragePilot"
          pcall(function()
            for k, v in pairs(workspace.Locations:GetChildren()) do if v.Name == "Naples' Sewers" then v.Parent = parent3 end end
          end)
          local new = Instance.new("ObjectValue", environment7.Parent)
          new.Name = "FocusCam"
          new.Value = humanoid5
          local new2, entry18, entry19 = pairs(Character:GetDescendants())
          for k, v in new2, entry18, entry19 do if v:IsA("BasePart") then v.CanCollide = false end end
          pcall(function()
            local standAttach = environment7.PrimaryPart:FindFirstChild("StandAttach")
            if standAttach then
              local alignOrientation = standAttach:FindFirstChild("AlignOrientation")
              local alignPosition = standAttach:FindFirstChild("AlignPosition")
              if alignOrientation then alignOrientation.Enabled = false end
              if alignPosition then alignPosition.Enabled = false end
            end
          end)
          new2 = Instance.new("Animation")
          new2.AnimationId = "rbxassetid://5191325822"
          local loadAnimationResult = nil
          pcall(function()
            if humanoid5 then
              loadAnimationResult = humanoid5:LoadAnimation(new2)
              if loadAnimationResult then
                loadAnimationResult.Priority = Enum.AnimationPriority.Action
                loadAnimationResult.Looped = true
              end
            end
          end)
          local enabled33 = false
          table.insert(entries16, humanoid6:GetPropertyChangedSignal("Jump"):Connect(function()
            if humanoid6.Jump then humanoid5.Jump = true end
            task.wait()
          end))
          table.insert(entries16, sourceContext.runServiceService.Heartbeat:Connect(function()
            if not (Character and Character.Parent) then return end
            if environment7 and environment7.Parent then
              local vectorToObjectSpaceResult = workspace.CurrentCamera.CFrame:VectorToObjectSpace(humanoid6.MoveDirection)
              humanoid5:Move(vectorToObjectSpaceResult, true)
              local count18 = vectorToObjectSpaceResult.Magnitude > 0.1
              if count18 and not enabled33 then
                enabled33 = true
                pcall(function()
                  if loadAnimationResult and loadAnimationResult.IsPlaying == false then loadAnimationResult:Play(0.2) end
                end)
              elseif not count18 and enabled33 then
                enabled33 = false
                pcall(function()
                  if loadAnimationResult and loadAnimationResult.IsPlaying then loadAnimationResult:Stop(0.2) end
                end)
              end
              if not count18 then
                pcall(function()
                  if humanoid5 then
                    local isPlayingResult = humanoid5:IsPlaying()
                    if isPlayingResult then

                    end
                  end
                end)
              end
              if getgenv().PilotConfig.SpeedChangerEnabled then humanoid5.WalkSpeed = getgenv().PilotConfig.Speed end
              if rootPart8 and rootPart5 then
                rootPart5.CFrame = rootPart8.CFrame - Vector3.new(0, 25, 0)
                rootPart5.AssemblyLinearVelocity = Vector3.zero
                rootPart5.AssemblyAngularVelocity = Vector3.zero
              end
              return
            end
            pcall(function() remoteFunction4:InvokeServer("ToggleStand", "Toggle") end)
          end))
          pcall(function()
            for k, v in pairs(environment7.Parent:GetDescendants()) do
              if v:IsA("BasePart") or v:IsA("UnionOperation") then game:GetService("PhysicsService"):SetPartCollisionGroup(v, "Players") end
            end
          end)
          sourceContext.notify("Stands", "Stand Pilot enabled!")
          return
        end
        sourceContext.notify("Stands", "Stand not properly loaded!")
        return
      end
      sourceContext.notify("Stands", "Character not ready!")
      return
    end
    sourceContext.notify("Stands", "Character not loaded!")
  end
  pilotStandOptions.Callback = callback148
  toggle3(section7, pilotStandOptions)
  pilotStandOptions = "Toggle"
  speedChangerEnabled = section7
  toggle3 = section7.Toggle
  local pilotSpeedChangerOptions = { Name = "Pilot Speed Changer" }
  callback148 = sourceContext.callback35
  callback148 = sourceContext.callback35("PSC", false)
  pilotSpeedChangerOptions.Default = callback148
  function callback148(SpeedChangerEnabled)
    sourceContext.callback34("PSC", SpeedChangerEnabled)
    getgenv().PilotConfig.SpeedChangerEnabled = SpeedChangerEnabled
    if SpeedChangerEnabled and humanoid5 then
      humanoid5.WalkSpeed = getgenv().PilotConfig.Speed
      sourceContext.notify("Stands", "Speed changer " .. (SpeedChangerEnabled and "enabled" or "disabled"))
    end
  end
  pilotSpeedChangerOptions.Callback = callback148
  toggle3(section7, pilotSpeedChangerOptions)
  pilotSpeedChangerOptions = "Slider"
  speedChangerEnabled = section7
  toggle3 = section7.Slider
  local pilotSpeedOptions = { Name = "Pilot Speed" }
  callback148 = tonumber
  sapphireText = if sourceContext.callback35 then sourceContext.callback35("PilotSpeed", getgenv().PilotConfig.Speed) else sourceContext.callback35
  pilotSpeedOptions.Default = callback148(sapphireText) or 50
  callback148 = 0
  pilotSpeedOptions.Minimum = 0
  pilotSpeedOptions.Maximum = 200
  pilotSpeedOptions.DisplayMethod = "Value"
  pilotSpeedOptions.Precision = 0
  function pilotSpeedOptions.Callback(a)
    getgenv().PilotConfig.Speed = a
    sourceContext.callback34("PilotSpeed", a)
    local getgenv4 = getgenv
    getgenv4 = getgenv4()
    getgenv4 = getgenv4.PilotConfig.SpeedChangerEnabled
    if getgenv4 and humanoid5 and humanoid5.Parent then humanoid5.WalkSpeed = a end
  end
  function pilotSpeedOptions.onInputComplete(a)
    sourceContext.callback34("PilotSpeed", a)
    sourceContext.notify("Stands", "Pilot speed set to: " .. a)
  end
  toggle3(section7, pilotSpeedOptions)
  pilotSpeedOptions = "Toggle"
  speedChangerEnabled = section7
  toggle3 = section7.Toggle
  local infPilotRangeOptions = { Name = "Inf Pilot Range" }
  callback148 = sourceContext.callback35
  callback148 = sourceContext.callback35("IPR", false)
  infPilotRangeOptions.Default = callback148
  function callback148(infPilotRangeEnabled)
    sourceContext.callback34("IPR", infPilotRangeEnabled)
    getgenv().infPilotRangeEnabled = infPilotRangeEnabled
    if infPilotRangeEnabled then
      sourceContext.notify("Stands", "Infinite Pilot Range enabled.")
      getgenv().infPilotRangeConnection = sourceContext.runServiceService.Heartbeat:Connect(function()
        pcall(function()
          if sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("StandMorph") then
            local StandMorph = sourceContext.player.Character.StandMorph
            StandMorph = StandMorph:FindFirstChild("IsPiloting")
            if StandMorph then StandMorph.Value = 999999 end
          end
        end)
      end)
    else
      sourceContext.notify("Stands", "Infinite Pilot Range disabled.")
      if getgenv().infPilotRangeConnection then
        getgenv().infPilotRangeConnection:Disconnect()
        getgenv().infPilotRangeConnection = nil
      end
    end
  end
  infPilotRangeOptions.Callback = callback148
  toggle3(section7, infPilotRangeOptions)
  toggle3 = sourceContext.player.CharacterAdded
  infPilotRangeOptions = "Connect"
  speedChangerEnabled = toggle3
  toggle3.Connect(toggle3, function()
    if getgenv().PilotConfig.IsActive then
      PilotConfig()
      sourceContext.notify("Stands", "Stand Pilot auto-disabled (character respawned).")
    end
    if getgenv().infPilotRangeConnection then
      getgenv().infPilotRangeConnection:Disconnect()
      getgenv().infPilotRangeConnection = nil
    end
  end)
  speedChangerEnabled = section7
  toggle3 = section7.Button
  local forceCleanupPilotOptions = { Name = "Force Cleanup Pilot" }
  function callback148()
    PilotConfig()
    sourceContext.notify("Stands", "Pilot cleanup forced!")
  end
  forceCleanupPilotOptions.Callback = callback148
  toggle3(section7, forceCleanupPilotOptions)
end
sourceContext.Shop, sourceContext.sectionText5 = sourceContext.entries12.Shop, "Section"
sourceContext.sectionResult3 = sourceContext.Shop.Section(sourceContext.Shop, { Side = "Left", Name = "Items" })
sourceContext.sectionResult3.Header(sourceContext.sectionResult3, { Text = "Buy Items", AutoLocalize = false })
do
  local function callback149()
    return sourceContext.player.Character or sourceContext.player.CharacterAdded:Wait()
  end
  local sectionResult4
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Rokakaka ($2,500)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Rokakaka" }, 1, 2)
        sourceContext.notify("Shop", "Bought Rokakaka")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Pure Rokakaka ($4,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Pure Rokakaka" }, 1, 2)
        sourceContext.notify("Shop", "Bought Pure Rokakaka")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Mysterious Arrow ($750)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Mysterious Arrow" }, 1, 2)
        sourceContext.notify("Shop", "Bought Mysterious Arrow")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Lucky Arrow ($75,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Lucky Arrow" }, 1, 2)
        sourceContext.notify("Shop", "Bought Lucky Arrow")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy DIO's Diary ($20,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x DIO's Diary" }, 1, 2)
        sourceContext.notify("Shop", "Bought DIO's Diary")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Rib Cage ($3,500)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Rib Cage of The Saint's Corpse" }, 1, 2)
        sourceContext.notify("Shop", "Bought Rib Cage")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Left Arm ($15,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Left Arm of The Saint's Corpse" }, 1, 2)
        sourceContext.notify("Shop", "Bought Left Arm")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Pelvis ($45,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Pelvis of The Saint's Corpse" }, 1, 2)
        sourceContext.notify("Shop", "Bought Pelvis")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Heart ($45,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PurchaseShopItem", { ItemName = "1x Heart of The Saint's Corpse" }, 1, 2)
        sourceContext.notify("Shop", "Bought Heart")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Pizza ($50)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Pizza", Option = "Option1", Dialogue = "Dialogue2" }, 1, 2)
        sourceContext.notify("Shop", "Bought Pizza")
      end
    end,
  })
  sourceContext.sectionResult3.Button(sourceContext.sectionResult3, {
    Name = "Buy Tea ($50)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Cafe", Option = "Option1", Dialogue = "Dialogue2" }, 1, 2)
        sourceContext.notify("Shop", "Bought Tea")
      end
    end,
  })
  sectionResult4 = sourceContext.Shop.Section(sourceContext.Shop, { Side = "Right", Name = "Fighting Styles" })
  sectionResult4.Header(sectionResult4, { Text = "Buy Fighting Styles", AutoLocalize = false })
  local sectionResult5
  sectionResult4.Button(sectionResult4, {
    Name = "Buy Hamon ($15,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Jonathan", Option = "Option1", Dialogue = "Dialogue5" })
        sourceContext.notify("Shop", "Bought Hamon")
      end
    end,
  })
  sectionResult4.Button(sectionResult4, {
    Name = "Buy Boxing ($10,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Quinton", Option = "Option1", Dialogue = "Dialogue5" })
        sourceContext.notify("Shop", "Bought Boxing")
      end
    end,
  })
  sectionResult4.Button(sectionResult4, {
    Name = "Buy Spin ($10,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Gyro", Option = "Option1", Dialogue = "Dialogue5" })
        sourceContext.notify("Shop", "Bought Spin")
      end
    end,
  })
  sectionResult4.Button(sectionResult4, {
    Name = "Buy Vampire ($10,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Elder Vampire Roomy", Option = "Option1", Dialogue = "Dialogue5" })
        sourceContext.notify("Shop", "Bought Vampire")
      end
    end,
  })
  sectionResult4.Button(sectionResult4, {
    Name = "Buy Pluck ($10,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Uzurashi", Option = "Option1", Dialogue = "Dialogue5" })
        sourceContext.notify("Shop", "Bought Pluck")
      end
    end,
  })
  sectionResult4.Button(sectionResult4, {
    Name = "Buy Boxing Gloves ($1,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Boxing Gloves", Option = "Option1", Dialogue = "Dialogue1" })
        sourceContext.notify("Shop", "Bought Boxing Gloves")
      end
    end,
  })
  sectionResult4.Button(sectionResult4, {
    Name = "Buy Sword ($1,000)",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("EndDialogue", { NPC = "Pluck", Option = "Option1", Dialogue = "Dialogue1" })
        sourceContext.notify("Shop", "Bought Sword")
      end
    end,
  })
  sectionResult5 = sourceContext.Shop.Section(sourceContext.Shop, { Side = "Right", Name = "Dialogues" })
  sectionResult5.Header(sectionResult5, { Text = "Open Dialogues", AutoLocalize = false })
  sectionResult5.Button(sectionResult5, {
    Name = "Halloween Event Dialogue",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue:FindFirstChild("Halloween Event"))
        sourceContext.notify("Shop", "Opened Halloween Shop")
      end
    end,
  })
  sectionResult5.Button(sectionResult5, {
    Name = "Jesus Dialogue",
    Callback = function()
      local remoteEvent6 = callback149():FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue.Jesus)
        sourceContext.notify("Shop", "Opened Jesus Dialogue")
      end
    end,
  })
  local function callback150()
    local coreGuiService = gethui and gethui() or game:GetService("CoreGui")
    local settings7 = sourceContext.RAILhubWindow and sourceContext.RAILhubWindow.Settings
    local rAILHubText = settings7 and settings7.Title or "RAIL|hub"
    local yBAText = settings7 and settings7.Subtitle or "YBA"
    local Parent = nil
    for k2, v2 in ipairs(coreGuiService:GetChildren()) do
      if v2:IsA("ScreenGui") then
        for k, v in ipairs(v2:GetDescendants()) do
          if v:IsA("TextLabel") and v.Text == rAILHubText then
            Parent = v
            break
          end
        end
      end
      if Parent then break end
    end
    if Parent then
      local Parent2 = Parent.Parent
      if Parent2 and Parent2:IsA("GuiObject") then
        local menuHeaderPadding = Parent2:FindFirstChild("MenuHeaderPadding")
        if not menuHeaderPadding then
          menuHeaderPadding = Instance.new("UIPadding")
          menuHeaderPadding.Name = "MenuHeaderPadding"
          menuHeaderPadding.Parent = Parent2
        end
        menuHeaderPadding.PaddingLeft = UDim.new(0, 40)
        Parent.AnchorPoint = Vector2.new(0, 0)
        local TextSize = math
        TextSize = TextSize.max
        local TextSize2 = Parent.TextSize
        Parent.TextSize = TextSize(16, TextSize2 or 0)
        TextSize = Parent.SetAttribute
        TextSize(Parent, "WaveRawText", Parent.Text)
        function TextSize(a)
          if a:GetAttribute("MenuOffsetX") == nil then
            local AbsolutePosition2 = Parent2.AbsolutePosition
            local AbsolutePosition = a.AbsolutePosition
            a:SetAttribute("MenuOffsetX", math.floor(AbsolutePosition.X - AbsolutePosition2.X + 0.5))
            a:SetAttribute("MenuOffsetY", math.floor(AbsolutePosition.Y - AbsolutePosition2.Y + 0.5))
          end
          a.Position = UDim2.new(0, a:GetAttribute("MenuOffsetX") or a.Position.X.Offset, 0, a:GetAttribute("MenuOffsetY") or a.Position.Y.Offset)
        end
        TextSize(Parent)
        for k3, v3 in ipairs(Parent2:GetChildren()) do
          if v3:IsA("TextLabel") and v3.Text == yBAText then
            v3.AnchorPoint = Vector2.new(0, 0)
            TextSize(v3)
            break
          end
        end
        function TextSize2(a)
          if not a then return end
          local base = a:FindFirstChild("Base", true)
          local sidebar = base and base:FindFirstChild("Sidebar", true)
          local information = sidebar and sidebar:FindFirstChild("Information", true)
          local informationHolder = information and information:FindFirstChild("InformationHolder", true)
          if informationHolder then return informationHolder end
          for k, v in ipairs(a:GetDescendants()) do if v:IsA("Frame") and v.Name == "InformationHolder" then return v end end
        end
        local Parent3 = Parent
        local FindFirstAncestorWhichIsA = Parent.FindFirstAncestorWhichIsA
        FindFirstAncestorWhichIsA = FindFirstAncestorWhichIsA(Parent, "ScreenGui") or game:GetService("CoreGui")
        Parent3 = TextSize2
        Parent3 = TextSize2(FindFirstAncestorWhichIsA)
        local menuLeftImage = Parent2:FindFirstChild("MenuLeftImage")
        if menuLeftImage then menuLeftImage:Destroy() end
        if Parent3 then
          menuLeftImage = Parent3:FindFirstChild("MenuLeftImage")
          if menuLeftImage then menuLeftImage:Destroy() end
        end
        local Parent4 = Instance.new("ImageLabel")
        Parent4.Name = "MenuLeftImage"
        Parent4.BackgroundTransparency = 1
        Parent4.Size = UDim2.new(0, 40, 0, 40)
        Parent4.ScaleType = Enum.ScaleType.Crop
        Parent4.ZIndex = Parent.ZIndex
        Instance.new("UICorner").Parent = Parent4
        local position5
        Parent4.Image = getgenv()._YBA_resolveMenuHeaderImage and getgenv()._YBA_resolveMenuHeaderImage() or ""
        position5 = Vector2
        position5 = position5.new
        position5 = position5(0, 0)
        Parent4.AnchorPoint = position5
        if Parent3 then
          Parent4.Parent = Parent3
          position5 = UDim2.new(0, -10, 1, -40)
          Parent4.Position = position5
        else
          Parent4.Parent = Parent
          position5 = UDim2.new(0, -50, 1, -12)
          Parent4.Position = position5
        end
        return true
      end
      return false
    end
    return false
  end
  task.spawn(function()
    for i = 1, 40 do
      if callback150() then return end
      task.wait(0.2)
    end
  end)
end
sourceContext.Player, sourceContext.sectionText6 = sourceContext.entries12.Player, "Section"
sourceContext.section8 = sourceContext.Player.Section(sourceContext.Player, { Side = "Left", Name = "Visuals" })
sourceContext.section8.Header(sourceContext.section8, { Text = "Visuals", AutoLocalize = false })
sourceContext.section9 = sourceContext.section8.Toggle
sourceContext.viewSelfHPOptions = { Name = "View Self HP" }
sourceContext.callback151 = sourceContext.callback35
sourceContext.callback151 = sourceContext.callback35("HUD_HP", true)
sourceContext.viewSelfHPOptions.Default = sourceContext.callback151
function sourceContext.callback151(HUDHealthEnabled)
  sourceContext.callback34("HUD_HP", HUDHealthEnabled)
  getgenv().HUDHealthEnabled = HUDHealthEnabled
end
sourceContext.viewSelfHPOptions.Callback = sourceContext.callback151
sourceContext.section9(sourceContext.section8, sourceContext.viewSelfHPOptions)
sourceContext.viewSelfHPOptions = "Section"
blockBotSec = sourceContext.Player.Section(sourceContext.Player, { Side = "Left", Name = "Block Bot" })
blockBotSettingsSec = sourceContext.Player.Section(sourceContext.Player, { Side = "Right", Name = "Settings" })
sourceContext.section9 = blockBotSettingsSec
sourceContext.section9.Header(sourceContext.section9, { Text = "Movement", AutoLocalize = false })
sourceContext.section9 = getgenv
sourceContext.section9 = sourceContext.section9()
sourceContext.playerMoveCfgText = "PlayerMoveCfg"
sourceContext.PlayerMoveCfg = getgenv()
sourceContext.PlayerMoveCfg = sourceContext.PlayerMoveCfg.PlayerMoveCfg
if not sourceContext.PlayerMoveCfg then
  sourceContext.PlayerMoveCfg = {
    Speed = sourceContext.callback35("PMS", false), WalkSpeed = sourceContext.callback35("PWS", 35),
    JumpPowerEnabled = sourceContext.callback35("PJP_E", false), JumpPower = sourceContext.callback35("PJP", 50),
    Fly = sourceContext.callback35("PFLY", false), FlySpeed = sourceContext.callback35("PFS", 75),
  }
end
sourceContext.section9.PlayerMoveCfg = sourceContext.PlayerMoveCfg
moveLoop = moveLoop or sourceContext.runServiceService.Heartbeat:Connect(function()
  local PlayerMoveCfg = getgenv().PlayerMoveCfg
  local Character = sourceContext.player.Character
  local humanoid7 = Character and Character:FindFirstChildOfClass("Humanoid")
  local rootPart9 = Character and Character:FindFirstChild("HumanoidRootPart")
  if humanoid7 then humanoid7.UseJumpPower = true end
  if not (humanoid7 and rootPart9) then return end
  if PlayerMoveCfg.Fly then
    local cFrame2 = sourceContext.parent.CurrentCamera and sourceContext.parent.CurrentCamera.CFrame or rootPart9.CFrame
    local lookVector = cFrame2.LookVector
    local rightVector = cFrame2.RightVector
    local upVector = cFrame2.UpVector
    local zero = Vector3.zero
    if lookVector.Magnitude > 0 then lookVector = lookVector.Unit end
    if rightVector.Magnitude > 0 then rightVector = rightVector.Unit end
    if upVector.Magnitude > 0 then upVector = upVector.Unit end
    if sourceContext.userInputServiceService:IsKeyDown(Enum.KeyCode.W) then zero = zero + lookVector end
    if sourceContext.userInputServiceService:IsKeyDown(Enum.KeyCode.S) then zero = zero - lookVector end
    if sourceContext.userInputServiceService:IsKeyDown(Enum.KeyCode.D) then zero = zero + rightVector end
    if sourceContext.userInputServiceService:IsKeyDown(Enum.KeyCode.A) then zero = zero - rightVector end
    if sourceContext.userInputServiceService:IsKeyDown(Enum.KeyCode.Space) then zero = zero + upVector end
    local entry18 = sourceContext.userInputServiceService
    entry18 = sourceContext.userInputServiceService.IsKeyDown
    entry18 = entry18(sourceContext.userInputServiceService, Enum.KeyCode.LeftShift)
    if entry18 or sourceContext.userInputServiceService:IsKeyDown(Enum.KeyCode.LeftControl) then zero = zero - upVector end
    entry18 = zero.Magnitude
    local AssemblyLinearVelocity
    AssemblyLinearVelocity = if entry18 > 0 then zero.Unit * PlayerMoveCfg.FlySpeed else zero
    rootPart9.AssemblyLinearVelocity = AssemblyLinearVelocity
    humanoid7:ChangeState(Enum.HumanoidStateType.Freefall)
  elseif PlayerMoveCfg.Speed and humanoid7.MoveDirection.Magnitude > 0 then
    local walkSpeed = humanoid7.MoveDirection.Unit * PlayerMoveCfg.WalkSpeed
    rootPart9.AssemblyLinearVelocity = Vector3.new(walkSpeed.X, rootPart9.AssemblyLinearVelocity.Y, walkSpeed.Z)
  end
end)
sourceContext.section9 = blockBotSettingsSec
sourceContext.playerMoveCfgText = sourceContext.section9
sourceContext.section9 = sourceContext.section9.Toggle
sourceContext.speedChangerOptions = { Name = "Speed Changer" }
sourceContext.callback151 = sourceContext.callback35
sourceContext.callback151 = sourceContext.callback35("PMS", false)
sourceContext.speedChangerOptions.Default = sourceContext.callback151
function sourceContext.callback151(Speed)
  getgenv().PlayerMoveCfg.Speed = Speed
  sourceContext.callback34("PMS", Speed)
end
sourceContext.speedChangerOptions.Callback = sourceContext.callback151
sourceContext.section9(sourceContext.playerMoveCfgText, sourceContext.speedChangerOptions)
sourceContext.section9 = blockBotSettingsSec
sourceContext.speedChangerOptions = "Slider"
sourceContext.playerMoveCfgText = sourceContext.section9
sourceContext.section9 = sourceContext.section9.Slider
sourceContext.walkSpeedOptions = { Name = "WalkSpeed" }
sourceContext.callback151 = tonumber
sourceContext.entry32 = nil
sourceContext.entry32 = if sourceContext.callback35 then sourceContext.callback35("PWS", getgenv().PlayerMoveCfg.WalkSpeed) else sourceContext.callback35
sourceContext.walkSpeedOptions.Default = sourceContext.callback151(sourceContext.entry32) or 35
sourceContext.callback151 = 0
sourceContext.walkSpeedOptions.Minimum = 0
sourceContext.walkSpeedOptions.Maximum = 200
sourceContext.walkSpeedOptions.DisplayMethod = "Value"
sourceContext.walkSpeedOptions.Precision = 0
function sourceContext.walkSpeedOptions.Callback(a)
  getgenv().PlayerMoveCfg.WalkSpeed = math.max(0, a)
  sourceContext.callback34("PWS", getgenv().PlayerMoveCfg.WalkSpeed)
end
function sourceContext.walkSpeedOptions.onInputComplete(a) sourceContext.notify("Player", "WalkSpeed: " .. a) end
sourceContext.section9(sourceContext.playerMoveCfgText, sourceContext.walkSpeedOptions)
sourceContext.section9 = blockBotSettingsSec
sourceContext.walkSpeedOptions = "Toggle"
sourceContext.playerMoveCfgText = sourceContext.section9
sourceContext.section9 = sourceContext.section9.Toggle
sourceContext.jumpPowerChangerOptions = { Name = "JumpPower Changer" }
sourceContext.callback151 = sourceContext.callback35
sourceContext.callback151 = sourceContext.callback35("PJP_E", false)
sourceContext.jumpPowerChangerOptions.Default = sourceContext.callback151
function sourceContext.callback151(JumpPowerEnabled)
  getgenv().PlayerMoveCfg.JumpPowerEnabled = JumpPowerEnabled
  sourceContext.callback34("PJP_E", JumpPowerEnabled)
end
sourceContext.jumpPowerChangerOptions.Callback = sourceContext.callback151
sourceContext.section9(sourceContext.playerMoveCfgText, sourceContext.jumpPowerChangerOptions)
sourceContext.section9 = blockBotSettingsSec
sourceContext.jumpPowerChangerOptions = "Slider"
sourceContext.playerMoveCfgText = sourceContext.section9
sourceContext.section9 = sourceContext.section9.Slider
sourceContext.jumpPowerOptions = { Name = "JumpPower" }
sourceContext.callback151 = tonumber
sourceContext.entry33 = nil
sourceContext.entry33 = if sourceContext.callback35 then sourceContext.callback35("PJP", getgenv().PlayerMoveCfg.JumpPower) else sourceContext.callback35
sourceContext.jumpPowerOptions.Default = sourceContext.callback151(sourceContext.entry33) or 50
sourceContext.callback151 = 0
sourceContext.jumpPowerOptions.Minimum = 0
sourceContext.jumpPowerOptions.Maximum = 200
sourceContext.jumpPowerOptions.DisplayMethod = "Value"
sourceContext.jumpPowerOptions.Precision = 0
function sourceContext.jumpPowerOptions.Callback(a)
  getgenv().PlayerMoveCfg.JumpPower = math.max(0, a)
  sourceContext.callback34("PJP", getgenv().PlayerMoveCfg.JumpPower)
end
function sourceContext.jumpPowerOptions.onInputComplete(a) sourceContext.notify("Player", "JumpPower: " .. a) end
sourceContext.section9(sourceContext.playerMoveCfgText, sourceContext.jumpPowerOptions)
sourceContext.section9 = blockBotSettingsSec
sourceContext.jumpPowerOptions = "Toggle"
sourceContext.playerMoveCfgText = sourceContext.section9
sourceContext.section9 = sourceContext.section9.Toggle
sourceContext.flyOptions = { Name = "Fly" }
sourceContext.callback151 = sourceContext.callback35
sourceContext.callback151 = sourceContext.callback35("PFLY", false)
sourceContext.flyOptions.Default = sourceContext.callback151
function sourceContext.callback151(Fly)
  getgenv().PlayerMoveCfg.Fly = Fly
  sourceContext.callback34("PFLY", Fly)
end
sourceContext.flyOptions.Callback = sourceContext.callback151
sourceContext.section9(sourceContext.playerMoveCfgText, sourceContext.flyOptions)
sourceContext.section9 = blockBotSettingsSec
sourceContext.flyOptions = "Slider"
sourceContext.playerMoveCfgText = sourceContext.section9
sourceContext.section9 = sourceContext.section9.Slider
sourceContext.flySpeedOptions = { Name = "Fly Speed" }
sourceContext.callback151 = tonumber
sourceContext.entry34 = nil
sourceContext.entry34 = if sourceContext.callback35 then sourceContext.callback35("PFS", getgenv().PlayerMoveCfg.FlySpeed) else sourceContext.callback35
sourceContext.flySpeedOptions.Default = sourceContext.callback151(sourceContext.entry34) or 75
sourceContext.callback151 = 0
sourceContext.flySpeedOptions.Minimum = 0
sourceContext.flySpeedOptions.Maximum = 300
sourceContext.flySpeedOptions.DisplayMethod = "Value"
sourceContext.flySpeedOptions.Precision = 0
function sourceContext.flySpeedOptions.Callback(a)
  getgenv().PlayerMoveCfg.FlySpeed = math.max(0, a)
  sourceContext.callback34("PFS", getgenv().PlayerMoveCfg.FlySpeed)
end
function sourceContext.flySpeedOptions.onInputComplete(a) sourceContext.notify("Player", "Fly Speed: " .. a) end
sourceContext.section9(sourceContext.playerMoveCfgText, sourceContext.flySpeedOptions)
sourceContext.section9 = blockBotSettingsSec
sourceContext.flySpeedOptions = "Toggle"
sourceContext.playerMoveCfgText = sourceContext.section9
sourceContext.section9 = sourceContext.section9.Toggle
sourceContext.noclipOptions = { Name = "Noclip" }
sourceContext.callback151 = sourceContext.callback35
sourceContext.callback151 = sourceContext.callback35("PNC", false)
sourceContext.noclipOptions.Default = sourceContext.callback151
function sourceContext.callback151(a)
  sourceContext.callback34("PNC", a)
  local YBAItemFarm = _G.YBAItemFarm
  if a then
    if YBAItemFarm and YBAItemFarm.enableNoclip then
      YBAItemFarm.enableNoclip("main")
    elseif enableNoclip then enableNoclip("main") end
  elseif YBAItemFarm and YBAItemFarm.disableNoclip then
    YBAItemFarm.disableNoclip("main")
  elseif disableNoclip then disableNoclip("main") end
end
sourceContext.noclipOptions.Callback = sourceContext.callback151
sourceContext.section9(sourceContext.playerMoveCfgText, sourceContext.noclipOptions)
do
  local connectResult9 = nil
  local enabled34 = false
  local function callback152(a)
    enabled34 = a
    if a then
      local LocalPlayer = game:GetService("Players")
      LocalPlayer = LocalPlayer.LocalPlayer
      local function callback23()
        local Character = LocalPlayer.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then return Character.HumanoidRootPart end
        return nil
      end
      if callback23() then
        local pairsResult, entry18, entry19 = pairs(workspace:GetChildren())
        for k, v in pairsResult, entry18, entry19 do
          if v:IsA("MeshPart") and v.Name == "Money" then
            task.spawn(function()
              task.wait(0.1)
              while enabled34 and v.Parent == workspace do
                local rootPart9 = callback23()
                if rootPart9 then v.CFrame = rootPart9.CFrame end
                task.wait()
              end
            end)
          end
        end
      end
      if not connectResult9 then
        connectResult9 = workspace.ChildAdded:Connect(function(b)
          if b.Name == "Money" then
            task.spawn(function()
              task.wait(0.55)
              while enabled34 and b.Parent == workspace do
                local rootPart9 = callback23()
                if rootPart9 then b.CFrame = rootPart9.CFrame end
                task.wait()
              end
            end)
          end
        end)
      end
    elseif connectResult9 then
      connectResult9:Disconnect()
      connectResult9 = nil
    end
  end
  local blockBotSettingsSec2 = blockBotSettingsSec
  sourceContext.callback151 = blockBotSettingsSec2
  local Toggle = blockBotSettingsSec2.Toggle
  local stealDroppedMoneyOptions = { Name = "Steal Dropped Money" }
  local callback153 = sourceContext.callback35
  callback153 = sourceContext.callback35("PStealMoney", false)
  stealDroppedMoneyOptions.Default = callback153
  function callback153(a)
    sourceContext.callback34("PStealMoney", a)
    callback152(a)
  end
  stealDroppedMoneyOptions.Callback = callback153
  Toggle(blockBotSettingsSec2, stealDroppedMoneyOptions)
  Toggle = sourceContext.callback35
  Toggle = sourceContext.callback35("PStealMoney", false)
  if Toggle and not sourceContext.enabled10 then task.delay(1.5, function() callback152(true) end) end
  local connectResult10, connectResult11 = nil, nil
  local enabled35 = false
  local function callback154(a)
    if connectResult10 then
      connectResult10:Disconnect()
      connectResult10 = nil
    end
    if connectResult11 then
      connectResult11:Disconnect()
      connectResult11 = nil
    end
    if not a then return end
    local humanoid7 = a:WaitForChild("Humanoid", 5)
    local rootPart9 = a:WaitForChild("HumanoidRootPart", 5)
    if not (humanoid7 and rootPart9) then return end
    connectResult11 = humanoid7.StateChanged:Connect(function(_, b)
      if b == Enum.HumanoidStateType.Landed or b == Enum.HumanoidStateType.Running or b == Enum.HumanoidStateType.RunningNoPhysics or b == Enum.HumanoidStateType.Seated then
        enabled35 = false
      end
    end)
    connectResult10 = humanoid7:GetPropertyChangedSignal("Jump"):Connect(function()
      local PlayerMoveCfg = getgenv().PlayerMoveCfg
      if PlayerMoveCfg and PlayerMoveCfg.JumpPowerEnabled and humanoid7.Jump and not enabled35 then
        local getStateResult = humanoid7:GetState()
        if humanoid7.FloorMaterial ~= Enum.Material.Air or getStateResult == Enum.HumanoidStateType.Running or getStateResult == Enum.HumanoidStateType.RunningNoPhysics or getStateResult == Enum.HumanoidStateType.Landed or getStateResult == Enum.HumanoidStateType.Jumping then
          enabled35 = true
          local count18 = tonumber(PlayerMoveCfg.JumpPower) or 50
          task.defer(function()
            if rootPart9 and rootPart9.Parent and humanoid7 and humanoid7.Parent then
              rootPart9.AssemblyLinearVelocity = Vector3.new(rootPart9.AssemblyLinearVelocity.X, count18, rootPart9.AssemblyLinearVelocity.Z)
            end
          end)
          task.delay(0.25, function()
            if humanoid7 and humanoid7.Parent and humanoid7.FloorMaterial ~= Enum.Material.Air then enabled35 = false end
          end)
        end
      end
    end)
  end
  callback153 = "CharacterAdded"
  local characterAdded = sourceContext.player.CharacterAdded
  characterAdded.Connect(characterAdded, callback154)
  if sourceContext.player.Character then callback154(sourceContext.player.Character) end
  characterAdded = sourceContext.callback35
  characterAdded = sourceContext.callback35("PNC", false)
  if characterAdded then
    task.delay(1, function()
      local YBAItemFarm = _G.YBAItemFarm
      if YBAItemFarm and YBAItemFarm.enableNoclip then
        YBAItemFarm.enableNoclip("main")
      elseif enableNoclip then enableNoclip("main") end
    end)
  end
end
sourceContext.entries17 = {}
sourceContext.blockBotSec2 = blockBotSec
sourceContext.headerText, sourceContext.blockBotSec22 = "Header", sourceContext.blockBotSec2
sourceContext.blockBotSec2.Header(sourceContext.blockBotSec2, { Text = "Block Bot", AutoLocalize = false })
sourceContext.entries17.blockbot = sourceContext.callback35("BB", false)
sourceContext.entries17.reblocking = sourceContext.callback35("BB_RB", true)
sourceContext.entries17.keepblock = sourceContext.callback35("BB_KB", true)
sourceContext.entries17.projectiles_priority = sourceContext.callback35("BB_PP", false)
sourceContext.entries17.unblocking = sourceContext.callback35("BB_UB", true)
sourceContext.entries17.coliseumenabled = sourceContext.callback35("BB_COL", false)
_G.rodblocking = sourceContext.callback35("BB_ROD", false)
sourceContext.entries17.lboverriding = true
sourceContext.entries17.blockprocsuntil = 0
sourceContext.entries17.lastblock = 0
sourceContext.entries17.blockactions = false
sourceContext.entries17.blocked = false
sourceContext.entries17.lastboi = nil
sourceContext.entries17.lastbad = ""
sourceContext.lastbb2 = nil
sourceContext.entries17.lastbb = tick()
sourceContext.blocksPerfect = {}
sourceContext.lastbb2 = {}
sourceContext.settings12 = { def = 0.2 }
sourceContext.lastbb2[1] = "rbxassetid://7217913060"
sourceContext.lastbb2[2] = sourceContext.settings12
sourceContext.settings12 = "rbxassetid://6032844827"
sourceContext.entries18 = {}
sourceContext.settings13 = {
  def = 0,
  chckfunc = function(a)
    local standMorph = a.Parent:FindFirstChild("StandMorph")
    if standMorph then
      local standName = standMorph:FindFirstChild("Stand Name")
      return standName and standName.Value == "Star Platinum"
    end
    return false
  end,
}
sourceContext.entries18[1] = "rbxassetid://7217914447"
sourceContext.entries18[2] = sourceContext.settings13
sourceContext.entries19 = {}
sourceContext.settings13 = "rbxassetid://7217914447"
sourceContext.def = {
  def = 0,
  chckfunc = function(a)
    local standMorph = a.Parent:FindFirstChild("StandMorph")
    if standMorph then
      local standName = standMorph:FindFirstChild("Stand Name")
      return standName and standName.Value ~= "Star Platinum"
    end
    return false
  end,
}
sourceContext.entries19[1] = "rbxassetid://7217914447"
sourceContext.entries19[2] = sourceContext.def
sourceContext.blocksPerfect[1] = sourceContext.lastbb2
sourceContext.blocksPerfect[2] = "rbxassetid://4725629903"
sourceContext.blocksPerfect[3] = "rbxassetid://6032844827"
sourceContext.blocksPerfect[4] = "rbxassetid://163619849"
sourceContext.blocksPerfect[5] = sourceContext.entries18
sourceContext.blocksPerfect[6] = sourceContext.entries19
sourceContext.lastbb2 = {}
sourceContext.entries20 = {}
sourceContext.settings14 = { def = 0.3 }
sourceContext.entries20[1] = "rbxassetid://6032836072"
sourceContext.entries20[2] = sourceContext.settings14
sourceContext.settings14 = {}
sourceContext.entries18 = "rbxassetid://10459370874"
sourceContext.entries19 = { def = 0.35, addw = -0.35, dist = 15 }
sourceContext.settings14[1] = "rbxassetid://10459370874"
sourceContext.settings14[2] = sourceContext.entries19
sourceContext.entries21 = {}
sourceContext.entries19 = "rbxassetid://12440326715"
sourceContext.settings15 = { addw = -0.1, dist = 15 }
sourceContext.entries21[1] = "rbxassetid://12440326715"
sourceContext.entries21[2] = sourceContext.settings15
sourceContext.entries22 = {}
sourceContext.settings15 = "rbxassetid://74034132845527"
sourceContext.def = { def = 0.4 }
sourceContext.entries22[1] = "rbxassetid://74034132845527"
sourceContext.entries22[2] = sourceContext.def
sourceContext.lastbb2[1] = sourceContext.entries20
sourceContext.lastbb2[2] = "rbxassetid://6034138660"
sourceContext.lastbb2[3] = sourceContext.settings14
sourceContext.lastbb2[4] = sourceContext.entries21
sourceContext.lastbb2[5] = sourceContext.entries22
blocks_base = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries20 = "rbxassetid://11876873350"
sourceContext.lastbb2[1] = "rbxassetid://11876873350"
blocks_UNBLOCK = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries23 = {}
sourceContext.settings14 = {}
sourceContext.entries21 = "def"
sourceContext.entries22 = 0
sourceContext.settings14.def = 0
function sourceContext.settings14.chckfunc(_, b)
  local standMorph = b.Parent:FindFirstChild("StandMorph")
  if standMorph then
    local standName = standMorph:FindFirstChild("Stand Name")
    return standName and standName.Value == "Star Platinum"
  end
  return false
end
sourceContext.entries23[1] = "rbxassetid://6048575522"
sourceContext.entries23[2] = sourceContext.settings14
sourceContext.entries24 = {}
sourceContext.settings14 = "rbxassetid://6048575522"
sourceContext.settings16 = {
  def = 0,
  chckfunc = function(_, b)
    local standMorph = b.Parent:FindFirstChild("StandMorph")
    if standMorph then
      local standName = standMorph:FindFirstChild("Stand Name")
      return standName and standName.Value ~= "Star Platinum"
    end
    return false
  end,
}
sourceContext.entries24[1] = "rbxassetid://6048575522"
sourceContext.entries24[2] = sourceContext.settings16
sourceContext.entries25 = {}
sourceContext.settings16 = "rbxassetid://4211804997"
sourceContext.entries26 = {}
sourceContext.def = 0.3
sourceContext.entries26.def = 0.3
function sourceContext.entries26.chckfunc(_, b)
  local standMorph = b.Parent:FindFirstChild("StandMorph")
  if standMorph then
    local standName = standMorph:FindFirstChild("Stand Name")
    return standName and standName.Value ~= "Tusk ACT 4"
  end
  return false
end
sourceContext.entries25[1] = "rbxassetid://4211804997"
sourceContext.entries25[2] = sourceContext.entries26
sourceContext.entries27 = {}
sourceContext.entries26 = "rbxassetid://13899360363"
sourceContext.settings17 = { def = 0.4 }
sourceContext.entries27[1] = "rbxassetid://13899360363"
sourceContext.entries27[2] = sourceContext.settings17
sourceContext.entries28 = {}
sourceContext.settings17 = "rbxassetid://7189005773"
sourceContext.settings18 = { def = 0.3 }
sourceContext.entries28[1] = "rbxassetid://7189005773"
sourceContext.entries28[2] = sourceContext.settings18
sourceContext.entries29 = {}
sourceContext.settings18 = "rbxassetid://6835249882"
sourceContext.settings19 = { def = 0.4 }
sourceContext.entries29[1] = "rbxassetid://6835249882"
sourceContext.entries29[2] = sourceContext.settings19
sourceContext.entries30 = {}
sourceContext.settings19 = "rbxassetid://11886825775"
sourceContext.settings20 = { def = 0.3 }
sourceContext.entries30[1] = "rbxassetid://11886825775"
sourceContext.entries30[2] = sourceContext.settings20
sourceContext.entries31 = {}
sourceContext.settings20 = "rbxassetid://4879759800"
sourceContext.settings21 = { def = 0.4 }
sourceContext.entries31[1] = "rbxassetid://4879759800"
sourceContext.entries31[2] = sourceContext.settings21
sourceContext.entries32 = {}
sourceContext.settings21 = "rbxassetid://4825999731"
sourceContext.settings22 = { def = 0.5, dist = 160, chckfunc = function() return coliseumenabled end }
sourceContext.entries32[1] = "rbxassetid://4825999731"
sourceContext.entries32[2] = sourceContext.settings22
sourceContext.settings22 = "rbxassetid://6049426097"
sourceContext.entries33 = {}
sourceContext.entries34 = {}
sourceContext.entries33[1] = "rbxassetid://6105486059"
sourceContext.entries33[2] = sourceContext.entries34
sourceContext.entries35 = {}
sourceContext.entries34 = "rbxassetid://5303743107"
sourceContext.entries36 = {}
sourceContext.entries35[1] = "rbxassetid://5303743107"
sourceContext.entries35[2] = sourceContext.entries36
sourceContext.entries37 = {}
sourceContext.entries36 = "rbxassetid://7250792726"
sourceContext.settings23 = { def = 0.4 }
sourceContext.entries37[1] = "rbxassetid://7250792726"
sourceContext.entries37[2] = sourceContext.settings23
sourceContext.settings23 = {}
sourceContext.settings24 = {
  def = 0.3,
  chckfunc = function(a)
    task.wait()
    return a.Speed > 1.39
  end,
}
sourceContext.settings23[1] = "rbxassetid://6216052429"
sourceContext.settings23[2] = sourceContext.settings24
sourceContext.entries38 = {}
sourceContext.settings24 = "rbxassetid://6216052429"
sourceContext.entries39 = {}
sourceContext.entries38[1] = "rbxassetid://6216052429"
sourceContext.entries38[2] = sourceContext.entries39
sourceContext.entries40 = {}
sourceContext.entries39 = "rbxassetid://4096014941"
sourceContext.settings25 = {
  def = 0.4,
  chckfunc = function(a)
    task.wait()
    return a.Speed > 1.049 and a.Speed < 1.051
  end,
}
sourceContext.entries40[1] = "rbxassetid://4096014941"
sourceContext.entries40[2] = sourceContext.settings25
sourceContext.entries41 = {}
sourceContext.settings25 = "rbxassetid://4096014941"
sourceContext.settings26 = { def = 0.4, chckfunc = function(a) return a.Speed > 1.074 and a.Speed < 1.076 end }
sourceContext.entries41[1] = "rbxassetid://4096014941"
sourceContext.entries41[2] = sourceContext.settings26
sourceContext.entries42 = {}
sourceContext.settings26 = "rbxassetid://4096014941"
sourceContext.settings27 = {
  def = 0.4,
  chckfunc = function(a, b)
    local standMorph = b.Parent:FindFirstChild("StandMorph")
    if standMorph then
      local standName = standMorph:FindFirstChild("Stand Name")
      if standName and standName.Value == "Magician's Red" then return a.Speed == 1 end
    end
    return false
  end,
}
sourceContext.entries42[1] = "rbxassetid://4096014941"
sourceContext.entries42[2] = sourceContext.settings27
sourceContext.entries43 = {}
sourceContext.settings27 = "rbxassetid://4096014941"
sourceContext.settings28 = {
  def = 0.4,
  chckfunc = function(_, b)
    local standMorph = b.Parent:FindFirstChild("StandMorph")
    if standMorph then
      local standName = standMorph:FindFirstChild("Stand Name")
      return standName and standName.Value == "Gold Experience"
    end
    return false
  end,
}
sourceContext.entries43[1] = "rbxassetid://4096014941"
sourceContext.entries43[2] = sourceContext.settings28
sourceContext.entries44 = {}
sourceContext.settings28 = "rbxassetid://4096014941"
sourceContext.settings29 = {
  def = 0.3, dist = 75,
  chckfunc = function(_, b)
    local standMorph = b.Parent:FindFirstChild("StandMorph")
    if standMorph then
      local standName = standMorph:FindFirstChild("Stand Name")
      if standName and standName.Value == "The Hand" then
        task.wait()
        for k, v in ipairs(standMorph:GetChildren()) do if v:IsA("Sound") and v.SoundId == "rbxassetid://7217913060" then return false end end
        return true
      end
      return false
    end
    return false
  end,
}
sourceContext.entries44[1] = "rbxassetid://4096014941"
sourceContext.entries44[2] = sourceContext.settings29
sourceContext.entries45 = {}
sourceContext.settings29 = "rbxassetid://4096014941"
sourceContext.settings30 = { def = 0.4, chckfunc = function(a) return a.Speed > 1.09 and a.Speed < 1.11 end }
sourceContext.entries45[1] = "rbxassetid://4096014941"
sourceContext.entries45[2] = sourceContext.settings30
sourceContext.def2 = {}
sourceContext.settings30 = "rbxassetid://4096014941"
sourceContext.settings31 = { def = 0.4, chckfunc = function(a) return a.Speed > 0.84 and a.Speed < 0.86 end }
sourceContext.def2[1] = "rbxassetid://4096014941"
sourceContext.def2[2] = sourceContext.settings31
sourceContext.lastbb2[1] = sourceContext.entries23
sourceContext.lastbb2[2] = sourceContext.entries24
sourceContext.lastbb2[3] = sourceContext.entries25
sourceContext.lastbb2[4] = sourceContext.entries27
sourceContext.lastbb2[5] = sourceContext.entries28
sourceContext.lastbb2[6] = sourceContext.entries29
sourceContext.lastbb2[7] = sourceContext.entries30
sourceContext.lastbb2[8] = sourceContext.entries31
sourceContext.lastbb2[9] = sourceContext.entries32
sourceContext.lastbb2[10] = "rbxassetid://6704817082"
sourceContext.lastbb2[11] = "rbxassetid://6049426097"
sourceContext.lastbb2[12] = sourceContext.entries33
sourceContext.lastbb2[13] = sourceContext.entries35
sourceContext.lastbb2[14] = sourceContext.entries37
sourceContext.lastbb2[15] = "rbxassetid://4812642386"
sourceContext.lastbb2[16] = sourceContext.settings23
sourceContext.lastbb2[17] = sourceContext.entries38
sourceContext.lastbb2[18] = sourceContext.entries40
sourceContext.lastbb2[19] = sourceContext.entries41
sourceContext.lastbb2[20] = sourceContext.entries42
sourceContext.lastbb2[21] = sourceContext.entries43
sourceContext.lastbb2[22] = sourceContext.entries44
sourceContext.lastbb2[23] = sourceContext.entries45
sourceContext.lastbb2[24] = sourceContext.def2
blocksanim_perfect = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries23 = {}
sourceContext.entries24 = "rbxassetid://12733018380"
sourceContext.entries25 = { def = 0.35, dist = 15, addw = 1.1 }
sourceContext.entries23[1] = "rbxassetid://12733018380"
sourceContext.entries23[2] = sourceContext.entries25
sourceContext.entries46 = {}
sourceContext.entries25 = "rbxassetid://12733022476"
sourceContext.entries27 = { coliseum = true, dist = 1000, addw = 0.3 }
sourceContext.entries46[1] = "rbxassetid://12733022476"
sourceContext.entries46[2] = sourceContext.entries27
sourceContext.entries47 = {}
sourceContext.entries27 = "rbxassetid://4608512208"
sourceContext.entries28 = { addw = 0.25 }
sourceContext.entries47[1] = "rbxassetid://4608512208"
sourceContext.entries47[2] = sourceContext.entries28
sourceContext.entries48 = {}
sourceContext.entries28 = "rbxassetid://5303988283"
sourceContext.entries29 = { def = 0.2 }
sourceContext.entries48[1] = "rbxassetid://5303988283"
sourceContext.entries48[2] = sourceContext.entries29
sourceContext.entries49 = {}
sourceContext.entries29 = "rbxassetid://6780938176"
sourceContext.entries30 = { def = 0.2, addw = 0.3 }
sourceContext.entries49[1] = "rbxassetid://6780938176"
sourceContext.entries49[2] = sourceContext.entries30
sourceContext.entries30 = {}
sourceContext.entries31 = "rbxassetid://6277192242"
sourceContext.entries32 = { def = 0.2, dist = 50, addw = 1 }
sourceContext.entries30[1] = "rbxassetid://6277192242"
sourceContext.entries30[2] = sourceContext.entries32
sourceContext.entries50 = {}
sourceContext.entries32 = "rbxassetid://6651725175"
sourceContext.settings32 = { addw = -0.1, dist = 40 }
sourceContext.entries50[1] = "rbxassetid://6651725175"
sourceContext.entries50[2] = sourceContext.settings32
sourceContext.entries51 = {}
sourceContext.settings32 = "rbxassetid://6216058630"
sourceContext.settings33 = { def = 0, coliseum = true, dist = 60, addw = -0.1 }
sourceContext.entries51[1] = "rbxassetid://6216058630"
sourceContext.entries51[2] = sourceContext.settings33
sourceContext.entries52 = {}
sourceContext.settings33 = "rbxassetid://10726619714"
sourceContext.entries33 = { def = 0.2, addw = 0.55 }
sourceContext.entries52[1] = "rbxassetid://10726619714"
sourceContext.entries52[2] = sourceContext.entries33
sourceContext.entries53 = {}
sourceContext.entries33 = "rbxassetid://12293320463"
sourceContext.entries35 = { def = 0.3 }
sourceContext.entries53[1] = "rbxassetid://12293320463"
sourceContext.entries53[2] = sourceContext.entries35
sourceContext.entries54 = {}
sourceContext.entries35 = "rbxassetid://6869896659"
sourceContext.entries37 = { def = 0.2, addw = 0.75 }
sourceContext.entries54[1] = "rbxassetid://6869896659"
sourceContext.entries54[2] = sourceContext.entries37
sourceContext.entries55 = {}
sourceContext.entries37 = "rbxassetid://14174878575"
sourceContext.settings34 = { def = 0.3, addw = -0.1, dist = 70, coliseum = true }
sourceContext.entries55[1] = "rbxassetid://14174878575"
sourceContext.entries55[2] = sourceContext.settings34
sourceContext.entries56 = {}
sourceContext.settings34 = "rbxassetid://7189003645"
sourceContext.settings23 = { def = 0.3, addw = 0.2 }
sourceContext.entries56[1] = "rbxassetid://7189003645"
sourceContext.entries56[2] = sourceContext.settings23
sourceContext.settings23 = {}
sourceContext.entries38 = "rbxassetid://4595562165"
sourceContext.entries40 = { def = 0, addw = 0.3 }
sourceContext.settings23[1] = "rbxassetid://4595562165"
sourceContext.settings23[2] = sourceContext.entries40
sourceContext.entries40 = {}
sourceContext.entries41 = "rbxassetid://4133363765"
sourceContext.entries42 = { def = 0.6 }
sourceContext.entries40[1] = "rbxassetid://4133363765"
sourceContext.entries40[2] = sourceContext.entries42
sourceContext.entries57 = {}
sourceContext.entries42 = "rbxassetid://4691787301"
sourceContext.entries43 = {}
sourceContext.entries44 = "def"
sourceContext.entries45 = 0.25
sourceContext.entries43.def = 0.25
sourceContext.entries43.addw = 0.75
sourceContext.entries43.dist = 100
function sourceContext.entries43.chckfunc(_, b)
  task.wait()
  local RightHand = b.Parent.RightHand
  RightHand = RightHand:FindFirstChild("Grapple")
  if RightHand then return RightHand.Attachment1 == game.Players.LocalPlayer.Character.HumanoidRootPart.RootRigAttachment end
  return false
end
sourceContext.entries57[1] = "rbxassetid://4691787301"
sourceContext.entries57[2] = sourceContext.entries43
sourceContext.entries58 = {}
sourceContext.entries43 = "rbxassetid://12733016318"
sourceContext.entries59 = {}
sourceContext.def2 = 0.325
sourceContext.entries59.def = 0.325
sourceContext.entries59.addw = -0.1
sourceContext.entries59.dist = 15
function sourceContext.entries59.chckfunc(a) return a.Speed < 0.75 end
sourceContext.entries58[1] = "rbxassetid://12733016318"
sourceContext.entries58[2] = sourceContext.entries59
sourceContext.lastbb2[1] = sourceContext.entries23
sourceContext.lastbb2[2] = sourceContext.entries46
sourceContext.lastbb2[3] = sourceContext.entries47
sourceContext.lastbb2[4] = sourceContext.entries48
sourceContext.lastbb2[5] = sourceContext.entries49
sourceContext.lastbb2[6] = "rbxassetid://12292886724"
sourceContext.lastbb2[7] = sourceContext.entries30
sourceContext.lastbb2[8] = sourceContext.entries50
sourceContext.lastbb2[9] = sourceContext.entries51
sourceContext.lastbb2[10] = sourceContext.entries52
sourceContext.lastbb2[11] = sourceContext.entries53
sourceContext.lastbb2[12] = sourceContext.entries54
sourceContext.lastbb2[13] = sourceContext.entries55
sourceContext.lastbb2[14] = sourceContext.entries56
sourceContext.lastbb2[15] = "rbxassetid://5793968491"
sourceContext.lastbb2[16] = sourceContext.settings23
sourceContext.lastbb2[17] = "rbxassetid://5227558947"
sourceContext.lastbb2[18] = sourceContext.entries40
sourceContext.lastbb2[19] = sourceContext.entries57
sourceContext.lastbb2[20] = sourceContext.entries58
blocksanim_base = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries23 = "rbxassetid://12293318922"
sourceContext.entries46 = "rbxassetid://13819646949"
sourceContext.entries47 = "rbxassetid://6780937804"
sourceContext.entries48 = "rbxassetid://6780982308"
sourceContext.entries49 = {}
sourceContext.entries30 = { dist = 10 }
sourceContext.entries49[1] = "rbxassetid://10443019808"
sourceContext.entries49[2] = sourceContext.entries30
sourceContext.lastbb2[1] = "rbxassetid://12293318922"
sourceContext.lastbb2[2] = "rbxassetid://13819646949"
sourceContext.lastbb2[3] = "rbxassetid://6780937804"
sourceContext.lastbb2[4] = "rbxassetid://6780982308"
sourceContext.lastbb2[5] = sourceContext.entries49
blocksanim_UNBLOCK = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries60 = {}
sourceContext.entries49 = nil
sourceContext.entries60[1] = "VisionPlunderBubble"
sourceContext.entries60[2] = "Core"
sourceContext.entries60[3] = 15
sourceContext.entries60[4] = nil
sourceContext.entries61 = {}
function sourceContext.callFindFirstChild(a) return a:FindFirstChild("Victim") end
sourceContext.entries30 = false
sourceContext.entries50 = true
sourceContext.entries61[1] = " SP Bullet"
sourceContext.entries61[2] = nil
sourceContext.entries61[3] = 20
sourceContext.entries61[4] = sourceContext.callFindFirstChild
sourceContext.entries61[5] = false
sourceContext.entries61[6] = true
sourceContext.workspace2 = {}
sourceContext.entries30 = nil
sourceContext.entries51 = true
sourceContext.workspace2[1] = "Last Shot"
sourceContext.workspace2[2] = nil
sourceContext.workspace2[3] = 20
sourceContext.workspace2[4] = nil
sourceContext.workspace2[5] = false
sourceContext.workspace2[6] = true
sourceContext.entries62 = {}
function sourceContext.callFindFirstChild2(a) return a:FindFirstChild("BloodTrail") end
sourceContext.entries62[1] = "Main"
sourceContext.entries62[2] = nil
sourceContext.entries62[3] = 25
sourceContext.entries62[4] = sourceContext.callFindFirstChild2
sourceContext.entries62[5] = true
sourceContext.settings35 = { [1] = "HomingShard", [2] = nil, [3] = 20 }
sourceContext.entries63 = {}
function sourceContext.entries52(a)
  local name2 = a.Name
  local entry18 = name2
  name2 = name2.find
  if not name2(entry18, "SP Bullet") and not a.Name:find("SPBullet") then return not a:FindFirstChild("Victim") end
  return false
end
sourceContext.entries63[1] = "Bullet"
sourceContext.entries63[2] = nil
sourceContext.entries63[3] = 20
sourceContext.entries63[4] = sourceContext.entries52
sourceContext.entries64 = {}
sourceContext.entries52 = 40
function sourceContext.entries53(a)
  local onFireSparks = a:FindFirstChild("OnFireSparks")
  return onFireSparks and onFireSparks.Enabled
end
sourceContext.entries54 = true
sourceContext.entries55 = true
sourceContext.entries64[1] = "CrossFirePiece"
sourceContext.entries64[2] = nil
sourceContext.entries64[3] = 40
sourceContext.entries64[4] = sourceContext.entries53
sourceContext.entries64[5] = true
sourceContext.entries64[6] = true
sourceContext.entries65 = {}
sourceContext.entries52 = nil
sourceContext.entries53 = 20
sourceContext.entries65[1] = "Baseball3"
sourceContext.entries65[2] = nil
sourceContext.entries65[3] = 20
sourceContext.lastbb2[1] = sourceContext.entries60
sourceContext.lastbb2[2] = sourceContext.entries61
sourceContext.lastbb2[3] = sourceContext.workspace2
sourceContext.lastbb2[4] = sourceContext.entries62
sourceContext.lastbb2[5] = sourceContext.settings35
sourceContext.lastbb2[6] = sourceContext.entries63
sourceContext.lastbb2[7] = sourceContext.entries64
sourceContext.lastbb2[8] = sourceContext.entries65
block_projectiles = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries60 = {}
sourceContext.entries61 = "Wormhole"
sourceContext.workspace2 = workspace
sourceContext.entries62 = 7
function sourceContext.settings35() return 0, 0, -(game.Players.LocalPlayer:GetNetworkPing() / 2), false end
sourceContext.entries60[1] = "Wormhole"
sourceContext.entries60[2] = sourceContext.workspace2
sourceContext.entries60[3] = 7
sourceContext.entries60[4] = sourceContext.settings35
sourceContext.lastbb2[1] = sourceContext.entries60
block_objects = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries60 = {}
function sourceContext.workspace2(a)
  local settings7 = { def = 0, wt = 0, addw = -0.1 }
  local rootPart10 = a:Clone()
  rootPart10.Size = Vector3.new(15 + 10, 5, 40 + 10)
  rootPart10.CFrame = rootPart10.CFrame * CFrame.new(0, 0, -12.5)
  task.wait(0.15)
  local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if humanoidRootPart then
    local Position = humanoidRootPart.Position
    local Position2 = rootPart10.Position
    Position2 = Position2 - rootPart10.Size / 2
    local Position3 = rootPart10.Position
    Position3 = Position3 + rootPart10.Size / 2
    local X = Position.X
    if Position2.X <= X and Position.X <= Position3.X then
      local Y = Position.Y
      if Position2.Y <= Y and Position.Y <= Position3.Y then
        local Z = Position.Z
        if Position2.Z <= Z and Position.Z <= Position3.Z then reqblock(settings7.def, settings7.wt, settings7.addw, false) end
      end
    end
  end
  rootPart10:Destroy()
  return true
end
sourceContext.entries60[1] = "GroundIndicator"
sourceContext.entries60[2] = sourceContext.workspace2
sourceContext.entries66 = {}
sourceContext.workspace2 = "FloorDash"
function sourceContext.callback155(a)
  local Character = game.Players.LocalPlayer.Character
  Character = Character:FindFirstChild("HumanoidRootPart")
  if Character then
    if (Character.Position - a.Position).Magnitude > 40 then return false end
    local settings7 = { def = 0, wt = 0, addw = 0.25 }
    task.wait(0.2)
    reqblock(settings7.def, settings7.wt, settings7.addw, false)
    return true
  end
  return false
end
sourceContext.entries66[1] = "FloorDash"
sourceContext.entries66[2] = sourceContext.callback155
sourceContext.lastbb2[1] = sourceContext.entries60
sourceContext.lastbb2[2] = sourceContext.entries66
block_SPECIAL = sourceContext.lastbb2
sourceContext.lastbb2 = {}
sourceContext.entries60 = "rbxassetid://7217913060"
sourceContext.lastbb2["rbxassetid://7217913060"] = { [1] = "rbxassetid://4096014941" }
overriders = sourceContext.lastbb2
sourceContext.lastbb2 = "blocks_perfect"
sourceContext.entries17.blocks_perfect = sourceContext.blocksPerfect
sourceContext.entries17.blocks_base = blocks_base
sourceContext.entries17.blocks_UNBLOCK = blocks_UNBLOCK
sourceContext.entries17.blocksanim_perfect = blocksanim_perfect
sourceContext.entries17.blocksanim_base = blocksanim_base
sourceContext.entries17.blocksanim_UNBLOCK = blocksanim_UNBLOCK
sourceContext.entries17.block_objects = block_objects
sourceContext.entries17.block_SPECIAL = block_SPECIAL
sourceContext.entries17.overriders = overriders
do
  local blockbot = sourceContext.entries17.blockbot
  local reblocking = sourceContext.entries17.reblocking
  local keepblock = sourceContext.entries17.keepblock
  local unblocking = sourceContext.entries17.unblocking
  local coliseumenabled2 = sourceContext.entries17.coliseumenabled
  local lboverriding = sourceContext.entries17.lboverriding
  local blockprocsuntil = sourceContext.entries17.blockprocsuntil
  local lastblock = sourceContext.entries17.lastblock
  local blockactions = sourceContext.entries17.blockactions
  local blocked = sourceContext.entries17.blocked
  local lastboi = sourceContext.entries17.lastboi
  local lastbad = sourceContext.entries17.lastbad
  local lastbb = sourceContext.entries17.lastbb
  local blocks_perfect = sourceContext.entries17.blocks_perfect
  local blocks_base2 = sourceContext.entries17.blocks_base
  local blocks_UNBLOCK2 = sourceContext.entries17.blocks_UNBLOCK
  local blocksanim_perfect2 = sourceContext.entries17.blocksanim_perfect
  local blocksanim_base2 = sourceContext.entries17.blocksanim_base
  local blocksanim_UNBLOCK2 = sourceContext.entries17.blocksanim_UNBLOCK
  local block_objects2 = sourceContext.entries17.block_objects
  local block_SPECIAL2 = sourceContext.entries17.block_SPECIAL
  local overriders2 = sourceContext.entries17.overriders
  local function callback156(a) return a and a:FindFirstChild("StandMorph") end
  local function callback157(a) return a and a:FindFirstChild("StandMorph") end
  local function callback158()
    local lighting = game.Lighting
    return lighting.FindFirstChild(lighting, "TimeStop") and true or false
  end
  local function callback159(a)
    if a then return a:FindFirstChild("RagdollParts") and true or false end
    return false
  end
  local function callGetNetworkPing() return game.Players.LocalPlayer:GetNetworkPing() end
  local function callback160()
    local Character = game.Players.LocalPlayer.Character
    if not Character then return end
    if blocked then return end
    local blockingCapacity = Character:FindFirstChild("Blocking_Capacity")
    if blockingCapacity and blockingCapacity.Value > 0 then
      blocked = true
      return
    end
    blocked = true
    local remoteEvent6 = Character:FindFirstChild("RemoteEvent")
    if remoteEvent6 then
      remoteEvent6:FireServer("StartBlocking", "pass")
      task.wait()
      remoteEvent6:FireServer("StartBlocking", "pass")
    end
  end
  local function callback161(a)
    local Character = game.Players.LocalPlayer.Character
    if not Character then return end
    if not a and keepblock and not callback159(Character) then return end
    if blocked then
      local remoteEvent6 = Character:FindFirstChild("RemoteEvent")
      if remoteEvent6 then
        remoteEvent6:FireServer("StopBlocking", "pass")
        task.wait()
        remoteEvent6:FireServer("StopBlocking", "pass")
      end
      blocked = false
      blockactions = false
      return
    end
    blockactions = false
  end
  function reqblock(a, b, c, d, e)
    if not blockbot then return end
    local count19 = e or 0
    if blockactions then
      local number = tonumber(blockactions)
      if number then
        if count19 <= number then return end
      elseif count19 == 0 then return end
    end
    blockactions = count19
    local Character = game.Players.LocalPlayer.Character
    local remoteEvent6 = Character and Character:FindFirstChild("RemoteEvent")
    if remoteEvent6 then
      remoteEvent6:FireServer("HoldAttack", { Bool = false, Type = "m1" })
      lastbb = tick()
      local living = sourceContext.parent:FindFirstChild("Living")
      living = living and sourceContext.parent.Living:FindFirstChild(game.Players.LocalPlayer.Name)
      local blockingCapacity = living and living:FindFirstChild("Blocking_Capacity")
      if blockingCapacity and blockingCapacity.Value > 0 and d then
        if a < 0.2 or not reblocking then
          blockactions = false
          return
        end
        callback161(true)
      end
      lastblock = lastblock + 1
      local lastblock2 = lastblock
      if b > 0 then task.wait(b) end
      if not (lboverriding and lastblock ~= lastblock2 or callback158()) then
        callback160()
        task.wait(0.4 + math.max(0.05, callGetNetworkPing()) + (c or 0))
        if not lboverriding or lastblock == lastblock2 then
          blockactions = false
          callback161(false)
        end
        return
      end
      blockactions = false
      return
    end
    blockactions = false
  end
  function frek()
    if blockbot and unblocking then
      blockprocsuntil = tick() + 0.75
      lastblock = lastblock + 1
      local lastblock2 = lastblock
      blockactions = true
      callback161(false, true)
      task.wait(0.05)
      callback161(false, true)
      task.wait(0.7)
      if not (lboverriding and lastblock ~= lastblock2) then blockactions = false end
    end
  end
  local function callback162(a, b, c)
    local Character = game.Players.LocalPlayer.Character
    Character = Character:FindFirstChild("HumanoidRootPart")
    if Character then
      if a < (Character.Position - b.Position).Magnitude then
        if not c then return 0 end
        if a < (Character.Position - c.Position).Magnitude then return 0 end
      end
      return 1
    end
    return 0
  end
  local function callback163(a)
    if blockactions and overriders2 and overriders2[lastbad] then for k, v in ipairs(overriders2[lastbad]) do if v == a then return false end end end
    return true
  end
  local count19, count20 = 12, 7
  local function callback164(a, b, c, d)
    local enabled36 = false
    for i = 1, #d do
      local entry18 = d[i]
      if entry18 and type(entry18) == "table" then
        for k2, v2 in ipairs(entry18) do
          if type(v2) ~= "table" or not v2[2].coliseum or coliseumenabled2 then
            local typeResult2 = type(v2)
            typeResult2 = if typeResult2 == "table" then v2[1] else v2 or v2[1]
            if callback163(typeResult2) then
              local count19 = i == 1 and 12 or 7
              local entry19 = count19
              local enabled37 = false
              if type(v2) == "table" then
                enabled36 = i == 1 or i ~= 2 and enabled36
                entry19 = v2[2] and v2[2].dist or count19
                if v2[2].chckfunc and not v2[2].chckfunc(b) then enabled37 = true end
              end
              if not enabled37 and a.SoundId == typeResult2 and callback162(entry19, b, c) == 1 then
                if i == 3 then return frek(), nil, nil end
                local enabled38 = false
                for k, v in ipairs(a.Parent:GetChildren()) do
                  if string.find(string.lower(v.Name), "barrage") then
                    enabled38 = true
                    break
                  end
                end
                if not enabled38 then
                  _G._blockEntry = v2
                  return true, enabled36, v2
                end
              end
            end
          end
        end
      end
    end
    return false, enabled36, nil
  end
  local function callback165(a, b, c, d)
    local enabled36 = false
    local AnimationId = a.Animation.AnimationId
    for i = 1, #d do
      local entry18 = d[i]
      if entry18 and type(entry18) == "table" then
        for k, v in ipairs(entry18) do
          if type(v) ~= "table" or not v[2].coliseum or coliseumenabled2 then
            local typeResult2 = type(v)
            typeResult2 = if typeResult2 == "table" then v[1] else v or v[1]
            if callback163(typeResult2) then
              local count19 = i == 1 and 12 or 7
              local entry19 = count19
              local enabled37 = false
              if type(v) == "table" then
                enabled36 = i == 1 or i ~= 2 and enabled36
                entry19 = v[2].dist or count19
                if v[2].chckfunc and not v[2].chckfunc(a, b) then enabled37 = true end
              end
              if not enabled37 and typeResult2 == AnimationId and callback162(entry19, b, c) == 1 then
                if i == 3 then return frek(), nil, nil end
                _G._blockEntry = v
                return true, enabled36, v
              end
            end
          end
        end
      end
    end
    return false, enabled36, nil
  end
  function proroc(a, b, c)
    if callback158() then return end
    if callback159(game.Players.LocalPlayer.Character) then return end
    if not blockbot then return end
    if tick() < blockprocsuntil then return end
    local Parent = b.Parent
    local enabled36, enabled37, entry18, a5 = false, false, nil, a
    if a:IsA("Sound") then
      local entry19, entry20, entry23 = callback164(a, b, c, { [1] = blocks_perfect, [2] = blocks_base2, [3] = blocks_UNBLOCK2 })
      enabled36, enabled37, entry18 = entry20, entry19, entry23
    else
      if a:IsA("AnimationTrack") then
        local entry24, entry26, entry27 = callback165(a, b, c, { [1] = blocksanim_perfect2, [2] = blocksanim_base2, [3] = blocksanim_UNBLOCK2 })
        enabled36, enabled37, entry18 = entry26, entry24, entry27
      end
    end
    if enabled37 then
      lastboi = Parent
      local count19 = 0
      local count20, count21 = nil, nil
      if type(entry18) == "table" then
        local entry28 = entry18[2]
        count20 = entry28.def or 0.4
        count19 = 0 + (entry28.addw or 0)
        count21 = entry28.prio or 0
      else
        count20, count21 = 0.4, 0
      end
      lastbad = entry18
      local max = math.max
      max = max(0, count20 - callGetNetworkPing())
      reqblock(count20, max, count19, enabled36, count21)
    end
  end
  function handleproj(a)
    if blockbot and typeof(a) == "Instance" and a.Parent and block_projectiles and type(block_projectiles) == "table" then
      for k, v in ipairs(block_projectiles) do
        if a.Name and a.Name:find(v[1]) then
          local rootPart10 = v[2] == nil and a or a[v[2]]
          local callback58 = v[4] or function() return true end
          if not rootPart10 or not rootPart10.Parent or not rootPart10:IsA("BasePart") then return end
          local humanoidRootPart = sourceContext.player.Character and sourceContext.player.Character:FindFirstChild("HumanoidRootPart")
          if not humanoidRootPart then return end
          while a.Parent do
            if not a:IsDescendantOf(workspace) then break end
            if not rootPart10.Parent then break end
            if not callback58(a) then break end
            local AssemblyLinearVelocity = rootPart10.AssemblyLinearVelocity
            local Position = rootPart10.Position
            local magnitude = AssemblyLinearVelocity.Magnitude > 0.01 and ((humanoidRootPart.Position - Position).Magnitude < v[3] or (humanoidRootPart.Position - (Position + AssemblyLinearVelocity.Unit * 10)).Magnitude < v[3]) or (humanoidRootPart.Position - Position).Magnitude < v[3]
            if magnitude and (not blockactions or projectiles_priority) then
              if blockactions then return end
              lastblock = lastblock + 1
              local lastblock2 = lastblock
              blockactions = not projectiles_priority or 42000
              callback160()
              local timestamp3 = tick()
              while a.Parent and a:IsDescendantOf(workspace) and rootPart10.Parent and tick() - timestamp3 < 0.75 and callback58(a) do
                local Position2 = rootPart10.Position
                local AssemblyLinearVelocity2 = rootPart10.AssemblyLinearVelocity
                local magnitude2 = AssemblyLinearVelocity2.Magnitude > 0.01 and ((humanoidRootPart.Position - Position2).Magnitude < v[3] or (humanoidRootPart.Position - (Position2 + AssemblyLinearVelocity2.Unit * 10)).Magnitude < v[3]) or (humanoidRootPart.Position - Position2).Magnitude < v[3]
                if not magnitude2 then break end
                task.wait()
              end
              local entry18 = tick() - timestamp3
              if entry18 < 0.4321 then task.wait(0.4321 - entry18) end
              if not callback158() and (not lboverriding or lastblock == lastblock2) then
                callback161(false)
                blockactions = false
              end
            end
            task.wait()
          end
        end
      end
    end
  end
  function checkSpecial(a)
    if blockbot and typeof(a) == "Instance" and a.Parent and block_SPECIAL2 and type(block_SPECIAL2) == "table" then
      for k, v in ipairs(block_SPECIAL2) do if a.Name and a.Name:find(v[1]) and v[2](a) then return end end
    end
  end
  function handleChildAdded(a)
    if not (blockbot and typeof(a) == "Instance" and a.Parent) then return end
    if tick() < blockprocsuntil then return end
    if block_projectiles and type(block_projectiles) == "table" then
      for k, v in ipairs(block_projectiles) do if a.Parent and a.Name and a.Name:find(v[1]) then return handleproj(a) end end
    end
    if block_SPECIAL2 and type(block_SPECIAL2) == "table" then
      for k2, v2 in ipairs(block_SPECIAL2) do if a.Parent and a.Name and a.Name:find(v2[1]) then return checkSpecial(a) end end
    end
  end
  local descendantAdded = workspace.DescendantAdded
  descendantAdded.Connect(descendantAdded, function(a)
    if not (typeof(a) == "Instance" and a.Parent) then return end
    if block_objects2 and type(block_objects2) == "table" then
      for k, v in ipairs(block_objects2) do
        local Character = game.Players.LocalPlayer.Character
        local humanoidRootPart = Character and (Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart"))
        if humanoidRootPart and a:IsA("BasePart") and v[1] == a.Name and (v[2] == "any" or v[2] == a.Parent) and (humanoidRootPart.Position - a.Position).Magnitude < v[3] then
          reqblock(v[4]())
        end
      end
    end
  end)
  local childAdded, connectText2 = workspace.ChildAdded, "Connect"
  childAdded.Connect(childAdded, handleChildAdded)
  pcall(function() workspace.IgnoreInstances.ChildAdded:Connect(handleChildAdded) end)
  local Character = game.Players.LocalPlayer.Character
  if Character then
    local ChildAdded = Character.ChildAdded
    ChildAdded.Connect(ChildAdded, function(a)
      if a.Name == "RagdollParts" then
        lastblock = lastblock + 1
        blockprocsuntil = tick() + 0.2
        blockactions = false
        blocked = false
        callback161(false)
      end
    end)
  end
  local CharacterAdded = game.Players.LocalPlayer.CharacterAdded
  CharacterAdded.Connect(CharacterAdded, function(a)
    a.ChildAdded:Connect(function(b)
      if b.Name == "RagdollParts" then
        lastblock = lastblock + 1
        blockprocsuntil = tick() + 0.2
        blockactions = false
        blocked = false
        callback161(false)
      end
    end)
  end)
  CharacterAdded = "proroc"
  sourceContext.entries17.proroc = proroc
  function sourceContext.entries17.setBlockbot(a) blockbot = a end
  function sourceContext.entries17.setReblocking(a) reblocking = a end
  function sourceContext.entries17.setKeepblock(a) keepblock = a end
  function sourceContext.entries17.setUnblocking(a) unblocking = a end
  function sourceContext.entries17.setProjectiles(a) projectiles_priority = a end
  function sourceContext.entries17.setColiseum(a) coliseumenabled2 = a end
end
do
  local function callback166(...) return sourceContext.entries17.proroc and sourceContext.entries17.proroc(...) end
  local function callback167(a, b)
    local torso = a.PrimaryPart or a:FindFirstChild("HumanoidRootPart") or a:FindFirstChild("UpperTorso") or a:FindFirstChild("Torso")
    if torso and callback166 then callback166(b, torso, nil) end
  end
  local function callback168(a, b)
    task.wait(0.1)
    b.AnimationPlayed:Connect(function(c)
      local torso = a.PrimaryPart or a:FindFirstChild("HumanoidRootPart") or a:FindFirstChild("UpperTorso") or a:FindFirstChild("Torso")
      if torso and callback166 then callback166(c, torso, nil) end
    end)
  end
  local function callback169(a)
    if not a then return end
    a.DescendantAdded:Connect(function(b)
      if b:IsA("Sound") then
        callback167(a, b)
      elseif b:IsA("Model") and b.Name == "StandMorph" then
        task.wait(0.15)
        b.DescendantAdded:Connect(function(c)
          if c:IsA("Sound") then
            callback167(a, c)
          elseif c:IsA("Animator") then callback168(a, c) end
        end)
      elseif b:IsA("Animator") then callback168(a, b) end
    end)
    local humanoid8 = a:FindFirstChildOfClass("Humanoid")
    if humanoid8 then
      local animator = humanoid8:FindFirstChild("Animator")
      if animator then
        animator.AnimationPlayed:Connect(function(b)
          local torso = a.PrimaryPart or a:FindFirstChild("HumanoidRootPart") or a:FindFirstChild("UpperTorso") or a:FindFirstChild("Torso")
          if torso and callback166 then callback166(b, torso, nil) end
        end)
      end
    end
    local standMorph = a:FindFirstChild("StandMorph")
    if standMorph then
      task.wait(0.15)
      standMorph.DescendantAdded:Connect(function(b)
        if b:IsA("Sound") then
          callback167(a, b)
        elseif b:IsA("Animator") then callback168(a, b) end
      end)
    end
  end
  local entries67 = {}
  local function callback170(a)
    if a == game.Players.LocalPlayer then return end
    if entries67[a] then return end
    entries67[a] = true
    if a.Character then callback169(a.Character) end
    a.CharacterAdded:Connect(callback169)
    a.AncestryChanged:Connect(function() if not a:IsDescendantOf(game) then entries67[a] = nil end end)
  end
  local entry35 = ipairs
  local Players = game.Players
  for k9, v9 in entry35(Players.GetPlayers(Players)) do callback170(v9) end
  local playerAdded = game.Players.PlayerAdded
  Players = playerAdded
  playerAdded.Connect(playerAdded, callback170)
  playerAdded = blockBotSec
  Players = playerAdded
  local toggle4 = playerAdded.Toggle
  local enableBlockBotOptions = { Name = "Enable BlockBot" }
  local callback171 = sourceContext.callback35
  callback171 = sourceContext.callback35("BB", false)
  enableBlockBotOptions.Default = callback171
  function callback171(a)
    sourceContext.callback34("BB", a)
    if sourceContext.entries17.setBlockbot then sourceContext.entries17.setBlockbot(a) end
    sourceContext.notify("BlockBot", a and "Enabled!" or "Disabled!")
  end
  enableBlockBotOptions.Callback = callback171
  toggle4(playerAdded, enableBlockBotOptions)
  toggle4 = blockBotSec
  enableBlockBotOptions = "Toggle"
  Players = toggle4
  local toggle5 = toggle4.Toggle
  local allowReBlockingOptions = { Name = "Allow re-blocking" }
  callback171 = sourceContext.callback35
  callback171 = sourceContext.callback35("BB_RB", true)
  allowReBlockingOptions.Default = callback171
  function callback171(a)
    sourceContext.callback34("BB_RB", a)
    if sourceContext.entries17.setReblocking then sourceContext.entries17.setReblocking(a) end
  end
  allowReBlockingOptions.Callback = callback171
  toggle5(toggle4, allowReBlockingOptions)
  toggle5 = blockBotSec
  allowReBlockingOptions = "Toggle"
  Players = toggle5
  local toggle6 = toggle5.Toggle
  local keepBlockWhileHoldingFOptions = { Name = "Keep block while holding F" }
  callback171 = sourceContext.callback35
  callback171 = sourceContext.callback35("BB_KB", true)
  keepBlockWhileHoldingFOptions.Default = callback171
  function callback171(a)
    sourceContext.callback34("BB_KB", a)
    if sourceContext.entries17.setKeepblock then sourceContext.entries17.setKeepblock(a) end
  end
  keepBlockWhileHoldingFOptions.Callback = callback171
  toggle6(toggle5, keepBlockWhileHoldingFOptions)
  toggle6 = blockBotSec
  keepBlockWhileHoldingFOptions = "Toggle"
  Players = toggle6
  local toggle7 = toggle6.Toggle
  local unblockingOptions = { Name = "Unblocking" }
  callback171 = sourceContext.callback35
  callback171 = sourceContext.callback35("BB_UB", true)
  unblockingOptions.Default = callback171
  function callback171(a)
    sourceContext.callback34("BB_UB", a)
    if sourceContext.entries17.setUnblocking then sourceContext.entries17.setUnblocking(a) end
  end
  unblockingOptions.Callback = callback171
  toggle7(toggle6, unblockingOptions)
  toggle7 = blockBotSec
  unblockingOptions = "Toggle"
  Players = toggle7
  local toggle8 = toggle7.Toggle
  local projectilesPriorityOptions = { Name = "Projectiles priority" }
  callback171 = sourceContext.callback35
  callback171 = sourceContext.callback35("BB_PP", false)
  projectilesPriorityOptions.Default = callback171
  function callback171(a)
    sourceContext.callback34("BB_PP", a)
    if sourceContext.entries17.setProjectiles then sourceContext.entries17.setProjectiles(a) end
  end
  projectilesPriorityOptions.Callback = callback171
  toggle8(toggle7, projectilesPriorityOptions)
  toggle8 = blockBotSec
  projectilesPriorityOptions = "Toggle"
  Players = toggle8
  local toggle9 = toggle8.Toggle
  local coliseumV1V2ModeOptions = { Name = "Coliseum (1v1/2v2) mode" }
  callback171 = sourceContext.callback35
  callback171 = sourceContext.callback35("BB_COL", false)
  coliseumV1V2ModeOptions.Default = callback171
  function callback171(a)
    sourceContext.callback34("BB_COL", a)
    if sourceContext.entries17.setColiseum then sourceContext.entries17.setColiseum(a) end
  end
  coliseumV1V2ModeOptions.Callback = callback171
  toggle9(toggle8, coliseumV1V2ModeOptions)
  toggle9 = blockBotSec
  coliseumV1V2ModeOptions = "Toggle"
  Players = toggle9
  local toggle10 = toggle9.Toggle
  local blockBeachBoyEAndOptions = { Name = "Block Beach Boy E and Y" }
  callback171 = sourceContext.callback35
  callback171 = sourceContext.callback35("BB_ROD", false)
  blockBeachBoyEAndOptions.Default = callback171
  function callback171(rodblocking)
    sourceContext.callback34("BB_ROD", rodblocking)
    _G.rodblocking = rodblocking
  end
  blockBeachBoyEAndOptions.Callback = callback171
  toggle10(toggle9, blockBeachBoyEAndOptions)
  toggle10 = blockBotSec
  blockBeachBoyEAndOptions = "Button"
  Players = toggle10
  local button3 = toggle10.Button
  local reHookPlayersOptions = { Name = "Re-hook Players" }
  function callback171()
    entries67 = {}
    for k, v in pairs(workspace.Living:GetChildren()) do
      local findFirstChildResult2 = game.Players:FindFirstChild(v.Name)
      if findFirstChildResult2 then
        task.spawn(function()
          if findFirstChildResult2 ~= game.Players.LocalPlayer then callback170(findFirstChildResult2) end
        end)
      end
    end
    sourceContext.notify("BlockBot", "Re-hooked all players!")
  end
  reHookPlayersOptions.Callback = callback171
  button3(toggle10, reHookPlayersOptions)
end
do
  local enabled36, count21 = false, 0
  local settings36 = { enabled = false, startTime = nil, startLevel = nil, startPrestige = nil, startDate = nil }
  local function callFormat(a, b) return string.format("%0" .. b .. "i", a) end
  local function callback172()
    local date = os.date("!*t")
    local year = date.year
    local month = date.month
    local day = date.day
    local hour = date.hour
    local min = date.min
    local sec = date.sec
    return year .. "-" .. callFormat(month, 2) .. "-" .. callFormat(day, 2) .. "T" .. callFormat(hour, 2) .. ":" .. callFormat(min, 2) .. ":" .. callFormat(sec, 2) .. "Z"
  end
  local function callFormat2(a)
    return string.format("%02d:%02d:%02d", math.floor(a / 3600), math.floor(a % 3600 / 60), math.floor(a % 60))
  end
  local function callback173(a)
    local webhook = getgenv()
    webhook = webhook.webhook
    if not (webhook and webhook ~= "") then return end
    local requestBody2 = sourceContext.httpServiceService2:JSONEncode(a)
    pcall(function()
      local request3 = syn and syn.request or http_request or request or http.request
      if request3 then request3({ Url = webhook, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = requestBody2 }) end
    end)
  end
  local function callback174(a, _)
    local Value = sourceContext.player.PlayerStats.Level.Value
    local Value2 = sourceContext.player.PlayerStats.Prestige.Value
    local timestamp = callback172()
    local enabled37 = sourceContext.callback37 and sourceContext.callback37() or false
    local settings7 = {
      title = "[RAIL Hub] Auto Prestige",
      color = a == "started" and 3447003 or a == "completed" and 15844367 or a == "stopped" and 15158332 or 7506394,
      timestamp = timestamp, footer = { text = "RAIL Hub | Your Bizarre Adventure" },
    }
    if a == "started" then
      local fields3 = {}
      local settings11 = {
        name = enabled37 and "Игрок" or "Player",
        value = sourceContext.callback41 and sourceContext.callback41() or sourceContext.player.Name, inline = true,
      }
      local settings12 = { name = enabled37 and "Статус" or "Status", value = enabled37 and "Запущен Auto Prestige" or "Started Auto Prestige", inline = true }
      local settings13 = { name = enabled37 and "Уровень" or "Level", value = "Level " .. Value, inline = true }
      local settings14 = { name = enabled37 and "Престиж" or "Prestige", value = "Prestige " .. Value2, inline = true }
      local settings15 = { name = enabled37 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
      local settings16 = { name = enabled37 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
      fields3[1] = settings11
      fields3[2] = settings12
      fields3[3] = settings13
      fields3[4] = settings14
      fields3[5] = settings15
      fields3[6] = settings16
      settings7.fields = fields3
    elseif a == "stopped" then
      local Text6 = settings36.startLevel or "?"
      local Text7 = settings36.startPrestige or "?"
      local startTime2 = settings36.startTime
      local unknownText = startTime2 and callFormat2(tick() - startTime2) or "Unknown"
      local fields2 = {}
      local settings17 = {
        name = enabled37 and "Игрок" or "Player",
        value = sourceContext.callback41 and sourceContext.callback41() or sourceContext.player.Name, inline = true,
      }
      local settings18 = { name = enabled37 and "Статус" or "Status", value = enabled37 and "Остановлен" or "Stopped", inline = true }
      local settings19 = { name = enabled37 and "Длительность" or "Duration", value = unknownText, inline = true }
      local settings20 = { name = enabled37 and "Прогресс" or "Progress", value = "P" .. Text7 .. " L" .. Text6 .. " -> P" .. Value2 .. " L" .. Value, inline = true }
      local settings21 = { name = enabled37 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
      local settings22 = { name = enabled37 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
      fields2[1] = settings17
      fields2[2] = settings18
      fields2[3] = settings19
      fields2[4] = settings20
      fields2[5] = settings21
      fields2[6] = settings22
      settings7.fields = fields2
    elseif a == "completed" then
      local startTime = settings36.startTime
      local unknownText2 = startTime and callFormat2(tick() - startTime) or "Unknown"
      if sourceContext.sendPrestigeWebhook then
        sourceContext.sendPrestigeWebhook(3, 50, true, unknownText2)
        return
      end
      settings7.title = enabled37 and "[RAIL Hub] Auto Prestige Завершен" or "[RAIL Hub] Auto Prestige Completed"
      settings7.color = 15844367
      local fields = {}
      local settings23 = {
        name = enabled37 and "Статус" or "Status",
        value = enabled37 and "Максимальный уровень 50 / Престиж 3 (50/3)" or "Max Level 50 / Prestige 3 (50/3)",
        inline = true,
      }
      local settings24 = { name = enabled37 and "Баланс" or "Balance", value = ("$%s"):format(sourceContext.callback42(sourceContext.callback43())), inline = true }
      local settings25 = { name = enabled37 and "Время" or "Time Taken", value = unknownText2, inline = true }
      local settings26 = {
        name = enabled37 and "Игрок" or "Player",
        value = sourceContext.callback41 and sourceContext.callback41() or sourceContext.player.Name, inline = true,
      }
      local settings27 = { name = enabled37 and "Сервер" or "Server", value = game.JobId == "" and "Unknown" or game.JobId or "Unknown", inline = false }
      fields[1] = settings23
      fields[2] = settings24
      fields[3] = settings25
      fields[4] = settings26
      fields[5] = settings27
      settings7.fields = fields
    end
    callback173({ embeds = { [1] = settings7 } })
  end
  local function callback175(_)

  end
  local function callback176()
    local entry18 = count21
    local function callback58() return enabled36 and count21 == entry18 end
    local tick3
    getgenv().waitUntilCollect = 0.5
    getgenv().sortOrder = "Asc"
    getgenv().lessPing = false
    getgenv().autoRequiem = true
    getgenv().NPCTimeOut = 15
    getgenv().HamonCharge = 90
    tick3 = tick
    tick3 = tick3()
    repeat
      task.wait()
      local entry19 = callback58
      entry19 = callback58()
      if not entry19 then return end
      local gameReference = game
      local IsLoaded = gameReference.IsLoaded
    until IsLoaded(gameReference) and game.Players.LocalPlayer and game.Players.LocalPlayer.Character or tick() - tick3 > 30
    if not (game.Players.LocalPlayer and game.Players.LocalPlayer.Character) then return end
    local LocalPlayer = game.Players.LocalPlayer
    local Character = LocalPlayer.Character
    local timestamp3 = tick()
    repeat
      task.wait()
      local entry20 = callback58
      entry20 = callback58()
      if not entry20 then return end
      if not Character or not Character.Parent then Character = LocalPlayer.Character end
    until Character and Character.Parent and Character:FindFirstChild("RemoteEvent") and Character:FindFirstChild("RemoteFunction") or tick() - timestamp3 > 30
    if not (Character and Character.Parent and Character:FindFirstChild("RemoteEvent")) then return end
    local RemoteFunction = Character.RemoteFunction
    local RemoteEvent = Character.RemoteEvent
    local PrimaryPart, enabled37 = Character.PrimaryPart, true
    if LocalPlayer.PlayerStats.Level.Value == 50 and LocalPlayer.PlayerStats.Prestige.Value >= 3 then
      sourceContext.notify("Auto Prestige", "Already max prestige and level!")
      enabled36 = false
      autoPrestigeRunning = false
      sourceContext.callback34("AP", false)
      if type(prevAutoPrestigeEnv) == "table" then
        local pairsResult, entry23, entry24 = pairs(prevAutoPrestigeEnv)
        for k, v in pairsResult, entry23, entry24 do getgenv()[k] = v end
      end
      getgenv().AutoPrestigeEnvBackup = nil
      return
    end
    pcall(function()
      local Lighting = game.Lighting
      Lighting = Lighting:FindFirstChild("DepthOfField")
      if Lighting then Lighting.Enabled = false end
    end)
    pcall(function()
      workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_6.Size = Vector3.new(2048, 89, 2048)
      workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_4.Size = Vector3.new(2048, 89, 2048)
    end)
    local entries14 = {}
    if not pcall(function()
      local JSONDecode = game:GetService("HttpService")
      entries14 = JSONDecode.JSONDecode(JSONDecode, readfile("AutoPres3_" .. LocalPlayer.Name .. ".txt"))
    end) then
      local settings7 = { Time = tick(), Prestige = LocalPlayer.PlayerStats.Prestige.Value }
      local level
      level = LocalPlayer.PlayerStats.Level.Value
      settings7.Level = level
      entries14 = settings7
      settings7 = pcall
      function level()
        writefile("AutoPres3_" .. LocalPlayer.Name .. ".txt", game:GetService("HttpService"):JSONEncode(entries14))
      end
      settings7(level)
    end
    local timestamp4 = tick()
    local timestamp5 = tick()
    local function callback65(a)
      local settings7 = { Position = {}, ProximityPrompt = {}, Items = {} }
      local itemSpawns = game:GetService("Workspace"):FindFirstChild("Item_Spawns")
      itemSpawns = itemSpawns and game:GetService("Workspace").Item_Spawns:FindFirstChild("Items")
      if itemSpawns then
        for k, v in pairs(itemSpawns:GetChildren()) do
          local proximityPrompt6 = v:FindFirstChild("ProximityPrompt")
          local FindFirstChild = v.FindFirstChild
          FindFirstChild = FindFirstChild(v, "MeshPart") or v:FindFirstChildOfClass("BasePart")
          if FindFirstChild and proximityPrompt6 and proximityPrompt6.ObjectText == a then
            table.insert(settings7.Items, proximityPrompt6.ObjectText)
            table.insert(settings7.ProximityPrompt, proximityPrompt6)
            table.insert(settings7.Position, FindFirstChild.CFrame)
          end
        end
        return settings7
      end
      return settings7
    end
    local function callback69(a) return sfCountItem(a) end
    local function callback71(a, entry19)
      local backpack4 = LocalPlayer.Backpack
      local findFirstChildResult3 = backpack4.WaitForChild(backpack4, a, 5) or LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(a)
      if findFirstChildResult3 then
        local humanoid8 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid8 then humanoid8:EquipTool(findFirstChildResult3) end
        if entry19 then
          local remoteFunction5 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RemoteFunction")
          if remoteFunction5 then
            for i = 1, tonumber(entry19) or 2 do
              pcall(function()
                remoteFunction5:InvokeServer("LearnSkill", { Skill = "Worthiness", SkillTreeType = "Character" })
              end)
              task.wait(0.08)
            end
            pcall(function()
              remoteFunction5:InvokeServer("LearnSkill", { Skill = "Worthiness", SkillTreeType = "Character" })
            end)
            task.wait(0.05)
          end
        end
        local timestamp3 = tick()
        repeat
          pcall(function() findFirstChildResult3:Activate() end)
          task.wait(0.05)
          local playerGui3 = LocalPlayer.PlayerGui
          local entry20 = playerGui3
          playerGui3 = playerGui3.FindFirstChild
        until playerGui3(entry20, "DialogueGui") or tick() - timestamp3 > 3
        local dialogueGui3 = LocalPlayer.PlayerGui:FindFirstChild("DialogueGui")
        if dialogueGui3 then
          pcall(function()
            local Text
            repeat
              sourceContext.callback6(dialogueGui3.Frame.ClickContinue.MouseButton1Click)
              task.wait(0.05)
              local Options = dialogueGui3.Frame.Options
              Options = Options:FindFirstChild("Option1")
            until Options
            local option1 = dialogueGui3.Frame.Options:FindFirstChild("Option1")
            if option1 and option1:FindFirstChild("TextButton") then
              sourceContext.callback6(option1.TextButton.MouseButton1Click)
              sourceContext.callback6(option1.TextButton.Activated)
            end
            repeat
              sourceContext.callback6(dialogueGui3.Frame.ClickContinue.MouseButton1Click)
              task.wait(0.05)
              Text = dialogueGui3.Frame.DialogueFrame.Frame.Line001.Container.Group001.Text
            until Text == "You"
            sourceContext.callback6(dialogueGui3.Frame.ClickContinue.MouseButton1Click)
          end)
        end
        return true
      end
      return false
    end
    local entry26 = nil
    local settings11 = {
      Anubis = true, Aerosmith = true, ["White Album"] = true, ["Six Pistols"] = true, ["Beach Boy"] = true,
      ["Mr. President"] = true, ["Tusk (Act 1)"] = true, ["Scary Monsters"] = true, ["Hermit Purple"] = true,
    }
    local count19 = 0
    local function callback72()
      if not getgenv()._YBA_directTP then return end
      local timestamp3 = tick()
      if timestamp3 - count19 < 0.4 then task.wait(0.4 - (timestamp3 - count19)) end
    end
    local function callback76() count19 = tick() end
    local function callback77(a, cFrame2)
      if not (a and cFrame2) then return end
      if getgenv()._YBA_directTP then
        callback72()
        a.CFrame = cFrame2
        a.AssemblyLinearVelocity = Vector3.zero
        a.AssemblyAngularVelocity = Vector3.zero
        callback76()
      else
        local Magnitude = a.Position - cFrame2.Position
        Magnitude = Magnitude.Magnitude
        if Magnitude < 1 then return end
        local clamp = math.clamp(Magnitude / 425, 0.05, 3)
        local createResult3 = sourceContext.tweenServiceService:Create(a, TweenInfo.new(clamp, Enum.EasingStyle.Linear), { CFrame = cFrame2 })
        createResult3:Play()
        local timestamp3 = tick()
        while createResult3.PlaybackState ~= Enum.PlaybackState.Completed do
          if not (tick() - timestamp3 < clamp + 3 and callback58() and a) then break end
          if not a.Parent then break end
          task.wait(0.1)
        end
        pcall(function() createResult3:Cancel() end)
        createResult3:Destroy()
        a.AssemblyLinearVelocity = Vector3.zero
        a.AssemblyAngularVelocity = Vector3.zero
      end
    end
    local function callback82()
      local backpack4 = LocalPlayer.Backpack
      local entry19 = backpack4
      backpack4 = backpack4.FindFirstChild
      backpack4 = backpack4(entry19, "Rokakaka") or Character and Character:FindFirstChild("Rokakaka")
      if not backpack4 then
        entry19 = LocalPlayer.PlayerStats.Money.Value
        if entry19 >= 2500 then
          pcall(function() RemoteEvent:FireServer("PurchaseShopItem", { ItemName = "1x Rokakaka" }, 1, 2) end)
          task.wait(0.3)
          entry19 = LocalPlayer.Backpack
          entry19 = entry19:FindFirstChild("Rokakaka")
          if entry19 then
            backpack4 = entry19
          else
            local Character4 = Character
            backpack4 = if Character4 then Character:FindFirstChild("Rokakaka") else Character4
          end
        end
        if not backpack4 then
          entry26("Rokakaka", 1)
          task.wait(0.5)
          entry19 = LocalPlayer.Backpack
          entry19 = entry19:FindFirstChild("Rokakaka")
          if entry19 then
            backpack4 = entry19
          else
            local Character5 = Character
            backpack4 = if Character5 then Character:FindFirstChild("Rokakaka") else Character5
          end
        end
        if not backpack4 then return false end
      end
      local Value = LocalPlayer.PlayerStats.Stand.Value
      useItemDirect("Rokakaka", "Rokakaka")
      local Character6 = Character
      local timestamp3 = tick()
      while tick() - timestamp3 < 4 and LocalPlayer.Character == Character6 and callback58() do task.wait(0.05) end
      if LocalPlayer.Character and LocalPlayer.Character ~= Character6 then
        Character = LocalPlayer.Character
        RemoteFunction = Character:FindFirstChild("RemoteFunction")
        RemoteEvent = Character:FindFirstChild("RemoteEvent")
        PrimaryPart = Character.PrimaryPart
      end
      local timestamp6 = tick()
      timestamp3 = timestamp6
      while tick() - timestamp6 < 3 and callback58() do
        if LocalPlayer.PlayerStats.Stand.Value == "None" then return true end
        task.wait(0.1)
      end
      return LocalPlayer.PlayerStats.Stand.Value == "None"
    end
    local function callback95(a)
      a = a or 5
      local count20 = 0
      while count20 < a and callback58() do
        local Value = LocalPlayer.PlayerStats.Stand.Value
        local backpack4 = LocalPlayer.Backpack
        local entry19 = backpack4
        backpack4 = backpack4.FindFirstChild
        backpack4 = backpack4(entry19, "Mysterious Arrow") or Character and Character:FindFirstChild("Mysterious Arrow")
        if not backpack4 then
          if LocalPlayer.PlayerStats.Money.Value >= 750 then
            pcall(function() RemoteEvent:FireServer("PurchaseShopItem", { ItemName = "1x Mysterious Arrow" }, 1, 2) end)
            task.wait(0.3)
            local Backpack = LocalPlayer.Backpack
            Backpack = Backpack:FindFirstChild("Mysterious Arrow")
            if Backpack then
              backpack4 = Backpack
            else
              local Character4 = Character
              backpack4 = if Character4 then Character:FindFirstChild("Mysterious Arrow") else Character4
            end
          end
          if not backpack4 then
            entry26("Mysterious Arrow", 1)
            task.wait(0.5)
            local Backpack2 = LocalPlayer.Backpack
            Backpack2 = Backpack2:FindFirstChild("Mysterious Arrow")
            if Backpack2 then
              backpack4 = Backpack2
            else
              local Character5 = Character
              backpack4 = if Character5 then Character:FindFirstChild("Mysterious Arrow") else Character5
            end
          end
          if not backpack4 then return false end
        end
        useItemDirect("Mysterious Arrow", "Mysterious Arrow")
        local Character6 = Character
        local timestamp3 = tick()
        while tick() - timestamp3 < 4 and LocalPlayer.Character == Character6 and callback58() do task.wait(0.05) end
        if LocalPlayer.Character and LocalPlayer.Character ~= Character6 then
          Character = LocalPlayer.Character
          RemoteFunction = Character:FindFirstChild("RemoteFunction")
          RemoteEvent = Character:FindFirstChild("RemoteEvent")
          PrimaryPart = Character.PrimaryPart
        end
        local Value2 = LocalPlayer.PlayerStats.Stand.Value
        if Value2 ~= "None" and Value2 ~= Value then return true end
        count20 = count20 + 1
        task.wait(0.3)
      end
      return false
    end
    local function callback96()
      if LocalPlayer.PlayerStats.Level.Value < 2 then return false end
      if LocalPlayer.PlayerStats.Stand.Value == "None" then
        callback77(LocalPlayer.Character.HumanoidRootPart, standFarmPosition)
        if not LocalPlayer.Character:GetAttribute("WorthinessLearned") then
          sfLearnWorthiness()
          pcall(function() LocalPlayer.Character:SetAttribute("WorthinessLearned", true) end)
        end
        pcall(function() RemoteFunction:InvokeServer("LearnSkill", { Skill = "Stand Summon", SkillTreeType = "Stand" }) end)
        local count20 = 0
        while true do
          if LocalPlayer.PlayerStats.Stand.Value ~= "None" or not (count20 < 20) or not callback58() then break end
          if count20 % 3 == 0 then
            pcall(function() sfLearnWorthiness(true) end)
            task.wait(0.3)
          end
          callback95(3)
          count20 = count20 + 1
          if LocalPlayer.PlayerStats.Stand.Value ~= "None" then
            local Value = LocalPlayer.PlayerStats.Stand.Value
            if not settings11[Value] then
              sourceContext.notify("Auto Prestige", "Got stand: " .. Value .. "! Resetting...")
              task.spawn(function()
                RemoteFunction:InvokeServer("LearnSkill", { Skill = "Stand Summon", SkillTreeType = "Stand" })
                local settings7 = {
                  [1] = "Destructive Power I", [2] = "Destructive Power II", [3] = "Destructive Power III",
                  [4] = "Destructive Power IV", [5] = "Destructive Power V", [6] = "Stand Barrage",
                  [7] = "Stand Barrage Finisher",
                }
                for k, v in pairs(settings7) do RemoteFunction:InvokeServer("LearnSkill", { Skill = v, SkillTreeType = "Stand" }) end
              end)
              task.wait(0.3)
              local humanoid8 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
              if humanoid8 then
                local Character2 = LocalPlayer.Character
                humanoid8.Health = 0
                local Character32 = nil
                local timestamp3 = tick()
                while tick() - timestamp3 < 15 and callback58() do
                  local Character3 = LocalPlayer.Character
                  if Character3 and Character3 ~= Character2 and Character3.Parent then
                    local humanoid9 = Character3:FindFirstChildOfClass("Humanoid")
                    if humanoid9 and humanoid9.Health > 0 then
                      Character32 = Character3
                      break
                    end
                  end
                  task.wait(0.25)
                end
                if callback58() then
                  task.wait(1)
                  if Character32 then
                    Character = Character32
                    local Character4 = Character
                    RemoteFunction = Character4.WaitForChild(Character4, "RemoteFunction", 5) or Character:FindFirstChild("RemoteFunction")
                    local Character5 = Character
                    RemoteEvent = Character5.WaitForChild(Character5, "RemoteEvent", 5) or Character:FindFirstChild("RemoteEvent")
                    local Character6 = Character
                    PrimaryPart = Character6.WaitForChild(Character6, "HumanoidRootPart", 5) or Character:FindFirstChild("HumanoidRootPart")
                  end
                  break
                end
                return
              end
              break
            end
            sourceContext.notify("Auto Prestige", "Blacklisted: " .. Value .. " — rerolling...")
            callback82()
            task.wait(1)
          end
        end
      end
      enabled37 = true
    end
    local function callback97(a, b)
      local enabled38 = false
      local waitUntilCollect = getgenv()
      waitUntilCollect = waitUntilCollect.waitUntilCollect
      waitUntilCollect = waitUntilCollect + 5
      if Character:FindFirstChild("SummonedStand") and Character.SummonedStand.Value then RemoteFunction:InvokeServer("ToggleStand", "Toggle") end
      local connectResult12 = nil
      connectResult12 = LocalPlayer.Backpack.ChildAdded:Connect(function()
        enabled38 = true
        if connectResult12 then connectResult12:Disconnect() end
      end)
      task.spawn(function()
        while not enabled38 do
          task.wait()
          pcall(function()
            if a.Position[b] then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a.Position[b] - Vector3.new(0, 10, 0) end
          end)
        end
      end)
      task.wait(getgenv().waitUntilCollect)
      task.spawn(function()
        if a.ProximityPrompt[b] then fireproximityprompt(a.ProximityPrompt[b]) end
        local screenGui = LocalPlayer and LocalPlayer.PlayerGui and (LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") or LocalPlayer.PlayerGui:WaitForChild("ScreenGui", 3))
        if screenGui then
          local part2 = screenGui:FindFirstChild("Part") or screenGui:WaitForChild("Part", 2)
          if part2 then
            for k, v in pairs(part2:GetDescendants()) do
              if v:FindFirstChild("Part") and v:IsA("ImageButton") then
                local FindFirstChild = v.FindFirstChild
                FindFirstChild = FindFirstChild(v, "Part") or v:WaitForChild("Part", 2)
                if FindFirstChild and FindFirstChild.TextColor3 == Color3.new(0, 1, 0) then
                  local timestamp3 = tick()
                  repeat
                    if not callback58() then break end
                    local typeResult2 = type(firesignal)
                    if typeResult2 == "function" then
                      pcall(function()
                        firesignal(v.MouseEnter)
                        firesignal(v.MouseButton1Up)
                        firesignal(v.MouseButton1Click)
                        firesignal(v.Activated)
                      end)
                    else
                      pcall(function() sourceContext.callback9(v) end)
                    end
                    typeResult2 = task
                    typeResult2.wait(0.1)
                    typeResult2 = LocalPlayer
                    typeResult2 = LocalPlayer.PlayerGui
                    local entry19 = typeResult2
                    typeResult2 = typeResult2.FindFirstChild
                  until not typeResult2(entry19, "ScreenGui") or tick() - timestamp3 > 10
                end
              end
            end
          end
        end
      end)
      task.spawn(function()
        for i = waitUntilCollect, 1, -1 do task.wait(1) end
        if not enabled38 then enabled38 = true end
      end)
      while not enabled38 do task.wait() end
    end
    function entry26(a, b)
      local environment8 = getgenv()
      environment8 = environment8._YBA_Exports
      environment8 = environment8 or {}
      environment8 = environment8.farmItemByName
      if environment8 then
        enableNoclipState("stand")
        environment8(a, b, callback58)
        disableNoclipState("stand")
        return true
      end
      warn("[Auto Prestige] farmItemByName not found in _YBA_Exports")
      return false
    end
    local function callback99(a)
      if not a then return end
      sourceContext.callback9(a)
    end
    local function callback101()
      local Character = LocalPlayer.Character
      if Character then
        if not Character:FindFirstChild("InCombat") and not Character:FindFirstChild("Combat") and not Character:FindFirstChild("CombatTag") then
          local playerStats2 = LocalPlayer:FindFirstChild("PlayerStats")
          if playerStats2 and (playerStats2:FindFirstChild("InCombat") or playerStats2:FindFirstChild("Combat")) then return true end
          local collectionServiceService = game:GetService("CollectionService")
          if not collectionServiceService:HasTag(Character, "InCombat") and not collectionServiceService:HasTag(Character, "Combat") then return false end
          return true
        end
        return true
      end
      return false
    end
    local function callback102(a)
      a = a or 18
      if callback101() then
        callback175("In combat! Waiting for combat tag to clear...")
        local timestamp3 = tick()
        while callback101() and tick() - timestamp3 < a and callback58() do task.wait(0.5) end
        task.wait(0.5)
      end
    end
    local entries18 = {}
    local function callback106(a, b, c)
      b = b or 1
      local find = a:lower()
      local findResult = find.find(find, "mista") ~= nil
      callback102()
      local PlayerGui = LocalPlayer.PlayerGui
      PlayerGui = PlayerGui:FindFirstChild("DialogueGui")
      if PlayerGui and PlayerGui.Parent and PlayerGui.Enabled and PlayerGui:FindFirstChild("Frame") and PlayerGui.Frame.Visible then
        local Frame = PlayerGui.Frame
        Frame = Frame:FindFirstChild("ClickContinue")
        if Frame then
          sourceContext.callback9(Frame)
          task.wait(0.15)
        end
      end
      local entry19 = nil
      local entry20 = entries18[tostring(a)]
      if entry20 and entry20.Parent and entry20:IsDescendantOf(workspace) then entry19 = entry20 end
      if not entry19 and workspace:FindFirstChild("Dialogues") then
        entry19 = workspace.Dialogues:FindFirstChild(a)
        if not entry19 then
          local ipairsResult, entry23, entry24 = ipairs(workspace.Dialogues:GetChildren())
          for k, v in ipairsResult, entry23, entry24 do
            local name2 = v.Name
            name2 = name2:lower()
            local entry27 = name2
            name2 = name2.find
            name2 = name2(entry27, a:lower(), 1, true)
            if name2 then
              entry19 = v
              break
            end
          end
        end
      end
      if not entry19 then
        local entries19 = {}
        local nPCs = workspace:FindFirstChild("NPCs")
        local living = workspace:FindFirstChild("Living")
        local workspace4 = workspace
        entries19[1] = nPCs
        entries19[2] = living
        entries19[3] = workspace4
        nPCs = ipairs
        living = entries19
        local ipairs3Result2, entry28, entry30 = nPCs(entries19)
        for k3, v3 in ipairs3Result2, entry28, entry30 do
          if v3 and not entry19 then
            local ipairsResult2, entry31, entry32 = ipairs(v3:GetChildren())
            for k2, v2 in ipairsResult2, entry31, entry32 do
              if v2:IsA("Model") and not sourceContext.playersService:GetPlayerFromCharacter(v2) then
                local Name = v2.Name
                Name = Name:lower()
                local lowerResult = tostring(a):lower()
                local findResult2 = Name:find(lowerResult, 1, true)
                if findResult2 or lowerResult:find(Name, 1, true) then
                  entry19 = v2
                  break
                end
              end
            end
          end
        end
      end
      if entry19 then
        entries18[tostring(a)] = entry19
        local rootPart10 = entry19:FindFirstChild("HumanoidRootPart")
        rootPart10 = rootPart10 or entry19.PrimaryPart or entry19:FindFirstChild("Torso") or entry19:FindFirstChild("UpperTorso") or entry19:FindFirstChild("Head") or entry19:FindFirstChildOfClass("BasePart")
        if rootPart10 then
          local Character = LocalPlayer.Character
          local rootPart11 = Character and Character:FindFirstChild("HumanoidRootPart")
          local humanoid8 = Character and Character:FindFirstChildOfClass("Humanoid")
          if rootPart11 then
            local LookVector = rootPart10.CFrame.LookVector
            local new = CFrame.new(rootPart10.Position + LookVector * 3, rootPart10.Position)
            if rootPart10.Name == "Head" then new = new - Vector3.new(0, 1.5, 0) end
            callback77(rootPart11, new)
            rootPart11.AssemblyLinearVelocity = Vector3.zero
            rootPart11.AssemblyAngularVelocity = Vector3.zero
            if humanoid8 then
              humanoid8.Jump = false
              pcall(function() humanoid8:ChangeState(Enum.HumanoidStateType.Running) end)
            end
            local function callback65()
              pcall(function()
                if rootPart11 and rootPart11.Parent then
                  rootPart11.AssemblyLinearVelocity = Vector3.zero
                  rootPart11.AssemblyAngularVelocity = Vector3.zero
                end
                if humanoid8 and humanoid8.Parent then humanoid8.Jump = false end
              end)
            end
            local proximityPrompt6 = entry19:FindFirstChildWhichIsA("ProximityPrompt", true)
            local function callback69()
              if proximityPrompt6 then
                pcall(function() fireproximityprompt(proximityPrompt6) end)
                pcall(function()
                  if type(firesignal) == "function" then
                    firesignal(proximityPrompt6.Triggered, sourceContext.player)
                    firesignal(proximityPrompt6.PromptTriggered, sourceContext.player)
                  end
                end)
              end
            end
            task.wait(0.12)
            callback69()
            local function callback97(d)
              local entries19 = {}
              for k2, v2 in ipairs(d:GetChildren()) do
                if v2:IsA("GuiObject") and v2.Visible and v2.Name ~= "UIListLayout" and v2.Name ~= "UIPadding" and v2.Name ~= "UIGridLayout" then
                  local textButton = v2:FindFirstChildWhichIsA("TextButton", true)
                  textButton = textButton or v2:FindFirstChildWhichIsA("GuiButton", true) or v2:IsA("GuiButton") and v2
                  local rawText = ""
                  if textButton and textButton:IsA("TextButton") and textButton.Text and textButton.Text ~= "" then rawText = textButton.Text end
                  if rawText == "" then
                    local ipairsResult, entry19, entry20 = ipairs(v2:GetDescendants())
                    for k, v in ipairsResult, entry19, entry20 do
                      if (v:IsA("TextLabel") or v:IsA("TextButton")) and v.Text and v.Text ~= "" then
                        rawText = v.Text
                        break
                      end
                    end
                  end
                  if rawText == "" and v2:IsA("TextLabel") and v2.Text ~= "" then rawText = v2.Text end
                  table.insert(entries19, {
                    name = v2.Name, btn = textButton or v2, opt = v2, text = rawText:lower():gsub("^%s+", ""):gsub("%s+$", ""),
                    rawText = rawText, y = v2.AbsolutePosition and v2.AbsolutePosition.Y or 9999,
                  })
                end
              end
              if #entries19 == 0 then return nil end
              if c and c ~= "" then
                local lowerResult = c:lower()
                for k3, v3 in ipairs(entries19) do
                  local text = v3.text
                  text = text:find(lowerResult, 1, true)
                  if text and (not findResult or not v3.text:find("four") and not v3.text:find("4")) then return v3.btn end
                end
              end
              if findResult then
                local entries20 = {}
                for k4, v4 in ipairs(entries19) do
                  local text4 = v4.text
                  local entry23 = text4
                  text4 = text4.find
                  if not text4(entry23, "four") and not v4.text:find("4") then table.insert(entries20, v4) end
                end
                if #entries20 > 0 then
                  for k5, v5 in ipairs(entries20) do
                    local text5 = v5.text
                    local entry24 = text5
                    text5 = text5.find
                    if text5(entry24, "recruit") or v5.text:find("on it") or v5.text:find("i'm on it") then return v5.btn end
                  end
                  for k6, v6 in ipairs(entries20) do
                    local text6 = v6.text
                    local entry27 = text6
                    text6 = text6.find
                    if text6(entry27, "know") or v6.text:find("idea") or v6.text:find("five") or v6.text:find("не знаю") or v6.text:find("21") then return v6.btn end
                  end
                  for k7, v7 in ipairs(entries20) do if v7.text ~= "..." and v7.text ~= "" then return v7.btn end end
                  return entries20[1].btn
                end
              end
              local ipairsResult2, entry28, entry30 = ipairs({
                [1] = "see ya later", [2] = "see you later", [3] = "see ya", [4] = "see you", [5] = "okay, see ya",
                [6] = "see ya later!", [7] = "can i help out again", [8] = "help out again", [9] = "help out", [10] = "again",
                [11] = "help", [12] = "recruit", [13] = "got this", [14] = "what now", [15] = "here it is",
                [16] = "knock some sense", [17] = "understood", [18] = "wow, thanks", [19] = "relax", [20] = "nice to meet",
                [21] = "yep", [22] = "yeah", [23] = "agreed", [24] = "yes", [25] = "sure", [26] = "take care", [27] = "dream",
                [28] = "let him know", [29] = "accept", [30] = "continue", [31] = "okay", [32] = "fine", [33] = "on it",
                [34] = "i'm on it", [35] = "where", [36] = "safe", [37] = "sooner", [38] = "ready", [39] = "i will",
                [40] = "deal", [41] = "let's go", [42] = "lets go", [43] = "alright", [44] = "all right", [45] = "sounds good",
                [46] = "prestige",
              })
              for k9, v9 in ipairsResult2, entry28, entry30 do
                local ipairsResult5, entry31, entry32 = ipairs(entries19)
                for k8, v8 in ipairsResult5, entry31, entry32 do
                  local text2 = v8.text
                  text2 = text2:find(v9, 1, true)
                  if text2 then return v8.btn end
                end
              end
              local settings7 = {
                [1] = "nevermind", [2] = "never mind", [3] = "no thanks", [4] = "no thank you", [5] = "maybe later",
                [6] = "not right now", [7] = "not now", [8] = "i'm busy", [9] = "im busy", [10] = "decline", [11] = "cancel",
                [12] = "i'll pass", [13] = "ill pass", [14] = "don't want to", [15] = "dont want to", [16] = "no,",
                [17] = "no.",
              }
              local entries21 = {}
              for k11, v11 in ipairs(entries19) do
                local enabled39
                if v11.text == "no" then
                  enabled39 = true
                else
                  local ipairsResult6, entry33, entry34 = ipairs(settings7)
                  enabled39 = false
                  for k10, v10 in ipairsResult6, entry33, entry34 do
                    local text3 = v11.text
                    text3 = text3:find(v10, 1, true)
                    if text3 then
                      enabled39 = true
                      break
                    end
                  end
                end
                if not enabled39 then table.insert(entries21, v11) end
              end
              local entry35 = #entries21 > 0 and entries21 or entries19
              local ipairsResult7, entry36, entry37 = ipairs(entry35)
              for k12, v12 in ipairsResult7, entry36, entry37 do if v12.text ~= "..." and v12.text ~= "" then return v12.btn end end
              local ipairsResult8, entry38, entry39 = ipairs(entry35)
              for k13, v13 in ipairsResult8, entry38, entry39 do
                if v13.name == "Option" .. tostring(b) or v13.name == "Option1" then return v13.btn end
              end
              return entry35[1].btn
            end
            local timestamp3 = tick()
            local enabled39 = false
            local timestamp6 = tick()
            local enabled40 = false
            pcall(function()
              while tick() - timestamp3 < 4.5 and callback58() do
                if humanoid8 then humanoid8.Jump = false end
                local playerGui3 = LocalPlayer.PlayerGui
                local entry19 = playerGui3
                playerGui3 = playerGui3.FindFirstChild
                playerGui3 = playerGui3(entry19, "DialogueGui") or LocalPlayer.PlayerGui:FindFirstChild("Dialogue")
                local visible = playerGui3 and playerGui3.Parent and playerGui3.Enabled and playerGui3:FindFirstChild("Frame") and playerGui3.Frame.Visible
                if visible then
                  enabled39 = true
                  local Frame = playerGui3.Frame
                  local dialogueFrame = Frame:FindFirstChild("DialogueFrame")
                  local Text6 = ""
                  if dialogueFrame then
                    local ipairsResult, entry20, entry23 = ipairs(dialogueFrame:GetDescendants())
                    for k, v in ipairsResult, entry20, entry23 do
                      if v:IsA("TextLabel") and v.Text ~= "" then Text6 = Text6 .. " " .. v.Text end
                    end
                  end
                  local lowerResult = Text6:lower()
                  if lowerResult:find("combat") or lowerResult:find("в бою") then
                    callback175("NPC dialogue blocked by combat! Waiting for tag to expire...")
                    enabled40 = true
                    local clickContinue = Frame:FindFirstChild("ClickContinue")
                    if clickContinue then sourceContext.callback9(clickContinue) end
                    break
                  end
                  if Text6:find("COMPLETE STORYLINE QUESTS IN ORDER") or Text6:find("Level 25+") or Text6:find("You need to be") then
                    local clickContinue2 = Frame:FindFirstChild("ClickContinue")
                    if clickContinue2 then sourceContext.callback9(clickContinue2) end
                    break
                  end
                  local options = Frame:FindFirstChild("Options")
                  local visible2 = options and options.Visible and callback97(options)
                  if visible2 then
                    sourceContext.callback9(visible2)
                    task.wait(0.12)
                  else
                    local clickContinue3 = Frame:FindFirstChild("ClickContinue")
                    if clickContinue3 and clickContinue3.Visible then
                      sourceContext.callback9(clickContinue3)
                      task.wait(0.08)
                    elseif dialogueFrame and dialogueFrame.Visible then
                      sourceContext.callback9(dialogueFrame)
                      task.wait(0.08)
                    elseif clickContinue3 then
                      sourceContext.callback9(clickContinue3)
                      task.wait(0.08)
                    else
                      sourceContext.callback9(Frame)
                      task.wait(0.08)
                    end
                  end
                else
                  if enabled39 then break end
                  if tick() - timestamp6 > 0.6 then
                    timestamp6 = tick()
                    callback69()
                  end
                end
                task.wait(0.02)
              end
            end)
            callback65()
            pcall(function()
              local dialogueGui4 = LocalPlayer.PlayerGui:FindFirstChild("DialogueGui")
              if dialogueGui4 and dialogueGui4.Parent and dialogueGui4.Enabled and dialogueGui4:FindFirstChild("Frame") and dialogueGui4.Frame.Visible then
                local clickContinue = dialogueGui4.Frame:FindFirstChild("ClickContinue")
                if clickContinue then
                  sourceContext.callback9(clickContinue)
                  task.wait(0.05)
                end
              end
            end)
            task.wait(0.05)
            if enabled40 then return false end
            return enabled39
          end
          return false
        end
        return false
      end
      warn("[Auto Prestige] NPC not found: " .. tostring(a))
      return false
    end
    local function callback109(a, b, c, d)
      d = d or 3
      for i = 1, d do
        if not callback58() then break end
        if callback106(a, b, c) and not callback101() then return true end
        if i < d and callback58() then
          callback175("Retrying dialogue with " .. tostring(a) .. " (" .. i .. "/" .. d .. ")...")
          callback102(5)
          task.wait(0.4)
        end
      end
      return false
    end
    local function callback124(a)
      local entries19 = {}
      local Backpack = "Pure Rokakaka"
      entries19[1] = "Mysterious Arrow"
      entries19[2] = "Rokakaka"
      entries19[3] = "Diamond"
      entries19[4] = "Steel Ball"
      entries19[5] = "Quinton's Glove"
      entries19[6] = "Pure Rokakaka"
      entries19[7] = "Rib Cage of The Saint's Corpse"
      entries19[8] = "Ancient Scroll"
      entries19[9] = "Clackers"
      entries19[10] = "Caesar's Headband"
      for k, v in pairs(entries19) do
        if a <= LocalPlayer.PlayerStats.Money.Value or not callback58() then break end
        entry26(v, 10)
        Backpack = LocalPlayer.Backpack
        Backpack = Backpack:FindFirstChild(v)
        if Backpack and not isProtectedItem(Backpack) and not isProtectedItem(Backpack.Name) then sellItem(Backpack, true) end
      end
    end
    local entries19 = {}
    local function callback129(a, _, _, d)
      local connectResult13, entry19, entry20, entries20, entry23, entry24, gameReference, entry27, entry28, humanoidRootPart, Character, Position, settings7, Value, entry30, entry31, new2, entry32, attachStandToTarget2, entries21, Stepped, entry33, Value2, Value3, count20, timestamp7, humanoid9, health, Health, count22, entry34, count23, Value4, humanoid10, Value5, humanoid11, health2, count24, count25, entry35
      connectResult13 = nil
      function entry19(b)
        if b and b.Parent and b:FindFirstChild("HumanoidRootPart") then
          local humanoid9 = b:FindFirstChildOfClass("Humanoid")
          if humanoid9 and not (humanoid9.Health <= 0) then
            local health = b:FindFirstChild("Health")
            if health and health:IsA("ValueBase") and health.Value <= 0 and humanoid9.Health <= 0.1 then return false end
            return true
          end
          return false
        end
        return false
      end
      function entry20()
        local pairsResult, entry20, entry23, timestamp7
        local timestamp8 = tick()
        timestamp8 = timestamp8 + (getgenv().NPCTimeOut or 15)
        repeat
          timestamp5 = tick()
          local v15 = nil
          local huge = math.huge
          local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
          if humanoidRootPart then
            pairsResult, entry20, entry23 = pairs(workspace.Living:GetChildren())
            for k, v in pairsResult, entry20, entry23 do
              timestamp7 = entries19[v] and tick() < entries19[v]
              if not timestamp7 and v.Name == a and v:FindFirstChild("HumanoidRootPart") and entry19(v) then
                local Magnitude = humanoidRootPart.Position - v.HumanoidRootPart.Position
                Magnitude = Magnitude.Magnitude
                if Magnitude < huge then v15, huge = v, Magnitude end
              end
            end
          end
          if v15 then return v15 end
          task.wait(0.2)
        until timestamp8 < tick() or not callback58()
        return nil
      end
      local count26 = 0
      local count27 = 0
      entries20 = {}
      local anubis = { [1] = "Stand Barrage", [2] = "Ora Kicks" }
      entries20["Star Platinum"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Ora Kicks", [3] = "Skull Crusher" }
      entries20["Star Platinum: The World"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Knives", [3] = "Kick Barrage" }
      entries20["The World"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Knives", [3] = "Gun", [4] = "Chop" }
      entries20["The World: Alternate Universe"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Chop" }
      entries20["King Crimson"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Chop" }
      entries20["King Crimson Requiem"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Create Life" }
      entries20["Gold Experience"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Scorpion Beam" }
      entries20["Gold Experience Requiem"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Million Pricks", [3] = "Last Shot" }
      entries20["Silver Chariot"] = anubis
      anubis = { [1] = "Stand Barrage" }
      entries20["Chariot Requiem"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Bearing Shot", [3] = "Blood Slash" }
      entries20["Crazy Diamond"] = anubis
      anubis = { [1] = "Stand Barrage" }
      entries20["Crazy Diamond Requiem"] = anubis
      anubis = { [1] = "Stand Barrage" }
      entries20["Diver Down"] = anubis
      anubis = { [1] = "Stand Barrage" }
      entries20["Killer Queen"] = anubis
      anubis = { [1] = "Stand Barrage" }
      entries20["Killer Queen: Bites the Dust"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Acid Spit" }
      entries20.Whitesnake = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Surface Inversion Punch" }
      entries20["C-Moon"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Speed Slice" }
      entries20["Made in Heaven"] = anubis
      anubis = { [1] = "Stand Barrage" }
      entries20.D4C = anubis
      anubis = { [1] = "Stand Barrage" }
      entries20["D4C: Love Train"] = anubis
      anubis = { [1] = "Nail Shots" }
      entries20["Tusk Act 1"] = anubis
      anubis = { [1] = "Nail Shots", [2] = "Golden Rectangle Nail" }
      entries20["Tusk Act 2"] = anubis
      anubis = { [1] = "Nail Shots", [2] = "Golden Rectangle Nail" }
      entries20["Tusk Act 3"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Golden Rectangle Nail" }
      entries20["Tusk Act 4"] = anubis
      anubis = { [1] = "Vine Slap", [2] = "Vine Trap" }
      entries20["Hermit Purple"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Crossfire Hurricane" }
      entries20["Magician's Red"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Bulb Throw" }
      entries20["Purple Haze"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Extend Arm" }
      entries20["Sticky Fingers"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Erasure", [3] = "Erasure Pull" }
      entries20["The Hand"] = anubis
      anubis = { [1] = "Multi Shot", [2] = "Auto Reload" }
      entries20["Sex Pistols"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Vola Barrage" }
      entries20.Aerosmith = anubis
      anubis = { [1] = "Hook Slash", [2] = "Auto Rod" }
      entries20["Beach Boy"] = anubis
      anubis = {}
      entries20["Mr. President"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Cursed Blade" }
      entries20.Anubis = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Lightning Jab" }
      entries20["Red Hot Chili Pepper"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Friction Plunder" }
      entries20["Soft & Wet"] = anubis
      anubis = { [1] = "Stand Barrage", [2] = "Go Beyond Bubble", [3] = "Explosive Spin" }
      entries20["Soft & Wet: Go Beyond"] = anubis
      function entry23(b)
        if not entry19(b) then return end
        local Character = LocalPlayer.Character
        if not Character then return end
        local RemoteFunction2 = Character:FindFirstChild("RemoteFunction") or RemoteFunction
        local FindFirstChild = Character.FindFirstChild
        FindFirstChild = FindFirstChild(Character, "RemoteEvent") or RemoteEvent
        if not RemoteFunction2 then return end
        local function callback65(c, e)
          if not (callback58() and entry19(b)) then return end
          task.spawn(function() pcall(function() RemoteFunction2:InvokeServer(c, e) end) end)
        end
        local collectionServiceService = game:GetService("CollectionService")
        if collectionServiceService:HasTag(b, "Blocking") then
          if FindFirstChild then FindFirstChild.FireServer(FindFirstChild, "InputBegan", { Input = Enum.KeyCode.R }) end
          callback65("Attack", "m2")
        else
          local timestamp7 = tick()
          if timestamp7 - count26 > 0.12 and getgenv().autoSkills ~= false and LocalPlayer.PlayerStats.Stand.Value ~= "None" then
            count26 = timestamp7
            local entry20 = entries20
            local entry23 = LocalPlayer.PlayerStats.Stand.Value
            entry23 = entry20[entry23]
            if entry23 then for k, v in ipairs(entry23) do callback65("SpecialMove", { Skill = v }) end end
          end
          for i = 1, 5 do callback65("Attack", "m1") end
        end
        local timestamp8 = tick()
        if timestamp8 - count27 >= 1 then
          local Value = LocalPlayer.PlayerStats.Spec.Value
          Value = Value:lower()
          Value = Value:find("hamon")
          Value = Value ~= nil or Character:FindFirstChild("Hamon") ~= nil
          if Value then
            if Character:FindFirstChild("Hamon") then
              local Value2 = Character.Hamon.Value
              local HamonCharge = getgenv()
              HamonCharge = HamonCharge.HamonCharge
              HamonCharge = HamonCharge and getgenv().HamonCharge * 10 or 90
              if Value2 < HamonCharge then
                count27 = timestamp8
                RemoteFunction2:InvokeServer("ChargeHamon")
              end
            else
              count27 = timestamp8
              RemoteFunction2:InvokeServer("ChargeHamon")
            end
          end
        end
      end
      entry24 = entry20()
      if entry24 then
        gameReference = game
        gameReference = gameReference:GetService("RunService")
        humanoidRootPart = entry24:FindFirstChild("HumanoidRootPart")
        Character = LocalPlayer.Character
        local rootPart10 = Character and Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart and rootPart10 then
          local diavoloText = a == "Diavolo" or entry24 and entry24.Name == "Diavolo"
          Position = humanoidRootPart.Position
          settings7 = {
            None = true, ["Beach Boy"] = true, ["Sex Pistols"] = true, Anubis = true, ["Hermit Purple"] = true,
            ["Mr. President"] = true, ["White Album"] = true, ["Scary Monsters"] = true,
          }
          Value = LocalPlayer.PlayerStats.Stand.Value
          local enabled41
          enabled41 = if Value == "None" then false else not settings7[Value]
          entry30 = sourceContext.callback29(Value)
          entry31 = enabled41 and 11.5 or entry30
          new2 = CFrame.new
          local new = Vector3.new(0, entry31, 0)
          local heartbeat
          rootPart10.CFrame = new2(Position - new) * CFrame.Angles(math.rad(90), 0, 0)
          rootPart10.AssemblyLinearVelocity = Vector3.new(0, 0.05, 0)
          rootPart10.AssemblyAngularVelocity = Vector3.zero
          heartbeat = gameReference.Heartbeat
          heartbeat.Wait(heartbeat)
          task.wait(0.06)
          if enabled41 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("SummonedStand") and not LocalPlayer.Character.SummonedStand.Value then
            pcall(function()
              local character2 = LocalPlayer.Character
              local entry20 = character2
              character2 = character2.FindFirstChild
              character2 = character2(entry20, "RemoteFunction") or RemoteFunction
              if character2 then character2:InvokeServer("ToggleStand", "Toggle") end
            end)
            task.wait(0.3)
          end
          function attachStandToTarget2(Enabled)
            local Character = LocalPlayer.Character
            local standMorph = Character and Character:FindFirstChild("StandMorph")
            local standAttach = standMorph and standMorph.PrimaryPart and standMorph.PrimaryPart:FindFirstChild("StandAttach")
            if standAttach then
              local alignPosition = standAttach:FindFirstChildOfClass("AlignPosition")
              local alignOrientation = standAttach:FindFirstChildOfClass("AlignOrientation")
              if alignPosition then alignPosition.Enabled = Enabled end
              if alignOrientation then alignOrientation.Enabled = Enabled end
            end
          end
          if enabled41 then attachStandToTarget2(false) end
          entries21 = {}
          pcall(function()
            if LocalPlayer.Character then
              for k, v in ipairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then entries21[#entries21 + 1] = v end end
            end
          end)
          local connectResult14 = nil
          pcall(function()
            if LocalPlayer.Character then
              connectResult14 = LocalPlayer.Character.DescendantAdded:Connect(function(b) if b:IsA("BasePart") then entries21[#entries21 + 1] = b end end)
            end
          end)
          local Heartbeat
          connectResult13 = gameReference.Stepped:Connect(function()
            if LocalPlayer.Character then
              if connectResult14 == nil or connectResult14.Connected == false then
                if table.clear then table.clear(entries21) else for entry20 in pairs(entries21) do entries21[entry20] = nil end end
                pcall(function()
                  for k, v in ipairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then entries21[#entries21 + 1] = v end end
                end)
              end
              for i = 1, #entries21 do
                local entry23 = entries21[i]
                if entry23 and entry23.Parent and entry23.CanCollide then entry23.CanCollide = false end
              end
            end
          end)
          Heartbeat = gameReference.Heartbeat
          Heartbeat = Heartbeat:Connect(function()
            local Parent = LocalPlayer.Character
            local rootPart10 = Parent and Parent:FindFirstChild("HumanoidRootPart")
            local rootPart12 = entry24 and entry24:FindFirstChild("HumanoidRootPart")
            if rootPart10 and rootPart12 and rootPart12.Parent and entry19(entry24) then
              if d then
                d(entry24)
              else
                local standMorph = Parent:FindFirstChild("StandMorph")
                local Position2 = rootPart12.Position
                if enabled41 then
                  local summonedStand = Parent:FindFirstChild("SummonedStand")
                  if summonedStand and not summonedStand.Value then
                    pcall(function()
                      local FindFirstChild = Parent.FindFirstChild
                      FindFirstChild = FindFirstChild(Parent, "RemoteFunction") or RemoteFunction
                      if FindFirstChild then FindFirstChild:InvokeServer("ToggleStand", "Toggle") end
                    end)
                  end
                  if standMorph and standMorph.PrimaryPart then
                    attachStandToTarget2(false)
                    local LookVector = rootPart12.CFrame.LookVector
                    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z)
                    Unit = if Unit.Magnitude > 0.01 then Unit.Unit else Vector3.new(0, 0, -1)
                    local newResult = Position2 - Unit * 1.2 + Vector3.new(0, 0.5, 0)
                    standMorph.PrimaryPart.CFrame = CFrame.lookAt(newResult, Position2)
                    standMorph.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
                    standMorph.PrimaryPart.AssemblyAngularVelocity = Vector3.zero
                    local focusCam = Parent:FindFirstChild("FocusCam")
                    if not focusCam then
                      focusCam = Instance.new("ObjectValue")
                      focusCam.Name = "FocusCam"
                      focusCam.Parent = Parent
                    end
                    if focusCam.Value ~= standMorph.PrimaryPart then focusCam.Value = standMorph.PrimaryPart end
                  end
                  rootPart10.CFrame = CFrame.new(Position - Vector3.new(0, 11.5, 0)) * CFrame.Angles(math.rad(90), 0, 0)
                  rootPart10.AssemblyLinearVelocity = Vector3.zero
                  rootPart10.AssemblyAngularVelocity = Vector3.zero
                else
                  rootPart10.CFrame = CFrame.new(rootPart12.Position - Vector3.new(0, entry30, 0)) * CFrame.Angles(math.rad(90), 0, 0)
                  rootPart10.AssemblyLinearVelocity = Vector3.zero
                  rootPart10.AssemblyAngularVelocity = Vector3.zero
                end
              end
            end
          end)
          local enabled42, count28, connectResult15 = false, 0, nil
          Value2 = LocalPlayer.PlayerStats.Quest.Value
          Value3 = LocalPlayer.PlayerStats.QuestProgress.Value
          pcall(function()
            connectResult15 = LocalPlayer.PlayerGui.HUD.Main.DropMoney.Money.ChildAdded:Connect(function(b)
              local number = tonumber(string.match(b.Name, "%d+"))
              if number then enabled42 = true end
            end)
          end)
          count20 = tick() + 35
          timestamp7 = tick()
          humanoid9 = entry24:FindFirstChildOfClass("Humanoid")
          health = entry24:FindFirstChild("Health")
          count22, entry34, count23 = 0, timestamp7, humanoid9 and humanoid9.Health or health and health:IsA("ValueBase") and health.Value or 9999
          while callback58() and tick() < count20 do
            timestamp5 = tick()
            humanoid10 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if not humanoid10 then break end
            if humanoid10.Health <= 0 then break end
            if not entry24 or not entry24.Parent or not entry24:FindFirstChild("HumanoidRootPart") then
              enabled42 = true
              break
            end
            if enabled42 then break end
            Value5 = LocalPlayer.PlayerStats.Quest.Value
            if Value5 == Value2 and Value3 < LocalPlayer.PlayerStats.QuestProgress.Value then
              enabled42 = true
              break
            end
            humanoid11 = entry24:FindFirstChildOfClass("Humanoid")
            health2 = entry24:FindFirstChild("Health")
            count24 = humanoid11 and humanoid11.Health or health2 and health2:IsA("ValueBase") and health2.Value or 0
            local count29, timestamp8, entry36
            if count24 < count23 then
              entry36 = count24
              timestamp8 = tick()
              count29 = tick() + 25
            else
              count29, timestamp8, entry36 = count20, entry34, count23
            end
            if tick() - timestamp8 > 12 then break end
            if (humanoid11 and humanoid11.Health <= 0) or (health2 and health2:IsA("ValueBase") and health2.Value <= 0 and humanoid11 and humanoid11.Health <= 0.1) then
              count22 = count22 + 1
              if count22 > 4 then
                enabled42 = true
                break
              end
            else
              entry23(entry24)
              task.wait()
              count22, count20, entry34, count23 = 0, count29, timestamp8, entry36
              continue
            end
          end
          if not enabled42 and entry24 then entries19[entry24] = tick() + 20 end
          if connectResult15 then connectResult15:Disconnect() end
          if Heartbeat then Heartbeat:Disconnect() end
          if connectResult13 then
            connectResult13:Disconnect()
            connectResult13 = nil
          end
          if connectResult14 then
            pcall(function() connectResult14:Disconnect() end)
            connectResult14 = nil
          end
          if _G.YBAItemFarm and _G.YBAItemFarm.restoreCollisions then _G.YBAItemFarm.restoreCollisions() end
          if enabled42 then pcall(function() if entry24 and entry24.Parent then entry24:Destroy() end end) end
          pcall(function()
            local focusCam = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("FocusCam")
            if focusCam then focusCam:Destroy() end
          end)
          if enabled41 then attachStandToTarget2(true) end
          pcall(function()
            local Character = LocalPlayer.Character
            local rootPart10 = Character and Character:FindFirstChild("HumanoidRootPart")
            if rootPart10 then
              local head = entry24 and (entry24:FindFirstChild("HumanoidRootPart") or entry24.PrimaryPart or entry24:FindFirstChild("Torso") or entry24:FindFirstChild("Head"))
              local position5 = diavoloText and Position or head and head.Position
              if position5 then rootPart10.CFrame = CFrame.new(position5 + Vector3.new(0, 3.5, 0)) else rootPart10.CFrame = rootPart10.CFrame + Vector3.new(0, 25, 0) end
              rootPart10.AssemblyLinearVelocity = Vector3.zero
              rootPart10.AssemblyAngularVelocity = Vector3.zero
            end
          end)
          return
        end
        task.wait(0.5)
        return
      end
      callback175("No " .. a .. " found nearby, waiting...")
      task.wait(1)
    end
    local function callback135()
      pcall(function()
        local settings7 = { [1] = "I", [2] = "II", [3] = "III", [4] = "IV", [5] = "V" }
        if LocalPlayer.PlayerStats.Stand.Value ~= "None" then
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Stand Summon", SkillTreeType = "Stand" })
          local ipairsResult, entry20, entry23 = ipairs(settings7)
          for k, v in ipairsResult, entry20, entry23 do
            local RemoteFunction3 = RemoteFunction
            RemoteFunction3.InvokeServer(RemoteFunction3, "LearnSkill", { Skill = "Destructive Power " .. v, SkillTreeType = "Stand" })
          end
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Stand Barrage", SkillTreeType = "Stand" })
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Stand Barrage Finisher", SkillTreeType = "Stand" })
        end
        local ipairsResult2, entry27, entry28
        ipairsResult2, entry27, entry28 = ipairs(settings7)
        for k2, v2 in ipairsResult2, entry27, entry28 do
          local RemoteFunction4 = RemoteFunction
          RemoteFunction4.InvokeServer(RemoteFunction4, "LearnSkill", { Skill = "Agility " .. v2, SkillTreeType = "Character" })
          local RemoteFunction5 = RemoteFunction
          RemoteFunction5.InvokeServer(RemoteFunction5, "LearnSkill", { Skill = "Vitality " .. v2, SkillTreeType = "Character" })
          local RemoteFunction6 = RemoteFunction
          RemoteFunction6.InvokeServer(RemoteFunction6, "LearnSkill", { Skill = "Sturdiness " .. v2, SkillTreeType = "Character" })
        end
        RemoteFunction:InvokeServer("LearnSkill", { Skill = "Worthiness", SkillTreeType = "Character" })
        ipairsResult2 = LocalPlayer.PlayerStats.Spec.Value
        ipairsResult2 = ipairsResult2:lower()
        entry27 = ipairsResult2
        ipairsResult2 = ipairsResult2.find
        ipairsResult2 = ipairsResult2(entry27, "hamon") ~= nil or LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Hamon") ~= nil
        if ipairsResult2 then
          for k3, v3 in ipairs(settings7) do
            local RemoteFunction7 = RemoteFunction
            RemoteFunction7.InvokeServer(RemoteFunction7, "LearnSkill", { Skill = "Hamon Punch " .. v3, SkillTreeType = "Spec" })
            local RemoteFunction8 = RemoteFunction
            RemoteFunction8.InvokeServer(RemoteFunction8, "LearnSkill", { Skill = "Lung Capacity " .. v3, SkillTreeType = "Spec" })
            local RemoteFunction9 = RemoteFunction
            RemoteFunction9.InvokeServer(RemoteFunction9, "LearnSkill", { Skill = "Breathing Technique " .. v3, SkillTreeType = "Spec" })
            local RemoteFunction10 = RemoteFunction
            RemoteFunction10.InvokeServer(RemoteFunction10, "LearnSkill", { Skill = "Hamon Charge " .. v3, SkillTreeType = "Spec" })
          end
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Hamon Punch V", SkillTreeType = "Spec" })
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Lung Capacity V", SkillTreeType = "Spec" })
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Breathing Technique V", SkillTreeType = "Spec" })
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Zoom Punch", SkillTreeType = "Spec" })
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Scarlet Overdrive", SkillTreeType = "Spec" })
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Sunlight Yellow Overdrive", SkillTreeType = "Spec" })
          RemoteFunction:InvokeServer("LearnSkill", { Skill = "Hamon Defense", SkillTreeType = "Spec" })
        end
      end)
    end
    local enabled43 = false
    local function callback144()
      local PlayerStats = LocalPlayer.PlayerStats
      if PlayerStats.Quest.Value == "Take down 3 vampires" and PlayerStats.QuestProgress.Value < 3 then return true end
      if PlayerStats.Quest.Value == "Take down 3 vampires" and PlayerStats.QuestProgress.Value >= 3 then
        callback175("Handing in completed Vampire quest...")
        callback109("William Zeppeli [Lvl. 25+]", 1)
        local timestamp7 = tick()
        while tick() - timestamp7 < 3 do
          if not (callback58() and PlayerStats.Quest.Value == "Take down 3 vampires") then break end
          if PlayerStats.QuestProgress.Value < 3 then break end
          task.wait(0.2)
        end
        task.wait(0.3)
      end
      if PlayerStats.Quest.Value ~= "Take down 3 vampires" or PlayerStats.QuestProgress.Value >= 3 then
        callback175("Taking Vampire quest from Zeppeli...")
        callback109("William Zeppeli [Lvl. 25+]", 1, "help out")
        local timestamp8 = tick()
        while tick() - timestamp8 < 3 and callback58() do
          if PlayerStats.Quest.Value == "Take down 3 vampires" and PlayerStats.QuestProgress.Value < 3 then
            callback175("Vampire quest ready (0/3)!")
            return true
          end
          task.wait(0.2)
        end
      end
      return PlayerStats.Quest.Value == "Take down 3 vampires" and PlayerStats.QuestProgress.Value < 3
    end
    local function callback147()
      callback175("Farming vampires until max level...")
      sourceContext.notify("Auto Prestige", "Farming vampires until max level...")
      while callback58() and LocalPlayer.PlayerStats.Level.Value < 50 do
        local Value = LocalPlayer.PlayerStats.Level.Value
        local Value2 = LocalPlayer.PlayerStats.Prestige.Value
        local count20 = Value2 == 1 and 40 or Value2 == 2 and 45 or Value2 >= 3 and 50 or 35
        if count20 <= Value then
          if LocalPlayer.PlayerStats.Money.Value < 10000 then
            callback175("Max level reached. Collecting $10,000 for prestige...")
            callback124(10000)
          end
          if LocalPlayer.PlayerStats.Money.Value >= 10000 then
            callback175("Reached max level and $10,000 for P" .. Value2)
            break
          end
          callback175("Farming vampires for $10,000... ($" .. LocalPlayer.PlayerStats.Money.Value .. ")")
        end
        callback144()
        local Value3
        getgenv().HamonCharge = 10
        callback129("Vampire", 15)
        task.wait(0.05)
        Value3 = LocalPlayer.PlayerStats.QuestProgress.Value
        if Value3 >= 3 or LocalPlayer.PlayerStats.Quest.Value ~= "Take down 3 vampires" then callback144() end
      end
      callback175("Vampire farming complete! Level: " .. LocalPlayer.PlayerStats.Level.Value)
      return true
    end
    local function callback148()
      local Value = LocalPlayer.PlayerStats.Prestige.Value
      local Value2 = LocalPlayer.PlayerStats.Level.Value
      local count20 = Value == 0 and Value2 >= 35 or Value == 1 and Value2 >= 40 or Value == 2 and Value2 >= 45
      if count20 then
        if LocalPlayer.PlayerStats.Money.Value < 10000 then
          callback175("Collecting $10,000 for Prestige...")
          callback124(10000)
        end
        callback175("Prestiging! P" .. Value .. " -> P" .. Value + 1)
        sourceContext.notify("Auto Prestige", "Prestiging to P" .. Value + 1 .. "...")
        callback109("Prestige Master Rin", 1)
        local timestamp7 = tick()
        while tick() - timestamp7 < 10 and callback58() do
          timestamp5 = tick()
          if Value < LocalPlayer.PlayerStats.Prestige.Value then
            local Value3 = LocalPlayer.PlayerStats.Prestige.Value
            local Value4 = LocalPlayer.PlayerStats.Level.Value
            callback175("Prestiged successfully!")
            sourceContext.notify("Auto Prestige", "Prestiged to Prestige " .. Value3 .. "!")
            if sourceContext.sendPrestigeWebhook then sourceContext.sendPrestigeWebhook(Value3, Value4, false) end
            enabled43 = false
            return true
          end
          task.wait(0.2)
        end
        local Value7 = LocalPlayer.PlayerStats.Prestige.Value
        Value7 = Value < Value7
        if Value7 then
          local Value5 = LocalPlayer.PlayerStats.Prestige.Value
          local Value6 = LocalPlayer.PlayerStats.Level.Value
          if sourceContext.sendPrestigeWebhook then sourceContext.sendPrestigeWebhook(Value5, Value6, false) end
          enabled43 = false
        end
        return Value7
      end
      return false
    end
    local function callback151()
      callback175("Resetting character...")
      sourceContext.notify("Auto Prestige", "Resetting character...")
      local humanoid9 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
      if humanoid9 then humanoid9.Health = 0 end
      LocalPlayer.CharacterAdded:Wait()
      task.wait(3)
      Character = LocalPlayer.Character
      if Character then
        RemoteFunction = Character:WaitForChild("RemoteFunction", 5)
        RemoteEvent = Character:WaitForChild("RemoteEvent", 5)
        PrimaryPart = Character:WaitForChild("PrimaryPart", 5)
      end
      for k, v in pairs(Character:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide == true then v.CanCollide = false end end
      if not LocalPlayer.PlayerGui:FindFirstChild("HUD") then
        local hUD = game:GetService("ReplicatedStorage").Objects.HUD
        hUD.Clone(hUD).Parent = LocalPlayer.PlayerGui
      end
      return true
    end
    local function callback153(a)
      if a <= LocalPlayer.PlayerStats.Level.Value then return end
      callback175("Current Level " .. LocalPlayer.PlayerStats.Level.Value .. " < required Level " .. a .. " — leveling up...")
      local autoPrestigeText, a5 = "Auto Prestige", a
      sourceContext.notify("Auto Prestige", "Leveling up to Level " .. a .. "...")
      while callback58() and LocalPlayer.PlayerStats.Level.Value < a do
        local Value2 = LocalPlayer.PlayerStats.Level.Value
        if Value2 < 5 then
          autoPrestigeText = "Security Guard"
        elseif Value2 < 10 then
          autoPrestigeText = "Thug"
        elseif Value2 < 20 then
          autoPrestigeText = "Corrupt Police"
        elseif Value2 < 25 then
          autoPrestigeText = "Zombie Henchman"
        else
          autoPrestigeText = "Vampire"
          callback144()
        end
        callback129(autoPrestigeText, 15)
        task.wait(0.05)
        if autoPrestigeText == "Vampire" and (LocalPlayer.PlayerStats.QuestProgress.Value >= 3 or LocalPlayer.PlayerStats.Quest.Value ~= "Take down 3 vampires") then
          callback144()
        end
      end
    end
    local function callback154()
      timestamp5 = tick()
      if callback58() then
        if LocalPlayer.PlayerStats.Level.Value == 50 and LocalPlayer.PlayerStats.Prestige.Value >= 3 then
          local startTime3 = settings36 and settings36.startTime
          local unknownText = startTime3 and callFormat2(tick() - startTime3) or "Unknown"
          if sourceContext.sendPrestigeWebhook then sourceContext.sendPrestigeWebhook(3, 50, true, unknownText) else callback174("completed") end
          callback175("MAXED! P3 L50")
          sourceContext.notify("Auto Prestige", "MAX PRESTIGE 3 LEVEL 50!")
          enabled36 = false
          pcall(function() delfile("AutoPres3_" .. LocalPlayer.Name .. ".txt") end)
          return false
        end
        if LocalPlayer.PlayerStats.Stand.Value == "None" and LocalPlayer.PlayerStats.Level.Value >= 2 then
          callback96()
          task.wait(1)
        end
        if LocalPlayer.PlayerStats.Stand.Value ~= "None" and Character:FindFirstChild("RemoteFunction") and (not Character:FindFirstChild("SummonedStand") or not Character.SummonedStand.Value) then
          RemoteFunction:InvokeServer("ToggleStand", "Toggle")
          task.wait(0.5)
        end
        callback135()
        local autoRequiem = getgenv()
        autoRequiem = autoRequiem.autoRequiem
        if autoRequiem and LocalPlayer.PlayerStats.Level.Value >= 25 and LocalPlayer.PlayerStats.Prestige.Value >= 1 and LocalPlayer.Backpack:FindFirstChild("Requiem Arrow") and (LocalPlayer.PlayerStats.Stand.Value == "King Crimson" or LocalPlayer.PlayerStats.Stand.Value == "Star Platinum") then
          callback77(LocalPlayer.Character.HumanoidRootPart, standFarmPosition)
          local Value3 = LocalPlayer.PlayerStats.Stand.Value
          callback71("Requiem Arrow", "V")
          repeat
            task.wait()
            local Value6 = LocalPlayer.PlayerStats.Stand.Value
          until Value6 ~= Value3 or not callback58()
          task.wait(1)
        end
        local enabled44 = false
        pcall(function()
          local entry20 = LocalPlayer.PlayerStats and LocalPlayer.PlayerStats:FindFirstChild("Spec") and LocalPlayer.PlayerStats.Spec.Value
          local hamon = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Hamon") ~= nil
          if entry20 and entry20 ~= "None" and entry20 ~= "" or hamon then enabled44 = true end
        end)
        if not enabled44 and getgenv().autoHamon and LocalPlayer.PlayerStats.Level.Value >= 25 then
          if LocalPlayer.PlayerStats.Money.Value < 10000 then
            callback175("Collecting money for Hamon...")
            callback124(10000)
          end
          if LocalPlayer.PlayerStats.Money.Value >= 10000 then
            local backpack4 = LocalPlayer.Backpack
            local entry20 = backpack4
            backpack4 = backpack4.FindFirstChild
            if not backpack4(entry20, "Zeppeli's Hat") then entry26("Zeppeli's Hat", 1) end
            backpack4 = LocalPlayer.Backpack
            entry20 = backpack4
            backpack4 = backpack4.FindFirstChild
            if backpack4(entry20, "Zeppeli's Hat") then
              callback175("Buying Hamon...")
              local humanoid9 = LocalPlayer.Character.Humanoid
              humanoid9.EquipTool(humanoid9, LocalPlayer.Backpack:FindFirstChild("Zeppeli's Hat"))
              callback109("Lisa Lisa", 1)
              task.wait(1)
            end
          end
        end
        local Value = LocalPlayer.PlayerStats.Quest.Value
        local settings7 = {
          ["Help Giorno by Defeating Security Guards"] = function()
            callback175("Killing Security Guards...")
            while callback58() and LocalPlayer.PlayerStats.Quest.Value == "Help Giorno by Defeating Security Guards" do
              callback129("Security Guard", 15)
              task.wait(0.2)
              if LocalPlayer.PlayerStats.QuestProgress.Value >= 5 then break end
            end
            task.wait(0.3)
            callback109("Storyline #1 (Giorno)", 1)
            task.wait(0.5)
            callback109("Storyline #2 (Koichi)", 1)
            task.wait(0.5)
            callback109("Storyline #3 (Giorno)", 1)
            task.wait(0.5)
            return true
          end,
          ["Return Koichi's Suitcase"] = function()
            callback175("Returning Koichi's Suitcase...")
            callback109("Storyline #2 (Koichi)", 1)
            task.wait(0.5)
            callback109("Storyline #3 (Giorno)", 1)
            task.wait(0.5)
            return true
          end,
          ["Defeat Leaky Eye Luca"] = function()
            callback175("Killing Leaky Eye Luca...")
            while callback58() and LocalPlayer.PlayerStats.Quest.Value == "Defeat Leaky Eye Luca" do
              callback129("Leaky Eye Luca", 15)
              task.wait(0.2)
              if LocalPlayer.PlayerStats.QuestProgress.Value >= 1 then break end
            end
            task.wait(0.3)
            callback109("Storyline #3 (Giorno)", 1)
            task.wait(0.5)
            callback109("Storyline #4 (Bucciarati)", 1)
            task.wait(0.5)
            return true
          end,
          ["Defeat Bucciarati"] = function()
            callback175("Killing Bucciarati...")
            while callback58() and LocalPlayer.PlayerStats.Quest.Value == "Defeat Bucciarati" do
              callback129("Bucciarati", 15)
              task.wait(0.2)
              if LocalPlayer.PlayerStats.QuestProgress.Value >= 1 then break end
            end
            task.wait(0.3)
            callback109("Storyline #4 (Bucciarati)", 1)
            task.wait(0.5)
            callback109("Storyline #5 (Giorno)", 1)
            task.wait(0.5)
            return true
          end,
          ["Give Giorno The Lighter"] = function()
            callback175("Giving Giorno the Lighter...")
            callback109("Storyline #5 (Giorno)", 1)
            task.wait(0.5)
            callback109("Storyline #6 (Fugo)", 1)
            task.wait(0.5)
            return true
          end,
          ["Meet Fugo"] = function()
            callback175("Meeting Fugo...")
            callback109("Storyline #6 (Fugo)", 1)
            task.wait(0.5)
            callback109("Storyline #7 (Mista)", 1)
            task.wait(0.5)
            return true
          end,
          ["Meet Mista"] = function()
            callback175("Meeting Mista...")
            callback109("Storyline #7 (Mista)", 1)
            task.wait(0.5)
            callback109("Storyline #8 (Narancia)", 1)
            task.wait(0.5)
            return true
          end,
          ["Meet Narancia"] = function()
            callback175("Meeting Narancia...")
            callback109("Storyline #8 (Narancia)", 1)
            task.wait(0.5)
            callback109("Storyline #9 (Abbacchio)", 1)
            task.wait(0.5)
            return true
          end,
          ["Meet Abbacchio"] = function()
            callback175("Meeting Abbacchio...")
            callback109("Storyline #9 (Abbacchio)", 1)
            task.wait(0.5)
            callback109("Storyline #10 (Bucciarati)", 1)
            task.wait(0.5)
            return true
          end,
          ["Meet Bucciarati"] = function()
            callback175("Meeting Bucciarati...")
            callback109("Storyline #10 (Bucciarati)", 1)
            task.wait(0.5)
            return true
          end,
          ["Collect $5,000 To Cover For Popo's Real Fortune"] = function()
            if LocalPlayer.PlayerStats.Money.Value < 5000 then
              callback175("Collecting $5000...")
              callback124(5000)
            end
            callback109("Storyline #11 (Trish)", 1)
            task.wait(0.5)
            return true
          end,
          ["Defeat Fugo And His Purple Haze"] = function()
            callback175("Killing Fugo...")
            while callback58() and LocalPlayer.PlayerStats.Quest.Value == "Defeat Fugo And His Purple Haze" do
              callback129("Fugo", 15)
              task.wait(0.2)
              if LocalPlayer.PlayerStats.QuestProgress.Value >= 1 then break end
            end
            task.wait(0.3)
            callback109("Storyline #11 (Trish)", 1)
            task.wait(0.5)
            return true
          end,
          ["Defeat Pesci"] = function()
            callback175("Killing Pesci...")
            while callback58() and LocalPlayer.PlayerStats.Quest.Value == "Defeat Pesci" do
              callback129("Pesci", 15)
              task.wait(0.2)
              if LocalPlayer.PlayerStats.QuestProgress.Value >= 1 then break end
            end
            task.wait(0.3)
            callback109("Storyline #12 (Mista)", 1, "on it")
            task.wait(0.5)
            return true
          end,
          ["Defeat Ghiaccio"] = function()
            callback175("Killing Ghiaccio...")
            while callback58() and LocalPlayer.PlayerStats.Quest.Value == "Defeat Ghiaccio" do
              callback129("Ghiaccio", 15)
              task.wait(0.2)
              if LocalPlayer.PlayerStats.QuestProgress.Value >= 1 then break end
            end
            task.wait(0.3)
            callback109("Storyline #12 (Mista)", 1)
            task.wait(0.3)
            callback109("Storyline #13 (Bucciarati)", 1)
            task.wait(0.3)
            callback109("Storyline #14 (Giorno)", 1)
            task.wait(0.3)
            return true
          end,
          ["Defeat Diavolo"] = function()
            callback175("Killing Diavolo (Final Boss)...")
            while callback58() and LocalPlayer.PlayerStats.Quest.Value == "Defeat Diavolo" do
              callback129("Diavolo", 15)
              task.wait(0.2)
              if LocalPlayer.PlayerStats.QuestProgress.Value >= 1 then break end
            end
            task.wait(0.3)
            callback109("Storyline #14 (Giorno)", 1)
            task.wait(2)
            enabled43 = true
            return true
          end,
        }
        if Value ~= "" and settings7[Value] then
          local entry23 = settings7[Value]()
          if Value == "Defeat Diavolo" and enabled43 then
            callback175("Diavolo defeated! Storyline complete.")
            sourceContext.notify("Auto Prestige", "Storyline complete! Farming vampires...")
            callback147()
            if callback148() then
              task.wait(3)
              enabled37 = false
              timestamp4 = tick()
              callback175("Restarting storyline loop...")
              sourceContext.notify("Auto Prestige", "Restarting storyline for next prestige!")
              return callback154()
            end
            if LocalPlayer.PlayerStats.Level.Value == 50 and LocalPlayer.PlayerStats.Prestige.Value >= 3 then
              callback174("completed")
              callback175("MAXED! P" .. LocalPlayer.PlayerStats.Prestige.Value .. " L" .. LocalPlayer.PlayerStats.Level.Value)
              sourceContext.notify("Auto Prestige", "MAX PRESTIGE 3 LEVEL 50!")
              enabled36 = false
              pcall(function() delfile("AutoPres3_" .. LocalPlayer.Name .. ".txt") end)
              return false
            end
            return true
          end
          task.wait(0.5)
          return callback154()
        end
        local Value2 = LocalPlayer.PlayerStats.Level.Value
        if not enabled43 and Value2 < 25 then
          callback175("Advancing storyline sequentially (Lvl " .. Value2 .. ", Quest: " .. tostring(Value) .. ")...")
          local settings12 = {
            [1] = "Storyline #1 (Giorno)", [2] = "Storyline #2 (Koichi)", [3] = "Storyline #3 (Giorno)",
            [4] = "Storyline #4 (Bucciarati)", [5] = "Storyline #5 (Giorno)", [6] = "Storyline #6 (Fugo)",
            [7] = "Storyline #7 (Mista)", [8] = "Storyline #8 (Narancia)", [9] = "Storyline #9 (Abbacchio)",
            [10] = "Storyline #10 (Bucciarati)", [11] = "Storyline #11 (Trish)", [12] = "Storyline #12 (Mista)",
            [13] = "Storyline #13 (Bucciarati)", [14] = "Storyline #14 (Giorno)",
          }
          for k, v in ipairs(settings12) do
            if not callback58() then break end
            callback109(v, 1)
            task.wait(0.3)
            if LocalPlayer.PlayerStats.Quest.Value ~= "" and settings7[LocalPlayer.PlayerStats.Quest.Value] then return callback154() end
          end
        end
        enabled43 = Value2 >= 25
        callback147()
        if callback148() then
          task.wait(3)
          enabled37 = false
          timestamp4 = tick()
          return callback154()
        end
        if LocalPlayer.PlayerStats.Level.Value == 50 then
          if LocalPlayer.PlayerStats.Prestige.Value >= 3 then
            callback174("completed")
            callback175("MAXED! P3 L50")
            sourceContext.notify("Auto Prestige", "MAX PRESTIGE 3 LEVEL 50!")
            enabled36 = false
            pcall(function() delfile("AutoPres3_" .. LocalPlayer.Name .. ".txt") end)
            return false
          end
          if callback148() then
            task.wait(3)
            enabled37 = false
            timestamp4 = tick()
            return callback154()
          end
        end
        task.wait(1)
        return callback154()
      end
      return false
    end
    local function callback155()
      timestamp5 = tick()
      callback96()
      task.wait(1)
      local Value = LocalPlayer.PlayerStats.Prestige.Value
      local Value2 = LocalPlayer.PlayerStats.Level.Value
      local count20 = Value == 0 and 35 or Value == 1 and 40 or Value == 2 and 45 or 50
      if count20 <= Value2 then
        callback147()
        if callback148() then
          task.wait(3)
          return callback154()
        end
      end
      callback175("Starting storyline loop...")
      sourceContext.notify("Auto Prestige", "Starting storyline loop...")
      return callback154()
    end
    local connectResult13 = nil
    connectResult13 = game.Workspace.Living.ChildAdded:Connect(function(a)
      if a.Name == LocalPlayer.Name then
        if not callback58() then
          if connectResult13 then connectResult13:Disconnect() end
          return
        end
        if LocalPlayer.PlayerStats.Level.Value ~= 50 then
          task.wait(2)
          Character = LocalPlayer.Character
          if Character then
            RemoteFunction = Character:FindFirstChild("RemoteFunction")
            RemoteEvent = Character:FindFirstChild("RemoteEvent")
            PrimaryPart = Character.PrimaryPart
          end
          for k, v in pairs(Character:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide == true then v.CanCollide = false end end
          if enabled37 and callback58() then
            if tick() - timestamp5 > 30 then callback155() end
          elseif callback58() then callback96() end
        end
      end
    end)
    local connectResult16 = nil
    connectResult16 = LocalPlayer.PlayerStats.Level:GetPropertyChangedSignal("Value"):Connect(function()
      if callback58() then
        callback175("Level up! P" .. LocalPlayer.PlayerStats.Prestige.Value .. " L" .. LocalPlayer.PlayerStats.Level.Value)
        if LocalPlayer.PlayerStats.Level.Value >= 3 and LocalPlayer.PlayerStats.Stand.Value == "None" then
          task.spawn(function()
            task.wait(0.5)
            callback96()
          end)
        end
        return
      end
      if connectResult16 then connectResult16:Disconnect() end
    end)
    local connectResult17 = nil
    connectResult17 = LocalPlayer.CharacterAdded:Connect(function(a)
      if callback58() then
        Character = a
        RemoteFunction = a.WaitForChild(a, "RemoteFunction", 5) or a:FindFirstChild("RemoteFunction")
        RemoteEvent = a.WaitForChild(a, "RemoteEvent", 5) or a:FindFirstChild("RemoteEvent")
        PrimaryPart = a.WaitForChild(a, "PrimaryPart", 5) or a.PrimaryPart
        task.wait(1)
        for k, v in pairs(a:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide == true then v.CanCollide = false end end
        return
      end
      if connectResult17 then connectResult17:Disconnect() end
    end)
    local connectResult18 = nil
    local function callback156()
      if connectResult18 then connectResult18:Disconnect() end
      local Character = LocalPlayer.Character
      if not Character then return end
      local humanoid9 = Character:FindFirstChildOfClass("Humanoid")
      if not humanoid9 then return end
      connectResult18 = humanoid9.AnimationPlayed:Connect(function(a)
        if not callback58() then return end
        local animationId = a.Animation and a.Animation.AnimationId
        if not animationId then return end
        if animationId == "rbxassetid://5157052272" or animationId:find("5157052272") then
          callback175("Storyline completed animation detected - resetting to skip")
          sourceContext.notify("Auto Prestige", "Skipping storyline animation...")
          task.wait(0.1)
          callback151()
          task.wait(1)
          callback156()
        end
      end)
    end
    callback156()
    LocalPlayer.CharacterAdded:Connect(function(a)
      if not callback58() then return end
      task.wait(1)
      local humanoid9 = a:FindFirstChildOfClass("Humanoid")
      if humanoid9 then
        if connectResult18 then connectResult18:Disconnect() end
        connectResult18 = humanoid9.AnimationPlayed:Connect(function(b)
          if not callback58() then return end
          local animationId = b.Animation and b.Animation.AnimationId
          if not animationId then return end
          if animationId == "rbxassetid://5157052272" or animationId:find("5157052272") then
            callback175("Storyline completed animation detected - resetting to skip")
            sourceContext.notify("Auto Prestige", "Skipping storyline animation...")
            task.wait(0.1)
            callback151()
            task.wait(1)
            callback156()
          end
        end)
      end
    end)
    local pairsResult2, entry27, entry28 = pairs(Character:GetDescendants())
    for k2, v2 in pairsResult2, entry27, entry28 do if v2:IsA("BasePart") and v2.CanCollide == true then v2.CanCollide = false end end
    callback155()
  end
  function toggleAutoPrestige(a)
    if a then
      if not (sourceContext.callback14 and sourceContext.callback14()) then
        if getgenv()._YBA_prestigeWaiting then return end
        getgenv()._YBA_prestigeWaiting = true
        task.spawn(function()
          local timestamp7 = tick()
          while tick() - timestamp7 < 180 do
            task.wait(1)
            if sourceContext.callback14 and sourceContext.callback14() then break end
          end
          getgenv()._YBA_prestigeWaiting = false
          if sourceContext.callback14 and sourceContext.callback14() then toggleAutoPrestige(true) end
        end)
        return
      end
      getgenv()._YBA_prestigeWaiting = false
      count21 = count21 + 1
      sourceContext.callback34("AP", true)
      enabled36 = true
      settings36 = {
        enabled = true, startTime = tick(), startLevel = sourceContext.player.PlayerStats.Level.Value,
        startPrestige = sourceContext.player.PlayerStats.Prestige.Value, startDate = os.date("%Y-%m-%d %H:%M:%S"),
      }
      callback174("started")
      sourceContext.notify("Auto Prestige", "Auto Storyline & Prestige Started!")
      task.spawn(function()
        local pcallResult, entry20 = pcall(function() callback176() end)
        if not pcallResult then
          sourceContext.notify("Auto Prestige", "Error: " .. tostring(entry20))
          enabled36 = false
          sourceContext.callback34("AP", false)
        end
      end)
    else
      count21 = count21 + 1
      enabled36 = false
      sourceContext.callback34("AP", false)
      sourceContext.notify("Auto Prestige", "Auto Storyline & Prestige disabled.")
      if settings36.enabled then
        callback174("stopped")
        settings36.enabled = false
      end
    end
  end
  if getgenv then getgenv().RAILhub_ToggleAutoPrestige = toggleAutoPrestige end
  _G.toggleAutoPrestige = toggleAutoPrestige
  if sourceContext.callback35("AP", false) and not sourceContext.enabled10 then
    sourceContext.callback2("autostart scheduled: auto prestige")
    task.delay(2.5, function() if toggleAutoPrestige and not enabled36 then toggleAutoPrestige(true) end end)
  end
end
do
  local Text6, enabled45, connectResult19 = "", false, nil
  local function callback177()
    local pcallResult, entry20 = pcall(function()
      local network = game:GetService("Stats"):FindFirstChild("Network")
      if network then
        local dataPing = network:FindFirstChild("Data Ping")
        if dataPing and type(dataPing.Value) == "number" then return dataPing.Value end
        local serverStatsItem = network:FindFirstChild("ServerStatsItem")
        if serverStatsItem then
          local dataPing2 = serverStatsItem:FindFirstChild("Data Ping")
          if dataPing2 and type(dataPing2.Value) == "number" then return dataPing2.Value end
        end
      end
      return nil
    end)
    if pcallResult and type(entry20) == "number" and entry20 > 0 then return entry20 end
    local timestamp7 = tick()
    game:GetService("RunService").Heartbeat:Wait()
    return math.clamp((tick() - timestamp7) * 1000, 20, 500)
  end
  local function callback178() return callback177() / 1000 end
  local settings37 = {
    ["Star Platinum"] = { [1] = "Stand Barrage", [2] = "Ora Kicks" },
    ["Star Platinum: The World"] = { [1] = "Stand Barrage", [2] = "Ora Kicks", [3] = "Skull Crusher" },
    ["The World"] = { [1] = "Stand Barrage", [2] = "Knives", [3] = "Kick Barrage" },
    ["The World: Alternate Universe"] = { [1] = "Stand Barrage", [2] = "Knives", [3] = "Gun", [4] = "Chop" },
    ["King Crimson"] = { [1] = "Stand Barrage", [2] = "Chop" },
    ["King Crimson Requiem"] = { [1] = "Stand Barrage", [2] = "Chop" },
    ["Gold Experience"] = { [1] = "Stand Barrage", [2] = "Create Life" },
    ["Gold Experience Requiem"] = { [1] = "Stand Barrage", [2] = "Scorpion Beam" },
    ["Silver Chariot"] = { [1] = "Stand Barrage", [2] = "Million Pricks", [3] = "Last Shot" },
    ["Chariot Requiem"] = { [1] = "Stand Barrage" },
    ["Crazy Diamond"] = { [1] = "Stand Barrage", [2] = "Bearing Shot", [3] = "Blood Slash" },
    ["Crazy Diamond Requiem"] = { [1] = "Stand Barrage" }, ["Diver Down"] = { [1] = "Stand Barrage" },
    ["Killer Queen"] = { [1] = "Stand Barrage" }, ["Killer Queen: Bites the Dust"] = { [1] = "Stand Barrage" },
    Whitesnake = { [1] = "Stand Barrage", [2] = "Acid Spit" },
    ["C-Moon"] = { [1] = "Stand Barrage", [2] = "Surface Inversion Punch" },
    ["Made in Heaven"] = { [1] = "Stand Barrage", [2] = "Speed Slice" }, D4C = { [1] = "Stand Barrage" },
    ["D4C: Love Train"] = { [1] = "Stand Barrage" }, ["Tusk Act 1"] = { [1] = "Nail Shots" },
    ["Tusk Act 2"] = { [1] = "Nail Shots", [2] = "Golden Rectangle Nail" },
    ["Tusk Act 3"] = { [1] = "Nail Shots", [2] = "Golden Rectangle Nail" },
    ["Tusk Act 4"] = { [1] = "Stand Barrage", [2] = "Golden Rectangle Nail" },
    ["Hermit Purple"] = { [1] = "Vine Slap", [2] = "Vine Trap" },
    ["Magician's Red"] = { [1] = "Stand Barrage", [2] = "Crossfire Hurricane" },
    ["Purple Haze"] = { [1] = "Stand Barrage", [2] = "Bulb Throw" },
    ["Sticky Fingers"] = { [1] = "Stand Barrage", [2] = "Extend Arm" },
    ["The Hand"] = { [1] = "Stand Barrage", [2] = "Erasure", [3] = "Erasure Pull" },
    ["Sex Pistols"] = { [1] = "Multi Shot", [2] = "Auto Reload" },
    Aerosmith = { [1] = "Stand Barrage", [2] = "Vola Barrage" },
    ["Beach Boy"] = { [1] = "Hook Slash", [2] = "Auto Rod" }, ["Mr. President"] = {},
    Anubis = { [1] = "Stand Barrage", [2] = "Cursed Blade" },
    ["Red Hot Chili Pepper"] = { [1] = "Stand Barrage", [2] = "Lightning Jab" },
    ["Soft & Wet"] = { [1] = "Stand Barrage", [2] = "Friction Plunder" },
    ["Soft & Wet: Go Beyond"] = { [1] = "Stand Barrage", [2] = "Go Beyond Bubble", [3] = "Explosive Spin" },
  }
  local settings38 = {
    None = true, ["Beach Boy"] = true, ["Sex Pistols"] = true, Anubis = true, ["Hermit Purple"] = true,
    ["Mr. President"] = true, ["White Album"] = true, ["Scary Monsters"] = true,
  }
  local function callback179()
    local entries22 = {}
    for k, v in ipairs(sourceContext.playersService:GetPlayers()) do
      if v ~= sourceContext.player then
        local Character = v.Character
        local humanoid9 = Character and Character:FindFirstChildOfClass("Humanoid")
        if Character and humanoid9 and humanoid9.Health > 0 then table.insert(entries22, v) end
      end
    end
    if #entries22 == 0 then return nil end
    return entries22[math.random(1, #entries22)]
  end
  local function callback180()
    if Text6 ~= "" then
      for k, v in ipairs(sourceContext.playersService:GetPlayers()) do if v ~= sourceContext.player and v.Name == Text6 then return v end end
      Text6 = ""
    end
    return callback179()
  end
  local function attachStandToTarget3(Enabled)
    local Character = sourceContext.player.Character
    local standMorph = Character and Character:FindFirstChild("StandMorph")
    local standAttach = standMorph and standMorph.PrimaryPart and standMorph.PrimaryPart:FindFirstChild("StandAttach")
    if standAttach then
      local alignPosition = standAttach:FindFirstChildOfClass("AlignPosition")
      local alignOrientation = standAttach:FindFirstChildOfClass("AlignOrientation")
      if alignPosition then alignPosition.Enabled = Enabled end
      if alignOrientation then alignOrientation.Enabled = Enabled end
    end
  end
  local function callback181()
    enabled45 = false
    if connectResult19 then
      connectResult19:Disconnect()
      connectResult19 = nil
    end
    pcall(function() sourceContext.parent.CurrentCamera.CameraType = Enum.CameraType.Custom end)
  end
  local function callback182(a)
    if connectResult19 then
      connectResult19:Disconnect()
      connectResult19 = nil
    end
    if not a then return end
    local CurrentCamera = sourceContext.parent.CurrentCamera
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    connectResult19 = sourceContext.runServiceService.RenderStepped:Connect(function()
      if enabled45 and a and a.Parent then
        local LookVector = a.CFrame.LookVector
        CurrentCamera.CFrame = CFrame.lookAt(a.Position + Vector3.new(0, 2.5, 0) - LookVector * 6, a.Position + LookVector * 3)
        return
      end
      pcall(function() CurrentCamera.CameraType = Enum.CameraType.Custom end)
      if connectResult19 then
        connectResult19:Disconnect()
        connectResult19 = nil
      end
    end)
  end
  local function callback183()
    local function callback65() return false end
    local Character = sourceContext.player.Character
    if not Character then return end
    local rootPart10 = Character:FindFirstChild("HumanoidRootPart")
    if not rootPart10 then return end
    local vu832 = Character:FindFirstChild("RemoteFunction") or vu83
    if not Character:FindFirstChild("RemoteEvent") then local _ = vu84 end
    if not vu832 then return end
    local noneText = sourceContext.player.PlayerStats and sourceContext.player.PlayerStats.Stand.Value or "None"
    local enabled46
    enabled46 = if noneText == "None" then false else not settings38[noneText]
    local cFrame2 = rootPart10.CFrame
    local cFrame3 = CFrame.new(rootPart10.Position) * CFrame.Angles(math.rad(90), 0, 0)
    local player3 = callback180()
    if enabled46 then
      local summonedStand = Character:FindFirstChild("SummonedStand")
      if summonedStand and not summonedStand.Value then
        pcall(function() vu832:InvokeServer("ToggleStand", "Toggle") end)
        task.wait(0.3)
      end
      attachStandToTarget3(false)
    end
    local primaryPart = nil
    local Heartbeat = sourceContext.runServiceService.Heartbeat
    Heartbeat = Heartbeat:Connect(function()
      if not callback65() then return end
      local humanoidRootPart = player3 and player3.Character and player3.Character:FindFirstChild("HumanoidRootPart")
      if humanoidRootPart then
        cFrame3 = CFrame.new(humanoidRootPart.Position.X, humanoidRootPart.Position.Y - 20, humanoidRootPart.Position.Z) * CFrame.Angles(math.rad(90), 0, 0)
      end
      rootPart10.CFrame = cFrame3
      rootPart10.AssemblyLinearVelocity = Vector3.zero
      rootPart10.AssemblyAngularVelocity = Vector3.zero
      if not enabled46 then return end
      local player4 = player3
      if not player4 then return end
      local Character2 = player4.Character
      local rootPart12 = Character2 and Character2:FindFirstChild("HumanoidRootPart")
      local humanoid9 = Character2 and Character2:FindFirstChildOfClass("Humanoid")
      if not (rootPart12 and humanoid9 and not (humanoid9.Health <= 0)) then return end
      local entry20 = callback178()
      local AssemblyLinearVelocity = rootPart12.AssemblyLinearVelocity
      local Position = nil
      Position = rootPart12.Position + AssemblyLinearVelocity * entry20 * 1.5
      local standMorph = Character:FindFirstChild("StandMorph")
      if standMorph and standMorph.PrimaryPart then
        attachStandToTarget3(false)
        local LookVector = rootPart12.CFrame.LookVector
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z)
        Unit = if Unit.Magnitude > 0.01 then Unit.Unit else Vector3.new(0, 0, -1)
        local newResult = Position - Unit * 1.2 + Vector3.new(0, 0.5, 0)
        standMorph.PrimaryPart.CFrame = CFrame.lookAt(newResult, Position)
        standMorph.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
        standMorph.PrimaryPart.AssemblyAngularVelocity = Vector3.zero
        if enabled45 and primaryPart ~= standMorph.PrimaryPart then
          primaryPart = standMorph.PrimaryPart
          callback182(standMorph.PrimaryPart)
        end
      end
    end)
    task.spawn(function()
      while callback65() do
        local player4 = player3
        if player4 then
          local Character = player4.Character
          local humanoid9 = Character and Character:FindFirstChildOfClass("Humanoid")
          if Character and humanoid9 and humanoid9.Health > 0 then
            for i = 1, 5 do task.spawn(function() pcall(function() vu832:InvokeServer("Attack", "m1") end) end) end
          elseif humanoid9 and humanoid9.Health <= 0 then
            if Text6 == "" then
              task.wait(0.5)
              local entry20 = callback179()
              if entry20 then
                player3 = entry20
                sourceContext.notify("PvP", "Target died → switching to: " .. entry20.Name)
              end
            else
              task.wait(1)
            end
          end
        else
          task.wait(0.3)
          player3 = callback180()
        end
        task.wait()
      end
    end)
    while true do
      local entry20 = callback65
      entry20 = callback65()
      if not entry20 then break end
      task.wait(0.1)
    end
    Heartbeat:Disconnect()
    if enabled46 then attachStandToTarget3(true) end
    callback181()
    pcall(function()
      local Character = sourceContext.player.Character
      local rootPart12 = Character and Character:FindFirstChild("HumanoidRootPart")
      if rootPart12 then
        rootPart12.CFrame = cFrame2
        rootPart12.AssemblyLinearVelocity = Vector3.zero
        rootPart12.AssemblyAngularVelocity = Vector3.zero
      end
    end)
  end
end
do
  local PvP, sectionText7 = sourceContext.entries12.PvP, "Section"
  local section10 = PvP.Section(PvP, { Side = "Left", Name = "Target Stand Player" })
  local section11 = PvP.Section(PvP, { Side = "Right", Name = "Options" })
  section10.Header(section10, { Text = "Target Stand Player", AutoLocalize = false })
  section11.Header(section11, { Text = "Combat Options", AutoLocalize = false })
  local function callback184()
    local entries22 = {}
    for k, v in ipairs(sourceContext.playersService:GetPlayers()) do if v ~= sourceContext.player then table.insert(entries22, v.Name) end end
    table.sort(entries22)
    return entries22
  end
  local Dropdown = section10.Dropdown
  local targetPlayerOptions = { Name = "Target Player", Options = callback184(), Multi = false, Default = "" }
  function targetPlayerOptions.Callback(a) pvpTargetName = a or "" end
  Dropdown = Dropdown(section10, targetPlayerOptions)
  local Dropdown2 = Dropdown
  function Dropdown()
    pcall(function() if Dropdown2 and Dropdown2.Refresh then Dropdown2:Refresh(callback184()) end end)
  end
  local playerAdded2 = sourceContext.playersService.PlayerAdded
  targetPlayerOptions = playerAdded2
  playerAdded2.Connect(playerAdded2, function()
    task.wait(0.5)
    Dropdown()
  end)
  playerAdded2 = sourceContext.playersService.PlayerRemoving
  targetPlayerOptions = playerAdded2
  playerAdded2.Connect(playerAdded2, function(a)
    task.wait(0.1)
    if pvpTargetName == a.Name then
      pvpTargetName = ""
      if pvpEnabled then
        pvpEnabled = false
        pvpSession = pvpSession + 1
        pvpDoStopSpectate()
      end
    end
    Dropdown()
  end)
  targetPlayerOptions = section10
  section10.Button(section10, {
    Name = "Refresh Player List",
    Callback = function()
      Dropdown()
      sourceContext.notify("PvP", "Player list refreshed!")
    end,
  })
  targetPlayerOptions = section10
  section10.Toggle(section10, {
    Name = "Target Stand Player", Default = false,
    Callback = function(a)
      pvpEnabled = a
      pvpSession = pvpSession + 1
      if a then
        if pvpTargetName == "" then
          sourceContext.notify("PvP", "Select a target player first!")
          pvpEnabled = false
          return
        end
        sourceContext.notify("PvP", "Attacking: " .. pvpTargetName)
        task.spawn(pvpKillLoop)
      else
        pvpDoStopSpectate()
        sourceContext.notify("PvP", "Target Stand Player stopped.")
      end
    end,
  })
  targetPlayerOptions = section11
  section11.Toggle(section11, {
    Name = "Spectate Stand", Default = false,
    Callback = function(a)
      pvpSpectate = a
      if not a then pvpDoStopSpectate() end
    end,
  })
  targetPlayerOptions = section11
  section11.Toggle(section11, {
    Name = "Movement Prediction", Default = true,
    Callback = function(a)
      pvpPredictEnabled = a
      sourceContext.notify("PvP", "Prediction: " .. (a and "ON" or "OFF"))
    end,
  })
  targetPlayerOptions = section11
  section11.Slider(section11, {
    Name = "Prediction Strength", Default = 1.5, Minimum = 0.1, Maximum = 10, Precision = 1, Prefix = "x",
    DisplayMethod = "Value", Callback = function(a) pvpPredictMult = a end,
  })
  targetPlayerOptions = section11
  section11.Button(section11, { Name = "Show Ping", Callback = function() sourceContext.notify("PvP", "Ping: " .. math.floor(getPingMs()) .. " ms") end })
end
sourceContext.Webhooks, sourceContext.sectionText8 = sourceContext.entries12.Webhooks, "Section"
sourceContext.section12 = sourceContext.Webhooks.Section(sourceContext.Webhooks, { Side = "Left", Name = "Webhook Configuration" })
sourceContext.section12.Header(sourceContext.section12, { Text = "Configuration", AutoLocalize = false })
sourceContext.section13 = sourceContext.section12.Dropdown
sourceContext.languageOptions = { Name = "Language / Язык" }
sourceContext.options = {}
sourceContext.callback185 = "English"
sourceContext.options[1] = "English"
sourceContext.options[2] = "Русский"
sourceContext.languageOptions.Options = sourceContext.options
sourceContext.options = false
sourceContext.languageOptions.Multi = false
sourceContext.callback186 = sourceContext.callback35("WH_Lang", "English")
sourceContext.languageOptions.Default = sourceContext.callback186
function sourceContext.callback186(a)
  sourceContext.settings3.Language = a or "English"
  sourceContext.callback34("WH_Lang", sourceContext.settings3.Language)
end
sourceContext.languageOptions.Callback = sourceContext.callback186
sourceContext.section13(sourceContext.section12, sourceContext.languageOptions)
sourceContext.languageOptions = "Input"
sourceContext.section13 = sourceContext.section12.Input
sourceContext.webhookURLOptions = { Name = "Webhook URL" }
sourceContext.callback186 = sourceContext.callback35
sourceContext.webhookURLOptions.Default = sourceContext.callback35("WH_Url", "") or sourceContext.callback35("APWH", "") or ""
sourceContext.callback186 = "https://discord.com/api/webhooks/..."
sourceContext.webhookURLOptions.Placeholder = "https://discord.com/api/webhooks/..."
function sourceContext.webhookURLOptions.Callback(a)
  local webhook2 = tostring(a or "")
  webhook2 = webhook2:gsub("^%s+", "")
  webhook2 = webhook2:gsub("%s+$", "")
  sourceContext.settings3.Url = webhook2
  getgenv().webhook = webhook2
  sourceContext.callback34("WH_Url", webhook2)
end
sourceContext.section13(sourceContext.section12, sourceContext.webhookURLOptions)
sourceContext.webhookURLOptions = "Input"
sourceContext.section13 = sourceContext.section12.Input
sourceContext.discordUserIDOptions = { Name = "Discord User ID" }
sourceContext.callback186 = sourceContext.callback35
sourceContext.discordUserIDOptions.Default = sourceContext.callback35("WH_UserId", "") or ""
sourceContext.discordUserIDOptions.Placeholder = "123456789012345678"
sourceContext.discordUserIDOptions.AcceptedCharacters = "Numeric"
function sourceContext.discordUserIDOptions.Callback(a)
  local UserId = tostring(a or "")
  UserId = UserId:gsub("%D", "")
  sourceContext.settings3.UserId = UserId
  sourceContext.callback34("WH_UserId", UserId)
end
sourceContext.section13(sourceContext.section12, sourceContext.discordUserIDOptions)
sourceContext.discordUserIDOptions = "Toggle"
sourceContext.section13 = sourceContext.section12.Toggle
sourceContext.enablePingOptions = { Name = "Enable Ping" }
sourceContext.callback186 = sourceContext.callback35
sourceContext.callback186 = sourceContext.callback35("WH_Enabled", true)
sourceContext.enablePingOptions.Default = sourceContext.callback186
function sourceContext.callback186(Enabled)
  sourceContext.settings3.Enabled = Enabled
  sourceContext.callback34("WH_Enabled", Enabled)
  sourceContext.callback34("WH_PingRare", Enabled)
end
sourceContext.enablePingOptions.Callback = sourceContext.callback186
sourceContext.section13(sourceContext.section12, sourceContext.enablePingOptions)
sourceContext.enablePingOptions = "Toggle"
sourceContext.section13 = sourceContext.section12.Toggle
sourceContext.hideUsernameSpoilersOptions = { Name = "Hide Username (Spoilers)" }
sourceContext.callback186 = sourceContext.callback35
sourceContext.callback186 = sourceContext.callback35("WH_HideUser", false)
sourceContext.hideUsernameSpoilersOptions.Default = sourceContext.callback186
function sourceContext.callback186(HideUser)
  sourceContext.settings3.HideUser = HideUser
  sourceContext.callback34("WH_HideUser", HideUser)
end
sourceContext.hideUsernameSpoilersOptions.Callback = sourceContext.callback186
sourceContext.section13(sourceContext.section12, sourceContext.hideUsernameSpoilersOptions)
sourceContext.hideUsernameSpoilersOptions = "Button"
sourceContext.section13 = sourceContext.section12.Button
sourceContext.testWebhookOptions = { Name = "Test Webhook" }
function sourceContext.callback186()
  if sourceContext.settings3.Url and sourceContext.settings3.Url ~= "" and sourceContext.settings3.Url:find("^https?://") then
    local sendTestWebhookResult = sourceContext.sendTestWebhook()
    if sendTestWebhookResult then sourceContext.notify("Webhooks", "Test webhook queued.") else sourceContext.notify("Webhooks", "Failed to queue test webhook.") end
    return
  end
  sourceContext.notify("Webhooks", "Please enter a valid Webhook URL first.")
end
sourceContext.testWebhookOptions.Callback = sourceContext.callback186
sourceContext.section13(sourceContext.section12, sourceContext.testWebhookOptions)
sourceContext.testWebhookOptions = "Section"
sourceContext.section13 = sourceContext.Webhooks.Section(sourceContext.Webhooks, { Side = "Right", Name = "Notification Filters" })
sourceContext.testWebhookOptions = sourceContext.section13
sourceContext.section13.Header(sourceContext.section13, { Text = "Filters", AutoLocalize = false })
sourceContext.testWebhookOptions = sourceContext.section13
sourceContext.toggle11 = sourceContext.section13.Toggle
sourceContext.entries68 = {}
sourceContext.callback186 = "Legendary Item Pickup"
sourceContext.entries68.Name = "Legendary Item Pickup"
sourceContext.callback185 = sourceContext.callback35
sourceContext.callback185 = sourceContext.callback35("WH_NotifyItem", true)
sourceContext.entries68.Default = sourceContext.callback185
function sourceContext.callback185(NotifyItem)
  sourceContext.settings3.NotifyItem = NotifyItem
  sourceContext.callback34("WH_NotifyItem", NotifyItem)
end
sourceContext.entries68.Callback = sourceContext.callback185
sourceContext.toggle11(sourceContext.section13, sourceContext.entries68)
sourceContext.entries68 = "Toggle"
sourceContext.testWebhookOptions = sourceContext.section13
sourceContext.toggle11 = sourceContext.section13.Toggle
sourceContext.luckyMPingOptions = { Name = "9 Lucky + 1M Ping" }
sourceContext.callback185 = sourceContext.callback35
sourceContext.callback185 = sourceContext.callback35("WH_NotifyMilestone", true)
sourceContext.luckyMPingOptions.Default = sourceContext.callback185
function sourceContext.callback185(NotifyMilestone)
  sourceContext.settings3.NotifyMilestone = NotifyMilestone
  sourceContext.callback34("WH_NotifyMilestone", NotifyMilestone)
end
sourceContext.luckyMPingOptions.Callback = sourceContext.callback185
sourceContext.toggle11(sourceContext.section13, sourceContext.luckyMPingOptions)
sourceContext.luckyMPingOptions = "Toggle"
sourceContext.testWebhookOptions = sourceContext.section13
sourceContext.toggle11 = sourceContext.section13.Toggle
sourceContext.shinyStandOptions = { Name = "Shiny Stand" }
sourceContext.callback185 = sourceContext.callback35
sourceContext.callback185 = sourceContext.callback35("WH_NotifyStand", true)
sourceContext.shinyStandOptions.Default = sourceContext.callback185
function sourceContext.callback185(NotifyStand)
  sourceContext.settings3.NotifyStand = NotifyStand
  sourceContext.callback34("WH_NotifyStand", NotifyStand)
end
sourceContext.shinyStandOptions.Callback = sourceContext.callback185
sourceContext.toggle11(sourceContext.section13, sourceContext.shinyStandOptions)
sourceContext.shinyStandOptions = "Toggle"
sourceContext.testWebhookOptions = sourceContext.section13
sourceContext.toggle11 = sourceContext.section13.Toggle
sourceContext.autoPrestigeProgressOptions = { Name = "Auto Prestige Progress" }
sourceContext.callback185 = sourceContext.callback35
sourceContext.callback185 = sourceContext.callback35("WH_NotifyPrestige", true)
sourceContext.autoPrestigeProgressOptions.Default = sourceContext.callback185
function sourceContext.callback185(NotifyPrestige)
  sourceContext.settings3.NotifyPrestige = NotifyPrestige
  sourceContext.callback34("WH_NotifyPrestige", NotifyPrestige)
end
sourceContext.autoPrestigeProgressOptions.Callback = sourceContext.callback185
sourceContext.toggle11(sourceContext.section13, sourceContext.autoPrestigeProgressOptions)
sourceContext.autoPrestigeProgressOptions = "Toggle"
sourceContext.testWebhookOptions = sourceContext.section13
sourceContext.toggle11 = sourceContext.section13.Toggle
sourceContext.staffDetectedOptions = { Name = "Staff Detected" }
sourceContext.callback185 = sourceContext.callback35
sourceContext.callback185 = sourceContext.callback35("WH_NotifyStaff", true)
sourceContext.staffDetectedOptions.Default = sourceContext.callback185
function sourceContext.callback185(NotifyStaff)
  sourceContext.settings3.NotifyStaff = NotifyStaff
  sourceContext.callback34("WH_NotifyStaff", NotifyStaff)
end
sourceContext.staffDetectedOptions.Callback = sourceContext.callback185
sourceContext.toggle11(sourceContext.section13, sourceContext.staffDetectedOptions)
sourceContext.staffDetectedOptions = "Toggle"
sourceContext.testWebhookOptions = sourceContext.section13
sourceContext.toggle11 = sourceContext.section13.Toggle
sourceContext.serverReconnectHopOptions = { Name = "Server Reconnect / Hop" }
sourceContext.callback185 = sourceContext.callback35
sourceContext.callback185 = sourceContext.callback35("WH_NotifyKick", true)
sourceContext.serverReconnectHopOptions.Default = sourceContext.callback185
sourceContext.callback187 = "Callback"
function sourceContext.callback185(NotifyKick)
  sourceContext.settings3.NotifyKick = NotifyKick
  sourceContext.callback34("WH_NotifyKick", NotifyKick)
end
sourceContext.serverReconnectHopOptions.Callback = sourceContext.callback185
sourceContext.toggle11(sourceContext.section13, sourceContext.serverReconnectHopOptions)
sourceContext.Webhooks = "Settings"
sourceContext.settings39 = sourceContext.entries12.Settings
sourceContext.toggle11 = "Section"
sourceContext.section13 = sourceContext.settings39
sourceContext.section12 = sourceContext.settings39.Section
sourceContext.section12 = sourceContext.section12(sourceContext.settings39, { Side = "Left", Name = "Script Settings" })
sourceContext.testWebhookOptions = "Header"
sourceContext.toggle11 = sourceContext.section12
sourceContext.section12.Header(sourceContext.section12, { Text = "Settings", AutoLocalize = false })
sourceContext.toggle11 = sourceContext.section12
sourceContext.section14 = sourceContext.section12.Toggle
sourceContext.saveSettingsOptions = { Name = "Save Settings" }
sourceContext.serverReconnectHopOptions = "Default"
sourceContext.callback187 = sourceContext.callback35
sourceContext.callback185 = "SS"
sourceContext.callback187 = sourceContext.callback35("SS", true)
sourceContext.saveSettingsOptions.Default = sourceContext.callback187
function sourceContext.callback187(SaveSettings)
  sourceContext.settings2.SaveSettings = SaveSettings
  sourceContext.callback34("SS", SaveSettings)
end
sourceContext.saveSettingsOptions.Callback = sourceContext.callback187
sourceContext.section14(sourceContext.section12, sourceContext.saveSettingsOptions)
sourceContext.saveSettingsOptions = "Toggle"
sourceContext.toggle11 = sourceContext.section12
sourceContext.section14 = sourceContext.section12.Toggle
sourceContext.autoExecuteOptions = { Name = "Auto Execute" }
sourceContext.callback187 = sourceContext.callback35
sourceContext.callback187 = sourceContext.callback35("AE", true)
sourceContext.autoExecuteOptions.Default = sourceContext.callback187
function sourceContext.callback187(AutoExecute)
  sourceContext.settings2.AutoExecute = AutoExecute
  sourceContext.callback34("AE", AutoExecute)
  if AutoExecute then
    sourceContext.setAutoExecute()
  elseif getgenv then getgenv().RAILHUB_AUTOEXEC = nil end
end
sourceContext.autoExecuteOptions.Callback = sourceContext.callback187
sourceContext.section14(sourceContext.section12, sourceContext.autoExecuteOptions)
sourceContext.autoExecuteOptions = "Toggle"
sourceContext.toggle11 = sourceContext.section12
sourceContext.section14 = sourceContext.section12.Toggle
sourceContext.antiAFKOptions = { Name = "Anti AFK" }
sourceContext.callback187 = sourceContext.callback35
sourceContext.callback187 = sourceContext.callback35("AA", true)
sourceContext.antiAFKOptions.Default = sourceContext.callback187
function sourceContext.callback187(a)
  sourceContext.callback24(a)
  sourceContext.callback34("AA", a)
end
sourceContext.antiAFKOptions.Callback = sourceContext.callback187
sourceContext.section14(sourceContext.section12, sourceContext.antiAFKOptions)
sourceContext.antiAFKOptions = "Slider"
sourceContext.toggle11 = sourceContext.section12
sourceContext.section14 = sourceContext.section12.Slider
sourceContext.menuScaleOptions = { Name = "Menu Scale", Default = tonumber(string.format("%.1f", sourceContext.callback35("MenuScale") or 1)) }
sourceContext.callback187 = 0.5
sourceContext.menuScaleOptions.Minimum = 0.5
sourceContext.menuScaleOptions.Maximum = 1
sourceContext.menuScaleOptions.Precision = 1
sourceContext.menuScaleOptions.Prefix = "x"
sourceContext.menuScaleOptions.DisplayMethod = "Value"
function sourceContext.menuScaleOptions.Callback(a)
  local number = tonumber(string.format("%.1f", a))
  sourceContext.callback34("MenuScale", number)
  if not getgenv()._MenuScaleDebounce then getgenv()._MenuScaleDebounce = 0 end
  local environment8 = getgenv()
  environment8._MenuScaleDebounce = getgenv()._MenuScaleDebounce + 1
  environment8 = getgenv
  environment8 = environment8()
  environment8 = environment8._MenuScaleDebounce
  task.delay(0.2, function()
    local entry20 = environment8
    local _MenuScaleDebounce = getgenv()
    _MenuScaleDebounce = _MenuScaleDebounce._MenuScaleDebounce
    if entry20 == _MenuScaleDebounce and sourceContext.RAILhubWindow then
      pcall(function()
        if type(sourceContext.RAILhubWindow.SetScale) == "function" then sourceContext.RAILhubWindow:SetScale(number) end
      end)
    end
  end)
end
sourceContext.section14(sourceContext.section12, sourceContext.menuScaleOptions)
sourceContext.menuScaleOptions = "Button"
sourceContext.toggle11 = sourceContext.section12
sourceContext.section12.Button(sourceContext.section12, {
  Name = "Reset Settings to Default",
  Callback = function()
    sourceContext.callback36()
    sourceContext.notify("Settings", "All settings have been reset to default!")
  end,
})
sourceContext.toggle11 = sourceContext.settings39
securitySec = sourceContext.settings39.Section(sourceContext.settings39, { Side = "Left", Name = "Security & Protection" })
sourceContext.section14 = securitySec
sourceContext.toggle11 = sourceContext.section14
sourceContext.section14.Header(sourceContext.section14, { Text = "Staff Detector", AutoLocalize = false })
sourceContext.section14 = securitySec
sourceContext.toggle11 = sourceContext.section14
sourceContext.section14.Toggle(sourceContext.section14, {
  Name = "Staff Detector (Auto Rejoin)",
  Default = not sourceContext.callback35 or sourceContext.callback35("StaffAutoKick", true) or true,
  Callback = function(autoKick)
    getgenv().StaffDetectorData.autoKick = autoKick
    sourceContext.callback34("StaffAutoKick", autoKick)
    if autoKick then for k, v in ipairs(sourceContext.playersService:GetPlayers()) do checkStaffMember(v) end end
  end,
})
sourceContext.section14 = securitySec
sourceContext.toggle11 = sourceContext.section14
sourceContext.section14.Toggle(sourceContext.section14, {
  Name = "Staff ESP",
  Default = not sourceContext.callback35 or sourceContext.callback35("StaffESP", true) or true,
  Callback = function(espEnabled)
    getgenv().StaffDetectorData.espEnabled = espEnabled
    sourceContext.callback34("StaffESP", espEnabled)
    refreshStaffESP()
    if getgenv()._YBA_refreshPlayerESP then task.defer(getgenv()._YBA_refreshPlayerESP) end
  end,
})
sourceContext.toggle11 = sourceContext.settings39
reconnectSec = sourceContext.settings39.Section(sourceContext.settings39, { Side = "Right", Name = "Server" })
sourceContext.section14 = reconnectSec
sourceContext.toggle11 = sourceContext.section14
sourceContext.section14 = sourceContext.section14.Header
sourceContext.section14(sourceContext.toggle11, { Text = "Server", AutoLocalize = false })
if sourceContext.callback35 then
  sourceContext.section14 = sourceContext.callback35
  sourceContext.section14 = sourceContext.callback35("AutoRejoin", true)
else
  sourceContext.section14 = sourceContext.callback35
end
if sourceContext.section14 ~= nil then sourceContext.enabled2 = sourceContext.section14 end
sourceContext.reconnectSec2 = reconnectSec
sourceContext.reconnectSec3 = nil
sourceContext.reconnectSec2.Toggle(sourceContext.reconnectSec2, {
  Name = "Auto Rejoin (Kick/Error)", Default = sourceContext.section14 == nil or sourceContext.section14 or true,
  Callback = function(a)
    sourceContext.enabled2 = a
    sourceContext.callback34("AutoRejoin", a)
  end,
})
sourceContext.reconnectSec3 = reconnectSec
sourceContext.reconnectSec4 = nil
sourceContext.reconnectSec3.Button(sourceContext.reconnectSec3, {
  Name = "Reconnect",
  Callback = function()
    sourceContext.notify("Settings", "Reconnecting to current server...")
    task.wait(0.5)
    local JobId = game.JobId
    if JobId and JobId ~= "" then
      game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, JobId, sourceContext.player)
    else
      sourceContext.notify("Settings", "Could not get server ID, rejoining...")
      game:GetService("TeleportService"):Teleport(game.PlaceId, sourceContext.player)
    end
  end,
})
sourceContext.reconnectSec4 = reconnectSec
sourceContext.reconnectSec4.Button(sourceContext.reconnectSec4, { Name = "Server Hop", Callback = function() serverHopToRandom() end })
pcall(function()
  if sourceContext.entries12 and sourceContext.entries12.Info and type(sourceContext.entries12.Info.Select) == "function" then sourceContext.entries12.Info:Select() end
end)
sourceContext.notify("YBA Script", "Script loaded successfully!")
