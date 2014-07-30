# require 'java'

# module MouseWheel
#   def mouse_wheel &blk
#     unless @mwcs
#       @mwcs = []
#       app = self
#       ml = Swt::MouseWheelListener.new
#         class << ml; self end.
#         instance_eval do
#           define_method(:mouseScrolled){|e| app.mouse_wheel_control e.count > 0 ? :up : :down}
#         end
#       gui.real.addMouseWheelListener ml
#     end
#     @mwcs << blk
#   end

#   def mouse_wheel_control direction
#     @mwcs.each{|blk| blk[direction]}
#   end
# end

# Shoes.app(
# 		title:"this is a title",
# 		width: 600,
# 		height: 600
# 	) do
# 	extend MouseWheel
# 	@l = para "no scroll"
# 	mouse_wheel do |direction|
# 		@l.replace "#{direction}"
# 	end
# end
