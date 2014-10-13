import pandas as pd
import numpy as np
import pandas.io.data as web

all_data = {}

for ticker in ['AAPL', 'IBM', 'MSFT', 'GOOGL']:
    all_data[ticker] = web.get_data_yahoo(ticker, '1/1/2006', '1/1/2010')

#all_data is a dictionary from string('AAPL') to a DataFrame

price = pd.DataFrame({tic: data['Adj Close'] for tic,data in all_data.iteritems()})
#price is a new dataframe instantiated with a dictionary from ticker name to a list of closing prices in dataframe for ticker

"""
example_dict = {
    'APPL':[price1,price2,price3],
    'veg':['celery','tomato','cucumber'],
    'meat':['beef','pork','chicken']
}

"""


volume = pd.DataFrame({tic: data['Volume'] for tic,data in all_data.iteritems()})

returns = price.pct_change()

#print returns.MSFT.corr(returns.MSFT)

#covariance: unit * unit, so either units squared or product of two different unts
    #tells direction, but not magnitude

print returns.cov()

print returns.corr()

"""
df = pd.DataFrame(
    [[1,2],[3,4],[5,6],[7,8]],
    index=['a','b','c','d'],
    columns=['one','two']
)
#print df
#print df.sum(axis=1)
print df.describe()
"""