# Importar las bibliotecas necesarias
install.packages("tidyverse","caret","dplyr","ggplot2")

library(tidyverse)
library(caret)
library(dplyr)
library(ggplot2)

# Cargar los datos
climatologia1 <- read.csv("Climate Change/API_19_DS2_en_csv_v2_5998250.csv")
climatologiaMETADATA <- read.csv("Climate Change/Metadata_Country_API_19_DS2_en_csv_v2_5998250.csv")
climatologia2METADATA <- read.csv("Climate Change/Metadata_Indicator_API_19_DS2_en_csv_v2_5998250.csv")
seguridad_alimentaria1 <- read.csv("Agriculture & Rural Development/API_1_DS2_en_csv_v2_6011403.csv")
seguridad_alimentariaMETADATA <- read.csv("Agriculture & Rural Development/Metadata_Country_API_1_DS2_en_csv_v2_6011403.csv")
seguridad_alimentaria2METADATA <- read.csv("Agriculture & Rural Development/Metadata_Indicator_API_1_DS2_en_csv_v2_6011403.csv")
biodiversidad1 <- read.csv("Environment/API_6_DS2_en_csv_v2_5998158.csv")
biodiversidadMETADATA <- read.csv("Environment/Metadata_Country_API_6_DS2_en_csv_v2_5998158.csv")
biodiversidad2METADATA <- read.csv("Environment/Metadata_Indicator_API_6_DS2_en_csv_v2_5998158.csv")


#identificando los indicadores
indicadoresClima <- climatologia2METADATA[2]
indicadoresAlimento <- seguridad_alimentaria2METADATA[2]
indicadoresBio <- biodiversidad2METADATA[2]
indicadores <- (c(indicadoresBio,indicadoresAlimento,indicadoresClima))

#selecionando los datos
indicesAlimentacionSelecionados <- c("Rural population (% of total population)",
                                     "Employment in agriculture (% of total employment) (modeled ILO estimate)",
                                     "Agriculture, forestry, and fishing, value added (% of GDP)",
                                     "Access to electricity, rural (% of rural population)",
                                     "Cereal yield (kg per hectare)",
                                     "Livestock production index (2014-2016 = 100)",
                                     "Food production index (2014-2016 = 100)",
                                     "Crop production index (2014-2016 = 100)",
                                     "Agricultural machinery, tractors per 100 sq. km of arable land",
                                     "Agricultural land (% of land area)",
                                     "Fertilizer consumption (kilograms per hectare of arable land)")


# Filtrar las filas basadas en los valores de Indicator.Name
seguridad_alimentaria_filtrado <- seguridad_alimentaria1 %>%
  filter(Indicator.Name %in% indicesAlimentacionSelecionados)

# Visualizar el nuevo conjunto de datos
head(seguridad_alimentaria_filtrado)

# Filtrar las filas basadas en los valores de Indicator.Name
indicadoresClimaFiltrados <- c("Total greenhouse gas emissions (% change from 1990)",
                            "CO2 emissions from solid fuel consumption (% of total)",
                            "Renewable energy consumption (% of total final energy consumption)",
                            "Electricity production from renewable sources, excluding hydroelectric (% of total)",
                            "Agricultural irrigated land (% of total agricultural land)",
                            "Forest area (% of land area)",
                            "Arable land (% of land area)")

# Filter the dataset based on the selected indicators
seguridad_alimentariaFiltrado_climático <- climatologia1 %>%
  filter(Indicator.Name %in% indicadoresClimaFiltrados)
head(seguridad_alimentariaFiltrado_climático)

# indicadoresBio
indicadoresBioSeleccionados <- c("Mortality rate attributed to household and ambient air pollution, age-standardized (per 100,000 population)",
                               "Adjusted net savings, excluding particulate emission damage (% of GNI)",
                               "Adjusted net savings, including particulate emission damage (% of GNI)",
                               "Renewable internal freshwater resources per capita (cubic meters)",
                               "Annual freshwater withdrawals, total (% of internal resources)",
                               "Terrestrial and marine protected areas (% of total territorial area)",
                               "CO2 emissions from solid fuel consumption (% of total)",
                               "PM2.5 air pollution, population exposed to levels exceeding WHO guideline value (% of total)",
                               "Droughts, floods, extreme temperatures (% of population, average 1990-2009)",
                               "GHG net emissions/removals by LUCF (Mt of CO2 equivalent)")

# Filter the dataset based on the selected indicators
indicadoresBioFiltrados <- biodiversidad1 %>%
  filter(Indicator.Name %in% indicadoresBioSeleccionados)
head(indicadoresBioFiltrados)

# Ajustar el nombre de la columna Year y el cálculo del promedio según la estructura real de tus datos
#seguridad_alimentaria_filtrado <- seguridad_alimentaria_filtrado %>%
 # mutate(Year = strsplit(Indicator.Code, "X")[[1]][5])
# Seleccionar las columnas para las que deseas calcular el promedio (columnas 5 a 67)
columnas_a_promediar <- 5:67
# Calcular el promedio de las columnas seleccionadas
promedio_resultados <- seguridad_alimentaria_filtrado %>%
  select(columnas_a_promediar) %>%
  rowMeans(na.rm = TRUE)

# Agregar el resultado al conjunto de datos original
seguridad_alimentaria_con_promedio <- cbind(seguridad_alimentaria_filtrado, Promedio = promedio_resultados)

# Mostrar el conjunto de datos resultante
head(seguridad_alimentaria_con_promedio)



# Seleccionar las columnas para el mapa de calor (columnas 5 a 67)
columnas_a_mostrar <- c("Country.Name", "lat", "long", paste0("X", 1960:2022))

# Filtrar el conjunto de datos para el rango de años
seguridad_alimentaria_filtrado <- seguridad_alimentaria_filtrado %>%
  filter(Year >= 1960 & Year <= 2022)

# Seleccionar las columnas deseadas
data_mapa <- seguridad_alimentaria_filtrado %>% select(columnas_a_mostrar)

# Crear un mapa del mundo
mapa <- map_data("world")

# Fusionar los datos con el mapa
mapa <- left_join(mapa, data_mapa, by = "Country.Name")

# Graficar el mapa de calor
ggplot(data = mapa, aes(x = long, y = lat, fill = X1960)) +
  geom_tile() +
  scale_fill_continuous(low = "white", high = "red") +
  labs(title = "Mortalidad por contaminación del aire", fill = "Valor")