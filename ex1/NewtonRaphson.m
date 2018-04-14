function [zero, Niters]=NewtonRaphson(func, functag, tol, a, b)
%{
using Newton-Raphson method to find a root of func between a and b
starting position in the middle, except if we found a local minimum and then we start at a random position.

if the result is outside (a,b) we use bisection to cut the range to half.
%}
Niters = 0;
zero = (a+b)/2; 
last = b + tol;
while func(zero) ~=0 && abs(zero - last) > tol
    last = zero;
    Niters = Niters+1;
    if functag(zero) == 0 %if derivative is zero find a new start point:
        zero = a + (b-a)*rand(1,1); % start from another position
    else
        zero = zero - func(zero)/functag(zero);
    end

    %if zero is outside (a, b) run an bisection
    %iteration:
    if zero < a || zero >b 
        midPointValue = func((a+b)/2);
        if midPointValue == 0
            zero = midPointValue;
            return
        elseif midPointValue>0
            if func(a)>0
                a = (a+b)/2;
            else
                b = (a+b)/2;
            end
        else
            if func(a)>0
                b = (a+b)/2;
            else
                a = (a+b)/2;
            end    
        end
        zero = (a+b)/2;
        last = b + tol;
    end
end
end

