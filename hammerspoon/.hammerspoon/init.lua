hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.alert.show("Config loaded")

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("AppLauncher", {
  hotkeys = {
    c = "Calendar",
    d = "Discord",
    f = "Firefox Developer Edition",
    n = "Notes",
    p = "1Password 7",
    r = "Reeder",
    t = "Kitty",
    z = "Zoom.us",
  }
})
-- hs.loadSpoon("Caffeine")
-- spoon.Caffeine:start()

-- Paste anywhere with cmd+alt+V
hs.hotkey.bind({ "cmd", "alt" }, "V", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
