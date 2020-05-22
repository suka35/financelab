import numpy as np
import matplotlib.pyplot as plt

sigma_s = 1   ## volatility of domestic stocks
lamda_s = 1  ## risk premium of domestic stocks (MPR)
dz_s = 1 ## browninan motion of uncertainty of domestics stocks
dt = 1 ## 만기/거래일
r = 0.0286 ## 단기이자율

sigma_e = 1  ## volatility of domestic ESG stocks
lamda_e = 1 ## risk premium of domestic ESG stocks
dz_e = 1 ## browninan motion of uncertainty of domestics ESG stocks

sigma_r = 1 ## 국내 명목 이자율에 대한 변동성
k = 1 ## 국내 단기이자율의 평균으로의 회귀속도
r_bar = 1 ## 국내 단기이자율의 장기평균
dz_r = 1 ## 국내 이자율에대한 불확실성을 나타내는 브라우니안 모션

theta_s = 1 ## 국내주가수익률에 대한 시장의 위험가격 벡터
theta_e = 1 ## 국내ESG수익률에 대한 시장의 위험가격 벡터
theta_r = 1 ## 국내채권이자율에 대한 시장의 위험가격 벡터

Max_x = 1 ## 자산배분택터에 대한 최대값
W_t = 1 ## t시점의 부
gamma = 1 ## 상대적 위험회피계수
x_s = 1 ## 국내주식의 자산배분
x_e = 1 ## 국내ESG주식의 자산배분
x_r = 1 ## 국내채권의 자산배분

sigma_sf = 1   ## 해외 주가수익률의 변동성
lamda_sf = 1  ## 해외 주식에 대한 위험 프리미엄
dz_sf = 1 ## 해외 주식에 대한 불확실성을 나타내는 브라우니안 모션

sigma_ef = 1  ## 해외 ESG주가 수익률의 변동성
lamda_ef = 1 ## 해외 ESG주식에 대한 위험 프리미엄
dz_ef = 1 ## 해외 ESG 주식에 대한 불확실성을 나타내는 브라우니안 모션

sigma_rf = 1 ## 해외 명목 이자율에 대한 변동성
kf = 1 ## 해외 단기이자율의 평균으로의 회귀속도
rf_bar = 1 ## 해외 단기이자율의 장기평균
dz_rf = 1 ## 해외 이자율에대한 불확실성을 나타내는 브라우니안 모션

theta_sf = 1 ## 해외주가수익률에 대한 시장의 위험가격 벡터
theta_ef = 1 ## 해외ESG수익률에 대한 시장의 위험가격 벡터
theta_rf = 1 ## 해외채권이자율에 대한 시장의 위험가격 벡터

x_sf = 1 ## 해외주식의 자산배분
x_ef = 1 ## 해외ESG주식의 자산배분
x_rf = 1 ## 해외채권의 자산배분

A_s = r+(sigma_s*lamda_s)
B_s = sigma_s
A_e = r+(sigma_e*lamda_e)
B_e = sigma_e

dS = (A_s*dt) + (B_s*dz_s)
dE = (A_e*dt) + (B_e*dz_e)