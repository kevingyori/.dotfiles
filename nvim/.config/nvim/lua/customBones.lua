local lush = require "lush"
local base = require "rosebones"

-- Create some specs
local specs = lush.parse(function()
	return {
		Comment { base.Comment, gui = "italic" }, -- setting gui to "italic"
	}
end)

-- Apply specs using lush tool-chain
lush.apply(lush.compile(specs))
