import LibDataBroker from "@wowts/lib_data_broker-1.1";
import LibDBIcon from "@wowts/lib_d_b_icon-1.0";
import { UIGameTooltip } from "@wowts/wow-mock";

import PortableGreatVault from "./PortableGreatVault";

// declare new module for using LibDataBroker
const PortableGreatVaultDataBrokerBase = PortableGreatVault.NewModule(
  `${PortableGreatVault.GetName()}DataBroker`
);

// define functions to use with LibDataBroker
const handleOnClick = function (fr, button: string) {};

const handleOnTooltipShow = function (tooltip: UIGameTooltip) {
  tooltip.SetText(PortableGreatVault.GetName(), 1, 1, 1);
  tooltip.AddLine("Open the Great Vault", 1, 1, 1);
};

// Create the overrides for the module
class GreatVaultAnywhereDataBrokerClass extends PortableGreatVaultDataBrokerBase {
  broker = undefined;

  OnInitialize() {
    if (LibDataBroker) {
      const broker = {
        type: "data source",
        text: "",
        icon: "Interface\\Icons\\INV_Misc_Note_03",
        OnClick: handleOnClick,
        OnTooltipShow: handleOnTooltipShow,
      };
      this.broker = LibDataBroker.NewDataObject(
        PortableGreatVault.GetName(),
        broker
      );
      if (LibDBIcon) {
        LibDBIcon.Register(
          PortableGreatVault.GetName(),
          this.broker,
          PortableGreatVault.db.profile.minimap
        );
      }
    }

    if (this.broker) {
      this.UpdateIcon();
    }
  }

  UpdateIcon() {
    if (LibDBIcon && this.broker) {
      const minimap = PortableGreatVault.db.profile.minimap;
      LibDBIcon.Refresh(PortableGreatVault.GetName(), minimap);
      if (minimap && minimap.hide) {
        LibDBIcon.Hide(PortableGreatVault.GetName());
      } else {
        LibDBIcon.Show(PortableGreatVault.GetName());
      }
    }
  }
}

// instantiate
const GreatVaultAnywhereDataBroker = new GreatVaultAnywhereDataBrokerClass();
export default GreatVaultAnywhereDataBroker;
