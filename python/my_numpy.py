import numpy as np

data1 = [ 
    [6,7,8,9,10],
    [11,12,13,14,15]
    ]
"""
myarr = np.array(data1)

print "Rows: " + str(myarr.shape[0])

print myarr
"""

"""
#any difference if we use matrix?

mymat = np.matrix(data1)

#print "Rows: " + str(mymat.shape[0])

print mymat.dtype

print mymat.transpose()
"""

data2 = np.arange(15)

myslice = data2[5:10]
myslice[0] = 8
print myslice
print data2