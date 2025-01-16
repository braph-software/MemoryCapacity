%BRAPH2GENESIS_WITH_EXCLUSIONS
% This script generates and tests BRAPH2 including or excluding some 
%  directories and elements, whose list is defined by the variable rollcall.

delete(findall(0, 'type', 'figure'))
close all
clear all %#ok<CLALL>
clc

%% Download braph2genesis
braph2genesis_dir = 'braph2genesis';
pipeline_name = 'memorycapacity';
braph2_dir = ['braph2' pipeline_name];
pipelinegenesis_dir = [braph2_dir '_genesis']; % gets the name of the script being executed
if ~exist(braph2genesis_dir, 'dir') 
    repo_name = 'BRAPH-2'; % name of the repository to download
    
    % specify the reference type:
    % 'tags' for stable tagged versions (e.g., release versions like '2.0.0'),
    % 'heads' for ongoing branches (e.g., 'develop').
    ref = 'tags';

    % specify the version or branch:
    % For example, '2.0.0' refers to the stable release version as of 12 January 2025 and corresponds to 'tags'.
    % 'develop' refers to the ongoing development branch and correspods to 'heads'
    ver = '2.0.0';
    
    % construct the GitHub URL for the desired repository version
    repo = ['https://github.com/braph-software/' repo_name '/archive/refs/' ref '/' ver '.zip'];

    % download the repository ZIP file from the specified URL
    zipfile = [repo_name '-' ref '-' ver '.zip'];
    
    disp(['Downloading ' repo_name ' (' ref ': ' ver ')...']);
    disp(['From: ' repo]);
    disp(['To: ' zipfile]);
    websave(zipfile, repo);
    disp('Download complete.');
    
    % create directory for braph2genesis
    tmp_dir = 'tmp_unzip';
    mkdir(tmp_dir);
    mkdir(braph2genesis_dir)
    
    % unzip braph
    unzip(zipfile, tmp_dir)
    
    % copy braph2genesis from unzipped folder
    copyfile([fileparts(which(pipelinegenesis_dir)) filesep tmp_dir filesep repo_name '-' ver filesep braph2genesis_dir], ...
        [fileparts(which(pipelinegenesis_dir)) filesep braph2genesis_dir])
    
    % remove not needed directory and file
    rmdir(tmp_dir, 's')
    delete(zipfile)
end

addpath(['.' filesep() braph2genesis_dir])
addpath(['.' filesep() braph2genesis_dir filesep() 'genesis'])

%% Move memorycapacity to pipelines folder
copyfile([fileparts(which(pipelinegenesis_dir)) filesep pipeline_name], [braph2genesis_dir filesep 'pipelines' filesep pipeline_name])

%% Add here all included and excluded folders and elements
% '-folder'                 the folder and its elements will be excluded
%
% '+folder'                 the folder is included, but not its elements
%   '+_ElementName.gen.m'   the element is included,
%                           if the folder is included
%
% '+folder*'                the folder and its elements are included
%   '-_ElementName.gen.m'   the element is excluded,
%                           if the folder and its elements are included
% (by default, the folders are included as '+folder*')
rollcall = { ...
    '+util', '+_Exporter.gen.m', '+_Importer.gen.m', ...
    '+ds*', '-ds_examples', ...
    '+atlas*', ...
    '+gt', '+_Measure.gen.m', '+_Graph.gen.m', '+_GraphAdjPF.gen.m', '+_GraphHistPF.gen.m', '+_GraphPP_MDict.gen.m', '+_NoValue.gen.m', ...
        '+_MeasurePF.gen.m', '+_MeasurePF_GU.gen.m', '+_MeasurePF_NU.gen.m', '+_MeasurePF_NxPP_Node.gen.m', '+_MeasurePF_xUPP_Layer.gen.m', ...
    '+cohort*', ...
    '+analysis', '+_AnalyzeEnsemble.gen.m', '+_AnalyzeEnsemblePP_GDict.gen.m', '+_AnalyzeEnsemblePP_MeDict.gen.m', '+_CompareEnsemble.gen.m', '+_CompareEnsemblePP_CpDict.gen.m', ...
        '+_ComparisonEnsemble.gen.m', '+_ComparisonEnsembleBrainPF.gen.m', '+_ComparisonEnsembleBrainPF_BB.gen.m', '+_ComparisonEnsembleBrainPF_BS.gen.m', '+_ComparisonEnsembleBrainPF_BU.gen.m', ...
        '+_ComparisonEnsembleBrainPF_GB.gen.m', '+_ComparisonEnsembleBrainPF_GS.gen.m', '+_ComparisonEnsembleBrainPF_GU.gen.m', '+_ComparisonEnsembleBrainPF_NB.gen.m', '+_ComparisonEnsembleBrainPF_NS.gen.m', ...
        '+_ComparisonEnsembleBrainPF_NU.gen.m', '+_ComparisonEnsembleBrainPF_xSPP_Layer.gen.m', '+_ComparisonEnsembleBrainPF_xUPP_Layer.gen.m', '+_ComparisonEnsemblePF.gen.m', ...
        '+_ComparisonEnsemblePF_BB.gen.m', '+_ComparisonEnsemblePF_BS.gen.m', '+_ComparisonEnsemblePF_BU.gen.m', '+_ComparisonEnsemblePF_BxPP_Nodes.gen.m', '+_ComparisonEnsemblePF_GB.gen.m', ...
        '+_ComparisonEnsemblePF_GS.gen.m', '+_ComparisonEnsemblePF_GU.gen.m', '+_ComparisonEnsemblePF_NB.gen.m', '+_ComparisonEnsemblePF_NS.gen.m', '+_ComparisonEnsemblePF_NU.gen.m', '+_ComparisonEnsemblePF_NxPP_Node.gen.m', ...
        '+_ComparisonEnsemblePF_xUPP_Layer.gen.m', '+_MeasureEnsemble.gen.m', ...
        '+_MeasureEnsembleBrainPF.gen.m', '+_MeasureEnsembleBrainPF_GU.gen.m', '+_MeasureEnsembleBrainPF_NU.gen.m', '+_MeasureEnsembleBrainPF_xUPP_Layer.gen.m', ...
        '+_MeasureEnsemblePF.gen.m', '+_MeasureEnsemblePF_GU.gen.m', '+_MeasureEnsemblePF_NU.gen.m', '+_MeasureEnsemblePF_NxPP_Node.gen.m', '+_MeasureEnsemblePF_xUPP_Layer.gen.m', ...
        '+_PanelPropCellFDR.gen.m', ...
    '-nn', ...
    '+gui*', '-gui_examples', ...
    '+brainsurfs*', ...
    '+atlases*', ...
    '+graphs',  '+_GraphWU.gen.m', ...
    '+measures', ...
    '-neuralnetworks', ...
    '+pipelines', ...
        '+connectivity*', '-_AnalyzeEnsemble_CON_BUD.gen.m', '-_AnalyzeEnsemble_CON_BUT.gen.m', ...
        '+memorycapacity*', ...
    '+test*', ...
    '-sandbox' ...
    };

%% Genesis With Rollcall
if ispc
    fprintf([ ...
        '\n' ...
        '<strong>@@@@   @@@@    @@@   @@@@   @   @     ####   ####     ØØØØØ ØØØØ Ø   Ø ØØØØ  ØØØØ  Ø   ØØØØ\n</strong>' ...
        '<strong>@   @  @   @  @   @  @   @  @   @        #   #  #     Ø     Ø    ØØ  Ø Ø    Ø      Ø  Ø    \n</strong>' ...
        '<strong>@@@@   @@@@   @@@@@  @@@@   @@@@@     ####   #  #     Ø  ØØ ØØØ  Ø Ø Ø ØØØ   ØØØ   Ø   ØØØ \n</strong>' ...
        '<strong>@   @  @  @   @   @  @      @   @     #      #  #     Ø   Ø Ø    Ø  ØØ Ø        Ø  Ø      Ø\n</strong>' ...
        '<strong>@@@@   @   @  @   @  @      @   @     #### # ####     ØØØØØ ØØØØ Ø   Ø ØØØØ ØØØØ   Ø  ØØØØ \n</strong>' ...
        '\n' ...
        '                                                       M E M O R Y   C A P A C I T Y\n' ...
        '\n' ...
        ]);
else
    fprintf([ ...
        '\n' ...
        ' ████   ████    ███   ████   █   █     ▓▓▓▓   ▓▓▓▓     ▒▒▒▒▒ ▒▒▒▒ ▒   ▒ ▒▒▒▒  ▒▒▒▒  ▒   ▒▒▒▒\n' ...
        ' █   █  █   █  █   █  █   █  █   █        ▓   ▓  ▓     ▒     ▒    ▒▒  ▒ ▒    ▒      ▒  ▒    \n' ...
        ' ████   ████   █████  ████   █████     ▓▓▓▓   ▓  ▓     ▒  ▒▒ ▒▒▒  ▒ ▒ ▒ ▒▒▒   ▒▒▒   ▒   ▒▒▒ \n' ...
        ' █   █  █  █   █   █  █      █   █     ▓      ▓  ▓     ▒   ▒ ▒    ▒  ▒▒ ▒        ▒  ▒      ▒\n' ...
        ' ████   █   █  █   █  █      █   █     ▓▓▓▓ ▓ ▓▓▓▓     ▒▒▒▒▒ ▒▒▒▒ ▒   ▒ ▒▒▒▒ ▒▒▒▒   ▒  ▒▒▒▒ \n' ...
        '\n' ...
        '                                                       M E M O R Y   C A P A C I T Y\n' ...
        '\n' ...
        ]);
end

rollcall_per_line = 5;
offset = max(cellfun(@(x) length(x), rollcall)) + 2;
for i = 1:rollcall_per_line:length(rollcall)
    cellfun(@(x) fprintf([x repmat(' ', 1, offset - length(x))]), rollcall(i:min(i + rollcall_per_line - 1, length(rollcall))))
    fprintf('\n')
end
disp(' ')

target_dir = [fileparts(which(pipelinegenesis_dir)) filesep braph2_dir];
if exist(target_dir, 'dir') 
    if input([ ...
        'The target directory already exists:\n' ...
        target_dir '\n'...
        'It will be erased with all its content.\n' ...
        'Proceed anyways? (y/n)\n'
        ], 's') == 'y'
    
        backup_warning_state = warning('off', 'MATLAB:RMDIR:RemovedFromPath');
        rmdir(target_dir, 's')
        warning(backup_warning_state)
    else
        disp('Compilation interrupted.')
    end
end
if ~exist(target_dir, 'dir') 
    time_start = tic;

    [target_dir, source_dir] = genesis(target_dir, [], 2, rollcall);


    addpath(target_dir)

    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_wu.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_wu.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_bud.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_but.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_bud.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_but.braph2'])
    new_element_gen_list = getGenerators([fileparts(which('braph2memorycapacity_genesis')) filesep 'memorycapacity']);

    % remove genesis directory
    rmdir(braph2genesis_dir, 's')

    time_end = toc(time_start);

    disp( 'BRAPH 2 is now fully compiled and ready to be used.')
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
    
    braph2(false)

    % test only the newly generated elements (code below) or test all compiled elements using 'test_braph2'.
    % To test all elements, run: test_braph2
    for i = 1:numel(new_element_gen_list) % Loop through and test each new element
        % Extract the element name from the list and evaluate its corresponding test function
        eval(['test_' char(extractBetween(new_element_gen_list{i}, '_', '.gen'))]);
    end
end