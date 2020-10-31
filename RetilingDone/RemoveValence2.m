% 将remesh过后的网格去除度数是2的情况
% RemoveValence2(f,v)
nf = size(faces,1);
x1 = faces(:,1); x2 = faces(:,2); x3 = faces(:,3);
X = [x1; x2; x3]; Y = [x2; x3; x1]; 
f_name = [1:nf, 1:nf, 1:nf]';
half_face = sparse(X, Y, f_name);

np = max(max(faces));
oneRingP{np} = [];
vertex_valence(np) = 0;
for P = 1:np
    neighbor_P = find(half_face(:,P));
    vertex_valence(P) = length(neighbor_P);   
end

P2 = find(vertex_valence == 2);

delet_f = zeros(nf, 1); tf = 1;
for i = P2
    [ri, ~] = find(faces == i);
    delet_f(ri) = 1;
end
find(delet_f)
faces_new = faces(delet_f == 0,:);
adj_idx = 1:np;
adj_idx(20138:np) = adj_idx(20138:np) - 1;
faces_new = adj_idx(faces_new);
[oneRingP2, vertex_valence2] = findNearPs(faces_new);

vertices_new = vertices([1:20136,20138:end],:);
% 删除这个顶点，坐标也应该清除

figure(30)
trimesh(faces_new, vertices_new(:,1), vertices_new(:,2), vertices_new(:,3));
axis equal;