function var = computeSurfaceVariance(dist)
%COMPUTESURFACEVARIANCE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    double var = 0.0;
    size_dist = size(dist,2);
	s = sum(dist);
    var = sum((dist(:)-s/size_dist).^2);
    var = var / size_dist;
end

