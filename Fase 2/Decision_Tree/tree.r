dir = '/home/daniel/Projects/Student-Performance-Analysis/students-data.csv'

load_data <- function(path) {
  return(read.csv(path))
}

df <- load_data(dir)
df <- df[2:34]  # using only first dataset

fcols <- c()

for(i in 1:length(df)) {
  if(is.factor(df[,i]) && length(levels(df[,i])) == 2)
    fcols <- c(fcols, i)
}

qual <- subset(df, select=fcols)
rows <- dim(qual)[1]

print(names(qual))

set.seed(2)
s <- sample(1:rows, 2*rows/3)

require(rpart)
tree <- rpart(paid.x ~ ., data=qual[s,])

print(summary(tree))

png('report/tree.png', width=800, height=400)
plot(tree)
text(tree, use.n=TRUE, all=TRUE, pretty=0, xpd=TRUE)
dev.off()

pred <- predict(tree, newdata=qual[-s,], type="vector")
print(pred)
print("----------")

conf <- table(pred, qual[-s,]$paid.x)
print(conf)
print("----------")

error <- 1 - (sum(diag(conf)) / sum(conf))
print(error)