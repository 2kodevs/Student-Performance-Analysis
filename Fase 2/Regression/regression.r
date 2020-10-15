dir = '/home/daniel/Projects/Student-Performance-Analysis/students-data.csv'

load_data <- function(path) {
  return(read.csv(path))
}

df <- load_data(dir)
df <- df[2:34]  # using only first dataset

fcols <- c()
cols <- c()

for(i in 1:length(df)) {
  if(is.factor(df[,i]))
    fcols <- c(fcols, i)
  else cols <- c(cols, i)
}

qual <- subset(df, select=fcols)
quant <- subset(df, select=cols)
scaled_quant <- apply(quant, 2, scale)

df <- data.frame(qual, scaled_quant)

sink("report/output.txt")

print(cor(quant))

mod <- lm(G3.x ~ ., data=df)
mod <- MASS::stepAIC(mod, direction="backward", trace = 0, k = log(nrow(df)))
print(summary(mod))

print('Media de error residual (scaled)')
print(mean(mod$residuals))

print('Suma de error residual (scaled)')
print(sum(mod$residuals))

png('report/plots.png', width=800, height=400)
par(mfrow=c(1,2))

hist(mod$residuals, xlab='Residuals')
qqnorm(mod$residuals)
qqline(mod$residuals)

dev.off()

require(lmtest)
dwtest(mod)

pred = predict(mod, data=df)

print('Predicciones en modelo escalado')
print(pred)

print('Errores residuales')
print(residuals(mod))

png('report/homo.png')
plot(pred, residuals(mod), xlab='Predictions', ylab='Residuals of scaled model')
abline(h=0, lty=2)
dev.off()

sink()