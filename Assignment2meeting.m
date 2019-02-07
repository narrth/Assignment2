%ELEC 4700 Assignment-2 Finite Difference Method
%Due: Sunday, Feb. 24, 2019 11:59PM
clear;

%V = Vo @ x = 0
%V = 0 @ x = L
L = 20;     %Length of the rectangular region
W = 20;
Vo = 1;     %Initial voltage

G = sparse(W,L);
B = zeros(1,W);


for x = 1:L
    for y = 1:W
        n = y + (x-1)*W;
        
        if x = 1 || x = L
            G(n,:) = Vo;
            B(n) = 1;
            
        elseif y = 1 || y = W
            G(n,:) = 0;
            
        else
            nxp = x-1;  %previous x value
            nxn = x+1;  %next x value
            nyp = ;
            nyn = ;
            
            G(1,nxp) = 1;
            G(1,x) = -2;
            G(1,nxn) = 1;
        end
        nxp = x-1;  %previous x value
        nxn = x+1;  %next x value
    end
end

figure('Name','Visualize sparsity pattern');
spy(V)

surf(V)
