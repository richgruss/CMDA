
from sklearn import datasets
from sklearn import metrics
from sklearn.svm import SVC
import pyper as pr
import pandas as pd
from sklearn.preprocessing import StandardScaler

# load the KDDcup data; still classify churn as in Lect 33-35
r = pr.R()

r('data(mtcars)')
mtcars = r.get('mtcars')

print mtcars

features = []
target = []

def buildAndEvaluateSvm(p_kernel):
    model = SVC(kernel=p_kernel)

    model.fit(features, target)
    expected = target
    predicted = model.predict(features)
    print("SCORE: %f" % metrics.roc_auc_score(expected,predicted))



#buildAndEvaluateSvm('rbf') #radial basis function is Gaussian

