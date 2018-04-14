function y=myLog(a,x) %assuming a > 0, a != 1, x>12
assert(a>0 && a~=1, 'a is illegal  value')
assert(x>0, 'x is illegal  value')

tol = 10^-10;
lowerBound = -1;
if(a < 1)
    lowerBound = 1;
end
upperBound = -lowerBound;

while a^lowerBound > x %find lower bound
    lowerBound = lowerBound*2; 
end
while a^upperBound < x % find upper bound:
    upperBound = upperBound*2;
end

%find b and k such as abs(b-1) < 1 and ln(a)=2^-k*ln(b)
b = a;
k = -1;
while(abs(b-1) >= 1)
    k = k*2;
    b = a^(2^k);
end
b = b-1;

%calc logb (works just for abs(b)<1)
logb = b-b/2+b^2/3-b^3/4;
ii=4;
while abs(b^ii) > tol
    if mod(ii,2) == 0
        logb = logb + b^ii/(ii+1);
    else
        logb = logb - b^ii/(ii+1);
    end
    ii = ii+1;
end

%get the final results:
loga = 2^-k * logb;
[res, ] = NewtonRaphson(@(z)a^z-x,@(z)a^z*loga,tol,lowerBound,upperBound);
y = res;
end
