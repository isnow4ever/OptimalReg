function [datum_plane, datum_cloud] = computeDatumCoefficients(ptCloud)
%COMPUTEDATUMCOEFFICIENTS 此处显示有关此函数的摘要
%   此处显示详细说明
    %过滤
    roi = [-inf,inf;-inf,inf;-inf,10];
    indices = findPointsInROI(ptCloud, roi);
    ptCloud_roi = select(ptCloud,indices);
    
    maxDistance = 0.1;
%     referenceVector = [0,0,1];
%     maxAngularDistance = 5;
    [model,inlierIndices,outlierIndices] = pcfitplane(ptCloud_roi,maxDistance);
    datum_cloud = select(ptCloud_roi,inlierIndices);
    remainPtCloud = select(ptCloud_roi,outlierIndices);
    datum_plane = model.Parameters;
%     disp(datum_plane);
end

