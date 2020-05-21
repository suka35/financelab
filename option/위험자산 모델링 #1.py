# -*- coding: utf-8 -*-
"""
Created on Fri May 15 15:11:45 2020

@author: ASUS
"""

# 위험자산 모델링#1 
# S(t) = S(0)*e^(mu-(1/2)*sigma^2)*t+sigma*X_t

# 입력변수로 상정해야하는 것은 
# 1)위험자산가격의 초기 값 (S(0))
# 2)추세 파라미터(mu)
# 3)변동성 파라미터 (sigma)
# 4)만기 (t)
# 5)브라운운동 (X_t)

import numpy as np
import matplotlib.pyplot as plt

S0 = 100        # initial price
mu = 0.1        # drift
sigma = 0.23    # volatility
T = 1           # time to maturity
N = 10000           # number of trials
Xt = np.sqrt(T) * np.random.randn(N)


St = S0 * np.exp((mu - 0.5 * sigma ** 2) * T + sigma * Xt)

print (len(St))
plt.hist(St, bins=50)
plt.xlabel('price at maturity')
plt.ylabel('frequency')



