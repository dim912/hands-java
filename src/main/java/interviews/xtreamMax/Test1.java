package interviews.xtreamMax;


class Solution1 {
  public String solution(String S) {

    StringBuilder result = new StringBuilder();

    //split  words to an arry
    String[] words = S.split(" ");

    for (int i = 0; i < words.length; i++) {

      String word = words[i];

      char[] wordChars = word.toCharArray();
      for (int j = 0; j < wordChars.length; j++) {  //reverse word

        if (j >= wordChars.length - 1 - j) { // all letters are reversed now
          break;
        }

        char temp = wordChars[j];
        wordChars[j] = wordChars[wordChars.length - 1 - j];
        wordChars[wordChars.length - 1 - j] = temp;
      }
      result.append(wordChars);

      if (i < words.length - 1) { //last word does not need a space after it
        result.append(" ");
      }
    }

    return result.toString();
  }
}

public class Test1 {

  public static void main(String[] args) {

    Solution1 solution = new Solution1();

    String input = "we test coders";

    String res = solution.solution(input);

    System.out.println("-" + res  + "-");
  }
}
