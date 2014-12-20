import sys, re, string, math

from helperFunctions import mean, stripPunctuation

ratingFile = open("../Materials/imageability_mrc2.txt", "r")
ratingDict = dict()

firstline = 0
for l in ratingFile:
    if firstline == 0:
        firstline = 1
    else:
        l = l.strip()
        toks = l.split("\t")
        word = toks[0].lower()
        rating = toks[1]
        ratingDict[word] = float(rating)

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
    #print words
    freqs = []
    for word in words:
        if word not in ratingDict:
            count += 1
    propOOV = float(count) / float(len(words))
    print title_author + "," + poemType + "," + str(count) + "," + str(len(words)) + "," +  str(propOOV)

