function [yy] = HermiteShape(x, y, ytag, ser)
    persistent cache;
    if isempty(cache)
        cache = containers.Map;
    end
    
    key = ser(1)*65536 + ser(end);
    
    if isKey(cache,ser)
        yy = cache(ser);
        return;
    end
    
    if length(ser) == 1
        yy = y(ser);
    elseif length(ser) == 2 && ser(1) == ser(2)
        yy = ytag(ser(1));    
    else
        yy = HermiteShape(x, y, ytag, ser(2:end)) - HermiteShape(x, y, ytag, ser(1:end-1));
        yy = yy / (x(ser(end)) - x(ser(1)));
    end
    cache(ser) = yy;
end