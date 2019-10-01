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

# set seed 
SEED = 123

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
____.____(____, ____)

# Predict the labels of the training set
____ = ____.____(____)

# Evaluate the training set RMSE of dt
____ = (____(____, ____))**()

# Print RMSE_train
print('Train RMSE: {:.2f}'.format(RMSE_train))


















