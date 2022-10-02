-- Designing --

local Themes = {
	Dark = {
		Principal = Color3.fromRGB(20, 20, 20),
		Highlight = Color3.fromRGB(86, 69, 213),
		Image = Color3.fromRGB(255, 255, 255),
		Text = Color3.fromRGB(255, 255, 255)
	}
}

local Name
local Theme
local Size

-- Services --

local HttpService = game:GetService("HttpService")
local InputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Instances --

local AnchorPoint = Vector2.new(0.5, 0.5)
local Information = "Undetected"
local PlaceId = game.PlaceId
local StringName = HttpService:GenerateGUID(false)
local Updating = true

-- Archives --

local Modules = {}

local Hubs = {}
local Pages = {}
local Sections = {}
local Elements = {}

-- Modules --

function Modules:GetGame()
	if PlaceId == 4924922222 then
		Information = "Brookhaven | 4924922222"
	end
end

function Modules:DragEnabled(Top, Core)
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
		TweenService:Create(Core, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),{
			Position = Pos
		}):Play()
	end

	Top.InputBegan:Connect(
		function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = Input.Position
				StartPosition = Core.Position

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

	InputService.InputChanged:Connect(
		function(Input)
			if Input == DragInput and Dragging then
				Update(Input)
			end
		end
	)
end

-- Core --

function Hubs:CreateHub(HubInformation)
	Name = HubInformation.Name
	Theme = HubInformation.Theme
	Size = HubInformation.Size
	Name = Name or "Hub"
	Theme = Theme or "Dark"
	Size = Size or table

	Size.X = Size.X or 450
	Size.Y = Size.Y or 300

	if Size.X >= 450 then
		Size.X = 450
	end
	if Size.Y >= 300 then
		Size.Y = 300
	end

	local ElementSize = Size.Y / 10
	local PageFolder = Instance.new("Folder")

	local HubInstances = {
		Library = Instance.new("ScreenGui"),
		Core = Instance.new("Frame"),
		Core_Corner = Instance.new("UICorner"),
		Top = Instance.new("Frame"),
		Title = Instance.new("TextLabel"),
		Information = Instance.new("TextLabel"),
		Side = Instance.new("Frame"),
		PageList = Instance.new("ScrollingFrame"),
		Listing = Instance.new("UIListLayout")
	}

	Theme = Themes[Theme]
	table.insert(Hubs, Name)
	Modules:DragEnabled(HubInstances.Top, HubInstances.Core)
	Modules:DragEnabled(HubInstances.Side, HubInstances.Core)
	Modules:GetGame()

	HubInstances.Core.Position = UDim2.new(0.5, 0,0.5, 0)
	local function TickHub()
		HubInstances.Library.Archivable = true
		HubInstances.Library.DisplayOrder = 0
		HubInstances.Library.Enabled = true
		HubInstances.Library.IgnoreGuiInset = false
		HubInstances.Library.Name = StringName
		HubInstances.Library.Parent = game.Players.LocalPlayer.PlayerGui
		HubInstances.Library.ResetOnSpawn = false
		HubInstances.Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		HubInstances.Library.AutoLocalize = true
		HubInstances.Library.RootLocalizationTable = nil
		HubInstances.Library.SelectionGroup = false

		HubInstances.Core.SelectionImageObject = nil
		HubInstances.Core.Archivable = true
		HubInstances.Core.Active = false
		HubInstances.Core.AnchorPoint = AnchorPoint
		HubInstances.Core.AutomaticSize = Enum.AutomaticSize.None
		HubInstances.Core.BackgroundColor3 = Theme.Principal
		HubInstances.Core.BackgroundTransparency = 0
		HubInstances.Core.BorderColor3 = Theme.Principal
		HubInstances.Core.BorderMode = Enum.BorderMode.Outline
		HubInstances.Core.BorderSizePixel = 0
		HubInstances.Core.LayoutOrder = 0
		HubInstances.Core.Name = StringName
		HubInstances.Core.Parent = HubInstances.Library
		HubInstances.Core.Rotation = 0
		HubInstances.Core.Size = UDim2.new(0, Size.X,0, Size.Y)
		HubInstances.Core.SizeConstraint = Enum.SizeConstraint.RelativeXY
		HubInstances.Core.Style = Enum.FrameStyle.Custom
		HubInstances.Core.Visible = true
		HubInstances.Core.ZIndex = 1
		HubInstances.Core.ClipsDescendants = false
		HubInstances.Core.AutoLocalize = true
		HubInstances.Core.RootLocalizationTable = nil
		HubInstances.Core.NextSelectionDown = nil
		HubInstances.Core.NextSelectionLeft = nil
		HubInstances.Core.NextSelectionRight = nil
		HubInstances.Core.NextSelectionUp = nil
		HubInstances.Core.Selectable = false
		HubInstances.Core.SelectionGroup = false
		HubInstances.Core.SelectionOrder = 0

		HubInstances.Core_Corner.CornerRadius = UDim.new(0, Size.Y / 25)
		HubInstances.Core_Corner.Archivable = true
		HubInstances.Core_Corner.Name = StringName
		HubInstances.Core_Corner.Parent = HubInstances.Core

		HubInstances.Top.SelectionImageObject = nil
		HubInstances.Top.Archivable = true
		HubInstances.Top.Active = false
		HubInstances.Top.AnchorPoint = AnchorPoint
		HubInstances.Top.AutomaticSize = Enum.AutomaticSize.None
		HubInstances.Top.BackgroundColor3 = Theme.Highlight
		HubInstances.Top.BackgroundTransparency = 0
		HubInstances.Top.BorderColor3 = Theme.Highlight
		HubInstances.Top.BorderMode = Enum.BorderMode.Outline
		HubInstances.Top.BorderSizePixel = 0
		HubInstances.Top.LayoutOrder = 0
		HubInstances.Top.Name = StringName
		HubInstances.Top.Parent = HubInstances.Core
		HubInstances.Top.Position = UDim2.new(0.5, 0,0.1, 0)
		HubInstances.Top.Rotation = 0
		HubInstances.Top.Size = UDim2.new(1, 0,0.2, 0)
		HubInstances.Top.SizeConstraint = Enum.SizeConstraint.RelativeXY
		HubInstances.Top.Style = Enum.FrameStyle.Custom
		HubInstances.Top.Visible = true
		HubInstances.Top.ZIndex = 1
		HubInstances.Top.ClipsDescendants = false
		HubInstances.Top.AutoLocalize = true
		HubInstances.Top.RootLocalizationTable = nil
		HubInstances.Top.NextSelectionDown = nil
		HubInstances.Top.NextSelectionLeft = nil
		HubInstances.Top.NextSelectionRight = nil
		HubInstances.Top.NextSelectionUp = nil
		HubInstances.Top.Selectable = false
		HubInstances.Top.SelectionGroup = false
		HubInstances.Top.SelectionOrder = 0

		HubInstances.Title.SelectionImageObject = nil
		HubInstances.Title.Active = true
		HubInstances.Title.AnchorPoint = AnchorPoint
		HubInstances.Title.AutomaticSize = Enum.AutomaticSize.None
		HubInstances.Title.BackgroundColor3 = Theme.Highlight
		HubInstances.Title.BackgroundTransparency = 1
		HubInstances.Title.BorderColor3 = Theme.Highlight
		HubInstances.Title.BorderMode = Enum.BorderMode.Outline
		HubInstances.Title.BorderSizePixel = 0
		HubInstances.Title.LayoutOrder = 0
		HubInstances.Title.Name = StringName
		HubInstances.Title.Parent = HubInstances.Top
		HubInstances.Title.Position = UDim2.new(0.425, 0,0.375, 0)
		HubInstances.Title.Rotation = 0
		HubInstances.Title.Size = UDim2.new(0.825, 0,0.6, 0)
		HubInstances.Title.SizeConstraint = Enum.SizeConstraint.RelativeXY
		HubInstances.Title.Visible = true
		HubInstances.Title.ZIndex = 1
		HubInstances.Title.ClipsDescendants = false
		HubInstances.Title.AutoLocalize = true
		HubInstances.Title.RootLocalizationTable = nil
		HubInstances.Title.NextSelectionDown = nil
		HubInstances.Title.NextSelectionLeft = nil
		HubInstances.Title.NextSelectionRight = nil
		HubInstances.Title.NextSelectionUp = nil
		HubInstances.Title.Selectable = false
		HubInstances.Title.SelectionGroup = false
		HubInstances.Title.SelectionOrder = 0
		HubInstances.Title.Font = Enum.Font.SciFi
		HubInstances.Title.LineHeight = 1
		HubInstances.Title.MaxVisibleGraphemes = -1
		HubInstances.Title.RichText = false
		HubInstances.Title.Text = Name
		HubInstances.Title.TextColor3 = Theme.Text
		HubInstances.Title.TextScaled = true
		HubInstances.Title.TextSize = 1
		HubInstances.Title.TextStrokeColor3 = Theme.Text
		HubInstances.Title.TextStrokeTransparency = 1
		HubInstances.Title.TextTransparency = 0
		HubInstances.Title.TextTruncate = Enum.TextTruncate.None
		HubInstances.Title.TextWrapped = true
		HubInstances.Title.TextXAlignment = Enum.TextXAlignment.Left
		HubInstances.Title.TextYAlignment = Enum.TextYAlignment.Center

		HubInstances.Information.SelectionImageObject = nil
		HubInstances.Information.Active = true
		HubInstances.Information.AnchorPoint = AnchorPoint
		HubInstances.Information.AutomaticSize = Enum.AutomaticSize.None
		HubInstances.Information.BackgroundColor3 = Theme.Highlight
		HubInstances.Information.BackgroundTransparency = 1
		HubInstances.Information.BorderColor3 = Theme.Highlight
		HubInstances.Information.BorderMode = Enum.BorderMode.Outline
		HubInstances.Information.BorderSizePixel = 0
		HubInstances.Information.LayoutOrder = 0
		HubInstances.Information.Name = StringName
		HubInstances.Information.Parent = HubInstances.Top
		HubInstances.Information.Position = UDim2.new(0.425, 0,0.815, 0)
		HubInstances.Information.Rotation = 0
		HubInstances.Information.Size = UDim2.new(0.825, 0,0.35, 0)
		HubInstances.Information.SizeConstraint = Enum.SizeConstraint.RelativeXY
		HubInstances.Information.Visible = true
		HubInstances.Information.ZIndex = 1
		HubInstances.Information.ClipsDescendants = false
		HubInstances.Information.AutoLocalize = true
		HubInstances.Information.RootLocalizationTable = nil
		HubInstances.Information.NextSelectionDown = nil
		HubInstances.Information.NextSelectionLeft = nil
		HubInstances.Information.NextSelectionRight = nil
		HubInstances.Information.NextSelectionUp = nil
		HubInstances.Information.Selectable = false
		HubInstances.Information.SelectionGroup = false
		HubInstances.Information.SelectionOrder = 0
		HubInstances.Information.Font = Enum.Font.SciFi
		HubInstances.Information.LineHeight = 1
		HubInstances.Information.MaxVisibleGraphemes = -1
		HubInstances.Information.RichText = false
		HubInstances.Information.Text = Information
		HubInstances.Information.TextColor3 = Theme.Text
		HubInstances.Information.TextScaled = true
		HubInstances.Information.TextSize = 1
		HubInstances.Information.TextStrokeColor3 = Theme.Text
		HubInstances.Information.TextStrokeTransparency = 1
		HubInstances.Information.TextTransparency = 0
		HubInstances.Information.TextTruncate = Enum.TextTruncate.None
		HubInstances.Information.TextWrapped = true
		HubInstances.Information.TextXAlignment = Enum.TextXAlignment.Left
		HubInstances.Information.TextYAlignment = Enum.TextYAlignment.Center

		HubInstances.Side.SelectionImageObject = nil
		HubInstances.Side.Archivable = true
		HubInstances.Side.Active = false
		HubInstances.Side.AnchorPoint = AnchorPoint
		HubInstances.Side.AutomaticSize = Enum.AutomaticSize.None
		HubInstances.Side.BackgroundColor3 = Theme.Highlight
		HubInstances.Side.BackgroundTransparency = 0
		HubInstances.Side.BorderColor3 = Theme.Highlight
		HubInstances.Side.BorderMode = Enum.BorderMode.Outline
		HubInstances.Side.BorderSizePixel = 0
		HubInstances.Side.LayoutOrder = 0
		HubInstances.Side.Name = StringName
		HubInstances.Side.Parent = HubInstances.Core
		HubInstances.Side.Position = UDim2.new(0.175, 0,0.6, 0)
		HubInstances.Side.Rotation = 0
		HubInstances.Side.Size = UDim2.new(0.35, 0,0.8, 0)
		HubInstances.Side.SizeConstraint = Enum.SizeConstraint.RelativeXY
		HubInstances.Side.Style = Enum.FrameStyle.Custom
		HubInstances.Side.Visible = true
		HubInstances.Side.ZIndex = 1
		HubInstances.Side.ClipsDescendants = false
		HubInstances.Side.AutoLocalize = true
		HubInstances.Side.RootLocalizationTable = nil
		HubInstances.Side.NextSelectionDown = nil
		HubInstances.Side.NextSelectionLeft = nil
		HubInstances.Side.NextSelectionRight = nil
		HubInstances.Side.NextSelectionUp = nil
		HubInstances.Side.Selectable = false
		HubInstances.Side.SelectionGroup = false
		HubInstances.Side.SelectionOrder = 0

		HubInstances.PageList.SelectionImageObject = nil
		HubInstances.PageList.Archivable = true
		HubInstances.PageList.Active = false
		HubInstances.PageList.AnchorPoint = AnchorPoint
		HubInstances.PageList.AutomaticSize = Enum.AutomaticSize.None
		HubInstances.PageList.BackgroundColor3 = Theme.Highlight
		HubInstances.PageList.BackgroundTransparency = 1
		HubInstances.PageList.BorderColor3 = Theme.Highlight
		HubInstances.PageList.BorderMode = Enum.BorderMode.Outline
		HubInstances.PageList.BorderSizePixel = 0
		HubInstances.PageList.LayoutOrder = 0
		HubInstances.PageList.Name = StringName
		HubInstances.PageList.Parent = HubInstances.Side
		HubInstances.PageList.Position = UDim2.new(0.5, 0,0.5, 0)
		HubInstances.PageList.Rotation = 0
		HubInstances.PageList.Size = UDim2.new(0.9, 0,0.875, 0) 
		HubInstances.PageList.SizeConstraint = Enum.SizeConstraint.RelativeXY
		HubInstances.PageList.Visible = true
		HubInstances.PageList.ZIndex = 1
		HubInstances.PageList.ClipsDescendants = true
		HubInstances.PageList.AutoLocalize = true
		HubInstances.PageList.RootLocalizationTable = nil
		HubInstances.PageList.AutomaticCanvasSize = Enum.AutomaticSize.None
		HubInstances.PageList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
		HubInstances.PageList.CanvasSize = UDim2.new(0, 0,0, 0)
		HubInstances.PageList.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		HubInstances.PageList.HorizontalScrollBarInset = Enum.ScrollBarInset.None
		HubInstances.PageList.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		HubInstances.PageList.ScrollBarImageColor3 = Theme.Image
		HubInstances.PageList.ScrollBarImageTransparency = 0
		HubInstances.PageList.ScrollBarThickness = Size.X / 100
		HubInstances.PageList.ScrollingDirection = Enum.ScrollingDirection.XY
		HubInstances.PageList.ScrollingEnabled = true
		HubInstances.PageList.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
		HubInstances.PageList.VerticalScrollBarInset = Enum.ScrollBarInset.None
		HubInstances.PageList.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
		HubInstances.PageList.NextSelectionDown = nil
		HubInstances.PageList.NextSelectionLeft = nil
		HubInstances.PageList.NextSelectionRight = nil
		HubInstances.PageList.NextSelectionUp = nil
		HubInstances.PageList.Selectable = true
		HubInstances.PageList.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
		HubInstances.PageList.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
		HubInstances.PageList.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
		HubInstances.PageList.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
		HubInstances.PageList.SelectionGroup = true
		HubInstances.PageList.SelectionOrder = 0

		HubInstances.Listing.Padding = UDim.new(0, ElementSize / 6)
		HubInstances.Listing.Archivable = true
		HubInstances.Listing.Name = StringName
		HubInstances.Listing.Parent = HubInstances.PageList
		HubInstances.Listing.FillDirection = Enum.FillDirection.Vertical
		HubInstances.Listing.HorizontalAlignment = Enum.HorizontalAlignment.Center
		HubInstances.Listing.SortOrder = Enum.SortOrder.LayoutOrder
		HubInstances.Listing.VerticalAlignment = Enum.VerticalAlignment.Top

		PageFolder.Archivable = true
		PageFolder.Name = StringName
		PageFolder.Parent = HubInstances.Library
		for i, Page in pairs(PageFolder:GetChildren()) do
			Page.Visible = false
		end

		local function UpdateSize()
			local TotalSize = HubInstances.Listing.AbsoluteContentSize.Y

			HubInstances.PageList.CanvasSize = UDim2.new(0, 0,0, TotalSize)
		end
		UpdateSize()

		HubInstances.PageList.ChildRemoved:Connect(UpdateSize)
		HubInstances.PageList.ChildAdded:Connect(UpdateSize)
	end
	TickHub()

	RunService.Heartbeat:Connect(function()
		if Updating == true then
			TickHub()
			StringName = HttpService:GenerateGUID(false)
		else
			return
		end
	end)

	local Primary = true
	local Selected

	function Pages:NewPage(PageInformation)
		local PageName = PageInformation.Name
		local PageIcon = PageInformation.Icon
		PageName = PageName or "Page"
		PageIcon = PageIcon or "rbxassetid://2790558331"

		local TabInstances = {
			Core = Instance.new("Frame"),
			Corner = Instance.new("UICorner"),
			Detector = Instance.new("TextButton"),
			Icon = Instance.new("ImageLabel"),
			Display = Instance.new("TextLabel")
		}

		local PageInstances = {
			Core = Instance.new("ScrollingFrame"),
			List = Instance.new("UIListLayout"),
			Padding = Instance.new("UIPadding")
		}

		table.insert(Pages, PageName)
		TabInstances.Core.Parent = HubInstances.PageList
		local function TickPage()
			TabInstances.Core.SelectionImageObject = nil
			TabInstances.Core.Archivable = true
			TabInstances.Core.Active = false
			TabInstances.Core.AnchorPoint = AnchorPoint
			TabInstances.Core.AutomaticSize = Enum.AutomaticSize.None
			TabInstances.Core.BackgroundColor3 = Theme.Principal
			TabInstances.Core.BackgroundTransparency = 0
			TabInstances.Core.BorderColor3 = Theme.Principal
			TabInstances.Core.BorderMode = Enum.BorderMode.Outline
			TabInstances.Core.BorderSizePixel = 0
			TabInstances.Core.LayoutOrder = 0
			TabInstances.Core.Name = StringName
			TabInstances.Core.Rotation = 0
			TabInstances.Core.Size = UDim2.new(0.9, 0,0, ElementSize)
			TabInstances.Core.SizeConstraint = Enum.SizeConstraint.RelativeXY
			TabInstances.Core.Style = Enum.FrameStyle.Custom
			TabInstances.Core.Visible = true
			TabInstances.Core.ZIndex = 1
			TabInstances.Core.ClipsDescendants = false
			TabInstances.Core.AutoLocalize = true
			TabInstances.Core.RootLocalizationTable = nil
			TabInstances.Core.NextSelectionDown = nil
			TabInstances.Core.NextSelectionLeft = nil
			TabInstances.Core.NextSelectionRight = nil
			TabInstances.Core.NextSelectionUp = nil
			TabInstances.Core.Selectable = false
			TabInstances.Core.SelectionGroup = false
			TabInstances.Core.SelectionOrder = 0

			TabInstances.Corner.CornerRadius = UDim.new(0.2, 0)
			TabInstances.Corner.Archivable = true
			TabInstances.Corner.Name = StringName
			TabInstances.Corner.Parent = TabInstances.Core

			TabInstances.Detector.SelectionImageObject = nil
			TabInstances.Detector.Archivable = true
			TabInstances.Detector.Active = true
			TabInstances.Detector.AnchorPoint = AnchorPoint
			TabInstances.Detector.AutoButtonColor = false
			TabInstances.Detector.AutomaticSize = Enum.AutomaticSize.None
			TabInstances.Detector.BackgroundColor3 = Theme.Principal
			TabInstances.Detector.BackgroundTransparency = 1
			TabInstances.Detector.BorderColor3 = Theme.Principal
			TabInstances.Detector.BorderMode = Enum.BorderMode.Outline
			TabInstances.Detector.BorderSizePixel = 0
			TabInstances.Detector.LayoutOrder = 0
			TabInstances.Detector.Modal = false
			TabInstances.Detector.Name = StringName
			TabInstances.Detector.Parent = TabInstances.Core
			TabInstances.Detector.Position = UDim2.new(0.5, 0,0.5, 0)
			TabInstances.Detector.Rotation = UDim2.new(0.5, 0,0.5, 0)
			TabInstances.Detector.Selected = false
			TabInstances.Detector.Size = UDim2.new(0.9, 0,0.9, 0)
			TabInstances.Detector.SizeConstraint = Enum.SizeConstraint.RelativeXY
			TabInstances.Detector.Style = Enum.ButtonStyle.Custom
			TabInstances.Detector.Visible = true
			TabInstances.Detector.ZIndex = 0
			TabInstances.Detector.ClipsDescendants = false
			TabInstances.Detector.AutoLocalize = true
			TabInstances.Detector.RootLocalizationTable = nil
			TabInstances.Detector.NextSelectionDown = nil
			TabInstances.Detector.NextSelectionLeft = nil
			TabInstances.Detector.NextSelectionRight = nil
			TabInstances.Detector.NextSelectionUp = nil
			TabInstances.Detector.Selectable = false
			TabInstances.Detector.SelectionGroup = false
			TabInstances.Detector.SelectionOrder = 0
			TabInstances.Detector.Font = Enum.Font.AmaticSC
			TabInstances.Detector.LineHeight = 3
			TabInstances.Detector.MaxVisibleGraphemes = -1
			TabInstances.Detector.RichText = false
			TabInstances.Detector.TextColor3 = Theme.Principal
			TabInstances.Detector.TextScaled = false
			TabInstances.Detector.TextSize = 1
			TabInstances.Detector.TextStrokeColor3 = Theme.Principal
			TabInstances.Detector.TextStrokeTransparency = 1
			TabInstances.Detector.TextTransparency = 1
			TabInstances.Detector.TextTruncate = Enum.TextTruncate.None
			TabInstances.Detector.TextWrapped = false
			TabInstances.Detector.TextXAlignment = Enum.TextXAlignment.Center
			TabInstances.Detector.TextYAlignment = Enum.TextYAlignment.Center

			TabInstances.Icon.SelectionImageObject = nil
			TabInstances.Icon.Active = false
			TabInstances.Icon.AnchorPoint = AnchorPoint
			TabInstances.Icon.AutomaticSize = Enum.AutomaticSize.None
			TabInstances.Icon.BackgroundColor3 = Theme.Principal
			TabInstances.Icon.BackgroundTransparency = 1
			TabInstances.Icon.BorderColor3 = Theme.Principal
			TabInstances.Icon.BorderMode = Enum.BorderMode.Outline
			TabInstances.Icon.BorderSizePixel = 0
			TabInstances.Icon.LayoutOrder = 0
			TabInstances.Icon.Name = StringName
			TabInstances.Icon.Parent = TabInstances.Core
			TabInstances.Icon.Position = UDim2.new(0.125, 0,0.5, 0)
			TabInstances.Icon.Rotation = 0
			TabInstances.Icon.Size = UDim2.new(0, ElementSize / 1.5, 0,ElementSize / 1.5)
			TabInstances.Icon.SizeConstraint = Enum.SizeConstraint.RelativeXY
			TabInstances.Icon.Visible = true
			TabInstances.Icon.ZIndex = 1
			TabInstances.Icon.ClipsDescendants = false
			TabInstances.Icon.Image = PageIcon
			TabInstances.Icon.ImageColor3 = Theme.Image
			TabInstances.Icon.ImageRectOffset = Vector2.new(0, 0)
			TabInstances.Icon.ImageRectSize = Vector2.new(0, 0)
			TabInstances.Icon.ImageTransparency = 0.5
			TabInstances.Icon.ResampleMode = Enum.ResamplerMode.Default
			TabInstances.Icon.ScaleType = Enum.ScaleType.Stretch
			TabInstances.Icon.SliceScale = 1
			TabInstances.Icon.AutoLocalize = true
			TabInstances.Icon.RootLocalizationTable = nil
			TabInstances.Icon.NextSelectionDown = nil
			TabInstances.Icon.NextSelectionLeft = nil
			TabInstances.Icon.NextSelectionRight = nil
			TabInstances.Icon.NextSelectionUp = nil
			TabInstances.Icon.Selectable = false
			TabInstances.Icon.SelectionGroup = false
			TabInstances.Icon.SelectionOrder = 0

			TabInstances.Display.SelectionImageObject = nil
			TabInstances.Display.Active = true
			TabInstances.Display.AnchorPoint = AnchorPoint
			TabInstances.Display.AutomaticSize = Enum.AutomaticSize.None
			TabInstances.Display.BackgroundColor3 = Theme.Principal
			TabInstances.Display.BackgroundTransparency = 1
			TabInstances.Display.BorderColor3 = Theme.Principal
			TabInstances.Display.BorderMode = Enum.BorderMode.Outline
			TabInstances.Display.BorderSizePixel = 0
			TabInstances.Display.LayoutOrder = 0
			TabInstances.Display.Name = StringName
			TabInstances.Display.Parent = TabInstances.Core
			TabInstances.Display.Position = UDim2.new(0.6, 0,0.5, 0)
			TabInstances.Display.Rotation = 0
			TabInstances.Display.Size = UDim2.new(0.7, 0,0.75, 0)
			TabInstances.Display.SizeConstraint = Enum.SizeConstraint.RelativeXY
			TabInstances.Display.Visible = true
			TabInstances.Display.ZIndex = 1
			TabInstances.Display.ClipsDescendants = false
			TabInstances.Display.AutoLocalize = true
			TabInstances.Display.RootLocalizationTable = nil
			TabInstances.Display.NextSelectionDown = nil
			TabInstances.Display.NextSelectionLeft = nil
			TabInstances.Display.NextSelectionRight = nil
			TabInstances.Display.NextSelectionUp = nil
			TabInstances.Display.Selectable = false
			TabInstances.Display.SelectionGroup = false
			TabInstances.Display.SelectionOrder = 0
			TabInstances.Display.Font = Enum.Font.SciFi
			TabInstances.Display.LineHeight = 1
			TabInstances.Display.MaxVisibleGraphemes = -1
			TabInstances.Display.RichText = false
			TabInstances.Display.Text = PageName
			TabInstances.Display.TextColor3 = Theme.Text
			TabInstances.Display.TextScaled = true
			TabInstances.Display.TextSize = 1
			TabInstances.Display.TextStrokeColor3 = Theme.Text
			TabInstances.Display.TextStrokeTransparency = 1
			TabInstances.Display.TextTransparency = 0.5
			TabInstances.Display.TextTruncate = Enum.TextTruncate.None
			TabInstances.Display.TextWrapped = true
			TabInstances.Display.TextXAlignment = Enum.TextXAlignment.Left
			TabInstances.Display.TextYAlignment = Enum.TextYAlignment.Center

			PageInstances.Core.SelectionImageObject = nil
			PageInstances.Core.Archivable = true
			PageInstances.Core.Active = false
			PageInstances.Core.AnchorPoint = AnchorPoint
			PageInstances.Core.AutomaticSize = Enum.AutomaticSize.None
			PageInstances.Core.BackgroundColor3 = Theme.Highlight
			PageInstances.Core.BackgroundTransparency = 0
			PageInstances.Core.BorderColor3 = Theme.Highlight
			PageInstances.Core.BorderMode = Enum.BorderMode.Outline
			PageInstances.Core.BorderSizePixel = 0
			PageInstances.Core.LayoutOrder = 0
			PageInstances.Core.Name = StringName
			PageInstances.Core.Parent = PageFolder
			PageInstances.Core.Position = UDim2.new(0.675, 0,0.6, 0)
			PageInstances.Core.Rotation = 0
			PageInstances.Core.Size = UDim2.new(0.6, 0,0.725, 0) 
			PageInstances.Core.SizeConstraint = Enum.SizeConstraint.RelativeXY
			PageInstances.Core.Visible = true
			PageInstances.Core.ZIndex = 1
			PageInstances.Core.ClipsDescendants = true
			PageInstances.Core.AutoLocalize = false
			PageInstances.Core.RootLocalizationTable = nil
			PageInstances.Core.AutomaticCanvasSize = Enum.AutomaticSize.None
			PageInstances.Core.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
			PageInstances.Core.CanvasSize = UDim2.new(0, 0,0, 0)
			PageInstances.Core.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
			PageInstances.Core.HorizontalScrollBarInset = Enum.ScrollBarInset.None
			PageInstances.Core.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			PageInstances.Core.ScrollBarImageColor3 = Theme.Image
			PageInstances.Core.ScrollBarImageTransparency = 0
			PageInstances.Core.ScrollBarThickness = Size.X / 100
			PageInstances.Core.ScrollingEnabled = true
			PageInstances.Core.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
			PageInstances.Core.VerticalScrollBarInset = Enum.ScrollBarInset.None
			PageInstances.Core.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
			PageInstances.Core.NextSelectionDown = nil
			PageInstances.Core.NextSelectionLeft = nil
			PageInstances.Core.NextSelectionRight = nil
			PageInstances.Core.NextSelectionUp = nil
			PageInstances.Core.Selectable = true
			PageInstances.Core.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
			PageInstances.Core.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
			PageInstances.Core.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
			PageInstances.Core.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
			PageInstances.Core.SelectionGroup = true
			PageInstances.Core.SelectionOrder = 0

			PageInstances.List.Padding = UDim.new(0, Size.X / 100)
			PageInstances.List.Archivable = true
			PageInstances.List.Name = StringName
			PageInstances.List.Parent = PageInstances.Core
			PageInstances.List.FillDirection = Enum.FillDirection.Vertical
			PageInstances.List.HorizontalAlignment = Enum.HorizontalAlignment.Center
			PageInstances.List.SortOrder = Enum.SortOrder.LayoutOrder
			PageInstances.List.VerticalAlignment = Enum.VerticalAlignment.Top

			PageInstances.Padding.Archivable = true
			PageInstances.Padding.Name = StringName
			PageInstances.Padding.Parent = PageInstances.Core
			PageInstances.Padding.PaddingBottom = UDim.new(0, 0)
			PageInstances.Padding.PaddingLeft = UDim.new(0, -Size.X / 60)
			PageInstances.Padding.PaddingRight = UDim.new(0, 0)
			PageInstances.Padding.PaddingTop = UDim.new(0, Size.X / 100)

			local function UpdateSize()
				local Size = PageInstances.List.AbsoluteContentSize.Y

				PageInstances.Core.CanvasSize = UDim2.new(0, 0,0, Size)
			end

			UpdateSize()

			if Primary then
				Selected = PageName
				Primary = false
			end

			TabInstances.Detector.MouseButton1Click:Connect(function()
				Selected = PageName
			end)

			if Selected == PageName then
				for i, Variable in pairs(HubInstances.Core:GetChildren()) do
					if Variable:IsA("ScrollingFrame") then
						Variable.Parent = PageFolder
					end
				end

				TabInstances.Display.TextTransparency = 0
				TabInstances.Icon.ImageTransparency = 0
				PageInstances.Core.Parent = HubInstances.Core
			end
		end
		TickPage()

		RunService.Heartbeat:Connect(function()
			if Updating == true then
				TickPage()
			else
				return
			end
		end)

		function Sections:NewSection(SectionInformation)
			local SectionName = SectionInformation.Name
			local SectionIcon = SectionInformation.Icon
			SectionName = SectionName or "Section"
			SectionIcon = SectionIcon or "rbxassetid://6023426974"

			local SectionInstances = {
				Core = Instance.new("Frame"),
				Display = Instance.new("TextLabel"),
				Icon = Instance.new("ImageLabel")
			}

			SectionInstances.Core.Parent = PageInstances.Core
			local function TickSection()
				SectionInstances.Core.SelectionImageObject = nil
				SectionInstances.Core.Archivable = true
				SectionInstances.Core.Active = false
				SectionInstances.Core.AnchorPoint = AnchorPoint
				SectionInstances.Core.AutomaticSize = Enum.AutomaticSize.None
				SectionInstances.Core.BackgroundColor3 = Theme.Highlight
				SectionInstances.Core.BackgroundTransparency = 1
				SectionInstances.Core.BorderColor3 = Theme.Highlight
				SectionInstances.Core.BorderMode = Enum.BorderMode.Outline
				SectionInstances.Core.BorderSizePixel = 0
				SectionInstances.Core.LayoutOrder = 0
				SectionInstances.Core.Name = StringName 
				SectionInstances.Core.Rotation = 0
				SectionInstances.Core.Size = UDim2.new(0.925, 0,0, ElementSize / 1.2)
				SectionInstances.Core.SizeConstraint = Enum.SizeConstraint.RelativeXY
				SectionInstances.Core.Style = Enum.FrameStyle.Custom
				SectionInstances.Core.Visible = true
				SectionInstances.Core.ZIndex = 1
				SectionInstances.Core.ClipsDescendants = false
				SectionInstances.Core.AutoLocalize = true
				SectionInstances.Core.RootLocalizationTable = nil
				SectionInstances.Core.NextSelectionDown = nil
				SectionInstances.Core.NextSelectionLeft = nil
				SectionInstances.Core.NextSelectionRight = nil
				SectionInstances.Core.NextSelectionUp = nil
				SectionInstances.Core.Selectable = false
				SectionInstances.Core.SelectionGroup = false
				SectionInstances.Core.SelectionOrder = 0

				SectionInstances.Display.SelectionImageObject = nil
				SectionInstances.Display.Active = true
				SectionInstances.Display.AnchorPoint = AnchorPoint
				SectionInstances.Display.AutomaticSize = Enum.AutomaticSize.None
				SectionInstances.Display.BackgroundColor3 = Theme.Highlight
				SectionInstances.Display.BackgroundTransparency = 1
				SectionInstances.Display.BorderColor3 = Theme.Highlight
				SectionInstances.Display.BorderMode = Enum.BorderMode.Outline
				SectionInstances.Display.BorderSizePixel = 0
				SectionInstances.Display.LayoutOrder = 0
				SectionInstances.Display.Name = StringName
				SectionInstances.Display.Parent = SectionInstances.Core
				SectionInstances.Display.Position = UDim2.new(0.5, 0,0.5, 0)
				SectionInstances.Display.Rotation = 0
				SectionInstances.Display.Size = UDim2.new(0.975, 0,0.8, 0)
				SectionInstances.Display.SizeConstraint = Enum.SizeConstraint.RelativeXY
				SectionInstances.Display.Visible = true
				SectionInstances.Display.ZIndex = 1
				SectionInstances.Display.ClipsDescendants = false
				SectionInstances.Display.AutoLocalize = true
				SectionInstances.Display.RootLocalizationTable = nil
				SectionInstances.Display.NextSelectionDown = nil
				SectionInstances.Display.NextSelectionLeft = nil
				SectionInstances.Display.NextSelectionRight = nil
				SectionInstances.Display.NextSelectionUp = nil
				SectionInstances.Display.Selectable = false
				SectionInstances.Display.SelectionGroup = false
				SectionInstances.Display.SelectionOrder = 0
				SectionInstances.Display.Font = Enum.Font.FredokaOne
				SectionInstances.Display.LineHeight = 1
				SectionInstances.Display.MaxVisibleGraphemes = -1
				SectionInstances.Display.RichText = false
				SectionInstances.Display.Text = SectionName
				SectionInstances.Display.TextColor3 = Theme.Text
				SectionInstances.Display.TextScaled = true
				SectionInstances.Display.TextSize = 1
				SectionInstances.Display.TextStrokeColor3 = Theme.Text
				SectionInstances.Display.TextStrokeTransparency = 1
				SectionInstances.Display.TextTransparency = 0
				SectionInstances.Display.TextTruncate = Enum.TextTruncate.None
				SectionInstances.Display.TextWrapped = true
				SectionInstances.Display.TextXAlignment = Enum.TextXAlignment.Left
				SectionInstances.Display.TextYAlignment = Enum.TextYAlignment.Center

				SectionInstances.Icon.SelectionImageObject = nil
				SectionInstances.Icon.Active = false
				SectionInstances.Icon.AnchorPoint = AnchorPoint
				SectionInstances.Icon.AutomaticSize = Enum.AutomaticSize.None
				SectionInstances.Icon.BackgroundColor3 = Theme.Highlight
				SectionInstances.Icon.BackgroundTransparency = 1
				SectionInstances.Icon.BorderColor3 = Theme.Highlight
				SectionInstances.Icon.BorderMode = Enum.BorderMode.Outline
				SectionInstances.Icon.BorderSizePixel = 0
				SectionInstances.Icon.LayoutOrder = 0
				SectionInstances.Icon.Name = StringName
				SectionInstances.Icon.Parent = SectionInstances.Core
				SectionInstances.Icon.Position = UDim2.new(0, 0,0.5, 0)
				SectionInstances.Icon.Rotation = 0
				SectionInstances.Icon.Size = UDim2.new(0, ElementSize / 1.5, 0,ElementSize / 1.5)
				SectionInstances.Icon.SizeConstraint = Enum.SizeConstraint.RelativeXY
				SectionInstances.Icon.Visible = true
				SectionInstances.Icon.ZIndex = 1
				SectionInstances.Icon.ClipsDescendants = true
				SectionInstances.Icon.Image = SectionIcon
				SectionInstances.Icon.ImageColor3 = Theme.Image
				SectionInstances.Icon.ImageRectOffset = Vector2.new(0, 0)
				SectionInstances.Icon.ImageRectSize = Vector2.new(0, 0)
				SectionInstances.Icon.ImageTransparency = 0
				SectionInstances.Icon.ResampleMode = Enum.ResamplerMode.Default
				SectionInstances.Icon.ScaleType = Enum.ScaleType.Stretch
				SectionInstances.Icon.SliceScale = 1
				SectionInstances.Icon.AutoLocalize = true
				SectionInstances.Icon.RootLocalizationTable = nil
				SectionInstances.Icon.NextSelectionDown = nil
				SectionInstances.Icon.NextSelectionLeft = nil
				SectionInstances.Icon.NextSelectionRight = nil
				SectionInstances.Icon.NextSelectionUp = nil
				SectionInstances.Icon.Selectable = false
				SectionInstances.Icon.SelectionGroup = false
				SectionInstances.Icon.SelectionOrder = 0

				local function UpdateSize()
					local Size = SectionInstances.Display.TextBounds.X + 20
					SectionInstances.Icon.Position = UDim2.new(0, Size,0.5, 0)
				end

				UpdateSize()
			end

			RunService.Heartbeat:Connect(function()
				if Updating == true then
					TickSection()
				else
					return
				end
			end)

			function Elements:Button(ButtonInformation)
				local ButtonName = ButtonInformation.Name
				local ButtonFunction = ButtonInformation.Function
				ButtonName = ButtonName or "Button"
				ButtonFunction = ButtonFunction or function() end

				local ButtonInstances = {
					Core = Instance.new("Frame"),
					Corner = Instance.new("UICorner"),
					Detector = Instance.new("TextButton"),
					Icon = Instance.new("ImageLabel"),
					Display = Instance.new("TextLabel")
				}

				table.insert(Elements, ButtonName)
				ButtonInstances.Core.Parent = PageInstances.Core
				local function TickElement()
					ButtonInstances.Core.SelectionImageObject = nil
					ButtonInstances.Core.Archivable = true
					ButtonInstances.Core.Active = false
					ButtonInstances.Core.AnchorPoint = AnchorPoint
					ButtonInstances.Core.AutomaticSize = Enum.AutomaticSize.None
					ButtonInstances.Core.BackgroundColor3 = Theme.Principal
					ButtonInstances.Core.BackgroundTransparency = 0
					ButtonInstances.Core.BorderColor3 = Theme.Principal
					ButtonInstances.Core.BorderMode = Enum.BorderMode.Outline
					ButtonInstances.Core.BorderSizePixel = 0
					ButtonInstances.Core.LayoutOrder = 0
					ButtonInstances.Core.Name = StringName
					ButtonInstances.Core.Rotation = 0
					ButtonInstances.Core.Size = UDim2.new(0.925, 0,0, ElementSize)
					ButtonInstances.Core.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ButtonInstances.Core.Style = Enum.FrameStyle.Custom
					ButtonInstances.Core.Visible = true
					ButtonInstances.Core.ZIndex = 1
					ButtonInstances.Core.ClipsDescendants = false
					ButtonInstances.Core.AutoLocalize = true
					ButtonInstances.Core.RootLocalizationTable = nil
					ButtonInstances.Core.NextSelectionDown = nil
					ButtonInstances.Core.NextSelectionLeft = nil
					ButtonInstances.Core.NextSelectionRight = nil
					ButtonInstances.Core.NextSelectionUp = nil
					ButtonInstances.Core.Selectable = false
					ButtonInstances.Core.SelectionGroup = false
					ButtonInstances.Core.SelectionOrder = 0

					ButtonInstances.Corner.CornerRadius = UDim.new(0.2, 0)
					ButtonInstances.Corner.Archivable = true
					ButtonInstances.Corner.Name = StringName
					ButtonInstances.Corner.Parent = ButtonInstances.Core

					ButtonInstances.Detector.SelectionImageObject = nil
					ButtonInstances.Detector.Archivable = true
					ButtonInstances.Detector.Active = true
					ButtonInstances.Detector.AnchorPoint = AnchorPoint
					ButtonInstances.Detector.AutoButtonColor = false
					ButtonInstances.Detector.AutomaticSize = Enum.AutomaticSize.None
					ButtonInstances.Detector.BackgroundColor3 = Theme.Principal
					ButtonInstances.Detector.BackgroundTransparency = 1
					ButtonInstances.Detector.BorderColor3 = Theme.Principal
					ButtonInstances.Detector.BorderMode = Enum.BorderMode.Outline
					ButtonInstances.Detector.BorderSizePixel = 0
					ButtonInstances.Detector.LayoutOrder = 0
					ButtonInstances.Detector.Modal = false
					ButtonInstances.Detector.Name = StringName
					ButtonInstances.Detector.Parent = ButtonInstances.Core
					ButtonInstances.Detector.Position = UDim2.new(0.5, 0,0.5, 0)
					ButtonInstances.Detector.Rotation = UDim2.new(0.5, 0,0.5, 0)
					ButtonInstances.Detector.Selected = false
					ButtonInstances.Detector.Size = UDim2.new(0.9, 0,0.9, 0)
					ButtonInstances.Detector.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ButtonInstances.Detector.Style = Enum.ButtonStyle.Custom
					ButtonInstances.Detector.Visible = true
					ButtonInstances.Detector.ZIndex = 0
					ButtonInstances.Detector.ClipsDescendants = false
					ButtonInstances.Detector.AutoLocalize = true
					ButtonInstances.Detector.RootLocalizationTable = nil
					ButtonInstances.Detector.NextSelectionDown = nil
					ButtonInstances.Detector.NextSelectionLeft = nil
					ButtonInstances.Detector.NextSelectionRight = nil
					ButtonInstances.Detector.NextSelectionUp = nil
					ButtonInstances.Detector.Selectable = false
					ButtonInstances.Detector.SelectionGroup = false
					ButtonInstances.Detector.SelectionOrder = 0
					ButtonInstances.Detector.Font = Enum.Font.AmaticSC
					ButtonInstances.Detector.LineHeight = 3
					ButtonInstances.Detector.MaxVisibleGraphemes = -1
					ButtonInstances.Detector.RichText = false
					ButtonInstances.Detector.TextColor3 = Theme.Principal
					ButtonInstances.Detector.TextScaled = false
					ButtonInstances.Detector.TextSize = 1
					ButtonInstances.Detector.TextStrokeColor3 = Theme.Principal
					ButtonInstances.Detector.TextStrokeTransparency = 1
					ButtonInstances.Detector.TextTransparency = 1
					ButtonInstances.Detector.TextTruncate = Enum.TextTruncate.None
					ButtonInstances.Detector.TextWrapped = false
					ButtonInstances.Detector.TextXAlignment = Enum.TextXAlignment.Center
					ButtonInstances.Detector.TextYAlignment = Enum.TextYAlignment.Center

					ButtonInstances.Icon.SelectionImageObject = nil
					ButtonInstances.Icon.Active = false
					ButtonInstances.Icon.AnchorPoint = AnchorPoint
					ButtonInstances.Icon.AutomaticSize = Enum.AutomaticSize.None
					ButtonInstances.Icon.BackgroundColor3 = Theme.Principal
					ButtonInstances.Icon.BackgroundTransparency = 1
					ButtonInstances.Icon.BorderColor3 = Theme.Principal
					ButtonInstances.Icon.BorderMode = Enum.BorderMode.Outline
					ButtonInstances.Icon.BorderSizePixel = 0
					ButtonInstances.Icon.LayoutOrder = 0
					ButtonInstances.Icon.Name = StringName
					ButtonInstances.Icon.Parent = ButtonInstances.Core
					ButtonInstances.Icon.Position = UDim2.new(0.925, 0,0.5, 0)
					ButtonInstances.Icon.Rotation = 0
					ButtonInstances.Icon.Size = UDim2.new(0, ElementSize / 1.5, 0,ElementSize / 1.5)
					ButtonInstances.Icon.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ButtonInstances.Icon.Visible = true
					ButtonInstances.Icon.ZIndex = 1
					ButtonInstances.Icon.ClipsDescendants = false
					ButtonInstances.Icon.Image = "rbxassetid://6035047381"
					ButtonInstances.Icon.ImageColor3 = Theme.Image
					ButtonInstances.Icon.ImageRectOffset = Vector2.new(0, 0)
					ButtonInstances.Icon.ImageRectSize = Vector2.new(0, 0)
					ButtonInstances.Icon.ImageTransparency = 0
					ButtonInstances.Icon.ResampleMode = Enum.ResamplerMode.Default
					ButtonInstances.Icon.ScaleType = Enum.ScaleType.Stretch
					ButtonInstances.Icon.SliceScale = 1
					ButtonInstances.Icon.AutoLocalize = true
					ButtonInstances.Icon.RootLocalizationTable = nil
					ButtonInstances.Icon.NextSelectionDown = nil
					ButtonInstances.Icon.NextSelectionLeft = nil
					ButtonInstances.Icon.NextSelectionRight = nil
					ButtonInstances.Icon.NextSelectionUp = nil
					ButtonInstances.Icon.Selectable = false
					ButtonInstances.Icon.SelectionGroup = false
					ButtonInstances.Icon.SelectionOrder = 0

					ButtonInstances.Display.SelectionImageObject = nil
					ButtonInstances.Display.Active = true
					ButtonInstances.Display.AnchorPoint = AnchorPoint
					ButtonInstances.Display.AutomaticSize = Enum.AutomaticSize.None
					ButtonInstances.Display.BackgroundColor3 = Theme.Principal
					ButtonInstances.Display.BackgroundTransparency = 1
					ButtonInstances.Display.BorderColor3 = Theme.Principal
					ButtonInstances.Display.BorderMode = Enum.BorderMode.Outline
					ButtonInstances.Display.BorderSizePixel = 0
					ButtonInstances.Display.LayoutOrder = 0
					ButtonInstances.Display.Name = StringName
					ButtonInstances.Display.Parent = ButtonInstances.Core
					ButtonInstances.Display.Position = UDim2.new(0.45, 0,0.5, 0)
					ButtonInstances.Display.Rotation = 0
					ButtonInstances.Display.Size = UDim2.new(0.825, 0,0.75, 0)
					ButtonInstances.Display.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ButtonInstances.Display.Visible = true
					ButtonInstances.Display.ZIndex = 1
					ButtonInstances.Display.ClipsDescendants = false
					ButtonInstances.Display.AutoLocalize = true
					ButtonInstances.Display.RootLocalizationTable = nil
					ButtonInstances.Display.NextSelectionDown = nil
					ButtonInstances.Display.NextSelectionLeft = nil
					ButtonInstances.Display.NextSelectionRight = nil
					ButtonInstances.Display.NextSelectionUp = nil
					ButtonInstances.Display.Selectable = false
					ButtonInstances.Display.SelectionGroup = false
					ButtonInstances.Display.SelectionOrder = 0
					ButtonInstances.Display.Font = Enum.Font.SciFi
					ButtonInstances.Display.LineHeight = 1
					ButtonInstances.Display.MaxVisibleGraphemes = -1
					ButtonInstances.Display.RichText = false
					ButtonInstances.Display.Text = ButtonName
					ButtonInstances.Display.TextColor3 = Theme.Text
					ButtonInstances.Display.TextScaled = true
					ButtonInstances.Display.TextSize = 1
					ButtonInstances.Display.TextStrokeColor3 = Theme.Text
					ButtonInstances.Display.TextStrokeTransparency = 1
					ButtonInstances.Display.TextTransparency = 0
					ButtonInstances.Display.TextTruncate = Enum.TextTruncate.None
					ButtonInstances.Display.TextWrapped = true
					ButtonInstances.Display.TextXAlignment = Enum.TextXAlignment.Left
					ButtonInstances.Display.TextYAlignment = Enum.TextYAlignment.Center
				end

				ButtonInstances.Detector.MouseButton1Click:Connect(ButtonFunction)

				RunService.Heartbeat:Connect(function()
					if Updating == true then
						TickElement()
					else
						return
					end
				end)
			end
			function Elements:Toggle(ToggleDescription)
				local ToggleName = ToggleDescription.Name
				local ToggleDefault = ToggleDescription.Default
				local ToggleFunction = ToggleDescription.Function
				ToggleName = ToggleName or "Toggle"
				ToggleDefault = ToggleDefault or false
				ToggleFunction = ToggleFunction or function() end

				table.insert(Elements, ToggleName)
				local ToggleInstances = {
					Core = Instance.new("Frame"),
					Corner = Instance.new("UICorner"),
					Detector = Instance.new("TextButton"),
					Icon = Instance.new("ImageLabel"),
					Display = Instance.new("TextLabel")
				}

				local Using = ToggleDefault

				ToggleInstances.Core.Parent = PageInstances.Core
				local function TickElement()
					ToggleInstances.Core.SelectionImageObject = nil
					ToggleInstances.Core.Archivable = true
					ToggleInstances.Core.Active = false
					ToggleInstances.Core.AnchorPoint = AnchorPoint
					ToggleInstances.Core.AutomaticSize = Enum.AutomaticSize.None
					ToggleInstances.Core.BackgroundColor3 = Theme.Principal
					ToggleInstances.Core.BackgroundTransparency = 0
					ToggleInstances.Core.BorderColor3 = Theme.Principal
					ToggleInstances.Core.BorderMode = Enum.BorderMode.Outline
					ToggleInstances.Core.BorderSizePixel = 0
					ToggleInstances.Core.LayoutOrder = 0
					ToggleInstances.Core.Name = StringName
					ToggleInstances.Core.Rotation = 0
					ToggleInstances.Core.Size = UDim2.new(0.925, 0,0, ElementSize)
					ToggleInstances.Core.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ToggleInstances.Core.Style = Enum.FrameStyle.Custom
					ToggleInstances.Core.Visible = true
					ToggleInstances.Core.ZIndex = 1
					ToggleInstances.Core.ClipsDescendants = false
					ToggleInstances.Core.AutoLocalize = true
					ToggleInstances.Core.RootLocalizationTable = nil
					ToggleInstances.Core.NextSelectionDown = nil
					ToggleInstances.Core.NextSelectionLeft = nil
					ToggleInstances.Core.NextSelectionRight = nil
					ToggleInstances.Core.NextSelectionUp = nil
					ToggleInstances.Core.Selectable = false
					ToggleInstances.Core.SelectionGroup = false
					ToggleInstances.Core.SelectionOrder = 0

					ToggleInstances.Corner.CornerRadius = UDim.new(0.2, 0)
					ToggleInstances.Corner.Archivable = true
					ToggleInstances.Corner.Name = StringName
					ToggleInstances.Corner.Parent = ToggleInstances.Core

					ToggleInstances.Detector.SelectionImageObject = nil
					ToggleInstances.Detector.Archivable = true
					ToggleInstances.Detector.Active = true
					ToggleInstances.Detector.AnchorPoint = AnchorPoint
					ToggleInstances.Detector.AutoButtonColor = false
					ToggleInstances.Detector.AutomaticSize = Enum.AutomaticSize.None
					ToggleInstances.Detector.BackgroundColor3 = Theme.Principal
					ToggleInstances.Detector.BackgroundTransparency = 1
					ToggleInstances.Detector.BorderColor3 = Theme.Principal
					ToggleInstances.Detector.BorderMode = Enum.BorderMode.Outline
					ToggleInstances.Detector.BorderSizePixel = 0
					ToggleInstances.Detector.LayoutOrder = 0
					ToggleInstances.Detector.Modal = false
					ToggleInstances.Detector.Name = StringName
					ToggleInstances.Detector.Parent = ToggleInstances.Core
					ToggleInstances.Detector.Position = UDim2.new(0.5, 0,0.5, 0)
					ToggleInstances.Detector.Rotation = UDim2.new(0.5, 0,0.5, 0)
					ToggleInstances.Detector.Selected = false
					ToggleInstances.Detector.Size = UDim2.new(0.9, 0,0.9, 0)
					ToggleInstances.Detector.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ToggleInstances.Detector.Style = Enum.ButtonStyle.Custom
					ToggleInstances.Detector.Visible = true
					ToggleInstances.Detector.ZIndex = 0
					ToggleInstances.Detector.ClipsDescendants = false
					ToggleInstances.Detector.AutoLocalize = true
					ToggleInstances.Detector.RootLocalizationTable = nil
					ToggleInstances.Detector.NextSelectionDown = nil
					ToggleInstances.Detector.NextSelectionLeft = nil
					ToggleInstances.Detector.NextSelectionRight = nil
					ToggleInstances.Detector.NextSelectionUp = nil
					ToggleInstances.Detector.Selectable = false
					ToggleInstances.Detector.SelectionGroup = false
					ToggleInstances.Detector.SelectionOrder = 0
					ToggleInstances.Detector.Font = Enum.Font.AmaticSC
					ToggleInstances.Detector.LineHeight = 3
					ToggleInstances.Detector.MaxVisibleGraphemes = -1
					ToggleInstances.Detector.RichText = false
					ToggleInstances.Detector.TextColor3 = Theme.Principal
					ToggleInstances.Detector.TextScaled = false
					ToggleInstances.Detector.TextSize = 1
					ToggleInstances.Detector.TextStrokeColor3 = Theme.Principal
					ToggleInstances.Detector.TextStrokeTransparency = 1
					ToggleInstances.Detector.TextTransparency = 1
					ToggleInstances.Detector.TextTruncate = Enum.TextTruncate.None
					ToggleInstances.Detector.TextWrapped = false
					ToggleInstances.Detector.TextXAlignment = Enum.TextXAlignment.Center
					ToggleInstances.Detector.TextYAlignment = Enum.TextYAlignment.Center

					ToggleInstances.Icon.SelectionImageObject = nil
					ToggleInstances.Icon.Active = false
					ToggleInstances.Icon.AnchorPoint = AnchorPoint
					ToggleInstances.Icon.AutomaticSize = Enum.AutomaticSize.None
					ToggleInstances.Icon.BackgroundColor3 = Theme.Principal
					ToggleInstances.Icon.BackgroundTransparency = 1
					ToggleInstances.Icon.BorderColor3 = Theme.Principal
					ToggleInstances.Icon.BorderMode = Enum.BorderMode.Outline
					ToggleInstances.Icon.BorderSizePixel = 0
					ToggleInstances.Icon.LayoutOrder = 0
					ToggleInstances.Icon.Name = StringName
					ToggleInstances.Icon.Parent = ToggleInstances.Core
					ToggleInstances.Icon.Position = UDim2.new(0.925, 0,0.5, 0)
					ToggleInstances.Icon.Rotation = 0
					ToggleInstances.Icon.Size = UDim2.new(0, ElementSize / 1.5, 0,ElementSize / 1.5)
					ToggleInstances.Icon.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ToggleInstances.Icon.Visible = true
					ToggleInstances.Icon.ZIndex = 1
					ToggleInstances.Icon.ClipsDescendants = false
					ToggleInstances.Icon.Image = "rbxassetid://6031068420"
					ToggleInstances.Icon.ImageColor3 = Theme.Image
					ToggleInstances.Icon.ImageRectOffset = Vector2.new(0, 0)
					ToggleInstances.Icon.ImageRectSize = Vector2.new(0, 0)
					ToggleInstances.Icon.ImageTransparency = 0
					ToggleInstances.Icon.ResampleMode = Enum.ResamplerMode.Default
					ToggleInstances.Icon.ScaleType = Enum.ScaleType.Stretch
					ToggleInstances.Icon.SliceScale = 1
					ToggleInstances.Icon.AutoLocalize = true
					ToggleInstances.Icon.RootLocalizationTable = nil
					ToggleInstances.Icon.NextSelectionDown = nil
					ToggleInstances.Icon.NextSelectionLeft = nil
					ToggleInstances.Icon.NextSelectionRight = nil
					ToggleInstances.Icon.NextSelectionUp = nil
					ToggleInstances.Icon.Selectable = false
					ToggleInstances.Icon.SelectionGroup = false
					ToggleInstances.Icon.SelectionOrder = 0

					if Using then
						ToggleInstances.Icon.Image = "rbxassetid://6031068421"
					end

					ToggleFunction(Using)

					ToggleInstances.Display.SelectionImageObject = nil
					ToggleInstances.Display.Active = true
					ToggleInstances.Display.AnchorPoint = AnchorPoint
					ToggleInstances.Display.AutomaticSize = Enum.AutomaticSize.None
					ToggleInstances.Display.BackgroundColor3 = Theme.Principal
					ToggleInstances.Display.BackgroundTransparency = 1
					ToggleInstances.Display.BorderColor3 = Theme.Principal
					ToggleInstances.Display.BorderMode = Enum.BorderMode.Outline
					ToggleInstances.Display.BorderSizePixel = 0
					ToggleInstances.Display.LayoutOrder = 0
					ToggleInstances.Display.Name = StringName
					ToggleInstances.Display.Parent = ToggleInstances.Core
					ToggleInstances.Display.Position = UDim2.new(0.45, 0,0.5, 0)
					ToggleInstances.Display.Rotation = 0
					ToggleInstances.Display.Size = UDim2.new(0.825, 0,0.75, 0)
					ToggleInstances.Display.SizeConstraint = Enum.SizeConstraint.RelativeXY
					ToggleInstances.Display.Visible = true
					ToggleInstances.Display.ZIndex = 1
					ToggleInstances.Display.ClipsDescendants = false
					ToggleInstances.Display.AutoLocalize = true
					ToggleInstances.Display.RootLocalizationTable = nil
					ToggleInstances.Display.NextSelectionDown = nil
					ToggleInstances.Display.NextSelectionLeft = nil
					ToggleInstances.Display.NextSelectionRight = nil
					ToggleInstances.Display.NextSelectionUp = nil
					ToggleInstances.Display.Selectable = false
					ToggleInstances.Display.SelectionGroup = false
					ToggleInstances.Display.SelectionOrder = 0
					ToggleInstances.Display.Font = Enum.Font.SciFi
					ToggleInstances.Display.LineHeight = 1
					ToggleInstances.Display.MaxVisibleGraphemes = -1
					ToggleInstances.Display.RichText = false
					ToggleInstances.Display.Text = ToggleName
					ToggleInstances.Display.TextColor3 = Theme.Text
					ToggleInstances.Display.TextScaled = true
					ToggleInstances.Display.TextSize = 1
					ToggleInstances.Display.TextStrokeColor3 = Theme.Text
					ToggleInstances.Display.TextStrokeTransparency = 1
					ToggleInstances.Display.TextTransparency = 0
					ToggleInstances.Display.TextTruncate = Enum.TextTruncate.None
					ToggleInstances.Display.TextWrapped = true
					ToggleInstances.Display.TextXAlignment = Enum.TextXAlignment.Left
					ToggleInstances.Display.TextYAlignment = Enum.TextYAlignment.Center
				end

				ToggleInstances.Detector.MouseButton1Click:Connect(function()
					Using = not Using
				end)

				RunService.Heartbeat:Connect(function()
					if Updating == true then
						TickElement()
					else
						return
					end
				end)
			end

			function Elements:Label(LabelDescription)
				local LabelIcon = LabelDescription.Icon
				local LabelText = LabelDescription.Text

				table.insert(Elements, LabelText)
				local LabelInstances = {
					Core = Instance.new("Frame"),
					Corner = Instance.new("UICorner"),
					Detector = Instance.new("TextButton"),
					Icon = Instance.new("ImageLabel"),
					Display = Instance.new("TextLabel")
				}
				
				LabelInstances.Core.Parent = PageInstances.Core
				local function TickElement()
					LabelInstances.Core.SelectionImageObject = nil
					LabelInstances.Core.Archivable = true
					LabelInstances.Core.Active = false
					LabelInstances.Core.AnchorPoint = AnchorPoint
					LabelInstances.Core.AutomaticSize = Enum.AutomaticSize.None
					LabelInstances.Core.BackgroundColor3 = Theme.Principal
					LabelInstances.Core.BackgroundTransparency = 0
					LabelInstances.Core.BorderColor3 = Theme.Principal
					LabelInstances.Core.BorderMode = Enum.BorderMode.Outline
					LabelInstances.Core.BorderSizePixel = 0
					LabelInstances.Core.LayoutOrder = 0
					LabelInstances.Core.Name = StringName
					LabelInstances.Core.Rotation = 0
					LabelInstances.Core.Size = UDim2.new(0.925, 0,0, ElementSize)
					LabelInstances.Core.SizeConstraint = Enum.SizeConstraint.RelativeXY
					LabelInstances.Core.Style = Enum.FrameStyle.Custom
					LabelInstances.Core.Visible = true
					LabelInstances.Core.ZIndex = 1
					LabelInstances.Core.ClipsDescendants = false
					LabelInstances.Core.AutoLocalize = true
					LabelInstances.Core.RootLocalizationTable = nil
					LabelInstances.Core.NextSelectionDown = nil
					LabelInstances.Core.NextSelectionLeft = nil
					LabelInstances.Core.NextSelectionRight = nil
					LabelInstances.Core.NextSelectionUp = nil
					LabelInstances.Core.Selectable = false
					LabelInstances.Core.SelectionGroup = false
					LabelInstances.Core.SelectionOrder = 0

					LabelInstances.Icon.SelectionImageObject = nil
					LabelInstances.Icon.Active = false
					LabelInstances.Icon.AnchorPoint = AnchorPoint
					LabelInstances.Icon.AutomaticSize = Enum.AutomaticSize.None
					LabelInstances.Icon.BackgroundColor3 = Theme.Principal
					LabelInstances.Icon.BackgroundTransparency = 1
					LabelInstances.Icon.BorderColor3 = Theme.Principal
					LabelInstances.Icon.BorderMode = Enum.BorderMode.Outline
					LabelInstances.Icon.BorderSizePixel = 0
					LabelInstances.Icon.LayoutOrder = 0
					LabelInstances.Icon.Name = StringName
					LabelInstances.Icon.Parent = LabelInstances.Core
					LabelInstances.Icon.Position = UDim2.new(0.925, 0,0.5, 0)
					LabelInstances.Icon.Rotation = 0
					LabelInstances.Icon.Size = UDim2.new(0, ElementSize / 1.5, 0,ElementSize / 1.5)
					LabelInstances.Icon.SizeConstraint = Enum.SizeConstraint.RelativeXY
					LabelInstances.Icon.Visible = true
					LabelInstances.Icon.ZIndex = 1
					LabelInstances.Icon.ClipsDescendants = false
					LabelInstances.Icon.Image = LabelIcon
					LabelInstances.Icon.ImageColor3 = Theme.Image
					LabelInstances.Icon.ImageRectOffset = Vector2.new(0, 0)
					LabelInstances.Icon.ImageRectSize = Vector2.new(0, 0)
					LabelInstances.Icon.ImageTransparency = 0
					LabelInstances.Icon.ResampleMode = Enum.ResamplerMode.Default
					LabelInstances.Icon.ScaleType = Enum.ScaleType.Stretch
					LabelInstances.Icon.SliceScale = 1
					LabelInstances.Icon.AutoLocalize = true
					LabelInstances.Icon.RootLocalizationTable = nil
					LabelInstances.Icon.NextSelectionDown = nil
					LabelInstances.Icon.NextSelectionLeft = nil
					LabelInstances.Icon.NextSelectionRight = nil
					LabelInstances.Icon.NextSelectionUp = nil
					LabelInstances.Icon.Selectable = false
					LabelInstances.Icon.SelectionGroup = false
					LabelInstances.Icon.SelectionOrder = 0

					LabelInstances.Display.SelectionImageObject = nil
					LabelInstances.Display.Active = true
					LabelInstances.Display.AnchorPoint = AnchorPoint
					LabelInstances.Display.AutomaticSize = Enum.AutomaticSize.None
					LabelInstances.Display.BackgroundColor3 = Theme.Principal
					LabelInstances.Display.BackgroundTransparency = 1
					LabelInstances.Display.BorderColor3 = Theme.Principal
					LabelInstances.Display.BorderMode = Enum.BorderMode.Outline
					LabelInstances.Display.BorderSizePixel = 0
					LabelInstances.Display.LayoutOrder = 0
					LabelInstances.Display.Name = StringName
					LabelInstances.Display.Parent = LabelInstances.Core
					LabelInstances.Display.Position = UDim2.new(0.45, 0,0.5, 0)
					LabelInstances.Display.Rotation = 0
					LabelInstances.Display.Size = UDim2.new(0.825, 0,0, LabelInstances.Core.Size.Y.Offset)
					LabelInstances.Display.SizeConstraint = Enum.SizeConstraint.RelativeXY
					LabelInstances.Display.Visible = true
					LabelInstances.Display.ZIndex = 1
					LabelInstances.Display.ClipsDescendants = true
					LabelInstances.Display.AutoLocalize = true
					LabelInstances.Display.RootLocalizationTable = nil
					LabelInstances.Display.NextSelectionDown = nil
					LabelInstances.Display.NextSelectionLeft = nil
					LabelInstances.Display.NextSelectionRight = nil
					LabelInstances.Display.NextSelectionUp = nil
					LabelInstances.Display.Selectable = false
					LabelInstances.Display.SelectionGroup = false
					LabelInstances.Display.SelectionOrder = 0
					LabelInstances.Display.Font = Enum.Font.SciFi
					LabelInstances.Display.LineHeight = 1
					LabelInstances.Display.MaxVisibleGraphemes = -1
					LabelInstances.Display.RichText = false
					LabelInstances.Display.Text = LabelText
					LabelInstances.Display.TextColor3 = Theme.Text
					LabelInstances.Display.TextScaled = false
					LabelInstances.Display.TextSize = Size.Y / 15
					LabelInstances.Display.TextStrokeColor3 = Theme.Text
					LabelInstances.Display.TextStrokeTransparency = 1
					LabelInstances.Display.TextTransparency = 0
					LabelInstances.Display.TextTruncate = Enum.TextTruncate.None
					LabelInstances.Display.TextWrapped = true
					LabelInstances.Display.TextXAlignment = Enum.TextXAlignment.Left
					LabelInstances.Display.TextYAlignment = Enum.TextYAlignment.Center

					local function UpdateSize()
						local ChangeSize = 0

						if math.floor(LabelInstances.Core.AbsoluteSize.X) >= math.floor(LabelInstances.Display.TextBounds.X) then
							LabelInstances.Display.TextWrapped = true
							ChangeSize = math.floor(LabelInstances.Core.AbsoluteSize.X) - math.floor(LabelInstances.Display.TextBounds.X)
						end

						LabelInstances.Core.Size = UDim2.new(0.925, 0,0, LabelInstances.Core.Size.Y.Offset + ChangeSize)
						LabelInstances.Display.Size = UDim2.new(0.825, 0,0, LabelInstances.Core.Size.Y.Offset)
					end
					UpdateSize()
				end

				RunService.Heartbeat:Connect(function()
					if Updating == true then
						TickElement()
					else
						return
					end
				end)
			end
			return Elements;
		end
		return Sections;
	end
	return Pages;
end
return Hubs;
