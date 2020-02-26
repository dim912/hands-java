package org.behavioral;

/**
 * Denies a Stub/skeleton for an algorithem (sequence of steps)
 * <p>
 * Used when, two or more similar algorithem exist
 * <p>
 * subclasses redefine some steps of the algorithem without changing the structure of the algo
 * <p>
 * Abstract class -> contains the final templateMethod (which can not be modified by subclasses)
 *
 * Template Method follows => Do not call us, We will call you principle.
 *
 * Template method controls the overall process calling abstract methods (implemented at the child class)
 *
 *
 * Use when
 * 1) Behaviour of an algorithem can be vary
 * 2) Avoid code duplication
 * 3) When two or more classes are apperently doing same structure of work
 * 4) When the Sub classes should be forced to follow a pattern.
 *
 */
public class TemplateMethodTest {

    public static void main(String[] args) {
        TemplateJob job = new MyJob();
        job.execute();
    }

    //can have
    //concrete utility methods
    //abstract methods
    //Hook methods -> which containing a default implementation
    //template methods -> which call above methods
}

abstract class TemplateJob {

    /*implementations of below methods will be coming from child classes */
    abstract void prepare();

    abstract void process();

    abstract void clear();

    /*access modifier is default. Then only the same package classes can call execute(). This is to implement I will call you, do not call me from child classes in other packages*/
    final void execute() {
        prepare();
        process();
        clear();
    }

}

class MyJob extends TemplateJob {

    @Override
    void prepare() {
        System.out.println("prepare");
    }

    @Override
    void process() {
        System.out.println("process");
    }

    @Override
    void clear() {
        System.out.println("clear");
    }
}


