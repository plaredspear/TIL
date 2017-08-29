# Chapter 4 분류자 학습시키기

분할선 y = Ax
오차(E) = 목표 값 - 실제 출력 값

t = (A + \delta A)x

E = t - y
  = (A + \delta A)x - Ax
  = Ax + \delta Ax - Ax
  = \delta Ax

\delta = E / x

목표 값을 기준으로 \delta 값을 결정함.

moderate : \delta의 일부분만 업데이트

\delta = L ( E / x )

L: Learning rate

Learning rate를 moderate
