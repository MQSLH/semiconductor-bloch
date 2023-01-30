
function mesh = Kgrid(rBohr,nR,nPhi)
%mesh = Kgrid(rBohr,nR,nPhi)
% Forms a radially symmetric 2-dimensional nonlinear mesh in k-space
% INPUT:
%   rBohr: max radius of k set to 5/rBohr
%   nR: number of mesh points in radial direction
%   NPhi: number of mesh points in angular direction
%
% OUTPUT:
%   mesh: structure with fields
%   r: radial mesh vector
%   phi: angle mesh vector
%   R, PHI meshgrid matrices in polar coordinates
%   X,Y: meshgrid matrices in cartesian coordinates


mesh.nR = nR;
mesh.nPhi = nPhi;
mesh.rBohr = rBohr;

kmax = 5/rBohr;
kmin = 1/(10*nR);
% linear = linspace(kmin,1,nR);
% mesh.r = exp(3*linear)-1;
% mesh.r = (mesh.r/max(mesh.r))*kmax;

mesh.r = linspace(kmin,kmax,nR);
mesh.phi = linspace(0,(1-1/(nPhi))*2*pi,nPhi);

mesh.dPhi = (2*pi)/nPhi;
mesh.dr = mesh.r(2)-mesh.r(1);

[mesh.R, mesh.PHI] = meshgrid(mesh.r,mesh.phi);


mesh.X = mesh.R.*cos(mesh.PHI);
mesh.Y = mesh.R.*sin(mesh.PHI);


%% cell area

kmax = 2*5/rBohr;
kmin = 1/(100*nR);
linear = linspace(kmin,1,2*nR);
r = exp(3*linear)-1;
r = (r/max(r))*kmax;

rtemp = [0 r r(end)+(r(end)-r(end-1))];


for ii = 2:2*nR+1
    
    mesh.cellArea(ii-1) = (1/2)*(rtemp(ii)^2-rtemp(ii-1)^2)*mesh.dPhi;

end

% figure(2)
% plot(r,cellArea)
mesh.cellAreaf = griddedInterpolant([0 r],[0 mesh.cellArea]);

end







