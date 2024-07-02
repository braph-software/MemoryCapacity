%% ¡header!
NodalMemoryCapacity < Measure (m, nodal memory capacity) is the graph NodalMemoryCapacity.

%%% ¡description!
The nodal memory capacity measures how well a given node manages to encode a random input signal applied to itself.
This nodal memory capacity is determined by training the nodal output to reproduce delayed input time series 
and comparing the delayed input applied to the given node with its output. 
A high memory capacity indicates that the node has high capacity to remember and process the temporal 
information contained in the input signal. 

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
Measure MAXIMUM_DELAY

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.M
%%%% ¡title!
NodalMemoryCapacity

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
M (result, cell) is the average nodal memory capacity across all trials.
%%%% ¡calculate!
mc_all_trials = m.get('MC_ALL_TRIALS');
if isempty(mc_all_trials)
    m_value = {};
else
    summed_mc_all_trials = cellfun(@(mc_all_delays) sum(mc_all_delays, 1), mc_all_trials, 'UniformOutput', false);
    m_value = {mean(cell2mat(summed_mc_all_trials'))};
    m_value = m_value';
end
value = m_value;

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
35

%%% ¡prop!
MC_ALL_TRIALS (result, cell) is the nodal memory capacity at all trials.
%%%% ¡calculate!
trials = m.get('TRIALS');
T = m.get('TRAINING_SAMPLES');
tau_max = m.get('TAU_MAX');
conn_matrix = cell2mat(m.get('G').get('A'));
N = size(conn_matrix, 1);

if isequal(N, 0)
    mc_all_trials = {};
else
    for i = 1:trials
        input_data = rand(1, T);  % input data

        % input-to-reservoir weight matrix
        W_in = normrnd(0, 1, N, 1);
        Wsing = svd(W_in);
        W_in = W_in * (1 / Wsing);  % Normalize: Set maximal singular value of W_in to 1

        W = conn_matrix;  % Data for the corresponding subject

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

        mc_all_trials{i} = m.get('MC_CALC', W, W_in, tau_max, input_data, 0, 0);
    end
end

value = mc_all_trials;

%%% ¡prop!
MC_CALC (query, cell) calculates nodal memory capacity, given weighted connectivity matrix, input signal and maximum delay.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
W = varargin{1};
W_in = varargin{2};
tau_max = varargin{3};
input_data = varargin{4};
ridge = varargin{5};
verbose = varargin{6};

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

value = MC_tau;

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