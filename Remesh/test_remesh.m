clear; clc
% load('bunny.mat')
load('bronze.mat');
% load('data3.mat'); vertices = x; faces = t;
% figure(1)
% trimesh(faces, vertices(:,1), vertices(:,2), vertices(:,3));
% axis equal; 

[vertices, faces] = DoRemesh(vertices, faces);
figure(2)
trimesh(faces, vertices(:,1), vertices(:,2), vertices(:,3));
axis equal; 

RemoveValence2

[oneRingP2, vertex_valence2] = findNearPs(faces);
figure(3)
trimesh(faces, vertices(:,1), vertices(:,2), vertices(:,3));
axis equal;

% 每个点都有对应的三角形
% a = sort(unique(faces(:)));
% find(sort(unique(faces(:))) - (1:size(vertices,1))')