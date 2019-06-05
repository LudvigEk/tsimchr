tsimchr
========

Simulation code for the paper "Identification of essential genes constraining the extent of homozygous deletions in cancer genomes" (Pertesi et al 2019)

Parts are dependent on MFC libraries, doesn't compile easily on linux/MAC. Uploaded visual studio solution to get compiler settings etc, for easier compilation.

Installation
------------

To compile the executable properly you will need the dependencies located at 

https://github.com/LudvigEk/tsimchr_dependencies

Start by downloading those, then extract tsimchr into the tsimchr folder inside tsimchr_dependencies. After that you can compile.

Usage
--------

example:
tsimchr -pmajor:20 -ppoint:79 -predup:1 test_simulation.txt

Switches are:
pmajor - percentage chance of regional deletion
ppoint - percentage chance of point deletion
predup - percentage chance of reduplication event
n - keep going until this many homozygous deletions of the TSG has occured

Notes
--------
To change number of essential genes and their location, or to change position of the TSG, modify the source code and recompile.
Open tsimchr.cpp and search for 'v_essential.SetAt'. Their index is set at a relative position in the genelist. 
Process is similar for setting position of the tumor suppressor (driver gene), called i_tsg.
