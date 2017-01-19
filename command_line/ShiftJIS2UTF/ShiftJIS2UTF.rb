open_dir_name = './input_shift_jis/'
output_dir_name = './output_utf/'
file_names = Dir.entries(open_dir_name)
file_names.select! {|item| /[^.]+\.[^.]+/ === item }

file_names.each_with_index do |file_name, index|
	puts "-----------#{file_name}-----------"
	File.open(open_dir_name + file_name, 'r',  encoding: "Shift_JIS:UTF-8") do |input|
		output = File.open(output_dir_name + file_name, 'w', encoding: "UTF-8")
		output.puts(input.read)
		output.close()
	end
end
