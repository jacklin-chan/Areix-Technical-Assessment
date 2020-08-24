def maxWater(input, n):
	# store the maximum water that can be stored
	res = 0

	for i in range(1, n - 1): 
		# get the maximum element on its left
		left = input[i]
		for j in range(i):
			left = max(left, input[j])

		# get the maximum element on its right
		right = input[i]

		for j in range(i + 1 , n): 
			right = max(right, input[j])
		# update the maximum water
		res = res + (min(left, right) - input[i])

	return res

# Drive code
if __name__ == "__main__" :
    # test case
	arr = [0,1,0,2,1,0,1,3,2,1,2,1]
	n = len(arr)
	print(maxWater(arr, n))
