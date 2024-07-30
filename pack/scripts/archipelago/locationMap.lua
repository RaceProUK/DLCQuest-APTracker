LocationMap = {
    [120000] = { "Shopkeep", "Movement Pack", 4 },
    [120001] = { "Shopkeep", "Animation Pack", 5 },
    [120002] = { "Shopkeep", "Audio Pack", 5 },
    [120003] = { "Shopkeep", "Pause Menu Pack", 5 },
    [120004] = { "Grindstone", "Time is Money Pack", 20 },
    [120005] = { "Double Jump Platforms", "Double Jump Pack", 100 },
    [120006] = { "Westernmost Cave", "Pet Pack", 5 },
    [120007] = { "Sexy Outfits Alcove", "Sexy Outfits Pack", 5 },
    [120008] = { "Top Hat Platform", "Top Hat Pack", 5 },
    [120009] = { "Area Transition (West)", "Map Pack", 240 },
    [120010] = { "Troll", "Gun Pack", 75 },
    [120011] = { "Zombie Alcove", "The Zombie Pack", 5 },
    [120012] = { "Area Transition (East)", "Night Map Pack", 75 },
    [120013] = { "Random Encounter", "Psychological Warfare Pack", 50 },
    [120014] = { "Armor for your Horse Pack", "Armor for your Horse Pack", 250 },
    [120015] = { "Easternmost Tunnel", "Finish the Fight Pack", 5 },

    [120016] = { "Particles Pack", "Particles Pack", 5 },
    [120017] = { "Day One Patch & Checkpoints", "Day One Patch Pack", 5 },
    [120018] = { "Day One Patch & Checkpoints", "Checkpoint Pack", 5 },
    [120019] = { "Incredibly Important Pack", "Incredibly Important Pack", 15 },
    [120020] = { "Wall Jump Pack", "Wall Jump Pack", 35 },
    [120021] = { "Health Bar Pack", "Health Bar Pack", 5 },
    [120022] = { "Parallax Pack", "Parallax Pack", 5 },
    [120023] = { "Harmless Plants Pack", "Harmless Plants Pack", 130 },
    [120024] = { "Death of Comedy Pack", "Death of Comedy Pack", 15 },
    [120025] = { "Canadian Dialog Pack", "Canadian Dialog Pack", 10 },
    [120026] = { "DLC NPC Pack", "DLC NPC Pack", 15 },
    [120027] = { "Cut Content Pack", "Cut Content Pack", 40 },
    [120028] = { "Name Change Pack", "Name Change Pack", 150 },
    [120029] = { "Season Pass", "Season Pass", 199 },
    [120030] = { "High Definition Next Gen Pack", "High Definition Next Gen Pack", 20 },
    [120031] = { "Increased HP Pack", "Increased HP Pack", 10 },
    [120032] = { "Remove Ads Pack", "Remove Ads Pack", 25 },

    [120033] = { "Final Boss", "Big Sword Pack" },
    [120034] = { "Final Boss", "Really Big Sword Pack" },
    [120035] = { "Final Boss", "Unfathomable Sword Pack" },

    [120036] = { "Pickaxe", "Pickaxe" },
    [120037] = { "Gunsmith", "Gun" },
    [120038] = { "Grindstone", "Sword" },
    [120039] = { "Wooden Sword", "Wooden Sword" },
    [120040] = { "Box of Various Supplies", "Box of Various Supplies" },
    [120041] = { "Humble Indie Bindle", "Humble Indie Bindle" },

    [120042] = { "Double Jump Platforms", "Double Jump Alcove Sheep" },
    [120043] = { "Double Jump Platforms", "Double Jump Floating Sheep" },
    [120044] = { "Sexy Outfits Alcove", "Sexy Outfits Sheep" },
    [120045] = { "Forest", "Forest High Sheep" },
    [120046] = { "Forest", "Forest Low Sheep" },
    [120047] = { "Between Trees", "Between Trees Sheep" },
    [120048] = { "Hole in the Wall", "Hole in the Wall Sheep" },
    [120049] = { "Shepherd", "Shepherd Sheep" },
    [120050] = { "Top Hat Platform", "Top Hat Sheep" },
    [120051] = { "North West", "North West Ceiling Sheep" },
    [120052] = { "North West", "North West Alcove Sheep" },
    [120053] = { "Westernmost Cave", "West Cave Sheep" },
    [120054] = { "Cutscene Platform", "Cutscene Sheep" },

    [120055] = { "Spike Pit", "Not Exactly Noble" },
    [120056] = { "DLC NPC", "Story is Important" },
    [120057] = { "Cheats", "Nice Try" },
    [120058] = { "Comedian", "I Get That Reference!" }
}

for i = 1,825 do
    LocationMap[120058 + i] = { "DLCQ Coinsanity", "Coin Bundle" }
end

for i = 1,889 do
    LocationMap[120058 + 825 + i] = { "LFOD Coinsanity", "Coin Bundle" }
end