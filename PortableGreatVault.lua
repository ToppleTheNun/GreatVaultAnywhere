PortableGreatVault = LibStub("AceAddon-3.0"):NewAddon("PortableGreatVault", "AceConsole-3.0")

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
            LoadAddOn("Blizzard_WeeklyRewards")
            WeeklyRewardsFrame:Show()
        end,
        OnTooltipShow = function(tooltip)
            tooltip:SetText("PortableGreatVault")
            tooltip:AddLine("Open the Great Vault", 1, 1, 1)
            tooltip:Show()
        end
    })
    self.minimap.icon = LibStub("LibDBIcon-1.0")
    self.minimap.icon:Register("PortableGreatVault", self.minimap.icon_data, self.db.profile.minimap)
end

function PortableGreatVault:OnInitialize()    
    self.db = LibStub("AceDB-3.0"):New("PortableGreatVaultDB", defaults, true)
    self:ConstructMinimapIcon()
end
