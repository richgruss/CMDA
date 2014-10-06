
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


# In[ ]:



