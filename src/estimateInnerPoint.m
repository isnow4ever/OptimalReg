function inner = estimateInnerPoint(point,chull_points)
%ESTIMATEINNERPOINT 此处显示有关此函数的摘要
%   此处显示详细说明
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

        % 点与多边形顶点重合或在多边形的边上
        if (sx - px) * (px - tx) >= 0 && (sy - py) * (py - ty) >= 0 && (px - sx) * (ty - sy) == (py - sy) * (tx - sx)
            inner = true;
            return;
        end

        % 点与相邻顶点连线的夹角
        angle = atan2(sy - py, sx - px) - atan2(ty - py, tx - px);

        % 确保夹角不超出取值范围（-π 到 π）
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

