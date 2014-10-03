#Inclass4 Part 3

"""What does the code below do? Run the code in iPython.
For each line of code, add an explanation
through a comment."""

#PART I

#Use the code from Lecture14.py to create and change the 
#'stuff' list; Then comment on each line of the code below
#what it does, and what the result is

ten_things = "Apples Oranges Crows Telephone Light Sugar"
stuff = ten_things.split(' ')

print stuff[1] #prints the second element, Orange
print stuff[-1] # prints the last element, Sugar
print stuff.pop() #removes the last element of the list and prints its value, Sugar
print ' '.join(stuff) #creates a string by joining the elements of stuff, separating each with a white space, Apples Oranges Crows Telephone Light
print '#'.join(stuff[3:5])  #extracts index 3-5 and joins elements separated by # Telephone#Light


#PART II

#Create comments where marked with # to explain the code below

#creates a states dictionary with give elements (pairs of LongName->Abbrev)
states = {
    'Oregon': 'OR',
    'Florida': 'FL',
    'California': 'CA',
    'New York': 'NY',
    'Michigan': 'MI'
}



#creates a cities dictionary with elements (pairs of Abbrev->LongName)
cities = {
    'CA': 'San Francisco',
    'MI': 'Detroit',
    'FL': 'Jacksonville'
}


cities['NY'] = 'New York' #sets element in cities with key 'NY' to value 'New York'
cities['OR'] = 'Portland' #sets elements in cities with key 'OR' to value 'Portland'


print '-' * 10 #prints 10 hyphens
print "NY State has: ", cities['NY'] #prints "NY State has:" and value in cities with key'NY,',  New York
print "OR State has: ", cities['OR']#prints "OR State has:" and value in cities with key'OR,',  Portland

# 
print '-' * 10 #prints 10 hyphens
print "Michigan's abbreviation is: ", states['Michigan'] #prints the string + value of element in states with index 'Michigan', MI
print "Florida's abbreviation is: ", states['Florida']#prints the string + value of element in states with index 'Florida', FL

# 
print '-' * 10 #prints 10 hyphens
print "Michigan has: ", cities[states['Michigan']]#prints string + value of element in cities with index (value of element in states with Michigan = 
#'MI', so Detroit)
print "Florida has: ", cities[states['Florida']]#prints string + value of element in cities with index (value of element in states with Florida = 
#'FL', so Jacksonville)

# 
print '-' * 10 #prints 10 hyphens
for state, abbrev in states.items(): #separates states dict into key (state) and value (abbrev) and loops
    print "%s is abbreviated %s" % (state, abbrev) #prints "<state> is abbreviated by <abbreviation>"

# 
print '-' * 10 #prints 10 hyphens
for abbrev, city in cities.items():  #separates cities dict into key (abbrev) and value (city) and loops
    print "%s has the city %s" % (abbrev, city) #prints "<abbrev> has the city <city>" 

# 
print '-' * 10 #prints 10 hyphens
for state, abbrev in states.items(): #separates states dict into key (state) and value (abbrev) and loops
    print "%s state is abbreviated %s and has city %s" % ( #prints <state> is abbreviated <abbrev> and has city <value of of element in cities with key <abbrev>"
        state, abbrev, cities[abbrev])



