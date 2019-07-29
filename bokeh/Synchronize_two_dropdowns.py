
# coding: utf-8

# In[3]:


from bokeh.io import curdoc
from bokeh.layouts import column, row, widgetbox
from bokeh.models import ColumnDataSource, Select
from bokeh.plotting import figure
from numpy.random import random, normal, lognormal

import pandas as pd
import numpy as np


# In[2]:


# Create two dropdown Select widgets: select1, select2
select1 = Select(title='First', options = ['A', 'B'], value = 'A')
select2 = Select(title='Second', options = ['1', '2', '3'], value = '1')


# In[ ]:


# Define a callback function: callback

def callback(attr, old, new):
    # If select1 is 'A'
    if select1 == 'A':
        # Set select2 options to ['1', '2', '3']
        select2.options = ['1', '2', '3']
        
        # Set select2 value to '1'
        select2.value = '1'
    else:
        # Set select2 option to ['100', '200', '300']
        select2.options = ['100', '200', '300']
        
        select2.value = '100'
        
# Attach the callback to the 'value' property of select1
select1.on_change('value', callback)

# Create layout and add to current document
layout = widgetbox(select1, select2)
curdoc().add_root(layout)      
        

