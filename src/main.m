clc;
load 'data_with_normals.txt';
load 'model_with_normals.txt'
global cloud_model;
global cloud_data;
cloud_model = model_with_normals(:,1:3);
cloud_data = data_with_normals(:,1:3);
normals_model = model_with_normals(:,4:6);
normals_data = data_with_normals(:,4:6);
x1 = model_with_normals(:,1);
y1 = model_with_normals(:,2);
z1 = model_with_normals(:,3);
x2 = data_with_normals(:,1);
y2 = data_with_normals(:,2);
z2 = data_with_normals(:,3);
scatter3(x1,y1,z1,0.01,'red');
hold on;
scatter3(x2,y2,z2,0.01,'green');
hold on;


options = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
options.InitialPopulationRange = [-1,-1,-1,-1,-1,-1;1,1,1,1,1,1];
options.PopulationSize = 200;
options.MaxStallGenerations = 50;
FitnessFcn = @computeFitness;
numberOfVariables = 6;
LB = -ones(1,6);
UB = ones(1,6);
rng('default');
[x,fval,exitFlag,Output,population,scores] = ga(FitnessFcn,numberOfVariables,[],[],[],[],LB,UB,[],options);