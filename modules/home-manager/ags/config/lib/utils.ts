import Gtk from "gi://Gtk?version=3.0"
import Gdk from "gi://Gdk"

export function forMonitors(widget: (monitor: number) => Gtk.Window) {
    const display = Gdk.Display.get_default();

    // create the widget on each
    const n = display?.get_n_monitors() || 1
    range(n, 0).flatMap(widget)
}

/**
 * @returns [start...length]
 */
export function range(length: number, start = 1) {
    return Array.from({ length }, (_, i) => i + start)
}


export function addWindows(windows) {
    windows.forEach(win => App.addWindow(win));
}

export function addMonitorWindows(windows, monitor) {
    windows.forEach(win => {
        App.addWindow(win(monitor))
    })
}

export function watchMonitors(monitorWindows) {
    const display = Gdk.Display.get_default();
    const n = display?.get_n_monitors() || 1
    for (let m = 0; m < n; m++) {
        const monitor = display?.get_monitor(m);
        addMonitorWindows(monitorWindows, monitor);
    }

    display?.connect("monitor-added", (disp, monitor) => {
        addMonitorWindows(monitorWindows, monitor);
    });

    display?.connect("monitor-removed", (disp, monitor) => {
        App.windows.forEach(win => {
            if (win.gdkmonitor === monitor) App.removeWindow(win);
        });
    });
}
