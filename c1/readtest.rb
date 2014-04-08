load('classes.rb')
load('methods_io.rb')

profilesFile = File.new('profilesFile')
settingsFile = File.new('settingsFile')
profileCount = Integer(f_getsLine(profilesFile))
profilesFileLine = Array.new()
userProfiles = Profile.load('profilesFile')
defaultProfile = Integer(f_getsLine(settingsFile))
for k in 0..profileCount-1
	if Integer(userProfiles[k].profileID) == defaultProfile
		puts "the default profile is " + userProfiles[k].profileName
	end
end