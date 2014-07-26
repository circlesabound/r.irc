require 'socket'
require 'thread'
require 'shoes'
require 'java'
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
# $tabs.each do |t|
# 	t.threads.each do |key,thr|
# 		thr.join
# 	end
# end

# def testpara(st)
# 	every 1 do
# 		st.append do
# 			para "f"
# 		end
# 	end
# end

# a = []
# t = []

# Shoes.app(
# 		title: "r.IRC #{VERSION}",
# 		width: 300,
# 		height: 300
# 	) do
# 	@newButton = button "new" do
# 		a << Shoes.app(
# 				title: "window",
# 				width: 100,
# 				height: 100
# 			) do
# 			@display = ::Swt::Widgets::Display.getCurrent
# 			t << thr = Thread.new do
# 				begin
# 					@display.asyncExec do
# 						y = stack
# 						testpara(y)
# 					end
# 				rescue Exception => e
# 					p e.to_s
# 				end
# 			end
# 			sleep(10)
# 			thr.join
# 		end
# 	end
# 	@u = stack
# 	every 1 do
# 		# a.each do |s|
# 		# 	u.append do
# 		# 		para s
# 		# 	end
# 		# end
# 		@display = ::Swt::Widgets::Display.getCurrent
# 		ty = Thread.new do
# 			@display.asyncExec do
# 				@u.append do
# 					t.each do |thr|
# 						para "#{thr.status}"
# 					end
# 				end
# 			end
# 		end
# 		ty.join
# 	end
# end