clear;clc;
%% ����
% 1.����
% load('model.mat');
% load('bunny.mat');
load('bronze.mat'); load('ubelongcd.mat')

% % 2.������
% n_k = 1/4; % ������ n_k ȡ1/4��1/2��1 * numF����Ϊѡȡ�ĵ���Ŀ
% 
% %%
% figure(1)
% trimesh(faces, vertices(:,1),vertices(:,2),vertices(:,3));axis equal
% title('��ʼ����')
%% do Re_Tiling
% % retiling ���Ҫ��new�м���
% 
% [vertices_Mutual, faces_Mutual, nameF_cand, remain_p] = myRe_tiling(vertices, faces, n_k);
% 
% figure(2)
% trimesh(faces_Mutual, vertices_Mutual(:,1), vertices_Mutual(:,2), vertices_Mutual(:,3));axis equal;
% title('mesh after removing old points');

%%
% return; 
% �����ÿ������������꣬����PPS
% �������μ��㲿�ֵ�ʱ��

%% do PPS
% 1.loopSurface
disp('loopSurface')
loop_point = mesh_connect_LoopSurf(vertices, faces); % #ok<UNRCH>
% return;

% PPS
disp('PPS')
surfaceP = surfaceConstruction(vertices, faces, loop_point, ubelongcd);
figure(3)
plot3(surfaceP(:,1),surfaceP(:,2),surfaceP(:,3),'b.');axis equal
title('PPS')

%% Retiling and PPS
% vertices_final = vertices_Mutual;faces_final = faces_Mutual;
% for i = 1:size(vertices_Mutual)
%     [~, idx] = min(sum(abs(vertices_final(i,:) - surfaceP).^2, 2));
%     vertices_final(i,:) = surfaceP(idx, :);
% end
% 
% %ͼ��
% figure(4)
% trimesh(faces_final, vertices_final(:,1), vertices_final(:,2), vertices_final(:,3));axis equal;
% title('Retiling & PPS');