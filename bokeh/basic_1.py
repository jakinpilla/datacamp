
# coding: utf-8

# In[ ]:


from bokeh.io import curdoc
from bokeh.plotting import figure

# Create plots and widgets
plot = figure()

# Add callbacks
plot.line(x=[1,2,3,4,5], y=[2,5,4,6,7])

# Arrange plots and widgets in layouts

curdoc().add_root(plot)

