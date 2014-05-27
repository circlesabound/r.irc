##################################################################################
##                                                                              ##
##     BACK END METHODS                                                         ##
##                                                                              ##
##################################################################################

def startup
	$profiles = Profile.load("../common/profilesFile")
	$settings = Settings.load("../common/settingsFile")
	# for i in 0..Profile.count-1
	# 	if Integer(profiles[i].profileID) == settings.defaultProfile
	# 		$defaultProfile = i
	# 	end
	# end
	$tabs = [] # init tab array
	$application = Application.load($settings)
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
		para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>black
	when "green"
		para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>green
	when "red"
		para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>red
	else
		para "#{text}", :font=>"#{FONT_SIZE}px", :stroke=>black
	end
end

def g_para(
		text,
		align = "left"
	)
	para "#{text}", :font=>"12px", :align=>align
end

def g_statusBar
	flow :width=>1.0, :height=>FONT_SIZE+10, :bottom=>0 do # status bar container
		border silver, :strokewidth=>1
		stack :width=>0.25, :height=>1.0 do # identity container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				g_smallPara("Identity:")
			end
		end
		stack :width=>0.25, :height=>1.0 do # channel modes container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				g_smallPara("Channel modes:")
			end
		end
		stack :width=>0.25, :height=>1.0 do # user modes container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				g_smallPara("User modes:")
			end
		end
		stack :width=>0.25, :height=>1.0 do # online/offline indicator container
			border silver, :strokewidth=>1
			stack :width=>1.0, :height=>1.0, :margin=>2 do
				# g_smallPara("ONLINE","green")
				g_smallPara("OFFLINE","red")
			end
		end
	end
end

def g_noTabPage
	# @noTabPage = flow :width=>1.0, :height=>1.0 do
	# 	stack :width=>0.3, :height=>1.0 # left padding
	# 	stack :width=>0.4, :height=>1.0 do # middle container
	# 		stack :width=>1.0, :height=>0.2 #top padding
	# 		stack :width=>1.0 do
	# 			g_para("No tabs open","center")
	# 		end
	# 	end
	# 	stack :width=>0.3, :height=>1.0 # right  padding
	# end
	@noTabButton = button "No Tabs", :left=>0.5, :top=>0.5
end