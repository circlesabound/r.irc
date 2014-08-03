require 'thread'

a = Thread.new do
	gets
end
puts "#{a.status}"
a.stop
puts "#{a.status}"