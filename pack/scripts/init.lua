--Tracker:AddLocations("locations/dlcQuest.json")
--Tracker:AddLocations("locations/liveFreemiumOrDie.json")

Tracker:AddMaps("maps/dlcQuest.json")
Tracker:AddMaps("maps/liveFreemiumOrDie.json")

Tracker:AddItems("items/dlcQuest.json")
Tracker:AddItems("items/liveFreemiumOrDie.json")
Tracker:AddItems("items/settings.json")

Tracker:AddLayouts("layouts/itemsDLC.json")
Tracker:AddLayouts("layouts/itemsLFOD.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/layout.json")
Tracker:AddLayouts("layouts/tracker.json")

if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/archipelago.lua")
end