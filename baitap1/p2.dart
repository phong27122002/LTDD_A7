import 'dart:io';
import 'dart:math';

//Viet chuong trinh tinh tong cac uoc cua 1 so nguyen (n >= 1)
void main(){
  int n = 0;
  do{
    stdout.write("Nhap so nguyen a (a >= 1): ");
    String? inputN = stdin.readLineSync();
    if(inputN != null){
      n = int.tryParse(inputN) ?? 0;
    }
    if(n == 0){
      print("Vui long nhap lai: ");
    }
  }while(n <= 0);
  int tong = 0;
  for(int i = 1; i <= n; i++){
    if(n % i == 0){
      tong += i;
    }
  }
}
