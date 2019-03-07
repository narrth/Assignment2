%% ELEC 4700 Assignment-2 Finite Difference Method
% Due: Sunday, Feb. 24, 2019 11:59PM
% By: Narrthanan Seevananthan
clear;
clc;

%V = Vo @ x = 0, x = L
%V = 0 @ y = 0, y = W
L = 3;     %Length of the rectangular region
W = 2;
Vo = 1;     %Initial voltage

%mesh density and mesh points
%adjusting the mesh density changes the distance between the nodes,
%resulting in a chnage in the precision of the solution
%the mesh density also affects the number of points in the matrix making
%the simulation faster or slower
dx = 0.05;
dy = 0.05;

nx = L/dx;
ny = W/dy;

%Equations pulled from Griffiths “Intro to Electrodynamics 3e
%x2 beacaue there are two x and y differentials
VXY = -2*(1/(dx^2) + 1/(dy^2));
VX = 1/(dx^2);
VY = 1/(dy^2);

G = sparse(nx*ny,nx*ny);
B = zeros(nx*ny,1);

%chnaged the convention of i&j to x&y
%x = i
%y = j
for x = 1:nx
    for y = 1:ny
        n = y + (x-1)*ny;
        
        if x == 1 || x == nx
%             G(n,:) = Vo;
            G(n,n) = 1;
            B(n) = Vo;
            
        elseif y == 1 || y == ny
%             G(n,:) = 0;
            G(n,n) = 1;
            b(n) = 0;
            
        else
%changed the convention of nxm&nxp to nxp&nxn
            nxp = y + (x-2)*ny;      %previous x value
            nxn = y + x*ny;          %next x value
            nyp = y-1 + (x-1)*ny;    %previous y value
            nyn = y+1 + (x-1)*ny;    %next y value
            
            G(n,n) = VXY;
            G(n,nxp) = VX;
            G(n,nxn) = VX;
            G(n,nyp) = VY;
            G(n,nyn) = VY;
            
%values for fixed mesh grid            
%             G(n,n) = -4;
%             G(n,nxp) = 1;
%             G(n,nxn) = 1;
%             G(n,nyp) = 1;
%             G(n,nyn) = 1;
            
        end
        
    end
end


%having an error with the matrix left division because the vectors contain
%0s so must divide more carefully
%turns out error was from incorrect boundary contions (ny long band of 1s)
%resulting in an incorrect solution being generated 

%the second problem with the E matrix was you were multiplying the
%transpose not the inverse.... use inv() instead of "'"

V = G\B;
%E = inv(G)*B;


%because B is a vector after MLdivision "\" the solution(V) is a vector
%which must be reshaped to correctly plot
V_2 = reshape(V,[ny,nx]);
%E_2 = reshape(E,[ny,nx]);

%plots from part 1(a) (code has been changes does not work anymore)
figure('Name','Visualize sparsity pattern');
spy(G);




%plot from 1(b)
figure('Name','Surface plot of V(x, y)');
surf(V_2);
%surf(E_2)

%for part2 make a new matrix to hold the conductivity, the conductivity in
%the boxes should be very low making the voltage passing through them very
%resistive
%1/R = conuctivity, V = I*R

