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
    readonly property bool isOneLine: !inVerticalPanel && Plasmoid.configuration.displayLayout === "one_line"

    // Compute a stable minimum width based on the font size so the panel doesn't jitter
    readonly property int maxFontSize: Math.max(
        Plasmoid.configuration.uploadFontSize,
        Plasmoid.configuration.downloadFontSize
    )
    readonly property real stableMinWidth: isOneLine
        ? Math.round((Plasmoid.configuration.uploadFontSize + Plasmoid.configuration.downloadFontSize) * 9.0)
        : Math.round(maxFontSize * 8.5)

    readonly property real activeImplicitWidth: isOneLine ? linesRow.implicitWidth : linesColumn.implicitWidth
    readonly property real activeImplicitHeight: isOneLine ? linesRow.implicitHeight : linesColumn.implicitHeight

    Layout.minimumWidth: inVerticalPanel ? 0 : Math.max(stableMinWidth, activeImplicitWidth + 8)
    Layout.preferredWidth: inVerticalPanel ? -1 : Layout.minimumWidth
    Layout.fillWidth: inVerticalPanel

    Layout.minimumHeight: activeImplicitHeight + 4
    Layout.preferredHeight: inVerticalPanel ? activeImplicitHeight + 8 : -1
    Layout.fillHeight: !inVerticalPanel

    implicitWidth: activeImplicitWidth + 8
    implicitHeight: activeImplicitHeight + 4

    ColumnLayout {
        id: linesColumn
        anchors.centerIn: parent
        width: compactRoot.inVerticalPanel ? Math.min(parent.width - 4, implicitWidth) : implicitWidth
        spacing: Plasmoid.configuration.lineSpacing
        visible: !compactRoot.isOneLine

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

    RowLayout {
        id: linesRow
        anchors.centerIn: parent
        spacing: Math.max(4, Plasmoid.configuration.lineSpacing + 4)
        visible: compactRoot.isOneLine

        SpeedLine {
            iconName: "go-up"
            speedText: compactRoot.uploadText
            fontFamily: Plasmoid.configuration.uploadFontFamily
            fontSize: Plasmoid.configuration.uploadFontSize
            fontBold: Plasmoid.configuration.uploadFontBold
            fontItalic: Plasmoid.configuration.uploadFontItalic
            customColor: Plasmoid.configuration.uploadColor
            Layout.alignment: Qt.AlignVCenter
        }

        Rectangle {
            Layout.alignment: Qt.AlignVCenter
            implicitWidth: 1
            implicitHeight: Math.max(10, Math.round(compactRoot.maxFontSize * 1.2))
            color: Kirigami.Theme.textColor
            opacity: 0.35
        }

        SpeedLine {
            iconName: "go-down"
            speedText: compactRoot.downloadText
            fontFamily: Plasmoid.configuration.downloadFontFamily
            fontSize: Plasmoid.configuration.downloadFontSize
            fontBold: Plasmoid.configuration.downloadFontBold
            fontItalic: Plasmoid.configuration.downloadFontItalic
            customColor: Plasmoid.configuration.downloadColor
            Layout.alignment: Qt.AlignVCenter
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
