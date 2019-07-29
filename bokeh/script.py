
# coding: utf-8

# In[1]:


from bokeh.io import curdoc
from bokeh.layouts import column
from bokeh.models import ColumnDataSource, Select
from bokeh.plotting import figure
from numpy.random import random, normal, lognormal


# In[2]:


N=1000
source = ColumnDataSource(data={'x':random(N), 'y':random(N)})


# In[3]:


plot = figure()
plot.circle(x='x', y='y', source=source)


# In[4]:


menu = Select(options=['uniform', 'normal', 'lognormal'],
             value = 'uniform', title='Distribution')


# In[5]:


def callback(attr, old, new):
    if menu.value == 'uniform': f = random
    elif menu.value == 'normal': f = normal
    else:
        source.data={'x': f(size=N), 'y':f(size=N)}
menu.on_change('value', callback)


# In[6]:


layout = column(menu, plot)


# In[7]:


curdoc().add_root(layout)

