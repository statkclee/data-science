import re

readings = []

for filename in ('../data/evil/notebook-1.txt', '../data/evil/notebook-2.txt'):
    lines = open(filename, 'r').read().strip().split('\n')
    readings += lines[1:7]
    
for r in readings:
    print r
    
for r in readings:
    if '06' in r:
        print '......\n'
        print r

for r in readings:
    if re.search('06', r):
        print '.........\n'
        print r

def show_matches(pattern, strings):
    for s in strings:
        if re.search(pattern, s):
            print '**', s
        else:
            print '  ', s

show_matches('06|7', readings)            


match = re.search('(2009|2010|2011)',
                   'Baker 1\t2011-11-17\t 1223.0')

print 'first:', match.group(1)

match = re.search('(....)-(..)-(..)',
                   'Baker 1\t2009-11-17\t1223.0')
print '\n ----------------'
print match.group(1), match.group(2), match.group(3)
print match.group(0)

def show_groups(pattern, text):
    m = re.search(pattern, text)
    if m is None:
        print 'NO MATCH'
        return
    for i in range(1, 1 + len(m.groups())):
        print '%2d: %s' % (i, m.group(i))

show_groups('(.+)/(.+)/(.+)', '//')
show_groups('(.+)/(.+) (.+), (.+)/(.+)',
            'Davison/May 22, 2010/1721.3')

m = re.search('(wo.+d)', "How much wood, would a woodchuck chuck?")
print m.group(1)
        


