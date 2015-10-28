import java.io.*;


public class Solution1{

    public static void main(String []argh){
        Adder X=new Adder();
        System.out.println("My superclass is: "+X.getClass().getSuperclass().getName());    
        System.out.print(X.add(10,32)+" "+X.add(10,3)+" "+X.add(10,10)+"\n");

    }
}



class Arithmetic
{
void Output()
    {
    System.out.println("The addition is x"); 
}
}
class Adder extends Arithmetic
{
int add(int x,int y)
    {
   int z=x+y;
    return z;
}
}