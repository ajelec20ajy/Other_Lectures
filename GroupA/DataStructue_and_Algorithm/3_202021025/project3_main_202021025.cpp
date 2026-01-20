#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>

#define MAX_SIZE 5

// 구현
int edge_num(int adj_matrix[MAX_SIZE][MAX_SIZE]) 
{
	int n = 0;
	for (int i = 0; i < 5; i++) //2차원 배열을 다루기 위한 2중 for문
	{
		for (int j = 0; j < 5; j++)
		{
			if (adj_matrix[i][j] == 1)
				n++; // [i][j]요소가 1이면, 즉 간선이 있으면 n에 1을 더함.
		}
	}
	return n / 2; // 무방향 그래프라서, symmetric matrix로 구성되므로 n은 항상 2의 배수이다. 따라서 2로 나누어주면 간선의 개수이다.
}

// 구현
void complete_graph(int adj_matrix[MAX_SIZE][MAX_SIZE]) // 완전 그래프 : 모든 정점들이 연결되어 있는 그래프
{
	int n = edge_num(adj_matrix);
	if (n == MAX_SIZE*(MAX_SIZE-1)/2) // 완전 그래프라면. 정점의 개수 n에 대하여 (간선의 수) = n*(n-1)/2를 만족해야한다. n = 5이므로 (간선의 수) = 10이다.
		printf("complete graph\n");
	else
		printf("Non-complete graph\n");
}


// 구현
void check_simple_path(int adj_matrix[MAX_SIZE][MAX_SIZE], char path[]) 
{
	int size = sizeof(path) / sizeof(char); // 배열 path의 길이
	int x[sizeof(path) / sizeof(char)]; // path 배열의 요소를 adj_matrix의 인덱스에 사용하고자 path의 요소를 int형 자료로 저장할 배열 x
	int n = 0; // 경로가 이어지는지를 확인한 결과를 저장할 변수
	int o = 0; // 경로 중 중복 요소가 있는지를 확인한 결과를 저장할 변수

	for (int i = 0; i < size; i++)
	{
		x[i] = path[i] - 48; // x에 path의 값을 각각 대입시키기. path는 char형 변수이므로 ASCII 코드를 고려하여 -48을 해주어야 한다.
	}
	for (int i = 0; i < size-1; i++) // 경로의 정점이 서로 다 이어져 있는지 확인
	{
		if (adj_matrix[x[i]][x[i+1]] == 1)
		{
			n++; // 이어짐
		}
	}

	for (int i = 0; i < size; i++) // 단순 경로라면 경로 내의 중복되는 노드가 없어야 한다. 따라서 아래의 for문으로 배열 내 중복요소가 있는지를 확인한다.
	{
		for (int j = i+1; j < size; j++)
		{
			if (x[i] == x[j])
				o++; // 중복되는 요소가 있다면 o의 값이 증가하여 0이 아니게 된다.
		}
	}
	if (n == size - 1 && o == 0) // 단순 경로인 경우
		printf("Yes\n");
	else
		printf("No\n"); // 입력된 경로의 노드가 그래프 내에서 경로를 구성하지 않거나 중복되는 요소가 있어서 단순 경로가 아닌 경우
}


// 구현
int get_largest_connected_component(int adj_matrix[MAX_SIZE][MAX_SIZE]) 
{
	int m[MAX_SIZE] = {0}; //각 연결요소의 노드 개수를 저장할 배열 m
	int l = 0; //m의 인덱스를 지정할 변수

	for (int i = 0; i < MAX_SIZE; i++) // adj_matrix는 symmetry matrix이므로, 대칭되는 부분 중 한 부분만 다룬다. 마치 DFS처럼 이어진 부분을 인덱스 순대로 따라가지만 여기서는 단순히 연속되는 
		                               // 두 정점이 연결이 되어 있는지만 판단하면 되므로 돌아오는 과정은 필요없다.
	{
		for (int j = i + 1; j < MAX_SIZE; j++)
		{
			if (adj_matrix[i][j]) // 정점 i와 정점j가 연결되어 있다면
			{
				m[l]++; // m에 +1
				j = MAX_SIZE; // j로 제어되는 for문 탈출
			}
			else if (!adj_matrix[i][j] && j == MAX_SIZE - 1) // i정점에 대하여 모든 j 정점이 연결되어 있지 않은 경우 -> 연결요소의 끝에 옴.
			{
				l++; // 다음 연결요소로 넘어감
			}
		}
	}

	int max = m[0];
	for (int i = 0; i < MAX_SIZE; i++)
		if (m[i] > max)
			max = m[i]; // m중 최대값 결정

	return max+1; //+1을 해주어야 정점의 개수 (n개의 간선으로 단순 경로로 타고가면 정점은 n+1개이므로)
}


int main() {

	int G1[MAX_SIZE][MAX_SIZE] = {
		{ 0, 1, 1, 0, 1 },
		{ 1, 0, 1, 0, 0 },
		{ 1, 1, 0, 1, 1 },
		{ 0, 0, 1, 0, 1 },
		{ 1, 0, 1, 1, 0 } };

	int G2[MAX_SIZE][MAX_SIZE] = {
		{ 0, 1, 1, 1, 1 },
		{ 1, 0, 0, 0, 0 },
		{ 1, 0, 0, 0, 0 },
		{ 1, 0, 0, 0, 0 },
		{ 1, 0, 0, 0, 0 } };

	int G3[MAX_SIZE][MAX_SIZE] = {
		{ 0, 1, 0, 0, 1 },
		{ 1, 0, 1, 0, 0 },
		{ 0, 1, 0, 1, 0 },
		{ 0, 0, 1, 0, 1 },
		{ 1, 0, 0, 1, 0 } };

	int G4[MAX_SIZE][MAX_SIZE] = {
		{ 0, 1, 0, 0, 0 },
		{ 1, 0, 1, 0, 0 },
		{ 0, 1, 0, 0, 0 },
		{ 0, 0, 0, 0, 1 },
		{ 0, 0, 0, 1, 0 } };

	char path[] = "0123";


	printf("그래프의 총 간선의 수: %d \n\n", edge_num(G1));

	complete_graph(G2);

	printf("\n");
	printf("A simple path?(Yes/No):");
	check_simple_path(G3, path);

	printf("\n");
	printf("가장 큰 연결요소의 정점의 개수: %d \n\n", get_largest_connected_component(G4));

	return 0;
}