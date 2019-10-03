# creating a keras model...

# Specify Architure
# Compile 
# Fit
# Predict


import numpy as np
import pandas as pd
from keras.layers import Dense
from keras.models import Sequential

df = pd.read_csv('./data/hourly_wages.csv')
df.head()
df.describe()

predictors = df.iloc[:, 1:].values
target = df.iloc[:, 0].values

# Import necessary modules
import keras
from keras.layers import Dense
from keras.models import Sequential

# Save the number of columns in predictors: n_cols
n_cols = predictors.shape[1]

# Set up the model: model
model = Sequential()

# Add the first layer
model.add(Dense(50, activation='relu', input_shape=(n_cols,)))

# Add the second layer
model.add(Dense(32, activation='relu'))

# Add the output layer
model.add(Dense(1))

model.compile(optimizer = 'adam', loss = 'mean_squared_error')

# Verify that model contains information from compiling
print("Loss function: " + model.loss)

model.fit(predictors, target)


# Classification 
## categorical_crossentropy loss function...


## Loading titanic dataset...
titanic = pd.read_csv('./data/titanic_all_numeric.csv')
titanic.head()
titanic.columns
titanic.describe
titanic.info()

titanic[['age']].describe()

df = titanic

# Import necessary modules
import keras
from keras.layers import Dense
from keras.models import Sequential
from keras.utils import to_categorical


# predictors = df.drop(['survived'], axis=1).as_matrix()
# predictors.shape

# Convert the target to categorical: target
target = to_categorical(df.survived)
# target.shape
# 
# n_cols = predictors.shape[1]

# Set up the model
model = Sequential()

# Add the first layer
model.add(Dense(32, activation = 'relu', input_shape = (n_cols, )))

# Add the output layer
model.add(Dense(2, activation = 'softmax'))

# Compile the model
model.compile(optimizer='sgd', loss = 'categorical_crossentropy', metrics = ['accuracy'])

# Fit the model
model.fit(predictors, target)

# Using models...

# Specify, compile, and fit the model
model = Sequential()
model.add(Dense(32, activation='relu', input_shape = (n_cols,)))
model.add(Dense(2, activation='softmax'))
model.compile(optimizer='sgd', 
              loss='categorical_crossentropy', 
              metrics=['accuracy'])
model.fit(predictors, target)

# Calculate predictions: predictions
predictions = model.predict(pred_data)

# Calculate predicted probability of survival: predicted_prob_true
predicted_prob_true = predictions[:, 1]

# print predicted_prob_true
print(predicted_prob_true)







