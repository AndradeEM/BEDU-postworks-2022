
   ############# POSTWORK SESION 4   ###########
#Realizar un análisis probabilístico del total de cargos internacionales de una compañía de telecomunicaciones

library(DescTools)
library(ggplot2)
   
"Utilizando la variable total_intl_charge de la base de datos telecom_service.csv
de la sesión 3, realiza un análisis probabilístico."
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
summary(df)

"Para ello, debes determinar la función de distribución de probabilidad
que más se acerque el comportamiento de los datos.
Hint: Puedes apoyarte de medidas descriptivas o técnicas de visualización."

#medidas descriptivas. 
media <- mean(df$total_intl_charge)
mediana <- median(df$total_intl_charge)
moda <- Mode(df$total_intl_charge)
desv <- sd(df$total_intl_charge)

#histograma
?hist
hist(df$total_intl_charge, main = "Histograma de cargos de llamadas internacionales")

##### se comporta como una distribucion normal (es simetrica y forma de campana)
####  media = mediana = moda

#Una vez que hayas seleccionado el modelo, realiza lo siguiente:

#Grafica la distribución teórica de la variable aleatoria total_intl_charge
curve(dnorm(x, mean = media, sd = desv), from = 0.5, to = 5, 
      col='red', main = "Densidad Normal:\nigual a la media",
      ylab = "f(x)", xlab = "X")
abline(v = media, lwd = 0.5, lty = 2)

#¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 1.85 usd?
pnorm(q = 1.85, mean = media, sd = desv) #P(X < 1.85)


#¿Cuál es la probabilidad de que el total de cargos internacionales sea mayor a 3 usd?
pnorm(q = 3, mean = media, sd = desv, lower.tail = FALSE)  #P(X > 3)

#o se puede calcular tambien de la siguientes manera:
1 - pnorm(q = 3, mean = media, sd = desv)

#¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 2.35usd y 4.85 usd?
pnorm(q = 4.85, mean = media, sd = desv) - pnorm(q = 2.35, mean = media, sd = desv)
  
#Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más alto que podría esperar?
qnorm(p = 0.48, mean = media, sd = desv, lower.tail = TRUE)

#¿Cuáles son los valores del total de cargos internacionales que dejan exactamente al centro el 80% de probabilidad?
#se obtiene el valor restante de la probabilidad que es 20%. #10% para cada lado ya que el 80% debe estar al centro (20% -> 0.2)
qnorm(p = 0.2/2, mean = media, sd = desv); qnorm(p = 0.2/2, mean = media, sd = desv, lower.tail = FALSE)
#o 
qnorm(p = 0.2/2, mean = media, sd = desv); qnorm(p = 1 - 0.2/2, mean = media, sd = desv, lower.tail = TRUE)

   