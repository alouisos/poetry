import sys, re, string
from helperFunctions import stripPunctuation, mean

f = open(sys.argv[1], "r")

wordDict = dict()

for l in f:
    l = l.strip()
    toks = l.split("| ")
    title_author = toks[0].replace(",", "")
    poemType = toks[1]
    words = " ".join(toks[2:]).lower()
    words = stripPunctuation(words)
    words = words.split()
    for word in words:
        if word not in wordDict:
            typeDict = dict()
            typeDict["Poet"] = 0
            typeDict["19th"] = 0
            typeDict["Amateur"] = 0
            typeDict[poemType] = 1
            wordDict[word] = typeDict
        else:
            typeDict = wordDict[word]
            typeDict[poemType] += 1
            wordDict[word] = typeDict

print "Word,contempPoet,19th,contempAmateur,total"

for word, info in wordDict.iteritems():
    toPrint = []
    toPrint.append(word)
    totalCount = sum(info.values())
    for poemType, count in info.iteritems():
        toPrint.append(str(count))
    toPrint.append(str(totalCount))
    print ",".join(toPrint)

 
