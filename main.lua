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
		ref_value = "buddyjollysfx",
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

SMODS.current_mod.credits_tab = function()

	local text_scale = 0.9
	chosen = true
	return {
		n = G.UIT.ROOT,
		config = { align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10 },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0.1, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1 },
				nodes = {
					{
				n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = 'Special thanks to', scale = text_scale * 0.6, colour = G.C.GOLD, shadow = true } },
						}
					},
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = 'George the Rat - Created the art for most Jokers', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
						}
					},
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = 'AlexSC - Helped a massive amount with coding this mod', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
						}
					},
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = 'Astrapboy - Same as AlexSC; thank you!', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
						}
					},
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = 'Cryptid Community - Thank you all so much for the help!', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
						}
					},
				}
			}
		}
	}
end

SMODS.current_mod.config_tab = glitchsbacklogConfigTab
