require 'rubygems'
require 'zip'

Shoes.app(
		title:"this is a title",
		width: 600,
		height: 600
	) do
	list_box items: ["hi","its","me"]
end
