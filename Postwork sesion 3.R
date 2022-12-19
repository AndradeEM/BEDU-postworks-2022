
  ########## POSTWORK SESION 3  ##############


# Realizar un análisis descriptivo de las variables de un dataframe

library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)  

    
"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."
  
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")
Str(df)
head(df)
summary(df)
df$Categoria <- factor(df$Categoria)
df$Grupo <- factor(df$Grupo)
complete.cases(df)
df.clean <- df[complete.cases(df),]
df.clean

#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`
mean(df.clean$Mediciones)
median(df.clean$Mediciones)
Mode(df.clean$Mediciones)

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?
#RESPUESTA: Media > Mdiana > Moda. Sesgo hacia la derecha

#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`
var(df.clean$Mediciones)
sd(df.clean$Mediciones)
IQR(df.clean$Mediciones)
# La desviacion estandar es de +/- 53.76 con repsecto a la media

cuartiles <- quantile(df.clean$Mediciones, prob = c(0, 0.25, 0.5, 0.75, 1))
cuartiles
#los cuartiles de la distribución:
# el 25% de las mediciones es de 23.45 o menos
# el 50% de las mediciones es de 49.30 o menos
# el 75% de las mediciones es de 82.85 o menos

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?" # No , las 3 categorias estan sesgadas a la derecha

ggplot(df.clean, aes(Mediciones)) +
  geom_histogram(aes(fill = Categoria), bins = 10, binwidth = 5) + 
  labs(title = "Histograma", 
       x = "Mediciones",
       y = "Frequency") + 
  theme_gray()

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría.
¿Consideras que hay diferencias entre categorías? Si
¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo? Si, el grupo 0 de la categoria C3 "

ggplot(df.clean, aes(x = Categoria, y = Mediciones)) +
  geom_boxplot(aes(fill = Grupo),) + 
  labs(title = "Boxplot", 
       x = "Categoria",
       y = "Mediciones") + 
  theme_gray()





