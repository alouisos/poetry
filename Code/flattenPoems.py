# turn each poem into a single line with
# poem title, poem type, and content as each field seperated by \t

import sys, re, string

f = open(sys.argv[1], "r")

index = 0
for l in f:
    l = l.strip()
    if l == "******":
        l = "\n"
    else:
        l = l + "|"
    print l,

