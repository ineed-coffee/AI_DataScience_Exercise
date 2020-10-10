library(ggplot2)
library(dplyr)

iris_data <-iris
iris[,-5] <-scale(iris[,-5])
# Sepal.Length / Sepal.Width
kmeans_12 <- kmeans(iris_data[,c(1,2)],3,nstart=100)
round(sum(kmeans_12$withinss),2) # 37.05
centers <- kmeans_12$centers
iris_plot <-ggplot(data=iris_data,aes(x=iris_data[,1] , y = iris_data[,2] , colour=iris_data[,5]))+
  geom_point(shape=19,size=4)+
  ggtitle('iris data')
iris_plot+
  annotate('text',x=centers[1,1],y=centers[1,2],label='Setosa',size=5)+
  annotate('text',x=centers[2,1],y=centers[2,2],label='Veriscolor',size=5)+
  annotate('text',x=centers[3,1],y=centers[3,2],label='Virginica',size=5)

# Sepal.Length / Petal.Length
kmeans_13 <- kmeans(iris_data[,c(1,3)],3,nstart=100)
round(sum(kmeans_13$withinss),2) # 53.81
centers <- kmeans_13$centers
iris_plot <-ggplot(data=iris_data,aes(x=iris_data[,1] , y = iris_data[,3] , colour=iris_data[,5]))+
  geom_point(shape=19,size=4)+
  ggtitle('iris data')
iris_plot+
  annotate('text',x=centers[1,1],y=centers[1,2],label='Setosa',size=5)+
  annotate('text',x=centers[2,1],y=centers[2,2],label='Veriscolor',size=5)+
  annotate('text',x=centers[3,1],y=centers[3,2],label='Virginica',size=5)

# Sepal.Length / Petal.Width
kmeans_14 <- kmeans(iris_data[,c(1,4)],3,nstart=100)
round(sum(kmeans_14$withinss),2) # 32.73
centers <- kmeans_14$centers
iris_plot <-ggplot(data=iris_data,aes(x=iris_data[,1] , y = iris_data[,4] , colour=iris_data[,5]))+
  geom_point(shape=19,size=4)+
  ggtitle('iris data')
iris_plot+
  annotate('text',x=centers[1,1],y=centers[1,2],label='Setosa',size=5)+
  annotate('text',x=centers[2,1],y=centers[2,2],label='Veriscolor',size=5)+
  annotate('text',x=centers[3,1],y=centers[3,2],label='Virginica',size=5)

# Sepal.Width / Petal.Length
kmeans_23 <- kmeans(iris_data[,c(2,3)],3,nstart=100)
round(sum(kmeans_23$withinss),2) # 40.74
centers <- kmeans_23$centers
iris_plot <-ggplot(data=iris_data,aes(x=iris_data[,2] , y = iris_data[,3] , colour=iris_data[,5]))+
  geom_point(shape=19,size=4)+
  ggtitle('iris data')
iris_plot+
  annotate('text',x=centers[1,1],y=centers[1,2],label='Setosa',size=5)+
  annotate('text',x=centers[2,1],y=centers[2,2],label='Veriscolor',size=5)+
  annotate('text',x=centers[3,1],y=centers[3,2],label='Virginica',size=5)

# Sepal.Width / Petal.Width
kmeans_24 <- kmeans(iris_data[,c(2,4)],3,nstart=100)
kmeans_24$tot.withinss
round(sum(kmeans_24$withinss),2) # 20.6
centers <- kmeans_24$centers
iris_plot <-ggplot(data=iris_data,aes(x=iris_data[,2] , y = iris_data[,4] , colour=iris_data[,5]))+
  geom_point(shape=19,size=4)+
  ggtitle('iris data')
iris_plot+
  annotate('text',x=centers[1,1],y=centers[1,2],label='Setosa',size=5)+
  annotate('text',x=centers[2,1],y=centers[2,2],label='Veriscolor',size=5)+
  annotate('text',x=centers[3,1],y=centers[3,2],label='Virginica',size=5)

# 2 칼럼 군집화는 Sepal.Width / Petal.Width 가 가장 좋음

# Sepal.Length / Sepal.Width / Petal.Length
kmeans_123 <- kmeans(iris_data[,c(1,2,3)],3,nstart=100)
round(sum(kmeans_123$withinss),2) # 69.43
kmeans_123$size # 50 58 42

# Sepal.Length / Sepal.Width / Petal.Width
kmeans_124 <- kmeans(iris_data[,c(1,2,4)],3,nstart=100)
round(sum(kmeans_124$withinss),2) # 48.66
kmeans_124$size # 50 54 46

# Sepal.Width / Petal.Length / Petal.Width
kmeans_234 <- kmeans(iris_data[,c(2,3,4)],3,nstart=100)
round(sum(kmeans_234$withinss),2) # 47.87
kmeans_234$size # 53 47 50

# 3 컬럼 군집화는 Sepal.Width / Petal.Length / Petal.Width 가 가장 좋음

kmeans_1234 <- kmeans(iris_data[,-5],3,nstart=100)
round(sum(kmeans_1234$withinss),2) # 78.85
kmeans_1234$size # 38 50 62

# 4 컬럼은 군집화가 제대로 이루어 지지 않음


