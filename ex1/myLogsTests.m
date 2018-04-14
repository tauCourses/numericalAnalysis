functions = {@(a,x)myLog(a,x) @(a,x)myLog2(a,x)};
tests = [2 16; 2 2^20; 0.1 2^20; 12345 0.12456];
outputFiles = {'myLogRes.txt' 'myLogRes2.txt'};

for ii=1:length(functions)
    fprintf('function - %s\n', strrep(char(functions{ii}),'@(x)',''));
    results = zeros(length(tests));
    for jj=1:length(tests)
        results(jj) = functions{ii}(tests(jj,1),tests(jj,2));
    end
    fileID = fopen(outputFiles{ii},'w');
    for jj=1:length(tests)
        trueLogValue = log(tests(jj,2))/log(tests(jj,1));
        errorValue = real(log10(abs(results(jj)-trueLogValue)/trueLogValue));
        fprintf(fileID, 'log_%f(%f)\r\n',tests(jj,1),tests(jj,2));
        fprintf(fileID, 'computed log: %f\r\n',results(jj));
        fprintf(fileID, 'matlab result: %f\r\n',trueLogValue);
        fprintf(fileID, 'err: %f\r\n\r\n',errorValue);
    end
    fclose(fileID);
end
