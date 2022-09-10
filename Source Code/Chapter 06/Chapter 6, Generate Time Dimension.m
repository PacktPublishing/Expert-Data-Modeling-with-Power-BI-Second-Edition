let
Source = Table.FromList({1..86400}, Splitter.SplitByNothing()),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "ID"}}),
    #"Time Column Added" = Table.AddColumn(#"Renamed Columns", "Time", each Time.From(#datetime(1970,1,1,0,0,0) + #duration(0,0,0,[ID]))),
    #"Hour Added" = Table.AddColumn(#"Time Column Added", "Hour", each Time.Hour([Time])),
    #"Minute Added" = Table.AddColumn(#"Hour Added", "Minute", each Time.Minute([Time])),
    #"5 Min Band Added" = Table.AddColumn(#"Minute Added", "5 Min Band", each Time.From(#datetime(1970,1,1,0,0,0) + #duration(0, 0, Number.RoundDown(Time.Minute([Time])/5) * 5, 0))  +  #duration(0, 0, 5, 0)),
    #"15 Min Band Added" = Table.AddColumn(#"5 Min Band Added", "15 Min Band", each Time.From(#datetime(1970,1,1,0,0,0) + #duration(0, 0, Number.RoundDown(Time.Minute([Time])/15) * 15, 0))  +  #duration(0, 0, 15, 0)),
    #"30 Min Band Added" = Table.AddColumn(#"15 Min Band Added", "30 Min Band", each Time.From(#datetime(1970,1,1,0,0,0) + #duration(0, 0, Number.RoundDown(Time.Minute([Time])/30) * 30, 0))  +  #duration(0, 0, 30, 0)),
    #"45 Min Band Added" = Table.AddColumn(#"30 Min Band Added", "45 Min Band", each Time.From(#datetime(1970,1,1,0,0,0) + #duration(0, 0, Number.RoundDown(Time.Minute([Time])/45) * 45, 0))  +  #duration(0, 0, 45, 0)),
    #"60 Min Band Added" = Table.AddColumn(#"45 Min Band Added", "60 Min Band", each Time.From(#datetime(1970,1,1,0,0,0) + #duration(0, 0, Number.RoundDown(Time.Minute([Time])/60) * 60, 0))  +  #duration(0, 0, 60, 0)),
    #"Removed Other Columns" = Table.SelectColumns(#"60 Min Band Added",{"Time", "Hour", "Minute", "5 Min Band", "15 Min Band", "30 Min Band", "45 Min Band", "60 Min Band"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Other Columns",{{"Time", type time}, {"Hour", Int64.Type}, {"Minute", Int64.Type}, {"5 Min Band", type time}, {"15 Min Band", type time}, {"30 Min Band", type time}, {"45 Min Band", type time}, {"60 Min Band", type time}})
in
#"Changed Type"