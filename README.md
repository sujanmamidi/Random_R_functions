# Random_R_functions

## sliding_window_frequency
Calculates SNP frequency in sliding windows along a chromosome. 
Requires a text file with 2 columns (space separated, no heading). 
Usage:  
sliding_window_frequency("mysnps.txt") # Calculates SNP frequency at defaults (window=10000, slide=2000)
sliding_window_frequency("mysnps.txt",window=100000, slide=20000) # Calculates SNP frequency at window=100000, slide=20000)

