require 'socket'
require 'thread'
require 'shoes'
require_relative '../common/constants.rb'
require_relative '../common/classes.rb'
require_relative '../common/methods_io.rb'
require_relative '../common/methods_irc.rb'
require_relative '../common/methods_rirc.rb'

s = TCPSocket.new "irc.rizon.net","6667"

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
# queue = Queue.new

b_threads << receive = Thread.new do
	while incoming = s.gets
		# messages << incoming
		b_addToHistory(messages,incoming)
		# queue << incoming
	end
end

b_threads << send = Thread.new do
	while outgoing = gets
		# messages << outgoing
		b_addToHistory(messages,outgoing)
		# queue << outgoing
	end
end

b_threads << gui = Thread.new do
	Shoes.app(
			title: "r.irc #{VERSION}",
			width: WINDOW_WIDTH,
			height: WINDOW_HEIGHT
		) do
		@flow = flow do
			@messagebox = stack :height => 600, :scroll =>true do
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
		g_statusBar
	end
	c_part(s,"\#nsbhs","bye")
	send.kill
	receive.kill
	c_quit(s)
	s.close
end

b_threads.each do |t|
	t.join
end