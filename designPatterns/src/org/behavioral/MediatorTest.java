package org.behavioral;

import java.util.ArrayList;
import java.util.List;

/**
 * Used to handle complex communication among related objects, while de coupling(loose coupling) those objects
 *
 * Ex : Airport control  => planes do not communicate directly, but through control tower.
 *
 * Encapsulate the way set of objects interact/communicate
 *
 * 1) Mediator -> define the interface for communication between colleague objects
 * 2) Colleague -> comounicates with other colleague objects through Mediator. But do not know others directly(de coupled).
 *
 * * Colleague communication can be controlled and monitored at mediator.
 *
 * * use when object communication is complicated but well defined. Ex: JMS - Java Message Service - Subscribe and Push model
 *
 * */

public class MediatorTest {

    public static void main(String[] args){

        Mediator m = new MediatorImpl();

        AbstractAirVehicle boying =  new Plane("boying");
        boying.setMediator(m);

        AbstractAirVehicle airBus  = new Plane("airBus");
        airBus.setMediator(m);

        AbstractAirVehicle helicop  = new Helicoptor("helicop");
        helicop.setMediator(m);

        ((MediatorImpl)m).addColleague(boying);
        ((MediatorImpl)m).addColleague(airBus);
        ((MediatorImpl)m).addColleague(helicop);

        boying.send("I am going to land");
        helicop.send("I am going to take off");

    }
}

//this is the Colleague interface which send and receive messages from other Colleaues
interface AirVehicle {
    void send(String message);
    void receive(String message, AirVehicle sender);
}

interface Mediator {
    void send(String message, AirVehicle sender);
}

//Mediator implementation which keep maintain the Colleges list to which the messages should be distributed
//this has the centralized control and monitoring
class MediatorImpl implements  Mediator{

    private List<AirVehicle> colleagueList = new ArrayList<>();

    @Override
    public void send(String message, AirVehicle sender) {
        colleagueList.stream().filter(c->c!=sender).forEach(v->v.receive(message, sender));
    }

    public void addColleague(AirVehicle airVehicle){
        colleagueList.add(airVehicle);
    }
}

//Colleague implementation. This has a reference to mediator. But not to other Colleague.
abstract class AbstractAirVehicle implements AirVehicle {
    Mediator mediator;
    protected String name;

    @Override
    public void receive(String message, AirVehicle sender) {
        System.out.println(this.toString() +" Received : " + message+" - from : " +  sender.toString());
    }

    public Mediator getMediator() {
        return mediator;
    }

    public void setMediator(Mediator mediator) {
        this.mediator = mediator;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}

class Plane extends AbstractAirVehicle{

    public Plane(String name) {
        super.name = name;
    }

    @Override
    public void send(String message) {
        mediator.send("Plane" + getName() + ":" + message , this);
    }
}

class Helicoptor extends AbstractAirVehicle{

    public Helicoptor(String name) {
        super.name = name;
    }

    @Override
    public void send(String message) {
        mediator.send("Helicoptor"  +getName()+ ":" + message , this);
    }
}



