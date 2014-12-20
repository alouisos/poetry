import sys, re, string

from helperFunctions import mean, stripPunctuation

f = open(sys.argv[1], "r")

for l in f:
    typeDict = dict()
    l = l.strip()
    toks = l.split("| ")
    title_author = toks[0].replace(",", "")
    poemType = toks[1]
    words = " ".join(toks[2:]).lower()
    words = stripPunctuation(words)
    words = words.split()
    for word in words:
        typeDict[word] = 1
    ratio = float(len(typeDict.keys())) / float(len(words))
    print title_author + "," + poemType + "," + str(ratio)

