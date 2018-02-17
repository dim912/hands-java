package org.behavioral;

import java.util.ArrayList;

/**
 * Allow sequentially move through the aggregator(Collection) with out knowing the internal representation.
 * Allows concurrent traversals
 * A uniform interface
 * (in history all were access through different APIs -> now all through Iterator since Collection extends Iterable)
 *
 *
 * java.util.ArrayList iterator is not thread Safe
 * in a concurrent environment -> Can get => ConcurrentModification Exception
 * But for Single threaded Env -> It does not throw ConcurrentModifiation Exception. (removing elements with out iterator throws it)
 */

public class IteratorTest {

    public static void main(String[] args){

        ChannelList cList = new ChannelList();
        cList.add(new Channel(1,ChannelTypeEnum.ENGLISH));
        cList.add(new Channel(2,ChannelTypeEnum.HINDI));
        cList.add(new Channel(3,ChannelTypeEnum.FRENCH));
        cList.add(new Channel(4,ChannelTypeEnum.ENGLISH));

        CIterator cIterator = cList.cIterator(ChannelTypeEnum.ENGLISH);

        while(cIterator.hasNext()){
            System.out.println(((Channel)cIterator.next()).getFrequency());
        }
    }
}

interface CIterator<T> {
    boolean hasNext();
    T next();
}

enum ChannelTypeEnum {
    ENGLISH, HINDI, FRENCH, ALL;
}

//Objects to Store in collection
class Channel {
    private double frequency;
    private ChannelTypeEnum TYPE;

    public Channel(double freq, ChannelTypeEnum type) {
        this.frequency = freq;
        this.TYPE = type;
    }

    public double getFrequency() {
        return frequency;
    }

    public ChannelTypeEnum getTYPE() {
        return TYPE;
    }

    @Override
    public String toString() {
        return "Frequency=" + this.frequency + ", Type=" + this.TYPE;
    }
}

class ChannelList extends ArrayList<Channel> {

    CIterator<Channel> cIterator(ChannelTypeEnum channelType) {
        return new ChannelIterator(channelType);
    }

    //new iterator which implements Citerator.
    //ChannelIterator is private static so that it can not be instantiated externally
    private class ChannelIterator implements CIterator<Channel> {
        ChannelTypeEnum channelType;
        int position;
        public ChannelIterator(ChannelTypeEnum channelType) {
            this.channelType = channelType;
        }
        //Check the collection and return accordigly
        @Override
        public boolean hasNext() {
            while (position < size()) {
                if (get(position).getTYPE() == this.channelType) {
                    return true;
                }
                position++;
            }
            return false;
        }
        @Override
        public Channel next() {
            while (position < size()) {
                if (get(position).getTYPE() == this.channelType) {
                    Channel c=  get(position);
                    position++;
                    return c;
                }
            }
            return null;
        }
    }
}