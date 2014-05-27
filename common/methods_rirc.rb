def startup
	$profiles = Profile.load("../common/profilesFile")
	$settings = Settings.load("../common/settingsFile")
	# for i in 0..Profile.count-1
	# 	if Integer(profiles[i].profileID) == settings.defaultProfile
	# 		$defaultProfile = i
	# 	end
	# end
	$tabs = [] # init tab array
	$currentTab = -1 # init current tab, -1 means no tab
end
