const hyprland = await Service.import("hyprland")

const dispatch = (arg: string | number) => {
    hyprland.messageAsync(`dispatch workspace ${arg}`)
}

const activeId = hyprland.active.workspace.bind("id")
const Workspaces = (ws) => {
    return ws.sort((a, b) => {
        return a.id > b.id
    }).map(({ id }) => (
        Widget.Button({
            on_clicked: () => dispatch(id),
            child: Widget.Label(` `),
            class_name: activeId.as(i => `item ${i === id ? "focused" : ""}`),
        })
    ))
}

export default () => Widget.Button({
    class_name: "workspaces",
    on_scroll_up: () => dispatch("m+1"),
    on_scroll_down: () => dispatch("m-1"),
    child: Widget.Box({
        children: hyprland.bind("workspaces").as(Workspaces),
    })
})
