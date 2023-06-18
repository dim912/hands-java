package vehicles;

/**
 * more fine grained inheritance control
 * allow to define interfaces and classes to define permitted subtypes
 *
 * sealed => allow to set permits
 *        => child classes should be final or sealed or non-sealed
 * permited => should be classes from same module
 * non sealed => open for extension
 *
 * */


public sealed interface Vehicle permits Car, Bus{
}


/**
 * if (vehicle instanceof Car car) {
 *     return car.getNumberOfSeats();
 * } else if (vehicle instanceof Truck truck) {
 *     return truck.getLoadCapacity();
 * } else {
 *     throw new RuntimeException("Unknown instance of Vehicle");
 * }*/