function y=myExp(a,x,ln_a, tol)
%{
using the fact that a^x = e^(x*ln a)
and the n'th derivative is e^(x*ln a) * (ln a)^n
using x = 1 we get a*(ln a)^n 
assuming we already know ln(a) and we can calculate a^x with Taylor series

if x<0 and a>1 it's numerically better to calc 1/a^(-x) 
%}
if x < 0 && a > 1
    y = 1/myExp(a,-x,ln_a, tol);
    return
end
if tol >= 1
    tol = 1;
end
y=a;
lasty = a+2;
ii=1;
x = x - 1;
multiX = 1;
multiLn_a = 1;
while abs(lasty - y) > tol
    multiLn_a = multiLn_a *ln_a ;
    multiX = multiX * x;
    lasty = y;
    y = y + a * multiLn_a * multiX / factorial(ii);
    ii = ii+1;
end
end