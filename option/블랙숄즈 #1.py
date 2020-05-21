# -*- coding: utf-8 -*-
"""
Created on Tue May 19 11:39:02 2020

@author: SSU
"""


# Import Libraries

import numpy as np
import scipy.stats as stat 

import plotly.graph_objs as go
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot

init_notebook_mode(connected=True)



def europian_option(S,K,T,r,sigma,option_type):
    
    d1 = (np.log(S / K) + (r + 0.5 * sigma **2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)
    
    if option_type == 'call':
    
        V = S * stat.norm.cdf(d1) - K * np.exp(-r * T) * stat.norm.cdf(d2)
    
    else:
        
        V = K * np.exp(-r * T) * stat.norm.cdf(-d2) - S * stat.norm.cdf(-d1)
        
        
    return V


# Parameters
    
K = 100

r = 0.01

sigma = 0.25

# Variables

T = np.linspace(0, 1, 100)

S = np.linspace(0, 200, 100)

T, S = np.meshgrid(T, S)

# Output

Call_Value = europian_option(S, K, T, r, sigma, 'call')
Put_Value = europian_option(S, K, T, r, sigma, 'put')

# # Call
# trace = go.Surface(x=T, y=S, z=Call_Value)
# data = [trace]
# layout = go.Layout(title='call option',
#                    scene={'xaxis':{'title':'Maturity'}, 'yaxis':{'title':'Spot Price'},
#                            'zaxis':{'title':'Option Price'}}
#                    )

# fig = go.Figure(data=data, layout=layout)
# plot(fig)


# Put
trace = go.Surface(x=T, y=S, z=Put_Value)
data = [trace]

layout = go.Layout(title='Put Option', 
                    scene={'xaxis':{'title':'Maturity'}, 'yaxis':{'title':'Spot Price'},
                          'zaxis':{'title':'Option Price'}}
                    )

fig = go.Figure(data=data, layout=layout)
plot(fig)

