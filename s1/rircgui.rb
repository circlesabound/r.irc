require 'socket'
load('../common/classes.rb')
load('../common/methods_io.rb')
load('../common/methods_irc.rb')

$threads = []
$threads << t_gui = Thread.new do
	rirc = Shoes.app do # gui wrapper
		#
	end
end

$threads << t_back = Thread.new do
	# back end
	startup()
end

$threads.each do |thr|
	thr.join
end