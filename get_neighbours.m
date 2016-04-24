function neighbours = get_neighbours(matrix, row, column)
[s1, s2] = size(matrix);
neighbours = [];
for i = row-1:row+1
    for j = column-1:column+1
        if (i > 0 && j > 0 && i <= s1 && j <= s2 && (i ~= row || j ~= column))
            neighbours = [neighbours, matrix(i, j)];
        end;
    end;
end;
end

