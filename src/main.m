clc;
global cloud_model;
global cloud_data;

pointcloud1 = pcread('part_1_m.ply');
pointcloud2 = pcread('part_1_d_t.ply');
pcshowpair(pointcloud1,pointcloud2);
tform = pcregrigid(pointcloud2,pointcloud1,'MaxIterations',200);
cloud=pctransform(pointcloud2,tform);
pcshowpair(pointcloud1,cloud);
view(2);
[datum_model,datum_model_cloud] = computeDatumCoefficients(pointcloud1);
[datum_data,datum_data_cloud] = computeDatumCoefficients(cloud);
figure;
pcshowpair(datum_model_cloud,datum_data_cloud);

% 
% global triangles;
% triangles = triangulation(boundary(double(pointcloud1.Location),1),double(pointcloud1.Location));

cloud_model = pointcloud1;
cloud_data = cloud;
% 
% A = [0 0 0 0 0 0];
% fitness = computeFitness(A);

options = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
options.InitialPopulationRange = [-1,-1,-1,-1,-1,-1;1,1,1,1,1,1];
options.PopulationSize = 20;
options.MaxStallGenerations = 10;
FitnessFcn = @computeFitness;
numberOfVariables = 6;
LB = -ones(1,6);
UB = ones(1,6);
rng('default');
[x,fval,exitFlag,Output,population,scores] = ga(FitnessFcn,numberOfVariables,[],[],[],[],LB,UB,[],options);