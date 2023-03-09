//File created by B. Pusch
//Methods needed throughout the project

//given a rectangle, this returns the pixel size of each letter so that the text fits into the rectangle for globe
public float getTextSize(float width, float height, int length)
{
    return height*.7;  //for globe
}

//given a rectangle, this returns the pixel size of each letter so that the text fits into the rectangle for graphs
public float getTextSizeChart(float width, float height, int length)
{
    return Math.min(height*.8,(width)/(float)length*1.2); 
}

public class MappingComparator implements Comparator<Mapping> 
{
    @Override
    public int compare(Mapping m1, Mapping m2) 
    {
        return m1.compareTo(m2);
    }
}

public class MappingKeyComparator implements Comparator<Mapping> 
{
    @Override
    public int compare(Mapping m1, Mapping m2) 
    {
        return m1.compareToKeys(m2);
    }
}

public class OrbitComparator implements Comparator<Orbit> 
{
    @Override
    public int compare(Orbit o1, Orbit o2) {
        return o1.compareTo(o2);
    }
}

public class GlobeDataComparator implements Comparator<String[]> 
{
    @Override
    public int compare(String s1[], String s2[]) {
        return s1[1].compareTo(s2[1]);
    }
}