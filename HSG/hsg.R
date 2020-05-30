
### Domestic variable


sigma_S <- 1     ## volatility of domestic stocks
#lam_S <- 1      ## risk premium of domestic stocks (MPR)
dz_S <- 1        ## browninan motion of uncertainty of domestics stocks
T <- 174
# T<- np.array([x for x in np.arange(0,174,1)])
D <- 252
dt <- T/D        ## ë§Œê¸°/ê±°ëž˜?¼
r <- rep(0.0286,100)      ## ?‹¨ê¸°ì´?ž?œ¨

sigma_E <- 1     ## volatility of domestic ESG stocks
#lam_E <- 1      ## risk premium of domestic ESG stocks
dz_E <- 1        ## browninan motion of uncertainty of domestics ESG stocks

sigma_r <- 1     ## êµ??‚´ ëª…ëª© ?´?ž?œ¨?— ??€?•œ ë³€?™?„±
kapa <- 1        ## êµ??‚´ ?‹¨ê¸°ì´?ž?œ¨?˜ ?‰ê· ìœ¼ë¡œì˜ ?šŒê·€?†?„
rbar <- 1        ## êµ??‚´ ?‹¨ê¸°ì´?ž?œ¨?˜ ?ž¥ê¸°í‰ê·?
dz_r <- 1        ## êµ??‚´ ?´?ž?œ¨?—??€?•œ ë¶ˆí™•?‹¤?„±?„ ?‚˜??€?‚´?Š” ë¸Œë¼?š°?‹ˆ?•ˆ ëª¨ì…˜

pi_S <- 1        ## êµ??‚´ì£¼ê?€?ˆ˜?µë¥ ì— ??€?•œ ?‹œ?ž¥?˜ ?œ„?—˜ê°€ê²? ë²¡í„°
pi_E <- 1        ## êµ??‚´ESG?ˆ˜?µë¥ ì— ??€?•œ ?‹œ?ž¥?˜ ?œ„?—˜ê°€ê²? ë²¡í„°
pi_r <- 1        ## êµ??‚´ì±„ê¶Œ?´?ž?œ¨?— ??€?•œ ?‹œ?ž¥?˜ ?œ„?—˜ê°€ê²? ë²¡í„°

Max_x <- 1      ## ?ž?‚°ë°°ë¶„?ƒ?„°?— ??€?•œ ìµœë?€ê°?
W_t <- 1        ## t?‹œ? ?˜ ë¶€
gamma <- 1      ## ?ƒ??€?  ?œ„?—˜?šŒ?”¼ê³„ìˆ˜
x_s <- 1        ## êµ??‚´ì£¼ì‹?˜ ?ž?‚°ë°°ë¶„
x_e <- 1        ## êµ??‚´ESGì£¼ì‹?˜ ?ž?‚°ë°°ë¶„
x_r <- 1        ## êµ??‚´ì±„ê¶Œ?˜ ?ž?‚°ë°°ë¶„

rho_Sr <- 0.23145
rho_Er <- 0.12385
rho_SE <- 0.21345
## rho_sr <- np.repeat(0.5, 100, ) (ë°˜ë³µë¬? ë§Œë“¤ê¸?)


### foreign variable

sigma_sf <- 1   ## ?•´?™¸ ì£¼ê?€?ˆ˜?µë¥ ì˜ ë³€?™?„±
lam_sf <- 1     ## ?•´?™¸ ì£¼ì‹?— ??€?•œ ?œ„?—˜ ?”„ë¦¬ë?¸ì—„
dz_sf <- 1      ## ?•´?™¸ ì£¼ì‹?— ??€?•œ ë¶ˆí™•?‹¤?„±?„ ?‚˜??€?‚´?Š” ë¸Œë¼?š°?‹ˆ?•ˆ ëª¨ì…˜

sigma_ef <- 1   ## ?•´?™¸ ESGì£¼ê?€ ?ˆ˜?µë¥ ì˜ ë³€?™?„±
lam_ef <- 1     ## ?•´?™¸ ESGì£¼ì‹?— ??€?•œ ?œ„?—˜ ?”„ë¦¬ë?¸ì—„
dz_ef <- 1      ## ?•´?™¸ ESG ì£¼ì‹?— ??€?•œ ë¶ˆí™•?‹¤?„±?„ ?‚˜??€?‚´?Š” ë¸Œë¼?š°?‹ˆ?•ˆ ëª¨ì…˜

sigma_rf <- 1   ## ?•´?™¸ ëª…ëª© ?´?ž?œ¨?— ??€?•œ ë³€?™?„±
kapaf <- 1      ## ?•´?™¸ ?‹¨ê¸°ì´?ž?œ¨?˜ ?‰ê· ìœ¼ë¡œì˜ ?šŒê·€?†?„
rfbar <- 1      ## ?•´?™¸ ?‹¨ê¸°ì´?ž?œ¨?˜ ?ž¥ê¸°í‰ê·?
dz_rf <- 1      ## ?•´?™¸ ?´?ž?œ¨?—??€?•œ ë¶ˆí™•?‹¤?„±?„ ?‚˜??€?‚´?Š” ë¸Œë¼?š°?‹ˆ?•ˆ ëª¨ì…˜

theta_sf <- 1   ## ?•´?™¸ì£¼ê?€?ˆ˜?µë¥ ì— ??€?•œ ?‹œ?ž¥?˜ ?œ„?—˜ê°€ê²? ë²¡í„°
theta_ef <- 1   ## ?•´?™¸ESG?ˆ˜?µë¥ ì— ??€?•œ ?‹œ?ž¥?˜ ?œ„?—˜ê°€ê²? ë²¡í„°
theta_rf <- 1   ## ?•´?™¸ì±„ê¶Œ?´?ž?œ¨?— ??€?•œ ?‹œ?ž¥?˜ ?œ„?—˜ê°€ê²? ë²¡í„°

x_sf <- 1       ## ?•´?™¸ì£¼ì‹?˜ ?ž?‚°ë°°ë¶„
x_ef <- 1       ## ?•´?™¸ESGì£¼ì‹?˜ ?ž?‚°ë°°ë¶„
x_rf <- 1       ## ?•´?™¸ì±„ê¶Œ?˜ ?ž?‚°ë°°ë¶„


### parameter

lam_S <- -(pi_S+(pi_E*rho_SE)+(pi_r*rho_Sr))
lam_E <- -(pi_E +(pi_S*rho_SE)+(pi_r*rho_Er))
lam_r <- -((pi_S*rho_Sr) + (pi_E*rho_Er) + pi_r)

### Model

## Domestic
dS <- (r+sigma_S*lam_S)*dt + (sigma_S*dz_S) # êµ??‚´ì£¼ì‹ GBM
dE <- (r+sigma_E*lam_E)*dt + (sigma_E*dz_E) # ?•´?™¸ESG  GBM
dr <- kapa*((rbar-r)*dt)+sigma_r*dz_r #?´?ž?œ¨ vasicek ëª¨í˜•
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

