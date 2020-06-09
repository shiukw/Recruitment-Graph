library(ggplot2)
library(dplyr)
library(patchwork)

# Load recruitment total CSV
rc_total <- read.csv("recruitmenttotal.csv", header=T)

# Load recruitment site CSV
rc_site <- read.csv("recruitmentsite.csv", header=T)

# create ordered vector of dates
ordered_dates <- c("Jan-18",
                   "Feb-18",
                   "Mar-18",
                   "Apr-18",
                  "May-18",
                   "Jun-18",
                   "Jul-18",
                   "Aug-18",
                   "Sep-18",
                   "Oct-18",
                  "Nov-18",
                   "Dec-18") 

# Update the dataframes to follow the specific date order
rc_total$date <- ordered(rc_total$date, levels = ordered_dates)
rc_site$date <- ordered(rc_site$date, levels = ordered_dates)

# Create the recruitment graph
p1 <- rc_total %>% 
  group_by(type) %>% 
  mutate(cumn = cumsum(n)) %>% 
  ggplot(aes(x = date, y = cumn, group = factor(type), linetype=factor(type))) + 
  geom_line() +
  theme_classic() +
  ylab("Number of participants") + 
  labs(linetype = "Recruitment") +
  scale_y_continuous(labels = c(0,50, 100,150,200), breaks = c(0,50, 100,150,200)) +
  scale_linetype_discrete(breaks = c("Expected","Observed"), labels = c("Target","Actual")) + 
  theme(legend.position = c(0.1, 0.9),
        axis.text.x = element_text(angle = 90, size=12, vjust=-0.01),
        axis.text.y = element_text(size=12),
        axis.ticks.y = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=15, vjust=-20),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12, face="bold"),
        legend.background = element_blank(),
        legend.box.background = element_rect(colour = "black"))
p1

# Set the order of the sites, starting from Target recruitment
site_levels = c("Target recruitment",
                "Actual recruitment",
                "Monthly recruitment",
               "Site A",
               "Site B",
               "Site C",
               "Site D",
               "Site E",
               "Site F",
               "Site G",
               "Site H",
               "Site I")

# Graph for recruitment numbers table
data_table <- ggplot(rc_site, aes(x = date, y = factor(type), label = format(as.character(n), nsmall = 2, na.encode = F))) +
  geom_text(size = 3.5) + theme_bw() +
  theme(legend.position = "none") +
  theme(plot.margin = unit(c(-0.5,1, 0, 0.5), "lines")) + xlab(NULL) + ylab(NULL) + theme_classic() + 
  theme(legend.position = "none", axis.ticks = element_blank(), axis.text.x = element_blank()) +
  scale_y_discrete(limits = rev(site_levels), expand=c(0.1,0)) + # necessary to apply rev() function or else Site I will be on top
  geom_hline(yintercept=10.5, size=1) +
  theme(axis.line = element_blank(),
        axis.text.y = element_text(size=10))


data_table

# patchwork stitches p1 on top of data_table
recruitmentplot <- (p1 / data_table)

recruitmentplot

# Save your graph
ggsave("YOUR_PLOT_NAME.jpeg", 
       recruitmentplot, 
       device="jpeg",
       path="ENTER/FILE/OUTPUT/PATH",
       dpi=300,
       width=250,
       height = 300,
       units="mm")
