import pandas as pd
import numpy as np
import math

bike_data = pd.read_csv('/Users/rgruss/git/CMDA/final_project/bicycle_data.csv')

print bike_data.describe()
print bike_data['temp'].describe()

bins = [0,13,27,37,41]

bike_data['subj_temp'] = pd.cut(bike_data['temp'], bins, labels=['cold','warm','hot','very hot'])

# verify 'hot' and 'very hot' worked
print bike_data[ ['temp','subj_temp']][bike_data['temp'] > 35]

#print pd.value_counts(bike_data['subj_temp'])

temp_cond_map = {'cold': 'bad', 'warm': 'good', 'hot': 'good', 'very hot':'bad'}

bike_data['cycling_conditions'] = bike_data['subj_temp'].map(temp_cond_map)
#verify that cold and very hot are bad cycling conditions
print bike_data['subj_temp'][bike_data['cycling_conditions'] == 'bad']

bike_data.rename(columns={'temp': 'temp celsius'}, inplace=True)
bike_data.rename(columns={'season': 'season code'}, inplace=True)

def getRandomRowSet(data_frame, fraction):
    num_rows = data_frame.shape[0]
    perm = np.random.permutation(num_rows)

    pivot = math.floor(num_rows * fraction)

    train_idx = perm[:pivot]
    return data_frame.take(train_idx)

train_1 = getRandomRowSet(bike_data, .5)
print 'Size of random training set 1: %i ' % train_1.shape[0]

train_2 = getRandomRowSet(bike_data, .5)
print 'Size of random training set 1: %i ' % train_2.shape[0]


combined_df = pd.concat([train_1,train_2])
print 'Size of combined training set: %i ' % combined_df.shape[0]

trimmed_combined_df = combined_df.drop_duplicates()
print 'Percentage of original rows left: %f ' % ((100.0) * trimmed_combined_df.shape[0]/combined_df.shape[0])
