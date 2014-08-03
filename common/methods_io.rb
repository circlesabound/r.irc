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
	arr = f_loadFileIntoArray(originalFileName)
	f_writeFileFromArray(copyName,arr)
end

def f_loadFileIntoArray(
		fileName
	)
	arr = Array.new
	f = File.new(fileName,"r")
	while line = f.gets
		arr << line.chomp
	end
	f.close
	return arr
end

def f_modifyProfileCount(
		fileName,
		newCount
	)
	arr = f_loadFileIntoArray(fileName)
	if arr.include?("[count]")
		index = arr.index("[count]") + 1
		arr[index] = String(newCount)
		f_writeFileFromArray(fileName,arr)
	else
		# bad profilesFile !
	end
end

def f_writeFileFromArray(
		fileName,
		arr
	)
	f = File.new(fileName,"w")
	arr.each do |l|
		f.print "#{l}\n"
	end
	f.close
end