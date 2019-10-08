import os
os.getcwd()

import numpy as np
import pandas as pd
pd.set_option('display.max_rows', 50)
pd.set_option('display.max_columns', 50)
pd.set_option('display.width', 100)

# Import plotting modules
import matplotlib.pyplot as plt 
import seaborn as sns


import networkx as nx
G = nx.Graph()

G.add_nodes_from([1, 2, 3])
G.nodes()

G.add_edge(1, 2)
G.edges()

G.node[1]['label'] = 'blue'
G.nodes(data=True)

nx.draw(G)
plt.show()

# Import necessary modules
import matplotlib.pyplot as plt
import networkx as nx

# Draw the graph to screen
nx.draw(T_sub)
plt.show()


# Use a list comprehension to get the nodes of interest: noi
noi = [n for n, d in T.nodes(data=True) if d['occupation'] == 'scientist']

# Use a list comprehension to get the edges of interest: eoi
eoi = [(u, v) for u, v, d in T.edges(data=True) if d['date'] < date(2010, 1, 1)]


# Undirected graphs
import networkx as nx
G = nx.Graph()
type(G)

# Directed graphs...
D = nx.DiGraph()
type(D)

# Multi-edge (Directed) graphs...
M = nx.MultiDiGraph()
type(M)

MD = nx.MultiDiGraph()
type(MD)

# Self-loops...

# Set the weight of the edge
T.edges[1, 10]['weight'] = 2

# Iterate over all the edges (with metadata)
for u, v, d in T.edges(data = True):

    # Check if node 293 is involved
    if 293 in [u, v]:

        # Set the weight to 1.1
         T.edges[u, v]['weight'] = 1.1




# Define find_selfloop_nodes()
def find_selfloop_nodes(G):
    """
    Finds all nodes that have self-loops in the graph G.
    """
    nodes_in_selfloops = []

    # Iterate over all the edges of G
    for u, v in G.edges():

    # Check if node u and node v are the same
        if u == v:

            # Append node u to nodes_in_selfloops
            nodes_in_selfloops.append(u)

    return nodes_in_selfloops

# Check whether number of self loops equals the number of nodes in self loops
assert T.number_of_selfloops() == len(find_selfloop_nodes(T))


# Irrational vs. Rational visualizatons...

# Matrix plot...
# Arc Plot..
# Circos Plot...

# nxviz API....

import nxviz as nv
import matplotlib.pyplot as plt

plt.clf()
ap = nv.ArcPlot(G)
ap.draw()
plt.show()

# Import necessary modules
import matplotlib.pyplot as plt
import nxviz as nv

# Create the CircosPlot object: c
c = nv.CircosPlot(T)

# Draw c to the screen
c.draw()

# Display the plot
plt.show()


# Import necessary modules
import matplotlib.pyplot as plt
from nxviz import CircosPlot

# Create the CircosPlot object: c
c = CircosPlot(T)

# Draw c to the screen
c.draw()

# Display the plot
plt.show()


# Import necessary modules
import matplotlib.pyplot as plt
from nxviz import ArcPlot

# Create the un-customized ArcPlot object: a
a = ArcPlot(T)

# Draw a to the screen
a.draw()

# Display the plot
plt.show()

# Create the customized ArcPlot object: a2
a2 = ArcPlot(T, node_order='category',
node_color = 'category')

# Draw a2 to the screen
a2.draw()

# Display the plot
plt.show()




