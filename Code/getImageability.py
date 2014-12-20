import sys, re, string

from helperFunctions import mean, stripPunctuation

ratingsFile = open("../Materials/imageability_mrc2_zscored.txt", "r")
imageDict = dict()

firstline = 0
for l in ratingsFile:
    if firstline == 0:
        firstline = 1
    else:
        l = l.strip()
        l = l.replace('"', "")
        toks = l.split("\t")
        word = toks[0].lower()
        imageness = toks[1]
        imageDict[word] = float(imageness)

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
    ratings = []
    for word in words:
        if word in imageDict:
            rating = imageDict[word]
            ratings.append(rating)
    meanRating = mean(ratings)
    print title_author + "," + poemType + "," + str(meanRating)

