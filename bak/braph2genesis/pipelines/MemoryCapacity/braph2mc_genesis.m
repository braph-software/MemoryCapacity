%BRAPH2MemoryCapacity_GENESIS
% This script generates and tests BRAPH2 for MemoryCapacity

delete(findall(0, 'type', 'figure'))
close all
clear all %#ok<CLALL>
clc

%% Add here all excluded folders and elements
% cellfun(@(x) fprintf([ ' ''_' x '.gen.m'' ' ]), Measure.getSubclasses())
% cellfun(@(x) fprintf([ ' ''_' x '.gen.m'' ' ]), Graph.getSubclasses())
excluded = { ...
    'nn', 'neuralnetworks', 'measures' ...
	};

%% Genesis for MemoryCapacity
if ispc
    fprintf([ ...
        '\n' ...
        '<strong>@@@@   @@@@    @@@   @@@@   @   @     ####   ####     ØØØØØ ØØØØ Ø   Ø ØØØØ  ØØØØ  Ø   ØØØØ\n</strong>' ...
        '<strong>@   @  @   @  @   @  @   @  @   @        #   #  #     Ø     Ø    ØØ  Ø Ø    Ø      Ø  Ø    \n</strong>' ...
        '<strong>@@@@   @@@@   @@@@@  @@@@   @@@@@     ####   #  #     Ø  ØØ ØØØ  Ø Ø Ø ØØØ   ØØØ   Ø   ØØØ \n</strong>' ...
        '<strong>@   @  @  @   @   @  @      @   @     #      #  #     Ø   Ø Ø    Ø  ØØ Ø        Ø  Ø      Ø\n</strong>' ...
        '<strong>@@@@   @   @  @   @  @      @   @     #### # ####     ØØØØØ ØØØØ Ø   Ø ØØØØ ØØØØ   Ø  ØØØØ \n</strong>' ...
        '\n' ...
        '                                                       f o r   M e m o r y C a p a c i t y\n' ...
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
        '                                                       f o r   M e m o r y C a p a c i t y\n' ...
        '\n' ...
        ]);
end

addpath(['.' filesep() '..' filesep() '..'])
addpath(['.' filesep() '..' filesep() '..' filesep() 'genesis'])

addpath(fileparts(which('braph2genesis')))
addpath([fileparts(which('braph2genesis')) filesep 'genesis'])

target_dir = [fileparts(fileparts(which('braph2genesis'))) filesep 'braph2mc'];
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

    [target_dir, source_dir] = genesis(target_dir, [], 2, false, excluded);

    % move braph2mc to main folder
    movefile([target_dir filesep() 'pipelines' filesep() 'MemoryCapacity' filesep() 'braph2mc.m'], target_dir)

    % move test_braph2distap to test folder
    movefile([target_dir filesep() 'pipelines' filesep() 'MemoryCapacity' filesep() 'test_braph2mc.m'], [target_dir filesep() 'test'])

    % erase braph2distap from compiled software
    delete([target_dir filesep() 'pipelines' filesep() 'MemoryCapacity' filesep() 'braph2mc_genesis.m'])

    addpath(target_dir)

    time_end = toc(time_start);

    disp( 'BRAPH 2 is now fully compiled and ready to be used.')
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
    
    braph2(false)

    test_braph2mc
end