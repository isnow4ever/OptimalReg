function var = computeSurfaceVariance(dist)
%COMPUTESURFACEVARIANCE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    var = 0.0;
    size_dist = size(dist,1);
	s = sum(dist);
    var = sum((dist(:,1)-s/size_dist).^2);
    var = var / size_dist;
end

