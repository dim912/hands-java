new level of abstraction above packages (package of packages)
can package as separate java modules
code and data(resources) are within the module

visibility
encapsulation
dependencies 
    -> are defined within the module


Four Types of Modules
---------------------

1) System modules - comes from JDK - java --list-modules (Now JDK is shipped differently)
        a. java - SE language spec
        b. javafx - FX UI
        a. jdk - thinks needed by JDK
        a. oracle - oracle specific
2) Application modules - what the programer creates. comes to the module-info.class in the assembled jar
3) Automatic modules  - on official modules, by adding JAR into the class path. program has access to all by default 
4) Unnamed modules - when a jar if loaded, but not the module path -> it is automatically added to unamed module. this is for backwards compatibility


Module distirbuton
-----------------

1) JAR - one jar can hace only one module (so each module needs its own jar file at shipping)
2) exploded compile project


















 