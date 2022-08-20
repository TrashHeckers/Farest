-- Theme --

local Themes = {
	Dark = {
		Background = Color3.fromRGB(25, 25, 25),
		Text = Color3.fromRGB(255, 255, 255),
		Images = Color3.fromRGB(255, 255, 255),
		Elements = Color3.fromRGB(33, 33, 33)
	},
	Light = {
		Background = Color3.fromRGB(255, 255, 255),
		Text = Color3.fromRGB(0, 0, 0),
		Images = Color3.fromRGB(0, 0, 0),
		Elements = Color3.fromRGB(161, 161, 161)
	},
	Red = {
		Background = Color3.fromRGB(229, 66, 69),
		Text = Color3.fromRGB(255, 255, 255),
		Images = Color3.fromRGB(255, 255, 255),
		Elements = Color3.fromRGB(184, 15, 18)
	}
}

-- Services --

local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Description --

local GameDescription = "Template | 0"

function FindGameDescription(GameId)

	if GameId == 189707 then
		GameDescription = "Natural Disaster | 189707"
	end

end

-- Variables --

local AnchorPoint = Vector2.new(0.5, 0.5)

-- Archived --

local GUIDString = HttpService:GenerateGUID()

local Hubs = {}
local Tabs = {}
local Sections = {}
local Elements = {}

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

function Hubs:CreateHub(HubName, Theme)

	HubName = HubName or "Farest"
	Theme = Theme or "Dark"

	Theme = Themes[Theme]
	table.insert(Hubs, HubName)

	local PanelList = Instance.new("ScrollingFrame")

	local HubInstances = {
		PrincipalUI = Instance.new("ScreenGui"),
		Core = Instance.new("Frame"),
		CloseButton = Instance.new("ImageButton"),
		PageFolder = Instance.new("Folder")
	}

	local HubVisibles = {
		MainCorner = Instance.new("UICorner"),
		PageInset = Instance.new("UIListLayout")
	}

	local HubDescription = {
		Main = Instance.new("Frame"),
		HubName = Instance.new("TextLabel"),
		GameDescription = Instance.new("TextLabel")
	}

	local GameId = game.PlaceId
	Draggable(HubDescription.Main, HubInstances.Core)

	HubInstances.PrincipalUI.Name = GUIDString
	HubInstances.PrincipalUI.Parent = game.Players.LocalPlayer.PlayerGui
	HubInstances.PrincipalUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	HubInstances.PrincipalUI.ResetOnSpawn = false

	HubInstances.Core.Name = GUIDString
	HubInstances.Core.Parent = HubInstances.PrincipalUI
	HubInstances.Core.AnchorPoint = AnchorPoint
	HubInstances.Core.Position = UDim2.new(0.5, 0,0.5, 0)
	HubInstances.Core.Size = UDim2.new(0, 700,0, 450)
	HubInstances.Core.BackgroundColor3 = Theme.Background
	HubVisibles.MainCorner.Name = GUIDString
	HubVisibles.MainCorner.Parent = HubInstances.Core
	HubVisibles.MainCorner.CornerRadius = UDim.new(0.035, 0)

	HubDescription.Main.Name = GUIDString
	HubDescription.Main.Parent = HubInstances.Core
	HubDescription.Main.AnchorPoint = AnchorPoint
	HubDescription.Main.Position = UDim2.new(0.5, 0,0.071, 0)
	HubDescription.Main.Size = UDim2.new(1, 0,0.146, 0)
	HubDescription.Main.BackgroundColor3 = Theme.Background
	HubDescription.Main.BorderSizePixel = 0

	HubDescription.HubName.Name = GUIDString
	HubDescription.HubName.Parent = HubDescription.Main
	HubDescription.HubName.AnchorPoint = AnchorPoint
	HubDescription.HubName.Position = UDim2.new(0.425, 0, 0.385, 0)
	HubDescription.HubName.Size = UDim2.new(0.8, 0,0.45, 0)
	HubDescription.HubName.BackgroundTransparency = 1
	HubDescription.HubName.TextColor3 = Theme.Text
	HubDescription.HubName.Font = Enum.Font.SourceSansBold
	HubDescription.HubName.TextScaled = true
	HubDescription.HubName.Text = HubName
	HubDescription.HubName.TextXAlignment = Enum.TextXAlignment.Left

	FindGameDescription(GameId)

	HubDescription.GameDescription.Name = GUIDString
	HubDescription.GameDescription.Parent = HubDescription.Main
	HubDescription.GameDescription.AnchorPoint = AnchorPoint
	HubDescription.GameDescription.Position = UDim2.new(0.425, 0, 0.673, 0)
	HubDescription.GameDescription.Size = UDim2.new(0.8, 0,0.329, 0)
	HubDescription.GameDescription.BackgroundTransparency = 1
	HubDescription.GameDescription.TextColor3 = Theme.Text
	HubDescription.GameDescription.Font = Enum.Font.SourceSans
	HubDescription.GameDescription.TextScaled = true
	HubDescription.GameDescription.Text = GameDescription
	HubDescription.GameDescription.TextXAlignment = Enum.TextXAlignment.Left

	HubInstances.PageFolder.Name = GUIDString
	HubInstances.PageFolder.Parent = HubInstances.PrincipalUI

	HubInstances.CloseButton.Name = GUIDString
	HubInstances.CloseButton.Parent = HubDescription.Main
	HubInstances.CloseButton.AnchorPoint = AnchorPoint
	HubInstances.CloseButton.Position = UDim2.new(0.965, 0,0.35, 0)
	HubInstances.CloseButton.Size = UDim2.new(0.033, 0,0.349, 0)
	HubInstances.CloseButton.BackgroundTransparency = 1
	HubInstances.CloseButton.ImageColor3 = Theme.Images
	HubInstances.CloseButton.Image = "rbxassetid://10619464475"
	HubInstances.CloseButton.MouseButton1Click:Connect(function()
		HubInstances.Core:TweenSize(
			UDim2.new(0, 0,0, 0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Linear,
			0.25,
			false
		)
		wait(0.3)
		HubInstances.PrincipalUI:Destroy()
	end)

	local TabAmount = 0
	
	local function UpdateTabList()

	local CanvasSize = HubVisibles.PageInset.AbsoluteContentSize

	TweenService:Create(PanelList, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
		CanvasSize = UDim2.new(0, 0,0, CanvasSize.Y)
	}):Play()

	end
	
	PanelList.Name = GUIDString
	PanelList.Parent = HubInstances.Core
	PanelList.AnchorPoint = AnchorPoint
	PanelList.Position = UDim2.new(0.15, 0,0.55, 0)
	PanelList.Size = UDim2.new(0.25, 0,0.785, 0)
	PanelList.BackgroundTransparency = 1

	PanelList.ChildAdded:Connect(function()
		TabAmount += 1
		UpdateTabList()
	end)
	PanelList.ChildRemoved:Connect(function()
		TabAmount -= 1
		UpdateTabList()
	end)

	HubVisibles.PageInset.Name = GUIDString
	HubVisibles.PageInset.Parent = PanelList
	HubVisibles.PageInset.CellPadding = UDim2.new(0, 0,0, 3)
	
	coroutine.wrap(function()
		while wait() do
			for i, Page in pairs(HubInstances.PageFolder:GetChildren()) do
				Page.Visible = false
			end
			
			UpdateTabList()

			HubInstances.Core.BackgroundColor3 = Theme.Background
			HubDescription.Main.BackgroundColor3 = Theme.Background
			HubDescription.HubName.TextColor3 = Theme.Text
			HubDescription.GameDescription.TextColor3 = Theme.Text
			HubInstances.CloseButton.ImageColor3 = Theme.Images
		end
	end)()

	local Primary = true

	function Tabs:NewTab(TabName, TabIcon)

		TabName = TabName or "Tab"
		TabIcon	= TabIcon or "rbxassetid://10537918474"

		local function ChangeTab(TargetName)

			for i, Page in pairs(HubInstances.PageFolder:GetChildren()) do
				if Page:IsA("ScrollingFrame") and Page.Name == TargetName then

					for i, Page in pairs(HubInstances.Core:GetChildren()) do
						if Page:IsA("ScrollingFrame") then
							Page.Parent = HubInstances.PageFolder
							if Page.Name == GUIDString then
								Page.Parent = HubInstances.Core
							end
							if PanelList:WaitForChild(Page.Name) then
								local Selection = PanelList:WaitForChild(Page.Name)
								if Selection:IsA("TextButton") then
									Selection.Display.TextTransparency = 0.25
								end
							end
						end
					end

					Page.Parent = HubInstances.Core
					Page.Visible = true

					local Selection = PanelList:WaitForChild(Page.Name)

					for i, Variable in pairs(Selection:GetChildren()) do
						if Variable:IsA("TextLabel") then
							Variable.TextTransparency = 0
						end
					end

				end
			end
		end

		table.insert(Tabs, TabName)

		local ElementAmount = 0

		local TabInstances = {
			Core = Instance.new("ScrollingFrame"),
			Inset = Instance.new("UIListLayout")
		}

		local ButtonInstances = {
			Core = Instance.new("TextButton"),
			Corner = Instance.new("UICorner"),
			Icon = Instance.new("ImageLabel"),
			Display = Instance.new("TextLabel")
		}

		local function UpdateElementSize()

			local CanvasSize = TabInstances.Inset.AbsoluteContentSize

			TweenService:Create(TabInstances.Core, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				CanvasSize = UDim2.new(0, 0,0, CanvasSize.Y)
			}):Play()

		end

		TabInstances.Core.Name = TabName
		TabInstances.Core.Parent = HubInstances.PageFolder
		TabInstances.Core.AnchorPoint = AnchorPoint
		TabInstances.Core.Position = UDim2.new(0.625, 0,0.55, 0)
		TabInstances.Core.Size = UDim2.new(0.65, 0,0.785, 0)
		TabInstances.Core.BackgroundTransparency = 1
		TabInstances.Core.ScrollBarThickness = 0

		TabInstances.Inset.Name = GUIDString
		TabInstances.Inset.Parent = TabInstances.Core
		TabInstances.Inset.HorizontalAlignment = Enum.HorizontalAlignment.Center
		TabInstances.Inset.SortOrder = Enum.SortOrder.LayoutOrder
		TabInstances.Inset.Padding = UDim.new(0, 5)

		ButtonInstances.Core.Name = TabName
		ButtonInstances.Core.Parent = PanelList
		ButtonInstances.Core.AnchorPoint = AnchorPoint
		ButtonInstances.Core.Size = UDim2.new(0.9, 0,0, 40)
		ButtonInstances.Core.TextTransparency = 1
		ButtonInstances.Core.BackgroundColor3 = Theme.Elements
		ButtonInstances.Core.AutoButtonColor = false
		ButtonInstances.Core.MouseButton1Click:Connect(function()
			ChangeTab(TabName)
		end)

		ButtonInstances.Icon.Name = GUIDString
		ButtonInstances.Icon.Parent = ButtonInstances.Core
		ButtonInstances.Icon.AnchorPoint = AnchorPoint
		ButtonInstances.Icon.Position = UDim2.new(0.15, 0,0.5, 0)
		ButtonInstances.Icon.Size = UDim2.new(0.173, 0,0.5, 0)
		ButtonInstances.Icon.BackgroundTransparency = 1
		ButtonInstances.Icon.ImageColor3 = Theme.Text
		ButtonInstances.Icon.Image = TabIcon

		ButtonInstances.Display.Name = GUIDString
		ButtonInstances.Display.Parent = ButtonInstances.Core
		ButtonInstances.Display.AnchorPoint = AnchorPoint
		ButtonInstances.Display.Position = UDim2.new(0.645, 0,0.5, 0)
		ButtonInstances.Display.Size = UDim2.new(0.7, 0,0.5, 0)
		ButtonInstances.Display.BackgroundTransparency = 1
		ButtonInstances.Display.Font = Enum.Font.SciFi
		ButtonInstances.Display.TextXAlignment = Enum.TextXAlignment.Left
		ButtonInstances.Display.TextColor3 = Theme.Text
		ButtonInstances.Display.TextScaled = true
		ButtonInstances.Display.Text = TabName

		ButtonInstances.Corner.Name = GUIDString
		ButtonInstances.Corner.Parent = ButtonInstances.Core
		ButtonInstances.Corner.CornerRadius = UDim.new(0.15, 0)

		if Primary == true then
			Primary = false
			ButtonInstances.Display.TextTransparency = 0
			TabInstances.Core.Parent = HubInstances.Core
			TabInstances.Core.Visible = true
		else
			ButtonInstances.Display.TextTransparency = 0.25
		end

		coroutine.wrap(function()
			while wait() do
				ButtonInstances.Core.BackgroundColor3 = Theme.Elements
				ButtonInstances.Icon.ImageColor3 = Theme.Text
				ButtonInstances.Display.TextColor3 = Theme.Text
				UpdateElementSize()
			end
		end)()

		function Sections:NewSection(SectionName, SectionIcon)

			SectionName = SectionName or "Section"
			SectionIcon = SectionIcon or "rbxassetid://0"

			table.insert(Sections, SectionName)

			local SectionContent = {
				Core = Instance.new("Frame"),
				Corner = Instance.new("UICorner"),
				Display = Instance.new("TextLabel")
			}
			SectionContent.Core.Name = GUIDString
			SectionContent.Core.Parent = TabInstances.Core
			SectionContent.Core.AnchorPoint = AnchorPoint
			SectionContent.Core.BackgroundColor3 = Theme.Elements
			SectionContent.Core.Size = UDim2.new(0.875, 0,0, 45)
			
			SectionContent.Corner.Name = GUIDString
			SectionContent.Corner.Parent = SectionContent.Core
			SectionContent.Corner.CornerRadius = UDim.new(0.15, 0)
			
			SectionContent.Display.Name = GUIDString
			SectionContent.Display.Parent = SectionContent.Core
			SectionContent.Display.AnchorPoint = AnchorPoint
			SectionContent.Display.BackgroundTransparency = 1
			SectionContent.Display.Position = UDim2.new(0.45, 0,0.5, 0)
			SectionContent.Display.Size = UDim2.new(0.865, 0,0.85, 0)
			SectionContent.Display.TextScaled = true
			SectionContent.Display.TextColor3 = Theme.Text
			SectionContent.Display.Text = SectionName
			SectionContent.Display.Position = UDim2.new(0.5, 0,0.5, 0)
			SectionContent.Display.Font = Enum.Font.SourceSansBold
			
			coroutine.wrap(function()
				while wait() do
					SectionContent.Core.BackgroundColor3 = Theme.Elements
					SectionContent.Display.TextColor3 = Theme.Text
				end
			end)()

			local function ButtonAnimation(Parent)

				Parent = Parent or Instance

				local Mouse = Players.LocalPlayer:GetMouse()

				local Image = Instance.new("ImageLabel")

				Image.Parent = Parent
				Image.Name = "STRING-"..GUIDString
				Image.Position = UDim2.new(0, Mouse.X, 0,Mouse.Y)
				Image.ImageColor3 = Theme.Text
				Image.Image = "rbxassetid://10477070900"

				Image:TweenSize(UDim2.new(1.3, 0,1.3, 0),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Linear,
					0.25,
					false
				)

				coroutine.wrap(function()
					while wait() do
						Image.ImageColor3 = Theme.Text
					end
				end)()
			end

			function Elements:Button(ButtonName, Function)

				ButtonName = ButtonName or "Button"
				Function = Function or function() end

				table.insert(Elements, ButtonName)

				local ButtonInstances = {
					Core = Instance.new("Frame"),
					Corner = Instance.new("UICorner"),
					Display = Instance.new("TextLabel"),
					Detector = Instance.new("TextButton")
				}

				ButtonInstances.Core.Name = GUIDString
				ButtonInstances.Core.Parent = TabInstances.Core
				ButtonInstances.Core.AnchorPoint = AnchorPoint
				ButtonInstances.Core.BackgroundColor3 = Theme.Elements
				ButtonInstances.Core.Size = UDim2.new(0.875, 0,0, 45)

				ButtonInstances.Corner.Name = GUIDString
				ButtonInstances.Corner.Parent = ButtonInstances.Core
				ButtonInstances.Corner.CornerRadius = UDim.new(0.15, 0)

				ButtonInstances.Display.Name = GUIDString
				ButtonInstances.Display.Parent = ButtonInstances.Core
				ButtonInstances.Display.AnchorPoint = AnchorPoint
				ButtonInstances.Display.BackgroundTransparency = 1
				ButtonInstances.Display.Position = UDim2.new(0.45, 0,0.5, 0)
				ButtonInstances.Display.Size = UDim2.new(0.865, 0,0.85, 0)
				ButtonInstances.Display.TextScaled = true
				ButtonInstances.Display.TextColor3 = Theme.Text
				ButtonInstances.Display.Text = ButtonName

				ButtonInstances.Display.TextXAlignment = Enum.TextXAlignment.Left
				ButtonInstances.Display.Position = UDim2.new(0.45, 0,0.5, 0)
				ButtonInstances.Display.Font = Enum.Font.SourceSans

				ButtonInstances.Detector.Parent = ButtonInstances.Core
				ButtonInstances.Detector.Name = GUIDString
				ButtonInstances.Detector.AnchorPoint = AnchorPoint
				ButtonInstances.Detector.BackgroundTransparency = 1
				ButtonInstances.Detector.Text = ""
				ButtonInstances.Detector.Position = UDim2.new(0.5, 0,0.5, 0)
				ButtonInstances.Detector.Size = UDim2.new(1, 0,1, 0)
				ButtonInstances.Detector.AutoButtonColor = false
				ButtonInstances.Detector.MouseButton1Click:Connect(function()
					Function()
					ButtonAnimation(ButtonInstances.Core)
				end)
				
				coroutine.wrap(function()
					while wait() do
						ButtonInstances.Core.BackgroundColor3 = Theme.Elements
						ButtonInstances.Display.TextColor3 = Theme.Text
					end
				end)()
			end
			return Elements
		end
		return Sections
	end
	return Tabs
end
return Hubs
