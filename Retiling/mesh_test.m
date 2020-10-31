% mesh_test
%% 1. ���������Ƿ���
faces_test = faces_Mutual;
x1 = faces_test(:,1); x2 = faces_test(:,2); x3 = faces_test(:,3);
X = [x1; x2; x3]; Y = [x2; x3; x1]; % R = [1:size(faces,1), 1:size(faces,1), 1:size(faces,1)]';
halfEdge = sparse(X, Y, 1);
if ~isempty(find(halfEdge - halfEdge', 1))
    warning('��ʱMutual tessellation���Ƿ������.')
else
    disp('1.Mutual tessellation is closed!')
end

%% 2.���Լ���Ķ����Ƿ����������ڲ�
flag_test = isOnTriangle(nameF_cand(1:nCand), vertices_cand(1:nCand,:), vertices, faces, norm_face);
if isempty(find(flag_test == 0, 1))
    disp('2.cadidate points in triangles interior!');
else
    warning('cadidate points �����������ڲ�.')
end