######  5 - 1 ###################

# In[1]:

import pandas,numpy,matplotlib


# In[10]:

get_ipython().magic('psearch pandas.*')


# In[11]:

get_ipython().magic('psearch numpy.*')


# In[12]:

get_ipython().magic('psearch matplotlib.*')


# In[14]:

ten_things = "Apples Oranges Crows Telephone Light Sugar"

stuff = ten_things.split(' ')

more_stuff = ["Day", "Night", "Song", "Frisbee", "Corn", "Banana", "Girl", "Boy"]

while len(stuff) != 10:
    next_one = more_stuff.pop()
    print "Adding: ", next_one
    stuff.append(next_one)
    print "There are %d items now." % len(stuff)

print "The 'stuff' list: ", stuff


# In[15]:

get_ipython().magic('ls')


# In[19]:

get_ipython().magic('quickref')


# In[20]:

get_ipython().magic('ls')


# In[21]:

get_ipython().magic('pwd')


# In[22]:

get_ipython().magic('hist')


# In[23]:

get_ipython().magic('pinfo %xdel')


# In[24]:

get_ipython().magic('pinfo %str.split')


# In[28]:

import re


# In[29]:

get_ipython().magic('pinfo re')


# In[30]:

import matplotlib.pylab


# In[31]:

get_ipython().magic('pinfo matplotlib.pylab')


# In[32]:

get_ipython().magic('matplotlib inline')
a = numpy.random.randn(100)
plot(a.cumsum())


# In[33]:

get_ipython().magic('pinfo cumsum')


# In[34]:

get_ipython().magic('timeit numpy.random.randn(100)')


# In[36]:

get_ipython().magic('timeit numpy.random.randn(1000)')


# In[37]:

get_ipython().magic('timeit numpy.random.randn(10000)')


############### 5 - 2 ##################################


# coding: utf-8

# In[1]:

import numpy as np


# In[2]:

data1Arr = np.array([6, 7.5, 8, 0 , 1])


# In[3]:

data1Arr.shape


# In[4]:

data1Arr.dtype


# In[5]:

data2Arr = np.array([1,2,3,4,5])


# In[6]:

data1Arr + data2Arr


# In[7]:

data1Arr * data2Arr


# In[8]:

a6x6I = np.eye(6)


# In[9]:

a6x6I


# In[10]:

a6x6I[2] = 5


# In[11]:

a6x6I


# In[12]:

a6x6I[a6x6I!=0] = 6


# In[13]:

a6x6I


# In[14]:

arr3 = np.empty([2,3,4])


# In[15]:

arr3


# In[16]:

arr3.ndim


# In[17]:

arr3.shape


# In[18]:

arr3.dtype


# In[22]:

arr3[1:2:2] = 5


# In[23]:

arr3


# In[27]:

randArr = np.random.random_sample(20,)


# In[31]:

randArr.min()


# In[ ]:

randArr.max()


# In[32]:

randArr.mean()


# In[33]:

randArr.sum()


# In[35]:

randArr.std()


# In[38]:

randArr


# In[45]:

randArr = np.where(randArr > .5, 1, randArr)


# In[46]:

randArr.sort()
randArr


# In[48]:

np.unique(randArr)


# In[ ]:



################  5 - 3 ###############################
# coding: utf-8

# In[1]:

import pandas


# In[2]:

import Quandl


# In[3]:

bitstamp = Quandl.get("BCHARTS/BITSTAMPUSD", trim_start="2014-01-01", trim_end="2014-09-30", authtoken="dFQ4ow8iGQFfSrSDaWfL")


# In[4]:

bitfinex = Quandl.get("BCHARTS/BITFINEXUSD", trim_start="2014-01-01", trim_end="2014-09-30", authtoken="dFQ4ow8iGQFfSrSDaWfL")


# In[5]:

lakebtc = Quandl.get("BCHARTS/LAKEUSD", trim_start="2014-01-01", trim_end="2014-09-30", authtoken="dFQ4ow8iGQFfSrSDaWfL")


# In[6]:

bitstamp.head()


# In[7]:

bitfinex.head()


# In[8]:

lakebtc.head()


# In[11]:

bitstamp.columns


# In[10]:

#each row is a day of trading


# In[13]:

ind1 = bitstamp.index


# In[14]:

ind2 = bitfinex.index


# In[15]:

ind3 = lakebtc.index


# In[18]:

ind1


# In[19]:

#273 DatetimeIndex  elements in bitstamp.index


# In[20]:

ind2


# In[ ]:

#273 DateTimeIndex elementsi in bitfinex


# In[22]:

ind3


# In[23]:

#214 DateTimeIndex elements for lake


# In[24]:

ind1.values


# In[25]:

ind2.values


# In[26]:

ind3.values


# In[27]:

#these are all datetime64 


# In[28]:

bitstamp.columns


# In[29]:

bitfinex.columns


# In[30]:

lakebtc.columns


# In[31]:

#All data frames have 7 columns


# In[33]:

bitstamp.drop('Volume (BTC)', 1)


# In[34]:

bitfinex.drop('Volume (BTC)', 1)


# In[35]:

lakebtc.drop('Volume (BTC)', 1)





