%% ¡header!
GlobalMemoryCapacity < Measure (m, global memory capacity) is the graph GlobalMemoryCapacity.

%%% ¡description!
The global memory capacity measures how well a network manages to encode a random input signal in its reservoir.
This global memory capacity is determined by training the network output to reproduce delayed input time series 
and comparing the delayed input with the reservoir output across all reservoir nodes. 
A high memory capacity indicates that the network has high capacity to remember and process the temporal 
information contained in the input signal. 

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.TRIALS
%%%% ¡title!
Measure TRIALS

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.TRAINING_SAMPLES
%%%% ¡title!
Measure TRAINING_SAMPLES

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.TAU_MAX
%%%% ¡title!
Measure MAXIMUM_DELAY

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.N_LOWER
%%%% ¡title!
Measure DATA_DIMENSION

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.M
%%%% ¡title!
GlobalMemoryCapacity

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
GlobalMemoryCapacity.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the GlobalMemoryCapacity.
%%%% ¡default!
'GlobalMemoryCapacity'

%%% ¡prop!
NAME (constant, string) is the name of the GlobalMemoryCapacity.
%%%% ¡default!
'GlobalMemoryCapacity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the GlobalMemoryCapacity.
%%%% ¡default!
'Global memory capacity is calculated using reservoir computing, which is is a recurrent neural-network model. More details about the calculation can be found at: Mijalkov et al. Computational memory capacity predicts aging and cognitive decline. (2024).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the GlobalMemoryCapacity.
%%%% ¡settings!
'GlobalMemoryCapacity'

%%% ¡prop!
ID (data, string) is a few-letter code of the GlobalMemoryCapacity.
%%%% ¡default!
'GlobalMemoryCapacity ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the GlobalMemoryCapacity.
%%%% ¡default!
'GlobalMemoryCapacity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the GlobalMemoryCapacity.
%%%% ¡default!
'GlobalMemoryCapacity notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.GLOBAL

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
M (result, cell) is the GlobalMemoryCapacity.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
tmp_data = g.get('A');  % cell with the subjects data
if isempty(tmp_data)
    value = {};
    return;
end
for i = 1:1:size(tmp_data, 1)
    data{i} = tmp_data{i, i};
end
global_mc = cell(g.get('LAYERNUMBER'), 1);

% parameters
trials = m.get('TRIALS');  
T = m.get('TRAINING_SAMPLES');
tau_max = m.get('TAU_MAX');  
N = size(data{1}, 1);
n = m.get('N_LOWER');

% initialize
subjects = size(data, 2);  % Number of subjects
data_alltrial_MCs = cell(1, trials);  % Initialize structure - each element holds data for each trial

for trial = 1:1:trials
    input_data = rand(1, T);  % input data

    % input-to-reservoir weight matrix
    W_in = normrnd(0, 1, N, n);
    Wsing = svd(W_in);
    W_in = W_in * (1 / Wsing);  % Normalize: Set maximal singular value of W_in to 1

    MCs_tau_sub = zeros(tau_max, subjects);  % Initialize array for MC for all subjects at given tau

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
        MC_tau = calculate_MCglobal(W, W_in, tau_max, input_data, 0, 0);

        % Store memory capacity for each subject
        MCs_tau_sub(:, subject) = MC_tau;

    end

    % Place the values into the array
    data_alltrial_MCs{1, trial} = MCs_tau_sub;
end

    % Extract the values as average of all trials
    MC_values = zeros(size(data_alltrial_MCs(1)));
    for i_trial = 1:1:length(data_alltrial_MCs)
        MC_values = MC_values + data_alltrial_MCs{i_trial};
    end
    MC_values = MC_values ./ length(data_trial);  % calculate average

value = transpose(sum(MC_values,1));

%%%% ¡calculate_callbacks!
function MC_tau = calculate_MCglobal(W, W_in, tau_max, input_data, ridge, verbose)
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
    MC_tau = zeros(tau_max, 1);
    tau_idx = 1;
    for tau = tau_max:-1:1
        % Set target to be training data shifted by tau back in time
        y = X(1, tau:1:(T - (tau_max - tau) - 1));
    
        % Remove transient
        y_f = y(1, TRANSIENT:1:end);
        R_f = R(:, TRANSIENT:1:end);
    
        % Compute W_out for given delay tau using ridge regression (linear regression if ridge = 0)
        term_A = y_f * R_f';
        term_B = pinv(R_f * R_f' + ridge * eye(N), 1e-15);
        W_out = term_A * term_B;
    
        % Compute output of reservoir using W_out
        y_pred = W_out * R_f;
    
        % Compute correlation between output and delayed input
        MC_tau(tau_idx) = corr(y_f', y_pred');
    
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
N_LOWER (parameter, scalar) is the dimension of the data (1 for global memory capacity).
%%%% ¡default!
1

%% ¡tests!

%%% ¡excluded_props!
[GlobalMemoryCapacity.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = rand(10);  % create random matrix 0-1
B(1:length(B)+1:numel(B)) = 0;  % remove diagonal
g = GraphWU('B', B);
mc_global = g.get('MEASURE', 'GlobalMemoryCapacity');  % calculate global memory capacity
result = mc_global.get('M');