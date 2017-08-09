library(ggplot2)

size <- c(240, 960, 2160, 4000)
# Mean
CPUseq <- cbind(size, "CPUSeq", c(0.42745741009906246, 6.710403074195104, 33.322337080031865, 112.33468089220212))
CPUOMP <- cbind(size, "CPU+OpenMP", c(0.12838128153331732, 2.2240155914022277, 12.135257472735248, 41.76173592719715 ))
GPU <-  cbind(size, "GPU+OpenMP", c(0.14864438673248515, 0.20578972496829617, 0.427673206096127, 1.05179645329578))
DF <- data.frame(rbind(CPUseq, CPUOMP, GPU))
names(DF) <- c("Size", "Version", "Mean")
DF$Size <- factor(DF$Size, levels = c("240", "960", "2160", "4000"))
DF$Mean <- as.numeric(as.character(DF$Mean))

Graph <- ggplot(DF, aes(x = Size, y = Mean, color = Version, group = Version)) + 
  geom_point(size = 2.5,mapping = aes(shape=Version)) + 
  geom_line(aes(linetype = Version), size=1.25) +
  theme_bw() + 
#  scale_colour_manual(values=c(cbbPalette)) +
#  scale_fill_manual(values=c(cbbPalette)) +
  scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
              labels = scales::trans_format("log10", scales::math_format(10^.x)))  + 
  annotation_logticks(sides = "l")  +
  ylab("Mean (seconds)") + 
  xlab(expression(paste("Number of Mesh Elements"))) +
  theme(plot.title = element_text(family = "Times", face="bold", size=16)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(family = "Times", face="bold", size=16)) +
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


# Median
CPUseq <- c(0.4790759129991784, 7.484063304498704, 37.15695717749986, 123.71510654349913 )
CPUOMP <- c(0.15920984800322913, 3.2040811575134285, 16.986593497509602, 56.69127115351148 )
GPU <-  c(0.12808945053257048, 0.3175889280100819, 1.0840124645328615,  3.266195518517634)
