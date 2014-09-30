#Lecture 13
#Intro to Python I


#Whitespace

a = 1
#    b = 2 #what happens here?

#Objects

#The "a" object above is an integer object.
#We can use it in all sorts of arithmetic operations.
b = a + 1
#Now we are telling Pythong to output the b value
print b

#Comments
'''
How about
this
?
'''
#Functions
print type(a) #print the type of object a; function "type"
#takes one argument

#transform integer a into a string and assigns that value
#to another variable s
c = str(a)

#Printing
print "String c has value", c
#Print quotes
print "Here 'c' is a string with value", c, "."
#Print using variables and formats for variables.
print "The string %s." % c
print "The integer %d." % a
print "The string %s and the integer %d." % (c, a)

#Lists
hairs = ['brown', 'blond', 'red']
#Can print it
print hairs
#Can print each element
print hairs[0]
#Can modify elements
hairs[0] = 'dark brown'
print hairs
#Can have lists of integers
weights = [1, 2, 3, 4]
print weights[3] #this is the last element in the list of 4 elements
#can mix types of elements
mix = [1,2,'one','two']
print mix[1]
print mix[3]