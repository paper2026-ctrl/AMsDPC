function [labels] = Dual_tierExpansion(labels, candidate_indices, core_cluster_labels, ...
                                        KNN, lambda, lambda_std, K)
  
 [labels, core_points] = label_propagation(labels, candidate_indices, core_cluster_labels, ...
                                               KNN, lambda, lambda_std, K);
 labels = core_diffusion(labels, core_points, KNN, dist, lambda, K);
 end

