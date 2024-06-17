function HiddenPlantsPackAccessible()
    local hpp = Tracker:FindObjectForCode("PackHarmlessPlants")
    local ncp = Tracker:FindObjectForCode("PackNameChange")
    return hpp and ncp and (ncp.Active or not hpp.Active)
end