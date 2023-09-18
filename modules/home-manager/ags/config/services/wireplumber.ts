class WireplumberService extends Service {
    static {
        Service.register(
            this,
            {
            },
            {
                'speakerMuted': ['boolean'],
                'speakerVolume': ['int', 'rw'],
                'micMuted': ['boolean'],
                'micVolume': ['int', 'rw'],
            }
        );
    }

    #speakerVolume = Variable(0, {
        poll: [500, 'bash -c "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F \'[ ]\' \'{print $2 * 100 }\'"'],
    })
    #speakerMuted = Variable(false, {
        poll: [500, 'bash -c "wpctl get-volume @DEFAULT_AUDIO_SINK@"', out => {
            let v = out.includes("MUTED")
            return v
        }]
    })
    #micVolume = Variable(0, {
        poll: [500, 'bash -c "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk -F \'[ ]\' \'{print $2 * 100 }\'"'],
    })
    #micMuted = Variable(false, {
        poll: [500, 'bash -c "wpctl get-volume @DEFAULT_AUDIO_SOURCE@"', out => {
            let v = out.includes("MUTED")
            return v
        }]
    })

    get speakerVolume() {
        return this.#speakerVolume.getValue();
    }

    set speakerVolume(value) {
        // Wireplumber is using 0-1 for 0-100% so we need to transform the value
        value = (value | 0) / 100
        Utils.exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ " + value)
    }

    get speakerMuted() {
        return this.#speakerMuted.getValue();
    }

    set speakerMuted(value) {
        Utils.exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ " + value)
    }

    toggleSpeakerMuted() {
        Utils.exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
    }

    get micVolume() {
        return this.#micVolume.getValue();
    }

    set micVolume(value) {
        // Wireplumber is using 0-1 for 0-100% so we need to transform the value
        value = (value | 0) / 100
        Utils.exec("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ " + value)
    }

    get micMuted() {
        return this.#micMuted.getValue();
    }

    set micMuted(value) {
        Utils.exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ " + value)
    }

    toggleMicMuted() {
        Utils.exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
    }

    constructor() {
        super();

        this.#speakerMuted.connect('changed', () => { this.changed("speakerMuted") });
        this.#speakerVolume.connect('changed', () => { this.changed("speakerVolume"); });
        this.#micMuted.connect('changed', () => { this.changed("micMuted") });
        this.#micVolume.connect('changed', () => { this.changed("micVolume"); });
    }
}

// the singleton instance
const service = new WireplumberService;

// export to use in other modules
export default service;
