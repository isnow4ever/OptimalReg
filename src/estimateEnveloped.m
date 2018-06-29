function [eveloped,dist] = estimateEnveloped(probability, cloud_model, cloud_data)
%ESTIMATEEVELOPED 此处显示有关此函数的摘要
%   此处显示详细说明
    datum_plane = [0.0 0.0 1.0 0.0];
    layers_num = 10;
    slicing_planes = createSlicingPlanes(datum_plane, cloud_model, layers_num);
    enveloped_count = 0;
    total_count = 0;
    dist = [];
    for i=1:layers_num
        [points_on_planes_m, points_on_planes_d] = estimatePointsBySlicing(slicing_planes(i), cloud_model, cloud_data, 1.0);
        pt_on_planes_m = zeros(size(points_on_planes_m,2),3);
        pt_on_planes_d = zeros(size(points_on_planes_d,2),3);
        for j=1:size(points_on_planes_m,2)
            enveloped_point = estimateInnerPoint(points_on_planes_m(j), points_on_planes_d);
            if enveloped_point == true
                enveloped_count = enveloped_count + 1;
            end
            pt_on_planes_m(j) = [points_on_planes_m(1),points_on_planes_m(2),0.0];
        end
        total_count = total_count + size(points_on_planes_m,2);

        for k=1:size(points_on_planes_d,2)
            pt_on_planes_d(k) = [points_on_planes_d(1),points_on_planes_d(2),0.0];
        end
        idx = knnsearch(pt_on_planes_d,pt_on_planes_m);
        dist = [dist sqrt((pt_on_planes_d(idx,1) - pt_on_planes_m(:,1)).^2 + (pt_on_planes_d(idx,2) - pt_on_planes_m(:,2)).^2 + (pt_on_planes_d(idx,3) - pt_on_planes_m(:,3)).^2)];
    end
    enveloped_rate = enveloped_count / total_count;
    if enveloped_rate < probability
        eveloped = true;
    else
        eveloped = false;
    end
end

