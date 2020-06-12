% OUP standard error 구하는거


load('OUP_se.mat')

for j = 71:100
t0 = clock;           % 계산 시간을 재기위해 시작 시간을 측정
    j
for i = 1: 10
    ff(i) = f*invF(:,i,j);
end

fff = ff*fp;

dfkk = diff(diff(fff,k),k);     % 카파 2번 미분
dfthth = diff(diff(fff,th),th); % 쎄타 2번 미분
dfss = diff(diff(fff,s),s);     % 시그마 2번 미분
dfll = diff(diff(fff,l),l);     % 람다 2번 미분
dfkth = diff(diff(fff,k),th);
dfks = diff(diff(fff,k),s);
dfkl = diff(diff(fff,k),l);
dfths = diff(diff(fff,th),s);
dfthl = diff(diff(fff,th),l);
dfsl = diff(diff(fff,s),l);


    m11(j) = subs(dfkk,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m12(j) = subs(dfkth,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m13(j) = subs(dfks,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m14(j) = subs(dfkl,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m22(j) = subs(dfthth,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m23(j) = subs(dfths,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m24(j) = subs(dfthl,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m33(j) = subs(dfss,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m34(j) = subs(dfsl,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});
    m44(j) = subs(dfll,{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,s,k,l,r,th},{z(j,1),z(j,2),z(j,3),z(j,4),z(j,5),z(j,6),z(j,7),z(j,8),z(j,9),z(j,10),para(3),para(1),para(4),sr(j),para(2)});


m(1,j)=m11(j);
m(2,j)=m12(j);
m(3,j)=m13(j);
m(4,j)=m14(j);
m(5,j)=m22(j);
m(6,j)=m23(j);
m(7,j)=m24(j);
m(8,j)=m33(j);
m(9,j)=m34(j);
m(10,j)=m44(j);

elapsed_time = etime(clock,t0) / 60;    % 계산 시간을 분단위로 구해준다.
fprintf('\n시뮬레이션 경과시간은 %4.2f분입니다.\n',elapsed_time);
end
I=zeros(4,4);
I(1,1) = sum(m(1,:));
I(1,2) = sum(m(2,:));
I(2,1) = I(1,2);
I(1,3) = sum(m(3,:));
I(3,1) = I(1,3);
I(1,4) = sum(m(4,:));
I(4,1) = I(1,4);
I(2,2) = sum(m(5,:));
I(3,2) = sum(m(6,:));
I(2,3) = I(3,2);
I(4,2) = sum(m(7,:));
I(2,4) = I(4,2);
I(3,3) = sum(m(8,:));
I(4,3) = sum(m(9,:));
I(3,4) = I(4,3);
I(4,4) = sum(m(10,:));
%AsymVar=inv(-I)
