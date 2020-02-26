package org.behavioral;

import java.util.ArrayList;
import java.util.List;

/**
 * Allow one/more distinct operations to be applied on ore/more structure of objects at run time
 * Decouple operations from object structure. (Clean code)
 * <p>
 * Use When
 * --------
 * <p>
 * 1) An Object structure has many unrelated operations
 * 2) Structure is constant and has many different operations
 * 3) Exposing object structure and internal state is acceptable
 * 4) Can add additional functionality to a class without change it
 * <p>
 * Visitor class use data that are in other class
 *
 * Note : Stratergy vs Visitor
 *
 * Visior pattern does not maintain a instance level reference variable to Visitor as Stratergy do.
 *
 * Visitor is considered as a many to many pattern. But stratergy is one to Many.
 * Visitor pattern keeps the same operations of multiple objects in a single location.
 *
 */


public class VisitorTest {

    public static void main(String[] args) {
        List<Visitable> goods = new ArrayList<>();
        Book b = new Book(1, 5);
        goods.add(b);

        ShoppingCart shoppingCart = new ShoppingCart(goods);
        double postalCharge = shoppingCart.calculatePostage();
        System.out.println("Postal Charge : " + postalCharge);

    }
}

interface Visitor {
    void visit(Book b);
    void visit(CD c);
}

class PostageVisitor implements Visitor {

    private double postageCost;

    @Override
    public void visit(Book e) {
        if (e.getPrice() < 10.0) {
            postageCost += e.getWeight() * 2 / 100;
        }
    }

    @Override
    public void visit(CD c) {
    }

    public double getPostageCost() {
        return postageCost;
    }

    public void setPostageCost(double postageCost) {
        this.postageCost = postageCost;
    }
}


interface Visitable {
    void accept(Visitor v);
}

class Book implements Visitable {

    private double weight;
    private double price;

    public Book(double weight, double price) {
        this.weight = weight;
        this.price = price;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public void accept(Visitor v) { //passing self to the visitor visit method.
        v.visit(this);
    }
}


class CD implements Visitable {

    @Override
    public void accept(Visitor v) {

    }
}


class ShoppingCart {
    private List<Visitable> goods;

    public ShoppingCart(List<Visitable> goods) {
        this.goods = goods;
    }

    public double calculatePostage() {
        PostageVisitor postageVisitor = new PostageVisitor();
        goods.forEach(good -> good.accept(postageVisitor));
        return postageVisitor.getPostageCost();
    }
}