require 'socket'
load('../common/methods_io.rb')
load('../common/methods_irc.rb')
load('../common/classes.rb')

puts "r.irc v0.2"
print "Enter server location: "
server = gets.chomp
print "Enter port (default 6667): "
port = gets.chomp
port = (port.length==0) ? "6667" : port

puts "Connecting to #{server}:#{port} ..."

(s = TCPSocket.new server,port) or puts "Connection failed"

puts "Connection successful"

puts "Getting user profiles from file"
profilesFile = File.new("profilesFile","r")
settingsFile = File.new("settingsFile","r")
profileCount = Integer(f_getsLine(profilesFile))
userProfiles = Profile.load('profilesFile')
defaultProfileID = Integer(f_getsLine(settingsFile))
for k in 0..profileCount-1
	if Integer(userProfiles[k].profileID) == defaultProfileID
		puts "The default profile is: #{userProfiles[k].profileID}"
		puts "Profile name: #{userProfiles[k].profileName}"
		puts "Nickname: #{userProfiles[k].nickname}"
		puts "Realname: #{userProfiles[k].realname}"
		puts "Username: #{userProfiles[k].username}"
		currentProfile = k
	end
end

# if userProfiles[currentProfile].username == "-1"
# 	userProfiles[currentProfile].username = "user"
# end

userProfiles[currentProfile].username = (userProfiles[currentProfile].username == "-1") ? "user" : userProfiles[currentProfile].username

# s.puts "NICK #{userProfiles[currentProfile].nickname}"
c_nick(s,userProfiles[currentProfile].nickname)
# s.puts "USER #{userProfiles[currentProfile].username} 0 * :#{userProfiles[currentProfile].realname}"
c_user(s,userProfiles[currentProfile].username,0,userProfiles[currentProfile].realname)

# print "Nickname: "
# nickname = gets.chomp
# s.puts "NICK " + nickname
# print "User name: "
# username=gets.chomp
# print "Real name: "
# realname = gets.chomp
# user = username + " 0 * :" + realname
# s.puts "USER " + user

print "Enter channel name (begins with \# or \$): "
channel = []
channel << gets.chomp
# s.puts "JOIN #{channel}"
c_join(s,channel)

threads = []
threads << t_read = Thread.new do
	while incoming = s.gets
		puts incoming
	end
end
threads << t_write = Thread.new do
	loop do
		input = gets.chomp
		if input[0]=="/" && input[1]!="/"
			command=input[1..input.length]
			case command
				when "quit","bye","exit"
					c_quit(s,"testmsg",0)
					puts "Bye"
					threads.each {|thr| thr.kill}
					break
				else
					s.puts command
			end
		else
			c_privmsg(s,channel,input,0)
		end
	end
end

threads.each do |thr|
	thr.join
end