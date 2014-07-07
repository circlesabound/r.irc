require 'socket'
require 'thread'
require 'shoes'
load('../common/constants.rb')
load('../common/classes.rb')
load('../common/methods_io.rb')
load('../common/methods_irc.rb')
load('../common/methods_rirc.rb')

s = TCPSocket.new "irc.rizon.net","6667"

# profilesFile = File.new("../common/profilesFile","r")
# settingsFile = File.new("../common/settingsFile","r")
# profileCount = Integer(f_getsLine(profilesFile))
# userProfiles = Profile.load("../common/profilesFile")

b_startup

for k in 0..Profile.count-1
	if Integer($profiles[k].profileID) == $settings.defaultProfile
		currentProfile = k
	end
end

s.puts "NICK #{$profiles[currentProfile].nickname}"
s.puts "USER #{$profiles[currentProfile].username} 0 * :#{$profiles[currentProfile].realname}"

s.puts "JOIN \#nsbhs"

messages = []
b_threads = []
queue = Queue.new

b_threads << receive = Thread.new do
	while incoming = s.gets
		# messages << incoming
		b_addToHistory(messages,incoming)
		queue << incoming
	end
end

b_threads << send = Thread.new do
	while outgoing = gets
		# messages << outgoing
		b_addToHistory(messages,outgoing)
		queue << outgoing
	end
end

b_threads << gui = Thread.new do
	Shoes.app do
		@messagebox = stack do
			# g_para("test")
		end
		every 0.5 do
			
			######################

			# the following block is inefficient
			# it redraws all the contents of @messagebox every time

			@messagebox.clear
			messages.each do |m|
				@messagebox.append do
					g_para("#{m}")
				end
			end

			######################

			# the following block would seem more efficient
			# but has a freezing side effect

			# @messagebox.append do
			# 	para "#{queue.pop}"
			# end

			####################
		end
	end
end

b_threads.each do |t|
	t.join
end