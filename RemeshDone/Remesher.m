function [vnew, fnew, meanedge, stdev] = Remesher(V, F, edgelength, iterations)
% INPUT
% -V: vertices of mesh; n*3 array of xyz coordinates
% -F: faces of  mesh; n*3 array
% -edgelength:  edgelength aimed for
% -iterations: nr of iterations, 5 to 10 suffice
% 

% OUTPUT
% -vnew: remeshed vertices list: n*3 array of xyz coordinates
% -fnew: remeshed list of faces of  mesh; n*3 array
% -meanedge: average edgelenth obtained
% -stdev: stdev of edgelengths

% EXAMPLE
%     load testdatafemur
%     [vnew, fnew, meanedge, stdev]=remesher(vnew, fnew, 3, 5);


% 函数的作用
% 1.CleanPatch
% (1)去除重复的顶点
% (2)去除边[a,a,b]
% (3)去除没有用到的顶点，“空顶点”

% 2.SubdivideLarge
% 将长边一分为二

% 3.EdgeCollaps
% 将短边合二为一

% 4.RemoveBadTriangles
% 将面积过小的三角形移除

%clean up patch
[vnew, fnew] = CleanPatch(V, F);
voriginal = vnew;
foriginal = fnew;
[vnew,fnew] = SubdivideLarge( vnew, fnew,edgelength,voriginal,foriginal );
voriginal = vnew;
foriginal = fnew;

for i = 1:iterations
    
[vnew, fnew,temp] = EdgeCollaps( vnew, fnew, edgelength ,voriginal,foriginal);
[vnew, fnew, temp] = RemoveBadTriangles( vnew, fnew,voriginal,foriginal);
[vnew,fnew] = SubdivideLarge( vnew, fnew,0 ,voriginal,foriginal);
[vnew, fnew, temp] = RemoveBadTriangles( vnew, fnew,voriginal,foriginal);

% disp(['Iteration:' num2str(i) '  Output mesh: ' num2str(size(fnew,1)) ' triangles, ' ... 
%     num2str(size(vnew,1))  ' vertices.']);
end

meanedge = temp(:,1);
stdev=temp(:,2);

