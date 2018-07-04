function inner = estimateInnerPoint2(point,chull_points)
%ESTIMATEINNERPOINT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    size_p = size(chull_points,2);
    
    cen=mean(chull_points);
    ang=atan2(chull_points(:,1)-cen(1),chull_points(:,2)-cen(2)); %ÿ���㵽�������ļ���
    chull_points=[chull_points,ang];
    chull_points=sortrows(chull_points,3);    %����������
    poly=chull_points(:,1:2);
%     hold on;
%     plot(poly(:,1),poly(:,2),'r.');
%     plot(point(1),point(2),'g.');
    
    inner = inpolygon(point(1),point(2),poly(:,1),poly(:,2));
    
%     size_p=size_p+1;                %���߷��㣬�ѵ�һ������ӵ����һ�������
%     poly(size_p,:)=poly(1,:);
%     flag=0;
%     for j=2:size_p
%         x1=poly(j-1,1);         %�����ǰ��������
%         y1=poly(j-1,2);
%         x2=poly(j,1);
%         y2=poly(j,2);
% 
%         k=(y1-y2)/(x1-x2);      %�����һ����ֱ��
%         b=y1-k*x1;
%         x=point(1);               %����ǰ��ֱ�ߺͶ���ν���
%         y=k*x+b;          
% 
%         if min([x1 x2])<=x && x<=max([x1 x2]) && min([y1 y2])<=y && y<=max([y1 y2]) && y>=point(2)
%                flag = flag + 1;
%         end
%     end
% 
%     if mod(flag,2)==0               %ż�������ⲿ
%         inner = false;
%     else                            %���������ڲ�
%         inner = true;        
%     end
end

