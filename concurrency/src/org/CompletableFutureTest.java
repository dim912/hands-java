package org;


import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * java 8 CompletableFuture extends Future and CompletionStage APIs
 * <p>
 * Java 5 Future class did not had any way to combine Futures, without blocking.
 * <p>
 * CompletableFutures can be manually set completed or exceptionally completed.
 * Can Chain actions without blocking
 * Can combine multiple futures
 * <p>
 * Unlike Futures, completableFutures provides a way to create asyn, sync, chaining easily implementing CompletionStage API
 * ,Before executors, callbales, runnables were needed. (Anyway CompletableFuture can be used as Java 5 future since it extends Future interface)
 * <p>
 * Creating new async task
 * -----------------------
 * CompletionStage<Void> CompletableFuture.runAsync(Runnable)
 * CompletionStage<T> CompletableFuture.supplyAsync(Supplier<T>)
 * <p>
 * abcAsync method always gets a new thread from ForkJoin pool
 * <p>
 * thenApply => methods expects Function<R,T> as an input and returns CompletableFuture<T>
 * <p>
 * waiting for multiple futures Futures //monadic design pattern(functional way) -> combining also returns completable futures wi
 * ---------------------------------
 * <p>
 * If no return value is needed from the combined future => use thenAcceptBoth (CompletionStage, BiConsumer);
 * If a reutrn value is needed => use Combine(CompletionStage, BiFunction)
 * <p>
 * Use CompletableFuture.allOf(completableFuture1,completableFuture12) . //This method retuns a VOID completableFuture. this is a limitaiton
 * <p>
 * Stream.of(worldF,isF,beautyF).map(CompletableFuture::join).collect(Collectors.joining(" "));
 */

public class CompletableFutureTest {

    public static void main(String[] args) {

        try {
            //Ex 1
            CompletableFuture<String> completableFuture = new CompletableFuture<>();
            completableFuture.complete("Hello");
            System.out.println(completableFuture.get());

            //Ex2
            Service.asyncMethod().get();
            System.out.println("AsyncMethod is done");

            //Ex3
            CompletableFuture<Void> asynRun = CompletableFuture.runAsync(() -> System.out.println("yo")); //Runnable is provided
            CompletableFuture<String> asyncSupply = CompletableFuture.supplyAsync(() -> "yo"); //Supplier is provided

            //Ex4 - Chaining
            System.out.println(CompletableFuture.supplyAsync(() -> "Hello").thenApplyAsync(s -> s + " World").get());

            //Ex5 - Combinning futurs
            CompletionStage worldStage = CompletableFuture.completedFuture("world");
            //Hellow supplier runs paralled with world supplier. When both finish BiFunction runs
            CompletableFuture.supplyAsync(() -> "Hello").thenCombine(worldStage, (p, q) -> p + q).toCompletableFuture().get();

            //Ex6 - waiting for multiple futures to finish
            // allOf method only returns a VOID completable Future. So can only wait,get to know all the futures are completed. This is a limitation
            CompletableFuture.allOf(worldStage.toCompletableFuture(), worldStage.toCompletableFuture());

            CompletableFuture<String> worldF = CompletableFuture.completedFuture("World");
            CompletableFuture<String> isF = CompletableFuture.completedFuture("World");
            CompletableFuture<String> beautyF = CompletableFuture.completedFuture("World");

            //Ex7 : join() method is same as the get method. But it throw only un checked exceptions.
            //so it can be used as a method reference.  And can collect the results
            Stream.of(worldF, isF, beautyF).map(CompletableFuture::join).collect(Collectors.joining(" "));

            String name = null;

            //Ex8 - Error handling . To avoid ExecutionException when a Runtime error happen
            //use completableFuture.hendle function to retun a defalult value when the execution throuws an runtime Exception
            CompletableFuture<String> f = CompletableFuture.supplyAsync(() -> {
                if (name == null) {
                    throw new RuntimeException("Computation error!");
                }
                return "Hello, " + name;
            }).handle((result, throwable) -> result != null ? result : "Hello, Stranger!"); //result of the computation and throwable is passed to handle function


            //If the wrapping method return with an exception -> future still surview with the default value, not throwing excecution exception.
            CompletableFuture f2 = CompletableFuture.supplyAsync(() -> {
                throw new RuntimeException("RunTimeError");
            }).handle((s, t) -> "Nice");
            System.out.println(f2.get());

        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace(


            );
        }

    }
}


class Service {

    public static Future<String> asyncMethod() {
        CompletableFuture<String> future = new CompletableFuture<>();
        future.complete("done"); // CompletableFuture.completedFuture("");
        return future;
    }

}