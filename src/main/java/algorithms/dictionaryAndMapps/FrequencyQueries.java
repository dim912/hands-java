package algorithms.dictionaryAndMapps;

import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;
import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;

/**
 * two hashmaps are needed since there are two searchables
 *
 * */

public class  FrequencyQueries{

    // Complete the freqQuery function below.
    static List<Integer> freqQuery(List<List<Integer>> queries) {

        Map<Integer, Integer> counts = new HashMap<>();
        Map<Integer, Integer> freq = new HashMap<>();

        List<Integer> output = new ArrayList<>();

        queries.forEach(query->{

            Integer operation = query.get(0);;
            Integer operand = query.get(1);;

            if(operation== 1){
                Integer existing = counts.putIfAbsent(operand, 1);
                if(existing != null){
                    freq.put(existing, freq.get(existing)-1);
                    counts.put(operand, existing+1);
                    Integer existingFreq = freq.putIfAbsent(existing + 1, freq.get(existing) + 1);
                    if(existingFreq !=null){
                        freq.put(existing+1, freq.get(existing+1)+1);
                    }
                }
                else{
                    Integer existingFreq = freq.putIfAbsent(1, 1);
                    if(existingFreq !=null){
                        freq.put(1, freq.get(1)+1);
                    }
                }
            }
            else if(operation == 2){
                Integer existing = counts.get(operand);
                if(existing != null){
                    freq.put(existing, freq.get(existing)-1);
                    Integer newCount = existing > 0 ? existing-1 : 0;
                    Integer existingFreq = freq.putIfAbsent(newCount, freq.get(existing) + 1);
                    if(existingFreq !=null){
                        freq.put(newCount, freq.get(newCount)+1);
                    }
                    counts.put(operand, existing > 0 ? existing -1 : 0);
                }
            }
            else if (operation== 3){
                Integer existing = freq.get(operand);
                if(existing != null &&  existing > 0){
                    output.add(1);
                }
                else{
                    output.add(0);
                }
            }
        });
        return output;
    }

    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter("result"));

        int q = Integer.parseInt(bufferedReader.readLine().trim());

        List<List<Integer>> queries = new ArrayList<>();

        IntStream.range(0, q).forEach(i -> {
            try {
                queries.add(
                        Stream.of(bufferedReader.readLine().replaceAll("\\s+$", "").split(" "))
                                .map(Integer::parseInt)
                                .collect(toList())
                );
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        });

        List<Integer> ans = freqQuery(queries);

        bufferedWriter.write(
                ans.stream()
                        .map(Object::toString)
                        .collect(joining("\n"))
                        + "\n"
        );

        bufferedReader.close();
        bufferedWriter.close();
    }
}

/**
 * You are given queries. Each query is of the form two integers described below: - : Insert x in
 * your data structure. - : Delete one occurence of y from your data structure, if present. - :
 * Check if any integer is present whose frequency is exactly . If yes, print 1 else 0.
 *
 * <p>The queries are given in the form of a 2-D array of size where contains the operation, and
 * contains the data element. For example, you are given array . The results of each operation are:
 *
 * <p>Operation Array Output (1,1) [1] (2,2) [1] (3,2) 0 (1,1) [1,1] (1,1) [1,1,1] (2,1) [1,1] (3,2)
 * 1 Return an array with the output: .
 *
 * <p>Function Description
 *
 * <p>Complete the freqQuery function in the editor below. It must return an array of integers where
 * each element is a if there is at least one element value with the queried number of occurrences
 * in the current array, or 0 if there is not.
 *
 * <p>freqQuery has the following parameter(s):
 *
 * <p>queries: a 2-d array of integers Input Format
 *
 * <p>The first line contains of an integer , the number of queries. Each of the next lines contains
 * two integers denoting the 2-d array .
 *
 * <p>Constraints
 *
 * <p>All Output Format
 *
 * <p>Return an integer array consisting of all the outputs of queries of type .
 *
 * <p>Sample Input 0
 *
 * <p>8 1 5 1 6 3 2 1 10 1 10 1 6 2 5 3 2 Sample Output 0
 *
 * <p>0 1 Explanation 0
 *
 * <p>For the first query of type , there is no integer whose frequency is (). So answer is . For
 * the second query of type , there are two integers in whose frequency is (integers = and ). So,
 * the answer is .
 *
 * <p>Sample Input 1
 *
 * <p>4 3 4 2 1003 1 16 3 1 Sample Output 1
 *
 * <p>0 1 Explanation 1
 *
 * <p>For the first query of type , there is no integer of frequency . The answer is . For the
 * second query of type , there is one integer, of frequency so the answer is .
 *
 * <p>Sample Input 2
 *
 * <p>10 1 3 2 3 3 2 1 4 1 5 1 5 1 4 3 2 2 4 3 2 Sample Output 2
 *
 * <p>0 1 1 Explanation 2
 *
 * <p>When the first output query is run, the array is empty. We insert two 's and two 's before the
 * second output query, so there are two instances of elements occurring twice. We delete a and run
 * the same query. Now only the instances of satisfy the query.
 */
