% clear;

% 缩减循环时所耗费的时间
% 缩减每次计算排斥力的时间
% 计算每个面之间的距离
% clear; clc
% load('bronze.mat')
% tic
% [FSD, num_FSD] = FacesShortDistance(vertices, faces);
% toc
% max(num_FSD)
% min(num_FSD)

% % 测试投影
% % 测试结果：加速了投影
% clear;clc
% p = [1,1,1;-1,1,1;1,-1,-1;-1,-1,-1];
% surface([-2,2;2,-2], [-2,-2;2,2], [0,0;0,0]); view(3);
% hold on;
% triangle = [-1,0,0;1,0,0;1,1,0]; normal_tri = [0,0,1];
% ponit_on_plane = project_point_to_triangle2(p, triangle, normal_tri);
% plot3(p(:,1), p(:,2), p(:,3),'b*');
% plot3(ponit_on_plane(:,1),ponit_on_plane(:,2),ponit_on_plane(:,3),'r*')
%
% 测试旋转
% 测试结果：以法向量方向，逆时针旋转
% clear;clc
% p3 = [0,0,1;1,1,1/2;1,1,1;0,1,1];
% line = [1,0,0;1,0,0;1,0,0]; v0 = zeros(3,3); n_1 = 1; n_2 = 1; n_3 = 2;
% thetas = [pi/2, -atan2(1/2,1), -pi/4]';
% pl = point_rotate_line(p3, line, v0, thetas, n_1, n_2, n_3);
% surface([-2,2;2,-2], [-2,-2;2,2], [0,0;0,0]); view(3); hold on
% plot3(p3(:,1), p3(:,2), p3(:,3),'b*');
% plot3(pl(:,1),pl(:,2),pl(:,3),'r*')
% axis equal
% xlabel('x'); ylabel('y'); zlabel('z')
% view(93.4691,21.5090)
% dist = sum((pl - zeros(4,3)).*[0,0,1],2);
% max(dist)


% clear; clc
% load('bronze.mat')
% % load('bunny.mat')
% % load('model.mat')
% nCand = size(faces, 1); k_level = 2;
% pre_compute_ReT;
% v = vertices; f = faces;
% vc = (v(f(:,1),:) + v(f(:,2),:) + v(f(:,3),:))/3;
% tic
% [CanF_Rotate, CDP_rotate] = CandidateAfterRotate3(vc, v, f, 1:nf, norm_face, hedge_face);
% toc

% 为了处理不正常网格，先做一个小的调整
% 用邻域点做处理
% 对使用前网格和生成的网格都需要remesh处理

% clear;
% n_test = 0; normal = [0,0,0]; 
% for i = 1:15
%     
%     switch n_test
%         case 0
%         case 1; normal = [.8507, .4472, .2764];
%         case 2; normal = [-.8507, .4472, .2764];
%         case 3; normal = [.8507, -.4472, .2764];
%         case 4; normal = [.8507, .4472, -.2764];
%         case 5; normal = [.5257, .4472, .7236];
%         case 6; normal = [-.5257, .4472, .7236];
%         case 7; normal = [.5257, -.4472, .7236];
%         case 8; normal = [.5257, .4472, -.7236];
%         case 9; normal = [.0, .4472, .8944];
%         case 10; normal = [.0, -.4472, .8944];
%         case 11; normal = [.0, .4472, -.8944];
%         case 12; normal = [0, 1, 0];
%         case 13; normal = [1, 0,0];
%         case 14; normal = [0, 0, 1];
%     end
%     a = [normal; zeros(1,3); -normal];
%     plot3(a(:,1),a(:,2),a(:,3),'b-*');
%     hold on;axis equal; grid on
%     n_test = n_test+1;
% end
% 
% % 将邻域点对应到二维平面
% % 将第一个点投影到所在平面
% base1 = project_point_to_triangle3(near_p0, vi, normal_fi);
% base1 = base1/norm(base1);
% base2 = cross(normal_fi, base1, 2); 
% 
% % 先投影，再计算二维坐标对应
% proj_nears = project_point_to_triangle3(near1, vi, normal_fi);
% xy = zeros(n_near, 2);
% xy(:, 1) = sum(proj_nears.*base1, 2);
% xy(:, 2) = sum(proj_nears.*base2, 2);
% 
% a = 0;
% try
%     a(2) = 1/0;
%     error;
% catch
%     a = 1;
% end
% a
% 
% % 测试能否投影到平面
% xy = [cos((1:6)*2*pi/6); sin((1:6)*2*pi/6)]; xy = xy';
% xy(1,:) = [0,-2];
% plot(xy(:,1),xy(:,2))
% ProjectFormNormal(xy)


% 测试移除老点 程序
clear; clc
load('bronze.mat');
vc = (vertices(faces(:,1),:) + vertices(faces(:,2),:) + vertices(faces(:,3),:))/3;
nf = size(faces,1);
np = size(vertices, 1);
id_add = ((1:nf) + np)';
faces1 = [faces(:,1), faces(:,2), id_add];
faces2 = [faces(:,2), faces(:,3), id_add];
faces3 = [faces(:,3), faces(:,1), id_add];
faces_new = [faces1; faces2; faces3];
vertices_new = [vertices; vc];
% trimesh(faces_new, vertices_new(:,1), vertices_new(:,2), vertices_new(:,3));
% axis equal;

nCand = nf;
k_level = 0;
pre_compute_ReT;

[vertices_Mutual, faces_Mutual, n_rem] = RemovingOldVertices_cpp(...
    mymesh, vc, faces_new, 1:2:nf);
trimesh(faces_Mutual, vertices_Mutual(:,1), vertices_Mutual(:,2), vertices_Mutual(:,3));
axis equal

clear
clc
lastwarn('')
warning('1');
[msg,warnID] = lastwarn;
 warning('off',warnID);
 warning('2');
 [msg,warnID] = lastwarn
