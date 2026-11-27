import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

Item {
    id: compactRoot

    required property string uploadText
    required property string downloadText
    signal toggleExpanded()

    readonly property bool inVerticalPanel: Plasmoid.formFactor === PlasmaCore.Types.Vertical

    // Compute a stable minimum width based on the larger font size so the panel doesn't jitter
    readonly property int maxFontSize: Math.max(
        Plasmoid.configuration.uploadFontSize,
        Plasmoid.configuration.downloadFontSize
    )
    readonly property real stableMinWidth: Math.round(maxFontSize * 8.5)

    Layout.minimumWidth: inVerticalPanel ? 0 : Math.max(stableMinWidth, linesColumn.implicitWidth + 8)
    Layout.preferredWidth: inVerticalPanel ? -1 : Layout.minimumWidth
    Layout.fillWidth: inVerticalPanel

    Layout.minimumHeight: linesColumn.implicitHeight + 4
    Layout.preferredHeight: inVerticalPanel ? linesColumn.implicitHeight + 8 : -1
    Layout.fillHeight: !inVerticalPanel

    implicitWidth: linesColumn.implicitWidth + 8
    implicitHeight: linesColumn.implicitHeight + 4

    ColumnLayout {
        id: linesColumn
        anchors.centerIn: parent
        width: compactRoot.inVerticalPanel ? Math.min(parent.width - 4, implicitWidth) : implicitWidth
        spacing: Plasmoid.configuration.lineSpacing

        SpeedLine {
            id: uploadLine
            iconName: "go-up"
            speedText: compactRoot.uploadText
            fontFamily: Plasmoid.configuration.uploadFontFamily
            fontSize: Plasmoid.configuration.uploadFontSize
            fontBold: Plasmoid.configuration.uploadFontBold
            fontItalic: Plasmoid.configuration.uploadFontItalic
            customColor: Plasmoid.configuration.uploadColor
            Layout.fillWidth: true
        }

        SpeedLine {
            id: downloadLine
            iconName: "go-down"
            speedText: compactRoot.downloadText
            fontFamily: Plasmoid.configuration.downloadFontFamily
            fontSize: Plasmoid.configuration.downloadFontSize
            fontBold: Plasmoid.configuration.downloadFontBold
            fontItalic: Plasmoid.configuration.downloadFontItalic
            customColor: Plasmoid.configuration.downloadColor
            Layout.fillWidth: true
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: {
            if (Plasmoid.formFactor === PlasmaCore.Types.Horizontal || Plasmoid.formFactor === PlasmaCore.Types.Vertical) {
                compactRoot.toggleExpanded();
            }
        }
    }
}
