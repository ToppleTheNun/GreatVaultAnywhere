local defaults = {
    profile = {
        minimap = {
            hide = false
        }
    }
}

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
            self:addTooltipText(tooltip)
        end
    })
    self.minimap.icon = LibStub("LibDBIcon-1.0")
    self.minimap.icon:Register("PortableGreatVault", self.minimap.icon_data, self.db.profile.minimap)
end

function PortableGreatVault:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("PortableGreatVaultDB", defaults, true)
    self:ConstructMinimapIcon()
    self:RegisterChatCommand("gv", "GvProcessorFunc")
    LoadAddOn("Blizzard_WeeklyRewards")
end

function PortableGreatVault:GvProcessorFunc()
    WeeklyRewardsFrame:Show()
end
