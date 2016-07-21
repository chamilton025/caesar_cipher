#!/c/RailsInstaller/Ruby2.2.0/bin/ruby

module Enumerable
    def my_each
        for i in 0...self.size do
            yield(self[i])
        end
    end

    def my_each_with_index
        for i in 0...self.size do
            yield(self[i], i)
        end
    end

    def my_select
        newArr = []
        self.my_each do |n|
            if yield(n)
                newArr.push(n)
            end
        end
        newArr
    end

    def my_all?
        allT = true
        self.my_each do |n|
            if !yield(n)
                allT = false
            end
        end
        allT
    end

    def my_any?
        anyT = false
        self.my_each do |n|
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
        if item.length==0
            if !block_given?
                puts block_given?
                puts "here instead"
                return self.size
            else
                puts "here"
                self.my_select do |n|
                    puts n
                    yield(n)
                end.size
            end
        else
            self.my_select do |n|
                n==item[0]
            end.size
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
print newArr
puts 

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
testArr.my_count do |n|
    n%2==0
end