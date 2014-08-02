# methods_io.rb
# methods for input/output to various streams

########################
#       FILE  IO       #
########################

# f_getsLine
# a variation on gets() that ignores:
# 	whole-line comments starting with '#'
# 	blank lines
# ARGS:
# 	source file as type FILE

def f_getsLine(
		file
	)
	line = file.gets().chomp
	while line.strip.nil? == true || line == "\n" || line[0] == '#' || line == ""
		line = file.gets().chomp
	end
	return line
end

# f_createCopy
# creates a copy of the specified file
# ARGS:
# 	path to the original file as type STRING
# 	path to the copy file as type STRING

def f_createCopy(
		originalFileName,
		copyName
	)
	exitCode = 0
	originalFile = File.new(originalFileName,"r")
	copy = File.new(copyName,"w+")
	while line = originalFile.gets
		begin
			copy.print line
		rescue Errno.EACCES => e
			puts e
			exitCode = 1
		end
	end
	originalFile.close
	copy.close
	return exitCode
end