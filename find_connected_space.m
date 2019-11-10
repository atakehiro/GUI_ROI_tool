function f = find_connected_space(x,y,matrix)

list = [x,y];
Land = zeros(size(matrix,1), size(matrix,2));


while isempty(list) < 1
    pos = list(1,:);
    list(1,:) = [];
    if matrix(pos(1),pos(2)) > 0
        
        Land(pos(1),pos(2)) = 1;
        
        if pos(1) > 1
            a = pos - [1, 0];
            if Land(a(1),a(2)) < 1
                list = [list;a];
            end
        end
        
        if pos(1) < size(matrix,1)
            a = pos + [1, 0];
            if Land(a(1),a(2)) < 1
                list = [list;a];
            end
        end
        
        if pos(2) > 1
            a = pos - [0, 1];
            if Land(a(1),a(2)) < 1 
                list = [list;a];
            end
        end
        
        if pos(2) < size(matrix,2)
            a = pos + [0, 1];
            if Land(a(1),a(2)) < 1
                list = [list;a];
            end
        end   
    end
    list = unique(list,'rows');
end

[m,n] = find(Land);
f = [m,n];
end