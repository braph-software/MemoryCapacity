%EXAMPLE_MC
% Script example pipeline Memory Capacity

clear variables %#ok<*NASGU>

%% Load BrainAtlas
memory_example_path = [fileparts(which('braph2mc')) filesep 'pipelines' filesep 'MemoryCapacity' filesep 'Example data Memory Capacity'];
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [memory_example_path filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_MP_XLS( ...
    'DIRECTORY', [memory_example_path filesep 'CON_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

%% Analysis Global MC
a_WU1 = AnalyzeEnsemble_CON_MP_WU( ...
    'GR', gr1 ...
    );

% measure calculation

global_memory_capacity_WU1 = a_WU1.get('MEASUREENSEMBLE', 'GlobalMemoryCapacity').get('M');
nodal_memory_capacity_WU1 = a_WU1.get('MEASUREENSEMBLE', 'NodalMemoryCapacity').get('M');