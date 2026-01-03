function [labels] = remaining(labels,dist,rho)
    if isempty(remaining_unassigned)
        fprintf(' All points have been  allocated.\n');
        return;
    end
    [~, rho_sort_idx] = sort(rho(remaining_unassigned), 'descend');
    sorted_remaining = remaining_unassigned(rho_sort_idx);
    for i = 1:length(sorted_remaining)
        current_point = sorted_remaining(i);
        assigned_points = find(labels ~= 0);
        
        if isempty(assigned_points)
            continue;
        end
        distances = dist(current_point, assigned_points);
        [~, min_idx] = min(distances);
        nearest_assigned = assigned_points(min_idx);
        nearest_cluster = labels(nearest_assigned);
        labels(current_point) = nearest_cluster;
    end
end

