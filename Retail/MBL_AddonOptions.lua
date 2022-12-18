local MB = "|cffe1a500Marking|cff69ccf0Bar|cffff0000Lives|cffffffff"  -- MB Title
local MBF = "|cffe1a500MBL|cff69ccf0Flares|cffffffff"   -- MBFlares Title
local versionNum = GetAddOnMetadata("MarkingBarLives", "Version")
local curVer = "|cffffffff "..versionNum.."|cffe1a500"      -- Version Number

local mainOptionsPanel, markerOptionsPanel, controlOptionsPanel, flaresOptionsPanel, announceOptionsPanel

local function deferredInterfaceOptions()
    if (mainOptionsPanel and markerOptionsPanel and controlOptionsPanel and flaresOptionsPanel and announceOptionsPanel) then
        markerOptionsPanel.parent = mainOptionsPanel.name
        controlOptionsPanel.parent = mainOptionsPanel.name
        flaresOptionsPanel.parent = mainOptionsPanel.name
        announceOptionsPanel.parent = mainOptionsPanel.name
        InterfaceOptions_AddCategory(mainOptionsPanel);
        InterfaceOptions_AddCategory(markerOptionsPanel);
        InterfaceOptions_AddCategory(controlOptionsPanel);
        InterfaceOptions_AddCategory(flaresOptionsPanel);
        InterfaceOptions_AddCategory(announceOptionsPanel);
    end
end

function MarkingBarOpt_OnLoad(panel)
    panel.name = "Marking Bar Lives"
    panel.okay = function(self) MB_Announce_Save(); end
    panel.cancel = function(self) MB_Announce_Save(); end
    panel.default = function(self) MB_reset(); MB_checkUpdater(); end
    panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end

    MBOptionsText:SetText(MB.."|cffe1a500 Options")

    mainOptionsPanel = panel
    deferredInterfaceOptions()
end

function MarkerOptPg_OnLoad(panel)
    panel.name = "Markers"
    panel.okay = function(self) MB_Announce_Save(); end
    panel.cancel = function(self) MB_Announce_Save(); end
    panel.default = function(self) MB_reset(); MB_checkUpdater(); end
    panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end

    markerOptionsText:SetText(MB.."|cffe1a500 Options")

    markerOptionsPanel = panel
    deferredInterfaceOptions()
end

function ControlOptPg_OnLoad(panel)
    panel.name = "Controls"
    panel.okay = function(self) MB_Announce_Save(); end
    panel.cancel = function(self) MB_Announce_Save(); end
    panel.default = function(self) MB_reset(); MB_checkUpdater(); end
    panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end

    ctrlOptionsText:SetText(MB.."|cffe1a500 Control Options")

    controlOptionsPanel = panel
    deferredInterfaceOptions()
end

function FlaresOptPg_OnLoad(panel)
    panel.name = "Flares"
    panel.okay = function(self) MB_Announce_Save(); end
    panel.cancel = function(self) MB_Announce_Save(); end
    panel.default = function(self) MB_reset(); MB_checkUpdater(); end
    panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end

    flareOptionsText:SetText(MBF.."|cffe1a500 Options")

    flaresOptionsPanel = panel
    deferredInterfaceOptions()
end

function AnnounceOptPg_OnLoad(panel)
    panel.name = "Marker Announcements"
    panel.okay = function(self) MB_Announce_Save(); end
    panel.cancel = function(self) MB_Announce_Save(); end
    panel.default = function(self) MB_reset(); end
    panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end

    AnnounceOptionsText:SetText("|cffe1a500Chat Announcement Options")

    announceOptionsPanel = panel
    deferredInterfaceOptions()
end

function versFooter_OnLoad(frame)
    versionText:SetText(MB..curVer)
end
