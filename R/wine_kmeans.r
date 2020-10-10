library(dplyr)
library(readxl)

wine <- read.csv(file = './R연습데이터셋/wine.data',header=F)
colnames(wine) <- c('Class id','Alcohol','Malic acid','Ash','Alcalinity of ash',
                    'Magnesium','Total phenols','Flavanoids',
                    'Nonflavanoid phenols','Proanthocyanins',
                    'Color intensity','Hue','OD280/OD315 of diluted wines',
                    'Proline')
str(wine) # 178 X 14 : 1 = 그룹번호(타겟데이터) + 2~14 = 13개 특성데이터



# 특성 요약
#타겟 데이터
#와인의 종류 0, 1, 2의 세가지 값
#특징 데이터
#알콜(Alcohol)
#말산(Malic acid)
#회분(Ash)
#회분의 알칼리도(Alcalinity of ash)
#마그네슘(Magnesium)
#총 폴리페놀(Total phenols)
#플라보노이드 폴리페놀(Flavanoids)
#비 플라보노이드 폴리페놀(Nonflavanoid phenols)
#프로안토시아닌(Proanthocyanins)
#색상의 강도(Color intensity)
#색상(Hue)
#희석 와인의 OD280/OD315 비율 (OD280/OD315 of diluted wines)
#프롤린(Proline)

wine %>% filter(is.na(wine)) # NO NA

wine[-1] <- scale(wine[-1]) # 특성 컬럼 표준화

wine_clusters <- kmeans(x=wine[-1],nstart = 100,centers=3,iter.max = 20) # 클러스터링
wine_clusters$size # 65 : 62 : 51 


# centroid 조사로 그룹별 특징 
wine_clusters$centers[1,order(wine_clusters$centers[1,])]
# 1그룹 : 알코올 성분 낮음 , 색상이 더 화이트에 가까운(?)

wine_clusters$centers[2,order(wine_clusters$centers[2,])]
# 2그룹 : 회분의 알칼리도가 낮음 , 프롤린 비율이 아주 높음

wine_clusters$centers[3,order(wine_clusters$centers[3,])]
# 3그룹 : 희석 와인의 OD280/OD315 비율이 아주 낮음 , 색상이 진함(높음)


# 예측 분류 컬럼 전달
wine$custered <- wine_clusters$cluster 

# 정확도 : 0.983
wine %>% 
  mutate(result=1-(`Class id` - custered)) %>% # result : 1-correct , 0-wrong
  summarise(acc = mean(result))
