function fitness = computeFitness(theta,phi,psi,a,b,c)
%COMPUTEFITNESS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    load '../data/data_with_normals.txt';
    load '../data/model_with_normals.txt'
    cloud_model = model_with_normals(:,1:3);
    cloud_data = data_with_normals(:,1:3);
    normals_model = model_with_normals(:,4:6);
    normals_data = data_with_normals(:,4:6);
    R = angle2dcm(theta,phi,psi);
    T = [a b c];
    cloud_data = R*cloud_data+T;
    alpha = 0.2;
    beta = 0.8;
    probability = 0.7;
    enveloped = estimateEveloped(probability, cloud_model, cloud_data);
    if enveloped == true
        datum_model = computeDatumCoefficients(cloud_model);
        datum_data = computeDatumCoefficients(cloud_data);
        mA = datum_model(1);
		mB = datum_model(2);
		mC = datum_model(3);
		datum_normal = [mA / sqrt(mA*mA + mB*mB + mC*mC)  mB / sqrt(mA*mA + mB*mB + mC*mC) mC / sqrt(mA*mA + mB*mB + mC*mC)];
		datum_error = computeDatumError(datum_model, datum_data, datum_normal);
		dist_variance = computeSurfaceVariance(dist);
        sigmoid_e = 1 / (1 + sqrt(0.01 * datum_error));
		sigmoid_v = 1 / (1 + sqrt(dist_variance));
		fitness = alpha * sigmoid_e + beta * sigmoid_v;
    else
        fitness = 0.0;
    end
end
