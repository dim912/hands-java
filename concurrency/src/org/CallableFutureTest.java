package org;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

/**
 * java.util.concurrent is introduced in java 5. Thread and Runnable was avilable from before in java.lang package
 *
 *  Unlike Runnable : callables can return values and exceptions to caller.
 *
 *
 * Futures support
 * 1) get() : V  , get(timeOut)  the wrapping result. ExecutionException (this exception wrapps underlaying processing exception). InterruptedException(if the thread is interuupted)
 * 2) isDone() whether completed
 * 3) cancel(boolean interruptRunningTask),
 * 4) isCanclled()
 *
 *
 * Future : Represent the value of a asynchronous computation
 *
 * when a future is canclled CancellationException RuntimeException is thrown.
 *
 */
public class CallableFutureTest {

    public static void main(String[] args) {

        int numberOfThreads = 1;

        long startTime = System.currentTimeMillis() ;
        ExecutorService es = Executors.newFixedThreadPool(5);

        //completion service return the futures in the order of completion.
        CompletionService<Long> cs = new ExecutorCompletionService(es);

        long start = 0;
        long end = 100000000;
        long total = 0;

        List<Future<Long>> sumsFuture = new ArrayList<>();

        for (int i = 0; i < numberOfThreads; i++) {
            sumsFuture.add(es.submit(new Adder(start, (end / numberOfThreads) * (i + 1))));
            start = (end / numberOfThreads) * (i + 1) + 1;
         //   sumsFuture.add(cs.submit(new Adder(start, (end / numberOfThreads) * (i + 1))));
        }

        total = sumsFuture.stream().mapToLong(f -> {
            try {
                return cs.take().get(); //retuns in the order of finishing the tasks
                //f.cancel(true); //to simulate CancellationException
                //return f.get(); //return in the order of calling the tasks
            } catch (InterruptedException e) {
                e.printStackTrace();
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
            return 0;
        }).sum();
        long endTime = System.currentTimeMillis() ;

        System.out.println((endTime-startTime)+ ": " + total);
    }
}

class Adder implements Callable<Long> {
    long start;
    long end;
    public Adder(long start, long end) {
        this.start = start;
        this.end = end;
    }
    @Override
    public Long call() throws Exception {
        Thread.sleep(1000);
        int total = 0;
        for (long i = start; i <= end; i++) {
            total += i;
        }
        return new Long(total);
    }
}