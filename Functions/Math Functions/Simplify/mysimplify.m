function result = mysimplify(f)
% This function simplifies a function in several ways
% and outputs several variants if they exist
syms x
result(1)=simplify(f);
result(2)=simplify(f,'Steps',50);
% Check if results are equivalent
equ=isequal(result(1),result(2));

% Display one result or several depending on if they're equal
fprintf('\n');
disp('The equation');
pretty(f)
disp('simplifies to');
fprintf('\n');
if (equ==1)
    pretty(result(1))
    % Simplify without analytic constraints
    result(2)=simplify(f, 'IgnoreAnalyticConstraints', true);
    % Check if results are equivalent
    equ=isequal(result(1),result(2));
    if (equ==1)
        result(2)=[];
        % Simplify assuming x is real
        assume(x,'real');
        result(2)=simplify(f);
        % Check if results are equivalent
        equ=isequal(result(1),result(2));
        if (equ==1)
            result(2)=[];
            % Convert result matrix into column matrix
            result=result.';
            % Ask for further results
            more=input('Enter y if you would like to see more results: ', 's');
            fprintf('\n');
            if strcmp(more, 'y')
                % Find alternate forms of function
                extra=simplify(result(1),'Steps',25,'All',true);
                % Creating display for loop arguments
                sr=size(result,1);
                st=size(extra,1);
                start=sr+1;
                s=sr+st;
                % Concatenate results
                result=[result;extra];
                n=1;
                for i=start:1:s
                    fprintf('\n');
                    disp(['Equation ' num2str(i) ': ']);
                    pretty(result(i))
                    n=n+1;
                end
            end
        else
            disp('Assuming x is real:');
            fprintf('\n');
            pretty(result(2))
            % Convert result matrix into column matrix
            result=result.';
            % Ask for further results
            more=input('Enter y if you would like to see more results: ', 's');
            fprintf('\n');
            if strcmp(more, 'y')
                % Find alternate forms of function
                extra=simplify(result(2),'Steps',25,'All',true);
                % Creating display for loop arguments
                sr=size(result,1);
                st=size(extra,1);
                start=sr+1;
                s=sr+st;
                % Concatenate results
                result=[result;extra];
                n=1;
                for i=start:1:s
                    fprintf('\n');
                    disp(['Equation ' num2str(i) ': ']);
                    pretty(result(i))
                    n=n+1;
                end
            end
        end
    else
        disp('Ignoring Analytic Constraints:');
        fprintf('\n');
        pretty(result(2))
        % Simplify assuming x is real
        assume(x,'real');
        result(3)=simplify(f);
        % Check if results are equivalent
        equ=isequal(result(1),result(3));
        if (equ==1)
            result(3)=[];
        else
            disp('Assuming x is real:');
            fprintf('\n');
            pretty(result(3))
        end
        % Convert result matrix into column matrix
        result=result.';
        % Ask for further results
        more=input('Enter y if you would like to see more results: ', 's');
        fprintf('\n');
        if strcmp(more, 'y')
            % Find alternate forms of function
            extra=simplify(result(2),'Steps',25,'All',true);
            % Creating display for loop arguments
            sr=size(result,1);
            st=size(extra,1);
            start=sr+1;
            s=sr+st;
            % Concatenate results
            result=[result;extra];
            n=1;
            for i=start:1:s
                fprintf('\n');
                disp(['Equation ' num2str(i) ': ']);
                pretty(result(i))
                n=n+1;
            end
        end
    end
else
    pretty(result(1))
    disp('or');
    fprintf('\n');
    pretty(result(2))
    % Simplify without analytic constraints
    result(3)=simplify(f, 'IgnoreAnalyticConstraints', true);
    % Check if results are equivalent
    equ=isequal(result(1),result(3));
    if (equ==1)
        result(3)=[];
        % Simplify assuming x is real
        assume(x,'real');
        result(3)=simplify(f);
        % Check if results are equivalent
        equ=isequal(result(1),result(3));
        if (equ==1)
            result(3)=[];
        else
            disp('Assuming x is real:');
            fprintf('\n');
            pretty(result(3))
        end
    else
        disp('Ignoring Analytic Constraints:');
        fprintf('\n');
        pretty(result(3))
        % Simplify assuming x is real
        assume(x,'real');
        result(4)=simplify(f);
        % Check if results are equivalent
        equ=isequal(result(1),result(4));
        if (equ==1)
            result(4)=[];
        else
            disp('Assuming x is real:');
            fprintf('\n');
            pretty(result(4))
        end
    end
    % Convert result matrix into column matrix
    result=result.';
    % Ask for further results
    more=input('Enter y if you would like to see more results: ', 's');
    fprintf('\n');
    if strcmp(more, 'y')
        % Find alternate forms of function
        extra=simplify(result(2),'Steps',25,'All',true);
        % Creating display for loop arguments
        sr=size(result,1);
        st=size(extra,1);
        start=sr+1;
        s=sr+st;
        % Concatenate results
        result=[result;extra];
        n=1;
        for i=start:1:s
            disp(['Equation ' num2str(i) ': ']);
            fprintf('\n');
            pretty(result(i))
            n=n+1;
        end
    end
end
end