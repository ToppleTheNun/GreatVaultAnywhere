-- Setup function container
PortableGreatVault.F = {}

-- Get localization
local L = LibStub("AceLocale-3.0"):GetLocale("PortableGreatVault", true)

local function filterActivitiesByType(activities, type)
    local filteredActivities = {}
    for _, activityInfo in ipairs(activities) do
        if activityInfo.type == type then
            table.insert(filteredActivities, activityInfo)
        end
    end
    return filteredActivities
end


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

local function clampMythicPlusLevel(level)
    if level < 5 then
        return 2
    end
    if level < 7 then
        return 5
    end
    if level < 10 then
        return 7
    end
    if level < 15 then
        return 10
    end
    if level < 20 then
        return 15
    end
    return 20
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
            L["mythicPlusSuccessDifficultyColor"][clampMythicPlusLevel(activity.level)],
            activity.level,
            L["mythicPlusSuccessDifficultyColor"][clampMythicPlusLevel(activity.level)],
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

function PortableGreatVault:addTooltipText(tooltip)
    -- get all activities from WoW
    local activities = C_WeeklyRewards.GetActivities()

    local raidActivities = filterActivitiesByType(activities, Enum.WeeklyRewardChestThresholdType.Raid)
    local mythicPlusActivities = filterActivitiesByType(activities, Enum.WeeklyRewardChestThresholdType.MythicPlus)
    local pvpActivities = filterActivitiesByType(activities, Enum.WeeklyRewardChestThresholdType.RankedPvP)

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
