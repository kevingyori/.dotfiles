-- human_event_jiggler.lua

local jiggleTimer
local running = false

-- config: adjust to taste
local minInterval, maxInterval = 5, 10 -- seconds between jiggles
local minOffset, maxOffset = -3, 3 -- pixels to move in X and Y
local minHold, maxHold = 0.05, 0.25 -- seconds to hold before moving back

math.randomseed(os.time())

-- send a real mouse-move event
local function sendMove(x, y)
	hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, { x = x, y = y }):post()
end

-- one human-like jiggle
local function humanJiggle()
	local p = hs.mouse.absolutePosition()
	local dx = math.random(minOffset, maxOffset)
	local dy = math.random(minOffset, maxOffset)
	sendMove(p.x + dx, p.y + dy)
	hs.timer.doAfter(math.random() * (maxHold - minHold) + minHold, function()
		sendMove(p.x, p.y)
	end)
end

-- schedule next jiggle at random interval
local function scheduleNext()
	local interval = math.random(minInterval, maxInterval)
	jiggleTimer = hs.timer.doAfter(interval, function()
		humanJiggle()
		scheduleNext()
	end)
end

-- toggle on/off
local function toggleJiggle()
	if running then
		if jiggleTimer then
			jiggleTimer:stop()
		end
		hs.alert.show("Mouse jiggler: OFF")
		running = false
	else
		scheduleNext()
		hs.alert.show("Mouse jiggler: ON")
		running = true
	end
end

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "J", toggleJiggle)
