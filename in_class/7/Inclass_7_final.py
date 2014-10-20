######## Inclass 7 - 1 ################

# In[34]:

import pandas as pd
import numpy as np
import math
import matplotlib.pyplot as plt
import random

#read bicycle data into pandas dataframe:  see https://www.kaggle.com/c/bike-sharing-demand
bike_data = pd.read_csv('/Users/rgruss/git/CMDA/final_project/bicycle_data.csv')
print bike_data.shape


# In[66]:

# 1. a histogram;
#count: total bikes rented in any given hour
print bike_data['count'].describe()
counts = bike_data['count']
counts.hist(bins=10);plt.title('Number of bike rentals');plt.xlabel('Num Rentals');plt.ylabel('Num instances/10800')
plt.savefig('histogram.png')


# In[67]:

# 2. a density plot
counts.plot(kind='kde', title='Density of bikes rented hourly')
plt.savefig('density.png')


# In[68]:

# 3. a bar chart
#rentals by hour on a given day
one_day_counts = bike_data.loc[:24,['datetime','count']]
one_day_counts.plot(kind='bar', title='Hourly bikes rented on Jan. 1, 2011')
plt.savefig('barchart.png')


# In[69]:

# 4. a horizontal stacked bar chart with categories summing to 1
# bicycles can be rented as either 'casual' or 'registered'.  Stack those categories to get percentage of total for that hour
one_day_counts_kinds = bike_data.loc[:24,['datetime','casual', 'registered']]
one_day_counts_kinds['casual_norm'] = one_day_counts_kinds['casual'].div(one_day_counts_kinds['casual'] + one_day_counts_kinds['registered'])
one_day_counts_kinds['registered_norm'] = one_day_counts_kinds['registered'].div(one_day_counts_kinds['casual'] + one_day_counts_kinds['registered'])

one_day_counts_norm = one_day_counts_kinds.loc[:, ['datetime','casual_norm', 'registered_norm']]

one_day_counts_norm.plot(kind='barh', stacked=True, title='Type of hourly rentals, Jan. 1, 2011')
plt.savefig('stacked_horizontal_normalized_bar.png')


# In[70]:

# 5. a scatterplot.
#visualize the correlation between temperature and number of bike rentals
#10,000 rows is too hard to visualize. Take a random subset of 100 rows
import random

sample_idx = random.sample(bike_data.index, 100)
sample = bike_data.ix[sample_idx]

fig = plt.scatter(sample['temp'], sample['count'])
plt.xlabel('Temperature(Celsius)')
plt.ylabel('Hourly bike rentals')
plt.suptitle('Bike Rentals by Temperature')
plt.savefig('scatterplot.png')


############### Inclass 7 - 2 #####################

# coding: utf-8

# In[25]:

import pandas as pd
import numpy as np
from sklearn.cross_validation import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import SGDClassifier

medical_data = pd.read_csv('Medical.csv')


# In[8]:

medical_data_subset =  medical_data.loc[:,['Age','HgA1C']]
print medical_data_subset


# In[19]:

y = np.array(medical_data['A Literacy Category'])


# In[20]:

X = np.array(medical_data.as_matrix(columns=['Age','HgA1C']))


# In[36]:

X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=.25,random_state=33)


# In[37]:

scaler = StandardScaler().fit(X_train)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)


# In[49]:

print y_test


# In[24]:


# In[38]:

clf = SGDClassifier()
clf.fit(X_train, y_train)


# In[50]:

print clf.coef_


# In[51]:

print clf.intercept_


# In[52]:

#Classifer equation: -27.64585708 + 5.08968882 x1 + -16.81823155 x2


# In[53]:

from sklearn import metrics
y_pred = clf.predict(X_train)
print metrics.accuracy_score(y_train, y_pred)


# In[54]:

# 89% accuracy on the training data


# In[55]:

y_pred = clf.predict(X_test)
print metrics.accuracy_score(y_test, y_pred)


# In[35]:

# 100% accuracy on the test data


# In[45]:

print metrics.confusion_matrix(y_test,y_pred)


# In[57]:

print y_train
#This classifer has too easy of a job to do.  Every one of the y_test values was 'HIGH' and ALMOST all of the
#training values were 'HIGH'.  If it simply said 'HIGH' every time it would be right



####################### Inclass 7 - 3 ###############################

# coding: utf-8

# In[1]:

get_ipython().magic(u'pylab inline')


# In[2]:

import sklearn as sk
import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt


## Principal Components Analysis

#### Dimensionality Reduction and Visualization

####### #Get the digits data

# In[3]:

from sklearn.datasets import load_digits
digits = load_digits()


####### #What does the digits dataset contain?

# In[4]:

print digits.keys()


####### #Each row of data in X_digits corresponds to one of the following digits:

# In[5]:

digits.target_names


# In[6]:

X_digits, y_digits = digits.data, digits.target


####### #What does the X matrix look like?

# In[7]:

X_digits.shape


####### #Get the first 10 principal components of the X_digits matrix

# In[8]:

from sklearn.decomposition import PCA

estimator = PCA(n_components=10)
X_pca = estimator.fit_transform(X_digits)


####### #What does the PCA matrix looks like

# In[9]:

X_pca.shape


# In[10]:

X_pca


####### #Visualize our data using the first two principal components in a scatterplot

# In[11]:

colors = ['black', 'blue', 'purple', 'yellow', 'white', 'red', 'lime', 'cyan', 'orange', 'gray']
for i in xrange(len(colors)):
    px = X_pca[:, 0][y_digits == i]
    py = X_pca[:, 1][y_digits == i]
    plt.scatter(px, py, c=colors[i])
plt.legend(digits.target_names)
plt.xlabel('First Principal Component')
plt.ylabel('Second Principal Component')


# 0's are easily distinguished from 1's.  4's are easily distinguised from 3's.  Lots of overlap
# between 7's and 8's, for some reason.

# In[12]:

for i in xrange(len(colors)):
    px = X_pca[:, 8][y_digits == i]
    py = X_pca[:, 9][y_digits == i]
    plt.scatter(px, py, c=colors[i])
plt.legend(digits.target_names)
plt.xlabel('Ninth Principal Component')
plt.ylabel('Tenth Principal Component')


# This is a mess. The 9th and 10th components don't distinguish well at all.
# There is some differentiation between 8's and 9's, but that's about it.











