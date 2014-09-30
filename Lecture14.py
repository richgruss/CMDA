#Lecture 14
#Intro to Python III


#Working with Lists

ten_things = "Apples Oranges Crows Telephone Light Sugar"


#print "Wait there are not 10 things in that list. Let's fix that."

stuff = ten_things.split(' ')

more_stuff = ["Day", "Night", "Song", "Frisbee", "Corn", "Banana", "Girl", "Boy"]

while len(stuff) != 10:
    next_one = more_stuff.pop()
    print "Adding: ", next_one
    stuff.append(next_one)
    print "There are %d items now." % len(stuff)

print "The 'stuff' list: ", stuff


#Working with Dictionaries

d1 = {'a': 'first element', 'b': [1, 2, 3, 4]} #can contain lists



#Access an element by key
print d1['a']



#Add an element (a pair key: value) to the dict
d1[7] = 'an integer'
print d1

#Check if the dict contains a certain key
print "b" in d1.keys()

'''
#Delete a value

del d1[7] #this is weird
print d1

#Use functions defined for dictionaries
print "Keys", d1.keys()
print "Values", d1.values()
'''