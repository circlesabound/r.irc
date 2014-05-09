require 'socket'
load('../commands.rb')

Shoes.app {
	def u_input
		@inputDisplay.clear
		@inputArray.each { |t|
			@inputDisplay.append {
				para t
			}
		}
	end
	s = TCPSocket.new "localhost","6667"
	s.puts "USER username 0 * realname"
	s.puts "NICK rircs0"
	s.puts "JOIN #test"
	threads=[]
	stack {
		para "r.irc s0"
		@inputArray=[]
		@inputDisplay=stack
	}
	@inputflow = flow {
		@input = edit_line
		threads << t_input = Thread.new {
			@inputflow.append button("submit") {
				if @input.text[0]=="/"
					strippedCommand=@input.text[1..@input.text.length].upcase
					case strippedCommand
						when "QUIT","BYE","EXIT"
							s.close()
							@inputArray << "Bye"
							threads.each {|t| t.kill}
					end
				else
					@inputArray << "> " + @input.text
					s.puts @input.text
				end
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
		# threads.each {|t| t.join}
		if threads.length()==0
			# close window
		end
	}
}