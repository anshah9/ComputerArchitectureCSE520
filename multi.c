#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <math.h>
#include <string.h>

struct argument{
	int *a, *b, *c;
	int first,last;
};

void * compute(void * argTemp){
	struct timeval begin, end;
	struct argument * Temp = (struct argument *)argTemp;
	printf("first = %d\t, last = %d\n",Temp->first, Temp->last);
	
	gettimeofday(&begin, NULL);

	for(int i = Temp->first; i < Temp->last; i++){
		for(int j= Temp->first;j <  Temp->last; j++){
			for(int k= Temp->first;k < Temp->last; k++){
				Temp-> c[(Temp->last)*i + j] +=  Temp-> a[(Temp->last)*i + k] * Temp-> b[(Temp->last)*k + j];
			}		
		}	
	}
	gettimeofday(&end, NULL);
 
	printf("time by sequential version in micro-sec %lu\n",end.tv_usec - begin.tv_usec);
	return NULL;
}

int main(int argc , char * argv[]){
	int n,t,ret,temp,temp1;
	int *A,*B,*C;
	struct timeval begin, end;
	struct argument *arg;

	n = atoi(argv[1]);
	t = atoi(argv[2]);
	
	pthread_t p_thread[t];

	// printf("Enter value of n :\t");
	// scanf("%d", &n);

	printf("n = %d\t,t = %d\n",n,t);

	A=(int*)malloc(sizeof(int)*n*n);
	B=(int*)malloc(sizeof(int)*n*n);
	C=(int*)calloc(n*n,sizeof(int));

	for(int i=0; i < n*n; i++){

		A[i]=(rand()%(32767 - 0) + 0);
		B[i]=(rand()%(32767 - 0) + 0);
	}

	gettimeofday(&begin, NULL);

	for(int i = 0; i < n; i++){
		for(int j = 0; j < n; j++){
			for(int k = 0; k < n; k++){
				C[n*i + j] += A[n*i + k] * B[n*k + j];
			}		
		}	
	}
	gettimeofday(&end, NULL);
 
	printf("time by sequential version in micro-sec %lu\n",end.tv_usec - begin.tv_usec);
	//-----------------------------------------------//

	// printf("Enter the number of threads :\t");
	// scanf("%d",&t);


	temp = (n*n)/t;
	temp1 = temp;
	for(int i=0; i < n*n; i++){

		C[i]=0;
	}


	for (int i = 0; i < t; i++)
	{
		arg = (struct argument*)malloc(sizeof(struct argument));

		arg->a = A;
		arg->b = B;
		arg->c = C;

		if (i < t-1){
			arg->first = i*temp;
			temp1 = i*temp + temp;
			arg->last = temp1;
		}
		else{
			
			arg->first = temp1;
			arg->last = n*n;
		}

		ret = pthread_create(&p_thread[i],NULL,compute, (void *) arg);
		if(ret != 0){
			printf("thread create error\n");
		}
	}

	for(int i = 0; i<= t; i++){
		ret = pthread_join(p_thread[i],NULL);
	}

	free(A);
	free(B);
	free(C);

	return 0;
}