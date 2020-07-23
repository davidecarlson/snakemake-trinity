rule stats:
    input:
        filtered=RESULTS + "/assemblies/{sample}.oneiso.Trinity.fasta",
        assembly=RESULTS + "/assemblies/{sample}_trinity.Trinity.fasta"
    output:
        stats_oneiso=RESULTS + "/assemblies/{sample}.oneiso.stats.txt",
        stats_all=RESULTS + "/assemblies/{sample}.stats.txt"
    shell:
        "/home/progs/trinityrnaseq-v2.11.0/util/TrinityStats.pl {input.assembly} > {output.stats_all} "
        "&& /home/progs/trinityrnaseq-v2.11.0/util/TrinityStats.pl {input.filtered} > {output.stats_oneiso}"
