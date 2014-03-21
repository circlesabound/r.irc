BEGIN _main_
	_startUpProcedures_
	// more //
END _main_

BEGIN _startUpProcedures_
	settingsArray = _readSettings_ 									// read settings config file into array
	profileArray = _readProfile_(settingsArray.defaultProfile) 		// read profile config file into array
END _startUpProcedures_