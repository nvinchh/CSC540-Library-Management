import java.util.*;
public class ArrayList {

	static Iterator func(ArrayList mylist)
	{
		Iterator it=mylist.iterator();
		while(it.hasNext())
		{
			Object element=it.next();
			if(element instanceof String)
				break;
		}
	}

public static void main(String args[])
{
	ArrayList mylist=new ArrayList();
	Scanner stdin = new Scanner(System.in);
	int x=stdin.nextInt();
	int y=stdin.nextInt();

	for(int i=0;i<x;i++)
	{
		mylist.add(stdin.nextInt());
	}
	mylist.add("###";)
	for(int j=0;j<y;j++)
	{
		mylist.add(stdin.next());
	}
	Iterator it=func(calculate(mylist));

	while(it.hasNext())
	{
		Object element=it.next();
		System.out.println(String(element));
	}
}
}
