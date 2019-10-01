# Import DecisionTreeClassifier
from sklearn.tree import DecisionTreeClassifier

# Import train_test_split
from sklearn.model_selection import train_test_split

# Import accuracy_score
from sklearn.metrics import accuracy_score

X = iris.iloc[:, 0:4]
y = iris.iloc[:, 4]

# Split dataset into 80% train, 20% test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=.2, 
stratify = y, random_state = 1)

# Instantiate DT
dt = DecisionTreeClassifier(max_depth=2, random_state = 1)

# fitting...
dt.fit(X_train, y_train)

# predicting...
y_pred = dt.predict(X_test)

# Evaluate test_set accuracy
accuracy_score(y_test, y_pred)

##-----

data = pd.read_csv('./data/wbc.csv')[['radius_mean', 'concave points_mean', 'diagnosis']]
X = data.iloc[:, 0:2]
y = data.iloc[:, 2]

X.head()
y.head()

X.shape
y.shape



# Import DecisionTreeClassifier from sklearn.tree
from sklearn.tree import DecisionTreeClassifier

# Instantiate a DecisionTreeClassifier 'dt' with a maximum depth of 6
dt = DecisionTreeClassifier(max_depth=6, random_state=1)

# Fit dt to the training set
dt.fit(X_train, y_train)

# Predict test set labels
y_pred = dt.predict(X_test)
print(y_pred[0:5])


# Import accuracy_score
from sklearn.metrics import accuracy_score

# Predict test set labels
y_pred = dt.predict(X_test)

# Compute test set accuracy  
acc = accuracy_score(y_test, y_pred)
print("Test set accuracy: {:.2f}".format(acc))


## ----
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
