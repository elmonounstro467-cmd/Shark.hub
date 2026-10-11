-- 🦈 Shark Hub | BlockSpin
-- Auto Farm Edition (Pesca + Limpiador + Cajas)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

player.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

if playerGui:FindFirstChild("SharkHub") then
	playerGui.SharkHub:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "SharkHub"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = playerGui

local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 55, 0, 55)
openBtn.Position = UDim2.new(1, -70, 0.5, -27)
openBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
openBtn.BackgroundTransparency = 0.1
openBtn.Text = "🦈"
openBtn.TextSize = 26
openBtn.Font = Enum.Font.GothamBold
openBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
openBtn.BorderSizePixel = 0
openBtn.ZIndex = 20
openBtn.Parent = sg

Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke", openBtn)
stroke.Color = Color3.fromRGB(100, 160, 255)
stroke.Thickness = 2
stroke.Transparency = 0.3

local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 280, 0, 380)
main.Position = UDim2.new(0.5, -140, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
main.BorderSizePixel = 0
main.Visible = false
main.Parent = sg

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(80, 130, 220)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.4

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🦈 Shark Hub | AutoFarm"
title.TextColor3 = Color3.fromRGB(220, 230, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = main

local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -20, 1, -55)
container.Position = UDim2.new(0, 10, 0, 45)
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.ScrollBarThickness = 4
container.CanvasSize = UDim2.new(0, 0, 0, 480)
container.Parent = main

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.Parent = container

local function createToggle(name, default, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
	btn.BorderSizePixel = 0
	btn.Text = ""
	btn.AutoButtonColor = false
	btn.Parent = container
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -50, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(220, 225, 240)
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = btn

	local indicator = Instance.new("Frame")
	indicator.Size = UDim2.new(0, 18, 0, 18)
	indicator.Position = UDim2.new(1, -30, 0.5, -9)
	indicator.BackgroundColor3 = default and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(60, 60, 75)
	indicator.BorderSizePixel = 0
	indicator.Parent = btn
	Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

	local enabled = default
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		indicator.BackgroundColor3 = enabled and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(60, 60, 75)
		callback(enabled)
	end)
end

local autoPesca = false
local autoLimpiador = false
local autoCajas = false
local autoATM = false
local speedBoost = false
local infiniteJump = false
local noClip = false

createToggle("🎣 Auto Pesca", false, function(v) autoPesca = v end)
createToggle("🧹 Auto Limpiador", false, function(v) autoLimpiador = v end)
createToggle("📦 Auto Cajas", false, function(v) autoCajas = v end)
createToggle("💰 Auto ATM", false, function(v) autoATM = v end)
createToggle("⚡ Speed Boost", false, function(v)
	speedBoost = v
	if humanoid then humanoid.WalkSpeed = v and 28 or 16 end
end)
createToggle("🦘 Infinite Jump", false, function(v) infiniteJump = v end)
createToggle("👻 NoClip", false, function(v) noClip = v end)

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(1, 0, 0, 36)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 70)
rejoinBtn.BorderSizePixel = 0
rejoinBtn.Text = "🔄 Rejoin Server"
rejoinBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
rejoinBtn.Font = Enum.Font.Gotham
rejoinBtn.TextSize = 14
rejoinBtn.Parent = container
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 8)

rejoinBtn.MouseButton1Click:Connect(function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

local guiOpen = false
openBtn.MouseButton1Click:Connect(function()
	guiOpen = not guiOpen
	main.Visible = guiOpen
end)

UIS.JumpRequest:Connect(function()
	if infiniteJump and humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

RunService.Stepped:Connect(function()
	if noClip and character then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")
	if speedBoost then humanoid.WalkSpeed = 28 end
end)

local function fireNearbyPrompts(maxDist)
	maxDist = maxDist or 14
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("ProximityPrompt") and obj.Enabled then
			local parent = obj.Parent
			if parent and parent:IsA("BasePart") then
				local dist = (root.Position - parent.Position).Magnitude
				if dist <= maxDist then
					pcall(function() fireproximityprompt(obj) end)
				end
			end
		end
	end
end

task.spawn(function()
	while true do
		task.wait(0.6)
		if autoPesca or autoLimpiador or autoCajas or autoATM then
			pcall(function() fireNearbyPrompts(14) end)
		end
	end
end)

print("🦈 Shark Hub cargado")
