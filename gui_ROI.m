function gui_ROI(img)
[height, width] = size(img);
Green  = [0 0.7 0];
RGB = zeros(height, width, 3);
ROI = zeros(height, width);
old_ROI = ROI;
IMG = img;
TMP = IMG;
TMP_flag = 0;
p = 0;
R_flag = 0;
G_flag = 1;
B_flag = 0;
figure
set(gcf,'Position',[200,200,1000,700]);
ax1 = subplot(12,12,[3,120]);
imshow(RGB,[])
xl = xlim;
yl = ylim;
imageshow()


%% UI object
uicontrol('Style', 'pushbutton', 'String', 'undo',...
    'FontSize',12,....
    'Position', [20 580 100 50],...
    'ForegroundColor', 'b',...
    'Callback', @undo_ROI); 

uicontrol('Style', 'pushbutton', 'String', 'get peripheral',...
    'FontSize',12,....
    'Position', [20 520 100 50],...
    'ForegroundColor', 'b',...
    'Callback', @get_peripheral); 

f_2 = uicontrol('Style', 'pushbutton', 'String', 'get area',...
    'FontSize',12,....
    'Position', [20 400 100 50],...
    'Visible','off',....
    'ForegroundColor','b',...
    'Callback', @get_region); 

uicontrol('Style', 'pushbutton', 'String', 'get line',...
    'FontSize',12,....
    'Position', [20 460 100 50],...
    'ForegroundColor','b',...
    'Callback', @get_road); 

p_1 = uicontrol('Style', 'pushbutton', 'String', 'save',...
    'FontSize',12,....
    'Position', [20 320 100 50],...
    'ForegroundColor','b',...
    'Callback', @save_ROI);  
%%
uicontrol('Style', 'checkbox', 'String', 'show ROI',...
    'Min',0,'Max',1,'Value',0,...
    'FontSize',12,....
    'Position', [20 260 150 50],...
    'ForegroundColor','b',...
    'Callback', @visible_b);  

uicontrol('Style', 'checkbox', 'String', 'show WS',...
    'Min',0,'Max',1,'Value',1,...
    'FontSize',12,....
    'Position', [20 200 150 50],...
    'ForegroundColor', Green,...
    'Callback', @visible_g);  

uicontrol('Style', 'checkbox', 'String', 'show Original',...
    'Min',0,'Max',1,'Value',0,...
    'FontSize',12,....
    'Position', [20 140 150 50],...
    'ForegroundColor','r',...
    'Callback', @visible_r);  

p_2 = uicontrol('Style', 'pushbutton', 'String', 'reset',...
    'FontSize',12,....
    'Position', [20 80 100 50],...
    'ForegroundColor', Green,...
    'Callback', @reset_g); 

pop_1 = uicontrol('Style', 'popup',...
    'String', {'mean filter','threshold','------'},...
    'FontSize',12,....
    'Value',3,...
    'Position', [20 20 100 50],...
    'Callback', @change_method);    
%%
s_p1 = uicontrol('Style', 'slider',...
    'Min',0,'Max',100,'Value',90,...
    'SliderStep',[1/100 1],...
    'Position', [120 20 600 20],...
    'Visible','off',....
    'Callback', @plim); 

t_p1 = uicontrol('Style','text',...
    'Position',[120 45 300 20],...
    'FontSize',12,....
    'Fontweight','bold',.....
    'Visible','off',.........
    'String','パーセンタイル閾値');

t_p2 = uicontrol('Style','text',...
    'Position',[420 45 300 20],...
    'String','未設定',.....
    'Fontweight','bold',.....
    'Visible','off',....
    'FontSize',12);

p_p1 = uicontrol('Style', 'pushbutton', 'String', 'Confirm',...
    'FontSize',12,....
    'Position', [750 20 100 50],...
    'Visible','off',....
    'Callback', @Comfirm_p);  
%%
s_f1 = uicontrol('Style', 'slider',...
    'Min',1,'Max',30,'Value',1,...
    'SliderStep',[1/30 1],...
    'Position', [120 20 600 20],...
    'Visible','off',....
    'Callback', @mean_filter); 

t_f1 = uicontrol('Style','text',...
    'Position',[120 45 300 20],...
    'FontSize',12,....
    'Fontweight','bold',.....
    'Visible','off',.........
    'String','フィルタのサイズ');

t_f2 = uicontrol('Style','text',...
    'Position',[420 45 300 20],...
    'String','未設定',.....
    'Fontweight','bold',.....
    'Visible','off',....
    'FontSize',12);

p_f1 = uicontrol('Style', 'pushbutton', 'String', 'Confirm',...
    'FontSize',12,....
    'Position', [750 20 100 50],...
    'Visible','off',....
    'Callback', @Comfirm_f);  

%%
function visible_r(source,~)
    R_flag = source.Value;
    imageshow()
end

function visible_g(source,~)
    G_flag = source.Value;
    imageshow()
end

function visible_b(source,~)
    B_flag = source.Value;
    imageshow()
end

function save_ROI(~,~)
    save('ROI.mat','ROI','img')
    p_1.String = 'Done!';
    pause(2);
    p_1.String = 'save';
end

function reset_g(~,~)
    IMG = img;
    f_2.Visible = 'off';
    s_p1.Visible = 'off';
    t_p1.Visible = 'off';
    t_p2.Visible = 'off';   
    p_p1.Visible = 'off'; 
    s_f1.Visible = 'off';
    t_f1.Visible = 'off';
    t_f2.Visible = 'off';   
    p_f1.Visible = 'off'; 
    t_p2.String = '未設定';
    t_f2.String = '未設定';
    pop_1.Value = 3;
    imageshow()
end

function change_method(source,~)
    TMP = IMG;
    pop_1.Enable = 'off';
    p_2.Enable = 'off';
    f_2.Visible = 'off';
    if source.Value == 1
        s_p1.Visible = 'off';
        t_p1.Visible = 'off';
        t_p2.Visible = 'off';   
        p_p1.Visible = 'off';  
        s_f1.Visible = 'on';
        t_f1.Visible = 'on';
        t_f2.Visible = 'on';
        p_f1.Visible = 'on';  
        s_f1.Enable = 'on';
        p_f1.Enable = 'on'; 
    elseif source.Value == 2       
        s_p1.Visible = 'on';
        t_p1.Visible = 'on';
        t_p2.Visible = 'on';
        p_p1.Visible = 'on';  
        s_f1.Visible = 'off';
        t_f1.Visible = 'off';
        t_f2.Visible = 'off';   
        p_f1.Visible = 'off'; 
        s_p1.Enable = 'on';
        p_p1.Enable = 'on'; 
    else
        pop_1.Enable = 'on';
        s_p1.Visible = 'off';
        t_p1.Visible = 'off';
        t_p2.Visible = 'off';
        p_p1.Visible = 'off';  
        s_f1.Visible = 'off';
        t_f1.Visible = 'off';
        t_f2.Visible = 'off';   
        p_f1.Visible = 'off'; 
        s_p1.Enable = 'off';
        p_p1.Enable = 'off'; 
    end
end

function plim(source,~)
    TMP_flag = 1;
    p = round(source.Value);
    t_p2.String = ['p=', num2str(p)];
    TMP = img > prctile(IMG(:), p);
    imageshow()
end

function Comfirm_p(~,~)
    pop_1.Enable = 'on';
    p_2.Enable = 'on';
    TMP_flag = 0;
    IMG = TMP;
    f_2.Visible = 'on';
    s_p1.Enable = 'off';
    p_p1.Enable = 'off'; 
    imageshow()
end

function mean_filter(source,~)
    TMP_flag = 1;
    Fsize = round(source.Value);
    t_f2.String = ['s=', num2str(Fsize)];
    TMP = filter2(fspecial('average', Fsize), IMG);
    imageshow()
end

function Comfirm_f(~,~)
    pop_1.Enable = 'on';
    p_2.Enable = 'on';
    TMP_flag = 0;
    IMG = TMP;
    s_f1.Enable = 'off';
    p_f1.Enable = 'off'; 
    imageshow()
end

function imageshow() 
    RGB(:,:,1) = img * R_flag;
    if TMP_flag == 1
        if islogical(TMP)
            RGB(:,:,2) = TMP * 2^6 * G_flag;
        else
            RGB(:,:,2) = TMP * G_flag;
        end
    elseif islogical(IMG)
        RGB(:,:,2) = IMG * 2^6 * G_flag;
    else
        RGB(:,:,2) = IMG * G_flag;
    end
    RGB(:,:,3) = ROI * 2^6 * B_flag;
    xl = xlim;
    yl = ylim;
    cla(ax1);
    ax1 = subplot(12,12,[3,120]);
    imshow(RGB,[])
    xlim(xl);
    ylim(yl);
end

function undo_ROI(~,~)
    ROI = old_ROI;
    imageshow()
end

function get_peripheral(~,~)
    old_ROI = ROI;
    ROI = filter2(fspecial('average', 3), ROI) > 0;
    imageshow()
end

function get_region(~,~)
    xl = xlim;
    yl = ylim;
    fig1 = figure;
    RGB(:,:,1) = img;
    RGB(:,:,2) = IMG * 2^6;
    RGB(:,:,3) = ROI * 2^6;
    imshow(RGB,[])
    xlim(xl);
    ylim(yl);
    m = msgbox({'取得したい領域をクリックしてください'});
    uiwait(m)
    [py,px] = ginput(1);
    x = round(px);
    y = round(py);
    id = find_connected_space(x,y,IMG);
    if size(id,1) > 0
        old_ROI = ROI;
        for i = 1:size(id,1)
            ROI(id(i,1),id(i,2)) = 1;
        end
    else
        m1 = msgbox('有効領域(緑)外が選択されました');
        uiwait(m1)
    end
    close(fig1)
    imageshow() 
end

function get_road(~,~)
    xl = xlim;
    yl = ylim;
    fig2 = figure;
    RGB(:,:,1) = img;
    RGB(:,:,2) = img;
    RGB(:,:,3) = ROI * 2^6;
    imshow(RGB,[])
    xlim(xl);
    ylim(yl);
    m = msgbox({'2方向探索を行います','開始点と終了点をクリックしてください'});
    uiwait(m)
    [py,px] = ginput(2);
    x = round(px);
    y = round(py);
    Start = [x(1), y(1)];
    End = [x(2), y(2)];
    ANS = find_road_2direction(img, Start, End);
    Road = zeros(size(img,1), size(img,2));
    pos = Start;
    D = ANS.road;
    for i = 1:size(D,2)
        if D(i) == 1
            pos(1) = pos(1) + 1 * sign(End(1)-Start(1));
        elseif D(i) == 10
           pos(2) = pos(2) + 1 * sign(End(2)-Start(2));
        end
        Road(pos(1), pos(2)) = 1;
    end
    old_ROI = ROI;
    ROI = (ROI + Road) > 0;
    close(fig2)
    imageshow() 
end

end

