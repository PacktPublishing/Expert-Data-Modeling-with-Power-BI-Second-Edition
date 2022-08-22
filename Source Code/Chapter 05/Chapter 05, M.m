Table.TransformColumnTypes(Table as table, TypeTransformations as list, optional Culture as nullable text)
--------------------
Table.AddColumn(Table as table, NewColumnName as text, ColumnGenerator as function, optional ColumnType as nullable type)
--------------------
List.Average(#"Merged Columns"[YearlyIncome])
--------------------
Table.AddColumn(#"Merged Columns", "Is Yearly Income Below Average", each if [YearlyIncome] <= List.Average(#"Merged Columns"[YearlyIncome]) then true else false, 
)
--------------------
List.Contains(#"Approved Subcategories"[Approved Product Subcategories], [Product Subcategory])
--------------------
Table.NestedJoin(
	FirstTable as table
	, KeyColumnofFirstTable as any
	, SecondTable as any
	, KeyColumnofSecondTable as any
	, NewColumnName as text
	, optional JoinKind as nullable JoinKind.Type
	)
--------------------	
Table.FuzzyNestedJoin(
	FirstTable as table
	, KeyColumnofFirstTable as any
	, SecondTable as table
	, KeyColumnofSecondTable as any
	, NewColumnName as text
	, optional JoinKind as nullable JoinKind.Type
	, optional JoinOptions as nullable record
	)
--------------------	
= Table.ReplaceValue(#"Renamed Columns", each if Text.Length([Description]) > 30 then [Description] else "",each Text.Start([Description], 30) & "...",Replacer.ReplaceValue,{"Description"})
--------------------
#date(year as number, month as number, day as number)
--------------------
#datetime(year as number, month as number, day as number, hour as number, minute as number, second as number)
--------------------
#datetimezone(year as number, month as number, day as number, hour as number, minute as number, second as number, offsetHours as number, offsetMinutes as number)
--------------------
let
    Source = [
	Date = #date(2020, 8, 9)
	, DateTime = #datetime(2020, 8, 9, 17, 0, 0)
	, DateTimeZone = #datetimezone(2020, 8, 9, 17, 0, 0, 12, 0)
	]
in
    Source
--------------------
Int64.From(Date.ToText([OrderDate], "yyyyMMdd"))
--------------------
Table.AddColumn(#"Changed Type", "OrderDateTimeUTC", each DateTimeZone.ToUtc(DateTimeZone.From([OrderDateTime])), DateTimeZone.Type)
--------------------
Table.AddColumn(#"Added OrderDateTimeUTC", "OrderDateTimeLocal", each DateTimeZone.ToLocal([OrderDateTimeUTC]), type datetimezone)
