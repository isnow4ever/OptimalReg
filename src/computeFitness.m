function fitness = computeFitness(X)
%COMPUTEFITNESS 此处显示有关此函数的摘要
%   此处显示详细说明\
    PI = 3.141592654;
    global cloud_model;
    global cloud_data;
    global cloud_datum;
    global Di Vi Ei Fi;
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
    
    alpha = 0.3;
    beta = 0.1;
    gama = 0.9;
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
    
%     if enveloped == true
        [datum_model,datum_model_cloud] = computeDatumCoefficients(cloud_model);
        [datum_data,datum_data_cloud] = computeDatumCoefficients(trans_data);
		datum_model_n = datum_model(1:3)/norm(datum_model(1:3));
        datum_data_n = datum_data(1:3)/norm(datum_data(1:3));
        lamnda = acos(dot(datum_model_n,datum_data_n)/(norm(datum_model_n)*norm(datum_data_n)));
        if lamnda > PI/2
            lamnda = lamnda - PI;
        end
		%datum_error = computeDatumError(datum_model_cloud, datum_data_cloud, datum_normal);
		dist_variance = computeSurfaceVariance(dist);
        %sigmoid_e = 1 / (1 + sqrt(0.01 * datum_error));
		%sigmoid_v = 1 / (1 + sqrt(dist_variance));
% 		fitness = alpha * sigmoid_e + beta * sigmoid_v;
%         fitness = -dist_variance;
        D = abs(lamnda)/0.02; 
        V = dist_variance/25;
        E = 1 - enveloped_rate;
        fitness = alpha * D + beta * exp(V) + gama * exp(E);
        Di = [Di D];
        Vi = [Vi V];
        Ei = [Ei E];
        Fi = [Fi fitness];
%     else
%         fitness = 0.0;
%     end
%     fitness = -enveloped_rate;
end

