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
"<code>  im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [memory_example_path filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA'); </code> "

    
6.  
7.
8.
9.	Click on the link that the MATLAB terminal will print saying "<ins>Open Memory Capacity Analysis</ins> "

### BRAPH 2.0 tutorials

This pipeline utilizes the full functionalities of the BRAPH 2.0 software. For more information on how to use BRAPH 2.0, please refer to the [BRAPH 2.0 Tutorials](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials). More information about BRAPH 2.0 can be found both in the [BRAPH 2.0 repository](https://github.com/braph-software/BRAPH-2/tree/develop) and http://braph.org/.

### Example
1. Create dataset (if you haven't done so) by running [create_data_Memory_Capacity.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2mc/pipelines/MemoryCapacity/create_data_Memory_Capacity.m). This will create the folder [Example data Memory Capacity](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2mc/pipelines/MemoryCapacity/Example%20data%20Memory%20Capacity) (already included in the compiled version under [braph2mc](https://github.com/braph-software/MemoryCapacity/tree/develop/braph2mc) folder.
2. Run [example_MemoryCapacity.m](https://github.com/braph-software/MemoryCapacity/blob/develop/example_MemoryCapacity.m). It is an example file demonstrating how to use the MemoryCapacity pipeline. It can be found in the same directory.

### Software compilation

The compiled version of the software is already provided in this repository under "braph2mc" folder. However, if you would like to compile the software again (e.g., after implementing new functionalities in BRAPH 2.0) you will need to run [braph2genesis.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2genesis/braph2genesis.m) file. This will re-generate "braph2mc" folder which can be used as explained above. **WARNING**: be aware that this process will erase all files inside "braph2mc" folder and re-generate them again.

