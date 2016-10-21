-- Project: GameDev-02- DisplayAnimate
-- Copyright 2012 Three Ring Ranch
-- http://MasteringCoronaSDK.com
-- Project: GameDev-02- DisplayAnimate
-- Copyright 2012 Three Ring Ranch
-- http://MasteringCoronaSDK.com
local storyboard = require("storyboard")

local GGdata = require("GGdata") 

display.setStatusBar(display.HiddenStatusBar)

centerX = display.contentWidth *.5
centerY = display.contentHeight * .5

local prefs = GGdata:new("preferences")

musicIsPlaying = true
SFXisPlaying = true


local function loadPrefs()
	prefs: load()
	musicIsPlaying = prefs.musicIsPlaying
	SFXisPlaying = prefs.SFXisPlaying
end

function savePrefs()
	prefs.musicIsPlaying = musicIsPlaying
	prefs.SFXisPlaying = SFXisPlaying
	prefs:save()
end

-- local path
-- local file
-- local data = "Blah blah blah"

-- local score = 140

-- --path = system.pathForFile ("highscore.txt", system.DocumentsDirectory)
-- --file = io.open (path, "a")
-- --file: write(score .."\n")
-- --io.close(file)

-- local savedData

-- path = system.pathForFile ("story.txt", system.ResourceDirectory)
-- file = io.open (path, "r")
-- savedData = file: read("*a")
-- io.close(file)

-- local myText = display.newText(savedData, 10, 10, display.contentWidth - 20, 0, native.systemFont, 16)

-- --print(savedData)

-- path = system.pathForFile ("highscore.txt", system.DocumentsDirectory)
-- file = io.open (path, "r")
-- local idx = 1
-- for x in file: lines() do
-- 	--display.newText(tostring(x), 100, 40 * idx, "Helvetica", 24)
-- 	idx = idx + 1
-- end
-- io.close(file)

-- --load a text file and return it as a string
-- local function loadTextFile (fname, base)
-- 	base = base or system.ResourceDirectory
-- 	local path = system.pathForFile (fname, base)
-- 	local txtData
-- 	local file = io.open(path, "r")
-- 	if file then
-- 		txtData = file:read("*a")
-- 		io.close(file)
-- 	end
-- 	return txtData
-- end
-- savedData = loadTextFile("story.txt")
-- print(savedData)

-- local scores = GGdata:new(1, "gamescores")
-- -- scores.playername = "Mandy"
-- -- local gamescores = {30, 50, 150, 60, 200}
-- -- scores.highscores = gamescores
-- -- scores: save()
-- -- print(scores.playername)

-- local myData = scores.highscores
-- print (myData[1], myData[2], myData[5])

audio.reserveChannels(1)

sndChanMusic = 1
--sndChanSFX = 2

local sndBuhBuh = audio.loadSound("audio/bubububuh.mp3")
local sndWhip = audio.loadSound("audio/whip.mp3")
local sndYip = audio.loadSound("audio/yipyip.mp3")
local sndWhoo = audio.loadSound("audio/whoo.mp3")
local sndJump = audio.loadSound("audio/boing.mp3")
local sndMusic = audio.loadStream("audio/HappyPants.wav")

local allSFX = {sndBuhBuh, sndWhip, sndYip, sndWhoo, sndJump}

function playSFX(audioHandle, opt)
	local options = opt or {}
	local loopNum = options.loop or 0
	local channel = options.channel or 0
	local chanUsed = nil
	if SFXisPlaying then
		chanUsed = audio.play(audioHandle, {channel = channel, loops = loopNum})
	end
	return chanUsed
end

function playMusic()
		if musicIsPlaying then
			audio.play(sndMusic, {channel=sndChanMusic, loops = -1})
			audio.setVolume(1, {channel = sndChanMusic})			
		end
end

local function playSound(audioObj, chn)
	local chanUsed = nil

	if audioIsPlaying then
		chanUsed = audio.play( audioObj, {channel = chn})
	end
	return chanUsed
end

local function resetMusic(e)
	if e.completed == "false" and e.phase == "stopped" then
		audio.setVolume(.25, {channel = sndChanMusic})
		audio.rewind(sndMusic)
	end
end

local function makeButton(title, xPos, yPos, listener, action)
   local btn = widget.newButton( {label=title, onRelease=listener} )
   btn.action = action
   btn.x = xPos
   btn.y = yPos
end

--makeButton("Play Music", centerX-100, 80, playMusic, "play")
--makeButton("Stop & Rewind", centerX-100, 20, playMusic, "stop")
--makeButton("Fade Out", centerX-100, 60, playMusic, "fade out")


--for x = 1, #allSFX do
--	makeButton("Play SFX", centerX + 100, 40 +(40*x), playSFX, allSFX[x])
--end


loadPrefs()

storyboard.gotoScene ("menu", {effect = "zoomOutInRotate"})