package algorithms.dictionaryAndMapps;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

/**
 * logic, If I wants to search anything in a collection faster manner multiple times
 *
 * => Then I should index those data
 *
 * => So, load data to an array based colleciton => To a HashMap or a HashSet helps
 *
 * */

public class TwoStrings{

    /**
     * Time complexity => O ( m + n ). The brute force approach is m * n
     *
     * */

    // Complete the twoStrings function below.
    static String twoStringsSol(String s1, String s2) {

        char[]  longArr;
        char[]  shortArr;

        if(s1.length() >s2.length()){
            longArr = s1.toCharArray();
            shortArr = s2.toCharArray();
        }
        else{
            shortArr= s1.toCharArray();
            longArr= s2.toCharArray();
        }

        //load long array to a HashSet

        Set<Character>  longSet = new HashSet<>();

        for(int i=0 ; i< longArr.length ; i++){
            longSet.add(longArr[i]);
        }


        for(int i =0 ; i< shortArr.length ; i++){
            if(longSet.contains(shortArr[i])){
                System.out.println("YES");
                return "YES";
            }
        }
        System.out.println("NO");
        return "NO";
    }

    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws IOException {
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter("result"));

        int q = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

        for (int qItr = 0; qItr < q; qItr++) {
            String s1 = scanner.nextLine();

            String s2 = scanner.nextLine();

            String result = twoStringsSol(s1, s2);

            bufferedWriter.write(result);
            bufferedWriter.newLine();
        }

        bufferedWriter.close();

        scanner.close();
    }
}

/**
 * Given two strings, determine if they share a common substring. A substring may be as small as one character.
 *
 * For example, the words "a", "and", "art" share the common substring . The words "be" and "cat" do not share a substring.
 *
 * Function Description
 *
 * Complete the function twoStrings in the editor below. It should return a string, either YES or NO based on whether the strings share a common substring.
 *
 * twoStrings has the following parameter(s):
 *
 * s1, s2: two strings to analyze .
 * Input Format
 *
 * The first line contains a single integer , the number of test cases.
 *
 * The following  pairs of lines are as follows:
 *
 * The first line contains string .
 * The second line contains string .
 * Constraints
 *
 *  and  consist of characters in the range ascii[a-z].
 * Output Format
 *
 * For each pair of strings, return YES or NO.
 *
 * Sample Input
 *
 * 2
 * hello
 * world
 * hi
 * world
 * Sample Output
 *
 * YES
 * NO
 * Explanation
 *
 * We have  pairs to check:
 *
 * , . The substrings  and  are common to both strings.
 * , .  and  share no common substrings.
 *
 * */
