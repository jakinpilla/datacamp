# Tunning a CART's hyperparameters...

# hyperparameters: not learned from data, set prior to training...
## CART example: max_depth, min_samples_leaf, slitting criterion...

# What is hyperparameter tunning...
## Problem: search for a set of optimal hyperparameters for a learning algorithm.
## Solution: find a set of optimal hyperparameters that results in an optimal model...
## Optimal model: yields an optimal score...
## Score: in sklearn defaults to accuracy (classification) and R^2 (regression)


# Approach to hyperparnameter tunnung...
## Grid Search...
## Random Search...
## Bayesian Optimization..
## Genetic Algorithms...

# Grid search cross validation...
## Manually set a grid if discrete hyperprarmeter values.
## Set a metric for scoring mdoel performance...
## Search exhaustively through the gird...
## For each set of hyperparameters evaluate each model's CV scoe...
## The optimal hyperparameters are those of the model achieving the best CV score...

# Hyperparameters grids..
## max_depth = {2, 3, 4}
## min_sample_leaf = {.05, .1}
## hyperparameter space = {(2, .05), (2, .1), (3, .05)....}
## CV scores...
## optimal hyperparameters = set of hyperparameters corresponding to the best CV score....

# Inspecting the hyperparameters of a CART in sklearn...

# Import DecisionTreeClassifier...
from sklearn.tree import DecisionTreeClassifier

# Set seed to 1 for reproducibility...
SEED = 1

# Instantiate a DecisionTreeClassifier 'dt'
dt = DecisionTreeClassifier(random_state=SEED)

# Print  out 'dt's hyperparameters
print(dt.get_params())

# Import GridSearchCV
from sklearn.model_selection import GridSearchCV

# Define the grid of hyperparameters 'params_dt'
params_dt = {
  'max_depth': [3, 4, 5, 6],
  'min_samples_leaf': [.04, .06, .08],
  'max_features': [.2, .4, .6, .8]
}

# Instantiate a 10-fold CV grid search object 'grid_dt'
grid_dt= GridSearchCV(estimator=dt, param_grid = params_dt, scoring = 'accuracy', 
cv = 10, n_jobs=-1)

# Fitting the grid_dt...
grid_dt.fit(X_train, y_train)

# Extract best hyperparameters from 'grid_dt'
best_hyperparams = grid_dt.best_params_
print('Best hyperparameters:\n' , best_hyperparams)

# Extract best CV score from 'gird_dt'
best_CV_score = grid_dt.best-score_
print('Best CV accuracy:'.format(best_CV_score))

# Extract best model from 'grid_dt'
best_model = grid_dt.best_estimator_

# Evaluate tetst set accuracy...
test_acc = best_model.score(X_test, y_test)

# Print test set accuracy
print('Test set accuracy of best model; {:.3f}'.format(test_acc))


# Define params_dt
params_dt = {
  'max_depth': [2, 3, 4],
  'min_samples_leaf': [.12, .14, .16, .18]
}


# Import GridSearchCV
from sklearn.model_selection import GridSearchCV

# Instantiate grid_dt
grid_dt = GridSearchCV(estimator=dt,
                       param_grid=params_dt,
                       scoring='roc_auc',
                       cv=5,
                       n_jobs=-1)


# Suppose that we already have trained GridsearchCV object 'grid_dt'

# Import roc_auc_score from sklearn.metrics
from sklearn.metrics import roc_auc_score

# Extract the best estimator
best_model = grid_dt.best_estimator_

# Predict the test set probabilities of the positive class
y_pred_proba = best_model.predict_proba(X_test)[:, 1]

# Compute test_roc_auc
test_roc_auc = roc_auc_score(y_test, y_pred_proba)

# Print test_roc_auc
print('Test set ROC AUC score: {:.3f}'.format(test_roc_auc))


# Tuning a RF's hyperparameters...

# Import RandomForestRegressor 
from sklearn.ensemble import RandomForestRegressor

# Set seed for reproducibility
SEED = 1

# Instantiate a random forests regressor 'rf'
rf = RandomForestRegressor(random_state = SEED)

# Inspect rf's hyperparameters 
rf.get_params()

# Basic import 
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import GridSearchCV

# Define a grid of hyperparameter 'params_rf'
params_rf = {
  'n_estimators': [300, 400, 500],
  'max_depth': [4, 6, 8],
  'min_samples_leaf': [.1, .2],
  'max_features': ['log2', 'sqrt']
}


# Instantiate 'grid_dt'
grid_rf = GridSearchCV(estimator=rf, param_grid = params_rf, cv = 3, scoring='neg_mean_squared_error', 
verbose=1, n_jobs = -1)

# Extract best hyperparameters from 'grid_df'...
best_hyperparams = grid_rf.best_params_
print('Best hyperparameters:\n', best_hyperparams)

# Extract best model from 'grid_rf'
best_model = grid_rf.best_estimator_

# Predict the test set labels...
y_pred = best_model.predict(X_test)

# Evaluate the test set RMSE
rmse_test = MSE(y_test, y_pred)**(1/2)

# Print the test set RMSE
print('Test set RMSE of rf: {:.2f}'.format(rmse_test))



# Define the dictionary 'params_rf'
params_rf = {
  'n_estimators': [100, 350, 500],
  'max_features': ['log2', 'auto', 'sqrt'],
  'min_samples_leaf': [2, 10, 30]
}


# Import GridSearchCV
from sklearn.model_selection import GridSearchCV

# Instantiate grid_rf
grid_rf = GridSearchCV(estimator=rf,
                       param_grid=params_rf,
                       scoring='neg_mean_squared_error',
                       cv=3,
                       verbose=1,
                       n_jobs=-1)


# Import mean_squared_error from sklearn.metrics as MSE 
from sklearn.metrics import mean_squared_error as MSE

# Extract the best estimator
best_model = grid_rf.best_estimator_

# Predict test set labels
y_pred = best_model.predict(X_test)

# Compute rmse_test
rmse_test = MSE(y_test, y_pred)**(1/2)

# Print rmse_test
print('Test RMSE of best model: {:.3f}'.format(rmse_test)) 








