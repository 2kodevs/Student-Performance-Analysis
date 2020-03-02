get_measures = function(x) {
	return(c(mean(x), getmode(x), median(x), var(x), sd(x), sd(x) / mean(x)))
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

for(i in c(1:cols)) 
	barplot(M[i,], names.arg=bar_names, main=graphic_names[i], col="#a1e6e3")
