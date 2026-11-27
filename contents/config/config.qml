import QtQuick
import org.kde.plasma.configuration
import org.kde.plasma.plasmoid
import "../ui/i18n.js" as Tr

ConfigModel {
    ConfigCategory {
        name: Tr.t("appearance", Plasmoid.configuration.language)
        icon: "preferences-desktop-color"
        source: "ConfigAppearance.qml"
    }
    ConfigCategory {
        name: Tr.t("general", Plasmoid.configuration.language)
        icon: "configure"
        source: "ConfigGeneral.qml"
    }
}
