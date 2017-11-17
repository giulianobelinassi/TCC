library(ggplot2)
size <- c(240, 960, 2160, 4000)
gpu_h <- cbind(size, "gpu H", c(2.57101328E-06,	2.05148935E-05,	3.14042700E-05,	8.71655629E-06))
gpu_g <- cbind(size, "gpu G", c(1.47996502E-06,	1.60930940E-05,	2.47341577E-05,	9.87323801E-06))
gpu_sing_h <- cbind(size, "gpu_sing H", c(4.70368977E-05, 4.08425374E-04, 1.08150579E-03, 1.03810722E-04))
gpu_sing_g <- cbind(size, "gpu_sing G", c(2.11043152E-06, 1.60930940E-05, 2.47341577E-05, 1.01516853E-05))
DF <- data.frame(rbind(gpu_h, gpu_g, gpu_sing_h, gpu_sing_g))
names(DF) <- c("Size", "Version", "Error")
DF$Size <- factor(DF$Size, levels = c("240", "960", "2160", "4000"))
print(DF)
DF$Error <- as.numeric(as.character(DF$Error))


Graph <- ggplot(DF, aes(x = Size, y = Error, color = Version, group = Version)) + 
  geom_point(size = 2.5,mapping = aes(shape=Version)) + 
  geom_line(aes(linetype = Version), size=1.25) +
  theme_bw() +
  scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
              labels = scales::trans_format("log10", scales::math_format(10^.x))) + 
  annotation_logticks(sides = "l")  +
  ylab("Error") + 
  xlab(expression(paste("Mesh size"))) +
  theme(plot.title = element_text(family = "Times", face="bold", size=12)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(family = "Times", face="bold", size=12)) +
  theme(axis.text  = element_text(family = "Times", face="bold", size=10, colour = "Black")) +
  theme(legend.title  = element_text(family = "Times", face="bold", size=0)) +
  theme(legend.text  = element_text(family = "Times", face="bold", size=12)) +
  theme(legend.key.size = unit(5, "cm")) +
  theme(legend.direction = "horizontal",
        legend.position = "bottom",
        legend.key=element_rect(size=0),
        legend.key.size = unit(1, "lines")) +
  guides(col = guide_legend(nrow = 1))
ggsave(paste("~/Giuliano-plots.pdf",sep=""), Graph,  height=10, width=15, units="cm")
