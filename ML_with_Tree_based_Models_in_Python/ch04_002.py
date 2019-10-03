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
____

# Evaluate test-set roc_auc_score
____ = ____(____, ____)

# Print roc_auc_score
print('ROC AUC score: {:.2f}'.format(ada_roc_auc))





# Import GradientBoostingRegressor
____

# Instantiate gb
gb = ____(____=____, 
            ____=____,
            random_state=2)
            
            


## ----

# Import GradientBoostingRegressor
from sklearn.ensemble import GradientBoostingRegressor

# Instantiate sgbr
sgbr = ____(max_depth=____, 
            subsample=____,
            max_features=____,
            n_estimators=____,                                
            random_state=2)
            
            
# Fit sgbr to the training set
____

# Predict test set labels
y_pred = ____



# Import mean_squared_error as MSE
____

# Compute test set MSE
mse_test = ____

# Compute test set RMSE
rmse_test = ____

# Print rmse_test
print('Test set RMSE of sgbr: {:.3f}'.format(rmse_test))
