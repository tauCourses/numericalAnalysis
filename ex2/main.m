
%profile on

functions = {@(x)x
            @(x) x.^8 + 6*(x.^3) 
            @(x) tanh(9*x) + (x * 0.5)
            @(x) sin(20*x).*(1+x)
            @(x) abs(x)
            @(x) 1 ./ (1 + (16*(x.^2)))};
        
derivatives = { @(x) 1 + x - x
                @(x) 8 * (x.^7) + 18 * (x.^2)
                @(x) (sech(9*x).^2)*9 + 0.5
                @(x) cos(20*x)*20.*(x+1) + sin(20*x)
                @(x) (x>=0)*2-1
                @(x) -((1 ./ (1 + (16*(x.^2)))).^2)*32.*x};
            
for ii=1:length(functions)
    fprintf('function - %s\n', strrep(char(functions{ii}),'@(x)',''));
    CompareMethods(functions{ii}, derivatives{ii}, false)
    CompareMethods(functions{ii}, derivatives{ii}, true)
end

%profile viewer