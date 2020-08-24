def carpenter(input):
    print("Input: satisfaction = {}".format(input))
    max = 0     # desired output, 0 is baseline
    input.sort(reverse=True)    # sort from highest to lowest
    # print(input)
    length = len(input)

    for i in range(1, length + 1):
        tmp = i # aka time[i]
        cur_max = 0

        # accumulate the sums of time[i] * satisfaction[i]
        while(tmp > 0):
            cur_max = cur_max + tmp * input[i - tmp]
            tmp = tmp - 1

        # break the for loop
        # condition: the current attained max value is lower than overall max
        if(cur_max < max):
            break

        # update the overall max
        max = cur_max

    print("Output: {}".format(max))
    print('===========================')
    return

# Drive code
if __name__ == '__main__':
    # test cases
    case_1 = [-1, -8, 0, 5, -9]
    case_2 = [4, 3, 2]
    case_3 = [-1, -4, -5]
    case_4 = [-2, 5, -1, 0, 3, -3]

    carpenter(case_1)
    carpenter(case_2)
    carpenter(case_3)
    carpenter(case_4)
