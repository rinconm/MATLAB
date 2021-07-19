function [compression_ratio] = cratio(original_image,C1,C2,C3)
%function [compression_ratio] = cratio(original_image,C1,C2,C3)
%
%    C1,C2,C3 are the 3 possible image planes (RGB or YCbCr)
%    if only C1 is present, then the original image is assumed to be
%         grayscale

if nargin == 2
    bits_original=8*size(original_image,1)*size(original_image,2);
elseif nargin == 4
    bits_original=8*prod(size(original_image));
else
    sprintf('%s','answer is incorrect due to improper inputs')
end
bits_compressed=0;
c=C1(:);
c=Q8bit(c);
symbols=unique(c);
prob=sum(c==symbols')/length(c);
dict=huffmandict(symbols,prob);
enco=huffmanenco(c,dict);
bits_compressed=bits_compressed+numel(de2bi(enco));
if nargin > 2
  c=C2(:);
  c=Q8bit(c);
  symbols=unique(c);
  prob=sum(c==symbols')/length(c);
  dict=huffmandict(symbols,prob);
  enco=huffmanenco(c,dict);
  bits_compressed=bits_compressed+numel(de2bi(enco));
  c=C3(:);
  c=Q8bit(c);
  symbols=unique(c);
  prob=sum(c==symbols')/length(c);
  dict=huffmandict(symbols,prob);
  enco=huffmanenco(c,dict);
  bits_compressed=bits_compressed+numel(de2bi(enco));
end
compression_ratio=bits_compressed/bits_original;

end

