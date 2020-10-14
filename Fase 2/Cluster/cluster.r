require(lmtest)

load_data <- function(root) {
    return(read.csv(root, nrows=30))
}

select_data <- function(data) {
    return(data.frame(data$G1.x, data$G2.x, data$G3.x, data$G1.y, data$G2.y, data$G3.y))
}

jerarquical <- function(data){
    png('images/jerarquical.png')
    d <- dist(data, method="euclidean")
    fit <- hclust(d, method="complete")
    plot(fit)
    rect.hclust(fit, k=6, border="red")
    dev.off()
}

nonjerarquical <- function(data){
    fit <- kmeans(data, 6)
    print(fit)
}

main <- function() {
    cat("Enter the csv dir:\n")
    df <- load_data(readLines("stdin", n=1))

    std <- scale(select_data(df))
    
    jerarquical(std)
    nonjerarquical(std)
}

main()
