require 'socket'
load('../common/methods_io.rb')
load('../common/methods_irc.rb')
load('../common/classes.rb')

threads = []
threads << t_gui = Thread.new do
	Shoes.app do
		# GUI wrapper
	end
end

threads << t_back = Thread.new do
	# back end
	startup()
end

threads.each do |thr|
	thr.join
end