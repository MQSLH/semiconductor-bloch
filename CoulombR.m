


function coulomb = CoulombR(mesh)

% R = sqrt(KX.^2+KY.^2);
% cellArea = mesh.cellAreaf(sqrt(KX.^2+KY.^2));
% dK = cellArea*cellAreaI;

er = 12.9;

        
    coulomb = zeros(mesh.nR);
    
    for ii=1:mesh.nR
        
        
        % reference point
        ri = mesh.r(ii);
        thetai = 0;
        % cartesian
        xi = ri;
        yi = 0;
        
        
        % disatnce matrix to all other points on the full mesh
        R = sqrt((xi-mesh.X).^2+mesh.Y.^2);
        
        % 1 by nR coulomb vector for rGrid 
        Vr = ((constantsA.q)^2/(2*constantsA.e_0*er*(2*pi)^2))*mesh.r.*sum(1./(R))*mesh.dPhi*mesh.dr;

        Vr(ii) = 0;
        coulomb(ii,:) = Vr;
        
    end

if max(max(coulomb))>1e6
    error();
end
% d1 = [0;diag(C,-1)];
% d2 = [diag(C,1);0];
% 
% C(diagonal) = mean([d1 d2],2);

end