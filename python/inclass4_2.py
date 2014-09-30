#Inclass4 Part 2

"""What does the code below do? Run the code in iPython.
For each line of code, add an explanation
through a comment."""

#PART I

print "I will now count my chickens:"
#prints the string


print "Hens", 25 + 30 / 6
#prints concatenation of string Hens with sum of 25 and 5


print "Roosters", 100 - 25 * 3 % 4
#prings cat of string and value (97)

print "Now I will count the eggs:"

print 3 + 2 + 1 - 5 + 4 % 2 - 1 / 4 + 6
#prints 7

print "Is it true that 3 + 2 < 5 - 7?"
#prints str

print 3 + 2 < 5 - 7
#False

print "What is 3 + 2?", 3 + 2
#concat string and sum(5)

print "What is 5 - 7?", 5 - 7
#concat string and diff (-2)

print "Oh, that's why it's False."
print "How about some more."
#prints strings

print "Is it greater?", 5 > -2
print "Is it greater or equal?", 5 >= -2
print "Is it less or equal?", 5 <= -2
#These are all booleans, so we're concatenating string and bools (True, True, False)

#PART II

days = "Mon Tue Wed Thu Fri Sat Sun"
#string with spaces
months = "Jan\nFeb\nMar\nApr\nMay\nJun\nJul\nAug"
#months:  string with newlines


print "Here are the days: ", days
#prints days straight

print "Here are the months: ", months
#prints like this because of the newlines
"""
Here are the months:  Jan
Feb
Mar
Apr
May
Jun
Jul
Aug
"""


#PART III

the_count = [1, 2, 3, 4, 5]
#int list

fruits = ['apples', 'oranges', 'pears', 'apricots']
#string list

change = [1, 'pennies', 2, 'dimes', 3, 'quarters']
#mixed list


# 
for number in the_count:
    print "This is count %d" % number

#list is numbers, and the %d is a string template for decimal values

"""
This is count 1
This is count 2
This is count 3
This is count 4
This is count 5

"""
    

# 
for fruit in fruits:
    print "A fruit of type: %s" % fruit
    
#fruit is a list of strings, and %s is a string template for string values    
    
"""
A fruit of type: apples
A fruit of type: oranges
A fruit of type: pears
A fruit of type: apricots

"""

# 
# Use %r format when you don't know
#if the elements are strings or integers
for i in change:
    print "I got %r" % i
    
#list is mixed, so the general purpose %r string tempalte is used.    

"""
I got 1
I got 'pennies'
I got 2
I got 'dimes'
I got 3
I got 'quarters'


"""

# we can also build lists, first start with an empty one
elements = []
#instantiates an empty list

# then use the range function to do 0 to 5 counts
for i in range(0, 6):
    print "Adding %d to the list." % i
    # append is a function that lists understand
    elements.append(i)

#loops through 0,1,2,3,4,5 and prints below.  Then, in the loops in aappends the number to elements list

"""
Adding 0 to the list.
Adding 1 to the list.
Adding 2 to the list.
Adding 3 to the list.
Adding 4 to the list.
Adding 5 to the list.

"""

# 
for i in elements:
    print "Element was: %d" % i
 
#loops through the elements list and prints values as decimal/integer value    
          
"""
Element was: 0
Element was: 1
Element was: 2
Element was: 3
Element was: 4
Element was: 5
"""
