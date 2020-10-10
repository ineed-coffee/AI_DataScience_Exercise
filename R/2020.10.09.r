library(ggplot2)
library(dplyr)
library(readxl)
library(proxy)

# Q0. ������ �ε� , �ܾ��÷� ǥ��ȭ , 
sns_data <- read.csv('./R���������ͼ�/snsdata.csv')
sns_data[5:40] <- as.data.frame(lapply(sns_data[5:40],scale))
#-------------------------------------------------------------------------------


# Q1. gender�� �ٸ� ������ ��ü, na ���� ���� �л��� ���� ������(�Ÿ�) �л� 10�� �˻� 
# -> ���� �Ǵ�(�� ���� ��) �� ��ü
notna_gender <- (sns_data %>% filter(!is.na(gender)))[5:40] # ������ NA�� �ƴ� ������ �� �ܾ�Į����
na_gender <- (sns_data %>% filter(is.na(gender))) #������ NA�� ������ 

myfunc <- function(x){
  cur_interest <- t(as.matrix(x[5:40])) # x���� �ܾ�Į�� ����
  cur_dist <- as.matrix(proxy::dist(x=cur_interest,y=notna_gender,method = 'cosine')) # cur_interest �຤�Ϳ� notna_gender�� �� �຤�� ������ �Ÿ� ��� ����
  top_index <- head(order(cur_dist),11) # cur_interest �຤�Ϳ� �ڻ��� �Ÿ��� ���� ���� 11��(�ڽŵ� ���Ե� ��) ���� ��ȣ ���� 
  top_index <- top_index[2:11] # ���� ����
  cnt_table <- table(sns_data$gender[top_index]) # top_index ����� ���� ���̺� ����
  return(ifelse(cnt_table[1]>=5,'F','M')) # 5>= �̸� F , �ƴϸ� M ��ȯ
}

sns_data$gender[is.na(sns_data$gender)] <- apply(na_gender,1,myfunc) # ��ü ������ ������Ʈ
#-------------------------------------------------------------------------------


# Q2. �� �۷����� ����(n-start ��)�Ͽ� Ŭ�����͸�

# gradyear �� ǥ��ȭ
sns_data$gradyear <- scale(sns_data$gradyear)

# gender �� ����ȭ (F:1 , M:0)
sns_data$gender <- ifelse(sns_data$gender == 'F',1,0)

# age �� �̻�ġ ���� + ����ġ �׷캰(gradyear) ������� ��ü + ǥ��ȭ
sns_data$age <- ifelse(sns_data$age>=13 &sns_data$age<20,sns_data$age,NA)
ave_age <- ave(sns_data$age,sns_data$gradyear , FUN= function(x) mean(x,na.rm=T))
sns_data$age <- ifelse(is.na(sns_data$age),ave_age,sns_data$age)
sns_data$age <- scale(sns_data$age)

# friends ���� �����ϰ� ����ȭ
sns_clustering <- kmeans(x=sns_data[-4],centers = 5,nstart = 100,iter.max = 25)
#-------------------------------------------------------------------------------


# Q3.�� Ŭ������ �ؼ�(using aggregate())
#???  ~ cluster  => �ؼ� ����� �������� �ۼ�

sns_data$cluster <- sns_clustering$cluster # ���� �����Ϳ� ���� ��ȣ �� �߰�

# ������ ���� ���� 
aggregate(data=sns_data,cbind(age,gradyear)~cluster,mean)
#cluster      age      gradyear
#1       1 -0.1364148  0.1315948
#2       2 -0.8479510  0.8819588
#3       3 -0.3243307  0.3181345
#4       4  0.8569269 -0.8889441
#5       5  0.1425984 -0.1416891
# -------> 4�� �׷��� ���̰� ������, 2�� �׷��� ��������� � �׷�


# ������ ���� ���� (0�� �������� ���ڰ� ���� , 1�� �������� ���ڰ� ����)
aggregate(data=sns_data,gender~cluster,mean)
#cluster    gender
#1       1 0.8876133
#2       2 0.8350406
#3       3 0.9126016
#4       4 0.7986152
#5       5 0.7920792
# -------> 4,5�� �׷��� ���ڰ� ����, 3�� �׷��� Ư���� ���� �������� ����


# ������ ���� � ��ȣ 
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
# -------> 1,3�� �׷��� �׳���(?) ��� ������


# ������ ���� ��,�Ӹ�,���ο� ���� ���ɵ� 
# (hollister,abercrombie,mall,hair,shopping,clothes,dress)
aggregate(data=sns_data,cbind(hollister,abercrombie,mall,hair,
                              shopping,clothes,dress)~cluster,mean)
#cluster   hollister abercrombie        mall        hair     shopping     clothes        dress
#1       1  0.09647802   0.1303735  0.71825746  2.11304288  0.426890720  1.28254662  0.589325016
#2       2 -0.12685921  -0.1368865 -0.00499873 -0.10794802 -0.032281895 -0.07530701 -0.100863968
#3       3  3.77823603   3.7503360  0.73288428  0.42039844  1.026441614  0.59748293  0.214380485
#4       4 -0.15495514  -0.1482483 -0.13297295 -0.18192595 -0.094905116 -0.12764409  0.005984797
#5       5 -0.16816311  -0.1476118 -0.06395242 -0.03017213 -0.004369212  0.02447107  0.101903192
# -------> 3�� �׷��� Ư�� �귣�忡 ���� ������ ���ϰ� 1�� �׷��� �Ϲ����� �׷�ֿ� ������ ����


# ������ ���� ���� ���ɵ� 
# (bible,jesus,god,church)
#(��� god,jesus �� oh my god, holy jesus ���� ���忡 ���ΰ� �ƴϿ����� ������ ��� �ϴµ�..)
aggregate(data=sns_data,cbind(bible,jesus,god,church)~cluster,mean)
#cluster        bible       jesus         god       church
#1       1  0.288446699  0.28515783  0.64683008  0.390695940
#2       2 -0.028235631 -0.01564325 -0.05666972 -0.001782124
#3       3 -0.034722019  0.02048630  0.03112940  0.025349592
#4       4 -0.008142261 -0.02398509 -0.03196559 -0.052647080
#5       5  0.065088936  0.06549380  0.13148509  0.110029036
# -------> 1�� �׷��� �׳���(?) ������ ���� ����


# ������ ���� �̼� ���ɵ� 
# (hot,sex,kissed,sexy,blonde,cute)
aggregate(data=sns_data,cbind(hot,sex,kissed,sexy,blonde,cute)~cluster,mean)
#cluster         hot         sex      kissed        sexy      blonde         cute
#1       1  0.44071059  1.46415253  2.00865483  0.63523509  0.31832417  0.849865576
#2       2  0.02320612 -0.09331498 -0.12023316 -0.01621468 -0.01382314 -0.045488685
#3       3  0.39752706  0.01804604  0.05477221  0.13286797  0.06207983  0.434774899
#4       4 -0.10326434 -0.08744784 -0.13088549 -0.07069213 -0.02935724 -0.091081618
#5       5 -0.04036203 -0.03950454 -0.02766550 -0.01426827 -0.01185477  0.002761376
# -------> 1�� �׷��� �̼��� ������ ����


# ������ ���� ���� ���� Ȱ�� ���ɵ� 
# (cheerleading,rock,music,dance,band,marching)
aggregate(data=sns_data,cbind(cheerleading,rock,music,dance,band,marching)~cluster,mean)
#cluster cheerleading        rock       music        dance       band    marching
#1       1  0.304881973  1.13341785  1.05703760  0.572408949  0.2933489 -0.04249949
#2       2 -0.004620669 -0.04970498 -0.07269981 -0.005434922 -0.1002700 -0.11472436
#3       3  0.490162287  0.04593365  0.11764073  0.273289705 -0.1015605 -0.11309987
#4       4 -0.064110123 -0.10056369 -0.08974323 -0.088326262 -0.1151762 -0.10678153
#5       5 -0.091822648  0.16387697  0.51371142  0.089917976  4.1246426  5.18687340
# -------> 1�� �׷��� ���ǰ� �㿡 , 5�� �׷��� ��Ī��忡 ������ ����.



# ������ ���� Ż�� ���ɵ� 
# (drunk,drugs,die,death)
aggregate(data=sns_data,cbind(drunk,drugs,die,death)~cluster,mean)
#cluster       drunk       drugs         die       death
#1       1  1.29197401  1.79418403  1.24840079  0.81608306
#2       2 -0.10233957 -0.11165841 -0.07329496 -0.05532519
#3       3  0.06223171  0.02509933  0.02090334  0.09910124
#4       4 -0.05910021 -0.10967061 -0.08307454 -0.05545281
#5       5 -0.07982733 -0.05550800  0.01171970  0.05581678
# -------> 1�� �׷��� ��...


# �� �׷� centers �� �� ����
sns_clustering$centers[1,][order(sns_clustering$centers[1,])]
# 1�� �׷� : ������ , � , �̼�

sns_clustering$centers[2,][order(sns_clustering$centers[2,])]
# 2�� �׷� : Ư������ , ���� �

sns_clustering$centers[3,][order(sns_clustering$centers[3,])]
# 3�� �׷� : �ٹ̱� ������ , ���� ���� ���� 

sns_clustering$centers[4,][order(sns_clustering$centers[4,])]
# 4�� �׷� : ���� ���� , ���� ���� , SNS �� ����

sns_clustering$centers[5,][order(sns_clustering$centers[5,])]
# 5�� �׷� : ���� , ��Ī ���