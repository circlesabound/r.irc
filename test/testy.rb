Shoes.app(title:"this is a title") do
	@test = flow :height=>20 do
		background black
		para "hi"
	end
	@buttons = flow do
		button "push" do
			@test.toggle()
		end
	end
end