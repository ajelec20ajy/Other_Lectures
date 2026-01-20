int cal\_length(DLlistType\* dlist);



이중 연결 리스트의 노드들의 개수를 계산하여 반환하는 함수.





DLlistNode\* node\_position(int pos, DLlistType\* dlist);



이중 연결 리스트에서 position 위치의 노드 주소를 반환하는 함수.





DLlistNode\* delete\_pos(int pos, DLlistType\* dlist);



이중 연결 리스트에서 position에 해당하는 노드를 삭제하는 함수.





void insert\_node\_pos(int pos, int entrance\_year, char name\[MAX\_SIZE], float GPA,

DLlistType\* dlist);



이중 연결 리스트에서 지정한 position에 새로운 노드 삽입 함수.





void insert\_inc\_entrance\_year(int entrance\_year, char name\[MAX\_SIZE], float GPA,

DLlistType\* dlist);



이중 연결 리스트에 새로운 노드를 삽입하는 함수이며 리스트의 노드의 입학년도가 증가하는 순서가 되도록 삽입하는 함수.





void insert\_dec\_GPA(int number, char name\[MAX\_SIZE], float GPA, DLlistType\* dlist);



이중 연결 리스트에 새로운 노드를 삽입하는 함수이며 리스트의 노드의 학점이 감소하는 순서가 되도록 삽입하는 함수.



