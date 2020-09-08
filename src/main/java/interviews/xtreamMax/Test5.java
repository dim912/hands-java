package interviews.xtreamMax;
import java.util.Arrays;

class Solution5 {


  public boolean solution(int[] A) {

    int[] B = new int[A.length];

    for(int i=0 ; i< A.length; i++){
      B[i] = A[i];
    }

    Arrays.sort(B);

    int changedCount = 0;
    for(int i=0; i<A.length; i++){

      if(A[i] != B[i]){
        changedCount ++ ;
      }

      if(changedCount >2){
       return false;
      }
    }
    return  true;
  }


}


class Tree{

  int x;
  Tree l;
  Tree r;

}

public class Test4 {

  public static void main(String[] args) {


    System.out.println("completed");
  }
}
