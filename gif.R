library(magrittr)
library(ggplot2); theme_set(theme_bw())

fps <- 30
seconds <- 20

p <- ggplot(data.frame(x = 1)) +
  geom_function(fun = dnorm, n = 500, color = "red") +
  xlim(-6, 6) +
  ylim(0, 0.5)

png("/tmp/gif-part%04d.png", width = 1600, height = 1200)
for (i in exp(seq(log(0.01), log(100), length = fps * seconds))) {
  print(
    p +
      geom_function(fun = function(x) dt(x, df = i), n = 501) +
      labs(title = paste("df:", i))
  )
}
dev.off()

paste("ffmpeg -r", fps, "-i /tmp/gif-part%04d.png output.mp4") %>%
  system()

