function [ N,slope,c ] = scale_fts( M,varargin )
%scale matrix columns and return scaling values
if(isempty(varargin))
    a = -1; b=1; %map to [-1,1]
else
    a = varargin{1}; b=varargin{2};
end
maxi = max(M);
mini = min(M);

slope = (b-a)./(maxi-mini);
%in rare case maxi == mini
[x] = find(isinf(slope));
if(~isempty(x))
    slope(x) = 1;
end

c = b-slope.*maxi;
N = M.*repmat(slope,size(M,1),1) + repmat(c,size(M,1),1);
end

