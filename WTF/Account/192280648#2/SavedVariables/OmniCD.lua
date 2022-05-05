
OmniCDDB = {
	["global"] = {
		["oodVer"] = 2711,
		["oodChk"] = 220408,
		["disableElvMsg"] = true,
		["oodMsg"] = "|cfff16436 有新版本可以使用。|cff99cdff(次要更新)",
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["cooldowns"] = {
	},
	["profileKeys"] = {
		["薇羽 - 影之哀伤"] = "薇羽Anne",
		["杜一航 - 安苏"] = "薇羽Anne",
		["柳絮菲菲 - 影之哀伤"] = "薇羽Anne",
		["薇羽 - 冰风岗"] = "Default",
	},
	["version"] = 2.51,
	["profiles"] = {
		["Default"] = {
		},
		["薇羽Anne"] = {
			["Party"] = {
				["party"] = {
					["extraBars"] = {
						["interruptBar"] = {
							["scale"] = 0.71,
						},
					},
					["general"] = {
						["showPlayer"] = true,
					},
					["icons"] = {
						["scale"] = 0.7,
						["showTooltip"] = true,
					},
					["position"] = {
						["preset"] = "TOPLEFT",
						["attach"] = "TOPLEFT",
						["layout"] = "doubleRow",
						["uf"] = "ElvUI",
						["anchor"] = "TOPRIGHT",
					},
					["manualPos"] = {
						["raidCDBar"] = {
							["y"] = 591.23329986069,
							["x"] = 333.03381450311,
						},
						["interruptBar"] = {
							["y"] = 481.1890034957323,
							["x"] = 136.9444665012543,
						},
					},
				},
				["noneZoneSetting"] = "party",
				["arena"] = {
					["position"] = {
						["attach"] = "TOPLEFT",
						["preset"] = "TOPLEFT",
						["uf"] = "ElvUI",
						["anchor"] = "TOPRIGHT",
					},
					["general"] = {
						["showPlayer"] = true,
					},
				},
				["visibility"] = {
					["scenario"] = true,
					["finder"] = true,
					["none"] = true,
				},
				["scenarioZoneSetting"] = "party",
			},
		},
	},
}
