function create_data_Memory_Capacity(data_dir, random_seed)
if nargin < 1
    data_dir = [fileparts(which('GlobalMemoryCapacity')) filesep 'Example data Memory Capacity'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isfolder(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasXLS( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.xlsx'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng(random_seed)

    sex_options = {'Female' 'Male'};

    % Group 1
    % 5 modules of 18 nodes each
    % 3 modules of 30 nodes each

    % initialize values for the WS model
    K1 = [3 4 5 6 7];
    K2 = [4 5 7];
    beta1 = [0.02 0.1 0.3 0.5 0.8];
    beta2 = [0.1 0.3 0.8];

    % initialize the indices where the matrices will be placed
    indices1 = {1:18; 19:36; 37:54; 55:72; 73:90};
    indices2 = {1:30; 31:60; 61:90};

    gr1_name = 'CON_MP_Group_1_XLS';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:50 % subject number
        sub_id = ['SubjectCON_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));

        K_temp2 = K2(randperm(length(K2)));
        beta_temp2 = beta2(randperm(length(beta2)));

        % initialize matrix for the subject
        A_full1 = zeros(N);
        A_full2 = zeros(N);

        % loop over each module
        % layer 1
        for i_mod = 1:1:5
            A_full1(indices1{i_mod},indices1{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
        end
        % layer 2
        for i_mod = 1:1:3
            A_full2(indices2{i_mod},indices2{i_mod}) = full(adjacency(WattsStrogatz(30, K_temp2(i_mod), beta_temp2(i_mod))));
        end
        A_full1(1:length(A_full1)+1:numel(A_full1)) = 0;
        A_full2(1:length(A_full2)+1:numel(A_full2)) = 0;

        % make the adjacency matrix weighted
        r = 0 + (0.5 - 0) * rand(size(A_full1));
        diffA = A_full1 - r;
        A_full1(A_full1 ~= 0) = diffA(A_full1 ~= 0);
        r = 0 + (0.5 - 0) * rand(size(A_full2));
        diffA = A_full2 - r;
        A_full2(A_full2 ~= 0) = diffA(A_full2 ~= 0);

        % figure(1)
        % imshow(A_full1)
        % figure(2)
        % imshow(A_full2)

        writetable(array2table(A_full1), [gr1_dir filesep() sub_id '.1.xlsx'], 'WriteVariableNames', false)
        writetable(array2table(A_full2), [gr1_dir filesep() sub_id '.2.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    % reset RNG
    rng(rng_settings_)
end
end

%%% ¡test_functions!
function h = WattsStrogatz(N,K,beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
s = repelem((1:N)',1,K);
t = s + repmat(1:K,N,1);
t = mod(t-1,N)+1;

% Rewire the target node of each edge with probability beta
for source=1:N
    switchEdge = rand(K, 1) < beta;

    newTargets = rand(N, 1);
    newTargets(source) = 0;
    newTargets(s(t==source)) = 0;
    newTargets(t(source, ~switchEdge)) = 0;

    [~, ind] = sort(newTargets, 'descend');
    t(source, switchEdge) = ind(1:nnz(switchEdge));
end

h = graph(s,t);
end