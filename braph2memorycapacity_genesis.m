%BRAPH2GENESIS_WITH_EXCLUSIONS
% This script generates and tests BRAPH2 including or excluding some 
%  directories and elements, whose list is defined by the variable rollcall.

delete(findall(0, 'type', 'figure'))
close all
clear all %#ok<CLALL>
clc

%%% ADD CODE TO DOWLOAD braph2genesis

addpath(['.' filesep() '..' filesep() 'braph2genesis'])
addpath(['.' filesep() '..' filesep() 'braph2genesis' filesep() 'genesis'])

%%% MOVE 

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
    '+util*', '-_Exporter.gen.m', '+_Importer.gen.m', ...
    '+ds*', '-ds_examples', ...
    '-atlas', ...
    '-gt', ...
    '-cohort', ...
    '-analysis', ...
    '-nn', ...
    '-gui', '-gui_examples', ...
    '-brainsurfs', ...
    '-atlases', ...
    '-graphs', ...
    '-measures', ...
    '-neuralnetworks', ...
    '-pipelines', ...
    '+test*', ...
    '-sandbox*' ...
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

addpath([fileparts(which('braph2memorycapacity_genesis')) filesep() '..'])
addpath([fileparts(which('braph2memorycapacity_genesis')) filesep() '..' filesep 'genesis'])

target_dir = [fileparts(fileparts(which('braph2genesis'))) filesep 'braph2memorycapacity_genesis'];
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

    time_end = toc(time_start);

    disp( 'BRAPH 2 is now fully compiled and ready to be used.')
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
    
    braph2(false)

    test_braph2
end
