function [z] = LSVM(T,d)
% LSVM: Classify d-dimensional feature vectors (training data) into
%       two possible classes {+1,-1}, compute the coefficients of
%       the linear classifier, plot the training data with its
%       classifier line (if 2D or 3D data set) and determine slack 
%       variables when desired using the MATLAB function quadprog.
% Note: Optimization Toolbox required. This function assumes that
%       the training data comes with y (class). With the solution 
%       z, a binary classifier can be made to classify new data:
%           f(x)=sign(w'x+b)
%
% [z] = LSVM(T,d)
% T: Training data
% d: Emphasis on slack variables (d=0 for no slack variables)
% z: Solution for the linear classifier coefficients and slack
%    variables when desired. z = [w b e]' , where w is a vector
%    (length(x)) and e is a vector (lenth(T))
%
if nargin < 2                   % If input arguments < 2
    d=0;                        % Fix d to 0 (no slack)
end
% Feature Extraction
S=size(T);                      % Dimension of Training Data
s1=length(find(T(:,end)==1));   % Number of elements in Class 1
s2=S(1)-s1;                     % Number of elements in Class 2
% Separate Training Data into Two Classes
class1=zeros(s1,S(2)-1);        % Preallocate variables for
class2=zeros(s2,S(2)-1);        % speed
c1=0; c2=0;                     % For loop Counter Variables 
for i=1:S(1)
    if T(i,end)==1              % In Class1 if y=+1
        c1=c1+1;
        class1(c1,:)=T(i,1:end-1);
    else                        % In Class2 if y=-1
        c2=c2+1;
        class2(c2,:)=T(i,1:end-1);
    end
end
% Solve for Solution using Quadratic Progamming
%  min 0.5*z'*H*z + f'*z   subject to:  At*z <= c 
%   z
if d==0                         % If No Slack Variables Desired
    H=[eye(S(2)-1) zeros(S(2)-1,1);
       zeros(1,S(2)-1) 0];
    f=zeros(S(2),1);
    c=-ones(S(1),1);
    At=[-class1 -ones(s1,1);
         class2  ones(s2,1)];
else                            % Including Slack Variables
    H=[eye(S(2)-1) zeros(S(2)-1,1+S(1));
       zeros(1+S(1),S(2)-1) zeros(1+S(1),1+S(1))];
    f=d*[zeros(S(2),1);
         ones(S(1),1)];
    c=[-ones(S(1),1);
        zeros(S(1),1)];
    At=[-class1 -ones(s1,1);
         class2  ones(s2,1)];
    At=[At -eye(S(1));
        zeros(S(1),S(2)) -eye(S(1))];
end
z=quadprog(H,f,At,c);           % Quadratic Programming Function
% Display Results
if S(2)==3                      % 2-D Classifier Line
    xs=min(floor(T(:,1)));              % Start and end x coord
    xe=max(ceil(T(:,1)));               % of Classifier Line
    x1=[xs xe];                         % x coord of CL
    x2=(-z(1)/z(2))*x1+(-z(3)/z(2));    % y coord of CL
    plot(class1(:,1),class1(:,2),'bo')  % Class 1 in blue
    grid on
    hold
    plot(class2(:,1),class2(:,2),'ro')  % Class 2 in red
    axis('square')
    plot(x1,x2,'-k')                    % Plot Classifier Line
    title(['LSVM with d = ' num2str(d)])
    legend('Class 1(y = +1)','Class 2(y = -1)', 'Classifier Line')
elseif S(2)==4                  % 3-D Classifier Plane
    x1s=min(floor(T(:,1)));             % Start and end x coord
    x1e=max(ceil(T(:,1)));              % of Classifier Plane
    x2s=min(floor(T(:,1)));             % Start and end y coord
    x2e=max(ceil(T(:,1)));              % of Classifier Plane
    x1=[x1s:.1:x1e];                    % x coord of CP
    x2=[x2s:.1:x2e];                    % y coord of CP
    sy=length(x1);                      % To preallocate for
    sy(2)=length(x2);                   % speed
    x3=zeros(sy(1),sy(2));              % Preallocate z for speed
    for k=1:sy(1)                       % z' of Classifier Plane
     for n=1:sy(2)
      x3(k,n)=(-z(1)/z(3))*x1(k)+(-z(2)/z(3))*x2(n)+(-z(4)/z(3));
     end
    end                                 % Class1=blue Class2=red
    scatter3(class1(:,1),class1(:,2),class1(:,3),'bo')
    hold
    scatter3(class2(:,1),class2(:,2),class2(:,3),'ro')
    surf(x1,x2,x3')                     % Plot Classifier Plane
    title(['LSVM with d = ' num2str(d)])
    legend('Class 1(y = +1)','Class 2(y = -1)', 'Classifier Plane')
else                            % Hyperplane Classifier
    fprintf('\n')
    disp('The Linear Classifier is a hyperplane')
end
end