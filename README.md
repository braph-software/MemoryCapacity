![BRAPH 2](braph2banner.png)

[![BRAPH 2](https://img.shields.io/badge/Bluesky-BRAPH%202-blue?style=social&logo=bluesky&url=https%3A%2F%2Fbraph2software.bsky.social)](https://braph2software.bsky.social)
[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![cite us](https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue)](https://doi.org/10.1371/journal.pone.0178798)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/braph-software/BRAPH-2)](https://github.com/braph-software/BRAPH-2/releases)
[![Zenodo](https://zenodo.org/badge/DOI/10.5281/zenodo.14633697.svg)](https://doi.org/10.5281/zenodo.14633697)

# BRAPH 2 Memory Capacity
The **BRAPH 2 Memory Capacity** is a BRAPH 2 distribution that uses the reservoir computing approach to calculate both global and regional memory capacity. This pipeline has been used to derive the results in the manuscript: “Computational memory capacity predicts aging and cognitive decline” by Mijalkov et al. (2025).

This distribution utilizes the necessary analytical functionalities of the standard BRAPH 2 distribution. More information about the analysis and how to use the interfaces can be found in the main [BRAPH 2](https://github.com/braph-software/BRAPH-2/tree/develop) repository. The full tutorials are available [here](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials).

## Memory Capacity Tutorial
The [tutorial](https://github.com/braph-software/MemoryCapacity/tutorials/tut_mc_wu) for the memory capacity pipeline (fully integrated in BRAPH 2 framework) shows how to calculate the global and regional memory capacity for each subject and compare between groups of subjects. This pipeline can be used both from MATLAB command line or through the Graphical User Interfaces.
The codes implementing the global and regional memory capacity are located in the [memorycapacity](https://github.com/braph-software/MemoryCapacity/tree/develop/memorycapacity) folder. 

## Software compilation

The compiled version of the software is already provided in this repository under `braph2memorycapacity` folder. However, if you need to recompile the software again (for example, after implementing new functionalities or adding new pipelines), you can do so by running the [braph2genesis](https://github.com/braph-software/MemoryCapacity/blob/develop/braph2memorycapacity_genesis.m) function with the command `braph2genesis('braph2memorycapacity_config.m')`. This will re-generate `braph2memorycapacity` folder which can then be used as explained above. **WARNING**: To ensure a successful compilation, the `braph2memorycapacity` folder should be erased and all of its dependencies should be removed from the MATLAB path. This folder will be regenerated after a successful compilation.

