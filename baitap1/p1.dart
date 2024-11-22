import 'dart:io';
import 'dart:math';

//Bai tap: Viet chuong trinh chuyen doi 1 so nguyen thanh so nhi phan
void main(){
  int a = 0;
  do{
    stdout.write("Nhap so nguyen a (a >= 0): ");
    String? inputA = stdin.readLineSync();
    if(inputA != null){
      a = int.tryParse(inputA) ?? 0;
    }
    if(a == 0){
      print("Vui long nhap lai: ");
    }
  }while(a < 0);
  
  String chuoiNhiPhan = a.toRadixString(2);
  print("Nhi phan: $chuoiNhiPhan");
}
