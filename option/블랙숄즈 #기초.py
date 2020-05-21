# -*- coding: utf-8 -*-
"""
Created on Tue May 19 11:18:06 2020

@author: SSU
"""


import numpy as np
import scipy.stats as stat

def europian_option(S,K,T,r,sigma,option_type):
    
    d1 = (np.log(S / K) + r + 0.5 * sigma **2) * T / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)
    
    if option_type == 'call':
    
        V = S * stat.norm.cdf(d1) - K * np.exp(-r * T) * stat.norm.cdf(d2)
    
    else:
        
        V = K * np.exp(-r * T) * stat.norm.cdf(-d2) - S * stat.norm.cdf(-d1)
        
        
    return V


print(europian_option(100,100,1,0.02,0.2,'call'))
print(europian_option(100,100,1,0.02,0.2,'put'))

