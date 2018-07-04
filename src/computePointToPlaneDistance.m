function distance = computePointToPlaneDistance(cloud,plane)
%COMPUTEPOINTTOPLANEDISTANCE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    mA = plane(1);
    mB = plane(2);
    mC = plane(3);
    mD = plane(4);
    n = cloud.Count;
    distance = zeros(n,1);
    for i = 1:n 
        mX = cloud.Location(i,1);
        mY = cloud.Location(i,2);
        mZ = cloud.Location(i,3);
        if mA*mA + mB*mB + mC*mC ~= 0
            dt = abs(mA*mX + mB*mY + mC*mZ + mD) / sqrt(mA*mA + mB*mB + mC*mC);
            distance(i) = dt;
        end
    end  
end

