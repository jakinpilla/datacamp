
# Import DecisionTreeClassifier from sklearn.tree
from sklearn.tree import ______

# Instantiate a DecisionTreeClassifier 'dt' with a maximum depth of 6
dt = DecisionTreeClassifier(______=6, random_state=1)

# Fit dt to the training set
dt.fit(______, ______)

# Predict test set labels
y_pred = ______.______(______)
print(y_pred[0:5])


# Import accuracy_score
from sklearn.metrics import ______

# Predict test set labels
y_pred = dt.predict(______)

# Compute test set accuracy  
acc = accuracy_score(y_test, y_pred)
print("Test set accuracy: {:.2f}".format(acc))

# Import LogisticRegression from sklearn.linear_model
from ____.____ import  ____

# Instatiate logreg
____ = ____(random_state=1)

# Fit logreg to the training set
____.____(____, ____)

# Define a list called clfs containing the two classifiers logreg and dt
clfs = [logreg, dt]


## -----


# Review the decision regions of the two classifiers
plot_labeled_decision_regions(X_test, y_test, clfs)


# Import DecisionTreeClassifier from sklearn.tree
from ____.____ import ____

# Instantiate dt_entropy, set 'entropy' as the information criterion
dt_entropy = ____(____=____, ____='____', random_state=1)

# Fit dt_entropy to the training set
____.____(____, ____)


# Import accuracy_score from sklearn.metrics
from ____.____ import ____

# Use dt_entropy to predict test set labels
____= ____.____(____)

# Evaluate accuracy_entropy
accuracy_entropy = ____(____, ____)

# Print accuracy_entropy
print('Accuracy achieved by using entropy: ', accuracy_entropy)

# Print accuracy_gini
print('Accuracy achieved by using the gini index: ', accuracy_gini)


# Import DecisionTreeRegressor from sklearn.tree
from sklearn.tree import DecisionTreeRegressor

# Instantiate dt
dt = DecisionTreeRegressor(max_depth=8, min_samples_leaf=.13, random_state=3)

# Fit dt to the training set
dt.fit(X_train, y_train)



# Import mean_squared_error from sklearn.metrics as MSE
from ____.____ import ____ as ____

# Compute y_pred
____ = ____.____(____)

# Compute mse_dt
____ = ____(____, ____)

# Compute rmse_dt
____ = ____

# Print rmse_dt
print("Test set RMSE of dt: {:.2f}".format(rmse_dt))


# Predict test set labels 
____ = ____.____(____)

# Compute mse_lr
____ = ____(____, ____)

# Compute rmse_lr
____ = ____

# Print rmse_lr
print('Linear Regression test set RMSE: {:.2f}'.format(rmse_lr))

# Print rmse_dt
print('Regression Tree test set RMSE: {:.2f}'.format(rmse_dt))
