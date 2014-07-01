require 'socket'
load('../common/constants.rb')
load('../common/classes.rb')
load('../common/methods_io.rb')
load('../common/methods_irc.rb')
load('../common/methods_rirc.rb')

@rirc = Shoes.app(
		title: "r.irc #{VERSION}",
		width: WINDOW_WIDTH,
		height: WINDOW_HEIGHT
	) do # gui wrapper
	$threads = []
	$threads_tabs = []
	$threads << t_gui = Thread.new do
		@flow1 = flow :height=>1.0 do
			border silver, :strokewidth=>1 # faint interior windor border
			g_statusBar()
			# at least one of the below two must be hidden at any time!
			g_tabBarContainer()
			g_chatContainer()
			g_newTabPage()
			# if($application.currentTab == -1)
			# 	# no tabs open
			# 	# draw "empty window" with new tab prompt
			# 	@noTabButton.show()
			# 	@tabBarContainer.hide()
			# else
			# 	@noTabButton.hide()
			# 	@tabBarContainer.show()
			# end
		end
	end

	$threads << t_back = Thread.new do
		# back end
		b_startup()
		# loop do
		# 	if($application.currentTab == -1)
		# 		# there are no tabs open !
		# 	else
		# 		# there is at least one tab open
		# 	end
		# end
		# $threads_tabs.each do |thr|
		# 	thr.join
		# end
	end

	$threads.each do |thr|
		thr.join
	end
end