return {
	descriptions = {
		Back = {
			b_gbl_weezer = {
				name = "Weezer Deck",
        			text = {
            				"Start with an eternal",
					"{C:attention}Buddy Jolly{}",
				},
			},
			b_gbl_hyperspace = {
				name = "Hyperspace Deck",
        			text = {
            				"{C:attention}+1 Ascension Power{}",
					"to all poker hands",
					"and {C:attention}+1{} card selection",
					"limit when {C:attention}Boss Blind{}",
					"defeated",
				},
			},
		},
		Joker = {
			j_gbl_buddy_jolly = {
				name = "Buddy Jolly",
				text = {
					"If {C:attention}scored cards'{} values add up to a multiple of {C:attention}4{},",
					"this Joker gains {C:chips}+#3#{} Chips and {C:mult}+#4#{} Mult",
					"{C:inactive,s:0.8}(J = 11, Q = 12, K = 13, A = 14){}",
					"{C:inactive}(Currently {C:chips}+#1#{} {C:inactive}and{} {C:mult}+#2#{} {C:inactive}Mult){}",
				},
			},
			j_gbl_brick_by_brick = {
				name = "Brick by Brick",
				text = {
					"One random scored card in {C:attention}winning hand{}",
					"permanently gains {X:mult,C:white}X#1#{} Mult",
					"{C:inactive}I built this shit, brick by brick!{}",
				},
			},
			j_gbl_hotdog = {
				name = 'Hotdog',
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"Destroyed at end of round",
				},
			},
			j_gbl_hotdog_stand = {
				name = 'Hotdog Stand',
				text = {
					"Create a {C:attention}Hotdog{}",
					"when hand is played",
					"{C:inactive}(Must have room){}",
				},
			},
			j_gbl_pixar_lamp = {
				name = 'Pixar Lamp',
				text = {
					"If played hand is {C:attention}Ascended{},",
					"make all scored cards {C:attention}Light{} cards",
				},
			},
			j_gbl_chakra = {
				name = 'Chakra',
				text = {
					"If played hand contains",
					"a {C:attention}Straight Flush{}, make all",
					"unscored cards {C:dark_edition}Astral{}"
				}
			},
			j_gbl_electric_joker = {
				name = 'Electric Joker',
				text = {
					"If {C:attention}played hand{} has only {C:attention}two{} cards and",
					"is a {C:attention}Pair{}, swap one random {C:attention}modification{}",
					"between the two cards",
					"{C:inactive}({}{C:attention}Enhancement{}{C:inactive}, {}{C:attention}Edition{}{C:inactive}, or {}{C:attention}Seal{}{C:inactive}){}",
					
				}
			},
			j_gbl_inequality_alligator = {
				name = 'Inequality Alligator',
				text = {
					"If played hand contains at least two cards of",
					"differing {C:attention}ranks{}, destroy the highest ranked card",
					"and add its {C:attention}rank{} to this Joker's {C:mult}Mult{} after scoring",
					"{C:inactive,s:0.8}(J = 11, Q = 12, K = 13, A = 14){}",
					"{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} Mult){}",
				}
			},

		},
	},
}
