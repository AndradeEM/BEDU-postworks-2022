#####################  POSTWORK SESION 8  ###############
"Un centro de salud nutricional está interesado en analizar estadísticamente y
probabilísticamente los patrones de gasto en alimentos saludables y no saludables
en los hogares mexicanos con base en su nivel socioeconómico, en si el hogar tiene
recursos financieros extras al ingreso y en si presenta o no inseguridad alimentaria.
Además, está interesado en un modelo que le permita identificar los determinantes
socioeconómicos de la inseguridad alimentaria.
La base de datos es un extracto de la Encuesta Nacional de Salud y Nutrición (2012)
levantada por el Instituto Nacional de Salud Pública en México. La mayoría de las
personas afirman que los hogares con menor nivel socioeconómico tienden a gastar más
en productos no saludables que las personas con mayores niveles socioeconómicos y
que esto, entre otros determinantes, lleva a que un hogar presente cierta
inseguridad alimentaria."

#La base de datos contiene las siguientes variables:
#nse5f (Nivel socioeconómico del hogar): 1 "Bajo", 2 "Medio bajo", 3 "Medio", 4 "Medio alto", 5 "Alto"
#area (Zona geográfica): 0 "Zona urbana", 1 "Zona rural"
#numpeho (Número de persona en el hogar)
#refin (Recursos financieros distintos al ingreso laboral): 0 "no", 1 "sí"
#edadjef (Edad del jefe/a de familia)
#sexojef (Sexo del jefe/a de familia): 0 "Hombre", 1 "Mujer"
#añosedu (Años de educación del jefe de familia)
#ln_als (Logaritmo natural del gasto en alimentos saludables)
#ln_alns (Logaritmo natural del gasto en alimentos no saludables)
#IA (Inseguridad alimentaria en el hogar): 0 "No presenta IA", 1 "Presenta IA"

#Plantea el problema del caso
#Realiza un análisis descriptivo de la información
#Calcula probabilidades que nos permitan entender el problema en México
#Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México
#Estima un modelo de regresión, lineal o logístico, para identificar los determinantes de la inseguridad alimentaria en México
#Escribe tu análisis en un archivo README.MD y tu código en un script de R y publica ambos en un repositorio de Github.

"Todo tu planteamiento deberá estar correctamente desarrollado y deberás analizar
e interpretar todos tus resultados para poder dar una conclusión final al problema planteado."

#Llamaremos las librerias a utilizar
library(dplyr)
library(DescTools)
library(ggplot2)

#Llamamos al archivo de datos y analizamos su estructura y composicion
df<-read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-08/Postwork/inseguridad_alimentaria_bedu.csv")
summary(df)
#omitimos los registros con valores NA
df.final<- na.omit(df)

"Vamos a transformar las variables a su escala correspondiente"
df.final$nse5f <- factor(df.final$nse5f, labels = c("Bajo", "Medio bajo", "Medio", "Medio alto", "Alto"), ordered = TRUE)
df.final$refin <- factor(df.final$refin, labels = c("No", "Si"))
df.final$IA <- factor(df.final$IA, labels = c("No presenta IA", "Si presenta IA"))
df.final$area <- factor(df.final$area, labels = c("Zona urbana", "Zona rural"))
df.final$sexojef <- factor(df.final$sexojef, labels = c("Hombre", "Mujer"))
attach(df.final)
summary(df.final)

##- Plantea el problema del caso

"Analizaremos el impacto en los patrones de gasto en alimentos saludables y no saludables en los hogares mexicanos en base a:
  
  - Nivel socioeconomico
- Recurso financiero extra al ingreso
- Si presenta IA o no presenta IA

Presentaremos un modelo que identifique los determinantes socioeconomicos de la
inseguridad alimentaria.

Analizaremos a traves de pruebas de hipotesis para aceptar o rechazar:
  
1. Que los hogares con menor nivel socioeconomico tienden a gastar mas en alimentos
no saludables que los hogares con nivel socioeconomicos mas altos.

2. Que los gastos en alimentos no saludables son determinantes para que los hogares
presenten cierta inseguridad alimentaria.

Los datos utilizados provienen de la encuesta nacional de salud y nutrición 2012,
realizada por el instituto nacional de salud pública en México, en la cual,
el diseño muestral trata de una encuesta probabilística nacional con representatividad
estatal, por estratos nacionales urbano y rural, y una sobre muestra de los hogares
con mayor carencias del país."

##############    ANALISIS DESCRIPTIVO DE LA INFORMACION  #####################

"Analisis descriptivo para el nivel socioeconomico"
#Tablas de distribucion de frecuencias
n <- table(nse5f); n   #frecuencias absolutas
f <- n/length(nse5f); f  #frecuencias relativas
x0 <- round(f*100, 2); x0  #porcentaje de frecuencias relativas
N <- cumsum(n); N #frecuencias absolutas acumuladas
F <- cumsum(f); F #frecuencias relativas acumuladas
#Graficos
barplot(n, main = "Niveles socioeconomicos en Mexico", ylab = "Frecuencia absoluta", col = "green")
fp0<- barplot(x0, main = "Niveles socioeconomicos en Mexico", ylab = "% Frecuencia relativa", col = "light blue")
text(x = fp0, y = x0, pos = 1, cex = 1, label = round(x0, 1), col = "blue")

"Analisis descriptivo para Recursos financieros distintos al ingreso laboral"
#Tablas de distribucion de frecuencias
n1 <- table(refin); n1
f1 <- n1/length(refin); f1
x1 <- round(f1*100, 2); x1
N1 <- cumsum(n1); N1
F1 <- cumsum(f1); F1
#Graficos
barplot(n1, main = "Recursos financieros distintos al ingreso laboral", ylab = "Frecuencia absoluta", col = "green")
fp1<- barplot(height = x1, horiz = FALSE, main = "Recursos financieros distintos al ingreso laboral", ylab = "% Frecuencia relativa", col = "light blue")
text(x = fp1, y = x1, pos = 1, cex = 1, label = round(x1, 1), col = "blue")

"Analisis descriptivo para Inseguridad alimentaria en el hogar"
#Tablas de distribucion de frecuencias
n2 <- table(IA); n2
f2 <- n2/length(IA); f2
x2 <- round(f2*100, 2); x2
N2 <- cumsum(n2); N2
F2 <- cumsum(f2); F2
#Graficos
bp<- barplot(height = n2, horiz = FALSE, main = "Inseguridad alimentaria en hogares de mexico", ylab = "Frecuencia absoluta", col = "light blue");
text(x = bp, y = n2+2, pos = 1, cex = 1, label = round(n2, 1), col = "blue")
fp2<- barplot(height = x2, horiz = FALSE, main = "Inseguridad alimentaria en hogares de mexico", ylab = "% Frecuencia relativa", col = "light blue")
text(x = fp2, y = x2, pos = 1, cex = 1, label = round(x2, 1), col = "blue")

"Analisis descriptivo para el sexo del jefe de familia"
#Tablas de distribucion de frecuencias
n3 <- table(sexojef ); n3
f3 <- n3/length(sexojef); f3
x3 <- round(f3*100, 2); x3
N3 <- cumsum(n3); N3
F3 <- cumsum(f3); F3
#Graficos
bp<- barplot(height = n3, horiz = FALSE, main = "Hogares por sexo del jefe de familia", ylab = "Frecuencia absoluta", col = "light blue");
text(x = bp, y = n3+2, pos = 1, cex = 1, label = round(n3, 1), col = "blue")
fp3<- barplot(height = x3, horiz = FALSE, main = "Hogares por sexo del jefe de familia", ylab = "% Frecuencia relativa", col = "light blue")
text(x = fp3, y = x3, pos = 1, cex = 1, label = round(x3, 1), col = "blue")

"Analisis descriptivo por area de los hogares"
#Tablas de distribucion de frecuencias
n4 <- table(area); n4
f4<- n4/length(area); f4
x4 <- round(f4*100, 2); x4
N4 <- cumsum(n4); N4
F4 <- cumsum(f4); F4
#Graficos
bp<- barplot(height = n4, horiz = FALSE, main = "Area de los hogares encuestados", ylab = "Frecuencia absoluta", col = "light blue");
text(x = bp, y = n4+2, pos = 1, cex = 1, label = round(n4, 1), col = "blue")
fp4<- barplot(height = x4, horiz = FALSE, main = "Area de los hogares encuestados", ylab = "% Frecuencia relativa", col = "light blue")
text(x = fp4, y = x4, pos = 1, cex = 1, label = round(x4, 1), col = "blue")


"Analisis descriptivo para los gastos en alimentos saludables"
mean(ln_als) ; median(ln_als) ; Mode(ln_als); var(ln_als); sd(ln_als)
hist(ln_als, main = "Distribucion del gasto en alimentos saludables", ylab = "Frecuencia")
cuartiles.als <- quantile(ln_als, probs = c(0, 0.25, 0.50, 0.75, 1)); cuartiles.als
boxplot(ln_als)

"Analisis descriptivo para los gastos en alimentos no saludables"
mean(ln_alns) ; median(ln_alns) ; Mode(ln_alns); var(ln_alns) ; sd(ln_alns)
hist(ln_alns, main = "Gasto en alimentos no saludables", ylab = "Frecuencia")
cuartiles.alns <- quantile(ln_alns, probs = c(0, 0.25, 0.50, 0.75, 1)); cuartiles.alns
boxplot(ln_alns)

"Analisis descriptivo para el numero de personas que habitan en el hogar"
mean(numpeho) ; median(numpeho) ; Mode(numpeho)
var(numpeho) ; sd(numpeho)
hist(numpeho, main = "Numero de personas que habitan en el hogar", ylab = "Frecuencia")
cuartiles.numpeho <- quantile(numpeho, probs = c(0, 0.25, 0.50, 0.75, 1))
cuartiles.numpeho
boxplot(numpeho)

"Analisis descriptivo para los años de educacion de jefe(a) de familia"
mean(añosedu) ; median(añosedu) ; Mode(añosedu)
var(añosedu) ; sd(añosedu)
hist(añosedu, main = "Años de educacion de jefe(a) de familia", ylab = "Frecuencia")
cuartiles.añosedu <- quantile(añosedu, probs = c(0, 0.25, 0.50, 0.75, 1))
cuartiles.añosedu
boxplot(añosedu)

"Analisis descriptivo para la edad de jefe(a) de familia"
mean(edadjef ) ; median(edadjef) ; Mode(edadjef)
var(edadjef) ; sd(edadjef)
hist(edadjef, main = "Edad de jefe(a) de familia", ylab = "Frecuencia")
cuartiles.edadjef <- quantile(edadjef, probs = c(0, 0.25, 0.50, 0.75, 1))
cuartiles.edadjef
boxplot(edadjef)

"Patrones de gasto en alimentos no saludables en base al nivel socioeconomico bajo,
nivel socioeconomico alto, si presenta ingreso extra, no presenta ingreso extra,
si presenta IA, no presenta IA"

alns_nse5f <- ggplot(df.final,aes(x=nse5f, y=ln_alns))
alns_nse5f + geom_col(position = "dodge",  fill="light blue") + theme_classic()
alns_refin <- ggplot(df.final,aes(x=refin, y=ln_alns), )
alns_refin + geom_col(position = "dodge",  fill="light blue") + theme_classic() 
alns_IA <- ggplot(df.final,aes(x=IA, y=ln_alns))
alns_IA + geom_col(position = "dodge",  fill="light blue") + theme_classic()
ggplot(df.final,aes(x=IA, y=ln_alns, fill=nse5f)) + geom_col(position = "dodge") + theme_classic()
ggplot(df.final,aes(x=IA, y=ln_alns, fill=refin)) + geom_col(position = "dodge") + theme_classic()

"Patrones de gasto en alimentos saludables en base a nivel socioeconomico bajo,
nivel socioeconomico alto, si presenta ingreso extra, no presenta ingreso extra,
si presenta IA, no presenta IA"

als_nse5f <- ggplot(df.final,aes(x=nse5f, y=ln_als))
als_nse5f + geom_col(position = "dodge", fill="light blue") + theme_classic()
als_refin <- ggplot(df.final,aes(x=refin, y=ln_als))
als_refin + geom_col(position = "dodge", fill="light blue") + theme_classic()
als_IA <- ggplot(df.final,aes(x=IA, y=ln_als))
als_IA + geom_col(position = "dodge", fill="light blue") + theme_classic()
ggplot(df.final,aes(x=IA, y=ln_als, fill=nse5f)) + geom_col(position = "dodge") + theme_classic()
ggplot(df.final,aes(x=IA, y=ln_als, fill=refin)) + geom_col(position = "dodge") + theme_classic()

"Otros patrones a considerar"

# Obtener la relacion entre los niveles socioeconomicos y la inseguridad alimentaria
ggplot(df.final,aes(x=nse5f)) + geom_bar(aes(fill=IA), position = "dodge") + theme_classic()

# Obtener la relacion entre la inseguridad alimentaria y el ingreso extra 
ggplot(df.final,aes(x=refin)) + geom_bar(aes(fill=IA), position = "dodge") + theme_classic()

#Obtener la relacion entre el area y la inseguridad alimentaria
ggplot(df.final,aes(x=area)) + geom_bar(aes(fill=IA), position = "dodge") + theme_classic()

#####Calcula probabilidades que nos permitan entender el problema en México ########

"1.La media de gasto en alimentos no saludables es de 4 al año, que probabilidad hay de que:"
#a) se gaste 6 el proximo año. Utilizando la distribución de poisson tenemos
dpois(6,4)
#R/ 0.1041956
#b) se gaste 2 el proximo año
dpois(2,4)
#R/ 0.1465251

"2.La media de gasto en alimentos saludables es de 6 al año, que probabilidad hay de que:"
#a) se gaste 8 el proximo año. Utilizando la distribución de poisson tenemos
dpois(8,6)
#R/ 0.1032577
#b) se gaste 4 el proximo año
dpois(4,6)
#R/ 0.1338526

####Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México

"Hipotesis 1. En promedio el gasto en alimentos no saludable en hogares con nivel socioeconomico bajo es mayor
a los gastos en alimentos no saludables en hogares con un nivel socioeconomico alto.
Ho: prom.ln_alns_nse5f_bajo <= prom.ln_alns_nse5f_alto
Ha: prom.ln_alns_nse5f_bajo > prom.ln_alns_nse5f_alto"

var.test(df.final[df.final$nse5f == "Bajo", "ln_alns"], 
         df.final[df.final$nse5f == "Alto", "ln_alns"], 
         ratio = 1, alternative = "two.sided")

t.test(x = df.final[df.final$nse5f == "Bajo", "ln_alns"], 
       y = df.final[df.final$nse5f == "Alto", "ln_alns"], 
       alternative = "greater",
       mu = 0, var.equal = FALSE)

"Con un NC del 95% (0.05), existe evidencia estadística para no rechazar Ho,
es decir, en promedio, el gasto en alimentos no saludable en hogares con nivel
socioeconomico bajo es menor o igual a los gastos en alimentos no saludables en hogares
con un nivel socioeconomico alto."

"Hipótesis 2. En promedio el gasto en alimentos saludables cuando el hogar tiene
ingresos extra es mayor al promedio en gasto en alimentos saludables cuando el
hogar no tiene ingresos extra
Ho: prom.ln_als_refin_si <= prom.ln_als_refin_no
Ha: prom.ln_als_refin_si > prom.ln_als_refin_no"

var.test(df.final[df.final$refin == "Si", "ln_als"], 
         df.final[df.final$refin == "No", "ln_als"], 
         ratio = 1, alternative = "two.sided")

t.test(df.final[df.final$refin == "Si", "ln_als"], 
       df.final[df.final$refin == "No", "ln_als"], 
       alternative = "greater",
       mu = 0, var.equal = TRUE)

"Hipótesis 3. En promedio el gasto en alimentos no saludables cuando el hogar tiene
ingresos extra es mayor al promedio en gasto en alimentos no saludables cuando el
hogar no tiene ingresos extra
Ho: prom.ln_alns_refin_si <= prom.ln_alns_refin_no
Ha: prom.ln_alns_refin_si > prom.ln_alns_refin_no"

var.test(df.final[df.final$refin == "Si", "ln_alns"], 
         df.final[df.final$refin == "No", "ln_alns"], 
         ratio = 1, alternative = "two.sided")

t.test(df.final[df.final$refin == "Si", "ln_alns"], 
       df.final[df.final$refin == "No", "ln_alns"], 
       alternative = "greater",
       mu = 0, var.equal = TRUE)

"Con un NC del 95% (0.05), existe evidencia estadística para rechazar Ho,
es decir, en promedio, el gasto en alimentos saludable en hogares con nivel
socioeconomico alto es mayor a los gastos en alimentos saludables en hogares
con un nivel socioeconomico bajo."


#Estima un modelo de regresión, lineal o logístico, para identificar los determinantes de la inseguridad alimentaria en México

"Modelo 1 . Evaluando todas las variables"
log.1 <- glm(IA ~ nse5f + area + numpeho + refin + edadjef + 
               añosedu + ln_als + ln_alns , data = df.final, family = binomial)
summary(log.1)
pseudo_r2.1 <- (log.1$null.deviance - log.1$deviance)/log.1$null.deviance
pseudo_r2.1     #[1] 0.09198


"Modelo 2. Separando la edad del jefe de familia por sexo del jefe de familia"
log.2 <- glm(IA ~ nse5f + area + numpeho + refin + edadjef:sexojef + 
               añosedu + ln_als + ln_alns , data = df.final, family = binomial)
summary(log.2)
pseudo_r2.2 <- (log.2$null.deviance - log.2$deviance)/log.2$null.deviance
pseudo_r2.2     #[1] 0.09216

"Modelo 3. Separando los años de educacion del jefe de familia por sexo del jefe de familia"
log.3 <- glm(IA ~ nse5f + area + numpeho + refin + edadjef:sexojef + 
               añosedu:sexojef + ln_als + ln_alns , data = df.final, family = binomial)
summary(log.3)
pseudo_r2.3 <- (log.3$null.deviance - log.3$deviance)/log.3$null.deviance
pseudo_r2.3     #[1] 0.09331

"Modelo 4. Eliminando la edad del jefe de familia por el sexo del h¿jefe de familia"
log.4 <- update(log.3, ~.- edadjef:sexojef )
summary(log.4)
pseudo_r2.4 <- (log.4$null.deviance - log.4$deviance)/log.4$null.deviance
pseudo_r2.4     #"[1]  0.09284"




