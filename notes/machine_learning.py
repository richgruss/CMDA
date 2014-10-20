import scipy as sp
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sklearn as sk
from sklearn import datasets
from sklearn.cross_validation import train_test_split
from sklearn import preprocessing

iris = datasets.load_iris()
X_iris, y_iris = iris.data, iris.target

#only the first two attributes
X,y = X_iris[:, :2], y_iris

X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=.25,random_state=33)

scaler = preprocessing.StandardScaler().fit(X_train)
X_train = scaler.transform(X_train)

X_test = scaler.transform(X_test)

"""
colors = ['red','greenyellow','blue']
for i in xrange(len(colors)):
    xs = X_train[:,0][y_train == i] #Sepal length --
        # first[] is slice, all rows, 0 column. second[] is bool selector
        # gets all the rows classified as iris type 0 (see iris.target_names
    ys = X_train[:,1][y_train == i] #Sepal width
    plt.scatter(xs,ys,c=colors[i])

plt.legend(iris.target_names)
plt.xlabel('Sepal length')
plt.ylabel('Sepal width')

plt.show()
"""
#stochastic gradient descent classifier
from sklearn.linear_model import SGDClassifier
clf = SGDClassifier()
clf.fit(X_train, y_train) #builds the classifier

from sklearn import metrics
y_test_pred = clf.predict(X_test)
print metrics.accuracy_score(y_test, y_test_pred)

#print iris.DESCR
#print iris.data.shape
#print iris.target.shape

print "done"