distribution_name = 'Memory Capacity';
distribution_moniker = 'memorycapacity';
pipeline_folders = {
    'memorycapacity'
    };
braph2_version = 'heads/ywc-lite-genesis';

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
    '+gui*', ...
    '+brainsurfs*', ...
    '+atlases*', ...
    '+graphs', '+_GraphWU.gen.m', ...
    '+measures', ...
    '-neuralnetworks', ...
    '+pipelines', ...
        '+connectivity*', '-_AnalyzeEnsemble_CON_BUD.gen.m', '-_AnalyzeEnsemble_CON_BUT.gen.m', ...
        '+memorycapacity*', ...
    '+test*', ...
    '-sandbox' ...
    };
files_to_delete = { ...
    ['graphs' filesep 'test_GraphWU.m'], ...
    ['pipelines' filesep 'connectivity' filesep 'test_AnalyzeEnsemble_CON_WU.m'], ...
    ['pipelines' filesep 'connectivity' filesep 'example_CON_BUD.m'], ...
    ['pipelines' filesep 'connectivity' filesep 'example_CON_BUT.m'], ...
    ['pipelines' filesep 'connectivity' filesep 'example_CON_WU.m'], ...
    ['pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_wu.braph2'], ...
    ['pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_wu.braph2'], ...
    ['pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_bud.braph2'], ...
    ['pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_analysis_but.braph2'], ...
    ['pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_bud.braph2'], ...
    ['pipelines' filesep 'connectivity' filesep 'pipeline_connectivity_comparison_but.braph2'] ...   
    };