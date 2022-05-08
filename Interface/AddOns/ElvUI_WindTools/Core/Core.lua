local W, F, E, L, V, P, G = unpack(select(2, ...))

local format = format
local pairs = pairs
local pcall = pcall
local print = print
local strsub = strsub
local tinsert = tinsert
local tonumber = tonumber

local GetLocale = GetLocale
local GetMaxLevelForPlayerExpansion = GetMaxLevelForPlayerExpansion
local InCombatLockdown = InCombatLockdown

local ACCEPT = _G.ACCEPT
local CANCEL = _G.CANCEL

-- 一些常量
W.Title = L["WindTools"]
W.Locale = GetLocale()
W.ChineseLocale = strsub(W.Locale, 0, 2) == "zh"
W.MaxLevelForPlayerExpansion = GetMaxLevelForPlayerExpansion()
W.SupportElvUIVersion = 12.75

-- 模块部分
W.RegisteredModules = {}

-- 更新记录
W.Changelog = {}

-- 快捷键注册
_G.BINDING_CATEGORY_ELVUI_WINDTOOLS = L["WindTools"]
for i = 1, 5 do
    _G["BINDING_HEADER_WTEXTRAITEMSBAR" .. i] =
        F.CreateColorString(L["Extra Items Bar"] .. " " .. i, E.db.general.valuecolor)
    for j = 1, 12 do
        _G[format("BINDING_NAME_CLICK WTExtraItemsBar%dButton%d:LeftButton", i, j)] = L["Button"] .. " " .. j
    end
end

_G.BINDING_CATEGORY_ELVUI_WINDTOOLS_EXTRA = L["WindTools"] .. " - " .. L["Extra"]
_G.BINDING_HEADER_WTEXTRABUTTONS = L["Extra Buttons"]
_G["BINDING_NAME_CLICK WTExtraBindingButtonLogout:LeftButton"] = L["Logout"]
_G["BINDING_NAME_CLICK WTExtraBindingButtonLeaveGroup:LeftButton"] = L["Leave Party"]
_G["BINDING_NAME_CLICK WTExtraBindingButtonLeavePartyIfSoloing:LeftButton"] = L["Leave Party if soloing"]

--[[
    注册 WindTools 模块
    @param {string} name 模块名
]]
function W:RegisterModule(name)
    if not name then
        F.DebugMessage(W, "注册模块名为空")
        return
    end
    if self.initialized then
        self:GetModule(name):Initialize()
    else
        tinsert(self.RegisteredModules, name)
    end
end

-- 初始化 WindTools 模块
function W:InitializeModules()
    for _, moduleName in pairs(W.RegisteredModules) do
        local module = self:GetModule(moduleName)
        if module.Initialize then
            pcall(module.Initialize, module)
        end
    end
end

-- 配置更改后的模块更新
function W.UpdateModules()
    for _, moduleName in pairs(W.RegisteredModules) do
        local module = W:GetModule(moduleName)
        if module.ProfileUpdate then
            pcall(module.ProfileUpdate, module)
        end
    end
end

E.PopupDialogs.WINDTOOLS_ELVUI_OUTDATED = {
    text = format(
        "%s\n%s",
        format(L["%s not been loaded since you are using an outdated version of ElvUI."], W.Title),
        format(L["Please upgrade your ElvUI to %2.2f or newer version!"], W.SupportElvUIVersion)
    ),
    button1 = ACCEPT,
    hideOnEscape = 1
}

-- Check ElvUI version, if not matched, show a popup to user
function W:CheckElvUIVersion()
    if W.SupportElvUIVersion > E.version then
        E:StaticPopup_Show("WINDTOOLS_ELVUI_OUTDATED")
        return false
    end
    return true
end

E.PopupDialogs.WINDTOOLS_OPEN_CHANGELOG = {
    text = format(L["Welcome to %s %s!"], L["WindTools"], W.Version),
    button1 = L["Open Changelog"],
    button2 = CANCEL,
    OnAccept = function(self)
        E:ToggleOptionsUI("WindTools,information,changelog")
    end,
    hideOnEscape = 1
}

function W:UpdateScripts(oldVersion, currentVersion)
    if not oldVersion or not currentVersion then
        return
    end

    currentVersion = tonumber(currentVersion)
    oldVersion = tonumber(oldVersion)

    local isFirstLine = true

    local function UpdateMessage(text)
        if isFirstLine then
            isFirstLine = false
            print(
                E:TextGradient(
                    "----------------------------------",
                    0.910,
                    0.314,
                    0.357,
                    0.976,
                    0.835,
                    0.431,
                    0.953,
                    0.925,
                    0.761,
                    0.078,
                    0.694,
                    0.671
                )
            )
            F.Print(format("%s (|cff00a8ff%.2f|r -> |cff00a8ff%.2f|r)", L["Update"], oldVersion, currentVersion))
        end

        print(text)
    end

    local doneIcon = " |TInterface\\RaidFrame\\ReadyCheck-Ready:0|t"

    -- Clear the history of move frames.
    if oldVersion >= 2.27 and oldVersion <= 2.31 then
        E.private.WT.misc.framePositions = {}
        UpdateMessage(L["Move Frames"] .. " - " .. L["Clear History"] .. doneIcon)
    end

    -- Copy old move frames options to its new db.
    if oldVersion <= 2.33 then
        local miscDB = E.private.WT.misc
        miscDB.moveFrames.enable = miscDB.moveBlizzardFrames or miscDB.moveFrames.enable
        miscDB.moveFrames.elvUIBags = miscDB.moveElvUIBags or miscDB.moveFrames.elvUIBags
        miscDB.moveFrames.rememberPositions = miscDB.rememberPositions or miscDB.moveFrames.rememberPositions
        miscDB.moveFrames.framePositions = miscDB.framePositions or miscDB.moveFrames.framePositions

        miscDB.moveBlizzardFrames = nil
        miscDB.moveElvUIBags = nil
        miscDB.rememberPositions = nil
        miscDB.framePositions = nil

        UpdateMessage(L["Move Frames"] .. " - " .. L["Update Database"] .. "..." .. doneIcon)
    end

    if not isFirstLine then
        print(
            E:TextGradient(
                "----------------------------------",
                0.910,
                0.314,
                0.357,
                0.976,
                0.835,
                0.431,
                0.953,
                0.925,
                0.761,
                0.078,
                0.694,
                0.671
            )
        )
    end
end

function W:ForBetaUser()
    local miscDB = E.private.WT.misc
    
    miscDB.moveFrames.enable = miscDB.moveBlizzardFrames or miscDB.moveFrames.enable
    miscDB.moveFrames.elvUIBags = miscDB.moveElvUIBags or miscDB.moveFrames.elvUIBags
    miscDB.moveFrames.rememberPositions = miscDB.rememberPositions or miscDB.moveFrames.rememberPositions
    miscDB.moveFrames.framePositions = miscDB.framePositions or miscDB.moveFrames.framePositions

    miscDB.moveBlizzardFrames = nil
    miscDB.moveElvUIBags = nil
    miscDB.rememberPositions = nil
    miscDB.framePositions = nil
end

-- 检查安装版本, 提示更新记录
function W:CheckInstalledVersion()
    if not InCombatLockdown() then
        W:ForBetaUser()
        if not E.global.WT.Version or E.global.WT.Version ~= W.Version then
            E:StaticPopup_Show("WINDTOOLS_OPEN_CHANGELOG")
            W:UpdateScripts(E.global.WT.Version, W.Version)
            E.global.WT.Version = W.Version
        elseif E.private.WT.core.loginMessage then
            local icon = F.GetIconString(W.Media.Textures.smallLogo, 14)
            print(
                format(
                    icon ..
                        " " ..
                            L["%s %s Loaded."] ..
                                " " .. L["You can send your suggestions or bugs via %s, %s, %s, and the thread in %s."],
                    L["WindTools"],
                    W.Version,
                    L["QQ Group"],
                    L["Discord"],
                    L["Github"],
                    L["NGA.cn"]
                )
            )
        end
    end
end
