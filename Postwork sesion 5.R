
#############  POSTWORK SESION 5   ###########
"Realizar inferencia estadística para extraer información de la muestra
que sea contrastable con la población"
library(ggplot2)
head(iris)
summary(iris)
"El data frame iris contiene información recolectada por Anderson sobre 50 flores
de 3 especies distintas (setosa, versicolor y virginca), incluyendo medidas en centímetros
del largo y ancho del sépalo así como de los pétalos."

"Utilizando pruebas de inferencia estadística, concluye si existe evidencia suficiente
para concluir que los datos recolectados por Anderson están en línea con los nuevos estudios
Utiliza 99% de confianza para todas las pruebas, en cada caso realiza el planteamiento
de hipótesis adecuado y concluye"

# Ho (H1): <=, =, >=
# Ha (H2): >, !=, <

# Nivel de confianza:99%
# Nivel de significancia (1 - NC): 0.01 # prob cometer error tipo I

# Toma de decisión: Si pvalue >= significancia -> No rechazo Ho
#                   Si pvalue < significancia -> Rechazo Ho

# Para prueba de dos colas: Nivel de significancia/2

#Estudios recientes sobre las mismas especies muestran que:
  
#I. En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es igual a 5.7 cm
#Planteamiento de hipótesis:
# Ho: prom.Sepal.Lenght == 5.7
# Ha: prom.Sepal.Lenght != 5.7

t.test(x = iris[iris$Species == 'setosa', "Sepal.Length"], alternative = "two.sided", mu = 5.7)
# Nivel de significancia = 0.01 -> 0.01/2 = 0.005
#p-value < 2.2e-16     2.2e-16 < 0.005 -->  Se rechaza Ho

#II. En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es menor a 2.1 cm
#Planteamiento de hipótesis:
# Ho: prom.Petal.Width >= 2.1
# Ha: prom.Petal.Width < 2.1

t.test(x = iris[iris$Species == 'virginica', "Petal.Width"], alternative = "less", mu = 2.1)
# Nivel de significancia = 0.01
#p-value = 0.03132     0.03132 > 0.01 No se rechaza Ho

#III. En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más grande
#     que el promedio del largo del pétalo de la especie versicolor.
#Planteamiento de hipótesis:
# Ho: prom.Petal.Length.virgin <= 1.1*prom.Petal.Length.versicolor 
# Ha: prom.Petal.Length.virgin > 1.1*prom.Petal.Length.versicolor 

var.test(iris[iris$Species == 'virginica', "Petal.Width"], 
         iris[iris$Species == 'versicolor', "Petal.Width"], 
         ratio = 1, alternative = "two.sided")

t.test(x = iris[iris$Species == 'virginica', "Petal.Width"], y = iris[iris$Species == 'versicolor', "Petal.Width"],
       alternative = "greater",
       mu = 1.1, var.equal = TRUE)
# Nivel de significancia = 0.01
#p-value = 1     1 > 0.01 No se rechaza Ho

#IV. En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies.
"Planteamiento de hipótesis:
Ho: prom.Sepal.Width.virginica = prom.Sepal.Width.versicolor = prom.Sepal.Width.setosa
Ha: Al menos uno es diferente."
?boxplot
boxplot(Sepal.Width ~ Species,
        data = iris)

anova <- aov(Sepal.Width ~ Species,
             data = iris)
summary(anova)






