import sys, re, string
from helperFunctions import mean, stripPunctuation

ratingsFile = open("../Materials/Warriner_et_al emot ratings_zscored.csv", "r")
valenceDict = dict()
arousalDict = dict()

firstline = 0
for l in ratingsFile:
    if firstline == 0:
        firstline = 1
    else:
        l = l.strip()
        l = l.replace('"', "")
        toks = l.split(",")
        word = toks[1]
        valence = toks[2]
        arousal = toks[5]
        valenceDict[word] = float(valence)
        arousalDict[word] = float(arousal)

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
    valenceRatings = []
    arousalRatings = []
    for word in words:
        if word in valenceDict:
            valenceRating = valenceDict[word]
            arousalRating = arousalDict[word]
            valenceRatings.append(valenceRating)
            arousalRatings.append(arousalRating)
    meanValenceRating = mean(valenceRatings)
    meanArousalRating = mean(arousalRatings)
    print title_author + "," + poemType + "," + str(meanValenceRating) + "," + str(meanArousalRating)

