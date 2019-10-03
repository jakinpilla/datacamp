# Generalization Error...

# f_hat = bias^2 + variance + irreducible error...

# If f_hat suffers from high variance : CV error of f_hat > training set error of f_hat...; overfitting....
## --  decrease model complexity
## --  decrease max depth, increase min samples per leaf...
## --  gather mroe data...

from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error as MSE
from sklearn.model_selection import cross_val_score
import numpy as np
import pandas as pd

# set seed 
SEED = 123

# loading data..
auto = pd.read_csv('./data/auto.csv')
auto.head()
auto.origin.unique()

dummies = pd.get_dummies(auto['origin']).rename(columns=lambda x: 'origin_' + str(x))

df = pd.concat([auto, dummies], axis=1)
df.head()
df = df.drop(['origin'], axis=1)
df.head()

X = df.iloc[:, 1:]
y = df.iloc[:, 0]

# Spliting data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = .3, random_state = SEED)

# Instantiate decision tree regressor and assign it to 'dt'
dt = DecisionTreeRegressor(max_depth = 4, min_samples_leaf = .14, random_state = SEED)

# Evaluating the list of MSE trained by 10-fold CV
# Set n_jobs to -1 in order to exploit all CPU  cores on computation...
MSE_CV = - cross_val_score(dt, X_train, y_train, cv = 10, scoring = 'neg_mean_squared_error', n_jobs = -1)

# fitting...
dt.fit(X_train, y_train)

# Predict the labels of training set...
y_predict_train = dt.predict(X_train)

# Predict the labels of test set...
y_predict_test = dt.predict(X_test)

# CV MSE
print('CV MSE: {:.2f}'.format(MSE_CV.mean()))

# Training set MSE...
print('Train MSE: {:.2f}'.format(MSE(y_train, y_predict_train)))

# Test set MSE
print('Test MSE: {:.2f}'.format(MSE(y_test, y_predict_test)))


# Import train_test_split from sklearn.model_selection
from sklearn.model_selection import train_test_split

# Set SEED for reproducibility
SEED = 1

# Split the data into 70% train and 30% test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=.3, random_state=SEED)

# Instantiate a DecisionTreeRegressor dt
dt = DecisionTreeRegressor(max_depth=4, min_samples_leaf=.26, random_state=SEED)


# Compute the array containing the 10-folds CV MSEs
MSE_CV_scores = - cross_val_score(dt, X_train, y_train, cv=10, 
                       scoring='neg_mean_squared_error',
                       n_jobs=-1)

# Compute the 10-folds CV RMSE
RMSE_CV = (MSE_CV_scores.mean())**(1/2)

# Print RMSE_CV
print('CV RMSE: {:.2f}'.format(RMSE_CV))


# Import mean_squared_error from sklearn.metrics as MSE
from sklearn.metrics import mean_squared_error as MSE

# Fit dt to the training set
dt.fit(X_train, y_train)

# Predict the labels of the training set
y_pred_train = dt.predict(X_train)

# Evaluate the training set RMSE of dt
RMSE_train = (MSE(y_pred_train, y_train))**(1/2)

# Print RMSE_train
print('Train RMSE: {:.2f}'.format(RMSE_train))


## Ensemble sLearning....

# Advantages of CARTs...
## Flexiblity: ablility to describe non-linear dependencies..
## Preprocessing: no need to standardized or normalize features...

# Limitation of CARTs...
## Sensitive to small variations in the training set...
## High variance : unconstrained CARTs may overfit the training set...
## solution : ensemble learning...

data = pd.read_csv('./data/wbc.csv')
data.head()

X = data.iloc[:, 2:]
y = data.iloc[:, 1]

X.head()
y.head()

X.shape
y.shape

# Import functions to compute accuracy and split data
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split

# Import models, including VotingClassifier meta-model
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier as KNN
from sklearn.ensemble import VotingClassifier

# Set seed
SEED = 1

# Spliting...
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = .3, random_state = SEED)

# Instantiate 
lr = LogisticRegression(random_state=SEED)
knn = KNN()
dt = DecisionTreeClassifier(random_state = SEED)

# Define a list called classifier that contains the tuples (classifier_name, classifier)
classifiers = [('Logistic Regression', lr), ('K Nearest Neighbours', knn), ('Classification Tree', dt)]

# Iterate over the defined list of tuples containing the classifiers
for clf_name, clf in classifiers:
  # fit clf to the training set
  clf.fit(X_train, y_train)
  
  # Predict the labels fi the test set
  y_pred = clf.predict(X_test)
  
  # Evaluate the accuracy  of clf on the test set
  print('{:s} : {:.3f}'.format(clf_name, accuracy_score(y_test, y_pred)))
  

# Instantiate....
vc = VotingClassifier(estimators=classifiers)

# Fit 'vc' to the training set and predict test as labels...
vc.fit(X_train, y_train)

y_pred = vc.predict(X_test)

# Evaluate the test-set accuracy of 'vc'
print('Voting Classifier: {:.2f}'.format(accuracy_score(y_test, y_pred)))


## loading dataset...
pd.read_csv('./data/indian_liver_patient_preprocessed.csv', index_col = 0).head()
pd.read_csv('./data/indian_liver_patient_preprocessed.csv', index_col = 0).shape
pd.read_csv('./data/indian_liver_patient_preprocessed.csv', index_col = 0).columns

indian = pd.read_csv('./data/indian_liver_patient_preprocessed.csv', index_col = 0)

indian.head()

X = indian.iloc[:, 0:10]
y = indian.iloc[:, -1]

# Set seed for reproducibility
SEED=1

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = .3, random_state = SEED)

# Instantiate lr
lr = LogisticRegression(random_state=SEED)

# Instantiate knn
knn = KNN(n_neighbors=27)

# Instantiate dt
dt = DecisionTreeClassifier(min_samples_leaf=.13, random_state=SEED)

# Define the list classifiers
classifiers = [('Logistic Regression', lr), ('K Nearest Neighbours', knn), ('Classification Tree', dt)]

# Iterate over the pre-defined list of classifiers
for clf_name, clf in classifiers:    
    # Fit clf to the training set
    clf.fit(X_train, y_train)   
    # Predict y_pred
    y_pred = clf.predict(X_test)
    # Calculate accuracy
    accuracy = accuracy_score(y_test, y_pred) 
    # Evaluate clf's accuracy on the test set
    print('{:s} : {:.3f}'.format(clf_name, accuracy))


# Import VotingClassifier from sklearn.ensemble
from sklearn.ensemble import VotingClassifier

# Instantiate a VotingClassifier vc
vc = VotingClassifier(estimators=classifiers)     

# Fit vc to the training set
vc.fit(X_train, y_train)   

# Evaluate the test set predictions
y_pred = vc.predict(X_test)

# Calculate accuracy score
accuracy = accuracy_score(y_test, y_pred)
print('Voting Classifier: {:.3f}'.format(accuracy))






