function ExamplePanel_OnLoad (panel)
    panel.name = "Marking Bar Lives"
    panel.okay = function(self) MB_Announce_Save(); end
    panel.cancel = function(self) MB_Announce_Save(); end
    panel.default = function(self) MB_reset(); MB_checkUpdater(); end
    panel.refresh = function(self) MB_checkUpdater(); MB_Announce_Save(); end
    InterfaceOptions_AddCategory(panel);
end
