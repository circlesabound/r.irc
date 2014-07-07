# methods_irc.rb
# all irc commands

def c_admin(s,server)
	# Instructs the server to return information about the administrator of the server, or the current server if none specified
	s.puts "ADMIN #{server}"
end

def c_away(s,message)
	# Provides the server with a message to automatically send in reply to a PRIVMSG directed at the user, but not to a channel they are on. If <message> is omitted, the away status is removed.
	s.puts "AWAY #{message}"
end

def c_connect(s,server,port,rserver="")
	# Instructs the server <remote server> (or the current server, if <remote server> is omitted) to connect to <target server> on port <port>. This command should only be available to IRC Operators.
	s.puts "CONNECT #{server} #{port} #{rserver}"
end

def c_die(s)
	# Instructs the server to shut down. Operator only (obviously)
	s.puts "DIE"
end

def c_help(s)
	# Requests the server help file
	s.puts "HELP"
end

def c_info(s,target="")
	# Returns information about the <target> server, or the current server if <target> is omitted.
	s.puts "INFO #{target}"
end

def c_invite(s,nickname,channel)
	# Invites <nickname> to the channel <channel>. <channel> does not have to exist, but if it does, only members of the channel are allowed to invite other clients.
	s.puts "INVITE #{nickname} #{channel}"
end

def c_ison(s,nicknames)
	# Queries the server to see if the clients in the space-separated list <nicknames> are currently on the network. The server returns only the nicknames that are on the network in a space-separated list. If none of the clients are on the network the server returns an empty list.
	# <nicknames> is passed in as an array
	nicknameList = ""
	nicknames.each do |n|
		nicknameList << "#{n},"
	end
	s.puts "ISON #{nicknameList}"
end

def c_join(s,channels,keys="")
	# Makes the client join the channels in the comma-separated list <channels>, specifying the passwords, if needed, in the comma-separated list <keys>. If the channel(s) do not exist then they will be created.
	channelList,keysList = ""
	channels.each do |c|
		channelList << "#{c},"
	end
	channelList = channelList[0..channelList.length-2]
	unless keys == ""
		keys.each do |k|
			keysList << "#{k},"
		end
		keysList = keysList[0..keysList.length-2]
	end
	s.puts "JOIN #{channelList} #{keysList}"
end

def c_kick(s,channel,client,message="")
	# Forcibly removes <client> from <channel>
	s.puts "KICK #{channel} #{client} #{message}"
end

def c_kill(s,client,comment)
	# Forcibly removes <client> from the network
	s.puts "KILL #{client} #{comment}"
end

def c_knock(s,channel,message="")
	# Sends a NOTICE to an invitation-only <channel> with an optional <message>, requesting an invite.
	s.puts "KNOCK #{channel} #{message}"
end

def c_list(s,channels="",server="")
	# Lists all channels on the server. If the comma-separated list <channels> is given, it will return the channel topics. If <server> is given, the command will be forwarded to <server> for evaluation.
	server = (channels == "") ? "" : server
	channelList = ""
	channels.each do |c|
		channelList << "#{c},"
	end
	channelList = channelList[0..channelList.length-2]
	s.puts "LIST #{channelList} #{server}"
end

def c_lusers(s,mask="",server="")
	server = (mask == "") ? "" : server
	s.puts "LUSERS #{mask} #{server}"
end

def c_mode_user(s,nickname,flags_on="",flags_off="")
	# Sets user modes
	# <flags_on> and <flags_off> are arrays of strings
	flagsList = (flags_on.count == 0) ? "" : "+"
	flags_on.each do |f|
		flagsList << "#{f}"
	end
	flagsList << (flags_off.count == 0) ? "" : " -"
	flags_off.each do |f|
		flagsList << "#{f}"
	end
	unless flagsList.length == 0
		flagsList = flagsList[0..flagsList.length-2]
	end
	s.puts "MODE #{nickname} #{flagsList}"
end

def c_mode_channel(s,channel,flags_on,flags_off)
	# Sets channel modes
	flagsList = (flags_on.count == 0) ? "" : "+"
	flags_on.each do |f|
		flagsList << "#{f}"
	end
	flagsList << (flags_off.count == 0) ? "" : " -"
	flags_off.each do |f|
		flagsList << "#{f}"
	end
	unless flagsList.length == 0
		flagsList = flagsList[0..flagsList.length-2]
	end
	s.puts "MODE #{channel} #{flagsList}"
end

def c_motd(s,server="")
	# Returns the MOTD on <server> or the current server
	s.puts "MOTD #{server}"
end

def c_names(s,channels="",server="")
	# Returns a list of who is on the comma-separated list of <channels>
	server = (channels == "") ? "" : server
	channelList = ""
	channels.each do |c|
		channelList << "#{c},"
	end
	unless channelList.length == 0
		channelList = channelList[0..channelList.length-2]
	end
	s.puts "NAMES #{channelList} #{server}"
end

def c_nick(s,nick)
	# Allows a client to change their IRC nickname.
	s.puts "NICK #{nick}"
end

def c_notice(s,msgtarget,message)
	# This command works similarly to PRIVMSG, except automatic replies must never be sent in reply to NOTICE messages.
	s.puts "NOTICE #{msgtarget} #{message}"
end

def c_oper(s,username,password)
	# Authenticates a user as an IRC operator on that server/network
	s.puts "OPER #{username} #{password}"
end

def c_part(s,channels,message)
	# Causes a user to leave the channels in the comma-separated list <channels>.
	channelList = ""
	channels.each do |c|
		channelList << "#{c},"
	end
	unless channelList.length == 0
		channelList = channelList[0..channelList.length-2]
	end
end

def c_ping(s,server1,server2="")
	s.puts "PING #{server1} #{server2}"
end

def c_pong(s,server1,server2="")
	s.puts "PONG #{server1} #{server2}"
end

def c_privmsg(s,msgtarget,message)
	# Sends <message> to <msgtarget>, which is usually a user or channel.
	s.puts "PRIVMSG #{msgtarget} :#{message}"
end

def c_quit(s,message="")
	# Disconnects the user from the server.
	s.puts "QUIT #{message}"
	s.close()
end

def c_restart(s)
	# Restarts a server. It may only be sent by IRC operators
	s.puts "RESTART"
end

def c_rules(s)
	# Requests the server rules
	s.puts "RULES"
end

def c_summon(s,user,server,channel)
	# Gives users who are on the same host as <server> a message asking them to join
	s.puts "SUMMON #{user} #{server} #{channel}"
end

def c_time(s,server="")
	# Returns the local time on the server specified
	s.puts "TIME #{server}"
end

def c_topic(s,channel,topic="")
	# Allows the client to query or set the channel topic on <channel>
	# If <topic> is given, it sets the channel topic to <topic>
	s.puts "TOPIC #{channel} #{topic}"
end

def c_trace(s,target="")
	# Trace a path across the IRC network to a specific server or client
	s.puts "TRACE #{target}"
end

def c_user(s,username,mode,realname)
	# Used at the beginning of a connection to specify details
	# user modes:
	# 0 : nothing
	# 4 : receives wallops
	# 8 : invisible
	s.puts "USER #{username} #{mode} * :#{realname}"
end

def c_userhost(s,nicknames)
	# returns a list of information about the nicknames specified
	# <nicknames> is an array
	nicknameList = ""
	nicknames.each do |n|
		nicknameList << "#{n} "
	end
	s.puts "USERHOST #{nicknameList}"
end

def c_users(s,server="")
	# returns a list of users and information about those users
	s.puts "USERS #{server}"
end

def c_version(s,server="")
	# returns the version of <server> or the current server
	s.puts "VERSION #{server}"
end

def c_wallops(s,message)
	# Sends <message> to all users with the user mode 'w'
	s.puts "WALLOPS #{message}"
end

def c_who(s,name,flag_op=false)
	# Returns a list of users who match <name>
	# If flag 'o' is set, only information about operators is returned
	s.puts (flag_op) ? "WHO #{name} o" : "WHO #{name}"
end

def c_whois(s,server="",nicknames)
	# Returns information about the comma-separated list of nicknames masks <nicknames>
	# Command is forwarded to <server> if given
	nicknameList = ""
	nicknames.each do |n|
		nicknameList << "#{n},"
	end
	s.puts "WHOIS #{server} #{nicknameList}"
end

def c_whowas(s,nicknames,count="",server="")
	# Used to return information about a nickname no longer in use
	# Returns information about the last <count> times the nickname was used, or all of them
	# Command is forwarded to <server> if given
	# <nicknames> is an array
	nicknameList = ""
	nicknames.each do |n|
		nicknameList "#{n},"
	end
	unless nicknameList.length == 0
		nicknameList = nicknameList[0..nicknameList.length-2]
	end
	s.puts "WHOWAS #{nicknameList} #{count} #{server}"
end