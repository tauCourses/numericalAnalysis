%{
creates the graph for the function mentioned in the exercise,
we should expect for straight lines on a log x graph

I changed the ranges a bit, because in two of the three functions
the root was right in the middle and found in the first iteration.
%}
functions = {@(x)x^3 @(x)x^10 @(x)tanh(9*x)+x/2};
derivative = {@(x)3*x^2 @(x)10*x^9 @(x)(1-tanh(9*x)^2)*9+1/2};
lowerBound = [-100 -10 -2]; %changed from exercise!
upperBound = [10 15 1]; %changed from exercise!

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
    semilogx(tolerances, iterations, 'Color',colorVec(ii,:),...
        'DisplayName', func2str(functions{ii}));
    legendInfo{ii} = ['Y= ' strrep(char(functions{ii}),'@(x)','')];
    hold on
end
legend(legendInfo,'Location','North')
set(gca, 'XDir','reverse')