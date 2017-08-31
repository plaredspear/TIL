# Warning git gc

개발 중에 깃느님께서 warning을 주셨다.
git gc 어쩌고 저쩌고..

무심결에 그냥 스쳐지나갔는데, 확인해보고 넘어가자.

[9.7 Git의 내부 - 운영 및 데이터 복구](https://git-scm.com/book/ko/v1/Git%EC%9D%98-%EB%82%B4%EB%B6%80-%EC%9A%B4%EC%98%81-%EB%B0%8F-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EB%B3%B5%EA%B5%AC)

문서에서 눈에 띄는 것.

#### 운영을 위해 [레퍼런스](https://git-scm.com/book/ko/v1/Git%EC%9D%98-%EB%82%B4%EB%B6%80-Git-%EB%A0%88%ED%8D%BC%EB%9F%B0%EC%8A%A4)를 압축

그러고보니, 레퍼런스가 많이 쌓이면, 부담이 될 수도 있겠구나 하는 생각이 든다.

=> 레퍼런스 개념: 외우기 쉬운 이름으로 된 파일에 SHA-1을 저장한 것

=> Git 브랜치의 역할: 브랜치는 어떤 작업들 중 마지막 작업을 가리키는 포인터 또는 레퍼런스이다.


#### 데이터 복구

삭제한 커밋을 복구할 수도 있었네???
문서의 예시에서
- 브랜치에서 예전 커밋으로 reset할 경우, 최근 커밋 두 개는 어떤 브랜치도 가리키지 않는 상태가 된다.
- git reflog 명령을 사용하면 HEAD가 변경될 때마다 남긴 log를 확인할 수 있다.
- git reflog에서 SHA 값을 확인할 수 있다.
- 확인된 SHA 값으로 브랜치를 만들면 끝.


#### 개체 삭제

Git은 History에 있는 모든 파일을 Clone 한다.
파일을 삭제한 커밋을 남겨도 History에 남아 있는 것이 문제.

git rm을 통해 삭제할 수 있음.
!!! 주의 !!! 하지만 삭제 이후의 커밋은 모두 재작성된다.
