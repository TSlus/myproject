nf = size(faces,1); np = size(vertices, 1);

%% 1.�ж���������
x1 = faces(:,1); x2 = faces(:,2); x3 = faces(:,3);
X = [x1; x2; x3]; Y = [x2; x3; x1]; % R = [1:size(faces,1), 1:size(faces,1), 1:size(faces,1)]';
halfEdge = sparse(X, Y, 1);
if ~isempty(find(halfEdge - halfEdge', 1))
    warning('�����Ƿ������');
    return;
end

%% 2.���ð����������
hedge_face = sparse(X, Y, [1:nf, 1:nf, 1:nf]');

%% 3.����ÿ����ķ�����
v1 = vertices(faces(:,2),:) - vertices(faces(:,1),:);
v2 = vertices(faces(:,3),:) - vertices(faces(:,1),:);
norm_face = cross(v1, v2, 2);
norm_face_normal = sum(abs(norm_face).^2, 2).^(1/2);
norm_face = norm_face ./ norm_face_normal;
% onee = sum(norm_face.^2,2) - 1;max(abs(onee))

%% 4.area of suface
si = norm_face_normal / 2; %ÿ��С���������
sa = sum(si);              %��������
% ��¼si��С����
% �ٷ�֮һ�ġ�С������������ϲ�ѡ candidate_points
k_si = ceil(nf * 0.05);
[~, si_small] = mink(si, k_si);

%% ��������Ϣ���廯
mymesh.vertices = vertices; mymesh.faces = faces;
mymesh.np = np; mymesh.nf = nf;
mymesh.hedge_face = hedge_face;
mymesh.norm_face = norm_face; 
mymesh.si = si; mymesh.sa = sa;

%% 
[oneRingPs, v_valence] = findNearPs(faces);
vertex_valence = v_valence;

%% �ƶ��뾶
radius = 2 * sqrt(sa / (nCand + k_level));
mymesh.radius = radius;

% vceng = (vertices(faces(:,1),:) + vertices(faces(:,2),:) + vertices(faces(:,3),:)) / 3;
% trimesh(faces,vertices(:,1), vertices(:,2), vertices(:,3))
% axis equal; hold on;
% drawsphere(vceng(end,1),vceng(end,2),vceng(end,3),radius);


