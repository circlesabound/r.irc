def startup
	profiles = Profile.load("../common/profilesFile")
	settings = Settings.load("../common/settingsFile")
	for i in 0..Profile.count-1 do
		if Integer(profiles[i].profileID) == settings.defaultProfile
	end
end