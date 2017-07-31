[//]: ========================================
# Software for Summary Statistics Imputation
[//]: ========================================

This command-line software enables summary statistics imputation (SSimp) for GWAS summary statistics. 

The only input needed from the user are the **GWAS summary statistics** and a **reference panel** (e.g. 1000 genomes, needed for LD computation).

## Installation
[//]: -------------------------------

### Source code
1. Clone the github folder. 
2. Run  `stu bin/ssimp`

### Compiled version
Download
* [ssimp 0.1 - Mac OS X]()
* [ssimp 0.1 - Ubuntu 12.04]()

## Download 1000 genomes reference panel
[//]: -------------------------------

Download the files in 'ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/'
to a directory on your computer. 

    cd ~                # to your home directory
    mkdir -p ref_panels/1000genomes
    cd       ref_panels/1000genomes
    wget -nd -r 'ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/'

When using `ssimp` you can then pass this directory name to 'ssimp', and specify that only
as subset of individuals (here AFR) should be used:

`ssimp gwas.txt output.txt ~/ref_panels/1000genomes --sample.names super_pop=AFR`

## Minimal example
[//]: -------------------------------

`bin/ssimp --gwas data/my_gwas.txt --ref ~/ref_panels/my_reference_panel.vcf --out output.txt` will impute the Z-statistics, using the selected reference panel (see above) and generate a file `output.txt`. `data/my_gwas.txt` contains at least the following columns: SNP-id, Z-statistic, reference allele and risk allele, and at least one row. The imputed summary statistics are stored in `output.txt`. 

## Documentation
[//]: -------------------------------
Run ssimp with no arguments to see the [usage message](https://github.com/sinarueeger/ssimp_software/blob/master/docu/usage.txt). 
```diff 
- (run ssimp with no arguments: tbd)
```

Check-out [examples](https://github.com/sinarueeger/ssimp_software/blob/master/docu/examples.md).

We also provide a [detailed manual](https://github.com/sinarueeger/ssimp_software/blob/master/docu/manual.md) that contains information not present in the usage message.

