# 스팸 메일 분류기를 통해 예측하고 결과 혼동행렬을 출력해보기

library(readxl)
library(tm)
library(SnowballC)
library(e1071)
library(gmodels)

sms_train <- read.csv('C:/임시/RData/sms_spam_ansi.txt')
sms_test <- read.csv('C:/임시/RData/햄스팸테스트.txt',header=F)

# 병합 후 전처리 -> 끝나면 다시 분할
split_point <- dim(sms_train)[1]
names(sms_test) <- c('type','text') # 칼럼명 통일 (병합에 필요)
data <- rbind(sms_train,sms_test) # 병합

table(data$type) # 4818 hams 751 spams

# 전처리 -------------------------------------------

sms_corpus <- VCorpus(VectorSource(data$text)) # 코퍼스 생성
sms_corpus_preprocessed <- tm_map(sms_corpus,removeNumbers) # 숫자 제거
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,content_transformer(tolower)) # 소문자 통일
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,removePunctuation) # 특수문자 제거
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,removeWords,stopwords()) # 불용어 제거

sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,stemDocument) # 어근 변환
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,stripWhitespace) # 공백 제거

# 문서 단어 행렬 생성 ----------------------------------

sms_dtm <- DocumentTermMatrix(sms_corpus_preprocessed)
sms_dtm #terms :6909 #Non-/sparse entries: 43348/38416166    #Sparsity: 100% 

# 희소성 리미팅
sms_dtm <-removeSparseTerms(sms_dtm,0.999)
sms_dtm #terms :1200 #Non-/sparse entries: 34159/6648641     #Sparsity: 99%

# 빈도 수치 범주형 변환
sms_dtm <- apply(sms_dtm, MARGIN = 2, function(x)ifelse(x>0,'Y','N'))


# 학습,예측 데이터 분할

xtrain <- sms_dtm[1:split_point,]
ytrain <- factor(data$type[1:split_point])

xtest <- sms_dtm[(split_point+1):5569,]
ytest <- factor(data$type[(split_point+1):5569])

# 베이시안 분류기 생성&예측
sms_Classifier <- naiveBayes(xtrain,ytrain,laplace = 1)
ypred <- predict(sms_Classifier,xtest)

# 성능 출력
CrossTable(ypred,ytest,
           dnn=c('predicted','actual'))

# 정확도 100%
