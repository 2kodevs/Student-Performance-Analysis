## Árbol de Clasificación

Construimos un árbol para analizar si un estudiante determinado debe optar por tener profesores particulares (además de los de la escuela) o no. Para esto utilizamos las siguiente variables cualitativas:

- `famsup.x` (apoyo educacional por parte de la familia)
- `higher.x` (quiere tener una educación universitaria)
- `nursery` (atiende además a la escuela de medicina)
- `activities.x` (hace actividades extracurriculares)
- `internet` (tiene internet)
- `sex` (sexo M o F)

Obtenemos el siguiente árbol, en el cual se pueden ver las probabilidades de si un estudiante debe optar por profesores particulares o no:

![Tree](tree.png "Árbol de Clasificación")

El error de entrenamiento es de 0.3879.