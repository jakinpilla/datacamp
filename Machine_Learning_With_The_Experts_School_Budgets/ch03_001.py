import os
os.getcwd()
os.chdir('C:\\Users\\Daniel\\Documents\\datacamp\\Machine_Learning_With_The_Experts_School_Budgets') 

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns



# Pipelines, feature & preprocessing...

iris = pd.read_csv('./data/iris.csv')

from sklearn.pipeline import Pipeline

from sklearn.linear_model import LogisticRegression

from sklearn.multiclass import OneVsRestClassifier

pl = Pipeline([
  ('clf', OneVsRestClassifier(LogisticRegression()))
])

from sklearn.model_selection import train_test_split

NUMERIC = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width']
LABEL = ['Species']

X_train, X_test, y_train, y_test = train_test_split(
  iris[NUMERIC],
  pd.get_dummies(iris[LABEL]),
  random_state=2
)

X_train.shape
y_train.shape

pl.fit(X_train, y_train)

accuracy = pl.score(X_test, y_test)

print('accuracy on numeric data, no nans: ', accuracy)

##----

sample_df_with_missing = pd.read_csv('./data/sample_df.csv')


NUMERIC = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'with_missing']
LABEL = ['Species']


X_train, X_test, y_train, y_test = train_test_split(
  sample_df_with_missing[NUMERIC],
  pd.get_dummies(sample_df_with_missing[LABEL]),
  random_state=2
)pl

from sklearn.preprocessing import Imputer

pl = Pipeline([
  ('imp', Imputer()),
  ('clf', OneVsRestClassifier(LogisticRegression()))
])

pl.fit(X_train, y_train)

accuracy = pl.score(X_test, y_test)

print('accuracy on all numeric, incl nans: ', accuracy)



# Import Pipeline
from sklearn.pipeline import Pipeline

# Import other necessary modules
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.multiclass import OneVsRestClassifier


NUMERIC = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width']
LABEL = ['Species']

# Split and select numeric data only, no nans 
X_train, X_test, y_train, y_test = train_test_split(iris[NUMERIC],
                                                    pd.get_dummies(iris[LABEL]), 
                                                    random_state=22)

# Instantiate Pipeline object: pl
pl = Pipeline([
        ('clf', OneVsRestClassifier(LogisticRegression()))
    ])

# Fit the pipeline to the training data
pl.fit(X_train, y_train)

# Compute and print accuracy
accuracy = pl.score(X_test, y_test)
print("\nAccuracy on sample data - numeric, no nans: ", accuracy)


# Import the Imputer object
from sklearn.preprocessing import Imputer

NUMERIC = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'with_missing']
LABEL = ['Species']

# Create training and test sets using only numeric data
X_train, X_test, y_train, y_test = train_test_split(sample_df_with_missing[NUMERIC],
                                                    pd.get_dummies(sample_df_with_missing[LABEL]), 
                                                    random_state=456)

# Insantiate Pipeline object: pl
pl = Pipeline([
        ('imp', Imputer()),
        ('clf', OneVsRestClassifier(LogisticRegression()))
    ])

# Fit the pipeline to the training data
pl.fit(X_train, y_train)

# Compute and print accuracy
accuracy = pl.score(X_test, y_test)
print("\nAccuracy on sample data - all numeric, incl nans: ", accuracy)


df.head()

# make sample data...
sample_df_with_missing
sample_df_with_missing['text'] = df.Program_Description

sample_df_with_missing.head()

sample_df = sample_df_with_missing
sample_df['text']
sample_df['text'].fillna("", inplace = True)

sample_df = sample_df.rename(columns = {'Species':'label'})
sample_df['label']


sample_df.head()


from sklearn.feature_extraction.text import CountVectorizer

X_train, X_test, y_train, y_test  = train_test_split(sample_df['text'], 
pd.get_dummies(sample_df['label']), random_state = 2)

X_train.head()
X_train.shape

y_train.head()
y_train.shape

pl = Pipeline([
  ('vec', CountVectorizer()), 
  ('clf', OneVsRestClassifier(LogisticRegression()))
])


pl.fit(X_test, y_test)

accuracy = pl.score(X_test, y_test)

print('accuracy on sample data: ', accuracy)

## ----
sample_df.head()
sample_df['numeric'] = np.random.rand(150)


X_train, X_test, y_train, y_test = train_test_split(sample_df[['numeric', 'with_missing', 'text']], 
pd.get_dummies(sample_df['label']), random_state =2)


from sklearn.preprocessing import FunctionTransformer
from sklearn.pipeline import FeatureUnion


get_text_data = FunctionTransformer(lambda x: x['text'], validate = False)
get_numeric_data = FunctionTransformer(lambda x: x[['numeric', 'with_missing']], validate = False)


numeric_pipeline = Pipeline([
  ('selector', get_numeric_data),
  ('imputer', Imputer())
])


text_pipeline = Pipeline([
  ('selector', get_text_data),
  ('vectorizer', CountVectorizer())
])



# Make pipeline....

pl = Pipeline([
  ('union', FeatureUnion([
    ('numeric', numeric_pipeline),
    ('text', text_pipeline)
  ])),
  ('clf', OneVsRestClassifier(LogisticRegression()))
])



# Import the CountVectorizer
from sklearn.feature_extraction.text import CountVectorizer

# Split out only the text data
X_train, X_test, y_train, y_test = train_test_split(sample_df['text'],
                                                    pd.get_dummies(sample_df['label']), 
                                                    random_state=456)

# Instantiate Pipeline object: pl
pl = Pipeline([
        ('vec', CountVectorizer()),
        ('clf', OneVsRestClassifier(LogisticRegression()))
    ])

# Fit to the training data
pl.fit(X_train, y_train)

# Compute and print accuracy
accuracy = pl.score(X_test, y_test)
print("\nAccuracy on sample data - just text data: ", accuracy)


# Import FunctionTransformer
from sklearn.preprocessing import FunctionTransformer

# Obtain the text data: get_text_data
get_text_data = FunctionTransformer(lambda x: x['text'], validate=False)

# Obtain the numeric data: get_numeric_data
get_numeric_data = FunctionTransformer(lambda x: x[['numeric', 'with_missing']], validate=False)

# Fit and transform the text data: just_text_data
just_text_data = get_text_data.fit_transform(sample_df)

# Fit and transform the numeric data: just_numeric_data
just_numeric_data = get_numeric_data.fit_transform(sample_df)

# Print head to check results
print('Text Data')
print(just_text_data.head())
print('\nNumeric Data')
print(just_numeric_data.head())



# Import FeatureUnion
from sklearn.pipeline import FeatureUnion

# Split using ALL data in sample_df
X_train, X_test, y_train, y_test = train_test_split(sample_df[['numeric', 'with_missing', 'text']],
                                                    pd.get_dummies(sample_df['label']), 
                                                    random_state=22)

# numeric_pipeline = Pipeline([
#   ('selector', get_numeric_data),
#   ('imputer', Imputer())
# ])
# 
# 
# text_pipeline = Pipeline([
#   ('selector', get_text_data),
#   ('vectorizer', CountVectorizer())
# ])

# Create a FeatureUnion with nested pipeline: process_and_join_features
process_and_join_features = FeatureUnion(
            transformer_list = [
                ('numeric_features', Pipeline([
                    ('selector', get_numeric_data),
                    ('imputer', Imputer())
                ])),
                ('text_features', Pipeline([
                    ('selector', get_text_data),
                    ('vectorizer', CountVectorizer())
                ]))
             ]
        )

# pl = Pipeline([
#   ('union', FeatureUnion([
#     ('numeric', numeric_pipeline),
#     ('text', text_pipeline)
#   ])),
#   ('clf', OneVsRestClassifier(LogisticRegression()))
# ])

# Instantiate nested pipeline: pl
pl = Pipeline([
        ('union', process_and_join_features),
        ('clf', OneVsRestClassifier(LogisticRegression()))
    ])


# Fit pl to the training data
pl.fit(X_train, y_train)

# Compute and print accuracy
accuracy = pl.score(X_test, y_test)
print("\nAccuracy on sample data - all data: ", accuracy)


## Choosing a classification model....

# Import FunctionTransformer
from sklearn.preprocessing import FunctionTransformer


NUMERIC_COLUMNS = ['FTE', 'Total']
LABELS = ['Function', 'Use', 'Sharing', 'Reporting', 'Student_Type', 'Position_Type',
       'Object_Type', 'Pre_K', 'Operating_Status']
       
# df.columns

# Get the dummy encoding of the labels
dummy_labels = pd.get_dummies(df[LABELS])

dummy_labels.columns
DUMMY_LABELS = dummy_labels.columns.tolist()
dummy_labels.head()

# dummy_labels.shape

NON_LABELS = [c for c in df.columns if c not in LABELS]

# len(NON_LABELS)  - len(NUMERIC_COLUMNS)

import multilabel as mll
# Split into training and test sets
X_train, X_test, y_train, y_test = mll.multilabel_train_test_split(df[NON_LABELS], dummy_labels, 0.8, seed=123)
 
X_train.shape
y_train.shape

df_test = pd.concat([X_test, y_test], axis = 1)

df_test.shape

X_train_1, X_test, y_train_1, y_test = mll.multilabel_train_test_split(df_test[NON_LABELS], df_test[DUMMY_LABELS], .2, seed =123)

X_test.shape
y_test.shape

# X_train_1, X_test, y_train_1, y_test = mll.multilabel_train_test_split(df[NON_LABELS], dummy_labels, 0.8, seed=123)

combine_text_columns(df)

# Preprocess the text data: get_text_data
get_text_data = FunctionTransformer(combine_text_columns, validate=False)

# Preprocess the numeric data: get_numeric_data
get_numeric_data = FunctionTransformer(lambda x: x[NUMERIC_COLUMNS], validate=False)


# Complete the pipeline: pl
pl = Pipeline([
        ('union', FeatureUnion(
            transformer_list = [
                ('numeric_features', Pipeline([
                    ('selector', get_numeric_data),
                    ('imputer', Imputer())
                ])),
                ('text_features', Pipeline([
                    ('selector', get_text_data),
                    ('vectorizer', CountVectorizer())
                ]))
             ]
        )),
        ('clf', OneVsRestClassifier(LogisticRegression()))
    ])

# X_train.shape
# y_train.shape

# Fit to the training data
pl.fit(X_train, y_train)

# Compute and print accuracy
accuracy = pl.score(X_test, y_test)
print("\nAccuracy on budget dataset: ", accuracy)


## -------------

# Import random forest classifer
from sklearn.ensemble import RandomForestClassifier

# Edit model step in pipeline
pl = Pipeline([
        ('union', FeatureUnion(
            transformer_list = [
                ('numeric_features', Pipeline([
                    ('selector', get_numeric_data),
                    ('imputer', Imputer())
                ])),
                ('text_features', Pipeline([
                    ('selector', get_text_data),
                    ('vectorizer', CountVectorizer())
                ]))
             ]
        )),
        ('clf', RandomForestClassifier())
    ])

# Fit to the training data
pl.fit(X_train, y_train)

# Compute and print accuracy
accuracy = pl.score(X_test, y_test)
print("\nAccuracy on budget dataset: ", accuracy)




# Import RandomForestClassifier
from sklearn.ensemble import RandomForestClassifier

# Add model step to pipeline: pl
pl = Pipeline([
        ('union', FeatureUnion(
            transformer_list = [
                ('numeric_features', Pipeline([
                    ('selector', get_numeric_data),
                    ('imputer', Imputer())
                ])),
                ('text_features', Pipeline([
                    ('selector', get_text_data),
                    ('vectorizer', CountVectorizer())
                ]))
             ]
        )),
        ('clf', RandomForestClassifier(n_estimators=15))
    ])

# Fit to the training data
pl.fit(X_train, y_train)

# Compute and print accuracy
accuracy = pl.score(X_test, y_test)
print("\nAccuracy on budget dataset: ", accuracy)


