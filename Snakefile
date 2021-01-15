import shutil

configfile:
    "config.yaml"

# read config file to get run-specific informatoin

INPUT=config['fastqs']
#print(INPUT)

SAMPLES, = glob_wildcards(INPUT + "/{id}-read_1.fq")
#print(SAMPLES)

RESULTS = config['results_loc']
print("Output will be found in the following directory:", RESULTS)

onstart:
	print("The samples used in this analysis are:"),
	print(SAMPLES),
	print("Running the denovo transcriptome assembly pipeline") 


rule all:
    input:
        expand(RESULTS + "/fastq_trimmed/{sample}.1.trimmed.fastq", sample=SAMPLES),
        expand(RESULTS + "/assemblies/{sample}_trinity.Trinity.fasta", sample=SAMPLES),
        expand(RESULTS + "/quantification/{sample}.ok", sample=SAMPLES),
        expand(RESULTS + "/matrices/{sample}.ok", sample=SAMPLES),
        expand(RESULTS + "/assemblies/{sample}.oneiso.Trinity.fasta", sample=SAMPLES),
        expand(RESULTS + "/assemblies/{sample}.oneiso.stats.txt", sample=SAMPLES),
        expand(RESULTS + "/transdecoder/{sample}/longest_orfs.pep", sample=SAMPLES),
        expand(RESULTS + "/blastp/{sample}.blastp.outfmt6", sample=SAMPLES),
        expand(RESULTS + "/hmmer/{sample}.PFAM.out", sample=SAMPLES),
        expand(RESULTS + "/transdecoder/{sample}/{sample}.oneiso.Trinity.fasta.transdecoder.pep", sample=SAMPLES)
	
include:        "rules/fastp.smk"
include:        "rules/trinity.smk"
include:        "rules/abundance.smk"
include:        "rules/make_matrix.smk"
include:        "rules/filter.smk"
include:        "rules/stats.smk"
include:        "rules/trans_longest.smk"
include:        "rules/blastp.smk"
include:        "rules/hmmer.smk"
include:        "rules/trans_predict.smk"

onsuccess:
	print("Transcriptome assembly finished!")
	shutil.rmtree(".snakemake")
