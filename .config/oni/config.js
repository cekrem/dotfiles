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
    "ui.colorscheme": "onedark",
    "autoClosingPairs.enabled": false,
    "commandline.mode": false,
    "wildmenu.mode": false,
    "tabs.mode": "native",
    //    "statusbar.enabled"        : false, // use vim's default statusline
    "sidebar.enabled": false,
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
        "enabled": false
    }
    //    "sidebar.default.open"     : false, // the side bar collapse 
    ,
    //    "sidebar.default.open"     : false, // the side bar collapse 
    "learning.enabled": false,
    "achievements.enabled": false,
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
