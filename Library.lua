-- Farthest --

local ThemeList = {
	Custom = {
		Background = Color3.fromRGB(20, 20, 20),
		UpdateBackground = Color3.fromRGB(38, 81, 200),
		Text = Color3.fromRGB(255, 255, 255),
		Images = Color3.fromRGB(255, 255, 255)
	}
}

-- Services --

local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Variables --

local StringName = HttpService:GenerateGUID()
local AnchorPoint = Vector2.new(0.5, 0.5)

-- Archived --

local Hubs = {}

-- Library --

local function Draggable(Top, Hub)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(Input)
		local Delta = Input.Position - DragStart
		local Pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		Hub.Position = Pos
	end

	Top.InputBegan:Connect(
		function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = Input.Position
				StartPosition = Hub.Position

				Input.Changed:Connect(
					function()
						if Input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	Top.InputChanged:Connect(
		function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseMovement or
				Input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = Input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(Input)
			if Input == DragInput and Dragging then
				Update(Input)
			end
		end
	)
end

function Hubs:CreateHub(HubName, Theme, HubIcon, Key, Updates)

	HubName = HubName or "Hub"
	Theme = Theme or "Custom"
	HubIcon = HubIcon or "rbxassetid://10666450758"
	Key = Key or "FarthestOnTop"
	Updates = Updates or table
	
	Theme = ThemeList[Theme]
	table.insert(Hubs, HubName)
	local Duplicated = false
	
	for i, Hub in pairs(Hubs) do
		if Hub == HubName then
			Duplicated = true
		else
			Duplicated = false
		end
	end
	
	local PrincipalUI = Instance.new("ScreenGui")
	
	local KeyPrincipal = {
		Core = Instance.new("Frame"),
		Corner = Instance.new("UICorner"),
		Icon = Instance.new("ImageLabel"),
		Name = Instance.new("TextLabel")
	}
	
	local UpdateInstances = {
		Principal = Instance.new("Frame"),
		Core = Instance.new("Frame"),
		Inset = Instance.new("UIListLayout"),
		Display = Instance.new("TextLabel"),
		Copyright = Instance.new("TextLabel")
	}
	
	PrincipalUI.Name = StringName.."-"..HubName
	PrincipalUI.Parent = game.CoreGui
	PrincipalUI.ResetOnSpawn = false
	PrincipalUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	KeyPrincipal.Core.Name = StringName
	KeyPrincipal.Core.Parent = PrincipalUI
	KeyPrincipal.Core.AnchorPoint = AnchorPoint
	KeyPrincipal.Core.Size = UDim2.new(0, 690,0, 450)
	KeyPrincipal.Core.Position = UDim2.new(0.5, 0,0.5, 0)
	KeyPrincipal.Core.BackgroundColor3 = Theme.Background
	
	KeyPrincipal.Corner.Name = StringName
	KeyPrincipal.Corner.Parent = KeyPrincipal.Core
	KeyPrincipal.Corner.CornerRadius = UDim.new(0.025, 0)

	KeyPrincipal.Icon.Name = StringName
	KeyPrincipal.Icon.Parent = KeyPrincipal.Core
	KeyPrincipal.Icon.AnchorPoint = AnchorPoint
	KeyPrincipal.Icon.Size = UDim2.new(0, 80,0, 80)
	KeyPrincipal.Icon.Position = UDim2.new(0.725, 0,0.3, 0)
	KeyPrincipal.Icon.BackgroundTransparency = 1
	KeyPrincipal.Icon.ImageColor3 = Theme.Images
	KeyPrincipal.Icon.Image = HubIcon

	KeyPrincipal.Name.Name = StringName
	KeyPrincipal.Name.Parent = KeyPrincipal.Core
	KeyPrincipal.Name.AnchorPoint = AnchorPoint
	KeyPrincipal.Name.Size = UDim2.new(0.5, 0,0.1, 0)
	KeyPrincipal.Name.Position = UDim2.new(0.725, 0,0.1, 0)
	KeyPrincipal.Name.BackgroundTransparency = 1
	KeyPrincipal.Name.Font = Enum.Font.SciFi
	KeyPrincipal.Name.TextColor3 = Theme.Text
	KeyPrincipal.Name.TextScaled = true
	KeyPrincipal.Name.Text = HubName

	UpdateInstances.Principal.Name = StringName
	UpdateInstances.Principal.Parent = KeyPrincipal.Core
	UpdateInstances.Principal.AnchorPoint = AnchorPoint
	UpdateInstances.Principal.Size = UDim2.new(0.45, 0,1, 0)
	UpdateInstances.Principal.Position = UDim2.new(0.225, 0.5)
	UpdateInstances.Principal.BackgroundColor3 = Theme.UpdateBackground
	
	UpdateInstances.Core.Name = StringName
	UpdateInstances.Core.Parent = UpdateInstances.Principal
	UpdateInstances.Core.AnchorPoint = AnchorPoint
	UpdateInstances.Core.Size = UDim2.new(0.9, 0,0.715, 0)
	UpdateInstances.Core.Position = UDim2.new(0.5, 0,0.5, 0)
	UpdateInstances.Core.BackgroundTransparency = 1

	UpdateInstances.Inset.Name = StringName
	UpdateInstances.Inset.Parent = UpdateInstances.Core
	UpdateInstances.Inset.Padding = UDim.new(0, 5)

	UpdateInstances.Display.Name = StringName
	UpdateInstances.Display.Parent = UpdateInstances.Principal
	UpdateInstances.Display.AnchorPoint = AnchorPoint
	UpdateInstances.Display.Size = UDim2.new(0.8, 0,0.1, 0)
	UpdateInstances.Display.Position = UDim2.new(0.5, 0,0.085, 0)
	UpdateInstances.Display.BackgroundTransparency = 1
	UpdateInstances.Display.Font = Enum.Font.SciFi
	UpdateInstances.Display.TextColor3 = Theme.Text
	UpdateInstances.Display.TextScaled = true
	UpdateInstances.Display.Text = "Updates:"

	UpdateInstances.Copyright.Name = StringName
	UpdateInstances.Copyright.Parent = UpdateInstances.Principal
	UpdateInstances.Copyright.AnchorPoint = AnchorPoint
	UpdateInstances.Copyright.Size = UDim2.new(0.925, 0,0, 25)
	UpdateInstances.Copyright.Position = UDim2.new(0.5, 0,0.95, 0)
	UpdateInstances.Copyright.BackgroundTransparency = 1
	UpdateInstances.Copyright.Font = Enum.Font.Oswald
	UpdateInstances.Copyright.TextColor3 = Theme.Text
	UpdateInstances.Copyright.TextScaled = true
	UpdateInstances.Copyright.Text = "Farthest Library"
	UpdateInstances.Copyright.TextXAlignment = Enum.TextXAlignment.Left
	
	local function UpdateVariable(Update)
		
		Update = Update or "Invite | XVbFqyEJhq"
		
		local Core = Instance.new("TextLabel")
		
		Core.Name = StringName
		Core.Parent = UpdateInstances.Core
		Core.AnchorPoint = AnchorPoint
		Core.Size = UDim2.new(1, 0,0, 25)
		Core.BackgroundTransparency = 1
		Core.Font = Enum.Font.SourceSansSemibold
		Core.TextColor3 = Theme.Text
		Core.TextScaled = true
		Core.Text = "- "..Update
	end

	for i, Update in pairs(Updates) do
		UpdateVariable(Update)
	end
end
return Hubs
