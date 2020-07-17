
rule fastp:
    input:
        reads=INPUT + "/{sample}.fastq",
        #rev=INPUT + "/{sample}-read_2.fq"
    output:
        reads=RESULTS + "/fastq_trimmed/{sample}.trimmed.fastq",
        #rev=RESULTS + "/fastq_trimmed/{sample}.2.trimmed.fastq",
        html=RESULTS + "/fastq_trimmed/{sample}.html",
        json=RESULTS + "/fastq_trimmed/{sample}.json"
    threads:
        5
    log:
        RESULTS + "/logs/fastp/{sample}.preprocess.log"
    shell:
        "fastp --in1 {input.reads} "
        "--out1 {output.reads} --thread {threads} --cut_tail --html {output.html} --json {output.json} 2> {log}"
