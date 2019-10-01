# Generalization Error...

# f_hat = bias^2 + variance + irreducible error...

# If f_hat suffers from high variance : CV error of f_hat > training set error of f_hat...; overfitting....
## --  decrease model complexity
## --  decrease max depth, increase min samples per leaf...
## --  gather mroe data...

# Import train_test_split from sklearn.model_selection
____

# Set SEED for reproducibility
SEED = 1

# Split the data into 70% train and 30% test
X_train, X_test, y_train, y_test = ____(____, ____, test_size=____, random_state=SEED)

# Instantiate a DecisionTreeRegressor dt
dt = ____(____=____, ____=____, random_state=SEED)



# Compute the array containing the 10-folds CV MSEs
MSE_CV_scores = - ____(____, ____, ____, cv=____, 
                       ____='____',
                       n_jobs=-1)

# Compute the 10-folds CV RMSE
RMSE_CV = (____.____)**(____)

# Print RMSE_CV
print('CV RMSE: {:.2f}'.format(RMSE_CV))



# Import mean_squared_error from sklearn.metrics as MSE
____

# Fit dt to the training set
____.____(____, ____)

# Predict the labels of the training set
____ = ____.____(____)

# Evaluate the training set RMSE of dt
____ = (____(____, ____))**()

# Print RMSE_train
print('Train RMSE: {:.2f}'.format(RMSE_train))
