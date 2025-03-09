-- a file specificlaly to load all other lua files in the mod
-- probably redundant, but it's easier on me to do this instead of asserting all fiels like a path

assert(SMODS.load_file('jokers.lua'))()
assert(SMODS.load_file('decks.lua'))()
