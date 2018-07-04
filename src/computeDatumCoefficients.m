function [datum_plane, datum_cloud] = computeDatumCoefficients(ptCloud)
%COMPUTEDATUMCOEFFICIENTS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    %����
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

