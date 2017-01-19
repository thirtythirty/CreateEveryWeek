
open_dir_name = './input_utf/'
output_dir_name = './output_shift_jis/'
file_names = Dir.entries(open_dir_name)
file_names.select! {|item| /[^.]+\.[^.]+/ === item }

file_names.each_with_index do |file_name, index|
	puts "-----------#{file_name}-----------"
	File.open(open_dir_name + file_name, 'r',  encoding: "UTF-8:Shift_JIS") do |input|
		output = File.open(output_dir_name + file_name, 'w', encoding: "Shift_JIS")
		input.each do |i|
			o = i.encode
			output.puts(o)
		end
		output.close()
	end
end
