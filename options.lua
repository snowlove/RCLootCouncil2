﻿-- Author      : Potdisc
-- Create Date : 5/24/2012 6:24:55 PM
-- options.lua - option frame in BlizOptions for RCLootCouncil

-- TODO		Clarify "Responses from chat"
local addon = LibStub("AceAddon-3.0"):GetAddon("RCLootCouncil")
local L = LibStub("AceLocale-3.0"):GetLocale("RCLootCouncil")
------ Options ------
function addon:OptionsTable()
	--local plugins = {}
	local db = addon:Getdb()
	local options = {
		name = "RCLootCouncil",
		type = "group",
		handler = addon,
		get = "DBGet",
		set = "DBSet",
		args = {
			settings = {
				order = 1,
				type = "group",
				name = "General",
				childGroups = "tab",
				args = {
					version = {
						order = 1,
						type = "description",
						name = function() return self.tVersion and "v"..self.version.."-"..self.tVersion or "v"..self.version end,
					},
					generalSettingsTab = {
						order = 2,
						type = "group",
						name = "General",
						childGroups = "tab",
						args = {
						generalOptions = {
							order = 1.1,
							name = L["General options"],
							type = "group",
							inline = true,
							args = {
								disable = {
									order = 1,
									name = L["Activate"],
									desc = L["activate_desc"],
									type = "toggle",
									set = function() addon.enabled = not addon.enabled end,
									get = function() return not addon.enabled end,
								},
								autoOpen = {
									order = 1.2,
									name = L["Auto Open"],
									desc = L["auto_open_desc"],
									type = "toggle",
								},
								--toggleAdvanced = {
								--	order = 1.3,
								--	name = "Toggle ML Options",
								--	desc = "Shows options that's only available to MasterLooters, such as changing loot buttons/responses, looting styles, announcements, voting types, etc.",
								--	type = "toggle",
								--	get = function() return db.advancedOptions end,
								--	set = function() db.advancedOptions = not db.advancedOptions; end,
								--},
								header = {
									order = 2,
									type = "header",
									name = "Autopass",
									width = "half",
								},
								testButton = {
									order = 7,
									name = L["Test"],
									desc = L["test_desc"],
									type = "execute",
									func = function()
										InterfaceOptionsFrame:Hide(); -- close all option frames before testing
										self:Test(3)
									end,
								},
								versionTest = {
									name = L["Version Check"],
									desc = L["version_check_desc"],
									type = "execute",
									order = 8	,
									func = function()
										InterfaceOptionsFrame:Hide()
										LibStub("AceConfigDialog-3.0"):CloseAll()
										addon:CallModule("version")
									end,
								},
							},
						},
						autoPassOptions = {
							order = 2,
							type = "group",
							name = L["Auto Pass"],
							inline = true,
							args = {
								autoPass = {
									order = 1,
									name = L["Auto Pass"],
									desc = L["auto_pass_desc"],
									type = "toggle",
								},
								silentAutoPass = {
									order = 2,
									name = L["Silent Auto Pass"],
									desc = L["silent_auto_pass_desc"],
									type = "toggle",
								},
								autoPassBoE = {
									order = 3,
									name = L["Auto pass BoE"],
									desc = L["auto_pass_boe_desc"],
									type = "toggle",
								},
							},
						},
						lootHistoryOptions = {
							order = 3,
							type = "group",
							name = L["Loot History"],
							inline = true,
							args = {
								desc1 = {
									order = 1,
									name = L["loot_history_desc"],
									type = "description",
								},
								enableHistory = {
									order = 2,
									name = L["Enable Loot History"],
									desc = L["enable_loot_history_desc"],
									type = "toggle",
								},
								sendHistory = {
									order = 3,
									name = L["Send History"],
									desc = L["send_history_desc"],
									type = "toggle",
								},
								header = {
									order = 4,
									type = "header",
									name = "",
								},
								openLootDB = {
									order = 5,
									name = L["Open the Loot History"],
									desc = L["open_the_loot_history_desc"],
									type = "execute",
									func = function() self:CallModule("loothistory");	InterfaceOptionsFrame:Hide();end,
								},
								clearLootDB = {
									order = -1,
									name = L["Clear Loot History"],
									desc = L["clear_loot_history_desc"],
									type = "execute",
									func = function() self.db.factionrealm.lootDB = {} end,
									confirm = true,
								},
							},
						},
						},
					},
				},
				plugins = {
					default = {

					}
				}
			},
			mlSettings = {
				name = L["Master Looter"],
				order = 2,
				type = "group",
				childGroups = "tab",
				handler = addon,
				get = "DBGet",
				set = "DBSet",
				--hidden = function() return not db.advancedOptions end,
				args = {
					desc = {
						order = 1,
						type = "description",
						name = L["master_looter_desc"],
					},
					general = {
						order = 2,
						type = "group",
						name = L["General"],
						args = {
							lootDesc = {
								order = 1,
								name = L["Looting options"],
								type = "group",
								inline = true,
								args = {
									autoEnable = {
										order = 1,
										name = L["Auto Enable"],
										desc = L["auto_enable_desc"],
										type = "toggle",
									},
									altClickLooting = {
										order = 2,
										name = L["Alt click Looting"],
										desc = L["alt_click_looting_desc"],
										type = "toggle",
									},
									spacer = {
										order = 3,
										type = "header",
										name = "",
									},
									autoStart = {
										order = 4,
										name = L["Auto Start"],
										desc = L["auto_start_desc"],
										type = "toggle",
									},
									autolootEverything = {
										order = 5,
										name = L["Loot Everything"],
										desc = L["loot_everything_desc"],
										type = "toggle",
										disabled = function() return not db.autoStart end,
									},
									autolootBoE = {
										order = 6,
										name = L["Autoloot BoE"],
										desc = L["autoloot_BoE_desc"],
										type = "toggle",
										disabled = function() return not db.autoStart end,
									},
								},
							},
							voteOptions = {
								order = 2,
								name = L["Voting options"],
								type = "group",
								inline = true,
								args = {
									selfVote = {
										order = 1,
										name = L["Self Vote"],
										desc = L["self_vote_desc"],
										type = "toggle",
									},
									multiVote = {
										order = 2,
										name = L["Multi Vote"],
										desc = L["multi_vote_desc"],
										type = "toggle",
									},
									allowNotes = {
										order = 3,
										name = L["Notes"],
										desc = L["notes_desc"],
										type = "toggle",
									},
									anonymousVoting = {
										order = 4,
										name = L["Anonymous Voting"],
										desc = L["anonymous_voting_desc"],
										type = "toggle",
									},
									showForML = {
										order = 5,
										name = L["ML sees voting"],
										desc = L["ml_sees_voting_desc"],
										type = "toggle",
										disabled = function() return not db.anonymousVoting end,
									},
									hideVotes = {
										order = 6,
										name = L["Hide Votes"],
										desc = L["hide_votes_desc"],
										type = "toggle",
									},
								},
							},
							ignoreOptions = {
								order = 3,
								name = L["Ignore Options"],
								type = "group",
								inline = true,
								args = {
									desc = {
										order = 1,
										name = L["ignore_options_desc"],
										type = "description",
									},
									ignoreInput = {
										order = 2,
										name = L["Add Item"],
										desc = L["ignore_input_desc"],
										type = "input",
										pattern = "%d",
										usage = L["ignore_input_usage"],
										get = function() return "\"itemID\"" end,
										set = function(info, val) tinsert(db.ignore, val); LibStub("AceConfigRegistry-3.0"):NotifyChange("RCLootCouncil") end,
									},
									ignoreList = {
										order = 3,
										name = L["Ignore List"],
										desc = L["ignore_list_desc"],
										type = "select",
										style = "dropdown",
										width = "double",
										values = function()
											local t = {}
											for i = 1, #db.ignore do
												local link = select(2, GetItemInfo(db.ignore[i]))
												t[i] = link or L["Not cached, please reopen."]
											end
											return t
										end,
										get = function() return L["Ignore List"] end,
										set = function(info, val) tremove(db.ignore, val) end,
									},
								},
							},
						},
					},
					awards = {
						order = 3,
						type = "group",
						name = L["Awards"],
						args = {
							autoAward = {
								order = 1,
								name = L["Auto Award"],
								type = "group",
								inline = true,
								disabled = function() return not db.autoAward end,
								args = {
									autoAward = {
										order = 1,
										name = L["Auto Award"],
										desc = L["auto_award_desc"],
										type = "toggle",
										disabled = false,
									},
									autoAwardLowerThreshold = {
										order = 1.1,
										name = L["Lower Quality Limit"],
										desc = L["lower_quality_limit_desc"],
										type = "select",
										style = "dropdown",
										values = function()
											local t = {}
											for i = 0, 5 do
												local r,g,b,hex = GetItemQualityColor(i)
												t[i] = "|c"..hex.." "..getglobal("ITEM_QUALITY"..i.."_DESC")
											end
											return t;
										end,
									},
									autoAwardUpperThreshold = {
										order = 1.2,
										name = L["Upper Quality Limit"],
										desc = L["upper_quality_limit_desc"],
										type = "select",
										style = "dropdown",
										values = function()
											local t = {}
											for i = 0, 5 do
												local r,g,b,hex = GetItemQualityColor(i)
												t[i] = "|c"..hex.." "..getglobal("ITEM_QUALITY"..i.."_DESC")
											end
											return t;
										end,
									},
									autoAwardTo = {
										order = 2,
										name = L["Auto Award to"],
										desc = L["auto_award_to_desc"],
										width = "double",
										type = "input",
										hidden = function() return IsInRaid() end,
										get = function() return db.autoAwardTo; end,
										set = function(i,v) db.autoAwardTo = v; end,
									},
									autoAwardTo2 = {
										order = 2,
										name = L["Auto Award to"],
										desc = L["auto_award_to_desc"],
										width = "double",
										type = "select",
										style = "dropdown",
										values = function()
											local t = {}
											for i = 1, GetNumGroupMembers() do
												t[i] = GetRaidRosterInfo(i)
											end
											return t;
										end,
										hidden = function() return not IsInRaid() end,
									},
									autoAwardReason = {
										order = 2.1,
										name = L["Reason"],
										desc = L["reason_desc"],
										type = "select",
										style = "dropdown",
										values = function()
											local t = {}
											for i = 1, db.numAwardReasons do
												t[i] = db.awardReasons[i].text
											end
											return t
										end,
									},
								},
							},
							awardReasons = {
								order = 2,
								type = "group",
								name = L["Award Reasons"],
								inline = true,
								args = {
									desc = {
										order = 0,
										name = L["award_reasons_desc"],
										type = "description",
									},
									numAwardReasons = {
										order = 1,
										name = L["Number of reasons"],
										desc = L["number_of_reasons_desc"],
										type = "range",
										width = "full",
										min = 1,
										max = db.maxAwardReasons,
										step = 1,
									},
									-- Award reasons made further down
									reset = {
										order = -1,
										name = L["Reset to default"],
										desc = L["reset_to_default_desc"],
										type = "execute",
										confirm = true,
										func = function() addon:awardReasonsToDefault() end,
									},
								},
							},
						},
					},
					announcements = {
						order = 4,
						type = "group",
						name = L["Announcements"],
						args = {
							awardAnnouncement = {
								order = 1,
								name = L["Award Announcement"],
								type = "group",
								inline = true,
								args = {
									announceAward = {
										order = 1,
										name = L["Announce Awards"],
										desc = L["announce_awards_desc"],
										type = "toggle",
										width = "full",
									},
									outputDesc = {
										order = 2,
										name = L["announce_awards_desc2"],
										type = "description",
										hidden = function() return not db.announceAward end,
									},
									-- Rest is made further below
								},
							},

							announceConsiderations = {
								order = 2,
								name = L["Announce Considerations"],
								type = "group",
								inline = true,
								args = {
									announceItems = {
										order = 1,
										name = L["Announce Considerations"],
										desc = L["announce_considerations_desc"],
										type = "toggle",
										width = "full",
									},
									desc = {
										order = 2,
										type = "description",
										name = L["announce_considerations_desc2"],
										hidden = function() return not db.announceItems end,
									},
									announceChannel = {
										order = 3,
										name = L["Channel"],
										desc = L["channel_desc"],
										type = "select",
										style = "dropdown",
										values = {
											SAY = L["Say"],
											YELL = L["Yell"],
											PARTY = L["Party"],
											GUILD = L["Guild"],
											OFFICER = L["Officer"],
											RAID = L["Raid"],
											RAID_WARNING = L["Raid Warning"],
											group = L["Group"], -- must be converted
										},
										set = function(i,v)
												-- Convert "group" if needed
												if v == "group" then
													if IsInRaid() then
														v = "RAID"
													else
														v = "PARTY"
													end
												end
												db.announceChannel = v
											end,
										hidden = function() return not db.announceItems end,
									},
									announceText = {
										order = 3.1,
										name = L["Message"],
										desc = L["message_desc"],
										type = "input",
										width = "double",
										hidden = function() return not db.announceItems end,
									},
								},
							},
							reset = {
								order = -1,
								name = L["Reset to default"],
								desc = L["reset_announce_to_default_desc"],
								type = "execute",
								confirm = true,
								func = function() addon:announceToDefault() end
							},
						},
					},
					buttons = {
						order = 5,
						type = "group",
						name = L["Buttons and Responses"],
						args = {
							buttonOptions = {
								order = 1,
								type = "group",
								name = L["Buttons and Responses"],
								inline = true,
								args = {
									optionsDesc = {
										order = 0,
										name = format(L["buttons_and_responses_desc"], db.maxButtons),
										type = "description"
									},
									numButtons = {
										order = 1,
										name = L["Number of buttons"],
										desc = L["number_of_buttons_desc"],
										type = "range",
										width = "full",
										min = 1,
										max = db.maxButtons,
										step = 1,
									},
									-- passButton = {
									-- 	order = -1,
									-- 	name = "Pass button",
									-- 	desc = "Select which buttons' response you want to filter when selecting \"Filter Passes\".",
									-- 	type = "select",
									-- 	style = "dropdown",
									-- 	width = "double",
									-- 	values = function()
									-- 		local t = {}
									-- 		t[(db.maxButtons + 1)] = "None";
									-- 		for i = 1, db.maxButtons do
									-- 			if i <= db.numButtons then t[i] = "Button "..i; else break end
									-- 		end
									-- 		return t;
									-- 	end,
									-- 	set = function(i,v) db.passButton = v end,
									-- 	get = function() return db.passButton end,
									-- },
								},
							},
							responseFromChat = {
								order = 2,
								type = "group",
								name = L["Responses from Chat"],
								inline = true,
								args = {
									acceptWhispers = {
										order = 1,
										name = L["Accept Whispers"],
										desc = L["accept_whispers_desc"],
										type = "toggle",
									},
									-- acceptRaidChat = {
									-- 	order = 1.1,
									-- 	name = "Accept Raid Chat",
									-- 	desc = "Enables players to post their current item(s) in raid chat and thus get added to the voting frame.",
									-- 	type = "toggle",
									-- 	get = function() return db.acceptRaidChat end,
									-- 	set = function() db.acceptRaidChat = not db.acceptRaidChat; end,
									-- },
									desc = {
										order = 2,
										name = L["responses_from_chat_desc"],
										type = "description",
										hidden = function() return not (db.acceptWhispers or db.acceptRaidChat) end,
									},
									-- Made further down
								},
							},
							reset = {
								order = -1,
								name = L["Reset to default"],
								desc = L["reset_buttons_to_default_desc"],
								type = "execute",
								confirm = true,
								func = function() addon:buttonsToDefault() end
							},
						},
					},
					council = {
						order = 6,
						type = "group",
						name = L["Council"],
						childGroups = "tab",
						args = {
							currentCouncil = {
								order = 1,
								type = "group",
								name = L["Current Council"],
								args = {
									currentCouncilDesc = {
										order = 1,
										name = L["current_council_desc"],
										type = "description",
									},
									councilList = {
										order = 2,
										type = "multiselect",
										name = "",
										values = function()
											local t = {}
											for k,v in ipairs(db.council) do t[k] = ""..v end
											return t;
										end,
										width = "full",
										get = function() return true end,
										set = function(m,key) tremove(db.council,key) end,
									},
									removeAll = {
										order = 3,
										name = L["Remove All"],
										desc = L["remove_all_desc"],
										type = "execute",
										confirm = true,
										func = function() db.council = {} end,
									},
								},
							},
							addCouncil = {
								order = 2,
								type = "group",
								name = L["Guild Council Members"],
								childGroups = "tree",
								args = {
									addRank = {
										order = 1,
										name = L["Add ranks"],
										type = "group",
										args = {
											header1 = {
												order = 1,
												name = L["add_ranks_desc"],
												type = "header",
												width = "full",
											},
											selection = {
												order = 2,
												name = "",
												type = "select",
												width = "full",
												values = function()
													GuildRoster();
													local info = {};
													for ci = 1, GuildControlGetNumRanks() do
														info[ci] = " "..ci.." - "..GuildControlGetRankName(ci);
													end
													return info
												end,
												set = function(j,i) db.council = {}; db.minRank = i; end,
												get = function() return db.minRank; end,
											},
											desc = {
												order = 3,
												name = L["add_ranks_desc2"],
												type = "description",
											},
										},
									},
									spacer = {
										order = 2,
										name = "",
										type = "group",
										args = {}
									},
								},
							},
							addGroupCouncil = {
								order = 3,
								type = "group",
								name = L["Group Council Members"],
								args = {
									header1 = {
										order = 1,
										name = L["group_council_members_head"],
										type = "header",
										width = "full",
									},
									desc = {
										order = 2,
										name = L["group_council_members_desc"],
										type = "description",
									},
									list = {
										order = 3,
										type = "multiselect",
										name = "",
										width = "full",
										values = function()
											local t = {}
											for i = 1, GetNumGroupMembers() do
												-- Ambiguate to distinguish people from own realm, not sure if it's smart at the end of the day though
												tinsert(t, Ambiguate(select(1,GetRaidRosterInfo(i)), "none"))	-- might need a tostring()
											end
											table.sort(t, function(v1, v2)
												return v1 and v1 < v2
											end)
											return t
										end,
										set = function(info,key,tag)
											local values = info[#info-1].values()
											if tag then -- add
												tinsert(self.db.profile.council, values[key])
											else -- remove
												for k,v in ipairs(self.db.profile.council) do
													if v == values[key] then
														tremove(self.db.profile.council, k)
													end
												end
											end
										end,
										get = function(info, key)
											local values = info[#info-1].values()
											return tContains(self.db.profile.council, values[key])
										end,
									},
								},
							},
						},
					},
				},
			},
		},
	}

	-- #region Create options thats made with loops
	-- Buttons
	--[[local button, picker, text = {}, {}, {}
	for i = 1, db.maxButtons do
		button = {
			order = i * 3 + 1,
			name = L["Button"].." "..i,
			desc = L["Set the text on button "]..i,
			type = "input",
			get = function() return db.buttons[i].text end,
			set = function(info, value)	db.buttons[i].text = tostring(value) end,
			hidden = function() return db.numButtons < i end,
		}
		options.args.mlSettings.args.buttonsOptionsTab.args.buttonOptions.args["button"..i] = button;
		picker = {
			order = i * 3 + 2,
			name = L["Response color"],
			desc = L["response_color_desc"],
			type = "color",
			get = function() return unpack(db.responses[i].color)	end,
			set = function(info,r,g,b,a) db.responses[i].color = {r,g,b,a} end,
			hidden = function() return db.numButtons < i end,
		}
		options.args.mlSettings.args.buttonsOptionsTab.args.buttonOptions.args["picker"..i] = picker;
		text = {
			order = i * 3 + 3,
			name = L["Response"],
			desc = format(L["Set the text for button i's response."], i),
			type = "input",
			get = function() return db.responses[i].text end,
			set = function(info, value) db.responses[i].text = tostring(value) end,
			hidden = function() return db.numButtons < i end,
		}
		options.args.mlSettings.args.buttonsOptionsTab.args.buttonOptions.args["text"..i] = text;

		local whisperKeys = {
			order = i + 3,
			name = L["Button"]..i,
			desc = format(L["Set the whisper keys for button i. Used in conjunction with Chat settings."], i),
			type = "input",
			width = "double",
			get = function() return db.buttons[i].whisperKey end,
			set = function(k,v) db.buttons[i].whisperKey = tostring(v) end,
			hidden = function() return not (db.acceptWhispers or db.acceptRaidChat) or db.numButtons < i end,
		}
		options.args.mlSettings.args.buttonsOptionsTab.args.responseFromChat.args["whisperKey"..i] = whisperKeys;
	end

	-- Award Reasons
	for i = 1, db.maxAwardReasons do
		options.args.mlSettings.args.awardTab.args.awardReasons.args["reason"..i] = {
			order = i+1,
			name = L["Reason"]..i,
			desc = L["Text for reason #i"]..i,
			type = "input",
			width = "double",
			get = function() return db.awardReasons[i].text end,
			set = function(k,v) db.awardReasons[i].text = v; end,
			hidden = function() return db.numAwardReasons < i end,
		}
		options.args.mlSettings.args.awardTab.args.awardReasons.args["color"..i] = {
			order = i +1.1,
			name = L["Text color"],
			desc = L["text_color_desc"],
			type = "color",
			width = "half",
			get = function() return unpack(db.awardReasons[i].color) end,
			set = function(info, r,g,b,a) db.awardReasons[i].color = {r,g,b,a} end,
			hidden = function() return db.numAwardReasons < i end,
		}
		options.args.mlSettings.args.awardTab.args.awardReasons.args["log"..i] = {
			order = i +1.2,
			name = L["Log"],
			desc = L["log_desc"],
			type = "toggle",
			width = "half",
			get = function() return db.awardReasons[i].log end,
			set = function() db.awardReasons[i].log = not db.awardReasons[i].log end,
			hidden = function() return db.numAwardReasons < i end,
		}
	end
	-- Announce Channels
	for i = 1, #db.awardText do
		options.args.mlSettings.args.announcementTab.args.awardAnnouncement.args["outputSelect"..i] = {
			order = i+3,
			name = L["Channel"]..i..":",
			desc = L["channel_desc"],
			type = "select",
			style = "dropdown",
			values = {
				NONE = L["None"],
				SAY = L["Say"],
				YELL = L["Yell"],
				PARTY = L["Party"],
				GUILD = L["Guild"],
				OFFICER = L["Officer"],
				RAID = L["Raid"],
				RAID_WARNING = L["Raid Warning"],
			},
			set = function(j,v) db.awardText[i].channel = v end,
			get = function() return db.awardText[i].channel end,
			hidden = function() return not db.announceAward end,
		}
		options.args.mlSettings.args.announcementTab.args.awardAnnouncement.args["outputMessage"..i] = {
			order = i+3.1,
			name = L["Message"],
			desc = L["message_desc"],
			type = "input",
			width = "double",
			get = function() return db.awardText[i].text end,
			set = function(j,v) db.awardText[i].text = v; end,
			hidden = function() return not db.announceAward end,
		}
	end]]
	-- #endregion
	return options
end

function RCLootCouncil:DBGet(info)
	return self.db.profile[info[#info]]
end

function RCLootCouncil:DBSet(info, val)
	self.db.profile[info[#info]] = val
end

function addon:GetGuildOptions()
	for i = 1, GuildControlGetNumRanks() do
		local rank = GuildControlGetRankName(i)
		local names = {}

		-- Define the individual council option:
		local option = {
			order = i + 2,
			name = rank,
			type = "group",
			args = {
				ranks = {
					order = i,
					name = ""..rank,
					type = "multiselect",
					width = "full",
					values = function()
						wipe(names)
						for ci = 1, GetNumGuildMembers() do
							local name, rank1, rankIndex = GetGuildRosterInfo(ci);
							name = Ambiguate(name, "none")
							if (rankIndex + 1) == i then tinsert(names, name) end
						end
						table.sort(names, function(v1, v2)
							return v1 and v1 < v2
						end)
						return names
					end,
					get = function(info, key)
						local values = info[#info-1].args.ranks.values()
						return tContains(self.db.profile.council, values[key])
					end,
					set = function(info, key, tag)
						--local values = addon.options.args.council.args.addCouncil.args[info[#info-1]].args.ranks.values()
						local values = info[#info-1].args.ranks.values()
						if tag then
							tinsert(self.db.profile.council, values[key])
						else
							for k,v in ipairs(self.db.profile.council) do
								if v == values[key] then
									tremove(self.db.profile.council, k)
								end
							end
						end
					end,
				},
			},
		}

		-- Add it to the guildMembersGroup arguments:
		self.options.args.mlSettings.args.councilTab.args.addCouncil.args[i..""..rank] = option
	end
end
