
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

# Review the decision regions of the two classifiers
plot_labeled_decision_regions(X_test, y_test, clfs)
