import csv
import matplotlib.pyplot as plt

c_val = []
j_val = []
a_val = []
p_val = []

# create output file
def clr_out() :
    f = open("output_stats.txt", "w")
    f.close()


# write to output file
def write_stats(lang, avg, max, min):
    f = open("output_stats.txt", "a")
    s = "Lang= "+lang+" avg= "+str(avg)+"s max= "+str(max)+"s min="+str(min)+"s\n"
    f.write(s)
    f.close()


# returns 50 lambdas for each language
def read(file):
    val = [0 for j in range(50)]
    with open(file) as csv_file:
        csv_reader = csv.reader(csv_file)
        i = j = 0
        for row in csv_reader:
            val[i] += float(row[0])
            j +=1
            if j == 500:
                i += 1
                j = 0
            if j==500 and i == 49:
            	print("All read")
    return val


def comp_stats (arr):
    avg = 0
    min = max = arr[0]
    for i in range(50):
        avg += arr[i]
        if min > arr[i]:
            min = arr[i]
        if max < arr[i]:
            max = arr[i]
    return avg/50, max, min

def main():
    clr_out()
    java = "java.csv"
    cpp = "cpp.csv"
    asm = "asm.csv"
    py = "py.csv"

    j_val = read(java)
    c_val = read(cpp)
    a_val = read(asm)
    p_val = read(py)

    avg, max, min = comp_stats(j_val)
    write_stats("Java", avg, max, min)

    avg, max, min = comp_stats(c_val)
    write_stats("C++", avg, max, min)

    avg, max, min = comp_stats(a_val)
    write_stats("ASM", avg, max, min)

    avg, max, min = comp_stats(p_val)
    write_stats("Python", avg, max, min)

main()

#x = np.arange(0,50,1)

#plt.ylabel("Execution time across ")
#plt.xlabel("No. of lambdas")
#plt.plot(x, c_val)
#plt.title("Execution time across 50 runs (seconds)")
#plt.show()


