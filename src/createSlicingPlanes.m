function slicing_planes = createSlicingPlanes(datum_plane,cloud,number)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    %n = size(cloud, 2);
    %points_distance = zero(n);
    points_distance = computePointToPlaneDistance(cloud, datum_plane);
    double mA mB mC mD;
    mA = datum_plane(1);
    mB = datum_plane(2);
    mC = datum_plane(3);
    mD = datum_plane(4);

    step = (max(points_distance) / (number + 1)) * sqrt(mA*mA + mB*mB + mC*mC);
    slicing_planes = zeros(number,4);
    for i = 1:number
        plane = [mA, mB, mC, mD - i*step];
        slicing_planes(i) = plane;
    end
end

