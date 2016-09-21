-- Project: GameDev-02- DisplayAnimate
-- Copyright 2012 Three Ring Ranch
-- http://MasteringCoronaSDK.com

local widget = require ("widget")

local pads = {}
local idx = 0
local frog
local frogJumpSpeed = 600
local fly
local audioIsPlaying = true

local centerX = display.contentWidth *.5
local centerY = display.contentHeight * .5

audio.reserveChannels(2)

sndChanMusic = 1
sndChanSFX = 2

local sndBuhBuh = audio.loadSound("audio/bubububuh.mp3")
local sndWhip = audio.loadSound("audio/whip.mp3")
local sndYip = audio.loadSound("audio/yipyip.mp3")
local sndWhoo = audio.loadSound("audio/whoo.mp3")
local sndJump = audio.loadSound("audio/boing.mp3")
local sndMusic = audio.loadStream("audio/HappyPants.wav")

local allSFX = {sndBuhBuh, sndWhip, sndYip, sndWhoo, sndJump}

local function playSound(audioObj, chn)
	local chanUsed = nil

	if audioIsPlaying then
		chanUsed = audio.play( audioObj, {channel = chn})
	end
	return chanUsed
end

local function resetMusic(e)
	if e.completed == "false" and e.phase == "stopped" then
		audio.setVolume(1, {channel = musicChannel})
		audio.rewind(sndMusic)
	end
end

local function playMusic(event)
	local action = event.target.action
	if action == "play" then
		if audioIsPlaying then
			audio.play(sndMusic, {channel=sndChanMusic, onComplete= resetMusic})
		end
	elseif action == "stop" then
		audio.stop(sndChanMusic)
		audio.rewind(sndChanMusic)
	elseif action == "fade out" then
		audio.fadeOut ({channel= sndChanMusic, time= 3000})
	end
end

local function makeButton(title, xPos, yPos, listener, action)
   local btn = widget.newButton( {label=title, onRelease=listener} )
   btn.action = action
   btn.x = xPos
   btn.y = yPos
end

makeButton("Play Music", centerX-100, 80, playMusic, "play")
makeButton("Stop & Rewind", centerX-100, 20, playMusic, "stop")
makeButton("Fade Out", centerX-100, 60, playMusic, "fade out")

local function playSFX(event)
	local snd = event.target.action
	playSound(snd, 0)
end

for x = 1, #allSFX do
	makeButton("Play SFX", centerX + 100, 40 +(40*x), playSFX, allSFX[x])
end

local function buttonHit(target)
	playMusic(target)
end

local function hopDone(obj)
	local function killPad(lpobj)
		display.remove (lpobj)
	end
	transition.to (pads[1], {time = 1000, alpha = 0, xScale = .1, yScale = .1, rotation = 360, onComplete = killPad})
end

local function frogTapped (event)
	print("Croak!")
	transition.to(event.target, {rotation = 360, delta = true})
end

local function padTouched (event)
	local pad = event.target
	if event.phase == "ended" then
		local angleBetween = math.ceil(math.atan2((pad.y - frog.y), (pad.x - frog.x)) * 180 / math.pi) + 90
		frog.rotation = angleBetween
		transition.to (frog, {time = frogJumpSpeed, x = pad.x, y = pad.y, transition = easing.InOutQuad})
	end
end

local function flyTouched (event)
	local obj = event.target
	if event.phase == "began" then
		display.getCurrentStage(): setFocus(obj)
		obj.startMoveX = obj.x
		obj.startMoveY = obj.y
	elseif event.phase == "moved" then
		obj.x = (event.x - event.xStart) + obj.startMoveX
		obj.y = (event.y - event.yStart) + obj.startMoveY
	elseif event.phase == "ended" or event.phase == "cancelled" then
		display.getCurrentStage(): setFocus(nil)


end
return true
end

local bg = display.newImageRect("images/bg_iPhone.png", display.contentWidth, display.contentHeight)
bg.x = centerX
bg.y = centerY

for vVal = 1, 4 do
	for hVal = 1, 6 do
		idx = idx + 1
		local pad = display.newImageRect("images/lilypad_green.png", 64, 64)
		pad: rotate(math.random(0, 359))
		pad.x = (hVal * 75) - 23
		pad.y = (vVal * 70)
		local sizer = 1 + math.random(-1, 1) / 10
		pad: scale(sizer, sizer)
		pad: addEventListener("touch", padTouched)
		pads[idx] = pad
		pads[idx].idx = idx
	end
end
local function deviceOrientation (event)
	print(event.type)
end

local function touchedFrog (event)
	print(event.target.name .. " says, 'Ouch'")
	print(event.phase)
end

frog = display.newImageRect("images/frog.png", 64, 95)
frog.x = 52
frog.y = 70
frog.name = "Gladys"

frog: addEventListener ("tap", frogTapped)

fly = display.newImageRect("images/fly.png", 32, 22)
fly.x = centerX
fly.y = 15
fly: addEventListener ("touch", flyTouched)

makeButton("Play", centerX, 80, buttonHit, "play")


Runtime: addEventListener ("orientation", deviceOrientation)

