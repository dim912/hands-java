package structural;

/**
 * 
 * There are two ways to implement adapter pattern
 *
 * 1. class adapter -> adapter class extends adapted class or interface (Inheritance base -> has side effects and violate encapsulation(composition over inheritance) )
 * 2. object adapter -> adapter has an instance of adapted class (Composition based)
 *
 *
 * */

public class AdapterTest {

    public static void main(String[] args){

        ModernInterfaceConsumer consumer = new ModernInterfaceConsumer();

        ModernInterfaec modenInterface =  new ModernInterfaceAdapter();
        consumer.setModernInterfaec(modenInterface);

        consumer.transderData();
    }

}

/** Context needs a  modern interface implementation*/
class ModernInterfaceConsumer {
    ModernInterfaec modernInterfaec ;

    void transderData(){
        this.modernInterfaec.modernMethod();
    }

    public void setModernInterfaec(ModernInterfaec modernInterfaec) {
        this.modernInterfaec = modernInterfaec;
    }
}

/** LEGACY SYSTEM*/
interface LegacyInterface {
    void legacyMethod();
}

class LegacyClass implements LegacyInterface{

    @Override
    public void legacyMethod() {
        System.out.println("Data transfer through legacy method");
    }
}

/** MODERN SYSTEM. But there is no implementation for the modern interface yet. But existing interface is up*/
interface ModernInterfaec {
    void modernMethod();
}

/**Adapter from LegacyInterface to modern interface
 *
 * This is Object based adapter
 * */

class ModernInterfaceAdapter implements ModernInterfaec{

    LegacyInterface legacyInterface = new LegacyClass();

    @Override
    public void modernMethod() {
        legacyInterface.legacyMethod();
    }
}






