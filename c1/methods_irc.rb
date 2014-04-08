# methods_irc.rb
# all irc commands

def c_admin(s,server,caller)
	# Instructs the server to return information about the administrator of the server, or the current server if none specified
end

def c_away(s,message,caller)
	# Provides the server with a message to automatically send in reply to a PRIVMSG directed at the user, but not to a channel they are on. If <message> is omitted, the away status is removed.
end

def c_connect(s,server,port,rserver,caller)
	# Instructs the server <remote server> (or the current server, if <remote server> is omitted) to connect to <target server> on port <port>. This command should only be available to IRC Operators.
end

def c_die(s,caller)
	# Instructs the server to shut down. Operator only (obviously)
end

def c_help(s,caller)
	# Requests the server help file
end

def c_info(s,target,caller)
	# Returns information about the <target> server, or the current server if <target> is omitted.
end

def c_invite(s,nick,channel,caller)
	# Invites <nickname> to the channel <channel>. <channel> does not have to exist, but if it does, only members of the channel are allowed to invite other clients.
end

def c_ison(s,nicks,caller)
	# Queries the server to see if the clients in the space-separated list <nicknames> are currently on the network. The server returns only the nicknames that are on the network in a space-separated list. If none of the clients are on the network the server returns an empty list.
end

def c_join(s,channels,keys,caller)
	# Makes the client join the channels in the comma-separated list <channels>, specifying the passwords, if needed, in the comma-separated list <keys>. If the channel(s) do not exist then they will be created.
end

def c_kick(s,channel,client,message,caller)
	# Forcibly removes <client> from <channel>.
end

def c_kill(s,client,comment,caller)
	# Forcibly removes <client> from the network.
end

def c_knock(s,channel,message,caller)
	# Sends a NOTICE to an invitation-only <channel> with an optional <message>, requesting an invite.
end

def c_list(s,channels,server,caller)
	# Lists all channels on the server. If the comma-separated list <channels> is given, it will return the channel topics. If <server> is given, the command will be forwarded to <server> for evaluation.
end

def c_nick(s,nick,caller)
	# Allows a client to change their IRC nickname.
end

def c_notice(s,msgtarget,message,caller)
	# This command works similarly to PRIVMSG, except automatic replies must never be sent in reply to NOTICE messages.
end

def c_part(channels,message,caller)
	# Causes a user to leave the channels in the comma-separated list <channels>.
end

def c_privmsg(msgtarget,message,caller)
	# Sends <message> to <msgtarget>, which is usually a user or channel.
end

def c_quit(s,message,caller)
	# Disconnects the user from the server.
	s.puts "QUIT #{message}"
end
