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

df <- subset(df, select=fcols)

print(names(df))

require(caTools)
set.seed(127)
split <- sample.split(df, SplitRatio = 0.75)
training_set <- subset(df, split == TRUE)
test_set <- subset(df, split == FALSE)

require(rpart)
tree <- rpart(paid.x ~ ., data=training_set)

print(summary(tree))

png('report/tree.png')
require(rpart.plot)
rpart.plot(tree, type=1, fallen.leaves=F, cex=1, extra=102, under=T)
dev.off()

pred <- predict(tree, newdata=test_set, type="vector")
print(pred)

conf <- table(pred, test_set$paid.x)
print(conf)

error <- 1 - (sum(diag(conf)) / sum(conf))
print(error)