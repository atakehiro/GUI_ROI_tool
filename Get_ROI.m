% tif file�̐擪�̉摜��ǂݎ����ROI���GUI���N������B
% F5�܂��͎��s�{�^���Ŏ��s
% �摜�� 8 bit�܂��� 16 bit�̃O���[�X�P�[���摜
%%
% Copyright:
% 2019, Takehiro Ajioka; 
% License: MIT License
%%
tic
[file, file_path] = uigetfile('*.tif');
file_info = imfinfo([file_path, file]);
d1 = file_info(1).Height;
d2 = file_info(1).Width;
bit = file_info(1).BitDepth;
t = 1;
image = double(imread([file_path, file], t));
disp('�f�[�^�ǂݎ�芮��')
%%
img =  image /(2^(bit + 8)) * (2^8); %cast(image,'uint32')
gui_ROI(img)

