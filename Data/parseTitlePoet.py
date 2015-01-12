import sys, re, string

f = open(sys.argv[1], "r")
firstline = 0
for l in f:
    if firstline == 0:
        firstline = 1
    else:
        l = l.strip()
        toks = l.split(",")
        title_poet = toks[0].split(" by ")
        poetType = toks[1]
        year = toks[2]
        imagist = toks[3]
        if poetType != "Amateur":
            print title_poet[0] + "," + title_poet[1] + "," + poetType + "," + year + "," + imagist
        else:
            print title_poet[0] + "," + "anonymous" + "," + poetType + "," + "n/a" + "," + imagist

    
