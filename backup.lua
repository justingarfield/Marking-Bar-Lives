
        <Button name="iconButton" virtual="true" enableMouse="true">
        <Size x="20" y="20"/>
        <Scripts>
            <OnClick>
                SetRaidTargetIcon("target", 8)
            </OnClick>
            <OnEnter>
                if (MBDB.tooltips==true) then
                    GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
                    GameTooltip:ClearLines();
                    if MBDB.announce_tooltip then
                        GameTooltip:AddLine(MBDB.msg_skull, 1,1,1,true);
                    end
                    GameTooltip:AddLine("Skull", 0.88,0.65,0);
                    GameTooltip:Show()
                end
            </OnEnter>
            <OnLeave>
                GameTooltip:Hide()
            </OnLeave>
        </Scripts>
    </Button>



-------------------------------------------------------
-- MB Main Frame and Movers
-------------------------------------------------------

--MBL_RaidTargeting = CreateFrame("Frame", "MBL_RaidTargeting", UIParent, BackdropTemplateMixin and "BackdropTemplate")
--MBL_RaidTargeting:SetBackdrop(borderlessBackdrop)
--MBL_RaidTargeting:SetBackdropColor(0,0,0,0)
--MBL_RaidTargeting:EnableMouse(true)
--MBL_RaidTargeting:SetMovable(true)
--MBL_RaidTargeting:SetUserPlaced(true)
--MBL_RaidTargeting:SetUserPlaced(false)
--MBL_RaidTargeting:SetSize(190,35)
--MBL_RaidTargeting:SetPoint("TOP", UIParent, "TOP")
--MBL_RaidTargeting:SetClampedToScreen(false)

--local MBL_RaidTargeting_Mover = CreateFrame("Frame", "MBL_RaidTargeting_Mover", MBL_RaidTargeting, BackdropTemplateMixin and "BackdropTemplate")
--MBL_RaidTargeting_Mover:SetBackdrop(defaultBackdrop)
--MBL_RaidTargeting_Mover:SetBackdropColor(0.1,0.1,0.1,0.7)
--MBL_RaidTargeting_Mover:EnableMouse(true)
--MBL_RaidTargeting_Mover:SetMovable(true)
--MBL_RaidTargeting_Mover:SetSize(20,35)
--MBL_RaidTargeting_Mover:SetPoint("RIGHT", MBL_RaidTargeting, "LEFT")
--MBL_RaidTargeting_Mover:SetScript("OnMouseDown", function(self,button) if (button=="LeftButton") then MBL_RaidTargeting:StartMoving() end end)
--MBL_RaidTargeting_Mover:SetScript("OnMouseUp", function(self) MBL_RaidTargeting:StopMovingOrSizing() end)


-------------------------------------------------------
-- MB Icon Frame and Icons
-------------------------------------------------------

--local iconFrame = CreateFrame("Frame", "MBL_RaidTargeting_Icons", MBL_RaidTargeting, BackdropTemplateMixin and "BackdropTemplate")
--iconFrame:SetBackdrop(defaultBackdrop)
--iconFrame:SetBackdropColor(0.1,0.1,0.1,0.7)
--iconFrame:EnableMouse(true)
--iconFrame:SetMovable(true)
--iconFrame:SetSize(190,35)
--iconFrame:SetPoint("LEFT", MBL_RaidTargeting, "LEFT")

--local iconSkull = CreateFrame("Button", "iconSkull", iconFrame)
--iconSkull:SetSize(20,20)
--iconSkull:SetPoint("LEFT", iconFrame, "LEFT",5,0)
--iconSkull:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconSkull:GetNormalTexture():SetTexCoord(0.75,1,0.25,0.5)
--iconSkull:EnableMouse(true)
--iconSkull:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 8) end)
--iconSkull:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_skull, 1,1,1,true); end GameTooltip:AddLine("Skull", 0.88,0.65,0); GameTooltip:Show() end end)
--iconSkull:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local iconCross = CreateFrame("Button", "iconCross", iconFrame)
--iconCross:SetSize(20,20)
--iconCross:SetPoint("LEFT", iconSkull, "RIGHT")
--iconCross:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconCross:GetNormalTexture():SetTexCoord(0.5,0.75,0.25,0.5)
--iconCross:EnableMouse(true)
--iconCross:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 7) end)
--iconCross:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_cross, 1,1,1,true); end GameTooltip:AddLine("Cross", 0.88,0.65,0); GameTooltip:Show() end end)
--iconCross:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local iconSquare = CreateFrame("Button", "iconSquare", iconFrame)
--iconSquare:SetSize(20,20)
--iconSquare:SetPoint("LEFT", iconCross, "RIGHT")
--iconSquare:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconSquare:GetNormalTexture():SetTexCoord(0.25,0.5,0.25,0.5)
--iconSquare:EnableMouse(true)
--iconSquare:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 6) end)
--iconSquare:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_square, 1,1,1,true); end GameTooltip:AddLine("Square", 0.88,0.65,0); GameTooltip:Show() end end)
--iconSquare:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local iconMoon = CreateFrame("Button", "iconMoon", iconFrame)
--iconMoon:SetSize(20,20)
--iconMoon:SetPoint("LEFT", iconSquare, "RIGHT")
--iconMoon:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconMoon:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.5)
--iconMoon:EnableMouse(true)
--iconMoon:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 5) end)
--iconMoon:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_moon, 1,1,1,true); end GameTooltip:AddLine("Moon", 0.88,0.65,0); GameTooltip:Show() end end)
--iconMoon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local iconTriangle = CreateFrame("Button", "iconTriangle", iconFrame)
--iconTriangle:SetSize(20,20)
--iconTriangle:SetPoint("LEFT", iconMoon, "RIGHT")
--iconTriangle:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconTriangle:GetNormalTexture():SetTexCoord(0.75,1,0,0.25)
--iconTriangle:EnableMouse(true)
--iconTriangle:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 4) end)
--iconTriangle:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_triangle, 1,1,1,true); end GameTooltip:AddLine("Triangle", 0.88,0.65,0); GameTooltip:Show() end end)
--iconTriangle:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local iconDiamond = CreateFrame("Button", "iconDiamond", iconFrame)
--iconDiamond:SetSize(20,20)
--iconDiamond:SetPoint("LEFT", iconTriangle, "RIGHT")
--iconDiamond:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconDiamond:GetNormalTexture():SetTexCoord(0.5,0.75,0,0.25)
--iconDiamond:EnableMouse(true)
--iconDiamond:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 3) end)
--iconDiamond:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_diamond, 1,1,1,true); end GameTooltip:AddLine("Diamond", 0.88,0.65,0); GameTooltip:Show() end end)
--iconDiamond:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local iconCircle = CreateFrame("Button", "iconCircle", iconFrame)
--iconCircle:SetSize(20,20)
--iconCircle:SetPoint("LEFT", iconDiamond, "RIGHT")
--iconCircle:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconCircle:GetNormalTexture():SetTexCoord(0.25,0.5,0,0.25)
--iconCircle:EnableMouse(true)
--iconCircle:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 2) end)
--iconCircle:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_circle, 1,1,1,true); end GameTooltip:AddLine("Circle", 0.88,0.65,0); GameTooltip:Show() end end)
--iconCircle:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local iconStar = CreateFrame("Button", "iconStar", iconFrame)
--iconStar:SetSize(20,20)
--iconStar:SetPoint("LEFT", iconCircle, "RIGHT")
--iconStar:SetNormalTexture("interface\\targetingframe\\ui-raidtargetingicons")
--iconStar:GetNormalTexture():SetTexCoord(0,0.25,0,0.25)
--iconStar:EnableMouse(true)
--iconStar:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 1) end)
--iconStar:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); if MBDB.announce_tooltip then GameTooltip:AddLine(MBDB.msg_star, 1,1,1,true); end GameTooltip:AddLine("Star", 0.88,0.65,0); GameTooltip:Show() end end)
--iconStar:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local lockIcon = CreateFrame("Button", "lockIcon", iconFrame)
--lockIcon:SetSize(20,20)
--lockIcon:SetPoint("LEFT", iconStar , "RIGHT")
--lockIcon:SetNormalTexture("Interface\\AddOns\\MarkingBarLives\\resources\\Glues-Addon-Icons")
--lockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
--lockIcon:EnableMouse(true)
--lockIcon:SetScript("OnClick", function(self) MB_lockToggle("main") end)
--lockIcon:SetScript("OnEnter", function(self) if (MBDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Lock/Unlock Icons",0.88,0.65,0); GameTooltip:Show() end end)
--lockIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)


-------------------------------------------------------
-- MB Control Frame
-------------------------------------------------------

--local MBL_RaidControls = CreateFrame("Frame", "MBL_RaidControls", UIParent, BackdropTemplateMixin and "BackdropTemplate")
--MBL_RaidControls:SetBackdrop(defaultBackdrop)
--MBL_RaidControls:SetBackdropColor(0.1,0.1,0.1,0.7)
--MBL_RaidControls:EnableMouse(true)
--MBL_RaidControls:SetMovable(true)
--MBL_RaidControls:SetSize(120,35)
--if MBDB.ctrlLock then
--    MBL_RaidControls:SetSize(100,35)
--end
--MBL_RaidControls:SetPoint("LEFT", MBL_RaidTargeting_Icons, "RIGHT",5,0)

--local announceIcon  = CreateFrame("Button", "announceIcon ", MBL_RaidControls)
--announceIcon :SetSize(20,20)
--announceIcon :SetPoint("LEFT", MBL_RaidControls, "LEFT",10,0)
--announceIcon :SetNormalTexture("Interface\\AddOns\\MarkingBarLives\\resources\\announce")
--announceIcon :GetNormalTexture():SetTexCoord(0,1,0,1)
--announceIcon :EnableMouse(true)
--announceIcon :SetScript("OnClick", function(self) MB_Announce() end)
--announceIcon :SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Announce to Chat", 0.88,0.65,0); GameTooltip:Show() end end)
--announceIcon :SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local readyCheck = CreateFrame("Button", "readyCheck", MBL_RaidControls)
--readyCheck:SetSize(20,20)
--readyCheck:SetPoint("LEFT", announceIcon , "RIGHT")
--readyCheck:SetNormalTexture("interface\\raidframe\\readycheck-ready")
--readyCheck:GetNormalTexture():SetTexCoord(0,1,0,1)
--readyCheck:EnableMouse(true)
--readyCheck:SetScript("OnClick", function(self) DoReadyCheck() end)
--readyCheck:SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Ready Check",0.88,0.65,0); GameTooltip:Show() end end)
--readyCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local roleCheck = CreateFrame("Button", "roleCheck", MBL_RaidControls)
--roleCheck:SetSize(20,20)
--roleCheck:SetPoint("LEFT", readyCheck , "RIGHT")
--roleCheck:SetNormalTexture("interface\\raidframe\\readycheck-waiting")
--roleCheck:GetNormalTexture():SetTexCoord(0,1,0,1)
--roleCheck:EnableMouse(true)
--roleCheck:SetScript("OnClick", function(self) InitiateRolePoll() end)
--roleCheck:SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Role Poll",0.88,0.65,0); GameTooltip:Show() end end)
--roleCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local optIcon = CreateFrame("Button", "optIcon", MBL_RaidControls)
--optIcon:SetSize(20,20)
--optIcon:SetPoint("LEFT", roleCheck , "RIGHT")
--optIcon:SetNormalTexture("interface\\AddOns\\MarkingBarLives\\resources\\Gear_64")
--optIcon:GetNormalTexture():SetTexCoord(0,.5,0,.5)
--optIcon:EnableMouse(true)
--optIcon:RegisterForClicks("AnyDown")
--optIcon:SetScript("OnClick", function(self,button) if ( button == "RightButton" ) then InterfaceOptionsFrame_OpenToCategory(MarkingBarOpt.AnnounceOptPg) else InterfaceOptionsFrame_OpenToCategory(MarkingBarOpt.MarkerOptPg) end end )
--optIcon:SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Options",0.88,0.65,0); GameTooltip:Show() end end)
--optIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local ctrlLockIcon = CreateFrame("Button", "ctrlLockIcon", MBL_RaidControls)
--ctrlLockIcon:SetSize(20,20)
--ctrlLockIcon:SetNormalTexture("Interface\\AddOns\\MarkingBarLives\\resources\\Glues-Addon-Icons")
--ctrlLockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
--ctrlLockIcon:SetScript("OnClick", function(self) MB_lockToggle("ctrl") end)
--ctrlLockIcon:SetScript("OnEnter", function(self) if (MBCtrlDB.tooltips==true) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Lock/Unlock Controls",0.88,0.65,0); GameTooltip:Show() end end)
--ctrlLockIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
--ctrlLockIcon:SetPoint("LEFT", optIcon , "RIGHT")
--ctrlLockIcon:SetAlpha(1)
--ctrlLockIcon:EnableMouse(true)

--local moverRight = CreateFrame("Frame", "moverRight", MBL_RaidControls, BackdropTemplateMixin and "BackdropTemplate")
--moverRight:SetBackdrop(defaultBackdrop)
--moverRight:SetBackdropColor(0.1,0.1,0.1,0.7)
--moverRight:SetSize(20,35)
--moverRight:SetMovable(true)
--moverRight:SetScript("OnMouseDown", function(self,button) if (button=="LeftButton") then MBL_RaidControls:StartMoving() end end)
--moverRight:SetScript("OnMouseUp", function(self) MBL_RaidControls:StopMovingOrSizing() end)
--moverRight:SetPoint("LEFT", MBL_RaidControls , "RIGHT")
--moverRight:SetAlpha(1)
--moverRight:EnableMouse(true)


-------------------------------------------------------
-- MBFlares Main Frame and Movers
-------------------------------------------------------

--MBL_WorldMarkers = CreateFrame("Frame", "MBL_WorldMarkers", UIParent, BackdropTemplateMixin and "BackdropTemplate")
--MBL_WorldMarkers:SetBackdrop(borderlessBackdrop)
--MBL_WorldMarkers:SetBackdropColor(0,0,0,0)
--MBL_WorldMarkers:EnableMouse(true)
--MBL_WorldMarkers:SetMovable(true)
--MBL_WorldMarkers:SetUserPlaced(true)
--MBL_WorldMarkers:SetUserPlaced(false)
--MBL_WorldMarkers:SetSize(180,35)
--MBL_WorldMarkers:SetPoint("TOP", UIParent, "TOP",0,-40)
--MBL_WorldMarkers:SetClampedToScreen(false)

--local MBFlares_MBL_RaidTargeting_Mover = CreateFrame("Frame", "MBFlares_MBL_RaidTargeting_Mover", MBL_WorldMarkers, BackdropTemplateMixin and "BackdropTemplate")
--MBFlares_MBL_RaidTargeting_Mover:SetBackdrop(defaultBackdrop)
--MBFlares_MBL_RaidTargeting_Mover:SetBackdropColor(0.1,0.1,0.1,0.7)
--MBFlares_MBL_RaidTargeting_Mover:EnableMouse(true)
--MBFlares_MBL_RaidTargeting_Mover:SetMovable(true)
--MBFlares_MBL_RaidTargeting_Mover:SetSize(20,35)
--MBFlares_MBL_RaidTargeting_Mover:SetPoint("RIGHT", MBL_WorldMarkers, "LEFT")
--MBFlares_MBL_RaidTargeting_Mover:SetScript("OnMouseDown", function(self,button) if (button=="LeftButton") then MBL_WorldMarkers:StartMoving() end end)
--MBFlares_MBL_RaidTargeting_Mover:SetScript("OnMouseUp", function(self) MBL_WorldMarkers:StopMovingOrSizing() end)


-------------------------------------------------------
-- The Flare Frame and Flares
-------------------------------------------------------

--local flareFrame = CreateFrame("Frame", "MB_flareFrame", MBL_WorldMarkers, BackdropTemplateMixin and "BackdropTemplate")
--flareFrame:SetBackdrop(defaultBackdrop)
--flareFrame:SetBackdropColor(0.1,0.1,0.1,0.1,0.7)
--flareFrame:EnableMouse(true)
--flareFrame:SetMovable(true)
--flareFrame:SetSize(255,35)
--flareFrame:SetPoint("LEFT", MBL_WorldMarkers, "LEFT")

--local flareWhite = CreateFrame("Button", "flareWhite", flareFrame, "SecureActionButtonTemplate")
--flareWhite:SetSize(25,25)
--flareWhite:SetNormalTexture("interface\\minimap\\partyraidblips")
--flareWhite:GetNormalTexture():SetTexCoord(0.5,0.625,0,0.25)
--flareWhite:SetPoint("TOPLEFT", flareFrame, "TOPLEFT",5,-5)
--flareWhite:SetAttribute("type", "macro")
--flareWhite:SetAttribute("macrotext1", "/wm 8")
--flareWhite:RegisterForClicks("AnyDown")
--flareWhite:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Skull world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flareWhite:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flareRed = CreateFrame("Button", "flareRed", MB_flareFrame, "SecureActionButtonTemplate")
--flareRed:SetSize(25,25)
--flareRed:SetNormalTexture("interface\\minimap\\partyraidblips")
--flareRed:GetNormalTexture():SetTexCoord(0.625,0.75,0,0.25)
--flareRed:SetPoint("LEFT", flareWhite, "RIGHT")
--flareRed:SetAttribute("type", "macro")
--flareRed:SetAttribute("macrotext1", "/wm 4")
--flareRed:RegisterForClicks("AnyDown")
--flareRed:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Cross world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flareRed:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flareBlue = CreateFrame("Button", "flareBlue", MB_flareFrame, "SecureActionButtonTemplate")
--flareBlue:SetSize(25,25)
--flareBlue:SetNormalTexture("interface\\minimap\\partyraidblips")
--flareBlue:GetNormalTexture():SetTexCoord(0.75,0.875,0,0.25)
--flareBlue:SetPoint("LEFT", flareRed, "RIGHT")
--flareBlue:SetAttribute("type", "macro")
--flareBlue:SetAttribute("macrotext1", "/wm 1")
--flareBlue:RegisterForClicks("AnyDown")
--flareBlue:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Square world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flareBlue:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flareSilver = CreateFrame("Button", "flareSilver", MB_flareFrame, "SecureActionButtonTemplate")
--flareSilver:SetSize(25,25)
--flareSilver:SetNormalTexture("interface\\minimap\\partyraidblips")
--flareSilver:GetNormalTexture():SetTexCoord(0.875,1,0,0.25)
--flareSilver:SetPoint("LEFT", flareBlue, "RIGHT")
--flareSilver:SetAttribute("type", "macro")
--flareSilver:SetAttribute("macrotext1", "/wm 7")
--flareSilver:RegisterForClicks("AnyDown")
--flareSilver:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Moon world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flareSilver:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flareGreen = CreateFrame("Button", "flareGreen", MB_flareFrame, "SecureActionButtonTemplate")
--flareGreen:SetSize(25,25)
--flareGreen:SetNormalTexture("interface\\minimap\\partyraidblips")
--flareGreen:GetNormalTexture():SetTexCoord(0.25,0.375,0,0.25)
--flareGreen:SetPoint("LEFT", flareSilver, "RIGHT")
--flareGreen:SetAttribute("type", "macro")
--flareGreen:SetAttribute("macrotext1", "/wm 2")
--flareGreen:RegisterForClicks("AnyDown")
--flareGreen:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Triangle world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flareGreen:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flarePurple = CreateFrame("Button", "flarePurple", MB_flareFrame, "SecureActionButtonTemplate")
--flarePurple:SetSize(25,25)
--flarePurple:SetNormalTexture("interface\\minimap\\partyraidblips")
--flarePurple:GetNormalTexture():SetTexCoord(0,0.125,0.25,0.5)
--flarePurple:SetPoint("LEFT", flareGreen, "RIGHT")
--flarePurple:SetAttribute("type", "macro")
--flarePurple:SetAttribute("macrotext1", "/wm 3")
--flarePurple:RegisterForClicks("AnyDown")
--flarePurple:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Diamond world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flarePurple:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flareOrange = CreateFrame("Button", "flareOrange", MB_flareFrame, "SecureActionButtonTemplate")
--flareOrange:SetSize(25,25)
--flareOrange:SetNormalTexture("interface\\minimap\\partyraidblips")
--flareOrange:GetNormalTexture():SetTexCoord(0.25,0.375,0.25,0.5)
--flareOrange:SetPoint("LEFT", flarePurple, "RIGHT")
--flareOrange:SetAttribute("type", "macro")
--flareOrange:SetAttribute("macrotext1", "/wm 6")
--flareOrange:RegisterForClicks("AnyDown")
--flareOrange:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Circle world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flareOrange:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flareYellow = CreateFrame("Button", "flareYellow", MB_flareFrame, "SecureActionButtonTemplate")
--flareYellow:SetSize(25,25)
--flareYellow:SetNormalTexture("interface\\minimap\\partyraidblips")
--flareYellow:GetNormalTexture():SetTexCoord(0.375,0.5,0,0.25)
--flareYellow:SetPoint("LEFT", flareOrange, "RIGHT")
--flareYellow:SetAttribute("type", "macro")
--flareYellow:SetAttribute("macrotext1", "/wm 5")
--flareYellow:RegisterForClicks("AnyDown")
--flareYellow:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Star world marker",0.88,0.65,0); GameTooltip:Show() end end)
--flareYellow:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flareClear = CreateFrame("Button", "flareClear", MB_flareFrame, "SecureActionButtonTemplate")
--flareClear:SetSize(15,15)
--flareClear:SetNormalTexture("interface\\glues\\loadingscreens\\dynamicelements")
--flareClear:GetNormalTexture():SetTexCoord(0,0.5,0,0.5)
--flareClear:SetPoint("LEFT", flareYellow, "RIGHT")
--flareClear:SetAttribute("type", "macro")
--flareClear:SetAttribute("macrotext1", "/cwm 0")
--flareClear:RegisterForClicks("AnyDown")
--flareClear:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Clear all world markers.",0.88,0.65,0); GameTooltip:Show() end end)
--flareClear:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

--local flarelockIcon = CreateFrame("Button", "flarelockIcon", MB_flareFrame)
--flarelockIcon:SetSize(20,20)
--flarelockIcon:SetPoint("LEFT", flareClear , "RIGHT",5,0)
--flarelockIcon:SetNormalTexture("Interface\\AddOns\\MarkingBarLives\\resources\\Glues-Addon-Icons")
--flarelockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
--flarelockIcon:EnableMouse(true)
--flarelockIcon:SetScript("OnClick", function(self) MB_lockToggle("flare") end)
--flarelockIcon:SetScript("OnEnter", function(self) if (MBFlaresDB.tooltips) then GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:ClearLines(); GameTooltip:AddLine("Lock/Unlock",0.88,0.65,0); GameTooltip:Show() end end)
--flarelockIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)


