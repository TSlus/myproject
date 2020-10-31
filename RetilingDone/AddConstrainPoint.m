function CSP_idx = AddConstrainPoint(mymesh, k_level)   %#ok<INUSL>
mesh_to_VFdetail; % 将mesh中的数据离散化

% 将曲率较大的点设为CSP
FV.vertices = vertices;
FV.faces = faces;
[Cmean,~,~,~,~,~] = GetCurvature(FV, true);
abs_Cmean = abs(Cmean);

% 还应考虑到CSP在网格上不宜靠的太近
% 可以给网格做一次 remesh。


[~, CSP_idx] = maxk(abs_Cmean, k_level);

end