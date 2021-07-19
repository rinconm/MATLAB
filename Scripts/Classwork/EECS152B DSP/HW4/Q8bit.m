function [out]=Q8bit(in)
%
% takes the input and quantizes it to 8 bits
% out is double, but its entries are integers between 0-255

maxin=max(max(max(in)));
minin=min(min(min(in)));
out=fix(255*(in-minin)/(maxin-minin));



