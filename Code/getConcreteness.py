import sys, re, string

from helperFunctions import mean, stripPunctuation

ratingsFile = open("../Materials/Concreteness_ratings_Brysbaert_et_al_BRM_zscored.csv", "r")
concretenessDict = dict()

firstline = 0
for l in ratingsFile:
    if firstline == 0:
        firstline = 1
    else:
        l = l.strip()
        l = l.replace('"', "")
        toks = l.split(",")
        word = toks[0]
        concreteness = toks[2]
        concretenessDict[word] = float(concreteness)
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
        if word in concretenessDict:
            rating = concretenessDict[word]
            ratings.append(rating)
    meanRating = mean(ratings)
    print title_author + "," + poemType + "," + str(meanRating)

