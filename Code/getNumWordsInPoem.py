import sys, re, string, math

from helperFunctions import mean, stripPunctuation

f = open(sys.argv[1], "r")

for l in f:
    count = 0
    l = l.strip()
    toks = l.split("| ")
    title_author = toks[0].replace(",", "")
    poemType = toks[1]
    words = " ".join(toks[2:]).lower()
    words = stripPunctuation(words)
    words = words.split()
    print title_author + "," + poemType + "," + str(len(words))

