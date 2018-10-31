"use strict";
exports.__esModule = true;
exports.activate = function (oni) {
    console.log("config activated");
    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", function () { return console.log("Control+Enter was pressed"); });
    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
};
exports.deactivate = function (oni) {
    console.log("config deactivated");
};
exports.configuration = {
    //add custom config here, such as
    "oni.hideMenu": "hidden",
    "oni.loadInitVim": true,
    "oni.useDefaultConfig": false,
    "ui.colorscheme": "",
    // "autoClosingPairs.enabled" : false, // disable autoclosing pairs
    "commandline.mode": false,
    "wildmenu.mode": false,
    "tabs.mode": "native",
    "statusbar.enabled": false,
    // "sidebar.enabled"          : false, // sidebar ui is gone
    "editor.fullScreenOnStart": true,
    "editor.maximizeScreenOnStart": true,
    "oni.plugins.prettier": {
        "settings": {
            "semi": false,
            "tabWidth": 2,
            "useTabs": false,
            "singleQuote": true,
            "trailingComma": "es5",
            "bracketSpacing": true,
            "jsxBracketSameLine": false,
            "arrowParens": "avoid",
            "printWidth": 80
        },
        "formatOnSave": true,
        "enabled": true
    }
    //    "sidebar.default.open"     : false, // the side bar collapse 
    //"learning.enabled"         : false, // Turn off learning pane
    //"achievements.enabled"     : false, // Turn off achievements tracking / UX
    ,
    //    "sidebar.default.open"     : false, // the side bar collapse 
    //"learning.enabled"         : false, // Turn off learning pane
    //"achievements.enabled"     : false, // Turn off achievements tracking / UX
    "editor.typingPrediction": false,
    "editor.textMateHighlighting.enabled": false,
    //"oni.useDefaultConfig": true,
    //"oni.bookmarks": ["~/Documents"],
    //"oni.loadInitVim": false,
    "editor.fontSize": "14px",
    //"editor.fontFamily": "Monaco",
    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
    // language server configuration
    "language.go.languageServer.rootFiles": [".git"],
    "language.go.languageServer.command": "~/go/bin/go-langserver",
    "language.go.languageServer.arguments": ["--gocodecompletion", "--freeosmemory", "false"]
};
