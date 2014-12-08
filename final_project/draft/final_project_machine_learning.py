import matplotlib.pyplot as plt
import numpy as np
from sklearn import linear_model
import pandas as pd
from sklearn.cross_validation import train_test_split
from sklearn.naive_bayes import MultinomialNB
from sklearn import preprocessing
from sklearn.cross_validation import cross_val_score, KFold
from scipy.stats import sem
import numpy as np

def categorize(bins, val):
    for idx,item in enumerate(bins):
        if idx == len(bins)-1: #we got to the end
            return idx
        elif val >= item and val < bins[idx+1]:
            return idx
    return -1 #not found.  shouldn't happen


def linearRegression(bike_data):
    bike_data_X = bike_data.ix[:, 0:7]
    bike_data_y = bike_data.ix[:, 8]

    X_train, X_test, y_train, y_test = train_test_split(bike_data_X, bike_data_y, test_size=0.8)

    # Create linear regression object
    regr = linear_model.LinearRegression(normalize=True)

    # Train the model using the training sets
    regr.fit(X_train, y_train)

    # The coefficients
    print('Coefficients: \n', regr.coef_)
    # The mean square error
    print("Residual sum of squares: %.2f"
          % np.mean((regr.predict(X_test) - y_test) ** 2))
    # Explained variance score: 1 is perfect prediction
    print('Variance score: %.2f' % regr.score(X_test, y_test))

    test_dataframe = pd.DataFrame()
    test_dataframe['actual_count'] = y_test
    test_dataframe['pred_count'] = regr.predict(X_test)

    test_dataframe = test_dataframe.sort(columns=['pred_count'])

    #print test_dataframe

    plt.scatter(test_dataframe['pred_count'], test_dataframe['actual_count'],  color='black')

    plt.xlabel('Predicted Hourly Rentals')
    plt.ylabel('Actual Hourly Rentals')

    plt.show()


def evaluate_cross_validation(clf,X,y,K):
   cv = KFold(len(y), K, shuffle=True, random_state=0)
   scores = cross_val_score(clf, X, y, cv=cv)
   print scores
   print ("Mean score: {0:.3f} (+/- {1:.3f})").format(np.mean(scores), sem(scores))

def naiveBayesClassify(bike_data):
     #scale numeric features
    min_max_scaler = preprocessing.MinMaxScaler()
    bike_data['atemp_scaled'] = min_max_scaler.fit_transform(bike_data['atemp'])
    bike_data['humidity_scaled'] = min_max_scaler.fit_transform(bike_data['humidity'])
    bike_data['windspeed_scaled'] = min_max_scaler.fit_transform(bike_data['windspeed'])

    #bin according to count
    bins = np.linspace(bike_data['count'].min(), bike_data['count'].max(), 5)
    #bins is an ndarray where value is min for that bin
    bike_data['category'] = bike_data.apply(lambda row: categorize(bins,row['count']), axis=1)


    bike_data=bike_data[['time_int','season', 'holiday', 'workingday', 'weather',
                         'atemp_scaled', 'humidity_scaled', 'windspeed_scaled', 'category']]


    #print bike_data[bike_data['count'] < 10]

    print bike_data

    bike_data_X = bike_data.ix[:, 0:7]
    bike_data_y = bike_data.ix[:, 8]

    X_train, X_test, y_train, y_test = train_test_split(bike_data_X, bike_data_y, test_size=0.8)

    clf = MultinomialNB()
    clf.fit(X_train, y_train)
    MultinomialNB(alpha=1.0, class_prior=None, fit_prior=True)

    test_dataframe = pd.DataFrame()
    test_dataframe['category'] = y_test
    test_dataframe['pred_category'] = clf.predict(X_test)

    print test_dataframe


    evaluate_cross_validation(clf, X_train, y_train, 5)
    evaluate_cross_validation(clf, X_test, y_test, 5)


def main():
    #read bicycle data into pandas dataframe:  see https://www.kaggle.com/c/bike-sharing-demand
    bike_data = pd.read_csv('bicycle_data.csv',
                            parse_dates=[0], infer_datetime_format=True)

    #we want to use time of day as a feature, independent of date, so split out time and drop datetime
    temp = pd.DatetimeIndex(bike_data['datetime'])
    bike_data['date'] = temp.date
    bike_data['time'] = temp.time

    bike_data['time_int'] = bike_data.apply(lambda row: int(row['time'].hour), axis=1)

    #reorder columns to have date and time at the top again
    bike_data=bike_data[['time_int','season', 'holiday', 'workingday', 'weather',
                         'atemp', 'humidity', 'windspeed', 'count']]


    #print bike_data

    #print bike_data.describe()

    naiveBayesClassify(bike_data)

    #linearRegression(bike_data)


if __name__=='__main__':
    main()