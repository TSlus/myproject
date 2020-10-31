% mesh_test
%% 1. 测试网格是否封闭
faces_test = faces_Mutual;
x1 = faces_test(:,1); x2 = faces_test(:,2); x3 = faces_test(:,3);
X = [x1; x2; x3]; Y = [x2; x3; x1]; % R = [1:size(faces,1), 1:size(faces,1), 1:size(faces,1)]';
halfEdge = sparse(X, Y, 1);
if ~isempty(find(halfEdge - halfEdge', 1))
    warning('此时Mutual tessellation不是封闭网格.')
else
    disp('1.Mutual tessellation is closed!')
end

%% 2.测试加入的顶点是否在三角形内部
flag_test = isOnTriangle(nameF_cand(1:nCand), vertices_cand(1:nCand,:), vertices, faces, norm_face);
if isempty(find(flag_test == 0, 1))
    disp('2.cadidate points in triangles interior!');
else
    warning('cadidate points 不在三角形内部.')
end