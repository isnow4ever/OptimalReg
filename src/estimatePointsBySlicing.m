function [points_on_plane_m,points_on_plane_d] = estimatePointsBySlicing(slicing_plane,cloud_model, cloud_data, epsilon)
%ESTIMATEPOINTSBYSLICING 此处显示有关此函数的摘要
%   此处显示详细说明
    points_on_plane_m = [];
    points_on_plane_d = [];
    model_dist = computePointToPlaneDistance(cloud_model, slicing_plane);
    data_dist = computePointToPlaneDistance(cloud_data, slicing_plane);

    % Create the filtering object
    size_m = cloud_model.Count;
    size_d = cloud_data.Count;
    for i = 1:size_m
        p = cloud_model.Location(i,:);
        if model_dist(i) < epsilon
            point = computeProjectPoint(p,slicing_plane);
            points_on_plane_m = [points_on_plane_m; point];
        end
    end
    for j = 1:size_d
        p = cloud_data.Location(j,:);
        if data_dist(j) < epsilon
            point = computeProjectPoint(p,slicing_plane);
            points_on_plane_d = [points_on_plane_d; point];
        end
    end
end

