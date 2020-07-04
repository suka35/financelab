% 1 Factor Vasicek의 모수를 칼만필터를 이용해 추정하는 Code

function loglikelihood = kalman_filter_logl(para)

% para(1) : kappa
% para(2) : theta
% para(3) : sigma
% para(4) : lambda

load('yield.mat')       % yield data를 불러옴(변수 z)
nobs = size(z,1);       % 관측치 갯수(데이타 갯수) 총 52주(1년)
N = size(z,2);          % 만기 갯수(3개월,6개월,9개월,1년,1년6개월,2년,2년6개월,3년,5년,10년) 총10개
dt = 1/52;              % dalata t는 주별 데이타를 사용하기 때문에 
logl = zeros(nobs,1);   % 우도 함수 값을 저장하기 위한 변수

% 칼만 필터링에서 사용될 초기값들                 
rt_1 = para(2);                 % 상태 변수의 초기값을 상태변수의 장기평균(para(2))로 설정한다.  
Pt_1 = para(3)^2 / (2*para(1)); % 상태변수의 초기 unconditional variance를 다음과 같이 설정



F = exp(-para(1)*dt);                                   % 상태 방정식의 기울기
C = para(2)*(1 - exp(-para(1)*dt));                     % 상태 방정식의 계수
Q = (para(3)^2*(1-exp(-2*para(1)*dt))) / (2*para(1));   % 상태 방정식의 에러의 분산
R = diag(var(z));                                       % 관측 방정식의 에러의 분산(yield data의 분산값을 대각행렬로 가짐)
tau = [0.25,0.5,0.75,1,1.5,2,2.5,3,5,10]';              % 채권만기 10개
% 관측 방정식의 기울기의 원소인 A(tau), B(tau)값 구하기
A = zeros(N,1); B = zeros(N,1);
for j = 1 : N
     B(j) = (1-exp(-para(1)*tau(j))) / para(1);
     A(j) = (para(2)-(para(3)*para(4))/para(1) - para(3)^2/(2*para(1)^2))*(B(j)-tau(j)) ...
         - (para(3)^2*B(j)^2) / (4*para(1));
end
% 관측 방정식의 기울기와 계수
A = -A./tau;   % 계수
H = B./tau;   % 기울기
 
% 결과 값들을 저장할 변수를 지정함
z_cond = zeros(nobs,N);
r_cond = zeros(nobs,1);
P_cond = zeros(nobs,1);
v = zeros(nobs,N);
r = zeros(nobs,1);
P = zeros(nobs,1);

% 관측치 별로 칼만 필터를 적용하는 부분
for i = 1 : nobs
    zt = z(i,:)';
    % 관측방정식의 예측
    zt_1 = H * rt_1 + A;
    Ft = H*Pt_1*H' + R;
    % 업데이트 방정식
    vt = zt - zt_1;   % 실제관측값과 예측된 관측값의 차이
    rt = rt_1 + Pt_1*H'*inv(Ft)*vt;
    Pt = Pt_1 - Pt_1*H'*inv(Ft)*H*Pt_1;
    % 상태변수의 예측
    rt_1 = F * rt + C;
    Pt_1 = F * Pt * F' + Q;
    % 결과 저장하기
    z_cond(i,:) = zt_1;
    v(i,:) = vt';
    r(i) = rt;
    r_cond(i) = rt_1;
    P(i) = Pt;
    P_cond(i) = Pt_1;
    % LogLikelihood값 계산
    detF = det(Ft);
    if detF <= 0
        detF = 1e-10;
    end
    logl(i) = -(N/2)*log(2*pi) - 0.5*log(detF) - 0.5*vt'*inv(Ft)*vt;
end
loglikelihood = -sum(logl);   
% 우도 함수 값의 합을 최대로 하는 모수를 찾는것이 목적이므로 (-)을 붙여줌
% fminsearch 함수를 사용해 추정하려고