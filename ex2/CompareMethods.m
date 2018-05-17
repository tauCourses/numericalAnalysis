% the methods: myLS, HermiteInterp, LagrangeInterp, PWLinear
function [] = CompareMethods(func, func_dev, rnd)
    runs = 8;
    lagrangeErrors = zeros(1, runs);
    pwErrors = zeros(1, runs);
    hermiteErrors = zeros(1, runs);
    lsErrors = zeros(1, runs);
    for n = 1:runs
       x = sort(linspace(-1, 1, 2^n));
       y = func(x); 
       ytag = func_dev(x);
       if rnd
           y = y + 0.01*rand(1, length(y));
           ytag = ytag + 0.01*rand(1, length(ytag));
       end
                    
       xx = sort(linspace(min(x), max(x),1e4));
       true_yy = func(xx);
       
       yy = LagrangeInterp(x, y, xx);
       lagrangeErrors(n) = norm(yy' - true_yy);
       
       yy = PWLinear(x, y, xx);
       pwErrors(n) = norm(yy' - true_yy);
       
       yy = HermiteInterp(x, y, ytag, xx);
       hermiteErrors(n) = norm(yy' - true_yy);
       
       yy = myLS(x, y, xx, 50);
       lsErrors(n) = norm(yy' - true_yy);
    end

    
    figure
    semilogy(1:runs, lagrangeErrors, 'Color', 'red')
    hold on
    semilogy(1:runs, pwErrors, 'Color', 'green')
    semilogy(1:runs, hermiteErrors, 'Color', 'blue')
    semilogy(1:runs, lsErrors, 'Color', 'black') 
    
    t = sprintf('function - %s   |   rand - %s', strrep(char(func),'@(x)',''), mat2str(rnd));
    title(t)    

    legend('Lagrange', 'Piece-Wise Linear', 'Hermite', 'Least Squares')
    
end


