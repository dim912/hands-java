package org;

public class Equlibrium {

    public static void main(String[] args) {

        Equlibrium eq =  new Equlibrium();
        int[] A  =  {0,1,3,-2,0,1,0,-3,2,3};
        System.out.println(eq.solution(A));

    }

    public int solution(int[] A) {
        // write your code in Java SE 8

        int P = A[0];
        int Q = A[0];
        int R = A[0];

        boolean deeping = false;
        boolean climbing = false;
        int maxDeep = 0 ;

        for(int i=1 ; i< A.length ; i++){

            //if the end => check whether climbing
            if(i == A.length -1){
                if(climbing){
                    int currDepth = Math.min(P-Q,R-Q);
                    maxDeep = Math.max(currDepth,maxDeep);
                }
            }

            else if(A[i] > A[i-1]){ //going to peek
                if(!climbing && deeping){
                    climbing = true;
                    deeping  = false;
                    Q = A[i-1];
                }
                else if(climbing && !deeping){
                    continue;
                }
                else if(!climbing && !deeping){ //start climbing from a flat area
                    climbing = true;
                }
            }
            else if(A[i] < A[i-1]){ //going to deep
                if(deeping && !climbing){
                    continue;
                }
                else if(climbing && !deeping){
                    climbing = false;
                    deeping =  true;
                    R = A[i-1];
                    int currDepth = Math.min(P-Q,R-Q);
                    maxDeep = Math.max(currDepth,maxDeep);
                    P = A[i-1];
                }
            }
            else if(A[i] ==  A[i-1]){ //flat area
                if(climbing && !deeping){
                    climbing = false;
                    deeping =  false;
                    R = A[i-1];
                    int currDepth = Math.min(P-Q,R-Q);
                    maxDeep = Math.max(currDepth,maxDeep);
                    P = A[i-1];
                }
                if(!climbing && deeping){
                    deeping = false;
                }
            }
        }
        return maxDeep;
    }










	/* number of intersections of disks
	 *  public int solution(int[] A) {

        int count = 0 ;
        for(int i = 0 ; i< A.length ; i++){
            for(int j=i+1 ; j< A.length ; j++){
               if(i+A[i] >= j-A[j]){
                    count++;
               }
            }
        }
        return count;
    }
	 */

	/*
	 public int solution(int[] A) {
       Arrays.sort(A);

      int posCount = 0 ;
      int negCount = 0 ;
      int max = 0 ;

      for(int i=0 ; i < A.length ; i++){
        if(A[i] < 0){
            negCount++;
        }
        else{
            posCount++;
        }
      }
      if(posCount >= 3 && negCount <=1){
          max = A[A.length-1] *  A[A.length-2] * A[A.length-3] ;
      }
      else if(posCount >= 3 && negCount >1){
         max = A[A.length-1] *  A[A.length-2] * A[A.length-3] ;
         if(A[A.length-1] * A[0] * A[1] > max){
           max =   A[A.length-1] * A[0] * A[1] ;
         }
      }
      else if((posCount==1 || posCount==2 ) && negCount>=2 ){
        max =   A[A.length-1] * A[0] * A[1] ;
      }
      else if(posCount==2 && negCount==1){
             max =   A[0] * A[1] * A[2] ;
      }
      else if(posCount==0 && negCount>=3){
             max = A[A.length-1] * A[A.length-2] * A[A.length-3] ;
      }
       return max;
    }

	 */


	/*counting distinct elements in a array
public int solution(int[] A) {
        Arrays.sort(A);
        int metCount = 0 ;

        if(A.length>0){
            metCount = 1;
        }

        for(int i=1 ;  i< A.length ; i++){
            if(A[i] !=  A[i-1]){
                metCount++;
            }
        }
        return metCount;
    }
    */



	/* Number of divisable intigers between two integers
    public int solution(int A, int B, int K) {

     return A%K ==0 ? (B-A)/K + 1 : (B -(A-A%K))/K;
    }
    */


	/*DNA MIN
	 public int[] solution(String S, int[] P, int[] Q) {

      char[] text =  S.toCharArray();
      int[] arr = new int[P.length];

      int[] aCount =  new int[S.length()];
      int[] cCount =  new int[S.length()];
      int[] gCount =  new int[S.length()];
      int[] tCount =  new int[S.length()];

      //forming arrays
      for(int i=1 ; i < S.length() ; i++){
          aCount[i] = aCount[i-1];
          cCount[i] = cCount[i-1];
          gCount[i] = gCount[i-1];
          tCount[i] = tCount[i-1];

         if(text[i-1]=='A'){
             aCount[i]++;
         }
         else if(text[i-1]=='C'){
             cCount[i]++;
         }
         else if(text[i-1]=='G'){
              gCount[i]++;
         }
         else if(text[i-1]=='T'){
              tCount[i]++;
         }
      }
      for(int i=0;i<Q.length;i++){

          if(text[Q[i]]=='A' || ( aCount[Q[i]]-aCount[P[i]] ) > 0 ){
              arr[i] = 1;
          }
          else if(text[Q[i]]=='C' || ( cCount[Q[i]]-cCount[P[i]] ) > 0 ){
              arr[i] = 2;
          }
          else if(text[Q[i]]=='G' || ( gCount[Q[i]]-gCount[P[i]] ) > 0 ){
              arr[i] = 3;
          }
          else if(text[Q[i]]=='T' || ( tCount[Q[i]]-tCount[P[i]] ) > 0 ){
              arr[i] = 4;
          }
      }
      return arr;
    }
	 */

	/* Passing Cars
	 public int solution(int[] A) {

        int toEastCount = 0;
        int numPassing = 0;

        for(int i=0 ; i < A.length ; i++){
            if(A[i]==0){
                toEastCount ++;
            }
            else if(A[i]==1){
                if(numPassing + toEastCount > 1000000000 ){
                    return -1;
                }
                else{
                    numPassing += toEastCount;
                }
            }
        }

        return numPassing ;
    }
	 */


/* first missing positive integer. Use the tracker
public int solution(int[] A) {

        //labled whether 1 to N elements are in the array.
        boolean[] track = new boolean[A.length];

        for(int i=0;i<A.length;i++){
            if(A[i] > 0 && A[i]<=A.length && !track[A[i]-1]){
                track[A[i]-1] = true;
            }
        }

        //search for the first occurence of non existance
        for(int i=0;i<A.length;i++){
            if(!track[i]){
                return i+1;
            }
        }
        //if all 1 to N are there. Then the N+1 should be the first missing positve int
        return A.length + 1 ;
    }
*/

	/* max counters
	 public int[] solution(int N, int[] A) {

        int[] counters = new int[N];
        int publishedMax = 0;
        int max = 0 ;

        for(int i=0 ; i < A.length ; i++){
            if(A[i]<=N){

                if(counters[A[i]-1] > publishedMax ){
                    counters[A[i]-1] ++;
                }
                else{
                    counters[A[i]-1] = publishedMax + 1;
                }
                if(max < counters[A[i]-1]) {
                    max = counters[A[i]-1];
                }
            }
            else if(A[i]==N+1){
                publishedMax = max;
            }
        }
        for(int i= 0 ; i< N ; i++){
            if(counters[i] < publishedMax){
                counters[i] = publishedMax ;
            }
        }
     return counters ;
    }
	 * */
	/*Fog River One. The earliest time that Fog can cross the river
	 public int solution(int X, int[] A) {
	        int[] trace =  new int[X];
	        int unFilledCount = X;

	        for(int i=0; i < A.length ; i++){
	            if(A[i] <= X && trace[A[i]-1] == 0){
	                trace[A[i]-1] = X;
	                unFilledCount --;
	            }
	            if(unFilledCount == 0){
	            	return i;
	            }
	        }
	        return -1;
	    }
	    */


	/*
	Check whether an array having N elements contain all elements from 1 to N.
	class Solution {
	    public int solution(int[] A) {
	        long sum = 0 ;
	        for(int i=0;i<A.length ; i ++){
	            sum ^= (i+1)^A[i];
	        }
	        return sum == 0 ? 1  : 0 ;
	    }
	}
	*/



	/* Tape Equlibrium
	 public int solution(int[] A) {
        // write your code in Java SE 8

        long total = 0;
        long left_sum = 0;
        long right_sum = 0;
        long longDiff ;
        long currentDiff;

        for(int i=0 ; i< A.length ; i++) {
            total += A[i];
        }

        longDiff = Math.abs(total - 2 * A[0]);

        right_sum = total;

        for(int i=1 ; i< A.length ; i++){
            left_sum += A[i-1];
            right_sum -= A[i-1];

            currentDiff = Math.abs(right_sum - left_sum) ;

            if(currentDiff < longDiff){
                longDiff = currentDiff;
            }
        }
        return (int)longDiff ;
    }
	 * */

	/* Missing element
	     public int solution(int[] A) {

      Arrays.sort(A);

      for(int i=0; i < A.length ; i++){
        if(A[i+1]==A[i]+2){
            return A[i]+1;
        }
      }
       return 0;
    }

    By XOR
      public int solution(int[] A) {

      int missing = 0;
      for(int i=0; i < A.length ; i++){
             missing ^= (i+1) ^ A[i] ;
      }
      return missing ^  (A.length+1);
    }

    Other method : calculate the sum of 1 to N+1 elements.
    calculate the additon of all elements.
    Deduct
	 */

	/* shortest Fog Jump
    public int solution(int X, int Y, int D) {
        if( ((Y-X) % D ) == 0 ) {
            return (Y-X) /D ;
         }
         else{
             return  ((Y-X)/D) + 1;
         }
     }
     */

	/* rotating an Array
	public int[] solution(int[] A, int K) {
        int len = A.length;
        int[] res = new int[len];
        for(int i=0 ; i < len ;  i++){
            res[(i+K)%len] = A[i];
        }
        return res;
    }
    */
}

// Odd-Occurrences-In-Array or OddOccurrencesInArray
	/*
    public int solution(int[] A) {
    	/* 100%
        Arrays.sort(A);
        for(int i = 0 ; i < A.length/2 ;  i++){
            if(A[2*i] !=  A[2*i+1]){
                return A[2*i];
            }
        }
        return A[A.length - 1];


    	int oddNum = 0;
    	for(int i=0 ; i < A.length ; i++){
    		oddNum ^= A[i]; //this will cancel off all duplicates
    	}
        return oddNum;

     }
*/
	/* Array Equlibrium 100% solution.
	public int solution(int[] A) {

		long sum = 0;
		long sum_left = 0;
		long sum_right = 0;

		for (int i = 0; i < A.length; i++) {
			sum += A[i];
		}

		sum_right = sum;

		for (int i = 0; i < A.length; i++) {

			if (i > 0) {
				sum_left += A[i - 1];
			}
			sum_right -= A[i];

			if (sum_right == sum_left) {
				return i;
			}
		}
		return -1;
	}
	*/

	/* Longest 0 gap
    public int solution(int N) {

    	/* 100% marks. Performace not verified
    	String binary = Integer.toBinaryString(N);
    	int longestGap = 0;
    	int runningGap = 0;
    	boolean inGap = false;

    	for(int i=0 ; i < binary.length() ; i++){
    		if(inGap && binary.substring(i,i+1).equals("0")){
    			runningGap ++;
    		}
    		else if(inGap && binary.substring(i, i+1).equals("1")){
    			if(longestGap < runningGap){
    				longestGap = runningGap;
    			}
    			runningGap = 0;
    		}
       		if(binary.substring(i, i+1).equals("1")){
    			inGap = true;
    		}
    	}
       return longestGap;

    	boolean inGap = false;
    	int longestGap = 0 ;
    	int runningGap = 0;

    	    	/* 100% marks. Performace not verified

    	while(N>0){
    		//get the last bit of N and check whether it is decimal 1.
    		if(((N & 1) == 0 ) && inGap){
    			runningGap++;
    		}
    		//get the last bit of N and check whether it is decimal 0.
    		else if(((N & 1) == 1 ) && inGap){
    		    if(longestGap < runningGap){
    				longestGap = runningGap;
    			}
    			runningGap = 0;
    		}

    		if((N & 1) == 1){
    			inGap = true;
    		}
    		//right shift bit stream. the last bit is flushed out = to /2.
    		//after the last iteration N will be 0
    		N = N >> 1;
    	}
    	return longestGap;
    }
*/

