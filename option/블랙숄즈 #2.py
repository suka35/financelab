# -*- coding: utf-8 -*-
"""
Created on Tue May 19 14:43:52 2020

@author: SSU
"""

# import numpy as np
# import scipy.stats as stat 
# import plotly.graph_objs as go
# from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
# init_notebook_mode(connected=True)


# X-axis : Spot Price

S = np.linspace(0,200,100)

# Maturity 2 ~ 10

data1 = []
for i in range (2,11,2):
T = i
Z = europian_option(S, K, T, r, sigma, 'call')
trace = go.Scatter(x=S, y=Z, name=('Maturity=' + str(T)))
data.append(trace)

    
# Maturity 0 ~ 2
data2=[]

for i in range(0,11,2):
T = i / 10
Z = europian_option(S, K, T, r, sigma, 'call')
trace  = go.Scatter(x=S, y=Z, name=('Maturity=' + str(T)))
data2.append(trace)
    
# Plotting
layout = go.Layout(width=800, height=400, xaxis=dict(title='Spot Price'), yaxis=dict(title='Option Value'))
fig1 = dict(data=data1, layout=layout)
fig2 = dict(data=data2, layout=layout)

iplot(fig1)
iplot(fig2)
