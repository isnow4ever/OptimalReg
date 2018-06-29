function datum_plane = computeDatumCoefficients(cloud)
%COMPUTEDATUMCOEFFICIENTS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    %����
    number = size(cloud,2); % �ܵ���
    idx = [];
    for m=1:number
        if cloud(m,3)<10
            idx = [idx m];
        end
    end
    data = cloud(idx,:);
    iter = 1000;
    number = size(data,2); % �ܵ���
    %bestParameter1=0; bestParameter2=0; bestParameter3=0; % ���ƥ��Ĳ���
    sigma = 1;
    pretotal=0;     %�������ģ�͵����ݵĸ���
    
    for i=1:iter
        %%% ���ѡ��������
        idx = randperm(number,3); 
        sample = data(:,idx); 

        %%%���ֱ�߷��� z=ax+by+c
        %plane = zeros(1,3);
        x = sample(:, 1);
        y = sample(:, 2);
        z = sample(:, 3);

        a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
        b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
        c = z(1) - a * x(1) - b * y(1);
        plane = [a b -1 c];

        mask=abs(plane*[data; ones(1,size(data,2))]);    %��ÿ�����ݵ����ƽ��ľ���
        total=sum(mask<sigma);              %�������ݾ���ƽ��С��һ����ֵ�����ݵĸ���

        if total>pretotal            %�ҵ��������ƽ�������������ƽ��
            pretotal=total;
            datum_plane=plane;          %�ҵ���õ����ƽ��
        end  
    end
end

