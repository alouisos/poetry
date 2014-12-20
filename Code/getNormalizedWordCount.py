import sys, re, string
from helperFunctions import mean, stripPunctuation

wordF = open(sys.argv[1], "r")

wordList = []
for l in wordF:
    l = l.strip()
    wordList.append(l)

f = open(sys.argv[2], "r")

for l in f:
    count = 0
    l = l.strip()
    toks = l.split("| ")
    title_author = toks[0].replace(",", "")
    poemType = toks[1]
    words = " ".join(toks[2:]).lower()
    words = stripPunctuation(words)
    words = words.split()
    for word in words:
        if word in wordList:
            count +=1
    normalizedCount = float(count) / float(len(words))
    print title_author + "," + poemType + "," + str(normalizedCount)

