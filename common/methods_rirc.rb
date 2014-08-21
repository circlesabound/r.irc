##################################################################################
##                                                                              ##
##     TEST METHODS                                                             ##
##                                                                              ##
##################################################################################

def putToConsole(
		str
	)
	puts str
end

def getFromConsole
	return gets.chomp
end

def sendFromConsole(
		id
	)
	str = getFromConsole
	$tabs[id].queue << str
end

def putIncomingToConsole(
		str
	)
	begin
		n = b_processIncoming(str)
		if n[:prefix_host]
			print n[:host] << " : "
		elsif n[:prefix_user]
			print n[:nick] << " : "
		end
		if n[:params]
			print n[:params] << " "
		end
		if n[:trailing]
			print n[:trailing]
		end
	rescue NoMethodError => e
		print "! #{e}"
	end
	print "\n"
end


##################################################################################
##                                                                              ##
##     BACK END METHODS                                                         ##
##                                                                              ##
##################################################################################

def b_startup
	begin
		$profiles = Profile.load
	rescue StandardError => e
		p "Could not read profilesFile: #{e}"
	end
	begin
		$settings = Settings.load
	rescue StandardError => e
		p "Could not read settingsFile: #{e}"
	end
	$tabs = [] # init tab array
end

# def b_newTab(
# 		server,
# 		port,
# 		name = -1
# 	)
# 	s = TCPSocket.new("#{server},#{port}")
# 	if name != -1
# 		t = Tab.create(s,"#{name}")
# 	else
# 		t = Tab.create(s,"#{server}:#{port}")
# 	end
# 	$tabs[t.id] = t
# end

def b_addToHistory(
		messageArray,
		newLine,
		id,
		direction
	)
	if direction == 'i'
		# incoming message, process it !
		message = b_processIncoming(newLine)
		if message[:command] == "PING"
			# autorespond to pings
			putToConsole("PING") # DEBUGGING
			b_pingResponse(id,message)
		# elsif message[:command] == "NICK"
		# 	# nickname change
		# 	message[:trailing] = "#{message[:prefix_user]} is now known as #{message[:trailing]}"
		# 	message[:prefix_user] = ""
		# 	message[:prefix_host] = ""
		# 	if messageArray.count >= $settings.maxMessageHistory
		# 		messageArray.shift
		# 	end
		# 	messageArray << message
		# 	puts newLine
		elsif message[:command] == "411"
			# no recipient for privmsg
			putToConsole("441")
			putToConsole("#{message}")
			b_statusQuery_nick(
					id,
					message
				)
		elsif message[:command] == "324"
			# channel mode
			putToConsole("324")
			putToConsole("#{message}")
			putToConsole("#{message[:trailing]}")
			b_statusQuery_cm(
					id,
					message
				)
		elsif message[:command] == "329"
			# channel creation timestamp in unix time
			putToConsole("329")
		elsif message[:command] == "221"
			# user mode
			putToConsole("221")
			putToConsole("#{message}")
			b_statusQuery_um(
					id,
					message
				)
		else
			if messageArray.count >= $settings.maxMessageHistory
				messageArray.shift
			end
			messageArray << message
			puts newLine
		end
	elsif direction == 'o'
		# outgoing message, process it differently !
		if messageArray.count >= $settings.maxMessageHistory
			messageArray.shift
		end
		# PROBLEM !!!
		# messageArray should only accept
		# output from b_processIncoming or the like !!

		# messageArray << newLine

		# below is a bad, horrible, roundabout solution
		# it's so bad it doesn't even work properly
		newLine1 = Hash.new
		newLine1[:prefix_user] = 1
		newLine1[:nick] = $tabs[id].nick
		newLine1[:trailing] = newLine
		messageArray << newLine1

		puts newLine
	end
		
	# putIncomingToConsole(newLine)
	# @display.syncExec do
	# 	# @messageBox.append do
	# 	# 	para b_formatIncoming(newLine), :font=>"8px"
	# 	# end
	# 	@messageBox.clear
	# 	messageArray.each do |m|
	# 		@messageBox.append do
	# 			para b_formatIncoming(m), :font=>"8px"
	# 		end
	# 	end
	# end
end

def b_newTab(
		id
	)
	con = $tabs[id].connection
	$tabs[id].threads['r'] = Thread.new do
		loop do
			if $tabs[id].paused
				Thread.stop
			end
			incoming = con.gets.chomp
			b_addToHistory($tabs[id].messages,incoming,id,'i')
		end
	end
	$tabs[id].threads['s'] = Thread.new do
		loop do
			if $tabs[id].paused
				Thread.stop
			end
			outgoing = $tabs[id].queue.pop
			b_addToHistory($tabs[id].messages,outgoing,id,'o')
			b_send(id,outgoing)
		end
	end
	# g_newTab(id)
end

def b_pingResponse(
		id,
		message
	)
	putToConsole("PONG") # DEBUGGING
	c_pong($tabs[id].connection,message[:trailing])
end

def b_send(
		id,
		str
	)
	s = $tabs[id].connection
	if b_isIrcCommand(str)
		str = str[1..str.length]
		b_executeIrcCommand(id,str)
	elsif b_isEscapedMessage(str)
		str = str[1..str.length]
		c_privmsg(s,$tabs[id].channel,str)
	else
		c_privmsg(s,$tabs[id].channel,str)
	end

end

def b_isIrcCommand(
		str
	)
	isCommand = false
	if str.length >= 2
		if str[0]=="/" && str[1]!="/"
			isCommand = true
		end
	end
	return isCommand
end

def b_isEscapedMessage(
		str
	)
	isEscapedMessage = false
	if str.length >= 2
		if str[0]=="/" && str[1]=="/"
			isEscapedMessage = true
		end
	end
	return isEscapedMessage
end

# def b_executeIrcCommand_cli(
# 		id,
# 		command
# 	)
# 	s = $tabs[id].connection
# 	s.puts commmand
# end

def b_executeIrcCommand(
#def b_executeIrcCommand_gui(
		id,
		rawCommand
	)
	s = $tabs[id].connection
	command = rawCommand.split(%r{\s+},2)
	# separate the command portion from the arguments
	case command[0].upcase
	when "ADMIN"
		c_admin(s,command[1])
	when "AWAY"
		(command[1].nil?) ? c_away(s) : c_away(s,command[1])
	# should add the rest of them in
	else
		s.puts rawCommand
	end
end

def b_processIncoming(
		message
	)
	# example raw message
	# :nickname!username@hostname.net PRIVMSG #channel :test

	# newMessage = Hash.new
	# begin
	# 	newMessage = message.match(/^(?<nick>.*)!(?<user>\S*) (?<waste>.*) :(?<content>.*)$/)
	# rescue NoMethodError
	# 	newMessage[:nick] = ""
	# 	newMessage[:content] = message
	# end
	begin
		# n = Hash.new
		# n = message.match(/^(?<from>:.+) (?<command>.+) (?<to>.*) (?<content>:.+)/)
		n = message.match(IRC_REGEX)
	rescue NoMethodError => e
		n =  nil
	end
	# return newMessage
	return n
end

def b_formatIncoming(
		n
	)
	s = ""
	begin
		if n[:prefix_host]
			s << "*#{n[:host]}* : "
		elsif n[:prefix_user]
			s << "<#{n[:nick]}> : "
		end
		# if n[:params]
		# 	s << n[:params] << " "
		# end
		if n[:trailing]
			s << n[:trailing]
		end
		s << ""
	rescue NoMethodError => e
		s << "! #{e}"
	end
	return s
end

def b_statusQuery_nick(
		id,
		message
	)
	# nick = "nickname"
	# s = $tabs[id].connection
	# # $tabs[id].paused = true
	# response = false
	# while response == false
	# 	# we execute a bad command in order to get
	# 	# the server response
	# 	c_privmsg($tabs[id].connection,"","")
	# 	# don't ask me why there needs to be two
	# 	c_privmsg($tabs[id].connection,"","")
	# 	incoming = s.gets.chomp
	# 	puts "> #{incoming}"
	# 	processed = b_processIncoming(incoming)
		# if processed[:trailing].match(/^PRIVMSG/) != nil
	if message[:trailing].strip.match(/\(PRIVMSG\)/) != nil
		# found the correct server response
		nick = message[:params].strip
		puts "> #{nick}"
		response = true
	else
		# incorrect response
		puts "> bad nick response"
	end
	# end
	# $tabs[id].paused = false
	# $tabs[id].threads['s'].run
	# $tabs[id].threads['r'].run
	$tabs[id].nick = nick
	# return nick
end

def b_statusQuery_cm(
		id,
		message
	)
	# cm = ""
	# # $tabs[id].paused = true
	# response = false
	# counter = 0
	# c_mode_channel(s,$tabs[id].channel)
	# # again i don't know why
	# c_mode_channel(s,$tabs[id].channel)
	# while response == false && counter < 10
	# 	incoming = s.gets.chomp
	# 	incoming = s.gets.chomp
	# 	processed = b_processIncoming(incoming)
	if message[:trailing].strip.match(/\+[a-zA-Z]+$/) != nil
		# cm = processed[:params].match(//).strip
		cm = message[:trailing].strip.match(/(?<cm>\+[a-zA-Z]+){0}^\#.+ (\g<cm>)$/x)[:cm]
		puts "> #{cm}"
		# response = true
	else
		puts "> bad cm response"
		# counter += 1
	end
	# end
	# $tabs[id].paused = false
	# $tabs[id].threads['s'].run
	# $tabs[id].threads['r'].run
	# return cm
	$tabs[id].cm = cm
end

def b_statusQuery_um(
		id,
		message
	)
	# um = ""
	# s = $tabs[id].connection
	# # $tabs[id].paused = true
	# response = false
	# while response == false
	# 	c_mode_user(s,$tabs[id].nick)
	# 	# again i don't know why
	# 	c_mode_user(s,$tabs[id].nick)
	# 	incoming = s.gets.chomp
	# 	processed = b_processIncoming(incoming)
	if message[:trailing].strip.match(/^\+[a-zA-Z]+$/) != nil
		um = message[:trailing].strip.match(/^\+[a-zA-Z]+$/)
		puts "> #{um}"
	else
		puts "> bad um response"
	end
	# end
	# $tabs[id].paused = false
	# $tabs[id].threads['s'].run
	# $tabs[id].threads['r'].run
	# return um
	$tabs[id].um = um
end

def b_statusQuery_con(
		id
	)
	online = false
	# $tabs[id].paused = true
	# rubbish command to prompt server response
	c_privmsg($tabs[id].connection,"","")
	while response == false
		incoming = s.gets.chomp
		processed = b_processIncoming(incoming)
		if processed[:trailing].match(/^PRIVMSG/) != nil
			# found the correct server response
			online = true
			response = true
		else
			# incorrect response
		end
	end
	# online = false
	# $tabs[id].paused = false
	# $tabs[id].threads['s'].run
	# $tabs[id].threads['r'].run
	return online
end

##################################################################################
##                                                                              ##
##     FRONT END METHODS                                                        ##
##                                                                              ##
##################################################################################

def g_smallPara(
		text,
		colour = "black"
	)
	case colour
	when "black"
		obj = para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>black
	when "green"
		obj = para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>green
	when "red"
		obj = para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>red
	else
		obj = para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>black
	end
	return obj
end

def g_para(
		text,
		align = "left"
	)
	obj = para "#{text}", :font=>"12px", :align=>align
	return obj
end

def g_statusBar(
		id
	)
	flow :width=>1.0, :height=>FONT_SIZE+10, :bottom=>0 do # status bar container
		border silver, :strokewidth=>1
		# stack :width=>0.25, :height=>1.0 do # identity container
		# 	border silver, :strokewidth=>1
		# 	stack :width=>1.0, :height=>1.0, :margin=>2 do
		# 		g_smallPara("Identity:")
		# 	end
		# end
		stack :width=>0.35, :height=>1.0 do # channel modes container
		# stack :width=>0.25, :height=>1.0 do # channel modes container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				$tabs[id].window[:statusbar_cm] = g_smallPara("Channel modes: ")
				# $tabs[id].window[:statusbar_cm].text << ""
				thread_cm = Thread.new do
					@display.asyncExec do
						every 5 do
							c_mode_channel(
									$tabs[id].connection,
									$tabs[id].channel
								)
							# sleep(Random.rand(0...6))
							$tabs[id].window[:statusbar_cm].text = "Channel modes: "
							$tabs[id].window[:statusbar_cm].text << "#{$tabs[id].cm}"
						end
					end
				end
			end
		end
		stack :width=>0.35, :height=>1.0 do # user modes container
		# stack :width=>0.25, :height=>1.0 do # user modes container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				$tabs[id].window[:statusbar_um] = g_smallPara("User modes: ")
				# $tabs[id].window[:statusbar_um].text << ""
				thread_um = Thread.new do
					@display.asyncExec do
						every 5 do
							# sleep(Random.rand(0...6))
							c_mode_user(
									$tabs[id].connection,
									$tabs[id].nick
								)
							$tabs[id].window[:statusbar_um].text = "User modes: "
							$tabs[id].window[:statusbar_um].text << "#{$tabs[id].um}"
						end
					end
				end
			end
		end
		stack :width=>0.30, :height=>1.0 do # online/offline indicator container
		# stack :width=>0.25, :height=>1.0 do # online/offline indicator container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				# if b_statusQuery_con
				if true
					$tabs[id].window[:statusbar_con] = g_smallPara("ONLINE","green")
				else
					$tabs[id].window[:statusbar_con] = g_smallPara("OFFLINE","red")
				end
			end
		end
	end
end

# def g_newTabPage
# 	# @noTabPage = flow :width=>1.0, :height=>1.0 do
# 	# 	stack :width=>0.3, :height=>1.0 # left padding
# 	# 	stack :width=>0.4, :height=>1.0 do # middle container
# 	# 		stack :width=>1.0, :height=>0.2 #top padding
# 	# 		stack :width=>1.0 do
# 	# 			g_para("No tabs open","center")
# 	# 		end
# 	# 	end
# 	# 	stack :width=>0.3, :height=>1.0 # right  padding
# 	# end
# 	@newTabButton = button "No Tabs", :left=>0.5, :top=>0.5 do
# 		server = ask("server? :")
# 		port = ask("port? :")
# 		b_newTab(server,port)
# 		# s = TCPSocket.new "#{server}","#{port}"
# 		# currentTab = Tab.create(s,"#{server}:#{port}")
# 		# $tabs[currentTab.id] = currentTab
# 		# $tabs << currentTab = Tab.create(s,"#{server}:#{port}")
# 		alert("#{$tabs[0].name}")
# 		@tabList.text << $tabs[0].name << " | "
# 		@newTabButton.hide()
# 		$tabs[0].connection.puts "USER #{$profiles[$settings.defaultProfile].username} * #{$profiles[$settings.defaultProfile].realname}"
# 		$tabs[0].connection.puts "NICK #{$profiles[$settings.defaultProfile].nickname}"
# 		$tabs[0].connection.puts "JOIN #nsbhs"
# 		# while incoming = $tabs[0].connection.gets do
# 		# 	@history.text << incoming << "\n"
# 		# end
# 		while incoming = $tabs[0].connection.gets do
# 			alert(incoming)
# 		end
# 	end
# end

# def g_tabBarContainer
# 	@tabBarContainer = flow :width=>1.0, :height=>FONT_SIZE+25 do
# 		border black, :strokewidth=>1
# 		@tabList = para ""
# 	end
# end

# def g_chatContainer
# 	@chatContainer = flow :width=>1.0, :height=>1.0, :margin=>10 do
# 		border black, :strokewidth=>1
# 		@history = para ""
# 	end
# end

# def g_mainWindow
# 	Shoes.app(
# 			title: "r.irc #{VERSION}",
# 			width: 100,
# 			height: 100
# 		) do
# 		button "new" do
# 			g_newTabDialog
# 		end
# 	end
# end

# def g_newTabDialog
# 	@newTabDialog = window do
# 		stack do
# 			serverLine = edit_line :text => "irc.rizon.net"
# 			portLine = edit_line :text => "6667"
# 			usernameLine = edit_line
# 			modesLine = edit_line
# 			realnameLine = edit_line
# 			nicknameLine = edit_line
# 			channelLine = edit_line
# 			newTabConfirmButton = button "go" do
# 				channelArray = []
# 				channelArray << channelLine.text
# 				ta = Tab.create(
# 					serverLine.text,
# 					portLine.text,
# 					usernameLine.text,
# 					modesLine.text,
# 					realnameLine.text,
# 					nicknameLine.text,
# 					channelArray
# 				)
# 				# this makes the connection to the server
# 				b_newTab(
# 					ta
# 				)
# 				@display = ::Swt::Widgets::Display.getCurrent
# 				g_newTab(
# 					ta.id
# 				)
# 			end
# 		end
# 	end
# 	# return dialog
# end

# def g_newTab(
# 		id
# 	)
# 	# $tabs[id].threads['g'] = Thread.new do
# 		@display.asyncExec do
# 			# @newTabDialog.close
# 			$tabs[id].window[:window] = Shoes.app(
# 					width: WINDOW_WIDTH,
# 					height: WINDOW_HEIGHT
# 				) do
# 				flow do
# 					$tabs[id].window[:messagebox] = stack do
# 						g_para("test")
# 					end
# 					every 0.5 do
# 						$tabs[id].window[:messagebox].clear
# 						$tabs[id].messages.each do |m|
# 							$tabs[id].window[:messagebox].append do
# 								g_para("#{m}")
# 							end
# 						end
# 					end
# 				end
# 				$tabs[id].window[:statusbar] = g_statusBar(id)
# 			end
# 		end
# 	# end
# 	# $tabs[id].threads['g'].join
# 	$tabs[id].threads.each do |key,thr|
# 		thr.join
# 	end
# end

def g_makeChatContainer
	def changeMeansCustom
		# auto-select <custom> when changes are made
		@makeChatEntry_profile.choose("<custom>")
	end
	@makeChatContainer = stack :width=>1.0, :height=>1.0 do
		@makeChatTitleContainerPadding1 = flow :height=>50 do
			# padding
		end
		@makeChatTitleContainer = flow :height=>FONT_SIZE+50, :margin_left=>WINDOW_WIDTH/10 do
			# font declaration doesn't work
			# it's using Arial or something
			para "Join IRC channel", :align=>'center', :font=>FONT_TITLE
			# title
		end
		@makeChatTitleContainerPadding2 = flow :height=>50 do
			# padding
		end
		@makeChatEntryContainer = flow :height=>WINDOW_HEIGHT-2*(FONT_SIZE+50)-150, :margin=>5 do
			@makeChatEntryLeftContainer = stack :width=>0.5, :margin_right=>5, :margin_left=>20 do
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Server URL:"
					end
					@makeChatEntry_server = edit_line :margin_left=>10
				end
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Port:"
					end
					@makeChatEntry_port = edit_line :margin_left=>10
					@makeChatEntry_port.text = "6667"
				end
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Channel name:"
					end
					@makeChatEntry_channel = edit_line :margin_left=>10
				end
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Password (optional):"
					end
					@makeChatEntry_password = edit_line :margin_left=>10
				end
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "User modes:"
					end
					@makeChatEntry_um = edit_line :margin_left=>10
					@makeChatEntry_um.text = "0"
				end
			end
			@makeChatEntryRightContainer = stack :width=>0.5, :margin_right=>5, :margin_left=>20 do
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Profile:"
					end
					profileArray = Array.new
					$profiles.each do |p|
						profileArray << p.profileName
					end
					profileArray.unshift("<custom>")
					@makeChatEntry_profile = list_box :items=>profileArray
					@makeChatEntry_profile.change do
						profileName = @makeChatEntry_profile.text
						if profileName == "<custom>"
							# do nothing
						else
							$profiles.each do |p|
								if p.profileName == profileName
									@makeChatEntry_username.text = p.username
									@makeChatEntry_nickname.text = p.nickname
									@makeChatEntry_realname.text = p.realname
									@makeChatEntry_profile.choose(profileName)
								end
							end
						end
					end
				end
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Username:"
					end
					@makeChatEntry_username = edit_line :margin_left=>10
					@makeChatEntry_username.change do
						changeMeansCustom
					end
				end
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Nickname:"
					end
					@makeChatEntry_nickname = edit_line :margin_left=>10
					@makeChatEntry_nickname.change do
						changeMeansCustom
					end
				end
				flow :height=>FONT_SIZE+20, :margin=>2 do
					stack :width=>175, :margin_top=>2 do
						para "Real name:"
					end
					@makeChatEntry_realname = edit_line :margin_left=>10
					@makeChatEntry_realname.change do
						changeMeansCustom
					end
				end
				flow :height=>FONT_SIZE+50, :margin=>2 do
					@saveProfileButton = button "Save profile", :height=>0.5, :width=>102 do
						profileName = ask("Name your profile:")
						Profile.add(
								Profile.count,
								profileName,
								@makeChatEntry_nickname.text,
								@makeChatEntry_realname.text,
								@makeChatEntry_username.text
							)
						$profiles = Profile.load
						profileArray = Array.new
						$profiles.each do |p|
							profileArray << p.profileName
						end
						@makeChatEntry_profile.items = profileArray
					end
				end
			end
		end
		@makeChatButtonContainer = flow :height=>FONT_SIZE+50, :margin_left=>WINDOW_WIDTH-190 do
			@makeChatGoButton = button "Join", :height=>0.5, :width=>102 do
				begin
					@t = Tab.create(
							@makeChatEntry_server.text,
							@makeChatEntry_port.text,
							@makeChatEntry_username.text,
							@makeChatEntry_um.text,
							@makeChatEntry_realname.text,
							@makeChatEntry_nickname.text,
							@makeChatEntry_channel.text,
							@makeChatEntry_password.text
						)
				rescue StandardError => e
					putToConsole("could not connect: #{e}")
				end
				$tabs << @t
				@display = ::Swt::Widgets::Display.getCurrent
				@messageBoxContainer.append do
					@messageBox = stack :width=>1.0, :height=>1.0, :margin=>4 do
						# every 0.1 do
						# 	# @messageBox.text = ""
						# 	@messageBox.clear
						# 	$tabs[@t.id].messages.each do |m|
						# 		# @messageBox.text << m << "\n"
						# 		@messageBox.append do
						# 			para "#{m}\n"
						# 		end
						# 	end
						# end
						every 0.5 do
						# @display.asyncExec do
							@messageBox.clear
							$tabs[@t.id].messages.each do |m|
								@messageBox.append do
									para "#{b_formatIncoming(m)}", :font=>"#{$settings.messageFontSize}px"
								end
							end
						end
					end
				end
				@innerChatContainer.append do
					@inputBoxContainer = flow :margin=>10 do
						stack :width=>80, :margin=>2, :margin_top=>5 do
							@inputBoxNickname = para "#{@makeChatEntry_nickname.text}"
							thread_nick = Thread.new do
								@display.asyncExec do
									every 5 do
										c_privmsg($tabs[@t.id].connection,"","")
										@inputBoxNickname.text = "#{$tabs[@t.id].nick}"
									end
								end
							end
						end
						stack :width=>12, :margin=>2, :margin_top=>5 do
							para ">"
						end
						@inputBox = edit_line :width=>WINDOW_WIDTH-175
						@inputBoxSubmit = button "Send" do
							$tabs[@t.id].queue << @inputBox.text.chomp
							@inputBox.text = ""
						end
					end
					g_statusBar(@t.id)
				end
				b_newTab(@t.id)
				@makeChatContainer.clear
				@outerChatContainer.displace(0,-WINDOW_HEIGHT)
				@outerChatContainer.show
			end
			@makeChatCancelButton = button "Cancel", :height=>0.5, :width=>102 do
				self.close
			end
		end
	end
end

def g_chatContainer
	@outerChatContainer = stack :width=>1.0, :height=>1.0, :hidden=>true do
		# additional wrapper required to ensure
		# that elements don't drop out randomly
		@innerChatContainer = stack :width=>1.0, :height=>1.0 do
			@messageBoxContainer = flow :width=>1.0, :height=>WINDOW_HEIGHT-(FONT_SIZE+50), :margin=>5 do
				#
			end
		end
	end
end

def g_helpPage_1
	@helpContent.clear
	@helpContent.append do
		para "Getting started", :font=>"18px", :margin=>3, :margin_bottom=>6
		para "#{HELP_PAGE_1}", :margin=>3
		helpButton_next = button "Next", :height=>30, :width=>102 do
			g_helpPage_2
		end
		helpButton_next.move(HELP_WIDTH-175,HELP_HEIGHT-225)
	end
end

def g_helpPage_2
	@helpContent.clear
	@helpContent.append do
		para "Joining a channel - 1", :font=>"18px", :margin=>3, :margin_bottom=>6
		para "#{HELP_PAGE_2}", :margin=>3
		helpButton_previous = button "Previous", :height=>30, :width=>102 do
			g_helpPage_1
		end
		helpButton_previous.move(73,HELP_HEIGHT-225)
		helpButton_next = button "Next", :height=>30, :width=>102 do
			g_helpPage_3
		end
		helpButton_next.move(HELP_WIDTH-175,HELP_HEIGHT-225)
	end
end

def g_helpPage_3
	@helpContent.clear
	@helpContent.append do
		para "Joining a channel - 2", :font=>"18px", :margin=>3, :margin_bottom=>6
		para "#{HELP_PAGE_3}", :margin=>3
		helpButton_previous = button "Previous", :height=>30, :width=>102 do
			g_helpPage_2
		end
		helpButton_previous.move(73,HELP_HEIGHT-225)
		helpButton_next = button "Next", :height=>30, :width=>102 do
			g_helpPage_4
		end
		helpButton_next.move(HELP_WIDTH-175,HELP_HEIGHT-225)
	end
end

def g_helpPage_4
	@helpContent.clear
	@helpContent.append do
		para "Joining a channel - 3", :font=>"18px", :margin=>3, :margin_bottom=>6
		para "#{HELP_PAGE_4}", :margin=>3
		helpButton_previous = button "Previous", :height=>30, :width=>102 do
			g_helpPage_3
		end
		helpButton_previous.move(73,HELP_HEIGHT-225)
		helpButton_next = button "Next", :height=>30, :width=>102 do
			g_helpPage_5
		end
		helpButton_next.move(HELP_WIDTH-175,HELP_HEIGHT-225)
	end
end

def g_helpPage_5
	@helpContent.clear
	@helpContent.append do
		para "Main chat interface", :font=>"18px", :margin=>3, :margin_bottom=>6
		para "#{HELP_PAGE_5}", :margin=>3
		helpButton_previous = button "Previous", :height=>30, :width=>102 do
			g_helpPage_4
		end
		helpButton_previous.move(73,HELP_HEIGHT-225)
	end
end