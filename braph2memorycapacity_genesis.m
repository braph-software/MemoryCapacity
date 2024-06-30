%BRAPH2GENESIS_WITH_EXCLUSIONS
% This script generates and tests BRAPH2 including or excluding some 
%  directories and elements, whose list is defined by the variable rollcall.

delete(findall(0, 'type', 'figure'))
close all
clear all %#ok<CLALL>
clc

%%% ADD CODE TO DOWLOAD braph2genesis

addpath(['.' filesep() 'braph2genesis'])
addpath(['.' filesep() 'braph2genesis' filesep() 'genesis'])

%% Move memorycapacity to pipelines folder
copyfile([fileparts(which('braph2memorycapacity_genesis')) filesep 'memorycapacity'], [fileparts(which('braph2genesis')) filesep 'pipelines' filesep 'memorycapacity'])


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
    '+gt', '+_Measure.gen.m', '+_Graph.gen.m', '_GraphAdjPF.gen.m', '_NoValue.gen.m', ...
        '_MeasurePF.gen.m', '_MeasurePF_GU.gen.m', '_MeasurePF_NU.gen.m', '_MeasurePF_NxPP_Node.gen.m', '_MeasurePF_xUPP_Layer.gen.m', ...
    '+cohort*', ...
    '+analysis', '+_AnalyzeEnsemble.gen.m', '+_AnalyzeEnsemblePP_GDict.gen.m', '+_AnalyzeEnsemblePP_MeDict.gen.m', 'MeasureEnsemble.gen.m', ...
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

target_dir = [fileparts(fileparts(which('braph2genesis'))) filesep 'braph2memorycapacity'];
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

    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_bud.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_but.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_bud.braph2'])
    delete([fileparts(which('braph2')) filesep 'pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_but.braph2'])

    time_end = toc(time_start);

    disp( 'BRAPH 2 is now fully compiled and ready to be used.')
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
    
    braph2(false)

    %test_braph2
    test_GlobalMemoryCapacity
    test_NodalMemoryCapacity
end
