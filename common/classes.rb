# r.irc classes

class Profile
	attr_accessor :profileID, :profileName, :nickname, :realname, :username
	@@profileCount = 0
	def initialize(
			profileID,
			profileName,
			nickname,
			realname,
			username = -1
		)
		@profileID 		= profileID
		@profileName 	= profileName
		@nickname 		= nickname
		@realname 		= realname
		@username 		= username
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
		Profile.new(
			profileID,
			profileName,
			nickname,
			realname,
			username
		)
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
		# process complete [exitCode = 0]
		return exitCode
	end
	def self.count
		return @@profileCount
	end
end

class Settings
	attr_reader :defaultProfile, :defaultDetail
	def initialize(
			defaultProfile,
			defaultDetail
		)
		@defaultProfile = defaultProfile
		@defaultDetail 	= defaultDetail
	end
	def self.load(
			settingsFileName
		)
		settingsFile = File.new(settingsFileName,"r")
		defaultProfile = Integer(f_getsLine(settingsFile))
		defaultDetail = Integer(f_getsLine(settingsFile))
		settings = Settings.new(defaultProfile,defaultDetail)
		return settings
	end
end

# class Application
# 	attr_accessor :currentTab, :currentDetail
# 	def initialize(
# 			currentTab,
# 			currentDetail
# 		)
# 		@currentTab 	= currentTab # a value of -1 means there are no tabs
# 		@currentDetail 	= currentDetail
# 	end
# 	def self.load(
# 			settings
# 		)
# 		application = Application.new(-1,settings.defaultDetail)
# 		return application
# 	end
# end

class Tab
	attr_reader :id, :connection, :channel
	attr_accessor :threads, :messages, :queue, :window
	@@tabID = 0
	def initialize(
			connection,
			channel
		)
		@id 		= @@tabID
		@connection = connection
		@channel 	= channel
		@threads	= Hash.new
		# three threads per tab
		# 'r' => receive thread
		# 's' => send thread
		# 'g' => gui thread
		@messages	= []
		@queue		= Queue.new
		# queue is for outgoing messages,
		# enables cross thread data sharing
		@window		= Hash.new
		# a way to store the gui elements
		# for manipulation by functions called
		# by the back end
		@@tabID 	+= 1
	end
	def self.create(
			address,
			port,
			username,
			modes,
			realname,
			nickname,
			channel
		)
		begin
			s = TCPSocket.new("#{address}","#{port}")
		rescue StandardError => e
			p("Could not reach server: #{e}")
		end
		begin
			c_user(
				s,
				username,
				modes,
				realname
			)
			c_nick(
				s,
				nickname
			)
		rescue StandardError => e
			p("Could not send connection details: #{e}")
		end
		c_join(
			s,
			channel
		)
		tab = Tab.new(s,channel)
		return tab
	end
	def self.count
		return @@tabID
	end
end