# [San Francisco Crime Classification](https://www.kaggle.com/c/sf-crime)

## 11-26

#### 좌표 전체 활용

xgboost: -2.81218
- n_estimators=15
- nthread=3
- seed=35

kaggle: 2.80945

#### Dates One hot encoding

year, month, day, hour, minute

xgboost: -3.27755 (13min 57s)
- n_estimators=15
- nthread=3
- seed=35

kaggle: 2.78580


#### PdDistrcit One hot encoding

xgboost: -2.85622 (17min 22s)
- n_estimators=15
- nthread=3
- seed=35

kaggle: 2.85453

#### Dates, PdDistrict One hot encoding

xgboost: -3.15685 (24min 36s)
- n_estimators=15
- nthread=3
- seed=35

kaggle: 2.76431

#### Coordinates & Dates, PdDistrict One hot encoding

xgboost: -3.10345 (32min 21s)
- n_estimators=15
- nthread=3
- seed=35

kaggle: 2.73814
