% 1 factor Vasicek의 모수를 추정하는 알고리즘
t0 = clock;           % 계산 시간을 재기위해 시작 시간을 측정
ini_para = [0.1,0.04,0.02,-0.3,0,1,0,04];
[para,fval] = fminsearch(@kalman_filter_logl,ini_para,optimset('TolX',1e-10,'MaxFunEvals', 3500,'MaxIter',2500))
elapsed_time = etime(clock,t0) / 60;    % 계산 시간을 분단위로 구해준다.
fprintf('\n시뮬레이션 경과시간은 %4.2f분입니다.\n',elapsed_time);