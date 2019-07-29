
# coding: utf-8

# In[7]:


from bokeh.io import curdoc
from bokeh.layouts import column, row
from bokeh.models import ColumnDataSource, Select
from bokeh.plotting import figure
from numpy.random import random, normal, lognormal


# In[8]:


import pandas as pd
import numpy as np


# In[9]:


df_tmp = pd.read_csv('./data/fertility_data.csv')

fertility = df_tmp.fertility.tolist()
female_literacy_series = df_tmp['female_literacy']
female_literacy = female_literacy_series.tolist()


# In[10]:


# Create ColumnDataSource : spurce
source = ColumnDataSource(data = {
    'x' : fertility,
    'y' : female_literacy
})


# In[11]:


# Create a new plot: plot
plot = figure()


# In[12]:


# Add circles to the plot

plot.circle('x', 'y', source = source)


# In[15]:


# Define a callback function: update_plot
def update_plot(attr, old, new):
    # If the new Selection is 'female_literacy', update 'y' to female-literacy
    if new == 'female_literacy':
        source.data={
            'x' : fertility,
            'y' : female_literacy 
        }
    # Else, update 'y' to population
    else:
        source.data = {
            'x' : fertility,
            'y' : population
        }


# In[16]:


# Create a dropdown Select widget: select
select = Select(title="distribution", options=['female_literacy', 'population'], 
               value = 'female_literacy')


# In[17]:


# Attach the update_plot callback to the 'value' property of select
select.on_change('value', update_plot)


# In[ ]:


# Create layout and add to current document
layout = row(select, plot)
curdoc().add_root(layout)

