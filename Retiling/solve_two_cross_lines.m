function [t1, t2] = solve_two_cross_lines(p1, p2, w1, w2)
% 计算空间直线交点（已知两直线相交）
% 1.现将直线投影到xy平面，（或者xz，yz平面）
% 2.再利用公式求得t1, t2
% L1 = p1 + t1 x (p2 - p1);
% L2 = w1 + t2 x (w2 - w1);

%test
% p1 = [0,1,0; 0,0,0]; p2 = [0,0,1; 0,1,1]; 
% w1 = [0,0.5,0;0,0.5,0];w2 = [0,0.5,1;0,0.5,1];

% 计算投影轴
p_1 = p1(1,:); p_2 = p2(1,:); w_1 = w1(1,:); w_2 = w2(1,:);
[~, axik] = max(abs(cross(p_2 - p_1, w_2 - w_1))); % 投影轴
% axik = 3;
ck = [mod(axik,3) + 1, mod(axik + 1,3) + 1]; % 投影平面

% 投影参数化
x1 = p1(:, ck(1)); y1 = p1(:, ck(2)); x2 = p2(:, ck(1)); y2 = p2(:, ck(2));
u1 = w1(:, ck(1)); v1 = w1(:, ck(2)); u2 = w2(:, ck(1)); v2 = w2(:, ck(2));

% 公式计算
t1_up = -(u1 - x1).*(v2 - v1) + (v1 - y1).*(u2 - u1);
t2_up =  (x2 - x1).*(v1 - y1) - (y2 - y1).*(u1 - x1);
t_down = -(x2 - x1).*(v2 - v1) + (y2 - y1).*(u2 - u1);
t1 = t1_up ./ t_down;
t2 = t2_up ./ t_down;

end




