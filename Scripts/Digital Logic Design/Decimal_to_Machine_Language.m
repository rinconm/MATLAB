close all
clear all
clc
format
% Decimal to Machine Language Conversion
% This script takes decimal number(s) and converts
% to machine language to a multiple of four bits of
% the largest number in input
% Convert Decimal Number(s) to Machine Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:10
    % Ask for decimal
    n=input('Enter number of decimal values: ');
    for i=1:1:n
        fprintf('\n');
        d(i)=input(['Enter decimal number ' num2str(i) ': ']);
    end
    % Use dec2mach function
    dec2mach(d);
    fprintf('\n');
    clearvars -except i
end
% Test 
% 4669
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [binary,hex] = dec2mach(d)
% This function takes decimal number(s) and converts to machine
% language to a multiple of four bits of the largest magnitude 
% number in input

% Set minimum digits displayed to the lowest possible
% multiple of four for the entered decimal input
% Determine biggest number in input
m=max(abs(d));
% Determine if input(s) is(are) too large
if m>2^52
    error('An input value exceeds 2^52 4.503599627370496e+15)\n%s',...
           'maybe consider upgrading me? :)');
end
% Determine number of inputs
s=size(d,2);
% Check if the largest value is a negative
check(1)=-m==min(d);
% Set the bits shown accordingly to the largest input
% (either positive or negative)
if check(1)==1
    temp=dec2bin(-m);
    digits=size(temp,2);
else
    for i=1:1:52
        digits=i;
        temp=2^(i);
        check=ge(temp,m);
        if (check==1)
            temp=digits/4;
            check(2)=double(rem(temp,1)==0);
            if (check(2)~=1)
            else
                % Pad with zeros for positive binary values
                % that have a one on the msb
                check(3)=m-2^(digits-1)>=0;
                if (check(3)==1)
                    digits=digits+4;
                end
                break
            end
        end
    end
end
% Preallocate result variables for speed
binary=char(zeros(s,digits));
endr=digits+(digits/4-1);
result=char(zeros(s,endr));
% Solve for binary code of each decimal number and display 
% binary code with spaces
for i=1:s
    % Solve to a multiple of four bits
    if d(i)<0
        % Pad with ones for negative value input(s)
        % Solve to a multiple of four bits
        temp=dec2bin(d(i));
        temp=flip(temp);
        % Pad with ones
        st=size(temp,2);
        start=st+1;
        for j=start:1:digits
            temp(1,j)=string(1);
        end
        % Flip back to normal
        temp=flip(temp);
    else
        % Solve to a multiple of four bits of the largest value
        temp=dec2bin(d(i),digits);
    end
    % Store result in binary return variable
    binary(i,:)=temp;
    % Add a space after every fourth bit for Display Purposes
    % Determine how many multiples of four bits are in binary code
    halfbyte=size(binary,2)/4;
    % Determine number of rows to convert;
    rows=size(binary,2)/halfbyte;
    % Reshape into rowsxhalfbyte matrix
    temp=reshape(temp,rows,halfbyte);
    % Add a space row
    temp(rows+1,:)=' ';
    % Convert back to row matrix
    % Number of entries of converted matrix
    entries=numel(temp);
    temp=reshape(temp,1,entries);
    % Delete extraneous space
    temp(entries)='';
    result(i,:)=temp;
    % Solve for Hexadecimal value using binary result
    % Preallocate temp2 and hex result variable
    %hex=char(zeros(i,halfbyte));
    %temp2=zeros(s,digits);
    % Create a numeric array of the binary code
    for j=1:1:digits
        temp2(1,j)=str2double(binary(i,j));
    end
    % Solve for hexadecimal value
    hex(i,:)=binaryVectorToHex(temp2);
    % Display Result
    % Display Result
    fprintf('\n');
    str= ['Decimal Number: ',num2str(d(i))];
    str2=['2s Comp Binary: ',result(i,:)];
    str3=['2s Comp Hexdec: ',hex(i,:)];
    disp(str);
    disp(str2);
    disp(str3);
end
end