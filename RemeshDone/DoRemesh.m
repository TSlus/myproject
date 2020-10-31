% do remesh
function [vertices, faces] = DoRemesh(vertices, faces)

hedge = [faces(:,1:2); faces(:,2:3); faces(:,[3,1])];
de = sum(abs(vertices(hedge(:, 1),:) - vertices(hedge(:, 2),:)).^2, 2).^(1/2);
L = sum(de)/length(de);
% L = 0.9 * sum(de)/length(de);
% max_L = 5/3*L;
% min_L = 3/5*L;

[vertices, faces, ~, ~] = Remesher(vertices, faces, 1.1*L, 1);

end

