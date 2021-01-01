PortableGreatVault = LibStub("AceAddon-3.0"):NewAddon("PortableGreatVault", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("PortableGreatVault", true)

local defaults = {
    profile = {
        minimap = {
            hide = false
        }
    }
}

local function convertCompletedActivityToItemLevel(activity)
    local itemLink = C_WeeklyRewards.GetExampleRewardItemHyperlinks(activity.id)
    local itemLevel;
    if itemLink then
        itemLevel = GetDetailedItemLevelInfo(itemLink);
    end
    if not itemLevel then
        return ""
    end
    return tostring(itemLevel)
end

local function getDisplayForSuccessfulRaid(activity)
    return string.format(
            L["raidSuccess"],
            L["raidSuccessDifficultyColor"][activity.level],
            L["raidSuccessDifficultyName"][activity.level],
            L["raidSuccessDifficultyColor"][activity.level],
            convertCompletedActivityToItemLevel(activity)
    )
end

local function getDisplayForIncompleteRaid(activity)
    return string.format(
            L["raidIncomplete"],
            activity.progress,
            activity.threshold
    )
end

local function getDisplayForSuccessfulMythicPlus(activity)
    return string.format(
            L["mythicPlusSuccess"],
            activity.level,
            convertCompletedActivityToItemLevel(activity)
    )
end

local function getDisplayForIncompleteMythicPlus(activity)
    return string.format(
            L["mythicPlusIncomplete"],
            activity.progress,
            activity.threshold
    )
end

local function getDisplayForSuccessfulPvP(activity)
    return string.format(
            L["pvpSuccess"],
            activity.level,
            convertCompletedActivityToItemLevel(activity)
    )
end

local function getDisplayForIncompletePvP(activity)
    return string.format(
            L["pvpIncomplete"],
            activity.progress,
            activity.threshold
    )
end

local function getDisplayForRaid(activity)
    if activity.progress >= activity.threshold then
        return getDisplayForSuccessfulRaid(activity)
    else
        return getDisplayForIncompleteRaid(activity)
    end
end

local function getDisplayForMythicPlus(activity)
    if activity.progress >= activity.threshold then
        return getDisplayForSuccessfulMythicPlus(activity)
    else
        return getDisplayForIncompleteMythicPlus(activity)
    end
end

local function getDisplayForPvP(activity)
    if activity.progress >= activity.threshold then
        return getDisplayForSuccessfulPvP(activity)
    else
        return getDisplayForIncompletePvP(activity)
    end
end

local function getTooltipForRaids(activities)
    return string.format(
            L["raidRewards"],
            getDisplayForRaid(activities[1]),
            getDisplayForRaid(activities[2]),
            getDisplayForRaid(activities[3])
    )
end

local function getTooltipForMythicPlus(activities)
    return string.format(
            L["mythicPlusRewards"],
            getDisplayForMythicPlus(activities[1]),
            getDisplayForMythicPlus(activities[2]),
            getDisplayForMythicPlus(activities[3])
    )
end

local function getTooltipForPvP(activities)
    return string.format(
            L["pvpRewards"],
            getDisplayForPvP(activities[1]),
            getDisplayForPvP(activities[2]),
            getDisplayForPvP(activities[3])
    )
end

local function addTooltipText(tooltip)
    -- get all activities from WoW
    local activities = C_WeeklyRewards.GetActivities()

    local raidActivities = {}
    local mythicPlusActivities = {}
    local pvpActivities = {}

    for _, activityInfo in ipairs(activities) do
        if activityInfo.type == Enum.WeeklyRewardChestThresholdType.Raid then
            table.insert(raidActivities, activityInfo)
        end
        if activityInfo.type == Enum.WeeklyRewardChestThresholdType.MythicPlus then
            table.insert(mythicPlusActivities, activityInfo)
        end
        if activityInfo.type == Enum.WeeklyRewardChestThresholdType.RankedPvP then
            table.insert(pvpActivities, activityInfo)
        end
    end

    tooltip:SetText(L["addonName"])
    tooltip:AddLine(L["clickToOpen"], 1, 1, 1)
    tooltip:AddLine(" ")
    tooltip:AddDoubleLine(L["raidHeader"], getTooltipForRaids(raidActivities))
    tooltip:AddLine(" ")
    tooltip:AddDoubleLine(L["mythicPlusHeader"], getTooltipForMythicPlus(mythicPlusActivities))
    tooltip:AddLine(" ")
    tooltip:AddDoubleLine(L["pvpHeader"], getTooltipForPvP(pvpActivities))

    tooltip:Show()
end

function PortableGreatVault:ConstructMinimapIcon()
    self.minimap = {}
    self.minimap.icon_data = LibStub("LibDataBroker-1.1"):NewDataObject("PortableGreatVault", {
        type = "data source",
        text = "PortableGreatVault",
        icon = "Interface\\Icons\\INV_Misc_Note_03",
        OnClick = function(self, button)
            WeeklyRewardsFrame:Show()
        end,
        OnTooltipShow = function(tooltip)
            addTooltipText(tooltip)
        end
    })
    self.minimap.icon = LibStub("LibDBIcon-1.0")
    self.minimap.icon:Register("PortableGreatVault", self.minimap.icon_data, self.db.profile.minimap)
end

function PortableGreatVault:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("PortableGreatVaultDB", defaults, true)
    self:ConstructMinimapIcon()
    LoadAddOn("Blizzard_WeeklyRewards")
end
