require 'rubygems'
require 'zip'

require 'socket'
require 'thread'
require 'java'

require_relative 'common/constants.rb'
require_relative 'common/classes.rb'
require_relative 'common/methods_io.rb'
require_relative 'common/methods_irc.rb'
require_relative 'common/methods_rirc.rb'

## PREPARING FOR STARTUP

b_startup

## LOAD MAIN WINDOW

Shoes.app(
		title: "r.irc #{VERSION}",
		width: MENU_WIDTH,
		height: MENU_HEIGHT
	) do
	# load font: FF DIN Regular
	# "DINPro-Regular"
	font('res/DINPro-Regular.otf')
	# full container required to counter-act
	# any weird GUI redraws when resizing
	@menuContainer = stack :width=>MENU_WIDTH, :height=>MENU_HEIGHT do
		# a hacky way to center the title, since
		# TextBlock is not fully implemented
		flow :height=>50 do
			# padding
		end
		@titleContainer = flow :width=>1.0, :height=>FONT_SIZE+50 do
			stack :width=>0.25, :height=>1.0 do
				# padding
			end
			stack :width=>0.50, :height=>1.0, :margin=>2 do
				# font declaration doesn't work
				# it's using Arial or something
				para "r.IRC", :align=>'center', :font=>"DINPro 47px"
				# title
			end
			stack :width=>0.25, :height=>1.0 do
				# padding
			end
		end
		@buttonsContainer = stack :width=>1.0, :margin=>2 do
			flow :height=>50 do
				# padding
			end
			@newChatButtonContainer = flow :height=>FONT_SIZE+30 do
				stack :width=>0.33, :height=>1.0 do
					# padding
				end
				stack :width=>0.34, :height=>1.0 do
					@newChatButton = button "new chat", :width=>1.0, :height=>1.0 do
						# new chat
					end
				end
				stack :width=>0.33, :height=>1.0 do
					# padding
				end
			end
			flow :height=>10 do
				# padding
			end
			@optionsButtonContainer = flow :height=>FONT_SIZE+30 do
				stack :width=>0.33, :height=>1.0 do
					# padding
				end
				stack :width=>0.34, :height=>1.0 do
					@optionsButton = button "options", :width=>1.0, :height=>1.0 do
						# options
					end
				end
				stack :width=>0.33, :height=>1.0 do
					# padding
				end
			end
			flow :height=>10 do
				# padding
			end
			@helpButtonContainer = flow :height=>FONT_SIZE+15 do
				stack :width=>0.40, :height=>1.0 do
					# padding
				end
				stack :width=>0.20, :height=>1.0 do
					@helpButtonContainer = button "help", :width=>1.0, :height=>1.0 do
						# help
					end
				end
				stack :width=>0.40, :height=>1.0 do
					# padding
				end
			end
		end
	end
end