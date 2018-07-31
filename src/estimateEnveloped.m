function [enveloped,dist,enveloped_rate] = estimateEnveloped(probability, cloud_model, cloud_data)
%ESTIMATEEVELOPED 此处显示有关此函数的摘要
%   此处显示详细说明
    roi = [-inf,inf;-inf,inf;-inf,inf];
    indices = findPointsInROI(cloud_model, roi);
    cloud_model = select(cloud_model,indices);
    indices = findPointsInROI(cloud_data, roi);
    cloud_data = select(cloud_data,indices);
%     pcshowpair(cloud_model,cloud_data);
    
    datum_plane = [0.0 0.0 1.0 0.0];
    layers_num = 5;
    slicing_planes = createSlicingPlanes(datum_plane, cloud_model, layers_num);
    enveloped_count = 0;
    total_count = 0;
    dist = [];
    for i=1:layers_num
        [points_on_planes_m, points_on_planes_d] = estimatePointsBySlicing(slicing_planes(i,:), cloud_model, cloud_data, 1.0);
        pt_on_planes_m = zeros(size(points_on_planes_m,1),3);
        pt_on_planes_d = zeros(size(points_on_planes_d,1),3);
        k = boundary(double(points_on_planes_d(:,1:2)),1);
        for j=1:size(points_on_planes_m,1)
            enveloped_point = estimateInnerPoint2(points_on_planes_m(j,:), points_on_planes_d, k);
            if enveloped_point == true
                enveloped_count = enveloped_count + 1;
            end
            pt_on_planes_m(j,:) = [points_on_planes_m(j,1),points_on_planes_m(j,2),0.0];
        end
        total_count = total_count + size(points_on_planes_m,1);

        for k=1:size(points_on_planes_d,1)
            pt_on_planes_d(k,:) = [points_on_planes_d(k,1),points_on_planes_d(k,2),0.0];
        end
        idx = knnsearch(pt_on_planes_d,pt_on_planes_m);
        if idx == 0
            d=[0];
        else
            x1 = pt_on_planes_d(idx,1);
            y1 = pt_on_planes_d(idx,2);
            z1 = pt_on_planes_d(idx,3);
            x2 = pt_on_planes_m(:,1);
            y2 = pt_on_planes_m(:,2);
            z2 = pt_on_planes_m(:,3);
            d = sqrt((x1-x2).^2+(y1-y2).^2+(z1-z2).^2);
        end
        dist = [dist; d];
    end
    enveloped_rate = enveloped_count / total_count;
    disp(enveloped_rate);
    if enveloped_rate < probability
        enveloped = false;
    else
        enveloped = true;
    end
end

