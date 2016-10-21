local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- UPDATE use widgets instead of buttoncode
local widget = require("widget")
require("buttoncode")

-- local forward references should go here --
local frogJumpSpeed = 600

local pads = {}
local idx = 0
local frog
local fly

local scoreLabel
local scoreObj
local score = 0

local function addToScore (num)
	score = score + num
	scoreObj.text = score
	scoreObj: setReferencePoint(display.CenterLeftReferencePoint)
end

local function resetScore()
	score = 0
	addToScore(0)
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
		local function hopSound()
			playSFX(sndJump)
		end
		timer.performWithDelay (frogJumpSpeed / 4, hopSound)
		addToScore(10)
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


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
local bg = display.newImageRect("images/bg_iPhone.png", display.contentWidth, display.contentHeight)
bg.x = centerX
bg.y = centerY
group: insert(bg)

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
 		group: insert(pad)
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
group: insert(frog)

fly = display.newImageRect("images/fly.png", 32, 22)
fly.x = centerX
fly.y = 15
fly: addEventListener ("touch", flyTouched)
group: insert(fly)

Runtime: addEventListener ("orientation", deviceOrientation)

playMusic()

scoreLabel = display.newText("Score:   ", 0, 0, native.systemFont, 18)
scoreLabel.x = 380
scoreLabel.y = 10
scoreLabel: addEventListener("tap", resetScore)
group: insert(scoreLabel)

scoreObj = display.newText (tostring(score), 0, 0, native.systemFont, 18)
scoreObj: setReferencePoint(display.CenterLeftReferencePoint)
scoreObj.x = scoreLabel.x + (scoreLabel.width/2)
scoreObj.y = scoreLabel.y
group: insert(scoreObj)

makeButton("Back", 40, 20, buttonHit, "back", group)


	
	
end


-- Called immediately after scene has moved onscreen
function scene:enterScene( event )
        local group = self.view

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


---------------------------------------------------------------------------------

return scene
