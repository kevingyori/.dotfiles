hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.alert.show("Config loaded")

-- hs.loadSpoon("SpoonInstall")

-- hs.loadSpoon("Caffeine")
-- spoon.Caffeine:start()

-- Paste anywhere with cmd+alt+V
hs.hotkey.bind({ "cmd", "alt" }, "V", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- hyper key
require('keyboard.hyper')
