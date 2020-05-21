# -*- coding: utf-8 -*-
"""
Created on Fri May 15 15:28:17 2020

@author: ASUS
"""

# 위험자산 모델링#2
# https://blog.naver.com/stochastic73/221473863731 참조

import numpy as np
import matplotlib.pyplot as plt

S0 = 100        # Initial price
mu = 0.1        # Drift
sigma = 0.23    # Volatility
T = 1.0         # Time to Maturity
D = 252         # Trading Days in 1 year
dt = T/D        # Annualized Measure of 1 Day
N = 10000       # Number of Trials

# Create an empty array and fill the initial value

S = np.zeros((D+1,N))
S[0] = S0

# Conduct simulation

for t in range(1, D+1):
    S[t] = S[t-1] * np.exp((mu - 0.5 * sigma **2) * dt + sigma 
                           * np.sqrt(dt) * np.random.randn(N))

# Plot graph
plt.plot(S[:, :10000])   # plot by given range
plt.xlabel('day')        # title of x-axis
plt.ylabel('price')      # title of y-axis
plt.grid(True)           # draw gridline

