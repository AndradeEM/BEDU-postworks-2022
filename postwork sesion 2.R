
####### POSTWORK SESION 2 #######

"1) Inspecciona el DataSet iris disponible directamente en la librería de ggplot. 
Identifica las variables que contiene y su tipo, asegúrate de que no hayan datos faltantes y 
que los datos se encuentran listos para usarse."

?ggplot
library(dplyr)
library(ggplot2)

names(iris)  ###variables
head(iris)
class(iris)  ####clase
str(iris)    ###estructura y tipo de variables
complete.cases(iris)

"2) Crea una gráfica de puntos que contenga `Sepal.Lenght` en el eje horizontal, 
`Sepal.Width` en el eje vertical, que identifique `Species` por color y que el tamaño 
de la figura está representado por `Petal.Width`. 
Asegúrate de que la geometría contenga `shape = 10` y `alpha = 0.5`."
###aes es la estetica de la grafica
###shape forma del punto
### alpha que tan fuerte es el punto entre mas grande mas bold
iris1 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species, size = Petal.Width)) +
  geom_point(shape = 10, alpha = 0.5)  
iris1

"3) Crea una tabla llamada `iris_mean` que contenga el promedio de todas las variables 
agrupadas por `Species`."

iris.mean <- iris %>% group_by(Species) %>% summarise(Sepal.Length = mean(Sepal.Length), Sepal.Width = mean(Sepal.Width), Petal.Length = mean(Petal.Length), Petal.Width = mean(Petal.Width))

"4) Con esta tabla, agrega a tu gráfica anterior otra geometría de puntos para agregar 
los promedios en la visualización. Asegúrate que el primer argumento de la geometría 
sea el nombre de tu tabla y que los parámetros sean `shape = 23`, `size = 4`, 
`fill = 'black'` y `stroke = 2`. También agrega etiquetas, temas y los cambios 
necesarios para mejorar tu visualización."

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species, size = Petal.Width)) +
  geom_point(shape = 10, alpha = 0.5) + geom_point(data = iris.mean, shape = 23, size = 4, fill = "black", stroke = 2 )



