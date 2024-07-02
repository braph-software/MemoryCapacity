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

### Usage of the “MemoryCapacity” Pipeline
The braph2memorycapacity folder contains a fully compiled, mimimal version of BRAPH 2.0 that calculates the memory capacity. This version of BRAPH 2.0 contains only one pipeline, that allows the user to upload brain atlas, to upload subjects with connectivity matrices, and to calculate the memory capacity for each subject. This pipeline can be used both from  MATLAB command line or through the Graphical User Interfaces. To use the pipeline, follow these steps:

## Usage through MATLAB command line (suggested use)
1.	Open the [braph2memorycapacity](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2memorycapacity) folder. 
2.	Execute the [braph2mc.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2mc/braph2mc.m) script in MATLAB. This script loads BRAPH 2.0 and all related dependencies. 
3.  BRAPH 2.0 software is now fully loaded and ready to use. The calculation of memory capacity can be performed in 3 steps:
4.  Step 1: Load brain atlas.
   Braph atlas can be loaded by executing the following code:

 
<code>im_ba = ImporterBrainAtlasXLS( ...
    'FILE', ['atlas.xlsx'], ...
    'WAITBAR', true ...
    );
ba = im_ba.get('BA'); 
</code>

The above code load the atlas in atlas.xlsx file. A custom atlas can be uploaded by changing the file name, please ensure that your atlas is also in the .xlsx format. For more information about how to create brain atlas file, please check the following [tutorial](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/general/tut_ba), as well as the folder [atlases](https://github.com/braph-software/BRAPH-2/tree/develop/braph2/atlases) where you can find several already prepared atlases ready to use with BRAPH 2.0.

6.  Step 2: Load group of subjects.
Subjects can be loaded using the following:

<code>im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', ['MC_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr1 = im_gr1.get('GR');
</code>

The data for all subjects should be contained in a single folder (in this example named MC_Group_1_XLS). Each subject's connectivity matrix should be contained in a single, separate Excel file. For more information about how to create subject files, please check the following [tutorial](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/general/tut_gr_con).

7. Step 3: Create an analysis and calculate group average values.
This step can be performed using the following code:

<code>analysis_MC = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );
% measure calculation at group level
global_memorycapacity = analysis_MC.get('MEASUREENSEMBLE', 'GlobalMemoryCapacity').get('M');
nodal_memorycapacity = analysis_MC.get('MEASUREENSEMBLE', 'NodalMemoryCapacity').get('M');
</code>
In this code, gr1 refers to the group of subjects created in Step 2. The code creates a weighted unidrected (WU) analysis that will calculate both nodel and global memory capacity measures for each subject and report the average values per group (stored in the variables global_memorycapacity and nodal_memorycapacity, respectively. 

8. Step 4 (optional): Get memory capacity values for individual subjects.
This step can be performed using the following:

<code>num_subject = gr1.get('SUB_DICT').get('LENGTH');
global_memorycapacity_subject = cell(1, num_subject);
nodal_memorycapacity_subject  = cell(1, num_subject);
for i = 1:1:num_subject
    global_memorycapacity_subject{i} = analysis_MC.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'GlobalMemoryCapacity').get('M');
    nodal_memorycapacity_subject{i}  = analysis_MC.get('G_DICT').get('IT', i).get('M_DICT').get('IT', 'NodalMemoryCapacity').get('M');
end
</code>
The individual values are stored in global_memorycapacity_subject and nodal_memorycapacity_subject cell arrays, where each cell holds the data for individual subjects.

9. An example data that will allow the user to perform these steps can be created by running the script [create_data_memorycapacity.m](https://github.com/braph-software/MemoryCapacity/blob/gv/memorycapacity/create_data_memorycapacity.m). This script will create two groups of subjects and the associated atlas files. Each subject has a weighted random connectivity matrix with a mean nodal degree of 4, which has been derived using the Watts–Strogatz model (group 1 uses a rewiring probability of 0.3 and group 2 has a rewiring probability of 0.85). After running the code, the data will be created in braph2memorycapacity/pipelines/memorycapacity/Example Data memory capacity.
10. The code [example_memorycapacity.m](https://github.com/braph-software/MemoryCapacity/blob/gv/memorycapacity/example_memorycapacity.m) shows an example of the usage of the memory capacity pipeline on this example data.
11.
12.
13.	Click on the link that the MATLAB terminal will print saying "<ins>Open Memory Capacity Analysis</ins> "

### BRAPH 2.0 tutorials

This pipeline utilizes the full functionalities of the BRAPH 2.0 software. For more information on how to use BRAPH 2.0, please refer to the [BRAPH 2.0 Tutorials](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials). More information about BRAPH 2.0 can be found both in the [BRAPH 2.0 repository](https://github.com/braph-software/BRAPH-2/tree/develop) and http://braph.org/.

### Example
1. Create dataset (if you haven't done so) by running [create_data_Memory_Capacity.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2mc/pipelines/MemoryCapacity/create_data_Memory_Capacity.m). This will create the folder [Example data Memory Capacity](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2mc/pipelines/MemoryCapacity/Example%20data%20Memory%20Capacity) (already included in the compiled version under [braph2mc](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2mc) folder.
2. Run [example_MemoryCapacity.m](https://github.com/braph-software/MemoryCapacity/blob/develop/example_MemoryCapacity.m). It is an example file demonstrating how to use the MemoryCapacity pipeline. It can be found in the same directory.

### Software compilation

The compiled version of the software is already provided in this repository under "braph2mc" folder. However, if you would like to compile the software again (e.g., after implementing new functionalities in BRAPH 2.0) you will need to run [braph2genesis.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2genesis/braph2genesis.m) file. This will re-generate "braph2mc" folder which can be used as explained above. **WARNING**: be aware that this process will erase all files inside "braph2mc" folder and re-generate them again.

