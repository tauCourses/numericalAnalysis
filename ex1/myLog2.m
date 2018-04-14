function y=myLog2(a,x)
%{
The same as myLog but instead of using exp function using myExp
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
    b = a^(2^k); %it's just an integer power, a simple loop
end

%calc ln_b (works just for abs(b-1)<1)
b = b-1;
ln_b = b-b^2/2+b^3/3; %always use the first 3 elements
multi_b = b*b*b;
ii=4;
while abs(b^ii) > tol
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
[res, ] = NewtonRaphson(@(z)myExp(a,z,ln_a,tol)-x,...
                        @(z)myExp(a,z,ln_a,tol)*ln_a, ...
                        tol,lowerBound,upperBound); 
y = res;
end