import Clock from "widgets/clock/clock";
import Separator from "widgets/separator/separator";
import Volume from "widgets/volume/volume";
import Workspaces from "widgets/hyprland-workspaces/workspaces";

function Left() {
    return Widget.Box({
        children: [
            Workspaces(),
        ]
    })
}

function Center() {
    return Widget.Box({
        children: [
        ]
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        children: [
            Volume(),
            Separator(),
            Clock(),
        ]
    })
}

export default (monitor) => Widget.Window({
    gdkmonitor: monitor,
    class_name: "bar",
    name: `bar${monitor.model}`,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
});
