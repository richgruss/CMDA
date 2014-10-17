import pandas as pd
import numpy as np


#sampler = np.random.permutation(31)
#print sampler


#pandas provides dataframe (like R)

series1 = pd.Series([100,200,300])
series2 = pd.Series([400,500,600])

seriesall = series1 + series2

dict1 = {'Fruits':2, 'Veggies':10}

series4 = pd.Series(dict1)

dict_meal = {
    'fruits':['apple','pear','banana'],
    'veg':['celery','tomato','cucumber'],
    'meat':['beef','pork','chicken']
}

dataframe1 = pd.DataFrame(dict_meal)

#print dataframe1

#select one row
#print dataframe1.ix[0]

#print dataframe1['meat']

dataframe1['stuff'] = [1,2,3]

#transpose to make it more useable
dataframe1 = dataframe1.T

#print dataframe1.ix[0]

#df2 = dataframe1.drop('stuff')

#print df2

#numpy:  x is axis 0, y is axis 1

#print dataframe1[:1]
#dataframe1[1] = 'N'

#print dataframe1

#print dataframe1[[0,1,2]] #list of column indexes to show

#print dataframe1
#print dataframe1.ix[['fruits', 'veg'], [1,2]] #### These rows, these column indexes

#print dataframe1.describe()


#df.mean()

#here's a way to get around nltk.FreqDist
cat_ser = pd.Series(['a','b','c','a','a','b'])

#freq = pd.value_counts(cat_ser.values, ascending = False, sort = True)
#print freq

#dropna
#fillna(0)
#fillna(series.mean())

#hierarchical indexing
#data.unstack() turns multi-level indexing into table
#R has "reshape" package the does the same thing

# 2 indices unstacks to table
# 3 indices unstacks to cube


#print np.arange(5,10,.5) half-open interval


print np.random.permutation(20)



