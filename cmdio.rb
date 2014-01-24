require 'socket'
require 'observer'
require 'rubygems'

puts "r.irc v0.1a"
print "Enter server location: "
server = gets.chomp
print "Enter port (default 6667): "
port = gets.chomp
port = (port.length==0) ? "6667" : port

puts "Connecting to #{server}:#{port} ..."

s = TCPSocket.new server,port

puts "Connection successful"
print "User name: "
username=gets.chomp
print "Real name: "
realname = gets.chomp
user = username + " 0 * " + realname
s.puts "USER " + user
print "Nickname: "
nickname = gets.chomp
s.puts "NICK " + nickname

print "Enter channel name (begins with \# or \$): "
channel = gets.chomp
s.puts "JOIN #{channel}"

threads = []
threads << Thread.new do
	while incoming = s.gets
		puts incoming
	end
end
threads << Thread.new do
	loop {
		input = gets.chomp
		# if input=="/quit"||input=="/exit"||input=="/bye"
		# 	s.close
		# 	threads.each {|thr| thr.kill}
		# else
		# 	puts input[0]
		# 	s.puts "PRIVMSG #{channel} :#{input}"
		# end
		if input[0]=="/" && input[1]=="/"
			unless input[1]=="/"
				command=input[1..input.length]
				s.puts command
			end
		else
			s.puts "PRIVMSG #{channel} :#{input}"
		end
	}
end

threads.each {|thr| thr.join}