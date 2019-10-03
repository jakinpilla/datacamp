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


# Define params_dt
params_dt = ____


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



# Define the dictionary 'params_rf'
params_rf = ____



# Import GridSearchCV
____

# Instantiate grid_rf
grid_rf = ____(estimator=____,
                       param_grid=____,
                       scoring=____,
                       cv=____,
                       verbose=1,
                       n_jobs=-1)
