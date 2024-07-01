%% ¡header!
NodalMemoryCapacity < Measure (m, nodal memory capacity) is the graph NodalMemoryCapacity.

%%% ¡description!
The nodal memory capacity measures how well a given node manages to encode a random input signal applied to itself.
This nodal memory capacity is determined by training the nodal output to reproduce delayed input time series 
and comparing the delayed input with the reservoir output across the given node. 
A high memory capacity indicates that the node has high capacity to remember and process the temporal 
information contained in the input signal applied to this node. 

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.TRIALS
%%%% ¡title!
Measure TRIALS

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.TRAINING_SAMPLES
%%%% ¡title!
Measure TRAINING_SAMPLES

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.TAU_MAX
%%%% ¡title!
Measure TAU_MAX

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.N_LOWER
%%%% ¡title!
Measure DATA_DIMENSION

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.DENSITY
%%%% ¡title!
Measure DENSITY

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.M
%%%% ¡title!
Nodal Memory Capacity

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the NodalMemoryCapacity.
%%%% ¡default!
'NodalMemoryCapacity'

%%% ¡prop!
NAME (constant, string) is the name of the NodalMemoryCapacity.
%%%% ¡default!
'NodalMemoryCapacity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the NodalMemoryCapacity.
%%%% ¡default!
'Nodal memory capacity is calculated using reservoir computing, which is is a recurrent neural-network model. More details about the calculation can be found at: Mijalkov et al. Computational memory capacity predicts aging and cognitive decline. (2024).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the NodalMemoryCapacity.
%%%% ¡settings!
'NodalMemoryCapacity'

%%% ¡prop!
ID (data, string) is a few-letter code of the NodalMemoryCapacity.
%%%% ¡default!
'NodalMemoryCapacity ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the NodalMemoryCapacity.
%%%% ¡default!
'NodalMemoryCapacity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the NodalMemoryCapacity.
%%%% ¡default!
'NodalMemoryCapacity notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU'}

%%% ¡prop!
M (result, cell) is the NodalMemoryCapacity.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
tmp_data = g.get('A');  % cell with the subjects data
if isempty(tmp_data)
    value = {};
    return;
end
for i = 1:size(tmp_data, 1)
    data{i} = tmp_data{i, i};
end
global_mc = cell(g.get('LAYERNUMBER'), 1);

% parameters
trials = m.get('TRIALS');
T = m.get('TRAINING_SAMPLES');
tau_max = m.get('TAU_MAX');
N = size(data{1}, 1);
n = m.get('N_LOWER');
density = m.get('DENSITY');

% initialize
subjects = size(data, 2);  % Number of subjects
data_alltrial_MCs = cell(1, trials);  % Initialize structure - each element holds data for each trial

for trial = 1:1:trials
    input_data = rand(1, T);  % input data
    
    % input-to-reservoir weight matrix
    W_in = normrnd(0, 1, N, n);
    Wsing = svd(W_in);
    W_in = W_in * (1 / Wsing); % Set maximal singular value of W_in to 1

    MCs_tau_sub = zeros(tau_max, N, subjects);  % Initialize array for MC for all subjects at given tau
     
    for subject = 1:1:subjects
        W = data{1, subject};  % Data for the corresponding subject

        % Skip matrices with NaN values
        if ~isempty(find(isnan(W)))
            disp('W contains NaN values, skipping..')
            break
        end

        % Normalize reservoir weight matrix to have maximal singular value 1
        sr = max(svd(W));
        if sr == 0
            disp('Sing. val. equal to zero, skipping..')
            break
        end
        W = W / sr;

        % Compute memory capacity
        MC_tau = calculate_MCnodal(W, W_in, tau_max, input_data, 0, 0);

        % Store memory capacity for each subject
        MCs_tau_sub(:, :, subject) = MC_tau;

    end

    % Place the values into the array
    data_alltrial_MCs{1, trial} = MCs_tau_sub;
end

% Average across the trials
MC_values = zeros(N, subjects);
MC_tmp = zeros(size(data_alltrial_MCs{1}));
for i_trial = 1:1:length(data_alltrial_MCs)
    MC_tmp = MC_tmp + data_alltrial_MCs{i_trial};
end
MC_tmp = MC_tmp ./ length(data_alltrial_MCs);

for i_sub = 1:1:subjects
    % matrix for each subject
    tmp_submatrix = MC_tmp(:,:, i_sub);
    MC_values(:, i_sub) = sum(tmp_submatrix, 1)';
end

value = MC_values;
%%%% ¡calculate_callbacks!
function MC_tau = calculate_MCnodal(W, W_in, tau_max, input_data, ridge, verbose)
    N = size(W, 1);  % Network dimension
    T = size(input_data, 2);  % Training samples
    TRANSIENT = floor(0.05 * T);  % Transient so that reservoir dynamics are not affected by initial value
    
    % Initialize training data
    X = input_data;
    X_train = X(1, tau_max + 1:end); % Train reservoir on data starting from tau_max + 1
    T_train = size(X_train, 2);
    
    % Initialize reservoir states
    r = zeros(N, 1);
    R = zeros(N, T_train);
    
    % Run dynamics
    for t = 1:1:T_train
        b = W * r + W_in * X_train(t);
    
        r = tanh(b);
        R(:,t) = r;
    end
    
    % Train network for different delays
    MC_tau = zeros(tau_max, N);  % Initialize MC_tau: no delays x no of nodes
    tau_idx = 1;
    for tau = tau_max:-1:1
        % Set target to be training data shifted by tau back in time
        y = X(1, tau : 1 : (T - (tau_max - tau) - 1));
    
        % Remove transient
        y_f = y(1, TRANSIENT:1:end);
        R_tmp = R(:, TRANSIENT:1:end);
    
        % Consider each node
        for i_node = 1:1:N
            % output corresponding to this node
            R_f = R_tmp(i_node, :);
    
            % Compute W_out for given delay tau using ridge regression (linear regression if ridge = 0)
            term_A = y_f * R_f';
            term_B = pinv(R_f * R_f', 1e-15);  % remove the rigde term for nodal
            W_out = term_A * term_B;
    
            % Compute output of reservoir using W_out
            y_pred = W_out * R_f;
    
            % Compute correlation between output and delayed input
            MC_tau(tau_idx, i_node) = corr(y_f', y_pred');
        end
    
        if verbose
            disp(['MC (τ = ' num2str(tau_idx) ') = ' num2str(MC_tau(tau_idx))])
        end
        tau_idx = tau_idx + 1;
    end
end

%% ¡props!
%%% ¡prop!
TRIALS (parameter, scalar) is the number of trials.
%%%% ¡default!
10

%%% ¡prop!
TRAINING_SAMPLES (parameter, scalar) is the number of training samples (length of input time series).
%%%% ¡default!
20000

%%% ¡prop!
TAU_MAX (parameter, scalar) is the maximum delay to be considered.
%%%% ¡default!
50

%%% ¡prop!
N_LOWER (parameter, scalar) is the dimension of the data (number of nodes for nodal memory capacity).
%%%% ¡default!
1

%%% ¡prop!
DENSITY (parameter, scalar) is the density.
%%%% ¡default!
1

%% ¡tests!

%%% ¡excluded_props!
[NodalMemoryCapacity.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = rand(10);  % create random matrix 0-1
B(1:length(B)+1:numel(B)) = 0;  % remove diagonal
g = GraphWU('B', B);
mc_nodal = g.get('MEASURE', 'NodalMemoryCapacity');  % calculate nodal memory capacity
result = mc_nodal.get('M');