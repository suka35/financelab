### Module

import numpy as np
import math as m
import matplotlib.pyplot as plt
import pandas as pd
import datetime
import QuantLib as ql


### Common Variable

# zeta_s = 1                 # 불확실성을 나타내는 Brownian motion (측도 P에서 정의)
# zeta_1 = 1                 # 불확실성을 나타내는 Brownian motion (측도 P에서 정의)
# zeta_2 = 1                 # 불확실성을 나타내는 Brownian motion (측도 P에서 정의)


sigma_s = 1                # 국내 주가지수 수익률의 변동성
sigma_1 = 1                # 국내 단기이자율(무위험)의 변동성
sigma_2 = 1                # 해외 단기이자율(무위험)의 변동성
rho_s1  = 1                # 주가지수 수익률과 국내 단기이자율의 상관계수
rho_s2  = 1                # 주가지수 수익률과 해외 단기이자율의 상관계수
rho_12  = 1                # 국내단기 이자율과 해외 단기이자율의 상관계수
lamda_s = 1                # 주가지수 수익률에 대한 위험의 시장가격(MPR로 표기)
lamda_1 = 1                # 국내 단기이자율에 대한 위험의 시장가격
lamda_2 = 1                # 해외 단기이자율에 대한 위험의 시장가격
M = 1                      # 국내 pricing kernel
M_f = 1                    # 해외 pricing kernel
I = 1                      # 국내 주가지수(또는 대표주식)
r = 1                      # 국내 단기이자율
r_f = 1                    # 해외 단기이자율
P(t,T) = 1                 # 만기 T인 t시점의 국내 할인채권가격
Pf(t,T) = 1               # 만기 T인 t시점의 해외 할인채권가격(해외통화로 표시)
(P_f(t,T))**d = 1          # 해외 채권을 환율을 곱하여 국내화폐가치로 환산한 할인채권가격
S[t] = 1                   # t시점의 환율, 즉 해외화폐 1단위당 국내가격
prime() = matrix([[1,2,3],[10,20,30]])   # 전치행렬

### Domestic Market variation
kappa = 1                   # 국내의 단기이자율의 평균으로의 회귀속도
rbar = 1                  # 국내 단기이자율의 장기 평균

### Domestic Market

dI = (r + (sigma_s*lam_s)*dt) + (sigma_s*dz_s)          # GBM           eq(1)
dr = ((kappa * (r(bar) - r)) * dt) + (sigma_1 * dz_1)   # Vasicek       eq(2)
dM = (-r *dt) - (lamda_1 * dz_1)                        # 국내 pricing kernel 또는 SDF     eq(3)


### Foreign Market variation
kappa_f = 1               # 해외 단기이자율의 평균으로의 회귀속도
rfbar = 1          # 해외 단기이자율의 장기 평균

### Foreign Market

d(r_f) = (kappa_f * (rfbar-r_f) * dt + (sigma_2 * dz_2)  # Vasicek      eq(4)
d(M_f) = -(r_f*dt) - (lamda_2 * dz_2)                          # 해외 pricing kernel 또는 SDF     eq(5)
# kappa,kappa_f,r(bar),rfbar,sigma_1,sigma_2 = constant     # 실수의 상수             

### Exchange udo variation
S = 1         # 환율
exp[dz_1 * dz_2] = (rho_12 * dt)   #가정
(sigma***) = (((lamda_1)***) - (lamda_1 * lamda_2 * rho_12))    #정의
### Exchange yudo

dS = (d(M_f) - dM) + (((lamda_1**2)dt) - (np.cov(M,M_f)))        # 단위당 외국자산 가격과 국내자산 가격의 교환비율      
dS = (r-r_f+(((lamda_1)**2)dt) + (lamda_1 * dz_1)) - (lamda_2 * dz_2) = ((r - r_f + sigma***)dt + (lamda_1 * dz_1) - (lamda_2 * dz_2))        # 단위당 외국자산 가격과 국내자산 가격의 교환비율   eq(6)



### Dynamics of Bond Price

P(t,T) = exp(A(t,T)-B(t,T) * r)          # 지수 아파인 형태의 할인채권 가격      eq(7)
#A(.),B(.)는 FPDE을 만족한다.

B(t,T) = (1-exp(-kappa * (T-t))) / kappa          # B(t,T) 구체적 수식
P = (r-B(t,T) * sigma_1 * lamda_1) * dt - B(t,T) * sigma_1 * dz_1     # p(.)에 Ito lemma 적용한 SDE(Stochastic Differential Equation)    eq(8)

P(t,T)_f = exp(A(t,T)_f) - ((B(t,T)_f) * r_f)  # 해외채권의 외화표시 채권가격        eq(9)
dP_f = (r_f - B(t,T)_f) * sigma_2 * lamda_2) * dt - B(t,T))_f * sigma_2 * dz_2    #해외채권가격에 Ito lemma 적용한 식       eq(10)

(P_f)**d = P_f * S = P_f + S + np.cov(P_f,S)   # Ito chain rule에 의해 해외채권 원화표시가격인 (P_f)**d         eq(11)
d(P_f)**d = (r + K(t,T)) * dt



