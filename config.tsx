
import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as

    "oni.hideMenu"             : "hidden", // Hide top bar menu
    "oni.loadInitVim"          : true, // Load user's init.vim
    "oni.useDefaultConfig"     : false, // Do not load Oni's init.vim
    "ui.colorscheme"           : "onedark", // Load init.vim colorscheme, remove this line if wants Oni's default
    "autoClosingPairs.enabled" : false, // disable autoclosing pairs
    "commandline.mode"         : false, // Do not override commandline UI
    "wildmenu.mode"            : false, // Do not override wildmenu UI,
    "tabs.mode"                : "native", // Use vim's tabline, need completely quit Oni and restart a few times
//    "statusbar.enabled"        : false, // use vim's default statusline
    "sidebar.enabled"          : false, // sidebar ui is gone
//    "sidebar.default.open"     : false, // the side bar collapse 
    "learning.enabled"         : false, // Turn off learning pane
    "achievements.enabled"     : false, // Turn off achievements tracking / UX
    "editor.typingPrediction"  : false, // Wait for vim's confirmed typed characters, avoid edge cases
    "editor.textMateHighlighting.enabled" : false, // Use vim syntax highlighting

    //"oni.useDefaultConfig": true,
    //"oni.bookmarks": ["~/Documents"],
    //"oni.loadInitVim": false,
    "editor.fontSize": "14px",
    //"editor.fontFamily": "Monaco",

    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
    // language server configuration
    "language.go.languageServer.rootFiles": [".git"], // In a git repository
    "language.go.languageServer.command": "~/go/bin/go-langserver",
    "language.go.languageServer.arguments": ["--gocodecompletion", "--freeosmemory", "false"],
}

