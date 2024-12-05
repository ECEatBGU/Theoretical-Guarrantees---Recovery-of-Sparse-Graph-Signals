function L=RegularGraph(G)

numNodes = G.N;  % Number of nodes
degree = G.D;    % Degree of each node (must be even and less than numNodes)

% Create a ring lattice (regular graph)
adjacencyMatrix = zeros(numNodes);
for i = 1:numNodes
    for j = 1:degree/2
        adjacencyMatrix(i, mod(i+j-1, numNodes)+1) = 1;
        adjacencyMatrix(mod(i+j-1, numNodes)+1, i) = 1;
    end
end

% Create a graph object
regularGraph = graph(adjacencyMatrix);

D=adjacencyMatrix*ones(numNodes,1);
L=diag(D)-adjacencyMatrix;
% Calculate degrees

if ~G.quiet
% Plot the graph
figure;
plot(regularGraph);
title('Regular Graph');
xlabel('Node Index');
ylabel('Node Index');

% Display nodal degrees
disp('Nodal Degrees:');
disp(D);

% Display minimal and maximal nodal degrees
disp(['Minimal Nodal Degree: ', num2str(min(D))]);
disp(['Maximal Nodal Degree: ', num2str(max(D))]);

end