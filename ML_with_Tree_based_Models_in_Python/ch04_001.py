# AdaBoost

# Stands for Adaptive Boosting...
# Each predictor pays more attention to the instances wrongly predicted by its predecessor
# Achieved by changing the weights of training instances
# Each predictor is assigned a coefficient alpha
# alpha depends on the predictor's training errror....

# learing rate eta....
# 0 < eta <= 1

data = pd.read_csv('./data/wbc.csv')
data.head()

X = data.iloc[:, 2:]
y = data.iloc[:, 1]

di = {'M': 1, 'B': 0}
y = y.map(di)

X.head()
y.head()

X.shape
y.shape

# Import models and utility functions....
from sklearn.ensemble import AdaBoostClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import roc_auc_score 
from sklearn.model_selection import train_test_split

# set seed..
SEED = 1

# Split data into 70% train and 30% test....
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = .3, stratify = y, 
random_state = SEED)

# Instantiate a classifier-tree 'dt'
dt = DecisionTreeClassifier(max_depth=1, random_state=SEED)

# Instantiate an AdaBoost classifier 'adab_clf'
adb_clf = AdaBoostClassifier(base_estimator=dt, n_estimators = 100)

adb_clf.fit(X_train, y_train)

y_pred_proba = adb_clf.predict_proba(X_test)[:, 1]

# Evaludating
adb_clf_roc_auc_score = roc_auc_score(y_test, y_pred_proba)
 

## ---------

indian = pd.read_csv('./data/indian_liver_patient_preprocessed.csv', index_col = 0)
indian.head()

X = indian.iloc[:, 0:10]
y = indian.iloc[:, -1]


# Import DecisionTreeClassifier
from sklearn.tree import DecisionTreeClassifier

# Import AdaBoostClassifier
from sklearn.ensemble import AdaBoostClassifier

# Instantiate dt
dt = DecisionTreeClassifier(max_depth=2, random_state=1)

# Instantiate ada
ada = AdaBoostClassifier(base_estimator=dt, n_estimators=180, random_state=1)

# Fit ada to the training set
ada.fit(X_train, y_train)

# Compute the probabilities of obtaining the positive class
y_pred_proba = ada.predict_proba(X_test)[:, 1]


# Import roc_auc_score
from sklearn.metrics import roc_auc_score

# Evaluate test-set roc_auc_score
ada_roc_auc = roc_auc_score(y_test, y_pred_proba)

# Print roc_auc_score
print('ROC AUC score: {:.2f}'.format(ada_roc_auc))


# Gradient Boosted Trees

# Sequential correction of predecessor's errors.
# Does not tweak the weights of training instances..
# Fit each predictor is trained using its predecessor's residual errors as labels...
# Gradient Boosted TreesL a CART is used as a base learner...

# Shrinkage...: eta...
# teade-off eta and number of estimators...

## Loading auto dataset...
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

# Import models and utility functions....
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error as MSE

# Set seed for reproducibility
SEED = 1

# Split dataset into 70% train and 30% test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = .3, random_state = SEED)

# Instantiate  a GradientBoostingRegressor 'gbt'
gbt = GradientBoostingRegressor(n_estimators=300, max_depth=1, random_state=SEED)

# Fitting...
gbt.fit(X_train, y_train)

# Predict the test set lables...
y_pred = gbt.predict(X_test)

# Evaluate the test set RMSE...
rmse_test = MSE(y_test, y_pred)**(1/2)

# Print the test set RMSE
rmse_test


# Loading bikes dataset...
bike = pd.read_csv('./data/bikes.csv')

bike.columns
X = bike.drop('cnt', 1)
y = bike.loc[:, 'cnt']


# Import GradientBoostingRegressor
from sklearn.ensemble import GradientBoostingRegressor

# Instantiate gb
gb = GradientBoostingRegressor(max_depth=4, 
            n_estimators=200,
            random_state=2)


# Fit gb to the training set
gb.fit(X_train, y_train)

# Predict test set labels
y_pred = gb.predict(X_test)


# Import mean_squared_error as MSE
from sklearn.metrics import mean_squared_error as MSE

# Compute MSE
mse_test = MSE(y_test, y_pred)

# Compute RMSE
rmse_test = mse_test**(1/2)

# Print RMSE
print('Test set RMSE of gb: {:.3f}'.format(rmse_test))


# Stochastic Gradient Boosting(SGB)

# Gradient Boosting involves exhaustive search prodedure...
## Each CART is trained to finc the best split points and features...
## May lead to CARTs using the same split points and maybe the same features...

# Stochastic Gradient Boosting(SGB)
## Each tree is trained on a random subset of rows of the training data
## The sampled instances 40-80% of the training set are sampled without replacement
## Features are sampled (without replacement) when choosing split points..
## Result: furthue ensemble diversity
## Effect: adding further variance to the ensemble of trees..

# Loading auto dataset...
## Loading auto dataset...
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


# Import models and utility functions....
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error as MSE

# Set seed for reproducibility
SEED = 1

# Split dataset into 70% train and 30% test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = .3, random_state = SEED)

sgbt = GradientBoostingRegressor(max_depth = 1, subsample=.8, max_features=.2, 
n_estimators=300, random_state=SEED)

# Fitting...
sgbt.fit(X_train, y_train)

# Predict the test set labels...
y_pred = sgbt.predict(X_test)

# Evaluate test set RMSE 'rmse_test'
rmse_test = MSE(y_test, y_pred)**(1/2)

# Print 'rmse_test'
print('Test set RMSE: {:.2f}'.format(rmse_test))



# Import GradientBoostingRegressor
from sklearn.ensemble import GradientBoostingRegressor

# Instantiate sgbr
sgbr = GradientBoostingRegressor(max_depth=4, 
            subsample=.9,
            max_features=.75,
            n_estimators=200,                                
            random_state=2)


# Fit sgbr to the training set
sgbr.fit(X_train, y_train)

# Predict test set labels
y_pred = sgbr.predict(X_test)


# Import mean_squared_error as MSE
from sklearn.metrics import mean_squared_error as MSE

# Compute test set MSE
mse_test = MSE(y_test, y_pred)

# Compute test set RMSE
rmse_test = mse_test**(1/2)

# Print rmse_test
print('Test set RMSE of sgbr: {:.3f}'.format(rmse_test))
