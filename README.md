#Postwork sesión 8. Análisis de la Inseguridad Alimentaria en México
##OBJETIVO
Realizar un análisis estadístico completo de un caso
Publicar en un repositorio de Github el análisis y el código empleado
##REQUISITOS
Haber realizado los works y postworks previos
Tener una cuenta en Github o en RStudioCloud
##DESARROLLO
Un centro de salud nutricional está interesado en analizar estadísticamente y probabilísticamente los patrones de gasto en alimentos saludables y no saludables en los hogares mexicanos con base en su nivel socioeconómico, en si el hogar tiene recursos financieros extrar al ingreso y en si presenta o no inseguridad alimentaria. Además, está interesado en un modelo que le permita identificar los determinantes socioeconómicos de la inseguridad alimentaria.

La base de datos es un extracto de la Encuesta Nacional de Salud y Nutrición (2012) levantada por el Instituto Nacional de Salud Pública en México. La mayoría de las personas afirman que los hogares con menor nivel socioeconómico tienden a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un hogar presente cierta inseguridad alimentaria.

La base de datos contiene las siguientes variables:

nse5f (Nivel socieconómico del hogar): 1 "Bajo", 2 "Medio bajo", 3 "Medio", 4 "Medio alto", 5 "Alto"
area (Zona geográfica): 0 "Zona urbana", 1 "Zona rural"
numpeho (Número de persona en el hogar)
refin (Recursos financieros distintos al ingreso laboral): 0 "no", 1 "sí"
edadjef (Edad del jefe/a de familia)
sexoje (Sexo del jefe/a de familia): 0 "Hombre", 1 "Mujer"
añosedu (Años de educación del jefe de familia)
ln_als (Logarítmo natural del gasto en alimentos saludables)
ln_alns (Logarítmo natural del gasto en alimentos no saludables)
IA (Inseguridad alimentaria en el hogar): 0 "No presenta IA", 1 "Presenta IA"
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-08/Postwork/inseguridad_alimentaria_bedu.csv")

Plantea el problema del caso
Realiza un análisis descriptivo de la información
Calcula probabilidades que nos permitan entender el problema en México
Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México
Estima un modelo de regresión, lineal o logístico, para identificar los determinantes de la inseguridad alimentaria en México
Escribe tu análisis en un archivo README.MD y tu código en un script de R y publica ambos en un repositorio de Github.

NOTA: Todo tu planteamiento deberá estár correctamente desarrollado y deberás analizar e interpretar todos tus resultados para poder dar una conclusión final al problema planteado.

###- Plantea el problema del caso

Analizaremos el impacto en los patrones de gasto en alimentos saludables y no saludables en los hogares mexicanos en base a:

- Nivel socioeconomico
- Recurso financiero extra al ingreso
- Si presenta IA o no presenta IA

Presentaremos un modelo que identifique los determinantes socioeconomicos de la inseguridad alimentaria.

Analizaremos a traves de pruebas de hipotesis para aceptar o rechazar:

1. Que los hogares con menor nivel socioeconomico tienden a gastar mas en alimentos no saludables que los hogares con nivel socioeconomicos mas altos.

2. Que los gastos en alimentos no saludables son determinantes para que los hogares presenten cierta inseguridad alimentaria.

  Los datos utilizados provienen de la encuesta nacional de salud y nutrición 2012, realizada por el instituto nacional de salud pública en México, en la cual, el diseño muestral trata de una encuesta probabilística nacional con representatividad estatal, por estratos nacionales urbano y rural, y una sobre muestra de los hogares con mayor carencias del país.

###Realiza un análisis descriptivo de la información

  El analisis indica que el 17.5% de los hogares encuestado esta dentro del nivel socioeconomico bajo, el 19.4% de los hogares esta en el nivel medio bajo, el 20.3% esta en el nivel medio, el 21.5% esta en el nivel medio alto y el 21.3% se encuentra en el nivel alto. Con esto podemos observar que el 57.2% (poco mas de la mitad) de los hogares encuestados estan dentro de los niveles socioeconomicos bajo, medio bajo y medio; mientras que el 42.8% estan dentro de los niveles socioeconomicos medio alto y alto.

  De los hogares entrevistados en 81% de estos, no cuentan con recursos distintos o extras al ingreso laboral, mientras que el 19% si cuentan con un ingreso distinto al ingreso laboral.

  De acuerdo con el ENSANUT 2012, se reporto que 16,386 hogares presenta un cierto grado de inseguridad alimentaria, lo que representa un 70.6% del total de los hogares encuestados, mientras que 6,815 de ellos no presenta nungun tipo de inseguridad alimentaria, lo que representa el 29.4% de los hogares encuestados.

  En los hogares se pregunto quien era el jefe de familia (Hombre o Mujer), obteniendo que el 78.3% el jefe de familia era hombre y el 21.7% mujer.

Se analizo que tanto porcentaje representaba los hogares en zona rural y zona urbana, con un 68.8% de los hogares encuestados en zona urbana y un 31.2% de los hogares en zona rural.


Para los gastos en alimentos saludable, encontramos que  el promedio del gasto en alimentos saludables en los hogares encuestados es de 6.19 . Aqui cabe mencionar que la información del gasto en alimentos esta dado en logaritmo natural para una vision mas clara de la informacion. Tenemos tambien que el 50% del gasto en alimentos saludables es menor o igual 6.27, y el gasto en alimentos saludables con mas frecuencia en los hogares encuestados es de 6.30.Con esto podemos ver que la acumulacion del gasto en alimentos saludables esta sesgado a la izquierda, quiere decir que frecuentemente se gasta por encima del promedio en alimentos saludables. 

Para los gastos en alimentos no saludable, encontramos que  el promedio del gasto en alimentos no saludables en los hogares encuestados es de 4.11. El 50% del gasto en alimentos no saludables es mayor o igual 4.00, y el gasto en alimentos no saludables con mas frecuencia en los hogares encuestados es de 3.40. Esto nos dice que que la acumulacion del gasto en alimentos no saludables esta sesgado a la derecha, es decir, que frecuentemente se gasta por debajo del promedio en alimentos no saludables.

En el analisis del numero de personas bajo el mismo hogar, encontramos que en promedio hay 4 personas oir hogar, asi mismo, el 50% del numero de personas que habitan un hogar es mayor o igual a 4 personas, y el numero de personas con mas frecuencia en hogares mexicanos es de 4 personas.

Para los años de educacion del jefe(a) de familia encontramos que en promedio la escolaridad es de 10.89 años, la frecuencia de la escolaridad del jefe(a) de familia que mas se presenta es de 9 años, tambien nos muestra que en el 50% de los hogares, los jefes(as) de familia tiene mas o igual de 9 años de educacion. 

Analizando la edad del jefe(a) de familia encontramos que en promedio tiene 47.31 años, LA frecuencia de edad del jefe(a) de familia que mas se presenta en los hogares es de 38 años. Siendo que el 50% de la edad, es mayor o igual a 46 años. La edad del jefe(a) de familia tiene un sesgo hacia la derecha, lo que nos indica que la edad frecuentemente es menor que el promedio.


###Calcula probabilidades que nos permitan entender el problema en México

Realizando unos calculos de probabilidad para saber si en el año siguiente se presentará un aumento y disminucion en el gasto de alimentos saludables.
Tenemos que el promedio de gasto en alimentos saludables es de 4, la probabilidad que en el año siguiente el promedio del gasto en alimentos saludables sea de 6, es de 0.104; mientras que para el gasto de 2, la probabilidad es de 0.146. De igual manera calculamos para  el gasto en alimentos no saludables, el promedio de los gastos en alimentos no saludables es de 6, hay una probabilidad del 0.103 de que el gasto en alimentos sea de 8, y de igual manera la probabilidad de 0.133 de que el gasto en alimentos no saludables disminuya a 4.

## Resultado del planteamiento de hipótesis estadísticas y concluye sobre ellas para entender el problema en México

Existe evidencia estadistica para decir que en promedio, el gasto en alimentos no saludables en hogares con un nivel socioeconomico bajo es menor o igual a los gastos en alimentos no saludables en los hogares con un nivel socioeconomico alto. Asi mismo, en promedio, el gasto en alimentos saludables en hogares con nivel socioeconomico alto es mayor a los gastos en alimentos saludables en hogares con un nivel socioeconomico bajo.


###Estima un modelo de regresión, lineal o logístico, para identificar los determinantes de la inseguridad alimentaria en México

Se estimo un modelo para identificar los determinantes de la inseguridad alimentaria en México, con los siguientes resultados.

Las variables determinantes para la inseguridad alimentaria son:
1. Los niveles socioeconomicos bajo y medio bajo
2. Número de persona en el hogar
3. Recursos financieros distintos al ingreso laboral
4. Logarítmo natural del gasto en alimentos no saludables
5. Años de educación del jefe de familia"

###Conclusion.

  A traves de las diferentes herrmaientas probabilisticas y estadisticas se encontramos lo siguiente:
  
  Los hogares con nivel socioeconomico mas bajo no tienden a gastar ligermanete mas en alimentos no saludables que los hogares con nivel socioeconomico mas alto. Sin embargo, los hogares con nivel socioeconomico mas alto tienden a gastar ligeramente mas en aliementos saludables que los hogares con nivel socioeconomico mas bajo.
  Los hogares que no presentan recursos financieros extra gastan mas en alimentos no saludables que los hogares que cuentan con recursos financieros extras. Sin embargo, en el caso de los gastos en alimentos saludables no representan diferencia alguna.
  Los hogares que presentan cierta inseguridad alimentaria gastan menos en alimentos no saludables que los que no presentan inseguridad alimentaria.
  
En conclusion no existe evidencia estadistica que nos sugiera que el gasto en alimentos no saludables lleve a padecer inseguridad alimentaria en los hogares con nivel socioeconomico bajo. Se encontro evidencia de que en los hogares con nivel socioeconomico bajo que no presentan recursos financieros distintos al ingreso laboral se presenta cierta inseguridad aliemntaria en comparacion con los hogares que si presentan recursos financieros distintos al ingreso laboral.
  