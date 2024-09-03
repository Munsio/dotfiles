import "session"
import "style/style"
import Bar from "windows/bar/Bar"
import { addWindows, watchMonitors } from "lib/utils"

Utils.idle(() => {
    // Windows which are only set once.
    addWindows([
        // IndicatorWidget(),
        // Quicksettings(),
        // Launcher(),
        // PowerMenu(),
        // PopupNotifications(),
    ]);

    // Windows which should be set to each monitor.
    const monitorWindows = [
        Bar,
    ]

    watchMonitors(monitorWindows)
});

App.config({
});

App.addIcons(`${App.configDir}/assets/icons`)
