%% k-means法によるROIの分割
file = 'D:\Ajioka\180911_no101_x25x2.5_cell7_xyt_TurboReg.tif';
k = 20; %クラスタの数
%%%%%%%%%%
%% Miji
addpath('C:\Users\wakelab\Desktop\fiji-win64\Fiji.app\scripts')
javaaddpath 'C:\Program Files\MATLAB\R2017a\java\ij.jar'
javaaddpath 'C:\Program Files\MATLAB\R2017a\java\mij.jar'
Miji; %開始
%%
MIJ.run('Open...', ['path=', file]);
imagestack = MIJ.getCurrentImage; 
MIJ.run('Close');
%%
load('ROI.mat')
[x,y] = find(ROI);
[idx, C] = kmeans([x,y],k);
A = zeros(size(ROI,1), size(ROI,2));
for i = 1:size(idx,1)
    A(x(i),y(i)) = idx(i);
end

figure
imagesc(A)
hold on
for i = 1:k
    text(C(i,2), C(i,1), num2str(i),'FontSize',14,'FontWeight','bold','HorizontalAlignment','center')
end

%%
calwave = zeros(k,size(imagestack,3));

for i = 1:k
    [ix,iy] = find(A == i);
    tmp = zeros(size(ix,1), size(imagestack,3));
    for j = 1:size(ix)
        tmp(j,:) = imagestack(ix(j),iy(j),:);
    end
    calwave(i,:) = mean(tmp);
end

figure
plot(calwave')