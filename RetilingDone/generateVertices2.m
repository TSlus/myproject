function [nameF_cand, vertices_cand] = generateVertices2(mymesh, nCand)  %#ok<INUSL>
mesh_to_VFdetail; % 将mesh中的数据离散化

vertices_cand = zeros(nCand, 3);
[rand_num, nameF_cand, s_sum_i] = GRPONN(si, nCand);

% 利用rand_num计算权重；
u1 = (rand_num - s_sum_i(nameF_cand)) ./ si(nameF_cand);
u2 = (1 - u1) .* rand(nCand, 1);
u3 = 1 - u1 - u2;

u = [u1, u2, u3];
if ~isempty(find(u<=0 | u>=1,1))
    disp('candidate points 权重u取值超出(0,1)，重新生成。')
end

% 生成随机点的坐标
for i = 1:nCand
    vertices_cand(i, :) = [u1(i), u2(i), u3(i)] * vertices(faces(nameF_cand(i),:),:);
end

nameF_cand = nameF_cand';
end