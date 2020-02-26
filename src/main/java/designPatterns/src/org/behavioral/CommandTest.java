package org.behavioral;

/**
 * Command Object
 * --------------
 * Encapsulate a request to be treated as an object and decouple requester to decouple from task executor
 * -> this allowed the request to be handled in OOP way (queue and callback)
 *
 * used when
 * 1) need callback functionality
 * 2) request processing take varient time and order
 * 3) invoker is decoupled from object handling the invocation
 *
 * Command Patten forward request to a specific module (Chain of request forward to a chain)
 *
 * Ex:  waiter gets the order(command) and then queued for the kitchen staff
 *
 * Gives a unified, homogeneous and standard way of executing operations
 *
 * java.lang.Runnable is an implementation for Command Design pattern
 *
 * */

public class CommandTest {

    public static void main(String[] a){

        Light light = new Light();
        LightOnCommand lightOnCommand = new LightOnCommand(light);
        LightOffCommand lightOffCommand = new LightOffCommand(light);

        Switch lightSwitch = new Switch(lightOnCommand,lightOffCommand);
        lightSwitch.on();
        lightSwitch.off();

        Fan fan = new Fan();
        FanOnCommand fanOnCommand = new FanOnCommand(fan);
        FanOffCommand fanOffCommand = new FanOffCommand(fan);

        Switch fanSwitch = new Switch(fanOnCommand,fanOffCommand);
        fanSwitch.on();
        fanSwitch.off();

    }



}

class Fan{
    public void startRotate(){
        System.out.println("Fan is Roatating");
    }

    public void stopRotate(){
        System.out.println("Fan is not Roatating");
    }
}

class Light{
    public void turnOn(){
        System.out.println("Light is ON");
    }

    public void turnOff(){
        System.out.println("Light is OFF");
    }
}

@FunctionalInterface
interface Command{
    void execute();
}

/**light command hide the complexity of switching on a Light and expose the execute method. Operations are wrapped in Command class*/
class LightOnCommand implements Command{
    private Light light;
    public LightOnCommand(Light light) {
        this.light = light;
    }
    @Override
    public void execute() {
        light.turnOn();
    }
}

class LightOffCommand implements Command{
    private Light light;
    public LightOffCommand(Light light) {
        this.light = light;
    }
    @Override
    public void execute() {
        light.turnOff();
    }
}

class FanOnCommand implements Command{
    private Fan fan;
    public FanOnCommand(Fan fan) {
        this.fan = fan;
    }
    @Override
    public void execute() {
        fan.startRotate();
    }
}

class FanOffCommand implements Command{
    private Fan fan;
    public FanOffCommand(Fan fan) {
        this.fan = fan;
    }
    @Override
    public void execute() {
        fan.stopRotate();
    }
}

//sender. Completely decoupled from receiver(Fan and Light)

class Switch{ //has no knoledge about receivers interfaces

    private Command upCommand;
    private Command downDomand;
    public Switch(Command upCommand, Command downDomand) {
        this.upCommand = upCommand;
        this.downDomand = downDomand;
    }
    public void on(){
        upCommand.execute();
    }
    public void off(){
        downDomand.execute();
    }
}











