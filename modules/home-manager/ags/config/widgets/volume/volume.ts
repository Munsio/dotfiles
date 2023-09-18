import wireplumber from 'services/wireplumber'

const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
}

function getSpeakerIcon() {
    if (wireplumber.speakerMuted) {
        return `audio-volume-muted-blocking`
    }

    const icon = [101, 67, 34, 1, 0].find(threshold => threshold <= wireplumber.speakerVolume)
    return `audio-volume-${icons[icon]}-symbolic`
}

const speakerIcon = () => (Widget.Button({
    child: Widget.Icon({
        class_name: "icon",
        icon: Utils.watch(getSpeakerIcon(), wireplumber, getSpeakerIcon),
    }),
    on_primary_click: () => { wireplumber.toggleSpeakerMuted() }
}))

const speakerSlider = () => {
    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        value: wireplumber.bind("speakerVolume"),
        min: 0,
        max: 100,
        step: 5,
        on_change: ({ value }) => wireplumber.speakerVolume = value,
    })

    const revealer = Widget.Revealer({
        revealChild: false,
        transitionDuration: 300,
        transition: 'slide_left',
        child: slider,
    })

    return revealer
}

function getMicIcon() {
    if (wireplumber.micMuted) {
        return `mic-ready`
    }

    const icon = [101, 67, 34, 1, 0].find(threshold => threshold <= wireplumber.micVolume)
    return `microphone-sensitivity-${icons[icon]}`
}

const micIcon = () => (Widget.Button({
    child: Widget.Icon({
        class_name: "icon",
        icon: Utils.watch(getMicIcon(), wireplumber, getMicIcon),
    }),
    on_primary_click: () => { wireplumber.toggleMicMuted() }
}))

const micSlider = () => {
    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        value: wireplumber.bind("micVolume"),
        min: 0,
        max: 100,
        step: 5,
        on_change: ({ value }) => wireplumber.micVolume = value,
    })

    const revealer = Widget.Revealer({
        revealChild: false,
        transitionDuration: 300,
        transition: 'slide_left',
        child: slider,
    })

    return revealer
}

const Volume = () => {
    const sSlider = speakerSlider()

    const speakerBox = Widget.EventBox({
        class_name: "speaker",
        css: "min-width: 20px",
        child: Widget.Box({
            children: [speakerIcon(), sSlider]
        }),
    })
    speakerBox.connect("enter-notify-event", () => {
        sSlider.reveal_child = true
    })
    speakerBox.connect("leave-notify-event", () => {
        sSlider.reveal_child = false
    })

    const mSlider = micSlider()
    const micBox = Widget.EventBox({
        class_name: "mic",
        css: "min-width: 20px",
        child: Widget.Box({
            children: [micIcon(), mSlider]
        }),
    })
    micBox.connect("enter-notify-event", () => {
        mSlider.reveal_child = true
    })
    micBox.connect("leave-notify-event", () => {
        mSlider.reveal_child = false
    })

    return Widget.Box({
        class_name: "volume",
        children: [micBox, speakerBox]
    })
}

export default () => Volume()
