function [lambda] = calculateConnectivity(dist,KNN,K)
 n = size(dist, 1);
    i_indices = repmat((1:n)', 1, K);
    j_indices = KNN;
    values = ones(n*K, 1);
    RNN_sparse = sparse(i_indices(:), j_indices(:), values, n, n);
    RNN_size = sum(RNN_sparse, 1)';
    RNN_dist_sum = zeros(n, 1);
    for j = 1:n
        RNN_j = find(RNN_sparse(:, j));
        if ~isempty(RNN_j)
            RNN_dist_sum(j) = sum(dist(j, RNN_j));
        end
    end
    lambda = zeros(n, 1);
    for i = 1:n
        lambda_prime = RNN_size(i) / K;
        RNN_i = find(RNN_sparse(:, i));
        if ~isempty(RNN_i)
            numerator = min(RNN_dist_sum(RNN_i));
            denominator = sum(dist(i, RNN_i));
            gamma_val = numerator / denominator;
        else
            gamma_val = 0;
        end
        lambda(i) = lambda_prime * gamma_val;
    end
end

