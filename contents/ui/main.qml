import QtQuick
import org.kde.ksysguard.sensors as Sensors
import org.kde.plasma.plasmoid
import "i18n.js" as Tr
import "SpeedFormatter.js" as Formatter

PlasmoidItem {
    id: root

    property real uploadBytesPerSec: 0
    property real downloadBytesPerSec: 0
    property real peakUploadBytesPerSec: 0
    property real peakDownloadBytesPerSec: 0

    readonly property string lang: Plasmoid.configuration.language
    readonly property string unitMode: Plasmoid.configuration.speedUnit
    readonly property string uploadText: Formatter.formatSpeed(uploadBytesPerSec, unitMode)
    readonly property string downloadText: Formatter.formatSpeed(downloadBytesPerSec, unitMode)
    readonly property string peakUploadText: Formatter.formatSpeed(peakUploadBytesPerSec, unitMode)
    readonly property string peakDownloadText: Formatter.formatSpeed(peakDownloadBytesPerSec, unitMode)

    // Always display the 2-line monitor on both panels and desktop;
    // clicking on a panel toggles the detailed popup.
    preferredRepresentation: compactRepresentation

    toolTipMainText: Tr.t("widgetTitle", lang)
    toolTipSubText: Tr.t("upload", lang) + ": " + uploadText + "\n" + Tr.t("download", lang) + ": " + downloadText

    Sensors.Sensor {
        id: uploadSensor
        sensorId: "network/all/upload"
        enabled: true
        updateRateLimit: Plasmoid.configuration.updateInterval
        onValueChanged: {
            var v = Number(value);
            if (!isFinite(v) || v < 0) {
                v = 0;
            }
            root.uploadBytesPerSec = v;
            if (v > root.peakUploadBytesPerSec) {
                root.peakUploadBytesPerSec = v;
            }
        }
    }

    Sensors.Sensor {
        id: downloadSensor
        sensorId: "network/all/download"
        enabled: true
        updateRateLimit: Plasmoid.configuration.updateInterval
        onValueChanged: {
            var v = Number(value);
            if (!isFinite(v) || v < 0) {
                v = 0;
            }
            root.downloadBytesPerSec = v;
            if (v > root.peakDownloadBytesPerSec) {
                root.peakDownloadBytesPerSec = v;
            }
        }
    }

    compactRepresentation: CompactRepresentation {
        uploadText: root.uploadText
        downloadText: root.downloadText
        onToggleExpanded: root.expanded = !root.expanded
    }

    fullRepresentation: FullRepresentation {
        uploadText: root.uploadText
        downloadText: root.downloadText
        peakUploadText: root.peakUploadText
        peakDownloadText: root.peakDownloadText
        onResetPeakRequested: {
            root.peakUploadBytesPerSec = root.uploadBytesPerSec;
            root.peakDownloadBytesPerSec = root.downloadBytesPerSec;
        }
    }
}
