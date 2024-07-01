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
    'DIRECTORY', [memory_example_path filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

%% Analysis Global MC
a_WU1 = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );

% measure calculation at group level
global_memory_capacity_WU1 = a_WU1.get('MEASUREENSEMBLE', 'GlobalMemoryCapacity').get('M');
nodal_memory_capacity_WU1 = a_WU1.get('MEASUREENSEMBLE', 'NodalMemoryCapacity').get('M');

% measure calculation at individual level
num_subject = gr1.get('SUB_DICT').get('LENGTH');
for i = 1:num_subject
    global_memory_capacity_WU1_subject{i} = a_WU1.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'GlobalMemoryCapacity').get('M');
    nodal_memory_capacity_WU1_subject{i} = a_WU1.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'NodalMemoryCapacity').get('M');
end
