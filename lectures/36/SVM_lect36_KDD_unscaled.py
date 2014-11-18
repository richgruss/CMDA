
# coding: utf-8

# In[1]:

from sklearn import datasets
from sklearn import metrics
from sklearn.svm import SVC
import pyper as pr
import pandas as pd


# In[2]:

# load the KDDcup data; still classify churn as in Lect 33-35


# In[3]:

r = pr.R(RCMD = 'C:\\Program Files\\R\\R-3.1.1\\bin\\R',use_pandas = True) #need to give the full path to R installation


# In[5]:

r("load('KDD2009.Rdata')")


# In[9]:

#transfer data from R to Python


# In[13]:

r("dTrain$response <- dTrain$churn > 0")


# In[15]:

r("head(dTrain$response)")


# In[ ]:

#Pass data from R to Python


# In[16]:

target = r.get("dTrain$response")


# In[17]:

target


# In[11]:

r("features <- dTrain[,selVars]")


# In[18]:

r("names(features)")


# In[19]:

features = r.get("features") #pass data to Python


# In[28]:

features.describe()


## #Train SVM model

# In[20]:

# fit a SVM model to the data
model = SVC()
model.fit(features, target)
print(model)


# In[29]:

get_ipython().magic(u'pinfo SVC')


# In[25]:

# make predictions
expected = target
predicted = model.predict(features)


# In[30]:

predicted


# In[32]:

expected


# In[ ]:

#probably need to normalize data (scale)


## #Validation (same train set)

# In[22]:

print(metrics.classification_report(expected, predicted))


# In[23]:

print(metrics.confusion_matrix(expected, predicted))


# In[33]:

print(metrics.roc_auc_score(expected,predicted))





