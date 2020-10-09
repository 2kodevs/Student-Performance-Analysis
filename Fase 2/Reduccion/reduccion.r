load_data <- function(root) {
    data <- read.csv(root)
    return(data)
}

select_test_data <- function(data) {
    data$id             <- NULL
    data$sex            <- NULL
    data$Mjob           <- NULL
    data$Fjob           <- NULL
    data$school         <- NULL
    data$reason         <- NULL
    data$paid.x         <- NULL
    data$nursery        <- NULL
    data$address        <- NULL
    data$Pstatus        <- NULL
    data$famsize        <- NULL
    data$internet       <- NULL
    data$higher.x       <- NULL
    data$famsup.x       <- NULL
    data$romantic.x     <- NULL
    data$guardian.x     <- NULL
    data$schoolsup.x    <- NULL
    data$activities.x   <- NULL

    data$G1.y           <- NULL
    data$G2.y           <- NULL
    data$G3.y           <- NULL
    data$paid.y         <- NULL
    data$Dalc.y         <- NULL
    data$Walc.y         <- NULL
    data$goout.y        <- NULL
    data$health.y       <- NULL
    data$higher.y       <- NULL
    data$famsup.y       <- NULL
    data$famrel.y       <- NULL
    data$absences.y     <- NULL
    data$guardian.y     <- NULL
    data$romantic.y     <- NULL
    data$freetime.y     <- NULL
    data$failures.y     <- NULL
    data$studytime.y    <- NULL
    data$schoolsup.y    <- NULL
    data$activities.y   <- NULL
    data$traveltime.y   <- NULL

    write.csv(data, file = "sub-students-data.csv")
    return(data)
}

main <- function(root){
    cat("Enter the csv dir:\n")
    data <- select_test_data(load_data(readLines("stdin", n=1)))

    png('images/correlation-plot.png', width=1900, height=1900, res=40)
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