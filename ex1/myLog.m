function y=myLog(a,x)
%{
we are looking for y such that a^y=x => a^y-x = 0 => f(y)=a^y-x
we would like to use Newton-Raphson method that we already implemented.
but f'(y) = a^y*ln(a) so we need to find ln(a)
for 0<a<2 we can use ln(x+1) = x-x^2/2+x^3/3...
but a is not neccesserly between 0 and 2 so we use 
ln(x) = 2^-k * ln(x^(2^k)) => when k small enough x^(2^k) is close to 1

the function steps:
find a lower and upper bound.
find b and k such as ln(a) = 2^k * ln(b) and 0<b<2 using the above
find ln(a) and use it for running Newton-Raphson
%}
assert(a>0 && a~=1, 'a is illegal  value')
assert(x>0, 'x is illegal  value')

tol = 10^-9;
lowerBound = -1;
if(a < 1)
    lowerBound = 1;
end
upperBound = -lowerBound;

while a^lowerBound >= x %find lower bound
    lowerBound = lowerBound*2; 
end
while a^upperBound <= x % find upper bound:
    upperBound = upperBound*2;
end

%find b and k such as abs(b-1) < 1 and ln(a)=2^-k*ln(b)
b = a;
k = 0;
while abs(b-1) >= 1
    k = k-1;
    b = a^(2^k); %it's just an integer power - a simple loop
end

%calc ln_b (works just for abs(b-1)<1)
b = b-1;
ln_b = b-b^2/2+b^3/3; %always use the first 3 elements
multi_b = b*b*b;
ii=4;
while abs(b^ii) > tol || exp(ln_b)-b-1 > tol
    multi_b = multi_b*b;
    if mod(ii,2) == 0
        ln_b = ln_b - multi_b/ii;
    else
        ln_b = ln_b + multi_b/ii;
    end
    ii = ii+1;
end

%get the final results:
ln_a = 2^-k * ln_b;
[res, ] = NewtonRaphson(@(z)exp(z*ln_a)-x,...
                        @(z)exp(z*ln_a)*ln_a, ...
                        tol,lowerBound,upperBound);
y = res;
end
