function [yy] = HermiteInterp(x, y, ytag, xx)
    global hermiteShparCache;
     hermiteShparCache = containers.Map;
    temp = [1;1]*(1:length(x)); % for creation of dx
    hermiteIndexes = temp(:)';
    n = length(hermiteIndexes);
    yy = zeros(length(xx),1);
    multi = ones(length(xx),1);
    for ii=1:n
        yy = yy + HermiteShape(x, y, ytag, hermiteIndexes(1:ii)) * multi;
        multi = multi .* (xx-x(hermiteIndexes(ii)))'; 
    end
end