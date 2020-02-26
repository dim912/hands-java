package org.behavioral;

import java.io.File;

/**
 * Used for Changing the behaviour of an object run time, without tight coupling
 *
 * Defines a set of Encapsulated algorithems that can be swapped to carry out specific behaviour
 * Similar with State Patten. But different use case. (State pattern is mostly Finite State Machine based behaviour changes)
 *
 * Different stratergies will have its own classes, which is clear in coding.
 *
 * Citizens
 * 1) Strategy Interface
 * 2) Strategy implementations
 * 3) Strategy Context
 *
 * */
public class StrategyTest {

    public  static void main(String[] args){

        CompressContext compressContext = new CompressContext();
        //compress Rar File
        compressContext.setCompress(new RarCompress());
        compressContext.compress(null);
        //compress Zip file.
        compressContext.setCompress(new ZipCompress());
        compressContext.compress(null);

    }
}

@FunctionalInterface
interface Compress{
    void compress(File file);
}

//differnet implementation of the same functionality/algorithem
class RarCompress implements Compress{
    @Override
    public void compress(File file) {
        System.out.println("compress Rar");
    }
}


class ZipCompress implements Compress{
    @Override
    public void compress(File file) {
        System.out.println("compress Zip");
    }
}

//context class.
class CompressContext implements  Compress{
    Compress compress;
    @Override
    public void compress(File file) { //determining which Stratergy to call can be written here.
        compress.compress(file);
    }

    public Compress getCompress() {
        return compress;
    }

    public void setCompress(Compress compress) {
        this.compress = compress;
    }
}