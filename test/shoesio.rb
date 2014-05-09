require 'rubygems'

Shoes.app {
	push = button "Push me!"
	push.click {
		alert(
			if 1
				puts "hi"
			else
				puts "no" # this outputs to console
			end
		)
	}
}