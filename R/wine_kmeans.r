library(dplyr)
library(readxl)

wine <- read.csv(file = './R���������ͼ�/wine.data',header=F)
colnames(wine) <- c('Class id','Alcohol','Malic acid','Ash','Alcalinity of ash',
                    'Magnesium','Total phenols','Flavanoids',
                    'Nonflavanoid phenols','Proanthocyanins',
                    'Color intensity','Hue','OD280/OD315 of diluted wines',
                    'Proline')
str(wine) # 178 X 14 : 1 = �׷��ȣ(Ÿ�ٵ�����) + 2~14 = 13�� Ư��������



# Ư�� ���
#Ÿ�� ������
#������ ���� 0, 1, 2�� ������ ��
#Ư¡ ������
#����(Alcohol)
#����(Malic acid)
#ȸ��(Ash)
#ȸ���� ��Į����(Alcalinity of ash)
#���׳׽�(Magnesium)
#�� �������(Total phenols)
#�ö󺸳��̵� �������(Flavanoids)
#�� �ö󺸳��̵� �������(Nonflavanoid phenols)
#���ξ���þƴ�(Proanthocyanins)
#������ ����(Color intensity)
#����(Hue)
#�� ������ OD280/OD315 ���� (OD280/OD315 of diluted wines)
#���Ѹ�(Proline)

wine %>% filter(is.na(wine)) # NO NA

wine[-1] <- scale(wine[-1]) # Ư�� �÷� ǥ��ȭ

wine_clusters <- kmeans(x=wine[-1],nstart = 100,centers=3,iter.max = 20) # Ŭ�����͸�
wine_clusters$size # 65 : 62 : 51 


# centroid ����� �׷캰 Ư¡ 
wine_clusters$centers[1,order(wine_clusters$centers[1,])]
# 1�׷� : ���ڿ� ���� ���� , ������ �� ȭ��Ʈ�� �����(?)

wine_clusters$centers[2,order(wine_clusters$centers[2,])]
# 2�׷� : ȸ���� ��Į������ ���� , ���Ѹ� ������ ���� ����

wine_clusters$centers[3,order(wine_clusters$centers[3,])]
# 3�׷� : �� ������ OD280/OD315 ������ ���� ���� , ������ ����(����)


# ���� �з� �÷� ����
wine$custered <- wine_clusters$cluster 

# ��Ȯ�� : 0.983
wine %>% 
  mutate(result=1-(`Class id` - custered)) %>% # result : 1-correct , 0-wrong
  summarise(acc = mean(result))
