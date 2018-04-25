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

int n;

void * compute(void * argTemp){
	struct timeval begin1, end1;
	long long thread;
	struct argument * Temp = (struct argument *)argTemp;
	int first1,last1;
	printf("first = %d\t, last = %d\n",Temp->first, Temp->last);
	first1=Temp->first;
	last1=Temp->last;
//	printf("first = %d\t, last = %d\n",first1, last1);
	gettimeofday(&begin1, NULL);

	for(int i = first1; i < last1; i++){
		for(int j= 0;j < n; j++){
			for(int k=0;k <n; k++){
				*(Temp->c +  (i*n) + j ) +=  *(Temp->a +  (i*n) + k ) *  *(Temp->b +  (k*n) + j );
			}		
		}	
		}	
	gettimeofday(&end1, NULL);
	thread=end1.tv_usec - begin1.tv_usec;
 	printf("\n");
	printf("time by thread version in micro-sec %llu\n",thread);
	return NULL;
}

int main(int argc , char * argv[]){
	int t,ret,temp,temp1;
	int *A,*B,*C,*array;
	struct timeval begin, end,begin2,end2;
	struct argument *arg;
	long long serial,parallel;
	float speedup;
	n = atoi(argv[1]);
	t = atoi(argv[2]);
	
	pthread_t p_thread[t];

	// printf("Enter value of n :\t");
	// scanf("%d", &n);

	printf("n = %d\t,t = %d\n",n,t);

	A=(int*)malloc(sizeof(int)*n*n);
	B=(int*)malloc(sizeof(int)*n*n);
	C=(int*)calloc(n*n,sizeof(int));
	array = (int *) malloc( n * n * sizeof(int) );
	for(int i=0; i < n; i++){
		for(int j=0; j < n; j++){
		*(A +  (i*n) + j ) = (rand())% 32767;
		 *(B +  (i*n) + j ) = (rand())% 32767;
		}
	}

	gettimeofday(&begin, NULL);

	for(int i = 0; i < n; i++){
		for(int j = 0; j < n; j++){
			for(int k = 0; k < n; k++){
					*(C +  (i*n) + j ) +=  *(A +  (i*n) + k ) *  *(B +  (k*n) + j );
			}		
		}	
	}
	gettimeofday(&end, NULL);
	
	 for (int i = 0; i < n; ++i) {
      		for (int j = 0; j < n; ++j)
     		 {
  	  		*(array +  (i*n) + j ) =  *(C +  (i*n) + j );
      		}
    	}
	
 	serial=end.tv_usec - begin.tv_usec;
	printf("time by sequential version in micro-sec %llu\n",serial);
	//-----------------------------------------------//

	// printf("Enter the number of threads :\t");
	// scanf("%d",&t);


	temp = (n)/t;
	temp1 = temp;
/*	for(int i=0; i < n; i++){
		for(int j=0; j < n; j++){
		*(C +  (i*n) + j ) = 0;
		
		}
	}   */

	gettimeofday(&begin2, NULL); // Get the time stamp right before you create the threads
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
			arg->last = n;
		}
		
		// We can get it here!!
	
		
		ret = pthread_create(&p_thread[i],NULL,compute, (void *) arg);
		if(ret != 0){
			printf("thread create error\n");
		}
	}

	for(int i = 0; i< t; i++){
		ret = pthread_join(p_thread[i],NULL);
	}
	
	gettimeofday(&end2, NULL);  // So we can ge the exact time till the threads are created and joined
	parallel=end2.tv_usec - begin2.tv_usec;
	printf("time by parallel version in micro-sec %llu\n",parallel);
	speedup=(float)serial/parallel;
	printf("speed up %f\n",speedup);
//	if(FLAG==0)
//	{
//		 printf("Serial execution and parallel execution are equal!");
//	}



	free(A);
	free(B);
	free(C);

	return 0;
}
