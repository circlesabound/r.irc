require 'socket'
require 'rubygems'
#require 'Ruby-IRC'

#bot = IRC.new("Nickname","192.168.1.42","6667","Realname")
#IRCEvent.add_callback('endofmotd') {|event| bot.add_channel('#testchannel') }
#IRCEvent.add_callback('join') {|event| bot.send_message(event.channel, "Hello #{event.from}") }
#bot.connect

s = TCPSocket.new("localhost","6667")
s.puts "USER testing 0 * TESTING"
s.puts "NICK bot"
s.puts "JOIN #test"
s.puts "SENDLINE hey"
s.puts "QUIT #test"
