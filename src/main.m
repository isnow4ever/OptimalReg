clc;
global cloud_model;
global cloud_data;
result_dir = strcat('..\results\','result19'); %create result folder
test = 1; %select data
mkdir(result_dir);
%cd(result_dir);
if test == 1
pointcloud1 = pcread('blade_model_01.ply');
pcwrite(pointcloud1,'model','PLYFormat','binary');
pointcloud2 = pcread('trans_data.ply');
pointcloud3 = pcread('blade_original.ply');
elseif test == 2
pointcloud1 = pcread('part_1_m.ply');
pcwrite(pointcloud1,'model','PLYFormat','binary');
pointcloud2 = pcread('part_1_d_t.ply');
pointcloud3 = pcread('part_1_d.ply');
elseif test == 3
pointcloud1 = pcread('part_2_m.ply');
pcwrite(pointcloud1,'model','PLYFormat','binary');
pointcloud2 = pcread('part_2_d_t.ply');
pointcloud3 = pcread('part_2_d.ply');
elseif test == 4
pointcloud1 = pcread('part_3_m.ply');
pcwrite(pointcloud1,'model','PLYFormat','binary');
pointcloud2 = pcread('part_3_d_t.ply');
pointcloud3 = pcread('part_3_d.ply');
elseif test == 5
pointcloud1 = pcread('part_4_m.ply');
pcwrite(pointcloud1,'model','PLYFormat','binary');
pointcloud2 = pcread('part_4_d_t.ply');
pointcloud3 = pcread('part_4_d.ply');
elseif test == 6
pointcloud1 = pcread('part_5_m.ply');
pcwrite(pointcloud1,'model','PLYFormat','binary');
pointcloud2 = pcread('part_5_d_t.ply');
pointcloud3 = pcread('part_5_d.ply');
end
figure;
init = pcshowpair(pointcloud1,pointcloud3);
saveas(init,'init','fig');
sac_ia = pcshowpair(pointcloud1,pointcloud2);
saveas(sac_ia,'sac_ia','fig');
tform1 = pcregrigid(pointcloud2,pointcloud1,'MaxIterations',200);
cloud=pctransform(pointcloud2,tform1);
figure;
icp = pcshowpair(pointcloud1,cloud);%icp
view(2);
saveas(icp,'icp','fig');
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
options.FunctionTolerance = 1e-5;
options.MaxGenerations = 50;
FitnessFcn = @computeFitness;
numberOfVariables = 6;
LB = -ones(1,6);
UB = ones(1,6);
rng('default');
[x,fval,exitFlag,Output,population,scores] = ga(FitnessFcn,numberOfVariables,[],[],[],[],LB,UB,[],options);
% x = [-0.11 -0.56 -0.8 0.3940 0.2870 0.2314];
centroid = mean(cloud_datum.Location);
tf1 = [eye(3) zeros(3,1);-centroid 1]; %designed datum in z, '-centroid' is replaced with 'z-centroid' 
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
pcwrite(trans_data,'trans_data','PLYFormat','binary');
figure;
final = pcshowpair(pointcloud1,trans_data);
view(2);
saveas(final,'final','fig');
myplot('model.ply','trans_data.ply');
save('matlab');
