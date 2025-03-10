SMODS.Atlas {
	key = "buddyjolly",
	path = "buddyjolly.png",
	px = 71,
	py = 71
}
SMODS.Sound({
	key = "weezerriff",
	path = "weezerriff.wav"
})
SMODS.Joker{
	name = "gbl_buddyjolly",
	key = "buddyjolly",
	dependencies = {
		items = { "set_cry_m" } -- buddy jolly is an m joker
	},
	config = { extra = { chips = 0, mult = 0, chips_mod = 20, mult_mod = 4, jollies = 4 } },
	pos = { x = 0, y = 0 }, -- what coordinate to pull art from in assets file
	display_size = { w = 1 * 71, h = 0.75 * 95 }, -- buddy jolly is square, so this makes the dimensions like square joker
	rarity = 3, -- rarity, starting from common which equals 1, uncommon = 2, etc
	cost = 8, -- self-explanatory
	blueprint_compat = true,
	perishable_compat = false, -- scaling jokers are incompatible with perishable
	atlas = "gbl_buddyjolly",
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				card.ability.extra.chips,
				card.ability.extra.mult,
				card.ability.extra.chips_mod,
				card.ability.extra.mult_mod,
				card.ability.extra.jollies, -- used for the jolly joker condition
			},
		}
	end,
	loc_txt = {
		name = 'Buddy Jolly',
		text = {
			"If {C:attention}scored cards'{} values add up to a multiple of {C:attention}4{},",
			"this Joker gains {C:chips}+#3#{} Chips and {C:mult}+#4#{} Mult",
			"Always scales if you have {C:attention}4{} or more {C:attention}Jolly Jokers{}",
			"{C:inactive,s:0.8}(J = 11, Q = 12, K = 13, A = 14){}",
			"{C:inactive}(Currently {C:chips}+#1#{} {C:inactive}and{} {C:mult}+#2#{} {C:inactive}Mult){}"
		}
	},
	calculate = function(self, card, context)
		if context.before and not context.repetition and not context.blueprint then -- if not retriggered and if this isn't bp/bs
			local jollycount = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:is_jolly() then
					jollycount = jollycount + 1
				end
			end

			local hand = context.scoring_hand -- get the scoring cards and put them in a table/array called "hand"
			local var = 0 -- new variable called "var" that is 0 for now and will store our total score count
			for i=1, #hand do -- new variable i = 1, and while i is less than the number of cards in "hand" do this
				var = var + hand[i]:get_id() -- get the ith (1st, 2nd) card in hand and add its value to var
			end -- add 1 to i and go back to where it says "for", if the condition is false then continue the code
			-- var now equals the sum of the ranks of all scoring cards
			if var % 4 == 0 or (jollycount >= card.ability.extra.jollies) then -- if that total modulus 4 is 0 or there are 4 or more jolly jokers, then do the following
				-- anything in here will run if the cards ranks are divisible by 4
				card_eval_status_text(card, "extra", nil, nil, nil, {message = "Upgrade!", colour = G.C.FILTER}) -- upgrade text
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod -- mult scaling
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod -- chip scaling
			end
		end
		if context.joker_main then -- when scoring, score the chips and mult that we just scaled
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips
			}
		end
	end,
	add_to_deck = function ()
		if glitchsbacklog_config.glitchsbacklog and glitchsbacklog_config.glitchsbacklog.buddyjolly_music then
			play_sound("gbl_weezerriff")
		end
	end
}

SMODS.Atlas {
	key = "jokers",
	path = "atlasjokers.png",
	px = 71,
	py = 95
}
SMODS.Joker{
	name = "gbl_brickbybrick",
	key = "brickbybrick",
	config = { extra = { Xmult = 0.25, played_hand = {} } },
	pos = { x = 0, y = 0 }, -- what coordinate to pull art from in assets file, with (0, 0) being top-left
	rarity = 3, -- rarity, starting from common which equals 1, uncommon = 2, etc
	cost = 7, -- self-explanatory
	blueprint_compat = true,
	atlas = "gbl_jokers",
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				card.ability.extra.Xmult,
			},
		}
	end,
	loc_txt = {
		name = 'Brick by Brick',
		text = {
			"One random scored card in {C:attention}winning hand{} permanently",
			"gains {X:mult,C:white}X#1#{} Mult"
		}
	},
	calculate = function(self, card, context)
		if context.before then
			print("set scoring hand")
			card.ability.extra.played_hand = context.scoring_hand
		end
		if context.end_of_round and not context.game_over and card.ability.extra.played_hand then
			local chosen_card = pseudorandom_element(card.ability.extra.played_hand, pseudoseed('brickbybrick'))
			if chosen_card then
				chosen_card.ability.perma_x_mult = (chosen_card.ability.perma_x_mult or 1) + card.ability.extra.Xmult
				card_eval_status_text(chosen_card, "extra", nil, nil, nil, {
					message = localize('k_upgrade_ex'),
					colour = G.C.MULT,
				})
				card.ability.extra.played_hand = {}
			end
		end
	end
}

----------------------------------------------
------------MOD CODE END----------------------
