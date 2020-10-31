function [vertices_ReT, faces_ReT, n_rem, ubelong, nfig, xdelta] = ...
    Re_tiling(vertices, faces, nCand, k_level, nfig)

pre_compute_ReT;

%% 1.generateVertices and constrain points.
disp('Generate random Candidate Vertices on surface...')
[nameF_cand, vertices_cand] = generateVertices2(mymesh, nCand);

% add constrain points
% we set the point which has high curvature as CSP
disp('Add constrain points...')
CSP_idx = AddConstrainPoint(mymesh, k_level); CSP_idx = sort(CSP_idx);
vertices_CSP = vertices(CSP_idx, :); n_CSP = length(CSP_idx);

% plot v_cand and CSP
figure(nfig); nfig = nfig + 1;
trimesh(faces, vertices(:,1), vertices(:,2), vertices(:,3));axis equal;
hold on
plot3(vertices_cand(:,1), vertices_cand(:,2), vertices_cand(:,3), 'b*');
plot3(vertices(CSP_idx,1), vertices(CSP_idx,2), vertices(CSP_idx,3), 'r*');axis equal
hold off; title('Candidate Points and CSP')

%%
vertices_cand = [vertices_cand; vertices_CSP];
nameF_cand = [nameF_cand, zeros(1, n_CSP)];

%% 2.loop k = 100
% 计算面之间距离
disp('计算 FSD 和 VSD')
[FSD, num_FSD] = FacesShortDistance(vertices, faces, 2*radius, hedge_face);
disp(['num_FSD 最小值:', num2str(min(num_FSD))]);
[VSD, num_VSD] = VerticesShortDistance(vertices, faces, vertices_CSP, 2*radius);
disp(['num_vSD 最小值:', num2str(min(num_VSD))]);

disp('Move candidate points on mesh, looping...')
for n_move = 1:20
    % (1).repulsive force
    forces = ComputeRepulsiveForce_adj(mymesh, nameF_cand, vertices_cand, FSD, VSD);
    nameF_cand3 = nameF_cand; % for forces test

    % (2).move candidate points
    % 在做移动时，不需要考虑固定的点
    [vertices_cand2, nameF_cand2] = moveOnMesh_PLUS(mymesh,  vertices_cand(1:nCand, :), ...
        nameF_cand(1:nCand), forces(1:nCand, :));
    vertices_cand(1:nCand, :) = vertices_cand2;
    nameF_cand(1:nCand) = nameF_cand2;
end
force_test; % test 1

% the figure after moving candidate points
fig3 = 1; myplot; 

%% UbelongCD
UbelongCD; %

%% 3.doMutualTesselation
disp('Do MutualTesselation...')
faces_Mutual = doMutualTesselation2(mymesh, nameF_cand(1:nCand), vertices_cand);

vertices_Mutual = [vertices; vertices_cand(1:nCand,:)];
mesh_test; % test 2
% MutualTesselation图
% fig4 = 1; myplot; 

%% 4.RemovingOldVertices
disp('Removing Old Vertices...')
[vertices_ReT, faces_ReT, n_rem] = RemovingOldVertices_cpp2(...
    mymesh, vertices_cand(1:nCand, :), faces_Mutual, CSP_idx);

fig5 = 1; myplot; 

end