# 각 파일 실습 내용

### :arrow_right: 2020.08.24

- 미리 작성한 영화 평가 json 파일로부터 각 유저의 `Euclidean 거리` 및 `피어슨 상관계수` 계산

---

### :arrow_right: 2020.08.31

- 미리 작성한 영화 평가 데이터로부터 `정규화` 작업 후 , 특정 그룹과 `Euclidean 거리` 조사 

---

### :arrow_right: 2020.09.01

- 미리 작성한 영화 평가 데이터로부터 모든 그룹 간 `Pearson 상관계수` 계산

---

### :arrow_right: 2020.09.02

- [캐글 영화 메타 데이터](https://www.kaggle.com/karrrimba/movie-metadatacsv) 를 활용하여 상관계수 계산을 통한 다양한 PoC 

---

### :arrow_right: 2020.09.04

- 미완료 / [캐글 movielens 스몰 데이터](https://www.kaggle.com/shubhammehta21/movie-lens-small-latest-dataset) 활용
- Bag of Words 활용 , 
- Collaborative - Filtering 을 통한 유저기반 , 아이템 기반 추천시스템 제작
- CountVectorizer , DictVectorizer

---

### :arrow_right: 2020.09.10

- [캐글 타이타닉 학습 데이터셋](https://www.kaggle.com/hesh97/titanicdataset-traincsv) 을 활용하여 이진화 , 표준화 , 예측 모델 생성
- sklearn.preprocessing 모듈의 Binarizer , StandardScaler 사용
- 특정 입력으로 부터 생존 여부 예측에 `Euclidean dist` 기준으로 11-nearest 데이터 추출하여 과반수 활용

---

### :arrow_right: 2020.09.15 

- 미리 작성된 transaction 데이터로부터 
- 연관규칙 평가 척도 ( Support , Confidence , Lift) 계산

---

### :arrow_right: 2020.09.16

- [케글 식료품 구매 데이터](https://www.kaggle.com/roshansharma/market-basket-optimization) 를 활용하여 추천 알고리즘 작성
- mlxtend 패키지 내의 TransactionEncoder , apriori , association_rules 메소드 활용
- min_support , use_colnames , metrics , min_threshold 옵션 활용
- 메모리 효율을 위한 sparse matrix 인코딩 및 이를 통한 데이터프리임화

---





