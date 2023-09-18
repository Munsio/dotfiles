import GLib from "gi://GLib"

const clock = Variable(GLib.DateTime.new_now_local(), {
    poll: [1000, () => GLib.DateTime.new_now_local()],
})

const hour = Utils.derive([clock], (c) => c.format("%H") || "")
const minute = Utils.derive([clock], (c) => c.format("%M") || "")

// (defpoll clock_hour:interval "5m" "date +\%H")
// (defpoll clock_minute:interval "5s" "date +\%M")

const Clock = () => (Widget.Box({
    class_name: "clock",
    children: [
        Widget.Label({
            class_name: "hour",
            label: hour.bind(),
        }),
        Widget.Label({
            class_name: "separator",
            label: "⋮",
        }),
        Widget.Label({
            class_name: "minute",
            label: minute.bind(),
        }),
    ]
}))



export default () => Clock()
