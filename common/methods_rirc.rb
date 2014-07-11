##################################################################################
##                                                                              ##
##     BACK END METHODS                                                         ##
##                                                                              ##
##################################################################################

def b_startup
	begin
		$profiles = Profile.load("../common/profilesFile")
	rescue ReadError => e
		p "Could not read profilesFile: #{e}"
	end
	begin
		$settings = Settings.load("../common/settingsFile")
	rescue ReadError => e
		p "Could not read settingsFile: #{e}"
	end
	# for i in 0..Profile.count-1
	# 	if Integer(profiles[i].profileID) == settings.defaultProfile
	# 		$defaultProfile = i
	# 	end
	# end
	$tabs = [] # init tab array
	# $application = Application.load($settings)
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
		newLine
	)
	if messageArray.count >= MAX_HISTORY
		messageArray.shift
		messageArray << newLine
	else
		messageArray << newLine
	end
end

def b_newTab(
		ta
	)
	$tabs[ta.id] = ta
	con = $tabs[ta.id].connection
	$tabs[ta.id].threads['r'] = Thread.new do
		while incoming = con.gets
			b_addToHistory($tabs[ta.id].messages,incoming)
		end
	end
	$tabs[ta.id].threads['s'] = Thread.new do
		while outgoing = $tabs[ta.id].queue.pop
			b_addToHistory($tabs[ta.id].messages,outgoing)
			# need to actually send the message !!
		end
	end
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
		tabId
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
				$tabs[tabId].window['statusbar_cm'] = g_smallPara("Channel modes: +placeholder")
				every 5 do
					$tabs[tabId].window['statusbar_cm'].text = "Channel modes: +"
					$tabs[tabId].window['statusbar_cm'].text << "placeholder"
				end
			end
		end
		stack :width=>0.35, :height=>1.0 do # user modes container
		# stack :width=>0.25, :height=>1.0 do # user modes container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				$tabs[tabId].window['statusbar_um'] = g_smallPara("User modes: +placeholder")
				every 5 do
					$tabs[tabId].window['statusbar_um'].text = "User modes :+"
					$tabs[tabId].window['statusbar_um'].text << "placeholder"
				end
			end
		end
		stack :width=>0.30, :height=>1.0 do # online/offline indicator container
		# stack :width=>0.25, :height=>1.0 do # online/offline indicator container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				$tabs[tabId].window['statusbar_network'] = g_smallPara("ONLINE","green")
				# $tabs[tabId].window['statusbar_network'] = g_smallPara("OFFLINE","red")
				# $tabs[tabId].window['statusbar_network'] = g_smallPara("UNKNOWN")
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

def g_mainWindow
	Shoes.app(
			title: "r.irc #{VERSION}",
			width: 100,
			height: 100
		) do
		button "new" do
			@newtabdialog = g_newTabDialog
		end
	end
end

def g_newTabDialog
	dialog = window do
		stack do
			serverLine = edit_line :text => "irc.rizon.net"
			portLine = edit_line :text => "6667"
			usernameLine = edit_line
			modesLine = edit_line
			realnameLine = edit_line
			nicknameLine = edit_line
			channelLine = edit_line
			newTabConfirmButton = button "go" do
				channelArray = []
				channelArray << channelLine.text
				ta = Tab.create(
					serverLine.text,
					portLine.text,
					usernameLine.text,
					modesLine.text,
					realnameLine.text,
					nicknameLine.text,
					channelArray
				)
				# this makes the connection to the server
				b_newTab(
					ta
				)
				g_newTab(
					ta.id
				)
				dialog.close
			end
		end
	end
	# return dialog
end

def g_newTab(
		id
	)
	$tabs[id].threads['g'] = Thread.new do
		$tabs[id].window['window'] = Shoes.app(
				width: WINDOW_WIDTH,
				height: WINDOW_HEIGHT
			) do
			flow do
				$tabs[id].window['messagebox'] = stack do
					g_para("test")
				end
				every 0.5 do
					$tabs[id].window['messagebox'].clear
					$tabs[id].messages.each do |m|
						$tabs[id].window['messagebox'].append do
							g_para("#{m}")
						end
					end
				end
			end
			$tabs[id].window['statusbar'] = g_statusBar(id)
		end
	end
	$tabs[id].threads.each do |key,thr|
		thr.join
		# $tabs[id].threads['g'].join
	end
end