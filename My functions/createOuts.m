function X = createOuts(N, mov)
    X = zeros(N*mov,mov);
    for jj = 1:mov
        X((1:N) + N*(jj-1),jj) = 1;
    end
end