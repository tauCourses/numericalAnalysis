function y=myExp(a,x,ln_a, tol)
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