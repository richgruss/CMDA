######################### 6_1 #####################################
# coding: utf-8

# In[1]:
import pandas as pd

# In[2]:

#read tab-delimited text file into pandas dataframe
work_tab = pd.read_table('work_tab.txt')


# In[4]:
print work_tab

# In[6]:
#read csv into pandas data frame
work_comma = pd.read_csv('work_comma.csv')


# In[7]:
print work_comma


# In[8]:
#read text file, skipping first 19 rows
stress = pd.read_table('stress2_1.txt', skiprows = 19)


# In[9]:
print stress


# In[10]:
import json


# In[11]:
import requests


# In[12]:
#get from github api
r = requests.get('https://api.github.com/')

# In[13]:
r_json =  r.json()
#create a pandas dataframe from json using the following fields
fields = ['emails_url','emojis_url','events_url','feeds_url']
dataFrame = pd.DataFrame(r_json, fields)
print dataFrame

# In[14]:
dataFrame.to_pickle('github_dataframe')


# In[15]:
newFrame = pd.read_pickle('github_dataframe')


# In[16]:

import pandas.io.pytables
frameStore = pd.HDFStore('github_frame.h5')
frameStore['emails_url']


######################### 6_2 #####################################

import pandas as pd
import numpy as np
import math

#read bicycle data into pandas dataframe:  see https://www.kaggle.com/c/bike-sharing-demand
bike_data = pd.read_csv('/Users/rgruss/git/CMDA/final_project/bicycle_data.csv')

print bike_data.describe()
print bike_data['temp'].describe()

#categories the temperature into cold, warm, hot and very hot days based on temp celsius
bins = [0,13,27,37,41]
bike_data['subj_temp'] = pd.cut(bike_data['temp'], bins, labels=['cold','warm','hot','very hot'])

# verify 'hot' and 'very hot' worked
print bike_data[ ['temp','subj_temp']][bike_data['temp'] > 35]

print pd.value_counts(bike_data['subj_temp'])

temp_cond_map = {'cold': 'bad', 'warm': 'good', 'hot': 'good', 'very hot':'bad'}

bike_data['cycling_conditions'] = bike_data['subj_temp'].map(temp_cond_map)
#verify that cold and very hot are bad cycling conditions
print bike_data['subj_temp'][bike_data['cycling_conditions'] == 'bad']

#rename two columns
bike_data.rename(columns={'temp': 'temp celsius'}, inplace=True)
bike_data.rename(columns={'season': 'season code'}, inplace=True)

#function to split the rows of a given dataframe into a given framction
def getRandomRowSet(data_frame, fraction):
    num_rows = data_frame.shape[0]
    perm = np.random.permutation(num_rows)

    pivot = math.floor(num_rows * fraction)

    train_idx = perm[:pivot]
    return data_frame.take(train_idx)

#split off a random 50% from the observations
train_1 = getRandomRowSet(bike_data, .5)
print 'Size of random training set 1: %i ' % train_1.shape[0]

#split off another random 50%
train_2 = getRandomRowSet(bike_data, .5)
print 'Size of random training set 1: %i ' % train_2.shape[0]

#combine the two row sets
combined_df = pd.concat([train_1,train_2])
print 'Size of combined training set: %i ' % combined_df.shape[0]

#remove duplicate rows
#statistically, a fourth of them will be duplicates
trimmed_combined_df = combined_df.drop_duplicates()
print 'Percentage of original rows left: %f ' % ((100.0) * trimmed_combined_df.shape[0]/combined_df.shape[0])




