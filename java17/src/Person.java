import java.util.Objects;
public record Person(String name, String address) {

    //customized constructor
    /*
    public Person {
        Objects.requireNonNull(name);
        Objects.requireNonNull(address);
    }
    */

    /*
    public Person(String name) {
        this(name, "Unknown");
    }
     */

    // static variables are possible
    //public static String UNKNOWN_ADDRESS = "Unknown";

    /*
    public static Person unnamed(String address) {
        return new Person("Unnamed", address);
    }
     */

}

/**
 * reduces the boiler plates needed
 * By default immutable
 * final
 * can not extend any other class or record
 *
 *
 * COMES FREE
 * ==========
 *
 * 1) public constructor with all fields
 * 2) public getters. name of the getter matches the field
 * 3) equals method with all fileds
 * 3) hashCode containing all the fileds
 * 3) toString containing all
 *
 * */
