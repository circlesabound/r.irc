require 'socket'
require 'thread'
require 'shoes'
require_relative '../common/constants.rb'
require_relative '../common/classes.rb'
require_relative '../common/methods_io.rb'
require_relative '../common/methods_irc.rb'
require_relative '../common/methods_rirc.rb'

b_startup

# for k in 0..Profile.count-1
# 	if Integer($profiles[k].profileID) == $settings.defaultProfile
# 		currentProfile = k
# 	end
# end

g_mainWindow