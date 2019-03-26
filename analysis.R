library(CausalImpact)
library(ggplot2)

data <- cbind(gtrends_data$google, 
              gtrends_data$heat, 
              gtrends_data$warm, 
              gtrends_data$trump,
              gtrends_data$afd)

# Plot Google Search Volume
ggplot(data=gtrends_data, aes(x=as.numeric(row.names(gtrends_data)), y=google))+
  geom_line()+
  scale_y_continuous("Google Search Volume: klimawandel")+
  scale_x_continuous(" ",
                     breaks = c(0,52,104,157,209),
                     labels= c("2015","2016","2017","2018","2019"))+
  theme_light()

pre.period <- c(1, 215)
post.period <- c(216, 220)

impact <- CausalImpact(data, 
                       pre.period, 
                       post.period,
                       model.args = list(nseasons = 4, season.duration = 12),
                       dynamic.regression = T)

# Plot Impact
plot(impact, "original") +
  scale_y_continuous("Google Search Volume: klimawandel")+
  scale_x_continuous(" ",
                     breaks = c(0,52,104,157,209),
                     labels= c("2015","2016","2017","2018","2019"))+
  theme_light()

# Impact Summary
summary(impact)
plot(impact$model$bsts.model, "coefficients")
