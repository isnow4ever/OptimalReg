function point = computeProjectPoint(p,plane)
%COMPUTEPROJECTPOINT 此处显示有关此函数的摘要
%   此处显示详细说明
    px = p(1);
    py = p(2);
    pz = p(3);
    mA = plane(1);
    mB = plane(2);
    mC = plane(3);
    mD = plane(4);

    x = ((mB*mB + mC*mC)*px - mA*mB*py - mA*mC*pz - mA*mD) / (mA*mA + mB*mB +mC*mC);
    y = (mB/mA) * (x - px) + py;
    z = (mC/mA) * (x - px) + pz;

    point = [x y z];
end

