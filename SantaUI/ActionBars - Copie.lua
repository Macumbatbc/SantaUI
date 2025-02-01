local AddOn = CreateFrame("Frame")
local OnEvent = function(self, event, ...) self[event](self, event, ...) end
AddOn:SetScript("OnEvent", OnEvent)

-- Hide graphics  
for _, frame in ipairs({
  MainMenuBarLeftEndCap, 
  MainMenuBarRightEndCap, 
  MainMenuBarPageNumber, 
  MainMenuBarTexture2, 
  MainMenuBarTexture3, 
  MainMenuMaxLevelBar0,
  MainMenuMaxLevelBar1,
  MainMenuMaxLevelBar2, 
  MainMenuMaxLevelBar3, 
  MainMenuBarPerformanceBarFrame
  }) do
		frame:Hide()
end

for _, texture in ipairs({
  ReputationWatchBarTexture2, 
  ReputationWatchBarTexture3, 
  ReputationXPBarTexture2, 
  ReputationXPBarTexture3, 
  MainMenuBarTexture0, 
  MainMenuBarTexture1, 
  ReputationWatchBarTexture0, 
  ReputationWatchBarTexture1, 
  ReputationXPBarTexture0, 
  ReputationXPBarTexture1, 
  MainMenuBarLeftEndCap, 
  MainMenuBarRightEndCap, 
  MainMenuXPBarTexture0, 
  MainMenuXPBarTexture1, 
  MainMenuMaxLevelBar0, 
  MainMenuMaxLevelBar1, 
  PossessBackground1, 
  PossessBackground2
  }) do
	texture:SetTexture(nil)
end
-- BonusActionBarTexture0, BonusActionBarTexture1

local function OnDragStart(self)
    if( IsAltKeyDown() ) then
        self.isMoving = true
        self:StartMoving()
    end
end

local function OnDragStop(self)
    if( self.isMoving ) then
        self.isMoving = nil
        self:StopMovingOrSizing()
    end
end

-- Stance / Shapeshiftbar move
StanceBarFrame:ClearAllPoints()
StanceBarFrame:SetPoint("BOTTOMLEFT", 10, 102)
StanceBarFrame:SetScale(1)
StanceBarFrame.SetPoint = function() end

-- Pet/Posses Action Bar move / move with alt on PetActionButton1
local frame = CreateFrame("Frame", "DragFrame2", UIParent)
PetActionButton1:ClearAllPoints()
PetActionButton1:SetMovable(true)
PetActionButton1:EnableMouse(true)
PetActionButton1:SetClampedToScreen(true)
PetActionButton1:RegisterForDrag("LeftButton")
PetActionButton1:SetScript("OnDragStart", OnDragStart)
PetActionButton1:SetScript("OnDragStop", OnDragStop)
PetActionButton1:SetPoint("BOTTOMLEFT", 10, 152)
PetActionButton1:SetScale(1)
PetActionButton1.SetPoint = function() end


-- PossessBarFrame:ClearAllPoints()
-- PossessBarFrame:SetPoint("BOTTOMLEFT", 250, 132)
-- PossessBarFrame:SetScale(1)
-- PossessBarFrame.SetPoint = function() end

-- PossessButton1:ClearAllPoints()
-- PossessButton1:SetPoint("BOTTOMLEFT", 0, 60)
-- PossessButton1:SetScale(1)


-- Scaling
MainMenuBar:SetScale(1)
MainMenuBar:SetWidth(510)
MultiBarBottomLeft:SetScale(1); MultiBarBottomRight:SetScale(1)
MultiBarLeft:SetScale(.795)
MultiBarRight:SetScale(.795)

-- Bottom right actionbar
MainMenuBar:ClearAllPoints()
MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 11)

--reposition bottom right actionbar
MultiBarBottomRight:SetPoint("LEFT", MultiBarBottomLeft, "RIGHT", 5, 0)

--reposition second half of top right bar, underneath
MultiBarBottomRightButton7:SetPoint("LEFT", MainMenuBar, 513, -5)


                

VerticalMultiBarsContainer:SetPoint("TOPRIGHT", UIParent, -2, -590)


-- Experience bar
MainMenuExpBar:SetScale(0.735)

MainMenuExpBar:ClearAllPoints()
MainMenuExpBar:SetPoint("CENTER", ReputationWatchBar, 175, -82)

ReputationWatchBar:SetScale(0.9)
ReputationWatchBar:SetWidth(500)
ReputationWatchBar.StatusBar:SetScale(0.82)
ReputationWatchBar.StatusBar:SetPoint("LEFT", ReputationWatchBar, -35, -54)

ReputationWatchBar.OverlayFrame.Text:SetPoint("TOP", ReputationWatchBar, 160, 0)


-- XP Bar
-- ReputationWatchStatusBar:SetPoint("BOTTOMLEFT", -290, -2, -290, -2)

-- Paging
-- ActionBarUpButton:SetPoint("RIGHT", -22, 5)
ActionBarUpButton:SetAlpha(0.5)
-- ActionBarDownButton:SetPoint("RIGHT", -22, -16)
ActionBarDownButton:SetAlpha(0.5)

-- hide arena frames
if instanceType == "arena" then
ArenaEnemyFrame1:SetAlpha(0)
ArenaEnemyFrame2:SetAlpha(0)
ArenaEnemyFrame3:SetAlpha(0)
ArenaEnemyFrame4:SetAlpha(0)
ArenaEnemyFrame5:SetAlpha(0)       
end
-- Bags
MainMenuBarBackpackButton:ClearAllPoints()
MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", "Minimap", "BOTTOMRIGHT", 10, -1015)
MainMenuBarBackpackButton:SetScale(1)

-- MainMenuBarBackpackButton:SetAlpha(0)
CharacterBag0Slot:SetScale(1)
CharacterBag1Slot:SetScale(1)
CharacterBag2Slot:SetScale(1)
CharacterBag3Slot:SetScale(1)
KeyRingButton:SetScale(1)

-- Micro menu
local function PLAYER_ENTERING_WORLD()
	CharacterMicroButton:ClearAllPoints()
	CharacterMicroButton:SetPoint("BOTTOMLEFT", "Minimap", "BOTTOMLEFT", -60, -975)
end





-- Ghetto fix for the micro menu resetting it's postition sometimes
local f = CreateFrame("Frame", UIParent)
f:SetHeight(20)
f:SetWidth(140)
f:SetPoint("BOTTOMLEFT", "Minimap", "BOTTOMLEFT", -60, -900)

local fixMicroMenu = function(frame)
	local resetPos = function()
		CharacterMicroButton:ClearAllPoints()
		CharacterMicroButton:SetPoint("BOTTOMLEFT", "Minimap", "BOTTOMLEFT", 25, -55)
	end

	frame:EnableMouse(true)
	frame:HookScript("OnEnter", resetPos)
end

fixMicroMenu(f)

-- Show/hide frame on mouseover
local enableMouseOver = function(frame, includeChildren)
	local show = function()
		frame:SetAlpha(1)
	end

	local hide = function()
		frame:SetAlpha(0)
	end
	
	if includeChildren then
			for _, child in ipairs({frame:GetChildren()}) do
				child:HookScript("OnEnter", show)
				child:HookScript("OnLeave", hide)
			end
		end

	frame:EnableMouse(true)
	frame:HookScript("OnEnter", show)
	frame:HookScript("OnLeave", hide)
	hide()
end

MainMenuBarTexture0:Hide()
MainMenuBarTexture1:Hide()
ActionBarUpButton:Hide()
ActionBarDownButton:Hide()
-- enableMouseOver(ActionBarUpButton, true)
-- enableMouseOver(ActionBarDownButton, true)
-- enableMouseOver(PetActionBarFrame, true)
enableMouseOver(StanceBarFrame, true)

AddOn:RegisterEvent("PLAYER_ENTERING_WORLD")
AddOn["PLAYER_ENTERING_WORLD"] = PLAYER_ENTERING_WORLD