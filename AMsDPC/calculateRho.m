function [rho] = caculateRho(dist,K)
     n = size(dist, 1);
    [K_nearest_dists, idx] = mink(dist, K+1, 2);
    K_nearest_dists = K_nearest_dists(:, 2:end);
    rho = sum(exp(-(K_nearest_dists / K).^2), 2);
end

