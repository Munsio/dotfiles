async function resetCss() {
    try {
        // generated files
        const scss = `${TMP}/main.scss`
        const css = `${TMP}/main.css`

        // const reset_style = `${App.configDir}/reset.scss`
        // const base_style = `${App.configDir}/style.scss`
        // Add generated color scheme
        const color_scheme = `${Utils.HOME}/.cache/wal/colors.scss`

        // Read all scss files from the widget directory and append them.
        const fd = Utils.exec(`find ${App.configDir}/ -type f -name "*.scss"`)
        const files = fd.split(/\s+/)
        const imports = [color_scheme, ...files].map(f => `@import '${f}';`)

        // Add imports
        await Utils.writeFile(imports.join("\n"), scss)

        // compile, reset, apply
        await Utils.exec(`sassc ${scss} ${css}`)
        App.resetCss()
        App.applyCss(css)
    } catch (error) {
        error instanceof Error
            ? logError(error)
            : console.error(error)
    }
}

await resetCss()
globalThis.resetCss = resetCss
