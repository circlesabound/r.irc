Shoes.app(title:"this is a title") do
	background black
	border white,strokewidth:1
	@input = edit_line
	button "press me" do
		alert(@input.text)
		border white
	end
end