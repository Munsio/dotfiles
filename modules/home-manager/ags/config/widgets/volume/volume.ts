import wireplumber from 'services/wireplumber'

const speakerIcons = {
    60: "full",
    1: "mid",
    0: "off",
}

function getSpeakerIcon() {
    if (wireplumber.speakerMuted) {
        return `custom-volume-mute-symbolic`
    }
    const icon = [60, 1, 0].find(threshold => threshold <= wireplumber.speakerVolume)
    return `custom-volume-${speakerIcons[icon]}-symbolic`
}

const speakerIcon = () => (Widget.Button({
    child: Widget.Icon({
        class_name: "volumeIcon",
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
        return `custom-microphone-off-symbolic`
    }

    return `custom-microphone-symbolic`
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
            children: [sSlider, speakerIcon()]
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
            children: [mSlider, micIcon()]
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
