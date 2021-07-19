close all
clear all
clc
% Simplified JPEG Compression
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter Image in Function
image='pears.png';
%cr=jpeg('saturn.png');
% Passed: AT3_1m4_01.tif , autumn.tif , blobs.png , circles.png ,
% moon.tif , office_5.jpg , pears.png , board.tif , peppers.png ,
% saturn.png
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [cr] = jpeg(image)
% JPEG: This function takes an image (grayscale or color), 
%       compresses it via the Standard JPEG Compression Method 
%       on the yCbCR domain or in the RGB domain, and displays
%       the results with a compression ratio
% Note: The Image Processing Toolbox Add-on is required. 
%       The image must be input in single quotes (ex: 'saturn.png')
%       This function assumes that the image contains RGB pixel 
%       data by default. 
%       Further compression can be achieved by tuning the
%       Quantization Table factor a: 
%           a>1 = greater compression  a<1 = less compression
%       When compressing in the RGB color space, the two 
%       downsampled planes may be chosen.
% Tested Image Types: uint8, logical
% 
% [cr] = jpeg(A)
% A: Matrix of pixel information. (Use A=imread('image'); before
%    using this function
% cr: Compression Ratio
%
Q=[16 11 10 16 24 40 51 61;     % Quantization Table (Q50)
   12 12 14 19 26 28 60 55;
   14 13 16 24 40 57 69 56;
   14 17 22 29 51 87 80 62;
   18 22 37 56 68 109 103 77;
   24 35 55 64 81 104 113 92;
   49 64 78 87 103 121 120 101;
   72 92 95 98 112 100 103 99;];
a=1;                            % Quantization Table factor
Q=a*Q;                          % Quantization Compression Matrix
A=imread(image);                % Read image from Graphics File
uic=isa(A,'uint8');             % 8-bit Unsigned Integer Check
if uic==0                       % If not 8-bit Unsigned Integer
   A=255*A./max(A,[],'all');    % Fix Range to [0,255]
   A=uint8(A);                  % Convert to 8-bit Unsigned Integer
end
dim=8*fix(size(A(:,:,1))/8);    % Find Divisible by 8 Dimensions
Ac=A(1:dim(1),1:dim(2),:);      % Crop Image to be Divisible by 8
el=numel(size(A));              % Colored Image Check Variable
% If Colored Image
if el==3                        % Colored Image Flag
    disp('Color Image Detected')% Prompt Color Domain Compression
    disp('Enter Desired Color Domain for Compression')
    disp('(YCbCr=1, RGB=2)')
    d=input('');                % Domain of Compression
    if d==1                     % yCbCr Compression (Default)
        B=rgb2ycbcr(Ac);        % Converts RGB Data to yCbCr Data
    elseif d==2                 % (RGB Compression)
        B=Ac;                   % Because RGB Data by Default
    else                        % Error if RGB or YCbCr not Chosen
        error('Only inputs of 1 or 2 are possible!')
    end
    fprintf('\n')               % Prompt Downsampling Factor
    disp('Enter Downsampling Factor. Affects only 2 planes.')
    disp('(1=None)')
    dsf=input('');
    if dsf<1                    % Error if dsf<1
        error('The downsampling factor cannot be less than 1!')
    elseif dsf>1&&dsf<min(dim)/2% If Downsampling is Desired
        if d==2                 % RGB Plane Selection for DS'ing
            fprintf('\n')       % Prompt Planes of Downsampling
            disp('Enter Desired Planes of Downsampling')
            disp('(r=Red, g=Green, b=Blue)')
            p1=input('Plane 1: ','s');
            p2=input('Plane 2: ','s');
            c=strcmp(p1,p2);    % Determine if Unique Inputs
            if c==1             % Process Input Data
                error('Cannot choose same planes to downsample!')
            end
            rg=(strcmp(p1,'r')||strcmp(p2,'r'))...
                &&(strcmp(p1,'g')||strcmp(p2,'g'));
            rb=(strcmp(p1,'r')||strcmp(p2,'r'))...
                &&(strcmp(p1,'b')||strcmp(p2,'b'));
            gb=(strcmp(p1,'b')||strcmp(p2,'b'))...
                &&(strcmp(p1,'g')||strcmp(p2,'g'));
            if rg==1                % Rearrange RGB to BRG in order
                temp=B(:,:,1);      % to downsample Red and Green 
                B(:,:,1)=B(:,:,2);  % planes
                B(:,:,2)=temp;
                pstr='Red and Green';
            elseif rb==1            % Rearrange RGB to GRB in order
                temp=B(:,:,1);      % to downsample Red and Blue
                B(:,:,1)=B(:,:,3);  % planes
                B(:,:,3)=temp;
                pstr='Red and Blue';
            elseif gb==1            % No Rearranging Required
                pstr='Green and Blue';
            else                    % Impossible Combination
                error('Only inputs of r, b, and g are possible!')
            end
        end
        B=double(B);                % Conv to Floating Point Data
        Y=B(:,:,1);                 % Luminance (Non-DS'd Plane)
        Ch=B(:,:,2:3);              % Cb and Cr (DS'd Planes)
        Chd=Ch(1:dsf:end,1:dsf:end,:);  % Downsample Planes
        sd=size(Chd);               % Dimension of DS'd Planes
        sdz=8*ceil(sd(:,:,1)/8);    % Dim after Zeropad
        Chdz=[Chd zeros(sd(1),sdz(2)-sd(2),2);  % Zeropad DS Planes
              zeros(sdz(1)-sd(1),sdz(2),2)];
    elseif dsf==1                   % No Downsampling Desired
        B=double(B);                % Copy Variables (No Convert)
        Y=B(:,:,1);
        sd=dim;
        sdz=dim;
        Chdz=B(:,:,2:3);
    else
        error(['The downsampling factor has to be smaller than '...
              'half of the lowest dimension of the image!'])
    end
    % Compression via Discrete Cosine Transform for Colored Images
    for i=1:8:dim(1)                    % Compress Non-DS'd Plane
        for k=1:8:dim(2)                % in Blocks of 8x8 Pixels
            T=Y(i:i+7,k:k+7)-127;       % Subtract 127 each Block
            F=dct2(T);                  % DCT
            F=Q.*round(F./Q);           % Quantize Each Block
            C1(i:i+7,k:k+7)=F;          % Save Frequency Block
        end
    end
    for i=1:8:sdz(1)                    % Compress DS'd Plane 1
        for k=1:8:sdz(2)                % in Blocks of 8x8 Pixels
            T=Chdz(i:i+7,k:k+7,1)-127;  % Subtract 127 each Block
            F=dct2(T);                  % DCT
            F=Q.*round(F./Q);           % Quantize Each Block
            C2(i:i+7,k:k+7)=F;          % Save Frequency Block
        end
    end
    for i=1:8:sdz(1)                    % Compress DS'd Plane 2
        for k=1:8:sdz(2)                % in Blocks of 8x8 Pixels
            T=Chdz(i:i+7,k:k+7,2)-127;  % Subtract 127 each Block
            F=dct2(T);                  % DCT
            F=Q.*round(F./Q);           % Quantize Each Block
            C3(i:i+7,k:k+7)=F;          % Save Frequency Block
        end
    end
    cr=cratio(A,C1,C2,C3);      % Determine Compression Ratio
    % Reconstruction via Inverse Discrete Cosine Transform for CIs
     for i=1:8:dim(1)            % Reconstruct Non-DS'd Plane from
        for k=1:8:dim(2)         % frequency Image
            R(i:i+7,k:k+7)=idct2(C1(i:i+7,k:k+7))+127;
        end
    end
    for i=1:8:sdz(1)            % Reconstruct DS'd Planes from
        for k=1:8:sdz(2)        % frequency Images
            R2z(i:i+7,k:k+7)=idct2(C2(i:i+7,k:k+7))+127;
            R3z(i:i+7,k:k+7)=idct2(C3(i:i+7,k:k+7))+127;
        end
    end
    if dsf~=1                   % If Downsampling Occured
        R2=R2z(1:sd(1),1:sd(2));% Remove Extraneous Zero Pixels
        R3=R3z(1:sd(1),1:sd(2));% from DS'd Planes
        O=ones(dsf,dsf);        % For Kronecker Tensor Product
        if dim(1)~=dsf*sd(1)||dim(2)~=dsf*sd(2) % Nonequal Dims
            temp=kron(R2,O);
            temp(:,:,2)=kron(R3,O);
            temp=temp(1:dim(1),1:dim(2),:);
            R(:,:,2)=temp(:,:,1);
            R(:,:,3)=temp(:,:,2);
        else                                    % Equal Dimensions
            R(:,:,2)=kron(R2,O);    % Upsample by Downsample Factor
            R(:,:,3)=kron(R3,O);    % the DS'd Planes 
        end
    else                        % If No Downsampling Occured
        R(:,:,2)=R2z;
        R(:,:,3)=R3z;
    end
    R=uint8(R);                 % Convert to unsigned 8-bit int
    if d==1                     % When yCbCr Compression
        D=ycbcr2rgb(R);         % Convert back to RGB data
        dstr='YCbCr';           % String for Statistics
    else                        % When RGB Compression
        D=R;                    % No Need for Conversion
        dstr='RGB';             % String for Statistics
        if dsf~=1
            if rg==1                % Rearrange BRG to RGB
                temp=D(:,:,1);
                D(:,:,1)=D(:,:,2);
                D(:,:,2)=temp;
            elseif rb==1            % Rearrange GRB to RGB
                temp=D(:,:,1);
                D(:,:,1)=D(:,:,3);
                D(:,:,3)=temp;
            end
        end
    end
    % Display Colored Image Exclusive Results
    fprintf('\n')
    disp('Color Image')
    disp(['Domain of Compression: ',dstr])
    if dsf~=1                       % If Downsampling Desired
        if d==1                     % DS'd Planes of YCbCr
            disp('Downsampled Planes: Chromanance Planes (Cb,Cr)')
        else                        % DS'd Planes of RGB
            disp(['Downsampled Planes: ',pstr])
        end                         % Show Downsampling factor
        disp(['Downsampling Factor: ',num2str(dsf)])
    end
% If Grayscale
else
    B=double(Ac);                   % Conv to Floating Point Data
    Y=B(:,:,1);                     % Luminance Plane
    % Compression via Discrete Cosine Transform for Grayscale
    for i=1:8:dim(1)                % Compress Luminance Plane
        for k=1:8:dim(2)            % in Blocks of 8x8 Pixels
            T=Y(i:i+7,k:k+7)-127;   % Subtract 127 each 8x8 Block
            F=dct2(T);              % Discrete Cosine Transform
            F=Q.*round(F./Q);       % Quantize Each Block
            C1(i:i+7,k:k+7)=F;      % Save Frequency Block
        end
    end
    % Reconstruction via Inverse Discrete Cosine Transform for GS
    for i=1:8:dim(1)             % Reconstruct Chromanance Plane
        for k=1:8:dim(2)         % from Frequency Image
            R(i:i+7,k:k+7)=idct2(C1(i:i+7,k:k+7))+127;
        end
    end
    cr=cratio(A,C1);            % Compression Ratio for Grayscale
    D=uint8(R);                 % Convert to unsigned 8-bit int
    % Display Grayscale Image Exclusive Results
    fprintf('\n')
    disp('Grayscale Image')
end
MB=8*prod(size(A))*10^-6;      % Original Size of Image in MBs
mb=cr*MB;                      % Compressed Size of Image in MBs
% Display Inclusive Results
disp(['Size of Orignal Image: ',num2str(MB),' MBs'])
disp(['Size of Compressed Image: ',num2str(mb),' MBs'])
disp(['Compression Ratio: ',num2str(cr*100),'% of Original Image'])
subplot(1,2,1), imshow(A,[])
title('Original Image')
subplot(1,2,2), imshow(D,[])
title('Compressed Image')
%end