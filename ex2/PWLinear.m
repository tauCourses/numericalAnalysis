function [yy]=PWLinear(x, y, xx)
    ii = 1;
    ix = 1;
    yy = zeros(length(xx),1);
    while(ii<=length(xx))
        if(xx(ii) <= x(ix))
            yy(ii) = y(ix);
            ii = ii + 1;
        else
            break
        end
    end
    while(ii<=length(xx))
        if xx(ii) > x(ix+1)
            if  ix + 1 == length(x)
                ix = ix + 1;
                break
            else
                ix = ix + 1;
            end
        else
            yy(ii) = y(ix) + (y(ix+1) - y(ix))*(xx(ii)-x(ix)) / (x(ix+1) - x(ix)); 
            ii = ii + 1;
        end
    end
    while(ii<=length(xx))
        yy(ii) = y(ix);
        ii = ii + 1;
    end
end