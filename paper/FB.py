### Module

import numpy as np
import math as m
import matplotlib.pyplot as plt



### Variable

sigma_s = 1                # 국내 주가지수 수익률의 변동성
sigma_1 = 1                # 국내 단기이자율(무위험)의 변동성
sigma_2 = 1                # 해외 단기이자율(무위험)의 변동성
rho_s1  = 1





### Domestic Market

dI = (r + (sigma_s*lam_s)*dt) + (sigma_s*dz_s)         # GBM           eq(1)
                                                       # Vasicek       eq(2)

### Foreign Market






### Exchange yudo






### Dynamics of Bond Price