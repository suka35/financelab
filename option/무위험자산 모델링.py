# -*- coding: utf-8 -*-
"""
Created on Fri May 15 14:20:59 2020

@author: ASUS
"""

#무위험자산 모델링 
#M(t) = M(0)e^rt

import numpy as np
import matplotlib.pyplot as plt

def risk_free_value(init_val,r,t):
    result = init_val*np.exp(r*t)
    return result

#Input as Value
    
init_val=100 
r=0.02
t=10

v=risk_free_value(init_val,r,t)

print(round(v,2))

t= np.array([x for x in np.arange(0,100,0.1)])

v= risk_free_value(init_val,r,t)

plt.plot(t,v)

