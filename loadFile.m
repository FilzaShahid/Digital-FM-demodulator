function y = loadFile(filename)
%  y = loadFile(filename)
%
% reads  complex samples from the rf_data.dat file 
%

fid = fopen(filename,'rb');
y = fread(fid,'uint8=>double');

y = y-127;
y = y(1:2:end) + 1i*y(2:2:end);