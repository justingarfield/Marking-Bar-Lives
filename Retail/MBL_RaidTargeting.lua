
MBL_RaidTargeting_Mover_OnMouseDown = function(self, button)
	if (button=="LeftButton") then
		MBL_RaidTargeting:StartMoving()
	end
end

MBL_RaidTargeting_Mover_OnMouseUp = function(self)
	MBL_RaidTargeting:StopMovingOrSizing()
end
