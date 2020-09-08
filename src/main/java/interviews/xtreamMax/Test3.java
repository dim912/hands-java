package interviews.xtreamMax;


class Solution3 {

  int solution(int[] A, int X) {

    int N = A.length;
    if (N == 0) { //If no elements => then -1
      return -1;
    }
    int l = 0; //first index
    int r = N - 1; //last index

    while (l < r) {
      int m = (l + r) / 2; //middle
     if(A[m]==X) {
       return m;
     }
      else if (A[m] > X) { //X point is passed
        r = m - 1; //come to left
      } else { //take from m onwards
        l = m;
      }
    }
    return -1;
  }
}


public class Test3 {

  public static void main(String[] args) {

    Solution3 solution3 = new Solution3();

    int[] input = {1, 3, 5, 6, 10 };

    System.out.println(solution3.solution(input, 1));
  }
}

// Test Cases

/*

{1,3,4,5,10},   5
{1,3,5,6,10},   5

{1,3,4,5,10, 12}, 5
{1,3,5,6,10, 12}, 5

{1,4,5,10, 12} , 1
{1,3,6,10, 12}, 12

{1,3,4,5,10, 12} , 1
{1,3,5,6,10, 12}, 12

* */
