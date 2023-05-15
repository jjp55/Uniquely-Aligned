echo Trimming Reads
for file in *_R1_001.fastq.gz; do trim_galore --paired $file "`basename $file _R1_001.fastq.gz`_R2_001.fastq.gz"; done

echo Aligning
for file in *_R1_001_val_1.fq.gz; do bowtie2 -x /Path/To/Bowtie/Index -1 $file -2 "`basename $file _R1_001_val_1.fq.gz`_R2_001_val_2.fq.gz" -S "`basename $file _R1_001_val_1.fq.gz`.sam"; done

echo Removing Duplicate Reads and Indexing
for file in *.sam; do samtools view -S -b $file > "`basename $file .sam`.bam"; done
for file in *.bam; do samtools fixmate -m $file "`basename $file .bam`_fix.bam"; done 
for file in *_fix.bam; do samtools sort -o "`basename $file _fix.bam`_sort.bam" $file; done
for file in *_sort.bam; do samtools markdup -r -s $file "`basename $file _sort.bam`_unique.bam"; done


echo Removing Intermediate Files
for file in *_fix.bam; do rm $file; done
for file in *sort.bam; do rm $file; done

echo Finishing Up
for file in *_unique.bam; do samtools index $file; done

echo Organizing Files

mkdir uniqueReads/
for file in *_unique.bam; do mv $file uniqueReads; done
for file in *bai; do mv $file uniqueReads; done

mkdir rawData/
for file in *.fastq.gz; do mv $file rawData; done

mkdir trimmed/ 
for file in *.fq.gz; do mv $file trimmed; done
for file in *.txt; do mv $file trimmed; done

mkdir fullAlignmentFiles
for file in *.sam; do mv $file samFiles; done
for file in *.bam; do mv $file samFiles; done
