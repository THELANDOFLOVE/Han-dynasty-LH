CREATE TABLE Building_CityStateTradeRouteYieldModifiers (
	'BuildingType' text references Buildings(Type),
	'YieldType' text references Yields(Type),
	'Yield' integer default 0
);
CREATE TABLE Building_CityStateTradeRouteYieldModifiersGlobal (
	'BuildingType' text references Buildings(Type),
	'YieldType' text references Yields(Type),
	'Yield' integer default 0
);