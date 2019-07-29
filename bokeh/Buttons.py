
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd


# In[2]:


from bokeh.io import curdoc
from bokeh.layouts import column, row, widgetbox
from bokeh.models import ColumnDataSource, Select
from bokeh.plotting import figure
from numpy.random import random, normal, lognormal


# In[3]:


from bokeh.models import Button
from bokeh.models import CheckboxGroup, RadioGroup, Toggle


# In[4]:


button = Button(label='press me')


# In[5]:


x = np.linspace(0, 10, 1000)
y = np.sin(x) + np.random.random(1000)*.2


# In[6]:


source = ColumnDataSource(data={
    'x': x,
    'y': y
})


# In[7]:


plot = figure()


# In[8]:


def update():
    N = 200
    new_y = np.sin(x) + np.random.random(N)
    
    source.data = {'x': x, 'y': new_y}


# In[9]:


button.on_click(update)


# In[10]:


layout = column(widgetbox(button), plot)
curdoc().add_root(layout)


# In[11]:


# !jupyter nbconvert --to python Buttons.ipynb

