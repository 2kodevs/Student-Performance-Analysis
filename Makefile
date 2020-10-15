.DEFAULT_GOAL 	:= help

ANOVA 	:= Fase 2/ANOVA/
REDUC		:= Fase 2/Reduccion/
CLUSTER := Fase 2/Cluster/
DIR			:= $(shell pwd)
FILES		:= $(DIR)/files
DATASET 	:= students-data.csv
CSV			:= $(FILES)/$(DATASET)
SUBCSV		:= $(FILES)/sub-$(DATASET)

anova: ## Run the anova test
	@cd "$(ANOVA)" && echo "$(CSV)" | Rscript anova.r

reduc: ## Run the reduction test
	@cd "$(REDUC)" && echo "$(SUBCSV)" | Rscript reduccion.r

cluster: ## Run the cluster generation
	@cd "$(CLUSTER)" && echo "$(CSV)" | Rscript cluster.r

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
