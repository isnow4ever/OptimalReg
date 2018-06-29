function inner = estimateInnerPoint(point,chull_points)
%ESTIMATEINNERPOINT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    double px py sx sy tx ty;
    double sum = 0.0;
    px = point(1);
    py = point(2);
    size_p = size(chull_points,2);
    n = size_p;
    m = 1:size_p;
    n = [size_p,1:size_p-1];
    for i = 1:size_p
        sx = chull_points(m(i),1);
        sy = chull_points(m(i),2);
        tx = chull_points(n(i),1);
        ty = chull_points(n(i),2);

        % �������ζ����غϻ��ڶ���εı���
        if (sx - px) * (px - tx) >= 0 && (sy - py) * (py - ty) >= 0 && (px - sx) * (ty - sy) == (py - sy) * (tx - sx)
            inner = true;
            return;
        end

        % �������ڶ������ߵļн�
        angle = atan2(sy - py, sx - px) - atan2(ty - py, tx - px);

        % ȷ���нǲ�����ȡֵ��Χ��-�� �� �У�
        if angle >= PI
            angle = angle - PI * 2;
        elseif angle <= -PI
            angle = angle + PI * 2;
        end

        sum = sum + angle;
    end

    if round(sum / PI) == 0
        inner = false;
    else
        inner = true;
    end
end

