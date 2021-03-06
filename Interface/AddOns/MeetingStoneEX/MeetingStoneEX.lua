BuildEnv(...)

debug = IsAddOnLoaded('!!!!!tdDevTools') and print or nop

Addon = LibStub('AceAddon-3.0'):GetAddon('MeetingStone')
-- :NewAddon('MeetingStoneEX', 'AceEvent-3.0', 'LibModule-1.0', 'LibClass-2.0', 'AceHook-3.0')

GUI = LibStub('NetEaseGUI-2.0')

local BrowsePanel = Addon:GetModule('BrowsePanel')
local MainPanel = Addon:GetModule('MainPanel')

if not MEETINGSTONE_UI_DB.IGNORE_LIST then
    MEETINGSTONE_UI_DB.IGNORE_LIST = {}
end

if MEETINGSTONE_UI_DB.filters then
    for k,v in pairs(MEETINGSTONE_UI_DB.filters) do
        table.insert(MEETINGSTONE_UI_DB.IGNORE_LIST,{
            leader = k,
            time = v,
            dep = '旧数据结构转化',
        })
    end
    MEETINGSTONE_UI_DB.filters = nil
end

for i,v in ipairs(MEETINGSTONE_UI_DB.IGNORE_LIST) do
    if v.leader == nil then
        table.remove(MEETINGSTONE_UI_DB.IGNORE_LIST,i)
    end
    v.titles = nil
    if v.time == true then
        v.time = ''
    end
end

table.sort(MEETINGSTONE_UI_DB.IGNORE_LIST,function (a,b)
        if a.time == b.time then
            return a.leader < b.leader
        end
        if type(a.time) == type(b.time) and type(a.time) == 'string' then
            return a.time > b.time
        end
        return type(a.time) == 'string'
    end)

BrowsePanel.IgnoreWithTitle = {}
BrowsePanel.IgnoreWithLeader = {}
for i,v in ipairs(MEETINGSTONE_UI_DB.IGNORE_LIST) do
    BrowsePanel.IgnoreWithLeader[v.leader] = true
end
if MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG == nil then
    MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG = true
end

--添加过滤功能
BrowsePanel.ActivityList:RegisterFilter(function(activity, ...)
            local leader = activity:GetLeader()
            local displayType = activity:GetDisplayType()
            if leader == nil then
                return false
            end
            local data = C_LFGList.GetSearchResultMemberCounts(activity:GetID())
            if data and displayType == Enum.LfgListDisplayType.RoleEnumerate then
                if MEETINGSTONE_UI_DB.FILTER_TANK and  data.TANK > 0 then
                    return false
                end
                if MEETINGSTONE_UI_DB.FILTER_HEALTH and data.HEALER > 0 then
                    return false
                end
                if MEETINGSTONE_UI_DB.FILTER_DAMAGE and data.DAMAGER > 2 then
                    return false
                end
            end
            local title = activity:GetSummary()
          
            if BrowsePanel.IgnoreWithTitle[title] then
                if not BrowsePanel.IgnoreWithLeader[leader] then
                    BrowsePanel.IgnoreWithLeader[leader] = true
                    table.insert(MEETINGSTONE_UI_DB.IGNORE_LIST,1,{
                            leader = leader,
                            time = date('%Y-%m-%d %H:%M',time()),
                            dep = '由指定标题传染屏蔽',
                        })
                    if MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG then
                        print('标题 '..title..' 传染屏蔽 '..leader)
                    end
                end
                return false
            end
            if BrowsePanel.IgnoreWithLeader[leader] then
                if not BrowsePanel.IgnoreWithTitle[title] then
                    BrowsePanel.IgnoreWithTitle[title] = true
                    if MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG then
                        print('账号 '..leader..' 传染屏蔽 '..title)
                    end
                end
                return false
            end

            if BrowsePanel.ActivityDropdown:GetText() == '地下城' and BrowsePanel.MDSearchs then
                if BrowsePanel.MDSearchs[activity:GetName()] then
                    return activity:Match(...)
                else
                    return false
                end
            end
--改动结束
            return activity:Match(...)
        end)

function BrowsePanel:CreateExSearchPanel()
    -- body
    local ExSearchPanel = CreateFrame('Frame', nil, self, 'SimplePanelTemplate') do
        GUI:Embed(ExSearchPanel, 'Refresh')
        ExSearchPanel:SetSize(250, 320)
        ExSearchPanel:SetPoint('TOPLEFT', MainPanel, 'TOPRIGHT', -2, -30)
        ExSearchPanel:SetFrameLevel(self.ActivityList:GetFrameLevel()+5)
        ExSearchPanel:EnableMouse(true)

        local closeButton = CreateFrame('Button', nil, ExSearchPanel, 'UIPanelCloseButton') do
            closeButton:SetPoint('TOPRIGHT', 0, -1)
        end

        local Label = ExSearchPanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal') do
            Label:SetPoint('TOPLEFT', 5, -10)
            Label:SetText('大秘境-条件过滤')
        end
    end
    self.ExSearchPanel = ExSearchPanel
    ExSearchPanel:SetShown(false)


    local names = {
        '伤逝剧场'
        ,'凋魂之殇'
        ,'塞兹仙林的迷雾'
        ,'彼界'
        ,'晋升高塔'
        ,'赎罪大厅'
        ,'赤红深渊'
        ,'通灵战潮'
        ,'塔扎维什：琳彩天街'
        ,'塔扎维什：索·莉亚的宏图'
    }

    local function RefreshExSearch()
        local item = self.ActivityDropdown:GetItem()
        if not self.inUpdateFilters and item and item.categoryId then
            
            Profile:SetFilters(item.categoryId, self:GetExSearchs())
        end
    end

    self.MD = {}

    for i,v in ipairs(names) do
        local Box = Addon:GetClass('CheckBox'):New(ExSearchPanel.Inset)
        Box.Check:SetText(v)
        -- Box:SetCallback('OnChanged', RefreshExSearch)
        Box.dungeonName = v
        if i == 1 then
            Box:SetPoint('TOPLEFT', 10, -10)
            Box:SetPoint('TOPRIGHT', -10, -10)
        else
            Box:SetPoint('TOPLEFT', self.MD[i-1], 'BOTTOMLEFT')
            Box:SetPoint('TOPRIGHT', self.MD[i-1], 'BOTTOMRIGHT')
        end

        table.insert(self.MD, Box)
    end

    self.MDSearchs = nil
    local ResetFilterButton = CreateFrame('Button', nil, ExSearchPanel, 'UIPanelButtonTemplate') do
        ResetFilterButton:SetSize(80, 22)
        ResetFilterButton:SetPoint('BOTTOMRIGHT', ExSearchPanel, 'BOTTOM', 0, 3)
        ResetFilterButton:SetText('重置')
        ResetFilterButton:SetScript('OnClick', function()
            for i, box in ipairs(self.MD) do
                box:Clear()
            end
            self.MDSearchs = nil
        end)
    end

    local RefreshFilterButton = CreateFrame('Button', nil, ExSearchPanel, 'UIPanelButtonTemplate') do
        RefreshFilterButton:SetSize(80, 22)
        RefreshFilterButton:SetPoint('BOTTOMLEFT', ExSearchPanel, 'BOTTOM', 0, 3)
        RefreshFilterButton:SetText('确认')
        RefreshFilterButton:SetScript('OnClick', function()
            self.MDSearchs = nil
            for i, box in ipairs(self.MD) do
                if box.Check:GetChecked() then
                    if not self.MDSearchs then
                        self.MDSearchs = {}
                    end
                    self.MDSearchs[box.dungeonName..'（史诗钥石）'] = true
                end
            end
            self:DoSearch()
        end)
    end

end

function CreateMemberFilter(self,MainPanel,x,text,DB_Name)
    if MEETINGSTONE_UI_DB[DB_Name] == nil then
        MEETINGSTONE_UI_DB[DB_Name] = false
    end
    local TCount = CreateFrame('CheckButton', nil, self) do
        TCount:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
        TCount:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
        TCount:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]])
        TCount:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
        TCount:SetDisabledCheckedTexture([[Interface\Buttons\UI-CheckBox-Check-Disabled]])
        TCount:SetSize(22, 22)
        TCount:SetPoint('BOTTOMLEFT',MainPanel,x, 3)
        TCount:SetFontString(TCount:CreateFontString(nil, 'ARTWORK'))
        TCount:GetFontString():SetPoint('LEFT', TCount, 'RIGHT', 2, 0)
        TCount:SetNormalFontObject('GameFontHighlightSmall')
        TCount:SetHighlightFontObject('GameFontNormalSmall')
        TCount:SetDisabledFontObject('GameFontDisableSmall')
        TCount:SetScript('OnClick', function()
            MEETINGSTONE_UI_DB[DB_Name] = not MEETINGSTONE_UI_DB[DB_Name]
            self.ActivityList:Refresh()
        end)
        TCount:SetText(text)
        TCount:SetChecked(MEETINGSTONE_UI_DB[DB_Name])
    end
end

function BrowsePanel:CreateExSearchButton( )
    
    self.RefreshButton:SetPoint('TOPRIGHT', MainPanel, 'TOPRIGHT', -180, -38)
    local ExSearchButton = CreateFrame('Button', nil, self, 'UIMenuButtonStretchTemplate') do
        GUI:Embed(ExSearchButton, 'Tooltip')
        ExSearchButton:SetTooltipAnchor('ANCHOR_RIGHT')
        ExSearchButton:SetTooltip('大秘境')
        ExSearchButton:SetSize(83, 31)
        ExSearchButton:SetPoint('LEFT', self.RefreshButton, 'RIGHT', 0, 0)
        ExSearchButton:SetText('大秘境')
        ExSearchButton:SetNormalFontObject('GameFontNormal')
        ExSearchButton:SetHighlightFontObject('GameFontHighlight')
        ExSearchButton:SetDisabledFontObject('GameFontDisable')

        ExSearchButton:SetScript('OnClick', function()
            self:SwitchPanel(self.ExSearchPanel)
        end)
    end
    self.ExSearchButton = ExSearchButton
    self.AdvButton:SetPoint('LEFT', ExSearchButton, 'RIGHT', 0, 0)
    self.AdvButton:SetScript('OnClick', function()
        self:SwitchPanel(self.AdvFilterPanel)
    end)

    local ShowLogButton
    ShowLogButton = CreateFrame('Button', nil, self) do
        ShowLogButton:SetNormalFontObject('GameFontNormalSmall')
        ShowLogButton:SetHighlightFontObject('GameFontHighlightSmall')
        ShowLogButton:SetSize(70, 22)
        ShowLogButton:SetPoint('BOTTOMRIGHT', MainPanel, -200, 3)
        if MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG then
            ShowLogButton:SetText('隐藏屏蔽提示')
        else
            ShowLogButton:SetText('显示屏蔽提示')
        end
        ShowLogButton:RegisterForClicks('anyUp')
        ShowLogButton:SetScript('OnClick', function()
            MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG = not MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG
            if MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG then
                ShowLogButton:SetText('隐藏屏蔽提示')
            else
                ShowLogButton:SetText('显示屏蔽提示')
            end
        end)
    end

    CreateMemberFilter(self,MainPanel,70,'坦克','FILTER_TANK')
    CreateMemberFilter(self,MainPanel,130,'治疗','FILTER_HEALTH')
    CreateMemberFilter(self,MainPanel,190,'输出','FILTER_DAMAGE')
    -- local TCount = Addon:GetClass('CheckBox'):New(self)
    -- TCount.Check:SetText('T')
    -- TCount:SetPoint('BOTTOMLEFT',MainPanel,200, 3)
    -- TCount:SetCallback('OnChanged', function (... )
    --     print(...)
    --     MEETINGSTONE_UI_DB.FILTER_TANK = not MEETINGSTONE_UI_DB.FILTER_TANK
    -- end)

    -- self.ActivityList:SetCallback('OnItemDoubleClick',function (_1,_2,activity)
        -- local _, tank, healer, dps = GetLFGRoles();
        -- C_LFGList.ApplyToGroup(activity:GetID(),tank,healer,dps)
    -- end)
end

--添加大秘境过滤功能
function BrowsePanel:EX_INIT()
    self:CreateExSearchPanel()
    self:CreateExSearchButton()
end


function BrowsePanel:ToggleActivityMenu(anchor, activity)
    local usable, reason = self:CheckSignUpStatus(activity)

    GUI:ToggleMenu(anchor, {
        {text = activity:GetName(), isTitle = true, notCheckable = true}, {
            text = '申请加入',
            func = function()
                self:SignUp(activity)
            end,
            disabled = not usable or activity:IsDelisted() or activity:IsApplication(),
            tooltipTitle = not (activity:IsDelisted() or activity:IsApplication()) and '申请加入',
            tooltipText = reason,
            tooltipWhileDisabled = true,
            tooltipOnButton = true,
        }, {
            text = WHISPER_LEADER,
            func = function()
                ChatFrame_SendTell(activity:GetLeader())
            end,
            disabled = not activity:GetLeader(), -- or not activity:IsApplication(),
            tooltipTitle = not activity:IsApplication() and WHISPER,
            tooltipText = not activity:IsApplication() and LFG_LIST_MUST_SIGN_UP_TO_WHISPER,
            tooltipOnButton = true,
            tooltipWhileDisabled = true,
        }, {
            text = LFG_LIST_REPORT_GROUP_FOR,
            hasArrow = true,
            menuTable = {
                {
                    text = '不当的说明',
                    func = function()
                        C_LFGList.ReportSearchResult(activity:GetID(),
                                                     activity:IsMeetingStone() and 'lfglistcomment' or 'lfglistname')
                    end,
                }, {
                    text = LFG_LIST_BAD_DESCRIPTION,
                    func = function()
                        C_LFGList.ReportSearchResult(activity:GetID(), 'lfglistcomment')
                    end,
                    disabled = activity:IsMeetingStone() or not activity:GetComment(),
                }, {
                    text = LFG_LIST_BAD_VOICE_CHAT_COMMENT,
                    func = function()
                        C_LFGList.ReportSearchResult(activity:GetID(), 'lfglistvoicechat')
                    end,
                    disabled = not activity:GetVoiceChat(),
                }, {
                    text = LFG_LIST_BAD_LEADER_NAME,
                    func = function()
                        C_LFGList.ReportSearchResult(activity:GetID(), 'badplayername')
                    end,
                    disabled = not activity:GetLeader(),
                },
            },
        },
        {
            text = '拉黑队长名',
            func = function()
               local name = C_LFGList.GetSearchResultInfo(activity:GetID()).leaderName
               table.insert(MEETINGSTONE_UI_BLACKLISTEDLEADERS,name)
               print("已加入"..name.."到黑名单")
               BrowsePanel:DoSearch()
            end,
        }, -- {
        --     text = '加入关键字过滤',
        --     func = function()
        --         SettingPanel:AddSpamWord(activity:GetSummary() or activity:GetComment())
        --     end,
        -- },
        {
            text = '屏蔽同标题玩家',
            func = function()
                local title = activity:GetSummary() or activity:GetComment()
                if MEETINGSTONE_UI_DB.IGNORE_TIPS_LOG then
                    print('添加过滤：',title)
                end
                BrowsePanel.IgnoreWithTitle[title] = true
                BrowsePanel.ActivityList:Refresh()
            end,
        },
        {text = CANCEL},
    }, 'cursor')
end

function BrowsePanel:GetExSearchs()
    local filters = {}
    for _, box in ipairs(self.MD) do
        filters[box.dungeonName] = {
            enable = not not box.Check:GetChecked(),
        }
    end
    return filters
end

function BrowsePanel:SwitchPanel( panel)
    local list = {
        self.ExSearchPanel,
        self.AdvFilterPanel,
    }
    for i,v in ipairs(list) do
        if v == panel then
            v:SetShown(not v:IsShown())
        else
            v:SetShown(false)
        end

    end
end
BrowsePanel:EX_INIT()