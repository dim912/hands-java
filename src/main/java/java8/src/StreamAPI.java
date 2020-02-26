import java.util.Arrays;
import java.util.List;

/**
 * Created by dsenanayaka on 8/15/2017.
 */
public class StreamAPI {

    //to process data in a declarative way, like SQL
    //get use of multipel processors avilable, with out hardto manage Threads/Runnables.
    //Steam is a : squence of Objets from a source, which supports aggreate functions
    //streams works ondemand. Do not store anything
    //Collections, Arrays, I/O can be streamized
    //aggregate operations => filter, map, limit, reduce, find, match....etc
    //piplelining is avialbels.
    //iterations are automatic. No need to do outside

    //to get a stream => stream(), parallelStream() can be used.

    public static void main(String[] args) {
        List<String> strings = Arrays.asList("1", "2", "3", "7", "0", "4", "6");

        strings.stream().sorted().forEach(System.out::println);

    }



}
