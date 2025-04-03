----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas { -- creates an atlas for cards to use
	key = "decks", -- key for code to find
	path = "atlas_decks.png", -- name of the file, for the code to pull the atlas from
	px = 71, -- width of each sprite in 1x size
	py = 95 -- height of each sprite in 1x size
}

SMODS.Back{ -- making a deck, "Back" basically = deck
	name = "Weezer Deck", -- name of deck
	key = "weezer", -- name for code to refer to
	pos = { x = 0, y = 0 }, -- what coordinate to pull art from in assets file
	atlas = "decks", -- what art key to pull from
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					local newcard = SMODS.add_card{key="j_gbl_buddy-jolly"} -- makes buddy jolly on start
					newcard:set_eternal(true) -- makes the buddy jolly eternal
				end -- ends "if G.jokers"
				return true -- from math: Events require you to return true to let them know you finished. If you didn't do it, it would loop forever and keep creating Buddy Jollies
			end, -- ends "func = function()"
		}))
	end,
}