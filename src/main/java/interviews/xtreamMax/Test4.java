package interviews.xtreamMax;


class Solution4 {

  public static int count  = 0;

  public int solution(Tree T) {

    if(T==null){
      return 0;
    }
    else{
      count = 1;
      checkVisible(T,T.x);
    }

    return count;

  }

  void checkVisible(Tree T,int  maxVal){

    if(T==null){
      return;
    }

    if(T.x > maxVal){ //update the max value of the path
      maxVal = T.x;
    }
    else{
        count++;
    }
    checkVisible(T.l, maxVal);
    checkVisible(T.l, maxVal);
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
