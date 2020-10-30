﻿local SLE, T, E, L, V, P, G = unpack(select(2, ...))
local DB = SLE:NewModule("DataBars","AceHook-3.0", "AceEvent-3.0")
--GLOBALS: ChatFrame_AddMessageEventFilter, ChatFrame_RemoveMessageEventFilter
DB.Icons = {
	Rep = [[Interface\Icons\Achievement_Reputation_08]],
	XP = [[Interface\Icons\XP_ICON]],
}

function DB:RegisterFilters()
	if E.db.sle.databars.rep.chatfilter.enable then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_FACTION_CHANGE", self.FilterReputation)
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_COMBAT_FACTION_CHANGE", self.FilterReputation)
	end
	if E.db.sle.databars.exp.chatfilter.enable then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_XP_GAIN", self.FilterExperience)
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_COMBAT_XP_GAIN", self.FilterExperience)
	end
	if E.db.sle.databars.honor.chatfilter.enable then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_HONOR_GAIN", self.FilterHonor)
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_COMBAT_HONOR_GAIN", self.FilterHonor)
	end
end

function DB:Initialize()
	if not SLE.initialized then return end
	DB.db = E.db.sle.databars
	DB:RegisterFilters()

	function DB:ForUpdateAll()
		DB:RegisterFilters()
	end
	DB:ExpInit()
	DB:RepInit()
	print("try shit")
	DB:AzeriteInit()
	DB:HonorInit()
	DB:ForUpdateAll()
print("qqqq")
	-- self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE", "NewRepString")
	self:RegisterEvent("UPDATE_FACTION", "NewRepString")
	DB:NewRepString()

end

SLE:RegisterModule(DB:GetName())
