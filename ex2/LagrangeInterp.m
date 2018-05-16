function [yy]=LagrangeInterp(x, y, xx)
    n=length(x);
    ls=ones(length(xx), n); % contain all the l values
    
    for ii=1:n
      for jj=1:n
         if (ii~=jj)
            ls(:, ii) = ls(:, ii) .* (xx - x(jj))' / (x(ii) - x(jj));
         end
      end
    end
    
    yy = zeros(length(xx),1);
    for ii=1:n
        yy = yy + y(ii) * ls(:,ii);
    end
    
end