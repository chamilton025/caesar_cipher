#!/c/RailsInstaller/Ruby2.2.0/bin/ruby

module Enumerable
    def my_each
    	return self unless block_given?
        for i in 0...self.size do
            yield(self[i])
        end
    end

    def my_each_with_index
    	return self unless block_given?
        for i in 0...self.size do
            yield(self[i], i)
        end
    end

    def my_select
    	return self unless block_given?
        newArr = []
        my_each do |n|
            if yield(n)
                newArr.push(n)
            end
        end
        return newArr
    end

    def my_all?
        allT = true
        my_each do |n|
            if !yield(n)
                allT = false
            end
        end
        allT
    end

    def my_any?
        anyT = false
        my_each do |n|
            if yield(n)
                anyT = true
            end
        end
        anyT
    end

    def my_none?
        noneT = true
        self.my_each do |n|
            if yield(n)
                noneT = false
            end
        end
        noneT
    end

    def my_count(*item)
        c = 0
        if block_given?
        	my_each do |n|
        		if yield(n)
    				c+=1
    			end
    		end
    	elsif item.length==1
    		my_each do |n|
    			if n==item[0]
    				c+=1
    			end
    		end
        else
        	c=size
        end
        c
    end
    
    def my_map(*args)
    	return self if (!block_given?) && (args.size==0)
    	newArr = []
    	if args.size==1
    		argProc = args[0]
    		my_each do |n|
    			newArr.push(argProc.call(n))
    		end
    	else
	    	my_each do |n|
	    		newArr.push(yield(n))
	    	end
	    end
    	newArr
    end
    
    def my_inject(*args)
    	reuse = lambda do |init,sym,start|
    		retVal = init
    		for i in start...size do
    			retVal = sym.to_proc.call(retVal,self[i])
    		end
    		retVal
    	end
    	if block_given?
    		if args.size==1
    			initial = args[0]
    			return self unless initial.is_a?Integer
    			
    			retVal = initial
    			my_each do |n|
    				retVal = yield(retVal,n)
    			end
    			retVal
    		elsif args.size==0
    			retVal = self[0]
    			for i in 1...size do
    				retVal = yield(retVal,self[i])
    			end
    			retVal
    		else
    			return self
    		end
    	else
    		if args.size==2
    			initial = args[0]
    			sym = args[1]
    			return self unless (initial.is_a?Integer) && (sym.is_a?Symbol)
    			
    			retVal = reuse.call(initial, sym, 0)
    			retVal
			elsif args.size==1
				sym = args[0]
				return self unless sym.is_a?Symbol

    			retVal = reuse.call(self[0], sym, 1)
    			retVal
    		else
    			return self
    		end
    	end
    end
end

testArr = [1,2,3,3,4,5]

############################
testArr.my_each do |n|
    puts n*3
end

############################
testArr.my_each_with_index do |n,i|
    puts "#{n}, #{i}"
end

############################
newArr = testArr.my_select do |n|
    n.even?
end
puts newArr.join(",")

############################
ans = testArr.my_all? do |n|
    n.is_a?Integer
end
puts ans

############################
ans = testArr.my_any? do |n|
    n==0
end
puts ans

############################
ans = testArr.my_none? do |n|
    n==0
end
puts ans

############################
ans = testArr.my_count do |n|
    n%2==0
end
puts ans

############################
newArr = testArr.my_map do |n|
	n**n
end
puts newArr.join(",")

############################
ans =  %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
puts ans

############################
def multiply_els(pArr)
	ans = pArr.my_inject(:*)
	puts ans
end
multiply_els([2,4,5])

############################
testProc = Proc.new do |n|
	n**2
end
ans = testArr.my_map(testProc) do |n|
	n**3
end
puts ans.join(",")
