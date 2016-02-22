setwd("XXX")

library(sp)
require(rgdal)
require(ggmap)
library(maptools)
require(png)

irl <- readShapePoly("IRL_Census2011_Constituencies_2007.shp")
irl_to <- read.csv2("IRL_turnout_2011_mergeforR.csv", header=T)
irl_to$id <- irl_to$id-1

irl_df <- fortify(irl)
irl_all <- merge(irl_df,irl_to,by="id")

a <- ggplot() + 
  geom_polygon(data = irl_all,aes(x=long,y=lat,group=group, fill=turnout))+ 
  geom_path(data=irl_all, aes(x=long,y=lat, group=group), size=0.01)+
  scale_fill_gradient(low="greenyellow", high="green4") +
  ggtitle("Turnout in Irish General Election 2011") +
  theme(plot.title = element_text(size=20, face="bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        axis.line.y=element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        axis.line.x=element_blank())
ggsave("IRL_turnout_2011.png", width = 10, height = 14, dpi = 300)

pdf("IRL_turnout_2011.pdf", width = 10, height = 14)
plot(a)
dev.off()
