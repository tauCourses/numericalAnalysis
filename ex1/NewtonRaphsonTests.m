functions = {@(x)x^3 @(x)x^10 @(x)tanh(9*x)+x/2};
derivative = {@(x)3*x^2 @(x)10*x^9 @(x)(1-tanh(9*x)^2)*9+1/2};
lowerBound = [-100 -10 -1];
upperBound = [10 10 1];

colorVec = hsv(length(functions));

tolerances = arrayfun(@(x)10^(-x), 2:9);

for ii=1:length(functions)
    fprintf('function - %s\n', strrep(char(functions{ii}),'@(x)',''));
    iterations = zeros(1, length(tolerances));
    for jj=1:length(tolerances)
        [zero, niters] = NewtonRaphson(functions{ii}, ...
                                            derivative{ii}, ...
                                            tolerances(jj), ...
                                            lowerBound(ii), ...
                                            upperBound(ii));                                   
        iterations(jj) = niters;
    end
    plot(2:9, iterations, 'Color',colorVec(ii,:),...
        'DisplayName', func2str(functions{ii}));
    legendInfo{ii} = ['Y= ' strrep(char(functions{ii}),'@(x)','')];
    hold on
end
legend(legendInfo,'Location','North')
