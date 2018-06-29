function datum_plane = computeDatumCoefficients(cloud)
%COMPUTEDATUMCOEFFICIENTS 此处显示有关此函数的摘要
%   此处显示详细说明
    %过滤
    number = size(cloud,2); % 总点数
    idx = [];
    for m=1:number
        if cloud(m,3)<10
            idx = [idx m];
        end
    end
    data = cloud(idx,:);
    iter = 1000;
    number = size(data,2); % 总点数
    %bestParameter1=0; bestParameter2=0; bestParameter3=0; % 最佳匹配的参数
    sigma = 1;
    pretotal=0;     %符合拟合模型的数据的个数
    
    for i=1:iter
        %%% 随机选择三个点
        idx = randperm(number,3); 
        sample = data(:,idx); 

        %%%拟合直线方程 z=ax+by+c
        %plane = zeros(1,3);
        x = sample(:, 1);
        y = sample(:, 2);
        z = sample(:, 3);

        a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
        b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
        c = z(1) - a * x(1) - b * y(1);
        plane = [a b -1 c];

        mask=abs(plane*[data; ones(1,size(data,2))]);    %求每个数据到拟合平面的距离
        total=sum(mask<sigma);              %计算数据距离平面小于一定阈值的数据的个数

        if total>pretotal            %找到符合拟合平面数据最多的拟合平面
            pretotal=total;
            datum_plane=plane;          %找到最好的拟合平面
        end  
    end
end

