function [delta] = calculateDistance(dist,rho)
 n = size(dist, 1);
   
    [~, rho_order] = sort(rho, 'descend');
    delta = zeros(n, 1);
    max_dist = max(dist(:));
    for i = 2:n
        higher_idx = rho_order(1:i-1);
        [delta(rho_order(i)), ~] = min(dist(rho_order(i), higher_idx));
    end
    delta(rho_order(1)) = max_dist;
end

