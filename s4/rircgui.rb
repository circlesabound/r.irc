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

############ WINDOW MODULES ############

## MAIN MENU WINDOW MODULE

def g_menu
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
			@menuTitleContainer = flow :width=>1.0, :height=>FONT_SIZE+50 do
				stack :width=>0.25, :height=>1.0 do
					# padding
				end
				stack :width=>0.50, :height=>1.0, :margin=>2 do
					# font declaration doesn't work
					# it's using Arial or something
					para "r.IRC", :align=>'center', :font=>FONT_TITLE
					# title
				end
				stack :width=>0.25, :height=>1.0 do
					# padding
				end
			end
			@menuButtonsContainer = stack :width=>1.0, :margin=>2 do
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
							g_newTab
						end
					end
					stack :width=>0.33, :height=>1.0 do
						# padding
					end
				end
				flow :height=>10 do
					# padding
				end
				@menuSettingsButtonContainer = flow :height=>FONT_SIZE+30 do
					stack :width=>0.33, :height=>1.0 do
						# padding
					end
					stack :width=>0.34, :height=>1.0 do
						@settingsButton = button "settings", :width=>1.0, :height=>1.0 do
							# settings
							g_settings
						end
					end
					stack :width=>0.33, :height=>1.0 do
						# padding
					end
				end
				flow :height=>10 do
					# padding
				end
				@menuHelpButtonContainer = flow :height=>FONT_SIZE+15 do
					stack :width=>0.40, :height=>1.0 do
						# padding
					end
					stack :width=>0.20, :height=>1.0 do
						@helpButton = button "help", :width=>1.0, :height=>1.0 do
							# help
							g_help
						end
					end
					stack :width=>0.40, :height=>1.0 do
						# padding
					end
				end
			end
		end
	end
end

## CHAT WINDOW MODULE

def g_newTab
	Shoes.app(
			title: "r.IRC #{VERSION} - chat",
			width: WINDOW_WIDTH,
			height: WINDOW_HEIGHT
		) do
		# container to avoid resizing shenanigans
		@chatWindowContainer = stack :width=>WINDOW_WIDTH, :height=>WINDOW_HEIGHT do
			g_makeChatContainer
			g_chatContainer
		end
	end
end

## SETTINGS WINDOW MODULE

def g_settings
	Shoes.app(
			title: "Settings",
			width: SETTINGS_WIDTH,
			height: SETTINGS_HEIGHT
		) do
		# container to avoid resizing shenanigans
		@settingsContainer = stack :width=>SETTINGS_WIDTH, :height=>SETTINGS_HEIGHT do
			flow :height=>50 do
				# padding
			end
			@settingsTitleContainer = flow :height=>FONT_SIZE+50, :margin_left=>SETTINGS_WIDTH/10 do
				# font declaration doesn't work
				# it's using Arial or something
				para "settings", :align=>'center', :font=>FONT_TITLE
				# title
			end
			flow :height=>50 do
				# padding
			end
			#
		end
	end
end

## HELP WINDOW MODULE

def g_help
	Shoes.app(
			title: "Help",
			width: HELP_WIDTH,
			height: HELP_HEIGHT
		) do
		# container to avoid resizing shenanigans
		@helpContainer = stack :width=>HELP_WIDTH, :height=>HELP_HEIGHT do
			flow :height=>50 do
				# padding
			end
			@helpTitleContainer = flow :height=>FONT_SIZE+50, :margin_left=>HELP_WIDTH/10 do
				# font declaration doesn't work
				# it's using Arial or something
				para "help", :align=>'center', :font=>FONT_TITLE
				# title
			end
			flow :height=>50 do
				# padding
			end
			#
		end
	end
end

############ MAIN FUNCTION ############

b_startup
g_menu