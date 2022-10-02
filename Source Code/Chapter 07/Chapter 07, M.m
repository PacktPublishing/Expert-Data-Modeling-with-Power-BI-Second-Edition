//fnODataFeedAnalysis
(ODataFeed as text) as table =>
let   
Source = OData.Feed(ODataFeed),
        FilterTables = Table.SelectRows(Source, each Type.Is(Value.Type([Data]), Table.Type) = true),
    #"TableColumnCount Added" = Table.AddColumn(FilterTables, "Table Column Count", each Table.ColumnCount([Data]), Int64.Type),
    #"TableCountRows Added" = Table.AddColumn(#"TableColumnCount Added", "Table Row Count", each Table.RowCount([Data]), Int64.Type),
    #"NumberOfDecimalColumns Added" = Table.AddColumn(#"TableCountRows Added", "Number of Decimal Columns", each List.Count(Table.ColumnsOfType([Data], {Decimal.Type})), Int64.Type),
    #"ListOfDecimalColumns Added" = Table.AddColumn(#"NumberOfDecimalColumns Added", "List of Decimal Columns", each if [Number of Decimal Columns] = 0 then null else Table.ColumnsOfType([Data], {Decimal.Type})),
    #"NumberOfTextColumns Added" = Table.AddColumn(#"ListOfDecimalColumns Added", "Number of Text Columns", each List.Count(Table.ColumnsOfType([Data], {Text.Type})), Int64.Type),
    #"ListOfTextColumns Added" = Table.AddColumn(#"NumberOfTextColumns Added", "List of Text Columns", each if [Number of Text Columns] = 0 then null else Table.ColumnsOfType([Data], {Text.Type})),
    #"Sorted Rows" = Table.Sort(#"ListOfTextColumns Added",{{"Table Column Count", Order.Descending}, {"Table Row Count", Order.Descending}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Sorted Rows",{"Name", "Table Column Count", "Table Row Count", "Number of Decimal Columns", "List of Decimal Columns", "Number of Text Columns", "List of Text Columns"})
in
    #"Removed Other Columns"
--------------------
#table({"Value"}
    , {
        {100}
        , {65565}
        , {-100000}
        , {-999.9999}
        , {0.001}
        , {10000000.0000001}
        , {999999999999999999.999999999999999999}
    }
)
--------------------
Table.Schema(
      Table.FromValue([Value])
      )[TypeName]{0}
--------------------
// Decimal Numbers with 6 Decimal
let
    Source = List.Generate(()=> 0.000001, each _ <= 10, each _ + 0.000001 ),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Source"}}),
    #"Duplicated Source Column as Decimal" = Table.DuplicateColumn(#"Renamed Columns", "Source", "Decimal", Decimal.Type),
    #"Duplicated Source Column as Fixed Decimal" = Table.DuplicateColumn(#"Duplicated Source Column as Decimal", "Source", "Fixed Decimal", Currency.Type),
    #"Duplicated Source Column as Percentage" = Table.DuplicateColumn(#"Duplicated Source Column as Fixed Decimal", "Source", "Percentage", Percentage.Type)
in
    #"Duplicated Source Column as Percentage"
--------------------	
Table.AddColumn(#"Converted to Table", "DateKey", each Int64.From(Text.Combine({Date.ToText([Date], "yyyy"), Date.ToText([Date], "MM"), Date.ToText([Date], "dd")})))
--------------------
Table.AddColumn(#"Converted to Table", "DateKey", each Int64.From(Text.Combine({Date.ToText([Date], "yyyy"), Date.ToText([Date], "MM"), Date.ToText([Date], "dd")})), Int64.Type)
--------------------
if Value.Is(RowCount, Number.Type) 
    then Table.FirstN(#"Changed Type",  RowCount) 
    else #"Changed Type"
