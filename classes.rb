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
	def create(
			profileID,
			profileName,
			nickname,
			realname,
			username
		)
		# write to end of profileFile
	end
	def delete(
			profileID
		)
		# delete all from profileID declaration to next profileID declaration
	end
	def modify(
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
	def count
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