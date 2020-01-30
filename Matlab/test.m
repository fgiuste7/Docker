function output = test(input)
output = input;
fileID = fopen('/code/output.txt','w');
fprintf(fileID,'%s\n',output);
fclose(fileID);
% mcc -m test.m