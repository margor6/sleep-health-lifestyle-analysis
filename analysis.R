library(tidyverse)
library(knitr)
if(!require(corrplot)) install.packages("corrplot", repos = "http://cran.us.r-project.org")
library(corrplot)

#Wczytanie danych
dane <- read.csv("Sleep_health_and_lifestyle_dataset.csv")

#Czyszczenie danych
dane <- dane %>% 
  mutate(BMI.Category = ifelse(BMI.Category == "Normal Weight", "Normal", BMI.Category))

dane$Gender <- as.factor(dane$Gender)
dane$BMI.Category <- as.factor(dane$BMI.Category)


pliki_z_wykresami <- c(
  "gender.png", "bmi.png", 
  "stress.png", "qualityofsleep.png",
  "sleepduration.png", "age.png",
  "heart.png", "activity.png"
)

knitr::include_graphics(pliki_z_wykresami)

test1 <- t.test(Sleep.Duration ~ Gender, data=dane)




ggplot(dane, aes(x = Gender, y = Sleep.Duration, fill = Gender)) +
  geom_boxplot() +
  labs(title = "Dlugosc snu w zaleznosci od plci",
       x = "Plec",
       y = "Dlugosc snu (godziny)") +
  theme_minimal()


test2 <- aov(Stress.Level ~ BMI.Category, data = dane)

library(knitr)

tukey_wynik <- TukeyHSD(test2)

#Wyciągamy konkretną tabelę dla BMI.Category i wybieramy z niej tylko kolumnę "p adj"
#drop = FALSE, żeby R nie zamienił tabelki w zwykłą listę liczb
tylko_p_adj <- tukey_wynik$BMI.Category[, "p adj", drop = FALSE]

kable(tylko_p_adj, 
      digits = 4,                 
      caption = "Istotność różnic (p adj) dla par grup",
      col.names = "Wartość p")    

ggplot(dane, aes(x = BMI.Category, y = Stress.Level, fill = BMI.Category)) +
  geom_boxplot() +
  labs(title = "Poziom stresu w zaleznosci od BMI",
       x = "Kategoria BMI",
       y = "Poziom stresu (1-10)") +
  theme_minimal()

zmienne_numeryczne <- dane %>% 
  select(Sleep.Duration, Quality.of.Sleep, Physical.Activity.Level, Stress.Level, Age, Heart.Rate)

korelacje <- cor(zmienne_numeryczne)

corrplot(korelacje, method = "color", type = "upper", 
         addCoef.col = "black", 
         tl.col = "black", tl.srt = 45, 
         number.cex = 0.6,
         title = "Macierz korelacji", mar=c(0,0,1,0))

model_regresji <- lm(Quality.of.Sleep ~ Physical.Activity.Level + Age, data = dane)
summ <- summary(model_regresji)
print(summ)

ggplot(dane, aes(x = Physical.Activity.Level, y = Quality.of.Sleep)) +
  geom_point(alpha = 0.4, color = "darkblue", position = "jitter") +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  labs(title = "Wpływ aktywności fizycznej na jakość snu",
       subtitle = "Linia regresji liniowej",
       x = "Poziom aktywności (min/dzień)",
       y = "Jakość snu (1-10)") +
  theme_minimal()

#Przygotowanie zmiennych do tekstu
r2 <- round(summ$r.squared, 3)
r2_proc <- round(summ$r.squared * 100, 1)

coef_act <- coef(model_regresji)["Physical.Activity.Level"]
pval_act <- summ$coefficients["Physical.Activity.Level", "Pr(>|t|)"]
dir_act <- if(coef_act > 0) "wzrostem" else "spadkiem"
istotnosc_act <- if(pval_act < 0.05) "ma istotny statystycznie" else "nie ma istotnego statystycznie"
