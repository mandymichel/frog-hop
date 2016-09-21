
local sndJump = audio.loadSound("audio/boing.mp3")

local function playAudio()
	audio.play(sndJump)
end

Runtime: addEventListener("tap", playAudio)