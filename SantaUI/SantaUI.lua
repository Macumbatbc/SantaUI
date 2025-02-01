-- Hi
ChatFrame1:AddMessage("Santa says: Ho ho ho...",1,0,0.3)

-- /rl to reload UI
SLASH_LHRELOADUI1 = "/rl";
SlashCmdList["LHRELOADUI"] = function() ReloadUI(); end;

--[[ Reposition tooltip
hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
 	tooltip:SetOwner(parent, "ANCHOR_NONE")
 	tooltip:ClearAllPoints()
 	tooltip:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -30, 85)
 end)
]]

--[[ Unit frames Left upper corner
PlayerFrame:SetScale(1.1)
PlayerFrame:ClearAllPoints()
PlayerFrame:SetPoint("TOPLEFT", 90, -30)

TargetFrame:SetScale(1.1)
TargetFrame:ClearAllPoints()
TargetFrame:SetPoint("TOPLEFT", 350, -30)
]]

-- Mid screen
-- PlayerFrame:SetScale(1)
-- PlayerFrame:ClearAllPoints()
-- PlayerFrame:SetPoint("BOTTOM", -260, 220)

-- TargetFrame:SetScale(1)
-- TargetFrame:ClearAllPoints()
-- TargetFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 260, 220)

-- TargetOfTargetFrame:ClearAllPoints()
-- TargetOfTargetFrame:SetPoint("RIGHT", TargetFrame, "RIGHT", 54, -7)
-- TargetOfTargetFrame:SetScale(1)
-- TargetOfTargetFrame.TargetOfTargetFrame.SetPoint = Function() end

-- PetFrame:SetScale(1.0)
-- PetFrame:ClearAllPoints()
-- PetFrame:SetPoint("LEFT", PlayerFrame, "LEFT", -80, -10)
-- PetFrame.SetPoint = Function() end

MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()

-- Font size
PlayerFrame.name:SetFont("Fonts\\ARIALN.ttf",11)
PlayerFrameHealthBar.TextString:SetFont("Fonts\\ARIALN.ttf",11,"OUTLINE")
PlayerFrameManaBar.TextString:SetFont("Fonts\\ARIALN.ttf",11,"OUTLINE")

TargetFrame.name:SetFont("Fonts\\ARIALN.ttf",11)
TargetFrameHealthBar.TextString:SetFont("Fonts\\ARIALN.ttf",11,"OUTLINE")
TargetFrameManaBar.TextString:SetFont("Fonts\\ARIALN.ttf",11,"OUTLINE")
