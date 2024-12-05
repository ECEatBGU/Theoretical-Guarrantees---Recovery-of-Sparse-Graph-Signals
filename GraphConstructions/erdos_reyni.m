function L=erdos_reyni(G)
% Parameters
numNodes = G.N;      % Number of nodes
edgeProbability = G.p;  % Probability of edge creation

% Generate an Erdős-Rényi random graph
adjacencyMatrix = rand(numNodes) < edgeProbability;
adjacencyMatrix = triu(adjacencyMatrix, 1);  % Upper triangle without diagonal
adjacencyMatrix = adjacencyMatrix + adjacencyMatrix';  % Symmetric adjacency matrix

% Create a graph object
randomGraph = graph(adjacencyMatrix);

% Calculate degrees
nodeDegrees = degree(randomGraph);

%compute Laplacian
D=adjacencyMatrix*ones(numNodes,1);
L=diag(D)-adjacencyMatrix;

if ~G.quiet
% Plot the graph
figure;
plot(randomGraph);
title('Erdős-Rényi Random Graph');
xlabel('Node Index');
ylabel('Node Index');

% Display nodal degrees
disp('Nodal Degrees:');
disp(nodeDegrees);

% Display minimal and maximal nodal degrees
disp(['Minimal Nodal Degree: ', num2str(min(nodeDegrees))]);
disp(['Maximal Nodal Degree: ', num2str(max(nodeDegrees))]);
end

end