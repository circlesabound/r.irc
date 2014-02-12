require 'socket'
load('../commands.rb')

Shoes.app {
	def u_input
		@inputDisplay.clear
		@inputArray.each { |t|
			@inputDisplay.append{
				para t
			}
		}
	end
	s = TCPSocket.new "localhost","6667"
	s.puts "USER username 0 * realname"
	s.puts "NICK nickname"
	s.puts "JOIN #test"
	threads=[]
	flow {
		@input = edit_line
		threads << t_input = Thread.new {
			button("submit") {
				# @inputArray << @input.text
				@inputArray << "> " + @input.text
				s.puts @input.text
				u_input
				@input.text = ""
			}
		}
		threads << t_read = Thread.new {
			while incoming = s.gets
				@inputArray << incoming
				u_input
			end
		}
	}
	stack {
		para "r.irc s0"
		@inputArray=[]
		@inputDisplay=stack
	}
}