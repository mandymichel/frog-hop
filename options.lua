local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- UPDATE use widgets instead of buttoncode
local widget = require("widget")
require("buttoncode")

-- local forward references should go here --

local function buttonHit(parm)
	storyboard.gotoScene ( parm, { effect="slideUp" } )
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local bg = display.newImageRect("images/bg_iPhone.png", 480, 320)

	bg.x = centerX
	bg.y = centerY
	group: insert(bg)

	local title = display.newText(group, "Options", centerX, centerY, "Helvetica", 48)
	title.x = centerX
	title.y = centerY - 50

	makeButton("Back", 40, display.contentHeight - 20, buttonHit, "back", group)
	
end


-- Called immediately after scene has moved onscreen:
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
