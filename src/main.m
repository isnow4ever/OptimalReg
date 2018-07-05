clc;
global cloud_model;
global cloud_data;

pointcloud1 = pcread('part_3_m.ply');
pointcloud2 = pcread('part_3_d_t.ply');
% pcshowpair(pointcloud1,pointcloud2);
tform1 = pcregrigid(pointcloud2,pointcloud1,'MaxIterations',200);
cloud=pctransform(pointcloud2,tform1);
figure;
pcshowpair(pointcloud1,cloud);%icp
view(2);
[datum_model,datum_model_cloud] = computeDatumCoefficients(pointcloud1);
[datum_data,datum_data_cloud] = computeDatumCoefficients(cloud);
% figure;
% pcshowpair(datum_model_cloud,datum_data_cloud);%datum plane
tf2 = [eye(3) zeros(3,1);[0 0 -datum_data(4)] 1];
tform2 = affine3d(tf2);
cloud2=pctransform(cloud,tform2);
global cloud_datum;
cloud_datum = datum_model_cloud;


% 
% global triangles;
% triangles = triangulation(boundary(double(pointcloud1.Location),1),double(pointcloud1.Location));

gridStep = 0.1;
cloud_model = pcdownsample(pointcloud1,'gridAverage',gridStep);
cloud_data = pcdownsample(cloud2,'gridAverage',gridStep);
figure;
pcshowpair(cloud_model,cloud_data);
% 
% A = [0 0 0 0 0 0];
% fitness = computeFitness(A);
    global Di Vi Ei Fi;
    Di = [];
    Vi = [];
    Ei = [];
    Fi = [];

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
% x = [-0.070539934747450,0.689435926039218,-0.415051896784093,-0.400022554252527,0.252830781450442,-0.695243962061554];
centroid = mean(cloud_datum.Location);
tf1 = [eye(3) zeros(3,1);-centroid 1];
TF1 = affine3d(tf1);
m_data = pctransform(cloud2,TF1);

H = [0.01 0.005 0.005 2 2 1];
X = H.*x;
theta = X(1);
phi = X(2);
psi = X(3);
a = X(4);
b = X(5);
c = X(6);
R = angle2dcm(theta,phi,psi);
T = [a b c];
tf2 = [R zeros(3,1);T 1];
TF = affine3d(tf2);
n_data = pctransform(m_data,TF);

tf2 = [eye(3) zeros(3,1);centroid 1];
TF2 = affine3d(tf2);
trans_data = pctransform(n_data,TF2);
figure;
pcshowpair(pointcloud1,trans_data);