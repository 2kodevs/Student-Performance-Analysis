load_data <- function(root) {
    data <- read.csv(root)
    return(data)
}

main <- function(root){
    cat("Enter the csv dir:\n")
    data <- load_data(readLines("stdin", n=1))
    data$id <- NULL

    png('images/correlation-plot.png')
    plot(data)
    dev.off()

    matrix <- cor(data)
    print("     --- Corelation Matrix ---")
    print(matrix)    

    print("")
    print("     --- Corelation Summary ---")
    print(symnum(matrix))

    print("")
    print("     --- ACP ---")
    acp <- prcomp(data, scale=TRUE)
    print(summary(acp))
    png('images/acp-plot.png')
    plot(acp)
    dev.off()

    print("")
    print("     --- ACP Rotation ---")
    print(acp$rotation)
    
    png('images/bi-plot.png')
    biplot(acp)
    dev.off()
}

main()