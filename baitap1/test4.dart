import 'dart:io';
import 'dart:math';


void main(){
  double a = 0, b = 0, c = 0;
  //input a
  do{
     stdout.write("Nhap he so a(a ! = 0): ");
     String? inputA = stdin.readLineSync();
     if(inputA != null){
      a = double.tryParse(inputA) ?? 0;
     }
     if(a == 0){
      print("Vui long nhap lai: ");
     }
  }while(a == 0);

  //input b
   
     stdout.write("Nhap he so b: ");
     String? inputB = stdin.readLineSync();
     if(inputB != null){
      b = double.tryParse(inputB) ?? 0;
     }
     
  //input c
  
     stdout.write("Nhap he so c: ");
     String? inputC = stdin.readLineSync();
     if(inputC != null){
      c = double.tryParse(inputC) ?? 0;
     }

  }


//Tim delta
  double deta = b*b - 4*a*c;

//Giai pt
  if(deta < 0){
    print("Phuong trinh vo nghiem");
}else{
    
}