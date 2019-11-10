function f = find_road_2direction(raw_matrix, Start, End)

pre_matrix = raw_matrix(min(Start(1),End(1)):max(Start(1),End(1)),min(Start(2),End(2)):max(Start(2),End(2)));

if Start(1) > End(1)
    Start(1) = Start(1) - End(1) + 1;
    End(1) = 1;
elseif End(1) > Start(1)
    End(1) = End(1) - Start(1) + 1;
    Start(1) = 1;
else
    Start(1) = 1;
    End(1) = 1;
end

if Start(2) > End(2)
    Start(2) = Start(2) - End(2) + 1;
    End(2) = 1;
elseif End(2) > Start(2)
    End(2) = End(2) - Start(2) + 1;
    Start(2) = 1;
else
    Start(2) = 1;
    End(2) = 1;
end

%%
MAX = max(pre_matrix(:));
matrix = MAX * ones(size(pre_matrix,1), size(pre_matrix,2)) - pre_matrix;

%%
if End(1) > Start(1)
    dx = 1;
else
    dx = -1;
end
if End(2) > Start(2)
    dy = 1;
else
    dy = -1;
end

%% greedyƒAƒ‹ƒSƒŠƒYƒ€
Sum = 0;
R = zeros(size(matrix,1), size(matrix,2));
pos = Start;
ROAD = [];
X = abs(End(1) - Start(1));
Y = abs(End(2) - Start(2));
while X > 0 || Y > 0
    a = pos + [dx, 0];
    b = pos + [0, dy];
    if X == 0
        pos = b;
        ROAD = [ROAD, 10];
        Y = Y - 1;
    elseif Y == 0
        pos = a;
        ROAD = [ROAD, 1];
        X = X - 1;
    elseif matrix(a(1), a(2)) > matrix(b(1), b(2))
        pos = a;
        ROAD = [ROAD, 1];
        X = X - 1;
    else
        pos = b;
        ROAD = [ROAD, 10];
        Y = Y - 1;
    end
    R(pos(1), pos(2)) = 1;
    Sum = Sum + matrix(pos(1), pos(2));
end

%% •ªŠòŒÀ’è–@‚É‚æ‚é’Tõ
List.pos = Start;
List.road = [];
List.sum = 0;
minSum = Sum;
while size(List,2) > 0
    pos = List(1).pos;
    pSum = List(1).sum;
    proad = List(1).road;
    List(1) = [];
    if pos(1) == End(1) && pos(2) == End(2) && pSum < minSum
        minSum = pSum;
        ANS.sum = pSum;
        ANS.road = proad;
    end
    if (pos(1) > 1 && dx < 0) || (pos(1) < size(matrix,1) && dx > 0)
        if pSum + matrix(pos(1)+dx, pos(2)) < minSum
            A.pos = [pos(1)+dx, pos(2)];
            A.sum = pSum + matrix(pos(1)+dx, pos(2));
            A.road = [proad, 1];
            List = [List;A];
        end
    end
    if (pos(2) > 1 && dy < 0) || (pos(2) < size(matrix,2) && dy > 0)
        if pSum + matrix(pos(1), pos(2) + dy) < minSum
            A.pos = [pos(1), pos(2) + dy];
            A.sum = pSum + matrix(pos(1), pos(2) + dy);
            A.road = [proad, 10];
            List = [List;A];
        end
    end
    T = struct2table(List);
    [~, ia, ic] = unique(T.pos,'rows','stable');
    TMP = [];
    for i = 1:size(ia)
        B = List(ic == i);
        T = struct2table(B);
        [~, id] = min(T.sum);
        TMP = [TMP;B(id)];
    end
    List =  TMP;
end

f = ANS;

end