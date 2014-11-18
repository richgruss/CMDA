
# coding: utf-8

# In[22]:

from sklearn import datasets
from sklearn import metrics
from sklearn.svm import SVC #support vector classification
from IPython import get_ipython


# In[23]:

# load the iris datasets
dataset = datasets.load_iris()


## #Train SVM model

# In[24]:

# fit a SVM model to the data
model = SVC()
model.fit(dataset.data, dataset.target)
print(model)


# In[10]:

get_ipython().magic(u'pinfo SVC')


# In[25]:

# make predictions
expected = dataset.target
predicted = model.predict(dataset.data)


# In[13]:

expected


# In[26]:

predicted #on same train set


## #Validation (same train set)

# In[27]:

print(metrics.classification_report(expected, predicted))


# In[28]:

print(metrics.confusion_matrix(expected, predicted))

