function [zero, Niters]=NewtonRaphson(func, functag, tol, a, b)
    Niters = 0;
    zero = a + (b-a)*rand(1,1); % start at random position inside (a,b)
    last = b + tol;
    while(func(zero) ~=0 && abs(zero - last) > tol)
        last = zero;
        Niters = Niters+1;
        if(functag(zero) == 0) %if derivative is zero find a new start point:
            zero = a + (b-a)*rand(1,1);
        else
            zero = zero - func(zero)/functag(zero);
        end
        
        %if zero is outside (a, b) run an bisection for on
        %iteration:
        if(zero < a || zero >b) 
            %fprintf('out!\n');
            midPointValue = func((a+b)/2);
            if (midPointValue>0)
                if(func(a)>0)
                    a = (a+b)/2;
                else
                    b = (a+b)/2;
                end
            else
                if(func(a)>0)
                    b = (a+b)/2;
                else
                    a = (a+b)/2;
                end    
            end
            zero = a + (b-a)*rand(1,1);   
            last = b + tol;
        end
    end
end

