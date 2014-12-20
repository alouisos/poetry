import re

def stripPunctuation(string):
    string = re.sub('[()|,.?!;:"]', ' ', string)
    string = string.replace("-", " ")
    string = string.replace(" '", ' ')
    string = string.replace("' ", ' ')
    string = string.replace("'|", '"|')
    string = string.replace("'s", " 's")
    string = string.replace("'d", " 'd")
    string = string.replace("'nt", " 'nt")
    string = string.replace("'ll", " 'll")
    string = string.replace("'ve", " 've")
    return string

def mean(numbers):
    total = 0.0
    for number in numbers:
        total += float(number)
    return float(total)/len(numbers)

