GreatVaultAnywhere = LibStub("AceAddon-3.0"):NewAddon("GreatVaultAnywhere", "AceConsole-3.0")

local defaults = {
    profile = {
        minimap = {
            hide = false
        }
    }
}

function GreatVaultAnywhere:ConstructMinimapIcon()
    self.minimap = {}
    self.minimap.icon_data = LibStub("LibDataBroker-1.1"):NewDataObject("GreatVaultAnywhere", {
        type = "data source",
        text = "GreatVaultAnywhere",
        icon = "Interface\\Icons\\INV_Misc_Note_03",
        OnClick = function(self, button)
            LoadAddOn("Blizzard_WeeklyRewards")
            WeeklyRewardsFrame:Show()
        end,
        OnTooltipShow = function(tooltip)
            tooltip:SetText("GreatVaultAnywhere")
            tooltip:AddLine("Open the Great Vault", 1, 1, 1)
            tooltip:Show()
        end
    })
    self.minimap.icon = LibStub("LibDBIcon-1.0")
    self.minimap.icon:Register("GreatVaultAnywhere", self.minimap.icon_data, self.db.profile.minimap)
end

function GreatVaultAnywhere:OnInitialize()    
    self.db = LibStub("AceDB-3.0"):New("GreatVaultAnywhereDB", defaults, true)
    self:ConstructMinimapIcon()
end
