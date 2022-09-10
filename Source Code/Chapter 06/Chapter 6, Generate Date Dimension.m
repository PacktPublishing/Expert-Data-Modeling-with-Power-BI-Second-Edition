// GenerateDate
(#"Start Year" as number, #"End Year" as number) as table => 
    let 
        GenerateDates = List.Dates(#date(#"Start Year",1,1), Duration.Days(Duration.From(#date(#"End Year", 12, 31) - #date(#"Start Year" - 1,12,31))), #duration(1,0,0,0) ),
        #"Converted to Table" = Table.TransformColumnTypes(Table.FromList(GenerateDates, Splitter.SplitByNothing(), {"Date"}), {"Date", Date.Type}),
        #"Added Custom" = Table.AddColumn(#"Converted to Table", "DateKey", each Int64.From(Text.Combine({Date.ToText([Date], "yyyy"), Date.ToText([Date], "MM"), Date.ToText([Date], "dd")})), Int64.Type),
        #"Year Column Added" = Table.AddColumn(#"Added Custom", "Year", each Date.Year([Date]), Int64.Type),
        #"Quarter Column Added" = Table.AddColumn(#"Year Column Added", "Quarter", each "Qtr "&Text.From(Date.QuarterOfYear([Date])) , Text.Type),
        #"MonthOrder Column Added" = Table.AddColumn(#"Quarter Column Added", "MonthOrder", each Date.ToText([Date], "MM"), Text.Type),
        #"Short Month Column Added" = Table.AddColumn(#"MonthOrder Column Added", "Month Short", each Date.ToText([Date], "MMM"), Text.Type),
        #"Month Column Added" = Table.AddColumn(#"Short Month Column Added", "Month", each Date.MonthName([Date]), Text.Type)
    in
        #"Month Column Added"