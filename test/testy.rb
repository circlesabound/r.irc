Shoes.app(title:"this is a title") do
	flow margin: 2 do
		border silver, strokewidth:1
		flow margin: 2 do
			@input = edit_line
			button "press me" do
				alert(@input.text)
			end
		end
	end
end