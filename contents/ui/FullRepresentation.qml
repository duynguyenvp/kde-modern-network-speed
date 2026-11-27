import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid
import "i18n.js" as Tr

Item {
    id: fullRoot

    required property string uploadText
    required property string downloadText
    required property string peakUploadText
    required property string peakDownloadText
    signal resetPeakRequested()

    readonly property string lang: Plasmoid.configuration.language

    Layout.minimumWidth: Kirigami.Units.gridUnit * 14
    Layout.minimumHeight: mainColumn.implicitHeight + Kirigami.Units.largeSpacing * 2
    Layout.preferredWidth: Kirigami.Units.gridUnit * 16
    Layout.preferredHeight: mainColumn.implicitHeight + Kirigami.Units.largeSpacing * 2

    ColumnLayout {
        id: mainColumn
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing
        spacing: Kirigami.Units.largeSpacing

        RowLayout {
            Layout.fillWidth: true

            Kirigami.Icon {
                source: "network-wired"
                Layout.preferredWidth: Kirigami.Units.iconSizes.smallMedium
                Layout.preferredHeight: Kirigami.Units.iconSizes.smallMedium
            }

            Kirigami.Heading {
                level: 4
                text: Tr.t("widgetTitle", fullRoot.lang)
                Layout.fillWidth: true
            }

            PlasmaComponents.ToolButton {
                icon.name: "view-refresh"
                PlasmaComponents.ToolTip.text: Tr.t("resetPeak", fullRoot.lang)
                PlasmaComponents.ToolTip.visible: hovered
                onClicked: fullRoot.resetPeakRequested()
            }
        }

        Kirigami.Separator {
            Layout.fillWidth: true
        }

        PlasmaComponents.Label {
            text: Tr.t("currentSpeed", fullRoot.lang)
            font.bold: true
            opacity: 0.75
        }

        GridLayout {
            columns: 2
            columnSpacing: Kirigami.Units.largeSpacing
            rowSpacing: Kirigami.Units.smallSpacing
            Layout.fillWidth: true

            RowLayout {
                spacing: Kirigami.Units.smallSpacing
                Kirigami.Icon {
                    source: "go-up"
                    isMask: true
                    color: Plasmoid.configuration.uploadColor.length > 0
                        ? Plasmoid.configuration.uploadColor
                        : Kirigami.Theme.textColor
                    Layout.preferredWidth: Kirigami.Units.iconSizes.small
                    Layout.preferredHeight: Kirigami.Units.iconSizes.small
                }
                PlasmaComponents.Label {
                    text: Tr.t("upload", fullRoot.lang)
                }
            }

            PlasmaComponents.Label {
                text: fullRoot.uploadText
                font.bold: true
                font.features: ({ "tnum": 1 })
                color: Plasmoid.configuration.uploadColor.length > 0
                    ? Plasmoid.configuration.uploadColor
                    : Kirigami.Theme.textColor
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }

            RowLayout {
                spacing: Kirigami.Units.smallSpacing
                Kirigami.Icon {
                    source: "go-down"
                    isMask: true
                    color: Plasmoid.configuration.downloadColor.length > 0
                        ? Plasmoid.configuration.downloadColor
                        : Kirigami.Theme.textColor
                    Layout.preferredWidth: Kirigami.Units.iconSizes.small
                    Layout.preferredHeight: Kirigami.Units.iconSizes.small
                }
                PlasmaComponents.Label {
                    text: Tr.t("download", fullRoot.lang)
                }
            }

            PlasmaComponents.Label {
                text: fullRoot.downloadText
                font.bold: true
                font.features: ({ "tnum": 1 })
                color: Plasmoid.configuration.downloadColor.length > 0
                    ? Plasmoid.configuration.downloadColor
                    : Kirigami.Theme.textColor
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }
        }

        Kirigami.Separator {
            Layout.fillWidth: true
        }

        PlasmaComponents.Label {
            text: Tr.t("peakSpeed", fullRoot.lang)
            font.bold: true
            opacity: 0.75
        }

        GridLayout {
            columns: 2
            columnSpacing: Kirigami.Units.largeSpacing
            rowSpacing: Kirigami.Units.smallSpacing
            Layout.fillWidth: true

            PlasmaComponents.Label {
                text: Tr.t("upload", fullRoot.lang)
                opacity: 0.85
            }

            PlasmaComponents.Label {
                text: fullRoot.peakUploadText
                font.features: ({ "tnum": 1 })
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }

            PlasmaComponents.Label {
                text: Tr.t("download", fullRoot.lang)
                opacity: 0.85
            }

            PlasmaComponents.Label {
                text: fullRoot.peakDownloadText
                font.features: ({ "tnum": 1 })
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
            }
        }
    }
}
