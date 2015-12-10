function [b2] = makePosDef(M)
    [m,n] = size(M);
    MPos = M;
    V1 = V(:,1);
    b2 = b + V1*V1'*(eps(D(1,1))-D(1,1))
%     for i=1:m
%         if (MPos(i,i)<0)
%             MPos(i,i) = -MPos(i,i);
%         end
%     end
end