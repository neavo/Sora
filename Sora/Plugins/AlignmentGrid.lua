-- FUNCTIONS

-- Returns a tuple representing the current screen size.
local function GetScreenSize()
	return GetScreenWidth(), GetScreenHeight()
end

-- Returns a tuple representing the aspect ratio of a given value, taking into
-- consideration the current screen size. For example, on a 16:9 screen passing
-- in 16 will return 9, whereas on a 4:3 screen it will return 12.
local function DetermineAspectRatio(value)
	local screenWidth, screenHeight = GetScreenSize()
	local relativeValue = Round(screenHeight / screenWidth * value)
	return value, relativeValue
end


-- Draws a number of repeating white lines from start point to end point at
-- offset intervals onto parent frame. Highlights lines at  1/4, 1/2 and 3/4
-- intervals in yellow.
local function CreateLines(parentFrame, numberOfLines, startPoint, endPoint, offsetX, offsetY)
	for index = 1, (numberOfLines - 1) do
		local line = parentFrame:CreateLine()
		line:SetThickness(1)

		if index == (numberOfLines * 0.5) then
			line:SetColorTexture(1, 1, 0, 0.75)
		elseif ((index == (numberOfLines * 0.25)) or (index == (numberOfLines * 0.75))) then
			line:SetColorTexture(1, 1, 0, 0.5)
		else
			line:SetColorTexture(1, 1, 1, 0.25)
		end

		line:SetStartPoint(startPoint, (index * offsetX), (index * offsetY))
		line:SetEndPoint(endPoint, (index * offsetX), (index * offsetY))
	end
end

-- Draws a square grid of a given scale onto parent frame.
local function CreateGrid(parentFrame, scale)
	local numberOfVerticalLines, numberOfHorizontalLines = DetermineAspectRatio(scale)
	local screenWidth, screenHeight = GetScreenSize()
	local verticalOffset = screenWidth / numberOfVerticalLines
	local horizontalOffset = screenHeight / numberOfHorizontalLines

	CreateLines(parentFrame, numberOfVerticalLines, "TOPLEFT", "BOTTOMLEFT", verticalOffset, 0)
	CreateLines(parentFrame, numberOfHorizontalLines, "BOTTOMLEFT", "BOTTOMRIGHT", 0, horizontalOffset)
end


-- ADDON

-- The frame on which to render the grid.
local gridFrame = nil

SLASH_ALIGNMENTGRID1 = "/align"
SLASH_ALIGNMENTGRID2 = "/aligngrid"
SLASH_ALIGNMENTGRID3 = "/alignmentgrid"
SlashCmdList["ALIGNMENTGRID"] = function(message)
	if gridFrame then
		gridFrame:Hide()
		gridFrame = nil
	else
		gridFrame = CreateFrame("Frame", nil, UIParent)
		gridFrame:SetAllPoints(UIParent)

		local scale = 64
		if message == "large" then
			scale = 36
		elseif message == "small" then
			scale = 100
		end

		CreateGrid(gridFrame, scale)
	end
end
