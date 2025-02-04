![BRAPH 2.0](braph2banner.png)

[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![Website](https://img.shields.io/website?up_message=braph.org&url=http%3A%2F%2Fbraph.org%2F)](http://braph.org/)
[![DOI](https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue)](https://doi.org/10.1371/journal.pone.0178798)


# BRAPH 2.0 Memory Capacity
The **BRAPH 2.0 Memory Capacity** is a BRAPH 2.0 distribution that uses the reservoir computing framework to calculate both global and regional memory capacity. This pipeline has been used to derive the results in the manuscript: “Computational memory capacity predicts aging and cognitive decline” by Mijalkov et al. (2025).

This distribution utilizes the full functionalities of the BRAPH 2.0 software. More information about the analysis and how to use the interfaces can be found in the main [BRAPH 2.0](https://github.com/braph-software/BRAPH-2/tree/develop) repository. The full tutorials are available [here](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials).

## Memory Capacity Tutorial
The [tutorial](https://github.com/braph-software/MemoryCapacity/tutorials/tut_mc_wu) for the memory capacity pipeline (fully integrated in BRAPH 2.0 software) shows how to calculate the global and regional memory capacity for each subject and compare between groups of subjects. This pipeline can be used both from MATLAB command line or through the Graphical User Interfaces.
The codes implementing the global and regional memory capacity are located in the [memorycapacity](https://github.com/braph-software/MemoryCapacity/tree/develop/memorycapacity) folder. 

## Software compilation

The compiled version of the software is already provided in this repository under "braph2memorycapacity" folder. However, if you would like to compile the software again (for example, after implementing new functionalities in BRAPH 2.0, or adding new pipelines) you will need to run the [braph2memorycapacity_genesis.m](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2memorycapacity_genesis.m) script. This will re-generate "braph2memorycapacity" folder which can then be used as explained above. **WARNING**: To ensure a successful compilation, the folder "braph2memorycapacity" should be erased and all of its dependencies should be removed from the MATLAB path. This folder will be regenerated after a successful compilation.

