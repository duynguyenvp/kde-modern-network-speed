import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import "i18n.js" as Tr

KCM.SimpleKCM {
    id: generalPage

    property string cfg_language
    property string cfg_speedUnit
    property alias cfg_updateInterval: updateIntervalSpin.value

    readonly property var languageValues: ["system", "en", "vi"]
    readonly property var unitValues: ["decimal_bytes", "binary_bytes", "bits"]

    Kirigami.FormLayout {
        QQC2.ComboBox {
            id: languageCombo
            Kirigami.FormData.label: Tr.t("language", cfg_language)
            Layout.preferredWidth: Kirigami.Units.gridUnit * 16
            model: [
                Tr.t("languageSystem", cfg_language),
                Tr.t("languageEn", cfg_language),
                Tr.t("languageVi", cfg_language)
            ]
            currentIndex: Math.max(0, generalPage.languageValues.indexOf(cfg_language))
            onActivated: (idx) => {
                cfg_language = generalPage.languageValues[idx];
            }
        }

        QQC2.ComboBox {
            id: speedUnitCombo
            Kirigami.FormData.label: Tr.t("speedUnit", cfg_language)
            Layout.preferredWidth: Kirigami.Units.gridUnit * 16
            model: [
                Tr.t("unitDecimalBytes", cfg_language),
                Tr.t("unitBinaryBytes", cfg_language),
                Tr.t("unitBits", cfg_language)
            ]
            currentIndex: Math.max(0, generalPage.unitValues.indexOf(cfg_speedUnit))
            onActivated: (idx) => {
                cfg_speedUnit = generalPage.unitValues[idx];
            }
        }

        QQC2.SpinBox {
            id: updateIntervalSpin
            Kirigami.FormData.label: Tr.t("updateInterval", cfg_language)
            from: 500
            to: 10000
            stepSize: 250
            editable: true
            textFromValue: function(value) {
                return value + Tr.t("msSuffix", cfg_language);
            }
            valueFromText: function(text) {
                return parseInt(text, 10) || 1000;
            }
        }
    }
}
