
from sklearn import datasets
from sklearn import metrics
from sklearn.svm import SVC
import pyper as pr
import pandas as pd
from sklearn.preprocessing import StandardScaler

# load the KDDcup data; still classify churn as in Lect 33-35
r = pr.R()

r("load('Lect35.Rdata')")

#transfer data (TARGET AND FEATURES) from R to Python
r("dTrain$response <- dTrain$churn > 0")
r("head(dTrain$response)")
target = r.get("dTrain$response")
r("features <- dTrain[,selVars]")
r("names(features)")
features = r.get("features") #pass data to Python


def buildAndEvaluateSvm(p_kernel, p_scale):
    model = SVC(kernel=p_kernel)
    if p_scale:
        scaler = StandardScaler().fit(features)
        ft = scaler.transform(features)
    else:
        ft = features

    model.fit(ft, target)
    expected = target
    predicted = model.predict(ft)
    print("SCORE: %f" % metrics.roc_auc_score(expected,predicted))

print "RBF, Unscaled: "
buildAndEvaluateSvm('rbf', False)
print "RBF, Scaled: "
buildAndEvaluateSvm('rbf', True)
print "Linear, Unscaled: "
buildAndEvaluateSvm('linear', False)
print "Linear, Scaled: "
buildAndEvaluateSvm('linear', True)


