# 각 파일 실습 내용

### :arrow_right: 2020.09.21

- [캐글 bike sharing demand](https://www.kaggle.com/c/bike-sharing-demand) 데이터 활용
- 학습 데이터로 만들기 위한 전처리 과정 중 일부
- 'windspeed' 컬럼의 결측값 처리를 위한 다양한 방법 적용
- sol1 ) 다른 특성(feature) 로 그룹화 및 각 그룹의 평균치 적용
- sol2 ) One-Hot-Encoding + Cosine_similarity  활용 k=11 KNN 을 통해 평균치 적용

---

### :arrow_right: 2020.09.22

- [캐글 titanic 데이터셋](https://www.kaggle.com/c/titanic) 활용
- Decision Tree 를 활용하여 test data 예측 및 캐글 submit (acc=0.77)
- 기초 전처리 + 원핫 인코딩을 통해 모델 생성

---

### :arrow_right: 2020.09.23

- [캐글 titanic 데이터셋](https://www.kaggle.com/c/titanic) 활용
- Decision Tree 를 활용하여 test data 예측 및 캐글 submit (acc=0.90.7)
- 기존 난수 생성 방식의 전처리를 그룹화 , 호칭 등의 특성 추출을 통해 정교한 전처리
- Age: Name의 호칭 활용
- Cabin: 대구분을 추출하여 상관 관계가 높은 Pclass , Fare 로 그룹핑하여 난수 생성

---

### :arrow_right: 2020.10.01

- [캐글 house prices 데이터셋](https://www.kaggle.com/c/house-prices-advanced-regression-techniques) 활용
- Random Forest 를 활용하여 test data 예측 및 캐글 submit (RMSLE = 0.139)
- 기초 EDA + 정규성 및 상관관계 조사
- 컬럼 thresholding 및 결측 처리 (Fake NA & Actual NA)
- 왜도,첨도 조사 및 스케일링 변환을 통해 정규성 만족 특성 변환
- 연속형 , 범주형 데이터 각각 인코딩 및 표준화 
- GridsearchCV 모듈을 통한 하이퍼 파라미터 서칭
- 코랩 활용 학습

---

### :arrow_right: 2020.10.05

- [UCI ML 전복 데이터셋](http://archive.ics.uci.edu/ml/datasets/Abalone) 활용
- Random Forest 활용 회귀모델 생성 및 학습 RMSLE (0.16)
-  결측값 X
- 데이터 속성 분류 (연속형 , 범주형) 후 가변수화 & 표준화
- train_test_split 모듈 활용 학습 및 예측
- max_feature 옵션 중요도 :star: 

---

### :arrow_right: 

---

### :arrow_right: 

---


### :arrow_right: 

---


### :arrow_right: 

---






