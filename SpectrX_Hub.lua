--[[
    SpectrX Hub v8.0 - readable semantic reconstruction

    Recovered from the supplied VM-obfuscated script.
    The structure and feature set are preserved, while generated VM code,
    junk arithmetic, randomized identifiers and anti-analysis noise are gone.
]]

local ENV = type(getgenv) == "function" and getgenv() or _G

if ENV.SpectrXReadableState and type(ENV.SpectrXReadableState.cleanup) == "function" then
    pcall(ENV.SpectrXReadableState.cleanup)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local state = {
    alive = true,
    connections = {},
    espObjects = {},
    flags = {
        autoFarm = false,
        pvpMode = false,
        autoBlock = false,
        walkspeed = false,
        jumpPower = false,
        infiniteJump = false,
        noclip = false,
        fly = false,
        autoFarmItems = false,
        esp = false,
    },
    values = {
        pvpTarget = "",
        speed = 50,
        jumpPower = 50,
        flySpeed = 5,
    },
    previousHealth = nil,
    healthConnection = nil,
    bodyVelocity = nil,
    bodyGyro = nil,
}

ENV.SpectrXReadableState = state

local function track(connection)
    state.connections[#state.connections + 1] = connection
    return connection
end

local function disconnect(connection)
    if connection then
        pcall(function()
            connection:Disconnect()
        end)
    end
end

local function destroy(instance)
    if instance then
        pcall(function()
            instance:Destroy()
        end)
    end
end

local function getCharacterParts(player)
    player = player or LocalPlayer

    local character = player.Character
    if not character then
        return nil, nil, nil
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    return character, humanoid, root
end

local function sendKey(keyCode, holdTime)
    holdTime = holdTime or 0.08

    pcall(function()
        VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        task.wait(holdTime)
        VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
    end)
end

local function clickPrimary()
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(
            0,
            0,
            0,
            true,
            game,
            0
        )
        task.wait(0.04)
        VirtualInputManager:SendMouseButtonEvent(
            0,
            0,
            0,
            false,
            game,
            0
        )
    end)
end

local function findPlayer(query)
    query = string.lower(tostring(query or ""))
    if query == "" then
        return nil
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local name = string.lower(player.Name)
            local displayName = string.lower(player.DisplayName)

            if string.find(name, query, 1, true)
                or string.find(displayName, query, 1, true)
            then
                return player
            end
        end
    end

    return nil
end

local function findAlphaThug()
    local living = workspace:FindFirstChild("Living")
    if not living then
        return nil
    end

    for _, model in ipairs(living:GetChildren()) do
        local name = string.lower(model.Name)
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        local root = model:FindFirstChild("HumanoidRootPart")

        if string.find(name, "alpha thug", 1, true)
            and humanoid
            and root
            and humanoid.Health > 0
        then
            return model
        end
    end

    return nil
end

local function attackModel(model)
    if not model then
        return
    end

    local _, localHumanoid, localRoot = getCharacterParts()
    local targetHumanoid = model:FindFirstChildOfClass("Humanoid")
    local targetRoot = model:FindFirstChild("HumanoidRootPart")

    if not localHumanoid
        or localHumanoid.Health <= 0
        or not localRoot
        or not targetHumanoid
        or targetHumanoid.Health <= 0
        or not targetRoot
    then
        return
    end

    localRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
    clickPrimary()
end

local function findItemPart(item)
    if item:IsA("BasePart") then
        return item
    end

    return item:FindFirstChildWhichIsA("BasePart", true)
end

local function collectItem(item)
    local _, humanoid, root = getCharacterParts()
    local itemPart = findItemPart(item)

    if not humanoid or humanoid.Health <= 0 or not root or not itemPart then
        return
    end

    root.CFrame = itemPart.CFrame + Vector3.new(0, 2, 0)

    local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt and type(fireproximityprompt) == "function" then
        pcall(fireproximityprompt, prompt)
        return
    end

    local clickDetector = item:FindFirstChildWhichIsA("ClickDetector", true)
    if clickDetector and type(fireclickdetector) == "function" then
        pcall(fireclickdetector, clickDetector)
        return
    end

    if type(firetouchinterest) == "function" then
        pcall(firetouchinterest, root, itemPart, 0)
        pcall(firetouchinterest, root, itemPart, 1)
    else
        clickPrimary()
    end
end

local function removePlayerESP(player)
    local objects = state.espObjects[player]
    if not objects then
        return
    end

    disconnect(objects.characterConnection)
    destroy(objects.highlight)
    destroy(objects.billboard)
    state.espObjects[player] = nil
end

local function clearESP()
    local players = {}

    for player in pairs(state.espObjects) do
        players[#players + 1] = player
    end

    for _, player in ipairs(players) do
        removePlayerESP(player)
    end
end

local function attachESP(player)
    if player == LocalPlayer or not state.flags.esp then
        return
    end

    removePlayerESP(player)

    local character, humanoid, root = getCharacterParts(player)
    if not character or not humanoid or not root then
        return
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "SpectrX_Highlight"
    highlight.Adornee = character
    highlight.FillColor = Color3.fromRGB(255, 45, 70)
    highlight.FillTransparency = 0.7
    highlight.OutlineColor = Color3.fromRGB(255, 0, 50)
    highlight.OutlineTransparency = 0
    highlight.Parent = character

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "SpectrX_Name"
    billboard.Size = UDim2.new(0, 180, 0, 44)
    billboard.AlwaysOnTop = true
    billboard.ClipsDescendants = false
    billboard.MaxDistance = 500
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = root
    billboard.Parent = character

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 80, 100)
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.Parent = billboard

    state.espObjects[player] = {
        highlight = highlight,
        billboard = billboard,
        label = label,
    }
end

local function bindPlayerESP(player)
    if player == LocalPlayer then
        return
    end

    local existing = state.espObjects[player] or {}
    disconnect(existing.characterConnection)

    local characterConnection = player.CharacterAdded:Connect(function()
        task.wait(0.2)
        if state.flags.esp then
            attachESP(player)
        end
    end)

    existing.characterConnection = characterConnection
    state.espObjects[player] = existing

    attachESP(player)
end

local function setESP(enabled)
    state.flags.esp = enabled

    if not enabled then
        clearESP()
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        bindPlayerESP(player)
    end
end

local function ensureFlyMovers()
    if not state.bodyVelocity or not state.bodyVelocity.Parent then
        destroy(state.bodyVelocity)

        state.bodyVelocity = Instance.new("BodyVelocity")
        state.bodyVelocity.Name = "SpectrX_FlyVelocity"
        state.bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        state.bodyVelocity.Velocity = Vector3.zero
    end

    if not state.bodyGyro or not state.bodyGyro.Parent then
        destroy(state.bodyGyro)

        state.bodyGyro = Instance.new("BodyGyro")
        state.bodyGyro.Name = "SpectrX_FlyGyro"
        state.bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        state.bodyGyro.P = 90000
    end
end

local function stopFly()
    if state.bodyVelocity then
        state.bodyVelocity.Parent = nil
        state.bodyVelocity.Velocity = Vector3.zero
    end

    if state.bodyGyro then
        state.bodyGyro.Parent = nil
    end
end

local function bindHealthMonitor()
    disconnect(state.healthConnection)
    state.healthConnection = nil
    state.previousHealth = nil

    local _, humanoid = getCharacterParts()
    if not humanoid then
        return
    end

    state.previousHealth = humanoid.Health
    state.healthConnection = humanoid.HealthChanged:Connect(function(health)
        if state.flags.autoBlock
            and state.previousHealth
            and health < state.previousHealth
            and health > 0
        then
            task.spawn(sendKey, Enum.KeyCode.F, 0.15)
        end

        state.previousHealth = health
    end)
end

function state.cleanup()
    if not state.alive then
        return
    end

    state.alive = false

    disconnect(state.healthConnection)
    state.healthConnection = nil

    for _, connection in ipairs(state.connections) do
        disconnect(connection)
    end

    clearESP()
    stopFly()
    destroy(state.bodyVelocity)
    destroy(state.bodyGyro)

    if ENV.SpectrXReadableState == state then
        ENV.SpectrXReadableState = nil
    end
end

track(LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.25)
    bindHealthMonitor()
    stopFly()
end))

bindHealthMonitor()

track(Players.PlayerAdded:Connect(function(player)
    if state.flags.esp then
        bindPlayerESP(player)
    end
end))

track(Players.PlayerRemoving:Connect(function(player)
    removePlayerESP(player)
end))

track(UserInputService.JumpRequest:Connect(function()
    if not state.flags.infiniteJump then
        return
    end

    local _, humanoid = getCharacterParts()
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

track(RunService.Stepped:Connect(function()
    if not state.flags.noclip then
        return
    end

    local character = LocalPlayer.Character
    if not character then
        return
    end

    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false
        end
    end
end))

local espAccumulator = 0

track(RunService.Heartbeat:Connect(function(deltaTime)
    local character, humanoid, root = getCharacterParts()

    if humanoid and root then
        if state.flags.walkspeed and humanoid.MoveDirection.Magnitude > 0 then
            root.CFrame += humanoid.MoveDirection
                * state.values.speed
                * math.min(deltaTime, 1 / 30)
        end

        if state.flags.jumpPower then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = state.values.jumpPower
        end

        if state.flags.fly then
            ensureFlyMovers()

            state.bodyVelocity.Parent = root
            state.bodyGyro.Parent = root

            Camera = workspace.CurrentCamera
            local relativeMove =
                Camera.CFrame:VectorToObjectSpace(humanoid.MoveDirection)
            local direction =
                Camera.CFrame.RightVector * relativeMove.X
                + Camera.CFrame.LookVector * -relativeMove.Z

            local vertical = 0
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                vertical += 1
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                vertical -= 1
            end

            direction += Vector3.new(0, vertical, 0)

            if direction.Magnitude > 0 then
                direction = direction.Unit
            end

            state.bodyVelocity.Velocity =
                direction * (state.values.flySpeed * 20)
            state.bodyGyro.CFrame = Camera.CFrame
        else
            stopFly()
        end
    end

    if state.flags.esp then
        espAccumulator += deltaTime
        if espAccumulator >= 0.15 then
            espAccumulator = 0

            local _, _, localRoot = getCharacterParts()
            for player, objects in pairs(state.espObjects) do
                local _, targetHumanoid, targetRoot =
                    getCharacterParts(player)

                if objects.label and targetHumanoid and targetRoot then
                    local distance = localRoot
                        and math.floor(
                            (localRoot.Position - targetRoot.Position).Magnitude
                        )
                        or 0

                    objects.label.Text = string.format(
                        "%s\n%d HP | %d studs",
                        player.Name,
                        math.floor(targetHumanoid.Health),
                        distance
                    )
                end
            end
        end
    end
end))

task.spawn(function()
    while state.alive do
        if state.flags.autoFarm then
            attackModel(findAlphaThug())
        elseif state.flags.pvpMode then
            local targetPlayer = findPlayer(state.values.pvpTarget)
            if targetPlayer then
                attackModel(targetPlayer.Character)
            end
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while state.alive do
        if state.flags.autoFarmItems then
            local itemFolder = workspace:FindFirstChild("Item_Spawns")
            if itemFolder then
                for _, item in ipairs(itemFolder:GetChildren()) do
                    if not state.alive or not state.flags.autoFarmItems then
                        break
                    end

                    collectItem(item)
                    task.wait(0.12)
                end
            end
        end

        task.wait(0.35)
    end
end)

local Rayfield = loadstring(
    game:HttpGet("https://sirius.menu/rayfield")
)()

local Window = Rayfield:CreateWindow({
    Name = "SpectrX Hub - cracked by piscar.",
    LoadingTitle = "Restoring & Updating...",
    LoadingSubtitle = "by SpectrX_Hub",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "SpectrX_Config",
    },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Main")
MainTab:CreateSection("Combat System")

MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(value)
        state.flags.autoFarm = value
    end,
})

MainTab:CreateToggle({
    Name = "PVP Mode",
    CurrentValue = false,
    Callback = function(value)
        state.flags.pvpMode = value
    end,
})

MainTab:CreateInput({
    Name = "PVP Target Nickname",
    PlaceholderText = "Enter name...",
    Callback = function(value)
        state.values.pvpTarget = tostring(value or "")
    end,
})

MainTab:CreateToggle({
    Name = "Auto Block",
    CurrentValue = false,
    Callback = function(value)
        state.flags.autoBlock = value
    end,
})

local MovementTab = Window:CreateTab("Movement")
MovementTab:CreateSection("Movement Enhancements")

MovementTab:CreateToggle({
    Name = "Walkspeed Bypass",
    CurrentValue = false,
    Callback = function(value)
        state.flags.walkspeed = value
    end,
})

MovementTab:CreateSlider({
    Name = "Speed Value (1-100)",
    Range = {1, 100},
    Increment = 1,
    Suffix = " speed",
    CurrentValue = 50,
    Callback = function(value)
        state.values.speed = tonumber(value) or 50
    end,
})

MovementTab:CreateToggle({
    Name = "Jump Power",
    CurrentValue = false,
    Callback = function(value)
        state.flags.jumpPower = value
    end,
})

MovementTab:CreateSlider({
    Name = "Jump Power Value (1-100)",
    Range = {1, 100},
    Increment = 1,
    Suffix = " power",
    CurrentValue = 50,
    Callback = function(value)
        state.values.jumpPower = tonumber(value) or 50
    end,
})

MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(value)
        state.flags.infiniteJump = value
    end,
})

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(value)
        state.flags.noclip = value
    end,
})

MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(value)
        state.flags.fly = value
        if not value then
            stopFly()
        end
    end,
})

MovementTab:CreateSlider({
    Name = "Fly Speed Multiplier (1-10)",
    Range = {1, 10},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 5,
    Callback = function(value)
        state.values.flySpeed = tonumber(value) or 5
    end,
})

MovementTab:CreateSection("Auto Farm Items")

MovementTab:CreateToggle({
    Name = "Auto Farm Items",
    CurrentValue = false,
    Callback = function(value)
        state.flags.autoFarmItems = value
    end,
})

local VisualsTab = Window:CreateTab("Visuals")
VisualsTab:CreateSection("ESP")

VisualsTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = setESP,
})

local InfoTab = Window:CreateTab("Info")
InfoTab:CreateSection("How to use")
InfoTab:CreateLabel(
    "• Auto Farm Alpha Thugs: Automatically kills Alpha Thugs (Living folder)."
)
InfoTab:CreateLabel(
    "• PVP Mode: Hunts a player by nickname (enter below)."
)
InfoTab:CreateLabel(
    "• Auto Block: Presses F automatically when you take damage."
)
InfoTab:CreateLabel(
    "• Walkspeed Bypass: Adjustable speed (1-100)."
)
InfoTab:CreateLabel(
    "• Jump Power: Adjustable jump height (1-100)."
)
InfoTab:CreateLabel("• Infinite Jump: Jump repeatedly in air.")
InfoTab:CreateLabel("• Noclip: Walk through walls.")
InfoTab:CreateLabel("• Fly: Toggle flight. Speed multiplier 1-10.")
InfoTab:CreateLabel(
    "• Auto Farm Items: Collects all items in Item_Spawns."
)
InfoTab:CreateLabel("• ESP: Red highlight + name tags for players.")
InfoTab:CreateLabel("• Join Telegram: https://discord.gg/XC755YMZVs")

InfoTab:CreateSection("Script Info")
InfoTab:CreateLabel("Script: YBA script by SpectrX_Hub")
InfoTab:CreateLabel("Version: 8.0 (Classic Combat Fixed)")
InfoTab:CreateLabel("Status: ACTIVE")

local CreditsTab = Window:CreateTab("Credits")
CreditsTab:CreateLabel("Script written by SpectrX_Hub")
CreditsTab:CreateLabel("Special for my Subscribers")
CreditsTab:CreateLabel("Discord: https://discord.gg/XC755YMZVs")

CreditsTab:CreateButton({
    Name = "Copy Telegram Link",
    Callback = function()
        if type(setclipboard) == "function" then
            setclipboard("https://discord.gg/XC755YMZVs")
        end

        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "SpectrX Hub",
                Text = "Telegram link copied!\nПрисоединяйтесь: https://discord.gg/XC755YMZVs",
                Duration = 8,
            })
        end)
    end,
})

Rayfield:Notify({
    Title = "SpectrX",
    Content = "Script Fixed & Updated!",
    Duration = 3,
})
