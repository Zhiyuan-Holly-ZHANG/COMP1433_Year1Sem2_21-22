# Clear the environment:
rm(list = ls())

library(readr)
library(ggplot2)

points <- read.csv("points.txt", header = FALSE, sep = ',')
names(points) = c("x", "y")
x = points$x
y = points$y

# record<-data.frame(points)
# ggplot(record,aes(x,y)) + geom_point() + ggtitle("COMP1433 Q3 zzy")


xabc <- c(40, 100, 0)
yabc <- c(40, 0, 100)

rounds <- 1000

for (a in 1:rounds) {
    # Initialize the coordinates of three centroids:
    groupAx <- vector()
    groupAy <- vector()
    groupBx <- vector()
    groupBy <- vector()
    groupCx <- vector()
    groupCy <- vector()
    
    # Loop for each point in points.txt:
    for (b in 1:nrow(points)) {
        # Calculate the distance seperately:
        disA <- sqrt((x[b] - xabc[1]) ^ 2 + (y[b] - yabc[1]) ^ 2)
        disB <- sqrt((x[b] - xabc[2]) ^ 2 + (y[b] - yabc[2]) ^ 2)
        disC <- sqrt((x[b] - xabc[3]) ^ 2 + (y[b] - yabc[3]) ^ 2)

        # Find the minimum distance among these 3:
        min_num <- min(disA, disB, disC)

        # If corresponding minimum distance -- (40, 40), then they are in the same group
        if (min_num == disA) {
            groupAx <- c(groupAx, x[b])
            groupAy <- c(groupAy, y[b])
        }

        # If corresponding minimum distance -- (100, 0), then they are in the same group
        if (min_num == disB) {
            groupBx <- c(groupBx, x[b])
            groupBy <- c(groupBy, y[b])
        }

        # If corresponding minimum distance -- (0, 100), then they are in the same group
        if (min_num == disC) {
            groupCx <- c(groupCx, x[b])
            groupCy <- c(groupCy, y[b])
        }
  }

    # We can find the value of the coordinates by division:
    px1 = sum(groupAx) / length(groupAx)
    py1 = sum(groupAy) / length(groupAy)
    px2 = sum(groupBx) / length(groupBx)
    py2 = sum(groupBy) / length(groupBy)
    px3 = sum(groupCx) / length(groupCx)
    py3 = sum(groupCy) / length(groupCy)
}


k1group = replicate(length(groupAx), "A")
k2group = replicate(length(groupBx), "B")
k3group = replicate(length(groupCx), "C")

# Merge:
X <- c(groupAx, groupBx, groupCx)
Y <- c(groupAy, groupBy, groupCy)
group <- c(k1group, k2group, k3group)
graph <- data.frame(X, Y, group)

# Three centroids are: 
X <- c(px1, px2, px3)
Y <- c(py1, py2, py3)
data_centroids <- data.frame(X, Y)
data_centroids$group <- c("A", "B", "C")

# Print the graph:
ggplot(graph, aes(X, Y, color = group)) + geom_point() +
    geom_point(data = data_centroids, shape = 7, size = 5) +
    ggtitle("COMP1433 Q3 zzy") + xlab("X") + ylab("Y")
