function h = hessian1(FUNC,x)
% Calculate hessian of FUNC
%
% Format: h = hess(FUNC,x)
% FUNC is scalar valued
% x is a vector
% g is a matrix


% Check if Fackler and Miranda's hessian is loaded (CompEcon toolbox)
if exist('fd_hess') == 2
    h = fdhes(FUNC,x);
else
    
MIN_DIFF    = 1e-6;

n           = length(x);
h           = zeros(n,n);
f           = feval(FUNC,x);

for i = 1:n
    xi      = x;
    dxi     = x(i)*1e-6;
    dxi     = max(dxi,MIN_DIFF);
    xi(i)   = xi(i) + dxi;
    fi      = feval(FUNC,xi);

    x2      = x;
    x2(i)   = x2(i) - dxi;
    f2      = feval(FUNC,x2);
    h(i,i)  = (fi + f2 - 2*f) / (dxi^2);

    for j = 1:i-1
        xj      = x;
        xij     = xi;
        dxj     = x(j)*1e-6;
        dxj     = max(dxj,MIN_DIFF);
        xj(j)   = xj(j) + dxj;
        xij(j)  = xij(j) + dxj;
        fj      = feval(FUNC,xj);
        fij     = feval(FUNC,xij);
        h(i,j)  = (fij - fj - fi + f) / (dxi*dxj);
        h(j,i)  = h(i,j);
    end
end

end