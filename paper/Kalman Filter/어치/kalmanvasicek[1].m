1;

clear all;

%  State space reprsentation to be forcasted by kalman filter
%   zhi(t+1) = F*zhi(t) + v(t+1)   --> unbobserved varaibles
%   v~N(0,Q)
%   y(t) = A'*x(t) + H'*zhi(t) + w(t)
%   w~N(0,R)

global y;
global x;
global dt;
global BondT;
global kmin;
global kmax;
global thmin;
global thmax;

%%----    Enter  Input parameters ---------------------------------
theta=0.05; %long term mean of short rate process 
k=0.1; %mean reversion speed of short rate process 
T=2; %time till when short rate process is being evolved
n=200; %no. of time points
R=0.0001; %variance of zero coupon yield process
BondT=4; %maturity of zero coupon bond
sigma=0.01; %volatility of short rate process
lambda=0; %market price of risk parameter

kmin=0.01; %k lower limit for minimization
kmax=0.2; %k upper limit for minimization
thmin=0.01; %theta lower limit for minimization
thmax=0.15; %theta upper limit for minimization
%-------------------------------------------------------------------

dt=T/n; %time step size 
Q=sigma*sigma*(1-exp(-2*k*dt))/(2*k); %variance of state space process
F=exp(-k*dt); %coefficient in eqn. (63)
C=theta*(1-exp(-k*dt)); %coefficient in eqn. (63)


%Intialize state process
x=ones(n,1);
zhi=zeros(n,1); %short rate process 
y=zeros(n,1); %zero coupon yield process

v=normal_rnd(0,Q,n,1);
w=normal_rnd(0,R,n,1);

tau=BondT;
affineB=(1-exp(-k*tau))/k
affineG=k*k*(theta-sigma*lambda/k) - sigma*sigma/2
affineA=affineG*(affineB-tau)/(k*k) - sigma*sigma*affineB*affineB/(4*k)
A=-affineA/tau; %coefficient in (62)
H=affineB/tau; %coefficient in (62)
zhi(1) = theta + v(1); 
y(1)= A'*x(1) + H'*zhi(1) + w(1);

t=dt;
for i=2:n,
  tau=BondT-t;
  affineB=(1-exp(-k*tau))/k;
  affineG=k*k*(theta-sigma*lambda/k) - sigma*sigma/2;
  affineA=affineG*(affineB-tau)/(k*k) - sigma*sigma*affineB*affineB/(4*k);
  %P=exp(affineA-affineB*r);
  zhi(i) = F*zhi(i-1) + v(i);
  A=-affineA/tau; %coefficient in (62)
  H=affineB/tau; %coefficient in (62)
  zhi(i) = C + F*zhi(i-1) + v(i); %evolve state process in (63)
  y(i)= A'*x(i) + H'*zhi(i) + w(i); %evolve measurement process in (62)
  t=t+dt;
end

%log likelihood function of kalman filter
function ret=MyLikelihoodFn(p)
  global y;
  global x;
  global dt;
  global BondT;
  global kmin;
  global kmax;
  global thmin;
  global thmax;
  
  t=p(1);
  theta=thmin+(thmax-thmin)./(1+exp(-t));  %long term mean of short rate process 
  t=p(2);
  k=kmin+(kmax-kmin)./(1+exp(-t));  %mean reversion speed of short rate process 
  R=p(3)^2; %variance of zero coupon yield process
  sigma=p(4)^2; %volatility of short rate process
  lambda=0; %market price of risk parameter
  
  Q=sigma*sigma*(1-exp(-2*k*dt))/(2*k); %variance of state space process
  F=exp(-k*dt); %coefficient in eqn. (63)
  C=theta*(1-exp(-k*dt)); %coefficient in eqn. (63)

  n=size(y,1);
  P=Q; %initialize the variance to unconditional variance of state process
  Ezhi=theta; %initialize to unconditional mean
  Ezhivec=zeros(n,1);
  Ezhivec(1)=Ezhi;
  tmpsum=0;
  tmp1=-(n/2)*log(2*pi);
  t=dt;
  for i=2:n,
    yt=y(i);
    xt=x(i);
    tau=BondT-t;
    affineB=(1-exp(-k*tau))/k;
    affineG=k*k*(theta-sigma*lambda/k) - sigma*sigma/2;
    affineA=affineG*(affineB-tau)/(k*k) - sigma*sigma*affineB*affineB/(4*k);
    A=-affineA/tau; %coefficient in (62)
    H=affineB/tau; %coefficient in (62)

    Ezhi = F*Ezhi + F*P*H*inv(H'*P*H+R)*(yt-A'*xt-H'*Ezhi+H'*C);
    P = F*P*F' - F*P*H*inv(H'*P*H+R)*H'*P*F' + Q;
    Ezhivec(i)=Ezhi;
    tmpmat = H'*P*H + R;
    tmp2 = -0.5*log(det(tmpmat));
    tmpmat2 = yt - A'*xt - H'*Ezhi;
    tmp3=-0.5*tmpmat2'*inv(tmpmat)*tmpmat2;
    tmpsum=tmp1+tmp2+tmp3;
    t=t+dt;
  end
  ret=-tmpsum;   
endfunction  

param=zeros(4,1);

initparam=0.02;
t = -log((thmax-initparam)/(initparam-thmin)); 
param(1)=t;
initparam=0.15;
t = -log((kmax-initparam)/(initparam-kmin)); 
param(2)=t;
param(3)=R^0.5;
param(4)=sigma^0.5;

%solve log likelihood function
resultparam=fmins('MyLikelihoodFn',param)

actualTheta=theta
t=resultparam(1);
theta=thmin+(thmax-thmin)./(1+exp(-t))
actual_k=k
t=resultparam(2);
k=kmin+(kmax-kmin)./(1+exp(-t))
actual_R=R
R=resultparam(3)^2
actual_sigma=sigma
sigma=resultparam(4)^2

Q=sigma*sigma*(1-exp(-2*k*dt))/(2*k); %variance of state space process
F=exp(-k*dt); %coefficient in eqn. (63)
C=theta*(1-exp(-k*dt)); %coefficient in eqn. (63)

n=size(y,1);
P=Q; %initialize the variance to unconditional variance of state process
Ezhi=theta; %initialize to unconditional mean
Ezhivec=zeros(n,1);
Ezhivec(1)=Ezhi;
t=dt;
for i=2:n,
  yt=y(i);
  xt=x(i);
  tau=BondT-t;
  affineB=(1-exp(-k*tau))/k;
  affineG=k*k*(theta-sigma*lambda/k) - sigma*sigma/2;
  affineA=affineG*(affineB-tau)/(k*k) - sigma*sigma*affineB*affineB/(4*k);
  A=-affineA/tau; %coefficient in (62)
  H=affineB/tau; %coefficient in (62)
  Ezhi = F*Ezhi + F*P*H*inv(H'*P*H+R)*(yt-A'*xt-H'*Ezhi+H'*C);
  P = F*P*F' - F*P*H*inv(H'*P*H+R)*H'*P*F' + Q;
  Ezhivec(i)=Ezhi-C;
  t=t+dt;
end
                             
tmp=1:n;
plot(tmp,zhi,'-',tmp,Ezhivec,'-');






















return;

actualQ=Q
Q=resultparam(2)^2
actualA=A
A=resultparam(3)
actualR=R
R=resultparam(4)^2

n=size(y,1);
P=Q;
Ezhi=0;
Ezhivec=zeros(n,1);
Ezhivec(1)=Ezhi;

for i=2:n,
  yt=y(i);
  xt=x(i);
  H=Hvec(i);
  Ezhi = F*Ezhi + F*P*H*inv(H'*P*H+R)*(yt-A'*xt-H'*Ezhi);
  P = F*P*F' - F*P*H*inv(H'*P*H+R)*H'*P*F' + Q;
  Ezhivec(i)=Ezhi;
end
test=[zhi Ezhivec Hvec y];
tmp=1:n;
%plot(tmp,zhi,'-',tmp,Ezhivec,'-',tmp,Hvec,'-',tmp,y,'-');
plot(tmp,zhi,'-',tmp,Ezhivec,'-');

