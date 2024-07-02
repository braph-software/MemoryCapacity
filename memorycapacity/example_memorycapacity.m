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

%% Analysis Global MC
analysis_MC = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );

% measure calculation at group level
global_memorycapacity = analysis_MC.get('MEASUREENSEMBLE', 'GlobalMemoryCapacity').get('M');
nodal_memorycapacity = analysis_MC.get('MEASUREENSEMBLE', 'NodalMemoryCapacity').get('M');

% measure calculation at individual level
num_subject = gr1.get('SUB_DICT').get('LENGTH');
global_memorycapacity_subject = cell(1, num_subject);
nodal_memorycapacity_subject  = cell(1, num_subject);
for i = 1:1:num_subject
    global_memorycapacity_subject{i} = analysis_MC.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'GlobalMemoryCapacity').get('M');
    nodal_memorycapacity_subject{i}  = analysis_MC.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'NodalMemoryCapacity').get('M');
end
