require 'shoes'
Shoes.app(
		title:"this is a title",
		width: 600,
		height: 600
	) do
	@test = flow :height=>20, :width=>1.0 do
		background black
		para "hi"
	end
	@buttons = flow do
		button "push" do
			@test.toggle()
		end
	end
end
