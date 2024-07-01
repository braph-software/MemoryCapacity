close all; delete(findall(0, 'type', 'figure')); clear all; clc

%%
el_path = '/pipelines/memorycapacity';
el_class_list = {'NodalMemoryCapacity'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    %create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    ['test_' el_class]
    eval(['test_' el_class])
end