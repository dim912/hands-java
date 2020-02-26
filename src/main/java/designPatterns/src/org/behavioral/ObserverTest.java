package org.behavioral;
import java.util.ArrayList;
import java.util.List;

/**
 * Implements the one to many way of message passing => when the state of observable is changed. (Like broadcasting)
 *
 * . Java has Observerbale class and Observer interface for this design pattern in mind
 *
 * Observable does not couple with the observers. But deal through an interface.
 *
 * can be used to implement => subscribe / publish model.
 *
 * Used in UI development. Ex : Swing listners for an UI Button.
 *
 * DownSide : May cause to memory leaks if forget to remove the observers from observerList.
 *
 *
 * */

public class ObserverTest {

    public static void main(String[] agrs){

        Item shirt = new Item(); shirt.setItemName("Shirt");
        Customer cust1 = new Customer(); cust1.setName("Cust1");
        Customer cust2 = new Customer(); cust2.setName("Cust2");

        shirt.addObserver(cust1);
        shirt.addObserver(cust2);

        shirt.notifyObservers("Price reduced to 21");

    }
}

interface  Observer{
    void update(Observable observable, Object message);
}

interface  Observable{
    void addObserver(Observer observer);
    void removeObserver(Observer observer);
    void notifyObservers(Object message);
}

class Item implements  Observable{

    private String itemName;

    List<Observer> observerList = new ArrayList<>();

    @Override
    public void addObserver(Observer observer) {
        if(!observerList.contains(observer)){
            observerList.add(observer);
        }
    }

    @Override
    public void removeObserver(Observer observer) {
        observerList.remove(observer);
    }

    @Override
    public void notifyObservers(Object message) {
        observerList.forEach(o-> o.update(this,message));
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }


    @Override
    public String toString() {
        return itemName;
    }
}

class Customer implements  Observer {

    private String name;

    @Override
    public void update(Observable observable, Object message) {
        System.out.println("Got notified from : " +  observable.toString() + " : "  + message.toString());
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}