function inner = estimateInnerPoint2(point,chull_points)
%ESTIMATEINNERPOINT 此处显示有关此函数的摘要
%   此处显示详细说明
    
    cen=mean(chull_points);
    ang=atan2(chull_points(:,1)-cen(1),chull_points(:,2)-cen(2)); %每个点到坐标中心极角
    chull_points=[chull_points,ang];
    chull_points=sortrows(chull_points,3);    %按极角排序
    k = boundary(double(chull_points(:,1:2)),1);
%     hold on;
%     plot(chull_points(k(:),1),chull_points(k(:),2),'r.');
%     plot(point(1),point(2),'g.');
    
    inner = inpolygon(point(1),point(2),chull_points(k(:),1),chull_points(k(:),2));
end

