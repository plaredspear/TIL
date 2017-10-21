# [10 Minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/10min.html)

```
In [1]: import pandas as pd

In [2]: import numpy as np

In [3]: import matplotlib.pyplot as plt
```


### Object Creation

Series를 생성

=> Series가 Object 단위인 듯으로 보임

=> [Intro to Data Structure](https://pandas.pydata.org/pandas-docs/stable/dsintro.html#dsintro) pandas에서 활용하는 Data Structure를 설명하는 듯

```
In [4]: s = pd.Series([1,3,5,np.nan,6,8])

In [5]: s
Out[5]:
0    1.0
1    3.0
2    5.0
3    NaN
4    6.0
5    8.0
dtype: float64
```

=> `[1,3,5,np.nan,6,8] 배열로 Series를 생성

```
In [6]: dates = pd.date_range('20130101', periods=6)

In [7]: dates
Out[7]:
DatetimeIndex(['2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04',
               '2013-01-05', '2013-01-06'],
              dtype='datetime64[ns]', freq='D')

In [8]: df = pd.DataFrame(np.random.randn(6,4), index=dates, columns=list('ABCD'))

In [9]: df
Out[9]:
                   A         B         C         D
2013-01-01  0.469112 -0.282863 -1.509059 -1.135632
2013-01-02  1.212112 -0.173215  0.119209 -1.044236
2013-01-03 -0.861849 -2.104569 -0.494929  1.071804
2013-01-04  0.721555 -0.706771 -1.039575  0.271860
2013-01-05 -0.424972  0.567020  0.276232 -1.087401
2013-01-06 -0.673690  0.113648 -1.478427  0.524988
```

- [`pd.date_range`](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.date_range.html)

=> 지정한 날짜로부터 `periods` 길이의 날짜를 반환하는 것으로 보임.

- `np.random.randn(6,4)`

=> 인자가 dimension, 두 개의 인자이므로 2-dimension.

- `df = pd.DataFrame(np.random.randn(6,4), index=dates, columns=list('ABCD'))`

=> `list('ABCD')`: 'ABCD' 문자열을 배열로 반환

```
In [10]: df2 = pd.DataFrame({ 'A' : 1.,
   ....:                      'B' : pd.Timestamp('20130102'),
   ....:                      'C' : pd.Series(1,index=list(range(4)),dtype='float32'),
   ....:                      'D' : np.array([3] * 4,dtype='int32'),
   ....:                      'E' : pd.Categorical(["test","train","test","train"]),
   ....:                      'F' : 'foo' })
   ....:

In [11]: df2
Out[11]:
     A          B    C  D      E    F
0  1.0 2013-01-02  1.0  3   test  foo
1  1.0 2013-01-02  1.0  3  train  foo
2  1.0 2013-01-02  1.0  3   test  foo
3  1.0 2013-01-02  1.0  3  train  foo
```


