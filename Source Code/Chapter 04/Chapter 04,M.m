// fnTextCleaner
(FilePath as text) as table =>
let
    Source = File.Contents(FilePath),
    GetText = Text.FromBinary(Source),
    ReplaceCarriageReturn = Text.Replace(GetText, " #(cr,lf)", ""),
    ReplaceLineBreaks = Text.Replace(ReplaceCarriageReturn, " #(lf)", ""),
    TextToBinary = Text.ToBinary(ReplaceLineBreaks),
    #"Imported CSV" = Csv.Document(TextToBinary,[Delimiter=",", Columns=25, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ProductKey", Int64.Type}, {"ProductAlternateKey", type text}, {"ProductSubcategoryKey", type number}, {"WeightUnitMeasureCode", type text}, {"SizeUnitMeasureCode", type text}, {"EnglishProductName", type text}, {"StandardCost", type text}, {"FinishedGoodsFlag", type logical}, {"Color", type text}, {"SafetyStockLevel", Int64.Type}, {"ReorderPoint", Int64.Type}, {"ListPrice", type text}, {"Size", type text}, {"SizeRange", type text}, {"Weight", type text}, {"DaysToManufacture", Int64.Type}, {"ProductLine", type text}, {"DealerPrice", type text}, {"Class", type text}, {"Style", type text}, {"ModelName", type text}, {"EnglishDescription", type text}, {"StartDate", type datetime}, {"EndDate", type datetime}, {"Status", type text}})
in
    #"Changed Type"
