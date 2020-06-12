% 1 Factor Vasicek�� ����� Į�����͸� �̿��� �����ϴ� Code

function loglikelihood = kalman_filter_logl(para)

% para(1) : kappa
% para(2) : theta
% para(3) : sigma
% para(4) : lambda

load('yield.mat')       % yield data�� �ҷ���(���� z)
nobs = size(z,1);       % ����ġ ����(����Ÿ ����) �� 52��(1��)
N = size(z,2);          % ���� ����(3����,6����,9����,1��,1��6����,2��,2��6����,3��,5��,10��) ��10��
dt = 1/52;              % dalata t�� �ֺ� ����Ÿ�� ����ϱ� ������ 
logl = zeros(nobs,1);   % �쵵 �Լ� ���� �����ϱ� ���� ����

% Į�� ���͸����� ���� �ʱⰪ��                 
rt_1 = para(2);                 % ���� ������ �ʱⰪ�� ���º����� ������(para(2))�� �����Ѵ�.  
Pt_1 = para(3)^2 / (2*para(1)); % ���º����� �ʱ� unconditional variance�� ������ ���� ����



F = exp(-para(1)*dt);                                   % ���� �������� ����
C = para(2)*(1 - exp(-para(1)*dt));                     % ���� �������� ���
Q = (para(3)^2*(1-exp(-2*para(1)*dt))) / (2*para(1));   % ���� �������� ������ �л�
R = diag(var(z));                                       % ���� �������� ������ �л�(yield data�� �л갪�� �밢��ķ� ����)
tau = [0.25,0.5,0.75,1,1.5,2,2.5,3,5,10]';              % ä�Ǹ��� 10��
% ���� �������� ������ ������ A(tau), B(tau)�� ���ϱ�
A = zeros(N,1); B = zeros(N,1);
for j = 1 : N
     B(j) = (1-exp(-para(1)*tau(j))) / para(1);
     A(j) = (para(2)-(para(3)*para(4))/para(1) - para(3)^2/(2*para(1)^2))*(B(j)-tau(j)) ...
         - (para(3)^2*B(j)^2) / (4*para(1));
end
% ���� �������� ����� ���
A = -A./tau;   % ���
H = B./tau;   % ����
 
% ��� ������ ������ ������ ������
z_cond = zeros(nobs,N);
r_cond = zeros(nobs,1);
P_cond = zeros(nobs,1);
v = zeros(nobs,N);
r = zeros(nobs,1);
P = zeros(nobs,1);

% ����ġ ���� Į�� ���͸� �����ϴ� �κ�
for i = 1 : nobs
    zt = z(i,:)';
    % ������������ ����
    zt_1 = H * rt_1 + A;
    Ft = H*Pt_1*H' + R;
    % ������Ʈ ������
    vt = zt - zt_1;   % ������������ ������ �������� ����
    rt = rt_1 + Pt_1*H'*inv(Ft)*vt;
    Pt = Pt_1 - Pt_1*H'*inv(Ft)*H*Pt_1;
    % ���º����� ����
    rt_1 = F * rt + C;
    Pt_1 = F * Pt * F' + Q;
    % ��� �����ϱ�
    z_cond(i,:) = zt_1;
    v(i,:) = vt';
    r(i) = rt;
    r_cond(i) = rt_1;
    P(i) = Pt;
    P_cond(i) = Pt_1;
    % LogLikelihood�� ���
    detF = det(Ft);
    if detF <= 0
        detF = 1e-10;
    end
    logl(i) = -(N/2)*log(2*pi) - 0.5*log(detF) - 0.5*vt'*inv(Ft)*vt;
end
loglikelihood = -sum(logl);   
% �쵵 �Լ� ���� ���� �ִ�� �ϴ� ����� ã�°��� �����̹Ƿ� (-)�� �ٿ���
% fminsearch �Լ��� ����� �����Ϸ���