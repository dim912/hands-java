package org.behavioral;

/**
 * Ties objects behaviour to its internal state => Helps to avoid conditional statemetns
 *
 * Used When
 * 1) Behaviour of an object is influenced by its state
 * 2) Complex condition ties with objects behaviour
 *
 * Ex:  method of an email object
 *          a. Send email if the email is not yet sent
 *          b. If already sent do nothing or throw an exception
 *          c. If not connected to network -> do bla bla bla...
 *          4. If not delivered and If revert method is called -> delete from unread receivers
 *
 *Vending machine -> behave differently based on change availability, stock availability
 *
 * Citizens
 * --------
 * 1) State
 * 2) Context -> Has the state reference
 *
 *
 * Advantages
 *
 * 1) implement polymorpic behaviour without complex if-else ladder
 * 2) easy to add more status
 *
 * */

//Ex : Single ON / OFF button TV
public class StateTest {

    public static void main(String[] args){
        TvContext tvRemote = new TvContext(new OffState());
        tvRemote.doAction(null);
        tvRemote.doAction(null);
        tvRemote.doAction(null);
        tvRemote.doAction(null);

    }
}

interface State {
    void doAction(TvContext tvContext);
}


/**State reference is maintained at the Context object and gets dynamically change at run time. and Context object called the changed State object
 * which has the desired implementation */
class TvContext implements State{

    private  State state;

    public TvContext(State state) {
        this.state = state;
    }

    public State getState() {
        return state;
    }
    public void setState(State state) {
        this.state = state;
    }
    @Override
    public void doAction(TvContext tvContext) {
        state.doAction(this);
    }
}

class OnState implements State {
    @Override
    public void doAction(TvContext tvContext) {
        System.out.println("TV went OFF");
        tvContext.setState(new OffState());
    }
}

class OffState implements State {
    @Override
    public void doAction(TvContext tvContext) {
        System.out.println("TV got ON");
        tvContext.setState(new OnState());

    }
}


