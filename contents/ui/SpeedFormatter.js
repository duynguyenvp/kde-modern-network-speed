.pragma library

function formatSpeed(bytesPerSec, unitMode) {
    var val = Number(bytesPerSec);
    if (!isFinite(val) || val < 0) {
        val = 0;
    }

    var base = 1000;
    var units = ["B/s", "KB/s", "MB/s", "GB/s", "TB/s"];

    if (unitMode === "binary_bytes") {
        base = 1024;
        units = ["B/s", "KiB/s", "MiB/s", "GiB/s", "TiB/s"];
    } else if (unitMode === "bits") {
        val = val * 8;
        base = 1000;
        units = ["b/s", "Kb/s", "Mb/s", "Gb/s", "Tb/s"];
    }

    var unitIndex = 0;
    while (val >= base && unitIndex < units.length - 1) {
        val = val / base;
        unitIndex++;
    }

    var formatted;
    if (unitIndex === 0) {
        formatted = Math.round(val).toString();
    } else if (val >= 100) {
        formatted = val.toFixed(0);
    } else if (val >= 10) {
        formatted = val.toFixed(1);
    } else {
        formatted = val.toFixed(2);
    }

    return formatted + " " + units[unitIndex];
}
