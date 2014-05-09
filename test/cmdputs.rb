require 'socket'
require 'rubygems'

s = TCPSocket.new("localhost","6667")
print "User name : "
username=gets.chomp
print "Real name : "
realname = gets.chomp
user = username + " 0 * " + realname
s.puts "USER " + user
print "Nickname : "
nickname = gets.chomp
s.puts "NICK " + nickname
s.puts "JOIN #test"
while
	x=gets.chomp
	if x=="/quit"||x=="/bye"||x=="/exit"
		break
	else
		s.puts "PRIVMSG #test " + x
	end
end