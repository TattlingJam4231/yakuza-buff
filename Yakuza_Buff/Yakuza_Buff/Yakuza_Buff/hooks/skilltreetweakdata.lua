local original_init = SkillTreeTweakData.init

function SkillTreeTweakData:init(...)
	original_init(self, ...)
	
	table.insert(self.specializations[12][9].upgrades, "temporary_shallow_grave")
	
end