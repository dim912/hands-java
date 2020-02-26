package algorithms.dictionaryAndMapps;

import java.io.*;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import static java.util.stream.Collectors.toList;

public class CountTriplets{

    static long countTriplets(List<Long> arr, long r) {

        Map<Long, Long> counts = new LinkedHashMap<>(); //keep the insertion order untouched

        //pre processing stage
        long current = -1;
        long currentCount = 0;

        for(int i = 0 ; i< arr.size() ; i++){ //count the occurences of each number

            if(arr.get(i) == current){
                currentCount ++ ;
            }
            else{
                if(current>0){
                    counts.put(current, currentCount);
                }
                current = arr.get(i);
                currentCount = 1;
            }

            //coner case for the last element of the array
            if(i == arr.size()-1){
                counts.put(current, currentCount > 0 ? currentCount : 1);
            }
        }

        //calculation => SUM  ( number of occurences(NO) 1 * NO 2 * NO 3 ) for all n > 2
        //go though the counts to get the total
        int index = 0;
        Map.Entry<Long,Long> doublePrevious = null;
        Map.Entry<Long,Long>  previous = null;
        long count = 0;
        for(Map.Entry<Long, Long> entry : counts.entrySet()){

            System.out.println(entry.getKey() + ":" + entry.getValue());

            if(index>=2){
                long currentVal = entry.getKey() ;
                long doublePreVal = doublePrevious.getKey() ;
                long preVal = previous.getKey() ;
                if(doublePreVal * r ==preVal && preVal * r == currentVal){
                    count += entry.getValue() * doublePrevious.getValue() * previous.getValue();
                }
            }
            doublePrevious = previous;
            previous = entry;
            index++;
        }

        return count;


    }

    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter("result"));

        String[] nr = bufferedReader.readLine().replaceAll("\\s+$", "").split(" ");

        int n = Integer.parseInt(nr[0]);

        long r = Long.parseLong(nr[1]);

        List<Long> arr = Stream.of(bufferedReader.readLine().replaceAll("\\s+$", "").split(" "))
                .map(Long::parseLong)
                .collect(toList());

        long ans = countTriplets(arr, r);

        bufferedWriter.write(String.valueOf(ans));
        bufferedWriter.newLine();

        bufferedReader.close();
        bufferedWriter.close();
    }
}

/**
 *You are given an array and you need to find number of tripets of indices  such that the elements at those indices are in geometric progression for a given common ratio  and .
 *
 * For example, . If , we have  and  at indices  and .
 *
 * Function Description
 *
 * Complete the countTriplets function in the editor below. It should return the number of triplets forming a geometric progression for a given  as an integer.
 *
 * countTriplets has the following parameter(s):
 *
 * arr: an array of integers
 * r: an integer, the common ratio
 * Input Format
 *
 * The first line contains two space-separated integers  and , the size of  and the common ratio.
 * The next line contains  space-seperated integers .
 *
 * Constraints
 *
 * Output Format
 *
 * Return the count of triplets that form a geometric progression.
 *
 * Sample Input 0
 *
 * 4 2
 * 1 2 2 4
 * Sample Output 0
 *
 * 2
 * Explanation 0
 *
 * There are  triplets in satisfying our criteria, whose indices are  and
 *
 * Sample Input 1
 *
 * 6 3
 * 1 3 9 9 27 81
 * Sample Output 1
 *
 * 6
 * Explanation 1
 *
 * The triplets satisfying are index , , , ,  and .
 *
 * Sample Input 2
 *
 * 5 5
 * 1 5 5 25 125
 * Sample Output 2
 *
 * 4
 * Explanation 2
 *
 * The triplets satisfying are index , , , .
 *
 */
