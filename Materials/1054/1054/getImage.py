import sys, re, string

f = open(sys.argv[1], "r")

ratingDict = dict()

for l in f:
    l = l.strip()
    toks = l.split()
    word = toks[len(toks)-1].split("|")[0]
    info = toks[0]
    rating = int(info[31:34])
    if rating is not 0:
        ratingDict[word] = rating

for k in sorted(ratingDict.keys()):
    print k + "\t" + str(ratingDict[k])

