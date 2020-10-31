clear; 
clc;
load('bronze.mat'); load('bronze_loop_point.mat');
% load('bunny.mat'); load('bunny_loop_point.mat')

% k = 1008;
% vp = loop_point{k};
% trimesh(faces, vertices(:,1), vertices(:,2), vertices(:,3));
% axis equal; hold on
% plot3(vp(:,1),vp(:,2),vp(:,3),'r*')

disp('PPS')
surfaceP = surfaceConstruction(vertices, faces, loop_point);
figure(3)
plot3(surfaceP(:,1),surfaceP(:,2),surfaceP(:,3),'b.');axis equal
title('PPS')






