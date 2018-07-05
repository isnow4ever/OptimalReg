function var = computeSurfaceVariance(dist)
%COMPUTESURFACEVARIANCE 此处显示有关此函数的摘要
%   此处显示详细说明
    var = 0.0;
    size_dist = size(dist,1);
	s = sum(dist);
    var = sum((dist(:,1)-s/size_dist).^2);
    var = var / size_dist;
end

