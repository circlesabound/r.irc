require '../common/methods_io.rb'

puts "## duplicating 'test' ##"
puts "Return with code #{f_createCopy('test','test2')}"
puts "\n## dumping original file ##\n"
o = File.new('test','r')
while l = o.gets
    puts l
end
puts "\n## dumping new file ##\n"
n = File.new('test2','r')
while l = n.gets
    puts l
end
o.close
n.close
puts "\n"
