# ParallelNCL
Bash shell code to parallelize NCL code execution across a batch submission queue

# Description
When analyzing large domains across a large number of timesteps, serial execution of NCL scripts is ineffective, but NCL cannot be run natively in parallel. To solve this problem, these scripts read in files from a directory and efficiently delegate an NCL code to analyze individual timesteps via batch submission on a cluster or supercomputer. 
