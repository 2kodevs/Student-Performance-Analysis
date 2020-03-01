#path=/media/teno/Backup/Universidad/Clases/4to Año/Probabilidades y Estadística/Estadistica /1er Proyecto/Equipo 6/Equipo 6 - Student Performance/students-data.csv"

load_data <- function(path) {
  return(read.csv(path))
}

process_data <- function(data) {
  r <- table(cut(data, breaks=c(-1, 9, 11, 13, 15, 20), labels=c("[0,10)", "[10,12)", "[12,14)", "[14,16)", "[16,20]")))
  return(r)
}