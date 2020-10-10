library(ggplot2)
library(dplyr)
library(readxl)
library(proxy)

# Q0. 데이터 로드 , 단어컬럼 표준화 , 
sns_data <- read.csv('./R연습데이터셋/snsdata.csv')
sns_data[5:40] <- as.data.frame(lapply(sns_data[5:40],scale))
#-------------------------------------------------------------------------------


# Q1. gender를 다른 값으로 대체, na 값을 갖는 학생과 가장 유사한(거리) 학생 10명 검색 
# -> 성별 판단(더 많은 빈도) 후 대체
notna_gender <- (sns_data %>% filter(!is.na(gender)))[5:40] # 성별이 NA가 아닌 데이터 중 단어칼럼들
na_gender <- (sns_data %>% filter(is.na(gender))) #성별이 NA인 데이터 

myfunc <- function(x){
  cur_interest <- t(as.matrix(x[5:40])) # x행의 단어칼럼 벡터
  cur_dist <- as.matrix(proxy::dist(x=cur_interest,y=notna_gender,method = 'cosine')) # cur_interest 행벡터와 notna_gender의 각 행벡터 사이의 거리 행렬 생성
  top_index <- head(order(cur_dist),11) # cur_interest 행벡터와 코사인 거리가 가장 작은 11개(자신도 포함된 수) 행의 번호 추출 
  top_index <- top_index[2:11] # 본인 제거
  cnt_table <- table(sns_data$gender[top_index]) # top_index 행들의 성비 테이블 생성
  return(ifelse(cnt_table[1]>=5,'F','M')) # 5>= 이면 F , 아니면 M 반환
}

sns_data$gender[is.na(sns_data$gender)] <- apply(na_gender,1,myfunc) # 대체 값으로 업데이트
#-------------------------------------------------------------------------------


# Q2. 모델 퍼러미터 조정(n-start 등)하여 클러스터링

# gradyear 열 표준화
sns_data$gradyear <- scale(sns_data$gradyear)

# gender 열 이진화 (F:1 , M:0)
sns_data$gender <- ifelse(sns_data$gender == 'F',1,0)

# age 열 이상치 제거 + 결측치 그룹별(gradyear) 평균으로 대체 + 표준화
sns_data$age <- ifelse(sns_data$age>=13 &sns_data$age<20,sns_data$age,NA)
ave_age <- ave(sns_data$age,sns_data$gradyear , FUN= function(x) mean(x,na.rm=T))
sns_data$age <- ifelse(is.na(sns_data$age),ave_age,sns_data$age)
sns_data$age <- scale(sns_data$age)

# friends 열은 제외하고 군집화
sns_clustering <- kmeans(x=sns_data[-4],centers = 5,nstart = 100,iter.max = 25)
#-------------------------------------------------------------------------------


# Q3.각 클러스터 해석(using aggregate())
#???  ~ cluster  => 해석 결과를 문장으로 작성

sns_data$cluster <- sns_clustering$cluster # 기존 데이터에 군집 번호 열 추가

# 군집에 따른 나이 
aggregate(data=sns_data,cbind(age,gradyear)~cluster,mean)
#cluster      age      gradyear
#1       1 -0.1364148  0.1315948
#2       2 -0.8479510  0.8819588
#3       3 -0.3243307  0.3181345
#4       4  0.8569269 -0.8889441
#5       5  0.1425984 -0.1416891
# -------> 4번 그룹이 나이가 많은편, 2번 그룹이 상대적으로 어린 그룹


# 군집에 따른 성별 (0에 가까울수록 남자가 많음 , 1에 가까울수록 여자가 많음)
aggregate(data=sns_data,gender~cluster,mean)
#cluster    gender
#1       1 0.8876133
#2       2 0.8350406
#3       3 0.9126016
#4       4 0.7986152
#5       5 0.7920792
# -------> 4,5번 그룹은 남자가 많고, 3번 그룹은 특히나 여자 구성원이 많음


# 군집에 따른 운동 선호 
# (tennis, volleyball, softball, soccer, swimming, baseball, football, basketball, sports)
aggregate(data=sns_data,cbind(tennis,volleyball,softball,soccer,swimming,
                              baseball,football,basketball,sports)~cluster,mean)
#cluster       tennis  volleyball     softball      soccer      swimming      baseball    football
#1       1  0.131448412  0.22671439  0.234610802  0.23868189  0.3524560211  0.3895219862  0.50150844
#2       2 -0.023626211  0.03695199  0.030727010  0.03732244  0.0009895773  0.0008847808 -0.01183982
#3       3  0.163290205  0.27974563  0.117299829  0.10503306  0.2511220492  0.0326184331  0.25319718
#4       4 -0.006930113 -0.08082291 -0.067360459 -0.06788169 -0.0639173936 -0.0461071733 -0.07228806
#5       5  0.044931304 -0.06637044  0.009621152 -0.11333610  0.0400694461 -0.1030775022  0.09616698
#basketball      sports
#1  0.52077481  0.79056580
#2  0.03439940 -0.01749585
#3  0.20704382  0.09766686
#4 -0.10849873 -0.08243245
#5 -0.07588185 -0.09044514
# -------> 1,3번 그룹이 그나마(?) 운동을 좋아함


# 군집에 따른 옷,머리,쇼핑에 대한 관심도 
# (hollister,abercrombie,mall,hair,shopping,clothes,dress)
aggregate(data=sns_data,cbind(hollister,abercrombie,mall,hair,
                              shopping,clothes,dress)~cluster,mean)
#cluster   hollister abercrombie        mall        hair     shopping     clothes        dress
#1       1  0.09647802   0.1303735  0.71825746  2.11304288  0.426890720  1.28254662  0.589325016
#2       2 -0.12685921  -0.1368865 -0.00499873 -0.10794802 -0.032281895 -0.07530701 -0.100863968
#3       3  3.77823603   3.7503360  0.73288428  0.42039844  1.026441614  0.59748293  0.214380485
#4       4 -0.15495514  -0.1482483 -0.13297295 -0.18192595 -0.094905116 -0.12764409  0.005984797
#5       5 -0.16816311  -0.1476118 -0.06395242 -0.03017213 -0.004369212  0.02447107  0.101903192
# -------> 3번 그룹은 특정 브랜드에 대한 관심이 강하고 1번 그룹은 일반적인 그루밍에 관심이 많음


# 군집에 따른 종교 관심도 
# (bible,jesus,god,church)
#(사실 god,jesus 는 oh my god, holy jesus 같은 문장에 쓰인게 아니였을까 생각이 들긴 하는데..)
aggregate(data=sns_data,cbind(bible,jesus,god,church)~cluster,mean)
#cluster        bible       jesus         god       church
#1       1  0.288446699  0.28515783  0.64683008  0.390695940
#2       2 -0.028235631 -0.01564325 -0.05666972 -0.001782124
#3       3 -0.034722019  0.02048630  0.03112940  0.025349592
#4       4 -0.008142261 -0.02398509 -0.03196559 -0.052647080
#5       5  0.065088936  0.06549380  0.13148509  0.110029036
# -------> 1번 그룹이 그나마(?) 관심이 조금 있음


# 군집에 따른 이성 관심도 
# (hot,sex,kissed,sexy,blonde,cute)
aggregate(data=sns_data,cbind(hot,sex,kissed,sexy,blonde,cute)~cluster,mean)
#cluster         hot         sex      kissed        sexy      blonde         cute
#1       1  0.44071059  1.46415253  2.00865483  0.63523509  0.31832417  0.849865576
#2       2  0.02320612 -0.09331498 -0.12023316 -0.01621468 -0.01382314 -0.045488685
#3       3  0.39752706  0.01804604  0.05477221  0.13286797  0.06207983  0.434774899
#4       4 -0.10326434 -0.08744784 -0.13088549 -0.07069213 -0.02935724 -0.091081618
#5       5 -0.04036203 -0.03950454 -0.02766550 -0.01426827 -0.01185477  0.002761376
# -------> 1번 그룹이 이성에 관심이 많음


# 군집에 따른 음악 관련 활동 관심도 
# (cheerleading,rock,music,dance,band,marching)
aggregate(data=sns_data,cbind(cheerleading,rock,music,dance,band,marching)~cluster,mean)
#cluster cheerleading        rock       music        dance       band    marching
#1       1  0.304881973  1.13341785  1.05703760  0.572408949  0.2933489 -0.04249949
#2       2 -0.004620669 -0.04970498 -0.07269981 -0.005434922 -0.1002700 -0.11472436
#3       3  0.490162287  0.04593365  0.11764073  0.273289705 -0.1015605 -0.11309987
#4       4 -0.064110123 -0.10056369 -0.08974323 -0.088326262 -0.1151762 -0.10678153
#5       5 -0.091822648  0.16387697  0.51371142  0.089917976  4.1246426  5.18687340
# -------> 1번 그룹은 음악과 춤에 , 5번 그룹은 마칭밴드에 관심이 많다.



# 군집에 따른 탈선 관심도 
# (drunk,drugs,die,death)
aggregate(data=sns_data,cbind(drunk,drugs,die,death)~cluster,mean)
#cluster       drunk       drugs         die       death
#1       1  1.29197401  1.79418403  1.24840079  0.81608306
#2       2 -0.10233957 -0.11165841 -0.07329496 -0.05532519
#3       3  0.06223171  0.02509933  0.02090334  0.09910124
#4       4 -0.05910021 -0.10967061 -0.08307454 -0.05545281
#5       5 -0.07982733 -0.05550800  0.01171970  0.05581678
# -------> 1번 그룹이 또...


# 각 그룹 centers 로 총 정리
sns_clustering$centers[1,][order(sns_clustering$centers[1,])]
# 1번 그룹 : 문제아 , 운동 , 이성

sns_clustering$centers[2,][order(sns_clustering$centers[2,])]
# 2번 그룹 : 특색없음 , 나이 어림

sns_clustering$centers[3,][order(sns_clustering$centers[3,])]
# 3번 그룹 : 꾸미기 좋아함 , 여자 가장 많음 

sns_clustering$centers[4,][order(sns_clustering$centers[4,])]
# 4번 그룹 : 나이 많음 , 남자 많음 , SNS 잘 안함

sns_clustering$centers[5,][order(sns_clustering$centers[5,])]
# 5번 그룹 : 음악 , 마칭 밴드