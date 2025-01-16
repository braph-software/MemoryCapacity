%EXAMPLE_MC
% Script example pipeline Memory Capacity

clear variables %#ok<*NASGU>

%% Load BrainAtlas
memory_example_path = [fileparts(which('braph2')) filesep 'pipelines' filesep 'memorycapacity' filesep 'Example Data memory capacity'];
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [memory_example_path filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [memory_example_path filesep 'MC_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [memory_example_path filesep 'MC_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis Memory Capacity
a1 = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );

a2 = AnalyzeEnsemble_CON_WU( ...
    'GR', gr2 ...
    );

% set up parameters
a1.memorize('GRAPH_TEMPLATE').get('MEASURE', 'GlobalMemoryCapacity').set('TRIALS', 2);
a2.memorize('GRAPH_TEMPLATE').get('MEASURE', 'GlobalMemoryCapacity').set('TRIALS', 2);
a1.memorize('GRAPH_TEMPLATE').get('MEASURE', 'NodalMemoryCapacity').set('TRIALS', 2);
a2.memorize('GRAPH_TEMPLATE').get('MEASURE', 'NodalMemoryCapacity').set('TRIALS', 2);

% Calculate memory capacity at group level for group 1 & 2
gmc1 = a1.get('MEASUREENSEMBLE', 'GlobalMemoryCapacity').get('M');
nmc1 = a1.get('MEASUREENSEMBLE', 'NodalMemoryCapacity').get('M');

gmc2 = a2.get('MEASUREENSEMBLE', 'GlobalMemoryCapacity').get('M');
nmc2 = a2.get('MEASUREENSEMBLE', 'NodalMemoryCapacity').get('M');

% Calculate memory capacity at individual level for group 1
num_subject = gr1.get('SUB_DICT').get('LENGTH');
global_memorycapacity_subject = cell(1, num_subject);
nmc_subject  = cell(1, num_subject);
for i = 1:1:num_subject
    gmc_subject{i} = a1.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'GlobalMemoryCapacity').get('M');
    nmc_subject{i}  = a1.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'NodalMemoryCapacity').get('M');
end

%% Comparison Memory Capacity
c_WU = CompareEnsemble( ...
    'P', 10, ...
    'A1', a1, ...
    'A2', a2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

nmc_diff = c_WU.get('COMPARISON', 'NodalMemoryCapacity').get('DIFF');
nmc_p1 = c_WU.get('COMPARISON', 'NodalMemoryCapacity').get('P1');
nmc_p2 = c_WU.get('COMPARISON', 'NodalMemoryCapacity').get('P2');
nmc_cil = c_WU.get('COMPARISON', 'NodalMemoryCapacity').get('CIL');
nmc_ciu = c_WU.get('COMPARISON', 'NodalMemoryCapacity').get('CIU');

gmc_diff = c_WU.get('COMPARISON', 'GlobalMemoryCapacity').get('DIFF');
gmc_p1 = c_WU.get('COMPARISON', 'GlobalMemoryCapacity').get('P1');
gmc_p2 = c_WU.get('COMPARISON', 'GlobalMemoryCapacity').get('P2');
gmc_cil = c_WU.get('COMPARISON', 'GlobalMemoryCapacity').get('CIL');
gmc_ciu = c_WU.get('COMPARISON', 'GlobalMemoryCapacity').get('CIU');