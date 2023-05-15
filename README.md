# Uniquely-Aligned
Shell script for generating uniquely mapped bam/index files from Illumina Next-Seq

This script will utilize trim_galore, bowtie2 and samtools for QC, alignment, and duplicate removal to generate uniquely mapped read BAM files with indexes. 

To install these packages through conda please create a new environment and run the following commands:

conda install -c bioconda trim-galore

conda install -c bioconda bowtie2

conda install -c bioconda samtools

These index files can then be views in genome viewers, such as IGV. 

This script is made for paired-end reads generated from Illumina Next-Seq. Before running this script check your file naming. The script expects an ending of R1_001.fastq.gz. If this is not how your file is format, please edit line 2 and likely line 5 (based on the ouput received from trim_galore). Additionally, please change line 5's "/Path/To/Bowtie/Index" to your actual path. 
