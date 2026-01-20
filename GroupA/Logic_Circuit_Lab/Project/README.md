FPGA 기반 자판기 제어 시스템 설계 보고서







1\. 서론



본 프로젝트는 FPGA 보드를 이용하여 자판기(Vending Machine)의 동작을 제어하는 디지털 시스템을 설계하는 것을 목표로 한다.

Verilog HDL을 사용하여 하드웨어 수준에서 자판기의 입력 처리, 상태 제어 및 출력 표시 기능을 구현하였다.



사용자는 푸시 버튼을 통해 금액 입력 및 상품 선택을 수행하며, 시스템은 내부 상태에 따라 동작을 제어하고 FND(7-Segment Display)를 통해 현재 상태 및 금액 정보를 출력한다.



2\. 설계 환경



설계 언어: Verilog HDL



대상 플랫폼: FALTERA Cyclone IV FPAG: DE0 - NANO



개발 환경 :  Quartus Prime Lite



시스템 클럭: 50 MHz



출력 장치: FND (7-Segment Display)



입력 장치: Push Button







3\. Top Module 및 포트 구성



module pr\_last(clock\_50m, pb, fnd\_s, fnd\_d);



3.1 입력 포트

신호명	비트폭	설명

clock\_50m	1	FPGA 메인 클럭 (50MHz)

pb	16	사용자 입력용 푸시 버튼



3.2 출력 포트

신호명	비트폭	설명

fnd\_s	6	FND 자리 선택 신호

fnd\_d	8	FND 세그먼트 데이터





본 설계에서는 멀티플렉싱 방식으로 FND를 구동하여, 제한된 출력 핀으로 다자리 숫자 표시를 가능하게 하였다.







4\. 내부 신호 및 레지스터 설계



4.1 버튼 입력 처리 레지스터



reg \[15:0] npb;





푸시 버튼 입력은 비동기 신호이므로, 클럭 도메인으로 동기화하여 안정적인 처리를 수행하였다.





4.2 클럭 분주 관련 레지스터

reg \[31:0] init\_counter;

reg sw\_clk;

reg fnd\_clk;





sw\_clk : 버튼 입력 처리용 저속 클럭



fnd\_clk : FND 멀티플렉싱 제어용 클럭



50MHz 시스템 클럭을 그대로 사용할 경우 입력 처리 및 표시 제어에 부적합하므로, 내부 카운터를 이용해 목적에 맞는 클럭으로 분주하였다.









5\. 상태 머신(Finite State Machine) 설계



reg \[4:0] sw\_status;





본 시스템은 자판기의 동작을 상태 머신(FSM) 구조로 구현하였다.



5.1 상태 정의

parameter sw\_start = 0;



parameter sw\_s1    = 1;



parameter sw\_s2    = 2;



parameter sw\_s3    = 3;



parameter sw\_s4    = 4;



parameter sw\_s5    = 5;



parameter error    = 6;



parameter display  = 7;



parameter in\_over  = 8;





5.2 상태 설명



상태	설명



sw\_start	초기 상태



sw\_s1 ~ sw\_s5	금액 입력 및 상품 선택 단계



display	선택 결과 표시



error	잘못된 입력 또는 금액 부족



in\_over	입력 종료 상태



각 상태는 버튼 입력에 따라 전이되며, 상태에 따라 내부 금액 처리 및 출력 동작이 결정된다.





6\. 자판기 동작 로직



6.1 금액 입력



사용자는 버튼을 통해 동전을 입력



입력 값은 내부 레지스터에 누적 저장



상태 머신을 통해 단계별 입력 관리





6.2 상품 선택



특정 버튼 조합을 통해 상품 선택



선택된 상품 가격과 입력 금액 비교



금액이 부족한 경우 error 상태로 전이





7\. FND 표시 제어



7.1 멀티플렉싱 방식



reg \[2:0] fnd\_cnt;





fnd\_clk 기준으로 자리 선택 신호(fnd\_s)를 순차적으로 활성화



해당 자리에 맞는 세그먼트 데이터(fnd\_d) 출력



사용자에게 현재 금액 또는 상태 정보 제공





7.2 표시 내용



입력 금액



선택 상태



오류 상태 표시





8\. 설계 특징



FSM 기반 자판기 구현



자판기 동작을 단계적으로 명확히 표현



클럭 분주를 통한 안정적인 입력 처리



버튼 입력 오동작 최소화



FND 멀티플렉싱 적용



제한된 I/O 환경에서 효율적인 출력 구현



하드웨어 중심 설계



실제 FPGA 보드에서 동작 가능한 구조

