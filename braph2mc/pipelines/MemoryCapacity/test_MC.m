function test_MC(type)
%% test script
% I dont testd this since I dont have the data. Please make sure Mite
% in my opinion it needs a pipeline since theres no way to place the data
% into a multilayer and all importers average or ensemble
% have to run braph2genesis first

%% Load data

for i = 1:1:10
    data{i} = rand(120); %#ok<AGROW> 
end

%% Create graph
g = MultiplexWU('B', data);

%% create measures
switch type
    case 'nodal'
        mc_nodal = g.get('MEASURE', 'NodalMemoryCapacity');
        result = mc_nodal.get('M');
    case 'global'
        mc_global = g.get('MEASURE', 'GlobalMemoryCapacity');
        result = mc_global.get('M');
end

assert(~isempty(result))
end