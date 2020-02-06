% tif fileの先頭の画像を読み取ってROI取りGUIを起動する。
% F5または実行ボタンで実行
% 画像は 8 bitまたは 16 bitのグレースケール画像
%%
% Copyright:
% 2019, Takehiro Ajioka; 
% License: MIT License
%%
addpath('function')
tic
[file, file_path] = uigetfile('*.tif');
file_info = imfinfo([file_path, file]);
d1 = file_info(1).Height;
d2 = file_info(1).Width;
bit = file_info(1).BitDepth;
t = 1;
image = double(imread([file_path, file], t));
disp('データ読み取り完了')
%%
img =  image /(2^(bit + 8)) * (2^8); %cast(image,'uint32')
gui_ROI(img)

