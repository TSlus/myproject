function CSP_idx = AddConstrainPoint(mymesh, k_level)   %#ok<INUSL>
mesh_to_VFdetail; % ��mesh�е�������ɢ��

% �����ʽϴ�ĵ���ΪCSP
FV.vertices = vertices;
FV.faces = faces;
[Cmean,~,~,~,~,~] = GetCurvature(FV, true);
abs_Cmean = abs(Cmean);

% ��Ӧ���ǵ�CSP�������ϲ��˿���̫��
% ���Ը�������һ�� remesh��


[~, CSP_idx] = maxk(abs_Cmean, k_level);

end