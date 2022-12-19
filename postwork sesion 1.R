
#####    POSTWORK SESION 1  ########

" Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020
de la primera división de la liga española: https://www.football-data.co.uk/spainm.php"

#Importa los datos a R como un Dataframe
library(readr)
liga <- read.csv('F:/Andrade/documents/prog/bedu/f2/s1/postwork/SP11920.csv')
class(liga)

"Del dataframe que resulta de importar los datos a R, extrae las columnas que
contienen los números de goles anotados por los equipos que jugaron en casa (FTHG)
y los goles anotados por los equipos que jugaron como visitante (FTAG);
guárdalos en vectores separados"

(GJC <- liga$FTHG) 
(GJV <- liga$FTAG)
class(GJC)
is.vector(GJC)
is.vector(GJV)

#Consulta cómo funciona la función table en R
#Para ello, puedes ingresar los comandos help("table") o ?table para leer la documentación
#Responde a las siguientes preguntas:"
?table

#Para contestar las preguntas se hace una tabla con los dos vectores
table(GJC,GJV)

#a) ¿Cuántos goles tuvo el partido con mayor empate?
#49 empate a 1

#b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
#33

#c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor
#goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
#1