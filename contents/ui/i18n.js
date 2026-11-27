.pragma library

var translations = {
    en: {
        widgetTitle: "Network Speed",
        appearance: "Appearance",
        general: "General",
        upload: "Upload",
        download: "Download",
        uploadLine: "Upload Line (Top)",
        downloadLine: "Download Line (Bottom)",
        layoutSection: "Layout",
        displayLayout: "Display layout:",
        layoutTwoLines: "2 lines (stacked)",
        layoutOneLine: "1 line (inline)",
        previewSection: "Preview",
        fontFamily: "Font family:",
        fontSize: "Font size:",
        fontStyle: "Font style:",
        bold: "Bold",
        italic: "Italic",
        color: "Color:",
        chooseUploadColor: "Choose Upload Line Color",
        chooseDownloadColor: "Choose Download Line Color",
        resetToTheme: "Reset to theme color",
        systemDefault: "System Default",
        lineSpacing: "Line spacing:",
        language: "Language:",
        languageSystem: "System Default (Fallback: English)",
        languageEn: "English",
        languageVi: "Tiếng Việt",
        speedUnit: "Speed unit:",
        unitDecimalBytes: "Bytes/s (B/s, KB/s, MB/s)",
        unitBinaryBytes: "Binary Bytes/s (B/s, KiB/s, MiB/s)",
        unitBits: "Bits/s (b/s, Kb/s, Mb/s)",
        updateInterval: "Update interval:",
        currentSpeed: "Current Speed",
        peakSpeed: "Peak Speed",
        resetPeak: "Reset Peak",
        ptSuffix: " pt",
        pxSuffix: " px",
        msSuffix: " ms"
    },
    vi: {
        widgetTitle: "Tốc độ mạng",
        appearance: "Giao diện",
        general: "Chung",
        upload: "Tải lên",
        download: "Tải xuống",
        uploadLine: "Dòng Upload (Trên)",
        downloadLine: "Dòng Download (Dưới)",
        layoutSection: "Bố cục",
        displayLayout: "Kiểu hiển thị:",
        layoutTwoLines: "2 dòng (trên dưới)",
        layoutOneLine: "1 dòng (ngang)",
        previewSection: "Xem trước",
        fontFamily: "Kiểu chữ:",
        fontSize: "Cỡ chữ:",
        fontStyle: "Định dạng:",
        bold: "In đậm",
        italic: "In nghiêng",
        color: "Màu sắc:",
        chooseUploadColor: "Chọn màu dòng Upload",
        chooseDownloadColor: "Chọn màu dòng Download",
        resetToTheme: "Khôi phục màu chủ đề",
        systemDefault: "Mặc định hệ thống",
        lineSpacing: "Khoảng cách dòng:",
        language: "Ngôn ngữ:",
        languageSystem: "Theo hệ thống (Mặc định: Tiếng Anh)",
        languageEn: "English",
        languageVi: "Tiếng Việt",
        speedUnit: "Đơn vị tốc độ:",
        unitDecimalBytes: "Bytes/s (B/s, KB/s, MB/s)",
        unitBinaryBytes: "Binary Bytes/s (B/s, KiB/s, MiB/s)",
        unitBits: "Bits/s (b/s, Kb/s, Mb/s)",
        updateInterval: "Tần suất cập nhật:",
        currentSpeed: "Tốc độ hiện tại",
        peakSpeed: "Tốc độ đỉnh",
        resetPeak: "Đặt lại đỉnh",
        ptSuffix: " pt",
        pxSuffix: " px",
        msSuffix: " ms"
    }
};

function resolveLanguage(configuredLang) {
    if (configuredLang === "vi" || configuredLang === "en") {
        return configuredLang;
    }
    // Default: follow system locale, fallback to English
    var sysLocale = "";
    try {
        sysLocale = Qt.locale().name || "";
    } catch (e) {
        sysLocale = "";
    }
    if (sysLocale.toLowerCase().indexOf("vi") === 0) {
        return "vi";
    }
    return "en";
}

function t(key, configuredLang) {
    var lang = resolveLanguage(configuredLang);
    var dict = translations[lang] || translations.en;
    if (dict[key] !== undefined) {
        return dict[key];
    }
    return translations.en[key] !== undefined ? translations.en[key] : key;
}
