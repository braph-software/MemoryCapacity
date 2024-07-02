![BRAPH 2.0](braph2banner.png)


# BRAPH 2.0 — Multimodal and AI-powered Brain Connectivity Analysis

[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![Website](https://img.shields.io/website?up_message=braph.org&url=http%3A%2F%2Fbraph.org%2F)](http://braph.org/)
[![DOI](https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue)](https://doi.org/10.1371/journal.pone.0178798)


## BRAPH 2.0 Memory Capacity
The **BRAPH 2.0 Memory Capacity** is a pipeline that uses the reservoir computing faramework to calculate both global and regional memory capacity. This pipeline has been used to derive the results in the manuscript: “Computational memory capacity predicts aging and cognitive decline” by Mijalkov et al. (2024).

## Code implementation
The codes implementing the global and regional memory capacity are located in the [braph2mc/pipelines/MemoryCapacity](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2mc/pipelines/MemoryCapacity) folder. 
Both measures have been implemented within a single pipeline that is fully integrated in BRAPH 2.0 software.

## Usage of the “MemoryCapacity” Pipeline
The braph2memorycapacity folder contains a fully compiled, mimimal version of BRAPH 2.0 that calculates the memory capacity. This version of BRAPH 2.0 contains only one pipeline, which allows the user to upload brain atlas, to upload subjects with connectivity matrices, and to calculate the memory capacity for each subject. This pipeline can be used both from  MATLAB command line or through the Graphical User Interfaces. 

### Usage through MATLAB command line (suggested use)
1.	<b>Open</b> the [braph2memorycapacity](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2memorycapacity) folder. 
2.	<b>Execute</b> the [braph2mc.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2mc/braph2mc.m) script in MATLAB. This script loads BRAPH 2.0 and all related dependencies. 
3. <b>Close</b> the starting graphical user interface that appears. BRAPH 2.0 software is now fully loaded and ready to use. 
4. <b>Load brain atlas</b>. Braph atlas can be loaded by executing the following code:
 
<code>im_ba = ImporterBrainAtlasXLS( ...
    'FILE', ['atlas.xlsx'], ...
    'WAITBAR', true ...
    );
ba = im_ba.get('BA'); 
</code>

The above code load the atlas conained in the "atlas.xlsx" file. A custom atlas can be uploaded by changing the file name; please ensure that the atlas is also in the .xlsx format. For more information about how to create brain atlas file, please check the following [tutorial](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/general/tut_ba), as well as the folder [atlases](https://github.com/braph-software/BRAPH-2/tree/develop/braph2/atlases) which contains several already prepared atlases ready to use with BRAPH 2.0.

6. <b>Load group of subjects.</b> Subjects can be loaded using the following:

<code>im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', ['MC_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr1 = im_gr1.get('GR');
</code>

The data for all subjects should be contained in a single folder (in this example, named "MC_Group_1_XLS"). Each subject's connectivity matrix should be contained in a single, separate Excel file. For more information about how to create subject files, please check the following [tutorial](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/general/tut_gr_con).

7. <b>Create an analysis and calculate group average values.</b> This step can be performed using the following code:

<code>analysis_MC = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );
% measure calculation at group level
global_memorycapacity = analysis_MC.get('MEASUREENSEMBLE', 'GlobalMemoryCapacity').get('M');
nodal_memorycapacity = analysis_MC.get('MEASUREENSEMBLE', 'NodalMemoryCapacity').get('M');
</code>
Here, "gr1" refers to the group of subjects created in the previous step. The code creates a weighted unidrected (WU) analysis that will calculate both nodel and global memory capacity measures for each subject. The analysis reports the average values per group (stored in the variables "global_memorycapacity" and "nodal_memorycapacity", respectively. 

8. <b>Get memory capacity values for individual subjects (optional)</b>. 

<code>num_subject = gr1.get('SUB_DICT').get('LENGTH');
global_memorycapacity_subject = cell(1, num_subject);
nodal_memorycapacity_subject  = cell(1, num_subject);
for i = 1:1:num_subject
    global_memorycapacity_subject{i} = analysis_MC.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'GlobalMemoryCapacity').get('M');
    nodal_memorycapacity_subject{i}  = analysis_MC.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'NodalMemoryCapacity').get('M');
end
</code>
The individual values are stored in "global_memorycapacity_subject" and "nodal_memorycapacity_subject" cell arrays, where each cell holds the data for individual subjects.

#### Example

1. An example dataset that will allow the user to perform these steps can be created by running the script [create_data_memorycapacity.m](https://github.com/braph-software/MemoryCapacity/blob/gv/memorycapacity/create_data_memorycapacity.m). This script will create two groups of subjects and the associated atlas files. Each subject has a weighted random connectivity matrix with a mean nodal degree of 4, which has been derived using the Watts–Strogatz model (group 1 uses a rewiring probability of 0.3 and group 2 has a rewiring probability of 0.85). After running the code, the data will be created in braph2memorycapacity/pipelines/memorycapacity/Example Data memory capacity.
2. Run [example_memorycapacity.m](https://github.com/braph-software/MemoryCapacity/blob/gv/memorycapacity/example_memorycapacity.m). This is an example file demonstrating how to perform steps 4-8 above.


### Usage through BRAPH 2.0 Graphical User Inerfaces
The Memory capacity pipeline can also be used via the graphical interfaces integrated within BRAPH 2.0. Currently, the interfaces allow the calculation and plotting of group averaged global and nodal memory capacitie (single subject calculations can only be performed through the command line). 
1. <b>Open</b> the [braph2memorycapacity](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2memorycapacity) folder. 
2.	<b>Execute</b> the [braph2mc.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2mc/braph2mc.m) script in MATLAB. This script loads BRAPH 2.0 and all related dependencies. 
3.	On the main GUI, <b>select</b> the "Pipeline Memory Capacity Analysis WU" and <b>open</b> this pipeline by pressing the button <button>"Open Pipeline Memory Capacity Analysis WU ..."</button>.
4.	<b>This action opens an interface</b> with different sections that will guide the user through the different steps of the analyses (defining and ploting brain atlas, uploading a group, defining an analysis, and calculating the measures).

#### BRAPH 2.0 tutorials

This pipeline utilizes the full functionalities of the BRAPH 2.0 software (http://braph.org/). More information about the analysis and how to use the inferfaces can be found in the main [BRAPH 2.0](https://github.com/braph-software/BRAPH-2/tree/develop) repository. The full tutorials are available [here](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials). Please consider one of the [Tutorials for Graph Theory Analysis Pipelines](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/pipelines#single-layer-connectivity-pipelines) for more information on how to use the Memory Capacity pipeline.  

## Software compilation

The compiled version of the software is already provided in this repository under "braph2memorycapacity" folder. However, if you would like to compile the software again (for example, after implementing new functionalities in BRAPH 2.0, or adding new pipelines) you will need to run the [braph2memorycapacity_genesis.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2genesis/braph2genesis.m) file. This will re-generate "braph2memorycapacity" folder which can be used as explained above. **WARNING**: To ensure a successful compilation, the folder "braph2memorycapacity" should be erased and all of its dependencies should be removed from the MATLAB path. This folder will be regenerated after succesfull compilation.

