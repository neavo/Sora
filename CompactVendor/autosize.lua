VladsVendorListAutoSizeMixin = {}

local function ResizeChildren(frames)
	for i = 1, #frames do
		local frame = frames[i]
		if frame.AutoSize and frame:IsShown() then
			frame:AutoSize()
		end
	end
end

function VladsVendorListAutoSizeMixin:AutoSize()
	-- show so GetBoundsRect returns sane numbers
	self:Show()

	-- let's start as a tiny frame and work our way up from there
	self:SetWidth(1)

	-- resize all children recursively
	ResizeChildren({self:GetChildren()})

	-- resize the parent
	local _, _, width = self:GetBoundsRect()
	if width then
		self:SetWidth(width)
	end
end
