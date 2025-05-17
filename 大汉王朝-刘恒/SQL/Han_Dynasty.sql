INSERT INTO Policy_BuildingClassProductionModifiers (
    PolicyType,
    BuildingClassType,
    ProductionModifier
)
SELECT
    'POLICY_Han_Dynasty', 
    BuildingClass, 
    100 
FROM Buildings
WHERE NumTradeRouteBonus > 0;
INSERT INTO Policy_FreeBuildingClassCapital (PolicyType, BuildingClassType, Count)
VALUES ('POLICY_Han_Dynasty', 'BUILDINGCLASS_Han_Dynasty_1', 1);
INSERT INTO "Building_BuildingClassYieldChanges" (
    "BuildingType",
    "BuildingClassType",
    "YieldType",
    "YieldChange"
)
SELECT 
    'BUILDING_Han_Dynasty_1' AS "BuildingType", 
    "BuildingClass" AS "BuildingClassType", 
    (SELECT "Type" FROM "Yields" WHERE "Type" = 'YIELD_GOLD') AS "YieldType", 
    1 AS "YieldChange" 
FROM "Buildings"
WHERE "Building" IS NOT NULL; 
INSERT INTO "Building_SpecialistYieldChanges" (
    "BuildingType",
    "SpecialistType",
    "YieldType",
    "Yield"
)
SELECT
    'BUILDING_Han_Dynasty_1' AS "BuildingType", 
    "Type" AS "SpecialistType", 
    "YIELD_GOLD" AS "YieldType", 
    1 AS "Yield" 
FROM "Specialists";
INSERT INTO "Policy_ImprovementYieldChanges" (
    "PolicyType",
    "ImprovementType",
    "YieldType",
    "Yield"
)
SELECT
    'POLICY_Han_Dynasty' AS "PolicyType", 
    "Type" AS "ImprovementType", 
    "YIELD_GOLD" AS "YieldType", 
    1 AS "Yield" 
FROM "Improvements";
INSERT INTO Building_CityStateTradeRouteYieldModifiersGlobal (BuildingType, YieldType, Yield)
VALUES ('BUILDING_Han_Dynasty_1', 'YIELD_GOLD', 2),
       ('BUILDING_Han_Dynasty_1', 'YIELD_TOURISM', 2);
INSERT INTO "Building_ResourceYieldChanges" (
    "BuildingType",
    "ResourceType",
    "YieldType",
    "Yield"
)
SELECT
    'BUILDING_SheJiTan' AS "BuildingType", 
    "ResourceType", 
    'YIELD_CULTURE' AS "YieldType", 
    1 AS "Yield" 
FROM "Resource_YieldChanges"
WHERE 
    "YieldType" = 'YIELD_FOOD' AND 
    "Yield" > 0; 
INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
VALUES 
('BUILDING_SheJiTan', 'RESOURCE_FISH', 'YIELD_PRODUCTION', 1),
('BUILDING_SheJiTan', 'RESOURCE_CORAL', 'YIELD_PRODUCTION', 1),
('BUILDING_SheJiTan', 'RESOURCE_CRAB', 'YIELD_PRODUCTION', 1),
('BUILDING_SheJiTan', 'RESOURCE_WHALE', 'YIELD_PRODUCTION', 1),
('BUILDING_SheJiTan', 'RESOURCE_PEARLS', 'YIELD_PRODUCTION', 1),
('BUILDING_QuanNongTing', 'RESOURCE_WHEAT', 'YIELD_FOOD', 1),
('BUILDING_QuanNongTing', 'RESOURCE_BANANA', 'YIELD_FOOD', 1),
('BUILDING_QuanNongTing', 'RESOURCE_DEER', 'YIELD_FOOD', 1),
('BUILDING_QuanNongTing', 'RESOURCE_BISON', 'YIELD_FOOD', 1);
INSERT INTO Building_FeatureYieldChanges (BuildingType, FeatureType, YieldType, Yield)
VALUES 
('BUILDING_SheJiTan', 'FEATURE_ATOLL', 'YIELD_PRODUCTION', 1);
INSERT INTO Building_TradeRouteFromTheCityYieldsPerEra (BuildingType, YieldType, YieldValue)
VALUES 
('BUILDING_SheJiTan', 'YIELD_GOLD', 1),
('BUILDING_SheJiTan', 'YIELD_SCIENCE', 1),
('BUILDING_SheJiTan', 'YIELD_CULTURE', 1),
('BUILDING_SheJiTan', 'YIELD_FOOD', 1),
('BUILDING_SheJiTan', 'YIELD_PRODUCTION', 1),
('BUILDING_SheJiTan', 'YIELD_FAITH', 1);
INSERT  INTO Building_YieldChanges(BuildingType,YieldType,Yield)
VALUES  
('BUILDING_SheJiTan','YIELD_PRODUCTION',2),
('BUILDING_TaiXue','YIELD_SCIENCE',3),
('BUILDING_QuanNongTing','YIELD_FOOD',2);
INSERT INTO Building_YieldFromYieldPercentGlobal(BuildingType, YieldIn, YieldOut, 	Value)
VALUES	
('BUILDING_TaiXue', 	'YIELD_CULTURE', 	'YIELD_SCIENCE', 	100);
INSERT INTO Building_ImprovementYieldChanges (BuildingType, ImprovementType, YieldType, Yield)
VALUES 
('BUILDING_QuanNongTing', 'IMPROVEMENT_FARM', 'YIELD_FOOD', 1),
('BUILDING_QuanNongTing', 'IMPROVEMENT_FISHING_BOATS', 'YIELD_FOOD', 1),
('BUILDING_QuanNongTing', 'IMPROVEMENT_FISHFARM_MOD', 'YIELD_FOOD', 1),
('BUILDING_QuanNongTing', 'IMPROVEMENT_PLANTATION', 'YIELD_FOOD', 1);
INSERT INTO UnitPromotions_UnitCombats(PromotionType, UnitCombatType)
VALUES
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_NAVALRANGED'),
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_SUBMARINE'),
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_BOMBER'),
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_FIGHTER'),
	('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_MELEE'),
	('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_GUN'),
	('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_MOUNTED'),
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_ARCHER'),
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_HELICOPTER'),
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_SIEGE'),
    ('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_RECON'),
	('PROMOTION_Han_Dynasty_WDChi', 'UNITCOMBAT_ARMOR');
INSERT OR IGNORE INTO Building_SpecialistYieldChanges (
    BuildingType,
    SpecialistType,
    YieldType,
    Yield
)
SELECT
    'BUILDING_QuanNongTing' AS BuildingType,
    Type AS SpecialistType,
    'YIELD_HEALTH' AS YieldType,
    1 AS Yield
FROM Specialists
WHERE
    EXISTS (
        SELECT 1 FROM ROG_GlobalUserSettings WHERE Type = 'WORLD_POWER_PATCH' AND Value = 1
    );