# Non negative matrix factorization

# NMF
# Dimension reduction technique
# NMF are interpretable
# Easy to interpret means easy to explain...

# NMF expresss documents as combinations of topics (or 'theme')

from sklearn.decomposition import NMF

model = NMF(n_components=2)

samples

model.fit(samples)

nmf_features = model.transform(samples)

print(model.components_)

# Dimension of components = dimension of samples

print(nmf_features)

# NMF feature values are non-negative...
# Can by used to reconstruct the samples..
# ...combine feature values with components

i = 5
print(samples[i, :])

print(nmf_features[i, :])

# Multiply components by feature values, and add up
# Can also be expressed as a product of matrices
# This is the 'Matrix Factorization' in 'NMF'

# NMF fits to non-negative data, only...
# Word frequencies in each document...
# Images encoded as arrays...
# Purchase histories on e-commerce sites..


# Import NMF
from sklearn.decomposition import NMF

# Create an NMF instance: model
model = NMF(n_components=6)

# Fit the model to articles
model.fit(articles)

# Transform the articles: nmf_features
nmf_features = model.transform(articles)

# Print the NMF features
print(nmf_features)


##----------

toy_doc

toy_author = ['Kim', 'Lee' ,'Park']
toy_doc= ['cats say meow', 'dogs say woof', 'dogs chase cats']

df_text = pd.DataFrame({'author' : toy_author, 'text' : toy_doc})

# document name을 index로...
df_text.index = df_text['author']
df_text = df_text[['text']]

# Import TfidfVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer
from konlpy.tag import Komoran
tag = Komoran()

df = pd.read_csv('./data/news_dataset.csv', index_col=0)
df.head()

def kor_noun(text):
  words = []
  for w in tag.nouns(text):
    if len(w) > 1:
      words.append(w)
  return(words)

df.columns
txt_1  = df.iloc[0, 2]

kor_noun(txt_1)

# Create a TfidfVectorizer: tfidf
tfidf = TfidfVectorizer(tokenizer=kor_noun, norm='l2')

# Apply fit_transform to document: csr_mat
csr_mat = tfidf.fit_transform(df['content'])

# Create an NMF instance: model
model = NMF(n_components=6)

# Fit the model to articles
model.fit(csr_mat)

# Transform the articles: nmf_features
nmf_features = model.transform(csr_mat)

# Print the NMF features
print(nmf_features)


# Import pandas
import pandas as pd
df.date

doc_date = df.date.astype(str)

# Create a pandas DataFrame: df
df = pd.DataFrame(nmf_features, index=doc_date)
df.head()
df.index

# Print the row for 'Anne Hathaway'
print(df.loc['20170101', ])

# Print the row for 'Denzel Washington'
print(df.loc['20170201',])

##-----

# Import TfidfVectorizer
from sklearn.decomposition import NMF
from sklearn.feature_extraction.text import TfidfVectorizer
from konlpy.tag import Komoran
tag = Komoran()

df = pd.read_csv('./data/news_dataset.csv', index_col=0)
df.head()

def kor_noun(text):
  words = []
  for w in tag.nouns(text):
    if len(w) > 1:
      words.append(w)
  return(words)


# Create a TfidfVectorizer: tfidf
tfidf = TfidfVectorizer(tokenizer=kor_noun, norm='l2')

# Apply fit_transform to document: csr_mat
csr_mat = tfidf.fit_transform(df['content'])
articles = csr_mat

# Create an NMF instance: model
nmf = NMF(n_components=10)

# Fit the model to articles
nmf.fit(articles)

print(nmf.components_.shape)

# NMF components represents topics
# NMF features combine topics into documents

# Grayscale image example...

sample = np.array([0, 1, .5, 1, 0, 1])
bitmap = sample.reshape((2, 3))

from matplotlib.pyplot as plt

plt.clf()
plt.imshow(bitmap, cmap = 'gray', interpolation = 'nearest')
plt.show()

##-----------------------------------------------------------

# Import TfidfVectorizer
from sklearn.decomposition import NMF
from sklearn.feature_extraction.text import TfidfVectorizer
from konlpy.tag import Komoran
tag = Komoran()

df = pd.read_csv('./data/news_dataset.csv', index_col=0)
df.head()

def kor_noun(text):
  words = []
  for w in tag.nouns(text):
    if len(w) > 1:
      words.append(w)
  return(words)

# Create a TfidfVectorizer: tfidf
tfidf = TfidfVectorizer(tokenizer=kor_noun, norm='l2')

# Apply fit_transform to document: csr_mat
csr_mat = tfidf.fit_transform(df['content'])

words = tfidf.get_feature_names()
articles = csr_mat

# NMF model...
model = NMF(n_components=10)

# Fit the model to articles
model.fit(articles)

print(model.components_.shape)

# Import pandas
import pandas as pd

nmf.components_

# Create a DataFrame: components_df
components_df = pd.DataFrame(model.components_, columns = words)
components_df.head()

# Print the shape of the DataFrame
print(components_df.shape)

# Select row 3: component
component = components_df.iloc[3, ]

# Print result of nlargest
print(component.nlargest())


##  LED digits dataset---------------------------------------------------------

# loading dataset----
led = pd.read_csv('./data/lcd-digits.csv', header = None)
samples = led
samples = led.values
samples.shape

# Import pyplot
from matplotlib import pyplot as plt

# Select the 0th row: digit
digit = samples[0, :]

# Print digit
print(digit)

# Reshape digit to a 13x8 array: bitmap
bitmap = digit.reshape(13, 8)

# Print bitmap
print(bitmap)

plt.clf()
# Use plt.imshow to display bitmap
plt.imshow(bitmap, cmap='gray', interpolation='nearest')
plt.colorbar()
plt.show()


def show_as_image(sample):
    plt.clf()
    bitmap = sample.reshape((13, 8))
    plt.figure()
    plt.imshow(bitmap, cmap='gray', interpolation='nearest')
    plt.colorbar()
    plt.show()


samples.shape

# Import NMF
from sklearn.decomposition import NMF

# Create an NMF model: model
model = NMF(n_components=7)

# Apply fit_transform to samples: features
features = model.fit_transform(samples)

model.components_

plt.clf()
# Call show_as_image on each component
for component in model.components_:
    show_as_image(component)

# Assign the 0th row of features: digit_features
digit_features = features[0, ]

# Print digit_features
print(digit_features)


# Import PCA
from sklearn.decomposition import PCA

# Create a PCA instance: model
model = PCA(n_components=7)

# Apply fit_transform to samples: features
features = model.fit_transform(samples)

# Call show_as_image on each component
for component in model.components_:
    show_as_image(component)
    
    
# Recommender systems using NMF

# Import TfidfVectorizer
from sklearn.decomposition import NMF
from sklearn.feature_extraction.text import TfidfVectorizer
from konlpy.tag import Komoran
tag = Komoran()

df_text = pd.read_csv('./data/news_dataset.csv', index_col=0)
df_text.head()

def kor_noun(text):
  words = []
  for w in tag.nouns(text):
    if len(w) > 1:
      words.append(w)
  return(words)

# Create a TfidfVectorizer: tfidf
tfidf = TfidfVectorizer(tokenizer=kor_noun, norm='l2')

# Apply fit_transform to document: csr_mat
csr_mat = tfidf.fit_transform(df_text['content'])
words = tfidf.get_feature_names()
articles = csr_mat
    
from sklearn.decomposition import NMF
nmf = NMF(n_components=6)
nmf_features = nmf.fit_transform(articles)

# Cosine similarity...
# use the angle between the lines..
# Higher values means more similar...
# Maximum value is 1, when angle is 0

norm_features = normalize(nmf_features)

current_article = norm_features[23, :]

similarities = norm_features.dot(current_article)

norm_features = normalize(nmf_features)
norm_features.shape

# Create a pandas DataFrame: df
df = pd.DataFrame(norm_features, index=doc_date)
df.head()
df.index

current_article = df.loc['20170606']

similarities= df.dot(current_article)
similarities.tail()


df_text.head()
df_text[df_text['date'] == 20170606].content
df_text[df_text['date'] == 20171227].content

similarities.nlargest()


nmf_features
doc_date.values


# Perform the necessary imports
import pandas as pd
from sklearn.preprocessing import normalize

# Normalize the NMF features: norm_features
norm_features = normalize(nmf_features)

# Create a DataFrame: df
df = pd.DataFrame(norm_features, index = doc_date)

# Select the row corresponding to 'Cristiano Ronaldo': article
article = df.loc['20171225']

# Compute the dot products: similarities
similarities = df.dot(article)

# Display those with the largest cosine similarity
print(similarities.nlargest())


pd.read_csv('./data/artists.csv')
pd.read_csv('./data/scrobbler-small-sample.csv')

# Perform the necessary imports
from sklearn.decomposition import NMF
from sklearn.preprocessing import Normalizer, MaxAbsScaler
from sklearn.pipeline import make_pipeline

# Create a MaxAbsScaler: scaler
scaler = MaxAbsScaler()

# Create an NMF model: nmf
nmf = NMF(n_components=20)

# Create a Normalizer: normalizer
normalizer = Normalizer()

# Create a pipeline: pipeline
pipeline = make_pipeline(scaler, nmf, normalizer)

# Apply fit_transform to artists: norm_features
norm_features = pipeline.fit_transform(articles)


# Import pandas
import pandas as pd

# Create a DataFrame: df
df = pd.DataFrame(norm_features, index = doc_date)

# Select row of 'Bruce Springsteen': artist
article = df.loc['20171001']

# Compute cosine similarities: similarities
similarities = df.dot(article)

# Display those with highest cosine similarity
print(similarities)






















