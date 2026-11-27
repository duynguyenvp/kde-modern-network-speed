import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQuickControls
import org.kde.plasma.plasmoid
import "i18n.js" as Tr

KCM.SimpleKCM {
    id: configPage

    property string cfg_uploadFontFamily
    property alias cfg_uploadFontSize: uploadFontSizeSpin.value
    property alias cfg_uploadFontBold: uploadBoldCheck.checked
    property alias cfg_uploadFontItalic: uploadItalicCheck.checked
    property string cfg_uploadColor

    property string cfg_downloadFontFamily
    property alias cfg_downloadFontSize: downloadFontSizeSpin.value
    property alias cfg_downloadFontBold: downloadBoldCheck.checked
    property alias cfg_downloadFontItalic: downloadItalicCheck.checked
    property string cfg_downloadColor

    property string cfg_displayLayout: "two_lines"
    property alias cfg_lineSpacing: lineSpacingSpin.value

    readonly property var layoutValues: ["two_lines", "one_line"]

    readonly property string lang: Plasmoid.configuration.language
    readonly property var fontList: [""].concat(Qt.fontFamilies())

    function fontIndexFor(familyName) {
        if (!familyName || familyName.length === 0) {
            return 0;
        }
        var idx = fontList.indexOf(familyName);
        return idx >= 0 ? idx : 0;
    }

    Kirigami.FormLayout {
        id: formLayout

        // Live Preview
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: Tr.t("previewSection", configPage.lang)
        }

        Rectangle {
            Kirigami.FormData.label: ""
            readonly property bool previewOneLine: cfg_displayLayout === "one_line"
            readonly property real activePreviewWidth: previewOneLine ? previewRow.implicitWidth : previewColumn.implicitWidth
            readonly property real activePreviewHeight: previewOneLine ? previewRow.implicitHeight : previewColumn.implicitHeight
            implicitWidth: Math.max(activePreviewWidth + 32, 160)
            implicitHeight: activePreviewHeight + 20
            radius: Kirigami.Units.smallSpacing
            color: Kirigami.Theme.backgroundColor
            border.color: Kirigami.Theme.disabledTextColor
            border.width: 1

            ColumnLayout {
                id: previewColumn
                anchors.centerIn: parent
                spacing: cfg_lineSpacing
                visible: !parent.previewOneLine

                SpeedLine {
                    iconName: "go-up"
                    speedText: "128.4 KB/s"
                    fontFamily: cfg_uploadFontFamily
                    fontSize: cfg_uploadFontSize
                    fontBold: cfg_uploadFontBold
                    fontItalic: cfg_uploadFontItalic
                    customColor: cfg_uploadColor
                    Layout.fillWidth: true
                }

                SpeedLine {
                    iconName: "go-down"
                    speedText: "4.82 MB/s"
                    fontFamily: cfg_downloadFontFamily
                    fontSize: cfg_downloadFontSize
                    fontBold: cfg_downloadFontBold
                    fontItalic: cfg_downloadFontItalic
                    customColor: cfg_downloadColor
                    Layout.fillWidth: true
                }
            }

            RowLayout {
                id: previewRow
                anchors.centerIn: parent
                spacing: Math.max(4, cfg_lineSpacing + 4)
                visible: parent.previewOneLine

                SpeedLine {
                    iconName: "go-up"
                    speedText: "128.4 KB/s"
                    fontFamily: cfg_uploadFontFamily
                    fontSize: cfg_uploadFontSize
                    fontBold: cfg_uploadFontBold
                    fontItalic: cfg_uploadFontItalic
                    customColor: cfg_uploadColor
                    Layout.alignment: Qt.AlignVCenter
                }

                Rectangle {
                    Layout.alignment: Qt.AlignVCenter
                    implicitWidth: 1
                    implicitHeight: Math.max(10, Math.round(Math.max(cfg_uploadFontSize, cfg_downloadFontSize) * 1.2))
                    color: Kirigami.Theme.textColor
                    opacity: 0.35
                }

                SpeedLine {
                    iconName: "go-down"
                    speedText: "4.82 MB/s"
                    fontFamily: cfg_downloadFontFamily
                    fontSize: cfg_downloadFontSize
                    fontBold: cfg_downloadFontBold
                    fontItalic: cfg_downloadFontItalic
                    customColor: cfg_downloadColor
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }

        // Upload Line Section
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: Tr.t("uploadLine", configPage.lang)
        }

        QQC2.ComboBox {
            id: uploadFontCombo
            Kirigami.FormData.label: Tr.t("fontFamily", configPage.lang)
            Layout.preferredWidth: Kirigami.Units.gridUnit * 14
            model: configPage.fontList
            currentIndex: configPage.fontIndexFor(cfg_uploadFontFamily)
            displayText: currentIndex === 0
                ? Tr.t("systemDefault", configPage.lang)
                : configPage.fontList[currentIndex]
            delegate: QQC2.ItemDelegate {
                width: uploadFontCombo.width
                text: index === 0 ? Tr.t("systemDefault", configPage.lang) : modelData
                font.family: index === 0 ? Kirigami.Theme.defaultFont.family : modelData
                highlighted: uploadFontCombo.highlightedIndex === index
            }
            onActivated: (idx) => {
                cfg_uploadFontFamily = configPage.fontList[idx];
            }
        }

        QQC2.SpinBox {
            id: uploadFontSizeSpin
            Kirigami.FormData.label: Tr.t("fontSize", configPage.lang)
            from: 6
            to: 72
            editable: true
            textFromValue: function(value) {
                return value + Tr.t("ptSuffix", configPage.lang);
            }
            valueFromText: function(text) {
                return parseInt(text, 10) || 9;
            }
        }

        RowLayout {
            Kirigami.FormData.label: Tr.t("fontStyle", configPage.lang)
            spacing: Kirigami.Units.largeSpacing

            QQC2.CheckBox {
                id: uploadBoldCheck
                text: Tr.t("bold", configPage.lang)
            }
            QQC2.CheckBox {
                id: uploadItalicCheck
                text: Tr.t("italic", configPage.lang)
            }
        }

        RowLayout {
            Kirigami.FormData.label: Tr.t("color", configPage.lang)
            spacing: Kirigami.Units.smallSpacing

            KQuickControls.ColorButton {
                id: uploadColorButton
                dialogTitle: Tr.t("chooseUploadColor", configPage.lang)
                showAlphaChannel: false
                color: cfg_uploadColor.length > 0 ? cfg_uploadColor : Kirigami.Theme.textColor
                onAccepted: (chosenColor) => {
                    cfg_uploadColor = chosenColor.toString();
                }
            }

            QQC2.Button {
                icon.name: "edit-undo"
                text: Tr.t("resetToTheme", configPage.lang)
                enabled: cfg_uploadColor.length > 0
                onClicked: cfg_uploadColor = ""
            }
        }

        // Download Line Section
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: Tr.t("downloadLine", configPage.lang)
        }

        QQC2.ComboBox {
            id: downloadFontCombo
            Kirigami.FormData.label: Tr.t("fontFamily", configPage.lang)
            Layout.preferredWidth: Kirigami.Units.gridUnit * 14
            model: configPage.fontList
            currentIndex: configPage.fontIndexFor(cfg_downloadFontFamily)
            displayText: currentIndex === 0
                ? Tr.t("systemDefault", configPage.lang)
                : configPage.fontList[currentIndex]
            delegate: QQC2.ItemDelegate {
                width: downloadFontCombo.width
                text: index === 0 ? Tr.t("systemDefault", configPage.lang) : modelData
                font.family: index === 0 ? Kirigami.Theme.defaultFont.family : modelData
                highlighted: downloadFontCombo.highlightedIndex === index
            }
            onActivated: (idx) => {
                cfg_downloadFontFamily = configPage.fontList[idx];
            }
        }

        QQC2.SpinBox {
            id: downloadFontSizeSpin
            Kirigami.FormData.label: Tr.t("fontSize", configPage.lang)
            from: 6
            to: 72
            editable: true
            textFromValue: function(value) {
                return value + Tr.t("ptSuffix", configPage.lang);
            }
            valueFromText: function(text) {
                return parseInt(text, 10) || 9;
            }
        }

        RowLayout {
            Kirigami.FormData.label: Tr.t("fontStyle", configPage.lang)
            spacing: Kirigami.Units.largeSpacing

            QQC2.CheckBox {
                id: downloadBoldCheck
                text: Tr.t("bold", configPage.lang)
            }
            QQC2.CheckBox {
                id: downloadItalicCheck
                text: Tr.t("italic", configPage.lang)
            }
        }

        RowLayout {
            Kirigami.FormData.label: Tr.t("color", configPage.lang)
            spacing: Kirigami.Units.smallSpacing

            KQuickControls.ColorButton {
                id: downloadColorButton
                dialogTitle: Tr.t("chooseDownloadColor", configPage.lang)
                showAlphaChannel: false
                color: cfg_downloadColor.length > 0 ? cfg_downloadColor : Kirigami.Theme.textColor
                onAccepted: (chosenColor) => {
                    cfg_downloadColor = chosenColor.toString();
                }
            }

            QQC2.Button {
                icon.name: "edit-undo"
                text: Tr.t("resetToTheme", configPage.lang)
                enabled: cfg_downloadColor.length > 0
                onClicked: cfg_downloadColor = ""
            }
        }

        // Layout Section
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: Tr.t("layoutSection", configPage.lang)
        }

        QQC2.ComboBox {
            id: displayLayoutCombo
            Kirigami.FormData.label: Tr.t("displayLayout", configPage.lang)
            Layout.preferredWidth: Kirigami.Units.gridUnit * 14
            model: [
                Tr.t("layoutTwoLines", configPage.lang),
                Tr.t("layoutOneLine", configPage.lang)
            ]
            currentIndex: Math.max(0, configPage.layoutValues.indexOf(cfg_displayLayout))
            onActivated: (idx) => {
                cfg_displayLayout = configPage.layoutValues[idx];
            }
        }

        QQC2.SpinBox {
            id: lineSpacingSpin
            Kirigami.FormData.label: Tr.t("lineSpacing", configPage.lang)
            from: 0
            to: 20
            editable: true
            textFromValue: function(value) {
                return value + Tr.t("pxSuffix", configPage.lang);
            }
            valueFromText: function(text) {
                return parseInt(text, 10) || 0;
            }
        }
    }
}
