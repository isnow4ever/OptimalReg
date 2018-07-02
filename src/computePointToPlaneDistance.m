function distance = computePointToPlaneDistance(cloud,plane)
%COMPUTEPOINTTOPLANEDISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
    mA = plane(1);
    mB = plane(2);
    mC = plane(3);
    mD = plane(4);
    n = size(cloud, 2);
    distance = zeros(n,1);
    for i = 1:n 
        mX = cloud(i,1);
        mY = cloud(i,2);
        mZ = cloud(i,3);
        if mA*mA + mB*mB + mC*mC ~= 0
            dt = abs(mA*mX + mB*mY + mC*mZ + mD) / sqrt(mA*mA + mB*mB + mC*mC);
            distance(i) = dt;
        end
    end  
end

