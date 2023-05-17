clc, clear;
% Define the matrix
A = [5 7 9 5; 4 3 7 8; 7 5 6 11; 1 2 4 5];

[X] = mat_inv(A);                                                         %Function call to solve the eqaution AX = B using Gauss Elimination


function b = mat_inv(a)
% Find dimensions of input matrix
[r,c] = size(a);


% If input matrix is not square, stop function
if r ~= c
    disp('Only Square Matrices, please')
    b = [];
    return
end

% inverse matrix
b = eye(r);

for j = 1 : r
    for i = j : r
        if a(i,j) ~= 0
            for k = 1 : r
                s = a(j,k); a(j,k) = a(i,k); a(i,k) = s;
                s = b(j,k); b(j,k) = b(i,k); b(i,k) = s;
            end
            t = 1/a(j,j);
            for k = 1 : r
                a(j,k) = t * a(j,k);
                b(j,k) = t * b(j,k);
            end
            for L = 1 : r
                if L ~= j
                    t = -a(L,j);
                    for k = 1 : r
                        a(L,k) = a(L,k) + t * a(j,k);
                        b(L,k) = b(L,k) + t * b(j,k);
                    end
                end
            end           
        end
        break
    end
    % Display warning if a row full of zeros is found
    if a(i,j) == 0
        disp('Warning: Singular Matrix')
        b = 'error';
        return
    end
end
end