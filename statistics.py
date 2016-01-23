class Comparator:
    def __init__(self, label):
        self.label = label
    def __str__(self):
        return self.label + ' : ' + "%.2f" % self.ratio + ' %\n'
    def ratio(self, a, b):
        if (a != 0):
            self.ratio = ((b-a)/a) * 100
            return self.ratio
        else:
            return self.ratio

class ResultsGetter:
    def __init__(self, path):
        self.path = path
    def getResults(self):
        f = open(self.path, 'r')
        map = []
        for line in f.readlines():
            map.append(line.split(' '))
        f.close()
        return map

# Read in classification results
resultsGetter = ResultsGetter('LE7/stat.txt')
mapLE7 = resultsGetter.getResults()

resultsGetter = ResultsGetter('LC8/stat.txt')
mapLC8 = resultsGetter.getResults()


# Write in final statistics
f = open('statistics.txt', 'w+')

while mapLE7 != []:
    found = False
    i = 0
    while not found and i < len(mapLC8):
        if mapLE7[0][0] == mapLC8[i][0]:
            comparator = Comparator(mapLE7[0][0])
            comparator.ratio(float(mapLE7[0][1]),float(mapLC8[i][1]))
            f.read()
            f.write(str(comparator))
            mapLC8.remove(mapLC8[i])
            found = True
        i+=1
        
    # Label not existing in second Map
    if not found :
        comparator = Comparator(mapLE7[0][0])
        comparator.ratio(float(mapLE7[0][1]),0)
        f.read()
        f.write(str(comparator))
        #f.write(mapLE7[0][0] + ' : 0 %\n')
    
    # Already analysed
    mapLE7.remove(mapLE7[0])
    
# Possibility of new labels
while mapLC8 != []:
    f.read()
    new = mapLC8[0][0] + ' : new\n'
    f.write(new)
    mapLC8.remove(mapLC8[0][0])
    
# Closing file
f.close()
