###AUthor: Ariadna Cilleros Portet
##Date: 27/09/2018
#Exercise 1

#First of all to download the file in a specific directory we have to move there and run the command from there, in these case we will do: 
cd bash_HandsOn
cd exercises

wget (link)

#To take a look in the file we can use "cat":

less TAIR9_mRNA.bed

#If the file is compressed we will run the next command:

gunzip -l TAIR9_mRNA.bed
#Watch out: we have to compress the file first (gzip TAIR9_mRNA.bed)

#Once we uncompress the file, to find the genes that are in th chromosome 1 and in the plus strand, we will use "grep" to select the lines with these two characteristics and then we use the "wc" to count how many lines the "grep" has select: 

wc <(grep + <(grep chr1 TAIR9_mRNA.bed))
#My anwser is 4366 genes. 

#Considering that the exon sizes of each gene entry in file TAIR9_mRNA.bed are located in field number 11, get the first 10 lists of exon sizes. After the extraction, remove the last comma and print the length of the last exon (you can use sed and awk for that, respectively) How would you now reorder the records so that the first number shown is the largest exon size? Remove the repeated values.
awk '{print$NF}' <(sed 's/,/ /g' <(head -n 10 <(awk '{print$11}' TAIR9_mRNA.bed))) #With this we obtain the large of the last exon of the 10 first genes. NF means the last field of each line. 

uniq <(sort -nr <(awk '{print$NF}' <(sed 's/,/ /g' <(head -n 10 <(awk '{print$11}' TAIR9_mRNA.bed))))) 

#How would get the length of the ten longest exons in chromosome 1?

grep chr1 TAIR9_mRNA.bed | awk '{print$11}' | tr , "\n" | sort -nr | head

#How would you get the name of the gene and the number of exons of the ten genes with more exons in chromosome 1? (in case there were duplicates, do not show them)
# amb -k2,2 li estem indicant que volem que ordeni (sort) per la segona columna
grep chr1 TAIR9_mRNA.bed | awk '{print$4"\t"$10}' | sort -nr -k2,2 | uniq | head 

