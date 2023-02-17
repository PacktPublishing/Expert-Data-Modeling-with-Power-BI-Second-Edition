/**** Terminate Brian Welcker's previous role ****/
UPDATE DimEmployee
SET EndDate = '2012-04-30'
	, CurrentFlag = 0
	, Status = null
FROM DimEmployee
WHERE EmployeeKey = 277

/**** Terminate Stephen Jiang's previous role ****/
UPDATE DimEmployee
SET EndDate = '2012-04-30'
	, CurrentFlag = 0
	, Status = null
FROM DimEmployee
WHERE EmployeeKey = 272 

/**** Add Stephen Jiang's promotion ****/
INSERT INTO DimEmployee (
	ParentEmployeeKey
	, EmployeeNationalIDAlternateKey
	, ParentEmployeeNationalIDAlternateKey
	, SalesTerritoryKey
	, FirstName
	, LastName
	, MiddleName
	, NameStyle
	, Title
	, HireDate
	, BirthDate
	, LoginID
	, EmailAddress
	, Phone
	, MaritalStatus
	, EmergencyContactName
	, EmergencyContactPhone
	, SalariedFlag
	, Gender
	, PayFrequency
	, BaseRate
	, VacationHours
	, SickLeaveHours
	, CurrentFlag
	, SalesPersonFlag
	, DepartmentName
	, StartDate
	, EndDate
	, Status
	)
SELECT
	112	ParentEmployeeKey
	, EmployeeNationalIDAlternateKey
	, ParentEmployeeNationalIDAlternateKey
	, SalesTerritoryKey
	, FirstName
	, LastName
	, MiddleName
	, NameStyle
	, 'Vice President of Sales'	Title
	, HireDate
	, BirthDate
	, LoginID
	, EmailAddress
	, Phone
	, MaritalStatus
	, EmergencyContactName
	, EmergencyContactPhone
	, SalariedFlag
	, Gender
	, PayFrequency
	, 72.1154	BaseRate
	, VacationHours
	, SickLeaveHours
	, 1 CurrentFlag
	, 0	SalesPersonFlag
	, DepartmentName
	, '2012-05-01'	StartDate
	, NULL	EndDate
	, 'Current'	Status
FROM DimEmployee
WHERE EmployeeKey = 272

/**** Hire Roger Hamilton ****/
INSERT INTO DimEmployee (
	ParentEmployeeKey
	, EmployeeNationalIDAlternateKey
	, ParentEmployeeNationalIDAlternateKey
	, SalesTerritoryKey
	, FirstName
	, LastName
	, MiddleName
	, NameStyle
	, Title
	, HireDate
	, BirthDate
	, LoginID
	, EmailAddress
	, Phone
	, MaritalStatus
	, EmergencyContactName
	, EmergencyContactPhone
	, SalariedFlag
	, Gender
	, PayFrequency
	, BaseRate
	, VacationHours
	, SickLeaveHours
	, CurrentFlag
	, SalesPersonFlag
	, DepartmentName
	, StartDate
	, EndDate
	, Status
	)
VALUES (
	(
		SELECT EmployeeKey
		FROM DimEmployee
		WHERE EmployeeNationalIDAlternateKey = 502097814
			AND Status = 'Current'
		)
	, 112471123
	, NULL
	, 11
	, 'Roger'
	, 'Hamilton'
	, 'J'
	, 0
	, 'North American Sales Manager'
	, '2012-05-01'
	, '1960-11-17'
	, 'adventure-works\roger0'
	, 'roger0@adventure-works.com'
	, '238-555-0198'
	, 'M'
	, 'Roger Hamilton'
	, '238-555-0198'
	, 1
	, 'M'
	, 2
	, 48.101
	, 14
	, 30
	, 1
	, 1
	, 'Sales'
	, '2012-05-01'
	, NULL
	, 'Current'
	)

/**** Update Roger Hamilton's team members ****/
UPDATE DimEmployee
SET ParentEmployeeKey = (
		SELECT EmployeeKey
		FROM DimEmployee
		WHERE EmployeeNationalIDAlternateKey = 112471123
		)
FROM DimEmployee
WHERE ParentEmployeeKey = 
	(SELECT EmployeeKey
	 FROM DimEmployee
	 WHERE EmployeeNationalIDAlternateKey = 502097814
			AND Status IS NULL
			)
	AND Status = 'Current'

/**** Update Stephen Jiang's team members ****/
UPDATE DimEmployee
SET ParentEmployeeKey = (
		SELECT EmployeeKey
		FROM DimEmployee
		WHERE EmployeeNationalIDAlternateKey = 502097814
			AND Status = 'Current'
		)
WHERE ParentEmployeeKey = 
	(SELECT EmployeeKey
	 FROM DimEmployee
	 WHERE EmployeeNationalIDAlternateKey = 112432117
			AND Status IS NULL
			)
		AND Status = 'Current'