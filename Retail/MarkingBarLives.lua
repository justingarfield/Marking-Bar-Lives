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

----------------
-- Main Options Page
----------------

MarkingBarOpt = {};
MarkingBarOpt.panel = CreateFrame( "Frame", "MarkingBarOpt", InterfaceOptionsFramePanelContainer );
MarkingBarOpt.panel.name = "Marking Bar Lives";
MarkingBarOpt.panel.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.panel.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.panel.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.panel);

local MBOptionsText = MarkingBarOpt.panel:CreateFontString("MBOptionsText", "OVERLAY", "ChatFontNormal")
MBOptionsText:SetPoint("TOP", MarkingBarOpt.panel, "TOP",0,-10)
MBOptionsText:SetText(MB.."|cffe1a500 Options")

local OptionsText = MarkingBarOpt.panel:CreateFontString("OptionsText", "OVERLAY", "ChatFontSmall")
OptionsText:SetPoint("TOPLEFT", MarkingBarOpt.panel, "TOPLEFT",25,-30)
OptionsText:SetText("Expand the MarkingBarLives (+) on the left to see the options.")

local versFooter = CreateFrame("Frame", "versFooter", MarkingBarOpt.panel, BackdropTemplateMixin and "BackdropTemplate")
versFooter:SetBackdrop(defaultBackdrop)
versFooter:SetBackdropColor(0.1,0.1,0.1,0.9)
versFooter:SetBackdropBorderColor(1,1,1,0.5)
versFooter:SetPoint("BOTTOM", MarkingBarOpt.panel, "BOTTOM",0,5)
versFooter:SetSize(175,23)

local versionText = versFooter:CreateFontString("versionText", "OVERLAY", "ChatFontSmall")
versionText:SetPoint("TOP", versFooter, "TOP",0,-5)
versionText:SetText(MB..curVer)

----------------
-- Marker Options Page
----------------
MarkingBarOpt.MarkerOptPg = CreateFrame( "Frame", "optionsMarker", MarkingBarOpt.panel);
MarkingBarOpt.MarkerOptPg.name = "Markers";
MarkingBarOpt.MarkerOptPg.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.MarkerOptPg.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.MarkerOptPg.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.MarkerOptPg.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.MarkerOptPg.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.MarkerOptPg);

local markerOptionsText = MarkingBarOpt.MarkerOptPg:CreateFontString("markerOptionsText", "OVERLAY", "ChatFontNormal")
markerOptionsText:SetPoint("TOP", MarkingBarOpt.MarkerOptPg, "TOP",0,-10)
markerOptionsText:SetText(MB.."|cffe1a500 Options")

local showCheck = CreateFrame("CheckButton", "showCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
showCheck:SetPoint("TOPLEFT", MarkingBarOpt.MarkerOptPg, "TOPLEFT",25,-30)
showCheck:SetSize(20,20)
showCheck:SetScript("OnClick", function(self) MBDB.shown = not MBDB.shown; MB_targetChecker("main") end)
local showText = MarkingBarOpt.MarkerOptPg:CreateFontString("showText", "OVERLAY", "ChatFontSmall")
showText:SetPoint("LEFT", showCheck, "RIGHT", 5,0)
showText:SetText("Always show "..MB.." with or without a target")

local partyRaidText = MarkingBarOpt.MarkerOptPg:CreateFontString("partyRaidText", "OVERLAY", "ChatFontSmall")
partyRaidText:SetPoint("TOPLEFT", showCheck,"BOTTOMLEFT",0,-5)
partyRaidText:SetText("Show "..MB.." when...")

local aloneCheck = CreateFrame("CheckButton", "aloneCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
aloneCheck:SetPoint("TOPLEFT", partyRaidText,"BOTTOMLEFT",0,-2)
aloneCheck:SetSize(20,20)
aloneCheck:SetScript("OnClick", function(self) MBDB.aloneShow = not MBDB.aloneShow; MB_targetChecker("main") end)
local aloneText = MarkingBarOpt.MarkerOptPg:CreateFontString("aloneText", "OVERLAY", "ChatFontSmall")
aloneText:SetPoint("LEFT", aloneCheck, "RIGHT", 5,0)
aloneText:SetText(" Alone")

local partyCheck = CreateFrame("CheckButton", "partyCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
partyCheck:SetPoint("LEFT", aloneText, "RIGHT",20,0)
partyCheck:SetSize(20,20)
partyCheck:SetScript("OnClick", function(self) MBDB.partyShow = not MBDB.partyShow; MB_targetChecker("main") end)
local partyText = MarkingBarOpt.MarkerOptPg:CreateFontString("partyText", "OVERLAY", "ChatFontSmall")
partyText:SetPoint("LEFT", partyCheck, "RIGHT", 5,0)
partyText:SetText(" in a Party ")

local raidCheck = CreateFrame("CheckButton", "raidCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
raidCheck:SetPoint("LEFT", partyText, "RIGHT",20,0)
raidCheck:SetSize(20,20)
raidCheck:SetScript("OnClick", function(self) MBDB.raidShow = not MBDB.raidShow; MB_targetChecker("main") end)
local raidText = MarkingBarOpt.MarkerOptPg:CreateFontString("raidText", "OVERLAY", "ChatFontSmall")
raidText:SetPoint("LEFT", raidCheck, "RIGHT", 5,0)
raidText:SetText(" in a Raid ")

local lockCheck = CreateFrame("CheckButton", "lockCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
lockCheck:SetPoint("TOP",aloneCheck,"BOTTOM",0,-5)
lockCheck:SetSize(20,20)
lockCheck:SetScript("OnClick", function(self) MB_lockToggle("main") MB_checkUpdater() end)
local lockText = MarkingBarOpt.MarkerOptPg:CreateFontString("lockText", "OVERLAY", "ChatFontSmall")
lockText:SetPoint("LEFT", lockCheck, "RIGHT", 5,0)
lockText:SetText("Lock "..MB.."'s position")

local clampCheck = CreateFrame("CheckButton", "clampCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
clampCheck:SetPoint("TOP",lockCheck,"BOTTOM",0,-5)
clampCheck:SetSize(20,20)
clampCheck:SetScript("OnClick", function(self) MBDB.clamped = not MBDB.clamped; MBL_RaidTargeting:SetClampedToScreen(MBDB.clamped) end)
local clampText = MarkingBarOpt.MarkerOptPg:CreateFontString("clampText", "OVERLAY", "ChatFontSmall")
clampText:SetPoint("LEFT", clampCheck, "RIGHT", 5,0)
clampText:SetText("Keep "..MB.." inside screen edges")

local flipCheck = CreateFrame("CheckButton", "flipCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
flipCheck:SetPoint("TOP",clampCheck,"BOTTOM",0,-5)
flipCheck:SetSize(20,20)
flipCheck:SetScript("OnClick", function(self) MBDB.flipped = not MBDB.flipped; MB_flipChecker() end)
local flipText = MarkingBarOpt.MarkerOptPg:CreateFontString("flipText", "OVERLAY", "ChatFontSmall")
flipText:SetPoint("LEFT", flipCheck, "RIGHT", 5,0)
flipText:SetText("Reverse "..MB.."'s icon order")

local vertCheck = CreateFrame("CheckButton", "vertCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
vertCheck:SetPoint("TOP",flipCheck,"BOTTOM",0,-5)
vertCheck:SetSize(20,20)
vertCheck:SetScript("OnClick", function(self) MBDB.vertical = not MBDB.vertical; MB_flipChecker() end)
local vertText = MarkingBarOpt.MarkerOptPg:CreateFontString("vertText", "OVERLAY", "ChatFontSmall")
vertText:SetPoint("LEFT", vertCheck, "RIGHT", 5,0)
vertText:SetText("Display "..MB.." vertically")

local bgCheck = CreateFrame("CheckButton", "bgCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
bgCheck:SetPoint("TOP",vertCheck,"BOTTOM",0,-5)
bgCheck:SetSize(20,20)
bgCheck:SetScript("OnClick", function(self) MB_bgToggle("main") end)
local bgText = MarkingBarOpt.MarkerOptPg:CreateFontString("bgText", "OVERLAY", "ChatFontSmall")
bgText:SetPoint("LEFT", bgCheck, "RIGHT", 5,0)
bgText:SetText("Hide "..MB.."'s background and border")

local toolCheck = CreateFrame("CheckButton", "toolCheck", MarkingBarOpt.MarkerOptPg, "UICheckButtonTemplate")
toolCheck:SetPoint("TOP",bgCheck,"BOTTOM",0,-5)
toolCheck:SetSize(20,20)
toolCheck:SetScript("OnClick", function(self) MBDB.tooltips = not MBDB.tooltips end)
local toolText = MarkingBarOpt.MarkerOptPg:CreateFontString("toolText", "OVERLAY", "ChatFontSmall")
toolText:SetPoint("LEFT", toolCheck, "RIGHT", 5,0)
toolText:SetText("Enable "..MB.."'s tooltips")

local alphaSlider = CreateFrame("Slider", "alphaSlider", MarkingBarOpt.MarkerOptPg, "OptionsSliderTemplate")
alphaSlider:SetPoint("TOPLEFT", toolCheck, "BOTTOMLEFT",25,-25)
alphaSlider:SetSize(180,16)
alphaSlider:SetMinMaxValues(0,1)
alphaSlider:SetValue(1)
alphaSlider:SetValueStep(0.01)
alphaSlider:SetOrientation("HORIZONTAL")
alphaSlider:SetScript("OnValueChanged", function(self) MB_alpha(self,"main") end)
alphaSlider:SetScript("OnLoad", function(self) MB_alpha(self,"main") end)

local scaleSlider = CreateFrame("Slider", "scaleSlider", MarkingBarOpt.MarkerOptPg, "OptionsSliderTemplate")
scaleSlider:SetPoint("TOPLEFT", alphaSlider, "BOTTOMLEFT",0,-25)
scaleSlider:SetSize(180,16)
scaleSlider:SetMinMaxValues(0.5,1.5)
scaleSlider:SetValue(1)
scaleSlider:SetValueStep(0.01)
scaleSlider:SetOrientation("HORIZONTAL")
scaleSlider:SetScript("OnValueChanged", function(self) MB_scale(self,"main") end)
scaleSlider:SetScript("OnLoad", function(self) MB_scale(self,"main") end)


----------------
-- Control Options Page
----------------
MarkingBarOpt.ControlOptPg = CreateFrame( "Frame", "optionsControl", MarkingBarOpt.panel);
MarkingBarOpt.ControlOptPg.name = "Controls";
MarkingBarOpt.ControlOptPg.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.ControlOptPg.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.ControlOptPg.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.ControlOptPg.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.ControlOptPg.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.ControlOptPg);

local ctrlOptionsText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlOptionsText", "OVERLAY", "ChatFontNormal")
ctrlOptionsText:SetPoint("TOP", MarkingBarOpt.ControlOptPg, "TOP",0,-10)
ctrlOptionsText:SetText(MB.."|cffe1a500 Control Options")

local ctrlShowCheck = CreateFrame("CheckButton", "ctrlShowCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlShowCheck:SetPoint("TOPLEFT", MarkingBarOpt.ControlOptPg, "TOPLEFT",25,-30)
ctrlShowCheck:SetSize(20,20)
ctrlShowCheck:SetScript("OnClick", function(self) MBCtrlDB.shown = not MBCtrlDB.shown; MB_targetChecker("ctrl") end)
MarkingBarOpt.ControlOptPg:CreateFontString("ctrlShowText", "OVERLAY", "ChatFontSmall")
ctrlShowText:SetPoint("LEFT", ctrlShowCheck, "RIGHT", 5,0)
ctrlShowText:SetText("Always show "..MB.." controls  with or without a target")

local ctrlPartyRaidText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlPartyRaidText", "OVERLAY", "ChatFontSmall")
ctrlPartyRaidText:SetPoint("TOPLEFT", ctrlShowCheck,"BOTTOMLEFT",0,-5)
ctrlPartyRaidText:SetText("Show "..MB.." controls  when...")

local ctrlAloneCheck = CreateFrame("CheckButton", "ctrlAloneCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlAloneCheck:SetPoint("TOPLEFT", ctrlPartyRaidText,"BOTTOMLEFT",0,-2)
ctrlAloneCheck:SetSize(20,20)
ctrlAloneCheck:SetScript("OnClick", function(self) MBCtrlDB.aloneShow = not MBCtrlDB.aloneShow; MB_targetChecker("ctrl") end)
local ctrlAloneText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlAloneText", "OVERLAY", "ChatFontSmall")
ctrlAloneText:SetPoint("LEFT", ctrlAloneCheck, "RIGHT", 5,0)
ctrlAloneText:SetText(" Alone")

local ctrlPartyCheck = CreateFrame("CheckButton", "ctrlPartyCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlPartyCheck:SetPoint("LEFT", ctrlAloneText, "RIGHT",20,0)
ctrlPartyCheck:SetSize(20,20)
ctrlPartyCheck:SetScript("OnClick", function(self) MBCtrlDB.partyShow = not MBCtrlDB.partyShow; MB_targetChecker("ctrl") end)
local ctrlPartyText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlPartyText", "OVERLAY", "ChatFontSmall")
ctrlPartyText:SetPoint("LEFT", ctrlPartyCheck, "RIGHT", 5,0)
ctrlPartyText:SetText(" in a Party ")

local ctrlRaidCheck = CreateFrame("CheckButton", "ctrlRaidCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlRaidCheck:SetPoint("LEFT", ctrlPartyText, "RIGHT",20,0)
ctrlRaidCheck:SetSize(20,20)
ctrlRaidCheck:SetScript("OnClick", function(self) MBCtrlDB.raidShow = not MBCtrlDB.raidShow; MB_targetChecker("ctrl") end)
local ctrlRaidText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlRaidText", "OVERLAY", "ChatFontSmall")
ctrlRaidText:SetPoint("LEFT", ctrlRaidCheck, "RIGHT", 5,0)
ctrlRaidText:SetText(" in a Raid ")

local ctrlCheck = CreateFrame("CheckButton", "ctrlCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlCheck:SetPoint("TOP",ctrlAloneCheck,"BOTTOM",0,-5)
ctrlCheck:SetSize(20,20)
ctrlCheck:SetScript("OnClick", function(self) MB_ctrlLockToggle(); MB_checkUpdater(); end)
local ctrlText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlText", "OVERLAY", "ChatFontSmall")
ctrlText:SetPoint("LEFT", ctrlCheck, "RIGHT", 5,0)
ctrlText:SetText("Connect "..MB.."'s controls to the raid icons.")

local ctrlLockCheck = CreateFrame("CheckButton", "ctrlLockCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlLockCheck:SetPoint("TOP",ctrlCheck, "BOTTOM",0,-5)
ctrlLockCheck:SetSize(20,20)
ctrlLockCheck:SetScript("OnClick", function(self) MB_lockToggle("ctrl"); MB_checkUpdater(); end)
ctrlLockCheck:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Note: Changing this options will disconnect controls from the raid icons.",0.88,0.65,0); GameTooltip:Show() end)
ctrlLockCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local ctrlLockText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlLockText", "OVERLAY", "ChatFontSmall")
ctrlLockText:SetPoint("LEFT", ctrlLockCheck, "RIGHT", 5,0)
ctrlLockText:SetText("Lock "..MB.." control's position.")

local ctrlClampCheck = CreateFrame("CheckButton", "ctrlClampCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlClampCheck:SetPoint("TOP",ctrlLockCheck,"BOTTOM",0,-5)
ctrlClampCheck:SetSize(20,20)
ctrlClampCheck:SetScript("OnClick", function(self) MBCtrlDB.clamped = not MBCtrlDB.clamped; MBL_RaidControls:SetClampedToScreen(MBCtrlDB.clamped) end)
local ctrlClampText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlClampText", "OVERLAY", "ChatFontSmall")
ctrlClampText:SetPoint("LEFT", ctrlClampCheck, "RIGHT", 5,0)
ctrlClampText:SetText("Keep "..MB.." controls  inside screen edges")

local ctrlVertCheck = CreateFrame("CheckButton", "ctrlVertCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlVertCheck:SetPoint("TOP",ctrlClampCheck,"BOTTOM",0,-5)
ctrlVertCheck:SetSize(20,20)
ctrlVertCheck:SetScript("OnClick", function(self) MBCtrlDB.vertical = not MBCtrlDB.vertical; if MBDB.ctrlLock then MB_ctrlUnlock() end; MB_flipChecker(); MB_checkUpdater() end)
ctrlVertCheck:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Note: Changing this options will disconnect controls from the raid icons.",0.88,0.65,0); GameTooltip:Show() end)
ctrlVertCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
local ctrlVertText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlvertText", "OVERLAY", "ChatFontSmall")
ctrlVertText:SetPoint("LEFT", ctrlVertCheck, "RIGHT", 5,0)
ctrlVertText:SetText("Display "..MB.." controls  vertically")

local ctrlBgCheck = CreateFrame("CheckButton", "ctrlBgCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlBgCheck:SetPoint("TOP",ctrlVertCheck,"BOTTOM",0,-5)
ctrlBgCheck:SetSize(20,20)
ctrlBgCheck:SetScript("OnClick", function(self) MB_bgToggle("ctrl") end)
local ctrlBgText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlBgText", "OVERLAY", "ChatFontSmall")
ctrlBgText:SetPoint("LEFT", ctrlBgCheck, "RIGHT", 5,0)
ctrlBgText:SetText("Hide "..MB.." controls 's background and borders")

local ctrlToolCheck = CreateFrame("CheckButton", "ctrlToolCheck", MarkingBarOpt.ControlOptPg, "UICheckButtonTemplate")
ctrlToolCheck:SetPoint("TOP",ctrlBgCheck,"BOTTOM",0,-5)
ctrlToolCheck:SetSize(20,20)
ctrlToolCheck:SetScript("OnClick", function(self) MBCtrlDB.tooltips = not MBCtrlDB.tooltips; end)
local ctrlToolText = MarkingBarOpt.ControlOptPg:CreateFontString("ctrlToolText", "OVERLAY", "ChatFontSmall")
ctrlToolText:SetPoint("LEFT", ctrlToolCheck, "RIGHT", 5,0)
ctrlToolText:SetText("Enable "..MB.." controls 's tooltips")

local ctrlAlphaSlider = CreateFrame("Slider", "ctrlAlphaSlider", MarkingBarOpt.ControlOptPg, "OptionsSliderTemplate")
ctrlAlphaSlider:SetPoint("TOPLEFT", ctrlToolCheck, "BOTTOMLEFT",25,-25)
ctrlAlphaSlider:SetSize(180,16)
ctrlAlphaSlider:SetMinMaxValues(0,1)
ctrlAlphaSlider:SetValue(1)
ctrlAlphaSlider:SetValueStep(0.01)
ctrlAlphaSlider:SetOrientation("HORIZONTAL")
ctrlAlphaSlider:SetScript("OnValueChanged", function(self) MB_alpha(self,"ctrl") end)
ctrlAlphaSlider:SetScript("OnLoad", function(self) MB_alpha(self,"ctrl") end)

local ctrlScaleSlider = CreateFrame("Slider", "ctrlScaleSlider", MarkingBarOpt.ControlOptPg, "OptionsSliderTemplate")
ctrlScaleSlider:SetPoint("TOPLEFT", ctrlAlphaSlider, "BOTTOMLEFT",0,-25)
ctrlScaleSlider:SetSize(180,16)
ctrlScaleSlider:SetMinMaxValues(0.5,1.5)
ctrlScaleSlider:SetValue(1)
ctrlScaleSlider:SetValueStep(0.01)
ctrlScaleSlider:SetOrientation("HORIZONTAL")
ctrlScaleSlider:SetScript("OnValueChanged", function(self) MB_scale(self,"ctrl") end)
ctrlScaleSlider:SetScript("OnLoad", function(self) MB_scale (self,"ctrl") end)


----------------
-- Flares Options Page
----------------
MarkingBarOpt.FlaresOptPg = CreateFrame( "Frame", "optionsFlares", MarkingBarOpt.panel);
MarkingBarOpt.FlaresOptPg.name = "Flares";
MarkingBarOpt.FlaresOptPg.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.FlaresOptPg.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.FlaresOptPg.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.FlaresOptPg.default = function(self) MB_reset(); MB_checkUpdater(); end
MarkingBarOpt.FlaresOptPg.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.FlaresOptPg);

local flareOptionsText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareOptionsText", "OVERLAY", "ChatFontNormal")
flareOptionsText:SetPoint("TOP", MarkingBarOpt.FlaresOptPg, "TOP",0,-10)
flareOptionsText:SetText(MBF.."|cffe1a500 Options")

local flareShowCheck = CreateFrame("CheckButton", "flareShowCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareShowCheck:SetPoint("TOPLEFT", MarkingBarOpt.FlaresOptPg, "TOPLEFT",25,-30)
flareShowCheck:SetSize(20,20)
flareShowCheck:SetScript("OnClick", function(self) MBFlaresDB.shown = not MBFlaresDB.shown; MB_targetChecker("flare") end)
MarkingBarOpt.FlaresOptPg:CreateFontString("flareShowText", "OVERLAY", "ChatFontSmall")
flareShowText:SetPoint("LEFT", flareShowCheck, "RIGHT", 5,0)
flareShowText:SetText("Always show "..MBF.." with or without a target")

local flarePartyRaidText = MarkingBarOpt.FlaresOptPg:CreateFontString("flarePartyRaidText", "OVERLAY", "ChatFontSmall")
flarePartyRaidText:SetPoint("TOPLEFT", flareShowCheck,"BOTTOMLEFT",0,-5)
flarePartyRaidText:SetText("Show "..MBF.." when...")

local flareAloneCheck = CreateFrame("CheckButton", "flareAloneCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareAloneCheck:SetPoint("TOPLEFT", flarePartyRaidText,"BOTTOMLEFT",0,-2)
flareAloneCheck:SetSize(20,20)
flareAloneCheck:SetScript("OnClick", function(self) MBFlaresDB.aloneShow = not MBFlaresDB.aloneShow; MB_targetChecker("flare") end)
local flareAloneText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareAloneText", "OVERLAY", "ChatFontSmall")
flareAloneText:SetPoint("LEFT", flareAloneCheck, "RIGHT", 5,0)
flareAloneText:SetText(" Alone")

local flarePartyCheck = CreateFrame("CheckButton", "flarePartyCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flarePartyCheck:SetPoint("LEFT", flareAloneText, "RIGHT",20,0)
flarePartyCheck:SetSize(20,20)
flarePartyCheck:SetScript("OnClick", function(self) MBFlaresDB.partyShow = not MBFlaresDB.partyShow; MB_targetChecker("flare") end)
local flarePartyText = MarkingBarOpt.FlaresOptPg:CreateFontString("flarePartyText", "OVERLAY", "ChatFontSmall")
flarePartyText:SetPoint("LEFT", flarePartyCheck, "RIGHT", 5,0)
flarePartyText:SetText(" in a Party ")

local flareRaidCheck = CreateFrame("CheckButton", "flareRaidCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareRaidCheck:SetPoint("LEFT", flarePartyText, "RIGHT",20,0)
flareRaidCheck:SetSize(20,20)
flareRaidCheck:SetScript("OnClick", function(self) MBFlaresDB.raidShow = not MBFlaresDB.raidShow; MB_targetChecker("flare") end)
local flareRaidText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareRaidText", "OVERLAY", "ChatFontSmall")
flareRaidText:SetPoint("LEFT", flareRaidCheck, "RIGHT", 5,0)
flareRaidText:SetText(" in a Raid ")

local flareLockCheck = CreateFrame("CheckButton", "flareLockCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareLockCheck:SetPoint("TOP",flareAloneCheck, "BOTTOM",0,-5)
flareLockCheck:SetSize(20,20)
flareLockCheck:SetScript("OnClick", function(self) MB_lockToggle("flare") end)
local flareLockText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareLockText", "OVERLAY", "ChatFontSmall")
flareLockText:SetPoint("LEFT", flareLockCheck, "RIGHT", 5,0)
flareLockText:SetText("Lock "..MBF.."'s position")

local flareClampCheck = CreateFrame("CheckButton", "flareClampCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareClampCheck:SetPoint("TOP",flareLockCheck,"BOTTOM",0,-5)
flareClampCheck:SetSize(20,20)
flareClampCheck:SetScript("OnClick", function(self) MBFlaresDB.clamped = not MBFlaresDB.clamped; MBL_WorldMarkers:SetClampedToScreen(MBFlaresDB.clamped) end)
local flareClampText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareClampText", "OVERLAY", "ChatFontSmall")
flareClampText:SetPoint("LEFT", flareClampCheck, "RIGHT", 5,0)
flareClampText:SetText("Keep "..MBF.." inside screen edges")

local flareFlipCheck = CreateFrame("CheckButton", "flareflipCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareFlipCheck:SetPoint("TOP",flareClampCheck,"BOTTOM",0,-5)
flareFlipCheck:SetSize(20,20)
flareFlipCheck:SetScript("OnClick", function(self) MBFlaresDB.flipped = not MBFlaresDB.flipped; MB_flareflipChecker() end)
local flareFlipText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareflipText", "OVERLAY", "ChatFontSmall")
flareFlipText:SetPoint("LEFT", flareflipCheck, "RIGHT", 5,0)
flareFlipText:SetText("Reverse "..MBF.."'s icon order")

local flareVertCheck = CreateFrame("CheckButton", "flarevertCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareVertCheck:SetPoint("TOP",flareflipCheck,"BOTTOM",0,-5)
flareVertCheck:SetSize(20,20)
flareVertCheck:SetScript("OnClick", function(self) MBFlaresDB.vertical = not MBFlaresDB.vertical; MB_flareflipChecker() end)
local flareVertText = MarkingBarOpt.FlaresOptPg:CreateFontString("flarevertText", "OVERLAY", "ChatFontSmall")
flareVertText:SetPoint("LEFT", flarevertCheck, "RIGHT", 5,0)
flareVertText:SetText("Display "..MBF.." vertically")

local flareBgCheck = CreateFrame("CheckButton", "flareBgCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareBgCheck:SetPoint("TOP",flarevertCheck,"BOTTOM",0,-5)
flareBgCheck:SetSize(20,20)
flareBgCheck:SetScript("OnClick", function(self) MB_bgToggle("flare") end)
local flareBgText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareBgText", "OVERLAY", "ChatFontSmall")
flareBgText:SetPoint("LEFT", flareBgCheck, "RIGHT", 5,0)
flareBgText:SetText("Hide "..MBF.."'s background and borders")

local flareToolCheck = CreateFrame("CheckButton", "flareToolCheck", MarkingBarOpt.FlaresOptPg, "UICheckButtonTemplate")
flareToolCheck:SetPoint("TOP",flareBgCheck,"BOTTOM",0,-5)
flareToolCheck:SetSize(20,20)
flareToolCheck:SetScript("OnClick", function(self) MBFlaresDB.tooltips = not MBFlaresDB.tooltips end)
local flareToolText = MarkingBarOpt.FlaresOptPg:CreateFontString("flareToolText", "OVERLAY", "ChatFontSmall")
flareToolText:SetPoint("LEFT", flareToolCheck, "RIGHT", 5,0)
flareToolText:SetText("Enable "..MBF.."'s tooltips")

local flareAlphaSlider = CreateFrame("Slider", "flareAlphaSlider", MarkingBarOpt.FlaresOptPg, "OptionsSliderTemplate")
flareAlphaSlider:SetPoint("TOPLEFT", flareToolCheck, "BOTTOMLEFT",25,-25)
flareAlphaSlider:SetSize(180,16)
flareAlphaSlider:SetMinMaxValues(0,1)
flareAlphaSlider:SetValue(1)
flareAlphaSlider:SetValueStep(0.01)
flareAlphaSlider:SetOrientation("HORIZONTAL")
flareAlphaSlider:SetScript("OnValueChanged", function(self) MB_alpha(self,"flare") end)
flareAlphaSlider:SetScript("OnLoad", function(self) MB_alpha(self,"flare") end)

local flareScaleSlider = CreateFrame("Slider", "flareScaleSlider", MarkingBarOpt.FlaresOptPg, "OptionsSliderTemplate")
flareScaleSlider:SetPoint("TOPLEFT", flareAlphaSlider, "BOTTOMLEFT",0,-25)
flareScaleSlider:SetSize(180,16)
flareScaleSlider:SetMinMaxValues(0.5,1.5)
flareScaleSlider:SetValue(1)
flareScaleSlider:SetValueStep(0.01)
flareScaleSlider:SetOrientation("HORIZONTAL")
flareScaleSlider:SetScript("OnValueChanged", function(self) MB_scale(self,"flare") end)
flareScaleSlider:SetScript("OnLoad", function(self) MB_scale(self,"flare") end)

----------------
-- Announce Options Page
----------------
MarkingBarOpt.AnnounceOptPg = CreateFrame( "Frame", "optionsAnnounce", MarkingBarOpt.panel);
MarkingBarOpt.AnnounceOptPg.name = "Marker Announcements";
MarkingBarOpt.AnnounceOptPg.parent = MarkingBarOpt.panel.name;
MarkingBarOpt.AnnounceOptPg.okay = function(self) MB_Announce_Save(); end
MarkingBarOpt.AnnounceOptPg.cancel = function(self) MB_Announce_Save(); end
MarkingBarOpt.AnnounceOptPg.default = function(self) MB_reset(); end
MarkingBarOpt.AnnounceOptPg.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
InterfaceOptions_AddCategory(MarkingBarOpt.AnnounceOptPg);

local AnnounceOptionsText = MarkingBarOpt.AnnounceOptPg:CreateFontString("AnnounceOptionsText", "OVERLAY", "ChatFontNormal")
AnnounceOptionsText:SetPoint("TOP", MarkingBarOpt.AnnounceOptPg, "TOP",0,-10)
AnnounceOptionsText:SetText("|cffe1a500Chat Announcement Options")

local AnnounceInstText1 = MarkingBarOpt.AnnounceOptPg:CreateFontString("AnnounceInstText", "OVERLAY", "ChatFontSmall")
AnnounceInstText1:SetPoint("TOPLEFT", MarkingBarOpt.AnnounceOptPg, "TOPLEFT", 10,-30)
AnnounceInstText1:SetText("Send")

local AnnounceInstText2 = MarkingBarOpt.AnnounceOptPg:CreateFontString("AnnounceInstText", "OVERLAY", "ChatFontSmall")
AnnounceInstText2:SetPoint("TOP", MarkingBarOpt.AnnounceOptPg, "TOP", 0, -30)
AnnounceInstText2:SetText("Enter the chat messages to send:")

local AnnounceIntroCheck = CreateFrame("CheckButton", "AnnounceIntroCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnounceIntroCheck:SetPoint("TOPLEFT", MarkingBarOpt.AnnounceOptPg, "TOPLEFT", 10,-50)
AnnounceIntroCheck:SetSize(20,20)
AnnounceIntroCheck:SetScript("OnClick", function(self) MBDB.announce_intro = not MBDB.announce_intro end)
local AnnounceIntroMsg = CreateFrame("EditBox", "AnnounceIntroMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnounceIntroMsg:SetPoint("LEFT", AnnounceIntroCheck, "RIGHT", 10,0)
AnnounceIntroMsg:SetSize(320,20)
AnnounceIntroMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
AnnounceIntroMsg:SetAutoFocus(false)

local AnnounceskullCheck = CreateFrame("CheckButton", "AnnounceskullCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnounceskullCheck:SetPoint("TOP", AnnounceIntroCheck, "BOTTOM",0,-15)
AnnounceskullCheck:SetSize(20,20)
AnnounceskullCheck:SetScript("OnClick", function(self) MBDB.announce_skull = not MBDB.announce_skull end)
local AnnounceskullMsg = CreateFrame("EditBox", "AnnounceskullMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnounceskullMsg:SetPoint("LEFT", AnnounceskullCheck, "RIGHT", 10,0)
AnnounceskullMsg:SetSize(320,20)
AnnounceskullMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnounceskullIcon = CreateFrame("Button", "AnnounceSkullIcon", MarkingBarOpt.AnnounceOptPg)
AnnounceskullIcon:SetSize(20,20)
AnnounceskullIcon:SetPoint("LEFT", AnnounceskullMsg, "Right",5,0)
AnnounceskullIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnounceskullIcon:GetNormalTexture():SetTexCoord(0.75,1,0.25,0.5)
AnnounceskullIcon:EnableMouse(false)
AnnounceskullMsg:SetAutoFocus(false)

local AnnouncecrossCheck = CreateFrame("CheckButton", "AnnouncecrossCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncecrossCheck:SetPoint("TOP", AnnounceskullCheck, "BOTTOM",0,-5)
AnnouncecrossCheck:SetSize(20,20)
AnnouncecrossCheck:SetScript("OnClick", function(self) MBDB.announce_cross = not MBDB.announce_cross end)
local AnnouncecrossMsg = CreateFrame("EditBox", "AnnouncecrossMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncecrossMsg:SetPoint("LEFT", AnnouncecrossCheck, "RIGHT", 10,0)
AnnouncecrossMsg:SetSize(320,20)
AnnouncecrossMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnouncecrossIcon = CreateFrame("Button", "AnnouncecrossIcon", MarkingBarOpt.AnnounceOptPg)
AnnouncecrossIcon:SetSize(20,20)
AnnouncecrossIcon:SetPoint("LEFT", AnnouncecrossMsg, "Right",5,0)
AnnouncecrossIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncecrossIcon:GetNormalTexture():SetTexCoord(0.5,0.75,0.25,0.5)
AnnouncecrossIcon:EnableMouse(false)
AnnouncecrossMsg:SetAutoFocus(false)

local AnnouncesquareCheck = CreateFrame("CheckButton", "AnnouncesquareCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncesquareCheck:SetPoint("TOP", AnnouncecrossCheck, "BOTTOM",0,-5)
AnnouncesquareCheck:SetSize(20,20)
AnnouncesquareCheck:SetScript("OnClick", function(self) MBDB.announce_square = not MBDB.announce_square end)
local AnnouncesquareMsg = CreateFrame("EditBox", "AnnouncesquareMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncesquareMsg:SetPoint("LEFT", AnnouncesquareCheck, "RIGHT", 10,0)
AnnouncesquareMsg:SetSize(320,20)
AnnouncesquareMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnouncesquareIcon = CreateFrame("Button", "AnnouncesquareIcon", MarkingBarOpt.AnnounceOptPg)
AnnouncesquareIcon:SetSize(20,20)
AnnouncesquareIcon:SetPoint("LEFT", AnnouncesquareMsg, "Right",5,0)
AnnouncesquareIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncesquareIcon:GetNormalTexture():SetTexCoord(0.25,0.5,0.25,0.5)
AnnouncesquareIcon:EnableMouse(false)
AnnouncesquareMsg:SetAutoFocus(false)

local AnnouncemoonCheck = CreateFrame("CheckButton", "AnnouncemoonCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncemoonCheck:SetPoint("TOP", AnnouncesquareCheck, "BOTTOM",0,-5)
AnnouncemoonCheck:SetSize(20,20)
AnnouncemoonCheck:SetScript("OnClick", function(self) MBDB.announce_moon = not MBDB.announce_moon end)
local AnnouncemoonMsg = CreateFrame("EditBox", "AnnouncemoonMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncemoonMsg:SetPoint("LEFT", AnnouncemoonCheck, "RIGHT", 10,0)
AnnouncemoonMsg:SetSize(320,20)
AnnouncemoonMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnouncemoonIcon = CreateFrame("Button", "AnnouncemoonIcon", MarkingBarOpt.AnnounceOptPg)
AnnouncemoonIcon:SetSize(20,20)
AnnouncemoonIcon:SetPoint("LEFT", AnnouncemoonMsg, "Right",5,0)
AnnouncemoonIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncemoonIcon:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.5)
AnnouncemoonIcon:EnableMouse(false)
AnnouncemoonMsg:SetAutoFocus(false)

local AnnouncetriangleCheck = CreateFrame("CheckButton", "AnnouncetriangleCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncetriangleCheck:SetPoint("TOP", AnnouncemoonCheck, "BOTTOM",0,-5)
AnnouncetriangleCheck:SetSize(20,20)
AnnouncetriangleCheck:SetScript("OnClick", function(self) MBDB.announce_triangle = not MBDB.announce_triangle end)
local AnnouncetriangleMsg = CreateFrame("EditBox", "AnnouncetriangleMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncetriangleMsg:SetPoint("LEFT", AnnouncetriangleCheck, "RIGHT", 10,0)
AnnouncetriangleMsg:SetSize(320,20)
AnnouncetriangleMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnouncetriangleIcon = CreateFrame("Button", "AnnouncetriangleIcon", MarkingBarOpt.AnnounceOptPg)
AnnouncetriangleIcon:SetSize(20,20)
AnnouncetriangleIcon:SetPoint("LEFT", AnnouncetriangleMsg, "Right",5,0)
AnnouncetriangleIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncetriangleIcon:GetNormalTexture():SetTexCoord(0.75,1,0,0.25)
AnnouncetriangleIcon:EnableMouse(false)
AnnouncetriangleMsg:SetAutoFocus(false)

local AnnouncediamondCheck = CreateFrame("CheckButton", "AnnouncediamondCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncediamondCheck:SetPoint("TOP", AnnouncetriangleCheck, "BOTTOM",0,-5)
AnnouncediamondCheck:SetSize(20,20)
AnnouncediamondCheck:SetScript("OnClick", function(self) MBDB.announce_diamond = not MBDB.announce_diamond end)
local AnnouncediamondMsg = CreateFrame("EditBox", "AnnouncediamondMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncediamondMsg:SetPoint("LEFT", AnnouncediamondCheck, "RIGHT", 10,0)
AnnouncediamondMsg:SetSize(320,20)
AnnouncediamondMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnouncediamondIcon = CreateFrame("Button", "AnnouncediamondIcon", MarkingBarOpt.AnnounceOptPg)
AnnouncediamondIcon:SetSize(20,20)
AnnouncediamondIcon:SetPoint("LEFT", AnnouncediamondMsg, "Right",5,0)
AnnouncediamondIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncediamondIcon:GetNormalTexture():SetTexCoord(0.5,0.75,0,0.25)
AnnouncediamondIcon:EnableMouse(false)
AnnouncediamondMsg:SetAutoFocus(false)

local AnnouncecircleCheck = CreateFrame("CheckButton", "AnnouncecircleCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncecircleCheck:SetPoint("TOP", AnnouncediamondCheck, "BOTTOM",0,-5)
AnnouncecircleCheck:SetSize(20,20)
AnnouncecircleCheck:SetScript("OnClick", function(self) MBDB.announce_circle = not MBDB.announce_circle end)
local AnnouncecircleMsg = CreateFrame("EditBox", "AnnouncecircleMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncecircleMsg:SetPoint("LEFT", AnnouncecircleCheck, "RIGHT", 10,0)
AnnouncecircleMsg:SetSize(320,20)
AnnouncecircleMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnouncecircleIcon = CreateFrame("Button", "AnnouncecircleIcon", MarkingBarOpt.AnnounceOptPg)
AnnouncecircleIcon:SetSize(20,20)
AnnouncecircleIcon:SetPoint("LEFT", AnnouncecircleMsg, "Right",5,0)
AnnouncecircleIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncecircleIcon:GetNormalTexture():SetTexCoord(0.25,0.5,0,0.25)
AnnouncecircleIcon:EnableMouse(false)
AnnouncecircleMsg:SetAutoFocus(false)

local AnnouncestarCheck = CreateFrame("CheckButton", "AnnouncestarCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncestarCheck:SetPoint("TOP", AnnouncecircleCheck, "BOTTOM",0,-5)
AnnouncestarCheck:SetSize(20,20)
AnnouncestarCheck:SetScript("OnClick", function(self) MBDB.announce_star = not MBDB.announce_star end)
local AnnouncestarMsg = CreateFrame("EditBox", "AnnouncestarMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncestarMsg:SetPoint("LEFT", AnnouncestarCheck, "RIGHT", 10,0)
AnnouncestarMsg:SetSize(320,20)
AnnouncestarMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
local AnnouncestarIcon = CreateFrame("Button", "AnnouncestarIcon", MarkingBarOpt.AnnounceOptPg)
AnnouncestarIcon:SetSize(20,20)
AnnouncestarIcon:SetPoint("LEFT", AnnouncestarMsg, "Right",5,0)
AnnouncestarIcon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
AnnouncestarIcon:GetNormalTexture():SetTexCoord(0,0.25,0,0.25)
AnnouncestarIcon:EnableMouse(false)
AnnouncestarMsg:SetAutoFocus(false)

local AnnouncefooterCheck = CreateFrame("CheckButton", "AnnouncefooterCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncefooterCheck:SetPoint("TOP", AnnouncestarCheck, "BOTTOM",0,-5)
AnnouncefooterCheck:SetSize(20,20)
AnnouncefooterCheck:SetScript("OnClick", function(self) MBDB.announce_footer = not MBDB.announce_footer end)
local AnnouncefooterMsg = CreateFrame("EditBox", "AnnouncefooterMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncefooterMsg:SetPoint("LEFT", AnnouncefooterCheck, "RIGHT", 10,0)
AnnouncefooterMsg:SetSize(320,20)
AnnouncefooterMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
AnnouncefooterMsg:SetAutoFocus(false)

local AnnouncerwText = MarkingBarOpt.AnnounceOptPg:CreateFontString("AnnouncerwText", "OVERLAY", "ChatFontSmall")
AnnouncerwText:SetPoint("TOPLEFT", AnnouncefooterCheck, "BOTTOMLEFT",0,-15)
AnnouncerwText:SetText("Enter the chat message to send as a Raid Warning: (Only in a Raid)")

local AnnouncerwCheck = CreateFrame("CheckButton", "AnnouncerwCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncerwCheck:SetPoint("TOPLEFT", AnnouncerwText, "BOTTOMLEFT",0,-5)
AnnouncerwCheck:SetSize(20,20)
AnnouncerwCheck:SetScript("OnClick", function(self) MBFlaresDB.announce_rw = not MBFlaresDB.announce_rw end)
local AnnouncerwMsg = CreateFrame("EditBox", "AnnouncerwMsg", MarkingBarOpt.AnnounceOptPg, "InputBoxTemplate")
AnnouncerwMsg:SetPoint("LEFT", AnnouncerwCheck, "RIGHT", 10,0)
AnnouncerwMsg:SetSize(320,20)
AnnouncerwMsg:SetFont("Fonts\\ARIALN.TTF", 12, "")
AnnouncerwMsg:SetAutoFocus(false)

local AnnouncetooltipCheck = CreateFrame("CheckButton", "AnnouncetooltipCheck", MarkingBarOpt.AnnounceOptPg, "UICheckButtonTemplate")
AnnouncetooltipCheck:SetPoint("TOP", AnnouncerwCheck, "BOTTOM",0,-15)
AnnouncetooltipCheck:SetSize(20,20)
AnnouncetooltipCheck:SetScript("OnClick", function(self) MBDB.announce_tooltip = not MBDB.announce_tooltip end)
local AnnouncetooltipText = MarkingBarOpt.AnnounceOptPg:CreateFontString("AnnouncetooltipText", "OVERLAY", "ChatFontSmall")
AnnouncetooltipText:SetPoint("LEFT", AnnouncetooltipCheck, "RIGHT",10,0)
AnnouncetooltipText:SetText("Add announce text to raid icon tooltips.")

local AnnounceResetMsgButton = CreateFrame("Button", "AnnounceResetMsgButton", MarkingBarOpt.AnnounceOptPg, "UIPanelButtonTemplate") --Was OptionsButtonTemplate until patch 10.0.0
AnnounceResetMsgButton:SetPoint("BOTTOMRIGHT", MarkingBarOpt.AnnounceOptPg, "BOTTOMRIGHT",-5,5)
AnnounceResetMsgButton:SetScript("OnClick", function(self) MB_reset_msg(); MB_checkUpdater(); end)
AnnounceResetMsgButton:SetSize(200,20)
AnnounceResetMsgButton:SetText("Reset to Default Messages")

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
