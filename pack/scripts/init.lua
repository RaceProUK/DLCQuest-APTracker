Tracker:AddLocations("locations/dlcQuest.json")
Tracker:AddLocations("locations/liveFreemiumOrDie.json")

Tracker:AddMaps("maps/dlcQuest.json")
Tracker:AddMaps("maps/liveFreemiumOrDie.json")

Tracker:AddItems("items/dlcQuest.json")
Tracker:AddItems("items/liveFreemiumOrDie.json")
Tracker:AddItems("items/settings.json")

Tracker:AddLayouts("layouts/itemsDLC.json")
Tracker:AddLayouts("layouts/itemsLFOD.json")
Tracker:AddLayouts("layouts/settings.json")
if Tracker.ActiveVariantUID == "dlc" then
    Tracker:AddLayouts("layouts/layoutDLCQ.json")
    Tracker:AddLayouts("layouts/broadcastDLCQ.json")
elseif Tracker.ActiveVariantUID == "lfod" then
    Tracker:AddLayouts("layouts/layoutLFOD.json")
    Tracker:AddLayouts("layouts/broadcastLFOD.json")
else
    Tracker:AddLayouts("layouts/layout.json")
    Tracker:AddLayouts("layouts/broadcast.json")
end
Tracker:AddLayouts("layouts/tracker.json")

ScriptHost:LoadScript("scripts/logic.lua")
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/archipelago.lua")
end