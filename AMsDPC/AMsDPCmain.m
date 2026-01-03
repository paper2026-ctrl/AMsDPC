fileName = 'R15.txt';
X=load(fileName);
true_labels = X(:, end);
data = X(:, 1:end-1);
data = (data - min(data)) ./ (max(data) - min(data));
dist = pdist2(data, data);
n = size(dist, 1);
K = 15;
[~, KNN] = mink(dist, K+1, 2);
KNN = KNN(:, 2:end);
[rho] = calculateRho(dist,K);
[delta] = calculateDistance(dist,rho);
[lambda] = calculateConnectivity(dist,KNN,K);
knn_lambda = lambda(KNN);
lambda_std = zeros(n, 1);
for i = 1:n
    knn_lambda_i = knn_lambda(i, :);
    if length(unique(knn_lambda_i)) > 1
        lambda_std(i) = std(knn_lambda_i);
    else
        lambda_std(i) = 0.1 * mean(knn_lambda_i);
    end
end
rho_mean = mean(rho);
delta_mean = mean(delta);
candidate_indices = find(rho > rho_mean & delta > delta_mean);
n_cores = length(candidate_indices);
dist_cores = dist(candidate_indices, candidate_indices);
maxdist_cores = max(dist_cores(:));
S_cores = maxdist_cores - dist_cores;
S_cores(1:n_cores+1:end) = 0;  
L_cores = S_cores / maxdist_cores;
core_cluster_labels = threshold_merging(L_cores, 1.5);
labels = zeros(n, 1);
labels(candidate_indices) = core_cluster_labels;
[labels] = Dual_tierExpansion(labels, candidate_indices, core_cluster_labels, ...
                                          KNN, lambda, lambda_std, K);
[labels] = remaining(labels,dist,rho);
[ ARI, NMI, Purity] = evaluation(true_labels, labels, n, 1);