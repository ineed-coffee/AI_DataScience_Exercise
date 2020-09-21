# 각 파일 실습 내용

### :arrow_right: 2020.08.13

- Babynames 데이터셋 활용
- 연도별 인기 이름 , 모음 개수 변화 , 알파벳 사용 빈도 조사 

---

### :arrow_right: 2020.09.02

- [캐글 영화 메타 데이터](https://www.kaggle.com/karrrimba/movie-metadatacsv) 를 활용하여 상관계수 계산을 통한 다양한 PoC 
- 예산이 많이 들어갔다. -> 인기가 있다.
- 장르와 인기 사이 관계

---

### :arrow_right: 2020.09.03

- [캐글 tmdb 영화 데이터](https://www.kaggle.com/tmdb/tmdb-movie-metadata) 를 활용하여 각 영화의 `장르` 컬럼으로부터 특징 행렬 생성
- sklearn.feature_extraction.text 의 `CountVectorizer` 활용.
- n_gram 옵션 설정
- 코사인 유사도를 통해 특정 영화와 비슷한 영화 추출

---

### :arrow_right: 2020.09.04

- 미완료 / [캐글 movielens 스몰 데이터](https://www.kaggle.com/shubhammehta21/movie-lens-small-latest-dataset) 활용
- Bag of Words 활용 , 
- Collaborative - Filtering 을 통한 유저기반 , 아이템 기반 추천시스템 제작
- CountVectorizer , DictVectorizer

---

### :arrow_right: 2020.09.07

- pandas `merge` , `join` , `concat` 메서드를 통한 데이터프레임 병합 실습

---

### :arrow_right: 2020.09.09

- [캐글 타이타닉 학습 데이터셋](https://www.kaggle.com/hesh97/titanicdataset-traincsv) 을 활용하여 pandas 활용 자료 다루기 실습
- 정규 표현식 활용 칭호 (Mr, Mrs , Sir, ..) 추출
- NaN 값 처리 (각 열 평균 적용)
- 중복 제거 , 유니크 컬럼 추출
- value_counts 활용 그룹핑

---

### :arrow_right: 2020.09.11

- [캐글 바이크 쉐어링 데이터셋](https://www.kaggle.com/search?q=bike+share+in%3Adatasets) 을 활용하여 데이터프레임 실습
- 재구조화 , 시리얼 데이터 참조 및 활용
- 각 feature 들 사이 상관계수 계산을 통해 상관분석
- sklearn.preprocessing 모듈의 표준화 도구 StandScaler 메소드 활용

---

### :arrow_right: 2020.09.14

- [캐글 iris 데이터셋](https://www.kaggle.com/uciml/iris) 과 [캐글 titanic 데이터셋](https://www.kaggle.com/c/titanic) 을 활용한 자료 다루기 실습
- sklearn.preprocessing 모듈의 One-Hot-Encoder 활용으로 텍스트 인코딩
- 사용자 정의 구간 (bins) 활용 커스텀 그룹핑

---

### :arrow_right: 2020.09.15

- numpy 활용 배열 다루기 실습 , pandas 다중 인덱스 활용 실습
- tile , zstack() , hstack() , vstack()
- MultIndex Object()

---



