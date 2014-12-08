import pandas as pd
import numpy as np
import math
import matplotlib.pyplot as plt
import random

#read bicycle data into pandas dataframe:  see https://www.kaggle.com/c/bike-sharing-demand
bike_data = pd.read_csv('bicycle_data.csv',
                        parse_dates=[0], infer_datetime_format=True)
#print bike_data.shape

#print bike_data.describe()

# Splits the data for day and time to have columns for day and time

temp = pd.DatetimeIndex(bike_data['datetime'])

bike_data['date'] = temp.date
bike_data['time'] = temp.time

del bike_data['datetime']

#reorder columns to have date and time at the top again
bike_data=bike_data[['date', 'time','season', 'holiday', 'workingday', 'weather', 
                     'temp', 'atemp', 'humidity', 'windspeed', 'casual', 'registered', 'count']]

print "=============SPLIT ==============="
print bike_data

# Making a day data frame from hours 
# 	Add bike counts/casual/registered together to get total bikes
# 	Add a daily mean of bike counts field
# 	Average temp/humid/wind speed/weather to get daily amounts (also store standard deviation)
# 	(keep season/holiday/working day the same )

bike_data_daily = pd.read_csv('bicycle_data.csv',
                        parse_dates=[0], infer_datetime_format=True)

bike_data_daily.index=pd.to_datetime(bike_data_daily.datetime,unit='H')

bike_data_daily = bike_data_daily.resample('D',how={'casual': [np.sum,np.mean], 'registered': [np.sum,np.mean],
                                                'count': [np.sum,np.mean], 'season': np.mean,
                                                'holiday': np.mean, 'workingday': np.mean,
                                                'weather': [np.mean, np.std], 'temp': [np.mean, np.std],
                                                'atemp': [np.mean, np.std],
                                                'humidity': [np.mean, np.std], 'windspeed': [np.mean, np.std], })

print "======DAILY======"
print bike_data_daily

# This seems to resample based on what we need but puts in missing values
# -- NAN -- for the days we don't have data for

# We can fix that by dropping NA's

bike_data_daily.resample('D').dropna()

# This also adds standard deviation for columns about the weather and
# adds a column for the mean of bike counts per hour for each day

# We can use the latter to add the proper hourly rate for each missing data
# and that'll be our robust hourly. Right now, the count will be off for the
#  days with missing hours since those are 0's).

# We might want to resample that data frame to daily buckets for ease too

############# the following is from HW4 #############

counts = bike_data['count']
print counts.describe()
counts.hist(bins=20);plt.title('Number of bike rentals');plt.xlabel('Num Rentals');plt.ylabel('Num instances/10800')

#By far the most common number of bikes rented on any given hour is between 1 and 50.

#rentals by hour on a given day
one_day_counts = bike_data.loc[:24,['date','count']]
one_day_counts.plot(kind='bar', title='Hourly bikes rented on Jan. 1, 2011')


#This gives us the general pattern of bike rentals on a NON-WORKDAY.  There is a bump just after midnight,
#possibly as people are going home after drinking, and then again in the early afternoon.

#rentals by hour on a given day
one_day_counts2 = bike_data.loc[1852:1876,['date','count']]
one_day_counts2.plot(kind='bar', title='Hourly bikes rented on May 4, 2011')

#This gives us the general pattern of bike rentals on a WORKDAY.  There is a small bump in the early
#commuting hours, and then a large bump in the early evening commuting hours.

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

bike_data.to_pickle('bike_data.pkl')
