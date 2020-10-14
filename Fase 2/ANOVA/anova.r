require(lmtest)

box_plot <- function(df, label) {
    title <- 'Box-plot de las medias por zona'
    png(paste('images/box-', label, '.png', sep = ''))
    plot(
        df$measure ~ df$addr, 
        data=df,
        xlab="Zona",
        ylab="Resultado medio",
        main=title
    )
    dev.off()
}

qq_plot <- function(residuals, label) {
    png(paste('images/qq-', label, '.png', sep=''))
    qqnorm(residuals)
    qqline(residuals)
    dev.off()
}

hist_plot <- function(residuals, label) {
    png(paste('images/hist-', label, '.png', sep=''))
    hist(residuals)
    dev.off()
}

std_plot <- function(anova, label) {
    png(paste('images/std-', label, '.png', sep=''))
    plot(
        anova$fitted.values, 
        rstudent(anova), 
        ylab='Residuals',
        xlab='Predictions',
        main='Anova Residuals'
    )
    abline(h = 0, lty = 2)
    dev.off()
}

plot_assumptions <- function(anova, label) {
    png(paste('images/all-', label, '.png', sep=''))
    layout(matrix(c(1,2,3,4), 2, 2, byrow=T))
    plot(
        anova$fitted.values, 
        rstudent(anova), 
        ylab='Residuals',
        xlab='Predictions',
        main='Anova Residuals'
    )
    abline(h = 0, lty = 2)
    residuals <- anova$residuals
    hist(residuals)
    qqnorm(residuals)
    qqline(residuals)
    dev.off()
}

test_assumptions <- function(anova, df) {
    print("    ++ Shapiro ++     ")
    print(shapiro.test(anova$residuals))

    print("    ++ Bartlett ++     ")
    print(bartlett.test(anova$residuals, df$addr))

    print("    ++ Durbin-Watson ++     ")
    print(dwtest(anova))
}

make_model <- function(df, label) {
    # Box Plot
    box_plot(df, label)

    # Anova analysis
    anova <- aov(df$measure ~ df$addr, data=df)
    res <- anova$residuals

    print(paste('---------', label, '---------'))
    print('    ++ Anova ++    ')
    print(summary(anova))

    # Check anova residual assumptions
    # Test
    test_assumptions(anova, df)

    # Plots
    plot_assumptions(anova, label)
    # Plot in separated images
    std_plot(anova, label)
    hist_plot(res, label)
    qq_plot(res, label)
    
    return()
}

scores <- function(data, i) {
    return(mean(c(data$G1.x[i], data$G2.x[i], data$G3.x[i])))
}

load_data <- function(root) {
    data <- read.csv(root)

    lvl1 <- c()
    lvl2 <- c()
    lvls <- levels(data$address)
    ln <- length(data$sex)
    for(i in 1:ln){
        if (data$address[i] == lvls[1]) {
            lvl1 <- c(lvl1, scores(data, i))
        } else {
            lvl2 <- c(lvl2, scores(data, i))
        }
    }
    amount <- min(length(lvl1), length(lvl2))
    
    measure <- c(lvl1[1:amount], lvl2[1:amount])
    addr <- c(rep(lvls[1], amount), rep(lvls[2], amount))

    return(data.frame(addr, measure))
}

main <- function() {
    cat("Enter the csv dir:\n")
    df <- load_data(readLines("stdin", n=1))
    
    make_model(df, 'zona')
}

main()
