//Class created by B.Pusch
//Class for storing  keys with values (used by graphs)
public class Mapping
{
    int value;
    String key;

    public Mapping(String key)
    {
        this.value = 1; this.key = key;
    }
    public Mapping(String key, int value)
    {
        this.key = key; this.value = value;
    }

    public int getValue()
    {
        return value;
    }

    public String getKey()
    {
        return key;
    }

    public void increment()
    {
        this.value += 1;
    }

    public int compareTo(Object obj)
    {
        if(obj instanceof Mapping)
        {
            Mapping mapping = (Mapping) obj;
            return Integer.compare(this.value,mapping.getValue());
        }
        return -1;   
    }
    public int compareToKeys(Object obj)
    {
        if(obj instanceof Mapping)
        {
            Mapping mapping = (Mapping) obj;
            return this.key.compareTo(mapping.getKey());
        }
        return -1;   
    }

    public boolean equals(Object obj)
    {
        if(obj instanceof Mapping)
        {
            Mapping mapping = (Mapping) obj;
            return key.equals(mapping.getKey());
        }
        return false; 
    }
}