module com.baeldung.student.service{   //for name does are allowed. Not dashes (project-style or reverse DNS naming)

    //dependencies - dependent modules (both run time and compile time). so all public types of model become accessible now

    //requires static module.name; compile time only dependency

    requires transitive com.baeldung.student.model; //dependency will come with its downstream transitive dependencies as well


    //by default modules does not expose any API (strong encapsulaton)
    //public packages
    exports com.baeldung.student.service; //all public members of this package is exposed now (expose to the world)

    //exports com.baeldung.student.service to com.baeldung.student.model; //expose only to a target consumer

    //services offered
    //uses class.name; -- exposing the implemantation of an interface. class.name here is interface or abnstract class not the implemantation
    //instead of forcing modules to require all transitive dependencies --> use 'uses' directive to add module path

    //provides MyInterface with MyInterfaceImpl; -- interface followed by the the Impl

    //services consumed

    //reflection permission  --> by default consumers can not use reflection for any class
    //opens com.my.package; --exposes only one package for reflection

    //opens com.my.package to moduleOne, moduleTwo, etc.; --opens to selective targets


}

/* -- Open the whole package to reflection
open module my.module {
}
*/


