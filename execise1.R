#path=/media/teno/Backup/Universidad/Clases/4to Año/Probabilidades y Estadística/Estadistica /1er Proyecto/Equipo 6/Equipo 6 - Student Performance/students-data.csv"

load_data <- function(path) {
  return(read.csv(path))
}

process_data <- function(data) {
  r <- table(cut(data, breaks=c(-1, 9, 11, 13, 15, 20), labels=c("[0,10)", "[10,12)", "[12,14)", "[14,16)", "[16,20]")))
  return(r)
}

percent <- function(x, s) {
  return(round((x * 100 / s)))
}

bar_data <- function(x) {
  lbls <- c("Fail", "Sufficient", "Satisfactory", "Good", "Excellent/Very Good")
  cls <- c("red", "light green", "dark green", "blue", "dark blue")
  barplot(x, ylim=c(0,130), col=cls, legend=lbls)
}

pie_data <- function(x) {
  s <- sum(x)
  pct <- round(percent(x, s))
  lbls <- c("Fail", "Sufficient", "Satisfactory", "Good", "Excellent/Very Good")
  lbls2 <- paste(lbls, " ", pct, "%", sep="")
  cls <- c("red", "light green", "dark green", "blue", "dark blue")
  pie(x, labels=lbls2, col=cls)
}

hist_data <- function(data, g) {
  cls <- c("red","dark green", "blue")
  hist(data, col=cls, xlab="Grades", main=paste("Histogram of Grades period", g))
}

map <- function(l, f, args) {
  temp <- c()
  for (i in 1:length(l)) {
    temp[i] <- f(l[i], args)
  }
  return(temp)
}

pipeline <- function(data) {
  d1 <- process_data(data$G1.y)
  d2 <- process_data(data$G2.y)
  d3 <- process_data(data$G3.y)
  
  print(d1)
  print(d2)
  print(d3)
  
  hist_data(data$G1.y, 1)
  hist_data(data$G2.y, 2)
  hist_data(data$G3.y, 3)
  
  bar_data(d1)
  bar_data(d2)
  bar_data(d3)
  
  pie_data(d1)
  pie_data(d2)
  pie_data(d3)
  
  to_line_chart(d1, d2, d3)
}


to_line_chart <- function(f1, f2, f3) {
  df <- data.frame(f1, f2, f3)
  y <- c()
  x <- c()
  for (i in 1:length(f1)) {
    y <- c(y, 1, 2, 3)
    x <- c(x, df$Freq[i], df$Freq.1[i], df$Freq.2[i])
  }
  plot(y, x, type="n", ylab = "frequence", xlab="time")
  cls <- c("red", "light green", "dark green", "blue", "dark blue")
  linetype <- c(1:length(f1))
  plotchar <- seq(18, 18+length(f1), 1)
  for (i in 0:(length(f1)-1)) {
    lines(y[(i*3+1):(i*3+3)], x[(i*3+1):(i*3+3)], 
          type="b", 
          lwd=2, 
          lty=linetype[i + 1], 
          col=cls[i + 1], 
          pch=plotchar[i + 1] 
    ) 
  }
}

exercise3 <- function(data) {
  t <- table(d$G3.y, d$sex)
  
  main_message <- "Grades of both sex in period 3"
  boxplot(data$G3.y ~ data$sex, data=t, ylab="Grades", xlab="Sex", las=1, varwidth=TRUE, notch=TRUE, main=main_message)
  M <- t[1:(length(t)/2), 1]
  F <- t[1:(length(t)/2), 2]
  
  print(var.test(x=M, y=F, conf.level=0.95))
  print(t.test(M, F))
}