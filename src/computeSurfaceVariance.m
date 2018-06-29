function var = computeSurfaceVariance(dist)
%COMPUTESURFACEVARIANCE 此处显示有关此函数的摘要
%   此处显示详细说明
    double var = 0.0;
    size_dist = size(dist,2);
	s = sum(dist);
    var = sum((dist(:)-s/size_dist).^2);
    var = var / size_dist;
end

