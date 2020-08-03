clear;
clc;

% 1 factor Vasicek�� ����� �����ϴ� �˰���
t0 = clock;           % ��� �ð��� ������� ���� �ð��� ����

load 'kbond19.mat' % yield data�� �ҷ���(���� z)
z=k1909/100;
%initial value-----------------------------------------------------------%

%ia = 0.1;
%irbar = 0.04;
%isigma = 0.02;
%iu = -0.3;
%korean bond
ia  = +0.004;
irbar   =  +0.021;
isigma = +0.018;
iu  = -0.156;

%us bond
%ia  = +0.201;
%irbar   =  +0.008;
%isigma = +0.023;
%iu  = -0.292;

%ia = 0.14;  %���ǵ� (�״��)
%irbar=0.04;   %������
%isigma = 0.03; %���ͷ��� ǥ������
%iu= -0.16;  % Market Price of Risk

%------------------------------------------------------------------------%
InitialParams = [(ia) (irbar) (isigma) iu]; %���⼭ log�� ���� ������ parameter ���� ����� ������ �ֱ� ����.

P=[ia irbar isigma iu]; 


[para,fval,exitflag] = fminsearch(@(P) kalman_filter_logl(P,z),InitialParams,optimset('TolX',1e-10,'MaxFunEvals', 3500,'MaxIter',2500));
%[para,fval,exitflag,grad,hessian] = fminunc(@(P) kalman_filter_logl(P,z),InitialParams,optimset('TolX',1e-10,'MaxFunEvals', 3500,'MaxIter',2500));

para=para';
hh=hessian1(@(para) kalman_filter_logl(para,z),para);
pt=diag(sqrt(inv(hh)));

Tstat=para./pt;

fprintf('\n a  = %+3.5f (%+3.5f) \n rbar   = %+3.5f (%+3.5f)\n sigma = %+3.5f (%+3.5f) \n u  = % +3.5f (%+3.5f) \n',...
                para(1), Tstat(1), para(2), Tstat(2), para(3), Tstat(3), para(4), Tstat(4)); %������ parameter���� t-��跮 ȭ��ǥ��

elapsed_time = etime(clock,t0) / 60;    % ��� �ð��� �д����� �����ش�.
fprintf('\n�ùķ��̼� ����ð��� %4.2f���Դϴ�.\n',elapsed_time);

T1 = table(para(1), Tstat(1));
T2 = table(para(2), Tstat(2));
T3 = table(para(3), Tstat(3));
T4 = table(para(4), Tstat(4));
table = vertcat(T1,T2,T3,T4);
