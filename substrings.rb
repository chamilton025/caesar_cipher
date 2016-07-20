def substrings (pStr, dictionary)
	frequencies = Hash.new(0)
	
	strArr = pStr.split
	
	strArr.each do |word|
		word.downcase!
		word.gsub!(/\W+/, '')
		
		dictionary.each do |dictWord|
			if word.include? dictWord
				frequencies[dictWord]+=1	
			end
		end
	end
	
	frequencies
end
