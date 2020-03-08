get_measures = function(x) {
	return(c(Mean = mean(x), Mode = getmode(x), Median = median(x), Variance = var(x), Sd = sd(x), DC = sd(x) / mean(x)))
}

getmode <- function(v) {
	uniqv <- unique(v)
	uniqv[which.max(tabulate(match(v, uniqv)))]
}

poblation = rnorm(500)

sample_350 = sample(poblation,size=350,replace=FALSE)
sample_150 = sample(poblation,size=150,replace=FALSE)
sample_30 = sample(poblation,size=30,replace=FALSE)
sample_20 = sample(poblation,size=20,replace=FALSE)

sample_350_r = sample(poblation,size=350,replace=TRUE)
sample_150_r = sample(poblation,size=150,replace=TRUE)
sample_30_r = sample(poblation,size=30,replace=TRUE)
sample_20_r = sample(poblation,size=20,replace=TRUE)

# getting measure values

measures = c(
	get_measures(sample_20),
	get_measures(sample_20_r),
	get_measures(sample_30),
	get_measures(sample_30_r),
	get_measures(sample_150),
	get_measures(sample_150_r),
	get_measures(sample_350),
	get_measures(sample_350_r),
	get_measures(poblation)
)

# generating bar plots for c)

bar_names = c(
	"20",
	"20R",
	"30",
	"30R",
	"150",
	"150R",
	"350",
	"350R",
	"Pob."
)

graphic_names = c("Mean", "Mode", "Median", "Variance", "Standard Deviation", "Deviation Coefficient")
cols = length(graphic_names)

M = t(matrix(measures, ncol=cols, byrow=TRUE))

par(mfrow=c(2,3))

for(i in c(1:cols)) 
	barplot(M[i,], names.arg=bar_names, main=graphic_names[i], col="#a1e6e3")

mean_conf_interval = function(sample, alpha) {
	m = mean(sample)
	s = sd(sample)
	n = length(sample)

	error = 0

	if(n > 30) {
		error = qnorm(1 - alpha / 2)
	}

	else {
		error = qt(1 - alpha / 2, n - 1)
	}

	st = m - error * s / sqrt(n)
	nd = m + error * s / sqrt(n)

	return(c(start=st, end=nd))
}

variance_conf_interval = function(sample, alpha) {
	n = length(sample)
	vr = var(sample)

	q1 = qchisq(1 - alpha / 2, n - 1)
	q2 = qchisq(alpha / 2, n - 1)

	st = (n - 1) * vr / q1
	nd = (n - 1) * vr / q2

	return(c(start=st, end=nd))
}

print("Mean confidence intervals for S20 and S20R")
print(mean_conf_interval(sample_20, 0.05))
print(mean_conf_interval(sample_20_r, 0.05))
print("", quote=FALSE)

print("Var confidence interval for S20 and S20R")
print(variance_conf_interval(sample_20, 0.05))
print(variance_conf_interval(sample_20_r, 0.05))
print("", quote=FALSE)

print("Mean confidence intervals for S30 and S30R")
print(mean_conf_interval(sample_30, 0.05))
print(mean_conf_interval(sample_30_r, 0.05))
print("", quote=FALSE)

print("Var confidence interval for S30 and S30R")
print(variance_conf_interval(sample_30, 0.05))
print(variance_conf_interval(sample_30_r, 0.05))
print("", quote=FALSE)

print("Mean confidence intervals for S150 and S150R")
print(mean_conf_interval(sample_150, 0.05))
print(mean_conf_interval(sample_150_r, 0.05))
print("", quote=FALSE)

print("Var confidence interval for S150 and S150R")
print(variance_conf_interval(sample_150, 0.05))
print(variance_conf_interval(sample_150_r, 0.05))
print("", quote=FALSE)

print("Mean confidence intervals for S350 and S350R")
print(mean_conf_interval(sample_350, 0.05))
print(mean_conf_interval(sample_350_r, 0.05))
print("", quote=FALSE)

print("Var confidence interval for S350 and S350R")
print(variance_conf_interval(sample_350, 0.05))
print(variance_conf_interval(sample_350_r, 0.05))
print("", quote=FALSE)