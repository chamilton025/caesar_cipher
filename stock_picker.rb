def stock_picker (pArr)
	dayToBuy = 0
	dayToSell = 1
	totalProfit=0
	
	pArr.each do |pBuyDay|
		for i in (pArr.index(pBuyDay)+1)...pArr.size do
			pSellDay = pArr[i]
			tempProfit = pSellDay-pBuyDay
			
			if tempProfit > totalProfit
				dayToBuy = pArr.index(pBuyDay)
				dayToSell = pArr.index(pSellDay)
				totalProfit = tempProfit
			end
		end
	end
	
	newArr = [dayToBuy, dayToSell]
	newArr
end
