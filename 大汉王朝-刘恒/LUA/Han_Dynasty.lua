include("UtilityFunctions")  
include("FLuaVector.lua")  
include("PlotIterators.lua")  
local Han_civili = GameInfoTypes["CIVILIZATION_Han_Dynasty"]
local POLICY_Han_Dynasty_ID = GameInfo.Policies["POLICY_Han_Dynasty"].ID
function GiveHanDynastyPolicy(playerID)
    local player = Players[playerID]
    if player == nil then
        return
    end
    if player:IsBarbarian() or player:IsMinorCiv() then
        return
    end
    if player:GetCivilizationType() == Han_civili then
        if not player:HasPolicy(POLICY_Han_Dynasty_ID) then
            player:SetHasPolicy(POLICY_Han_Dynasty_ID, true, true)
            print("大汉王朝政策已赋予")
        end
    end
end
GameEvents.PlayerCityFounded.Add(GiveHanDynastyPolicy)
local YIELD_CONFIG = {
    [GameInfoTypes.ERA_ANCIENT] = { faith = 3, culture = 3 },
    [GameInfoTypes.ERA_CLASSICAL] = { faith = 6, culture = 6 },
    [GameInfoTypes.ERA_MEDIEVAL] = { faith = 9, culture = 9 },
    [GameInfoTypes.ERA_RENAISSANCE] = { faith = 16, culture = 16 },
    [GameInfoTypes.ERA_INDUSTRIAL] = { faith = 32, culture = 32 },
    [GameInfoTypes.ERA_MODERN] = { faith = 64, culture = 64 },
    [GameInfoTypes.ERA_WORLDWAR] = { faith = 128, culture = 128 },
    [GameInfoTypes.ERA_POSTMODERN] = { faith = 200, culture = 200 },
    [GameInfoTypes.ERA_INFORMATION] = { faith = 250, culture = 250 },
    [GameInfoTypes.ERA_FUTURE] = { faith = 300, culture = 300 }
}
function GetGameSpeedModifier()
    local gameSpeedType = Game.GetGameSpeedType()
    local speedInfo = GameInfo.GameSpeeds[gameSpeedType]
    if speedInfo.Type == "GAMESPEED_QUICK" then
        return 0.5 
    elseif speedInfo.Type == "GAMESPEED_STANDARD" then
        return 1.0  
    elseif speedInfo.Type == "GAMESPEED_EPIC" then
        return 1.5  
    elseif speedInfo.Type == "GAMESPEED_MARATHON" then
        return 2.0  
    else
        return 1.0 
    end
end
function OnHanBuildingCompleted(playerID, buildingID, cityID)
    local player = Players[playerID]
    for city in player:Cities() do  
        if player:GetCivilizationType() == GameInfoTypes.CIVILIZATION_Han_Dynasty and
        city:IsHasBuilding(GameInfoTypes.BUILDING_QuanNongTing) then
            local era = player:GetCurrentEra()
            local baseYields = YIELD_CONFIG[era] or { faith = 10, culture = 10 }
            local speedModifier = GetGameSpeedModifier()
            local faithYield = math.floor(baseYields.faith * speedModifier)
            local cultureYield = math.floor(baseYields.culture * speedModifier)
            player:ChangeFaith(faithYield)
            player:ChangeJONSCulture(cultureYield) 
            local cityName = city:GetName()
            player:AddNotification(
                NotificationTypes.NOTIFICATION_GENERIC,
                "城市 [" .. cityName .. "] 获得了 " .. faithYield .. " 点[ICON_PEACE]信仰和 " .. cultureYield .. " 点[ICON_CULTURE]文化",
                "上天赐予我大汉文明的祝福",
                city:GetX(),
                city:GetY()
            )
        end
    end
end
GameEvents.PlayerBuilt.Add(OnHanBuildingCompleted)
GameEvents.PlayerDoTurn.Add(function(playerID)
    local player = Players[playerID]
    if player:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_Han_Dynasty then
        return  
    end
    local buildingCount = 0
    for city in player:Cities() do
        if city:IsHasBuilding(GameInfoTypes.BUILDING_YuShiTai) then
            buildingCount = buildingCount + 1
        end
    end
    if buildingCount == 0 then
        return
    end
    for city in player:Cities() do
        for i = 1, buildingCount do
            city:SetNumRealBuilding(GameInfoTypes.BUILDING_YuShiTai_1, i)
        end
    end
end)