#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cctype> //isdigit(숫자판별), isspace(공백판별) 사용하기 위해서 헤더파일 추가

// 트리 구조체
typedef struct TreeNode {
	char op_ch;           // 피연산자 또는 연산자 문자 저장 
	struct TreeNode* left, * right;
} TreeNode;

typedef struct {
	struct TreeNode* root;
} TreeType;


// 스택 구조체
typedef struct StackNode {
	TreeNode* item;
	struct StackNode* link;
} StackNode;

typedef struct {
	StackNode* top;
} LinkedStackType;


void init_t(TreeType* t) {
	t->root = NULL;
}

void init(LinkedStackType* s) {
	s->top = NULL;
}

int is_empty(LinkedStackType* s) {
	return (s->top == NULL);
}


int is_full(LinkedStackType* s) {
	return 0;
}

void push(LinkedStackType* s, TreeNode* item) {
	StackNode* temp = (StackNode*)malloc(sizeof(StackNode));

	if (temp == NULL) {
		printf("메모리 할당 에러\n");
	}
	else {
		temp->item = item;
		temp->link = s->top;
		s->top = temp;
	}
}

TreeNode* pop(LinkedStackType* s) {
	if (is_empty(s)) {
		printf("스택이 비어있음\n");
		exit(1);
	}
	else {
		StackNode* temp = s->top;
		TreeNode* item = temp->item;
		s->top = s->top->link;
		free(temp);
		return item;
	}
}



void make_exp_tree(TreeType* t, char str[])
{
	LinkedStackType* st = (LinkedStackType*)malloc(sizeof(LinkedStackType));

	init(st);
	int k = strlen(str); //입력받은 배열의 길이

	for (int i = 0; i < k; i++)
	{
		TreeNode* x = (TreeNode*)malloc(sizeof(TreeNode));
		x->op_ch = str[i]; // x의 op_ch에 str[i]를 요소로 추가
		if (isdigit(str[i]))
		{
			x->left = NULL;
			x->right = NULL;
			push(st, x); // str이 숫자일 때, 단말노드로 하여 스택에 추가
		}
		else if (isspace(str[i]))
		{
			continue; // 배열에 공백도 포함되므로, 공백일때의 경우를 구분하여 공백이면 그냥 다음 for문으로 넘어가도록 continue 실행
		}
		else
		{
			x->right = pop(st);
			x->left = pop(st);
			push(st, x); // str이 연산자일 때, 기존 스택에서 피연산자 2개를 꺼내어 연산자를 부모노드로, 피연산자 2개를 자식노드로 설정하고 스택에 추가
			t->root = x; // 트리의 root를 x에 연결하여 트리 구성하기
		}
	}
}

//  구현
void tree_display(TreeNode* r) 
{
	if (r) // r != NULL
	{
		tree_display(r->left); // 재귀형식으로, r의 왼쪽 자식노드를 매개변수로 tree_display
		printf("%c ", r->op_ch); // 노드가 가지고 있는 데이터(연산자 혹은 피연산자) 출력
		tree_display(r->right); // r의 오른쪽 자식으로 재귀함수 
	}
}


int exp_evaluation(TreeNode* r)
{
	if (isdigit(r->op_ch)) {
		return r->op_ch - 48; // 노드의 데이터(op_ch)가 숫자인 경우에, 연산없이 그냥 op_ch를 반환하면 된다. 이때, 저장된 값이 char형 데이터이므로 
		                      // ascill 코드에서 char형 0은 int형으로 48 이므로 48을 빼주어서 반환해야 한다.
	}
	
	int left = exp_evaluation(r->left); // 재귀함수, 최종적으로, 가장 위의 노드의 왼쪽 자식 노드의 최종 연산값을 가진다
	int right = exp_evaluation(r->right); // 우측 자식 노드로 재귀함수
	
	if (r->op_ch == '+')
		return right + left;
	else if (r->op_ch == '-')
		return right - left;
	else if (r->op_ch == '*')
		return right * left;
	else if (r->op_ch == '/')
		return right / left; // 각각의 연산자가 무엇인지에 따라 연산 실행하여 반환
}

int terminal_node_count(TreeNode* node)
{
	if (isdigit(node->op_ch)) return 1; // node->op_ch가 숫자이면, 자식 노드가 없다 -> 단말노드이다 -> 1추가
	return terminal_node_count(node->left) + terminal_node_count(node->right); // 재귀함수를 이용하여 순회하면서 위의 if문으로 카운팅
}

int main() {

	TreeType rt;

	// 후위 표기법 (postfix notation) 문자열. 피연산자: 한 자릿수(0 ~ 9) 수자 문자. 연산자: + ,- , *, / 문자.
	char str[] = "2 3 * 5 +";

	init_t(&rt);

	printf("Input postfix notation: %s \n\n", str);

	// 수식 이진 트리 만들기. 스택 이용. 스택에 저장 정보. 
	make_exp_tree(&rt, str);

	printf("Binary tree inorder traversal: ");
	tree_display(rt.root); // 수식 이진 트리 출력
	printf("\n");
	
	// 수식 이진 트리를 이용한 수식 계산
	printf("\nEvaluation result: %d \n", exp_evaluation(rt.root));
	printf("\n");

	//수식 이진 트리에 있는 모든 단말 노드의 수를 반환하는 함수
	printf("terminal node count: %d \n", terminal_node_count(rt.root));

	return 0;
}