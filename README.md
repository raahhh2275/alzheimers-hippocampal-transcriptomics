# alzheimers-hippocampal-transcriptomics
# Alzheimer's Disease Hippocampal Transcriptomic Analysis

### Investigating neuroinflammation-associated processes and synaptic dysfunction using the GSE5281 microarray dataset

## 1. Project Overview

Alzheimer's disease (AD) is a progressive neurodegenerative disorder associated with neuronal dysfunction, synaptic alterations and changes in cellular metabolism.

This project uses publicly available gene-expression data to investigate molecular differences between Alzheimer's disease and control hippocampal samples.

The analysis combines exploratory data analysis, differential gene-expression analysis, microarray probe annotation and biological pathway enrichment.

**Main biological themes investigated:**
- Mitochondrial function and cellular energy metabolism
- Synaptic vesicle transport and synaptic processes
- Interferon-associated biological processes

This is an exploratory computational biology project. The results identify statistical associations and do not establish causation or clinical significance.

## 2. Research Objectives

1. Obtain and prepare hippocampal expression data from GEO.
2. Compare Alzheimer's disease and control samples.
3. Identify differentially expressed probe sets and genes.
4. Annotate microarray probes with gene information.
5. Identify enriched Gene Ontology and KEGG pathways.
6. Investigate synaptic and interferon-associated biological processes.
7. Visualize and interpret the results.

## 3. Dataset Information

| Parameter | Description |
|---|---|
| GEO accession | GSE5281 |
| Platform | GPL570 |
| Technology | Affymetrix Human Genome U133 Plus 2.0 microarray |
| Tissue | Hippocampus |
| Total samples | 23 |
| Control samples | 13 |
| Alzheimer's samples | 10 |

**Dataset source:** [NCBI GEO – GSE5281](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281)

The analysis uses the deposited processed Series Matrix expression values, which were log2-transformed.

**Data-processing limitation:** Raw CEL files were not processed. RMA normalization was not performed. This project uses processed microarray signals and does not use an RNA-sequencing workflow.

## 4. Computational Workflow

### Step 1 – Data acquisition and preparation
- Downloaded the GEO Series Matrix.
- Selected hippocampal samples.
- Extracted sample metadata and expression values.
- Converted expression values to numeric format.
- Checked for missing and infinite values.
- Applied log2 transformation.

### Step 2 – Exploratory data analysis
- Expression distribution plots
- Sample correlation analysis
- Hierarchical clustering
- Disease-group-labelled clustering

### Step 3 – Differential expression analysis

Differential expression was performed using the R/Bioconductor package **limma**.

The comparison was:

**Alzheimer's disease – Control**

The analysis used linear modelling and empirical Bayes moderation. Multiple-testing correction was performed using the Benjamini–Hochberg method.

Significance threshold: **adjusted p-value (FDR) < 0.05**.

Positive log fold-change indicates higher expression in Alzheimer's disease samples; negative log fold-change indicates lower expression.

### Step 4 – Probe annotation

Probe identifiers were annotated using:
- `hgu133plus2.db`
- `AnnotationDbi`

Gene symbols, gene names and Entrez identifiers were retrieved where available.

### Step 5 – Gene-level analysis

Probe sets mapped to gene symbols were grouped, and their expression values were averaged using `limma::avereps`. A separate gene-level differential expression analysis was performed.

### Step 6 – Functional enrichment

Pathway enrichment was performed using:
- `clusterProfiler`
- `org.Hs.eg.db`

Gene Ontology (GO) and KEGG enrichment analyses were performed separately for upregulated and downregulated genes.

## 5. Results

### 5.1 Probe-level differential expression

After excluding 62 AFFX control probe sets, 54,613 probe sets were analysed.

| Result | Count |
|---|---:|
| Total probe sets analysed | 54,613 |
| Significant probe sets | 6,545 |
| Upregulated | 4,273 |
| Downregulated | 2,272 |

Of the analysed probe sets, 44,637 were annotated and 9,976 remained unmapped.

### 5.2 Gene-level differential expression

| Result | Count |
|---|---:|
| Genes analysed | 21,355 |
| Significant genes | 1,893 |
| Upregulated | 1,015 |
| Downregulated | 878 |

### 5.3 Biological pathway enrichment

Downregulated genes showed enrichment in biological processes associated with:

- Cellular respiration
- Aerobic respiration
- Oxidative phosphorylation
- ATP metabolism
- Respiratory electron transport chain
- Mitochondrial organization

KEGG enrichment included neurodegeneration-associated pathway labels, ribosome function, proteasome activity and oxidative phosphorylation.

The appearance of Parkinson's disease, Huntington's disease and ALS pathway labels reflects shared molecular components in pathway databases. It does not indicate that these diseases were present in the analysed individuals.

### 5.4 Synaptic processes

Enriched synaptic GO terms included:

- Vesicle-mediated transport in synapse
- Synaptic vesicle cycle
- Presynaptic endocytosis
- Synaptic vesicle endocytosis
- Synaptic vesicle recycling
- Synaptic vesicle maturation

These findings indicate that genes associated with synaptic vesicle processes were overrepresented among the downregulated genes.

### 5.5 Interferon-associated processes

The following terms were enriched among downregulated genes:

- Cellular response to type I interferon
- Response to type I interferon

These results indicate altered expression of genes associated with interferon-related processes. They do not independently establish the overall level of neuroinflammation or microglial activation.

## 6. Biological Interpretation

The analysis identified three notable biological themes.

**Mitochondrial and energy metabolism:** Enrichment of cellular respiration, oxidative phosphorylation and ATP-related processes suggests altered expression of genes involved in cellular energy metabolism.

**Synaptic function:** Enrichment of synaptic vesicle transport, recycling and endocytosis suggests changes in the expression of genes involved in synaptic communication.

**Interferon-associated processes:** Enrichment of type I interferon response terms among downregulated genes indicates changes in expression of genes associated with this biological response.

These findings provide exploratory evidence of molecular differences involving energy metabolism, synaptic processes and immune-associated pathways in the analysed hippocampal samples.

## 7. Figures

The `results/` directory contains:

| Figure | Description |
|---|---|
| `volcano_plot.png` | Differential expression overview |
| `GO_pathway_summary.png` | Enriched pathway summary |
| `top30_gene_heatmap.png` | Expression patterns of selected genes |
| `expression_distribution.png` | Expression distributions across samples |
| `sample_correlation.png` | Sample-to-sample correlation |
| `disease_labelled_clustering.png` | Hierarchical clustering with disease labels |

## 8. Software and Tools

**Languages**
- Python
- R

**Python libraries**
- pandas
- NumPy
- Matplotlib
- Seaborn
- SciPy
- statsmodels

**R/Bioconductor packages**
- limma
- hgu133plus2.db
- AnnotationDbi
- clusterProfiler
- org.Hs.eg.db

**Environment:** Google Colab

## 9. Repository Structure

```text
alzheimers-hippocampal-transcriptomics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   ├── 01_Alzheimers_Data_Exploration.ipynb
│   └── gene_level_analysis.R
│
├── results/
│   ├── limma_differential_expression.csv
│   ├── limma_annotated_results.csv
│   ├── gene_level_limma_results.csv
│   ├── GO_downregulated.csv
│   ├── GO_upregulated.csv
│   ├── KEGG_downregulated.csv
│   ├── KEGG_upregulated.csv
│   ├── final_pathway_gene_table.csv
│   ├── volcano_plot.png
│   ├── GO_pathway_summary.png
│   ├── top30_gene_heatmap.png
│   ├── expression_distribution.png
│   ├── sample_correlation.png
│   └── disease_labelled_clustering.png
│
└── README.md
```

The folder structure describes the intended organization. Data files should be added only when they are actually present in the repository.

## 10. Limitations

1. The analysis includes 23 samples, which limits statistical power and generalizability.
2. The dataset contains processed microarray signals rather than raw CEL files.
3. Raw-data preprocessing and RMA normalization were not performed.
4. Probe annotation may be incomplete or ambiguous.
5. Averaging multiple probes per gene can conceal probe-specific differences.
6. Potential biological and technical confounding factors may influence the results.
7. Pathway enrichment identifies statistical overrepresentation, not direct pathway activity.
8. The analysis is observational and cannot establish causation.
9. Independent datasets and experimental validation are needed to confirm the findings.

## 11. References

1. NCBI Gene Expression Omnibus. GSE5281. https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281
2. Ritchie ME, et al. Limma powers differential expression analyses for RNA-sequencing and microarray studies. *Nucleic Acids Research*. 2015;43(7):e47. https://doi.org/10.1093/nar/gkv007
3. Yu G, Wang LG, Han Y, He QY. clusterProfiler: an R package for comparing biological themes among gene clusters. *OMICS*. 2012;16(5):284–287. https://doi.org/10.1089/omi.2011.0118
4. Gene Ontology Consortium. https://geneontology.org/
5. Kanehisa M, Goto S. KEGG: Kyoto Encyclopedia of Genes and Genomes. *Nucleic Acids Research*. 2000;28(1):27–30. https://doi.org/10.1093/nar/28.1.27

## 12. Disclaimer

This repository contains an academic bioinformatics analysis of publicly available gene-expression data. It is intended for educational and research purposes and is not intended for clinical diagnosis or medical decision-making.
