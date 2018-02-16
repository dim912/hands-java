
/**
 * Decouple messages from the receivers which should handle it.
 * Allow MULTIPLE handlers/objects to handle same messages by linking handlers, and handlers are not known prior.
 * Handlers for a message determined at runtime
 *
 *  Ex : Filters in servlets
 *
 * */

package org.behavioral;

public class ChainOfResponsibilityTest {

    static LoginFilter<Request> loginFilter = new LoginFilter();
    static AuthFilter<Request> authFilter = new AuthFilter();

    public static void main(String[] args) {
        loginFilter.setNext(authFilter);
        Request request = new Request();
        request.setUserName("Dimuthu");
        request.setReqeustType(ReqeustType.CREATE);
        loginFilter.filter(request);
    }
}

enum ReqeustType {
    LOGIN,
    CREATE,
    UPDATE,
    READ,
    DELETE
}

class Request {
    String userName;
    ReqeustType reqeustType;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public ReqeustType getReqeustType() {
        return reqeustType;
    }

    public void setReqeustType(ReqeustType reqeustType) {
        this.reqeustType = reqeustType;
    }
}

interface Filter<T> {
    void filter(T t);
}

abstract class AbstractFilter<T> implements Filter<T> {
    private Filter next;
    private String filterName;

    AbstractFilter(String filterName) {
        this.filterName = filterName;
    }

    @Override
    public void filter(T t) {
        if (check(t)) {
            if (next != null) {
                next.filter(t);
            }
        } else {
            System.out.println(filterName + " failed");
        }
    }

    abstract boolean check(T t);

    public Filter getNext() {
        return next;
    }

    public void setNext(Filter next) {
        this.next = next;
    }

}

class LoginFilter<T> extends AbstractFilter<T> {

    LoginFilter() {
        super("loggin Filter");
    }

    @Override
    boolean check(T o) {
        if (o instanceof Request) {
            if (((Request) o).getUserName().equals("Dimuthu")) {
                return true;
            }
        }
        return false;
    }
}

class AuthFilter<T> extends AbstractFilter<T> {
    AuthFilter() {
        super("AuthFilter");
    }

    @Override
    boolean check(T o) {
        if (o instanceof Request) {
            if (((Request) o).getReqeustType().equals(ReqeustType.LOGIN)) {
                return true;
            }
        }
        return false;
    }
}