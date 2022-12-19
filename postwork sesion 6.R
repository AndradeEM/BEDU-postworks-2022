########### POSTWORK SESION 6  ###########

"Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre como mejorar
las ventas de un producto particular, y el conjunto de datos con el que disponemos son
datos de publicidad que consisten en las ventas de aquel producto en 200 diferentes mercados,
junto con presupuestos de publicidad para el producto en cada uno de aquellos mercados
para tres medios de comunicación diferentes: TV, radio, y periódico. No es posible para
nuestro cliente incrementar directamente las ventas del producto. Por otro lado, ellos
pueden controlar el gasto en publicidad para cada uno de los tres medios de comunicación.
Por lo tanto, si determinamos que hay una asociación entre publicidad y ventas, entonces
podemos instruir a nuestro cliente para que ajuste los presupuestos de publicidad, y así
indirectamente incrementar las ventas.
En otras palabras, nuestro objetivo
es desarrollar un modelo preciso que pueda ser usado para predecir las ventas sobre la base
de los tres presupuestos de medios de comunicación. Ajuste modelos de regresión lineal múltiple
a los datos advertisement.csv y elija el modelo más adecuado siguiendo los procedimientos vistos.
Considera:
Y: Sales (Ventas de un producto)
X1: TV (Presupuesto de publicidad en TV para el producto)
X2: Radio (Presupuesto de publicidad en Radio para el producto)
X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)"

library(ggplot2)
library(dplyr)
adv <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")

"desarrollar un modelo preciso que pueda ser usado para predecir las ventas sobre la base
de los tres presupuestos de medios de comunicación.Ajuste modelos de regresión lineal múltiple
Elija el modelo más adecuado siguiendo los procedimientos vistos"
names(adv)
head(adv)
attach(adv)

#######PASO 1. Analizar la asociacion entre las variables idenpendientes y dependiente"
?cor
cor(adv)
#Se observa una fuerte correlacion entre las ventas y el presupuesto para TV del 90.12%

?pairs
pairs(~ Sales + TV + Radio + Newspaper, 
      data = adv, gap = 0.4, cex.labels = 1.5)
# Se observa en el diagrama de dispersion que existe
#una correlacion postiva entre la variable Sales y la variable TV
# mientras que la relacion de Sales con las demas variables esta muy dispersa

##Modelo 1
"Estimación por Mínimos Cuadrados Ordinarios (OLS)
Y = beta0 + beta1*TV + beta2*Radio + beta3*Newspaper + e"
?lm
m1 <- lm(Sales ~ TV + Radio + Newspaper)
summary(m1)

# el p-value es menor al nivel de significancia por lo tanto se rechaza Ho
# el coeficente de la variable newspaper no es significativo, quere decir, 
#que no sirve para explicar el comportamiento o variacion de las ventas

" Para este modelo tenemos:
Adjusted R-squared:  0.9011 # quiere decir que las variables TV, Radio y Newspaper explican un 90.11% a las ventas
F-statistic: 605.4 on 3 and 196 DF,  p-value: < 2.2e-16"


#Obteniendo los residuales estandarizados
res <- rstandard(m1)
par(mfrow = c(2, 3))
plot(Sales, res, ylab = "Residuales Estandarizados")
plot(TV, res, ylab = "Residuales Estandarizados")
plot(Radio, res, ylab = "Residuales Estandarizados")
plot(Newspaper, res, ylab = "Residuales Estandarizados")

qqnorm(res)
qqline(res)  

# Ho. la variable distribuye como una normal
# Ha. La variable no distribuye como una normal


shapiro.test(res)
dev.off()
"Shapiro-Wilk normality test
data:  res
W = 0.97528, p-value = 0.001339"

# Con estos resultados podemos ver que la variable no distribuye
#como una normal.


#Modelo 2 . Quitando la variable newspaper
#Y = beta0 + beta1*TV + beta2*Radio + e"
m2 <- update(m1, ~. -Newspaper) # actualizar el modelo m1 quitando Newspaper
summary(m2)
#Adjusted R-squared: 0.9016 # quiere decir que las variables TV y Radio explican un 90.16% de las ventas
#F-statistic: 912.7 on 2 and 197 DF,  p-value: < 2.2e-16"

res2 <- rstandard(m2) 
par(mfrow = c(2, 2))
plot(Sales, res2, ylab = "Residuales Estandarizados")
plot(TV, res2, ylab = "Residuales Estandarizados")
plot(Radio, res2, ylab = "Residuales Estandarizados")
qqnorm(res2)
qqline(res2)  
# no es normal
# Ho. la variable distribuye como una normal
# Ha. La variable no distribuye como una normal
shapiro.test(res2)
"Shapiro-Wilk normality test

data:  res2
W = 0.97535, p-value = 0.001365"

dev.off()

#Modelo 3 . Quitando la variable radio del modelo 2
#Y = beta0 + beta1*TV + e"
m3 <- update(m2, ~. -Radio) # actualizar el modelo m1 quitando Radio
summary(m3)
#Adjusted R-squared:  0.8112 # quiere decir que la variable TV explica un 81.12% a las ventas
#F-statistic: 912.7 on 2 and 197 DF,  p-value: < 2.2e-16"

res3 <- rstandard(m3) 
par(mfrow = c(2, 2))
plot(Sales, res3, ylab = "Residuales Estandarizados")
plot(TV, res3, ylab = "Residuales Estandarizados")
qqnorm(res3)
qqline(res3)  
# no es normal
# Ho. la variable distribuye como una normal
# Ha. La variable no distribuye como una normal

shapiro.test(res3)
"	Shapiro-Wilk normality test
data:  res3
W = 0.99348, p-value = 0.526"

dev.off()

" Resultado
El modelo 2 resulta ser el mas idoneo para predecir las ventas
Tomando los coeficientes para formar la ecuacion tenemos"

m2$coefficients
"mi ecaucion quedaria de la siguiente manera
  y = 4.63 + 0.054*x1 + 0.107*X2
  Sales = 4.63 + 0.054*TV + 0.107*Radio"


