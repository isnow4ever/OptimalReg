function inner = estimateInnerPoint2(point,chull_points)
%ESTIMATEINNERPOINT 此处显示有关此函数的摘要
%   此处显示详细说明
    size_p = size(chull_points,2);
    
    cen=mean(chull_points);
    ang=atan2(chull_points(:,1)-cen(1),chull_points(:,2)-cen(2)); %每个点到坐标中心极角
    chull_points=[chull_points,ang];
    chull_points=sortrows(chull_points,3);    %按极角排序
    poly=chull_points(:,1:2);
%     hold on;
%     plot(poly(:,1),poly(:,2),'r.');
%     plot(point(1),point(2),'g.');
    
    inner = inpolygon(point(1),point(2),poly(:,1),poly(:,2));
    
%     size_p=size_p+1;                %连线方便，把第一个点添加到最后一个点后面
%     poly(size_p,:)=poly(1,:);
%     flag=0;
%     for j=2:size_p
%         x1=poly(j-1,1);         %多边形前后两个点
%         y1=poly(j-1,2);
%         x2=poly(j,1);
%         y2=poly(j,2);
% 
%         k=(y1-y2)/(x1-x2);      %多边形一条边直线
%         b=y1-k*x1;
%         x=point(1);               %过当前点直线和多边形交点
%         y=k*x+b;          
% 
%         if min([x1 x2])<=x && x<=max([x1 x2]) && min([y1 y2])<=y && y<=max([y1 y2]) && y>=point(2)
%                flag = flag + 1;
%         end
%     end
% 
%     if mod(flag,2)==0               %偶数则在外部
%         inner = false;
%     else                            %奇数则在内部
%         inner = true;        
%     end
end

