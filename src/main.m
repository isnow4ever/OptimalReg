clc;
global cloud_model;
global cloud_data;

pointcloud1 = pcread('blade_model_01.ply');
pointcloud2 = pcread('trans_data.ply');
pcshowpair(pointcloud1,pointcloud2);
tform = pcregrigid(pointcloud2,pointcloud1,'MaxIterations',200);
cloud=pctransform(pointcloud2,tform);
pcshowpair(pointcloud1,cloud);

cloud_model = pointcloud1;
cloud_data = cloud;
% A = [1 0 0 0 0 0];
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