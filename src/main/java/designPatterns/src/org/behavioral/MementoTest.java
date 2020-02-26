package org.behavioral;

import java.util.Stack;

/**
 * capture and externalize objects internal state so that it can be restored later (without violating encapsulation)
 * <p>
 * Useful for Undo Operations( Serialize -> de serialize)
 * <p>
 * Originator : An object which knows how to save itself. Use an inner class to save the state of the object. Called Memento.
 * Memento : hold the information of Originator at save  points and can not be modified by Caretaker(outside). An inner class of Originator.
 * Caretaker : manage the saved points of Originator. save, undo should be called through CareTaker.
 *
 * Ex : text editor. Save and undo operations.s
 */


public class MementoTest {

    public static void main(String[] args) {

        //Originator which has save snapshot feature through Memento private inner class(Non modifiable since it is a private inner class)
        FileOriginator fileOriginator = new FileOriginator();
        //CareTaker which keeps the saved points
        FileCareTaker fileCareTaker = new FileCareTaker(fileOriginator);

        fileOriginator.append("1");
        fileCareTaker.Save();
        fileOriginator.append("22");
        fileCareTaker.Save();
        fileOriginator.append("333");
        fileCareTaker.Save();
        fileOriginator.append("4444");


        System.out.println(fileOriginator.getContent());
        fileCareTaker.restore();
        System.out.println(fileOriginator.getContent());
        fileCareTaker.restore();
        System.out.println(fileOriginator.getContent());
        fileCareTaker.restore();
        System.out.println(fileOriginator.getContent());

    }

}


class FileOriginator {

    private String fileName;
    private StringBuilder content = new StringBuilder();

    public void append(String delta) {
        content.append(delta);
    }

    //save method returns the snapshot. Memento to Caretaker
    public FileMemento save() {
        return new FileMemento();
    }

    //revert the object looking at the memento. Since memento is not visible to outside -> type passed is Object. But its a Mememnto Object saved at CareTaker
    public void revert(Object memento) {
        this.content = ((FileMemento) memento).contentx;
    }

    public StringBuilder getContent() {
        return content;
    }

    //this class is not visible to outside. So variables of this type can not be exist out side this class.
    //but references can exist. (through Object class)
    private class FileMemento {
        private StringBuilder contentx;
        public FileMemento() {
            this.contentx = new StringBuilder(content); //returns a deep clone.
        }
    }

}

class FileCareTaker {

    public FileCareTaker(FileOriginator fileOriginator) {
        this.fileOriginator = fileOriginator;
    }

    FileOriginator fileOriginator ;
    Stack<Object> savedStack = new Stack<>();

    public void Save() {
        savedStack.push(fileOriginator.save());
    }

    public void restore() {
        fileOriginator.revert(savedStack.pop());
    }

}