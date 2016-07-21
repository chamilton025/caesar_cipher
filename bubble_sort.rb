def bubble_sort(pArr)
    n = pArr.size
    swapped = true

    until !swapped do
    swapped = false
        for i in 1...n do
            # If the element to the left is bigger than the one on the right
            if pArr[i-1] > pArr[i]
                pArr[i-1],pArr[i] = pArr[i],pArr[i-1]
                swapped = true
            end
        end
    end
    return pArr
end

tmpArr = [4,3,78,2,0,2]

tmpArr = bubble_sort(tmpArr)

print tmpArr

def bubble_sort_by(pArr)
    n = pArr.size
    swapped = true

    until !swapped do
    swapped = false
        for i in 1...n do
            # If the element to the left is bigger than the one on the right
            result = yield(pArr[i-1],pArr[i])
            if result > 0
                pArr[i-1],pArr[i] = pArr[i],pArr[i-1]
                swapped = true
            end
        end
    end
    return pArr
end

tmpArr = ["hi","hello","hey"]

tmpArr = bubble_sort_by(tmpArr) do |l,r|
    l.length - r.length
end

print tmpArr