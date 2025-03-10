-- a file specificlaly to load all other lua files in the mod (and for config stuff)
-- probably redundant, but it's easier on me to do this instead of asserting all files like a path

assert(SMODS.load_file('jokers.lua'))()
assert(SMODS.load_file('decks.lua'))()

glitchsbacklog_config = SMODS.current_mod.config

local glitchsbacklogConfigTab = function()
	gbl_nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				--{n=G.UIT.O, config={object = DynaText({string = "", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
			},
		},
	}
	settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	settings.nodes[#settings.nodes + 1] = create_toggle({
		active_colour = G.C.RED,
		label = "Buddy Jolly SFX",
		ref_table = glitchsbacklog_config.glitchsbacklog,
		ref_value = "buddyjolly_music",
	})
	config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
	gbl_nodes[#gbl_nodes + 1] = config
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = gbl_nodes,
	}
end

SMODS.current_mod.config_tab = glitchsbacklogConfigTab
