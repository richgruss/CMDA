
# coding: utf-8

# In[1]:

import pandas as pd
import matplotlib.pyplot as plt
import pyper as pr


# In[2]:

iris = pd.read_csv('iris.csv')


# In[3]:

iris.head()


# In[4]:

print iris.shape


# In[ ]:

iris.describe()


# In[5]:

iris['sepall'].value_counts()


# In[ ]:

iris['sepalw'].value_counts()


# In[ ]:

iris['petall'].value_counts()


# In[ ]:

iris['sepalw'].value_counts()


# In[3]:

r = pr.R(use_pandas=True)


# In[4]:

r.assign('rdata', iris)


# In[5]:

print r("head(rdata)")


# In[12]:

print r("names(rdata)")


# In[17]:

print r("?princomp")


# In[6]:

print r("princomp(rdata)")


# In[6]:

r("p <- princomp(rdata)")


# In[7]:

print r("names(p)")


# In[9]:

print r("head(p$scores)")


# In[8]:

pydata = pd.DataFrame(r.get('p$scores'),columns=['Comp.1', 'Comp.2', 'Comp.3','Comp.4','Comp.5'])


# In[9]:

print pydata.head()


# In[10]:

fig = plt.scatter(pydata['Comp.1'], pydata['Comp.2'])
plt.xlabel('Princ Component 1')
plt.ylabel('Princ Component 2')
plt.suptitle('Iris, First Two Principal Components')


# In[31]:

#print iris.loc[0:3, 'Species']
#print pydata.loc[:,0]
colors = ['blue', 'green', 'yellow']
for i in xrange(len(colors)):
    px = pydata.loc[:,'Comp.1'][iris['Species'] == i]
    py = pydata.loc[:, 'Comp.2'][iris['Species'] == i]
    plt.scatter(px, py, c=colors[i])


# In[ ]:

#Given that we can easily separate each of the species with a line, the first two components
#do an excellent job of differentiating the three species.

