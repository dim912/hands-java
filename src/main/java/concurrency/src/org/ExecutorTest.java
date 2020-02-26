package org;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

/**
 * Executor interface has one method as execute.
 * Executors decouple business logic from executing logic. (manage threads separate)
 *
 *
 *
 * Note
 * ThredPoolExecutor(20,2000) : in ThreadPoolExecutor maximum and minimum number of thread can be set.
 *
 * Excutor is a way of managing threads organizely
 * */
public class ExecutorTest { //Executor service is introduced in java 5.

    /**Thread factory is optional in Executors.
     * ThreadFactory is an API.
     * If threads are to be created in a managedWay, threadFactories can be used, when creating the Executor service.(No other use)
     * ExecutorService is the main concept here (Not ThreadFactory)
     *
     * executorService.execute => does not retun any.
     * executoreService.submit => retun future
     *
     * */
    static ThreadFactory myThreadFacotry = new ManagedThreadFacotry();

    /**Executors is a factory class*/
    static ExecutorService executorService = Executors.newFixedThreadPool(3,myThreadFacotry); // newFixedThreadPool internally return a ThreadPoolExecutor

    /**cachedThreadPool creates new threads as required and reuse*/
    //static ExecutorService executorService = Executors.newCachedThreadPool();
    //newScheduledThreadPool => execute tasks after a given delay

    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            executorService.execute(new HttpReq(Integer.toString(i)));

        }
        /**once the shutdown() is called => No new tasks will be accepted
         * thread pool will be shout down once all submited tasks are completed.
         * */
        executorService.shutdown();
    }

}

class HttpReq implements Runnable {

    String messsage;

    public HttpReq(String messsage) {
        this.messsage = messsage;
    }

    @Override
    public void run() {
        System.out.println(Thread.currentThread().toString() + ": " + "processing HTTP message : " + messsage);
        try {
            Thread.sleep(2000L);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}

class ManagedThreadFacotry implements ThreadFactory {
    @Override
    public Thread newThread(Runnable r) {
        Thread t = new Thread(r);
        t.setName("createdThrough ManagedThreadFactory");
        return t;
    }
}