import { NewAddon } from "@wowts/tsaddon";
import aceConsole from "@wowts/ace_console-3.0";
import AceDB, { AceDatabase } from "@wowts/ace_db-3.0";

// DB options
export interface PortableGreatVaultDb {
  profile: {
    minimap: {
      hide: boolean;
    };
  };
}

// Declare the name of the addon as a constant
const addonName = "PortableGreatVault";

// Create the base of the addon
const PortableGreatVaultBase = NewAddon(addonName, aceConsole);

// Create the overrides for the addon
class PortableGreatVaultClass extends PortableGreatVaultBase {
  db: AceDatabase & PortableGreatVaultDb;

  OnInitialize() {
    this.db = AceDB.New(addonName, {
      profile: { minimap: { hide: false } },
    });
  }
}

// Create the actual instance of the addon
const PortableGreatVault = new PortableGreatVaultClass();
export default PortableGreatVault;
