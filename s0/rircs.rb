require 'socket'
# load('../commands.rb')

Shoes.app do
	def u_input
		every 0.1 do
			@inputDisplay.clear
			@inputArray.each { |t|
				@inputDisplay.append {
					para t
				}
			}
		end
	end
	s = TCPSocket.new "irc.rizon.net","6667"
	s.puts "USER rircs 0 * rircs"
	s.puts "NICK rircs0"
	s.puts "JOIN #nsbhs"
	threads = []
	stack {
		para "r.irc s0"
		@inputArray = []
		@inputDisplay = stack
	}
	@inputflow = flow {
		@input = edit_line
		# threads << t_input = Thread.new {
			button("submit") do
				if @input.text[0]=="/"
					strippedCommand=@input.text[1..@input.text.length].upcase
					case strippedCommand
						when "QUIT","BYE","EXIT"
							s.close()
							@inputArray << "Bye"
							threads.each do |thr|
								thr.kill
							end
					end
				else
					@inputArray << "> " + @input.text
					s.puts @input.text
				end
				u_input
				@input.text = ""
			end
		# }
		threads << t_read = Thread.new do
			every 0.1 do
				while incoming = s.gets
					@inputArray << incoming
					u_input
				end
			end
		end
		# threads.each {|t| t.join}
		if threads.length()==0
			# close window
		end
	}

	threads.each do |thr|
		thr.join
	end
end