# Voting Classifier...
## same training set...
## != algoritms

# Bagging...
## one algorithm
## != subsets of training set...

# Bagging : Bootstrap Aggregation...
## Reduce variance of individual models in the ensemble...

# Bagging : Classification & Regression

# Classification...
## Aggregates predictions by majority voting...
## BaggingClassifier in scikit-learn

# Regression...
## Aggregates predictions through averaging...
## BaggingRegressor in scikit-learn

from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error as MSE
from sklearn.model_selection import cross_val_score
import numpy as np
import pandas as pd

indian = pd.read_csv('./data/indian_liver_patient_preprocessed.csv', index_col = 0)

indian.head()

X = indian.iloc[:, 0:10]
y = indian.iloc[:, -1]

# Import models and utility functions...
from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split

# Set seed for reproducibility
SEED = 1

# Split data into  70% train and 30% test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size =.3, stratify = y, random_state = SEED)

# Instantiate a classification-tree 'dt'
dt = DecisionTreeClassifier(max_depth = 4, min_samples_leaf=.16, random_state = SEED)

# Instantiate a BaggingClassifier 'bc'
bc = BaggingClassifier(base_estimator=dt, n_estimators=300, n_jobs = -1)

# Fit 'bc' to the training set
bc.fit(X_train, y_train) # time consuming..

# Predict test set labels
y_pred = bc.predict(X_test)

# Evaluate and print test_set accuracy...
accuracy = accuracy_score(y_test, y_pred)

print('Accuracy of Bagging Classsifier: {:.3f}'.foramt(accuracy))




# Import DecisionTreeClassifier
from sklearn.tree import DecisionTreeClassifier

# Import BaggingClassifier
from sklearn.ensemble import BaggingClassifier

# Instantiate dt
dt = DecisionTreeClassifier(random_state=1)

# Instantiate bc
bc = BaggingClassifier(base_estimator=dt, n_estimators=50, random_state=1)



# Fit bc to the training set
bc.fit(X_train, y_train)

# Predict test set labels
y_pred = bc.predict(X_test)

# Evaluate acc_test
acc_test = accuracy_score(y_test, y_pred)
print('Test set accuracy of bc: {:.2f}'.format(acc_test)) 

# OOB Evaluation...

## 
pd.read_csv('./data/wbc.csv').head()
data = pd.read_csv('./data/wbc.csv')
X = data.iloc[:, 2:]
y = data.iloc[:, 1]

# Import models and utility functions...
from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split

# Set seed for reproducibility
SEED = 1

# Split data into  70% train and 30% test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size =.3, stratify = y, random_state = SEED)

dt = DecisionTreeClassifier(max_depth = 4, min_samples_leaf= .16, random_state = SEED)

# Instantiate a BaggingClassifier 'bc' : set oob_score  = True
bc = BaggingClassifier(base_estimator=dt, n_estimators = 300, oob_score = True, n_jobs= -1)


bc.fit(X_train, y_train)

y_pred =bc.pred(X_test)


test_accuracy = accuracy_score(y_test, y_pred)

oob_accuracy = bc.oob_score_


# Print test set accuracy...
print('Test set accuracy: {:.3f}'.format(test_accuracy))

# Print OOB accuracy...
print('OOB accuracy: {:.3f}'.format(oob_accuracy))





# Import DecisionTreeClassifier
from sklearn.tree import DecisionTreeClassifier

# Import BaggingClassifier
____

# Instantiate dt
dt = ____(min_samples_leaf=____, random_state=1)

# Instantiate bc
bc = ____(base_estimator=____, 
            n_estimators=____,
            oob_score=____,
            random_state=1)





# Fit bc to the training set 
____.____(____, ____)

# Predict test set labels
y_pred = ____.____(____)

# Evaluate test set accuracy
acc_test = ____(____, ____)

# Evaluate OOB accuracy
acc_oob = ____.____

# Print acc_test and acc_oob
print('Test set accuracy: {:.3f}, OOB accuracy: {:.3f}'.format(acc_test, acc_oob))



# Import mean_squared_error as MSE
from ____.____ import ____ as ____

# Predict the test set labels
y_pred = ____.____(____)

# Evaluate the test set RMSE
rmse_test = ____

# Print rmse_test
print('Test set RMSE of rf: {:.2f}'.format(rmse_test))

import matplotlib.pyplot as plt

# Create a pd.Series of features importances
importances = pd.Series(data=rf.feature_importances_,
                        index= X_train.columns)

# Sort importances
importances_sorted = ____

# Draw a horizontal barplot of importances_sorted
____.____(____='____', ____='____')
plt.title('Features Importances')
plt.show()





















