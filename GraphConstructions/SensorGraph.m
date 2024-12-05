function [L,W] = SensorGraph(N, gamma, theta)
   
    

   % Adjust the space size based on the number of nodes
    space_side = (N^2); % Scale space by sqrt(N)

    % Generate N random 2D Euclidean locations
    locations = space_side*rand(N, 2);
    
    gamma=(1/4)*((space_side)^(1/2))*gamma;
    theta=space_side*theta;
   

    % Initialize adjacency matrix for the graph
    W = zeros(N);
    
    % Function to calculate adjacency matrix with given locations
    function G = calculate_adjacency(locations)
        G = zeros(N);
        for i = 1:N
            for j = i+1:N
                dist = norm(locations(i, :) - locations(j, :));
                if dist < gamma
                    weight = exp(-(dist^2) / (2 * theta^2));
                    G(i, j) = weight;
                    G(j, i) = weight;
                end
            end
        end
    end

    % Update adjacency matrix
    W = calculate_adjacency(locations);

    % Check if the graph is connected
    while numel(unique(conncomp(graph(W)))) > 1
        % Find isolated nodes and move them
        temp=conncomp(graph(W));
        isolated_nodes = find(temp~=mode(temp));
        if ~isempty(isolated_nodes)
            % Move isolated nodes to new random positions
            locations(isolated_nodes, :) = sqrt(space_side)*rand(length(isolated_nodes), 2);
        end
        % Recalculate adjacency matrix with updated locations
        W = calculate_adjacency(locations);
    end

    %compute Laplacian
    D=W*ones(N,1);
    L=diag(D)-W;


    
   
end