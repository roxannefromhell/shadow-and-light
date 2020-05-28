﻿local SLE, T, E, L, V, P, G = unpack(select(2, ...))
local EDB = E:GetModule('DataBars')
local DB = SLE:GetModule("DataBars")

local format = format
local FACTION, REPUTATION, SCENARIO_BONUS_LABEL = FACTION, REPUTATION, SCENARIO_BONUS_LABEL

local function configTable()
	if not SLE.initialized then return end
	E.Options.args.sle.args.modules.args.databars = {
		type = "group",
		name = L["DataBars"],
		childGroups = 'tab',
		order = 1,
		args = {
			exp = {
				order = 1,
				type = "group",
				name = XP,
				args = {
					goElv = {
						order = 1,
						type = 'execute',
						name = "ElvUI: "..XPBAR_LABEL,
						func = function() E.Libs["AceConfigDialog"]:SelectGroup("ElvUI", "databars", "experience") end,
					},
					longtext = {
						order = 2,
						type = "toggle",
						name = L["Full value on Exp Bar"],
						desc = L["Changes the way text is shown on exp bar."],
						get = function(info) return E.db.sle.databars.exp.longtext end,
						set = function(info, value) E.db.sle.databars.exp.longtext = value; EDB:UpdateExperience() end,
					},
					chatfilters = {
						order = 3,
						type = "group",
						guiInline = true,
						name = L["Chat Filters"],
						get = function(info) return E.db.sle.databars.exp.chatfilter[ info[#info] ] end,
						set = function(info, value) E.db.sle.databars.exp.chatfilter[ info[#info] ] = value; end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								desc = L["Change the style of experience gain messages."],
								set = function(info, value) E.db.sle.databars.exp.chatfilter[ info[#info] ] = value; DB:RegisterFilters() end,
							},
							iconsize = {
								order = 2,
								type = "range",
								name = L["Icon Size"],
								disabled = function() return not E.db.sle.databars.exp.chatfilter.enable end,
								min = 8, max = 32, step = 1,
							},
							style = {
								order = 3,
								type = "select",
								name = L["Experience Style"],
								disabled = function() return not E.db.sle.databars.exp.chatfilter.enable end,
								values = {
									["STYLE1"] = format(DB.Exp.Styles["STYLE1"]["Bonus"], 14, E.myname, 300, 150, SCENARIO_BONUS_LABEL),
									["STYLE2"] = format(DB.Exp.Styles["STYLE2"]["Bonus"], 14, E.myname, 300, 150, SCENARIO_BONUS_LABEL),
								},
							},
						},
					},
				},
			},
			rep = {
				order = 2,
				type = "group",
				name = REPUTATION,
				args = {
					goElv = {
						order = 1,
						type = 'execute',
						name = "ElvUI: "..REPUTATION,
						func = function() E.Libs["AceConfigDialog"]:SelectGroup("ElvUI", "databars", "reputation") end,
					},
					longtext = {
						order = 2,
						type = "toggle",
						name = L["Full value on Rep Bar"],
						desc = L["Changes the way text is shown on rep bar."],
						get = function(info) return E.db.sle.databars.rep.longtext end,
						set = function(info, value) E.db.sle.databars.rep.longtext = value; EDB:UpdateReputation() end,
					},
					chatfilters = {
						order = 5,
						type = "group",
						guiInline = true,
						name = L["Chat Filters"],
						get = function(info) return E.db.sle.databars.rep.chatfilter[ info[#info] ] end,
						set = function(info, value) E.db.sle.databars.rep.chatfilter[ info[#info] ] = value; end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								desc = L["Change the style of reputation messages."],
								set = function(info, value) E.db.sle.databars.rep.chatfilter[ info[#info] ] = value; DB:RegisterFilters() end,
							},
							iconsize = {
								order = 2,
								type = "range",
								name = L["Icon Size"],
								disabled = function() return not E.db.sle.databars.rep.chatfilter.enable end,
								min = 8, max = 32, step = 1,
							},
							style = {
								order = 3,
								type = "select",
								name = L["Reputation increase Style"],
								disabled = function() return not E.db.sle.databars.rep.chatfilter.enable end,
								values = {
									["STYLE1"] = format(DB.RepIncreaseStyles["STYLE1"], 14, FACTION, 300),
									["STYLE2"] = format(DB.RepIncreaseStyles["STYLE2"], 14, FACTION, 300),
								},
							},
							styleDec = {
								order = 4,
								type = "select",
								name = L["Reputation decrease Style"],
								disabled = function() return not E.db.sle.databars.rep.chatfilter.enable end,
								values = {
									["STYLE1"] = format(DB.RepDecreaseStyles["STYLE1"], 14, FACTION, 300),
									["STYLE2"] = format(DB.RepDecreaseStyles["STYLE2"], 14, FACTION, 300),
								},
							},
							showAll = {
								order = 5,
								type = "toggle",
								name = L["Full List"],
								desc = L["Show all factions affected by the latest reputation change. When disabled only first (in alphabetical order) affected faction will be shown."],
								disabled = function() return not E.db.sle.databars.rep.chatfilter.enable end,
							},
							chatframe = {
								order = 6,
								type = "select",
								name = L["Output"],
								desc = L["Determines in which frame reputation messages will be shown. Auto is for whatever frame has reputation messages enabled via Blizzard options."],
								disabled = function() return not E.db.sle.databars.rep.chatfilter.enable end,
								values = {
									["AUTO"] = L["Auto"],
									["ChatFrame1"] = L["Frame 1"],
									["ChatFrame2"] = L["Frame 2"],
									["ChatFrame3"] = L["Frame 3"],
									["ChatFrame4"] = L["Frame 4"],
									["ChatFrame5"] = L["Frame 5"],
									["ChatFrame6"] = L["Frame 6"],
									["ChatFrame7"] = L["Frame 7"],
									["ChatFrame8"] = L["Frame 8"],
									["ChatFrame9"] = L["Frame 9"],
									["ChatFrame10"] = L["Frame 10"],
								},
							},
						},
					},
				},
			},
			honor = {
				order = 3,
				type = "group",
				name = HONOR,
				args = {
					goElv = {
						order = 1,
						type = 'execute',
						name = "ElvUI: "..HONOR,
						func = function() E.Libs["AceConfigDialog"]:SelectGroup("ElvUI", "databars", "honor") end,
					},
					longtext = {
						order = 2,
						type = "toggle",
						name = L["Full value on Honor Bar"],
						desc = L["Changes the way text is shown on honor bar."],
						get = function(info) return E.db.sle.databars.honor.longtext end,
						set = function(info, value) E.db.sle.databars.honor.longtext = value; EDB:UpdateHonor() end,
					},
					chatfilters = {
						order = 3,
						type = "group",
						guiInline = true,
						name = L["Chat Filters"],
						get = function(info) return E.db.sle.databars.honor.chatfilter[ info[#info] ] end,
						set = function(info, value) E.db.sle.databars.honor.chatfilter[ info[#info] ] = value; end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								desc = L["Change the style of honor gain messages."],
								set = function(info, value) E.db.sle.databars.honor.chatfilter[ info[#info] ] = value; DB:RegisterFilters() end,
							},
							iconsize = {
								order = 2,
								type = "range",
								name = L["Icon Size"],
								disabled = function() return not E.db.sle.databars.honor.chatfilter.enable end,
								min = 8, max = 32, step = 1,
							},
							spacer = {order = 3, type = "description", name = ""},
							style = {
								order = 4,
								type = "select",
								name = L["Honor Style"],
								disabled = function() return not E.db.sle.databars.honor.chatfilter.enable end,
								values = {
									["STYLE1"] = format(DB.Honor.Styles["STYLE1"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE2"] = format(DB.Honor.Styles["STYLE2"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE3"] = format(DB.Honor.Styles["STYLE3"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE4"] = format(DB.Honor.Styles["STYLE4"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE5"] = format(DB.Honor.Styles["STYLE5"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE6"] = format(DB.Honor.Styles["STYLE6"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE7"] = format(DB.Honor.Styles["STYLE7"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE8"] = format(DB.Honor.Styles["STYLE8"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE9"] = format(DB.Honor.Styles["STYLE9"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
								},
							},
							awardStyle = {
								order = 5,
								type = "select",
								name = L["Award Style"],
								desc = L["Defines the style of changed string. Colored parts will be shown with your selected value color in chat."],
								disabled = function() return not E.db.sle.databars.honor.chatfilter.enable end,
								values = {
									["STYLE1"] = format(DB.Honor.AwardStyles["STYLE1"], "3.45", DB.Honor.Icon, 12),
									["STYLE2"] = format(DB.Honor.AwardStyles["STYLE2"], "3.45", DB.Honor.Icon, 12),
									["STYLE3"] = format(DB.Honor.AwardStyles["STYLE3"], "3.45", DB.Honor.Icon, 12),
									["STYLE4"] = format(DB.Honor.AwardStyles["STYLE4"], "3.45", DB.Honor.Icon, 12),
									["STYLE5"] = format(DB.Honor.AwardStyles["STYLE5"], "3.45", DB.Honor.Icon, 12),
									["STYLE6"] = format(DB.Honor.AwardStyles["STYLE6"], "3.45", DB.Honor.Icon, 12),
								},
							},
						},
					},
				},
			},
			azerite = {
				order = 4,
				type = "group",
				name = L["Azerite Bar"],
				args = {
					goElv = {
						order = 1,
						type = 'execute',
						name = "ElvUI: "..L["Azerite Bar"],
						func = function() E.Libs["AceConfigDialog"]:SelectGroup("ElvUI", "databars", "azerite") end,
					},
					longtext = {
						order = 2,
						type = "toggle",
						name = L["Full value on Azerite Bar"],
						desc = L["Changes the way text is shown on azerite bar."],
						get = function(info) return E.db.sle.databars.azerite.longtext end,
						set = function(info, value) E.db.sle.databars.azerite.longtext = value; EDB:UpdateAzerite() end,
					},
					--[[chatfilters = {
						order = 3,
						type = "group",
						guiInline = true,
						name = L["Chat Filters"],
						get = function(info) return E.db.sle.databars.honor.chatfilter[ info[#info] ] end,
						set = function(info, value) E.db.sle.databars.honor.chatfilter[ info[#info] ] = value; end,
						args = {
							enable = {
								order = 1,
								type = "toggle",
								name = L["Enable"],
								desc = L["Change the style of honor gain messages."],
								set = function(info, value) E.db.sle.databars.honor.chatfilter[ info[#info] ] = value; DB:RegisterFilters() end,
							},
							iconsize = {
								order = 2,
								type = "range",
								name = L["Icon Size"],
								disabled = function() return not E.db.sle.databars.honor.chatfilter.enable end,
								min = 8, max = 32, step = 1,
							},
							spacer = {order = 3, type = "description", name = ""},
							style = {
								order = 4,
								type = "select",
								name = L["Honor Style"],
								disabled = function() return not E.db.sle.databars.honor.chatfilter.enable end,
								values = {
									["STYLE1"] = format(DB.Honor.Styles["STYLE1"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE2"] = format(DB.Honor.Styles["STYLE2"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE3"] = format(DB.Honor.Styles["STYLE3"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE4"] = format(DB.Honor.Styles["STYLE4"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE5"] = format(DB.Honor.Styles["STYLE5"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE6"] = format(DB.Honor.Styles["STYLE6"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE7"] = format(DB.Honor.Styles["STYLE7"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE8"] = format(DB.Honor.Styles["STYLE8"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
									["STYLE9"] = format(DB.Honor.Styles["STYLE9"], E.myname, RANK, "3.45", DB.Honor.Icon, 12),
								},
							},
							awardStyle = {
								order = 5,
								type = "select",
								name = L["Award Style"],
								desc = L["Defines the style of changed string. Colored parts will be shown with your selected value color in chat."],
								disabled = function() return not E.db.sle.databars.honor.chatfilter.enable end,
								values = {
									["STYLE1"] = format(DB.Honor.AwardStyles["STYLE1"], "3.45", DB.Honor.Icon, 12),
									["STYLE2"] = format(DB.Honor.AwardStyles["STYLE2"], "3.45", DB.Honor.Icon, 12),
									["STYLE3"] = format(DB.Honor.AwardStyles["STYLE3"], "3.45", DB.Honor.Icon, 12),
									["STYLE4"] = format(DB.Honor.AwardStyles["STYLE4"], "3.45", DB.Honor.Icon, 12),
									["STYLE5"] = format(DB.Honor.AwardStyles["STYLE5"], "3.45", DB.Honor.Icon, 12),
									["STYLE6"] = format(DB.Honor.AwardStyles["STYLE6"], "3.45", DB.Honor.Icon, 12),
								},
							},
						},
					},]]
				},
			},
		},
	}
end

tinsert(SLE.Configs, configTable)
