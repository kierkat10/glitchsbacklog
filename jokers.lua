----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
	key = "buddy_jolly",
	path = "buddy_jolly.png",
	px = 71,
	py = 71
}
SMODS.Sound({
	key = "weezerriff",
	path = "weezerriff.wav"
})
SMODS.Joker{
	name = "gbl_buddy_jolly",
	key = "buddy_jolly",
	config = { extra = { chips = 0, mult = 0, chips_mod = 16, mult_mod = 4 } },
	pos = { x = 0, y = 0 }, -- what coordinate to pull art from in assets file
	display_size = { w = 1 * 71, h = 0.75 * 95 }, -- buddy jolly is square, so this makes the dimensions like square joker
	rarity = 3, -- rarity, starting from common which equals 1, uncommon = 2, etc
	cost = 8, -- self-explanatory
	blueprint_compat = true,
	perishable_compat = false, -- scaling jokers are incompatible with perishable
	atlas = "gbl_buddy_jolly",
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				card.ability.extra.chips,
				card.ability.extra.mult,
				card.ability.extra.chips_mod,
				card.ability.extra.mult_mod
			},
		}
	end,
	calculate = function(self, card, context)
		if context.before and not context.repetition and not context.blueprint then -- if not retriggered and if this isn't bp/bs

			local hand = context.scoring_hand -- get the scoring cards and put them in a table/array called "hand"
			local var = 0 -- new variable called "var" that is 0 for now and will store our total score count
			for i=1, #hand do -- new variable i = 1, and while i is less than the number of cards in "hand" do this
				var = var + hand[i]:get_id() -- get the ith (1st, 2nd) card in hand and add its value to var
			end -- add 1 to i and go back to where it says "for", if the condition is false then continue the code
			-- var now equals the sum of the ranks of all scoring cards
			if var % 4 == 0 then -- if that total modulus 4 is 0, then do the following
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
	path = "atlas_jokers.png",
	px = 71,
	py = 95
}
SMODS.Joker{
	name = "gbl_brick_by_brick",
	key = "brick_by_brick",
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

SMODS.Joker{
	name = "gbl_hotdog", -- name (use prefix)
	key = "hotdog", -- key (don't use prefix)
	config = { extra = { Xmult_mod = 2 } },
	pos = { x = 1, y = 0 }, -- what coordinate to pull art from in assets file, with (0, 0) being top-left
	rarity = 1, -- rarity, starting from common which equals 1, uncommon = 2, etc
	cost = 4, -- how much it costs in-game
	blueprint_compat = true, -- if it can be copied by blueprint
	atlas = "gbl_jokers", -- what smods atlas key thingy to pull from (use prefix)
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				card.ability.extra.Xmult_mod,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult_mod,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult_mod } }
			}
		end
		if
		    context.end_of_round
		    and not context.blueprint
		    and not context.individual
		    and not context.repetition
		    and not context.retrigger_joker
		then
		    G.E_MANAGER:add_event(Event({ 
		            func = function()
		                play_sound("tarot1")
		                card.T.r = -0.2
		                card:juice_up(0.3, 0.4)
		                card.states.drag.is = true
		                card.children.center.pinch.x = true
		                G.E_MANAGER:add_event(Event({
		                    trigger = "after",
		                    delay = 0.3,
		                    blockable = false,
		                    func = function()
		                        G.jokers:remove_card(card)
		                        card:remove()
		                        card = nil
		                        return true
		                    end,
		                }))
		                return true
		            end,
		        }))
		        return {
		            message = localize("k_eaten_ex"),
		            colour = G.C.FILTER,
		        }
		end
	end
}

SMODS.Joker{
	name = "gbl_hotdog_stand", -- name (use prefix)
	key = "hotdog_stand", -- key (don't use prefix)
	config = { extra = {  } },
	pos = { x = 2, y = 0 }, -- what coordinate to pull art from in assets file, with (0, 0) being top-left
	rarity = 3, -- rarity, starting from common which equals 1, uncommon = 2, etc
	cost = 9, -- how much it costs in-game
	blueprint_compat = true, -- if it can be copied by blueprint
	atlas = "gbl_jokers", -- what atlas key (smods atlas thingy stated above) to pull from
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_gbl_hotdog
		return {
			vars = { 
			},
		}
	end,
	calculate = function(self, card, context)
		if context.before and not context.repetition and not context.retrigger_joker and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_gbl_hotdog") -- creates the card in question but puts it in the middle of the screen where it does nothing
			card:add_to_deck() -- puts the card you just created in the metaphorical "deck" of all cards you currently have, consumables and jokers included
			card:start_materialize() -- plays the particle animation when jokers spawn in
			G.jokers:emplace(card) -- puts the card you created in specifically your joker tray so Balatro knows what to do when it gets there
		end
	end
}

SMODS.Joker{
	name = "gbl_pixar_lamp", -- name (use prefix)
	key = "pixar_lamp", -- key (don't use prefix)
	config = { extra = {  } },
	pos = { x = 3, y = 0 }, -- what coordinate to pull art from in assets file, with (0, 0) being top-left
	rarity = "cry_epic", -- rarity, starting from common which equals 1, uncommon = 2, etc
	cost = 14, -- how much it costs in-game
	blueprint_compat = true, -- if it can be copied by blueprint
	atlas = "gbl_jokers", -- what atlas key (smods atlas thingy stated above) to pull from
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_light
		return {
			vars = { 
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint_card
			and not context.retrigger_joker
			and G.GAME.current_round.current_hand.cry_asc_num ~= 0
		then
			local converted = false

			for i = 1, #context.scoring_hand do
				converted = true
				local _card = context.scoring_hand[i] -- Fixed `scoring.hand` typo
				local enhancement = "m_cry_light"
				if _card.ability.effect ~= "Light Card" then
					_card:set_ability(G.P_CENTERS[enhancement], nil, true)
				end
				G.E_MANAGER:add_event(Event({
					delay = 0.6,
					func = function()
						_card:juice_up()
						play_sound("tarot1")
						return true
					end
				}))

			end

			if converted then
				return {message = 'Lit Up!', colour = G.C.FILTER} -- Fixed incorrect `)` to `}`
			end
		end
	end
}


SMODS.Joker{
	name = "gbl_chakra", -- name (use prefix)
	key = "chakra", -- key (don't use prefix)
	pos = { x = 4, y = 0 }, -- what coordinate to pull art from in assets file, with (0, 0) being top-left
	rarity = 3, -- rarity, starting from common which equals 1, uncommon = 2, etc
	cost = 8, -- how much it costs in-game
	blueprint_compat = false, -- if it can be copied by blueprint
	atlas = "gbl_jokers", -- what smods atlas key thingy to pull from (use prefix)
	loc_vars = function(self, info_queue, card)
		return {
			vars = { 
				
			},
		}
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint and not context.retrigger_joker then
			if next(context.poker_hands["Straight Flush"]) and #context.scoring_hand ~= #context.full_hand then
				for k, v in ipairs(context.full_hand) do
					if not SMODS.in_scoring(v, context.scoring_hand) and (not v.edition or v.edition and v.edition.type ~= "e_cry_astral") then
						v:set_edition("e_cry_astral", true)
						G.E_MANAGER:add_event(Event({
							func = function()
								v:juice_up()
								return true
							end
						}))
					end
				end
			end
		end
	end,
}
SMODS.Joker{
    name = "gbl_electric_joker",
    key = "electric_joker",
    pos = { x = 5, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    atlas = "gbl_jokers",
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 and 
           context.scoring_name == "Pair" and #context.full_hand == 2 and not context.blueprint then
            
            local card1 = context.full_hand[1]
            local card2 = context.full_hand[2]
            
            local possible_swaps = {}
            
            local enh1 = SMODS.get_enhancements(card1) or {}
            local enh2 = SMODS.get_enhancements(card2) or {}
            if next(enh1) and next(enh2) then
                table.insert(possible_swaps, "enhancement")
            end
            
            if card1.edition and card1.edition ~= nil and card1.edition ~= 'Base' and
               card2.edition and card2.edition ~= nil and card2.edition ~= 'Base' then
                table.insert(possible_swaps, "edition")
            end
            
            local seal1 = card1:get_seal(true)
            local seal2 = card2:get_seal(true)
            if seal1 and seal2 then
                table.insert(possible_swaps, "seal")
            end
            
            if #possible_swaps == 0 then
                card_eval_status_text(card, "extra", nil, nil, nil, {message = "Nope!", colour = G.C.PURPLE})
                return true
            end
            
            local swap_type = possible_swaps[math.random(1, #possible_swaps)]
            
            if swap_type == "enhancement" then
                -- Remove existing enhancements
                for k, _ in pairs(enh1) do card1:set_ability(G.P_CENTERS[k], nil, true) end
                for k, _ in pairs(enh2) do card2:set_ability(G.P_CENTERS[k], nil, true) end
                
                for k, v in pairs(enh2) do card1:set_ability(G.P_CENTERS[k], v, true) end
                for k, v in pairs(enh1) do card2:set_ability(G.P_CENTERS[k], v, true) end
                
            elseif swap_type == "edition" then
                local ed1 = card1.edition
                local ed2 = card2.edition
                card1:set_edition(ed2, true, true)
                card2:set_edition(ed1, true, true)
                
            elseif swap_type == "seal" then
                card1:set_seal(seal2, true, true)
                card2:set_seal(seal1, true, true)
            end
            
            card_eval_status_text(card, "extra", nil, nil, nil, {message = "Swapped "..swap_type.."!", colour = G.C.FILTER})
            return true
        end
        return nil
    end
}

SMODS.Joker{
    name = "gbl_inequality_alligator",
    key = "inequality_alligator",
    pos = { x = 6, y = 0 },
    rarity = 3,
    cost = 9,
    config = { extra = { mult = 0 } },
    blueprint_compat = true,
    atlas = "gbl_jokers",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.after and not context.repetition and not context.blueprint then
            local hand = context.scoring_hand
            if #hand < 2 then return end

            -- Find all valid cards (non-debuffed)
            local valid_cards = {}
            for _, hand_card in ipairs(hand) do
                if not hand_card.debuff then
                    table.insert(valid_cards, hand_card)
                end
            end

            -- Proceed only if we have at least 2 valid cards
            if #valid_cards < 2 then return end

            -- Find highest rank among valid cards
            local ranks = {}
            local highest_rank = 0
            local highest_card = nil
            
            for _, hand_card in ipairs(valid_cards) do
                local rank = hand_card:get_id()
                ranks[rank] = true
                
                if rank > highest_rank then
                    highest_rank = rank
                    highest_card = hand_card
                end
            end

            -- Check if we have at least 2 different ranks
            local unique_ranks = 0
            for _ in pairs(ranks) do unique_ranks = unique_ranks + 1 end

            if unique_ranks >= 2 and highest_card then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        highest_card:start_dissolve()
                        card.ability.extra.mult = card.ability.extra.mult + highest_rank
                        card_eval_status_text(
                            card,
                            "extra",
                            nil,
                            nil,
                            nil,
                            { message = "Consumed!", colour = G.C.RED }
                        )
                        return true
                    end
                }))
            end
        end

        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
        return nil
    end
}

----------------------------------------------
------------MOD CODE END----------------------
