function [yy] = HermiteShape(x, y, ytag, ser)
    global hermiteShparCache;

    if length(ser) == 1
        yy = y(ser);
        return
    elseif length(ser) == 2 && ser(1) == ser(2)
        yy = ytag(ser(1));
        return
    end
    
    key = char(ser);
    
    if isKey(hermiteShparCache,key)
        yy = hermiteShparCache(key);
        return;
    end
     
    yy = HermiteShape(x, y, ytag, ser(2:end)) - HermiteShape(x, y, ytag, ser(1:end-1));
    yy = yy / (x(ser(end)) - x(ser(1)));
    
    hermiteShparCache(key) = yy;
end