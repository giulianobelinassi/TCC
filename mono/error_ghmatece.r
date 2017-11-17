library(ggplot2)
size <- c(240, 960, 2160, 4000, 14400)
gpu_h <- cbind(size, "gpu H", c(2.57E-07, 3.46E-07, 4.84E-07, 5.05E-07, 1.65E-06))
gpu_g <- cbind(size, "gpu G", c(3.37E-07, 5.98E-06, 9.55E-06, 3.68E-06, 1.97E-05))
DF <- data.frame(rbind(gpu_h, gpu_g))
names(DF) <- c("Size", "Version", "Error")
DF$Size <- factor(DF$Size, levels = c("240", "960", "2160", "4000", "14400"))
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
