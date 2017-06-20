function [ RD ] = remove_graphshorcuts( D, beta )
%REMOVESHORCUTGRAPH Summary of this function goes here
%   Detailed explanation goes here

RD = D;
nPr = size(D,1);

for i = 1 : nPr 
   % set of neighbors of i
   Ni = find(D(i,:)>0);
   for j = (i + 1) : nPr         
      if(D(i,j) > 0)
         Nj = find(D(:,j)>0);
         inter = intersect(Ni,Nj);
         uni = union(Ni,Nj);
         jac = length(inter) / length(uni);
         if (jac <= beta)
            RD(i,j) = 0;
            RD(j,i) = 0;
         end
      end      
   end
end


end

