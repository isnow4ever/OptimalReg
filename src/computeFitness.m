function fitness = computeFitness(X)
%COMPUTEFITNESS 此处显示有关此函数的摘要
%   此处显示详细说明
    global cloud_model;
    global cloud_data;
    global cloud_datum;
%     global triangles;
    centroid = mean(cloud_datum.Location);
    tf1 = [eye(3) zeros(3,1);-centroid 1];
    TF1 = affine3d(tf1);
    m_data = pctransform(cloud_data,TF1);
    
    H = [0.01 0.005 0.005 2 2 1];
    X = H.*X;
    theta = X(1);
    phi = X(2);
    psi = X(3);
    a = X(4);
    b = X(5);
    c = X(6);
    R = angle2dcm(theta,phi,psi);
    T = [a b c];
    tf = [R zeros(3,1);T 1];
    TF = affine3d(tf);
    n_data = pctransform(m_data,TF);
    
    tf2 = [eye(3) zeros(3,1);centroid 1];
    TF2 = affine3d(tf2);
    trans_data = pctransform(n_data,TF2);
    %pcshowpair(cloud_model,trans_data);
    
    alpha = 0.2;
    beta = 0.8;
    probability = 0.9;
    [enveloped,dist,enveloped_rate] = estimateEnveloped(probability, cloud_model, trans_data);
%     in = inpolyhedron(triangles.ConnectivityList,triangles.Points,trans_data.Location);
%     in_count = size(find(in(:)==true),1);
%     enveloped_rate = in_count / size(in,1);
%     if enveloped_rate > probability
%         enveloped = true;
%     else
%         enveloped = false;
%     end
    
    if enveloped == true
        [datum_model,datum_model_cloud] = computeDatumCoefficients(cloud_model);
        [datum_data,datum_data_cloud] = computeDatumCoefficients(trans_data);
        mA = datum_model(1);
		mB = datum_model(2);
		mC = datum_model(3);
		datum_normal = [mA / sqrt(mA*mA + mB*mB + mC*mC)  mB / sqrt(mA*mA + mB*mB + mC*mC) mC / sqrt(mA*mA + mB*mB + mC*mC)];
		datum_error = computeDatumError(datum_model_cloud, datum_data_cloud, datum_normal);
		dist_variance = computeSurfaceVariance(dist);
        sigmoid_e = 1 / (1 + sqrt(0.01 * datum_error));
		sigmoid_v = 1 / (1 + sqrt(dist_variance));
% 		fitness = alpha * sigmoid_e + beta * sigmoid_v;
%         fitness = -dist_variance;
    else
        fitness = 0.0;
    end
    fitness = -enveloped_rate;
end

