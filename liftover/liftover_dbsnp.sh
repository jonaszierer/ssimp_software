##
cd /data/sgg/sina/public.data/dbsnp

## transform bcp.gz to bed file (which is needed for liftover)
## ------------------
zcat b150_SNPChrPosOnRef_108.bcp.gz  | egrep -v NotOn | egrep -v Un | awk '{print "chr"$2"\t"$3"\t"($3+1)"\trs"$1"\t"$2}' > tmp.bed ## rearranges the columns and removes lines with "NotOn" and "Un"

awk -F'\t' 'x$2' tmp.bed > dbsnp_hg20.bed  ## removes lines that have an empty field in the second column
#awk '!/^\t|\t\t\t|\t$/' infile ## removes all lines that have an empty field in any column


## do liftover hg20 > hg19
## ---------------------
/data/sgg/sina/software/liftOver/liftOver /data/sgg/sina/public.data/dbsnp/dbsnp_hg20.bed /data/sgg/sina/software/liftOver/hg20ToHg19.over.chain /data/sgg/sina/public.data/dbsnp/liftover_hg19.bed /data/sgg/sina/public.data/dbsnp/unlifted_hg19.bed

## do liftover hg20 > hg18
## ---------------------
/data/sgg/sina/software/liftOver/liftOver /data/sgg/sina/public.data/dbsnp/liftover_hg19.bed /data/sgg/sina/software/liftOver/hg19ToHg18.over.chain /data/sgg/sina/public.data/dbsnp/liftover_hg18.bed /data/sgg/sina/public.data/dbsnp/unlifted_hg18.bed

## merge files together
## --------------------
cd /data/sgg/sina/public.data/dbsnp
awk 'FNR==NR{a[$4]=$3;next}{if(a[$4]==""){a[$4]=0}; print $3,a[$4],$4,$5}' dbsnp_hg20.bed liftover_hg19.bed > tmp.txt

awk 'FNR==NR{a[$4]=$3;next}{if(a[$4]==""){a[$4]=0}; print a[$3],$1,$2,$3,$4}' liftover_hg18.bed tmp.txt > dbsnp_hg18_hg19_hg20.txt

rm tmp.txt


#FORMAT
#dbsnp_hg18_hg19_hg20.txt

#pos_hg18 pos_hg19 pos_hg20 rs  chr
#91617493 91779557 92150243 rs7 7
#...
