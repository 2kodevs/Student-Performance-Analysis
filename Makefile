.DEFAULT_GOAL 	:= help

ANOVA 	:= Fase 2/ANOVA/
DIR 	:= $(shell pwd)
CSV		:= $(DIR)/students-data.csv

anova: ## Run the anova test
	@cd "$(ANOVA)" && echo "$(CSV)" | Rscript anova.R

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
