# r.irc classes file

class Profile
	attr_reader :profileID, :profileName, :nickname, :realname, :username
	@@profileCount = 0
	def initialize(
			profileID,
			profileName,
			nickname,
			realname,
			username
		)
		@profileID = profileID
		@profileName = profileName
		@nickname = nickname
		@realname = realname
		@username = username # can be optional
		@@profileCount += 1
	end
	def self.load(
			profilesFileName
		)
		profilesFile = File.new(profilesFileName,"r")
		profileCount = Integer(f_getsLine(profilesFile))
		profilesFileLine = Array.new()
		userProfiles = Array.new()
		for i in 0..profileCount-1
			for j in 0..4
				profilesFileLine[j] = f_getsLine(profilesFile)
			end
			userProfiles[i] = Profile.new(
				profilesFileLine[0],
				profilesFileLine[1],
				profilesFileLine[2],
				profilesFileLine[3],
				profilesFileLine[4]
				)
		end
		return userProfiles
	end
	def self.create(
			profileID,
			profileName,
			nickname,
			realname,
			username
		)
		exitCode = 0
		f_createCopy("profilesFile","profilesFile.temp")
		# magic goes here once I've figured it out
		Profile.new(profileID, profileName, nickname, realname, username)
		return exitCode
	end
	def self.delete(
			profileID
		)
		exitCode = 0
		f_createCopy("profilesFile","profileFile.temp")
		# delete all from profileID declaration to next profileID declaration
		return exitCode
	end
	def self.modify(
			profileID,
			profileName,
			nickname,
			realname,
			username
		)
		exitCode = 0
		# make a copy of original profileFile > profileFile.temp [exitCode = 1]
		# modify profileFile.temp [exitCode = 2]
		# confirm changes [exitCode = 3]
		# rename original to profileFile.bak [exitCode = 4]
		# rename profileFile.temp > profileFile [exitCode = 5]
		return exitCode
	end
	def self.count
		return @@profileCount
	end
end

class Settings
	attr_reader :defaultProfile
	def initialise(
			defaultProfile
		)
		@defaultProfile = defaultProfile
	end
end