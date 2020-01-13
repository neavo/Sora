-- Engine
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function RegisterStyle(self, ...)
    local artifactPower = CreateFrame("StatusBar", nil, self)
    artifactPower:EnableMouse(true)
    artifactPower:SetAllPoints()
    artifactPower:SetStatusBarTexture(DB.Statusbar)

    artifactPower.text = S.MakeText(artifactPower, 10)
    artifactPower.text:SetText("N/A")
    artifactPower.text:SetPoint("CENTER", 0, 4)

    artifactPower.shadow = S.MakeShadow(artifactPower, 2)
    artifactPower.shadow:SetFrameLevel(artifactPower:GetFrameLevel())

    artifactPower.bg = artifactPower:CreateTexture(nil, "BACKGROUND")
    artifactPower.bg:SetTexture(DB.Statusbar)
    artifactPower.bg:SetAllPoints()
    artifactPower.bg:SetVertexColor(0.12, 0.12, 0.12)

    local function PostUpdate(self, event, isShown)
        if isShown then
            self.text:SetText(("%d%%"):format(self.current / self.max * 100))
        end
    end

    self.ArtifactPower = artifactPower
    self.ArtifactPower.PostUpdate = PostUpdate
end

function S.Minimap.CreateArtifactPower(parent)
    oUF:RegisterStyle("oUFSoraArtifactPower", RegisterStyle)
    oUF:SetActiveStyle("oUFSoraArtifactPower")

    return oUF:Spawn("player", "oUFSoraArtifactPower")
end
