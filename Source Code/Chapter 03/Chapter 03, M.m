DateTime.LocalNow()
--------------------
let  
   Variablename = expression1,  
   #"Variable name" = expression2  
in   
   #"Variable name"
--------------------
[
    First Name = "Soheil"
    , Last Name = "Bakhshi"
    , Occupation = "Consultant"
    ]

--------------------
[
    Name = {"Soheil", "John"}
    ]
--------------------
#table( {"ID", "Fruit Name"}, {{1, "Apple"}, {2, "Orange"}, {3, "Banana"}})
--------------------
#table( type table [ID = number, Fruit Name = text], {{1, "Apple"}, {2, "Orange"}, {3, "Banana"}} )
--------------------
#table( type table
            [Name = list]
                , {{{"Soheil", "John"}}}
                           )
--------------------
()as date => Date.EndOfMonth(Date.From(DateTime.LocalNow()))
--------------------
"1" is number
--------------------
1 is number
--------------------
type { number }
--------------------
SimpleFunction = (DateValue as date) as date =>
Date.AddDays(DateValue, 1)
--------------------
SimpleFunction(#date(2020,1,1))
--------------------
//fnRenameColumns
let
    fnRename = (ColumnName as text) as text =>
        let
            SplitColumnName = Splitter.SplitTextByCharacterTransition({"a".."z"}, {"A".."Z"})(ColumnName)
        in
    Text.Combine(SplitColumnName, " ")
in
    fnRename
--------------------
Table.TransformColumnNames(#"Renamed Columns", fnRenameColumns)
--------------------
//fnFactorial
let
   Factorial =
        (ValidNumber as number) as number =>
            if ValiedNumber < 0
            then error "Negative numbers are not allowed to calculate Factorial. Please select a positive number."
            else
                if ValidNumber = 0
                then 1
                else ValidNumber * @Factorial(ValiedNumber - 1)
in
    Factorial   
--------------------
//fnFactorial2
let
   Factorial = 
        (ValiedNumber as number) as number => 
          if Number.Sign(ValiedNumber) = 1 
          then 
               if ValiedNumber = 0
               then 1 
               else ValiedNumber * @Factorial(ValiedNumber - 1)
          else -1
in
    Factorial
