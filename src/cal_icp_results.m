clc;
PI = 3.141592654;
[enveloped,dist,enveloped_rate]=estimateEnveloped(0.9, pointcloud1,cloud);
[datum_model,datum_model_cloud] = computeDatumCoefficients(pointcloud1);
[datum_data,datum_data_cloud] = computeDatumCoefficients(cloud);
datum_model_n = datum_model(1:3)/norm(datum_model(1:3));
datum_data_n = datum_data(1:3)/norm(datum_data(1:3));
lamnda = acos(dot(datum_model_n,datum_data_n)/(norm(datum_model_n)*norm(datum_data_n)));
if lamnda > PI/2
    lamnda = lamnda - PI;
end
dist_variance = computeSurfaceVariance(dist);

D_icp = abs(lamnda)/0.02;
datum_error_icp = computeDatumError(datum_model_cloud, datum_data_cloud, datum_model_n)

[datum_model,datum_model_cloud] = computeDatumCoefficients(pointcloud1);
[datum_data,datum_data_cloud] = computeDatumCoefficients(trans_data);
datum_model_n = datum_model(1:3)/norm(datum_model(1:3));
datum_data_n = datum_data(1:3)/norm(datum_data(1:3));

datum_error = computeDatumError(datum_model_cloud, datum_data_cloud, datum_model_n)

V_icp = dist_variance/25
E_icp = 1 - enveloped_rate