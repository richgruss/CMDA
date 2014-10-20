
# coding: utf-8

# In[2]:

import pandas as pd
import numpy as np
import math
import matplotlib.pyplot as plt
import random

#read bicycle data into pandas dataframe:  see https://www.kaggle.com/c/bike-sharing-demand
bike_data = pd.read_csv('/Users/rgruss/git/CMDA/final_project/bicycle_data.csv')
print bike_data.shape


# In[4]:

print bike_data.describe()


# In[6]:

# We don't have any missing data.  This is possibly because rows were already removed.
# For example, Jan. 4 is missing from 1:00pm to 4:00pm rows entirely.

counts = bike_data['count']
print counts.describe()
counts.hist(bins=20);plt.title('Number of bike rentals');plt.xlabel('Num Rentals');plt.ylabel('Num instances/10800')

#By far the most common number of bikes rented on any given hour is between 1 and 50.

# In[68]:

#rentals by hour on a given day
one_day_counts = bike_data.loc[:24,['datetime','count']]
one_day_counts.plot(kind='bar', title='Hourly bikes rented on Jan. 1, 2011')


#This gives us the general pattern of bike rentals on a NON-WORKDAY.  There is a bump just after midnight,
#possibly as people are going home after drinking, and then again in the early afternoon.


# In[8]:

#rentals by hour on a given day
one_day_counts2 = bike_data.loc[1852:1876,['datetime','count']]
one_day_counts2.plot(kind='bar', title='Hourly bikes rented on May 4, 2011')


#This gives us the general pattern of bike rentals on a WORKDAY.  There is a small bump in the early
#commuting hours, and then a large bump in the early evening commuting hours.


# In[9]:

# This is a test to see if temperature affects bike rental.
#visualize the correlation between temperature and number of bike rentals
#10,000 rows is too hard to visualize. Take a random subset of 100 rows
import random

sample_idx = random.sample(bike_data.index, 100)
sample = bike_data.ix[sample_idx]

fig = plt.scatter(sample['temp'], sample['count'])
plt.xlabel('Temperature(Celsius)')
plt.ylabel('Hourly bike rentals')
plt.suptitle('Bike Rentals by Temperature')


# In[11]:

bike_data.to_pickle('bike_data.pkl')






