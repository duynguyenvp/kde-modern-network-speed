import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

RowLayout {
    id: lineRoot

    property string iconName: "go-up"
    property string speedText: "0 B/s"
    property string fontFamily: ""
    property int fontSize: 9
    property bool fontBold: false
    property bool fontItalic: false
    property string customColor: ""

    readonly property color effectiveColor: (customColor && customColor.length > 0)
        ? customColor
        : Kirigami.Theme.textColor

    readonly property real iconSize: Math.max(10, Math.round(speedLabel.font.pixelSize > 0
        ? speedLabel.font.pixelSize
        : fontSize * 1.25))

    spacing: 4

    Kirigami.Icon {
        id: directionIcon
        source: lineRoot.iconName
        isMask: true
        color: lineRoot.effectiveColor
        Layout.preferredWidth: lineRoot.iconSize
        Layout.preferredHeight: lineRoot.iconSize
        Layout.alignment: Qt.AlignVCenter
    }

    PlasmaComponents.Label {
        id: speedLabel
        text: lineRoot.speedText
        color: lineRoot.effectiveColor
        font.family: (lineRoot.fontFamily && lineRoot.fontFamily.length > 0)
            ? lineRoot.fontFamily
            : Kirigami.Theme.defaultFont.family
        font.pointSize: Math.max(6, lineRoot.fontSize)
        font.bold: lineRoot.fontBold
        font.italic: lineRoot.fontItalic
        font.features: ({ "tnum": 1 })
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        textFormat: Text.PlainText
        elide: Text.ElideNone
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
    }
}
