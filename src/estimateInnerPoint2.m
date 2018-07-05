function inner = estimateInnerPoint2(point,chull_points)
%ESTIMATEINNERPOINT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    
    cen=mean(chull_points);
    ang=atan2(chull_points(:,1)-cen(1),chull_points(:,2)-cen(2)); %ÿ���㵽�������ļ���
    chull_points=[chull_points,ang];
    chull_points=sortrows(chull_points,3);    %����������
    k = boundary(double(chull_points(:,1:2)),1);
%     hold on;
%     plot(chull_points(k(:),1),chull_points(k(:),2),'r.');
%     plot(point(1),point(2),'g.');
    
    inner = inpolygon(point(1),point(2),chull_points(k(:),1),chull_points(k(:),2));
end

