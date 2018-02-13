package org;

import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;

/**
 * Future task is the basic implementation of Future interface (which has get, cancle, isDone,isCancle methods). It implements Runnable also(can run through Thread
 * Or Executor)
 *
 * FutureTask provides a way to run a Callable without a executor service. (This is using thread class)
 *
 * FutureTask wraps a Callable to a Runnable with a features of Futures. (it allow the callable to run by Thread.start())
 *
 * FutureTask can wrap a Runnable and give a future same as executor.submit(Runnable). But run on a primary thread reated by ThreadClass.
 *
 */
public class FutureTaskTest {
    public static void main(String[] args) {

        FutureTask<String> f = new FutureTask<>(new Callable<String>() {
            public String call() throws Exception {
                Thread.sleep(10000);
                System.out.println("returned from a new Thread");
                return "returned from a new Thread";
            }
        });
        new Thread(f).start();
        System.out.println("exit");
    }
}
