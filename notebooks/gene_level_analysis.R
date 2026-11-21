
library(limma)
library(hgu133plus2.db)
library(AnnotationDbi)

# Load expression matrix
expr <- read.csv(
    "/content/expression_for_limma.csv",
    row.names = 1,
    check.names = FALSE
)

# Map Affymetrix probe IDs to gene symbols
symbols <- mapIds(
    hgu133plus2.db,
    keys = rownames(expr),
    column = "SYMBOL",
    keytype = "PROBEID",
    multiVals = "first"
)

# Keep probes with an assigned gene symbol
valid <- !is.na(symbols) & symbols != ""
expr <- expr[valid, , drop = FALSE]
symbols <- symbols[valid]

# Average expression for probes assigned to the same gene
gene_expr <- avereps(
    as.matrix(expr),
    ID = symbols
)

# Load and align sample groups
groups <- read.csv(
    "/content/sample_groups.csv",
    row.names = 1,
    check.names = FALSE
)

groups <- groups[colnames(gene_expr), , drop = FALSE]
group <- factor(
    groups$Group,
    levels = c("Control", "Alzheimer")
)

# Differential expression analysis
design <- model.matrix(~0 + group)
colnames(design) <- levels(group)

fit <- lmFit(gene_expr, design)

contrast <- makeContrasts(
    Alzheimer - Control,
    levels = design
)

fit2 <- contrasts.fit(fit, contrast)
fit2 <- eBayes(fit2)

gene_results <- topTable(
    fit2,
    coef = 1,
    number = Inf,
    adjust.method = "BH",
    sort.by = "P"
)

write.csv(
    gene_results,
    "/content/gene_level_limma_results.csv"
)

cat("Genes analysed:", nrow(gene_results), "\n")
cat("Significant genes (FDR < 0.05):",
    sum(gene_results$adj.P.Val < 0.05), "\n")
cat("Upregulated genes:",
    sum(gene_results$adj.P.Val < 0.05 &
        gene_results$logFC > 0), "\n")
cat("Downregulated genes:",
    sum(gene_results$adj.P.Val < 0.05 &
        gene_results$logFC < 0), "\n")
