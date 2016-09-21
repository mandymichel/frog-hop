local function makeButton(title, xPos, yPos, listener, action)
   local btn = widget.newButton( {label=title, onRelease=listener} )
   btn.action = action
   btn.x = xPos
   btn.y = yPos
end