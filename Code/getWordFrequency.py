import sys, re, string, math
from helperFunctions import mean, stripPunctuation

freqFile = open("../Materials/500k_wordlist_coca_orig.csv", "r")
freqDict = dict()

firstline = 0
for l in freqFile:
    if firstline == 0:
        firstline = 1
    else:
        l = l.strip()
        toks = l.split(",")
        word = toks[1].lower()
        freq = toks[0]
        #freqDict[word] = math.log(float(freq), 2)
        freqDict[word] = float(freq)

f = open(sys.argv[1], "r")

for l in f:
    l = l.strip()
    toks = l.split("| ")
    title_author = toks[0].replace(",", "")
    poemType = toks[1]
    words = " ".join(toks[2:]).lower()
    words = stripPunctuation(words)
    words = words.split()
    #print words
    freqs = []
    for word in words:
        if word in freqDict:
            freq = freqDict[word]
        else:
            freq = 0
        freqs.append(freq)
    meanFreq = mean(freqs)
    print title_author + "," + poemType + "," + str(meanFreq)

