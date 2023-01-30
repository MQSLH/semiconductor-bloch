function [C, R] = Coulombf(KX,KY,mesh,cellAreaI)

R = sqrt(KX.^2+KY.^2);
cellArea = mesh.cellAreaf(sqrt(KX.^2+KY.^2));
dK = cellArea*cellAreaI;

er = 12.9;


% C(~diagonal) = ((constantsA.q)^2/(2*constantsA.e_0*er*(2*pi)^2)) * (1./abs(KX(~diagonal)+1i*KY(~diagonal)));


C = ((constantsA.q)^2/(2*constantsA.e_0*er*(2*pi)^2)).*(1./R).*dK;
C(isnan(C)) = 0;
% [I, J] = find(R<1e-10);
% 
% for ii = 1:length(I)
% 
% if I(ii) == 1
%     C(I(ii),J(ii)) = C(I(ii)+1,J(ii));
% elseif I(ii) == size(KX,2)
% 
%     C(I(ii),J(ii)) = C(I(ii)-1,J(ii));
% else
%     C(I(ii),J(ii)) = mean([C(I(ii)+1,J(ii)) C(I(ii)-1,J(ii))]);
% end
% 
% end


if max(max(C))>1e6
    1
end
% d1 = [0;diag(C,-1)];
% d2 = [diag(C,1);0];
% 
% C(diagonal) = mean([d1 d2],2);

end