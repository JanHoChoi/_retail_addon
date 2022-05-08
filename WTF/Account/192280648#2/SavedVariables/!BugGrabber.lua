
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 3881,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\AddOnSkins\\Core\\API.lua:385: attempt to index local 'Button' (a nil value)",
			["time"] = "2022/05/05 21:45:47",
			["stack"] = "[string \"@Interface\\AddOns\\AddOnSkins\\Core\\API.lua\"]:385: in function `SkinButton'\n[string \"@Interface\\AddOns\\AddOnSkins\\Skins\\AddOns\\Altoholic-9.2.001.lua\"]:36: in function <...terface\\AddOns\\AddOnSkins\\Skins\\AddOns\\Altoholic.lua:26>\n[string \"@Interface\\AddOns\\AddOnSkins\\Core\\Core.lua\"]:215: in function <Interface\\AddOns\\AddOnSkins\\Core\\Core.lua:215>\n[string \"=[C]\"]: in function `xpcall'\n[string \"@Interface\\AddOns\\AddOnSkins\\Core\\Core.lua\"]:215: in function `CallSkin'\n[string \"@Interface\\AddOns\\AddOnSkins\\Core\\Core.lua\"]:165: in function `?'\n[string \"@Interface\\AddOns\\LibSharedMedia-3.0-8020003\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua\"]:119: in function <...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:119>\n[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\LibSharedMedia-3.0-8020003\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua\"]:29: in function <...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n[string \"@Interface\\AddOns\\LibSharedMedia-3.0-8020003\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua\"]:64: in function `Fire'\n[string \"@Interface\\AddOns\\ElvUI\\Libraries\\Core\\Ace\\AceEvent-3.0\\AceEvent-3.0-4.lua\"]:120: in function <...vUI\\Libraries\\Core\\Ace\\AceEvent-3.0\\AceEvent-3.0.lua:119>\n[string \"=[C]\"]: in function `LoadAddOn'\n[string \"*:OnShow\"]:2: in function <[string \"*:OnShow\"]:1>\n[string \"=[C]\"]: in function `Show'\n[string \"@Interface\\AddOns\\AddonFactory\\Templates\\AuctionHouseUI\\Main.lua\"]:86: in function `ToggleUI'\n[string \"*:OnClick\"]:2: in function <[string \"*:OnClick\"]:1>\n[string \"=[C]\"]: ?",
			["session"] = 3870,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] 插件 'WeakAuras' 尝试调用保护功能 '<unnamed>:ClearAllPoints()'。",
			["time"] = "2022/05/08 20:23:33",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `ClearAllPoints'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua\"]:45: in function `SetAnchorPoint'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua\"]:1078: in function `DoPositionChildrenPerFrame'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua\"]:1194: in function `DoPositionChildren'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua\"]:1056: in function `PositionChildren'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua\"]:1037: in function `SortUpdatedChildren'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua\"]:842: in function `Resume'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.16.lua\"]:3906: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3862>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.16.lua\"]:4000: in function `UpdatedTriggerState'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:752: in function `ScanEventsInternal'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:708: in function `ScanEvents'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:2386: in function `CheckItemSlotCooldowns'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:1970: in function <Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:1946>",
			["session"] = 3873,
			["counter"] = 2,
		}, -- [2]
		{
			["message"] = "[string \"Error in: 冰龙吐息/龙喷计时':'custo...\"]:5: attempt to perform arithmetic on field 'startTime' (a nil value)",
			["time"] = "2022/05/08 20:23:33",
			["stack"] = "[string \"=[C]\"]: in function `xpcall'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.16.lua\"]:4042: in function `RunCustomTextFunc'\n[string \"@Interface\\AddOns\\WeakAuras\\SubRegionTypes\\SubText.lua\"]:288: in function `?'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua\"]:34: in function `Notify'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.16.lua\"]:3808: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3805>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.16.lua\"]:3900: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3862>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.16.lua\"]:3983: in function `UpdatedTriggerState'\n[string \"@Interface\\AddOns\\WeakAuras\\BuffTrigger2.lua\"]:1588: in function <Interface\\AddOns\\WeakAuras\\BuffTrigger2.lua:1580>\n[string \"@Interface\\AddOns\\WeakAuras\\BuffTrigger2.lua\"]:1924: in function <Interface\\AddOns\\WeakAuras\\BuffTrigger2.lua:1917>",
			["session"] = 3873,
			["counter"] = 2,
		}, -- [3]
		{
			["message"] = "TexCoord out of range",
			["time"] = "2022/05/08 21:36:17",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n PixelSnapDisabled = true\n}\n(*temporary) = 0.257813\n(*temporary) = 29326.057171\n(*temporary) = 0.367188\n(*temporary) = 29326.057171\n(*temporary) = 0.257813\n(*temporary) = 0.062500\n(*temporary) = 0.367188\n(*temporary) = 0.062500\n",
			["stack"] = "[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `SetTexCoord'\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:200: in function <Interface\\SharedXML\\Backdrop.lua:199>\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:232: in function `SetupTextureCoordinates'\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:176: in function <Interface\\SharedXML\\Backdrop.lua:174>",
			["session"] = 3878,
			["counter"] = 3,
		}, -- [4]
	},
}
