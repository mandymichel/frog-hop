-- Project: GameDev-02- DisplayAnimate
-- Copyright 2012 Three Ring Ranch
-- http://MasteringCoronaSDK.com

display.setStatusBar(display.HiddenStatusBar)

centerX = display.contentWidth *.5
centerY = display.contentHeight * .5

local bg = display.newImageRect("images/bg_iPhone.png", display.contentWidth, display.contentHeight)
bg.x = centerX
bg.y = centerY

local pads = {}
local idx = 0
for vVal = 1, 4 do
	for hVal = 1, 6 do
		idx = idx + 1
		local pad = display.newImageRect("images/lilypad_green.png", 64, 64)
		pad: rotate(math.random(0, 359))
		pad.x = (hVal * 75) - 23
		pad.y = (vVal * 70)
		local sizer = 1 + math.random(-1, 1) / 10
		pad: scale(sizer, sizer)
		pads[idx] = pad
		pads[idx].idx = idx
	end
end


local frog = display.newImageRect("images/frog.png", 64, 95)
frog.x = 52
frog.y = 70
frog.alpha = .5

local transOpts

transition.to (frog, {delay = 1000, time = 2000, x = 427, y = 280, transition = easing.inOutQuad})

