# Import necessary modules
import keras
from keras.layers import Dense
from keras.models import Sequential

# Specify the model
n_cols = predictors.shape[1]
model = Sequential()
model.add(Dense(50, activation='relu', input_shape = (n_cols,)))
model.add(Dense(32, activation='relu'))
model.add(Dense(1))

# Compile the model
model.compile(optimizer='adam', loss='mean_squared_error')

# Fit the model
____



## Loading titanic dataset...
titanic = pd.read_csv('./data/titanic_all_numeric.csv')
titanic.head()
titanic.columns
titanic.describe
titanic.info()

titanic[['age']].describe()



# Import necessary modules
import keras
from keras.layers import Dense
from keras.models import Sequential
from keras.utils import to_categorical

# Convert the target to categorical: target
target = ____

# Set up the model
model = ____

# Add the first layer
____

# Add the output layer
____

# Compile the model
____

# Fit the model
____



# Specify, compile, and fit the model
model = Sequential()
model.add(Dense(32, activation='relu', input_shape = (n_cols,)))
model.add(Dense(2, activation='softmax'))
model.compile(optimizer='sgd', 
              loss='categorical_crossentropy', 
              metrics=['accuracy'])
model.fit(predictors, target)

# Calculate predictions: predictions
predictions = ____

# Calculate predicted probability of survival: predicted_prob_true
predicted_prob_true = ____

# print predicted_prob_true
print(predicted_prob_true)
