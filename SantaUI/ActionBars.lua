local AddOn = CreateFrame("Frame")
local OnEvent = function(self, event, ...)
    if self[event] then
        self[event](self, event, ...)
    else
        print("Unhandled event: " .. event)
    end
end
AddOn:SetScript("OnEvent", OnEvent)

if not SantaUIDB then
    SantaUIDB = {
        isAboveBags = true,
    }
end



-- Function to set the position of the CharacterMicroButton
local function SetCharacterMicroButtonPosition()
    if InCombatLockdown() then
        -- Retry after leaving combat
        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_REGEN_ENABLED")
        f:SetScript("OnEvent", function()
            SetCharacterMicroButtonPosition()
            f:UnregisterEvent("PLAYER_REGEN_ENABLED")
        end)
        return
    end
	
    CharacterMicroButton:ClearAllPoints()
    if SantaUIDB.isAboveBags then
        -- Position above the bags
		if UnitLevel("player") < 10 then
			CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -155, 43)
		else
			CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -180, 43)
		end
    else
        -- Position below the bags
		if UnitLevel("player") < 10 then
			CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -155, -43)
		else
			CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -180, -43)
		end		
    end
	
		if UnitLevel("player") < MAX_PLAYER_LEVEL then
			MainMenuBar:ClearAllPoints()
			MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 11)
		else
			MainMenuBar:ClearAllPoints()
			MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 0)
		end
end

local events = {}
function AddOn:ADDON_LOADED(event, addonName)
    if addonName == "SantaUI" then
        -- Initialize the database if it doesn't exist
        if not SantaUIDB then
            SantaUIDB = {}
        end

        -- Load the saved state for isAboveBags
        if SantaUIDB.isAboveBags == nil then
            SantaUIDB.isAboveBags = true -- Default to true if not set
        end
        -- isAboveBags = SantaUIDB.isAboveBags
		isAboveBags = SantaUIDB.isAboveBags
        -- Apply the saved position
        SetCharacterMicroButtonPosition()
        print("SantaUI loaded.")
    end
end

--- gets executed once all ui information is available (like honor etc)
function events:PLAYER_ENTERING_WORLD()
	ReapplyActionBarPosition()
    addon:UnregisterEvent("PLAYER_ENTERING_WORLD")
	SetCharacterMicroButtonPosition()
end

function events:PLAYER_REGEN_ENABLED()
	ReapplyActionBarPosition()
    addon:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

function events:ZONE_CHANGED_NEW_AREA()
	ReapplyActionBarPosition()
    addon:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
end

function events:ACTIONBAR_SLOT_CHANGED()
	ReapplyActionBarPosition()
    addon:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
end

--- save variables to SavedVariables
function AddOn:PLAYER_LOGOUT()
    -- Save the current state of isAboveBags to SantaUIDB
    SantaUIDB.isAboveBags = isAboveBags
end






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
MultiBarRight:SetScale(1); MultiBarLeft:SetScale(1)

-- Bottom right actionbar

	MAX_PLAYER_LEVEL = 70
if UnitLevel("player") < MAX_PLAYER_LEVEL then
	MainMenuBar:ClearAllPoints()
    MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 11)
	else
	MainMenuBar:ClearAllPoints()
	MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 0)
end
-- MainMenuBar:ClearAllPoints()
-- MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 11)

--reposition bottom right actionbar
MultiBarBottomRight:SetPoint("LEFT", MultiBarBottomLeft, "RIGHT", 5, 0)

--reposition second half of top right bar, underneath
MultiBarBottomRightButton7:SetPoint("LEFT", MainMenuBar, 513, -5)


VerticalMultiBarsContainer:SetPoint("TOPRIGHT", UIParent, -2, -490)


-- Experience bar


MainMenuExpBar:SetScale(0.735)
ExhaustionTick:SetScale(0.735)
MainMenuExpBar:ClearAllPoints()
MainMenuExpBar:SetPoint("CENTER", ReputationWatchBar, 175, -82)

MainMenuBarExpText:SetPoint("TOP", MainMenuExpBar, 0, 1)
MainMenuBarExpText:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE");
ReputationWatchBar:SetScale(0.9)
ReputationWatchBar:SetWidth(500)
ReputationWatchBar.StatusBar:SetScale(0.82)
ReputationWatchBar.StatusBar:SetPoint("LEFT", ReputationWatchBar, -35, -54)
ReputationWatchBar.OverlayFrame.Text:SetFont("Fonts\\FRIZQT__.TTF", 11.5, "OUTLINE");
ReputationWatchBar.OverlayFrame.Text:SetPoint("TOP", ReputationWatchBar.StatusBar, 0, 2)



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


-- fix for bar overlap for warrior but remove bars stance
-- if select(2, UnitClass("player")) == "WARRIOR" then
--	local frame = CreateFrame("frame");
--	frame:RegisterEvent("PLAYER_ENTERING_WORLD");
--	local HIDE_BONUS_BARS = function()
--		BonusActionBarFrame:UnregisterAllEvents();
--		BonusActionBarFrame.Show = function() end
--		BonusActionBarFrame:Hide();
--	end
--	frame:SetScript("OnEvent", HIDE_BONUS_BARS);
-- end


-- Bags
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
	local point, _, relativePoint, xOfs, yOfs = self:GetPoint()


end

	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetMovable(true)
	MainMenuBarBackpackButton:EnableMouse(true)
	MainMenuBarBackpackButton:SetClampedToScreen(true)
	MainMenuBarBackpackButton:RegisterForDrag("LeftButton")
	MainMenuBarBackpackButton:SetScript("OnDragStart", OnDragStart)
	MainMenuBarBackpackButton:SetScript("OnDragStop", OnDragStop)
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", "Minimap", "BOTTOMRIGHT", 10, -1030)
	MainMenuBarBackpackButton:SetScale(1)

-- MainMenuBarBackpackButton:SetAlpha(0)
CharacterBag0Slot:SetScale(1)
CharacterBag1Slot:SetScale(1)
CharacterBag2Slot:SetScale(1)
CharacterBag3Slot:SetScale(1)
KeyRingButton:SetScale(1)



-- Micro menu
-- Configuration to set the position of CharacterMicroButton




-- Event handlers
local function PLAYER_ENTERING_WORLD()
    SetCharacterMicroButtonPosition()
end

local function PLAYER_REGEN_ENABLED()
    SetCharacterMicroButtonPosition()
end

local function ZONE_CHANGED_NEW_AREA()
    SetCharacterMicroButtonPosition()
end

local function ACTIONBAR_SLOT_CHANGED()
    SetCharacterMicroButtonPosition()
end

-- Add a slash command to toggle the position dynamically
SLASH_SANTA1 = "/santa"
SLASH_SANTA2 = "/sa"
SlashCmdList["SANTA"] = function(msg)
    local command = string.lower(msg) -- Convert input to lowercase
    if command == "move" then
        -- Toggle the micro button position
        isAboveBags = not isAboveBags
        SantaUIDB.isAboveBags = isAboveBags -- Synchronize with SantaUIDB
        SetCharacterMicroButtonPosition()
        print("Character Micro Button is now " .. (isAboveBags and "above" or "below") .. " the bags.")
		print("isAboveBags:", isAboveBags, "SantaUIDB.isAboveBags:", SantaUIDB.isAboveBags)
    else
        -- Print usage instructions
        print("Usage: /santa move - Toggle the micro button position above or below the bags.")
    end
end

-- Register the event handlers
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        PLAYER_ENTERING_WORLD()
    elseif event == "PLAYER_REGEN_ENABLED" then
        PLAYER_REGEN_ENABLED()
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		ZONE_CHANGED_NEW_AREA()
	elseif event == "ACTIONBAR_SLOT_CHANGED" then
		ACTIONBAR_SLOT_CHANGED()
    end
end)

local function ReapplyActionBarPosition()
    if UnitLevel("player") < MAX_PLAYER_LEVEL then
		MainMenuBar:ClearAllPoints()
		MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 11)
	else
		MainMenuBar:ClearAllPoints()
		MainMenuBar:SetPoint("BOTTOM", UIParent, -110, 0)
	end
end

local inCombat = false
local events = CreateFrame("Frame")
events:RegisterEvent("ZONE_CHANGED_NEW_AREA")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_REGEN_ENABLED" then
		inCombat = false
        ReapplyActionBarPosition()
	elseif event == "PLAYER_REGEN_DISABLED" then
        inCombat = true
	elseif not inCombat then
        ReapplyActionBarPosition()
    else
        ReapplyActionBarPosition()
    end
end)



do
	local b = {
		"CharacterMicroButton",
		"SpellbookMicroButton",
		"TalentMicroButton",
		"QuestLogMicroButton",
		"SocialsMicroButton",
		"LFGMicroButton",
		"MainMenuMicroButton",
		-- "AchievementMicroButton",
		"HelpMicroButton",
		-- "PVPMicroButton",
		-- "CollectionsMicroButton"
		}
	for k, v in pairs(b) do
		_G[v]:SetScale(0.9)
		_G[v]:SetAlpha(1)
	end
end


-- Ghetto fix for the micro menu resetting it's postition sometimes
local f = CreateFrame("Frame", UIParent)
f:SetHeight(20)
f:SetWidth(140)
	if SantaUIDB.isAboveBags then
        -- Position above the bags
		if UnitLevel("player") < 10 then
			f:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -155, 43)
		else
			f:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -180, 43)
		end
    else
        -- Position below the bags
		if UnitLevel("player") < 10 then
			f:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -155, -43)
		else
			f:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -180, -43)
		end
    end


local fixMicroMenu = function(frame)
	local resetPos = function()
		CharacterMicroButton:ClearAllPoints()
		if SantaUIDB.isAboveBags then
			-- Position above the bags
			if UnitLevel("player") < 10 then
				CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -155, 43)
			else
				CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -180, 43)
			end
		else
			-- Position below the bags
			if UnitLevel("player") < 10 then
				CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -155, -43)
			else
				CharacterMicroButton:SetPoint("BOTTOMRIGHT", "MainMenuBarBackpackButton", "BOTTOMRIGHT", -180, -43)
			end
		end
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
AddOn:RegisterEvent("PLAYER_REGEN_ENABLED")
AddOn:RegisterEvent("ZONE_CHANGED_NEW_AREA")
AddOn:RegisterEvent("PLAYER_LOGOUT")
AddOn:RegisterEvent("ADDON_LOADED")	
AddOn["PLAYER_REGEN_ENABLED"] = PLAYER_REGEN_ENABLED
AddOn["PLAYER_ENTERING_WORLD"] = PLAYER_ENTERING_WORLD
AddOn["ZONE_CHANGED_NEW_AREA"] = ZONE_CHANGED_NEW_AREA
AddOn["ACTIONBAR_SLOT_CHANGED"] = ACTIONBAR_SLOT_CHANGED