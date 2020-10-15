# ���� ���� �з��⸦ ���� �����ϰ� ��� ȥ������� ����غ���

library(readxl)
library(tm)
library(SnowballC)
library(e1071)
library(gmodels)

sms_train <- read.csv('C:/�ӽ�/RData/sms_spam_ansi.txt')
sms_test <- read.csv('C:/�ӽ�/RData/�ܽ����׽�Ʈ.txt',header=F)

# ���� �� ��ó�� -> ������ �ٽ� ����
split_point <- dim(sms_train)[1]
names(sms_test) <- c('type','text') # Į���� ���� (���տ� �ʿ�)
data <- rbind(sms_train,sms_test) # ����

table(data$type) # 4818 hams 751 spams

# ��ó�� -------------------------------------------

sms_corpus <- VCorpus(VectorSource(data$text)) # ���۽� ����
sms_corpus_preprocessed <- tm_map(sms_corpus,removeNumbers) # ���� ����
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,content_transformer(tolower)) # �ҹ��� ����
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,removePunctuation) # Ư������ ����
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,removeWords,stopwords()) # �ҿ�� ����

sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,stemDocument) # ��� ��ȯ
sms_corpus_preprocessed <- tm_map(sms_corpus_preprocessed,stripWhitespace) # ���� ����

# ���� �ܾ� ��� ���� ----------------------------------

sms_dtm <- DocumentTermMatrix(sms_corpus_preprocessed)
sms_dtm #terms :6909 #Non-/sparse entries: 43348/38416166    #Sparsity: 100% 

# ��Ҽ� ������
sms_dtm <-removeSparseTerms(sms_dtm,0.999)
sms_dtm #terms :1200 #Non-/sparse entries: 34159/6648641     #Sparsity: 99%

# �� ��ġ ������ ��ȯ
sms_dtm <- apply(sms_dtm, MARGIN = 2, function(x)ifelse(x>0,'Y','N'))


# �н�,���� ������ ����

xtrain <- sms_dtm[1:split_point,]
ytrain <- factor(data$type[1:split_point])

xtest <- sms_dtm[(split_point+1):5569,]
ytest <- factor(data$type[(split_point+1):5569])

# ���̽þ� �з��� ����&����
sms_Classifier <- naiveBayes(xtrain,ytrain,laplace = 1)
ypred <- predict(sms_Classifier,xtest)

# ���� ���
CrossTable(ypred,ytest,
           dnn=c('predicted','actual'))

# ��Ȯ�� 100%
