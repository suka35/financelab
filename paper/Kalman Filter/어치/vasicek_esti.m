% 1 factor Vasicek�� ����� �����ϴ� �˰���
t0 = clock;           % ��� �ð��� ������� ���� �ð��� ����
ini_para = [0.1,0.04,0.02,-0.3,0,1,0,04];
[para,fval] = fminsearch(@kalman_filter_logl,ini_para,optimset('TolX',1e-10,'MaxFunEvals', 3500,'MaxIter',2500))
elapsed_time = etime(clock,t0) / 60;    % ��� �ð��� �д����� �����ش�.
fprintf('\n�ùķ��̼� ����ð��� %4.2f���Դϴ�.\n',elapsed_time);