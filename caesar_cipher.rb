def caesar_cipher (pStr, shift)
	alphabet = (10...36).map{|i| i.to_s 36}

	strArr = pStr.split("")
	newStr = Array.new
	
	strArr.each do |letter|
		upper = false
		if /[[:upper:]]/ =~ letter
			upper = true
			letter.downcase!
		end
		
		if !alphabet.include? letter
			newStr.push(letter)
		else
			letterIndex = alphabet.index(letter)
			newIndex = (letterIndex+shift)%26
			newLetter = alphabet[newIndex]
			if upper
				newLetter.upcase!
			end
			newStr.push(newLetter)
		end
	end
	
	newStr.join("")
end
