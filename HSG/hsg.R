
### Domestic variable


sigma_S <- 1     ## volatility of domestic stocks
#lam_S <- 1      ## risk premium of domestic stocks (MPR)
dz_S <- 1        ## browninan motion of uncertainty of domestics stocks
T <- 174
# T<- np.array([x for x in np.arange(0,174,1)])
D <- 252
dt <- T/D        ## 만기/거래일
r <- 0.0286      ## 단기이자율

sigma_E <- 1     ## volatility of domestic ESG stocks
#lam_E <- 1      ## risk premium of domestic ESG stocks
dz_E <- 1        ## browninan motion of uncertainty of domestics ESG stocks

sigma_r <- 1     ## 국내 명목 이자율에 대한 변동성
kapa <- 1        ## 국내 단기이자율의 평균으로의 회귀속도
rbar <- 1        ## 국내 단기이자율의 장기평균
dz_r <- 1        ## 국내 이자율에대한 불확실성을 나타내는 브라우니안 모션

pi_S <- 1        ## 국내주가수익률에 대한 시장의 위험가격 벡터
pi_E <- 1        ## 국내ESG수익률에 대한 시장의 위험가격 벡터
pi_r <- 1        ## 국내채권이자율에 대한 시장의 위험가격 벡터

Max_x <- 1      ## 자산배분택터에 대한 최대값
W_t <- 1        ## t시점의 부
gamma <- 1      ## 상대적 위험회피계수
x_s <- 1        ## 국내주식의 자산배분
x_e <- 1        ## 국내ESG주식의 자산배분
x_r <- 1        ## 국내채권의 자산배분

rho_Sr <- 0.23145
rho_Er <- 0.12385
rho_SE <- 0.21345
## rho_sr <- np.repeat(0.5, 100, ) (반복문 만들기)


### foreign variable

sigma_sf <- 1   ## 해외 주가수익률의 변동성
lam_sf <- 1     ## 해외 주식에 대한 위험 프리미엄
dz_sf <- 1      ## 해외 주식에 대한 불확실성을 나타내는 브라우니안 모션

sigma_ef <- 1   ## 해외 ESG주가 수익률의 변동성
lam_ef <- 1     ## 해외 ESG주식에 대한 위험 프리미엄
dz_ef <- 1      ## 해외 ESG 주식에 대한 불확실성을 나타내는 브라우니안 모션

sigma_rf <- 1   ## 해외 명목 이자율에 대한 변동성
kapaf <- 1      ## 해외 단기이자율의 평균으로의 회귀속도
rfbar <- 1      ## 해외 단기이자율의 장기평균
dz_rf <- 1      ## 해외 이자율에대한 불확실성을 나타내는 브라우니안 모션

theta_sf <- 1   ## 해외주가수익률에 대한 시장의 위험가격 벡터
theta_ef <- 1   ## 해외ESG수익률에 대한 시장의 위험가격 벡터
theta_rf <- 1   ## 해외채권이자율에 대한 시장의 위험가격 벡터

x_sf <- 1       ## 해외주식의 자산배분
x_ef <- 1       ## 해외ESG주식의 자산배분
x_rf <- 1       ## 해외채권의 자산배분


### parameter

lam_S <- -(pi_S+(pi_E*rho_SE)+(pi_r*rho_Sr))
lam_E <- -(pi_E +(pi_S*rho_SE)+(pi_r*rho_Er))
lam_r <- -((pi_S*rho_Sr) + (pi_E*rho_Er) + pi_r)

### Model

## Domestic
dS <- (r+sigma_S*lam_S)*dt + (sigma_S*dz_S) # 국내주식 GBM
dE <- (r+sigma_E*lam_E)*dt + (sigma_E*dz_E) # 해외ESG  GBM
dr <- kapa*((rbar-r)*dt)+sigma_r*dz_r #이자율 vasicek 모형
dM <- -r*dt+(pi_S*dz_S)+(pi_E*dz_E)+(pi_r*dz_r)



### Assumption

## E1(dz_S, dz_r) <- rho_sr*dt
E1 <- rho_Sr*dt

## E2(dz_E, dz_r) <- rho_Er*dt
E2 <- rho_Er * dt

## E3(dz_S, dz_E) <- rho_SE*dt
E3 <- rho_SE * dt

#for (j in 1:100){
for (t in 1:T){

B<- (1-exp(-kapa[T-t]))
A<- (rbar - (sigma_r/kapa)*lam_r - 0.5*((sigma_r/kapa)^2)) * (B[r, T] - (T-t) - ((sigma_r)^2/(4*kapa)*B^2[t,T]))

P<- exp(A[t,T]-(B[t,T]*r[t]))

}
#}

dS
dE
dr
dM

E1
E2
E3

t

