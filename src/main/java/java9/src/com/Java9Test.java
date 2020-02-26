package com;

import java.util.List;

public class Java9Test {

    public static void main(String[] args){
        //factory methods for immutable collections
        List<String> list = List.of("1","2");
        list.add("3");
        list.stream().forEach(System.out::print);
    }
}
