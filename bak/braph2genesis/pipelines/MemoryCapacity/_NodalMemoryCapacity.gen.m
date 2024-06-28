%% ¡header!
NodalMemoryCapacity < Measure (m, nodal memory capacity) is the graph NodalMemoryCapacity.

%%% ¡description!
Fix this Mite

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
Measure N_LOWER

%%% ¡prop!
%%%% ¡id!
NodalMemoryCapacity.DENSITY
%%%% ¡title!
Measure DENSITY

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
'Fix this Mite'

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
{'MultiplexWU'}

%%% ¡prop!
M (result, cell) is the NodalMemoryCapacity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
tmp_data = g.get('A'); % cell with the subjects data
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
% Number of subjects
subjects = size(data, 2);
% Initialize structure - each element holds data for each trial
data_alltrial_MCs = cell(1, trials);

for trial = 1:trials

    % input data
    input_data = rand(1, T);

    % input-to-reservoir weight matrix
    W_in = normrnd(0, 1, N, n);
    Wsing = svd(W_in);
    W_in = W_in * (1/Wsing); % Set maximal singular value of W_in to 1

    % Initialize array to hold tau values for all subjects for this trial
    MCs_tau_sub = zeros(tau_max, N, subjects);

    for subject = 1:subjects

        % Get the data for the corresponding subject
        W = data{1, subject};

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

% split
for i = 1:size(data, 2)
    tmp_layer_val{i} = cellfun(@(x) x(:,:,i), data_alltrial_MCs, 'UniformOutput',false);
end

%average
for i = 1:size(data, 2)
    tmp_trials = tmp_layer_val{i};
    mean_val_layer{i} =  mean(cat(ndims(tmp_trials{1}) + 1, tmp_trials{:}), ndims(tmp_trials{1}) + 1);
end

value = mean_val_layer;
%%%% ¡calculate_callbacks!
function MC_tau = calculate_MCnodal(W,W_in,tau_max,input_data, ridge,verbose)
% Network dimension
N = size(W, 1);

% Parameters
T = size(input_data, 2); % Training samples
TRANSIENT = floor(0.05*T); % Transient so that reservoir dynamics are not affected by initial value

% Initialize training data
X = input_data;
X_train = X(1, tau_max+1:end); % Train reservoir on data starting from tau_max + 1
T_train = size(X_train, 2);

% Set activation function
% tanh

% Initialize reservoir states
r = zeros(N, 1);
R = zeros(N, T_train);

% Run dynamics and save reservoir states
for t = 1:1:T_train
    b = W * r + W_in * X_train(t);

    r = tanh(b);
    R(:,t) = r;
end

% Train network for different delays
% MC_tau will be number of delays x number of nodes array
MC_tau = zeros(tau_max, N);
tau_idx = 1;

% for loop to come here
for tau = tau_max:-1:1

    % Set target to be training data shifted by tau back in time
    y = X(1, tau : 1 : (T-(tau_max-tau)-1));

    % Remove transient
    y_f = y(1, TRANSIENT:1:end);
    R_tmp = R(:, TRANSIENT:1:end);

    % Loop over each node and get the output from that node to reconstruct
    for i_node = 1:1:N

        % output corresponding to this node
        R_f = R_tmp(i_node, :);

        % Compute W_out for given delay tau using
        % ridge regression (linear regression if ridge = 0)
        term_A = y_f*R_f';
        term_B = pinv(R_f*R_f', 1e-15); % remove the rigde term for nodal
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
TRAINING_SAMPLES (parameter, scalar) is the number of training samples.
%%%% ¡default!
20000

%%% ¡prop!
TAU_MAX (parameter, scalar) is the number of tau.
%%%% ¡default!
50

%%% ¡prop!
N_LOWER (parameter, scalar) is the n lower.
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
example test
%%%% ¡probability!
.01
%%%% ¡code!
test_MC('nodal')