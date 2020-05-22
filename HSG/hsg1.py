# -*- coding: utf-8 -*-
"""
Created on Fri May 22 15:07:40 2020

@author: sungh
"""
import numpy as np

pai_s = 1   ## volatility of domestic stocks
lamda_s = 1  ## risk premium of domestic stocks
dz_s = 1 ## browninan motion of uncertainty of domestics stocks

pai_e = 1  ## volatility of domestic ESG stocks
lamda_e = 1 ## risk premium of domestic ESG stocks
dz_e = 1 ## browninan motion of uncertainty of domestics ESG stocks

pai_r = 1 ## 국내 명목 이자율에 대한 변동성
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

pai_sf = 1   ## 해외 주가수익률의 변동성
lamda_sf = 1  ## 해외 주식에 대한 위험 프리미엄
dz_sf = 1 ## 해외 주식에 대한 불확실성을 나타내는 브라우니안 모

pai_ef = 1  ## 해외 ESG주가 수익률의 변동성
lamda_ef = 1 ## 해외 ESG주식에 대한 위험 프리미엄
dz_ef = 1 ## 해외 ESG 주식에 대한 불확실성을 나타내는 브라우니안 모션

pai_rf = 1 ## 해외 명목 이자율에 대한 변동성
kf = 1 ## 해외 단기이자율의 평균으로의 회귀속도
rf_bar = 1 ## 해외 단기이자율의 장기평균
dz_rf = 1 ## 해외 이자율에대한 불확실성을 나타내는 브라우니안 모션

theta_sf = 1 ## 해외주가수익률에 대한 시장의 위험가격 벡터
theta_ef = 1 ## 해외ESG수익률에 대한 시장의 위험가격 벡터
theta_rf = 1 ## 해외채권이자율에 대한 시장의 위험가격 벡터

x_sf = 1 ## 해외주식의 자산배분
x_ef = 1 ## 해외ESG주식의 자산배분
x_rf = 1 ## 해외채권의 자산배분