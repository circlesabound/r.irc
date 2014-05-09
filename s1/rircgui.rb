require 'socket'
load('../common/methods_io.rb')
load('../common/methods_irc.rb')
load('../common/classes.rb')

threads = []
threads << t_gui = Thread.new{
	Shoes.app {
		# GUI wrapper
	}
}

threads << t_back = Thread.new{
	# back end
	startup()
}