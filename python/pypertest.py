import pandas as pd
import matplotlib as plt
import pyper as pr

r = pr.R(use_pandas=True)

iris = pd.read_csv('iris.csv')

r.assign('rdata', iris)

print r("summary(rdata)")