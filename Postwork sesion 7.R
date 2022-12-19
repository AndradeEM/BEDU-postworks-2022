################# Postwork sesion 7  ####################

"Utilizando el siguiente vector numérico, realiza lo que se indica:"
  
url = "https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-07/Data/global.txt"

Global <- scan(url, sep="")
View(Global)  
#Crea un objeto de serie de tiempo con los datos de Global. La serie debe ser mensual comenzando en Enero de 1856
G.st <- ts(Global, st = c(1856, 1), fr = 12)

#Realiza una gráfica de la serie de tiempo anterior
plot(G.st, xlab = "Tiempo", ylab = "Temperatura en grados C", 
     main = "Serie de tiempo de Temperatura Global",
     sub = "Serie mensual de Enero de 1856 a Diciembre de 2005")

#Ahora realiza una gráfica de la serie de tiempo anterior, transformando a la primera diferencia
plot(diff(G.st), xlab = "", ylab = "")
title(main = "Serie de tiempo temperatura Global transformada",
      xlab = "Tiempo", ylab = "Diferencia")

#¿Consideras que la serie es estacionaria en niveles o en primera diferencia?
# La serie esta estacionaria en primera diferencia

#Con base en tu respuesta anterior, obtén las funciones de autocorrelación y autocorrelación parcial?
acf(diff(G.st))
pacf(diff(G.st))
