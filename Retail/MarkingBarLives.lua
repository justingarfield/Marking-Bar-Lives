-------------------------------------------------------
-- Local variables and Loaded Message
-------------------------------------------------------
local MB = "|cffe1a500Marking|cff69ccf0Bar|cffff0000Lives|cffffffff"  -- MB Title
local MBF = "|cffe1a500MBL|cff69ccf0Flares|cffffffff"   -- MBFlares Title
local versionNum = GetAddOnMetadata("MarkingBarLives", "Version")
local curVer = "|cffffffff "..versionNum.."|cffe1a500"      -- Version Number

DEFAULT_CHAT_FRAME:AddMessage(MB..curVer..' is loaded.')
DEFAULT_CHAT_FRAME:AddMessage(MB..' Use /mbl to access the options panel.')

-------------------------------------------------------
-- Databases with Variable Options and Backdrops
-------------------------------------------------------
MBDB = {
    shown = true,
    aloneShow = true,
	partyShow = true,
    raidShow = true,
	locked = false,
	ctrlLock = true,
	clamped = true,
	flipped = false,
	vertical = false,
	bgHide = false,
	tooltips = true,
	scale = 1,
	alpha = 1,
	msg_intro = "I will use the following marks:", --Remember to change below if you change here!!!
	msg_skull = "Kill",
	msg_cross = "then kill",
	msg_square = "Hunter - Freezing Trap",
	msg_moon = "Mage - Polymorph",
	msg_triangle = "Druid - Hibernate",
	msg_diamond = "Warlock - Seduce/Banish/Enslave Demon",
	msg_circle = "Priest - Shackle/Mind Control",
	msg_star = "Rogue - Sap",
	msg_footer = "Input other miscellaneous text to send here.",
	announce_intro = true,
	announce_skull = true,
	announce_cross = true,
	announce_square = true,
	announce_moon = true,
	announce_triangle = true,
	announce_diamond = true,
	announce_circle = true,
	announce_star = true,
    announce_footer = false,
    announce_tooltips = false,
	dummy = true,
}

MBCtrlDB = {
    shown = true,
    aloneShow = true,
	partyShow = true,
    raidShow = true,
	locked = true,
	clamped = true,
	vertical = false,
	bgHide = false,
	tooltips = true,
	scale = 1,
	alpha = 1,
	MarkersAP = "",
	MarkersX = 0,
	MarkersY = 0,
	FlaresAP = "",
	FlaresX = 0,
	FlaresY = 0,
}

MBFlaresDB = {
	shown = true,
    aloneShow = true,
	partyShow = true,
    raidShow = true,
	locked = false,
	clamped = true,
	flipped = false,
	vertical = false,
	bgHide = false,
	tooltips = true,
	scale = 1,
	alpha = 1,
    announce_rw = false,
    msg_rw = "Please look at raid chat to see raid mark descriptions.",
}

-- For later use --
MBGLOBAL = {}

local defaultBackdrop = {
	bgFile = "Interface\\AddOns\\MarkingBarLives\\resources\\UI-Tooltip-Background",
	edgeFile = "Interface\\AddOns\\MarkingBarLives\\resources\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4,}
}
local borderlessBackdrop = {
	bgFile = "Interface\\AddOns\\MarkingBarLives\\resources\\UI-Tooltip-Background",
	tile = true,
	tileSize = 16
}

local editBoxBackdrop = {
	bgFile = "Interface\\AddOns\\MarkingBarLives\\resources\\Common-Input-Border",
	tile = false,
}

MB_DEFAULT_BACKDROP = defaultBackdrop;
MB_BORDERLESS_BACKDROP = borderlessBackdrop;
MB_EDIT_BOX_BACKDROP = editBoxBackdrop;

MB_MAIN_FRAME_BACKDROP_COLOR = CreateColor(0, 0, 0)
MB_MOVER_LEFT_FRAME_BACKDROP_COLOR = CreateColor(0.1, 0.1, 0.1)
MB_BACKDROP_BORDER_COLOR = CreateColor(1, 1, 1)

-------------------------------------------------------
-- MB Main Frame and Movers
-------------------------------------------------------

--TODO: Need to check this
--MBL_RaidTargeting:SetUserPlaced(true)
--MBL_RaidTargeting:SetUserPlaced(false)

-------------------------------------------------------
-- MB Icon Frame and Icons
-------------------------------------------------------

-------------------------------------------------------
-- MB Control Frame
-------------------------------------------------------

-- TODO: This needs to get moved elsewhere now
--if MBDB.ctrlLock then
--    MBL_RaidControls:SetSize(100,35)
--end

-------------------------------------------------------
-- MBFlares Main Frame and Movers
-------------------------------------------------------

--TODO: Need to check this
--MBL_WorldMarkers:SetUserPlaced(true)
--MBL_WorldMarkers:SetUserPlaced(false)

-------------------------------------------------------
-- The Flare Frame and Flares
-------------------------------------------------------

--TODO: Need to check this
--flareWhite:SetAttribute("type", "macro")
--flareWhite:SetAttribute("macrotext1", "/wm 8")

--flareRed:SetAttribute("type", "macro")
--flareRed:SetAttribute("macrotext1", "/wm 4")

--flareBlue:SetAttribute("type", "macro")
--flareBlue:SetAttribute("macrotext1", "/wm 1")

--flareSilver:SetAttribute("type", "macro")
--flareSilver:SetAttribute("macrotext1", "/wm 7")

--flareGreen:SetAttribute("type", "macro")
--flareGreen:SetAttribute("macrotext1", "/wm 2")

--flarePurple:SetAttribute("type", "macro")
--flarePurple:SetAttribute("macrotext1", "/wm 3")

--flareOrange:SetAttribute("type", "macro")
--flareOrange:SetAttribute("macrotext1", "/wm 6")

--flareYellow:SetAttribute("type", "macro")
--flareYellow:SetAttribute("macrotext1", "/wm 5")

--flareClear:SetAttribute("type", "macro")
--flareClear:SetAttribute("macrotext1", "/cwm 0")

-------------------------------------------------------
-- Functions
-------------------------------------------------------

function MB_Announce()
	if IsInGroup(LE_PARTY_CATEGORY_HOME) then -- true if player is in a group. 
		if IsInRaid() then  -- IN A RAID
			if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then		-- ABLE TO MARK
				MB_Announce_to_Chat("RAID")	
			else							--NOT ABLE TO MARK
				ChatFrame1:AddMessage(MB .. ": You are not a Raid Leader or Raid Assistant. You cannot use raid markers.");
			end
		else -- IN A PARTY
			MB_Announce_to_Chat("PARTY") 
		end	
			else if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				if IsInRaid() then
					if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then		-- ABLE TO MARK
						MB_Announce_to_Chat("INSTANCE_CHAT")	
					else
				ChatFrame1:AddMessage(MB .. ": You are not a Raid Leader or Raid Assistant. You cannot use raid markers.");
			end
		else
				MB_Announce_to_Chat("INSTANCE_CHAT") 
			end
		else -- NOT IN RAID OR PARTY
			ChatFrame1:AddMessage(MB .. ": You are not in a Party or Raid.");
		end
	end
end

function MB_Announce_to_Chat(ChatType)
	if (MBDB.announce_intro) then
		SendChatMessage(MBDB.msg_intro,ChatType,nil)
	end
	if (MBDB.announce_skull) then
		SendChatMessage(MBDB.msg_skull .. " {rt8}.",ChatType,nil)
	end
	if (MBDB.announce_cross) then
		SendChatMessage(MBDB.msg_cross .. " {rt7}.",ChatType,nil)
	end
	if (MBDB.announce_square) then
		SendChatMessage(MBDB.msg_square .. " {rt6}.",ChatType,nil)
	end
	if (MBDB.announce_moon) then
		SendChatMessage(MBDB.msg_moon .. " {rt5}.",ChatType,nil)
	end
	if (MBDB.announce_triangle) then
		SendChatMessage(MBDB.msg_triangle .. " {rt4}.",ChatType,nil)
	end
	if (MBDB.announce_diamond) then
		SendChatMessage(MBDB.msg_diamond .. " {rt3}.",ChatType,nil)
	end
	if (MBDB.announce_circle) then
		SendChatMessage(MBDB.msg_circle .. " {rt2}.",ChatType,nil)
	end
	if (MBDB.announce_star) then
		SendChatMessage(MBDB.msg_star .. " {rt1}.",ChatType,nil)
	end
    if (MBDB.announce_footer) then
		SendChatMessage(MBDB.msg_footer,ChatType,nil)
	end

    if ( ChatType == "RAID") then
        if MBFlaresDB.announce_rw then
            SendChatMessage(MBFlaresDB.msg_rw,ChatType,nil);
            SendChatMessage(MBFlaresDB.msg_rw,"RAID_WARNING",nil);
        end
    end
end

function MB_targetChecker(DB)
    if ( DB == "main" ) then
        MBL_RaidTargeting:Hide()
            if ( MBDB.shown == false ) then           -- show only with target
            if ( UnitExists("target") ) then    -- target exists
                MB_partyChecker(DB)
            else
                MBL_RaidTargeting:Hide()
            end
        else                                    -- show regardless of target
            MB_partyChecker(DB)
        end
    elseif ( DB == "ctrl" ) then
        MBL_RaidControls:Hide()
            if ( MBCtrlDB.shown == false ) then           -- show only with target
            if ( UnitExists("target") ) then    -- target exists
                MB_partyChecker(DB)
            else
                MBL_RaidControls:Hide()
            end
        else                                    -- show regardless of target
            MB_partyChecker(DB)
        end
    elseif ( DB == "flare" ) then
        MBL_WorldMarkers:Hide()
                if ( MBFlaresDB.shown == false ) then           -- show only with target
            if ( UnitExists("target") ) then    -- target exists
                MB_partyChecker(DB)
            else
                MBL_WorldMarkers:Hide()
            end
        else                                    -- show regardless of target
            MB_partyChecker(DB)
        end
    end
end

function MB_partyChecker(DB)
    if ( DB == "main" ) then
		if (IsInGroup()) then -- IN A PARTY OR RAID
			if (IsInRaid()) then -- IN A RAID
				if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
					MBL_RaidTargeting:Show()
				end
			else -- IN APARTY
				if ( MBDB.partyShow == true ) then
					MBL_RaidTargeting:Show()
				else
					MBL_RaidTargeting:Hide()
				end
			end
		else -- NOT IN ANY GROUP
			if ( MBDB.aloneShow == true ) then
				MBL_RaidTargeting:Show()
			else
				MBL_RaidTargeting:Hide()
			end
		end
    elseif ( DB == "ctrl" ) then
		if (IsInGroup()) then -- IN A PARTY OR RAID
			if (IsInRaid()) then -- IN A RAID
				if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
					MBL_RaidControls:Show()
				end
			else -- IN APARTY
				if ( MBCtrlDB.partyShow == true ) then
					MBL_RaidControls:Show()
				else
					MBL_RaidControls:Hide()
				end
			end
		else -- NOT IN ANY GROUP
			if ( MBCtrlDB.aloneShow == true ) then
				MBL_RaidControls:Show()
			else
				MBL_RaidControls:Hide()
			end
		end
    elseif ( DB == "flare" ) then
		if (IsInGroup()) then -- IN A PARTY OR RAID
			if (IsInRaid()) then -- IN A RAID
				if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
					MBL_WorldMarkers:Show()
				end
			else -- IN APARTY
				if ( MBFlaresDB.partyShow == true ) then
					MBL_WorldMarkers:Show()
				else
					MBL_WorldMarkers:Hide()
				end
			end
		else -- NOT IN ANY GROUP
			if ( MBFlaresDB.aloneShow == true ) then
				MBL_WorldMarkers:Show()
			else
				MBL_WorldMarkers:Hide()
			end
		end
    end
end

function MB_lock(DB)
    if ( DB == "main" ) then
        MBDB.locked = true
        MBL_RaidTargeting_Mover:SetAlpha(0)
        MBL_RaidTargeting_Mover:EnableMouse(false)
        lockIcon:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
    elseif  ( DB == "ctrl" ) then
        MBCtrlDB.locked = true
        moverRight:SetAlpha(0)
        moverRight:EnableMouse(false)
        ctrlLockIcon:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
    elseif  ( DB == "flare" ) then
        MBFlaresDB.locked = true
    	MBFlares_MBL_RaidTargeting_Mover:SetAlpha(0)
        MBFlares_MBL_RaidTargeting_Mover:EnableMouse(false)
        flarelockIcon:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
    end
end

function MB_unlock(DB)
    if ( DB == "main" ) then
        MBDB.locked = false
        MBL_RaidTargeting_Mover:SetAlpha(1)
        MBL_RaidTargeting_Mover:EnableMouse(true)
        lockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
    elseif  ( DB == "ctrl" ) then
        MBCtrlDB.locked = false
        moverRight:SetAlpha(1)
        moverRight:EnableMouse(true)
        ctrlLockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
    elseif  ( DB == "flare" ) then
        MBFlaresDB.locked = false
        MBFlares_MBL_RaidTargeting_Mover:SetAlpha(1)
        MBFlares_MBL_RaidTargeting_Mover:EnableMouse(true)
        flarelockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
    end
end

function MB_lockToggle(DB)
    if ( DB == "main" ) then
        if MBDB.locked then MB_unlock("main") else MB_lock("main") end
    elseif ( DB == "ctrl" ) then
        if MBCtrlDB.locked then
            if MBDB.ctrlLock then MB_ctrlUnlock() end -- if ctrl is connected to icons
            MB_unlock("ctrl")
        else
            MB_lock("ctrl")
        end
    elseif ( DB == "flare" ) then
        if MBFlaresDB.locked then MB_unlock("flare") else MB_lock("flare") end
    end
end

function MB_ctrlLock()
	MBDB.ctrlLock = true
    MB_lock("ctrl")
    MB_flipChecker()
end

function MB_ctrlUnlock()
	MBDB.ctrlLock = false
    MB_unlock("ctrl")
    MB_flipChecker()
end

function MB_ctrlLockToggle()
	if (MBDB.ctrlLock == true) then
		MB_ctrlUnlock()
	else
		MB_ctrlLock()
	end
end

function MB_reset_msg() 	--Remember to change up top if you change here!!!
	MBDB.msg_intro = "I will use the following marks:"
	MBDB.msg_skull = "Kill"
	MBDB.msg_cross = "Then kill"
	MBDB.msg_square = "Hunter - Freezing Trap"
	MBDB.msg_moon = "Mage - Polymorph"
	MBDB.msg_triangle = "Druid - Hibernate"
	MBDB.msg_diamond = "Warlock - Seduce/Banish/Enslave Demon"
	MBDB.msg_circle = "Priest - Shackle/Mind Control"
	MBDB.msg_star = "Rogue - Sap"
    MBDB.msg_footer = "Input other miscellaneous text to send here."
	MBDB.announce_intro = true
	MBDB.announce_skull = true
	MBDB.announce_cross = true
	MBDB.announce_square = true
	MBDB.announce_moon = true
	MBDB.announce_triangle = true
	MBDB.announce_diamond = true
	MBDB.announce_circle = true
	MBDB.announce_star = true
    MBDB.announce_footer = false
    MBFlaresDB.announce_rw = false
    MBFlaresDB.msg_rw = "Please look at raid chat to see raid mark descriptions."
end

function MB_reset()
    -- reset variables
    MBDB.ctrlLock = true
	MBDB.shown = true
    MBDB.aloneShow = true
	MBDB.partyShow = true
    MBDB.raidShow = true
	MBDB.locked= false
	MBDB.clamped = true
	MBDB.flipped = false
	MBDB.vertical = false
	MBDB.bgHide = false
	MBDB.tooltips = true
	MBDB.scale = 1
	MBDB.alpha = 1

	MB_reset_msg()

    --reset orientations
    MB_targetChecker("main")
	MB_unlock("main")
	MBL_RaidTargeting:SetClampedToScreen(true)
	MB_bgShow("main")

    --reset variables for Ctrl
	MBCtrlDB.shown = true
    MBCtrlDB.aloneShow = true
	MBCtrlDB.partyShow = true
    MBCtrlDB.raidShow = true
	MBCtrlDB.locked = true
	MBCtrlDB.clamped = true
	MBCtrlDB.vertical = false
	MBCtrlDB.bgHide = false
	MBCtrlDB.tooltips = true
    MBDB.announce_tooltip = false
	MBCtrlDB.scale = 1
	MBCtrlDB.alpha = 1
    --reset orientation for Ctrl
	MB_targetChecker("ctrl")
    MB_ctrlLock()
	MB_lock("ctrl")
	MBL_RaidControls:SetClampedToScreen(true)
	MB_bgShow("ctrl")

	MB_flipChecker()

    --reset variables for flares
	MBFlaresDB.shown = true
    MBFlaresDB.aloneShow = true
	MBFlaresDB.partyShow = true
    MBFlaresDB.raidShow = true
	MBFlaresDB.locked = false
	MBFlaresDB.clamped = true
	MBFlaresDB.bgHide = false
	MBFlaresDB.tooltips = true
	MBFlaresDB.scale = 1
	MBFlaresDB.alpha = 1
    --reset orientation for flares
	MB_targetChecker("flare")
	MB_unlock("flare")
	MBL_WorldMarkers:SetClampedToScreen(true)
    MB_flareflip(1)
	MB_bgShow("flare")
    --updates checkmarks
    --reset frames to center positions
	MBL_RaidTargeting:ClearAllPoints()
    MBL_RaidControls:ClearAllPoints()
	MBL_WorldMarkers:ClearAllPoints()
	MBL_RaidTargeting:SetPoint("TOP", UIParent, "TOP")
    MBL_RaidControls:SetPoint("LEFT", MBL_RaidTargeting_Icons, "RIGHT",5,0)
	MBL_WorldMarkers:SetPoint("TOP", UIParent, "TOP",0,-50)
	MB_checkUpdater()
end

function MB_savepositions()
	local f_ap, _, _, f_x, f_y = MBL_WorldMarkers:GetPoint() -- :)
	local m_ap, _, _, m_x, m_y = MBL_RaidTargeting:GetPoint()
	MBCtrlDB.FlaresAP = f_ap
	MBCtrlDB.FlaresX = f_x
	MBCtrlDB.FlaresY = f_y
	MBCtrlDB.MarkersAP = m_ap
	MBCtrlDB.MarkersX = m_x
	MBCtrlDB.MarkersY = m_y
end

function MB_setpositions()
	if (MBCtrlDB.MarkersX ~= nil) then
		MBL_RaidTargeting:ClearAllPoints()
		MBL_WorldMarkers:ClearAllPoints()
		MBL_RaidTargeting:SetPoint(MBCtrlDB.MarkersAP, UIParent, MBCtrlDB.MarkersX, MBCtrlDB.MarkersY)
		MBL_WorldMarkers:SetPoint(MBCtrlDB.FlaresAP, UIParent, MBCtrlDB.FlaresX, MBCtrlDB.FlaresY)
		MB_checkUpdater()
	end
end;

function MB_flip(dir)
	iconSkull:ClearAllPoints()
	iconCross:ClearAllPoints()
	iconSquare:ClearAllPoints()
	iconMoon:ClearAllPoints()
	iconTriangle:ClearAllPoints()
	iconDiamond:ClearAllPoints()
	iconCircle:ClearAllPoints()
	iconStar:ClearAllPoints()
	lockIcon:ClearAllPoints()
	MBL_RaidTargeting_Mover:ClearAllPoints()
	MBL_RaidTargeting_Icons:ClearAllPoints()
    announceIcon:ClearAllPoints()
	readyCheck:ClearAllPoints()
	roleCheck:ClearAllPoints()
	optIcon:ClearAllPoints()
    ctrlLockIcon:ClearAllPoints()
    moverRight:ClearAllPoints()
	if (dir==1) then -- Normal
		iconSkull:SetPoint("LEFT", MBL_RaidTargeting_Icons, "LEFT",5,0)
		iconCross:SetPoint("LEFT", iconSkull, "RIGHT")
		iconSquare:SetPoint("LEFT", iconCross, "RIGHT")
		iconMoon:SetPoint("LEFT", iconSquare, "RIGHT")
		iconTriangle:SetPoint("LEFT", iconMoon, "RIGHT")
		iconDiamond:SetPoint("LEFT", iconTriangle, "RIGHT")
		iconCircle:SetPoint("LEFT", iconDiamond, "RIGHT")
		iconStar:SetPoint("LEFT", iconCircle, "RIGHT")
		lockIcon:SetPoint("LEFT", iconStar , "RIGHT")
		MBL_RaidTargeting:SetSize(190,35)
		MBL_RaidTargeting_Icons:SetSize(190,35)
		MBL_RaidTargeting_Icons:SetPoint("LEFT", MBL_RaidTargeting, "LEFT")
        MBL_RaidTargeting_Mover:SetSize(20,35)
		MBL_RaidTargeting_Mover:SetPoint("RIGHT", MBL_RaidTargeting, "LEFT")
	elseif (dir==2) then -- Backwards
		iconStar:SetPoint("LEFT", MBL_RaidTargeting_Icons, "LEFT",5,0)
		iconCircle:SetPoint("LEFT", iconStar, "RIGHT")
		iconDiamond:SetPoint("LEFT", iconCircle, "RIGHT")
		iconTriangle:SetPoint("LEFT", iconDiamond, "RIGHT")
		iconMoon:SetPoint("LEFT", iconTriangle, "RIGHT")
		iconSquare:SetPoint("LEFT", iconMoon, "RIGHT")
		iconCross:SetPoint("LEFT", iconSquare, "RIGHT")
		iconSkull:SetPoint("LEFT", iconCross, "RIGHT")
		lockIcon:SetPoint("LEFT", iconSkull , "RIGHT")
		MBL_RaidTargeting:SetSize(190,35)
		MBL_RaidTargeting_Icons:SetSize(190,35)
		MBL_RaidTargeting_Icons:SetPoint("LEFT", MBL_RaidTargeting, "LEFT")
		MBL_RaidTargeting_Mover:SetSize(20,35)
		MBL_RaidTargeting_Mover:SetPoint("RIGHT", MBL_RaidTargeting, "LEFT")
	elseif (dir==3) then -- Normal vertical
		iconSkull:SetPoint("TOP", MBL_RaidTargeting_Icons, "TOP",0,-5)
		iconCross:SetPoint("TOP", iconSkull, "BOTTOM")
		iconSquare:SetPoint("TOP", iconCross, "BOTTOM")
		iconMoon:SetPoint("TOP", iconSquare, "BOTTOM")
		iconTriangle:SetPoint("TOP", iconMoon, "BOTTOM")
		iconDiamond:SetPoint("TOP", iconTriangle, "BOTTOM")
		iconCircle:SetPoint("TOP", iconDiamond, "BOTTOM")
		iconStar:SetPoint("TOP", iconCircle, "BOTTOM")
		lockIcon:SetPoint("TOP", iconStar , "BOTTOM")
		MBL_RaidTargeting:SetSize(35,190)
		MBL_RaidTargeting_Icons:SetSize(35,190)
		MBL_RaidTargeting_Icons:SetPoint("TOP", MBL_RaidTargeting, "TOP")
		MBL_RaidTargeting_Mover:SetSize(35,20)
		MBL_RaidTargeting_Mover:SetPoint("BOTTOM", MBL_RaidTargeting, "TOP")
	elseif (dir==4) then -- Backwards vertical
		iconStar:SetPoint("TOP", MBL_RaidTargeting_Icons, "TOP",0,-5)
		iconCircle:SetPoint("TOP", iconStar, "BOTTOM")
		iconDiamond:SetPoint("TOP", iconCircle, "BOTTOM")
		iconTriangle:SetPoint("TOP", iconDiamond, "BOTTOM")
		iconMoon:SetPoint("TOP", iconTriangle, "BOTTOM")
		iconSquare:SetPoint("TOP", iconMoon, "BOTTOM")
		iconCross:SetPoint("TOP", iconSquare, "BOTTOM")
		iconSkull:SetPoint("TOP", iconCross, "BOTTOM")
		lockIcon:SetPoint("TOP", iconSkull , "BOTTOM")
		MBL_RaidTargeting:SetSize(35,190)
		MBL_RaidTargeting_Icons:SetSize(35,190)
		MBL_RaidTargeting_Icons:SetPoint("TOP", MBL_RaidTargeting, "TOP")
		MBL_RaidTargeting_Mover:SetSize(35,20)
		MBL_RaidTargeting_Mover:SetPoint("BOTTOM", MBL_RaidTargeting, "TOP")
	end
    if MBCtrlDB.vertical then
            -- and stuff for control options vertically
		announceIcon :SetPoint("TOP", MBL_RaidControls, "TOP",0,-10)
		readyCheck:SetPoint("TOP", announceIcon , "BOTTOM")
		roleCheck:SetPoint("TOP", readyCheck , "BOTTOM")
		optIcon:SetPoint("TOP", roleCheck , "BOTTOM")
		if MBDB.ctrlLock then
            MBL_RaidControls:ClearAllPoints()
            MBL_RaidControls:SetSize(35,100)
            ctrlLockIcon:SetAlpha(0)
            ctrlLockIcon:EnableMouse(false)
            moverRight:SetAlpha(0)
            moverRight:EnableMouse(false)
            MBL_RaidControls:SetParent(MBL_RaidTargeting)
            MBL_RaidControls:SetPoint("TOP", MBL_RaidTargeting_Icons, "BOTTOM",0,5)
        else
            MBL_RaidControls:SetSize(35,120)
            ctrlLockIcon:SetAlpha(1)
            ctrlLockIcon:EnableMouse(true)
            MBL_RaidControls:SetParent(UIParent)
            ctrlLockIcon:SetPoint("TOP", optIcon , "BOTTOM")
            moverRight:SetSize(35,20)
            moverRight:SetPoint("TOP", MBL_RaidControls, "BOTTOM")
        end
    else
            -- and stuff for control options horizontally
		announceIcon :SetPoint("LEFT", MBL_RaidControls, "LEFT",10,0)
		readyCheck:SetPoint("LEFT", announceIcon , "RIGHT")
		roleCheck:SetPoint("LEFT", readyCheck , "RIGHT")
		optIcon:SetPoint("LEFT", roleCheck , "RIGHT")
 		if MBDB.ctrlLock then
            MBL_RaidControls:ClearAllPoints()
            MBL_RaidControls:SetSize(100,35)
            ctrlLockIcon:SetAlpha(0)
            ctrlLockIcon:EnableMouse(false)
            moverRight:SetAlpha(0)
            moverRight:EnableMouse(false)
            MBL_RaidControls:SetPoint("LEFT", MBL_RaidTargeting_Icons, "RIGHT",5,0)
        else
            MBL_RaidControls:SetSize(120,35)
            ctrlLockIcon:SetAlpha(1)
            ctrlLockIcon:EnableMouse(true)
            ctrlLockIcon:SetPoint("LEFT", optIcon , "RIGHT")
            moverRight:SetSize(20,35)
            moverRight:SetPoint("LEFT", MBL_RaidControls , "RIGHT")
        end
    end
end

function MB_flipChecker()
	if (MBDB.flipped==false) and (MBDB.vertical==false) then
		MB_flip(1)
	elseif (MBDB.flipped==true) and (MBDB.vertical==false) then
		MB_flip(2)
	elseif (MBDB.flipped==false) and (MBDB.vertical==true) then
		MB_flip(3)
	elseif (MBDB.flipped==true) and (MBDB.vertical==true) then
		MB_flip(4)
	end
end

function MB_flareflip(dir)
	flareWhite:ClearAllPoints()
	flareRed:ClearAllPoints()
	flareBlue:ClearAllPoints()
	flareSilver:ClearAllPoints()
	flareGreen:ClearAllPoints()
	flarePurple:ClearAllPoints()
	flareOrange:ClearAllPoints()
	flareYellow:ClearAllPoints()
	flareClear:ClearAllPoints()
	flarelockIcon:ClearAllPoints()
	MB_flareFrame:ClearAllPoints()
	MBFlares_MBL_RaidTargeting_Mover:ClearAllPoints()
	if (dir==1) then -- Normal
		flareWhite:SetPoint("TOPLEFT", MB_flareFrame, "TOPLEFT",4,-5)
		flareRed:SetPoint("LEFT", flareWhite, "RIGHT")
		flareBlue:SetPoint("LEFT", flareRed, "RIGHT")
		flareSilver:SetPoint("LEFT", flareBlue, "RIGHT")
		flareGreen:SetPoint("LEFT", flareSilver, "RIGHT")
		flarePurple:SetPoint("LEFT", flareGreen, "RIGHT")
		flareOrange:SetPoint("LEFT", flarePurple, "RIGHT")
		flareYellow:SetPoint("LEFT", flareOrange, "RIGHT")
		flareClear:SetPoint("LEFT", flareYellow, "RIGHT",3,0)
		flarelockIcon:SetPoint("LEFT", flareClear, "RIGHT",5,0)
		MBL_WorldMarkers:SetSize(180,35)
		MB_flareFrame:SetSize(255,35) --180
		MB_flareFrame:SetPoint("LEFT", MBL_WorldMarkers, "LEFT")
		MBFlares_MBL_RaidTargeting_Mover:SetSize(20,35)
		MBFlares_MBL_RaidTargeting_Mover:SetPoint("RIGHT", MBL_WorldMarkers, "LEFT")
	elseif (dir==2) then -- Backwards
		flareYellow:SetPoint("TOPLEFT", MB_flareFrame, "TOPLEFT",4,-5)
		flareOrange:SetPoint("LEFT", flareYellow, "RIGHT")
		flarePurple:SetPoint("LEFT", flareOrange, "RIGHT")
		flareGreen:SetPoint("LEFT", flarePurple, "RIGHT")
		flareSilver:SetPoint("LEFT", flareGreen, "RIGHT")
		flareBlue:SetPoint("LEFT", flareSilver, "RIGHT")
		flareRed:SetPoint("LEFT", flareBlue, "RIGHT")
		flareWhite:SetPoint("LEFT", flareRed, "RIGHT")
		flareClear:SetPoint("LEFT", flareWhite, "RIGHT",3,0)
		flarelockIcon:SetPoint("LEFT", flareClear, "RIGHT",5,0)
		MBL_WorldMarkers:SetSize(180,35)
		MB_flareFrame:SetSize(255,35) --180
		MB_flareFrame:SetPoint("LEFT", MBL_WorldMarkers, "LEFT")
		MBFlares_MBL_RaidTargeting_Mover:SetSize(20,35)
		MBFlares_MBL_RaidTargeting_Mover:SetPoint("RIGHT", MBL_WorldMarkers, "LEFT")
	elseif (dir==3) then -- Normal vertical
		flareWhite:SetPoint("TOPLEFT", MB_flareFrame, "TOPLEFT",4,-5)
		flareRed:SetPoint("TOP", flareWhite, "BOTTOM")
		flareBlue:SetPoint("TOP", flareRed, "BOTTOM")
		flareSilver:SetPoint("TOP", flareBlue, "BOTTOM")
		flareGreen:SetPoint("TOP", flareSilver, "BOTTOM")
		flarePurple:SetPoint("TOP", flareGreen, "BOTTOM")
		flareOrange:SetPoint("TOP", flarePurple, "BOTTOM")
		flareYellow:SetPoint("TOP", flareOrange, "BOTTOM")
		flareClear:SetPoint("TOP", flareYellow, "BOTTOM",0,-3)
		flarelockIcon:SetPoint("TOP", flareClear, "BOTTOM",0,-5)
		MBL_WorldMarkers:SetSize(35,180)
		MB_flareFrame:SetSize(35,255) --180
		MB_flareFrame:SetPoint("TOP", MBL_WorldMarkers, "TOP")
		MBFlares_MBL_RaidTargeting_Mover:SetSize(35,20)
		MBFlares_MBL_RaidTargeting_Mover:SetPoint("BOTTOM", MBL_WorldMarkers, "TOP")
	elseif (dir==4) then -- Backwards vertical
		flareYellow:SetPoint("TOPLEFT", MB_flareFrame, "TOPLEFT",4,-5)
		flareOrange:SetPoint("TOP", flareYellow, "BOTTOM")
		flarePurple:SetPoint("TOP", flareOrange, "BOTTOM")
		flareGreen:SetPoint("TOP", flarePurple, "BOTTOM")
		flareSilver:SetPoint("TOP", flareGreen, "BOTTOM")
		flareBlue:SetPoint("TOP", flareSilver, "BOTTOM")
		flareRed:SetPoint("TOP", flareBlue, "BOTTOM")
		flareWhite:SetPoint("TOP", flareRed, "BOTTOM")
		flareClear:SetPoint("TOP", flareWhite, "BOTTOM",0,-3)
		flarelockIcon:SetPoint("TOP", flareClear, "BOTTOM",0,-5)
		MBL_WorldMarkers:SetSize(35,180)
		MB_flareFrame:SetSize(35,255) --180
		MB_flareFrame:SetPoint("TOP", MBL_WorldMarkers, "TOP")
		MBFlares_MBL_RaidTargeting_Mover:SetSize(35,20)
		MBFlares_MBL_RaidTargeting_Mover:SetPoint("BOTTOM", MBL_WorldMarkers, "TOP")
	end
end

function MB_flareflipChecker()
	if (not MBFlaresDB.flipped) and ( not MBFlaresDB.vertical) then
		MB_flareflip(1)
	elseif (MBFlaresDB.flipped) and ( not MBFlaresDB.vertical) then
		MB_flareflip(2)
	elseif (not MBFlaresDB.flipped) and (MBFlaresDB.vertical) then
		MB_flareflip(3)
	elseif (MBFlaresDB.flipped) and (MBFlaresDB.vertical) then
		MB_flareflip(4)
	end
end

function MB_bgToggle(DB)
    if ( DB == "main" ) then
    	if ( MBDB.bgHide ) then MBDB.bgHide = false; MB_bgShow("main") else	MBDB.bgHide = true; MB_bgHide("main") end
    elseif ( DB == "ctrl" ) then
    	if ( MBCtrlDB.bgHide ) then MBCtrlDB.bgHide = false; MB_bgShow("ctrl") else	MBCtrlDB.bgHide = true; MB_bgHide("ctrl") end
    elseif ( DB == "flare" ) then
    	if ( MBFlaresDB.bgHide ) then MBFlaresDB.bgHide = false; MB_bgShow("flare") else MBFlaresDB.bgHide = true; MB_bgHide("flare") end
    end
end

function MB_bgHide(DB)
    if ( DB == "main" ) then
        MBL_RaidTargeting_Icons:SetBackdropColor(0,0,0,0)
        MBL_RaidTargeting_Icons:SetBackdropBorderColor(0,0,0,0)
    elseif ( DB == "ctrl" ) then
        MBL_RaidControls:SetBackdropColor(0,0,0,0)
        MBL_RaidControls:SetBackdropBorderColor(0,0,0,0)
    elseif ( DB == "flare" ) then
        flareFrame:SetBackdropColor(0,0,0,0)
        flareFrame:SetBackdropBorderColor(0,0,0,0)
    end
end

function MB_bgShow(DB)
    if ( DB == "main" ) then
        MBL_RaidTargeting_Icons:SetBackdropColor(0.1,0.1,0.1,0.7)
        MBL_RaidTargeting_Icons:SetBackdropBorderColor(1,1,1,1)
    elseif ( DB == "ctrl" ) then
        MBL_RaidControls:SetBackdropColor(0.1,0.1,0.1,0.7)
        MBL_RaidControls:SetBackdropBorderColor(1,1,1,1)
    elseif ( DB == "flare" ) then
        MB_flareFrame:SetBackdropColor(0.1,0.1,0.1,0.7)
        MB_flareFrame:SetBackdropBorderColor(1,1,1,1)
    end
end

function MB_scale(self,DB)
	if self == nil then return end
    if ( DB == "main" ) then
    	MBDB.scale = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." scale: "..math.floor((MBDB.scale*100)).."%")
        MBL_RaidTargeting:SetScale(MBDB.scale);
    elseif ( DB == "ctrl" ) then
    	MBCtrlDB.scale = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." controls scale: "..math.floor((MBCtrlDB.scale*100)).."%")
        MBL_RaidControls:SetScale(MBCtrlDB.scale);
    elseif ( DB == "flare" ) then
    	MBFlaresDB.scale = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MBF .." scale: "..math.floor((MBFlaresDB.scale*100)).."%")
        MBL_WorldMarkers:SetScale(MBFlaresDB.scale);
    end
end

function MB_alpha(self,DB)
	if self == nil then return end
    if ( DB == "main" ) then
        MBDB.alpha = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." opacity: "..math.floor((MBDB.alpha*100)).."%")
        MBL_RaidTargeting:SetAlpha(MBDB.alpha);
    elseif ( DB == "ctrl" ) then
        MBCtrlDB.alpha = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MB .." controls opacity: "..math.floor((MBCtrlDB.alpha*100)).."%")
        MBL_RaidControls:SetAlpha(MBCtrlDB.alpha);
    elseif ( DB == "flare" ) then
        MBFlaresDB.alpha = (self:GetValue());
        getglobal(self:GetName().."Text"):SetText(MBF .." opacity: "..math.floor((MBFlaresDB.alpha*100)).."%")
        MBL_WorldMarkers:SetAlpha(MBFlaresDB.alpha);
    end
end

function MB_checkUpdater()
	showCheck:SetChecked(MBDB.shown)
    aloneCheck:SetChecked(MBDB.aloneShow)
	partyCheck:SetChecked(MBDB.partyShow)
    raidCheck:SetChecked(MBDB.raidShow)
	lockCheck:SetChecked(MBDB.locked)
    ctrlCheck:SetChecked(MBDB.ctrlLock)
	clampCheck:SetChecked(MBDB.clamped)
	flipCheck:SetChecked(MBDB.flipped)
	vertCheck:SetChecked(MBDB.vertical)
	bgCheck:SetChecked(MBDB.bgHide)
	toolCheck:SetChecked(MBDB.tooltips)
	getglobal(scaleSlider:GetName().."Low"):SetText("50%")
	getglobal(scaleSlider:GetName().."High"):SetText("150%")
	getglobal(scaleSlider:GetName().."Text"):SetText(MB .." scale: "..math.floor((MBDB.scale*100)).."%")
	scaleSlider:SetValue(MBDB.scale)
	getglobal(alphaSlider:GetName().."Low"):SetText("0%")
	getglobal(alphaSlider:GetName().."High"):SetText("100%")
	getglobal(alphaSlider:GetName().."Text"):SetText(MB .." opacity: "..math.floor((MBDB.alpha*100)).."%")
	alphaSlider:SetValue(MBDB.alpha)

    ctrlShowCheck:SetChecked(MBCtrlDB.shown)
    ctrlAloneCheck:SetChecked(MBCtrlDB.aloneShow)
	ctrlPartyCheck:SetChecked(MBCtrlDB.partyShow)
    ctrlRaidCheck:SetChecked(MBCtrlDB.raidShow)
	ctrlLockCheck:SetChecked(MBCtrlDB.locked)
	ctrlClampCheck:SetChecked(MBCtrlDB.clamped)
	ctrlVertCheck:SetChecked(MBCtrlDB.vertical)
	ctrlBgCheck:SetChecked(MBCtrlDB.bgHide)
	ctrlToolCheck:SetChecked(MBCtrlDB.tooltips)
	getglobal(ctrlScaleSlider:GetName().."Low"):SetText("50%")
	getglobal(ctrlScaleSlider:GetName().."High"):SetText("150%")
	getglobal(ctrlScaleSlider:GetName().."Text"):SetText(MB .." scale: "..math.floor((MBCtrlDB.scale*100)).."%")
	ctrlScaleSlider:SetValue(MBCtrlDB.scale)
	getglobal(ctrlAlphaSlider:GetName().."Low"):SetText("0%")
	getglobal(ctrlAlphaSlider:GetName().."High"):SetText("100%")
	getglobal(ctrlAlphaSlider:GetName().."Text"):SetText(MB .." opacity: "..math.floor((MBCtrlDB.alpha*100)).."%")
	ctrlAlphaSlider:SetValue(MBCtrlDB.alpha)

	flareShowCheck:SetChecked(MBFlaresDB.shown)
    flareAloneCheck:SetChecked(MBFlaresDB.aloneShow)
	flarePartyCheck:SetChecked(MBFlaresDB.partyShow)
    flareRaidCheck:SetChecked(MBFlaresDB.raidShow)
	flareLockCheck:SetChecked(MBFlaresDB.locked)
	flareClampCheck:SetChecked(MBFlaresDB.clamped)
	flareflipCheck:SetChecked(MBFlaresDB.flipped)
	flarevertCheck:SetChecked(MBFlaresDB.vertical)
	flareBgCheck:SetChecked(MBFlaresDB.bgHide)
	flareToolCheck:SetChecked(MBFlaresDB.tooltips)
	getglobal(flareScaleSlider:GetName().."Low"):SetText("50%")
	getglobal(flareScaleSlider:GetName().."High"):SetText("150%")
	getglobal(flareScaleSlider:GetName().."Text"):SetText(MBF .. " scale: "..math.floor((MBFlaresDB.scale*100)).."%")
	flareScaleSlider:SetValue(MBFlaresDB.scale)
	getglobal(flareAlphaSlider:GetName().."Low"):SetText("0%")
	getglobal(flareAlphaSlider:GetName().."High"):SetText("100%")
	getglobal(flareAlphaSlider:GetName().."Text"):SetText(MBF .. " opacity: "..math.floor((MBFlaresDB.alpha*100)).."%")
	flareAlphaSlider:SetValue(MBFlaresDB.alpha)

    MB_Update_Announce()
end
function MB_Update_Announce()
	AnnounceIntroCheck:SetChecked(MBDB.announce_intro)
	AnnounceIntroMsg:SetText(MBDB.msg_intro)
    AnnounceIntroMsg:SetCursorPosition(0)
	AnnounceskullCheck:SetChecked(MBDB.announce_skull)
	AnnounceskullMsg:SetText(MBDB.msg_skull)
    AnnounceskullMsg:SetCursorPosition(0)
	AnnouncecrossCheck:SetChecked(MBDB.announce_cross)
	AnnouncecrossMsg:SetText(MBDB.msg_cross)
    AnnouncecrossMsg:SetCursorPosition(0)
	AnnouncesquareCheck:SetChecked(MBDB.announce_square)
	AnnouncesquareMsg:SetText(MBDB.msg_square)
	AnnouncesquareMsg:SetCursorPosition(0)
    AnnouncemoonCheck:SetChecked(MBDB.announce_moon)
	AnnouncemoonMsg:SetText(MBDB.msg_moon)
	AnnouncemoonMsg:SetCursorPosition(0)
    AnnouncetriangleCheck:SetChecked(MBDB.announce_triangle)
	AnnouncetriangleMsg:SetText(MBDB.msg_triangle)
	AnnouncetriangleMsg:SetCursorPosition(0)
    AnnouncediamondCheck:SetChecked(MBDB.announce_diamond)
	AnnouncediamondMsg:SetText(MBDB.msg_diamond)
	AnnouncediamondMsg:SetCursorPosition(0)
    AnnouncecircleCheck:SetChecked(MBDB.announce_circle)
	AnnouncecircleMsg:SetText(MBDB.msg_circle)
	AnnouncecircleMsg:SetCursorPosition(0)
    AnnouncestarCheck:SetChecked(MBDB.announce_star)
	AnnouncestarMsg:SetText(MBDB.msg_star)
    AnnouncestarMsg:SetCursorPosition(0)
    AnnouncefooterCheck:SetChecked(MBDB.announce_footer)
	AnnouncefooterMsg:SetText(MBDB.msg_footer)
    AnnouncefooterMsg:SetCursorPosition(0)
    AnnouncerwCheck:SetChecked(MBFlaresDB.announce_rw)
    AnnouncerwMsg:SetText(MBFlaresDB.msg_rw)
    AnnouncerwMsg:SetCursorPosition(0)
    AnnouncetooltipCheck:SetChecked(MBDB.announce_tooltip)
end

function MB_Announce_Save()
	MBDB.msg_intro = AnnounceIntroMsg:GetText()
	MBDB.msg_skull = AnnounceskullMsg:GetText()
	MBDB.msg_cross = AnnouncecrossMsg:GetText()
	MBDB.msg_square = AnnouncesquareMsg:GetText()
	MBDB.msg_moon = AnnouncemoonMsg:GetText()
	MBDB.msg_triangle = AnnouncetriangleMsg:GetText()
	MBDB.msg_diamond = AnnouncediamondMsg:GetText()
	MBDB.msg_circle = AnnouncecircleMsg:GetText()
	MBDB.msg_star = AnnouncestarMsg:GetText()
    MBDB.msg_footer = AnnouncefooterMsg:GetText()
    MBFlaresDB.msg_rw = AnnouncerwMsg:GetText()
end

-------------------------------------------------------
-- Slash Commands
-------------------------------------------------------

SLASH_MB1 = '/MBL'
SLASH_MB2 = '/MBLF'
SLASH_MB3 = "/MARKINGBARLIVES"
SLASH_MB4 = "/MBLFLARES"
SLASH_MB5 = "/MARKINGBARLIVESFLARES"
function SlashCmdList.MB(msg, editbox)
	local chan
	if (msg=="reset") then
		MB_reset()
    elseif (msg=="options") then
		InterfaceOptionsFrame_OpenToCategory(MarkingBarOpt.panel)
	else
		DEFAULT_CHAT_FRAME:AddMessage(MB..": v"..versionNum.." Author: "..GetAddOnMetadata("MarkingBarLives", "Author"))
		DEFAULT_CHAT_FRAME:AddMessage("use /mbl options to open configuration screen")
	end
end


-------------------------------------------------------
-- Profile Page
-------------------------------------------------------
--MarkingBarOpt.ProfilePg = CreateFrame( "Frame", "optionsProfiles", MarkingBarOpt.panel);
--MarkingBarOpt.ProfilePg.name = "Profiles";
--MarkingBarOpt.ProfilePg.parent = MarkingBarOpt.panel.name;
--MarkingBarOpt.ProfilePg.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
--InterfaceOptions_AddCategory(MarkingBarOpt.ProfilePg);

-------------------------------------------------------
-- OnEvent
-------------------------------------------------------
local MB_OnUpdate = CreateFrame("Frame")
MB_OnUpdate:RegisterEvent("ADDON_LOADED")
MB_OnUpdate:RegisterEvent("GROUP_ROSTER_UPDATE")
MB_OnUpdate:RegisterEvent("PLAYER_TARGET_CHANGED")
MB_OnUpdate:RegisterEvent("PLAYER_REGEN_DISABLED") --to hide flares and get no taint
MB_OnUpdate:RegisterEvent("PLAYER_REGEN_ENABLED")  --stupid taint
MB_OnUpdate:RegisterEvent("PLAYER_LOGOUT") -- save frame positions here
MB_OnUpdate:RegisterEvent("PLAYER_LOGIN")

MB_OnUpdate:SetScript("OnEvent", function(self, event, addon, ...)
	if (event == "ADDON_LOADED" and addon == "MarkingBarLives") then
		if (MBDB.shown) then
			MB_targetChecker("main")
		else
			MBL_RaidTargeting:Hide()
		end

		if (MBDB.locked) then
			MB_lock("main")
		else
			MB_unlock("main")
		end

		MBL_RaidTargeting:SetClampedToScreen(MBDB.clamped)

		if (MBDB.bgHide) then
			MB_bgHide("main")
		else
			MB_bgShow("main")
		end

		MBL_RaidTargeting:SetScale(MBDB.scale,main)
		MBL_RaidTargeting:SetAlpha(MBDB.alpha,main)

		if (MBCtrlDB.shown) then MB_targetChecker("ctrl") else MBL_RaidControls:Hide() end
		MBL_RaidControls:SetClampedToScreen(MBCtrlDB.clamped)
		if (MBCtrlDB.locked) then MB_lock("ctrl") else MB_unlock("ctrl") end
		if (MBCtrlDB.bgHide) then MB_bgHide("ctrl") else MB_bgShow("ctrl") end
		MBL_RaidControls:SetScale(MBCtrlDB.scale,ctrl)
		MBL_RaidControls:SetAlpha(MBCtrlDB.alpha,ctrl)

		MB_flipChecker()

		if (MBFlaresDB.shown) then MB_targetChecker("flare") else MBL_WorldMarkers:Hide() end --for shown and partyShow
		if (MBFlaresDB.locked) then MB_lock("flare") else MB_unlock("flare") end
		MBL_WorldMarkers:SetClampedToScreen(MBFlaresDB.clamped)
		MB_flareflipChecker() -- for flipped and vertical
		if (MBFlaresDB.bgHide) then MB_bgHide("flare") else MB_bgShow("flare") end
		MBL_WorldMarkers:SetScale(MBFlaresDB.scale,flare)
		MBL_WorldMarkers:SetAlpha(MBFlaresDB.alpha,flare)

		-- Can unregister once fired, since will never be hit again (unless a full reload which will start-over anyway)
		MB_OnUpdate:UnregisterEvent("ADDON_LOADED")

	elseif (event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_TARGET_CHANGED") then
		MB_targetChecker("main")
        MB_targetChecker("ctrl")
        if ( not InCombatLockdown() ) then
            MB_targetChecker("flare")
        end

    elseif event == "PLAYER_REGEN_ENABLED" then
        MB_targetChecker("flare")

	elseif event == "PLAYER_LOGOUT" then
		MB_savepositions()

	elseif event == "PLAYER_LOGIN" then
--		MB_setpositions()
	end
end
)
