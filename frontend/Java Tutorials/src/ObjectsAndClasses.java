//calling method with annonymous object

class ObjectsAndClasses{  
  
 void fact(int  n){  
  int fact=1;  
  for(int i=1;i<=n;i++){  
   fact=fact*i;  
  }  
 System.out.println("factorial is "+fact);  
}  
  
 
 
public static void main(String args[]){  
 new ObjectsAndClasses().fact(5);  
}  
}  