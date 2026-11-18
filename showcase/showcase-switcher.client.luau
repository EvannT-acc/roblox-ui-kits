-- Showcase switcher for screenshots: shows one UI kit at a time.
-- 1 HUD | 2 Shop/Index | 3 Roll | 4 Skill Tree | 5 Admin | 6 Roles/Nametags | 7 Square Shine | 8 Top Donators | 9 UI Pack | M Limited Store | P Steal Egg | 0 everything
-- L shows / hides the Roblox player list. The main menu is shown alone first; press PLAY to get to the kits.
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local MODES = {
	[Enum.KeyCode.One] = { name = "HUD Kit", guis = { "MainHUD" } },
	[Enum.KeyCode.Two] = { name = "Shop / Index Buttons", guis = { "Ui Buttons" } },
	[Enum.KeyCode.Three] = { name = "Roll & Reward Reveal", guis = { "Roll" } },
	[Enum.KeyCode.Four] = { name = "Skill Tree (press K)", guis = { "SkillTree" } },
	[Enum.KeyCode.Five] = { name = "Admin Panel (press F2)", guis = { "AdminPanel" } },
	[Enum.KeyCode.Six] = { name = "Nametags & Roles (press H)", guis = { "RolesPanel" } },
	[Enum.KeyCode.Seven] = { name = "Square Shine Buttons", guis = { "Shop Rebirth UI" } },
	-- the board is 3D, so this mode hides the 2D kits and walks you up to it
	[Enum.KeyCode.Eight] = { name = "Top Donators (walk up + press E)", guis = {}, standAt = Vector3.new(0, 3, -5), lookAt = Vector3.new(0, 3, -45) },
	-- the full UI Pack: its HUD + screens, and walks you to its pads and stalls
	[Enum.KeyCode.Nine] = { name = "UI Pack (walk onto a pad)", guis = { "UIPack", "Roll" }, standAt = Vector3.new(0, 3, 12), lookAt = Vector3.new(0, 3, 34) },
	[Enum.KeyCode.M] = { name = "Limited Store (click the button on the left)", guis = { "LimitedStore" } },
	-- the Steal Egg kit: its HUD and menus, and walks you to its stalls and pads
	[Enum.KeyCode.P] = {
		name = "Steal Egg Kit (walk onto a pad)",
		guis = { "HUD", "RobuxShop", "TrailShop", "GrowingEggs", "ActivePets", "PetFuse", "Index Menu New", "Sell Pets", "FreeGift" },
		standAt = Vector3.new(-178, 3, -21),
		lookAt = Vector3.new(-145, 3, -21),
	},
	[Enum.KeyCode.Zero] = { name = "Everything", guis = "all" },
}

-- the kits' own open keys jump straight to their kit, so K / F2 / H always show something
local OPEN_KEYS = {
	[Enum.KeyCode.K] = MODES[Enum.KeyCode.Four],
	[Enum.KeyCode.F2] = MODES[Enum.KeyCode.Five],
	[Enum.KeyCode.H] = MODES[Enum.KeyCode.Six],
}

-- kits whose own scripts switch their ScreenGuis on at start: keep them in line with the current mode
local STICKY_GUIS = {}
for _, n in MODES[Enum.KeyCode.P].guis do
	STICKY_GUIS[n] = true
end

local KIT_GUIS = {}
for _, mode in MODES do
	if type(mode.guis) == "table" then
		for _, n in mode.guis do
			KIT_GUIS[n] = true
		end
	end
end

for _, coreType in { Enum.CoreGuiType.PlayerList, Enum.CoreGuiType.Backpack } do
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, coreType, false)
end
local playerListShown = false

local current = MODES[Enum.KeyCode.One]
local inMenu = true

local function apply()
	local visible = {}
	if not inMenu then
		if current.guis == "all" then
			for n in KIT_GUIS do
				visible[n] = true
			end
		else
			for _, n in current.guis do
				visible[n] = true
			end
		end
	end
	for _, gui in playerGui:GetChildren() do
		if gui:IsA("ScreenGui") and KIT_GUIS[gui.Name] then
			gui.Enabled = visible[gui.Name] == true
		end
	end
end

-- small mode hint that fades out so it never ends up in a screenshot
local hintGui = Instance.new("ScreenGui")
hintGui.Name = "ShowcaseHint"
hintGui.ResetOnSpawn = false
hintGui.DisplayOrder = 100
hintGui.Parent = playerGui

local hint = Instance.new("TextLabel")
hint.AnchorPoint = Vector2.new(0.5, 1)
hint.Position = UDim2.new(0.5, 0, 1, -12)
hint.Size = UDim2.fromOffset(640, 30)
hint.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
hint.BackgroundTransparency = 1
hint.TextColor3 = Color3.new(1, 1, 1)
hint.TextTransparency = 1
hint.Font = Enum.Font.FredokaOne
hint.TextSize = 18
hint.Parent = hintGui
Instance.new("UICorner", hint).CornerRadius = UDim.new(0, 8)

local hintToken = 0
local function showHint(text)
	hintToken += 1
	local token = hintToken
	hint.Text = text
	hint.TextTransparency = 0
	hint.BackgroundTransparency = 0.35
	task.delay(2.5, function()
		if token ~= hintToken then
			return
		end
		TweenService:Create(hint, TweenInfo.new(0.4), { TextTransparency = 1, BackgroundTransparency = 1 }):Play()
	end)
end

local function watchMenu(menu)
	local function update()
		local wasInMenu = inMenu
		inMenu = menu.Enabled
		apply()
		if wasInMenu and not inMenu then
			showHint(`Keys 1-9, M and P switch kit  |  K / F2 / H open panels  |  0 = everything`)
		end
	end
	menu:GetPropertyChangedSignal("Enabled"):Connect(update)
	update()
end

local function watchSticky(gui)
	if STICKY_GUIS[gui.Name] then
		gui:GetPropertyChangedSignal("Enabled"):Connect(function()
			task.defer(apply)
		end)
	end
end

playerGui.ChildAdded:Connect(function(child)
	if not child:IsA("ScreenGui") then
		return
	end
	if child.Name == "MainMenu" then
		watchMenu(child)
	elseif KIT_GUIS[child.Name] then
		task.defer(apply)
		watchSticky(child)
	end
end)
for _, child in playerGui:GetChildren() do
	if child:IsA("ScreenGui") then
		watchSticky(child)
	end
end

local menu = playerGui:FindFirstChild("MainMenu")
if menu then
	watchMenu(menu)
else
	-- MainMenu may arrive a moment later; keep kits hidden until we know
	task.delay(3, function()
		if not playerGui:FindFirstChild("MainMenu") then
			inMenu = false
			apply()
		end
	end)
	apply()
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed or inMenu then
		return
	end
	local mode = MODES[input.KeyCode]
	if mode then
		-- leaving the Steal Egg kit: close its open menu so its background blur goes too
		local stealEggHud = playerGui:FindFirstChild("HUD")
		local closeMenu = stealEggHud and stealEggHud:FindFirstChild("CloseOpenMenu")
		if closeMenu and mode ~= MODES[Enum.KeyCode.P] and mode.guis ~= "all" then
			closeMenu:Fire()
		end
		current = mode
		apply()
		showHint(mode.name)
		local character = Players.LocalPlayer.Character
		if mode.standAt and character then
			character:PivotTo(CFrame.lookAt(mode.standAt, mode.lookAt))
			-- turn the camera too, otherwise it keeps facing wherever it was
			local back = (mode.standAt - mode.lookAt).Unit * 12
			workspace.CurrentCamera.CFrame = CFrame.lookAt(mode.standAt + back + Vector3.new(0, 5, 0), mode.lookAt)
		end
		return
	end
	if input.KeyCode == Enum.KeyCode.L then
		playerListShown = not playerListShown
		pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.PlayerList, playerListShown)
		return
	end
	local openMode = OPEN_KEYS[input.KeyCode]
	if openMode and current ~= openMode and current.guis ~= "all" then
		current = openMode
		apply()
	end
end)
