
### Domestic variable


sigma_S <- 1     ## volatility of domestic stocks
#lam_S <- 1      ## risk premium of domestic stocks (MPR)
dz_S <- 1        ## browninan motion of uncertainty of domestics stocks
T <- 174
# T<- np.array([x for x in np.arange(0,174,1)])
D <- 252
dt <- T/D        ## λ§κΈ°/κ±°λ?Ό
r <- rep(0.0286,100)      ## ?¨κΈ°μ΄??¨

sigma_E <- 1     ## volatility of domestic ESG stocks
#lam_E <- 1      ## risk premium of domestic ESG stocks
dz_E <- 1        ## browninan motion of uncertainty of domestics ESG stocks

sigma_r <- 1     ## κ΅??΄ λͺλͺ© ?΄??¨? ??? λ³??±
kapa <- 1        ## κ΅??΄ ?¨κΈ°μ΄??¨? ?κ· μΌλ‘μ ?κ·??
rbar <- 1        ## κ΅??΄ ?¨κΈ°μ΄??¨? ?₯κΈ°νκ·?
dz_r <- 1        ## κ΅??΄ ?΄??¨???? λΆν?€?±? ????΄? λΈλΌ?°?? λͺ¨μ

pi_S <- 1        ## κ΅??΄μ£Όκ???΅λ₯ μ ??? ??₯? ??κ°κ²? λ²‘ν°
pi_E <- 1        ## κ΅??΄ESG??΅λ₯ μ ??? ??₯? ??κ°κ²? λ²‘ν°
pi_r <- 1        ## κ΅??΄μ±κΆ?΄??¨? ??? ??₯? ??κ°κ²? λ²‘ν°

Max_x <- 1      ## ??°λ°°λΆ??°? ??? μ΅λ?κ°?
W_t <- 1        ## t?? ? λΆ
gamma <- 1      ## ????  ????Όκ³μ
x_s <- 1        ## κ΅??΄μ£Όμ? ??°λ°°λΆ
x_e <- 1        ## κ΅??΄ESGμ£Όμ? ??°λ°°λΆ
x_r <- 1        ## κ΅??΄μ±κΆ? ??°λ°°λΆ

rho_Sr <- 0.23145
rho_Er <- 0.12385
rho_SE <- 0.21345
## rho_sr <- np.repeat(0.5, 100, ) (λ°λ³΅λ¬? λ§λ€κΈ?)


### foreign variable

sigma_sf <- 1   ## ?΄?Έ μ£Όκ???΅λ₯ μ λ³??±
lam_sf <- 1     ## ?΄?Έ μ£Όμ? ??? ?? ?λ¦¬λ?Έμ
dz_sf <- 1      ## ?΄?Έ μ£Όμ? ??? λΆν?€?±? ????΄? λΈλΌ?°?? λͺ¨μ

sigma_ef <- 1   ## ?΄?Έ ESGμ£Όκ? ??΅λ₯ μ λ³??±
lam_ef <- 1     ## ?΄?Έ ESGμ£Όμ? ??? ?? ?λ¦¬λ?Έμ
dz_ef <- 1      ## ?΄?Έ ESG μ£Όμ? ??? λΆν?€?±? ????΄? λΈλΌ?°?? λͺ¨μ

sigma_rf <- 1   ## ?΄?Έ λͺλͺ© ?΄??¨? ??? λ³??±
kapaf <- 1      ## ?΄?Έ ?¨κΈ°μ΄??¨? ?κ· μΌλ‘μ ?κ·??
rfbar <- 1      ## ?΄?Έ ?¨κΈ°μ΄??¨? ?₯κΈ°νκ·?
dz_rf <- 1      ## ?΄?Έ ?΄??¨???? λΆν?€?±? ????΄? λΈλΌ?°?? λͺ¨μ

theta_sf <- 1   ## ?΄?Έμ£Όκ???΅λ₯ μ ??? ??₯? ??κ°κ²? λ²‘ν°
theta_ef <- 1   ## ?΄?ΈESG??΅λ₯ μ ??? ??₯? ??κ°κ²? λ²‘ν°
theta_rf <- 1   ## ?΄?Έμ±κΆ?΄??¨? ??? ??₯? ??κ°κ²? λ²‘ν°

x_sf <- 1       ## ?΄?Έμ£Όμ? ??°λ°°λΆ
x_ef <- 1       ## ?΄?ΈESGμ£Όμ? ??°λ°°λΆ
x_rf <- 1       ## ?΄?Έμ±κΆ? ??°λ°°λΆ


### parameter

lam_S <- -(pi_S+(pi_E*rho_SE)+(pi_r*rho_Sr))
lam_E <- -(pi_E +(pi_S*rho_SE)+(pi_r*rho_Er))
lam_r <- -((pi_S*rho_Sr) + (pi_E*rho_Er) + pi_r)

### Model

## Domestic
dS <- (r+sigma_S*lam_S)*dt + (sigma_S*dz_S) # κ΅??΄μ£Όμ GBM
dE <- (r+sigma_E*lam_E)*dt + (sigma_E*dz_E) # ?΄?ΈESG  GBM
dr <- kapa*((rbar-r)*dt)+sigma_r*dz_r #?΄??¨ vasicek λͺ¨ν
dM <- -r*dt+(pi_S*dz_S)+(pi_E*dz_E)+(pi_r*dz_r)



### Assumption

## E1(dz_S, dz_r) <- rho_sr*dt
E1 <- rho_Sr*dt

## E2(dz_E, dz_r) <- rho_Er*dt
E2 <- rho_Er * dt

## E3(dz_S, dz_E) <- rho_SE*dt
E3 <- rho_SE * dt

kapa_Tt <- 1
Kapa_Tr <- 1

#r[1] <- (1+r)
for (i in 1:174){

  r[i] <- r[i-1]+1
  
}
for (t in 1:T)
  {B_tT <-  (1-exp(-kapa*(T-t)))/kapa
  B_rT <-  (1-exp(-kapa*(T-r)))/kapa
  A_tT <-  rbar - (sigma_r/kapa)*lam_r - 0.5*((sigma_r/kapa)^2) * ((B_rT - (T-t)) - (sigma_r^2/(4*kapa)*(B_tT)^2))

  P <-  exp(A_tT-(B_tT*r[i]))}
  
B_tT

dS
dE
dr
dM

E1
E2
E3

t

