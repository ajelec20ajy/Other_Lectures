1. int edge\_num(int adj\_matrix\[MAX\_SIZE]\[MAX\_SIZE]);



함수 “edge\_num”은 배열로 표현된 무방향그래프를 입력으로 받아서 그래프에 있는 모든

간선의 수를 구해주는 함수입니다





2\.     void complete\_graph(int adj\_matrix\[MAX\_SIZE]\[MAX\_SIZE]);



함수 “complete\_graph”는 배열로 표현된 무방향그래프를 입력으로 받아서 그래프가 완전그

래프(complete graph) 여부를 판별하는 함수입니다. 함수 “complete\_graph”를 이용하여 주

어진 그래프가 완전그래프이면 “complete graph” 라고 출력하고 완전그래프가 아니면

“Non-complete graph”라고 출력합니다.





3\.     void check\_simple\_path(int adj\_matrix\[MAX\_SIZE]\[MAX\_SIZE], char path\[]);



함수 “check\_simple\_path”는 배열로 표현된 무방향그래프와 문자형 배열 path에 저장된

문자열로 표현된 경로( 예: “0123” )를 입력을 받으며 그래프에서 주어진 경로가 단순경로

(simple path)인지를 판별하는 함수입니다. 함수 “check\_simple\_path”를 이용하여 그래프에

서 주어진 경로가 단순경로이면 “Yes”라고 출력을 하고 단순경로가 아니면 “No”라고 출력합

니다.





4\.    int get\_largest\_connected\_component(int adj\_matrix\[MAX\_SIZE]\[MAX\_SIZE]);



함수 “get\_largest\_connected\_component”는 배열로 표현된 무방향그래프를 입력을 받아

서 그래프에서 가장 큰 연결요소(connected\_component)를 찾아서 가장 큰 연결요소의 정점

의 개수를 반환하는 함수입니다.

