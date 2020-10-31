clear;clc;
addpath(genpath('Models'));
name1 = 'model.mat'; name2 = 'bunny.mat';
name3 = 'bronze.mat';

%% input
% 1.mesh
load(name3);

% 2.number of candidate points
nCand = ceil(size(faces, 1)/2); % half of the number of faces

% 3.the level of detail, high curvature old points -- CSP
k_level = ceil(nCand/4); % quarter of nCand

%% do Retiling and PPS
Retiling_and_PPS;