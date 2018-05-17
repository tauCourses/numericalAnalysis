function [yy] = myLS(x, y, xx, n)
    X = zeros(length(x), n);
    xt = x';
    multi = ones(length(x),1);
    for ii = 1:n+1
        X(:,ii) = multi;
        multi = multi .* xt;
    end
    
    coefficients = X\y';
    xxt = xx';
    multi = ones(length(xx),1);
    yy = zeros(length(xx),1);
    for ii = 1:n+1
        yy = yy + coefficients(ii)*multi;
        multi = multi .* xxt;
    end
end