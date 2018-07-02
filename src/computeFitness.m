function fitness = computeFitness(X)
%COMPUTEFITNESS 此处显示有关此函数的摘要
%   此处显示详细说明
    load 'data_with_normals.txt';
    load 'model_with_normals.txt'
    cloud_model = model_with_normals(:,1:3);
    cloud_data = data_with_normals(:,1:3);
    normals_model = model_with_normals(:,4:6);
    normals_data = data_with_normals(:,4:6);
    H = [0.01 0.1 0.01 20 20 0.5];
    X = H'*X;
    theta = X(1);
    phi = X(2);
    psi = X(3);
    a = X(4);
    b = X(5);
    c = X(6);
    R = angle2dcm(theta,phi,psi);
    T = [a b c];
    cloud_data = (R*cloud_data'+T')';
    alpha = 0.2;
    beta = 0.8;
    probability = 0.7;
    enveloped = estimateEnveloped(probability, cloud_model, cloud_data);
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
        fitness = 1.0;
    end
end

